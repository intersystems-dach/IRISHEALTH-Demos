Class Demo.JSONtoFHIR.ObjectToFHIRCondition Extends Ens.DataTransformDTL [ DependsOn = (Demo.JSONtoFHIR.InputFile, HS.FHIR.DTL.vR4.Model.Resource.Condition) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Demo.JSONtoFHIR.InputFile' targetClass='HS.FHIR.DTL.vR4.Model.Resource.Condition' create='new' language='objectscript' >
<assign value='source.conditionid' property='target.id' action='set' />
<assign value='source.statuscode' property='target.clinicalStatus.coding.(1).code' action='set' />
<assign value='..Lookup("ConditionCodes","System")' property='target.clinicalStatus.coding.(1).system' action='set' />
<assign value='..Lookup("ConditionVerificationStatus","System")' property='target.verificationStatus.coding.(1).system' action='set' />
<assign value='source.verificationcode' property='target.verificationStatus.coding.(1).code' action='set' />
<assign value='source.conditioncodes.(1)' property='target.code.coding.(1).code' action='set' />
<assign value='..Lookup("ConditionCodes",source.conditioncodes.(1))' property='target.code.coding.(1).display' action='set' />
<assign value='..Lookup("ConditionCodes","System")' property='target.code.coding.(1).system' action='set' />
<assign value='source.patientname' property='target.subject.display' action='set' />
<assign value='"Patient/"_source.personid' property='target.subject.reference' action='set' />
</transform>
}

}
