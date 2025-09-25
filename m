Return-Path: <linux-kernel+bounces-833149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6872EBA14D7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15839381D40
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ED0324B1E;
	Thu, 25 Sep 2025 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwH2h31r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958573233EF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830661; cv=none; b=Zxajc/ojNlwY7ZZvJMFGuppreqS79RF8ni1CO/t2tnIHBH/V43dYhuioxRbHPubLZGl4xUdVEZrnRb2zgj5ddA3oqKwBzlV7hV8dgFEUp8w4rvuydb0GnvapFsc/51nlmIUW2DZyT44AOXZLYOS/1nfnkthTxNK5cg67JzCj3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830661; c=relaxed/simple;
	bh=xo1ybD9cfc9M4Kz+Mli/XGLt6Z6TLya4Q1mtqhvg5Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FK3weWCA1066f3M0aQEzKX7L2Pr/beFZCi0aU4Icdk46RVlgjKQ9Jr9hEUKH65YZLYNpdsjqbrP/seea8kAhzqfylm7Ml+af3ixABTIH2mdqzO5Sz27saEBKlrs4z06SNTLAAhpqD/vTm8fqmkMt8V6OAaZgjDT7pdTZhXWTfEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwH2h31r; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758830660; x=1790366660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xo1ybD9cfc9M4Kz+Mli/XGLt6Z6TLya4Q1mtqhvg5Ss=;
  b=bwH2h31rk0+eHQu5dCfNBgdv2I/tj2Xt7v2xlG26mU+PVzX8ADRYt+GI
   sGfL68J9CMhVPGxpk7cmgrb/2stV6IaT6igFmmGkbsisI+N+dsxM8fOCe
   fjVKd5Dhw8Jka2mVcSPOkTYyHN+FTb1G3AxDXujpQyjmbe9aiYMfWqWuX
   ieyBLf3XOi5FyNFf7fuPrvl5menGrh9oPv64naedA/ghH82q/JQAAjaRm
   NbaoWp/1SXGYSO+IlmB8Igb7dvI8utflT1p3OjJgD6ez2nVntgSWGfubo
   mg+MG6F9xZB7tva2RLx3MY/nosTWyuvhh6NphtmTBsfWWQRChf+gD2RpS
   w==;
X-CSE-ConnectionGUID: nr5pJCb3TeC6zIoMCbOHiw==
X-CSE-MsgGUID: j+7UdpMVRdqoi71D1ACCxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61074303"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61074303"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 13:04:12 -0700
X-CSE-ConnectionGUID: 0emR60+lTDyhXRLzgb6wXw==
X-CSE-MsgGUID: kgh+EWWrStOZFYXYw4EALQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="177003671"
Received: from inaky-mobl1.amr.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.220.206])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 13:04:12 -0700
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
Subject: [PATCH v11 20/31] fs/resctrl: Refactor Sub-NUMA Cluster (SNC) in mkdir/rmdir code flow
Date: Thu, 25 Sep 2025 13:03:14 -0700
Message-ID: <20250925200328.64155-21-tony.luck@intel.com>
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

SNC is only present in the RDT_RESOURCE_L3 domain.

Refactor code that makes and removes directories under "mon_data" to
special case the L3 resource.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 fs/resctrl/rdtgroup.c | 50 +++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 6e8937f94e7a..cab5cb9e6c93 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3155,6 +3155,7 @@ static void mon_rmdir_one_subdir(struct kernfs_node *pkn, char *name, char *subn
 		return;
 	kernfs_put(kn);
 
+	/* Subdirectories are only present on SNC enabled systems */
 	if (kn->dir.subdirs <= 1)
 		kernfs_remove(kn);
 	else
@@ -3171,19 +3172,24 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 					   struct rdt_domain_hdr *hdr)
 {
 	struct rdtgroup *prgrp, *crgrp;
-	struct rdt_l3_mon_domain *d;
+	int domid = hdr->id;
 	char subname[32];
-	bool snc_mode;
 	char name[32];
 
-	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
-		return;
+	if (r->rid == RDT_RESOURCE_L3) {
+		struct rdt_l3_mon_domain *d;
 
-	d = container_of(hdr, struct rdt_l3_mon_domain, hdr);
-	snc_mode = r->mon_scope == RESCTRL_L3_NODE;
-	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci_id : d->hdr.id);
-	if (snc_mode)
-		sprintf(subname, "mon_sub_%s_%02d", r->name, d->hdr.id);
+		if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
+			return;
+
+		d = container_of(hdr, struct rdt_l3_mon_domain, hdr);
+		/* SNC mode? */
+		if (r->mon_scope == RESCTRL_L3_NODE) {
+			domid = d->ci_id;
+			sprintf(subname, "mon_sub_%s_%02d", r->name, hdr->id);
+		}
+	}
+	sprintf(name, "mon_%s_%02d", r->name, domid);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		mon_rmdir_one_subdir(prgrp->mon.mon_data_kn, name, subname);
@@ -3213,7 +3219,7 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_domain_hdr *hdr,
 		if (ret)
 			return ret;
 
-		if (!do_sum && resctrl_is_mbm_event(mevt->evtid))
+		if (r->rid == RDT_RESOURCE_L3 && !do_sum && resctrl_is_mbm_event(mevt->evtid))
 			mon_event_read(&rr, r, hdr, prgrp, &hdr->cpu_mask, mevt, true);
 	}
 
@@ -3225,19 +3231,27 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 				struct rdt_resource *r, struct rdtgroup *prgrp)
 {
 	struct kernfs_node *kn, *ckn;
-	struct rdt_l3_mon_domain *d;
+	bool snc_mode = false;
+	int domid = hdr->id;
 	char name[32];
-	bool snc_mode;
 	int ret = 0;
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
-		return -EINVAL;
+	if (r->rid == RDT_RESOURCE_L3) {
+		snc_mode = r->mon_scope == RESCTRL_L3_NODE;
+		if (snc_mode) {
+			struct rdt_l3_mon_domain *d;
+
+			if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
+				return -EINVAL;
+
+			d = container_of(hdr, struct rdt_l3_mon_domain, hdr);
+			domid = d->ci_id;
+		}
+	}
+	sprintf(name, "mon_%s_%02d", r->name, domid);
 
-	d = container_of(hdr, struct rdt_l3_mon_domain, hdr);
-	snc_mode = r->mon_scope == RESCTRL_L3_NODE;
-	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci_id : d->hdr.id);
 	kn = kernfs_find_and_get(parent_kn, name);
 	if (kn) {
 		/*
@@ -3253,7 +3267,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 		ret = rdtgroup_kn_set_ugid(kn);
 		if (ret)
 			goto out_destroy;
-		ret = mon_add_all_files(kn, hdr, r, prgrp, hdr->id, snc_mode);
+		ret = mon_add_all_files(kn, hdr, r, prgrp, domid, snc_mode);
 		if (ret)
 			goto out_destroy;
 	}
-- 
2.51.0


