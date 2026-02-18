<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"/><meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<title>Agent Portal — SwiftData GH</title>
<link rel="preconnect" href="https://fonts.googleapis.com"/>
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet"/>
<script src="https://js.paystack.co/v2/inline.js"></script>
<style>
:root{--blue:#0051ff;--sky:#38bdf8;--mint:#00e5b0;--yellow:#f59e0b;--green:#22c55e;--red:#ef4444;}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Plus Jakarta Sans',sans-serif;background:#060b18;color:#fff;min-height:100vh;display:flex;flex-direction:column;}
/* BG */
body::before{content:'';position:fixed;inset:0;background:radial-gradient(ellipse 70% 60% at 30% 40%,rgba(0,81,255,.07) 0%,transparent 60%),radial-gradient(ellipse 50% 40% at 75% 70%,rgba(0,229,176,.05) 0%,transparent 60%);pointer-events:none;}
nav{height:64px;display:flex;align-items:center;border-bottom:1px solid rgba(255,255,255,.06);flex-shrink:0;}
.nav-inner{max-width:1100px;margin:0 auto;width:100%;padding:0 5%;display:flex;align-items:center;justify-content:space-between;}
.logo{font-weight:800;font-size:1.25rem;color:#fff;text-decoration:none;letter-spacing:-.3px;}
.logo span{color:var(--mint);}
.nav-home{color:rgba(255,255,255,.45);text-decoration:none;font-size:.85rem;font-weight:600;display:flex;align-items:center;gap:.4rem;transition:color .2s;}
.nav-home:hover{color:#fff;}
/* LAYOUT */
.page-wrap{flex:1;display:flex;align-items:center;justify-content:center;padding:2rem 1.5rem;}
.auth-card{background:rgba(255,255,255,.03);border:1px solid rgba(255,255,255,.07);border-radius:28px;padding:2.5rem;max-width:480px;width:100%;backdrop-filter:blur(20px);}
/* TABS */
.auth-tabs{display:flex;background:rgba(255,255,255,.05);border-radius:12px;padding:3px;margin-bottom:2rem;}
.auth-tab{flex:1;padding:.55rem;border-radius:10px;border:none;background:none;color:rgba(255,255,255,.4);font-family:inherit;font-weight:700;font-size:.9rem;cursor:pointer;transition:all .2s;}
.auth-tab.active{background:var(--blue);color:#fff;box-shadow:0 4px 12px rgba(0,81,255,.35);}
/* FORMS */
.auth-form{display:none;}
.auth-form.show{display:block;}
.form-title{font-weight:800;font-size:1.3rem;margin-bottom:.35rem;}
.form-sub{font-size:.85rem;color:rgba(255,255,255,.35);margin-bottom:1.75rem;line-height:1.5;}
.flabel{font-size:.7rem;font-weight:800;text-transform:uppercase;letter-spacing:1.5px;color:rgba(255,255,255,.3);margin-bottom:.4rem;}
.finput{width:100%;padding:.82rem 1rem;background:rgba(255,255,255,.05);border:1.5px solid rgba(255,255,255,.08);border-radius:12px;color:#fff;font-family:inherit;font-size:.92rem;outline:none;transition:border-color .2s;margin-bottom:.85rem;}
.finput::placeholder{color:rgba(255,255,255,.2);}
.finput:focus{border-color:rgba(0,81,255,.5);background:rgba(0,81,255,.05);}
.finput.error{border-color:rgba(239,68,68,.5);}
.pw-wrap{position:relative;}
.pw-wrap .finput{padding-right:3rem;margin-bottom:0;}
.pw-eye{position:absolute;right:.85rem;top:50%;transform:translateY(-50%);background:none;border:none;color:rgba(255,255,255,.3);cursor:pointer;font-size:.9rem;}
.pw-eye:hover{color:#fff;}
.pw-margin{margin-bottom:.85rem;}
.field-hint{font-size:.75rem;color:rgba(255,255,255,.25);margin-bottom:.85rem;margin-top:-.5rem;}
/* ACTIVATION FEE BOX */
.fee-box{background:rgba(0,229,176,.06);border:1.5px solid rgba(0,229,176,.18);border-radius:16px;padding:1.25rem;margin-bottom:1.5rem;}
.fee-box-title{display:flex;align-items:center;gap:.5rem;font-weight:800;font-size:.95rem;color:var(--mint);margin-bottom:.65rem;}
.fee-row{display:flex;justify-content:space-between;font-size:.85rem;color:rgba(255,255,255,.5);margin-bottom:.3rem;}
.fee-row strong{color:#fff;}
.fee-total{display:flex;justify-content:space-between;font-weight:800;font-size:1rem;margin-top:.6rem;padding-top:.6rem;border-top:1px solid rgba(0,229,176,.15);}
.fee-total .amount{color:var(--mint);font-size:1.2rem;}
/* SUBMIT BTN */
.submit-btn{width:100%;padding:.9rem;background:var(--blue);color:#fff;border:none;border-radius:12px;font-family:inherit;font-weight:800;font-size:.95rem;cursor:pointer;transition:transform .2s,box-shadow .2s;display:flex;align-items:center;justify-content:center;gap:.5rem;}
.submit-btn:hover:not(:disabled){transform:translateY(-2px);box-shadow:0 10px 28px rgba(0,81,255,.35);}
.submit-btn:disabled{opacity:.4;cursor:not-allowed;}
.submit-btn.mint-btn{background:linear-gradient(135deg,var(--mint),#00b4d8);color:#0a1020;}
.submit-btn.mint-btn:hover:not(:disabled){box-shadow:0 10px 28px rgba(0,229,176,.35);}
/* ERRORS */
.err-box{background:rgba(239,68,68,.1);border:1px solid rgba(239,68,68,.2);color:#fca5a5;border-radius:10px;padding:.7rem 1rem;font-size:.83rem;margin-bottom:1rem;display:none;}
.err-box.show{display:block;}
.success-box{background:rgba(34,197,94,.1);border:1px solid rgba(34,197,94,.2);color:#86efac;border-radius:10px;padding:.7rem 1rem;font-size:.83rem;margin-bottom:1rem;display:none;}
.success-box.show{display:block;}
/* ALREADY REGISTERED NOTE */
.or-divider{text-align:center;font-size:.78rem;color:rgba(255,255,255,.2);margin:1.25rem 0;}
.switch-link{text-align:center;font-size:.83rem;color:rgba(255,255,255,.35);}
.switch-link button{background:none;border:none;color:var(--mint);cursor:pointer;font-weight:700;font-family:inherit;font-size:.83rem;}
.switch-link button:hover{text-decoration:underline;}
/* SPINNER */
.spin{width:16px;height:16px;border:2px solid rgba(255,255,255,.3);border-top-color:#fff;border-radius:50%;animation:sp .7s linear infinite;display:inline-block;}
@keyframes sp{to{transform:rotate(360deg);}}
@keyframes fadeUp{from{opacity:0;transform:translateY(16px);}to{opacity:1;transform:translateY(0);}}
.auth-card{animation:fadeUp .35s ease;}
/* PENDING/BANNED STATES */
.status-alert{background:rgba(245,158,11,.08);border:1px solid rgba(245,158,11,.2);color:#fde68a;border-radius:16px;padding:1.5rem;text-align:center;margin-bottom:1rem;}
.status-alert.banned{background:rgba(239,68,68,.08);border-color:rgba(239,68,68,.2);color:#fca5a5;}
.status-alert h4{font-weight:800;margin-bottom:.4rem;}
.status-alert p{font-size:.85rem;opacity:.8;line-height:1.5;}
footer{text-align:center;padding:1.25rem;font-size:.75rem;color:rgba(255,255,255,.15);}
</style>
</head>
<body>
<nav>
  <div class="nav-inner">
    <a href="/home" class="logo">SwiftData<span>GH</span></a>
    <a href="/home" class="nav-home">← Back to Store</a>
  </div>
</nav>

<div class="page-wrap">
  <div class="auth-card">
    <!-- TAB SWITCH -->
    <div class="auth-tabs">
      <button class="auth-tab active" id="tab-signup" onclick="switchTab('signup')">Create Account</button>
      <button class="auth-tab" id="tab-login" onclick="switchTab('login')">Login</button>
    </div>

    <!-- SIGNUP FORM -->
    <div class="auth-form show" id="form-signup">
      <div class="form-title">Become an Agent ⚡</div>
      <div class="form-sub">Sign up, pay the one-time activation fee, and get your own store dashboard immediately.</div>
      <div id="signup-err" class="err-box"></div>
      <div id="signup-success" class="success-box"></div>
      <form onsubmit="handleSignup(event)">
        <div class="flabel">Full Name / Store Name</div>
        <input class="finput" type="text" id="su-name" placeholder="e.g. Kwame's Data Store" required/>
        <div class="flabel">Username (your store link ID)</div>
        <input class="finput" type="text" id="su-username" placeholder="e.g. kwame123" required oninput="sanitizeUsername(this)"/>
        <div class="field-hint">Your store link will be: swiftdatagh.vercel.app/store?agent=kwame123</div>
        <div class="flabel">Email Address</div>
        <input class="finput" type="email" id="su-email" placeholder="your@email.com" required/>
        <div class="flabel">Password</div>
        <div class="pw-wrap pw-margin">
          <input class="finput" type="password" id="su-pass" placeholder="At least 6 characters" required/>
          <button type="button" class="pw-eye" onclick="togglePw('su-pass')">👁</button>
        </div>
        <div class="flabel">Phone Number</div>
        <input class="finput" type="tel" id="su-phone" placeholder="05XXXXXXXX" maxlength="10" inputmode="numeric"/>

        <div class="fee-box">
          <div class="fee-box-title">⚡ Store Activation Fee</div>
          <div class="fee-row"><span>One-time activation</span><strong>GHS 24.39</strong></div>
          <div class="fee-row"><span>Platform fee (2.5%)</span><strong>GHS 0.61</strong></div>
          <div class="fee-total"><span>Total (via Paystack)</span><span class="amount">GHS 25.00</span></div>
        </div>

        <button type="submit" class="submit-btn mint-btn" id="signup-btn">
          Register & Pay GHS 25 →
        </button>
      </form>
      <div class="or-divider">Already have an account?</div>
      <div class="switch-link"><button onclick="switchTab('login')">Login to your dashboard</button></div>
    </div>

    <!-- LOGIN FORM -->
    <div class="auth-form" id="form-login">
      <div class="form-title">Welcome Back 👋</div>
      <div class="form-sub">Log in to access your agent dashboard and manage your store.</div>
      <div id="login-err" class="err-box"></div>
      <form onsubmit="handleLogin(event)">
        <div class="flabel">Email Address</div>
        <input class="finput" type="email" id="li-email" placeholder="your@email.com" required/>
        <div class="flabel">Password</div>
        <div class="pw-wrap pw-margin">
          <input class="finput" type="password" id="li-pass" placeholder="Your password" required/>
          <button type="button" class="pw-eye" onclick="togglePw('li-pass')">👁</button>
        </div>
        <button type="submit" class="submit-btn" id="login-btn">Login →</button>
      </form>
      <div class="or-divider">Don't have an account?</div>
      <div class="switch-link"><button onclick="switchTab('signup')">Register as an agent</button></div>
    </div>
  </div>
</div>
<footer>© 2026 SwiftData GH — Powered by Kaysam Growth</footer>

<script type="module">
import { initializeApp }      from "https://www.gstatic.com/firebasejs/10.13.1/firebase-app.js";
import { getAuth, createUserWithEmailAndPassword, signInWithEmailAndPassword, onAuthStateChanged } from "https://www.gstatic.com/firebasejs/10.13.1/firebase-auth.js";
import { getFirestore, collection, doc, setDoc, getDoc, getDocs, query, where, serverTimestamp } from "https://www.gstatic.com/firebasejs/10.13.1/firebase-firestore.js";

const firebaseConfig={apiKey:"AIzaSyBVTQqx3fpkpUeCRO5B4N9Hb8dDxJGDIsg",authDomain:"swiftdata-32d80.firebaseapp.com",projectId:"swiftdata-32d80",storageBucket:"swiftdata-32d80.firebasestorage.app",messagingSenderId:"112123396026",appId:"1:112123396026:web:8673fe7a2e5b77e2156783",measurementId:"G-GPS00TXFLD"};
const APP_ID='swiftdata-main-app';

const app=initializeApp(firebaseConfig);
const auth=getAuth(app);
const db=getFirestore(app);

// Check if already logged in
onAuthStateChanged(auth, async user => {
  if(user){
    // Check their agent status
    const agentDoc=await getDoc(doc(db,'swiftdata_agents',user.uid));
    if(agentDoc.exists()){
      const data=agentDoc.data();
      if(data.status==='active') window.location.href='/agent.dashboard';
    }
  }
});

// Tab switching
window.switchTab=(tab)=>{
  document.getElementById('form-signup').classList.toggle('show',tab==='signup');
  document.getElementById('form-login').classList.toggle('show',tab==='login');
  document.getElementById('tab-signup').classList.toggle('active',tab==='signup');
  document.getElementById('tab-login').classList.toggle('active',tab==='login');
};

window.sanitizeUsername=(inp)=>{
  inp.value=inp.value.toLowerCase().replace(/[^a-z0-9_]/g,'').substring(0,20);
};

window.togglePw=(id)=>{
  const i=document.getElementById(id);
  i.type=i.type==='password'?'text':'password';
};

function showErr(id,msg){const el=document.getElementById(id);el.textContent=msg;el.classList.add('show');}
function hideErr(id){document.getElementById(id).classList.remove('show');}

// Get paystack key
async function getPaystackKey(){
  try{
    const d=await getDoc(doc(db,'artifacts',APP_ID,'public','data','config','settings_doc'));
    return d.exists()?d.data().paystackPublicKey||'':'';
  }catch{return '';}
}

// Check username availability
async function isUsernameAvailable(username){
  const q=query(collection(db,'swiftdata_agents'),where('username','==',username));
  const snap=await getDocs(q);
  return snap.empty;
}

// SIGNUP HANDLER
window.handleSignup=async(e)=>{
  e.preventDefault();
  hideErr('signup-err');
  const name=document.getElementById('su-name').value.trim();
  const username=document.getElementById('su-username').value.trim().toLowerCase();
  const email=document.getElementById('su-email').value.trim();
  const pass=document.getElementById('su-pass').value;
  const phone=document.getElementById('su-phone').value.replace(/\D/g,'');

  if(!username||username.length<3){showErr('signup-err','Username must be at least 3 characters.');return;}
  if(!/^[a-z0-9_]+$/.test(username)){showErr('signup-err','Username can only contain letters, numbers, and underscores.');return;}

  const btn=document.getElementById('signup-btn');
  btn.disabled=true;btn.innerHTML='<span class="spin"></span> Checking…';

  try{
    // Check username uniqueness
    const available=await isUsernameAvailable(username);
    if(!available){showErr('signup-err','Username already taken. Please choose another.');btn.disabled=false;btn.innerHTML='Register & Pay GHS 25 →';return;}

    // Get Paystack key
    const psKey=await getPaystackKey();

    // Store pending signup data temporarily
    const pendingData={name,username,email,phone};
    sessionStorage.setItem('sd_pending_signup',JSON.stringify(pendingData));

    if(!psKey){
      // Demo mode — create account without payment
      await completeFreeSignup(pendingData, email, pass, 'DEMO_ACTIVATION_'+Date.now());
      return;
    }

    btn.innerHTML='<span class="spin"></span> Loading Payment…';

    // Create Firebase account first (before payment, in pending state)
    let userCred;
    try{ userCred=await createUserWithEmailAndPassword(auth,email,pass); }
    catch(authErr){
      if(authErr.code==='auth/email-already-in-use'){showErr('signup-err','This email is already registered. Please login.');}
      else if(authErr.code==='auth/weak-password'){showErr('signup-err','Password must be at least 6 characters.');}
      else{showErr('signup-err','Registration error: '+authErr.message);}
      btn.disabled=false;btn.innerHTML='Register & Pay GHS 25 →';return;
    }

    const uid=userCred.user.uid;
    // Save as pending
    await setDoc(doc(db,'swiftdata_agents',uid),{
      uid,name,username,email,phone,status:'pending',
      walletBalance:0,totalEarned:0,totalOrders:0,
      createdAt:serverTimestamp(),paymentRef:null
    });

    // Launch Paystack
    const ps=new PaystackPop();
    ps.newTransaction({
      key:psKey,email,amount:2500,// GHS 25.00 in pesewas
      currency:'GHS',ref:'AGENT_ACT_'+Date.now()+'_'+uid.substring(0,8),
      metadata:{uid,username,name,type:'agent_activation'},
      onSuccess:async(tx)=>{
        btn.innerHTML='<span class="spin"></span> Activating account…';
        // Update agent to active
        await setDoc(doc(db,'swiftdata_agents',uid),{
          uid,name,username,email,phone,status:'active',
          walletBalance:0,totalEarned:0,totalOrders:0,
          createdAt:serverTimestamp(),activatedAt:serverTimestamp(),
          paymentRef:tx.reference,activationFee:25
        },{merge:true});
        // Add default products (copy from main products with agent markup)
        sessionStorage.setItem('sd_agent_uid',uid);
        window.location.href='/agent.dashboard';
      },
      onCancel:async()=>{
        // Delete the pending agent record
        await fetch(`https://firestore.googleapis.com/v1/projects/swiftdata-32d80/databases/(default)/documents/swiftdata_agents/${uid}`,{method:'DELETE'}).catch(()=>{});
        await userCred.user.delete().catch(()=>{});
        auth.signOut();
        btn.disabled=false;btn.innerHTML='Register & Pay GHS 25 →';
        showErr('signup-err','Payment was cancelled. Your account was not created. Please try again.');
      }
    });
  }catch(err){
    console.error(err);showErr('signup-err','An error occurred: '+err.message);
    btn.disabled=false;btn.innerHTML='Register & Pay GHS 25 →';
  }
};

async function completeFreeSignup(data, email, pass, payRef){
  const btn=document.getElementById('signup-btn');
  btn.innerHTML='<span class="spin"></span> Creating account…';
  try{
    const cred=await createUserWithEmailAndPassword(auth,email,pass);
    const uid=cred.user.uid;
    await setDoc(doc(db,'swiftdata_agents',uid),{
      uid,name:data.name,username:data.username,email,phone:data.phone||'',
      status:'active',walletBalance:0,totalEarned:0,totalOrders:0,
      createdAt:serverTimestamp(),activatedAt:serverTimestamp(),
      paymentRef:payRef,activationFee:0,isDemoAccount:true
    });
    window.location.href='/agent.dashboard';
  }catch(err){
    if(err.code==='auth/email-already-in-use'){showErr('signup-err','This email is already registered. Please login.');}
    else{showErr('signup-err',err.message);}
    btn.disabled=false;btn.innerHTML='Register & Pay GHS 25 →';
  }
}

// LOGIN HANDLER
window.handleLogin=async(e)=>{
  e.preventDefault();
  hideErr('login-err');
  const email=document.getElementById('li-email').value.trim();
  const pass=document.getElementById('li-pass').value;
  const btn=document.getElementById('login-btn');
  btn.disabled=true;btn.innerHTML='<span class="spin"></span> Logging in…';
  try{
    const cred=await signInWithEmailAndPassword(auth,email,pass);
    const uid=cred.user.uid;
    const agentDoc=await getDoc(doc(db,'swiftdata_agents',uid));
    if(!agentDoc.exists()){await auth.signOut();showErr('login-err','No agent account found for this email.');btn.disabled=false;btn.innerHTML='Login →';return;}
    const data=agentDoc.data();
    if(data.status==='banned'){
      await auth.signOut();
      showErr('login-err','Your account has been suspended. Please contact support.');
      btn.disabled=false;btn.innerHTML='Login →';return;
    }
    if(data.status==='pending'){
      showErr('login-err','Your account is pending activation. Please complete the registration payment.');
      btn.disabled=false;btn.innerHTML='Login →';return;
    }
    window.location.href='/agent.dashboard';
  }catch(err){
    if(err.code==='auth/user-not-found'||err.code==='auth/wrong-password'||err.code==='auth/invalid-credential'){showErr('login-err','Incorrect email or password.');}
    else{showErr('login-err',err.message);}
    btn.disabled=false;btn.innerHTML='Login →';
  }
};
</script>
</body>
</html>
