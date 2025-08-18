Return-Path: <linux-kernel+bounces-774337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF597B2B126
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC011884109
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC543451C8;
	Mon, 18 Aug 2025 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DxgA3ZmC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123733451A6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543816; cv=none; b=Xkd1YTzxtYtP7BT6iTTUcBSJhP8rnNL9MQ8JXuJtgV8uAuEaFXnhjYDByhB4snFtL0MuU1AWsPTM3oGRgWF63xZ6mgcsA9vXUrUuktrxRcJ1MRHA1PKM4bTgUSoIOxgtPwejMvUGjvP5Djc9Kbza+t19Z4RwjiXgab8HPiW/k34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543816; c=relaxed/simple;
	bh=nWAi9mZaJnQiV7bC6UcDB0A7F/QRiXVKaGN8aEOZeJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QK5Y34MyU+9N7GkWcpZWSGSFpoRlitou/E8wumMR1VS3RQC70IGpIHYSV4oewYrraPHGB0FI/ZJEolIiEkQPMMd322FbKetmGPAbxkh3IczW9SXsgy76OJ0nx6toV4/PK4/eq6lKBjQUQBq/O3ZanA8Y1PyjdUpeV/f6cVvTWwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DxgA3ZmC; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755543814; x=1787079814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nWAi9mZaJnQiV7bC6UcDB0A7F/QRiXVKaGN8aEOZeJI=;
  b=DxgA3ZmCO/W3KpdMykC3y+ER590L7qWNvJ5ThYa//OXms03lvY534Nq5
   jKWrRICHWRoXL9GyAhi0/7n1r/d+ybd3fAqcPRStZmXu3dTNPKNu5N1LS
   HMKpv1UfsgwZEATSYOnf5RrlomwvVuSaoUsw43C0ytbKyQB00boUwfu3y
   SSH6WVe35dgwy+Mdnr8WvQqx9wk9lXVzGUZ7ixyax9fWuEM4fHnEvnLHD
   xpvpKsWAf72uoBKip2KPXB9pRpcESazxPnAZsb9hC56EkAfiYs8DYDpvm
   LcwO3/tWQ+pJn17dImJRU9/j6F6rVvd0t/J9J5MwBhpgHVPUSoNcJHSlT
   A==;
X-CSE-ConnectionGUID: LSCUmTx+RhSqd65daDYfJw==
X-CSE-MsgGUID: bDR3WQYmQ2WAG5st4dzBOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="69151596"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="69151596"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 12:03:32 -0700
X-CSE-ConnectionGUID: TgqeFxkOQEeCk6ipomBcrQ==
X-CSE-MsgGUID: 6Vq3CypeT/iLexlkHbBKjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="171890592"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa003.jf.intel.com with ESMTP; 18 Aug 2025 12:03:31 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Alex Murray <alex.murray@canonical.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scripts/x86: Add a script to update minimum Intel ucode revisions
Date: Mon, 18 Aug 2025 12:01:37 -0700
Message-ID: <20250818190137.3525414-3-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818190137.3525414-1-sohil.mehta@intel.com>
References: <20250818190137.3525414-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel keeps a table of the minimum expected microcode revisions for
Intel CPUs at intel-ucode-defs.h. Systems with microcode older those are
marked with X86_BUG_OLD_MICROCODE. For more details, see
Documentation/admin-guide/hw-vuln/old_microcode.rst.

Add a simple script to keep the header file up-to-date based on released
microcode updates.

Originally-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 MAINTAINERS                        |   1 +
 scripts/update-intel-ucode-defs.py | 134 +++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+)
 create mode 100755 scripts/update-intel-ucode-defs.py

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf..a819559ec672 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27260,6 +27260,7 @@ S:	Maintained
 F:	Documentation/admin-guide/hw-vuln/
 F:	arch/x86/include/asm/nospec-branch.h
 F:	arch/x86/kernel/cpu/bugs.c
+F:	scripts/update-intel-ucode-defs.py
 
 X86 MCE INFRASTRUCTURE
 M:	Tony Luck <tony.luck@intel.com>
