# 🐳 Docker, kubectl & Minikube Installation Guide

A step-by-step setup guide for installing Docker, kubectl, and Minikube on Ubuntu/Linux. This guide walks you through setting up a complete local Kubernetes development environment from scratch — starting with Docker as the container runtime, kubectl as the command-line tool to interact with Kubernetes, and Minikube to run a lightweight Kubernetes cluster on your local machine.

---

## Prerequisites

- Ubuntu/Debian-based Linux system
- `sudo` privileges
- Internet connection

---

## What Are We Installing?

| Tool | Purpose |
|------|---------|
| **Docker** | A container runtime that packages and runs applications in isolated environments called containers |
| **kubectl** | The official Kubernetes CLI tool used to deploy apps, inspect resources, and manage your cluster |
| **Minikube** | A tool that runs a single-node Kubernetes cluster locally inside a Docker container or VM — perfect for development and testing |

---

## Step 1: Install Docker

Docker is the foundation of this setup. It acts as the container engine that Minikube will use to spin up the Kubernetes cluster. Before installing Docker, we first update the system's package list to make sure we get the latest available version.

### 1.1 Update Package Index

Refreshes the list of available packages and their versions from the configured repositories. This ensures `apt` installs the most recent and compatible packages.

```bash
sudo apt update
```

<img width="1026" height="575" alt="Screenshot 2026-04-05 at 2 15 00 AM" src="https://github.com/user-attachments/assets/93822dac-4290-4ea6-a59e-a7698013365d" />


---

### 1.2 Install Docker

Installs the `docker.io` package — Ubuntu's official Docker package. The `-y` flag automatically confirms the installation without prompting.

```bash
sudo apt install -y docker.io
```

<img width="1200" height="709" alt="Screenshot 2026-04-05 at 2 15 35 AM" src="https://github.com/user-attachments/assets/007dc3c3-7f5a-4a94-abeb-bf9ed6df2462" />


---

### 1.3 Start and Enable Docker Service

Once installed, Docker needs to be started as a background service. We also **enable** it so it automatically starts on every system reboot — you won't have to manually start Docker each time you restart your machine.

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

<img width="541" height="42" alt="Screenshot 2026-04-05 at 2 16 23 AM" src="https://github.com/user-attachments/assets/ffcd3425-046d-467f-9098-821f7ad93fbb" />


---

### 1.4 Allow Non-Root User to Run Docker

By default, Docker commands require `sudo`. This step adds your current user (`$USER`) to the `docker` group, so you can run Docker commands without `sudo`. The `newgrp docker` command activates the new group membership immediately in the current terminal session.

```bash
sudo usermod -aG docker $USER
newgrp docker
```

> ⚠️ **Note:** If `newgrp docker` doesn't fully apply the change (e.g., in some environments), log out and log back in to ensure the group permissions take effect.

---

### 1.5 Verify Docker Installation

Confirms Docker was installed correctly by printing its version. If this command returns a version number, Docker is ready to use.

```bash
docker --version
```

**Expected output:**
```
Docker version 24.x.x, build xxxxxxx
```

<img width="581" height="115" alt="Screenshot 2026-04-05 at 2 17 24 AM" src="https://github.com/user-attachments/assets/65870398-d383-4312-b4fa-ce899b04600f" />


---

## Step 2: Install kubectl

`kubectl` is the Kubernetes command-line interface (CLI). It lets you communicate with your Kubernetes cluster — deploying applications, scaling workloads, checking logs, and much more. We download it directly from the official Kubernetes release server to ensure we get the latest stable version.

### 2.1 Download kubectl Binary

This command uses `curl` to download the `kubectl` binary. The inner `curl` dynamically fetches the latest stable version number from Kubernetes, which is then used to construct the correct download URL. This way, you always get the most up-to-date stable release automatically.

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```

<img width="1285" height="95" alt="Screenshot 2026-04-05 at 2 18 10 AM" src="https://github.com/user-attachments/assets/b7ca4032-e100-4713-bee8-5ad9676efcbb" />


---

### 2.2 Make kubectl Executable and Move to PATH

Downloaded files are not executable by default. `chmod +x` grants execute permission to the binary. Then we move it to `/usr/local/bin/` — a standard directory for user-installed programs — so the `kubectl` command is available system-wide from any terminal.

```bash
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
```

---

### 2.3 Verify kubectl Installation

Prints the installed client version of `kubectl`. The `--client` flag skips trying to connect to a cluster (which doesn't exist yet) and just shows the local binary version.

```bash
kubectl version --client
```

**Expected output:**
```
Client Version: v1.xx.x
Kustomize Version: v5.x.x
```

<img width="583" height="99" alt="Screenshot 2026-04-05 at 2 18 49 AM" src="https://github.com/user-attachments/assets/0068bb8c-37ed-4886-80e9-8aedf2f33d82" />


---

## Step 3: Install Minikube

Minikube creates a local Kubernetes cluster inside a single Docker container (or VM). It's ideal for developers who want to test Kubernetes features, experiment with deployments, or learn Kubernetes without needing a full cloud-based cluster.

### 3.1 Download Minikube Binary

Downloads the latest Minikube binary for Linux (amd64 architecture) directly from Google's official Minikube release storage.

```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
```

<img width="1061" height="77" alt="Screenshot 2026-04-05 at 2 19 47 AM" src="https://github.com/user-attachments/assets/72c4637a-88d2-4046-8747-868209e8fe6a" />


---

### 3.2 Install Minikube

The `install` command copies the binary to `/usr/local/bin/minikube` and automatically sets the correct permissions, making it executable and available system-wide. This is cleaner than manually using `chmod` + `mv`.

```bash
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

