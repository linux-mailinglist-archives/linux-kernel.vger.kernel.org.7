Return-Path: <linux-kernel+bounces-826458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC823B8E93D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294C91779C8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE6A2DA768;
	Sun, 21 Sep 2025 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2wYfs+r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4373D2D8DDD
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758494933; cv=none; b=YldJE3DiVStF+JIUJJim13g5p8qK8EIT5+Rqmi5n+OnlSHzwIRl6s7qbp9FFq3fX9xqP2a3FW8T6mKmrwkpysIrKfQKLbnSxueHcTBT/8l/ISYgcnkpd1SVz9UyswCBDrEK/zrmEzdYvGwrRbUd0NLXhrWaUOTFqQhPYnhd+LL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758494933; c=relaxed/simple;
	bh=p0227iz52RNi5Kex3NAQ74ySAajcotyLgJjABWeN+zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMS3E6U2Nbw/ZFQvRV+zgzSCwwhNvgWUScgs/EPIcgxT9fbom341e4wGXit+U4F/9Lk/iueGXuFYukXrhXwVdgcZ/UKBTkSAVpmvnV7MAFVbLxSm6MlcwSA8rlq5TlUz3JPnOSTmHOp3I4Sxj9Pi7TJ0jgUCRNQw90gHGGjs+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2wYfs+r; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758494933; x=1790030933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p0227iz52RNi5Kex3NAQ74ySAajcotyLgJjABWeN+zI=;
  b=C2wYfs+rdxrg+rdCtncYYts7hDIFBTnQyhMm5IhquTmwjVH3mZElYnPF
   5gNFZ4LbielFNUAJuVSm+qyed4zjydUz6Hag18Gw3Fh5hF7EEYrRu3oCU
   yiQGSWKFIcMWut0tJFNSMHoJbyuLFe6JAUKpzj80+H8tnmpG0vrV794Zl
   8IemdCEUnER2Q/LPk/rUDirSUeGL7GaZwebVzqzEh0bTDJ9Y++cLE3ZFq
   KUQIsITDFCiKKZla+9gFjTqEos53CSfg/8KxrJ6O5ueHx6687VZYZsPYT
   blnnqeQqqu44BN+vsAItJRPDnGDrW4Nzizdo7X0wMa146hZIJerHJ8Ccj
   A==;
X-CSE-ConnectionGUID: gfnnixktQPucAiXpd//Ugg==
X-CSE-MsgGUID: X//k4v3LTKa9l7OLM03qYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64562375"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64562375"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 15:48:52 -0700
X-CSE-ConnectionGUID: tDojOhPTSdKmcSlS4QXpEA==
X-CSE-MsgGUID: DnplcdfKRNOFHmXdGXQV4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="177129819"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.135.148])
  by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2025 15:48:51 -0700
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
Subject: [PATCH v6 7/7] x86/microcode/intel: Enable staging when available
Date: Sun, 21 Sep 2025 15:48:41 -0700
Message-ID: <20250921224841.3545-8-chang.seok.bae@intel.com>
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

With staging support implemented, enable it when the CPU reports the
feature.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Anselm Busse <abusse@amazon.de>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
V5 -> V6:
* Add Tony's review tag
* Trim the changelog

V4 -> V5:
* Collect Chao's review tag
* rdmsrl() -> rdmsrq() (Chao)

V1 -> V2:
* Fold MSR definitions (Boris).
---
 arch/x86/include/asm/msr-index.h      |  7 +++++++
 arch/x86/kernel/cpu/microcode/intel.c | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 0736e44f7c69..2db9154192ba 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -166,6 +166,10 @@
 						 * Processor MMIO stale data
 						 * vulnerabilities.
 						 */
+#define ARCH_CAP_MCU_ENUM		BIT(16) /*
+						 * Indicates the presence of microcode update
+						 * feature enumeration and status information.
+						 */
 #define ARCH_CAP_FB_CLEAR		BIT(17)	/*
 						 * VERW clears CPU fill buffer
 						 * even on MDS_NO CPUs.
@@ -927,6 +931,9 @@
 #define MSR_IA32_UCODE_WRITE		0x00000079
 #define MSR_IA32_UCODE_REV		0x0000008b
 
+#define MSR_IA32_MCU_ENUMERATION	0x0000007b
+#define MCU_STAGING			BIT(4)
+
 /* Intel SGX Launch Enclave Public Key Hash MSRs */
 #define MSR_IA32_SGXLEPUBKEYHASH0	0x0000008C
 #define MSR_IA32_SGXLEPUBKEYHASH1	0x0000008D
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 22b9c3d4f43d..033bcf5adba8 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -980,6 +980,18 @@ static __init void calc_llc_size_per_core(struct cpuinfo_x86 *c)
 	llc_size_per_core = (unsigned int)llc_size;
 }
 
+static __init bool staging_available(void)
+{
+	u64 val;
+
+	val = x86_read_arch_cap_msr();
+	if (!(val & ARCH_CAP_MCU_ENUM))
+		return false;
+
+	rdmsrq(MSR_IA32_MCU_ENUMERATION, val);
+	return !!(val & MCU_STAGING);
+}
+
 struct microcode_ops * __init init_intel_microcode(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
@@ -990,6 +1002,11 @@ struct microcode_ops * __init init_intel_microcode(void)
 		return NULL;
 	}
 
+	if (staging_available()) {
+		microcode_intel_ops.use_staging = true;
+		pr_info("Enabled staging feature.\n");
+	}
+
 	calc_llc_size_per_core(c);
 
 	return &microcode_intel_ops;
-- 
2.48.1


