pipeline {
    agent any

    environment {
        // Ensure Trivy is available or use docker to run it
        TRIVY_IMAGE = 'aquasec/trivy:latest'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Infrastructure Security Scan') {
            steps {
                script {
                    echo "Running Trivy Security Scan on Terraform..."
                    // FIX: Run Trivy directly (installed in image) instead of using Docker-in-Docker
                    // This avoids volume mounting issues.
                    sh "trivy config ."
                }
            }
            post {
                always {
                    echo "Security Scan Complete"
                }
                failure {
                    echo "Security Vulnerabilities Found! Please review the report."
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                echo "Running Terraform Plan (AWS Credentials Required)..."
                // Requires AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY to be set in Jenkins/Docker environment
                sh 'cd terraform && terraform init && terraform plan'
                echo "Terraform Plan generated."
            }
        }
    }
}
