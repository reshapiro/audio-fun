package res.audio;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;

public class Resampler {

	private final String sample;
	
	@SuppressWarnings("unused")
	/* will be used later */
	private final File outputDirectory;

	public Resampler(String sample, File outputDirectory) {
		this.sample = sample;
		this.outputDirectory = outputDirectory;
	}

	private void processFile(File file) {
		File parent = file.getParentFile();
		String baseName = file.getName().substring(0, file.getName().lastIndexOf('.'));
		
		flac2Wav(file);
		File wav = new File(parent, baseName + ".wav");
		
		System.err.println("wave file is " + wav);
		File resampled = new File(parent, baseName + "-resample.wav");
		resample(wav, resampled);
		wav2Flac(resampled);
		
	}

	private void wav2Flac(File wav) {
		ProcessBuilder  builder = new ProcessBuilder("/usr/local/bin/flac", wav.getAbsolutePath());
		try {
			Process process = builder.start();
			while (process.isAlive()) {
				Thread.sleep(100);
			}
		} catch (IOException e) {
			throw new RuntimeException(e);
		} catch (InterruptedException e) {
			/* interrupts are ok */
		}
		
	}

	private void resample(File wav, File file) {
		
		ProcessBuilder  builder = new ProcessBuilder("/usr/local/bin/sox", wav.getAbsolutePath(),  "-b", "16", file.getAbsolutePath(), "rate", "-s", "-a", sample, "dither", "-s");
		try {
			Process process = builder.start();
			while (process.isAlive()) {
				Thread.sleep(100);
			}
		} catch (IOException e) {
			throw new RuntimeException(e);
		} catch (InterruptedException e) {
			/* interrupts are ok */
		}
		
	}

	private void flac2Wav(File file) {
		ProcessBuilder  builder = new ProcessBuilder("/usr/local/bin/flac", "-d", "-f",  "--decode", file.getAbsolutePath());
		try {
			Process process = builder.start();
			while (process.isAlive()) {
				Thread.sleep(100);
			}
		} catch (IOException e) {
			throw new RuntimeException(e);
		} catch (InterruptedException e) {
			/* interrupts are ok */
		}
		
		
	}

	public static void main(String[] args) {
		if (args.length < 2) {
			throw new IllegalArgumentException();
		}
		File inputDirectory = new File(args[0]);
		String sample = args[1];
		
		
		File outputDirectory = null;
		
		if (args.length > 2) {
			outputDirectory = new File(args[2]);
			if (!outputDirectory.exists() && ! outputDirectory.mkdirs()) {
				throw new IllegalArgumentException("output directory" + outputDirectory + " does not exist and cannot be created");
			}
		}
		
		if (!inputDirectory.isDirectory()) {
			
			throw new IllegalArgumentException(inputDirectory + "is not a directory");
		}
			
		File[] files = inputDirectory.listFiles(new FilenameFilter() {
			
			@Override
			public boolean accept(File dir, String name) {
				return name.endsWith(".flac");
			}
		});
		if (files.length == 0) {
			System.err.println("No flac files in " + inputDirectory);
			System.exit(0);
		}
		
		Resampler worker = new Resampler(sample, outputDirectory);
		for (File file : files) {
			worker.processFile(file);
		}
	}

}
