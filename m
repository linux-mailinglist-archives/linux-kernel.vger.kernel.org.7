Return-Path: <linux-kernel+bounces-767267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2533B2521B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AFD91C21CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D41528B3E7;
	Wed, 13 Aug 2025 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6Nd2FLo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A41828850C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755106032; cv=none; b=s5EPDVb7e6GuIqOnGQKbWN8ZlYKqfSfler9xnM7YVgvBDcGtLYKKNDocUMa+TZbxKdIAcsgJUVW8kD5ueOI13tGBgzziJDHQdEcHkx5FzXU3YuzPIo7fzG/ldzdfcVbF+acVIVdd5yfhKCZ7+6FTeUqN5SfMlqfrCh5NDm4+4QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755106032; c=relaxed/simple;
	bh=pddAVofjUvwztbLAKX/AQSVKNcKJ0FW0t5mvkuaRnyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0WTnZQqcJ0kXdzSMdQVbBh3CR+/0p2oJ6OZey/qcu+C/LRltg9TSCUGUbalB6g8BEIhOURutv9UUIM+++FsV/GtjT4FqMQ/uXbLv/rCiFj09GL50oDXGHr+4LbPKwdO2E9S6i1oLk6Z7jHjT1Em7OhGzhN7W/JXzsxLd4DSn7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6Nd2FLo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755106031; x=1786642031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pddAVofjUvwztbLAKX/AQSVKNcKJ0FW0t5mvkuaRnyg=;
  b=Q6Nd2FLoXNL2uf+qm7Tn6XYN7jNgggJ9HjGoKDWuYtImG1QQ++w5R2D8
   l4/DOyj4uZpvG6npMSxgWKvf2jOf7pBoEShdWNTrTwuwksKVpE3cdRmF9
   MkJDsGqiR7ayGIJZpKcgnahkqosYWSXnXCz8lQCmbYAu2bNC3xK4lF6GX
   LHY1i8ts6hjHNmIv0/pd+iki4EFnSkEyDpd4YE3DLmdWtT73xOl3b5CJm
   7o8g5fScudVcmUACvRc6y8QhaeSiQk1/MtZ/vZew7ogOiFYslNI1ElH3Y
   qKy7E27UvRGAUhrxFYxoveWe2uXzKB2PVfWMiEHyRT5pJio6pWhH2VpYF
   Q==;
X-CSE-ConnectionGUID: tYuP4tVxTPuLbqgCGG+zPA==
X-CSE-MsgGUID: E7kDgq3dTCKab1YBund/OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61255211"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="61255211"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 10:27:11 -0700
X-CSE-ConnectionGUID: Y8Roc2FKQ8SN64N+OVj9Fg==
X-CSE-MsgGUID: yO+RCJ25SWuo87R3+6CZSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="167329705"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.193])
  by fmviesa010.fm.intel.com with ESMTP; 13 Aug 2025 10:27:09 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: x86@kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	colinmitchell@google.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	chang.seok.bae@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] x86/microcode/intel: Establish staging control logic
Date: Wed, 13 Aug 2025 10:26:45 -0700
Message-ID: <20250813172649.15474-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813172649.15474-1-chang.seok.bae@intel.com>
References: <20250409232713.4536-1-chang.seok.bae@intel.com>
 <20250813172649.15474-1-chang.seok.bae@intel.com>
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
V2 -> V3:
* Remove a global variable and adjust stage_microcode() (Dave).
* Simplify for_each_cpu() loop control code
* Handle rdmsrl_on_cpu() return code explicitly (Chao)

V1 -> V2:
* Adjust to reference the staging_state struct.
* Add lockdep_assert_cpus_held() (Boris)
---
 arch/x86/include/asm/msr-index.h      |  2 ++
 arch/x86/include/asm/topology.h       |  1 +
 arch/x86/kernel/cpu/microcode/intel.c | 50 +++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

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
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 6c79ee7c0957..91b5fc44ca62 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -235,6 +235,7 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline unsigned int topology_amd_nodes_per_pkg(void) { return 1; }
+#define cpu_primary_thread_mask cpu_none_mask
 #endif /* !CONFIG_SMP */
 
 static inline void arch_fix_phys_package_id(int num, u32 slot)
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 371ca6eac00e..468c4d3d5d66 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -299,6 +299,55 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
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
+		err = rdmsrl_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &mmio_pa);
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
+	pr_info("Staging of patch revision 0x%x succeeded.\n",
+		((struct microcode_header_intel *)ucode_patch_late)->rev);
+}
+
 static enum ucode_state __apply_microcode(struct ucode_cpu_info *uci,
 					  struct microcode_intel *mc,
 					  u32 *cur_rev)
@@ -627,6 +676,7 @@ static struct microcode_ops microcode_intel_ops = {
 	.collect_cpu_info	= collect_cpu_info,
 	.apply_microcode	= apply_microcode_late,
 	.finalize_late_load	= finalize_late_load,
+	.stage_microcode	= stage_microcode,
 	.use_nmi		= IS_ENABLED(CONFIG_X86_64),
 };
 
-- 
2.48.1


