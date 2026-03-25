#!/bin/bash

# 1. Define Paths
BASE_DIR="$HOME/AI_Projects/Board_Brief"
DATE_SUFFIX=$(date +%m%d%Y)
NEW_FILENAME="Board_Brief_$DATE_SUFFIX.md"
mkdir -p "$BASE_DIR"

# 2. File Check & Generation Logic
LATEST_MD=$(ls -t "$BASE_DIR"/Board_Brief_*.md 2>/dev/null | head -1)

if [ -z "$LATEST_MD" ]; then
    echo "Creating fresh base file: $NEW_FILENAME"
    cat <<EOF > "$BASE_DIR/$NEW_FILENAME"
# Board Brief: $DATE_SUFFIX
[Institutional Context: Red Rocks Credit Union]
* Founded 1979; legacy ties to Lockheed Martin[cite: 1746, 1840].
* Asset Size: ~$352.1M as of Feb 2026.
* Net Worth Ratio: 9.33%.

## Executive Summary: February 2026
* February closed with a net loss of \$37K.
* Loans increased \$10.9M via participation purchases[cite: 11, 16].
* \$4.4M unsecured pool purchased at 11.43% weighted average rate.

## Policy & Governance Updates
* Board Compensation (#1090): Initial pay at \$2,000/month.
* Inactive Purge: ~4,500 memberships identified for closure[cite: 1988, 1998].
* Cybersecurity: Target 'Evolving' maturity via NCUA ACET tool for 2026[cite: 1897, 1898].
EOF
    LATEST_MD="$BASE_DIR/$NEW_FILENAME"
else
    if [ ! -f "$BASE_DIR/$NEW_FILENAME" ]; then
        echo "Copying prior brief to new date..."
        cp "$LATEST_MD" "$BASE_DIR/$NEW_FILENAME"
    fi
    LATEST_MD="$BASE_DIR/$NEW_FILENAME"
fi

# 3. Folder Mapping (Year/Month)
MONTH_NUM=$(date +%m)
MONTH_NAME=$(date +%B)
YEAR_NUM=$(date +%Y)
DEST_DIR="$BASE_DIR/$YEAR_NUM/${MONTH_NUM}_$MONTH_NAME"
mkdir -p "$DEST_DIR"

# 4. Generate Human-Readable .txt File
TXT_FILENAME=$(basename "$LATEST_MD" .md).txt
cp "$LATEST_MD" "$DEST_DIR/$TXT_FILENAME"

echo "------------------------------------------------"
echo "Success! Human-readable brief saved to:"
echo "$DEST_DIR/$TXT_FILENAME"
echo "------------------------------------------------"