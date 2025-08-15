Return-Path: <linux-kernel+bounces-771479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723EEB287CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAA9CB63F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862BA30DEA4;
	Fri, 15 Aug 2025 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jz58FO/9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5992D3229
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293754; cv=none; b=PNeIfbnX799+MIOXMrBKY7EavwUTrxXbxsmx6+7SHsnbm4SHyg3JhRIaWUknQvjmzLXbdyT4gOMpv7fMnuBqghPnMWsrAbJfceDl9+WrwdXslfxKAJYC78md3Hj6xf7h5g2YM96D/zykqLH7tr1URv7k4Z4ShBtJvy3RtBdqxn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293754; c=relaxed/simple;
	bh=kDddHfsUPu43BOSmzJScDNiehhqgbeN1X7dbmj3yB3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rg5MCbG3WId7g4Nia1Lhh2UWdXXhuGJUuEfZ1VaBII3PPVGYevuXKFzt4yBopQQTAODeBjcfaD15qZkNTrLUQ26vQ1NThrPvSS12up70PvQ9odxRtzpRfj3+H1BUMWw85eLvAVTPtkblXuqg12i5Mqbfn6/LVHklSSqgC3KEc+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jz58FO/9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755293753; x=1786829753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kDddHfsUPu43BOSmzJScDNiehhqgbeN1X7dbmj3yB3g=;
  b=Jz58FO/9gQjHHRDFli/z+ORTannYPj8XkPQ8kwUXiudYTAfZLWsy7kf7
   ogvnQF8N//ft52qD0FIY7c2t4eTMKOLIVZkFUgiSNhdVTXuHUvLkQuFx5
   bLwU1L7fE7IhuQo182i1N2X9KipDOqXbS0c8V1hFQJqETO1xQvbY84KHj
   +tKMFraVDU02s++cWD/DpOYGKYqoNLrnfb+rkdMWeHCkdk1Wv7CfIiaW5
   ZTyE0IAD1LhUJVc6mLq7NIYVAMIW7iS1dJKFC4w02Gf6Bk3f+6RAqhb5D
   GjSoHyRHryiWkJ8QEz18vY+NUrA1UUl2drv7kacsJ9MTjonhqiHNE23Z5
   A==;
X-CSE-ConnectionGUID: m98A3gFPTcyGco/heCggKA==
X-CSE-MsgGUID: MYiSbFmlS6yBNCPAA/3Mog==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68707435"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68707435"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:35:47 -0700
X-CSE-ConnectionGUID: gJJwc7bMTzuw7prbtLVEWQ==
X-CSE-MsgGUID: uCss7RiJQ3i2MPVecBu3AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166319610"
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
Subject: [PATCH V3 10/17] perf/x86: Add OPMASK into sample_simd_pred_reg
Date: Fri, 15 Aug 2025 14:34:28 -0700
Message-Id: <20250815213435.1702022-11-kan.liang@linux.intel.com>
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

The OPMASK is the SIMD's predicate registers. Add them into
sample_simd_pred_reg. The qwords of OPMASK is 1. There are 8 registers.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c                | 13 +++++++++++++
 arch/x86/include/asm/perf_event.h     |  4 ++++
 arch/x86/include/uapi/asm/perf_regs.h |  3 +++
 arch/x86/kernel/perf_regs.c           | 18 ++++++++++++++----
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 85b739fe1693..1fa550efcdfa 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -430,6 +430,8 @@ static void x86_pmu_get_ext_regs(struct x86_perf_regs *perf_regs, u64 mask)
 		perf_regs->zmmh = get_xsave_addr(xsave, XFEATURE_ZMM_Hi256);
 	if (valid_mask & XFEATURE_MASK_Hi16_ZMM)
 		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
+	if (valid_mask & XFEATURE_MASK_OPMASK)
+		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
 }
 
 static void release_ext_regs_buffers(void)
@@ -1824,6 +1826,9 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
 			data->dyn_size += hweight64(attr->sample_simd_vec_reg_user) *
 					  sizeof(u64) *
 					  attr->sample_simd_vec_reg_qwords;
