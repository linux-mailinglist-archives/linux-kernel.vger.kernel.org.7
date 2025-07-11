Return-Path: <linux-kernel+bounces-728430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F03B02806
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84644E09CC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6767B246796;
	Fri, 11 Jul 2025 23:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DEOKCOT7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E14243964
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 23:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752278053; cv=none; b=u8MYNIXHkxHCM7HBv03x5zR3KS40OKG1e+7D3xBOEqg5Caru/fCjqcvCxfoHh2InUWqnq0V6cmrBJa+B5Q2AAeoR3/5RQAfNW5iCeGpJTETPkRoYJiY94hW/CB62LSBB04Vd8GAmYEee6uSVIQk89/MbKgg9+hAvan7iEVM+Ev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752278053; c=relaxed/simple;
	bh=U1ifVbvO+qNS8csk9YqAqbdJ9si8vGjr9Ymt+ieUuVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVSZu5zEs7D8lvHjMfp5c65zY+GUr5rcouubH4lMasx9oYdHC6WSKLi9CQPsAHthKFWAUVLsvrdLeIUOSg6wIBJF30rQBa8G+r8cJ/mdNYNdz0b98sIl5vlih9H5gIqiG6jwtmSmpcLg3fD0Z+K/obZcjxvzHfjGZHN03FAr624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DEOKCOT7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752278051; x=1783814051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U1ifVbvO+qNS8csk9YqAqbdJ9si8vGjr9Ymt+ieUuVw=;
  b=DEOKCOT7YFGKUrb9EQbCjMhH/Lmj8lpo8ungBREqpys7BbK1utHqFhbX
   YTCNzOeFtw22kjjX4P5aVfS2uFC0dYwPnrXvFnlg63eoxuT1I8z6pmH9l
   fZFsNulvAn0cVkgLGnGGXBeh3/puya+b67aZdSbRna1ibQghb10J/ZZ33
   rReFZtZC2RDqgfREoQo7bl72nxw+Ke0f1hNupi815WRb92mqVDEykPEkX
   SliDVQ6C0Y6yHLpQeCTqPjkYXtv/qMSJWy8+w7xxZAPgAd+o4QI9hmxmU
   BeCeocXNqNaicvbZWtwxRo7wic7mpw5Rk3ao6G7hT9i9SXnk33jN8ieCU
   w==;
X-CSE-ConnectionGUID: AwbqU1jcSmWKX3oqVzjv1w==
X-CSE-MsgGUID: 1hBd3DxVTjyNrX7IYhZcWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54292794"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="54292794"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:54:06 -0700
X-CSE-ConnectionGUID: sFKna1jxQ9Wna7KwhDh46g==
X-CSE-MsgGUID: HAXMTZZDQ9iJl5bK3S2UNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="155902169"
Received: from agluck-desk3.sc.intel.com ([172.25.103.51])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:54:07 -0700
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
Subject: [PATCH v7 27/31] x86,fs/resctrl: Move RMID initialization to first mount
Date: Fri, 11 Jul 2025 16:53:34 -0700
Message-ID: <20250711235341.113933-28-tony.luck@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711235341.113933-1-tony.luck@intel.com>
References: <20250711235341.113933-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The resctrl file system code assumed that the only monitor events were
tied to the RDT_RESOURCE_L3 resource. Also that the number of supported
RMIDs was enumerated during early initialization.

RDT_RESOURCE_PERF_PKG breaks both of those assumptions.

Delay the final enumeration of the number of RMIDs and subsequent
allocation of structures until first mount of the resctrl file system
so that the number of usable RMIDs can be computed as the minimum
value from all enabled monitor resources.

Since the dom_data* functions now only allocate/free structures
used for RMIDs, rename: dom_data_init() -> rmid_init(),
dom_data_exit() -> rmid_exit().

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 fs/resctrl/internal.h              |  2 ++
 arch/x86/kernel/cpu/resctrl/core.c |  8 ++++++--
 fs/resctrl/monitor.c               | 26 +++++++++-----------------
 fs/resctrl/rdtgroup.c              |  6 ++++++
 4 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 28d505efdb7c..7fca1849742f 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -358,6 +358,8 @@ int alloc_rmid(u32 closid);
 
 void free_rmid(u32 closid, u32 rmid);
 
+int rmid_init(void);
+
 int resctrl_mon_l3_resource_init(void);
 
 void resctrl_mon_l3_resource_exit(void);
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 31fb598482bf..1a6635cc5b37 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -112,10 +112,14 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 
 u32 resctrl_arch_system_num_rmid_idx(void)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	u32 num_rmids = U32_MAX;
+	struct rdt_resource *r;
+
+	for_each_mon_capable_rdt_resource(r)
+		num_rmids = min(num_rmids, r->num_rmid);
 
 	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
-	return r->num_rmid;
+	return num_rmids == U32_MAX ? 0 : num_rmids;
 }
 
 struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index e3eceba70713..3fe81c43e5e8 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -833,20 +833,19 @@ void mbm_setup_overflow_handler(struct rdt_l3_mon_domain *dom, unsigned long del
 		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
 }
 
-static int dom_data_init(struct rdt_resource *r)
+int rmid_init(void)
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
@@ -866,13 +865,10 @@ static int dom_data_init(struct rdt_resource *r)
 	entry = __rmid_entry(idx);
 	list_del(&entry->list);
 
-out_unlock:
-	mutex_unlock(&rdtgroup_mutex);
-
-	return err;
+	return 0;
 }
 
-static void dom_data_exit(struct rdt_resource *r)
+static void rmid_exit(struct rdt_resource *r)
 {
 	mutex_lock(&rdtgroup_mutex);
 
@@ -965,10 +961,6 @@ int resctrl_mon_l3_resource_init(void)
 	if (ret)
 		return ret;
 
-	ret = dom_data_init(r);
-	if (ret)
-		return ret;
-
 	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_TOTAL_EVENT_ID)) {
 		mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].configurable = true;
 		resctrl_file_fflags_init("mbm_total_bytes_config",
@@ -993,5 +985,5 @@ void resctrl_mon_l3_resource_exit(void)
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 
 	closid_num_dirty_rmid_exit();
-	dom_data_exit(r);
+	rmid_exit(r);
 }
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index b45f3d63c629..9e667d3a93ae 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2599,6 +2599,12 @@ static int rdt_get_tree(struct fs_context *fc)
 		goto out;
 	}
 
+	if (resctrl_arch_mon_capable()) {
+		ret = rmid_init();
+		if (ret)
+			goto out;
+	}
+
 	ret = rdtgroup_setup_root(ctx);
 	if (ret)
 		goto out;
-- 
2.50.0


