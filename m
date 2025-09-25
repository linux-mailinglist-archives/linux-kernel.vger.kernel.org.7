Return-Path: <linux-kernel+bounces-833153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E4BBA14EB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDEA1C245CC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789C5327A24;
	Thu, 25 Sep 2025 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRVA0hjc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C1326D46
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830665; cv=none; b=YLnNmliqCX6pWiDHV//Z0GFFE5AhZKnYbyWNWbay3Ya+yFmR6Pabe34E3WIJwx2TSl51vNgcDekMSRhPmBg7k1GLwt74MVAQ9vQOHfhRcE/JbSRscDCiqFgWsCnpBA5/diASJo31Oif5WXmudXcn7yJWCZXaP8eB68FaBGF19Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830665; c=relaxed/simple;
	bh=WZ1VQPKETnAUaaJQPINDo0+bF5Nl1BBFH5euWNjpisQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJPaWzumTGVqQ3UFmvOBk3gdHAYnl/MHZYbunf5fpzXYbBl3YNOhtKb7Nlui9H2DN6vWvGEnOtVfdYcoBUBoCdyxNZ887L6iGLfFfYvoQraezk0eNT8KeB65hbIH0yFl6CY2BZkhDp13LgPLGJPed3GDKySCmw1I0bc2woKCq84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRVA0hjc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758830664; x=1790366664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WZ1VQPKETnAUaaJQPINDo0+bF5Nl1BBFH5euWNjpisQ=;
  b=TRVA0hjcQhwB+x68vs+xytLUleJpP7mm6mbFnPtMS+X69SaELiJjyJET
   4zJ3JXauZYE6PYdtp117in63xKtRr/q7GieMYpEymQlOc9WKVVqRdOGHZ
   uMF/KJm+hI/YlL447nJUdGs6UIpfrY1+ezJdPD67YgevORLrk1QqilFhg
   CQQsh8jvXCmyNMT6SlCcgsgAg3++YqScSWVXpqHOXdQ8vLXFgFjXRoIAF
   h0hKMkswK22SrtRaxocC3+owkE3QECCJPj9j5R9l6UghGTqMgq1laz7Uq
   sNtqvwhcZu5YGGAc3EBMQZ3VN5MbH1FnwFQN1d4rOxmRlGdmsGV9yqzWA
   Q==;
X-CSE-ConnectionGUID: 9atJDMepTe+newUz1TYsbw==
X-CSE-MsgGUID: 5gPWUEskQDySN6mOZA/mJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61074343"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61074343"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 13:04:14 -0700
X-CSE-ConnectionGUID: AqAY7lp1QrOAxM5yGOq8LQ==
X-CSE-MsgGUID: Oh+EW0JOSMOlXJXhJF0KXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="177003687"
Received: from inaky-mobl1.amr.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.220.206])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 13:04:13 -0700
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
Subject: [PATCH v11 24/31] fs/resctrl: Move allocation/free of closid_num_dirty_rmid[]
Date: Thu, 25 Sep 2025 13:03:18 -0700
Message-ID: <20250925200328.64155-25-tony.luck@intel.com>
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

closid_num_dirty_rmid[] is allocated in dom_data_init() during resctrl
initialization and freed by dom_data_exit() during resctrl exit giving
it the same life cycle as rmid_ptrs[].

Move closid_num_dirty_rmid[] allocaction/free out to
resctrl_l3_mon_resource_init() and resctrl_l3_mon_resource_exit() in
preparation for rmid_ptrs[] to be allocated on resctrl mount in support
of the new telemetry events.

Keep the rdtgroup_mutex protection around the allocation/free of
closid_num_dirty_rmid[] as ARM needs this to guarantee memory
ordering.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 fs/resctrl/monitor.c | 77 ++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index d484983c0f02..5960a0afd0ca 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -883,36 +883,14 @@ void mbm_setup_overflow_handler(struct rdt_l3_mon_domain *dom, unsigned long del
 static int dom_data_init(struct rdt_resource *r)
 {
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
-	u32 num_closid = resctrl_arch_get_num_closid(r);
 	struct rmid_entry *entry = NULL;
 	int err = 0, i;
 	u32 idx;
 
 	mutex_lock(&rdtgroup_mutex);
-	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
-		u32 *tmp;
-
-		/*
-		 * If the architecture hasn't provided a sanitised value here,
-		 * this may result in larger arrays than necessary. Resctrl will
-		 * use a smaller system wide value based on the resources in
-		 * use.
-		 */
-		tmp = kcalloc(num_closid, sizeof(*tmp), GFP_KERNEL);
-		if (!tmp) {
-			err = -ENOMEM;
-			goto out_unlock;
-		}
-
-		closid_num_dirty_rmid = tmp;
-	}
 
 	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
 	if (!rmid_ptrs) {
-		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
-			kfree(closid_num_dirty_rmid);
-			closid_num_dirty_rmid = NULL;
-		}
 		err = -ENOMEM;
 		goto out_unlock;
 	}
@@ -948,11 +926,6 @@ static void dom_data_exit(struct rdt_resource *r)
 	if (!r->mon_capable)
 		goto out_unlock;
 
-	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
-		kfree(closid_num_dirty_rmid);
-		closid_num_dirty_rmid = NULL;
-	}
-
 	kfree(rmid_ptrs);
 	rmid_ptrs = NULL;
 
@@ -1789,6 +1762,43 @@ ssize_t mbm_L3_assignments_write(struct kernfs_open_file *of, char *buf,
 	return ret ?: nbytes;
 }
 
+static int closid_num_dirty_rmid_alloc(struct rdt_resource *r)
+{
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+		u32 num_closid = resctrl_arch_get_num_closid(r);
+		u32 *tmp;
+
+		/* For ARM memory ordering access to closid_num_dirty_rmid */
+		mutex_lock(&rdtgroup_mutex);
+
+		/*
+		 * If the architecture hasn't provided a sanitised value here,
+		 * this may result in larger arrays than necessary. Resctrl will
+		 * use a smaller system wide value based on the resources in
+		 * use.
+		 */
+		tmp = kcalloc(num_closid, sizeof(*tmp), GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+
+		closid_num_dirty_rmid = tmp;
+
+		mutex_unlock(&rdtgroup_mutex);
+	}
+
+	return 0;
+}
+
+static void closid_num_dirty_rmid_free(void)
+{
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+		mutex_lock(&rdtgroup_mutex);
+		kfree(closid_num_dirty_rmid);
+		closid_num_dirty_rmid = NULL;
+		mutex_unlock(&rdtgroup_mutex);
+	}
+}
+
 /**
  * resctrl_l3_mon_resource_init() - Initialise global monitoring structures.
  *
@@ -1809,10 +1819,16 @@ int resctrl_l3_mon_resource_init(void)
 	if (!r->mon_capable)
 		return 0;
 
-	ret = dom_data_init(r);
+	ret = closid_num_dirty_rmid_alloc(r);
 	if (ret)
 		return ret;
 
+	ret = dom_data_init(r);
+	if (ret) {
+		closid_num_dirty_rmid_free();
+		return ret;
+	}
+
 	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_TOTAL_EVENT_ID)) {
 		mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].configurable = true;
 		resctrl_file_fflags_init("mbm_total_bytes_config",
@@ -1857,5 +1873,10 @@ void resctrl_l3_mon_resource_exit(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 
+	if (!r->mon_capable)
+		return;
+
+	closid_num_dirty_rmid_free();
+
 	dom_data_exit(r);
 }
-- 
2.51.0


