package res.audio;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;

public class Resampler {

	private final String sample;

	public Resampler(String sample) {
		this.sample = sample;
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
		}
		
		
	}

	public static void main(String[] args) {
		if (args.length < 2) {
			throw new IllegalArgumentException();
		}
		File directory = new File(args[0]);
		String sample = args[1];
		if (directory.isDirectory()) {
			
		} else {
			throw new IllegalArgumentException(directory + "is not a directory");
		}
		File[] files = directory.listFiles(new FilenameFilter() {
			
			@Override
			public boolean accept(File dir, String name) {
				return name.endsWith(".flac");
			}
		});
		if (files.length == 0) {
			System.err.println("No flac files in " + directory);
			System.exit(0);
		}
		
		Resampler worker = new Resampler(sample);
		for (File file : files) {
			worker.processFile(file);
		}
	}

}
