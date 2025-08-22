Return-Path: <linux-kernel+bounces-780878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1956B30A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 02:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811771C81348
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3497F3594E;
	Fri, 22 Aug 2025 00:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arjedX3X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1588139E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 00:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755823587; cv=none; b=u0IBPYjvN2LO/KvA56zlkVv268HUAbYF3QUkB/xwNTK9puc8cFjum6Q+LZnBdkgist0xNyMu03gHswpTivVnawkxe0onERInNnW/ha0a3crFd5UFFspn6wfQmgbETdtUUrq0SZIRmvBz3AWEPnSC9BkxwLgCQ8jNYHZ4vkGqS/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755823587; c=relaxed/simple;
	bh=AyuZ+POIzx5Uu2DT9J+ItP+lp/B8Uaqi05bxyQMe+AI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XWSrfHre7UD70ZzRDPM5A72DySAammxTLNjLOiigyi1/K6DW0dUBdfbqW5Fh9HIwN4ZZ1gmLx/sQHpS6Sov+CB+YI+N4qon+TShKjaJik16btB1rAITt0c1W+K2t6E3J9pem0bc4bTR9qM2GkpV3EqetD2xNZ/XMB2FBdCekbew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arjedX3X; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755823585; x=1787359585;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AyuZ+POIzx5Uu2DT9J+ItP+lp/B8Uaqi05bxyQMe+AI=;
  b=arjedX3XlpKgMqHrT5o/NtH+Y7Gpjnhc2fkZqYHoHbhtAg+LQVXfwNIm
   b59qMQNzC2/4nrdGeHsBLVmQmuSlyUpbIlidwuLUNSUdNG3Ic7x4WfJQZ
   nj13Cpd+Fj1hDkbRZuhfG1Afed7QqbOnyycBU1REuihzdxdtml16RPmxR
   K3PY4gV03TxgXrNXU48PwIHB8n51WeBf1UEFjoNAvaH+dB+DxfubKTTfO
   oWavTYBJu0+m/r2DIywDU55X9UYx8n0qqdLdp4ZRWtV6Jc9yn9EruOzIh
   4SQ10YgU7aH91v0/CzNoEJIFEFbi4htmqQyBly7lPFOopfvvC2xkouOFu
   Q==;
X-CSE-ConnectionGUID: HhkpXNapSdS60ruVdLjU0g==
X-CSE-MsgGUID: LAVhwp4oSzeaDxR1tbfCJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61773543"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="61773543"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 17:46:25 -0700
X-CSE-ConnectionGUID: bY5Xa+bmRh6XLRPPSNYYOw==
X-CSE-MsgGUID: lAZqqa/wRHOZ1mCJZEhtKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="172757255"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa003.jf.intel.com with ESMTP; 21 Aug 2025 17:46:25 -0700
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
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] scripts/x86/intel: Add a script to update the minimum ucode revisions
Date: Thu, 21 Aug 2025 17:44:22 -0700
Message-ID: <20250822004422.2908427-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel maintains a table of minimum expected microcode revisions for
Intel CPUs in intel-ucode-defs.h. Systems with microcode older than
these revisions are flagged with X86_BUG_OLD_MICROCODE. For more
details, refer to Documentation/admin-guide/hw-vuln/old_microcode.rst.

Add a simple script to keep the header file up-to-date based on released
microcode updates.

Originally-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v2:
 - Remove the extra command line arguments.
 - Print to stdout instead of directly updating the header file.
 - Take multiple directories as input.

v1: https://lore.kernel.org/lkml/20250818190137.3525414-1-sohil.mehta@intel.com/
---
 MAINTAINERS                        |   1 +
 scripts/update-intel-ucode-defs.py | 118 +++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)
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
index 000000000000..96e91640033a
--- /dev/null
+++ b/scripts/update-intel-ucode-defs.py
@@ -0,0 +1,118 @@
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
+iucode-tool to extract the revision information. It prints the output in
+the format expected by intel-ucode-defs.h.
+
+A typical usage is to get the desired release of the Intel Microcode
+Update Package at:
+https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files.git
+
+And run:
+    ./{script} /path/to/microcode/files > /path/to/intel-ucode-defs.h
+
+Note: The microcode revisions are usually updated shortly after a new
+microcode package is released, allowing a reasonable time for systems to
+get the update.
+"""
+
+parser = argparse.ArgumentParser(description=DESCRIPTION,
+                                 formatter_class=argparse.RawDescriptionHelpFormatter)
+parser.add_argument('ucode_files', nargs='+', help='Path(s) to the microcode files')
+
+args = parser.parse_args()
+
+# Process the microcode files using iucode-tool
+if shutil.which("iucode-tool") is None:
+    print("Error: iucode-tool not found, please install it", file=sys.stderr)
+    sys.exit(1)
+
+cmd = ['iucode-tool', '--list-all' ]
+cmd.extend(args.ucode_files)
+
+process = subprocess.Popen(cmd, stdout=subprocess.PIPE, universal_newlines=True)
+process.wait()
+if process.returncode != 0:
+    print("Error: iucode-tool ran into an error, exiting", file=sys.stderr)
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
+        print("Error: Debug ucode file found, exiting", file=sys.stderr)
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
+# Prepare the microcode entries
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
+    print("Error: No valid microcode files found, exiting", file=sys.stderr)
+    sys.exit(1)
+
+# Sort and print the microcode entries
+ucode_entries.sort(key=lambda x: (x['family'], x['model'], x['steppings']))
+for entry in ucode_entries:
+    print("{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x%x,  .model = 0x%02x, .steppings = 0x%04x, .driver_data = 0x%x }," %
+          (entry['family'], entry['model'], entry['steppings'], entry['rev']))
-- 
2.43.0


