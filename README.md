# How to Install and Run a Liberdus Validator Node

This guide will walk you through the process of installing and running a Liberdus Validator Node on your system. Please follow the steps below carefully.

## Hardware Requirements

The minimum requirements are:
A VPS server with 2 CPU cores, 2 GB of RAM, 256 GB of SSD, 1 Gbps network, 1 TB/month bandwidth, DDOS protection, power backup and redundant Internet connections.
A Linux Ubuntu OS is highly recommended for easy setup.

A server like this should cost less than $30 per month from a web hosting company.

Although you can run a server from home, it is not recommended since electric power and redundant Internet connections would be lacking and would risk your node getting penalized if it goes down.

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

Follow the instructions provided by the installer script. You can just hit the enter button to accept the default values which should work for most cases.

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
- Run `operator-cli status` to check that it is running.
- Run `operator-cli -h` for list of commands.

### Stake LIB

Once your validator node is running, you can proceed with staking LIB to your node.

1. In the web dashboard, once logged in, you will see your **node address** and a **QR code** for your node address.
2. Open the [Liberdus wallet](https://liberdus.com/download/).
   - If this is your first time using the Liberdus Wallet, create an account by providing a username.
3. Select the **Validator** option in the menu.
5. Click the **Stake** button and enter your node address.
   - If you’re using the mobile app, you can scan the QR code instead.
4. If you don't have at least **1250 LIB**. you can get some by clicking the Claim button there.
6. Wait about 15 seconds to get the LIB. Click the **Subit Stake** button to complete the staking process.

After staking, the Web Dashboard will show your staked amount (**1250 LIB or more**) and your node status will update to `Standby` shortly afterward. This indicates that your validator node is set up correctly. The network will then automatically add your validator to the active set based on network load and available validator slots.

## Software version updates

Occacionally you will see a message in the validator dashboard that you need to update the node software version. To be notified of updates you can also check the node operators announcement channel in the Liberdus Discord or subscribe to the node operators mailing list here https://groups.google.com/g/liberdus-node-operators

### Gracefully stop the node

1. In the validator dashboard, click the **Settings** icon.
2. Uncheck the option for **Auto Restart Node** so that it does not join the network again after it is rotated out.

Never forse stop your node if it is participating in the network as this will trigger a penalty on the stake amount.

### Update the software

Just run the installer script again to update the validator node software.
Do the following as the user that was created earlier and not as root.

```bash
curl -O https://raw.githubusercontent.com/liberdus/validator-dashboard/main/installer.sh && chmod +x installer.sh && ./installer.sh
```

Follow the instructions provided by the installer script. You can just hit the enter button to accept the default values which should work for most cases.

## Docker management

In most cases you don't need to manage the docker images manually, but the following scripts are provided to make it easier if you do. These should be run as the user that was created during the setup and not as root.

### Start the docker images

```bash
cd .liberdus
./docker-up.sh
```

This will be more effective when the info gathered in the install script is stored in persisent volume that is mounted by the container.

### Stop the docker images

```bash
cd .liberdus
./docker-down.sh
```

### Clean up

```bash
cd .liberdus
./clean.sh
```

This will clean up the last (lastest) build. Just meant to save a few key strokes.

## Contributing

Contributions are very welcome! Everyone interacting in our codebases, issue trackers, and any other form of communication, including chat rooms and mailing lists, is expected to follow our [code of conduct](./CODE_OF_CONDUCT.md) so we can all enjoy the effort we put into this project.
