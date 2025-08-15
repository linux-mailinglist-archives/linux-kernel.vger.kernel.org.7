Return-Path: <linux-kernel+bounces-771475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3864DB287C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B693AE869F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204402D375B;
	Fri, 15 Aug 2025 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KkQ0oUb5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FF627F01B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293752; cv=none; b=S0+JnsT4h1zky815ibSXgYlJo36M0iIMm4O4SAGW2vY+nY3TtYJBi/vDrx3llii4mBVdSp1ZECdJatKhqPAJLw76Cn7UeZPUFRzivWXGr5YJTON6qPeuzv9QqIaSOyXhBfWFgE/VD+a9waggUQk1j1neRx8jgFPHUyI0MrjKhDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293752; c=relaxed/simple;
	bh=YgpTfTUmFFvdAT5UJK9nUhKQ5ZCDVu2ZiRZaDeutoLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZH5mUXhljIh2CGZch9lCsM4Gcy4kmRiJd+6TiTy/2c2P/xihqyM2QfqUZp6+5hAn6/wwIGxgXz1rerjHHpCzvVvu4GAexGjA/xC40IWa+M07HUYyrn+yLYwl30Kg6Y1UQGb0pOQukU23ve63EAbax2Bjt3HheXc0BTuRPUVQGVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KkQ0oUb5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755293750; x=1786829750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YgpTfTUmFFvdAT5UJK9nUhKQ5ZCDVu2ZiRZaDeutoLU=;
  b=KkQ0oUb5Gq6Zq9mwRg9fI5IZBhrvlDisknBnfxV4uKsLi1aCUi1MnXO2
   qxDd5q1LTlbRZZrDnYtMUeBB3ugf22AiUhhpEl1O7rNGnYG8vhBoPruOY
   21q35kURbuw26KQAmxe0ggfd8tXhJnQZGwPwRk6GoYrUuUxhMRZmsmnGE
   Ztq1QANqPX26dtwRFzD3iYVOhpxbA7PPuS5K/GkQ3Sh3T9HUKNUIeO3Ti
   t78VMCGhLFweD9WAJN52NljnnKurLjTJ0X1BnUoMrdhPJibFUSUPt52DN
   zlcZaYmYZ4Wsj9tubJisvrCEV3ErSZ56yt+GEFcrafRylAmTW+nafWkgo
   g==;
X-CSE-ConnectionGUID: 5O64e/nxS7ep/WGsiMtaow==
X-CSE-MsgGUID: gD+K0hV9Ro+C3B08t9rTMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68707410"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68707410"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:35:46 -0700
X-CSE-ConnectionGUID: GXvbfZqmRHSMXmDd4TE77A==
X-CSE-MsgGUID: QRlPCb2zT/W9GPDZ8HV/bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166319599"
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
Subject: [PATCH V3 07/17] perf/x86: Move XMM to sample_simd_vec_regs
Date: Fri, 15 Aug 2025 14:34:25 -0700
Message-Id: <20250815213435.1702022-8-kan.liang@linux.intel.com>
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

The XMM0-15 are SIMD registers. Move them from sample_regs to
sample_simd_vec_regs. Reject access to the extended space of the sample_regs
if the new sample_simd_vec_regs is used.

The perf_reg_value requires the abi to understand the layout of the
sample_regs. Add the abi information in the struct x86_perf_regs.

Implement the X86-specific perf_simd_reg_validate to validate the SIMD
registers configuration from the user tool. Only the XMM0-15 is
supported now. More registers will be added in the following patches.
Implement the X86-specific perf_simd_reg_value to retrieve the XMM
value.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c                | 38 ++++++++++++++++-
 arch/x86/events/intel/ds.c            |  2 +-
 arch/x86/events/perf_event.h          | 12 ++++++
 arch/x86/include/asm/perf_event.h     |  1 +
 arch/x86/include/uapi/asm/perf_regs.h |  6 +++
 arch/x86/kernel/perf_regs.c           | 61 ++++++++++++++++++++++++++-
 6 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f27c58f4c815..1789b91c95c6 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -709,6 +709,22 @@ int x86_pmu_hw_config(struct perf_event *event)
 				return -EINVAL;
 			if (!(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
 				return -EINVAL;
+			if (event->attr.sample_simd_regs_enabled)
+				return -EINVAL;
+		}
+
+		if (event_has_simd_regs(event)) {
+			if (!(event->pmu->capabilities & PERF_PMU_CAP_SIMD_REGS))
+				return -EINVAL;
+			/* Not require any vector registers but set width */
+			if (event->attr.sample_simd_vec_reg_qwords &&
+			    !event->attr.sample_simd_vec_reg_intr &&
+			    !event->attr.sample_simd_vec_reg_user)
+				return -EINVAL;
+			/* The vector registers set is not supported */
+			if (event->attr.sample_simd_vec_reg_qwords >= PERF_X86_XMM_QWORDS &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
+				return -EINVAL;
 		}
 	}
 	return x86_setup_perfctr(event);
@@ -1784,6 +1800,16 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
 		data->dyn_size += sizeof(u64);
 		if (data->regs_user.regs)
 			data->dyn_size += hweight64(attr->sample_regs_user) * sizeof(u64);
+		if (attr->sample_simd_regs_enabled && data->regs_user.abi) {
+			/* num and qwords of vector and pred registers */
+			data->dyn_size += sizeof(u64);
+			/* data[] */
+			data->dyn_size += hweight64(attr->sample_simd_vec_reg_user) *
+					  sizeof(u64) *
+					  attr->sample_simd_vec_reg_qwords;
+			data->regs_user.abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+		}
+		perf_regs->abi = data->regs_user.abi;
 		data->sample_flags |= PERF_SAMPLE_REGS_USER;
 	}
 
