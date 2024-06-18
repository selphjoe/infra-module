package terraform

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"testing"
	"time"
)

const (
	terraformDir = "../examples/eks/"
	terraformDirOld    = "./deploy_current_release/eks"
	ec2Dir            = "../cloud-servers/aws/ecs"
)
func TestEKSDeploy(t *testing.T) {

	// Define the Terraform options
	options := &terraform.Options{
		TerraformDir: terraformDir,
		NoColor:      true,
	}

	// Initialize and apply the Terraform configuration
	InitAndApply(t, options)

	// Verify cluster creation by updating the kubeconfig, get nodes and pods

	VerifyEKSCluster(t)

	// Sleep for a period before destroying the Terraform infrastructure
	time.Sleep(2 * time.Second)

	// perform a cleanup
	defer func() {
		Destroy(t, options)
	}()

}
func TestEKSUpgrade(t *testing.T) {

	// Define the Terraform options for the current release
	terraformDirOldOptions := &terraform.Options{
		TerraformDir: terraformDirOld,
		NoColor:      true,
	}

	// Initialize and apply the Terraform configuration for the current release
	InitAndApply(t, terraformDirOldOptions)

	// Verify cluster creation by updating the kubeconfig, get nodes and pods
	VerifyEKSCluster(t)

	// Verify EKS version before the upgrade
	VerifyEKSVersion(t)

	// Sleep for a period before performing upgrade
	time.Sleep(2 * time.Second)

	// If the current release was successful, proceed to upgrade the cluster using the upgradable release
	if t.Failed() == false {
		// Define the Terraform options for the upgradable release
		terraformDirOptions := &terraform.Options{
			TerraformDir: terraformDir,
			NoColor:      true,
		}
		// Initialize and apply the Terraform configuration for the upgradable release
		InitAndApply(t, terraformDirOptions)
	}

	// Verify cluster creation by updating the kubeconfig, get nodes and pods
	VerifyEKSCluster(t)

	// Verify EKS version after upgrade
	VerifyEKSVersion(t)

	// Sleep for a period before cleanup
	time.Sleep(10 * time.Second)

	// perform a cleanup
	defer func() {
		terraformDirOptions := &terraform.Options{
			TerraformDir: terraformDir,
			NoColor:      true,
		}
		Destroy(t, terraformDirOptions)
	}()
}

// func TestEC2Deploy(t *testing.T) {

// 	// Define the Terraform options
// 	options := &terraform.Options{
// 		TerraformDir: EC2Dir,
// 		NoColor:      true,
// 	}

// 	// Initialize and apply the Terraform configuration
// 	InitAndApply(t, options)

// 	// Sleep for a period before destroying the Terraform infrastructure
// 	time.Sleep(10 * time.Second)

// 	defer func() {
// 		Destroy(t, options)
// 	}()

// }
