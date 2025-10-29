Return-Path: <linux-kernel+bounces-876712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA61C1C12F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A731A23E83
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2943563C1;
	Wed, 29 Oct 2025 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bDlCokQP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922CE35503B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754904; cv=none; b=LxRbi0suTCZejgywZ+e+F8A0aBv5hB+p7sfHBWE1vqBn0Nh6Dze5nUa/txFsq+4QzF+sr9COMtUrMXluHlfBO5/B7lasv6fD2OrcN5R927kmJ02RIs+LV9q1RmIuxEf5CM5aKjnvEqGDDqj8FzNFtvc5iH5PR+18sG4L+I2pzoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754904; c=relaxed/simple;
	bh=S04DLKChqtxVIfbayGN7vRQzulAjFbTzMk1BBDVs9H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixFwl5Ou7Yx+TWbdTC8Dc7nH1Yq4z6rd9UzJ9EutyNBEGDTA1DriON2EsADY+IwDiPQosIEKDWbmmMUa4vh6bARoRpk86KBFexVXrwmmrn9KUw9C+aeOsbCic3HGY1EtAiMPB6Xxt6IIMcEc6dOfTXP4lbg9VLaNdnH0QSxtJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bDlCokQP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761754902; x=1793290902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S04DLKChqtxVIfbayGN7vRQzulAjFbTzMk1BBDVs9H4=;
  b=bDlCokQPLPJ6I3NNokI04EZL0wVpZ9prAekFo/QeBGHlzx1Y+llMlWbf
   pqKg8LcBCGuLaQ0hPTpvhsD8ZqPvarm4iu2+9PUEEzBxlBsEiaRnHtl8X
   AXX0C4cuPHQ1vSOUXg/wU4KKNg8/WMfo2rDWjl4gTmZqzlXFqmTwC0Uiw
   jicFUYnGD2lLBFuDsJ94pZ/qA5b+pCVFu0tRhZX6XN/4jeXudp7lET3Zn
   YrGYupDRxuYkMqdg8oE8OkvCvpfMeLY0+31Zg7tWFfir2cb0dOtJadtXU
   D8oUGsUKknep5X9/N1NNn1kFpNqBKq9/nT8QH25fPIS4Q6Q5jp/TNbIxD
   Q==;
X-CSE-ConnectionGUID: rC6/U5viTWmub7xWbVD6Bg==
X-CSE-MsgGUID: +bn1hhzLTE638Jh/c2oUOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75331031"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="75331031"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:33 -0700
X-CSE-ConnectionGUID: NUgfyV/+RRunMeXsmFfWmA==
X-CSE-MsgGUID: /T5OW1BBRliYjUuJw9JTQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="184901385"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.223.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:33 -0700
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
Subject: [PATCH v13 22/32] fs/resctrl: Refactor rmdir_mondata_subdir_allrdtgrp()
Date: Wed, 29 Oct 2025 09:21:05 -0700
Message-ID: <20251029162118.40604-23-tony.luck@intel.com>
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

Clearing a monitor group's mon_data directory is complicated because of the
support for Sub-NUMA Cluster (SNC) mode.

Refactor the SNC case into a helper function to make it easier to add support
for a new telemetry resource.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 fs/resctrl/rdtgroup.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index bcb76dc818c0..4f461ec773d6 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3163,28 +3163,24 @@ static void mon_rmdir_one_subdir(struct kernfs_node *pkn, char *name, char *subn
 }
 
 /*
- * Remove all subdirectories of mon_data of ctrl_mon groups
- * and monitor groups for the given domain.
- * Remove files and directories containing "sum" of domain data
- * when last domain being summed is removed.
+ * Remove files and directories for one SNC node. If it is the last node
+ * sharing an L3 cache, then remove the upper level directory containing
+ * the "sum" files too.
  */
-static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-					   struct rdt_domain_hdr *hdr)
+static void rmdir_mondata_subdir_allrdtgrp_snc(struct rdt_resource *r,
+					       struct rdt_domain_hdr *hdr)
 {
 	struct rdtgroup *prgrp, *crgrp;
 	struct rdt_l3_mon_domain *d;
 	char subname[32];
-	bool snc_mode;
 	char name[32];
 
 	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 		return;
 
 	d = container_of(hdr, struct rdt_l3_mon_domain, hdr);
-	snc_mode = r->mon_scope == RESCTRL_L3_NODE;
-	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci_id : d->hdr.id);
-	if (snc_mode)
-		sprintf(subname, "mon_sub_%s_%02d", r->name, d->hdr.id);
+	sprintf(name, "mon_%s_%02d", r->name, d->ci_id);
+	sprintf(subname, "mon_sub_%s_%02d", r->name, hdr->id);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		mon_rmdir_one_subdir(prgrp->mon.mon_data_kn, name, subname);
@@ -3194,6 +3190,30 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 	}
 }
 
+/*
+ * Remove all subdirectories of mon_data of ctrl_mon groups
+ * and monitor groups for the given domain.
+ */
+static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
+					   struct rdt_domain_hdr *hdr)
+{
+	struct rdtgroup *prgrp, *crgrp;
+	char name[32];
+
+	if (r->rid == RDT_RESOURCE_L3 && r->mon_scope == RESCTRL_L3_NODE) {
+		rmdir_mondata_subdir_allrdtgrp_snc(r, hdr);
+		return;
+	}
+
+	sprintf(name, "mon_%s_%02d", r->name, hdr->id);
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		kernfs_remove_by_name(prgrp->mon.mon_data_kn, name);
+
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
+			kernfs_remove_by_name(crgrp->mon.mon_data_kn, name);
+	}
+}
+
 /*
  * Create a directory for a domain and populate it with monitor files. Create
  * summing monitors when @hdr is NULL. No need to initialize summing monitors.
-- 
2.51.0


