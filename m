Return-Path: <linux-kernel+bounces-658298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA836AC001B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 00:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF95F1BA6B97
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 22:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2472B242D63;
	Wed, 21 May 2025 22:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDjYg64s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D8F23D2BC
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867867; cv=none; b=Gvj8hTER2jTlP7k9GtFQVi8q1wx0Hs0vYs1Dl1v/CSiC2vmdYyL4Po0obU0evZvZn9EAnMNp/1ZlmsVZHeubMjm1ubo5BoO99n/jIqOf5U6GHYNj9zTgOK//GO8JtMtyR6Dci281beVGxT6yw/KE7+auh2nKxV4KgOygPtsGjoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867867; c=relaxed/simple;
	bh=YkH8pInjOA8YZNAMBZOi7J5lUe3CDx68wNebUeznpXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5i71dc9fvRO3IA5LEgvcDPyInyosoLYbx04HKPUMc/50Rks268G2RLl6WEnGqogJP16irTSst1yf9IfwVuWrz4H7neAkK+J5iaDxBbz3x56VJzNt+zlOvqQLbDKcD0LcGxz7K0q4fVq7UVUgET1uJE2keBCS2CqNc3BaYUaqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDjYg64s; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747867866; x=1779403866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YkH8pInjOA8YZNAMBZOi7J5lUe3CDx68wNebUeznpXQ=;
  b=lDjYg64sMUSHjV7qHLV5CVOEwzDBXHkqbbBkPbNpYNsYKVBGkoJtDpzL
   /l0kSkmwazl70xUi8BYqRa3kowHZ0qT0bsQsokUDM5bu66Vk+EAB3kbrx
   btBRN+pIA6+jLidcnwKta5D4/yPwp/vPAicJmLwD/h2QyawlkKsdofBnK
   Iwe+Qi2KHSUaeCv1lM0Kg1vi0h81oN9OfHqreHzWnaJpxav8xHHIsOSKh
   5/vBaDEGCnaKqgYDRIxzID4UbZNDbd19Qq5KMGLDl3UCZU8fvNL990OJp
   8bAwjifTqzl+0yF2t1lOrtkKK4Yi4iFM9WbF0ZnBElHt2SIVlNS118Poi
   g==;
X-CSE-ConnectionGUID: eEHbmFxnRv2iM+wYF9Nt+A==
X-CSE-MsgGUID: r9YYsiZ9QHu7kUFFVzrKFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="53677726"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="53677726"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 15:50:59 -0700
X-CSE-ConnectionGUID: 8xVbxhROS22n7AbDQJZEVw==
X-CSE-MsgGUID: S1pT8Y/cQ/udrchiuI3Q7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="141352160"
Received: from agluck-desk3.sc.intel.com ([172.25.103.51])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 15:50:58 -0700
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
Subject: [PATCH v5 13/29] x86,fs/resctrl: Handle events that can be read from any CPU
Date: Wed, 21 May 2025 15:50:31 -0700
Message-ID: <20250521225049.132551-14-tony.luck@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521225049.132551-1-tony.luck@intel.com>
References: <20250521225049.132551-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resctrl file system code was built with the assumption that monitor
events can only be read from a CPU in the cpumask_t set for each
domain.

This was true for x86 events accessed with an MSR interface, but may
not be true for other access methods such as MMIO.

Add a flag to struct mon_evt to indicate which events can be read on
any CPU.

Architecture uses resctrl_enable_mon_event() to enable an event and
set the flag appropriately.

Bypass all the smp_call*() code for events that can be read on any CPU
and call mon_event_count() directly from mon_event_read().

Skip checks in __mon_event_count() that the read is being done from
a CPU in the correct domain or cache scope.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h            |  2 +-
 fs/resctrl/internal.h              |  2 ++
 arch/x86/kernel/cpu/resctrl/core.c |  6 +++---
 fs/resctrl/ctrlmondata.c           |  7 ++++++-
 fs/resctrl/monitor.c               | 26 ++++++++++++++++++++------
 5 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index b7a4c7bf4feb..9aab3d78005a 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -377,7 +377,7 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 u32 resctrl_arch_system_num_rmid_idx(void);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
