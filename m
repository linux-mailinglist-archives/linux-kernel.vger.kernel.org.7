Return-Path: <linux-kernel+bounces-792375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8B8B3C327
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D83E7B555E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22DA33A010;
	Fri, 29 Aug 2025 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEIThxF4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9965A25D202
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496049; cv=none; b=fPbqsoJhQhHXPN5LuaVivrSKQMZs3fclOTTATbnGZvWWTi+12Tg6k8IFQRWC1wxAo959yw76myaTlmZ7lhlyu8n2SaSzMKCf8ac6bLI2sv3OLCU85UWQvCyvXHv3AUyn3Ib4fColDtx12mwS2XyD+h/uDrzkSIk5fOqLQmjcPtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496049; c=relaxed/simple;
	bh=KfwvL8h8orJDpibC2tzWf6ztpEPlasV8YUKIQNmndkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkfpcYc4dBRYqB9xyYM353zPt7GHyltgebTc0gAF464MN+DiPBy2vNS53/DKOSQctvlM9ytwMeaJHRX5Ppj/qZWo2UpeTNAR9IQdtdnQGy3fPH5bBq4La/UUpkAZ47Ena6TGR8vVeao5z6+0YlDqSKFjupcdQDAFi/LxIBO0h40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XEIThxF4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756496046; x=1788032046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KfwvL8h8orJDpibC2tzWf6ztpEPlasV8YUKIQNmndkE=;
  b=XEIThxF4rfJ7bx/K1spiPlV18vHjRBISj811qUYGFq/6dx1+KLhrO5ZJ
   J0G1XP/7kfnbKhOQlunrefMaZ2H9DFMTPImFzyIacf+ilFcTDSzqilsYs
   vc4vAk7DtpW7katW7PnbGEcdTJe98pugnNFgrPS3JiRnb0gODezKuQOt9
   rrl79LQPjhlNeGSck5Z63i9jyA66jqs2kBPG4K5H+sIg2rFjEWdtKJXMY
   RxwhUjyaKiOxIAOi2Xi0KvTQvp6v5mIs/SfV6eQHxwFxYaU2K5DotnqJY
   Yv3JXM8r6Tiv2LPlDiGkxCSwJ2GNotmf5fFpvQdJMbmsCk25/ZPNepSEU
   g==;
X-CSE-ConnectionGUID: BOOM8BxyQ9qMSqgTVpSukA==
X-CSE-MsgGUID: IMXT/lFZQyCYlZq+s7C/aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62625310"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62625310"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:33:56 -0700
X-CSE-ConnectionGUID: o9uAywZERK6uQmTNw6IF+w==
X-CSE-MsgGUID: hcoFwYQQSuO7gYKI9ELeIw==
X-ExtLoop1: 1
Received: from ldmartin-desk2.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.220.202])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:33:56 -0700
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
Subject: [PATCH v9 21/31] x86/resctrl: Read telemetry events
Date: Fri, 29 Aug 2025 12:33:33 -0700
Message-ID: <20250829193346.31565-22-tony.luck@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829193346.31565-1-tony.luck@intel.com>
References: <20250829193346.31565-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Telemetry events are enumerated by the INTEL_PMT_TELEMETRY subsystem.
resctrl enables events with resctrl_enable_mon_event() passing a pointer
to the pmt_event structure for the event within the struct event_group.
The file system stores it in mon_evt::arch_priv.

Clear the address field of regions that did not pass the checks in
skip_this_region() so they will not be used by intel_aet_read_event().
This is safe to do because intel_pmt_get_regions_by_feature() allocates
a new pmt_feature_group structure to return to each caller and only
makes use of the pmt_feature_group::kref field when
intel_pmt_put_feature_group() returns the structure.

Add a check to resctrl_arch_rmid_read() for resource id
RDT_RESOURCE_PERF_PKG and directly call intel_aet_read_event()
passing the enum resctrl_event_id for the event and the arch_priv
pointer that was supplied when the event was enabled.

There may be multiple aggregators tracking each package, so scan all of
them and add up all counters. Aggregators may return an invalid data
indication if they have received no records for a given RMID. Return
success to the user if one or more aggregators provide valid data.

Resctrl now uses readq() so depends on X86_64. Update Kconfig.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h  |  7 ++++
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 53 ++++++++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/monitor.c   |  3 ++
 arch/x86/Kconfig                        |  2 +-
 4 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 9ddfbbe5c3cf..8986071dd72a 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -172,9 +172,16 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 #ifdef CONFIG_X86_CPU_RESCTRL_INTEL_AET
 bool intel_aet_get_events(void);
 void __exit intel_aet_exit(void);
+int intel_aet_read_event(int domid, int rmid, enum resctrl_event_id evtid,
+			 void *arch_priv, u64 *val);
 #else
 static inline bool intel_aet_get_events(void) { return false; }
 static inline void __exit intel_aet_exit(void) { }
+static inline int intel_aet_read_event(int domid, int rmid, enum resctrl_event_id evtid,
+				       void *arch_priv, u64 *val)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index 5c5466dc3189..9239740e9647 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -14,6 +14,7 @@
 #include <linux/cleanup.h>
 #include <linux/cpu.h>
 #include <linux/intel_vsec.h>
+#include <linux/io.h>
 #include <linux/resctrl.h>
 
 #include "internal.h"
@@ -125,8 +126,14 @@ static bool enable_events(struct event_group *e, struct pmt_feature_group *p)
 	bool usable_events = false;
 
 	for (int i = 0; i < p->count; i++) {
-		if (skip_this_region(&p->regions[i], e))
+		if (skip_this_region(&p->regions[i], e)) {
+			/*
+			 * Clear addr so that intel_aet_read_event() will
+			 * skip this region.
+			 */
+			p->regions[i].addr = NULL;
 			continue;
+		}
 		usable_events = true;
 	}
 
@@ -204,3 +211,47 @@ void __exit intel_aet_exit(void)
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
+int intel_aet_read_event(int domid, int rmid, enum resctrl_event_id eventid,
+			 void *arch_priv, u64 *val)
+{
+	struct pmt_event *pevt = arch_priv;
+	struct event_group *e;
+	bool valid = false;
+	u64 evtcount;
+	void *pevt0;
+	int idx;
+
+	pevt0 = pevt - pevt->idx;
+	e = container_of(pevt0, struct event_group, evts);
+	idx = rmid * e->num_events;
+	idx += pevt->idx;
+
+	if (idx * sizeof(u64) + sizeof(u64) > e->mmio_size) {
+		pr_warn_once("MMIO index %d out of range\n", idx);
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
index 249569327e4a..0333dd85450b 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -232,6 +232,9 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hdr,
 
 	resctrl_arch_rmid_read_context_check();
 
+	if (r->rid == RDT_RESOURCE_PERF_PKG)
+		return intel_aet_read_event(hdr->id, rmid, eventid, arch_priv, val);
+
 	if (r->rid != RDT_RESOURCE_L3)
 		return -EINVAL;
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 50051fdf4659..a42f749f31cb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -527,7 +527,7 @@ config X86_CPU_RESCTRL
 
 config X86_CPU_RESCTRL_INTEL_AET
 	bool "Intel Application Energy Telemetry" if INTEL_PMT_TELEMETRY=y && INTEL_TPMI=y
-	depends on X86_CPU_RESCTRL && CPU_SUP_INTEL
+	depends on X86_64 && X86_CPU_RESCTRL && CPU_SUP_INTEL
 	help
 	  Enable per-RMID telemetry events in resctrl.
 
-- 
2.50.1


