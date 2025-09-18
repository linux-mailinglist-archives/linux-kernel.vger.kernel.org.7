Return-Path: <linux-kernel+bounces-792382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27071B3C331
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E09A66A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C2235084A;
	Fri, 29 Aug 2025 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ny2O0gTY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F43B343D99
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496054; cv=none; b=GfouDQsE9GjDhLgxCs1wsxz88QrKJeSh6ZBZJkbKx2SLbivrrCSvFgk6kjgCXQRWU6mrfJeZORYQC15Qkf23Az0+aSDjuZkfFCXlkwD7Wu/smcr3CsQfE27U1Lf8rbQ9HQlshkPCBwzKfgxg+ENl6ZMrXy81sLdjVIQ1q1D2nSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496054; c=relaxed/simple;
	bh=I0AoKEGVNepufHaTc5K+obsXF6i+o7oDNg07Q0gurMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ghr/f91wFO+22kt3m+bMoCslzC1JQfACaOEQQPALpkrscN689N3bTiWwu+anCLzxMIvwkllCoyOpMptDKAHY/dvXTgs95MvPq2tfWVs92E/fcRIziOt/fJjzgC9sBTpt4XeUVMAi+ewt2klgPk7e4FSfNDRyVfIR7IeH/vjxc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ny2O0gTY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756496051; x=1788032051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I0AoKEGVNepufHaTc5K+obsXF6i+o7oDNg07Q0gurMA=;
  b=Ny2O0gTYnCqFhbi9pkq42UwKujd2+VWDIhfYqA2kcYbkcIonVW9vZ7VX
   hF5c4rW4YRkes9Zc7l7lG/+AjZswtNtZvvrutgwWJ1J5Lx0rEeWQaLdZt
   4dnfFGnGMDpDLVWREPwbKo8cL/xdmZFla+dWzewgsAaZsrK3RhxdSvHLV
   PlWMF5jhhi8gldp6pNAikpgUARrDXf7fI3ALXkQoS6Wucg2Uk47qSY5yF
   Of98IsVpwc5K0g6UtQeDJcCtABvCp9NEyLbR/8H/tY+A6WQWF3GsLJGZC
   mhoT3Ufjz5QSvTssVSejoogmmRjob9eeFjvrd/bcxa9C3eyJsgLx+IulZ
   Q==;
X-CSE-ConnectionGUID: 8znIozXFROCLmOgzQOYhtQ==
X-CSE-MsgGUID: EQX9IMjBQRWvRswkiAezMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62625359"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62625359"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:33:57 -0700
X-CSE-ConnectionGUID: HeJMq+zSSdKY7kNVxNNEEg==
X-CSE-MsgGUID: IpAduK0xSverX79sWXWAOQ==
X-ExtLoop1: 1
Received: from ldmartin-desk2.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.220.202])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:33:57 -0700
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
Subject: [PATCH v9 27/31] fs/resctrl: Move RMID initialization to first mount
Date: Fri, 29 Aug 2025 12:33:39 -0700
Message-ID: <20250829193346.31565-28-tony.luck@intel.com>
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

L3 monitor features are enumerated during resctrl initialization
and rmid_ptrs[] that tracks all RMIDs and depends on the
number of supported RMIDs is allocated during this time.

Telemetry monitor features are enumerated during first resctrl mount and
may support a different number of RMIDs compared to L3 monitor features.

Delay allocation and initialization of rmid_ptrs[] until first mount.
Since the number of RMIDs cannot change on later mounts, keep the same
set of rmid_ptrs[] until resctrl_exit().

Rename routines to match what they now do:
dom_data_init() -> setup_rmid_lru_list()
dom_data_exit() -> free_rmid_lru_list()

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 fs/resctrl/internal.h |  4 ++++
 fs/resctrl/monitor.c  | 50 ++++++++++++++-----------------------------
 fs/resctrl/rdtgroup.c |  7 ++++++
 3 files changed, 27 insertions(+), 34 deletions(-)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 7c37142df1cc..6dde28d9cfac 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -357,6 +357,10 @@ int closids_supported(void);
 
 void closid_free(int closid);
 
+int setup_rmid_lru_list(void);
+
+void free_rmid_lru_list(void);
+
 int alloc_rmid(u32 closid);
 
 void free_rmid(u32 closid, u32 rmid);
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index d5b96aca5d03..636342fad5a4 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -802,20 +802,24 @@ void mbm_setup_overflow_handler(struct rdt_l3_mon_domain *dom, unsigned long del
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
@@ -828,30 +832,21 @@ static int dom_data_init(struct rdt_resource *r)
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
 	mutex_lock(&rdtgroup_mutex);
-
-	if (!r->mon_capable)
-		goto out_unlock;
-
 	kfree(rmid_ptrs);
 	rmid_ptrs = NULL;
-
-out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
 }
 
@@ -914,7 +909,8 @@ bool resctrl_is_mon_event_enabled(enum resctrl_event_id eventid)
  * resctrl_l3_mon_resource_init() - Initialise global monitoring structures.
  *
  * Allocate and initialise global monitor resources that do not belong to a
- * specific domain. i.e. the rmid_ptrs[] used for the limbo and free lists.
+ * specific domain. i.e. the closid_num_dirty_rmid[] used to find the CLOSID
+ * with the cleanest set of RMIDs.
  * Called once during boot after the struct rdt_resource's have been configured
  * but before the filesystem is mounted.
  * Resctrl's cpuhp callbacks may be called before this point to bring a domain
@@ -925,7 +921,6 @@ bool resctrl_is_mon_event_enabled(enum resctrl_event_id eventid)
 int resctrl_l3_mon_resource_init(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
-	int ret;
 
 	if (!r->mon_capable)
 		return 0;
@@ -947,15 +942,6 @@ int resctrl_l3_mon_resource_init(void)
 		closid_num_dirty_rmid = tmp;
 	}
 
-	ret = dom_data_init(r);
-	if (ret) {
-		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
-			kfree(closid_num_dirty_rmid);
-			closid_num_dirty_rmid = NULL;
-		}
-		return ret;
-	}
-
 	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_TOTAL_EVENT_ID)) {
 		mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].configurable = true;
 		resctrl_file_fflags_init("mbm_total_bytes_config",
@@ -977,12 +963,8 @@ int resctrl_l3_mon_resource_init(void)
 
 void resctrl_l3_mon_resource_exit(void)
 {
-	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
-
 	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
 		kfree(closid_num_dirty_rmid);
 		closid_num_dirty_rmid = NULL;
 	}
-
-	dom_data_exit(r);
 }
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 3201e9cad8da..886de0e01e8a 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2599,6 +2599,12 @@ static int rdt_get_tree(struct fs_context *fc)
 		goto out;
 	}
 
+	if (resctrl_arch_mon_capable()) {
+		ret = setup_rmid_lru_list();
+		if (ret)
+			goto out;
+	}
+
 	ret = rdtgroup_setup_root(ctx);
 	if (ret)
 		goto out;
@@ -4408,4 +4414,5 @@ void resctrl_exit(void)
 	 */
 
 	resctrl_l3_mon_resource_exit();
+	free_rmid_lru_list();
 }
-- 
2.50.1


