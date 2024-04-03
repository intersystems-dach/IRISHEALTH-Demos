Class Demo.FHIRFacade.REST.Dispatcher Extends %CSP.REST
{

Parameter SERVICENAME = "FHIR Observation Service";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/Observation" Method="post" Call="PostObservation" Cors="true" />
</Routes>
}

ClassMethod PostObservation() As %Status
{
    #dim tSC As %Status = $$$OK
    If (%request.Content = "") {
        Set tSC = ..ReportHttpStatusCode(..#HTTP400BADREQUEST)
    } Else {
        Try {
            Set tJSONObject = ##class(%DynamicAbstractObject).%FromJSON(%request.Content)
            If tJSONObject.resourceType '= "Observation" {
                Set tSC = ..ReportHttpStatusCode(..#HTTP400BADREQUEST)
            } Else {
                Set tFHIRRequest = ##class(HS.FHIRServer.Interop.Request).%New()
                Set tFHIRRequest.Request.RequestPath = "Observation"
                Set tFHIRRequest.Request.RequestFormatCode = "JSON"
                Set tFHIRRequest.Request.SessionApplication = %session.Application
                Set tQuickStream = ##class(HS.SDA3.QuickStream).%New()                
                Set tFHIRRequest.QuickStreamId = tQuickStream.%Id()
                Do tQuickStream.CopyFrom(%request.Content)

                set tSC  = ##class(Ens.Director).CreateBusinessService(..#SERVICENAME,.tBs)
                do tBs.OnProcessInput(tFHIRRequest, .tResponse)
                Set tSc = ..ReportHttpStatusCode(tResponse.Response.Status)
            }

        } Catch {
            Set tSC = ..ReportHttpStatusCode(..#HTTP500INTERNALSERVERERROR)

        }

    }    

    Return tSC
}

}
