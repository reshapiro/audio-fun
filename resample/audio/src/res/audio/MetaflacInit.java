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
	 * Create flac metadata files for each flac file in a given directory.
	 * @param args one arg, the name of the directory containing flac files.
	 */
	
	private enum TAG_NAMES {
		ALBUM,
		TRACKNUMBER,
		TRACKTOTAL,
		TITLE;
		void print(String value, PrintWriter printer) {
			printer.println(name() + "=" + value);
		}
	}
	private final File flacDir;
	private final File metaFlacDir;
	private final int total;
	private final File[] flacFiles;
	private int index;
	private final List<String> otherValues = new ArrayList<>();
	
	MetaflacInit(String...args) {
		
		String flacDirPath = args[0];
		String metaFlacDirPath = args[1];
		for (int i=2; i< args.length; i++) {
			otherValues.add(args[i]);
		}
		
		metaFlacDir = new File(metaFlacDirPath);
		
		if (!metaFlacDir.isDirectory() && !metaFlacDir.mkdirs()) {
			fail(metaFlacDirPath + "does not exist and cannot be created");
		}
		
		this.flacDir = new File(flacDirPath);
		if (!flacDir.isDirectory()) {
			fail(flacDirPath + " is not a directory");
		}
		flacFiles = flacDir.listFiles(new FilenameFilter() {
			@Override
			public boolean accept(File dir, String name) {
				return name.endsWith(".flac");
			}
		});
		total = flacFiles != null ? flacFiles.length : 0;
		
	}
	
	private void processDirectory() {
		if (flacFiles != null) {
			for (File flacFile : flacFiles) {
				createMetaData(flacFile);
			}
		}
	}

	private void createMetaData(File flacFile) {
		String name = flacFile.getName();
		String title = name = name.substring(0, name.indexOf('.'));
		String metaFileName =  title + ".mfl";
		File metFlacFile = new File(metaFlacDir, metaFileName);
		
		try (PrintWriter writer = new PrintWriter(new FileWriter(metFlacFile))) {
			TAG_NAMES.ALBUM.print(flacDir.getName(), writer);
			TAG_NAMES.TRACKTOTAL.print(Integer.toString(total), writer);
			TAG_NAMES.TRACKNUMBER.print( Integer.toString(++index), writer);
			TAG_NAMES.TITLE.print(title, writer);
			addOtherValues(writer);
			
		} catch (IOException e) {
			fail(e.getMessage());
		}
		
	}

	private void addOtherValues(PrintWriter writer) {
		for (String value : otherValues) {
			writer.println(value);
		}
		
	}

	private static void fail(String message) {
		System.err.println(message);
		System.exit(-1);
	}

	/**
	 * 
	 * @param args two required args + any number of optional args
	 * arg1 should be the path to a directory of .flac files.
	 * arg2 should be a path to a directory for the genertated metadata.  This directory will be created if it doesn't already exist.
	 * 
	 * The remaining args should be name=value strings where the name is a  valid FLAC tag.
	 * If an optional value includes any spaces you must quote it: ARTIST="Ornette Coleman", not  ARTIST=Ornette Coleman
	 */
	public static void main(String[] args) {
		if (args.length < 2) {
			fail("A flac directory and metaflac file directory must be provided");
		}
		
		
		MetaflacInit metaflacInit = new MetaflacInit(args);
		
		metaflacInit.processDirectory();
	}

}
