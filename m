Return-Path: <linux-kernel+bounces-771480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9837DB287CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C591D05750
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BFC30DEBF;
	Fri, 15 Aug 2025 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BH+FmtjE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894412E2DFD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293755; cv=none; b=uSRD1ihx4C/RjO/ZBgSRqRkHuKrJ+WFYQkGWhuzbuWHh9qCyzH8ch7KILUud2pP88BlSj1pXS5/vwKVP4wAAy18/MRzRiyEhkD1GM2BcNR7rBh/3cpH3KOm+c7x+V+c0GuTHjqY+bFHI7IX9VpzcsH8dF0DX9D99XsB573wcZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293755; c=relaxed/simple;
	bh=9a37j8SIObA/Y7POlaW8vXb6NHK1dLDqle8KAAgUZ3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DKKRVBxUwEaUzUyVcdNCfpzcfKJkkzpFZ7MmVsW90AQoO7NuI4bmf414fUZMyAOVlPZtSuR+70U/fINQ6FJvlXo+u0ZQC8aGtorjF4aQ41vkcrcxJWX6nEAISNpPDcCvM9R2hynD12EV1AwwDx9MfnipW3Bb/EqROb5aBvqiG+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BH+FmtjE; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755293753; x=1786829753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9a37j8SIObA/Y7POlaW8vXb6NHK1dLDqle8KAAgUZ3k=;
  b=BH+FmtjE8ghVupsNLf6oeQMOM6ObMiavU4XmozSIqtmPF5neO0+/bXns
   Kh7EZxCMVNZbIhkxT987mywfHrzSFWDq30uZIRswf7mUO0upY9LdW6cul
   cMf0aV4rnVOYxW4DDEMynxTADG/BXYtRMwiL5624hWa8YkAoMMcHeVS9Z
   7z1DjoFx4lhZSGuC+ogIfqHhBFPoY/6oPxhUVHrsz/t8KiCogqJXRj4RF
   sZ0+WL0xadvm82ZcEjDWDnLSYg/GIYmJh2BPJLPtc1PBti6LqKWyU/qxL
   LDs7oxfNPkxRE0GInU3jnIa1doxiZgcHArXYFWWQFiOHy2vASfYOZUI+4
   w==;
X-CSE-ConnectionGUID: ZfWidEzyS8uatj5s6mcAZg==
X-CSE-MsgGUID: 1XXewvshTtevpXAgcJY2Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68707443"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68707443"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:35:47 -0700
X-CSE-ConnectionGUID: IAAsYWyuTTmHC7EZkihtkg==
X-CSE-MsgGUID: /RNl79gVScGnFn6ICizPng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166319614"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 15 Aug 2025 14:35:47 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	irogers@google.com,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: dapeng1.mi@linux.intel.com,
	ak@linux.intel.com,
	zide.chen@intel.com,
	mark.rutland@arm.com,
	broonie@kernel.org,
	ravi.bangoria@amd.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 11/17] perf/x86: Add eGPRs into sample_regs
Date: Fri, 15 Aug 2025 14:34:29 -0700
Message-Id: <20250815213435.1702022-12-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250815213435.1702022-1-kan.liang@linux.intel.com>
References: <20250815213435.1702022-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The eGPRs is only supported when the new SIMD registers configuration
method is used, which moves the XMM to sample_simd_vec_regs. So the
space can be reclaimed for the eGPRs.

The eGPRs is retrieved by XSAVE. Only support the eGPRs for X86_64.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c                | 39 +++++++++++++++++++++------
 arch/x86/include/asm/perf_event.h     |  4 +++
 arch/x86/include/uapi/asm/perf_regs.h | 26 ++++++++++++++++--
 arch/x86/kernel/perf_regs.c           | 31 ++++++++++-----------
 4 files changed, 75 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1fa550efcdfa..f816290defc1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -432,6 +432,8 @@ static void x86_pmu_get_ext_regs(struct x86_perf_regs *perf_regs, u64 mask)
 		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
 	if (valid_mask & XFEATURE_MASK_OPMASK)
 		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
+	if (valid_mask & XFEATURE_MASK_APX)
+		perf_regs->egpr = get_xsave_addr(xsave, XFEATURE_APX);
 }
 
 static void release_ext_regs_buffers(void)
