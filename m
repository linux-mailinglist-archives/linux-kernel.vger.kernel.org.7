Return-Path: <linux-kernel+bounces-613026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F24CA956F6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 21:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C04D16F710
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 19:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0831B1EFF91;
	Mon, 21 Apr 2025 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cnFnJfB+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1B91A83FB
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745265422; cv=none; b=TpXRYi9ly7xCI6j+GEn/1g9qWhMGaxjMO6ssOuv/mtDtdSclIXn8SR1qeP9qghGAh3+19rIWuApMg8vbkhsqimKK4oPLsi2xGocyVIlI5aNd0ITGxSdUakNA3ACVWx70Jp7flpEieQfQnTXb2oxMvB0o8R1J3ReKAQkcgsjIRVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745265422; c=relaxed/simple;
	bh=iTwXORS3lI8IP5e/h6ZVpf5iABsZL3o3MpwYVBU9kz0=;
	h=Subject:To:Cc:From:Date:Message-Id; b=s9vC9vsxsRvg2tXZuzaV5JfqpX+prjxqwN4abVZNLwBSQA7huwFVj0OvrIQUL+Feb13xHWwQ+okA1X5Fr3u6SZ/7AnxAb003QP2wyy3xfM5EORKBFWRMKWNF8pdbLOhAaoF9kfNOBrwp5MdBVtmZUj//NtjmC3bwF843UY9T25I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cnFnJfB+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745265421; x=1776801421;
  h=subject:to:cc:from:date:message-id;
  bh=iTwXORS3lI8IP5e/h6ZVpf5iABsZL3o3MpwYVBU9kz0=;
  b=cnFnJfB+36KkjM4xERuL9nGIKt1hZ+yHU+6fAJ3m6W51bZ0dUJdccP2s
   L0IVqvnUWZzXwZF09UgNNmFWKoAAYLyvJkzQU2/785BKysmofn6qiaa3o
   KEvCiwMfPjoAeqC7CEGftAGbl+x07OQ5Ba7P56mVR7MZ/9duMJfhPXLKa
   nCEQzyj12WEL/XzNBkYuj+jZdTsUFPqGXthUiXr0vL7kVCmkvGRlV8Q++
   /ILAQ2GgjuK2EgvLy64Q1KbaxPfTOGcn4SGh9qtcPS2glTEdpNMBAsZkf
   whZwNWjY2E4R1nyS6WCQbsDkXm0W/9Fx8YU/wZFRI9iezWHSCn5JLlxDG
   w==;
X-CSE-ConnectionGUID: 08qdEa4LSlO1nHWqnCYSjg==
X-CSE-MsgGUID: PYOQ25R7TpGaiTFPqNgg4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="58174931"
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="58174931"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 12:57:00 -0700
X-CSE-ConnectionGUID: 7pSHAeEsQ0SLmEWZUuFeZQ==
X-CSE-MsgGUID: G3pURwZFQk6Ds5jmA+U0eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="169016392"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa001.jf.intel.com with ESMTP; 21 Apr 2025 12:57:00 -0700
Subject: [PATCH] [v5] x86/cpu: Help users notice when running old Intel microcode
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, tglx@linutronix.de, bp@alien8.de, alex.murray@canonical.com, andrew.cooper3@citrix.com, Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Mon, 21 Apr 2025 12:56:59 -0700
Message-Id: <20250421195659.CF426C07@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>



Changes from v4:
 - Update list from commit: 8ac9378 microcode-20241112 Release

Changes from v3:
 - Update changelog and documentation to clarify behavior when
   microcode is updated at runtime.

Changes from v2:
 - Make cpu_latest_microcode[] static
 - Add a pr_info() when the CPU is not in the microcode version list

Changes from v1:
 - Flesh out changelog
 - Add Documentation/
 - add_taint() and pr_warn() in addition to vulnerabilities/ file
 - Add checks for running under VMMs. Do not taint and
   report vulnerability as unknown.

From: Dave Hansen <dave.hansen@linux.intel.com>

Old microcode is bad for users and for kernel developers.

For users, it exposes them to known fixed security and/or functional
issues. These obviously rarely result in instant dumpster fires in
every environment. But it is as important to keep your microcode up
to date as it is to keep your kernel up to date.

Old microcode also makes kernels harder to debug. A developer looking
at an oops need to consider kernel bugs, known CPU issues and unknown
CPU issues as possible causes. If they know the microcode is up to
date, they can mostly eliminate known CPU issues as the cause.

