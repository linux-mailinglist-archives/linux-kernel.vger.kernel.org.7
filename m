Return-Path: <linux-kernel+bounces-783136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 609CBB329E6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77AD75625F8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B534A2EA73C;
	Sat, 23 Aug 2025 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVcQXj1h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9108D2EA148
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964347; cv=none; b=XWhQ9aO1rVwMpqPcM9mSCq7ljimWVm9Frf3dFRSJqTI/jZ0JLsC9bvkee0SYQBHT2YXJCQD1ZpRxebMw2O2hbTBQAqkcfZUQ9hjU7EYFpwk2xeCJ+FXyKxYaCvgFY7L25w8Z++MbvKYEFShBzWa64cQ1Q1Zus7z5KlqLdaSuUIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964347; c=relaxed/simple;
	bh=msJTNaNSQ6qHiQGGVHZ28t+lSU4y4Ql7Ojc6kM+547k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jqob2M6tK4uUqYO6YeKJ9edYJOdTo7wReCiko0ZfdGhhpk9v17mpq/j2ijtTUPCPUf/w+77aa7yfz5t2uJFPGdK6zFfd7elbzSY8gpR8f7S777YT3jzf3owpbtBT+ixj4StCdC15lUAMnYt0WfTVgWho7zSa64anYj3yELH+Mqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVcQXj1h; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755964346; x=1787500346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=msJTNaNSQ6qHiQGGVHZ28t+lSU4y4Ql7Ojc6kM+547k=;
  b=XVcQXj1hV64ZBAECR0hBN9N2qLz3yVoc09K3vnh7lDdDRbtSsMxBZyMb
   eAVlN6mqXX1ZK93UL9o6FjG0/5m89r29lM0/y5TeRmHXpiYbVhLAiMwOC
   D4OU4p89FJYZF1v+BIAPrg0DzajLqqbloQ+830nEEpA0ZMn+6VbUZA4MP
   0JGxGMYe6pdSeELws49qGpch34/MCjeX++u146bryYk/PEgpFkLFzmLxR
   9ckBEdRc9XHwdwLiJFYoXCbgVlB89J3B+BzSPAtb+cgXtr/owLUGeeYpt
   Tn/HtXb5d9sPm/rdzdOwojkosPQaa7YAiplxiMUDYijjpqxePAaK9Wbvb
   g==;
X-CSE-ConnectionGUID: Hc+OoLGNS4u8sw+MA18PdA==
X-CSE-MsgGUID: 6G6eXQCvQLaiADAKSGag8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="75832833"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="75832833"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 08:52:26 -0700
X-CSE-ConnectionGUID: b4bDQL5YSPWsTvyazriGQQ==
X-CSE-MsgGUID: VV4vhXINSqej8sEFXiUInA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169748254"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.85.190])
  by fmviesa010.fm.intel.com with ESMTP; 23 Aug 2025 08:52:25 -0700
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
Subject: [PATCH v5 7/7] x86/microcode/intel: Enable staging when available
Date: Sat, 23 Aug 2025 08:52:10 -0700
Message-ID: <20250823155214.17465-8-chang.seok.bae@intel.com>
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

With the staging code being ready, check for staging availability by
reading these following MSRs:

  * IA32_ARCH_CAPABILITIES (bit 16) for the presence of
    IA32_MCU_ENUMERATION

  * IA32_MCU_ENUMERATION (bit 4) for the staging feature availability.

When available, enable it by setting the feature bit.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Tested-by: Anselm Busse <abusse@amazon.de>
---
V4 -> V5:
* Collect Chao's Review tag
* rdmsrl() -> rdmsrq() (Chao)

V1 -> V2:
* Fold MSR definings (Boris).
---
 arch/x86/include/asm/msr-index.h      |  7 +++++++
 arch/x86/kernel/cpu/microcode/intel.c | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 0356155f9264..2b7b598c414f 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -166,6 +166,10 @@
 						 * Processor MMIO stale data
 						 * vulnerabilities.
 						 */
+#define ARCH_CAP_MCU_ENUM		BIT(16) /*
+						 * Indicates the presence of microcode update
+						 * feature enumeration and status information
+						 */
 #define ARCH_CAP_FB_CLEAR		BIT(17)	/*
 						 * VERW clears CPU fill buffer
 						 * even on MDS_NO CPUs.
@@ -913,6 +917,9 @@
 #define MSR_IA32_UCODE_WRITE		0x00000079
 #define MSR_IA32_UCODE_REV		0x0000008b
 
+#define MSR_IA32_MCU_ENUMERATION	0x0000007b
+#define MCU_STAGING			BIT(4)
+
 #define MSR_IA32_MCU_STAGING_MBOX_ADDR	0x000007a5
 
 /* Intel SGX Launch Enclave Public Key Hash MSRs */
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index f6b365eba6a2..7d6582f8a80f 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -1007,6 +1007,18 @@ static __init void calc_llc_size_per_core(struct cpuinfo_x86 *c)
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
@@ -1017,6 +1029,11 @@ struct microcode_ops * __init init_intel_microcode(void)
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


