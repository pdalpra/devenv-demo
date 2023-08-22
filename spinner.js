import ora from 'ora';

const spinner = ora('Compiling Scala, come back in 10 minutes....').start();

setTimeout(() => {
	spinner.stop();
	console.log('Too fast to be true 🤣');
}, 5000);
