Return-Path: <linux-kernel+bounces-763395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C98B2141C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAA137B2F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9956D2E5B0C;
	Mon, 11 Aug 2025 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qg90mH7i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD392E541A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936269; cv=none; b=DkcUfQMeINXj5GsPl4tZxVpShMyBmVP3ROkREMbZ5eLTQ7jd29svRvbkAtd27wocPHyGMDQsdt0SBrrWw+KZOYUbnxof88apt/JwGyh88nl8smrx4vAUavoXWqeCYTHHwEMrumJmopyi5zo4vFhgkQdu7lfqqa8T1qpB4xtNpLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936269; c=relaxed/simple;
	bh=b6IVqR9pDUjerzkW1aPFwxLkZVvGGdytWKlMSyP1xH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2r+6+UdyWzZpobjcJ7B8Y5iHNg84n4uJ9VWDzm0+A2XFI+iZeL0wwnYPg7dDMJhVLgatq8LrHWIiMsPqtj6g7L1OFx1aJ+vxWmkq/k7Tlqt5k54cFdHsrY9t1az3W5FEkNNkSBFVCmspvbNsLIw+tWnY4j2/I5ED789cG2ljuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qg90mH7i; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754936268; x=1786472268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b6IVqR9pDUjerzkW1aPFwxLkZVvGGdytWKlMSyP1xH8=;
  b=Qg90mH7irnr/HhgLp1sMLbp5dATrsoViVpZiFdCMHiTAaGnyKwPWvKws
   SPKJlobATLZxOaP4rJqHhzTpuwiU1aGF4E7JIhCG6P83ZIDH6nDEnETqF
   3tLH9sUZVgr69REi8wGWjJkokN647ashRXCppMLpnFpcsH7IV/Q9I1kH+
   nyzbnreA3jD2JPRxSI+mfqlkxBL27bVPvptrz7cF6cNouKhqlYQ6kJVO4
   U5XkCVbgJOZ/FjFUk5L7jqeeR1DmUb/pfcD+jsd1pL6/NixF+vXr950/8
   G5PaZJvSwxivtVIxsdB3CMiLLusyLFVDaZNUAajCgd5u+KLtUSTk23l1i
   g==;
X-CSE-ConnectionGUID: k97X4CgNRZqdDN0qb+q8rw==
X-CSE-MsgGUID: 5XNQq5rWR6qZjrtvdpvcGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68277499"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68277499"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:17:27 -0700
X-CSE-ConnectionGUID: zuPWe7FZTe+htSNyvV3dVw==
X-CSE-MsgGUID: cu2geDdiTKu24k7Sm9UdyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="196825702"
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
Subject: [PATCH v8 26/32] fs/resctrl: Move allocation/free of closid_num_dirty_rmid
Date: Mon, 11 Aug 2025 11:17:00 -0700
Message-ID: <20250811181709.6241-27-tony.luck@intel.com>
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

closid_num_dirty_rmid[] is allocated in dom_data_init() and freed by
dom_data_exit() giving it the same life cycle as rmid_ptrs[].

Move the alloc/free out to resctrl_mon_l3_resource_init() and
resctrl_mon_l3_resource_exit() in preparation for rmid_ptrs[] to be
allocated on resctrl mount in support of the new telemetry events.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 fs/resctrl/monitor.c | 56 ++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 40c66caf299d..0d9c8d4e0e9c 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -805,36 +805,14 @@ void mbm_setup_overflow_handler(struct rdt_l3_mon_domain *dom, unsigned long del
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
@@ -870,11 +848,6 @@ static void dom_data_exit(struct rdt_resource *r)
 	if (!r->mon_capable)
 		goto out_unlock;
 
-	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
-		kfree(closid_num_dirty_rmid);
-		closid_num_dirty_rmid = NULL;
-	}
-
 	kfree(rmid_ptrs);
 	rmid_ptrs = NULL;
 
@@ -957,9 +930,31 @@ int resctrl_mon_l3_resource_init(void)
 	if (!r->mon_capable)
 		return 0;
 
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+		u32 num_closid = resctrl_arch_get_num_closid(r);
+		u32 *tmp;
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
+	}
+
 	ret = dom_data_init(r);
-	if (ret)
+	if (ret) {
+		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+			kfree(closid_num_dirty_rmid);
+			closid_num_dirty_rmid = NULL;
+		}
 		return ret;
+	}
 
 	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_TOTAL_EVENT_ID)) {
 		mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].configurable = true;
@@ -984,5 +979,10 @@ void resctrl_mon_l3_resource_exit(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+		kfree(closid_num_dirty_rmid);
+		closid_num_dirty_rmid = NULL;
+	}
+
 	dom_data_exit(r);
 }
-- 
2.50.1


