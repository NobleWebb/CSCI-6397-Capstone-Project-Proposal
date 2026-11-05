// ---- State ----
let token = null;
let currentUser = null;
let editingControlId = null;
let controlsCache = [];  // store compliance data for click lookups
let expandedFamily = null; // which family is currently expanded
let recsCache = []; // store recommendations for filtering
let activeTab = 'dashboard';

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
  expandedFamily = null;
  activeTab = 'dashboard';
  document.getElementById('appScreen').style.display = 'none';
  document.getElementById('loginScreen').style.display = 'flex';
  // Reset tab state
  document.querySelectorAll('.nav-tab').forEach(function(t) { t.classList.remove('active'); });
  document.querySelector('.nav-tab[data-tab="dashboard"]').classList.add('active');
  document.getElementById('tab-dashboard').style.display = '';
  document.getElementById('tab-recommendations').style.display = 'none';
});

// ---- Tab Navigation ----
document.querySelectorAll('.nav-tab').forEach(function(tab) {
  tab.addEventListener('click', function() {
    var target = this.getAttribute('data-tab');
    if (target === activeTab) return;

    activeTab = target;

    // Update tab buttons
    document.querySelectorAll('.nav-tab').forEach(function(t) { t.classList.remove('active'); });
    this.classList.add('active');

    // Show/hide tab content
    document.querySelectorAll('.tab-content').forEach(function(el) { el.style.display = 'none'; });
    document.getElementById('tab-' + target).style.display = '';

    // Load data for the tab
    if (target === 'recommendations') {
      loadRecommendations();
    }
  });
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

    controlsCache = complianceData || [];

    renderScore(scoreData);
    renderFamilies(scoreData.byFamily || {});

    // If a family was expanded, refresh its controls panel
    if (expandedFamily) {
      showFamilyControls(expandedFamily);
    }
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
    var barColor = pct >= 75 ? '#34d399' : pct >= 50 ? '#ffb72f' : '#f87171';
    var name = familyNames[fam] || fam;
    var isRainbow = pct >= 85;
    var barClass = 'family-bar-fill' + (isRainbow ? ' rainbow-bar' : '');
    var barWrapClass = 'family-bar' + (isRainbow ? ' rainbow-glow' : '');
    var barStyle = 'width:' + pct + '%;';
    if (isRainbow) {
      barStyle += 'background:linear-gradient(90deg,#ff0000,#ff8800,#ffff00,#00ff00,#00ccff,#8800ff,#ff0000);background-size:200% 100%;';
    } else {
      barStyle += 'background:' + barColor + ';';
    }
    var activeClass = (expandedFamily === fam) ? ' active' : '';
    return '<div class="family-card' + activeClass + '" data-family="' + fam + '">' +
      '<div class="family-name">' + fam + ' — ' + name + '</div>' +
      '<div class="family-percent">' + pct + '%</div>' +
      '<div class="' + barWrapClass + '">' +
        '<div class="' + barClass + '" style="' + barStyle + '"></div>' +
      '</div>' +
      '<div class="family-tap-hint">Click to view controls</div>' +
    '</div>';
  }).join('');
}

// ---- Family Card Click Handler ----
document.getElementById('familyGrid').addEventListener('click', function(e) {
  var card = e.target.closest('.family-card[data-family]');
  if (!card) return;

  var family = card.getAttribute('data-family');

  if (expandedFamily === family) {
    closeFamilyControls();
  } else {
    showFamilyControls(family);
  }
});

