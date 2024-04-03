Class Demo.JSONtoFHIR.ObjectToFHIREncounter Extends Ens.DataTransformDTL [ DependsOn = (Demo.JSONtoFHIR.InputFile, HS.FHIR.DTL.vR4.Model.Resource.Encounter) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Demo.JSONtoFHIR.InputFile' targetClass='HS.FHIR.DTL.vR4.Model.Resource.Encounter' create='new' language='objectscript' >
<assign value='source.encounterid' property='target.id' action='set' />
<assign value='source.encStatus' property='target.status' action='set' />
<assign value='source.category' property='target.class.code' action='set' />
<assign value='..Lookup("ActEncounterCode",source.category)' property='target.class.display' action='set' />
<assign value='..Lookup("ActEncounterCode","System")' property='target.class.system' action='set' />
<assign value='source.handledby' property='target.participant.(1).individual.reference' action='set' />
<assign value='source.motivation' property='target.reasonCode.(1).text' action='set' />
<assign value='source.location' property='target.serviceProvider.reference' action='set' />
<assign value='source.patientname' property='target.subject.display' action='set' />
<assign value='"Patient/"_source.personid' property='target.subject.reference' action='set' />
</transform>
}

}
