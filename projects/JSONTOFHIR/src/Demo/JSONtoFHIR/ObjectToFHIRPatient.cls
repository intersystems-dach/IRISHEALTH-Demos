Class Demo.JSONtoFHIR.ObjectToFHIRPatient Extends Ens.DataTransformDTL [ DependsOn = (Demo.JSONtoFHIR.InputFile, HS.FHIR.DTL.vR4.Model.Resource.Patient) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Demo.JSONtoFHIR.InputFile' targetClass='HS.FHIR.DTL.vR4.Model.Resource.Patient' create='new' language='objectscript' >
<assign value='source.personid' property='target.id' action='set' />
<assign value='"usual"' property='target.identifier.(1).use' action='set' />
<assign value='source.identifiersystem' property='target.identifier.(1).type.coding.(1).system' action='set' />
<assign value='source.identifiercode' property='target.identifier.(1).type.coding.(1).code' action='set' />
<assign value='..Piece(source.patientname," ",2)' property='target.name.(1).family' action='set' />
<assign value='..Piece(source.patientname," ",1)' property='target.name.(1).given.(1)' action='set' />
<assign value='"official"' property='target.name.(1).use' action='set' />
<assign value='source.mobilephone' property='target.telecom.(1).value' action='set' />
<assign value='"mobile"' property='target.telecom.(1).use' action='set' />
<assign value='"phone"' property='target.telecom.(1).system' action='set' />
<assign value='1' property='target.telecom.(1).rank' action='set' />
<assign value='..Lookup("GenderLookupTable",source.sex)' property='target.gender' action='set' />
<assign value='..ConvertDateTime(source.birthdate,"%d/%m/%Y","%Y-%m-%d")' property='target.birthDate' action='set' />
<assign value='source.postaladdr' property='target.address.(1).text' action='set' />
<assign value='"home"' property='target.address.(1).use' action='set' />
<assign value='"both"' property='target.address.(1).type' action='set' />
<assign value='..Piece(..Strip(..Piece(source.postaladdr,",",1),"&lt;&gt;W")," ",1,3)' property='target.address.(1).line.(1)' action='set' />
<assign value='..Strip(..Piece(source.postaladdr,",",2),"&lt;&gt;W")' property='target.address.(1).district' action='set' />
<assign value='..Piece(..Strip(..Piece(source.postaladdr,",",1),"&lt;&gt;W")," ",4)' property='target.address.(1).city' action='set' />
<assign value='..Piece(..Strip(..Piece(source.postaladdr,",",3),"&lt;&gt;W")," ",1)' property='target.address.(1).state' action='set' />
<assign value='..Piece(..Strip(..Piece(source.postaladdr,",",3),"&lt;&gt;W")," ",2)' property='target.address.(1).postalCode' action='set' />
<assign value='..ConvertDateTime(source.postaladdrsince,"%d/%m/%Y","%Y-%m-%d")' property='target.address.(1).period.start' action='set' />
<assign value='source.deceased' property='target.deceasedBoolean' action='set' />
</transform>
}

}
