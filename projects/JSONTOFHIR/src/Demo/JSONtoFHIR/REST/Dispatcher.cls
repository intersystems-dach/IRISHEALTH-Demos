Class Demo.JSONtoFHIR.REST.Dispatcher Extends Demo.JSONtoFHIR.REST.Base [ ProcedureBlock ]
{

Parameter Version = "1.0.0";

Parameter APIKey = "8BfaNUt0J3dzPd47Zeym4XGTF4cXGgdw";

Parameter Secret = "JmuFsTZtfNt12";

Parameter KeyID = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/Security" Method="post" Call="PostToken" Cors="true" />
  <Route Url="/TestData" Method="get" Call="GetData" Cors="true" />

</Routes>
}

ClassMethod PostToken() As %Status
{
    #dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set tMsgBody=%request.Content
    If (tMsgBody.APIKey = ..#APIKey) && (tMsgBody.Secret = ..#Secret) {
        Set tJWT = ##class(Demo.JSONtoFHIR.REST.JWT).IndexOpen(..#KeyID)
        If '$ISOBJECT(tJWT) {
            Set tJWT = ##class(Demo.JSONtoFHIR.REST.JWT).%New()
            Set tJWT.KeyID = ..#KeyID
        }
        Set tJWT.Key = $ZCONVERT(##class(%PopulateUtils).StringMin(100,100), "I", "UTF8")
        Set sc = tJWT.%Save()
        Set tResult = ##class(%Stream.TmpCharacter).%New()
        Do tResult.Write(""""_tJWT.Key_"""")
        Set tSC = ..%ProcessResult(sc, tResult)
    }
    Else {
        Set tSC = ..ReportHttpStatusCode(..#HTTP401UNAUTHORIZED)
    }

    Return tSC
}

ClassMethod GetData() As %Status
{
    Set tJWT = ##class(Demo.JSONtoFHIR.REST.JWT).IndexOpen(..#KeyID)
    If '$IsObject(tJWT) {
        Return ..ReportHttpStatusCode(..#HTTP401UNAUTHORIZED)
    }

    Set tAuthHeader = %request.GetCgiEnv("HTTP_AUTHORIZATION")
    Set tPrefix = $PIECE(tAuthHeader, " ", 1)
    Set tToken = $PIECE(tAuthHeader, " ", 2)

    If '(tToken= tJWT.Key) || '(tPrefix = "Bearer") {
        Return ..ReportHttpStatusCode(..#HTTP401UNAUTHORIZED)
    }

    Set xdataID="Demo.JSONtoFHIR.REST.Dispatcher||JSONInputFile"
    Set compiledXdata=##class(%Dictionary.CompiledXData).%OpenId(xdataID)
    Return ..%ProcessResult($$$OK, compiledXdata.Data)
}

XData JSONInputFile [ MimeType = application/json ]
{
{
        "person_id": "DoeJohn741225",
        "identifier_system": "http://terminology.hl7.org/CodeSystem/v2-0203",
        "identifier_code": "MR",
        "patient_name": "John DOE",
        "mobile_phone": "(03) 5555 6473",
        "sex": "M",
        "birth_date": "25/12/1974",
        "deceased": 0,
        "postal_addr": "534 Erewhon St PeasantVille, Rainbow, Vic 3999",
        "postal_addr_since": "25/12/1974",
        "encounter_id": "DoeJohnf20120130404",
        "encStatus": "finished",
        "category": "SS",
        "location": "Organization/SaintJeanHospital",
        "handled_by": "Practitioner/AddamsFrank680403",
        "motivation": "The patient had fever peaks over the last couple of days.",
        "observation_id": "f206",
        "observation_status": "final",
        "observation_date": "2013-03-11T10:28:00+01:00",
        "pos_results": [
            "Staphylococcus aureus"
        ],
        "tests_performed": [
            "104177"
        ],
        "condition_id": "2013983645",
        "status_code": "active",
        "verification_code": "confirmed",
        "condition_codes": [
            "386661006"
        ],
        "closure_status": "completed",
        "closure_condition": "This patient came due to generalized aching and proemient fiever",
        "closure_code": "A54",
        "closure_note": "Patient has sinusitis"
    }
}

}
