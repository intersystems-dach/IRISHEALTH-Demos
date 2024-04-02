Class Demo.ComServer.DTL.SwitchName Extends Ens.DataTransformDTL [ DependsOn = EnsLib.HL7.Message ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='EnsLib.HL7.Message' sourceDocType='2.5:ADT_A01' targetDocType='2.5:ADT_A01' create='new' language='objectscript' >
<assign value='source' property='target' action='set' />
<assign value='source.{PID:PatientName().FamilyName}' property='target.{PID:PatientName().GivenName}' action='set' />
<assign value='source.{PID:PatientName().GivenName}' property='target.{PID:PatientName().FamilyName}' action='set' />
</transform>
}

}
