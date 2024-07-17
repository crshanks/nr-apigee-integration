[![New Relic Experimental header](https://github.com/newrelic/opensource-website/raw/master/src/images/categories/Experimental.png)](https://opensource.newrelic.com/oss-category/#new-relic-experimental)
# nr-apigee-integration
This repository contains reusable configuration to provide observability of [Apigee](https://cloud.google.com/apigee/docs/api-platform/get-started/what-apigee) proxies through New Relic, using [W3C Trace Context](https://www.w3.org/TR/trace-context/) distributed tracing, metrics, and logs in context.

## Installation
Assumes an Apigee-X environment, but there is no reason this shouldn't work with Apigee Edge, aside from credentials.
### Prerequisites
* [maven](https://maven.apache.org/) - the deployment of proxies makes use of the [apigee-deploy-maven-plugin](https://github.com/apigee/apigee-deploy-maven-plugin)
* [gcloud CLI](https://cloud.google.com/sdk/docs/install)

### Configuration properties file
Update the [newrelic.properties.sample](newrelic.properties.sample) properties file to provide the configuration for your environment, and rename it `newrelic.properties`. **Important do not commit this new file to git!** (It should be ignored in `.gitignore` already.)
The newrelic.properties file contains the following value:
* LICENSE_KEY: your New Relic [Ingest License API key](https://docs.newrelic.com/docs/apis/intro-apis/new-relic-api-keys/#license-key)

Set the gcloud project, e.g. `gcloud config set project silicon-shape-123456`

Create, or update a propertyset named `NewRelicPropSet` for your environment using [props-create.sh](props-create.sh), and [props-update.sh](props-update.sh) respectively. Use [props-get.sh](props-get.sh) to verify the property set has been created successfully. Use [props-delete.sh](props-delete.sh) to delete the property set.

### Maven configuration
If you are using the New Relic EU region, instead of the US region, change the host endpoint values.
* For logging edit the [config.json](sharedflows/src/gateway/nr-logging-sharedflow/config.json) file. Use either `newrelic.syslog.nr-data.net` or `newrelic.syslog.eu.nr-data.net` depending on whether your New Relic account is hosted in the US or EU region respectively  
* For tracing edit the [config.json](sharedflows/src/gateway/nr-trace-api-sharedflow/config.json) file. Use either `trace-api.newrelic.com` or `trace-api.eu.newrelic.com` depending on whether your New Relic account is hosted in the US or EU region respectively

To configure the slow requests auto sample time edit the [config.json](sharedflows/src/gateway/nr-instrumentation-sharedflow/config.json) file. This is the time, in milliseconds, that will initiate auto-sampling of slow proxy requests. Suggested `5000`ms (5 seconds)

### Environment variables
Set the following environment variables:
* APIGEE_ORG: the name of your Apigee organization, e.g `silicon-shape-123456`
* APIGEE_ENV: your agigee environment. The proxies can be configured per environment, e.g. `dev`

If the environment variables are not set, they can alternatively be provided in the following file locations:
* [props-create.sh](props-create.sh), [props-update.sh](props-update.sh), and [props-get.sh](props-get.sh)
* deploy.sh for each of the proxies 

### Shared flows
The instrumentation examples in this repository make use of [shared flows](https://cloud.google.com/apigee/docs/api-platform/fundamentals/shared-flows).

Example API proxies are contained in the [examples](examples) directory. The example proxies are dependent on the following shared flows:
* nr-instrumentation-sharedflow
* nr-log-api-sharedflow
* nr-logging-sharedflow
* nr-metric-api-sharedflow
* nr-trace-api-sharedflow

To install the shared flows:
1. Execute the [deploy.sh](sharedflows/src/gateway/nr-instrumentation-sharedflow/deploy.sh) script from within the [sharedflows/src/gateway/nr-instrumentation-sharedflow](sharedflows/src/gateway/nr-instrumentation-sharedflow) directory.
2. Execute the [deploy.sh](sharedflows/src/gateway/nr-log-api-sharedflow/deploy.sh) script from within the [sharedflows/src/gateway/nr-log-api-sharedflow](sharedflows/src/gateway/nr-log-api-sharedflow) directory.
3. Execute the [deploy.sh](sharedflows/src/gateway/nr-logging-sharedflow/deploy.sh) script from within the [sharedflows/src/gateway/nr-logging-sharedflow](sharedflows/src/gateway/nr-logging-sharedflow) directory.
4. Execute the [deploy.sh](sharedflows/src/gateway/nr-metric-api-sharedflow/deploy.sh) script from within the [sharedflows/src/gateway/nr-metric-api-sharedflow](sharedflows/src/gateway/nr-metric-api-sharedflow) directory.
5. Execute the [deploy.sh](sharedflows/src/gateway/nr-trace-api-sharedflow/deploy.sh) script from within the [sharedflows/src/gateway/nr-trace-api-sharedflow](sharedflows/src/gateway/nr-trace-api-sharedflow) directory.

### Example flow
To install the example flows:
1. Execute the [deploy.sh](examples/newrelic-log/deploy.sh) script from within the [examples/newrelic-log](examples/newrelic-log) directory.
2. Execute the [deploy.sh](examples/newrelic-logging/deploy.sh) script from within the [examples/newrelic-logging](examples/newrelic-logging) directory.
3. Execute the [deploy.sh](examples/newrelic-metric/deploy.sh) script from within the [examples/newrelic-metric](examples/newrelic-metric) directory.
4. Execute the [deploy.sh](examples/newrelic-trace/deploy.sh) script from within the [examples/newrelic-trace](examples/newrelic-trace) directory.
5. Execute the [deploy.sh](examples/newrelic-trace-and-logging/deploy.sh) script from within the [examples/newrelic-trace-and-logging](examples/newrelic-trace-and-logging) directory.
6. Execute the [deploy.sh](examples/newrelic-trace-and-metric-and-log/deploy.sh) script from within the [examples/newrelic-trace-and-metric-and-log](examples/newrelic-trace-and-metric-and-log) directory.

## Synthetics tests for the example API proxies
Terraform configuration is available to create synthetics monitors to exercise the sample API proxies. Take a look at the [README.md](synthetics-tests/README.md) file in the [synthetics-tests](synthetics-tests) directory for more information.

## Acknowledgements
The distributed tracing instrumentation code here owes much to the https://github.com/sri-shetty/DT-Apigee-Proxy repository.

# Support

New Relic has open-sourced this project. This project is provided AS-IS WITHOUT WARRANTY OR DEDICATED SUPPORT. Issues and contributions should be reported to the project here on GitHub.

We encourage you to bring your experiences and questions to the [Explorers Hub](https://discuss.newrelic.com) where our community members collaborate on solutions and new ideas.

## Issues / enhancement requests

Issues and enhancement requests can be submitted in the [Issues tab of this repository](../../issues). Please search for and review the existing open issues before submitting a new issue.

# Contributing

Contributions are encouraged! If you submit an enhancement request, we'll invite you to contribute the change yourself. Please review our [Contributors Guide](CONTRIBUTING.md).

Keep in mind that when you submit your pull request, you'll need to sign the CLA via the click-through using CLA-Assistant.

# Open source license
This project is distributed under the [Apache 2 license](LICENSE).
