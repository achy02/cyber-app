# Cybersecurity Awareness App

A simple Flask application that displays cybersecurity threat levels and educational concepts.

**GitHub Repository:** [https://github.com/achy02/cyber-app](https://github.com/achy02/cyber-app)

## Project Structure
- `app.py`: Main Flask application.
- `Dockerfile`: Instructions to build the Docker image.
- `docker-compose.yml`: Configuration for running the app as a service.
- `requirements.txt`: Python dependencies.
- `templates/`: HTML templates for the application.
- `static/`: Static assets (CSS, images).
- `push_to_github.sh`: Script to automate GitHub push.

## Prerequisites

- [Python 3.9+](https://www.python.org/downloads/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Git](https://git-scm.com/downloads)

---

## 1. Run Locally (Python)

Follow these steps to run the application directly on your machine.

### Step 1: Install Dependencies
Open your terminal in the project directory and run:

```bash
pip install -r requirements.txt
```

### Step 2: Run the Application
Execute the following command:

```bash
python app.py
```

### Step 3: Access the App
Open your browser and navigate to:
[http://localhost:5000](http://localhost:5000)

---

## 2. Run with Docker (Recommended)

You can run the application in a container without installing Python dependencies locally.

### Option A: Using Docker Compose (Easiest)

1.  **Build and Run**:
    ```bash
    docker-compose up --build
    ```
    *Use `docker-compose up -d --build` to run in the background (detached mode).*

2.  **Access the App**:
    The app is mapped to port **8080** in the `docker-compose.yml`.
    Open: [http://localhost:8080](http://localhost:8080)

3.  **Stop the App**:
    Press `Ctrl+C` if running in the foreground, or run:
    ```bash
    docker-compose down
    ```

### Option B: Using Docker Commands Manually

1.  **Build the Image**:
    ```bash
    docker build -t cybersecurity-app .
    ```

2.  **Run the Container**:
    Map port 8080 on your host to port 5000 in the container:
    ```bash
    docker run -p 8080:5000 cybersecurity-app
    ```

3.  **Access the App**:
    Open: [http://localhost:8080](http://localhost:8080)

---

## 3. Infrastructure & Automation

### Architecture
- **Cloud Provider**: AWS (simulated via Terraform)
- **Infrastructure**:
    - **EC2 Instance**: `t2.micro` (Ubuntu 22.04) running the Dockerized app.
    - **Security Group**: Firewall rules managing ingress for HTTP (80) and SSH (22).
- **CI/CD**: Jenkins pipeline (local Docker container) managing:
    1.  Source Checkout
    2.  Infrastructure Security Scan (Trivy)
    3.  Terraform Plan

---

## 4. AI-Driven Remediation Log (Mandatory)

**1. Vulnerability Identified**
- **Tool**: Trivy (Infrastructure Scan)
- **Issue**: `AVD-AWS-0107` - Security Group allows unrestricted SSH access (`0.0.0.0/0`).
- **Severity**: Critical.
- **Risk**: Open SSH ports allow brute-force attacks from anywhere in the world, potentially leading to server compromise.

**2. AI Prompt Used**
> "Analyze the security report, explain the risks, and rewrite the code to fix the vulnerabilities."

**3. AI-Recommended Fix**
The AI agent analyzed `terraform/main.tf` and modified the ingress rule for port 22.
- **Before**: `cidr_blocks = ["0.0.0.0/0"]` (Open to World)
- **After**: `cidr_blocks = ["192.168.1.100/32"]` (Restricted to Admin IP)

**4. Result**
The security posture is improved by adopting the **Principle of Least Privilege**. Only authorized IPs can now attempt SSH connections, mitigating mass scanner and brute-force risks.
