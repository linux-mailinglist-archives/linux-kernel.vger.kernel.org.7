Return-Path: <linux-kernel+bounces-783132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7D5B329E1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5167172802
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34802E92CF;
	Sat, 23 Aug 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lBPEeCgl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF629D294
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964343; cv=none; b=lVcfRs9wlJ8hyPkNGfXbk1Mcwj3ni1kZVHmOOs8jiHCbJtHOBpTjS7Yc3/XQllMnrpy19betYlm1Q7ns+pV2EcfJ/DRypuF64QwoQs+G+UDxtFZIk42BCU4eQfPAFALexbZuPXWBnzeBE/dDxZRHrQ59Ligc7C/mIpyKhSXz8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964343; c=relaxed/simple;
	bh=Uud7x/kFOg3GusvE/Dmo+ob/jebuwykp9zsf6p/X4aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEFdLcsVxugK4k7xUPjXN/a5l/sp0fbxnuiM4pji7k+2UFjxHbtRZidN7rrSMRBJtkedWxNiN6GerT/mKRAeb3nTlOfebVL2EiiP0PdxlHlcdVObr2bmg9jdLlBhRYZitYiywDybpDLZVKkdSgYecMsTmsL98QDUUfbkHuVRaF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lBPEeCgl; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755964342; x=1787500342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uud7x/kFOg3GusvE/Dmo+ob/jebuwykp9zsf6p/X4aw=;
  b=lBPEeCglkEcUS0dCcKwXjop78CDoRq2STK+SqMoYzHeRZIP2Z+dLwBQ8
   8ZNV4FjbBqbGn4IwEqIpuWlcLxQlWmDiWC+uYtBsnH40igzyrXFodI3df
   XL5zBuvzWYZFKk2l0b+zV55PGNGO7Gs5vCO6vQWxGAzbI+eKRx2NXKBpA
   Po0o9Pls1SsHAFHnzWmJXdJrhNBYQWG+u1GsyrBmM4bbthafeBhiQ61Xf
   EhqnkRV9LG4wupkShBwi6EStqcsUcWCllrLKzIf2uf3OhWuT3oXWpTqt1
   F9J4gV4wwVtQuPuJQqYNLEWqu9oaSMtxztVhDfxAc//OVUMYBIJEdPGVI
   Q==;
X-CSE-ConnectionGUID: QrO9qYIxS4CI4qq5S3mHpQ==
X-CSE-MsgGUID: nlzLY26yS/Gw8RBmJ5CQfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="75832805"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="75832805"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 08:52:21 -0700
X-CSE-ConnectionGUID: uQktACwlTs2Bl447PmWG+Q==
X-CSE-MsgGUID: 37SbrWMOSRii2lfjNFjSGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169748230"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.85.190])
  by fmviesa010.fm.intel.com with ESMTP; 23 Aug 2025 08:52:21 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	chang.seok.bae@intel.com
Subject: [PATCH v5 3/7] x86/microcode/intel: Establish staging control logic
Date: Sat, 23 Aug 2025 08:52:06 -0700
Message-ID: <20250823155214.17465-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250823155214.17465-1-chang.seok.bae@intel.com>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250823155214.17465-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When microcode staging is initiated, operations are carried out through
an MMIO interface. Each package has a unique interface specified by the
IA32_MCU_STAGING_MBOX_ADDR MSR, which maps to a set of 32-bit registers.

Prepare staging with the following steps:

  1.  Ensure the microcode image is 32-bit aligned to match the MMIO
      register size.

  2.  Identify each MMIO interface based on its per-package scope.

  3.  Invoke the staging function for each identified interface, which
      will be implemented separately.

Also, define cpu_primary_thread_mask for the CONFIG_SMP=n case, allowing
consistent use when narrowing down primary threads to locate the
per-package interface.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Anselm Busse <abusse@amazon.de>
Link: https://lore.kernel.org/all/871pznq229.ffs@tglx
---
V4 -> V5:
* Rebase on the primary thread cpumask fix (Dave)
* Clean up the rev print code (Dave)
* rdmsrl_on_cpu() -> rdmsrq_on_cpu (Chao)

V2 -> V3:
* Remove a global variable and adjust stage_microcode() (Dave).
* Simplify for_each_cpu() loop control code
* Handle rdmsrl_on_cpu() return code explicitly (Chao)

V1 -> V2:
* Adjust to reference the staging_state struct.
* Add lockdep_assert_cpus_held() (Boris)
---
 arch/x86/include/asm/msr-index.h      |  2 ++
 arch/x86/kernel/cpu/microcode/intel.c | 49 +++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index b65c3ba5fa14..0356155f9264 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -913,6 +913,8 @@
 #define MSR_IA32_UCODE_WRITE		0x00000079
 #define MSR_IA32_UCODE_REV		0x0000008b
 
+#define MSR_IA32_MCU_STAGING_MBOX_ADDR	0x000007a5
+
 /* Intel SGX Launch Enclave Public Key Hash MSRs */
 #define MSR_IA32_SGXLEPUBKEYHASH0	0x0000008C
 #define MSR_IA32_SGXLEPUBKEYHASH1	0x0000008D
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 371ca6eac00e..d309fb1f058f 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -299,6 +299,54 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 	return size ? NULL : patch;
 }
 
+/*
+ * Handle the staging process using the mailbox MMIO interface.
+ * Return the result state.
+ */
+static enum ucode_state do_stage(u64 mmio_pa)
+{
+	pr_debug_once("Staging implementation is pending.\n");
+	return UCODE_ERROR;
+}
+
+static void stage_microcode(void)
+{
+	unsigned int pkg_id = UINT_MAX;
+	enum ucode_state ret;
+	int cpu, err;
+	u64 mmio_pa;
+
+	if (!IS_ALIGNED(get_totalsize(&ucode_patch_late->hdr), sizeof(u32)))
+		return;
+
+	lockdep_assert_cpus_held();
+
+	/*
+	 * The MMIO address is unique per package, and all the SMT
+	 * primary threads are online here. Find each MMIO space by
+	 * their package ids to avoid duplicate staging.
+	 */
+	for_each_cpu(cpu, cpu_primary_thread_mask) {
+		if (topology_logical_package_id(cpu) == pkg_id)
+			continue;
+		pkg_id = topology_logical_package_id(cpu);
+
+		err = rdmsrq_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &mmio_pa);
+		if (WARN_ON_ONCE(err))
+			return;
+
+		ret = do_stage(mmio_pa);
+		if (ret != UCODE_OK) {
+			pr_err("Error: staging failed with %s for CPU%d at package %u.\n",
+			       ret == UCODE_TIMEOUT ? "timeout" : "error state",
+			       cpu, pkg_id);
+			return;
+		}
+	}
+
+	pr_info("Staging of patch revision 0x%x succeeded.\n", ucode_patch_late->hdr.rev);
+}
+
 static enum ucode_state __apply_microcode(struct ucode_cpu_info *uci,
 					  struct microcode_intel *mc,
 					  u32 *cur_rev)
@@ -627,6 +675,7 @@ static struct microcode_ops microcode_intel_ops = {
 	.collect_cpu_info	= collect_cpu_info,
 	.apply_microcode	= apply_microcode_late,
 	.finalize_late_load	= finalize_late_load,
+	.stage_microcode	= stage_microcode,
 	.use_nmi		= IS_ENABLED(CONFIG_X86_64),
 };
 
-- 
2.48.1