// ---- Show Controls for a Family ----
function showFamilyControls(familyCode) {
  expandedFamily = familyCode;

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

  var name = familyNames[familyCode] || familyCode;
  document.getElementById('familyControlsTitle').textContent = familyCode + ' — ' + name;

  var familyControls = controlsCache.filter(function(r) {
    return r.control_family === familyCode;
  });

  var tbody = document.getElementById('familyControlsBody');
  if (familyControls.length === 0) {
    tbody.innerHTML = '<tr><td colspan="4" class="loading">No controls found for this family.</td></tr>';
  } else {
    tbody.innerHTML = familyControls.map(function(r) {
      var badgeClass = r.answer ? 'badge-' + r.answer.toLowerCase().replace(/\s+/g, '-') : 'badge-unanswered';
      var stars = r.rating ? '★'.repeat(r.rating) + '☆'.repeat(5 - r.rating) : '—';
      return '<tr data-control-id="' + r.control_id + '">' +
        '<td><strong>' + r.control_id + '</strong></td>' +
        '<td>' + r.control_name + '</td>' +
        '<td><span class="badge ' + badgeClass + '">' + (r.answer || 'Not assessed') + '</span></td>' +
        '<td><span class="rating">' + stars + '</span></td>' +
      '</tr>';
    }).join('');
  }

  document.getElementById('familyControls').style.display = 'block';

  var allCards = document.querySelectorAll('.family-card');
  allCards.forEach(function(c) { c.classList.remove('active'); });
  var activeCard = document.querySelector('.family-card[data-family="' + familyCode + '"]');
  if (activeCard) activeCard.classList.add('active');

  document.getElementById('familyControls').scrollIntoView({ behavior: 'smooth', block: 'nearest' });
}

// ---- Close Family Controls Panel ----
function closeFamilyControls() {
  expandedFamily = null;
  document.getElementById('familyControls').style.display = 'none';
  var allCards = document.querySelectorAll('.family-card');
  allCards.forEach(function(c) { c.classList.remove('active'); });
}

document.getElementById('closeFamilyControls').addEventListener('click', closeFamilyControls);

// ---- Control row click inside family panel → open edit modal ----
document.getElementById('familyControlsBody').addEventListener('click', function(e) {
  var row = e.target.closest('tr[data-control-id]');
  if (!row) return;

  var controlId = row.getAttribute('data-control-id');
  var record = controlsCache.find(function(r) { return r.control_id === controlId; });
  if (!record) return;

  openEditModal(controlId, record);
});

// ---- Open Edit Modal (shared by dashboard + recommendations) ----
function openEditModal(controlId, record) {
  editingControlId = controlId;
  document.getElementById('modalTitle').textContent = controlId;
  document.getElementById('modalSubtitle').textContent = record.control_name;
  document.getElementById('descriptionText').textContent = record.nist_standard || record.control_name;
  document.getElementById('phaseBadge').textContent = record.phase || '';
  document.getElementById('editAnswer').value = record.answer || record.current_answer || 'Yes';
  document.getElementById('editRating').value = record.rating || record.current_rating || '';
  document.getElementById('editEvidence').value = record.evidence || '';
  document.getElementById('editModal').classList.add('active');
}

// ---- Toggle NIST description expand/collapse ----
document.getElementById('controlDescription').addEventListener('click', function() {
  var desc = document.getElementById('controlDescription');
  var toggle = document.getElementById('descToggle');
  desc.classList.toggle('expanded');
  toggle.textContent = desc.classList.contains('expanded') ? 'TAP TO COLLAPSE' : 'TAP TO EXPAND';
});

// ---- Close Modal ----
function closeModal() {
  document.getElementById('editModal').classList.remove('active');
  document.getElementById('controlDescription').classList.remove('expanded');
  document.getElementById('descToggle').textContent = 'TAP TO EXPAND';
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
    // Refresh whichever tab is active
    if (activeTab === 'dashboard') {
      loadDashboard();
    } else {
      loadDashboard(); // refresh controlsCache too
      loadRecommendations();
    }
  } catch (err) {
    alert('Network error: ' + err.message);
  }
});

// ======================================================================
// ---- RECOMMENDATIONS TAB ----
// ======================================================================

var trailHistory = []; // breadcrumb trail: [{control_id, control_name}]

