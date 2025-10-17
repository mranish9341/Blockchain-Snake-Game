<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>DAppHero Snake Game</title>
  <style>
    body {
      font-family: sans-serif; 
      text-align: center; 
      margin-top: 50px;
    }
    input {
      padding: 5px;
      margin: 5px;
    }
    button {
      padding: 7px 15px;
      margin: 5px;
      cursor: pointer;
    }
  </style>
</head>
<body>
  <h1>🎮 Blockchain Snake Game</h1>
  
  <button id="connectButton">🔗 Connect MetaMask</button>
  <p>Wallet: <span id="walletAddress">Not Connected</span></p>

  <hr>

  <h3>Challenge Actions</h3>
  <input type="number" id="amount" placeholder="Deposit amount in ETH" />
  <button id="startChallenge">Start Challenge</button>

  <br>

  <input type="number" id="score" placeholder="Your score" />
  <button id="claimReward">Claim Reward</button>

  <p id="status"></p>

  <script src="https://cdn.jsdelivr.net/npm/web3@1.10.0/dist/web3.min.js"></script>
  <script>
    let web3;
    let accounts;
    let contract;

    const connectButton = document.getElementById('connectButton');
    const walletSpan = document.getElementById('walletAddress');
    const status = document.getElementById('status');

    // Replace with your actual contract address
    const contractAddress = "0xf8e81D47203A594245E36C48e151709F0C19fBe8";

    // Minimal ABI for your contract
    const contractABI = [
      { "constant": false, "inputs": [], "name": "newChallenge", "outputs": [], "payable": true, "stateMutability": "payable", "type": "function" },
      { "constant": false, "inputs": [{"name":"_score","type":"uint256"}], "name": "claim", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }
    ];

    // Connect MetaMask
    connectButton.onclick = async () => {
      if (window.ethereum) {
        try {
          accounts = await window.ethereum.request({ method: "eth_requestAccounts" });
          walletSpan.textContent = accounts[0];

          web3 = new Web3(window.ethereum);
          contract = new web3.eth.Contract(contractABI, contractAddress);

          status.textContent = "✅ MetaMask connected!";
        } catch (err) {
          console.error(err);
          status.textContent = "❌ Connection rejected.";
        }
      } else {
        alert("Please install MetaMask!");
      }
    };

    // Detect account changes
    if (window.ethereum) {
      window.ethereum.on("accountsChanged", (newAccounts) => {
        accounts = newAccounts;
        walletSpan.textContent = accounts[0] || "Not Connected";
        status.textContent = "🔄 Account changed!";
      });

      window.ethereum.on("chainChanged", () => {
        window.location.reload();
      });
    }

    // Start Challenge
    document.getElementById('startChallenge').onclick = async () => {
      if (!accounts || accounts.length === 0) return alert("Connect MetaMask first!");
      const amount = document.getElementById('amount').value;
      if (!amount) return alert("Enter an amount!");

      try {
        await contract.methods.newChallenge().send({
          from: accounts[0],
          value: web3.utils.toWei(amount, "ether")
        });
        status.textContent = "✅ Challenge started!";
      } catch (err) {
        console.error(err);
        status.textContent = "❌ Transaction failed.";
      }
    };

    // Claim Reward
    document.getElementById('claimReward').onclick = async () => {
      if (!accounts || accounts.length === 0) return alert("Connect MetaMask first!");
      const score = document.getElementById('score').value;
      if (!score) return alert("Enter your score!");

      try {
        await contract.methods.claim(score).send({ from: accounts[0] });
        status.textContent = "🏆 Reward claimed successfully!";
      } catch (err) {
        console.error(err);
        status.textContent = "❌ Claim failed.";
      }
    };
  </script>
</body>
</html>
