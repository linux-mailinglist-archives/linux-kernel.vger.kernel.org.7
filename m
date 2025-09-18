Return-Path: <linux-kernel+bounces-763397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A86B2141D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C25D6253AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AE72E62C3;
	Mon, 11 Aug 2025 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ak+g1wHJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1434B2E2DD5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936271; cv=none; b=EMSY0cH3IjLWDfW/2JJUvoLQ1NvTlku8bfPCCLqOZ/uPLpELKlsJiVi1wl8lAhFZGd12Xn+f+keu8kGzQ0+WCJXwzwYfPTrLXtwPARKGPYN3FIAbNhskeJV0chb4Che/Hx9fJucoiLDYdoPBEulz0dElg8wIqJCrwGxUGHlQLns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936271; c=relaxed/simple;
	bh=IKYOQlaLkDfqxldhdwZ4iBsq80GjbczOCwCWrZU2NHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQFMUxzoP23lIa2iNZI9ux27GPYxuTVGvXCqN6hWraV7OmdFl2d7xti5hfA6cyjIpCAcEdXhh9HHPhbvepQ2MsQAL07UtfpeOwH5sg6jZB3eYBEJFPk+QJm8r7GrAY78RU1FXqF9ERFzhdzMcPIApNlMG5aEwKgTn6qpathGF40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ak+g1wHJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754936269; x=1786472269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IKYOQlaLkDfqxldhdwZ4iBsq80GjbczOCwCWrZU2NHQ=;
  b=ak+g1wHJdtgf9juPHjCwUVK0p81p7e3uFY+rPWTJ4GFUxF+vKHi2bhsP
   it5akpsNYhsyyURG+cxGRiceQxj+Iy55XTIKYadKtz1gGmpUu7GVddgfB
   0NVxwc9mnT/GwN+zZ6+9GR2eF3fCYGpxNp04WUd6Ul0JStIwOttp2e2S5
   d5O2Se0ouK7/XCJu+hNymHvdrmG3si2sh7LKZaNAUOVq7BQX00NpAJzkQ
   gs+qTHe0cgA84c6QX260s3YKFS+6MzYdsr/yfjefSAvbqUT4aspyvh5mG
   Le5y4HaSjVAmoy311RnEpui4Xf/sMBRr2MQDW+ms4it6dzM/IK+YGLGJF
   g==;
X-CSE-ConnectionGUID: LUET71rwTJm8NJyww/I0Zw==
X-CSE-MsgGUID: VI+caHamSvG2ABVXELS8vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68277539"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68277539"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:17:27 -0700
X-CSE-ConnectionGUID: TU5NnaykTSWYst8ZBkie9g==
X-CSE-MsgGUID: VfFlBiyVSrCGX3kemrFEyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="196825708"
Received: from puneetse-mobl.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.221.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:17:26 -0700
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
Subject: [PATCH v8 28/32] fs/resctrl: Move RMID initialization to first mount
Date: Mon, 11 Aug 2025 11:17:02 -0700
Message-ID: <20250811181709.6241-29-tony.luck@intel.com>
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

resctrl assumesthat the number of supported RMIDs is enumerated during
early initialization.

Telemetry monitor events break that assumption because they are not
enumerated in early initialization and may support a different number
of RMIDs compared to L3 monitor features.

Delay allocation and initialization of rmid_ptrs[] until first mount.

Rename routines to match what they now do:
dom_data_init() -> setup_rmid_lru_list()
dom_data_exit() -> free_rmid_lru_list()

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 fs/resctrl/internal.h |  4 ++++
 fs/resctrl/monitor.c  | 47 ++++++++++---------------------------------
 fs/resctrl/rdtgroup.c |  7 +++++++
 3 files changed, 22 insertions(+), 36 deletions(-)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 9c1f821279bb..7abe3cb5c7ff 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -354,6 +354,10 @@ int closids_supported(void);
 
 void closid_free(int closid);
 
+int setup_rmid_lru_list(void);
+
+void free_rmid_lru_list(void);
+
 int alloc_rmid(u32 closid);
 
 void free_rmid(u32 closid, u32 rmid);
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 0d9c8d4e0e9c..4c13b55db995 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -802,20 +802,19 @@ void mbm_setup_overflow_handler(struct rdt_l3_mon_domain *dom, unsigned long del
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
@@ -828,31 +827,20 @@ static int dom_data_init(struct rdt_resource *r)
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
-
 	kfree(rmid_ptrs);
 	rmid_ptrs = NULL;
-
-out_unlock:
-	mutex_unlock(&rdtgroup_mutex);
 }
 
 #define MON_EVENT(_eventid, _name, _res, _fp)	\
@@ -914,7 +902,8 @@ bool resctrl_is_mon_event_enabled(enum resctrl_event_id eventid)
  * resctrl_mon_l3_resource_init() - Initialise global monitoring structures.
  *
  * Allocate and initialise global monitor resources that do not belong to a
- * specific domain. i.e. the rmid_ptrs[] used for the limbo and free lists.
+ * specific domain. i.e. the closid_num_dirty_rmid[] used to find the CLOSID
+ * with the cleanest set of RMIDs.
  * Called once during boot after the struct rdt_resource's have been configured
  * but before the filesystem is mounted.
  * Resctrl's cpuhp callbacks may be called before this point to bring a domain
@@ -925,7 +914,6 @@ bool resctrl_is_mon_event_enabled(enum resctrl_event_id eventid)
 int resctrl_mon_l3_resource_init(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
-	int ret;
 
 	if (!r->mon_capable)
 		return 0;
@@ -947,15 +935,6 @@ int resctrl_mon_l3_resource_init(void)
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
@@ -977,12 +956,8 @@ int resctrl_mon_l3_resource_init(void)
 
 void resctrl_mon_l3_resource_exit(void)
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
index 5352480eb55c..d1ecc5cd3089 100644
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
 
 	resctrl_mon_l3_resource_exit();
+	free_rmid_lru_list();
 }
-- 
2.50.1


