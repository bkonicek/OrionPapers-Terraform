provider "aws" {
  region = "${var.region}"
}

resource "aws_iam_user" "kunal" {
  name = "Kunal"
}

resource "aws_iam_user" "matt" {
  name = "Matt"
}

resource "aws_iam_user" "donna" {
  name = "Donna"
}

resource "aws_iam_group_membership" "dev_members" {
  name = "Dev Users"

  users = [
    "${aws_iam_user.donna.name}",
    "${aws_iam_user.matt.name}",
    "${aws_iam_user.kunal.name}",
  ]

  group = "${aws_iam_group.dev.name}"
}

resource "aws_iam_account_password_policy" "pw_policy" {
  allow_users_to_change_password = "${var.allow_user_change}"
  minimum_password_length        = "${var.min_pw_length}"
  require_lowercase_characters   = "${var.require_lowercase}"
  require_numbers                = "${var.require_nums}"
  require_symbols                = "${var.require_sym}"
  max_password_age               = "${var.max_pw_age}"
  hard_expiry                    = "${var.expiry}"
  password_reuse_prevention      = "${var.password_reuse}"
}

resource "aws_iam_group" "dev" {
  name = "Dev"
}

resource "aws_iam_group_policy_attachment" "s3_dev_group" {
  policy_arn = "${var.s3_full_access_policy}"
  group      = "${aws_iam_group.dev.name}"
}

resource "aws_iam_role" "ec2_s3_access" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  name = "EC2-S3-Access"
}

resource "aws_iam_role_policy_attachment" "ec2-s3-access" {
  policy_arn = "${var.s3_full_access_policy}"
  role       = "${aws_iam_role.ec2_s3_access.name}"
}
