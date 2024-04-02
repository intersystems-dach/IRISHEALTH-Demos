Class Demo.FHIR.AppointmentNotification.Interop.EmailRequest Extends Ens.Request
{

/// E-Mail
Property EmailAddress As %String(MAXLEN = 150);

/// Subject
Property Subject As %String(MAXLEN = 250);

/// Message
Property Message As %String(MAXLEN = 2500);

Storage Default
{
<Data name="EmailRequestDefaultData">
<Subscript>"EmailRequest"</Subscript>
<Value name="1">
<Value>EmailAddress</Value>
</Value>
<Value name="2">
<Value>Subject</Value>
</Value>
<Value name="3">
<Value>Message</Value>
</Value>
</Data>
<DefaultData>EmailRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