async function loadRecommendations() {
  var recList = document.getElementById('recList');
  recList.innerHTML = '<p class="loading">Loading recommendations...</p>';

  // Reset trail when re-loading the list
  closeTrail();

  try {
    var res = await fetch(API + '/api/recommendations', { headers: authHeaders() });
    var data = await res.json();

    recsCache = data.recommendations || [];

    document.getElementById('recCompletedCount').textContent = data.completedCount || 0;
    document.getElementById('recTotalCount').textContent = data.totalRecommended || 0;

    // Populate family filter dropdown
    var familyFilter = document.getElementById('recFamilyFilter');
    var currentVal = familyFilter.value;
    var families = [];
    var seen = {};
    recsCache.forEach(function(r) {
      if (!seen[r.control_family]) {
        seen[r.control_family] = true;
        families.push(r.control_family);
      }
    });
    families.sort();
    familyFilter.innerHTML = '<option value="">All Families</option>' +
      families.map(function(f) {
        return '<option value="' + f + '">' + f + '</option>';
      }).join('');
    familyFilter.value = currentVal || '';

    renderRecommendations();
  } catch (err) {
    console.error('Failed to load recommendations:', err);
    recList.innerHTML = '<p class="loading">Failed to load recommendations.</p>';
  }
}

function renderRecommendations() {
  var recList = document.getElementById('recList');
  var familyFilter = document.getElementById('recFamilyFilter').value;
  var statusFilter = document.getElementById('recStatusFilter').value;

  var filtered = recsCache.filter(function(r) {
    if (familyFilter && r.control_family !== familyFilter) return false;
    if (statusFilter === 'unassessed' && r.current_answer !== null) return false;
    if (statusFilter === 'incomplete' && r.current_answer !== 'No' && r.current_answer !== 'In-Progress') return false;
    return true;
  });

  if (filtered.length === 0) {
    recList.innerHTML = '<p class="loading">No recommendations match your filters. Complete more controls to see recommendations.</p>';
    return;
  }

  recList.innerHTML = filtered.map(function(r) {
    var badgeClass = r.current_answer ? 'badge-' + r.current_answer.toLowerCase().replace(/\s+/g, '-') : 'badge-unanswered';
    var statusText = r.current_answer || 'Not assessed';
    var stars = r.current_rating ? '★'.repeat(r.current_rating) + '☆'.repeat(5 - r.current_rating) : '';

    var linkedText = r.linked_from.length <= 3
      ? r.linked_from.join(', ')
      : r.linked_from.slice(0, 3).join(', ') + ' +' + (r.linked_from.length - 3) + ' more';

    return '<div class="rec-card" data-control-id="' + r.control_id + '">' +
      '<div class="rec-card-top">' +
        '<div class="rec-card-id">' + r.control_id + '</div>' +
        '<span class="badge ' + badgeClass + '">' + statusText + '</span>' +
      '</div>' +
      '<div class="rec-card-name">' + r.control_name + '</div>' +
      (r.phase ? '<span class="phase-badge">' + r.phase + '</span>' : '') +
      '<div class="rec-card-links">' +
        '<span class="rec-link-count">' + r.link_count + '</span> completed control' +
        (r.link_count !== 1 ? 's' : '') + ' reference this: ' +
        '<span class="rec-link-ids">' + linkedText + '</span>' +
      '</div>' +
      (stars ? '<div class="rec-card-rating"><span class="rating">' + stars + '</span></div>' : '') +
      '<div class="rec-card-explore">Click to explore connections</div>' +
    '</div>';
  }).join('');
}

// Filter change handlers
document.getElementById('recFamilyFilter').addEventListener('change', renderRecommendations);
document.getElementById('recStatusFilter').addEventListener('change', renderRecommendations);

