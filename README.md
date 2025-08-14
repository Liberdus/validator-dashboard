# How to Install and Run a Liberdus Validator Node

This guide will walk you through the process of installing and running a Liberdus Validator Node on your system. Please follow the steps below carefully.

## Install Dockers

Do the following as root or a sudo privilaged user:

**For Linux:**

1. Install Package Managers

```bash
sudo apt-get install curl
```

2. Update Package Managers:

```bash
sudo apt update
```

3. Install docker

Install docker with docker.io

```bash
sudo apt install docker.io
```

> Verify Docker installation by running `docker --version` (should return version 20.10.12 or higher).

```bash
sudo docker --version
```

4. Install docker-compose

```bash
sudo apt install docker-compose
```

> Verify docker-compose installation by running `docker-compose --version` (should return version 1.29.2 or higher).

```bash
sudo docker-compose --version
```

**For MacOS:**

1. Install Package Managers

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Add Homebrew to your `PATH`:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
eval "$(/opt/homebrew/bin/brew shellenv)"
```

2. Update Package Managers:

```bash
brew update
```

3. Install docker

```bash
brew install docker
```

> Verify Docker installation by running `docker --version` (should return version 20.10.12 or higher).

4. Install docker-compose

```bash
brew install docker-compose
```

> Verify docker-compose installation by running `docker-compose --version` (should return version 1.29.2 or higher).

## Create a Liberdus User

Do the following as root or a sudo user to create a Liberdus user that will install and run the node:

```bash
sudo adduser liberdus
```

```bash
sudo usermod -aG sudo liberdus
```

```bash
su liberdus
```

```bash
cd
```

## Download and Run Installation Script

Do the following as the user created above and not as root.

```bash
curl -O https://raw.githubusercontent.com/liberdus/validator-dashboard/main/installer.sh && chmod +x installer.sh && ./installer.sh
```

Follow the instructions provided by the installer script. Ensure you input the correct Archiver and Monitor IP addresses for the network you wish your validator to join.

> If you are behind a router and you are using ports 9001 and 10001 for p2p communication, make sure ports 9001 and 10001, are forwarded (be careful doing this since it will modify your firewall). More info on router port forwarding: <https://www.noip.com/support/knowledgebase/general-port-forwarding-guide/>

## Starting the Validator

After the installation process completes, you can start the validator using either the web-based dashboard or the command line:

Using Web Dashboard:

- Open a web browser and navigate to the web dashboard at `https://localhost:8080` or https://ServerIP:8080
- Enter the password you set during the installation process.
- Select the network you want to run your validator on (testnet, devnet, or localnet).
- Click the `Start Node` button to launch your validator node.

Using Command Line:

- Open a terminal and navigate to the Liberdus home directory (`$HOME/.liberdus`).
- Enter the validator container with `./shell`.
- In the container, run `operator-cli start` to start the validator node.
- Run `operator-cli -h` for list of commands.

### Stake LIB

Once your validator node is running, you can proceed with staking LIB.

1. In the web dashboard, once logged in, you will see your **node address** and a **QR code** for your node address.
2. Open the [Liberdus wallet](https://liberdus.com/download/).
   - If this is your first time using the Liberdus Wallet, create an account by providing a username.
   - Ensure your wallet balance is at least **1250 LIB** before staking.
3. Go to the **Validator** tab in the menu.
4. Click the **Stake** button and enter your node address.
   - If you’re using the mobile app, you can scan the QR code instead.
5. Complete the staking process.

After staking, the Web Dashboard will show your staked amount (**1250 LIB or more**) and your node status will update to `Standby` shortly afterward. This indicates that your validator node is set up correctly. The network will then automatically add your validator to the active set based on network load and available validator slots.

## Stack management

### Start the stack

```bash
./docker-up.sh
```

This will be more effective when the info gathered in the install script is stored in persisent volume that is mounted by the container.

### Stop the stack

```bash
./docker-down.sh
```

### Clean up

```bash
./clean.sh
```

This will clean up the last (lastest) build. Just meant to save a few key strokes.

Instructions for the user wanting to run a Liberdus validator node can be found here: <https://docs.liberdus.org/docs/node/run/validator>

## Versioning

To set up the dashboard installer script for different versions of the Liberdus network follow the steps below:

- Point the installer to the correct CLI and GUI versions in [the entrypoint.sh](https://github.com/liberdus/validator-dashboard/blob/d366e0fbf53ca7e8efb7f7d4aa1db4de7574657e/entrypoint.sh#L25) file.
- Set the right docker image version in the [Dockerfile](https://github.com/liberdus/validator-dashboard/blob/d366e0fbf53ca7e8efb7f7d4aa1db4de7574657e/Dockerfile#L1). You can find all tagged image versions [here](https://github.com/liberdus/liberdus/pkgs/container/server/versions?filters%5Bversion_type%5D=tagged).
- The installer script creates a `.env` file that [defines the network details](https://github.com/liberdus/validator-dashboard/blob/d366e0fbf53ca7e8efb7f7d4aa1db4de7574657e/installer.sh#L540-L589), modify the script to specify the details of the new network.
  The script should now correctly set up the Dashboard for your new network.

## Contributing

Contributions are very welcome! Everyone interacting in our codebases, issue trackers, and any other form of communication, including chat rooms and mailing lists, is expected to follow our [code of conduct](./CODE_OF_CONDUCT.md) so we can all enjoy the effort we put into this project.
