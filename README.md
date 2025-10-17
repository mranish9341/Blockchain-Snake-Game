# Blockchain Snake Game (Using DappHero)
Score Higher than the Rest and Win Crypto!


![](https://i.imgur.com/RWyIiuT.png)

Combining the Classic Snake game and the latest technology: Blockchain, this game aims to reward crypto to the Players that score better than the rest.

In order to start the match, the player deposits .001 ETH into the Game Pool and begins the game. On biting the snake's tail or hitting the wall, the game ends and the score is sent to the Game's Smart Contract. If the player's score is greater than the current overall Player Average than he is rewarded with .001 ETH (initial deposit) + 1% winning prize (0.00001 ETH). Losers lose entire .001 ETH to the Game Pool.

The entire blockchain interaction is handled via DappHero, game logic in phaser.js.

The game follows a unique concept to maintain balance:
If the OverallAverageScore to beat is lower, then the players can easily win emptying out our Prize Pool one-by-one, but because in order to win, the score must be higher than the Total Average Score. This means that with each new win the target to beat (Overall Average) keeps on increasing meaning that it becomes more difficult for each following player. This means more less-skilled players would now lose, losing their .001 ETH deposit thereby maintaining a balance between Prize Pool Reserves and Score To Beat.

![](https://i.imgur.com/F7UJiq8.png)

## Quick start

1. Install Node.js (v16+ recommended).
2. Install deps (only used for the static server):
   
   ```bash
   npm install
   ```

3. Run the local server:
   
   ```bash
   npm run start
   ```
   
   Then open `http://localhost:5173`.

## MetaMask & network

- Install the MetaMask browser extension and unlock your wallet.
- Connect by clicking "Login Via Metamask" in the app header.
- Make sure your wallet is on the same network as the deployed contract.

Current contract address used by the UI:

```
0xD7ACd2a9FD159E69Bb102A1ca21C9a3e3A5F771B
```

If your deployment is different, update `assets/js/contract.js` → `CONTRACT_ADDRESS`.

## Gameplay & on-chain actions

- Click "Deposit .001 ETH and PLAY!" and approve the transaction to start a new challenge.
- Play Snake. On Game Over, click "Claim Prize" to send your score to `claim(score)`.
- The UI includes a fallback direct MetaMask/Web3 flow if DappHero is unavailable.

## Controls

- Arrow keys to move the snake.
- From Game Over screen: click to play again.

## Troubleshooting

- Page not loading: ensure the server is running and visit `http://localhost:5173`.
- MetaMask not detected: install the MetaMask extension and refresh.
- Wrong network: switch to the network where your contract is deployed.
- Contract address mismatch: edit `assets/js/contract.js` and set your address.
- DappHero issues: the app includes a fallback that calls the contract directly via MetaMask using Web3.

## Scripts

- `npm run start` — serves the static site on port 5173.

