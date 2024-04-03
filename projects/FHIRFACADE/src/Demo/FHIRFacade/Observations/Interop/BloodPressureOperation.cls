Class Demo.FHIRServer.Observations.Interop.BloodPressureOperation Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Method StoreMsg(pRequest As Demo.FHIRServer.Observations.Interop.BloodPressureMsg, Output pResponse As Ens.Response, test As %String = "sdsdd") As %Status
{
    Set tBloodPressure = ##class(Demo.FHIRServer.Observations.BloodPressure).%New()
    set tBloodPressure.Timestamp = pRequest.Timestamp
    Set tBloodPressure.DeviceId = pRequest.DeviceId
    Set tBloodPressure.Systolic = pRequest.Systolic
    Set tBloodPressure.Diastolic = pRequest.Diastolic
    Do tBloodPressure.%Save()

    Set pResponse = ##class(Ens.Response).%New()

    Return $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="Demo.FHIRServer.Observations.Interop.BloodPressureMsg">
        <Method>StoreMsg</Method>
    </MapItem>
</MapItems>
}

}
