# infra-module
Terraform module for all infra-tools and infrastructure


------

# infra-tools-module


Upgrading EKS CLUSTER to 1.27,
1. Update Module Source Tag:

- Modify the tag in deploy_current_release/eks/main.tf from 0.3.0 to 0.4.0. The 0.3.0 tag is tied to Kubernetes version 1.25.

2. Update Current Release Add-ons:

- Ensure the current release add-ons in deploy_current_release support the Kubernetes version in 0.4.0. For example, if v0.4.0 corresponds to EKS version 1.26, update the add-ons to be compatible with 1.26 by copying from examples/eks/main.tf to deploy_current_release.

3. Update Local EKS Version:

- In cloud/aws/eks/variable.tf, update the EKS version to the new target version, which is 1.27. For example, set the version to 1.27 in variable.tf.

4. Update Plugin Version:

- Modify examples/eks/main.tf to support version 1.27. You can find the necessary version details from the AWS plugins documentation [here](https://docs.aws.amazon.com/eks/latest/userguide/managing-kube-proxy.html).

Upgrade Test. 

1. This will symulate our current cluster version by create a test cluster with the current release in 0.4.0 (k8s 1.26 that all our environment is currently running ) using the deploy_current_release/eks/main.tf source module 

2. It will then run init and apply again using the examples/eks/main.tf which module source is from our local to upgrade the cluster from 1.26 to 1.27 

3. After the upgrade it will delete the test cluster 