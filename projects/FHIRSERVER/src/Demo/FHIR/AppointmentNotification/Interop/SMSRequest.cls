Class Demo.FHIR.AppointmentNotification.Interop.SMSRequest Extends Ens.Request
{

/// MobilePhone 
Property MobilePhone As %String(MAXLEN = 50);

/// Message
Property Message As %String(MAXLEN = 640);

Storage Default
{
<Data name="SMSRequestDefaultData">
<Subscript>"SMSRequest"</Subscript>
<Value name="1">
<Value>MobilePhone</Value>
</Value>
<Value name="2">
<Value>Message</Value>
</Value>
</Data>
<DefaultData>SMSRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
