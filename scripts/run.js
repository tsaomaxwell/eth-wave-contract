async function main() {
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
    console.log("Contract deployed to:", waveContract.address);

    let waveCount;
    waveCount = await waveContract.getTotalWaves();

    let waveTxn = await waveContract.wave("A msg");
    await waveTxn.wait();

    waveTxn = await waveContract.wave("Another msg");
    await waveTxn.wait();
    
    let allWaves = await waveContract.getAllWaves()
    console.log(allWaves)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });