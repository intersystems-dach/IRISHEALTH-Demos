Class Demo.JSONtoFHIR.ObjectToFHIRObservation Extends Ens.DataTransformDTL [ DependsOn = (Demo.JSONtoFHIR.InputFile, HS.FHIR.DTL.vR4.Model.Resource.Observation) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Demo.JSONtoFHIR.InputFile' targetClass='HS.FHIR.DTL.vR4.Model.Resource.Observation' create='new' language='objectscript' >
<assign value='source.observationid' property='target.id' action='set' />
<assign value='source.observationstatus' property='target.status' action='set' />
<assign value='source.observationdate' property='target.issued' action='set' />
<assign value='..Lookup("ObservationInterpretation", "System")' property='target.interpretation.(1).coding.(1).system' action='set' />
<assign value='source.posresults.(1)' property='target.interpretation.(1).coding.(1).display' action='set' />
<assign value='"POS"' property='target.interpretation.(1).coding.(1).code' action='set' />
<assign value='..Lookup("LabResults","System")' property='target.code.coding.(1).system' action='set' />
<assign value='source.testsperformed.(1)' property='target.code.coding.(1).code' action='set' />
<assign value='..Lookup("LabResults",source.testsperformed.(1))' property='target.code.coding.(1).display' action='set' />
<assign value='source.patientname' property='target.subject.display' action='set' />
<assign value='"Patient/"_source.personid' property='target.subject.reference' action='set' />
</transform>
}

}
