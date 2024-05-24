# IRIS For Health Demo

InterSystems IRIS for Health Demos in a Docker container.

## Running the demo

1. Clone repository
2. Edit `.env`
3. Run `./setup.sh`

On a Windows machine use `WSL` oder `git bash`. If you want to use Let's encrypt certificates make sure to configre a publicly resolvable FQDN as `WEBGATEWAY_HOSTNAME` and that port 80 is accessible from the Internet. Let's encrypt is only supported on a Linux (and probably WSL2) machine that has snapd installed. 

## Usage

Open http://localhost:8002/csp/sys/UtilHome.csp. Login as SuperUser (password: "SYS123"). The demo includes the following demos which can be found in separate namespaces:

- **FHIRSERVER**: Uses the InterSystems FHIR Server and Interoperability to implement a use-case where a patient gets notfied if their appointment is changed. Appointment changes are triggered via FHIR Put messages. Make sure to use PUT instead of POST for the FHIR sample requests. The sample Patient-ID is 101 and the sample Appointment-ID is 501.
- **COMSERVER**: Uses InterSystems Interoperability to demonstrate HL7 routing from a CIS to a lab and kitchen system, as well as integrated conversion from HL7 to FHIR via SDA3 (requires the FHIRSERVER demo, otherwise the FHIR-HTTP-Operation will not work).
- **JSONTOFHIR**: Converts proprietary JSON data to FHIR bundle by using InterSystems Interoperability, BPLs and DTLs. The demo is executed via the built-in test function in the Production. Invoke a TestRequest in "Get JSON File and Convert to Object" Business Service. The schema is generated during the first execution; the actual conversion takes place from the second execution onwards.
- **FHIRFACADE**: A FHIR Observation (blood pressure, e.g. from a smart device) is received via REST (endoint: /fhirdacade/Observation), converted to a proprietary format and stored in a SQL databse.




