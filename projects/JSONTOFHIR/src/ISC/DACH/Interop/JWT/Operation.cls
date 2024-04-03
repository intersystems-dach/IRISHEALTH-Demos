Class ISC.DACH.Interop.JWT.Operation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.HTTP.OutboundAdapter";

Parameter INVOCATION = "Queue";

/// These are the production settings for this object
Parameter SETTINGS = "APICredentials:JWT:credentialsSelector,MessageBodyKeys:JWT,-ContentType";

/// This is the ID name of the set of credentials values (APIKey, Secret) to be used to obtain the JWT token.
/// The credentials username contains the APIKey and the password the secret.
Property APICredentials As %String [ InitialExpression = "None" ];

/// The keys (seperated by ',') used in the message body JSON object.
Property MessageBodyKeys As %String [ InitialExpression = "APIKey,Secret" ];

/// The Content-Type of the POST request. This value should not be changed in most cases.
Property ContentType As %String [ InitialExpression = "application/json" ];

/// This is the credentials object containing the values to be used to access the datasouce
Property %CredentialsObj As Ens.Config.Credentials [ Private ];

Method CredentialsSet(pInVal As %String) As %Status [ Private ]
{
	#; (Re)Set the Credentials object; do it always because we never know if the source row fields might have been updated
	#; make sure to instantiate even if re-setting to the InitialExpression string
	Set ..%CredentialsObj=$$$NULLOREF

	Set tClassname=$zobjmethod($this,"%ClassName",1) ; call subclass
	Set tClass = $$$comMemberKeyGet(tClassname,$$$cCLASSproperty,"%CredentialsObj",$$$cPROPtype)
	If ""'=tClass {
		Set tSC=##Class(Ens.Config.Credentials).GetCredentialsObj(.tObj,tClassname,tClass,pInVal)
		If $$$ISOK(tSC) { Set ..%CredentialsObj=tObj }
		ElseIf '$$$StatusEquals(tSC,$$$EnsErrNoCallerCredentials) {
			$$$LOGSTATUS(tSC)
		}
	}
	Quit $$$OK
}

Method SendPostRequest(Output pHttpResponse As %Net.HttpResponse, pContentType As %String, messageBody...) As %Status [ Private ]
{
    set tHttpRequest = ##class(%Net.HttpRequest).%New()
    set tHttpRequest.ContentType  =  pContentType
    return ..Adapter.SendFormDataArray(.pHttpResponse, "POST", tHttpRequest, , .messageBody)
}

Method GetToken(pRequest As Ens.Request, Output pResponse As Ens.StringResponse) As %Status
{
    #dim tSC As %Status = $$$OK
    Set pResponse = ##class(Ens.StringResponse).%New()

    /// Get APIKey and Secret from credentials id
    If '$IsObject(..%CredentialsObj) {
        Do ..CredentialsSet(..APICredentials) 
    }

    // Validate if credentials were obtained successfully
    If '$IsObject(..%CredentialsObj) { 
        Set tSC=$$$EnsError($$$EnsErrNoCredentials,..APICredentials) 
        Quit tSC
    }   
   
    // Set JSON message body
    set tMsgBody = ##class(%Library.DynamicObject).%New()    
    do tMsgBody.%Set($PIECE(..MessageBodyKeys, ",", 1), ..%CredentialsObj.Username, "string")
    do tMsgBody.%Set($PIECE(..MessageBodyKeys, ",", 2), ..%CredentialsObj.Password, "string")

    Set tHttpResponse = ##class(%Net.HttpResponse).%New()
    Set tSC = ..SendPostRequest(.tHttpResponse, ..ContentType, tMsgBody.%ToJSON())

    If $$$ISOK(tSC) {
        Set JWT = ""
        While (tHttpResponse.Data.AtEnd = 0) {
            Set JWT = $ZSTRIP(JWT_tHttpResponse.Data.Read(), "<>", """")
        }

        Set pResponse.StringValue = JWT
    }

    return tSC
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="Ens.Request">
    <Method>GetToken</Method>
  </MapItem>
</MapItems>
}

}