// Click on a recommendation card → open trail explorer
document.getElementById('recList').addEventListener('click', function(e) {
  var card = e.target.closest('.rec-card[data-control-id]');
  if (!card) return;

  var controlId = card.getAttribute('data-control-id');
  var record = recsCache.find(function(r) { return r.control_id === controlId; });
  if (!record) return;

  // Start a new trail
  trailHistory = [];
  openTrailExplorer(controlId);
});

// ---- Trail Explorer ----
async function openTrailExplorer(controlId) {
  var explorer = document.getElementById('trailExplorer');
  var recList = document.getElementById('recList');
  var trailBar = document.getElementById('trailBar');

  // Show the explorer, hide the list
  recList.style.display = 'none';
  trailBar.style.display = 'flex';
  explorer.style.display = 'block';
  explorer.innerHTML = '<p class="loading">Loading connections...</p>';

  try {
    var res = await fetch(API + '/api/recommendations/connections/' + controlId, { headers: authHeaders() });
    var data = await res.json();

    var ctrl = data.control;
    var leadsTo = data.leads_to || [];
    var referencedBy = data.referenced_by || [];

    // Add to breadcrumb trail (avoid duplicates from clicking back)
    var existingIdx = trailHistory.findIndex(function(t) { return t.control_id === controlId; });
    if (existingIdx >= 0) {
      // Clicked a breadcrumb — trim trail to that point
      trailHistory = trailHistory.slice(0, existingIdx + 1);
    } else {
      trailHistory.push({ control_id: ctrl.control_id, control_name: ctrl.control_name });
    }

    renderTrailCrumbs();
    renderExplorer(ctrl, leadsTo, referencedBy);

    explorer.scrollIntoView({ behavior: 'smooth', block: 'start' });
  } catch (err) {
    console.error('Failed to load connections:', err);
    explorer.innerHTML = '<p class="loading">Failed to load connections.</p>';
  }
}

function renderTrailCrumbs() {
  var crumbs = document.getElementById('trailCrumbs');
  crumbs.innerHTML = trailHistory.map(function(t, i) {
    var isLast = (i === trailHistory.length - 1);
    var sep = (i < trailHistory.length - 1) ? '<span class="trail-sep">&rarr;</span>' : '';
    if (isLast) {
      return '<span class="trail-crumb trail-crumb-active">' + t.control_id + '</span>' + sep;
    }
    return '<span class="trail-crumb" data-trail-idx="' + i + '">' + t.control_id + '</span>' + sep;
  }).join('');
}

// Click breadcrumb to jump back
document.getElementById('trailCrumbs').addEventListener('click', function(e) {
  var crumb = e.target.closest('.trail-crumb[data-trail-idx]');
  if (!crumb) return;
  var idx = parseInt(crumb.getAttribute('data-trail-idx'));
  var target = trailHistory[idx];
  if (target) {
    trailHistory = trailHistory.slice(0, idx);
    openTrailExplorer(target.control_id);
  }
});

