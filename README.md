# betterstack-config

This repo is used to configure the [TangledWires status page](https://status.tangledwires.co.uk/).

It is designed to be used with OpenTofu, and may use features not available in Terraform.

## GitHub setup

Create a new GitHub Actions secret called `uptime_api_token`, with the content being an API token created at [https://betterstack.com/settings/global-api-tokens](https://betterstack.com/settings/global-api-tokens).
