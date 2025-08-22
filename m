Return-Path: <linux-kernel+bounces-782767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160B0B3251C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00EDC621054
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E372C2363;
	Fri, 22 Aug 2025 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UR9xYITw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289CC2BF01D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755902384; cv=none; b=Ks6S1mn1qBT1FOKaqQjNqAY5W01yzSA8j14+yFsOMhfPp+QZtoAUQQ/6NLFLetIN3S8w/tS/x9vRAbW/QhNZHLvOZxHqy2OBzQV9iypO0HKoYaSpiSMN1oYdVU7a+r53aXexwknYGgPx8rFTVkqyxrooXq8MmKV3LqkZuN+r8xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755902384; c=relaxed/simple;
	bh=E62OVnWvHDRTHT1BmJfjlvxMSfin/FnTuky3FuS9cE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBoseVHxZVjzrlx+Jggn1giWViX4Txpc3CNwa45CicsiLJCmYsukbhpRpRfo8M46EzacrBxS01gCv0LM7vMGNQyjQcp5oAGpWIVioHHp4UPuiNm4cVsSI/sbIW5YGXf2ve/pI8YX+2w/M7nWIvK9tgb7EbT+Zp3PhS9PtI/5NB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UR9xYITw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755902383; x=1787438383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E62OVnWvHDRTHT1BmJfjlvxMSfin/FnTuky3FuS9cE0=;
  b=UR9xYITwji6EthdItZuOtOTXjfRJU8qwGRK8iqDNsQJAA7TG/WvEsEag
   j+r7ntiONDKfzJOAQxOpoDQrSwh1QiK2Hv8RfgSJOkVJ2mzJu3B4iHDXp
   HS9Uq7+lgdhVlTYjQ6puMQYXqwOPG7Pgjhb4K1CuUE4I5I5vMTDPoD3ev
   1Ede0d5VF/ojK2zhM9ZzfH3347Tn25TxyXCT0FQ2xjgHwpOL0umFeqrRj
   YiCMouu66P5Wjdp3ZO8v3WXWNMt5n902b8R0DZ9NNnld1y2O8KqDA3oTp
   TwRimw8ZV1/kLdRU5lAwxJ+LKRgLY+dAJd93PPoz7VgW3ZdI9RvxuFc4n
   w==;
X-CSE-ConnectionGUID: ra9CoxwwQbq+/kSKLMzRsQ==
X-CSE-MsgGUID: kzrvyk/IRQy7TT7/Y9Cdpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="75800174"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="75800174"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 15:39:43 -0700
X-CSE-ConnectionGUID: 5NTm/PgwQnui/P/Njj8FtQ==
X-CSE-MsgGUID: ZlW1h18jTMeoA0bKx8BfCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168716249"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.135.148])
  by orviesa007.jf.intel.com with ESMTP; 22 Aug 2025 15:39:42 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	colinmitchell@google.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	chang.seok.bae@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4a 2/6] x86/microcode/intel: Establish staging control logic
Date: Fri, 22 Aug 2025 15:39:40 -0700
Message-ID: <20250822223940.12504-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <06d43a86-204f-4658-9759-d24b7038b2d3@intel.com>
References: <06d43a86-204f-4658-9759-d24b7038b2d3@intel.com>
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
V4 -> V4a:
* Rebase on the primary thread cpumask fix (Dave)
* Clean up the rev print code (Dave)
* rdmsrl_on_cpu() -> rdmsrq_on_cpu (Chao)
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


