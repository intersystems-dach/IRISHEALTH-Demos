Class Demo.JSONtoFHIR.REST.JWT Extends %Persistent
{

Property KeyID As %Integer;

Property Key As %String(MAXLEN = 100);

Index Index On KeyID [ Unique ];

Storage Default
{
<Data name="JWTDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>KeyID</Value>
</Value>
<Value name="3">
<Value>Key</Value>
</Value>
</Data>
<DataLocation>^Demo.JSONtoFHIR.REST.JWTD</DataLocation>
<DefaultData>JWTDefaultData</DefaultData>
<IdLocation>^Demo.JSONtoFHIR.REST.JWTD</IdLocation>
<IndexLocation>^Demo.JSONtoFHIR.REST.JWTI</IndexLocation>
<StreamLocation>^Demo.JSONtoFHIR.REST.JWTS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
