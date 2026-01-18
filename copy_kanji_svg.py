#!/usr/bin/env python3
"""
Script to copy kanjivg SVG files based on kanji characters used in N3Kanji database.
Only copies SVG files that are actually needed to reduce assets size.
"""

import sqlite3
import os
import shutil
from pathlib import Path

def kanji_to_codepoint(kanji_char):
    """Convert a single kanji character to its Unicode code point in hex format."""
    return f"{ord(kanji_char):05x}"

def extract_kanji_from_database(db_path):
    """Extract all unique kanji characters from the word column in the database."""
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    # Get all words from the word table
    cursor.execute("SELECT DISTINCT word FROM word")
    words = cursor.fetchall()
    
    # Extract unique kanji characters
    kanji_set = set()
    for (word,) in words:
        for char in word:
            # Check if the character is a kanji (CJK Unified Ideographs)
            code_point = ord(char)
            if (0x4E00 <= code_point <= 0x9FFF or  # CJK Unified Ideographs
                0x3400 <= code_point <= 0x4DBF or  # CJK Unified Ideographs Extension A
                0x20000 <= code_point <= 0x2A6DF or  # CJK Unified Ideographs Extension B
                0x2A700 <= code_point <= 0x2B73F or  # CJK Unified Ideographs Extension C
                0x2B740 <= code_point <= 0x2B81F or  # CJK Unified Ideographs Extension D
                0x2B820 <= code_point <= 0x2CEAF or  # CJK Unified Ideographs Extension E
                0x2CEB0 <= code_point <= 0x2EBEF):    # CJK Unified Ideographs Extension F
                kanji_set.add(char)
    
    conn.close()
    return kanji_set

def copy_needed_svg_files(kanji_set, source_dir, dest_dir):
    """Copy SVG files for the needed kanji characters."""
    source_path = Path(source_dir)
    dest_path = Path(dest_dir)
    
    # Create destination directory if it doesn't exist
    dest_path.mkdir(parents=True, exist_ok=True)
    
    copied_count = 0
    missing_count = 0
    
    for kanji in sorted(kanji_set):
        codepoint = kanji_to_codepoint(kanji)
        svg_filename = f"{codepoint}.svg"
        source_file = source_path / svg_filename
        dest_file = dest_path / svg_filename
        
        if source_file.exists():
            shutil.copy2(source_file, dest_file)
            copied_count += 1
            print(f"Copied: {svg_filename} ({kanji})")
        else:
            missing_count += 1
            print(f"Missing: {svg_filename} ({kanji})")
    
    return copied_count, missing_count

def main():
    # Paths
    db_path = "/Users/naymyohtet/Workspace/personal-endeavor/N3Kanji/assets/N3Kanji"
    source_dir = "/Users/naymyohtet/Workspace/personal-endeavor/N3Kanji/assets/kanji"
    dest_dir = "/Users/naymyohtet/Workspace/personal-endeavor/N3Kanji/assets/kanjivg"
    
    print("Extracting kanji characters from database...")
    kanji_set = extract_kanji_from_database(db_path)
    print(f"Found {len(kanji_set)} unique kanji characters")
    
    print("Copying needed SVG files...")
    copied, missing = copy_needed_svg_files(kanji_set, source_dir, dest_dir)
    
    print(f"\nSummary:")
    print(f"- Total unique kanji found: {len(kanji_set)}")
    print(f"- SVG files copied: {copied}")
    print(f"- SVG files missing: {missing}")
    print(f"- Destination directory: {dest_dir}")

if __name__ == "__main__":
    main()
