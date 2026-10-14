// ---- State ----
let token = null;
let currentUser = null;
let editingControlId = null;
let controlsCache = [];  // store compliance data for click lookups

const API = '';  // same origin

// ---- Login ----
document.getElementById('loginForm').addEventListener('submit', async function(e) {
  e.preventDefault();
  var email = document.getElementById('loginEmail').value;
  var password = document.getElementById('loginPassword').value;
  var errorEl = document.getElementById('loginError');
  var btn = document.getElementById('loginBtn');

  btn.disabled = true;
  btn.textContent = 'Signing in...';
  errorEl.style.display = 'none';

  try {
    var res = await fetch(API + '/api/auth/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email: email, password: password })
    });
    var data = await res.json();

    if (!res.ok) {
      throw new Error(data.error || 'Login failed');
    }

    token = data.token;
    currentUser = data.user;
    document.getElementById('loginScreen').style.display = 'none';
    document.getElementById('appScreen').style.display = 'block';
    document.getElementById('userEmail').textContent = currentUser.email;
    loadDashboard();
  } catch (err) {
    errorEl.textContent = err.message;
    errorEl.style.display = 'block';
  } finally {
    btn.disabled = false;
    btn.textContent = 'Sign In';
  }
});

// ---- Logout ----
document.getElementById('logoutBtn').addEventListener('click', function() {
  token = null;
  currentUser = null;
  document.getElementById('appScreen').style.display = 'none';
  document.getElementById('loginScreen').style.display = 'flex';
});

// ---- API helpers ----
function authHeaders() {
  return {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ' + token
  };
}

// ---- Load Dashboard ----
async function loadDashboard() {
  try {
    var scoreRes = await fetch(API + '/api/compliance/score', { headers: authHeaders() });
    var complianceRes = await fetch(API + '/api/compliance', { headers: authHeaders() });

    var scoreData = await scoreRes.json();
    var complianceData = await complianceRes.json();

    renderScore(scoreData);
    renderFamilies(scoreData.byFamily || {});
    renderControls(complianceData);
  } catch (err) {
    console.error('Failed to load dashboard:', err);
  }
}

// ---- Render Score Cards ----
function renderScore(data) {
  var overall = data.overall || {};
  var pct = overall.compliancePercent || 0;

  var pctEl = document.getElementById('compliancePercent');
  pctEl.textContent = pct + '%';
  pctEl.className = 'value ' + (pct >= 75 ? 'score-good' : pct >= 50 ? 'score-warn' : 'score-bad');

  document.getElementById('complianceDetail').textContent =
    (overall.yes || 0) + ' of ' + (overall.applicable || 0) + ' applicable controls compliant';

  var maturity = overall.averageMaturity;
  var matEl = document.getElementById('maturityValue');
  matEl.textContent = maturity !== null && maturity !== undefined ? maturity + ' / 5' : 'N/A';
  matEl.className = 'value ' + (maturity >= 4 ? 'score-good' : maturity >= 2.5 ? 'score-warn' : 'score-bad');

  document.getElementById('controlsAssessed').textContent = overall.total || 0;
  document.getElementById('controlsDetail').textContent =
    (overall.notApplicable || 0) + ' not applicable';
}

