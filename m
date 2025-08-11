Return-Path: <linux-kernel+bounces-763387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08D6B21413
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C875C623618
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4F42E4250;
	Mon, 11 Aug 2025 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ltjSF79j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023F2E2EE5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936265; cv=none; b=N/pU9pHnZgYd7xLmfeRwPQmp31Qs+m2W6Rx8igIIAb5ulSNJi4AHuyS1gxdkS8062cY5vi63UJ9fpIBg/+kyrPaV6KnaZBCaK6QoiQwg8QdIG4Wzn7SEksMyTksa503fZlYsINWR5q5eZm1dXv2Ws5EmKCVfGKS/Kzjd3fkySBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936265; c=relaxed/simple;
	bh=vgJ9zQWK+5JzRjVDNt7iEf0tUgKpQctOz1vVeDHoBlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JS1Qz4dy0P7fhDjkCRR3wXZkpT0UhHzpQAOGekHOrXqhXOEefC/U9x7o2uVHwZA2Ze03t8zfZHpzzTtkKedNdPNh1+5UFHknBLGFxLkWaiWZN6NsF9k5db78xjU+jw5OAsTn/FfphSdw90yvyC9B8tm4AgUcyO1lMCPMP8qLKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ltjSF79j; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754936263; x=1786472263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vgJ9zQWK+5JzRjVDNt7iEf0tUgKpQctOz1vVeDHoBlQ=;
  b=ltjSF79jWG6ndu4VimjJPNpDVbU4xjGAyjkt3wFZCLg2kdwrrhvAy7Px
   KIDZ8nc0FW4GK/gE73k/S1gbVJZogpCvpRVFQ54dXR5ea7jhDJl1aUOZb
   kuHgjpBCKTC+qptj+iNR38RQoYbgjHOTAJ6JFmxp4oLgutAb+SpAvvYoD
   OPY2PLR0Ohr13mk9TpDneeaFeyjyWnd3JHrOO8XF5f5SlQ8Uvi3y7qxW0
   ykhmYwyu2ehd5qxEUUKL9uxAzfGaqc3W98xK/rxDs19UDD7Gq9ELRViaU
   hgFtJQ3j/WuzYdM/JgKJOtk/jy7Tpmtg3xsmrdBthO9Vx+aWs/2rH5R52
   w==;
X-CSE-ConnectionGUID: R4EySxYBTZ+mLfc0Ip8ZfQ==
X-CSE-MsgGUID: cmPIwk51SmqDQXGpG2zaqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68277447"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68277447"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:17:27 -0700
X-CSE-ConnectionGUID: bvVhzxW4SLGICtWC6kIMHA==
X-CSE-MsgGUID: lKXV9ksSQue+zWIHi5Vbjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="196825668"
Received: from puneetse-mobl.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.221.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:17:25 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Chen Yu <yu.c.chen@intel.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v8 17/32] x86/resctrl: Discover hardware telemetry events
Date: Mon, 11 Aug 2025 11:16:51 -0700
Message-ID: <20250811181709.6241-18-tony.luck@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811181709.6241-1-tony.luck@intel.com>
References: <20250811181709.6241-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Data for telemetry events is collected by each CPU and sent
to a nearby telemetry event aggregator either when the value
of IA32_PQR_ASSOC.RMID is changed, or when two milliseconds
have elapsed.

The telemetry event aggregators maintain per-RMID per-event
counts of the total seen for all the CPUs. There may be more
than one telemetry event aggregator per package.

Each telemetry event aggregator is responsible for a specific
group of events. E.g. on the Intel Clearwater Forest CPU there
are two types of aggregators. One type tracks a pair of energy
related events. The other type tracks a subset of "perf" type
events.

The event counts are made available to Linux in a region of
MMIO space for each aggregator. All details about the layout
of counters in each aggregator MMIO region are described in
XML files published by Intel and mad available in a GitHub
repository: https://github.com/intel/Intel-PMT.

The key to matching a specific telemetry aggregator to the
XML file that describes the MMIO layout is a 32-bit value. The
Linux telemetry subsystem refers to this as a "guid" while
the XML files call it a "uniqueid".

Each XML file provides the following information:
1) Which telemetry events are included in the group.
2) The order in which the event counters appear for each RMID.
3) The value type of each event counter (integer or fixed-point).
4) The number of RMIDs supported.
5) Which additional aggregator status registers are included.
6) The total size of the MMIO region for this aggregator.

Enumeration of support for telemetry events is done by the
INTEL_PMT_DISCOVERY driver (a subcomponent of the INTEL_PMT_TELEMETRY
driver). This driver provides intel_pmt_get_regions_by_feature()
to list all available telemetry event aggregators. The list
includes the "guid", the base address in MMIO space for the
region where the event counters are exposed, and the package
id where the CPUs that report to this aggregator are located.

Add a new Kconfig option CONFIG_X86_CPU_RESCTRL_INTEL_AET for the
Intel specific parts of telemetry code. This depends on the
INTEL_PMT_TELEMETRY and INTEL_TPMI drivers being built-in to the kernel
for enumeration of telemetry features.

Call intel_pmt_get_regions_by_feature() for each pmt_feature_id
that indicates per-RMID telemetry.

Save the returned pmt_feature_group pointers with guids that are known
to resctrl for use at run time.

Those pointers will be returned to the INTEL_PMT_TELEMETRY subsystem at
resctrl_arch_exit() time.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h  |   8 ++
 arch/x86/kernel/cpu/resctrl/core.c      |   5 +
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 120 ++++++++++++++++++++++++
 arch/x86/Kconfig                        |  13 +++
 arch/x86/kernel/cpu/resctrl/Makefile    |   1 +
 5 files changed, 147 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/resctrl/intel_aet.c

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 684a1b830ced..710493ec6548 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -169,4 +169,12 @@ void __init intel_rdt_mbm_apply_quirk(void);
 
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 
+#ifdef CONFIG_X86_CPU_RESCTRL_INTEL_AET
+bool intel_aet_get_events(void);
+void __exit intel_aet_exit(void);
+#else
+static inline bool intel_aet_get_events(void) { return false; }
+static inline void __exit intel_aet_exit(void) { }
+#endif
+
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index ec29b7f250ab..58756d216fe8 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -735,6 +735,9 @@ void resctrl_arch_pre_mount(void)
 
 	if (!atomic_try_cmpxchg(&only_once, &old, 1))
 		return;