+			data->dyn_size += hweight32(attr->sample_simd_pred_reg_user) *
+					  sizeof(u64) *
+					  attr->sample_simd_pred_reg_qwords;
 			data->regs_user.abi |= PERF_SAMPLE_REGS_ABI_SIMD;
 		}
 		perf_regs->abi = data->regs_user.abi;
@@ -1843,6 +1848,9 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
 			data->dyn_size += hweight64(attr->sample_simd_vec_reg_intr) *
 					  sizeof(u64) *
 					  attr->sample_simd_vec_reg_qwords;
+			data->dyn_size += hweight32(attr->sample_simd_pred_reg_intr) *
+					  sizeof(u64) *
+					  attr->sample_simd_pred_reg_qwords;
 			data->regs_intr.abi |= PERF_SAMPLE_REGS_ABI_SIMD;
 		}
 		perf_regs->abi = data->regs_intr.abi;
@@ -1868,6 +1876,11 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
 			perf_regs->h16zmm_regs = NULL;
 			mask |= XFEATURE_MASK_Hi16_ZMM;
 		}
+		if (attr->sample_simd_pred_reg_intr ||
+		    attr->sample_simd_pred_reg_user) {
+			perf_regs->opmask_regs = NULL;
+			mask |= XFEATURE_MASK_OPMASK;
+		}
 	}
 
 	mask &= ~ignore_mask;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 2d78bd9649bd..dda677022882 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -609,6 +609,10 @@ struct x86_perf_regs {
 		u64	*h16zmm_regs;
 		struct avx_512_hi16_state *h16zmm;
 	};
+	union {
+		u64	*opmask_regs;
+		struct avx_512_opmask_state *opmask;
+	};
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index f74e3ba65be2..dd7bd1dd8d39 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -55,11 +55,14 @@ enum perf_event_x86_regs {
 
 #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
 
+#define PERF_X86_SIMD_PRED_REGS_MAX	8
+#define PERF_X86_SIMD_PRED_MASK		GENMASK(PERF_X86_SIMD_PRED_REGS_MAX - 1, 0)
 #define PERF_X86_SIMD_VEC_REGS_MAX	32
 #define PERF_X86_SIMD_VEC_MASK		GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
 
 #define PERF_X86_H16ZMM_BASE		16
 
+#define PERF_X86_OPMASK_QWORDS		1
 #define PERF_X86_XMM_QWORDS		2
 #define PERF_X86_YMM_QWORDS		4
 #define PERF_X86_YMMH_QWORDS		(PERF_X86_YMM_QWORDS / 2)
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index f04c44d3d356..5e815f806605 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -75,7 +75,8 @@ void perf_simd_reg_check(struct pt_regs *regs,
 	if (*nr_vectors > PERF_X86_H16ZMM_BASE && !perf_regs->h16zmm_regs)
 		*nr_vectors = PERF_X86_H16ZMM_BASE;
 
-	*nr_pred = 0;
+	if (*nr_pred && !perf_regs->opmask_regs)
+		*nr_pred = 0;
 }
 
 u64 perf_reg_value(struct pt_regs *regs, int idx)
@@ -103,8 +104,14 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 {
 	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
 
-	if (pred)
-		return 0;
+	if (pred) {
+		if (WARN_ON_ONCE(idx >= PERF_X86_SIMD_PRED_REGS_MAX ||
+				 qwords_idx >= PERF_X86_OPMASK_QWORDS))
+			return 0;
+		if (!perf_regs->opmask_regs)
+			return 0;
+		return perf_regs->opmask_regs[idx];
+	}
 
 	if (WARN_ON_ONCE(idx >= PERF_X86_SIMD_VEC_REGS_MAX ||
 			 qwords_idx >= PERF_X86_SIMD_QWORDS_MAX))
@@ -151,7 +158,10 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 		if (vec_mask & ~PERF_X86_SIMD_VEC_MASK)
 			return -EINVAL;
 	}
-	if (pred_mask)
+
+	if (pred_qwords != PERF_X86_OPMASK_QWORDS)
+		return -EINVAL;
+	if (pred_mask & ~PERF_X86_SIMD_PRED_MASK)
 		return -EINVAL;
 
 	return 0;
-- 
2.38.1


