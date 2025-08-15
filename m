Return-Path: <linux-kernel+bounces-771482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE7FB287CF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F0B620655
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1F530F542;
	Fri, 15 Aug 2025 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFRbLJIe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C7B304BD2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293756; cv=none; b=kf6ot/bJZAr8Ok/oErzXCn1Oiq/ssWZ5ErtB+I6mgE7S9NToHqC2FnSaY0IIxd5msK3AaKhFo4Y3PHSlbYAfMLTgXxoToKhHciAqDiwtC0ZCywhbEqhgckTMfPOAcUlAqb9XPp1k4q6iVYV7WN4ZkOqAbszcygCfbDmozrk7vJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293756; c=relaxed/simple;
	bh=WT+twm8Uf99k768qpKBOGZ1/ZhOFLPhGU/CEE7PFnPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u7xZFRHn5rAkHajhhni8vUKKFU8LVqhtVl2AQJN6oE/kORsV6bqlp68e/GKklIDRaczuOsZCekhBLgfa3kckg3huZpEjiyvyhLzld1wkQnM3fCnDVhWAfbw1QynU7F05r1tjCmOOdhOXQdE5MnkxIDBKtnGA2HJ1aMCtNg4L8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFRbLJIe; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755293754; x=1786829754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WT+twm8Uf99k768qpKBOGZ1/ZhOFLPhGU/CEE7PFnPw=;
  b=NFRbLJIeSoWFZ1PkQrGffxrb+FhR/B1gxKGdIKhCRdktaj+ILxYYl8t9
   XPzyCJ6djOAzHtiZNSYcV39uF7qMZlL3yvRhR9F4BZ0mU3MfCbokLlTEA
   otW/kapHHZl8cliGCNGxOcKu1bUOGFkOALceYfTKJnHJwsnCwD9ZvQDxG
   pRzodOppGz5mVmp3kY57Oo8jVGU1GTKMIGEBsYVOK5o9uZgstH/rEsLle
   aLJDroFdFC3Fh+gVZhozDgGgzy++1hVpgJyGjGZBhJFThnliB1IOi7C9m
   tYskdRQhb++KqOEd24JRIWKDckSU0q4WDTRWJcYyNjX/eLKhZ90HMkFQs
   g==;
X-CSE-ConnectionGUID: /3To17/KSLiJyG0DqsCCTQ==
X-CSE-MsgGUID: pWbkKZiBRQOV++LKnol6nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68707459"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68707459"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:35:47 -0700
X-CSE-ConnectionGUID: lhaK5i9lQli2SWhlr0ynvA==
X-CSE-MsgGUID: +GXMbuktRMqMnyURUgzQLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166319621"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 15 Aug 2025 14:35:48 -0700
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
Subject: [PATCH V3 13/17] perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS
Date: Fri, 15 Aug 2025 14:34:31 -0700
Message-Id: <20250815213435.1702022-14-kan.liang@linux.intel.com>
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

Enable PERF_PMU_CAP_SIMD_REGS if there is XSAVES support for YMM, ZMM,
OPMASK, eGPRs, or SSP.

Disable large PEBS for these registers since PEBS HW doesn't support
them yet.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 46 ++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bd16f91dea1c..c09176400377 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4033,8 +4033,30 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 		flags &= ~PERF_SAMPLE_TIME;
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
-		flags &= ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR);
+	if (event->attr.sample_simd_regs_enabled) {
+		u64 nolarge = PERF_X86_EGPRS_MASK | BIT_ULL(PERF_REG_X86_SSP);
+
+		/*
+		 * PEBS HW can only collect the XMM0-XMM15 for now.
+		 * Disable large PEBS for other vector registers, predicate
+		 * registers, eGPRs, and SSP.
+		 */
+		if (event->attr.sample_regs_user & nolarge ||
+		    fls64(event->attr.sample_simd_vec_reg_user) > PERF_X86_H16ZMM_BASE ||
+		    event->attr.sample_simd_pred_reg_user)
+			flags &= ~PERF_SAMPLE_REGS_USER;
+
+		if (event->attr.sample_regs_intr & nolarge ||
+		    fls64(event->attr.sample_simd_vec_reg_intr) > PERF_X86_H16ZMM_BASE ||
+		    event->attr.sample_simd_pred_reg_intr)
+			flags &= ~PERF_SAMPLE_REGS_INTR;
+
+		if (event->attr.sample_simd_vec_reg_qwords > PERF_X86_XMM_QWORDS)
+			flags &= ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR);
+	} else {
+		if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
+			flags &= ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR);
+	}
 	return flags;
 }
 
@@ -5295,6 +5317,26 @@ static void intel_extended_regs_init(struct pmu *pmu)
 
 	x86_pmu.ext_regs_mask |= XFEATURE_MASK_SSE;
 	x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
+
+	if (boot_cpu_has(X86_FEATURE_AVX) &&
+	    cpu_has_xfeatures(XFEATURE_MASK_YMM, NULL))
+		x86_pmu.ext_regs_mask |= XFEATURE_MASK_YMM;
+	if (boot_cpu_has(X86_FEATURE_APX) &&
+	    cpu_has_xfeatures(XFEATURE_MASK_APX, NULL))
+		x86_pmu.ext_regs_mask |= XFEATURE_MASK_APX;
+	if (boot_cpu_has(X86_FEATURE_AVX512F)) {
+		if (cpu_has_xfeatures(XFEATURE_MASK_OPMASK, NULL))
+			x86_pmu.ext_regs_mask |= XFEATURE_MASK_OPMASK;
+		if (cpu_has_xfeatures(XFEATURE_MASK_ZMM_Hi256, NULL))
+			x86_pmu.ext_regs_mask |= XFEATURE_MASK_ZMM_Hi256;
+		if (cpu_has_xfeatures(XFEATURE_MASK_Hi16_ZMM, NULL))
+			x86_pmu.ext_regs_mask |= XFEATURE_MASK_Hi16_ZMM;
+	}
+	if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		x86_pmu.ext_regs_mask |= XFEATURE_MASK_CET_USER;
+
+	if (x86_pmu.ext_regs_mask != XFEATURE_MASK_SSE)
+		x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_SIMD_REGS;
 }
 
 static void update_pmu_cap(struct pmu *pmu)
-- 
2.38.1


