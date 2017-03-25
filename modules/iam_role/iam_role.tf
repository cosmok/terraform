# Input Variables
variable "name" {}

variable "path" {
  default = "/"
}

variable "principal_service_identifiers" {
  type = "list"
}

variable "not_principal_service_identifiers" {
  default = []
}

data "aws_iam_policy_document" "assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = "${var.principal_service_identifiers}"
    }
  }
}

resource "aws_iam_role" "role" {
  name               = "${var.name}"
  path               = "${var.path}"
  assume_role_policy = "${data.aws_iam_policy_document.assume_policy.json}"
}

resource "aws_iam_instance_profile" "profile" {
  roles = ["${aws_iam_role.role.name}"]
}

output "role_arn" {
  value = "${aws_iam_role.role.arn}"
}

output "role_create_date" {
  value = "${aws_iam_role.role.create_date}"
}

output "role_unique_id" {
  value = "${aws_iam_role.role.unique_id}"
}

output "role_name" {
  value = "${aws_iam_role.role.name}"
}

output "instance_profile_id" {
  value = "${aws_iam_instance_profile.profile.id}"
}

output "instance_profile_arn" {
  value = "${aws_iam_instance_profile.profile.arn}"
}

output "instance_profile_create_date" {
  value = "${aws_iam_instance_profile.profile.create_date}"
}

output "instance_profile_name" {
  value = "${aws_iam_instance_profile.profile.name}"
}

output "instance_profile_path" {
  value = "${aws_iam_instance_profile.profile.path}"
}

output "instance_profile_roles" {
  value = "${aws_iam_instance_profile.profile.roles}"
}

output "instance_profile_unique_id" {
  value = "${aws_iam_instance_profile.profile.unique_id}"
}
