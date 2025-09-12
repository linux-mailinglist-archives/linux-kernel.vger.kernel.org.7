Return-Path: <linux-kernel+bounces-814820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AA4B558FE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6862417DDBE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65A4362989;
	Fri, 12 Sep 2025 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2ziJpY/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5C135FC20
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 22:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715083; cv=none; b=hXlZUYeS7cv7IDj3n8XHBoHo82nH/xRE6U4EQUPWTSCDRqAJljZm7H/sEiiaXj+Kli+SqjPG6mqx3QuCR9vjt9/OK4gA4ErpkF4UuuicD+ylEEf4tl6JEb00YDdyoeO0JLNarM8wBjCfyhiwBZv+cxxe/aFAD13uWh0+b9VjvH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715083; c=relaxed/simple;
	bh=2HUuAzHe20nRMCZ/5WScTNwmIrfjvXa4EwyjIrFkErg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuCz7e2YiGMtIZCtCDCi3xNCQDkp74n8wWIXoTfcB5Fb5VOX8xB4OMbg9z3JcPfanTaLtgM+JwD3uwlyCt3n4F5pgYeCubR1AdQgjBwknzhwOsl+pwtCfv4rJML2mWwBAgo7N1TxRJcZL1PJRMoyvao6biLbhdWwP2InlbOWWL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2ziJpY/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757715081; x=1789251081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2HUuAzHe20nRMCZ/5WScTNwmIrfjvXa4EwyjIrFkErg=;
  b=V2ziJpY/u6NXjC7Wk1HhYNwACs9pqUPufg0C/yqp1zox8RL68WIV6TEV
   q3KQn9fS7qzukRCMwVZT695/SIQrxPv1q2Hrnwj2bghP+XtY4zAxBLuxv
   329z6StGL+9Gi/ueAdPsscJnFYNJZQ45BUeemNn0tM87kSsLb4AZ4bjaq
   QVwojpvfmYbNEaAnXXTUk9yWpNYhiojwc4aupWnYT0jnunSSqo4coF+uX
   pQSz7icZ1OUWo4L52kUoE0t42TEeMXr+tLB4k5rj1+r6eKR69Irz4AIJq
   VetvgIlxQOPE7r6O8jPtvBcg7e4duavDWGAlmNQKyFhfXF58tJ+1xkV0j
   g==;
X-CSE-ConnectionGUID: t2XFrldaRPKfZf6AmwH3Qw==
X-CSE-MsgGUID: 3fV9X8o0RdCzIhuAiL17oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="60002827"
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="60002827"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 15:11:13 -0700
X-CSE-ConnectionGUID: NO1rqUKxScWfn4FRZwkjMw==
X-CSE-MsgGUID: 9bTNvArbTUmQL8d3FhSoWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="179265225"
Received: from smoehrl-linux.amr.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.221.49])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 15:11:12 -0700
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
Subject: [PATCH v10 24/28] fs/resctrl: Move RMID initialization to first mount
Date: Fri, 12 Sep 2025 15:10:45 -0700
Message-ID: <20250912221053.11349-25-tony.luck@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912221053.11349-1-tony.luck@intel.com>
References: <20250912221053.11349-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

L3 monitor features are enumerated during resctrl initialization
and rmid_ptrs[] that tracks all RMIDs and depends on the
number of supported RMIDs is allocated during this time.

Telemetry monitor features are enumerated during first resctrl mount and
may support a different number of RMIDs compared to L3 monitor features.

Delay allocation and initialization of rmid_ptrs[] until first mount.
Since the number of RMIDs cannot change on later mounts, keep the same
set of rmid_ptrs[] until resctrl_exit(). This is required because the
limbo handler keeps running after resctrl is unmounted and may likely
need to access rmid_ptrs[] as it keeps tracking busy RMIDs after unmount.

Rename routines to match what they now do:
dom_data_init() -> setup_rmid_lru_list()
dom_data_exit() -> free_rmid_lru_list()

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 fs/resctrl/internal.h |  4 ++++
 fs/resctrl/monitor.c  | 50 +++++++++++++++++++------------------------
 fs/resctrl/rdtgroup.c |  5 +++++
 3 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index ec6f01751424..f2296f1efc12 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -367,6 +367,10 @@ int closids_supported(void);
 
 void closid_free(int closid);
 
