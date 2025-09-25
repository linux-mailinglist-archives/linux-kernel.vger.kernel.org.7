Return-Path: <linux-kernel+bounces-833148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2635EBA14D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159501C217A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02576323F7B;
	Thu, 25 Sep 2025 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOxwWeYr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFDC322C94
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830661; cv=none; b=ey2G6FgxEAdlSfi04je1ZpJh7tntA7zI8keneZPt32JlDeGi7Zb8n6FItAZn1gLk9oxVRuo9i6JSrvw4aGlQo2m6Jm+ZK6yW9E4jPna5yC4Sq0J3cRF49RcxhD3ytmrDqRVfTQCATkQh9tcJYYYgG9WIvZtM2IN6Nj7SN2PS2E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830661; c=relaxed/simple;
	bh=+RXa62AV+Tx5eKtJw1BZAV0tBy1MlMpJrPYaE552JhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guWc4ZkrrU4MfJPjq1up1wHaMB7ybDwTEk4/gyHQabUsIAKvRXaGV9l03NrBauBQAeWitCC98wi1nN11tDoSSDLmAxGYAhO/lDhqgV/wLfuXJ21wJiay2czx9ImxmhIUJwIMJ3pu7iWbhxsKhDTduiZF8KZ6kO/qEGQnOP2E0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NOxwWeYr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758830659; x=1790366659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+RXa62AV+Tx5eKtJw1BZAV0tBy1MlMpJrPYaE552JhY=;
  b=NOxwWeYrK8fDpfs/pfFrxIBXV3pJ41fjDo+uqpgo/P20W4LNj8csKWxS
   a+WOPV4O7W8WxncI5vDNU7LoDklWtZJtWSvXwcJ3mxxKkrTyZF1aPm1kw
   vTF/ah3PoYfQhVk3c4cpS/OWLs/N9AE0NFIh45SA6GlYI8P1udWfv9OOB
   oqvjYVdmGqZ8G2hxIcUmONW3mVGoVaRTZApHxvWcfLMRQwr77s8U+RhhU
   WPkr82X6u5x55s4bXqmJwxROW3KtMrIVhkbn0Y0FX27woyv0+7zgU6X+S
   BmqLFfjOQZtsMjMM+IR+q1nhHaoeM7v9Hkk5o73cqf2NdP/QpVs/2xYDe
   g==;
X-CSE-ConnectionGUID: I153ZQeKQcmyvhjOELMevA==
X-CSE-MsgGUID: reSHn6+ETWSzcf5nU+AttA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61074293"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61074293"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 13:04:12 -0700
X-CSE-ConnectionGUID: WRmizlY8SA+lxKWu/zIIiQ==
X-CSE-MsgGUID: +aMFRMoPQ72r6uHSUNLy8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="177003666"
Received: from inaky-mobl1.amr.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.220.206])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 13:04:11 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Chen Yu <yu.c.chen@intel.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v11 19/31] x86/resctrl: Read telemetry events
Date: Thu, 25 Sep 2025 13:03:13 -0700
Message-ID: <20250925200328.64155-20-tony.luck@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925200328.64155-1-tony.luck@intel.com>
References: <20250925200328.64155-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Telemetry events are enabled during the first mount of the resctrl
file system.

Mark telemetry regions that did not pass the sanity checks by
clearing their MMIO address fields so that they will not be
used when reading events.

Introduce intel_aet_read_event() to read telemetry events for resource
RDT_RESOURCE_PERF_PKG. There may be multiple aggregators tracking each
package, so scan all of them and add up all counters. Aggregators may
return an invalid data indication if they have received no records for
a given RMID. Return success to the user if one or more aggregators
provide valid data.

Resctrl now uses readq() so depends on X86_64. Update Kconfig.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h  |  7 +++
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 65 ++++++++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/monitor.c   |  3 ++
 arch/x86/Kconfig                        |  2 +-
 4 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 886261a82b81..97616c81682b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -220,9 +220,16 @@ void resctrl_arch_mbm_cntr_assign_set_one(struct rdt_resource *r);
 #ifdef CONFIG_X86_CPU_RESCTRL_INTEL_AET
 bool intel_aet_get_events(void);
 void __exit intel_aet_exit(void);
+int intel_aet_read_event(int domid, u32 rmid, enum resctrl_event_id evtid,
+			 void *arch_priv, u64 *val);
 #else
 static inline bool intel_aet_get_events(void) { return false; }
 static inline void __exit intel_aet_exit(void) { }
