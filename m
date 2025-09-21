Return-Path: <linux-kernel+bounces-826454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 552EEB8E934
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64723BF4BE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC252D780A;
	Sun, 21 Sep 2025 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AsP+lh9i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5BE2D061A
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758494930; cv=none; b=r79cWmpp/Yo3UZ8Iy2LBx2flk3BIv03b3MjU9KwOXqTAYmg2m8ZVCVx5vp2vLZ01qtlLDeFb+e3EQTQrnZ+//PMuCN02EBTnRwdsbxDnuwtrhFUZxT39lgemPx1Ih9PQTtZPbDRyPZO2Ge8El4s9Zus3UlSoFukKk7pKzQLtObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758494930; c=relaxed/simple;
	bh=JCgge53Fw3t5UR9MEKksCig7fONXWXnVW7EOCj1oPzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHQKBsxmR6jpkZUrBoMnkkMxc8c0VenFDUVKwcR8NTqLMzLeZ/cxf9dGdqD4/IoSZHYgWUf8ML1ZIvn665KIHVtWrZKB+TK0cP1oO01iX6L34sYH6XWlZWIcL1qwL41U5W/V7B4sk3puY0Tp6/3Z8ZgHfsBGnK4K+C+NqEPtIxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AsP+lh9i; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758494930; x=1790030930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JCgge53Fw3t5UR9MEKksCig7fONXWXnVW7EOCj1oPzc=;
  b=AsP+lh9irCD8257L90WkpIKAwutm7CPDBhVVwZ/26086NIYXdhRABnnk
   xEHJexKd+nf/Ca7aJ6hAcUUnohwYBf4mSgfZoSlz/dRsaX016bC7BfkEg
   XnAESFNdevjMc/ZtRWSXKRj8PY49i+utJH0/ZlPZy5+KGwLYNYIlONA0d
   7zEXAnS+o4u6PQaCLDPW0nhpANe2z+1fFi6Phz8Xv920ENvEzBjqCz6Bw
   JHkQCBJIOulW+xDBUiAa8NP6+ePGnjy0w8hc/s7J0EGznxJrEyHJeTCUc
   fNY+z3Ui5RsILMlhMf8ZcUXmjo64+p/jyOMtaatE2KpZbEU9QWgAqPsmU
   A==;
X-CSE-ConnectionGUID: dpIw5CokR5u7jNEaqHFI2A==
X-CSE-MsgGUID: /OV99bY1QsiYthFrK/mtvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64562348"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64562348"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 15:48:48 -0700
X-CSE-ConnectionGUID: Mx0pTSFAS7GVnpb6AzxOqA==
X-CSE-MsgGUID: ywHNAWZ2Tw634bmFPgCHFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="177129792"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.135.148])
  by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2025 15:48:47 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	tony.luck@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v6 3/7] x86/microcode/intel: Establish staging control logic
Date: Sun, 21 Sep 2025 15:48:37 -0700
Message-ID: <20250921224841.3545-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250921224841.3545-1-chang.seok.bae@intel.com>
References: <20250921224841.3545-1-chang.seok.bae@intel.com>
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

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Anselm Busse <abusse@amazon.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/all/871pznq229.ffs@tglx
---
V5 -> V6:
* Remove stale text in changelog (Boris)
* Place MSR definition in the right spot in msr-index.h (Boris)
* Dump error code instead of vague message (Boris)
* Collect Tony's review tag

V4 -> V5:
* Rebase on the primary thread cpumask fix (Dave)
* Clean up the revision print code (Dave)
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
 arch/x86/kernel/cpu/microcode/intel.c | 48 +++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 718a55d82fe4..0736e44f7c69 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1222,6 +1222,8 @@
 #define MSR_IA32_VMX_VMFUNC             0x00000491
 #define MSR_IA32_VMX_PROCBASED_CTLS3	0x00000492
 
+#define MSR_IA32_MCU_STAGING_MBOX_ADDR	0x000007a5
+
 /* Resctrl MSRs: */
 /* - Intel: */
 #define MSR_IA32_L3_QOS_CFG		0xc81
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 371ca6eac00e..daae74858347 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -299,6 +299,53 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 	return size ? NULL : patch;
 }
 
+/*
+ * Handle the staging process using the mailbox MMIO interface.
+ * Return 0 on success or an error code on failure.
+ */
+static int do_stage(u64 mmio_pa)
+{
+	pr_debug_once("Staging implementation is pending.\n");
+	return -EPROTONOSUPPORT;
+}
+
+static void stage_microcode(void)
+{
+	unsigned int pkg_id = UINT_MAX;
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
+
+		pkg_id = topology_logical_package_id(cpu);
+
+		err = rdmsrq_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &mmio_pa);
+		if (WARN_ON_ONCE(err))
+			return;
+
+		err = do_stage(mmio_pa);
+		if (err) {
+			pr_err("Error: staging failed (code = %d) for CPU%d at package %u.\n",
+			       err, cpu, pkg_id);
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
@@ -627,6 +674,7 @@ static struct microcode_ops microcode_intel_ops = {
 	.collect_cpu_info	= collect_cpu_info,
 	.apply_microcode	= apply_microcode_late,
 	.finalize_late_load	= finalize_late_load,
+	.stage_microcode	= stage_microcode,
 	.use_nmi		= IS_ENABLED(CONFIG_X86_64),
 };
 
-- 
2.48.1


