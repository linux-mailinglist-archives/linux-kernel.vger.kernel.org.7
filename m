Return-Path: <linux-kernel+bounces-771477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71779B287C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8981EAE4CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADCA2F9C3A;
	Fri, 15 Aug 2025 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RbSSIO1G"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7BC2BF3FB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293753; cv=none; b=SokwHzD0M9uUtGHtArq58LEDRhKNbNBcHd5tBbBYFUaT7JF2e4qfRlqbLa4ai9b5CRZ4fQWY0+2SEAsGTxRDiB8VIknaLwjL57GBQkYSyT+lYoWqRuGIeqm15DE+6CgmrfG9B6BQolYQOsoCnmuOVqYvZWY2mI+3aNEPiF3pOf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293753; c=relaxed/simple;
	bh=KnrEIK0Hu7VGXUlHrHcXxvD5+aCqJwlBbWbx/FuwhxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uasOFuhNM7SR3dA9kULxFTcegOrZ+Hcv+dRVq4l/jqehdOjS/biedp7DAZpUKomy4hIdg73ZLGI39RJ9vlCMckJeVMCg+QqR+zWgz+Fsf3faOC8Qo5g7wDcrfvN+Dlt/Q0VyxF37cGc+bPoTc1yiJV5KcIDCtAdhZPASwf9BErU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RbSSIO1G; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755293751; x=1786829751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KnrEIK0Hu7VGXUlHrHcXxvD5+aCqJwlBbWbx/FuwhxU=;
  b=RbSSIO1GJoPLulfWODXlUncua5avehvEDyLeACDoGUyJzC047doya5y1
   NEQtMO7I+xTV1mi9n9f9ZcZPWvk5L2DoHg5i1UKx8j/KcpbLEZsUk29cz
   RvRDAd+WQnkiulyN9FHI4M5WhFyKo7luhrdrRjwoy7/x10hcwRJ77anD4
   Hwo1mQ5vlEK8q/WqRSp92cJpOsRECOk3J7tPBIAvT0vpsL3shmdldHCt5
   9IozzDcHtP9aqpDUntQsZ9IYWZQz0yUOH6h7Jlvu6l9FyGlEU44nZldSY
   IFJhyIuPULWGUOzaXRAzShMWYqmRWBYw/eVN8TXR/NyXADLj2ctT38+9G
   Q==;
X-CSE-ConnectionGUID: E7txgLHxRe+L1MDk7GQ4GQ==
X-CSE-MsgGUID: ECGx4OYQRjuLYvCOtN84tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68707418"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68707418"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:35:46 -0700
X-CSE-ConnectionGUID: 2wKQkEqkSc2v/v+xxhLsYg==
X-CSE-MsgGUID: 83dP9wF/S+WlwTjF94FlKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166319603"
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
Subject: [PATCH V3 08/17] perf/x86: Add YMM into sample_simd_vec_regs
Date: Fri, 15 Aug 2025 14:34:26 -0700
Message-Id: <20250815213435.1702022-9-kan.liang@linux.intel.com>
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

The YMM0-15 is composed of XMM and YMMH. It requires 2 XSAVE commands to
get the complete value. Internally, the XMM and YMMH are stored in
different structures, which follow the XSAVE format. But the output
dumps the YMM as a whole.

The qwords 4 imply YMM.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c                | 13 +++++++++++++
 arch/x86/include/asm/perf_event.h     |  4 ++++
 arch/x86/include/uapi/asm/perf_regs.h |  4 +++-
 arch/x86/kernel/perf_regs.c           | 10 +++++++++-
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1789b91c95c6..aebd4e56dff1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -423,6 +423,9 @@ static void x86_pmu_get_ext_regs(struct x86_perf_regs *perf_regs, u64 mask)
 
 	if (valid_mask & XFEATURE_MASK_SSE)
 		perf_regs->xmm_space = xsave->i387.xmm_space;
+
+	if (valid_mask & XFEATURE_MASK_YMM)
+		perf_regs->ymmh = get_xsave_addr(xsave, XFEATURE_YMM);
 }
 
 static void release_ext_regs_buffers(void)
@@ -725,6 +728,9 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event->attr.sample_simd_vec_reg_qwords >= PERF_X86_XMM_QWORDS &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
 				return -EINVAL;
+			if (event->attr.sample_simd_vec_reg_qwords >= PERF_X86_YMM_QWORDS &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_YMM))
+				return -EINVAL;
 		}
 	}
 	return x86_setup_perfctr(event);
@@ -1837,6 +1843,13 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
 		mask |= XFEATURE_MASK_SSE;
 	}
 
+	if (attr->sample_simd_regs_enabled) {
+		if (attr->sample_simd_vec_reg_qwords >= PERF_X86_YMM_QWORDS) {
+			perf_regs->ymmh_regs = NULL;
+			mask |= XFEATURE_MASK_YMM;
+		}
+	}
+
 	mask &= ~ignore_mask;
 	if (mask)
 		x86_pmu_get_ext_regs(perf_regs, mask);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 538219c59979..81e3143fd91a 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -597,6 +597,10 @@ struct x86_perf_regs {
 		u64	*xmm_regs;
 		u32	*xmm_space;	/* for xsaves */
 	};
+	union {
+		u64	*ymmh_regs;
+		struct ymmh_struct *ymmh;
+	};
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index bd8af802f757..feb3e8f80761 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -59,6 +59,8 @@ enum perf_event_x86_regs {
 #define PERF_X86_SIMD_VEC_MASK		GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
 
 #define PERF_X86_XMM_QWORDS		2
-#define PERF_X86_SIMD_QWORDS_MAX	PERF_X86_XMM_QWORDS
+#define PERF_X86_YMM_QWORDS		4
+#define PERF_X86_YMMH_QWORDS		(PERF_X86_YMM_QWORDS / 2)
+#define PERF_X86_SIMD_QWORDS_MAX	PERF_X86_YMM_QWORDS
 
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 397357c5896b..d94bc687e4bf 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -66,6 +66,9 @@ void perf_simd_reg_check(struct pt_regs *regs,
 	if (*vec_qwords >= PERF_X86_XMM_QWORDS && !perf_regs->xmm_regs)
 		*nr_vectors = 0;
 
+	if (*vec_qwords >= PERF_X86_YMM_QWORDS && !perf_regs->xmm_regs)
+		*vec_qwords = PERF_X86_XMM_QWORDS;
+
 	*nr_pred = 0;
 }
 
@@ -105,6 +108,10 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 		if (!perf_regs->xmm_regs)
 			return 0;
 		return perf_regs->xmm_regs[idx * PERF_X86_XMM_QWORDS + qwords_idx];
+	} else if (qwords_idx < PERF_X86_YMM_QWORDS) {
+		if (!perf_regs->ymmh_regs)
+			return 0;
+		return perf_regs->ymmh_regs[idx * PERF_X86_YMMH_QWORDS + qwords_idx - PERF_X86_XMM_QWORDS];
 	}
 
 	return 0;
@@ -121,7 +128,8 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 		if (vec_mask)
 			return -EINVAL;
 	} else {
-		if (vec_qwords != PERF_X86_XMM_QWORDS)
+		if (vec_qwords != PERF_X86_XMM_QWORDS &&
+		    vec_qwords != PERF_X86_YMM_QWORDS)
 			return -EINVAL;
 		if (vec_mask & ~PERF_X86_SIMD_VEC_MASK)
 			return -EINVAL;
-- 
2.38.1