---

### 3.3 Verify Minikube Installation

Confirms Minikube is installed and prints the version. A successful response means Minikube is correctly placed in your PATH and ready to use.

```bash
minikube version
```

**Expected output:**
```
minikube version: v1.xx.x
commit: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

---

## Step 4: Start Minikube Cluster

Now that Docker, kubectl, and Minikube are all installed, we can launch our local Kubernetes cluster. The `--driver=docker` flag tells Minikube to use Docker containers as the virtualization layer instead of a traditional VM. This is faster to start and works well on most modern systems without requiring additional hypervisor configuration.

### 4.1 Start Minikube with Docker Driver

```bash
minikube start --driver=docker
```

> ⏳ **Note:** The first run may take a few minutes as Minikube pulls the Kubernetes node image (~500MB). Subsequent starts are much faster.

**What happens behind the scenes:**
- Minikube pulls a base Docker image containing a full Kubernetes node
- It creates and starts a Docker container for the cluster
- It installs and configures all core Kubernetes components (API server, scheduler, etcd, etc.)
- It automatically updates your `~/.kube/config` file so `kubectl` knows how to connect to this cluster

**Expected output:**
```
😄  minikube v1.xx.x on Ubuntu xx.xx
✨  Using the docker driver based on user choice
📌  Using Docker driver with root privileges
👍  Starting control plane node minikube in cluster minikube
🚜  Pulling base image ...
🔥  Creating docker container (CPUs=2, Memory=2200MB) ...
🐳  Preparing Kubernetes v1.xx.x on Docker xx.x.x ...
🔗  Configuring bridge CNI (Container Networking Interface) ...
🔎  Verifying Kubernetes components...
🌟  Enabled addons: storage-provisioner, default-storageclass
🏄  Done! kubectl is now configured to use "minikube" cluster
```

<img width="1316" height="444" alt="Screenshot 2026-04-05 at 2 21 42 AM" src="https://github.com/user-attachments/assets/d68cd5d6-f307-48b8-9834-923fc1d27334" />


---

## ✅ Verification Summary

Run all checks to confirm everything is installed and running correctly:

```bash
docker --version
kubectl version --client
minikube version
minikube status
```

A healthy `minikube status` output looks like this:
```
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```

<img width="455" height="150" alt="Screenshot 2026-04-05 at 2 22 22 AM" src="https://github.com/user-attachments/assets/dec8a7a5-65f9-4246-89cc-f614f50748b5" />


---

## 🛠️ Useful Commands After Setup

| Command | Description |
|--------|-------------|
| `minikube status` | Check if the cluster is running |
| `minikube stop` | Pause the cluster without deleting it |
| `minikube delete` | Completely remove the cluster |
| `kubectl get nodes` | List all nodes in the cluster |
| `kubectl get pods -A` | List all running pods across all namespaces |
| `minikube dashboard` | Open the Kubernetes web dashboard in your browser |

---

## ⚠️ Troubleshooting

**Docker permission denied:**
You tried to run a Docker command without `sudo`. Run `newgrp docker` or log out and back in after adding your user to the docker group.

**Minikube fails to start:**
Make sure Docker is running (`sudo systemctl start docker`). If it still fails, try:
```bash
minikube start --driver=docker --force
```

**kubectl can't connect to cluster:**
The kubeconfig may not be set up correctly. Use Minikube's built-in kubectl wrapper to verify connectivity:
```bash
minikube kubectl -- get pods -A
```
Or check your config file at `~/.kube/config`.

---

## 👨‍💻 Author

**Pravesh Kumar**
📬 [LinkedIn](https://www.linkedin.com/in/pravesh22) · [GitHub](https://github.com/pravesh2201)

*Guide last updated: April 2026*
