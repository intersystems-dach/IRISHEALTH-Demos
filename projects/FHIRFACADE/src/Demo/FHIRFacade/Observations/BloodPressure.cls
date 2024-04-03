Class Demo.FHIRServer.Observations.BloodPressure Extends %Persistent
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
<Data name="BloodPressureDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Timestamp</Value>
</Value>
<Value name="3">
<Value>DeviceId</Value>
</Value>
<Value name="4">
<Value>Systolic</Value>
</Value>
<Value name="5">
<Value>Diastolic</Value>
</Value>
</Data>
<DataLocation>^Demo.FHIRServB8F.BloodPressureD</DataLocation>
<DefaultData>BloodPressureDefaultData</DefaultData>
<IdLocation>^Demo.FHIRServB8F.BloodPressureD</IdLocation>
<IndexLocation>^Demo.FHIRServB8F.BloodPressureI</IndexLocation>
<StreamLocation>^Demo.FHIRServB8F.BloodPressureS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