// ---- Render Family Breakdown ----
function renderFamilies(byFamily) {
  var grid = document.getElementById('familyGrid');
  var families = Object.keys(byFamily).sort();

  if (families.length === 0) {
    grid.innerHTML = '<p style="color:#888;font-size:14px;">No compliance data yet.</p>';
    return;
  }

  var familyNames = {
    AC: 'Access Control', AT: 'Awareness & Training',
    AU: 'Audit & Accountability', CA: 'Assessment & Authorization',
    CM: 'Configuration Mgmt', CP: 'Contingency Planning',
    IA: 'Identification & Auth', IR: 'Incident Response',
    MA: 'Maintenance', MP: 'Media Protection',
    PE: 'Physical & Environmental', PL: 'Planning',
    PM: 'Program Management', PS: 'Personnel Security',
    PT: 'PII Processing', RA: 'Risk Assessment',
    SA: 'System Acquisition', SC: 'System & Comms Protection',
    SI: 'System & Info Integrity', SR: 'Supply Chain Risk'
  };

  grid.innerHTML = families.map(function(fam) {
    var s = byFamily[fam];
    var pct = s.compliancePercent || 0;
    var color = pct >= 75 ? '#059669' : pct >= 50 ? '#d97706' : '#dc2626';
    var name = familyNames[fam] || fam;
    return '<div class="family-card">' +
      '<div class="family-name">' + fam + ' — ' + name + '</div>' +
      '<div class="family-percent" style="color:' + color + '">' + pct + '%</div>' +
      '<div class="family-bar">' +
        '<div class="family-bar-fill" style="width:' + pct + '%;background:' + color + '"></div>' +
      '</div>' +
    '</div>';
  }).join('');
}

// ---- Render Controls Table ----
function renderControls(records) {
  var tbody = document.getElementById('controlsBody');
  controlsCache = records || [];

  if (!records || records.length === 0) {
    tbody.innerHTML = '<tr><td colspan="5" class="loading">No compliance records found.</td></tr>';
    return;
  }

  tbody.innerHTML = records.map(function(r) {
    var badgeClass = r.answer ? 'badge-' + r.answer.toLowerCase().replace(/\s+/g, '-') : 'badge-unanswered';
    var stars = r.rating ? '★'.repeat(r.rating) + '☆'.repeat(5 - r.rating) : '—';
    return '<tr data-control-id="' + r.control_id + '">' +
      '<td><strong>' + r.control_id + '</strong></td>' +
      '<td>' + r.control_name + '</td>' +
      '<td>' + r.control_family + '</td>' +
      '<td><span class="badge ' + badgeClass + '">' + (r.answer || 'Not assessed') + '</span></td>' +
      '<td><span class="rating">' + stars + '</span></td>' +
    '</tr>';
  }).join('');
}

// ---- Table row click handler (event delegation) ----
document.getElementById('controlsBody').addEventListener('click', function(e) {
  var row = e.target.closest('tr[data-control-id]');
  if (!row) return;

  var controlId = row.getAttribute('data-control-id');
  var record = controlsCache.find(function(r) { return r.control_id === controlId; });
  if (!record) return;

  editingControlId = controlId;
  document.getElementById('modalTitle').textContent = controlId;
  document.getElementById('modalSubtitle').textContent = record.control_name;
  document.getElementById('editAnswer').value = record.answer || 'Yes';
  document.getElementById('editRating').value = record.rating || '';
  document.getElementById('editEvidence').value = record.evidence || '';
  document.getElementById('editModal').classList.add('active');
});

// ---- Close Modal ----
function closeModal() {
  document.getElementById('editModal').classList.remove('active');
  editingControlId = null;
}

document.getElementById('cancelBtn').addEventListener('click', closeModal);

// Close modal on backdrop click
document.getElementById('editModal').addEventListener('click', function(e) {
  if (e.target === document.getElementById('editModal')) closeModal();
});

// ---- Save changes ----
document.getElementById('editForm').addEventListener('submit', async function(e) {
  e.preventDefault();
  if (!editingControlId) return;

  var payload = {
    answer: document.getElementById('editAnswer').value,
    rating: document.getElementById('editRating').value ? parseInt(document.getElementById('editRating').value) : null,
    evidence: document.getElementById('editEvidence').value || null
  };

  try {
    var res = await fetch(API + '/api/compliance/' + editingControlId, {
      method: 'PUT',
      headers: authHeaders(),
      body: JSON.stringify(payload)
    });

    if (!res.ok) {
      var errData = await res.json();
      alert('Failed to save: ' + (errData.error || JSON.stringify(errData.errors)));
      return;
    }

    closeModal();
    loadDashboard();  // Refresh everything
  } catch (err) {
    alert('Network error: ' + err.message);
  }
});
