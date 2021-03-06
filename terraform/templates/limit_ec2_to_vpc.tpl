{
   "Version": "2012-10-17",
   "Statement": [
      {
         "Sid": "NonResourceBasedReadOnlyPermissions",
         "Action": [
            "ec2:Describe*",
            "ec2:CreateKeyPair",
            "ec2:CreateSecurityGroup",
            "iam:GetInstanceProfile",
            "iam:ListInstanceProfiles"
         ],
         "Effect": "Allow",
         "Resource": "*"
      },
      {
         "Sid": "IAMPassRoleToInstance",
         "Action": [
            "iam:PassRole"
         ],
         "Effect": "Allow",
         "Resource": "arn:aws:iam::${ACCOUNTNUMBER}:role/ROLENAME"
      },
      {
         "Sid": "AllowInstanceActions",
         "Effect": "Allow",
         "Action": [
            "ec2:RebootInstances",
            "ec2:StopInstances",
            "ec2:TerminateInstances",
            "ec2:StartInstances",
            "ec2:AttachVolume",
            "ec2:DetachVolume"
         ],
         "Resource": "arn:aws:ec2:${REGION}:${ACCOUNTNUMBER}:instance/*",
         "Condition": {
            "StringEquals": {
               "ec2:InstanceProfile": "arn:aws:iam::${ACCOUNTNUMBER}:instance-profile/ROLENAME"

            }
         }
      },
      {
         "Sid": "EC2RunInstances",
         "Effect": "Allow",
         "Action": "ec2:RunInstances",
         "Resource": "arn:aws:ec2:${REGION}:${ACCOUNTNUMBER}:instance/*",
         "Condition": {
            "StringEquals": {
               "ec2:InstanceProfile": "arn:aws:iam::${ACCOUNTNUMBER}:instance-profile/ROLENAME"
            }
         }
      },
      {
         "Sid": "EC2RunInstancesSubnet",
         "Effect": "Allow",
         "Action": "ec2:RunInstances",
         "Resource": "arn:aws:ec2:${REGION}:${ACCOUNTNUMBER}:subnet/*",
         "Condition": {
            "StringEquals": {
               "ec2:vpc": "arn:aws:ec2:${REGION}:${ACCOUNTNUMBER}:vpc/${VPC-ID}"
            }
         }
      },
      {
         "Sid": "RemainingRunInstancePermissions",
         "Effect": "Allow",
         "Action": "ec2:RunInstances",
         "Resource": [        "arn:aws:ec2:${REGION}:${ACCOUNTNUMBER}:volume/*",
            "arn:aws:ec2:${REGION}::image/*",
            "arn:aws:ec2:${REGION}::snapshot/*",            "arn:aws:ec2:${REGION}:${ACCOUNTNUMBER}:network-interface/*",           "arn:aws:ec2:${REGION}:${ACCOUNTNUMBER}:key-pair/*",         "arn:aws:ec2:${REGION}:${ACCOUNTNUMBER}:security-group/*"
         ]
      },
      {
         "Sid": "EC2VpcNonresourceSpecificActions",
         "Effect": "Allow",
         "Action": [
            "ec2:DeleteNetworkAcl",
            "ec2:DeleteNetworkAclEntry",
            "ec2:DeleteRoute",
            "ec2:DeleteRouteTable",
            "ec2:AuthorizeSecurityGroupEgress",
            "ec2:AuthorizeSecurityGroupIngress",
            "ec2:RevokeSecurityGroupEgress",
            "ec2:RevokeSecurityGroupIngress",
            "ec2:DeleteSecurityGroup"
         ],
         "Resource": "*",
         "Condition": {
            "StringEquals": {
               "ec2:vpc": "arn:aws:ec2:${REGION}:${ACCOUNTNUMBER}:vpc/${VPC-ID}"
            }
         }
      }
   ]
}