-void resctrl_enable_mon_event(enum resctrl_event_id evtid);
+void resctrl_enable_mon_event(enum resctrl_event_id evtid, bool any_cpu);
 
 bool resctrl_is_mon_event_enabled(enum resctrl_event_id evt);
 
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 085a2ee1922f..eb6e92d1ab15 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -57,6 +57,7 @@ static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
  * @rid:		index of the resource for this event
  * @name:		name of the event
  * @configurable:	true if the event is configurable
+ * @any_cpu:		true if the event can be read from any CPU
  * @enabled:		true if the event is enabled
  */
 struct mon_evt {
@@ -64,6 +65,7 @@ struct mon_evt {
 	enum resctrl_res_level	rid;
 	char			*name;
 	bool			configurable;
+	bool			any_cpu;
 	bool			enabled;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b39537658618..5d9a024ce4b0 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -880,15 +880,15 @@ static __init bool get_rdt_mon_resources(void)
 	bool ret = false;
 
 	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC)) {
-		resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID);
+		resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID, false);
 		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
-		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
+		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID, false);
 		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
-		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
+		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID, false);
 		ret = true;
 	}
 
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index dcde27f6f2ec..1337716f59c8 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -569,6 +569,11 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		return;
 	}
 
+	if (evt->any_cpu) {
+		mon_event_count(rr);
+		goto done;
+	}
+
 	cpu = cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
 
 	/*
@@ -581,7 +586,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		smp_call_function_any(cpumask, mon_event_count, rr, 1);
 	else
 		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
-
+done:
 	resctrl_arch_mon_ctx_free(r, evt->evtid, rr->arch_mon_ctx);
 }
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 3cfd1bf1845e..e6e3be990638 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -356,9 +356,24 @@ static struct mbm_state *get_mbm_state(struct rdt_l3_mon_domain *d, u32 closid,
 	return states ? &states[idx] : NULL;
 }
 
+static bool cpu_on_wrong_domain(struct rmid_read *rr)
+{
+	cpumask_t *mask;
+
+	if (rr->evt->any_cpu)
+		return false;
+
+	/*
+	 * When reading from a specific domain the CPU must be in that
+	 * domain. Otherwise the CPU must be one that shares the cache.
+	 */
+	mask = rr->d ? &rr->d->hdr.cpu_mask : &rr->ci->shared_cpu_map;
+
+	return !cpumask_test_cpu(smp_processor_id(), mask);
+}
+
 static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 {
-	int cpu = smp_processor_id();
 	struct rdt_l3_mon_domain *d;
 	struct mbm_state *m;
 	int err, ret;
@@ -373,8 +388,7 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 	}
 
 	if (rr->d) {
-		/* Reading a single domain, must be on a CPU in that domain. */
-		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
+		if (cpu_on_wrong_domain(rr))
 			return -EINVAL;
 		rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
 						 rr->evt->evtid, &tval, rr->arch_mon_ctx);
@@ -386,8 +400,7 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 		return 0;
 	}
 
-	/* Summing domains that share a cache, must be on a CPU for that cache. */
-	if (!cpumask_test_cpu(cpu, &rr->ci->shared_cpu_map))
+	if (cpu_on_wrong_domain(rr))
 		return -EINVAL;
 
 	/*
@@ -865,7 +878,7 @@ struct mon_evt mon_event_all[QOS_NUM_EVENTS] = {
 	},
 };
 
-void resctrl_enable_mon_event(enum resctrl_event_id evtid)
+void resctrl_enable_mon_event(enum resctrl_event_id evtid, bool any_cpu)
 {
 	if (WARN_ON_ONCE(evtid >= QOS_NUM_EVENTS))
 		return;
@@ -874,6 +887,7 @@ void resctrl_enable_mon_event(enum resctrl_event_id evtid)
 		return;
 	}
 
+	mon_event_all[evtid].any_cpu = any_cpu;
 	mon_event_all[evtid].enabled = true;
 }
 
-- 
2.49.0


