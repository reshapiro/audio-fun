package res.audio;

import java.io.File;
import java.io.FileWriter;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class MetaflacInit {

	/**
	 * Initialize flac metadata for given directories
	 * @param args one arg, the name of the directory containing flac files.
	 */
	
	private enum TAG_NAMES {
		ALBUM,
		TRACKNUMBER,
		TRACKTOTAL,
		TITLE;
		void put(List<String> tags, String value) {
			tags.add(name() + "=" + value);
		}
	}
	private final File directory;
	private final List<String> tags = new ArrayList<>();
	private int index;
	
	MetaflacInit(String path) {
		directory = new File(path);
	}
	
	private List<String> processDirectory() {
		if (!directory.isDirectory()) {
			fail(directory + " is not a directory");
			return tags;
		}
		TAG_NAMES.ALBUM.put(tags, directory.getName());
		
		String[] files = directory.list(new FilenameFilter() {
			@Override
			public boolean accept(File dir, String name) {
				return name.endsWith(".flac");
			}
		});
		
		if (files != null) {
			for (String filename : files) {
				int dot = filename.indexOf('.');
				String name = filename.substring(0, dot);
				addTrack(name);
			}
		}
	
		TAG_NAMES.TRACKTOTAL.put(tags, Integer.toString(index));
		return tags;
	}

	private void addTrack(String name) {
		TAG_NAMES.TRACKNUMBER.put(tags, Integer.toString(++index));
		TAG_NAMES.TITLE.put(tags, name);
	}

	public static void main(String[] args) {
		if (args.length < 2) {
			fail("A directory and output file must be provided");
		}
		
		String directory = args[0];
		String outputFile = args[1];
		MetaflacInit metaflacInit = new MetaflacInit(directory);
		List<String> tags = metaflacInit.processDirectory();
		
		try (PrintWriter writer = new PrintWriter(new FileWriter(outputFile))) {
			for (String tag : tags) {
				writer.println(tag);
			}
			System.out.println("Wrote metaflac file to " + outputFile);
		} catch (IOException e) {
			fail("Failed to write results to " + outputFile +  ":" + e.getMessage());
		}
		
		

	}
	
	private static void fail(String message) {
		System.err.println(message);
		System.exit(-1);
	}

}