+static inline int intel_aet_read_event(int domid, u32 rmid, enum resctrl_event_id evtid,
+				       void *arch_priv, u64 *val)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index 98ba9ba05ee5..d53211ac6204 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -12,13 +12,17 @@
 #define pr_fmt(fmt)   "resctrl: " fmt
 
 #include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/compiler_types.h>
+#include <linux/container_of.h>
 #include <linux/cpu.h>
 #include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/intel_pmt_features.h>
 #include <linux/intel_vsec.h>
+#include <linux/io.h>
 #include <linux/overflow.h>
 #include <linux/printk.h>
 #include <linux/resctrl.h>
@@ -134,13 +138,28 @@ static bool skip_telem_region(struct telemetry_region *tr, struct event_group *e
 	return false;
 }
 
+/*
+ * Clear the address field of regions that did not pass the checks in
+ * skip_telem_region() so they will not be used by intel_aet_read_event().
+ * This is safe to do because intel_pmt_get_regions_by_feature() allocates
+ * a new pmt_feature_group structure to return to each caller and only makes
+ * use of the pmt_feature_group::kref field when intel_pmt_put_feature_group()
+ * returns the structure.
+ */
+static void mark_telem_region_unusable(struct telemetry_region *tr)
+{
+	tr->addr = NULL;
+}
+
 static bool enable_events(struct event_group *e, struct pmt_feature_group *p)
 {
 	bool usable_events = false;
 
 	for (int i = 0; i < p->count; i++) {
-		if (skip_telem_region(&p->regions[i], e))
+		if (skip_telem_region(&p->regions[i], e)) {
+			mark_telem_region_unusable(&p->regions[i]);
 			continue;
+		}
 		usable_events = true;
 	}
 
@@ -219,3 +238,47 @@ void __exit intel_aet_exit(void)
 		(*peg)->pfg = NULL;
 	}
 }
+
+#define DATA_VALID	BIT_ULL(63)
+#define DATA_BITS	GENMASK_ULL(62, 0)
+
+/*
+ * Read counter for an event on a domain (summing all aggregators
+ * on the domain). If an aggregator hasn't received any data for a
+ * specific RMID, the MMIO read indicates that data is not valid.
+ * Return success if at least one aggregator has valid data.
+ */
+int intel_aet_read_event(int domid, u32 rmid, enum resctrl_event_id eventid,
+			 void *arch_priv, u64 *val)
+{
+	struct pmt_event *pevt = arch_priv;
+	struct event_group *e;
+	bool valid = false;
+	u64 evtcount;
+	void *pevt0;
+	u32 idx;
+
+	pevt0 = pevt - pevt->idx;
+	e = container_of(pevt0, struct event_group, evts);
+	idx = rmid * e->num_events;
+	idx += pevt->idx;
+
+	if (idx * sizeof(u64) + sizeof(u64) > e->mmio_size) {
+		pr_warn_once("MMIO index %u out of range\n", idx);
+		return -EIO;
+	}
+
+	for (int i = 0; i < e->pfg->count; i++) {
+		if (!e->pfg->regions[i].addr)
+			continue;
+		if (e->pfg->regions[i].plat_info.package_id != domid)
+			continue;
+		evtcount = readq(e->pfg->regions[i].addr + idx * sizeof(u64));
+		if (!(evtcount & DATA_VALID))
+			continue;
+		*val += evtcount & DATA_BITS;
+		valid = true;
+	}
+
+	return valid ? 0 : -EINVAL;
+}
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 175488185b06..7d14ae6a9737 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -250,6 +250,9 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hdr,
 
 	resctrl_arch_rmid_read_context_check();
 
+	if (r->rid == RDT_RESOURCE_PERF_PKG)
+		return intel_aet_read_event(hdr->id, rmid, eventid, arch_priv, val);
+
 	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 		return -EINVAL;
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ce9d086625c1..6e0ec28ee904 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -527,7 +527,7 @@ config X86_CPU_RESCTRL
 
 config X86_CPU_RESCTRL_INTEL_AET
 	bool "Intel Application Energy Telemetry"
-	depends on X86_CPU_RESCTRL && CPU_SUP_INTEL && INTEL_PMT_TELEMETRY=y && INTEL_TPMI=y
+	depends on X86_64 && X86_CPU_RESCTRL && CPU_SUP_INTEL && INTEL_PMT_TELEMETRY=y && INTEL_TPMI=y
 	help
 	  Enable per-RMID telemetry events in resctrl.
 
-- 
2.51.0


