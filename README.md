<!--- BEGIN_TF_DOCS --->
# Google Cloud Run deployment module

Configurable module to:

* create a Cloud Run service based on the provided container image
* create a load balancer for the Cloud Run service and (optionally) a DNS record pointing to that load balancer

## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.13.5 |
| google | ~> 3.58 |
| random | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 3.58 |
| random | ~> 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_managed\_ssl\_certificate\_domains | Additional DNS records to be included in the certificate chain | `list(string)` | `[]` | no |
| cloud\_run\_service\_name | Name for the Cloud Run service | `string` | n/a | yes |
| container\_env | Map of environment variables that will be passed to the container | `map(string)` | `null` | no |
| container\_image | Container image to use, eg. `gcr.io/my-project/my-image:latest`. Image needs to be stored either in Google Container Registry or Google Artifact Registry | `string` | n/a | yes |
| container\_port | TCP port to open in the container | `number` | `8080` | no |
| create\_service\_account | Whether to create a new service account associated with the revision of the service | `bool` | `false` | no |
| dns\_managed\_zone | Name of the Google managed zone the DNS record will be created in | `string` | `""` | no |
| dns\_record\_name | Record name of the `domain_name` parameter pointing at the load balancer on (e.g. `registry`). Used if `ssl` is `true` | `string` | `""` | no |
| domain\_name | Domain name to run the load balancer on (e.g. example.com). Used if `ssl` is `true` | `string` | `""` | no |
| lb\_name | Name for load balancer and associated resources | `string` | `"cr-lb"` | no |
| name | Name which will be used as a part of NEG name | `string` | `"cr"` | no |
| name\_suffix | Add a name suffix to relevant Terraform resources | `string` | `""` | no |
| project\_id | GCP project ID to use | `string` | n/a | yes |
| region | Location for load balancer and Cloud Run resources | `string` | `"europe-west3"` | no |
| service\_account\_display\_name | Display name for the created service account. Used only if `create_service_account` is set to `true` | `string` | `"Cloud Run service account"` | no |
| service\_account\_email | Email address of the IAM service account associated with the revision of the service. The service account represents the identity of the running revision, and determines what permissions the revision has. If not provided and `create_service_account` is set to `false`, the revision will use the project's default service account (PROJECT\_NUMBER-compute@developer.gserviceaccount.com). Ignored if `create_service_account` is set to `true` | `string` | `null` | no |
| service\_account\_name | Name of the service account to create. Used only if `create_service_account` is set to `true` | `string` | `"cr-sa"` | no |
| service\_account\_roles | List of permissions set to the service account to be created. E.g. `["project_id=>roles/editor"]`. | `list(string)` | `[]` | no |
| ssl | Run load balancer on HTTPS and provision managed certificate with provided `domain` | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloud\_run\_status | From RouteStatus. URL holds the url that will distribute traffic over the provided traffic targets. It generally has the form https://{route-hash}-{project-hash}-{cluster-level-suffix}.a.run.app |
| dns\_name | DNS name which points to the created load balancer |
| load\_balancer\_ip | External IP of the created load balancer |
| service\_account\_email | Email address of the IAM service account associated with the revision of the service |
| suffix | Random ID used for LB, Cloud Run service and NEG naming |

<!--- END_TF_DOCS --->