Make it easier to tell if CPU microcode is out of date. Add a list
of released microcode. If the loaded microcode is older than the
release, tell users in a place that folks can find it:

	/sys/devices/system/cpu/vulnerabilities/old_microcode

Tell kernel kernel developers about it with the existing taint
flag:

	TAINT_CPU_OUT_OF_SPEC

== Discussion ==

When a user reports a potential kernel issue, it is very common
to ask them to reproduce the issue on mainline. Running mainline,
they will (independently from the distro) acquire a more up-to-date
microcode version list. If their microcode is old, they will
get a warning about the taint and kernel developers can take that
into consideration when debugging.

Just like any other entry in "vulnerabilities/", users are free to
make their own assessment of their exposure.

== Microcode Revision Discussion ==

The microcode versions in the table were generated from the Intel
microcode git repo:

	8ac9378a8487 ("microcode-20241112 Release")

which as of this writing lags behind the latest microcode-20250211.

It can be argued that the versions that the kernel picks to call "old"
should be a revision or two old. Which specific version is picked is
less important to me than picking *a* version and enforcing it.

This repository contains only microcode versions that Intel has deemed
to be OS-loadable. It is quite possible that the BIOS has loaded a
newer microcode than the latest in this repo. If this happens, the
system is considered to have new microcode, not old.

Specifically, the sysfs file and taint flag answer the question:

	Is the CPU running on the latest OS-loadable microcode,
	or something even later that the BIOS loaded?

In other words, Intel never publishes an authoritative list of CPUs
and latest microcode revisions. Until it does, this is the best that
Linux can do.

Also note that the "intel-ucode-defs.h" file is simple, ugly and
has lots of magic numbers. That's on purpose and should allow a
single file to be shared across lots of stable kernel regardless of if
they have the new "VFM" infrastructure or not. It was generated with
a dumb script.

== FAQ ==

Q: Does this tell me if my system is secure or insecure?
A: No. It only tells you if your microcode was old when the
   system booted.

Q: Should the kernel warn if the microcode list itself is too old?
A: No. New kernels will get new microcode lists, both mainline
   and stable. The only way to have an old list is to be running
   an old kernel in which case you have bigger problems.

Q: Is this for security or functional issues?
A: Both.

Q: If a given microcode update only has functional problems but
   no security issues, will it be considered old?
A: Yes. All microcode image versions within a microcode release
   are treated identically. Intel appears to make security
   updates without disclosing them in the release notes.  Thus,
   all updates are considered to be security-relevant.

Q: Who runs old microcode?
A: Anybody with an old distro. This happens all the time inside
   of Intel where there are lots of weird systems in labs that
   might not be getting regular distro updates and might also
   be running rather exotic microcode images.

Q: If I update my microcode after booting will it stop saying
   "Vulnerable"?
A: No. Just like all the other vulnerabilies, you need to
   reboot before the kernel will reassess your vulnerability.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/Documentation/ABI/testing/sysfs-devices-system-cpu  |    1 
 b/Documentation/admin-guide/hw-vuln/old_microcode.rst |   21 ++
 b/arch/x86/include/asm/cpufeatures.h                  |    1 
 b/arch/x86/kernel/cpu/bugs.c                          |   16 +
 b/arch/x86/kernel/cpu/common.c                        |   42 +++++
 b/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h    |  150 ++++++++++++++++++
 b/drivers/base/cpu.c                                  |    3 
 b/include/linux/cpu.h                                 |    2 
 8 files changed, 236 insertions(+)

diff -puN arch/x86/include/asm/cpufeatures.h~old-ucode-0 arch/x86/include/asm/cpufeatures.h
--- a/arch/x86/include/asm/cpufeatures.h~old-ucode-0	2025-04-21 12:37:44.065881626 -0700
+++ b/arch/x86/include/asm/cpufeatures.h	2025-04-21 12:37:44.134884174 -0700
@@ -533,4 +533,5 @@
 #define X86_BUG_BHI			X86_BUG(1*32 + 3) /* "bhi" CPU is affected by Branch History Injection */
 #define X86_BUG_IBPB_NO_RET	   	X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
 #define X86_BUG_SPECTRE_V2_USER		X86_BUG(1*32 + 5) /* "spectre_v2_user" CPU is affected by Spectre variant 2 attack between user processes */
