Return-Path: <linux-kernel+bounces-833160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DDBBA1506
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0B0D7A5297
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1398E3294F7;
	Thu, 25 Sep 2025 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCOasC2a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8A332897A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830670; cv=none; b=nKh167G5eBQfv9nXOQHCR3J2/4JksMyuZzLq/B/bc4zv5jkC9YinU3iJ5rluT/d7b9JOA8ymJrhBjFH+nKhbSLztoFPUA62bAELbFuvfkRlrsUOpp7SPlqbb/x1ZKmSijST1DTinUNOMQ0cEAKJUV94/OkdA34ppqP5Wf1gJ7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830670; c=relaxed/simple;
	bh=KKZ76b6f1fVw3YfuVP6not30dWXnaMRHgFBHlr5XoWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XT4WQTcGTKcfZoEmyhs0l+8WEwYmVQ02b87Q1Tm5E5cvFWeaFhoaa3/oY36I7yAnhPmphJj9wFzYdbGjP97vU11lQDAjagJ5+Gjliv703n3iUcybLo5zdNXSrfWkQlFmuyF13FEVceql3JfHY7D9/ZR4pJAnlQv8tOjm+Uf60n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCOasC2a; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758830669; x=1790366669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KKZ76b6f1fVw3YfuVP6not30dWXnaMRHgFBHlr5XoWI=;
  b=ZCOasC2a8x53YLPd1wYO87N/DsPsdIJ898xc7Pg09cffcwxClemMSIIt
   moWuwFEYTlGKl2WaZHyR04Vi1dNWQFc9BPoT/n75jJXMfoaNCeCFwqFw9
   CrHwOUgJC+e5QFcZB5+zVI8dVrlpuIaZpHWaS9Vvs9hTCd1Tu8vvG58P3
   EIjO2h/VnNsjEZ1W707Y0rzy3dD3bej6/vOczPWx5LTh1vK76xQMKM15I
   w/YA8j8OyDPoJo2LMUhvyIrJD0uQLj8gtJpRpT8J/ilaDrNgPUjKSLYEg
   J3jaMgTlplyAKYHaUSnQjKBYHyRId2YXAAZt1OEbL1gLPk6MmLQretnpv
   Q==;
X-CSE-ConnectionGUID: GAKD21lvSEeehCrPCczG5g==
X-CSE-MsgGUID: Oniw8+rnTp+p6kw/JZcahg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61074412"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61074412"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 13:04:16 -0700
X-CSE-ConnectionGUID: K0RKm+OUSNqvhPHncTdHuA==
X-CSE-MsgGUID: 02TGTeRXQN2qyC4Yyn4/+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="177003714"
Received: from inaky-mobl1.amr.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.220.206])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 13:04:16 -0700
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
Subject: [PATCH v11 31/31] fs/resctrl: Some kerneldoc updates
Date: Thu, 25 Sep 2025 13:03:25 -0700
Message-ID: <20250925200328.64155-32-tony.luck@intel.com>
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

resctrl event monitoring on Sub-NUMA Cluster (SNC) systems sums the
counts for events across all nodes sharing an L3 cache.

Update the kerneldoc for rmid_read::sum and the do_sum argument to
mon_get_kn_priv() to say these are only used on the RDT_RESOURCE_L3
resource.

Add Return: value description for l3_mon_domain_mbm_alloc(),
resctrl_l3_mon_resource_init(), and domain_setup_l3_mon_state()

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 fs/resctrl/internal.h              | 4 ++--
 arch/x86/kernel/cpu/resctrl/core.c | 2 ++
 fs/resctrl/monitor.c               | 2 +-
 fs/resctrl/rdtgroup.c              | 5 +++--
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 223a6cc6a64a..0dd89d3fa31a 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -96,8 +96,8 @@ extern struct mon_evt mon_event_all[QOS_NUM_EVENTS];
  * @list:            Member of the global @mon_data_kn_priv_list list.
  * @rid:             Resource id associated with the event file.
  * @evt:             Event structure associated with the event file.
- * @sum:             Set when event must be summed across multiple
- *                   domains.
+ * @sum:             Set for RDT_RESOURCE_L3 when event must be summed
+ *                   across multiple domains.
  * @domid:           When @sum is zero this is the domain to which
  *                   the event file belongs. When @sum is one this
  *                   is the id of the L3 cache that all domains to be
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 48ed6242d136..78c176e15b93 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -418,6 +418,8 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_ctrl_domain *
  * l3_mon_domain_mbm_alloc() - Allocate arch private storage for the MBM counters
  * @num_rmid:	The size of the MBM counter array
  * @hw_dom:	The domain that owns the allocated arrays
+ *
+ * Return:	%0 for success; Error code otherwise.
  */
 static int l3_mon_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_l3_mon_domain *hw_dom)
 {
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index c0e1b672afce..4cc310b9e78e 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1811,7 +1811,7 @@ static void closid_num_dirty_rmid_free(void)
  * Resctrl's cpuhp callbacks may be called before this point to bring a domain
  * online.
  *
- * Returns 0 for success, or -ENOMEM.
+ * Return: %0 for success; Error code otherwise.
  */
 int resctrl_l3_mon_resource_init(void)
 {
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 16b088c5f2be..04765dad3d31 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3037,7 +3037,8 @@ static void rmdir_all_sub(void)
  * @rid:    The resource id for the event file being created.
  * @domid:  The domain id for the event file being created.
  * @mevt:   The type of event file being created.
- * @do_sum: Whether SNC summing monitors are being created.
+ * @do_sum: Whether SNC summing monitors are being created. Only set
+ *          when @rid == RDT_RESOURCE_L3.
  */
 static struct mon_data *mon_get_kn_priv(enum resctrl_res_level rid, int domid,
 					struct mon_evt *mevt,
@@ -4281,7 +4282,7 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain_hdr *h
  * at mount time. This means the rdt_l3_mon_domain::mbm_states[] and
  * rdt_l3_mon_domain::rmid_busy_llc allocations may be larger than needed.
  *
- * Returns 0 for success, or -ENOMEM.
+ * Return: %0 for success; Error code otherwise.
  */
 static int domain_setup_l3_mon_state(struct rdt_resource *r, struct rdt_l3_mon_domain *d)
 {
-- 
2.51.0


