#!/usr/bin/env python3
"""
Script to create a slim version of kanjidict2.json.

This script:
1. Reads all words from the N3Kanji SQLite database (word table, word column)
2. Extracts unique kanji characters from those words
3. Filters kanjidict2.json to only include those kanji
4. Keeps only the fields actually used by the app: meanings, onyomi, kunyomi
5. Outputs a slim JSON file with minimal data

Usage:
    python scripts/slim_kanjidict.py
"""

import json
import sqlite3
import unicodedata
from pathlib import Path


def is_kanji(char: str) -> bool:
    """Check if a character is a CJK ideograph (kanji)."""
    try:
        name = unicodedata.name(char, "")
        return "CJK UNIFIED IDEOGRAPH" in name
    except ValueError:
        return False


def extract_kanji_from_words(db_path: Path) -> set[str]:
    """Extract all unique kanji characters from the word column in the database."""
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    cursor.execute("SELECT DISTINCT word FROM word WHERE word IS NOT NULL AND word != ''")
    words = cursor.fetchall()
    conn.close()
    
    kanji_set = set()
    for (word,) in words:
        for char in word:
            if is_kanji(char):
                kanji_set.add(char)
    
    return kanji_set


def as_string_list(value) -> list[str]:
    """Convert a value to a list of strings, handling N/A and other edge cases."""
    if value is None:
        return []
    if isinstance(value, str):
        s = value.strip()
        if not s or s in ("N/A", "N/A ", " N/A", " N/A "):
            return []
        return [s]
    if isinstance(value, list):
        return [
            e.strip() for e in value
            if isinstance(e, str) and e.strip() and e.strip() != "N/A"
        ]
    return []


def create_slim_dict(full_dict: dict, needed_kanji: set[str]) -> dict:
    """
    Create a slim dictionary with only needed kanji and minimal fields.
    
    The app uses these field names (from kanjidic2_service.dart):
    - meanings (or meaning)
    - on (or onyomi)  
    - kun (or kunyomi)
    
    We'll use the shorter field names for the slim version.
    """
    slim = {}
    
    for kanji, data in full_dict.items():
        if kanji not in needed_kanji:
            continue
        
        # Extract meanings - try both field names
        meanings = as_string_list(data.get("meanings")) or as_string_list(data.get("meaning"))
        
        # Extract onyomi - try both field names
        onyomi = as_string_list(data.get("on")) or as_string_list(data.get("onyomi"))
        
        # Extract kunyomi - try both field names
        kunyomi = as_string_list(data.get("kun")) or as_string_list(data.get("kunyomi"))
        
        # Only include if there's at least some data
        entry = {}
        if meanings:
            entry["meaning"] = meanings
        if onyomi:
            entry["onyomi"] = onyomi
        if kunyomi:
            entry["kunyomi"] = kunyomi
        
        if entry:  # Only add if there's at least one field
            slim[kanji] = entry
    
    return slim


def main():
    # Paths
    script_dir = Path(__file__).parent
    project_root = script_dir.parent
    assets_dir = project_root / "assets"
    
    db_path = assets_dir / "N3Kanji"
    full_json_path = assets_dir / "kanjidict2.json"
    slim_json_path = assets_dir / "kanjidict2_slim.json"
    
    # Validate paths
    if not db_path.exists():
        print(f"Error: Database not found at {db_path}")
        return 1
    
    if not full_json_path.exists():
        print(f"Error: Full kanji dictionary not found at {full_json_path}")
        return 1
    
    # Step 1: Extract kanji from database
    print("Extracting kanji from database...")
    needed_kanji = extract_kanji_from_words(db_path)
    print(f"  Found {len(needed_kanji)} unique kanji in word table")
    
    # Step 2: Load full dictionary
    print("Loading full kanji dictionary...")
    with open(full_json_path, "r", encoding="utf-8") as f:
        full_dict = json.load(f)
    print(f"  Full dictionary has {len(full_dict)} entries")
    
    # Step 3: Create slim dictionary
    print("Creating slim dictionary...")
    slim_dict = create_slim_dict(full_dict, needed_kanji)
    print(f"  Slim dictionary has {len(slim_dict)} entries")
    
    # Check for missing kanji
    found_kanji = set(slim_dict.keys())
    missing_kanji = needed_kanji - found_kanji
    if missing_kanji:
        print(f"  Warning: {len(missing_kanji)} kanji not found in dictionary: {sorted(missing_kanji)}")
    
    # Step 4: Save slim dictionary
    print(f"Saving slim dictionary to {slim_json_path}...")
    with open(slim_json_path, "w", encoding="utf-8") as f:
        json.dump(slim_dict, f, ensure_ascii=False, separators=(",", ":"))
    
    # Report size reduction
    full_size = full_json_path.stat().st_size
    slim_size = slim_json_path.stat().st_size
    reduction = (1 - slim_size / full_size) * 100
    
    print(f"\nSize comparison:")
    print(f"  Original: {full_size:,} bytes ({full_size / 1024:.1f} KB)")
    print(f"  Slim:     {slim_size:,} bytes ({slim_size / 1024:.1f} KB)")
    print(f"  Reduction: {reduction:.1f}%")
    
    print(f"\nDone! Slim dictionary saved to: {slim_json_path}")
    print("\nTo use the slim version, update kanjidic2_service.dart to load 'assets/kanjidict2_slim.json'")
    
    return 0


if __name__ == "__main__":
    exit(main())
