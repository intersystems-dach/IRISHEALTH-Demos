Class Demo.JSONtoFHIR.ObjectToFHIRClinicalImpression Extends Ens.DataTransformDTL [ DependsOn = (Demo.JSONtoFHIR.InputFile, HS.FHIR.DTL.vR4.Model.Resource.ClinicalImpression) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Demo.JSONtoFHIR.InputFile' targetClass='HS.FHIR.DTL.vR4.Model.Resource.ClinicalImpression' create='new' language='objectscript' >
<assign value='source.closurenote' property='target.summary' action='set' />
<assign value='source.patientname' property='target.subject.display' action='set' />
<assign value='"Patient/"_source.personid' property='target.subject.reference' action='set' />
<assign value='source.closurestatus' property='target.status' action='set' />
<assign value='source.closurecondition' property='target.description' action='set' />
<assign value='source.closurecode' property='target.finding.(1).itemCodeableConcept.coding.(1).code' action='set' />
<assign value='..Lookup("ClosureCodes",source.closurecode)' property='target.finding.(1).itemCodeableConcept.coding.(1).display' action='set' />
<assign value='..Lookup("ClosureCodes","System")' property='target.finding.(1).itemCodeableConcept.coding.(1).system' action='set' />
</transform>
}

}
