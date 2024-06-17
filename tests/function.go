package terraform

import (
	"bytes"
	"fmt"
	"os/exec"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

// InitAndApply calls terraform InitAndApply and handles errors
func InitAndApply(t *testing.T, options *terraform.Options) string {
	out, err := terraform.InitAndApplyE(t, options)
	require.NoError(t, err)
	return out
}

// Destroy runs terraform destroy with the given options and returns stdout/stderr.
func Destroy(t *testing.T, options *terraform.Options) string {
	var out string
	var err error

	// Retry logic
	retries := 3
	for i := 0; i < retries; i++ {
		out, err = terraform.DestroyE(t, options)
		if err == nil {
			return out
		}
		fmt.Printf("Destroy attempt %d failed: %s\n", i+1, err)
		time.Sleep(30 * time.Second) // Wait for 30 seconds before retrying
	}

	// If all retries fail, require error to fail the test
	require.NoError(t, err, "Failed to destroy resources after multiple attempts: %s", out)
	return out
}

func VerifyEKSCluster(t *testing.T) {
	if !t.Failed() {
		// Update kubeconfig
		cmd := exec.Command("aws", "eks", "--region", "eu-west-2", "update-kubeconfig", "--name", "test-eks")
		err := cmd.Run()
		require.NoError(t, err, "Error updating kubeconfig")

		// Get nodes
		cmd = exec.Command("kubectl", "get", "nodes")
		err = cmd.Run()
		require.NoError(t, err, "Error getting nodes")

		// Get pods
		cmd = exec.Command("kubectl", "get", "pods", "-A")
		err = cmd.Run()
		require.NoError(t, err, "Error getting pods")
	}
}

func VerifyEKSVersion(t *testing.T) {
	if !t.Failed() {
		// Update kubeconfig
		cmd := exec.Command("aws", "eks", "--region", "eu-west-2", "update-kubeconfig", "--name", "test-eks")
		err := cmd.Run()
		require.NoError(t, err, "Error updating kubeconfig")

		// Verify EKS kubectl version
		cmd = exec.Command("kubectl", "version")
		var out bytes.Buffer
		cmd.Stdout = &out
		cmd.Stderr = &out
		err = cmd.Run()
		require.NoError(t, err, "Error getting kubectl version")

		// Print the output of kubectl version with a custom message
		fmt.Printf("EKS version is: %s\n", out.String())
	}
}
