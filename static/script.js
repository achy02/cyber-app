document.addEventListener('DOMContentLoaded', () => {
    // Start updates
    setInterval(fetchStats, 2000);
    fetchStats();

    // IP Info
    fetchIpInfo();
});

async function fetchStats() {
    try {
        const response = await fetch('/api/stats');
        const data = await response.json();

        updateMetric('cpu-val', data.cpu, '%');
        updateMetric('ram-val', data.ram, '%');
        updateMetric('net-val', data.network_in_kb, ' KB/s');

        // Visual updates
        document.getElementById('cpu-bar').style.width = `${data.cpu}%`;
        document.getElementById('ram-bar').style.width = `${data.ram}%`;

    } catch (e) {
        console.error("Stats fetch failed", e);
    }
}

function updateMetric(id, value, unit) {
    const el = document.getElementById(id);
    if (el) el.innerText = `${value}${unit}`;
}

async function fetchIpInfo() {
    try {
        const response = await fetch('/api/ip');
        const data = await response.json();
        document.getElementById('user-ip').innerText = data.ip;
        document.getElementById('user-agent').innerText = data.user_agent;
    } catch (e) {
        document.getElementById('user-ip').innerText = "Unavailable";
    }
}

function runScan() {
    const btn = document.getElementById('scan-btn');
    const progressBar = document.getElementById('scan-progress');
    const progressFill = document.querySelector('.progress-fill');
    const resultArea = document.getElementById('scan-result');

    btn.disabled = true;
    btn.innerText = "Scanning...";
    progressBar.style.display = 'block';
    resultArea.style.display = 'none';

    let width = 0;
    const interval = setInterval(() => {
        if (width >= 100) {
            clearInterval(interval);
            finishScan();
        } else {
            width += 5;
            progressFill.style.width = width + '%';
        }
    }, 100);

    function finishScan() {
        btn.disabled = false;
        btn.innerText = "Run Diagnostics";
        progressBar.style.display = 'none';
        resultArea.style.display = 'block';

        const threats = ["No active threats found.", "System clean.", "Firewall active."];
        resultArea.innerHTML = `<div class="scan-success">✅ ${threats[Math.floor(Math.random() * threats.length)]}</div>`;
    }
}
