<!--- BEGIN_TF_DOCS --->
# Google Cloud Run deployment module

Configurable module to:

* create a Cloud Run service based on the provided container image
* create a load balancer for the Cloud Run service and (optionally) a DNS record pointing to that load balancer

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.13.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.58 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 3.58 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lb"></a> [lb](#module\_lb) | GoogleCloudPlatform/lb-http/google//modules/serverless_negs | ~> 4.5.0 |
| <a name="module_service_account"></a> [service\_account](#module\_service\_account) | terraform-google-modules/service-accounts/google | ~> 3.0.0 |

## Resources

| Name | Type |
|------|------|
| [google_cloud_run_service.service](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service) | resource |
| [google_cloud_run_service_iam_member.public_access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service_iam_member) | resource |
| [google_compute_region_network_endpoint_group.serverless_neg](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_network_endpoint_group) | resource |
| [google_dns_record_set.dns_record](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_managed_ssl_certificate_domains"></a> [additional\_managed\_ssl\_certificate\_domains](#input\_additional\_managed\_ssl\_certificate\_domains) | Additional DNS records to be included in the certificate chain | `list(string)` | `[]` | no |
| <a name="input_cloud_run_service_name"></a> [cloud\_run\_service\_name](#input\_cloud\_run\_service\_name) | Name for the Cloud Run service | `string` | n/a | yes |
| <a name="input_container_env"></a> [container\_env](#input\_container\_env) | Map of environment variables that will be passed to the container | `map(string)` | `null` | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | Container image to use, eg. `gcr.io/my-project/my-image:latest`. Image needs to be stored either in Google Container Registry or Google Artifact Registry | `string` | n/a | yes |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | TCP port to open in the container | `number` | `8080` | no |
| <a name="input_container_resources_limits_cpus"></a> [container\_resources\_limits\_cpus](#input\_container\_resources\_limits\_cpus) | CPUs measured in 1000 cpu units to allocate to service instances. Have a look at https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-cpu for details. | `number` | `1` | no |
| <a name="input_container_resources_limits_memory"></a> [container\_resources\_limits\_memory](#input\_container\_resources\_limits\_memory) | Memory in MiB (2^26 bytes) to allocate to service instances. Have a look at https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-memory for details. | `number` | `256` | no |
| <a name="input_create_service_account"></a> [create\_service\_account](#input\_create\_service\_account) | Whether to create a new service account associated with the revision of the service | `bool` | `false` | no |
| <a name="input_dns_managed_zone"></a> [dns\_managed\_zone](#input\_dns\_managed\_zone) | Name of the Google managed zone the DNS record will be created in | `string` | `""` | no |
| <a name="input_dns_record_name"></a> [dns\_record\_name](#input\_dns\_record\_name) | Record name of the `domain_name` parameter pointing at the load balancer on (e.g. `registry`). Used if `ssl` is `true` | `string` | `""` | no |
| <a name="input_dns_record_project_id"></a> [dns\_record\_project\_id](#input\_dns\_record\_project\_id) | Project ID the Google managed zone the DNS record will be created in. If empty `project_id` will be used. | `string` | `""` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain name to run the load balancer on (e.g. example.com). Used if `ssl` is `true` | `string` | `""` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | `map(string)` | `null` | no |
| <a name="input_lb_backend_log_config_enable"></a> [lb\_backend\_log\_config\_enable](#input\_lb\_backend\_log\_config\_enable) | This field denotes the logging options for the load balancer traffic served by this backend service. If logging is enabled, logs will be exported to Stackdriver. If set `true` sample rate will be set 1.0. | `bool` | `false` | no |
| <a name="input_lb_backend_log_config_sample_rate"></a> [lb\_backend\_log\_config\_sample\_rate](#input\_lb\_backend\_log\_config\_sample\_rate) | This field can only be specified if logging is enabled for this backend service. The value of the field must be in [0, 1]. This configures the sampling rate of requests to the load balancer where 1.0 means all logged requests are reported and 0.0 means no logged requests are reported. The default value is 1.0. | `number` | `1` | no |
| <a name="input_lb_name"></a> [lb\_name](#input\_lb\_name) | Name for load balancer and associated resources | `string` | `"cr-lb"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name which will be used as a part of NEG name | `string` | `"cr"` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | Add a name suffix to relevant Terraform resources | `string` | `""` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID to use | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Location for load balancer and Cloud Run resources | `string` | `"europe-west3"` | no |
| <a name="input_service_account_display_name"></a> [service\_account\_display\_name](#input\_service\_account\_display\_name) | Display name for the created service account. Used only if `create_service_account` is set to `true` | `string` | `"Cloud Run service account"` | no |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | Email address of the IAM service account associated with the revision of the service. The service account represents the identity of the running revision, and determines what permissions the revision has. If not provided and `create_service_account` is set to `false`, the revision will use the project's default service account (PROJECT\_NUMBER-compute@developer.gserviceaccount.com). Ignored if `create_service_account` is set to `true` | `string` | `null` | no |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | Name of the service account to create. Used only if `create_service_account` is set to `true` | `string` | `"cr-sa"` | no |
| <a name="input_service_account_roles"></a> [service\_account\_roles](#input\_service\_account\_roles) | List of permissions set to the service account to be created. E.g. `["project_id=>roles/editor"]`. | `list(string)` | `[]` | no |
| <a name="input_ssl"></a> [ssl](#input\_ssl) | Run load balancer on HTTPS and provision managed certificate with provided `domain` | `bool` | `true` | no |
| <a name="input_template_metadata_annotations"></a> [template\_metadata\_annotations](#input\_template\_metadata\_annotations) | n/a | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_run_service_name"></a> [cloud\_run\_service\_name](#output\_cloud\_run\_service\_name) | Cloud Run service name. |
| <a name="output_cloud_run_status"></a> [cloud\_run\_status](#output\_cloud\_run\_status) | From RouteStatus. URL holds the url that will distribute traffic over the provided traffic targets. It generally has the form https://{route-hash}-{project-hash}-{cluster-level-suffix}.a.run.app |
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | DNS name which points to the created load balancer |
| <a name="output_load_balancer_ip"></a> [load\_balancer\_ip](#output\_load\_balancer\_ip) | External IP of the created load balancer |
| <a name="output_service_account_email"></a> [service\_account\_email](#output\_service\_account\_email) | Email address of the IAM service account associated with the revision of the service |
| <a name="output_suffix"></a> [suffix](#output\_suffix) | Random ID used for LB, Cloud Run service and NEG naming |

<!--- END_TF_DOCS --->
