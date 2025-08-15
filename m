Return-Path: <linux-kernel+bounces-771481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCACEB287CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B0FEB64FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F04030DED1;
	Fri, 15 Aug 2025 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHs+FLxs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B4B2F9C35
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293755; cv=none; b=SH8cgyIfOQVVsJKO1ivvdreqi8hDMfQMhtIDBWCy+DIt8iEPrwFtzSpFWL0JnIpm4cLb97SiEcCr1hJpYMGlf4l3b3VYl3F2U+zSFoFRsZVwEi43d7oo7apXtSzcCre3N5oLCm3IB4cSZF/OKJvK8yXGEzWZgM+gp9xnJ3JQAPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293755; c=relaxed/simple;
	bh=zK00kmfRlCHwVjHg2vItvive4icCCJY9j1QesyHgFw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=me/+qI2dMl/IQhCNgDQ1PloZofWm3bgA5DBRcNKggwmZoe5HaXP2LG7NcqK+llc8Y0CGUGBD7zRsZtWzUdAH22zhwqc00gn5ef7xuWDTGM3Wgwo3VkoD43XEry8TXF5pprhs9E6Et7cHKrvNvugbTo5RcQYyL94ZAIVAM9oP2/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHs+FLxs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755293754; x=1786829754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zK00kmfRlCHwVjHg2vItvive4icCCJY9j1QesyHgFw4=;
  b=LHs+FLxs61lKJTF1Nf6YP6a7Jo+ZzXYMizAm/36OU6xCGluRbfdlarry
   gqF7sLYT1+Ch3allf5sXg2rN3OjcbxUoNN0t5qkWHkgerdDXGBjon3ztr
   gJ0akukXp7WWah5biKF2zPeYNPkyYntC5qx1MRbYSSpCv2EBcB49Fwiai
   DLrrjH+hIHLK2UmbL93TmjUvRrbvPPbb2KdiW5P/1/Fx9tE57NEmz25nr
   COAlncSSs3z3E5eN5ypvPMeew29TrnAxx4oxArU0TUU6qNw15KNfI37I1
   GhNlsRlvaVvHviUkbuX/uQyvDEEZJJcEl/EUSSH166wCY6NQKR3xvGGYh
   A==;
X-CSE-ConnectionGUID: p3CQqAaUSDKVyxTmzu5tww==
X-CSE-MsgGUID: ExwD0ZgMSBSPPio87jeLtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68707451"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68707451"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:35:47 -0700
X-CSE-ConnectionGUID: O5sb1IS4QQu6/APtYWUvQQ==
X-CSE-MsgGUID: z8utoMZ8RMK+oNYMNWJ/Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166319617"
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
Subject: [PATCH V3 12/17] perf/x86: Add SSP into sample_regs
Date: Fri, 15 Aug 2025 14:34:30 -0700
Message-Id: <20250815213435.1702022-13-kan.liang@linux.intel.com>
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

The SSP is only supported when the new SIMD registers configuration
method is used, which moves the XMM to sample_simd_vec_regs. So the
space can be reclaimed for the SSP.

The SSP is retrieved by XSAVE. Only support the SSP for X86_64.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c                | 14 +++++++++++++-
 arch/x86/include/asm/perf_event.h     |  4 ++++
 arch/x86/include/uapi/asm/perf_regs.h |  3 +++
 arch/x86/kernel/perf_regs.c           |  8 +++++++-
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f816290defc1..b0c8b24975cb 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -434,6 +434,8 @@ static void x86_pmu_get_ext_regs(struct x86_perf_regs *perf_regs, u64 mask)
 		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
 	if (valid_mask & XFEATURE_MASK_APX)
 		perf_regs->egpr = get_xsave_addr(xsave, XFEATURE_APX);
+	if (valid_mask & XFEATURE_MASK_CET_USER)
+		perf_regs->cet = get_xsave_addr(xsave, XFEATURE_CET_USER);
 }
 
 static void release_ext_regs_buffers(void)
@@ -712,7 +714,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 
 	if (event->attr.sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
 		if (event->attr.sample_simd_regs_enabled) {
-			u64 reserved = ~GENMASK_ULL(PERF_REG_X86_64_MAX - 1, 0);
+			u64 reserved = ~GENMASK_ULL(PERF_REG_MISC_MAX - 1, 0);
 
 			if (!(event->pmu->capabilities & PERF_PMU_CAP_SIMD_REGS))
 				return -EINVAL;
@@ -727,6 +729,11 @@ int x86_pmu_hw_config(struct perf_event *event)
 			     event->attr.sample_regs_intr & PERF_X86_EGPRS_MASK) &&
 			     !(x86_pmu.ext_regs_mask & XFEATURE_MASK_APX))
 				return -EINVAL;
+			if ((event->attr.sample_regs_user & BIT_ULL(PERF_REG_X86_SSP) ||
+			     event->attr.sample_regs_intr & BIT_ULL(PERF_REG_X86_SSP)) &&
+			     !(x86_pmu.ext_regs_mask & XFEATURE_MASK_CET_USER))
+				return -EINVAL;
+
 		} else {
 			/*
 			 * Besides the general purpose registers, XMM registers may
@@ -1904,6 +1911,11 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
 			perf_regs->egpr_regs = NULL;
 			mask |= XFEATURE_MASK_APX;
 		}
+		if (attr->sample_regs_user & BIT_ULL(PERF_REG_X86_SSP) ||
+		    attr->sample_regs_intr & BIT_ULL(PERF_REG_X86_SSP)) {
+			perf_regs->cet_regs = NULL;
+			mask |= XFEATURE_MASK_CET_USER;
+		}
 	}
 
 	mask &= ~ignore_mask;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 4400cb66bc8e..28ddff38d232 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -617,6 +617,10 @@ struct x86_perf_regs {
 		u64	*egpr_regs;
 		struct apx_state *egpr;
 	};
+	union {
+		u64	*cet_regs;
+		struct cet_user_state *cet;
+	};
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index cd0f6804debf..4d88cb18acb9 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -48,6 +48,9 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
 	PERF_REG_X86_64_MAX = PERF_REG_X86_R31 + 1,
 
+	PERF_REG_X86_SSP,
+	PERF_REG_MISC_MAX = PERF_REG_X86_SSP + 1,
+
 	/*
 	 * These all need two bits set because they are 128bit.
 	 * These are only available when !PERF_SAMPLE_REGS_ABI_SIMD
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index b6e50194ff3e..d579fa3223c0 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -92,6 +92,11 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 					return 0;
 				return perf_regs->egpr_regs[idx - PERF_REG_X86_R16];
 			}
+			if (idx == PERF_REG_X86_SSP) {
+				if (!perf_regs->cet_regs)
+					return 0;
+				return perf_regs->cet_regs[1];
+			}
 		} else {
 			if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
 				if (!perf_regs->xmm_regs)
@@ -179,7 +184,8 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 				 ~((1ULL << PERF_REG_X86_MAX) - 1))
 
 #ifdef CONFIG_X86_32
-#define REG_NOSUPPORT GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R8)
+#define REG_NOSUPPORT (GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R8) | \
+		       BIT_ULL(PERF_REG_X86_SSP))
 
 int perf_reg_validate(u64 mask)
 {
-- 
2.38.1


