
async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contacts with account:", deployer.address);

    console.log("Account balance:", (await deployer.getBalance()).toString());
    
    const Token = await ethers.getContractFactory("WavePortal");
    const token = await Token.deploy({value: ethers.utils.parseEther("0.001")});
    await token.deployed();
    console.log("WavePortal address:", token.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });