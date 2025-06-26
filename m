Return-Path: <linux-kernel+bounces-703764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B136DAE94A4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 05:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2644A5282
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 03:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E54A209F45;
	Thu, 26 Jun 2025 03:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0UQTdbJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1BB20E6EB;
	Thu, 26 Jun 2025 03:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750909380; cv=none; b=KZ+QbVYg1BIzumAnh3W5dhpcd2RUGFU8nB1dROGrtKbnuXKYgGrUFx4zLUVq4elJqIQwfhr3kplMW8WM5fAymyO/y9IjtZMbOUmmrbr98Axs3gVTEao/oVOsiJhFbVWmA9qPLFj/qjN5KG/eoof+6+MoDPTPw5shnV9132yPQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750909380; c=relaxed/simple;
	bh=hKYGOFeNNROvWCmwQJd0IU7n830DSXKVXHPwoVGgUrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJy6aaNsMHADCqD8KsbYKhYO6Alwld5K2576C44YxHyv5SnWbEeoqDK7jce6mu93aBJ4r7Z5XaTZMM2neBU9ap3Oo0DF0p3++FD0Vb4nVEoRnaVDclA4O3I9xCvc7Qm11y0qOVItlqLnikuT7YBtOGEd1j3FJQiR+okoJR0gZNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0UQTdbJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750909378; x=1782445378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hKYGOFeNNROvWCmwQJd0IU7n830DSXKVXHPwoVGgUrM=;
  b=G0UQTdbJL91bjMWGJ8P9KfNP0g81SA7n/MOQDqqwqXdMS51ufc7NqyGX
   tK4sRKRgmmdsqtCpTKSRAyprl/ja6NUF9e/f3jbFCMhblebqR/DN/lWHn
   SNdshEGIIUqCKH1JSK/Sg2r92WzY/S66ADzbWxCro1+JDBzcOFDySAIx7
   xi/b0v//Id41qrhLiYNKSyMjvC7tvo8cwpcFz+bs9vh/Y/TZCojzHQYun
   +zxbDTUstluO/cE55IRcx2xfKvGWpwO9PbbJpEBVISXHeBJ/rRRMzBz5N
   kozXRbj6ZCya+W2nypvGuU13KouQqtWE8OZKjsX2YA5pya9eA/F0xGirP
   A==;
X-CSE-ConnectionGUID: krOk2x4+TWGKfwO1qOwFMg==
X-CSE-MsgGUID: bZ6mZOuxQ/eVxvD8Mb7Rug==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="55820651"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="55820651"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 20:42:58 -0700
X-CSE-ConnectionGUID: L5pcD2JPRjyO8WnS3duBNQ==
X-CSE-MsgGUID: PuvGUUzgR82YY1bxutE7Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="157894961"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jun 2025 20:42:54 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v5 03/10] perf/x86/intel: Initialize architectural PEBS
Date: Mon, 23 Jun 2025 22:35:38 +0000
Message-ID: <20250623223546.112465-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623223546.112465-1-dapeng1.mi@linux.intel.com>
References: <20250623223546.112465-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch-PEBS leverages CPUID.23H.4/5 sub-leaves enumerate arch-PEBS
supported capabilities and counters bitmap. This patch parses these 2
sub-leaves and initializes arch-PEBS capabilities and corresponding
structures.

Since IA32_PEBS_ENABLE and MSR_PEBS_DATA_CFG MSRs are no longer existed
for arch-PEBS, arch-PEBS doesn't need to manipulate these MSRs. Thus add
a simple pair of __intel_pmu_pebs_enable/disable() callbacks for
arch-PEBS.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c            | 21 +++++++++---
 arch/x86/events/intel/core.c      | 55 +++++++++++++++++++++++--------
 arch/x86/events/intel/ds.c        | 52 ++++++++++++++++++++++++-----
 arch/x86/events/perf_event.h      | 25 ++++++++++++--
 arch/x86/include/asm/perf_event.h |  7 +++-
 5 files changed, 129 insertions(+), 31 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7610f26dfbd9..f30c423e4bd2 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -554,14 +554,22 @@ static inline int precise_br_compat(struct perf_event *event)
 	return m == b;
 }
 
-int x86_pmu_max_precise(void)
+int x86_pmu_max_precise(struct pmu *pmu)
 {
 	int precise = 0;
 
-	/* Support for constant skid */
 	if (x86_pmu.pebs_active && !x86_pmu.pebs_broken) {
-		precise++;
+		/* arch PEBS */
+		if (x86_pmu.arch_pebs) {
+			precise = 2;
+			if (hybrid(pmu, arch_pebs_cap).pdists)
+				precise++;
+
+			return precise;
+		}
 
+		/* legacy PEBS - support for constant skid */
+		precise++;
 		/* Support for IP fixup */
 		if (x86_pmu.lbr_nr || x86_pmu.intel_cap.pebs_format >= 2)
 			precise++;
@@ -569,13 +577,14 @@ int x86_pmu_max_precise(void)
 		if (x86_pmu.pebs_prec_dist)
 			precise++;
 	}
+
 	return precise;
 }
 
 int x86_pmu_hw_config(struct perf_event *event)
 {
 	if (event->attr.precise_ip) {
-		int precise = x86_pmu_max_precise();
+		int precise = x86_pmu_max_precise(event->pmu);
 
 		if (event->attr.precise_ip > precise)
 			return -EOPNOTSUPP;
@@ -2627,7 +2636,9 @@ static ssize_t max_precise_show(struct device *cdev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu_max_precise());
+	struct pmu *pmu = dev_get_drvdata(cdev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu_max_precise(pmu));
 }
 
 static DEVICE_ATTR_RO(max_precise);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9f957cf459bf..b8a7abc1f572 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5276,34 +5276,58 @@ static inline bool intel_pmu_broken_perf_cap(void)
 
 static void update_pmu_cap(struct pmu *pmu)
 {
-	unsigned int cntr, fixed_cntr, ecx, edx;
-	union cpuid35_eax eax;
-	union cpuid35_ebx ebx;
+	unsigned int eax, ebx, ecx, edx;
+	union cpuid35_eax eax_0;
+	union cpuid35_ebx ebx_0;
+	u64 cntrs_mask = 0;
+	u64 pebs_mask = 0;
+	u64 pdists_mask = 0;
 
-	cpuid(ARCH_PERFMON_EXT_LEAF, &eax.full, &ebx.full, &ecx, &edx);
+	cpuid(ARCH_PERFMON_EXT_LEAF, &eax_0.full, &ebx_0.full, &ecx, &edx);
 
-	if (ebx.split.umask2)
+	if (ebx_0.split.umask2)
 		hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_UMASK2;
-	if (ebx.split.eq)
+	if (ebx_0.split.eq)
 		hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_EQ;
 
-	if (eax.split.cntr_subleaf) {
+	if (eax_0.split.cntr_subleaf) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
-			    &cntr, &fixed_cntr, &ecx, &edx);
-		hybrid(pmu, cntr_mask64) = cntr;
-		hybrid(pmu, fixed_cntr_mask64) = fixed_cntr;
+			    &eax, &ebx, &ecx, &edx);
+		hybrid(pmu, cntr_mask64) = eax;
+		hybrid(pmu, fixed_cntr_mask64) = ebx;
+		cntrs_mask = (u64)ebx << INTEL_PMC_IDX_FIXED | eax;
 	}
 
-	if (eax.split.acr_subleaf) {
+	if (eax_0.split.acr_subleaf) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_ACR_LEAF,
-			    &cntr, &fixed_cntr, &ecx, &edx);
+			    &eax, &ebx, &ecx, &edx);
 		/* The mask of the counters which can be reloaded */
-		hybrid(pmu, acr_cntr_mask64) = cntr | ((u64)fixed_cntr << INTEL_PMC_IDX_FIXED);
+		hybrid(pmu, acr_cntr_mask64) = eax | ((u64)ebx << INTEL_PMC_IDX_FIXED);
 
 		/* The mask of the counters which can cause a reload of reloadable counters */
 		hybrid(pmu, acr_cause_mask64) = ecx | ((u64)edx << INTEL_PMC_IDX_FIXED);
 	}
 
+	/* Bits[5:4] should be set simultaneously if arch-PEBS is supported */
+	if (eax_0.split.pebs_caps_subleaf && eax_0.split.pebs_cnts_subleaf) {
+		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_PEBS_CAP_LEAF,
+			    &eax, &ebx, &ecx, &edx);
+		hybrid(pmu, arch_pebs_cap).caps = (u64)ebx << 32;
+
+		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_PEBS_COUNTER_LEAF,
+			    &eax, &ebx, &ecx, &edx);
+		pebs_mask = ((u64)ecx << INTEL_PMC_IDX_FIXED) | eax;
+		pdists_mask = ((u64)edx << INTEL_PMC_IDX_FIXED) | ebx;
+		hybrid(pmu, arch_pebs_cap).counters = pebs_mask;
+		hybrid(pmu, arch_pebs_cap).pdists = pdists_mask;
+
+		if (WARN_ON((pebs_mask | pdists_mask) & ~cntrs_mask))
+			x86_pmu.arch_pebs = 0;
+	} else {
+		WARN_ON(x86_pmu.arch_pebs == 1);
+		x86_pmu.arch_pebs = 0;
+	}
+
 	if (!intel_pmu_broken_perf_cap()) {
 		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
 		rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
@@ -6255,7 +6279,7 @@ tsx_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 static umode_t
 pebs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
-	return x86_pmu.ds_pebs ? attr->mode : 0;
+	return intel_pmu_has_pebs() ? attr->mode : 0;
 }
 
 static umode_t
@@ -7731,6 +7755,9 @@ __init int intel_pmu_init(void)
 	if (!is_hybrid() && boot_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
 		update_pmu_cap(NULL);
 
+	if (x86_pmu.arch_pebs)
+		pr_cont("Architectural PEBS, ");
+
 	intel_pmu_check_counters_mask(&x86_pmu.cntr_mask64,
 				      &x86_pmu.fixed_cntr_mask64,
 				      &x86_pmu.intel_ctrl);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c0b7ac1c7594..26e485eca0a0 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1531,6 +1531,15 @@ static inline void intel_pmu_drain_large_pebs(struct cpu_hw_events *cpuc)
 		intel_pmu_drain_pebs_buffer();
 }
 
+static void __intel_pmu_pebs_enable(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+
+	hwc->config &= ~ARCH_PERFMON_EVENTSEL_INT;
+	cpuc->pebs_enabled |= 1ULL << hwc->idx;
+}
+
 void intel_pmu_pebs_enable(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1539,9 +1548,7 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 	struct debug_store *ds = cpuc->ds;
 	unsigned int idx = hwc->idx;
 
-	hwc->config &= ~ARCH_PERFMON_EVENTSEL_INT;
-
-	cpuc->pebs_enabled |= 1ULL << hwc->idx;
+	__intel_pmu_pebs_enable(event);
 
 	if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) && (x86_pmu.version < 5))
 		cpuc->pebs_enabled |= 1ULL << (hwc->idx + 32);
@@ -1603,14 +1610,22 @@ void intel_pmu_pebs_del(struct perf_event *event)
 	pebs_update_state(needed_cb, cpuc, event, false);
 }
 
-void intel_pmu_pebs_disable(struct perf_event *event)
+static void __intel_pmu_pebs_disable(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 
 	intel_pmu_drain_large_pebs(cpuc);
-
 	cpuc->pebs_enabled &= ~(1ULL << hwc->idx);
+	hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
+}
+
+void intel_pmu_pebs_disable(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+
+	__intel_pmu_pebs_disable(event);
 
 	if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) &&
 	    (x86_pmu.version < 5))
@@ -1622,8 +1637,6 @@ void intel_pmu_pebs_disable(struct perf_event *event)
 
 	if (cpuc->enabled)
 		wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
-
-	hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
 }
 
 void intel_pmu_pebs_enable_all(void)
@@ -2669,11 +2682,26 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 	}
 }
 
+static void __init intel_arch_pebs_init(void)
+{
+	/*
+	 * Current hybrid platforms always both support arch-PEBS or not
+	 * on all kinds of cores. So directly set x86_pmu.arch_pebs flag
+	 * if boot cpu supports arch-PEBS.
+	 */
+	x86_pmu.arch_pebs = 1;
+	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
+	x86_pmu.pebs_capable = ~0ULL;
+
+	x86_pmu.pebs_enable = __intel_pmu_pebs_enable;
+	x86_pmu.pebs_disable = __intel_pmu_pebs_disable;
+}
+
 /*
  * PEBS probe and setup
  */
 
