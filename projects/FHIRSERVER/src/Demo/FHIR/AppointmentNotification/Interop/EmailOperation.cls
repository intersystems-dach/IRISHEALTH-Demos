Class Demo.FHIR.AppointmentNotification.Interop.EmailOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.EMail.OutboundAdapter";

Method OnMessage(pRequest As Demo.FHIR.AppointmentNotification.Interop.EmailRequest, Output pResponse As Ens.Response) As %Status
{
        Quit $$$OK
}

}
