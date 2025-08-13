Return-Path: <linux-kernel+bounces-767271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FC4B25224
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316D25A8526
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC162980A8;
	Wed, 13 Aug 2025 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNkyqL2l"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC60291861
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755106038; cv=none; b=cmYDkGGobtBpTUiFaNcQTQ8ZHg+StIZd67kcaXUSYElP5uxWiGXMbdtUq9L5O1azR/v3UUfyuhN2QFdxg20LUwzm85jR9p+YTNmo/s3SqCqZs9m4cxVp2L83hSjtIRTjawzuN5PyMHzsMuplen4sFXZatgn634UdjoWhuXaZfbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755106038; c=relaxed/simple;
	bh=xpbDvW/BHKIgitRmU6XLqWtAPgxiXoMaMAxkxFpaLt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B02QlSs9ZJxLxPUeRqIA4TTTeuqvCS+oCdxAw4LfPl/Gn/MXxJLhoMiC7bUrQJQE1UKzN9TzqTTu/63uCfw/48nrAdTzRfABMTIHbQ/m35ItIkMPPp/Rii9Usj1KWic1SnGedDQtj5l+ZYdqtn1B7Kt2ocK5pY+ezA+ihmFQ91E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNkyqL2l; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755106038; x=1786642038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xpbDvW/BHKIgitRmU6XLqWtAPgxiXoMaMAxkxFpaLt4=;
  b=NNkyqL2lxFIZ8LHRFYphtRv3WcfXtbDU2kZz3yZMyxXjB7aEJO5+sy2/
   77KCfUzjcsI+9sJt3InNEfKFiH3JBkHnIhpDbmKaUojCj+zNXIuAeYIdZ
   84g07x+YzOld4DanjsZYbBAMHb93kxqzSoqo4qwbPE18GDVjFGj0EpIOj
   A43CAbJZaOYvhu8qHIXKRmgsIkEc6KQqeGDMq7d0WyU6/YHGlkRCYcXHT
   3s7MxknPeBYTlgPMj0Q7M7bVeFlxNCHi5QLQg1ZYM3lw9ZpyP3BiY9t58
   eExH984umj0HPU72e5nwzcVUYeuSHZVgTx3ESyJyHpylTGv386DLZwjRN
   g==;
X-CSE-ConnectionGUID: hMam2lQYQw+RFgicembvUA==
X-CSE-MsgGUID: Mg2sn0RiTnujlq8yNXdiTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61255261"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="61255261"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 10:27:17 -0700
X-CSE-ConnectionGUID: FHour4/+Q66Jz3QbIqYJBA==
X-CSE-MsgGUID: oe/4pfVxSryXDOtdndcCNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="167329719"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.193])
  by fmviesa010.fm.intel.com with ESMTP; 13 Aug 2025 10:27:16 -0700
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
Subject: [PATCH v4 6/6] x86/microcode/intel: Enable staging when available
Date: Wed, 13 Aug 2025 10:26:49 -0700
Message-ID: <20250813172649.15474-7-chang.seok.bae@intel.com>
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

With the staging code being ready, check for staging availability by
reading these following MSRs:

  * IA32_ARCH_CAPABILITIES (bit 16) for the presence of
    IA32_MCU_ENUMERATION

  * IA32_MCU_ENUMERATION (bit 4) for the staging feature availability.

When available, enable it by setting the feature bit.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Anselm Busse <abusse@amazon.de>
---
V1 -> V2: Fold MSR definings (Boris).
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
index 5402bcb96f47..4da5f3581a94 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -959,6 +959,18 @@ static __init void calc_llc_size_per_core(struct cpuinfo_x86 *c)
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
+	rdmsrl(MSR_IA32_MCU_ENUMERATION, val);
+	return !!(val & MCU_STAGING);
+}
+
 struct microcode_ops * __init init_intel_microcode(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
@@ -969,6 +981,11 @@ struct microcode_ops * __init init_intel_microcode(void)
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


