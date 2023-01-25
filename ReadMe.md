<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_address.static](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_firewall.firewall](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.webserverrule](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.dev](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_email"></a> [email](#input\_email) | n/a | `string` | n/a | yes |
| <a name="input_privatekeypath"></a> [privatekeypath](#input\_privatekeypath) | n/a | `string` | `"~/.ssh/github.prv"` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | n/a | yes |
| <a name="input_publickeypath"></a> [publickeypath](#input\_publickeypath) | n/a | `string` | `"~/.ssh/github.pub"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"eu-central"` | no |
| <a name="input_user"></a> [user](#input\_user) | n/a | `string` | n/a | yes |

## Description
This is a Terraform configuration file that creates several resources on Google Cloud Platform (GCP). The first block "terraform" sets the backend to Google Cloud Storage (GCS) with a specified bucket and prefix for storing the state file.

The second block "provider" sets the provider to Google and includes variables for the project and region.

The next two blocks "google_compute_firewall" create two firewall rules, one named "crypto-mon-firewall-externalssh" that allows incoming TCP traffic on port 22 and assigns it the tag "externalssh", and another named "crypto-mon-webserver" that allows incoming TCP traffic on ports 80, 443, and 8080 and assigns it the tag "webserver". Both of these firewall rules allows traffic from any IP address (0.0.0.0/0) and apply to the default network.

Then, a "google_compute_address" resource named "vm-public-address" is created. It uses the project and region variables and depends on the firewall rule "crypto-mon-firewall-externalssh"

Lastly, a "google_compute_instance" resource named "devserver" is created. It has a machine type of "f1-micro", is located in the specified region and availability zone, is assigned the tags "externalssh" and "webserver", and uses a boot disk with the image "centos-cloud/centos-7". It also creates a network interface using the default network and assigns the static IP address to the instance using the "google_compute_address" resource created earlier.

A provisioner block is used to install and configure various software, such as Nginx, python3, Java 11, Jenkins, and starts the Jenkins service. It depends on the two firewall rules created earlier, and has a service account with the specified email and read-only scope for compute resources. Finally, it adds the specified user's public key as a metadata key for SSH access.
