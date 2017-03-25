provider "aws" {
  region = "ap-southeast-2"
}

module "iam_policy_ec2" "ec2_read_policy" {
  source      = "../modules/iam_policy"
  name        = "ec2-read-tags"
  description = "read instance tags"
  effect      = "Allow"
  resources   = ["arn:aws:ec2"]
  actions     = ["ec2:Describe*"]
}

module "iam_policy_s3" "s3_test_all" {
  source      = "../modules/iam_policy"
  name        = "s3-test-all"
  description = "all access to s3:/test"
  effect      = "Allow"
  resources   = ["arn:aws:s3:::test"]
  actions     = ["s3:*"]
}

module "iam_role_s3_and_ec2" "s3_and_ec2" {
  source                        = "../modules/iam_role"
  name                          = "s3_and_ec2"
  principal_service_identifiers = ["ec2.amazonaws.com", "redshift.amazonaws.com"]
}

module "iam_role_ec2" "ec2" {
  source                        = "../modules/iam_role"
  name                          = "ec2"
  principal_service_identifiers = ["ec2.amazonaws.com"]
}

resource "aws_iam_role_policy_attachment" "attach_ec2_to_s3_and_ec2" {
  role       = "${module.iam_role_s3_and_ec2.role_name}"
  policy_arn = "${module.iam_policy_ec2.permission_policy_arn}"
}

resource "aws_iam_role_policy_attachment" "attach_s3_to_s3_and_ec2" {
  role       = "${module.iam_role_s3_and_ec2.role_name}"
  policy_arn = "${module.iam_policy_s3.permission_policy_arn}"
}

resource "aws_iam_role_policy_attachment" "attach_ec2_to_ec2" {
  role       = "${module.iam_role_ec2.role_name}"
  policy_arn = "${module.iam_policy_ec2.permission_policy_arn}"
}
