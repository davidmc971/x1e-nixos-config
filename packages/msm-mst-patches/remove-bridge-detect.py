import re, sys

f = sys.argv[1]
src = open(f).read()

pattern = (
    r'/\*\*\n'
    r' \* msm_dp_bridge_detect - callback to determine if connector is connected\n'
    r' \* @bridge: Pointer to drm bridge structure\n'
    r' \* @connector: Pointer to drm connector structure\n'
    r' \* Returns: Bridge\'s \'is connected\' status\n'
    r' \*/\n'
    r'static enum drm_connector_status\n'
    r'msm_dp_bridge_detect\(struct drm_bridge \*bridge, struct drm_connector \*connector\)\n'
    r'\{.*?\}\n\n'
)

src = re.sub(pattern, '', src, flags=re.DOTALL)
open(f, 'w').write(src)
print("Done")
