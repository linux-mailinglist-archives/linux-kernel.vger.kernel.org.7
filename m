Return-Path: <linux-kernel+bounces-785275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD73B34871
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DB9188C580
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66A226E175;
	Mon, 25 Aug 2025 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3RDjmrg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F2B191F72
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756142226; cv=none; b=BzoVh2tiTrocie7fQpMGIVNaSGWvYEliDNE2YI9wOG8loP1hZCCjNFpvvbEhzuls66RaxX37SpRu6JCzV9Un0xGzndKKNHoxbC6CF4sq/F8Fw29G2PaTq+rgM8Tz+KdjIn6MtiAT+cf2MDSFUVE6V/sXtQwp5Omu9HYRkYMQ9gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756142226; c=relaxed/simple;
	bh=NMkfxo5MQkD4PnFu+/zJpUR7eCzzYYERGDUwOfhnTaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GYI7aoHgJ9g1jU+lcuCN0bQ+XLw7TMjZfpHrSRBQ0DWmV32WFQnRhqAxT1HmTQSVG4LUPbrcVudsibpy4ziYYB/TzcQXQ9PbtCRX9ulyMaby7+XvawNfz1clXENF7Nnpd3cbduzQVuk7NUh4SZTwdgWL/cq8gv904pRX7pZa3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3RDjmrg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756142224; x=1787678224;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NMkfxo5MQkD4PnFu+/zJpUR7eCzzYYERGDUwOfhnTaM=;
  b=X3RDjmrg/dsludx013TdH4x5Q2iFbDP/Log8ULxtqrQ8FtQJ09XT2GCW
   IrI0JIKHEhXtsfffgNDqAlmblxRjfdEL+NSXHSzvGKNNtzkwvExvA6cyR
   gS12cORkTXR2hZMfoR/dgEtXK8E6JNIw0AtqxuPM45lcx/zlRH8GoKNZh
   OolEkSl5ASc42/aX1BaPHKnnII+p47dHYlQW6K4wT6w+6DvaJI8N97Ef7
   w5p3hBwqPaCAaEnOYEMjGV8e2wBaNJmXvvjBXZUBSfLpUJgtZdAIOPI/g
   6QCHNIZCb4HxqzOGj0H6ECHoRqIMQW9nU7pDiT9edKb9SLh1tHoY4SVp8
   Q==;
X-CSE-ConnectionGUID: IyDARp+bRpSh4r6KOm2DDw==
X-CSE-MsgGUID: 1oMcafGaTmeNVZ5IXZL0rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="69735750"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="69735750"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 10:17:03 -0700
X-CSE-ConnectionGUID: XDF08hV4TM+LVIBNa6ORTg==
X-CSE-MsgGUID: wXiPNtoCQJ+JGN/sXqORKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="173748564"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 25 Aug 2025 10:17:02 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
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
Subject: [PATCH v3] scripts/x86/intel: Add a script to update the minimum ucode revisions
Date: Mon, 25 Aug 2025 10:15:10 -0700
Message-ID: <20250825171510.3332029-1-sohil.mehta@intel.com>
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
these revisions are flagged with X86_BUG_OLD_MICROCODE.

The static list of microcode revisions needs to be updated periodically
in response to releases of the official microcode at:
https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files.git.

Introduce a simple script to extract the revision information from the
microcode files and print it in the precise format expected by the
microcode header. Having the script in the kernel mainly makes it easier
to update the header whenever needed.

Typically, someone at Intel would see a new public release, run this
script, refresh the intel-ucode-defs.h file and send a patch upstream to
update the mainline and stable versions.

Originally-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v3:
 - Include motivation for having the script in the kernel. (Boris)
 - Update instructions to clarify typical usage. (Boris)

v2: https://lore.kernel.org/lkml/20250822004422.2908427-1-sohil.mehta@intel.com/
 - Remove the extra command line arguments. (DaveH)
 - Print to stdout instead of directly updating the header file. (DaveH)
 - Take multiple directories as input. (DaveH)
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
index 000000000000..14954e5e33c2
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
+This script is intended to be run in response to releases of the
+official Intel microcode GitHub repository:
+https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files.git
+
+It takes the Intel microcode files as input and uses iucode-tool to
+extract the revision information. It prints the output in the format
+expected by intel-ucode-defs.h.
+
+Usage:
+    ./{script} /path/to/microcode/files > /path/to/intel-ucode-defs.h
+
+Typically, someone at Intel would see a new release, run this script,
+refresh the intel-ucode-defs.h file, and send a patch upstream to update
+the mainline and stable versions.
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