function renderExplorer(ctrl, leadsTo, referencedBy) {
  var explorer = document.getElementById('trailExplorer');

  var badgeClass = ctrl.current_answer ? 'badge-' + ctrl.current_answer.toLowerCase().replace(/\s+/g, '-') : 'badge-unanswered';
  var statusText = ctrl.current_answer || 'Not assessed';
  var stars = ctrl.current_rating ? '★'.repeat(ctrl.current_rating) + '☆'.repeat(5 - ctrl.current_rating) : '';

  // Separate leads_to into groups
  var leadsToActionable = leadsTo.filter(function(c) { return c.current_answer !== 'Yes'; });
  var leadsToCompleted = leadsTo.filter(function(c) { return c.current_answer === 'Yes'; });

  var html = '';

  // ========== ROOT NODE ==========
  html += '<div class="tree-root">';
  html += '<div class="tree-node-card tree-node-current">';
  html += '<div class="tree-node-header">';
  html += '<div class="tree-node-id">' + ctrl.control_id + '</div>';
  html += '<span class="badge ' + badgeClass + '">' + statusText + '</span>';
  html += '</div>';
  html += '<div class="tree-node-name">' + ctrl.control_name + '</div>';
  html += '<div class="tree-node-meta">';
  if (ctrl.phase) html += '<span class="phase-badge">' + ctrl.phase + '</span>';
  if (stars) html += '<span class="rating">' + stars + '</span>';
  html += '</div>';

  // Collapsible NIST description
  if (ctrl.nist_standard) {
    html += '<div class="tree-nist-toggle" data-toggle="nist">View NIST Requirement <span class="toggle-icon">&#9662;</span></div>';
    html += '<div class="tree-nist-body" style="display:none;">';
    html += '<p>' + ctrl.nist_standard + '</p>';
    html += '</div>';
  }

  html += '<div class="tree-node-actions">';
  html += '<button class="explorer-assess-btn" data-assess-id="' + ctrl.control_id + '">Assess This Control</button>';
  html += '</div>';
  html += '</div>'; // .tree-node-current

  // "Referenced by" as a compact info bar under the root node
  if (referencedBy.length > 0) {
    html += '<div class="tree-ref-bar" data-toggle="refby">';
    html += '<span class="tree-ref-label">Referenced by ' + referencedBy.length + ' control' + (referencedBy.length !== 1 ? 's' : '') + '</span>';
    html += '<span class="toggle-icon">&#9662;</span>';
    html += '</div>';
    html += '<div class="tree-ref-list" style="display:none;">';
    referencedBy.forEach(function(c) {
      var cBadge = c.current_answer ? 'badge-' + c.current_answer.toLowerCase().replace(/\s+/g, '-') : 'badge-unanswered';
      var cStatus = c.current_answer || 'Not assessed';
      html += '<div class="tree-ref-chip" data-connection-id="' + c.control_id + '">';
      html += '<span class="tree-ref-id">' + c.control_id + '</span>';
      html += '<span class="tree-ref-name">' + c.control_name + '</span>';
      html += '<span class="badge ' + cBadge + '">' + cStatus + '</span>';
      html += '</div>';
    });
    html += '</div>';
  }
  html += '</div>'; // .tree-root

  // ========== TRUNK LINE ==========
  if (leadsTo.length > 0) {
    html += '<div class="tree-trunk">';
    html += '<div class="tree-trunk-line"></div>';
    html += '<div class="tree-trunk-label">BRANCHES TO ' + leadsTo.length + ' CONTROL' + (leadsTo.length !== 1 ? 'S' : '') + '</div>';
    html += '<div class="tree-trunk-line"></div>';
    html += '</div>';

    // ========== BRANCH NODES ==========
    html += '<div class="tree-branches">';

    // Actionable branches first (not yet completed)
    leadsToActionable.forEach(function(c, i) {
      var cBadge = c.current_answer ? 'badge-' + c.current_answer.toLowerCase().replace(/\s+/g, '-') : 'badge-unanswered';
      var cStatus = c.current_answer || 'Not assessed';
      var cStars = c.current_rating ? '★'.repeat(c.current_rating) + '☆'.repeat(5 - c.current_rating) : '';
      html += '<div class="tree-branch">';
      html += '<div class="tree-branch-connector"><div class="tree-branch-dot"></div></div>';
      html += '<div class="tree-node-card tree-node-actionable" data-connection-id="' + c.control_id + '">';
      html += '<div class="tree-node-header">';
      html += '<div class="tree-node-id">' + c.control_id + '</div>';
      html += '<span class="badge ' + cBadge + '">' + cStatus + '</span>';
      html += '</div>';
      html += '<div class="tree-node-name">' + c.control_name + '</div>';
      if (c.phase || cStars) {
        html += '<div class="tree-node-meta">';
        if (c.phase) html += '<span class="phase-badge">' + c.phase + '</span>';
        if (cStars) html += '<span class="rating">' + cStars + '</span>';
        html += '</div>';
      }
      html += '<div class="tree-node-follow">Follow this path &rarr;</div>';
      html += '</div>'; // .tree-node-card
      html += '</div>'; // .tree-branch
    });

    // Completed branches (dimmer, grouped)
    if (leadsToCompleted.length > 0) {
      html += '<div class="tree-completed-group">';
      html += '<div class="tree-completed-label">' + leadsToCompleted.length + ' completed control' + (leadsToCompleted.length !== 1 ? 's' : '') + '</div>';
      leadsToCompleted.forEach(function(c) {
        html += '<div class="tree-branch">';
        html += '<div class="tree-branch-connector tree-branch-connector-done"><div class="tree-branch-dot tree-branch-dot-done"></div></div>';
        html += '<div class="tree-node-card tree-node-done" data-connection-id="' + c.control_id + '">';
        html += '<div class="tree-node-header">';
        html += '<div class="tree-node-id">' + c.control_id + '</div>';
        html += '<span class="badge badge-yes">Yes</span>';
        html += '</div>';
        html += '<div class="tree-node-name">' + c.control_name + '</div>';
        html += '<div class="tree-node-follow">View connections &rarr;</div>';
        html += '</div>';
        html += '</div>';
      });
      html += '</div>';
    }

    html += '</div>'; // .tree-branches
  } else {
    html += '<div class="tree-trunk">';
    html += '<div class="tree-trunk-line"></div>';
    html += '<div class="tree-trunk-label">NO RELATED CONTROLS</div>';
    html += '<div class="tree-trunk-line"></div>';
    html += '</div>';
  }

  explorer.innerHTML = html;
}

