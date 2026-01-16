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
                    // In a real Jenkins env, we might use a plugin or docker run
                    // Here we simulate running trivy using docker agent or command
                    // This command matches the requirement to fail on failure or show warnings
                    
                    // Note: Since we are running Jenkins in Docker, we need to ensure it can run docker commands 
                    // or we assume trivy is installed. For this assignment simulation:
                    
                    sh "docker run --rm -v \$(pwd):/app -w /app ${TRIVY_IMAGE} config ./terraform"
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
                sh 'terraform init && terraform plan'
                echo "Terraform Plan generated."
            }
        }
    }
}