diff --git a/scripts/update-intel-ucode-defs.py b/scripts/update-intel-ucode-defs.py
new file mode 100755
index 000000000000..b8248f023cce
--- /dev/null
+++ b/scripts/update-intel-ucode-defs.py
@@ -0,0 +1,134 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0
+import argparse
+import re
+import shutil
+import subprocess
+import sys
+import os
+
+script = os.path.relpath(__file__)
+
+DESCRIPTION = f"""
+For Intel CPUs, update the microcode revisions that determine
+X86_BUG_OLD_MICROCODE.
+
+The script takes the Intel microcode files as input and uses the
+iucode-tool to extract the revision information. It formats the output
+and writes it to intel-ucode-defs.h which holds the minimum expected
+revision for each family-model-stepping.
+
+A typical usage is to get the desired release of the Intel Microcode
+Update Package at:
+https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files.git
+
+And run:
+    ./{script} -u /path/to/microcode/files
+
+Note: The microcode revisions are usually updated shortly after a new
+microcode package is released, allowing a reasonable time for systems to
+get the update.
+"""
+
+# Get the path to the microcode header defines
+script_path = os.path.abspath(sys.argv[0])
+linux_root = os.path.dirname(os.path.dirname(script_path))
+ucode_hdr = os.path.join(linux_root, 'arch/x86/kernel/cpu/microcode/intel-ucode-defs.h')
+
+parser = argparse.ArgumentParser(description=DESCRIPTION,
+                                 formatter_class=argparse.RawDescriptionHelpFormatter)
+parser.add_argument('-u','--ucode_path', required=True,
+                    help='Path to the microcode files')
+parser.add_argument('-o','--output', dest='header', default=ucode_hdr,
+                    help='The microcode header file to be updated (default: intel-ucode-defs.h)')
+
+args = parser.parse_args()
+
+# Process the microcode files using iucode-tool
+if shutil.which("iucode-tool") is None:
+    print("Error: iucode-tool not found, please install it")
+    sys.exit(1)
+
+cmd = ['iucode-tool', '--list-all' ]
+cmd.append(args.ucode_path)
+
+process = subprocess.Popen(cmd, stdout=subprocess.PIPE, universal_newlines=True)
+process.wait()
+if process.returncode != 0:
+    print("Error: iucode-tool ran into an error, exiting")
+    sys.exit(1)
+
+# Functions to extract family, model, and stepping
+def bits(val, bottom, top):
+    mask = (1 << (top + 1 - bottom)) - 1
+    mask = mask << bottom
+    return (val & mask) >> bottom
+
+def family(sig):
+    if bits(sig, 8, 11) == 0xf:
+        return bits(sig, 8, 11) + bits(sig, 20, 27)
+    return bits(sig, 8, 11)
+
+def model(sig):
+    return bits(sig, 4, 7)  | (bits(sig, 16, 19) << 4)
+
+def step(sig):
+    return bits(sig, 0, 3)
+
+# Parse the output of iucode-tool
+siglist = []
+for line in process.stdout:
+    if line.find(" sig ") == -1:
+        continue
+    sig = re.search('sig (0x[0-9a-fA-F]+)', line).group(1)
+    rev = re.search('rev (0x[0-9a-fA-F]+)', line).group(1)
+    sig = int(sig, 16)
+    rev = int(rev, 16)
+    debug_rev = bits(rev, 31, 31)
+    if debug_rev != 0:
+        print("Error: Debug ucode file found, exiting")
+        sys.exit(1);
+
+    sigrev = {}
+    sigrev['sig'] = sig
+    sigrev['rev'] = rev
+    siglist = siglist + [ sigrev ]
+
+# Remove duplicates, if any
+sigdict = {}
+for sr in siglist:
+    existing = sigdict.get(sr['sig'])
+    if existing != None:
+        # If the existing one is newer, just move on:
+        if existing['rev'] > sr['rev']:
+            continue
+    sigdict[sr['sig']] = sr
+
+# Prepare and sort the microcode entries
+ucode_entries = []
+for sig in sigdict:
+    rev = sigdict[sig]
+    ucode_entries.append({
+        'family': family(sig),
+        'model': model(sig),
+        'steppings': 1 << step(sig),
+        'rev': rev['rev'],
+        'sig': sig
+    })
+
+if not ucode_entries:
+    print("Error: No valid microcode files found, exiting")
+    sys.exit(1)
+
+ucode_entries.sort(key=lambda x: (x['family'], x['model'], x['steppings']))
+
+# Update the microcode header file
+header_path = args.header
+if not os.path.exists(header_path):
+    print(f"Error: '{header_path}' does not exist, use the '-o' option to specify a file to update")
+    sys.exit(1)
+
+with open(header_path, "w") as f:
+    for entry in ucode_entries:
+        f.write("{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x%x,  .model = 0x%02x, .steppings = 0x%04x, .driver_data = 0x%x },\n" %
+                (entry['family'], entry['model'], entry['steppings'], entry['rev']))
-- 
2.43.0


