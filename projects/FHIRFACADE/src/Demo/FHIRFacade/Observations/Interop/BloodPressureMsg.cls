Class Demo.FHIRServer.Observations.Interop.BloodPressureMsg Extends Ens.Request
{

/// Timestamp
Property Timestamp As %String(MAXLEN = 100);

/// Blodd Pressure measuring IOT device ID
Property DeviceId As %Integer;

/// Systolic blood pressure in mmHg
Property Systolic As %Integer;

/// Diastolic blood pressure in mmHg
Property Diastolic As %Integer;

Storage Default
{
<Data name="BloodPressureMsgDefaultData">
<Subscript>"BloodPressureMsg"</Subscript>
<Value name="1">
<Value>Timestamp</Value>
</Value>
<Value name="2">
<Value>DeviceId</Value>
</Value>
<Value name="3">
<Value>Systolic</Value>
</Value>
<Value name="4">
<Value>Diastolic</Value>
</Value>
</Data>
<DefaultData>BloodPressureMsgDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
