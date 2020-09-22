/*
SPDX-FileCopyrightText: 2019 SAP SE or an SAP affiliate company and Gardener contributors
SPDX-License-Identifier: Apache-2.0
*/

// Package validation - validation is used to validate cloud specific ProviderSpec
package validation

import (
	api "github.com/flant/machine-controller-manager-provider-yandex/pkg/provider/apis"
	corev1 "k8s.io/api/core/v1"
)

// ValidateProviderSpecNSecret validates provider spec and secret to check if all fields are present and valid
func ValidateProviderSpecNSecret(_ *api.YandexProviderSpec, _ *corev1.Secret) []error {
	// Code for validation of providerSpec goes here
	return nil
}