// Toggle collapsible sections (NIST description, Referenced By)
document.getElementById('trailExplorer').addEventListener('click', function(e) {
  var toggle = e.target.closest('[data-toggle]');
  if (toggle) {
    var type = toggle.getAttribute('data-toggle');
    var icon = toggle.querySelector('.toggle-icon');
    if (type === 'nist') {
      var body = toggle.nextElementSibling;
      if (body && body.classList.contains('tree-nist-body')) {
        var showing = body.style.display !== 'none';
        body.style.display = showing ? 'none' : 'block';
        if (icon) icon.innerHTML = showing ? '&#9662;' : '&#9652;';
      }
    } else if (type === 'refby') {
      var list = toggle.nextElementSibling;
      if (list && list.classList.contains('tree-ref-list')) {
        var showing2 = list.style.display !== 'none';
        list.style.display = showing2 ? 'none' : 'block';
        if (icon) icon.innerHTML = showing2 ? '&#9662;' : '&#9652;';
      }
    }
    return;
  }
});

// Click a connection chip → follow the trail
document.getElementById('trailExplorer').addEventListener('click', function(e) {
  // "Assess This Control" button
  var assessBtn = e.target.closest('.explorer-assess-btn');
  if (assessBtn) {
    var assessId = assessBtn.getAttribute('data-assess-id');
    var record = controlsCache.find(function(r) { return r.control_id === assessId; });
    if (record) {
      openEditModal(assessId, record);
    } else {
      // Fetch from recsCache or just open with what we have
      var rec = recsCache.find(function(r) { return r.control_id === assessId; });
      if (rec) openEditModal(assessId, rec);
    }
    return;
  }

  // Connection chip or branch node → follow trail
  var chip = e.target.closest('[data-connection-id]');
  if (!chip) return;
  var controlId = chip.getAttribute('data-connection-id');
  openTrailExplorer(controlId);
});

// Close trail → back to list
function closeTrail() {
  trailHistory = [];
  document.getElementById('trailBar').style.display = 'none';
  document.getElementById('trailExplorer').style.display = 'none';
  document.getElementById('recList').style.display = '';
}

document.getElementById('trailClose').addEventListener('click', function() {
  closeTrail();
  renderRecommendations(); // refresh the list
});
