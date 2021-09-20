# Ansible: Valheim deployment

Deploy Valheim to a Linux server!

This is a set of Ansible playbooks and prebuilt automation tools to deploy Valheim.
The aim of this repository is to make it simple to maintain a Valheim server.

## Getting Started

First, update the `hosts` file with your Valheim server(s).
This is a standard Ansible inventory file.

### Initialization (optional)

Optionally, run the following command to bootstrap your servers:

    make init

This will configure your Valheim server via the `initialize.yml` playbook.
By default, this includes server configuration and hardening.
It includes some pretty opinionated defaults, and it may not be for you!

### Installation

To install Valheim to the server:

    make deploy

After the deployment is finished,
Valheim will be deployed and running on your server's IP address.

## Maintenance

The playbooks will automatically configure nightly backups of your server by default.
However, in the event of server maintenance,
you may wish to take a local backup of your server:

    make backup

By default, backups are stored locally at `/opt/valheim/config`.
The location of these backups are configurable.

## Configuration

| Variable                   | Description                           | Default               |
|----------------------------|---------------------------------------|-----------------------|
| `valheim_config_dir`       | Valheim backups directory.            | `/opt/valheim/config` |
| `valheim_backups_schedule` | Cron syntax for frequency of backups. | `5 6 * * *`           |
| `valheim_password`         | Valheim server password.              | none                  |
| `valheim_port`             | Port on which Valheim will listen.    | `2456`                |
| `valheim_public`           | True: internet; False: LAN.           | `true`                |
| `valheim_servername`       | Valheim server name.                  | `"Valheim server"`    |

## License

See [LICENSE](LICENSE).