-void __init intel_pebs_init(void)
+static void __init intel_ds_pebs_init(void)
 {
 	/*
 	 * No support for 32bit formats
@@ -2788,6 +2816,14 @@ void __init intel_pebs_init(void)
 	}
 }
 
+void __init intel_pebs_init(void)
+{
+	if (x86_pmu.intel_cap.pebs_format == 0xf)
+		intel_arch_pebs_init();
+	else
+		intel_ds_pebs_init();
+}
+
 void perf_restore_debug_store(void)
 {
 	struct debug_store *ds = __this_cpu_read(cpu_hw_events.ds);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2b969386dcdd..a5145e8f1ddb 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -708,6 +708,12 @@ enum hybrid_pmu_type {
 	hybrid_big_small_tiny	= hybrid_big   | hybrid_small_tiny,
 };
 
+struct arch_pebs_cap {
+	u64 caps;
+	u64 counters;
+	u64 pdists;
+};
+
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
 	const char			*name;
@@ -752,6 +758,8 @@ struct x86_hybrid_pmu {
 					mid_ack		:1,
 					enabled_ack	:1;
 
+	struct arch_pebs_cap		arch_pebs_cap;
+
 	u64				pebs_data_source[PERF_PEBS_DATA_SOURCE_MAX];
 };
 
@@ -906,7 +914,7 @@ struct x86_pmu {
 	union perf_capabilities intel_cap;
 
 	/*
-	 * Intel DebugStore bits
+	 * Intel DebugStore and PEBS bits
 	 */
 	unsigned int	bts			:1,
 			bts_active		:1,
@@ -917,7 +925,8 @@ struct x86_pmu {
 			pebs_no_tlb		:1,
 			pebs_no_isolation	:1,
 			pebs_block		:1,
-			pebs_ept		:1;
+			pebs_ept		:1,
+			arch_pebs		:1;
 	int		pebs_record_size;
 	int		pebs_buffer_size;
 	u64		pebs_events_mask;
@@ -929,6 +938,11 @@ struct x86_pmu {
 	u64		rtm_abort_event;
 	u64		pebs_capable;
 
+	/*
+	 * Intel Architectural PEBS
+	 */
+	struct arch_pebs_cap arch_pebs_cap;
+
 	/*
 	 * Intel LBR
 	 */
@@ -1217,7 +1231,7 @@ int x86_reserve_hardware(void);
 
 void x86_release_hardware(void);
 
-int x86_pmu_max_precise(void);
+int x86_pmu_max_precise(struct pmu *pmu);
 
 void hw_perf_lbr_event_destroy(struct perf_event *event);
 
@@ -1792,6 +1806,11 @@ static inline int intel_pmu_max_num_pebs(struct pmu *pmu)
 	return fls((u32)hybrid(pmu, pebs_events_mask));
 }
 
+static inline bool intel_pmu_has_pebs(void)
+{
+	return x86_pmu.ds_pebs || x86_pmu.arch_pebs;
+}
+
 #else /* CONFIG_CPU_SUP_INTEL */
 
 static inline void reserve_ds_buffers(void)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 70d1d94aca7e..7fca9494aae9 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -196,6 +196,8 @@ union cpuid10_edx {
 #define ARCH_PERFMON_EXT_LEAF			0x00000023
 #define ARCH_PERFMON_NUM_COUNTER_LEAF		0x1
 #define ARCH_PERFMON_ACR_LEAF			0x2
+#define ARCH_PERFMON_PEBS_CAP_LEAF		0x4
+#define ARCH_PERFMON_PEBS_COUNTER_LEAF		0x5
 
 union cpuid35_eax {
 	struct {
@@ -206,7 +208,10 @@ union cpuid35_eax {
 		unsigned int    acr_subleaf:1;
 		/* Events Sub-Leaf */
 		unsigned int    events_subleaf:1;
-		unsigned int	reserved:28;
+		/* arch-PEBS Sub-Leaves */
+		unsigned int	pebs_caps_subleaf:1;
+		unsigned int	pebs_cnts_subleaf:1;
+		unsigned int	reserved:26;
 	} split;
 	unsigned int            full;
 };
-- 
2.43.0


