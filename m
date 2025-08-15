Return-Path: <linux-kernel+bounces-771478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C9BB287C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA921AE1D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EFE304BAA;
	Fri, 15 Aug 2025 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kcCjYJOU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFA52C0F84
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293754; cv=none; b=P1tJtFMh8P5MF9da5esuUHgcYELuSmAc54Rh3TksfClu1qacXl72a+JQOcdkjwyvTIk7X63b6/5FTghMT0lPW+jh9ZNlqbJcQP96S6MMR2a6xAftggWB8VKzazY7+aME21PnvWvchMbFAdHKeCgHuzFxz0VQdYYMNBc8XFtolCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293754; c=relaxed/simple;
	bh=65QRemEGqKZDYP445qWHAGhZ6ykDc+ZyhHM+PxueYOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WlPIDfIsPWsIbJyXARBV27YKEf8TlGt/rbgB3UZGyCKEIwbFbmH4tHvHc++gK4zzfwUjOECkdbKB9goSAUZsnGW/uTQ7F/KglSfoY6pJvbFD5yzMCDnzgxWOC3ZXS6lgGSXKsY37Ev48FJs3c2/Bk3uH9Fs9BapVGlAuM5yZklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kcCjYJOU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755293752; x=1786829752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=65QRemEGqKZDYP445qWHAGhZ6ykDc+ZyhHM+PxueYOY=;
  b=kcCjYJOUF+jZxAHrRcW8ln3q9YGMP/4jLmBl5GXHR6ziUNYv11o/4T3R
   SeirgKnPVbNrqroTA+pKYjcrg/KbttnLT7kBSMMNODNaF0UEnHijG+pb5
   oejwob/Xa+mXUVy3iOzFgMlqb/FG7tzWS5HqM9bVHUCQi/ID2uJejty0u
   VyAUWTChqyZa83OggdSqqLia33OIAqnCGqRlTj+5m3UXpAQvKg22j8GPm
   Hny0D3L6B6sWVqrUA3EJWfDSp2uWBawuC31abXMrC/zVrVt3DI62WFZ2I
   JHe/G1wc44aVbnnP9osH2UCFZ9/XGci6nlyN2+PV5WTvC+hNCsm0P+DjD
   g==;
X-CSE-ConnectionGUID: a4y0fO1VSHyzSFLYUe8a8w==
X-CSE-MsgGUID: QNhhX6WPTyy40GNOKUhXJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68707427"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68707427"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:35:46 -0700
X-CSE-ConnectionGUID: 9blzD+GUR/KJ53FOz+Y9UA==
X-CSE-MsgGUID: 0msfRi0BSq+IXIuwVJsKjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166319606"
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
Subject: [PATCH V3 09/17] perf/x86: Add ZMM into sample_simd_vec_regs
Date: Fri, 15 Aug 2025 14:34:27 -0700
Message-Id: <20250815213435.1702022-10-kan.liang@linux.intel.com>
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

The ZMM0-15 is composed of XMM, YMMH, and ZMMH. It requires 3 XSAVE
commands to get the complete value.
The ZMM16-31/YMM16-31/XMM16-31 are also supported, which only require
the XSAVE Hi16_ZMM.

Internally, the XMM, YMMH, ZMMH and Hi16_ZMM are stored in different
structures, which follow the XSAVE format. But the output dumps the ZMM
or Hi16 XMM/YMM/ZMM as a whole.

The qwords 8 imply ZMM.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c                | 20 ++++++++++++++++++++
 arch/x86/include/asm/perf_event.h     |  8 ++++++++
 arch/x86/include/uapi/asm/perf_regs.h |  8 ++++++--
 arch/x86/kernel/perf_regs.c           | 19 ++++++++++++++++++-
 4 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index aebd4e56dff1..85b739fe1693 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -426,6 +426,10 @@ static void x86_pmu_get_ext_regs(struct x86_perf_regs *perf_regs, u64 mask)
 
 	if (valid_mask & XFEATURE_MASK_YMM)
 		perf_regs->ymmh = get_xsave_addr(xsave, XFEATURE_YMM);
+	if (valid_mask & XFEATURE_MASK_ZMM_Hi256)
+		perf_regs->zmmh = get_xsave_addr(xsave, XFEATURE_ZMM_Hi256);
+	if (valid_mask & XFEATURE_MASK_Hi16_ZMM)
+		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
 }
 
 static void release_ext_regs_buffers(void)
@@ -731,6 +735,13 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event->attr.sample_simd_vec_reg_qwords >= PERF_X86_YMM_QWORDS &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_YMM))
 				return -EINVAL;
+			if (event->attr.sample_simd_vec_reg_qwords >= PERF_X86_ZMM_QWORDS &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_ZMM_Hi256))
+				return -EINVAL;
+			if ((fls64(event->attr.sample_simd_vec_reg_intr) > PERF_X86_H16ZMM_BASE ||
+			     fls64(event->attr.sample_simd_vec_reg_user) > PERF_X86_H16ZMM_BASE) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_Hi16_ZMM))
+				return -EINVAL;
 		}
 	}
 	return x86_setup_perfctr(event);
