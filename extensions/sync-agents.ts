/**
 * Auto-symlink agent definitions from this package into ~/.pi/agent/agents/
 *
 * On session_start, ensures each .md in our agents/ dir is symlinked into the
 * user agents directory so pi-subagents discovers them without manual copying.
 */

import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import * as fs from "node:fs";
import * as os from "node:os";
import * as path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const PACKAGE_AGENTS_DIR = path.join(__dirname, "..", "agents");
const USER_AGENTS_DIR = path.join(os.homedir(), ".pi", "agent", "agents");

export default function (pi: ExtensionAPI) {
	pi.on("session_start", async () => {
		fs.mkdirSync(USER_AGENTS_DIR, { recursive: true });

		let entries: fs.Dirent[];
		try {
			entries = fs.readdirSync(PACKAGE_AGENTS_DIR, { withFileTypes: true });
		} catch {
			return;
		}

		for (const entry of entries) {
			if (!entry.name.endsWith(".md")) continue;
			const src = path.join(PACKAGE_AGENTS_DIR, entry.name);
			const dest = path.join(USER_AGENTS_DIR, entry.name);

			try {
				const existing = fs.lstatSync(dest);
				if (existing.isSymbolicLink()) {
					const target = fs.readlinkSync(dest);
					if (path.resolve(path.dirname(dest), target) === src) continue;
					// Symlink points elsewhere — replace it
					fs.unlinkSync(dest);
				} else {
					// Regular file exists — don't overwrite user customizations
					continue;
				}
			} catch {
				// dest doesn't exist — proceed
			}

			fs.symlinkSync(src, dest);
		}
	});
}
