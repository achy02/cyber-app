# Cybersecurity Awareness App

A simple Flask application that displays cybersecurity threat levels and educational concepts.

## Project Structure
- `app.py`: Main Flask application.
- `Dockerfile`: Instructions to build the Docker image.
- `docker-compose.yml`: Configuration for running the app as a service.
- `requirements.txt`: Python dependencies.
- `templates/`: HTML templates for the application.
- `static/`: Static assets (CSS, images).

## Prerequisites

- [Python 3.9+](https://www.python.org/downloads/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)

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
