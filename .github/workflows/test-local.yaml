name: Test Local

on:
  workflow_dispatch:

defaults:
  run:
    shell: bash

jobs:
  test-local:
    name: 'Test Local'
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository code
        uses: actions/checkout@v3

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v2
        with:
          terraform_version: 1.2.3
          terraform_wrapper: false

      - name: Run Terraform
        working-directory: terraform-test
        run: |
          terraform init
          terraform plan
