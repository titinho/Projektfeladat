import pandas as pd
from pathlib import Path

RAW_DIR: Path = Path("../../data/raw/bux")
PROCESSED_DIR: Path = Path("../../data/processed")

def load_data(raw_dir: Path)-> pd.DataFrame:
    dfs:list[pd.DataFrame] = []
    for file in raw_dir.glob("*.csv"):
        df = pd.read_csv(file)
        dfs.append(df)
    return pd.concat(dfs, ignore_index=True)

def save_data(df: pd.DataFrame, output_file: Path):
    df.to_csv(PROCESSED_DIR/output_file, index=False)

def main():
    df = load_data(RAW_DIR)
    save_data(df, PROCESSED_DIR)

if __name__ == "__main__":
    main()
