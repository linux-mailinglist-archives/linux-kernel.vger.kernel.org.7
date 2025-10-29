Return-Path: <linux-kernel+bounces-876718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A21CC1C183
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 179405A2468
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FC0357A36;
	Wed, 29 Oct 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACILWPv2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68483570A3
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754910; cv=none; b=iXivEbK1jbsTtQDZlnMy9+kCqtWWIrDxOx9JZU8EgJO7oAv+41d/5zCI2MdnUarEonyKFgfZYYgMOl2BbpHOFCEdMirpoN18miuxVjhPJSZvldA1YxTip9Bxs4Nf8QsvnwLXkSrDe93UezNjvWHJteelwm61OSFbvtitWn+wUhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754910; c=relaxed/simple;
	bh=JiFS0CexxBfh1T3Xu534A0j8kEAr954jKVs6ltTpUC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqh4JYRzSP9+jaUy2CtMIt29Kl1B5kaJ1fmskd6T1vdPAziwLJ0jU3NKaze6Tn9//lq8DKbw70CpHnF53l+rh7dARsRulb8fjAFuZrRS8/OqiP64nB2hMhZzpPXFBVTlIV+09EoeMpYBhjq/B8hq5UtxiYq13eojsXgaggTdu0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACILWPv2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761754907; x=1793290907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JiFS0CexxBfh1T3Xu534A0j8kEAr954jKVs6ltTpUC4=;
  b=ACILWPv2bdmw6lRld74fMFdMwhZbDtkr0uG/qd6h6mpZN2myb53h6ox2
   Zt7zwm5rcy3WMmv3aveTsJvY+cNRRtEBrCcOav0hACQ5xkKGkfSC46Ygj
   Oets4dHhm0R92dF+1r/sQp2dqKMg8gFRPSyfa081uvotvR6aPUJkgKVln
   qi2r9OCoYQxhlnQjzoHPF2WhxpVjqOhaKQDgmc8zXX3t0EHqysiSMUizQ
   QZWRVM8fALLCvYMaH4koJMrDGgGj2a/VyYNmWB7mmE7WKVvPbE8QYGAMA
   eQvdLVqxC4Ra1fQ0PtCpuUU4GcfZx3x6pBNr+GM9phjuycntK7Nhj0tGw
   Q==;
X-CSE-ConnectionGUID: PqBMl812Qq+MYZm2zbICYw==
X-CSE-MsgGUID: pRmmuaroSamCPBhF6oQwFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75331045"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="75331045"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:35 -0700
X-CSE-ConnectionGUID: Svxtl1g7Q1+oMS5l0fC99Q==
X-CSE-MsgGUID: P2PXqnESQ/y3aUR7Zo7zlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="184901409"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.223.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:35 -0700
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
Subject: [PATCH v13 28/32] fs/resctrl: Move RMID initialization to first mount
Date: Wed, 29 Oct 2025 09:21:11 -0700
Message-ID: <20251029162118.40604-29-tony.luck@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029162118.40604-1-tony.luck@intel.com>
References: <20251029162118.40604-1-tony.luck@intel.com>
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
limbo handler keeps running after resctrl is unmounted and needs
to access rmid_ptrs[] as it keeps tracking busy RMIDs after unmount.

Rename routines to match what they now do:
dom_data_init() -> setup_rmid_lru_list()
dom_data_exit() -> free_rmid_lru_list()

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 fs/resctrl/internal.h |  4 ++++
 fs/resctrl/monitor.c  | 54 ++++++++++++++++++++-----------------------
 fs/resctrl/rdtgroup.c |  5 ++++
 3 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 46fd648a2961..0dd89d3fa31a 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -369,6 +369,10 @@ int closids_supported(void);
 
 void closid_free(int closid);
 
+int setup_rmid_lru_list(void);
+
+void free_rmid_lru_list(void);
+
 int alloc_rmid(u32 closid);
 
 void free_rmid(u32 closid, u32 rmid);
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 9f5097a4be82..448f490ba344 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -890,20 +890,29 @@ void mbm_setup_overflow_handler(struct rdt_l3_mon_domain *dom, unsigned long del
 		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
 }
 
-static int dom_data_init(struct rdt_resource *r)
+int setup_rmid_lru_list(void)
 {
-	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry = NULL;
-	int err = 0, i;
+	u32 idx_limit;
 	u32 idx;
+	int i;
 
-	mutex_lock(&rdtgroup_mutex);
+	if (!resctrl_arch_mon_capable())
+		return 0;
 
+	/*
+	 * Called on every mount, but the number of RMIDs cannot change
+	 * after the first mount, so keep using the same set of rmid_ptrs[]
+	 * until resctrl_exit(). Note that the limbo handler continues to
+	 * access rmid_ptrs[] after resctrl is unmounted.
+	 */
+	if (rmid_ptrs)
+		return 0;
+
+	idx_limit = resctrl_arch_system_num_rmid_idx();
 	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
-	if (!rmid_ptrs) {
-		err = -ENOMEM;
-		goto out_unlock;
-	}
+	if (!rmid_ptrs)
+		return -ENOMEM;
 
 	for (i = 0; i < idx_limit; i++) {
 		entry = &rmid_ptrs[i];
@@ -916,30 +925,24 @@ static int dom_data_init(struct rdt_resource *r)
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
 
@@ -1815,7 +1818,8 @@ static void closid_num_dirty_rmid_free(void)
  * resctrl_l3_mon_resource_init() - Initialise global monitoring structures.
  *
  * Allocate and initialise global monitor resources that do not belong to a
- * specific domain. i.e. the rmid_ptrs[] used for the limbo and free lists.
+ * specific domain. i.e. the closid_num_dirty_rmid[] used to find the CLOSID
+ * with the cleanest set of RMIDs.
  * Called once during boot after the struct rdt_resource's have been configured
  * but before the filesystem is mounted.
  * Resctrl's cpuhp callbacks may be called before this point to bring a domain
@@ -1835,12 +1839,6 @@ int resctrl_l3_mon_resource_init(void)
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
@@ -1887,6 +1885,4 @@ void resctrl_l3_mon_resource_exit(void)
 		return;
 
 	closid_num_dirty_rmid_free();
-
-	dom_data_exit(r);
 }
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 15b2765898d6..17f5b986f210 100644
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
@@ -4586,4 +4590,5 @@ void resctrl_exit(void)
 	 */
 
 	resctrl_l3_mon_resource_exit();
+	free_rmid_lru_list();
 }
-- 
2.51.0


