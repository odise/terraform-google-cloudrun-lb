# Usage
<!--- BEGIN_TF_DOCS --->
## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| container\_image | URI of the container image to use (needs to be stored stored either in Google Container Registry or Google Artifact Registry) | `string` | n/a | yes |
| project\_id | GCP project ID to use | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cloud\_run\_status | From RouteStatus. URL holds the url that will distribute traffic over the provided traffic targets. It generally has the form https://{route-hash}-{project-hash}-{cluster-level-suffix}.a.run.app |
| dns\_name | n/a |
| load\_balancer\_ip | n/a |
| service\_account\_email | n/a |
| suffix | n/a |

<!--- END_TF_DOCS --->