+int setup_rmid_lru_list(void);
+
+void free_rmid_lru_list(void);
+
 int alloc_rmid(u32 closid);
 
 void free_rmid(u32 closid, u32 rmid);
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 8f15bdf40593..f85bd6a401c1 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -882,20 +882,27 @@ void mbm_setup_overflow_handler(struct rdt_l3_mon_domain *dom, unsigned long del
 		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
 }
 
-static int dom_data_init(struct rdt_resource *r)
+int setup_rmid_lru_list(void)
 {
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry = NULL;
-	int err = 0, i;
 	u32 idx;
+	int i;
 
-	mutex_lock(&rdtgroup_mutex);
+	if (!resctrl_arch_mon_capable())
+		return 0;
+
+	/*
+	 * Called on every mount, but the number of RMIDs cannot change
+	 * after the first mount, so keep using the same set of rmid_ptrs[]
+	 * until resctrl_exit().
+	 */
+	if (rmid_ptrs)
+		return 0;
 
 	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
-	if (!rmid_ptrs) {
-		err = -ENOMEM;
-		goto out_unlock;
-	}
+	if (!rmid_ptrs)
+		return -ENOMEM;
 
 	for (i = 0; i < idx_limit; i++) {
 		entry = &rmid_ptrs[i];
@@ -908,30 +915,24 @@ static int dom_data_init(struct rdt_resource *r)
 	/*
 	 * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are special and
 	 * are always allocated. These are used for the rdtgroup_default
-	 * control group, which will be setup later in resctrl_init().
+	 * control group, which was setup earlier in rdtgroup_setup_default().
 	 */
 	idx = resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
 					   RESCTRL_RESERVED_RMID);
 	entry = __rmid_entry(idx);
 	list_del(&entry->list);
 
-out_unlock:
-	mutex_unlock(&rdtgroup_mutex);
-
-	return err;
+	return 0;
 }
 
-static void dom_data_exit(struct rdt_resource *r)
+void free_rmid_lru_list(void)
 {
-	mutex_lock(&rdtgroup_mutex);
-
-	if (!r->mon_capable)
-		goto out_unlock;
+	if (!resctrl_arch_mon_capable())
+		return;
 
+	mutex_lock(&rdtgroup_mutex);
 	kfree(rmid_ptrs);
 	rmid_ptrs = NULL;
-
-out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
 }
 
@@ -1805,7 +1806,8 @@ static void closid_num_dirty_rmid_free(void)
  * resctrl_l3_mon_resource_init() - Initialise global monitoring structures.
  *
  * Allocate and initialise global monitor resources that do not belong to a
- * specific domain. i.e. the rmid_ptrs[] used for the limbo and free lists.
+ * specific domain. i.e. the closid_num_dirty_rmid[] used to find the CLOSID
+ * with the cleanest set of RMIDs.
  * Called once during boot after the struct rdt_resource's have been configured
  * but before the filesystem is mounted.
  * Resctrl's cpuhp callbacks may be called before this point to bring a domain
@@ -1825,12 +1827,6 @@ int resctrl_l3_mon_resource_init(void)
 	if (ret)
 		return ret;
 
-	ret = dom_data_init(r);
-	if (ret) {
-		closid_num_dirty_rmid_free();
-		return ret;
-	}
-
 	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_TOTAL_EVENT_ID)) {
 		mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].configurable = true;
 		resctrl_file_fflags_init("mbm_total_bytes_config",
@@ -1879,6 +1875,4 @@ void resctrl_l3_mon_resource_exit(void)
 		return;
 
 	closid_num_dirty_rmid_free();
-
-	dom_data_exit(r);
 }
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 19f0feb51420..94fa7fb7d598 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2734,6 +2734,10 @@ static int rdt_get_tree(struct fs_context *fc)
 		goto out;
 	}
 
+	ret = setup_rmid_lru_list();
+	if (ret)
+		goto out;
+
 	ret = rdtgroup_setup_root(ctx);
 	if (ret)
 		goto out;
@@ -4570,4 +4574,5 @@ void resctrl_exit(void)
 	 */
 
 	resctrl_l3_mon_resource_exit();
+	free_rmid_lru_list();
 }
-- 
2.51.0