+
+	if (!intel_aet_get_events())
+		return;
 }
 
 enum {
@@ -1087,6 +1090,8 @@ late_initcall(resctrl_arch_late_init);
 
 static void __exit resctrl_arch_exit(void)
 {
+	intel_aet_exit();
+
 	cpuhp_remove_state(rdt_online);
 
 	resctrl_exit();
diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
new file mode 100644
index 000000000000..25075f369148
--- /dev/null
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Resource Director Technology(RDT)
+ * - Intel Application Energy Telemetry
+ *
+ * Copyright (C) 2025 Intel Corporation
+ *
+ * Author:
+ *    Tony Luck <tony.luck@intel.com>
+ */
+
+#define pr_fmt(fmt)   "resctrl: " fmt
+
+#include <linux/cleanup.h>
+#include <linux/cpu.h>
+#include <linux/intel_vsec.h>
+#include <linux/resctrl.h>
+
+#include "internal.h"
+
+/**
+ * struct event_group - All information about a group of telemetry events.
+ * @pfg:		Points to the aggregated telemetry space information
+ *			within the OOBMSM driver that contains data for all
+ *			telemetry regions.
+ * @guid:		Unique number per XML description file.
+ */
+struct event_group {
+	/* Data fields for additional structures to manage this group. */
+	struct pmt_feature_group	*pfg;
+
+	/* Remaining fields initialized from XML file. */
+	u32				guid;
+};
+
+/*
+ * Link: https://github.com/intel/Intel-PMT
+ * File: xml/CWF/OOBMSM/RMID-ENERGY/cwf_aggregator.xml
+ */
+static struct event_group energy_0x26696143 = {
+	.guid		= 0x26696143,
+};
+
+/*
+ * Link: https://github.com/intel/Intel-PMT
+ * File: xml/CWF/OOBMSM/RMID-PERF/cwf_aggregator.xml
+ */
+static struct event_group perf_0x26557651 = {
+	.guid		= 0x26557651,
+};
+
+static struct event_group *known_energy_event_groups[] = {
+	&energy_0x26696143,
+};
+
+static struct event_group *known_perf_event_groups[] = {
+	&perf_0x26557651,
+};
+
+/* Stub for now */
+static int discover_events(struct event_group *e, struct pmt_feature_group *p)
+{
+	return -EINVAL;
+}
+
+DEFINE_FREE(intel_pmt_put_feature_group, struct pmt_feature_group *,
+		if (!IS_ERR_OR_NULL(_T))
+			intel_pmt_put_feature_group(_T))
+
+/*
+ * Make a request to the INTEL_PMT_DISCOVERY driver for the
+ * pmt_feature_group for a specific feature. If there is
+ * one the returned structure has an array of telemetry_region
+ * structures. Each describes one telemetry aggregator.
+ * Try to use every telemetry aggregator with a known guid.
+ */
+static bool get_pmt_feature(enum pmt_feature_id feature, struct event_group **evgs,
+			    unsigned int num_evg)
+{
+	struct pmt_feature_group *p __free(intel_pmt_put_feature_group) = NULL;
+	struct event_group **peg;
+	int ret;
+
+	p = intel_pmt_get_regions_by_feature(feature);
+
+	if (IS_ERR_OR_NULL(p))
+		return false;
+
+	for (peg = evgs; peg < &evgs[num_evg]; peg++) {
+		ret = discover_events(*peg, p);
+		if (!ret) {
+			(*peg)->pfg = no_free_ptr(p);
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/*
+ * Ask OOBMSM discovery driver for all the RMID based telemetry groups
+ * that it supports.
+ */
+bool intel_aet_get_events(void)
+{
+	bool ret1, ret2;
+
+	ret1 = get_pmt_feature(FEATURE_PER_RMID_ENERGY_TELEM,
+			       known_energy_event_groups,
+			       ARRAY_SIZE(known_energy_event_groups));
+	ret2 = get_pmt_feature(FEATURE_PER_RMID_PERF_TELEM,
+			       known_perf_event_groups,
+			       ARRAY_SIZE(known_perf_event_groups));
+
+	return ret1 || ret2;
+}
+
+void __exit intel_aet_exit(void)
+{
+}
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100..56f0ff94c430 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -525,6 +525,19 @@ config X86_CPU_RESCTRL
 
 	  Say N if unsure.
 
+config X86_CPU_RESCTRL_INTEL_AET
+	bool "Intel Application Energy Telemetry" if INTEL_PMT_TELEMETRY=y && INTEL_TPMI=y
+	depends on X86_CPU_RESCTRL && CPU_SUP_INTEL
+	help
+	  Enable per-RMID telemetry events in resctrl
+
+	  Intel feature that collects per-RMID execution data
+	  about energy consumption, measure of frequency independent
+	  activity and other performance metrics. Data is aggregated
+	  per package.
+
+	  Say N if unsure.
+
 config X86_FRED
 	bool "Flexible Return and Event Delivery"
 	depends on X86_64
diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/resctrl/Makefile
index d8a04b195da2..273ddfa30836 100644
--- a/arch/x86/kernel/cpu/resctrl/Makefile
+++ b/arch/x86/kernel/cpu/resctrl/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_X86_CPU_RESCTRL)		+= core.o rdtgroup.o monitor.o
 obj-$(CONFIG_X86_CPU_RESCTRL)		+= ctrlmondata.o
+obj-$(CONFIG_X86_CPU_RESCTRL_INTEL_AET)	+= intel_aet.o
 obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+= pseudo_lock.o
 
 # To allow define_trace.h's recursive include:
-- 
2.50.1