@@ -709,17 +711,33 @@ int x86_pmu_hw_config(struct perf_event *event)
 	}
 
 	if (event->attr.sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
-		/*
-		 * Besides the general purpose registers, XMM registers may
-		 * be collected as well.
-		 */
-		if (event_has_extended_regs(event)) {
-			if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
+		if (event->attr.sample_simd_regs_enabled) {
+			u64 reserved = ~GENMASK_ULL(PERF_REG_X86_64_MAX - 1, 0);
+
+			if (!(event->pmu->capabilities & PERF_PMU_CAP_SIMD_REGS))
 				return -EINVAL;
-			if (!(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
+			/*
+			 * The XMM space in the perf_event_x86_regs is reclaimed
+			 * for eGPRs and other general registers.
+			 */
+			if (event->attr.sample_regs_user & reserved ||
+			    event->attr.sample_regs_intr & reserved)
 				return -EINVAL;
-			if (event->attr.sample_simd_regs_enabled)
+			if ((event->attr.sample_regs_user & PERF_X86_EGPRS_MASK ||
+			     event->attr.sample_regs_intr & PERF_X86_EGPRS_MASK) &&
+			     !(x86_pmu.ext_regs_mask & XFEATURE_MASK_APX))
 				return -EINVAL;
+		} else {
+			/*
+			 * Besides the general purpose registers, XMM registers may
+			 * be collected as well.
+			 */
+			if (event_has_extended_regs(event)) {
+				if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
+					return -EINVAL;
+				if (!(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
+					return -EINVAL;
+			}
 		}
 
 		if (event_has_simd_regs(event)) {
@@ -1881,6 +1899,11 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
 			perf_regs->opmask_regs = NULL;
 			mask |= XFEATURE_MASK_OPMASK;
 		}
+		if (attr->sample_regs_user & PERF_X86_EGPRS_MASK ||
+		    attr->sample_regs_intr & PERF_X86_EGPRS_MASK) {
+			perf_regs->egpr_regs = NULL;
+			mask |= XFEATURE_MASK_APX;
+		}
 	}
 
 	mask &= ~ignore_mask;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index dda677022882..4400cb66bc8e 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -613,6 +613,10 @@ struct x86_perf_regs {
 		u64	*opmask_regs;
 		struct avx_512_opmask_state *opmask;
 	};
+	union {
+		u64	*egpr_regs;
+		struct apx_state *egpr;
+	};
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index dd7bd1dd8d39..cd0f6804debf 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,11 +27,31 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R13,
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
+	/* Extended GPRs (EGPRs) */
+	PERF_REG_X86_R16,
+	PERF_REG_X86_R17,
+	PERF_REG_X86_R18,
+	PERF_REG_X86_R19,
+	PERF_REG_X86_R20,
+	PERF_REG_X86_R21,
+	PERF_REG_X86_R22,
+	PERF_REG_X86_R23,
+	PERF_REG_X86_R24,
+	PERF_REG_X86_R25,
+	PERF_REG_X86_R26,
+	PERF_REG_X86_R27,
+	PERF_REG_X86_R28,
+	PERF_REG_X86_R29,
+	PERF_REG_X86_R30,
+	PERF_REG_X86_R31,
 	/* These are the limits for the GPRs. */
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
-	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
+	PERF_REG_X86_64_MAX = PERF_REG_X86_R31 + 1,
 
-	/* These all need two bits set because they are 128bit */
+	/*
+	 * These all need two bits set because they are 128bit.
+	 * These are only available when !PERF_SAMPLE_REGS_ABI_SIMD
+	 */
 	PERF_REG_X86_XMM0  = 32,
 	PERF_REG_X86_XMM1  = 34,
 	PERF_REG_X86_XMM2  = 36,
@@ -55,6 +75,8 @@ enum perf_event_x86_regs {
 
 #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
 
+#define PERF_X86_EGPRS_MASK		GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16)
+
 #define PERF_X86_SIMD_PRED_REGS_MAX	8
 #define PERF_X86_SIMD_PRED_MASK		GENMASK(PERF_X86_SIMD_PRED_REGS_MAX - 1, 0)
 #define PERF_X86_SIMD_VEC_REGS_MAX	32
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 5e815f806605..b6e50194ff3e 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -83,14 +83,22 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 {
 	struct x86_perf_regs *perf_regs;
 
-	if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
+	if (idx > PERF_REG_X86_R15) {
 		perf_regs = container_of(regs, struct x86_perf_regs, regs);
-		/* SIMD registers are moved to dedicated sample_simd_vec_reg */
-		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
-			return 0;
-		if (!perf_regs->xmm_regs)
-			return 0;
-		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
+
+		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+			if (idx <= PERF_REG_X86_R31) {
+				if (!perf_regs->egpr_regs)
+					return 0;
+				return perf_regs->egpr_regs[idx - PERF_REG_X86_R16];
+			}
+		} else {
+			if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
+				if (!perf_regs->xmm_regs)
+					return 0;
+				return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
+			}
+		}
 	}
 
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(pt_regs_offset)))
@@ -171,14 +179,7 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 				 ~((1ULL << PERF_REG_X86_MAX) - 1))
 
 #ifdef CONFIG_X86_32
-#define REG_NOSUPPORT ((1ULL << PERF_REG_X86_R8) | \
-		       (1ULL << PERF_REG_X86_R9) | \
-		       (1ULL << PERF_REG_X86_R10) | \
-		       (1ULL << PERF_REG_X86_R11) | \
-		       (1ULL << PERF_REG_X86_R12) | \
-		       (1ULL << PERF_REG_X86_R13) | \
-		       (1ULL << PERF_REG_X86_R14) | \
-		       (1ULL << PERF_REG_X86_R15))
+#define REG_NOSUPPORT GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R8)
 
 int perf_reg_validate(u64 mask)
 {
-- 
2.38.1


