
// A Web3Provider wraps a standard Web3 provider, which is
// what MetaMask injects as window.ethereum into each page
var provider = new ethers.providers.Web3Provider(window.ethereum)

// MetaMask requires requesting permission to connect users accounts
async function send() { await provider.send("eth_requestAccounts", []); }
send();

// The MetaMask plugin also allows signing transactions to
// send ether and pay to change state within the blockchain.
// For this, you need the account signer...
var signer = provider.getSigner()
const dexAddress = "0x7a2088a1bFc9d81c55368AE168C2C02570cB814F";
const dexAbi = [
  "constructor(address _token, uint256 _price)",
  "function bestPrice(uint256) view returns (uint256)",
  "function buy(uint256 _tokens) payable",
  "function getBalance(address _add) view returns (uint256)",
  "function getBestPrice(uint256 _tokens) view returns (uint256)",
  "function getarr() view returns (uint256[])",
  "function quickSort(uint256[] arr) pure returns (uint256[])",
  "function sell(uint256 _tokens, uint256 _price)",
];

const contractObj = new ethers.Contract(dexAddress, dexAbi, signer);

async function sell() {
    const _tokens = document.getElementById("sellAmountInput").value;
    const _price = document.getElementById("priceInput").value;
    await contractObj.sell(_tokens, _price)
        .then(() => console.log("sold the amount of tokens you entered"))
        .catch(()=> console.log("transaction failed"));
}

async function buy() {
    const _tokens = document.getElementById("buyAmountInput").value;
    //const bestPrice = await contractObj.getBestPrice(_tokens);
    const pay = ethers.utils.parseUnits("100", "ether");
    await contractObj.buy(_tokens, { value: pay })
        .then(() => console.log("you bought " + _tokens + " tokens"))
        .catch(()=> console.log("transaction failed"));
}

async function getBp() {
    const input = document.getElementById("bestPriceInput").value;
    const bestPrice = await contractObj.getBestPrice(input);
    document.getElementById("bestPriceValue").innerHTML = bestPrice;
}

async function getBalance() {
    const address = document.getElementById("getBalance").value;
    console.log(await contractObj.getBalance(address));
}

