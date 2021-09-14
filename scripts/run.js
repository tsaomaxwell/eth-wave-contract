async function main() {
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy({value: hre.ethers.utils.parseEther("0.1")});
    await waveContract.deployed();
    console.log("Contract deployed to:", waveContract.address);

    let contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log("Contract Balance:", hre.ethers.utils.formatEther(contractBalance));

    let waveCount;
    waveCount = await waveContract.getTotalWaves();

    let waveTxn = await waveContract.wave("A msg");
    await waveTxn.wait();

    waveTxn = await waveContract.wave("Another msg");
    await waveTxn.wait();
    
    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log("Contract Balance:", hre.ethers.utils.formatEther(contractBalance));

    let allWaves = await waveContract.getAllWaves()
    console.log(allWaves)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });