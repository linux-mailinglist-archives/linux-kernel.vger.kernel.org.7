Return-Path: <linux-kernel+bounces-771476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6820B287CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA4160398E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AECE2F9C44;
	Fri, 15 Aug 2025 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DhLuV1r2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83B5263C8E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293753; cv=none; b=SEF308Py7nC2YHdY/5cduTS+WUZZakKW3viVoN0kOxVKpA+kKFRUMlOYzUJfk7U/B3K9k76/TT/3dIKpmjoOLWJNIHJPHx/s8SEw7hyd7O+FuECgHYFxffm67WebMICqyRkrm0IhjUBxUse/5I8BflW8GgYRnw8AEPOvQ9PF2ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293753; c=relaxed/simple;
	bh=OdsJzI8AoRa0uBrHbrllbXEbNLO0NsFCOL9QXfWDtWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j4pp28Ubuo+32em/EkBCxxjwZVPGqaGkhF94BKP/blijb/1AkjjwrIdISF9C4D1COpjlFA8aErLtdY6N9D0HOwaXRB7Calqv82u2GxF7qjIyDGVgQJETMdkah4xVH9JVsk+st+2iKcBvupa+tGHvyoMpdtiODjfNmj2q8BY7PpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DhLuV1r2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755293749; x=1786829749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OdsJzI8AoRa0uBrHbrllbXEbNLO0NsFCOL9QXfWDtWk=;
  b=DhLuV1r24c4XiZnpcYLIK/nf6mIyElbz/hSTPQ1hlErn5ktsdmpvWt8+
   sctwNgl/8yzMl8pVreZzhCJJIGyh9ECRVTtb7WNpqk4Sm5WNRLboPFDRf
   S0icz5wvYdfbO9zGNopbBM3DOgdQVFKnBLnre77IFqtUNwmk3drf1iLEC
   89eCtPvdQ6idRLTI8qEoPbkjp2/TK1jl46WsT+N1xUm54RIyjDDvdKPGU
   YNSV2/J0F3L6djNqcPqfKTVRjWjSYEmUZwdGwN1Y6LXtbJmSFIUhtINhu
   RJ5pkSwQ0mAQ64HW37sgkIrJ+oZMxGpe7hIKUShkhOA9BT9Vfy8aY2Pxn
   g==;
X-CSE-ConnectionGUID: lcxiyuq+SuSAn13HhwYMbw==
X-CSE-MsgGUID: XfMvE5EASX6fwGDIjFVVjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68707394"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68707394"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:35:46 -0700
X-CSE-ConnectionGUID: QqqqU16CTr6G1diA/23yVw==
X-CSE-MsgGUID: g1YkZflqSzOmt4xzLEMRaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166319592"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 15 Aug 2025 14:35:46 -0700
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
Subject: [PATCH V3 05/17] perf/x86: Support XMM register for non-PEBS and REGS_USER
Date: Fri, 15 Aug 2025 14:34:23 -0700
Message-Id: <20250815213435.1702022-6-kan.liang@linux.intel.com>
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

Collecting the XMM registers in a PEBS record has been supported since
the Icelake. But non-PEBS events don't support the feature. It's
possible to retrieve the XMM registers from the XSAVE for non-PEBS.
Add it to make the feature complete.

To utilize the XSAVE, a 64-byte aligned buffer is required. Add a
per-CPU ext_regs_buf to store the vector registers. The size of the
buffer is ~2K. kzalloc_node() is used because there's a _guarantee_
that all kmalloc()'s with powers of 2 are naturally aligned and also
64b aligned.

Extend the support for both REGS_USER and REGS_INTR. For REGS_USER, the
perf_get_regs_user() returns the regs from the task_pt_regs(current),
which is struct pt_regs. Need to move it to local struct x86_perf_regs
x86_user_regs.
For PEBS, the HW support is still preferred. The XMM should be retrieved
from PEBS records.

There could be more vector registers supported later. Add ext_regs_mask
to track the supported vector register group.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c            | 127 +++++++++++++++++++++++++-----
 arch/x86/events/intel/core.c      |  27 +++++++
 arch/x86/events/intel/ds.c        |  10 ++-
 arch/x86/events/perf_event.h      |   9 ++-
 arch/x86/include/asm/fpu/xstate.h |   2 +
 arch/x86/include/asm/perf_event.h |   5 +-
 arch/x86/kernel/fpu/xstate.c      |   2 +-
 7 files changed, 157 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c601ad761534..f27c58f4c815 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -406,6 +406,61 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
 	return x86_pmu_extra_regs(val, event);
 }
 
+static DEFINE_PER_CPU(struct xregs_state *, ext_regs_buf);
+
+static void x86_pmu_get_ext_regs(struct x86_perf_regs *perf_regs, u64 mask)
+{
+	struct xregs_state *xsave = per_cpu(ext_regs_buf, smp_processor_id());
+	u64 valid_mask = x86_pmu.ext_regs_mask & mask;
+
+	if (WARN_ON_ONCE(!xsave))
+		return;
+
+	xsaves_nmi(xsave, valid_mask);
+
+	/* Filtered by what XSAVE really gives */
+	valid_mask &= xsave->header.xfeatures;
+
+	if (valid_mask & XFEATURE_MASK_SSE)
+		perf_regs->xmm_space = xsave->i387.xmm_space;
+}
+
+static void release_ext_regs_buffers(void)
+{
+	int cpu;
+
+	if (!x86_pmu.ext_regs_mask)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		kfree(per_cpu(ext_regs_buf, cpu));
+		per_cpu(ext_regs_buf, cpu) = NULL;
+	}
+}
+
+static void reserve_ext_regs_buffers(void)
+{
+	unsigned int size;
+	int cpu;
+
+	if (!x86_pmu.ext_regs_mask)
+		return;
+
+	size = xstate_calculate_size(x86_pmu.ext_regs_mask, true);
+
+	for_each_possible_cpu(cpu) {
+		per_cpu(ext_regs_buf, cpu) = kzalloc_node(size, GFP_KERNEL,
+							  cpu_to_node(cpu));
+		if (!per_cpu(ext_regs_buf, cpu))
+			goto err;
+	}
+
+	return;
+
+err:
+	release_ext_regs_buffers();
+}
+
 int x86_reserve_hardware(void)
 {
 	int err = 0;
@@ -418,6 +473,7 @@ int x86_reserve_hardware(void)
 			} else {
 				reserve_ds_buffers();
 				reserve_lbr_buffers();
+				reserve_ext_regs_buffers();
 			}
 		}
 		if (!err)
@@ -434,6 +490,7 @@ void x86_release_hardware(void)
 		release_pmc_hardware();
 		release_ds_buffers();
 		release_lbr_buffers();
+		release_ext_regs_buffers();
 		mutex_unlock(&pmc_reserve_mutex);
 	}
 }
@@ -642,21 +699,18 @@ int x86_pmu_hw_config(struct perf_event *event)
 			return -EINVAL;
 	}
 
-	/* sample_regs_user never support XMM registers */
-	if (unlikely(event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK))
-		return -EINVAL;
-	/*
-	 * Besides the general purpose registers, XMM registers may
-	 * be collected in PEBS on some platforms, e.g. Icelake
-	 */
-	if (unlikely(event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK)) {
-		if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
-			return -EINVAL;
-
-		if (!event->attr.precise_ip)
-			return -EINVAL;
+	if (event->attr.sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
+		/*
+		 * Besides the general purpose registers, XMM registers may
+		 * be collected as well.
+		 */
+		if (event_has_extended_regs(event)) {
+			if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
+				return -EINVAL;
+			if (!(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
+				return -EINVAL;
+		}
 	}
-
 	return x86_setup_perfctr(event);
 }
 
@@ -1685,25 +1739,51 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	static_call_cond(x86_pmu_del)(event);
 }
 
+static DEFINE_PER_CPU(struct x86_perf_regs, x86_user_regs);
+
+static struct x86_perf_regs *
+x86_pmu_perf_get_regs_user(struct perf_sample_data *data,
+			   struct pt_regs *regs)
+{
+	struct x86_perf_regs *x86_regs_user = this_cpu_ptr(&x86_user_regs);
+	struct perf_regs regs_user;
+
+	perf_get_regs_user(&regs_user, regs);
+	data->regs_user.abi = regs_user.abi;
+	if (regs_user.regs) {
+		x86_regs_user->regs = *regs_user.regs;
+		data->regs_user.regs = &x86_regs_user->regs;
+	} else
+		data->regs_user.regs = NULL;
+	return x86_regs_user;
+}
+
 void x86_pmu_setup_regs_data(struct perf_event *event,
 			     struct perf_sample_data *data,
-			     struct pt_regs *regs)
+			     struct pt_regs *regs,
+			     u64 ignore_mask)
 {
-	u64 sample_type = event->attr.sample_type;
+	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
+	struct perf_event_attr *attr = &event->attr;
+	u64 sample_type = attr->sample_type;
+	u64 mask = 0;
+
+	if (!(attr->sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)))
+		return;
 
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
 		if (user_mode(regs)) {
 			data->regs_user.abi = perf_reg_abi(current);
 			data->regs_user.regs = regs;
 		} else if (!(current->flags & PF_KTHREAD)) {
-			perf_get_regs_user(&data->regs_user, regs);
+			perf_regs = x86_pmu_perf_get_regs_user(data, regs);
 		} else {
 			data->regs_user.abi = PERF_SAMPLE_REGS_ABI_NONE;
 			data->regs_user.regs = NULL;
 		}
 		data->dyn_size += sizeof(u64);
 		if (data->regs_user.regs)
-			data->dyn_size += hweight64(event->attr.sample_regs_user) * sizeof(u64);
+			data->dyn_size += hweight64(attr->sample_regs_user) * sizeof(u64);
 		data->sample_flags |= PERF_SAMPLE_REGS_USER;
 	}
 
@@ -1712,9 +1792,18 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
 		data->regs_intr.abi = perf_reg_abi(current);
 		data->dyn_size += sizeof(u64);
 		if (data->regs_intr.regs)
-			data->dyn_size += hweight64(event->attr.sample_regs_intr) * sizeof(u64);
+			data->dyn_size += hweight64(attr->sample_regs_intr) * sizeof(u64);
 		data->sample_flags |= PERF_SAMPLE_REGS_INTR;
 	}
+
+	if (event_has_extended_regs(event)) {
+		perf_regs->xmm_regs = NULL;
+		mask |= XFEATURE_MASK_SSE;
+	}
+
+	mask &= ~ignore_mask;
+	if (mask)
+		x86_pmu_get_ext_regs(perf_regs, mask);
 }
 
 int x86_pmu_handle_irq(struct pt_regs *regs)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c2fb729c270e..bd16f91dea1c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3284,6 +3284,8 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		if (has_branch_stack(event))
 			intel_pmu_lbr_save_brstack(&data, cpuc, event);
 
+		x86_pmu_setup_regs_data(event, &data, regs, 0);
+
 		perf_event_overflow(event, &data, regs);
 	}
 
@@ -5272,6 +5274,29 @@ static inline bool intel_pmu_broken_perf_cap(void)
 	return false;
 }
 
+static void intel_extended_regs_init(struct pmu *pmu)
+{
+	/*
+	 * Extend the vector registers support to non-PEBS.
+	 * The feature is limited to newer Intel machines with
+	 * PEBS V4+ or archPerfmonExt (0x23) enabled for now.
+	 * In theory, the vector registers can be retrieved as
+	 * long as the CPU supports. The support for the old
+	 * generations may be added later if there is a
+	 * requirement.
+	 * Only support the extension when XSAVES is available.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_XSAVES))
+		return;
+
+	if (!boot_cpu_has(X86_FEATURE_XMM) ||
+	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL))
+		return;
+
+	x86_pmu.ext_regs_mask |= XFEATURE_MASK_SSE;
+	x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
+}
+
 static void update_pmu_cap(struct pmu *pmu)
 {
 	unsigned int cntr, fixed_cntr, ecx, edx;
@@ -5306,6 +5331,8 @@ static void update_pmu_cap(struct pmu *pmu)
 		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
 		rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
 	}
+
+	intel_extended_regs_init(pmu);
 }
 
 static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e67d8a03ddfe..9cdece014ac0 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1415,8 +1415,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	if (gprs || (attr->precise_ip < 2) || tsx_weight)
 		pebs_data_cfg |= PEBS_DATACFG_GP;
 
-	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
-	    (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK))
+	if (event_has_extended_regs(event))
 		pebs_data_cfg |= PEBS_DATACFG_XMMS;
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
@@ -2127,8 +2126,12 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		}
 
 		if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
+			u64 mask = 0;
+
 			adaptive_pebs_save_regs(regs, gprs);
-			x86_pmu_setup_regs_data(event, data, regs);
+			if (format_group & PEBS_DATACFG_XMMS)
+				mask |= XFEATURE_MASK_SSE;
+			x86_pmu_setup_regs_data(event, data, regs, mask);
 		}
 	}
 
@@ -2755,6 +2758,7 @@ void __init intel_pebs_init(void)
 				x86_pmu.flags |= PMU_FL_PEBS_ALL;
 				x86_pmu.pebs_capable = ~0ULL;
 				pebs_qual = "-baseline";
+				x86_pmu.ext_regs_mask |= XFEATURE_MASK_SSE;
 				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 			} else {
 				/* Only basic record supported */
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 12682a059608..7bf24842b1dc 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -992,6 +992,12 @@ struct x86_pmu {
 	struct extra_reg *extra_regs;
 	unsigned int flags;
 
+	/*
+	 * Extended regs, e.g., vector registers
+	 * Utilize the same format as the XFEATURE_MASK_*
+	 */
+	u64		ext_regs_mask;
+
 	/*
 	 * Intel host/guest support (KVM)
 	 */
@@ -1280,7 +1286,8 @@ int x86_pmu_handle_irq(struct pt_regs *regs);
 
 void x86_pmu_setup_regs_data(struct perf_event *event,
 			     struct perf_sample_data *data,
-			     struct pt_regs *regs);
+			     struct pt_regs *regs,
+			     u64 ignore_mask);
 
 void x86_pmu_show_pmu_cap(struct pmu *pmu);
 
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 0c8b9251c29f..58bbdf9226d1 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -109,6 +109,8 @@ void xsaves(struct xregs_state *xsave, u64 mask);
 void xrstors(struct xregs_state *xsave, u64 mask);
 void xsaves_nmi(struct xregs_state *xsave, u64 mask);
 
+unsigned int xstate_calculate_size(u64 xfeatures, bool compacted);
+
 int xfd_enable_feature(u64 xfd_err);
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 70d1d94aca7e..f36f04bc95f1 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -592,7 +592,10 @@ extern void perf_events_lapic_init(void);
 struct pt_regs;
 struct x86_perf_regs {
 	struct pt_regs	regs;
-	u64		*xmm_regs;
+	union {
+		u64	*xmm_regs;
+		u32	*xmm_space;	/* for xsaves */
+	};
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 8602683fcb12..4747b29608cd 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -583,7 +583,7 @@ static bool __init check_xstate_against_struct(int nr)
 	return true;
 }
 
-static unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
+unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
 {
 	unsigned int topmost = fls64(xfeatures) -  1;
 	unsigned int offset, i;
-- 
2.38.1


