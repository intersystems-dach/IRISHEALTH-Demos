Class Demo.FHIR.AppointmentNotification.Interop.FHIRHelper Extends Ens.Rule.FunctionSet
{

/// Get FHIR Resource Type
ClassMethod FhirRequestType(QuickStreamId As %String) As %String
{
    Set tResourceType = ""

    Try {
        Set tQuickStream = ##class(HS.SDA3.QuickStream).%OpenId(QuickStreamId)
        Set tJsonObject = ##class(%DynamicAbstractObject).%FromJSON(tQuickStream)
        Set tResourceType = tJsonObject.resourceType
    }
    Catch { }
    

    Return tResourceType
}

}