+#define X86_BUG_OLD_MICROCODE		X86_BUG(1*32 + 6) /* "old_microcode" CPU has old microcode, it is surely vulnerable to something */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff -puN arch/x86/kernel/cpu/bugs.c~old-ucode-0 arch/x86/kernel/cpu/bugs.c
--- a/arch/x86/kernel/cpu/bugs.c~old-ucode-0	2025-04-21 12:37:44.066881663 -0700
+++ b/arch/x86/kernel/cpu/bugs.c	2025-04-21 12:37:44.134884174 -0700
@@ -2839,6 +2839,14 @@ static ssize_t rfds_show_state(char *buf
 	return sysfs_emit(buf, "%s\n", rfds_strings[rfds_mitigation]);
 }
 
+static ssize_t old_microcode_show_state(char *buf)
+{
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return sysfs_emit(buf, "Unknown: running under hypervisor");
+
+	return sysfs_emit(buf, "Vulnerable\n");
+}
+
 static char *stibp_state(void)
 {
 	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
@@ -3021,6 +3029,9 @@ static ssize_t cpu_show_common(struct de
 	case X86_BUG_RFDS:
 		return rfds_show_state(buf);
 
+	case X86_BUG_OLD_MICROCODE:
+		return old_microcode_show_state(buf);
+
 	default:
 		break;
 	}
@@ -3100,6 +3111,11 @@ ssize_t cpu_show_reg_file_data_sampling(
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_RFDS);
 }
+
+ssize_t cpu_show_old_microcode(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_OLD_MICROCODE);
+}
 #endif
 
 void __warn_thunk(void)
diff -puN arch/x86/kernel/cpu/common.c~old-ucode-0 arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~old-ucode-0	2025-04-21 12:37:44.067881700 -0700
+++ b/arch/x86/kernel/cpu/common.c	2025-04-21 12:37:44.135884211 -0700
@@ -1318,10 +1318,52 @@ static bool __init vulnerable_to_rfds(u6
 	return cpu_matches(cpu_vuln_blacklist, RFDS);
 }
 
+static struct x86_cpu_id cpu_latest_microcode[] = {
+#include "microcode/intel-ucode-defs.h"
+	{}
+};
+
+static bool __init cpu_has_old_microcode(void)
+{
+	const struct x86_cpu_id *m = x86_match_cpu(cpu_latest_microcode);
+
+	/* Give unknown CPUs a pass: */
+	if (!m) {
+		/* Intel CPUs should be in the list. Warn if not: */
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+			pr_info("x86/CPU: Model not found in latest microcode list\n");
+		return false;
+	}
+
+	/*
+	 * Hosts usually lie to guests with a super high microcode
+	 * version. Just ignore what hosts tell guests:
+	 */
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return false;
+
+	/* Consider all debug microcode to be old: */
+	if (boot_cpu_data.microcode & BIT(31))
+		return true;
+
+	/* Give new microocode a pass: */
+	if (boot_cpu_data.microcode >= m->driver_data)
+		return false;
+
+	/* Uh oh, too old: */
+	return true;
+}
+
 static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
 	u64 x86_arch_cap_msr = x86_read_arch_cap_msr();
 
+	if (cpu_has_old_microcode()) {
+		pr_warn("x86/CPU: Running old microcode\n");
+		setup_force_cpu_bug(X86_BUG_OLD_MICROCODE);
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	}
+
 	/* Set ITLB_MULTIHIT bug if cpu is not in the whitelist and not mitigated */
 	if (!cpu_matches(cpu_vuln_whitelist, NO_ITLB_MULTIHIT) &&
 	    !(x86_arch_cap_msr & ARCH_CAP_PSCHANGE_MC_NO))