@@ -1848,6 +1859,15 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
 			perf_regs->ymmh_regs = NULL;
 			mask |= XFEATURE_MASK_YMM;
 		}
+		if (attr->sample_simd_vec_reg_qwords >= PERF_X86_ZMM_QWORDS) {
+			perf_regs->zmmh_regs = NULL;
+			mask |= XFEATURE_MASK_ZMM_Hi256;
+		}
+		if (fls64(attr->sample_simd_vec_reg_intr) > PERF_X86_H16ZMM_BASE ||
+		    fls64(attr->sample_simd_vec_reg_user) > PERF_X86_H16ZMM_BASE) {
+			perf_regs->h16zmm_regs = NULL;
+			mask |= XFEATURE_MASK_Hi16_ZMM;
+		}
 	}
 
 	mask &= ~ignore_mask;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 81e3143fd91a..2d78bd9649bd 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -601,6 +601,14 @@ struct x86_perf_regs {
 		u64	*ymmh_regs;
 		struct ymmh_struct *ymmh;
 	};
+	union {
+		u64	*zmmh_regs;
+		struct avx_512_zmm_uppers_state *zmmh;
+	};
+	union {
+		u64	*h16zmm_regs;
+		struct avx_512_hi16_state *h16zmm;
+	};
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index feb3e8f80761..f74e3ba65be2 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -55,12 +55,16 @@ enum perf_event_x86_regs {
 
 #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
 
-#define PERF_X86_SIMD_VEC_REGS_MAX	16
+#define PERF_X86_SIMD_VEC_REGS_MAX	32
 #define PERF_X86_SIMD_VEC_MASK		GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
 
+#define PERF_X86_H16ZMM_BASE		16
+
 #define PERF_X86_XMM_QWORDS		2
 #define PERF_X86_YMM_QWORDS		4
 #define PERF_X86_YMMH_QWORDS		(PERF_X86_YMM_QWORDS / 2)
-#define PERF_X86_SIMD_QWORDS_MAX	PERF_X86_YMM_QWORDS
+#define PERF_X86_ZMM_QWORDS		8
+#define PERF_X86_ZMMH_QWORDS		(PERF_X86_ZMM_QWORDS / 2)
+#define PERF_X86_SIMD_QWORDS_MAX	PERF_X86_ZMM_QWORDS
 
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index d94bc687e4bf..f04c44d3d356 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -69,6 +69,12 @@ void perf_simd_reg_check(struct pt_regs *regs,
 	if (*vec_qwords >= PERF_X86_YMM_QWORDS && !perf_regs->xmm_regs)
 		*vec_qwords = PERF_X86_XMM_QWORDS;
 
+	if (*vec_qwords >= PERF_X86_ZMM_QWORDS && !perf_regs->zmmh_regs)
+		*vec_qwords = PERF_X86_YMM_QWORDS;
+
+	if (*nr_vectors > PERF_X86_H16ZMM_BASE && !perf_regs->h16zmm_regs)
+		*nr_vectors = PERF_X86_H16ZMM_BASE;
+
 	*nr_pred = 0;
 }
 
@@ -104,6 +110,12 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 			 qwords_idx >= PERF_X86_SIMD_QWORDS_MAX))
 		return 0;
 
+	if (idx >= PERF_X86_H16ZMM_BASE) {
+		if (!perf_regs->h16zmm_regs)
+			return 0;
+		return perf_regs->h16zmm_regs[idx * PERF_X86_ZMM_QWORDS + qwords_idx];
+	}
+
 	if (qwords_idx < PERF_X86_XMM_QWORDS) {
 		if (!perf_regs->xmm_regs)
 			return 0;
@@ -112,6 +124,10 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 		if (!perf_regs->ymmh_regs)
 			return 0;
 		return perf_regs->ymmh_regs[idx * PERF_X86_YMMH_QWORDS + qwords_idx - PERF_X86_XMM_QWORDS];
+	} else if (qwords_idx < PERF_X86_ZMM_QWORDS) {
+		if (!perf_regs->zmmh_regs)
+			return 0;
+		return perf_regs->zmmh_regs[idx * PERF_X86_ZMMH_QWORDS + qwords_idx - PERF_X86_YMM_QWORDS];
 	}
 
 	return 0;
@@ -129,7 +145,8 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 			return -EINVAL;
 	} else {
 		if (vec_qwords != PERF_X86_XMM_QWORDS &&
-		    vec_qwords != PERF_X86_YMM_QWORDS)
+		    vec_qwords != PERF_X86_YMM_QWORDS &&
+		    vec_qwords != PERF_X86_ZMM_QWORDS)
 			return -EINVAL;
 		if (vec_mask & ~PERF_X86_SIMD_VEC_MASK)
 			return -EINVAL;
-- 
2.38.1


