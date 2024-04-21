resource "aws_iam_policy" "glue_crawler_policy" {
    name        = "S3GlueServiceRole"
    description = "Policy for AWS Glue service role which allows access to related services."

    policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "glue:*",
                    "ec2:DescribeVpcEndpoints",
                    "ec2:DescribeRouteTables",
                    "ec2:CreateNetworkInterface",
                    "ec2:DeleteNetworkInterface",
                    "ec2:DescribeNetworkInterfaces",
                    "ec2:DescribeSecurityGroups",
                    "ec2:DescribeSubnets",
                    "ec2:DescribeVpcAttribute",
                    "iam:ListRolePolicies",
                    "iam:GetRole",
                    "iam:GetRolePolicy",
                    "cloudwatch:PutMetricData"
                ],
                "Resource": ["*"]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:CreateTags",
                    "ec2:DeleteTags"
                ],
                "Condition": {
                    "ForAllValues:StringEquals": {
                        "aws:TagKeys": [
                            "aws-glue-service-resource"
                        ]
                    }
                },
                "Resource": [
                    "arn:aws:ec2:*:*:network-interface/*",
                    "arn:aws:ec2:*:*:security-group/*",
                    "arn:aws:ec2:*:*:instance/*"
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "logs:CreateLogGroup",
                    "logs:CreateLogStream",
                    "logs:PutLogEvents"
                ],
                "Resource": [
                    "arn:aws:logs:*:*:*:/aws-glue/*"
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "s3:CreateBucket"
                ],
                "Resource": [
                    "arn:aws:s3:::aws-glue-*"
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "s3:GetObject",
                    "s3:PutObject",
                    "s3:DeleteObject"
                ],
                "Resource": [
                    "arn:aws:s3:::aws-glue-*/*",
                    "arn:aws:s3:::*/*aws-glue-*/*"
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "s3:GetObject"
                ],
                "Resource": [
                    "arn:aws:s3:::crawler-public*",
                    "arn:aws:s3:::aws-glue-*"
                ]
            },
        ]
    })
}

output "policy_out" {
  value = [aws_iam_policy.glue_crawler_policy.arn]
}