diff -puN arch/x86/kernel/cpu/microcode/intel-ucode-defs.h~old-ucode-0 arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
--- a/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h~old-ucode-0	2025-04-21 12:37:44.069881774 -0700
+++ b/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h	2025-04-21 12:38:24.722383086 -0700
@@ -0,0 +1,150 @@
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x03, .steppings = 0x0004, .driver_data = 0x2 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x05, .steppings = 0x0001, .driver_data = 0x45 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x05, .steppings = 0x0002, .driver_data = 0x40 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x05, .steppings = 0x0004, .driver_data = 0x2c },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x05, .steppings = 0x0008, .driver_data = 0x10 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x06, .steppings = 0x0001, .driver_data = 0xa },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x06, .steppings = 0x0020, .driver_data = 0x3 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x06, .steppings = 0x0400, .driver_data = 0xd },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x06, .steppings = 0x2000, .driver_data = 0x7 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x07, .steppings = 0x0002, .driver_data = 0x14 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x07, .steppings = 0x0004, .driver_data = 0x38 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x07, .steppings = 0x0008, .driver_data = 0x2e },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x08, .steppings = 0x0002, .driver_data = 0x11 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x08, .steppings = 0x0008, .driver_data = 0x8 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x08, .steppings = 0x0040, .driver_data = 0xc },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x08, .steppings = 0x0400, .driver_data = 0x5 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x09, .steppings = 0x0020, .driver_data = 0x47 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0a, .steppings = 0x0001, .driver_data = 0x3 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0a, .steppings = 0x0002, .driver_data = 0x1 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0b, .steppings = 0x0002, .driver_data = 0x1d },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0b, .steppings = 0x0010, .driver_data = 0x2 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0d, .steppings = 0x0040, .driver_data = 0x18 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0e, .steppings = 0x0100, .driver_data = 0x39 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0e, .steppings = 0x1000, .driver_data = 0x59 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0f, .steppings = 0x0004, .driver_data = 0x5d },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0f, .steppings = 0x0040, .driver_data = 0xd2 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0f, .steppings = 0x0080, .driver_data = 0x6b },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0f, .steppings = 0x0400, .driver_data = 0x95 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0f, .steppings = 0x0800, .driver_data = 0xbc },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0f, .steppings = 0x2000, .driver_data = 0xa4 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x16, .steppings = 0x0002, .driver_data = 0x44 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x17, .steppings = 0x0040, .driver_data = 0x60f },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x17, .steppings = 0x0080, .driver_data = 0x70a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x17, .steppings = 0x0400, .driver_data = 0xa0b },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x1a, .steppings = 0x0010, .driver_data = 0x12 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x1a, .steppings = 0x0020, .driver_data = 0x1d },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x1c, .steppings = 0x0004, .driver_data = 0x219 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x1c, .steppings = 0x0400, .driver_data = 0x107 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x1d, .steppings = 0x0002, .driver_data = 0x29 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x1e, .steppings = 0x0020, .driver_data = 0xa },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x25, .steppings = 0x0004, .driver_data = 0x11 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x25, .steppings = 0x0020, .driver_data = 0x7 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x26, .steppings = 0x0002, .driver_data = 0x105 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x2a, .steppings = 0x0080, .driver_data = 0x2f },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x2c, .steppings = 0x0004, .driver_data = 0x1f },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x2d, .steppings = 0x0040, .driver_data = 0x621 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x2d, .steppings = 0x0080, .driver_data = 0x71a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x2e, .steppings = 0x0040, .driver_data = 0xd },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x2f, .steppings = 0x0004, .driver_data = 0x3b },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x37, .steppings = 0x0100, .driver_data = 0x838 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x37, .steppings = 0x0200, .driver_data = 0x90d },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3a, .steppings = 0x0200, .driver_data = 0x21 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3c, .steppings = 0x0008, .driver_data = 0x28 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3d, .steppings = 0x0010, .driver_data = 0x2f },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3e, .steppings = 0x0010, .driver_data = 0x42e },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3e, .steppings = 0x0040, .driver_data = 0x600 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3e, .steppings = 0x0080, .driver_data = 0x715 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3f, .steppings = 0x0004, .driver_data = 0x49 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3f, .steppings = 0x0010, .driver_data = 0x1a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x45, .steppings = 0x0002, .driver_data = 0x26 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x46, .steppings = 0x0002, .driver_data = 0x1c },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x47, .steppings = 0x0002, .driver_data = 0x22 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x4c, .steppings = 0x0008, .driver_data = 0x368 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x4c, .steppings = 0x0010, .driver_data = 0x411 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x4d, .steppings = 0x0100, .driver_data = 0x12d },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x4e, .steppings = 0x0008, .driver_data = 0xf0 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0008, .driver_data = 0x1000191 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0010, .driver_data = 0x2007006 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0020, .driver_data = 0x3000010 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0040, .driver_data = 0x4003605 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0080, .driver_data = 0x5003707 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0800, .driver_data = 0x7002904 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x56, .steppings = 0x0004, .driver_data = 0x1c },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x56, .steppings = 0x0008, .driver_data = 0x700001c },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x56, .steppings = 0x0010, .driver_data = 0xf00001a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x56, .steppings = 0x0020, .driver_data = 0xe000015 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x5c, .steppings = 0x0004, .driver_data = 0x14 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x5c, .steppings = 0x0200, .driver_data = 0x48 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x5c, .steppings = 0x0400, .driver_data = 0x28 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x5e, .steppings = 0x0008, .driver_data = 0xf0 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x5f, .steppings = 0x0002, .driver_data = 0x3e },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x66, .steppings = 0x0008, .driver_data = 0x2a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x6a, .steppings = 0x0020, .driver_data = 0xc0002f0 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x6a, .steppings = 0x0040, .driver_data = 0xd0003e7 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x6c, .steppings = 0x0002, .driver_data = 0x10002b0 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x7a, .steppings = 0x0002, .driver_data = 0x42 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x7a, .steppings = 0x0100, .driver_data = 0x24 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x7e, .steppings = 0x0020, .driver_data = 0xc6 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8a, .steppings = 0x0002, .driver_data = 0x33 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8c, .steppings = 0x0002, .driver_data = 0xb8 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8c, .steppings = 0x0004, .driver_data = 0x38 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8d, .steppings = 0x0002, .driver_data = 0x52 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8e, .steppings = 0x0200, .driver_data = 0xf6 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8e, .steppings = 0x0400, .driver_data = 0xf6 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8e, .steppings = 0x0800, .driver_data = 0xf6 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8e, .steppings = 0x1000, .driver_data = 0xfc },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0100, .driver_data = 0x2c000390 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0080, .driver_data = 0x2b000603 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0040, .driver_data = 0x2c000390 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0020, .driver_data = 0x2c000390 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0010, .driver_data = 0x2c000390 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x96, .steppings = 0x0002, .driver_data = 0x1a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x97, .steppings = 0x0004, .driver_data = 0x37 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x97, .steppings = 0x0020, .driver_data = 0x37 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xbf, .steppings = 0x0004, .driver_data = 0x37 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xbf, .steppings = 0x0020, .driver_data = 0x37 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9a, .steppings = 0x0008, .driver_data = 0x435 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9a, .steppings = 0x0010, .driver_data = 0x435 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9c, .steppings = 0x0001, .driver_data = 0x24000026 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x0200, .driver_data = 0xf8 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x0400, .driver_data = 0xf8 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x0800, .driver_data = 0xf6 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x1000, .driver_data = 0xf8 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x2000, .driver_data = 0x100 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa5, .steppings = 0x0004, .driver_data = 0xfc },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa5, .steppings = 0x0008, .driver_data = 0xfc },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa5, .steppings = 0x0020, .driver_data = 0xfc },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa6, .steppings = 0x0001, .driver_data = 0xfe },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa6, .steppings = 0x0002, .driver_data = 0xfc },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa7, .steppings = 0x0002, .driver_data = 0x62 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xaa, .steppings = 0x0010, .driver_data = 0x20 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xb7, .steppings = 0x0002, .driver_data = 0x12b },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xba, .steppings = 0x0004, .driver_data = 0x4123 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xba, .steppings = 0x0008, .driver_data = 0x4123 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xba, .steppings = 0x0100, .driver_data = 0x4123 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xbe, .steppings = 0x0001, .driver_data = 0x1a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xcf, .steppings = 0x0004, .driver_data = 0x21000283 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xcf, .steppings = 0x0002, .driver_data = 0x21000283 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x00, .steppings = 0x0080, .driver_data = 0x12 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x00, .steppings = 0x0400, .driver_data = 0x15 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x01, .steppings = 0x0004, .driver_data = 0x2e },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x02, .steppings = 0x0010, .driver_data = 0x21 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x02, .steppings = 0x0020, .driver_data = 0x2c },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x02, .steppings = 0x0040, .driver_data = 0x10 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x02, .steppings = 0x0080, .driver_data = 0x39 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x02, .steppings = 0x0200, .driver_data = 0x2f },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x03, .steppings = 0x0004, .driver_data = 0xa },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x03, .steppings = 0x0008, .driver_data = 0xc },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x03, .steppings = 0x0010, .driver_data = 0x17 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0002, .driver_data = 0x17 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0008, .driver_data = 0x5 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0010, .driver_data = 0x6 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0080, .driver_data = 0x3 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0100, .driver_data = 0xe },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0200, .driver_data = 0x3 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0400, .driver_data = 0x4 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x06, .steppings = 0x0004, .driver_data = 0xf },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x06, .steppings = 0x0010, .driver_data = 0x4 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x06, .steppings = 0x0020, .driver_data = 0x8 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x06, .steppings = 0x0100, .driver_data = 0x9 },
diff -puN Documentation/ABI/testing/sysfs-devices-system-cpu~old-ucode-0 Documentation/ABI/testing/sysfs-devices-system-cpu
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu~old-ucode-0	2025-04-21 12:37:44.086882401 -0700
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu	2025-04-21 12:37:44.135884211 -0700
@@ -516,6 +516,7 @@ What:		/sys/devices/system/cpu/vulnerabi
 		/sys/devices/system/cpu/vulnerabilities/mds
 		/sys/devices/system/cpu/vulnerabilities/meltdown
 		/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
