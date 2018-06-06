provider "aws" {
  region = "${var.region}"
}

resource "aws_iam_user" "kunal" {
  name = "Kunal"
}

resource "aws_iam_user_policy_attachment" "s3_kunal" {
  user       = "${aws_iam_user.kunal.name}"
  policy_arn = "${var.s3_access_policy}"
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
