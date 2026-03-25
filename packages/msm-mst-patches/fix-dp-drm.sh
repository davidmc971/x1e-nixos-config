#!/usr/bin/env bash
# Normalize dp_drm.c and dp_drm.h for HPD v2 patch 3 application
set -e
DIR="$1"
FILE="$DIR/drivers/gpu/drm/msm/dp/dp_drm.c"
HEADER="$DIR/drivers/gpu/drm/msm/dp/dp_drm.h"

# 1. Remove the two-arg msm_dp_bridge_detect function body from dp_drm.c
perl -i -0pe 's|\n/\*\*\n \* msm_dp_bridge_detect[^\n]*\n \* \@bridge[^\n]*\n \* \@connector[^\n]*\n \* Returns[^\n]*\n \*/\nstatic enum drm_connector_status\nmsm_dp_bridge_detect\([^\)]*\)\n\{[^}]*\}\n||s' "$FILE"

# 2. Remove .detect entry from bridge ops
sed -i '/^\t\.detect.*=.*msm_dp_bridge_detect,$/d' "$FILE"

echo "Done: dp_drm.c normalized"
grep -n "msm_dp_bridge_detect" "$FILE" || echo "  (no remaining references in dp_drm.c)"