+		/sys/devices/system/cpu/vulnerabilities/old_microcode
 		/sys/devices/system/cpu/vulnerabilities/reg_file_data_sampling
 		/sys/devices/system/cpu/vulnerabilities/retbleed
 		/sys/devices/system/cpu/vulnerabilities/spec_store_bypass
diff -puN /dev/null Documentation/admin-guide/hw-vuln/old_microcode.rst
--- /dev/null	2025-04-19 18:20:13.724309711 -0700
+++ b/Documentation/admin-guide/hw-vuln/old_microcode.rst	2025-04-21 12:37:44.135884211 -0700
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+Old Microcode
+=============
+
+The kernel keeps a table of released microcode. Systems that had
+microcode older than this at boot will say "Vulnerable".  This means
+that the system was vulnerable to some known CPU issue. It could be
+security or functional, the kernel does not know or care.
+
+You should update the CPU microcode to mitigate any exposure. This is
+usually accomplished by updating the files in
+/lib/firmware/intel-ucode/ via normal distribution updates. Intel also
+distributes these files in a github repo:
+
+	https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files.git
+
+Just like all the other hardware vulnerabilities, exposure is
+determined at boot. Runtime microcode updates do not change the status
+of this vulnerability.
diff -puN drivers/base/cpu.c~old-ucode-0 drivers/base/cpu.c
--- a/drivers/base/cpu.c~old-ucode-0	2025-04-21 12:37:44.087882438 -0700
+++ b/drivers/base/cpu.c	2025-04-21 12:37:44.135884211 -0700
@@ -600,6 +600,7 @@ CPU_SHOW_VULN_FALLBACK(spec_rstack_overf
 CPU_SHOW_VULN_FALLBACK(gds);
 CPU_SHOW_VULN_FALLBACK(reg_file_data_sampling);
 CPU_SHOW_VULN_FALLBACK(ghostwrite);
+CPU_SHOW_VULN_FALLBACK(old_microcode);
 
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
@@ -616,6 +617,7 @@ static DEVICE_ATTR(spec_rstack_overflow,
 static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
 static DEVICE_ATTR(reg_file_data_sampling, 0444, cpu_show_reg_file_data_sampling, NULL);
 static DEVICE_ATTR(ghostwrite, 0444, cpu_show_ghostwrite, NULL);
+static DEVICE_ATTR(old_microcode, 0444, cpu_show_old_microcode, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -633,6 +635,7 @@ static struct attribute *cpu_root_vulner
 	&dev_attr_gather_data_sampling.attr,
 	&dev_attr_reg_file_data_sampling.attr,
 	&dev_attr_ghostwrite.attr,
+	&dev_attr_old_microcode.attr,
 	NULL
 };
 
diff -puN include/linux/cpu.h~old-ucode-0 include/linux/cpu.h
--- a/include/linux/cpu.h~old-ucode-0	2025-04-21 12:37:44.126883879 -0700
+++ b/include/linux/cpu.h	2025-04-21 12:37:44.135884211 -0700
@@ -78,6 +78,8 @@ extern ssize_t cpu_show_gds(struct devic
 extern ssize_t cpu_show_reg_file_data_sampling(struct device *dev,
 					       struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_ghostwrite(struct device *dev, struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_old_microcode(struct device *dev,
+				      struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
_

