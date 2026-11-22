#!/usr/bin/env bash
set -euo pipefail
xcodebuild -version
git rev-parse HEAD
work="$(mktemp -d "${RUNNER_TEMP:-${TMPDIR:-/tmp}}/counter-pilot.XXXXXX")"
xcrun simctl list devices available -j > "$work/devices.json"
udid="$(python3 - "$work/devices.json" <<'PYTHON'
import json, sys
with open(sys.argv[1]) as f:
    devices = json.load(f)["devices"]
target = "com.apple.CoreSimulator.SimRuntime.iOS-18-5"
matches = [d["udid"] for d in devices.get(target, [])
           if d["name"] == "iPhone 16" and d.get("isAvailable", True)]
if len(matches) != 1:
    raise SystemExit(f"Expected one available iPhone 16 on iOS 18.5, found {len(matches)}")
print(matches[0])
PYTHON
)"
printf 'Simulator: iPhone 16 / iOS 18.5 (%s)\n' "$udid"
xcodebuild test -project CounterPilot.xcodeproj -scheme CounterPilot \
  -destination "platform=iOS Simulator,id=$udid" -parallel-testing-enabled NO \
  -derivedDataPath "$work/DerivedData" -resultBundlePath "$work/Tests.xcresult" \
  CODE_SIGNING_ALLOWED=NO
