require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.10",
  networks: {
    hardhat: {
      forking: {
        enabled: true,
        url: "https://polygon-mainnet.g.alchemy.com/v2/S-cF3Pyunr77RoGtc9Igwd9vY7mJLGP5",
      },
      chainId: 137,
    },
  },
};
