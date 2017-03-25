variable "name" {}

variable "description" {}

variable "path" {
  default = "/"
}

variable "effect" {
  default = "Allow"
}

variable "resources" {
  type = "list"
}

variable "not_resources" {
  default = []
}

variable "actions" {
  type = "list"
}

variable "not_actions" {
  default = []
}

data "aws_iam_policy_document" "permission_policy" {
  statement {
    sid = "1"

    effect        = "${var.effect}"
    actions       = "${var.actions}"
    not_actions   = "${var.not_actions}"
    resources     = "${var.resources}"
    not_resources = "${var.not_resources}"
  }
}

resource "aws_iam_policy" "permission_policy" {
  name        = "${var.name}"
  description = "${var.description}"
  policy      = "${data.aws_iam_policy_document.permission_policy.json}"
}

output "permission_policy_id" {
  value = "${aws_iam_policy.permission_policy.id}"
}

output "permission_policy_arn" {
  value = "${aws_iam_policy.permission_policy.arn}"
}

output "permission_policy_name" {
  value = "${aws_iam_policy.permission_policy.name}"
}

output "permission_policy_path" {
  value = "${aws_iam_policy.permission_policy.path}"
}

output "permission_policy_description" {
  value = "${aws_iam_policy.permission_policy.description}"
}

output "permission_policy_policy" {
  value = "${aws_iam_policy.permission_policy.policy}"
}