@@ -1793,10 +1819,20 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
 		data->dyn_size += sizeof(u64);
 		if (data->regs_intr.regs)
 			data->dyn_size += hweight64(attr->sample_regs_intr) * sizeof(u64);
+		if (attr->sample_simd_regs_enabled && data->regs_intr.abi) {
+			/* num and qwords of vector and pred registers */
+			data->dyn_size += sizeof(u64);
+			/* data[] */
+			data->dyn_size += hweight64(attr->sample_simd_vec_reg_intr) *
+					  sizeof(u64) *
+					  attr->sample_simd_vec_reg_qwords;
+			data->regs_intr.abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+		}
+		perf_regs->abi = data->regs_intr.abi;
 		data->sample_flags |= PERF_SAMPLE_REGS_INTR;
 	}
 
-	if (event_has_extended_regs(event)) {
+	if (event_needs_xmm(event)) {
 		perf_regs->xmm_regs = NULL;
 		mask |= XFEATURE_MASK_SSE;
 	}
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 9cdece014ac0..4887f6ea7dde 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1415,7 +1415,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	if (gprs || (attr->precise_ip < 2) || tsx_weight)
 		pebs_data_cfg |= PEBS_DATACFG_GP;
 
-	if (event_has_extended_regs(event))
+	if (event_needs_xmm(event))
 		pebs_data_cfg |= PEBS_DATACFG_XMMS;
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 7bf24842b1dc..6f22ed718a75 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -133,6 +133,18 @@ static inline bool is_acr_event_group(struct perf_event *event)
 	return check_leader_group(event->group_leader, PERF_X86_EVENT_ACR);
 }
 
+static inline bool event_needs_xmm(struct perf_event *event)
+{
+	if (event->attr.sample_simd_regs_enabled &&
+	    event->attr.sample_simd_vec_reg_qwords >= PERF_X86_XMM_QWORDS)
+		return true;
+
+	if (!event->attr.sample_simd_regs_enabled &&
+	    event_has_extended_regs(event))
+		return true;
+	return false;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index f36f04bc95f1..538219c59979 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -592,6 +592,7 @@ extern void perf_events_lapic_init(void);
 struct pt_regs;
 struct x86_perf_regs {
 	struct pt_regs	regs;
+	u64		abi;
 	union {
 		u64	*xmm_regs;
 		u32	*xmm_space;	/* for xsaves */
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index 7c9d2bb3833b..bd8af802f757 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -55,4 +55,10 @@ enum perf_event_x86_regs {
 
 #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
 
+#define PERF_X86_SIMD_VEC_REGS_MAX	16
+#define PERF_X86_SIMD_VEC_MASK		GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
+
+#define PERF_X86_XMM_QWORDS		2
+#define PERF_X86_SIMD_QWORDS_MAX	PERF_X86_XMM_QWORDS
+
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 624703af80a1..397357c5896b 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -57,12 +57,27 @@ static unsigned int pt_regs_offset[PERF_REG_X86_MAX] = {
 #endif
 };
 
+void perf_simd_reg_check(struct pt_regs *regs,
+			 u64 mask, u16 *nr_vectors, u16 *vec_qwords,
+			 u16 pred_mask, u16 *nr_pred, u16 *pred_qwords)
+{
+	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
+
+	if (*vec_qwords >= PERF_X86_XMM_QWORDS && !perf_regs->xmm_regs)
+		*nr_vectors = 0;
+
+	*nr_pred = 0;
+}
+
 u64 perf_reg_value(struct pt_regs *regs, int idx)
 {
 	struct x86_perf_regs *perf_regs;
 
 	if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
 		perf_regs = container_of(regs, struct x86_perf_regs, regs);
+		/* SIMD registers are moved to dedicated sample_simd_vec_reg */
+		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
+			return 0;
 		if (!perf_regs->xmm_regs)
 			return 0;
 		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
@@ -74,6 +89,49 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	return regs_get_register(regs, pt_regs_offset[idx]);
 }
 
+u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
+			u16 qwords_idx, bool pred)
+{
+	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
+
+	if (pred)
+		return 0;
+
+	if (WARN_ON_ONCE(idx >= PERF_X86_SIMD_VEC_REGS_MAX ||
+			 qwords_idx >= PERF_X86_SIMD_QWORDS_MAX))
+		return 0;
+
+	if (qwords_idx < PERF_X86_XMM_QWORDS) {
+		if (!perf_regs->xmm_regs)
+			return 0;
+		return perf_regs->xmm_regs[idx * PERF_X86_XMM_QWORDS + qwords_idx];
+	}
+
+	return 0;
+}
+
+int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
+			   u16 pred_qwords, u32 pred_mask)
+{
+	/* pred_qwords implies sample_simd_{pred,vec}_reg_* are supported */
+	if (!pred_qwords)
+		return 0;
+
+	if (!vec_qwords) {
+		if (vec_mask)
+			return -EINVAL;
+	} else {
+		if (vec_qwords != PERF_X86_XMM_QWORDS)
+			return -EINVAL;
+		if (vec_mask & ~PERF_X86_SIMD_VEC_MASK)
+			return -EINVAL;
+	}
+	if (pred_mask)
+		return -EINVAL;
+
+	return 0;
+}
+
 #define PERF_REG_X86_RESERVED	(((1ULL << PERF_REG_X86_XMM0) - 1) & \
 				 ~((1ULL << PERF_REG_X86_MAX) - 1))
 
@@ -114,7 +172,8 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 
 int perf_reg_validate(u64 mask)
 {
-	if (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED)))
+	/* The mask could be 0 if only the SIMD registers are interested */
+	if (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))
 		return -EINVAL;
 
 	return 0;
-- 
2.38.1


