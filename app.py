from flask import Flask, render_template, jsonify, request
from datetime import datetime

import random

app = Flask(__name__)

def get_threat_level():
    levels = [
        ("LOW", "threat-low", "System Stable"),
        ("MEDIUM", "threat-medium", "Elevated Traffic Detected"),
        ("HIGH", "threat-high", "Intrusion Attempt Blocked"),
        ("CRITICAL", "threat-critical", "Breach Detected! Lockdown Initiated")
    ]
    return random.choice(levels)

@app.route('/')
def index():
    threat_level, thread_class, threat_msg = get_threat_level()
    return render_template('index.html', threat_level=threat_level, threat_class=thread_class, threat_msg=threat_msg)

@app.route('/details')
def details():
    concepts = [
        {"title": "CIA Triad", "desc": "Confidentiality, Integrity, and Availability. The three pillars of information security."},
        {"title": "Phishing", "desc": "Social engineering using deceptive emails. Always verify sender identity."},
        {"title": "MFA", "desc": "Multi-Factor Authentication. Adds a critical second layer of defense (Something you know + Something you have)."},
        {"title": "Zero Trust", "desc": "Never trust, always verify. Strict identity verification for every person and device accessing resources."},
        {"title": "DDoS", "desc": "Distributed Denial of Service. Overwhelming a system with traffic to make it unavailable."},
        {"title": "SQL Injection", "desc": "Malicious SQL statements are inserted into an entry field for execution."}
    ]
    return render_template('details.html', concepts=concepts, time=datetime.now().strftime("%Y-%m-%d %H:%M:%S UTC"))

# --- API Endpoints for Dynamic Features ---

@app.route('/api/threat-level')
def api_threat_level():
    threat_level, threat_class, threat_msg = get_threat_level()
    return jsonify({
        "level": threat_level,
        "class": threat_class,
        "msg": threat_msg,
        "timestamp": datetime.now().strftime("%H:%M:%S")
    })

@app.route('/api/activity-log')
def api_activity_log():
    # Simulate fetching logs from a database or SIEM
    actions = ["Login Attempt", "File Access", "Port Scan", "Firewall Block", "User Logout", "Admin Access"]
    users = ["admin", "system", "unknown", "user_101", "guest"]
    statuses = ["Success", "Failed", "Blocked", "Warning"]
    
    logs = []
    for _ in range(5):
        logs.append({
            "action": random.choice(actions),
            "user": random.choice(users),
            "status": random.choice(statuses),
            "time": datetime.now().strftime("%H:%M:%S")
        })
    return jsonify(logs)

@app.route('/api/report', methods=['POST'])
def api_report_incident():
    data = request.json
    print(f"[{datetime.now()}] INCIDENT REPORTED: {data}")
    return jsonify({"status": "received", "message": "Incident report logged successfully."})

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
