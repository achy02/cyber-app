from flask import Flask, render_template
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

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
