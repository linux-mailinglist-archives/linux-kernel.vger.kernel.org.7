Return-Path: <linux-kernel+bounces-876711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74842C1C3FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 894535A3D30
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9728C3559E4;
	Wed, 29 Oct 2025 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VO3S/Kx9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39CD355026
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754904; cv=none; b=QIHEhMCrvh2ezLR7djCTNqrovjEmK/gAmYsdSJ7VE0krojIsDR3Wu1B1mrklbPzuZfOA1qdXHIhLZ9UbBVRvDZS7h8Cx2xygamXM2c9fd6uCgTuyirfVCg8r9xn3SlWmchvLHKYcg4LNIDB+G3RDw2/9PgUqd1tD5fSDTcKz5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754904; c=relaxed/simple;
	bh=UcATRO+KaWKYG+P9B4suPyIWNDBkWNvb2zpOAvyverw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSNXL5ev91Kufvj744AbbJ9lv7wHSOCAj/Lw1W/Xaw0PDDr5lpCeFrre1dFsmdZfcrdCdLKHQTcMoMT2MmkCSs6KEh3/yWwI5ebukcNfrUBGUtQ3nJ7nMVHAxWEjSMNYF4wACYM0fhAL7UzaksW5SA924joTODsXDrW5thVBkI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VO3S/Kx9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761754902; x=1793290902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UcATRO+KaWKYG+P9B4suPyIWNDBkWNvb2zpOAvyverw=;
  b=VO3S/Kx90xRUG64Ppfe7g4hY5GW+DDOyEkt0HhIT8UR8gMsAnrwGIAz8
   i21oTe7cK4KHqu57hssyyDFQq11x6dZoU05as9BJs9mdrqBkWp7TuFvSO
   UI9poe6pkkpbERTND2EusRCkxCSjFOwPCEohNC8fsh7LEPHGBSxlWqagX
   +InUGlLDH2iko5LaqqH1BiwacDmaIfKzCvl3JxGphQfwMPU0+X8DT1Lq/
   bEkjYCy2sLGHdAjw8o9wg0qh0mlTHc+k03Qe5t5pmDohW5E5Ql0BmJjUa
   KB6rdUDGfpincZVMg1Un9a0+AwI7Q0y6QD2sF7sSKrVOfCdCSfQ3Z4NZx
   A==;
X-CSE-ConnectionGUID: 33FWX+lwRT2w8scXBENDpA==
X-CSE-MsgGUID: 0N0bcOllR+GFEcQN9wadaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75331030"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="75331030"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:32 -0700
X-CSE-ConnectionGUID: LP1P5fk4TF+bDvcofNRhSQ==
X-CSE-MsgGUID: 7SN3r5gRTXCN7uzfZQEvAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="184901382"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.223.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:32 -0700
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
Subject: [PATCH v13 21/32] fs/resctrl: Refactor mkdir_mondata_subdir()
Date: Wed, 29 Oct 2025 09:21:04 -0700
Message-ID: <20251029162118.40604-22-tony.luck@intel.com>
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

Population of a monitor group's mon_data directory is unreasonably complicated
because of the support for Sub-NUMA Cluster (SNC) mode.

Split out the SNC code into a helper function to make it easier to add support
for a new telemetry resource.

Move all the duplicated code to make and set owner of domain directories
into the mon_add_all_files() helper and rename to _mkdir_mondata_subdir().

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 fs/resctrl/rdtgroup.c | 108 +++++++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 50 deletions(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index fa1398787e83..bcb76dc818c0 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3194,57 +3194,65 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 	}
 }
 
-static int mon_add_all_files(struct kernfs_node *kn, struct rdt_domain_hdr *hdr,
-			     struct rdt_resource *r, struct rdtgroup *prgrp,
-			     bool do_sum)
+/*
+ * Create a directory for a domain and populate it with monitor files. Create
+ * summing monitors when @hdr is NULL. No need to initialize summing monitors.
+ */
+static struct kernfs_node *_mkdir_mondata_subdir(struct kernfs_node *parent_kn, char *name,
+						 struct rdt_domain_hdr *hdr,
+						 struct rdt_resource *r,
+						 struct rdtgroup *prgrp, int domid)
 {
-	struct rdt_l3_mon_domain *d;
 	struct rmid_read rr = {0};
+	struct kernfs_node *kn;
 	struct mon_data *priv;
 	struct mon_evt *mevt;
-	int ret, domid;
+	int ret;
 
-	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
-		return -EINVAL;
+	kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
+	if (IS_ERR(kn))
+		return kn;
+
+	ret = rdtgroup_kn_set_ugid(kn);
+	if (ret)
+		goto out_destroy;
 
-	d = container_of(hdr, struct rdt_l3_mon_domain, hdr);
 	for_each_mon_event(mevt) {
 		if (mevt->rid != r->rid || !mevt->enabled)
 			continue;
-		domid = do_sum ? d->ci_id : d->hdr.id;
-		priv = mon_get_kn_priv(r->rid, domid, mevt, do_sum);
-		if (WARN_ON_ONCE(!priv))
-			return -EINVAL;
+		priv = mon_get_kn_priv(r->rid, domid, mevt, !hdr);
+		if (WARN_ON_ONCE(!priv)) {
+			ret = -EINVAL;
+			goto out_destroy;
+		}
 
 		ret = mon_addfile(kn, mevt->name, priv);
 		if (ret)
-			return ret;
+			goto out_destroy;
 
-		if (!do_sum && resctrl_is_mbm_event(mevt->evtid))
+		if (hdr && resctrl_is_mbm_event(mevt->evtid))
 			mon_event_read(&rr, r, hdr, prgrp, &hdr->cpu_mask, mevt, true);
 	}
 
-	return 0;
+	return kn;
+out_destroy:
+	kernfs_remove(kn);
+	return ERR_PTR(ret);
 }
 
-static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
-				struct rdt_domain_hdr *hdr,
-				struct rdt_resource *r, struct rdtgroup *prgrp)
+static int mkdir_mondata_subdir_snc(struct kernfs_node *parent_kn,
+				    struct rdt_domain_hdr *hdr,
+				    struct rdt_resource *r, struct rdtgroup *prgrp)
 {
-	struct kernfs_node *kn, *ckn;
+	struct kernfs_node *ckn, *kn;
 	struct rdt_l3_mon_domain *d;
 	char name[32];
-	bool snc_mode;
-	int ret = 0;
-
-	lockdep_assert_held(&rdtgroup_mutex);
 
 	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 		return -EINVAL;
 
 	d = container_of(hdr, struct rdt_l3_mon_domain, hdr);
-	snc_mode = r->mon_scope == RESCTRL_L3_NODE;
-	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci_id : d->hdr.id);
+	sprintf(name, "mon_%s_%02d", r->name, d->ci_id);
 	kn = kernfs_find_and_get(parent_kn, name);
 	if (kn) {
 		/*
@@ -3253,41 +3261,41 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 		 */
 		kernfs_put(kn);
 	} else {
-		kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
+		kn = _mkdir_mondata_subdir(parent_kn, name, NULL, r, prgrp, d->ci_id);
 		if (IS_ERR(kn))
 			return PTR_ERR(kn);
+	}
 
-		ret = rdtgroup_kn_set_ugid(kn);
-		if (ret)
-			goto out_destroy;
-		ret = mon_add_all_files(kn, hdr, r, prgrp, snc_mode);
-		if (ret)
-			goto out_destroy;
+	sprintf(name, "mon_sub_%s_%02d", r->name, hdr->id);
+	ckn = _mkdir_mondata_subdir(kn, name, hdr, r, prgrp, hdr->id);
+	if (IS_ERR(ckn)) {
+		kernfs_remove(kn);
+		return PTR_ERR(ckn);
 	}
 
-	if (snc_mode) {
-		sprintf(name, "mon_sub_%s_%02d", r->name, hdr->id);
-		ckn = kernfs_create_dir(kn, name, parent_kn->mode, prgrp);
-		if (IS_ERR(ckn)) {
-			ret = -EINVAL;
-			goto out_destroy;
-		}
+	kernfs_activate(kn);
+	return 0;
+}
 
-		ret = rdtgroup_kn_set_ugid(ckn);
-		if (ret)
-			goto out_destroy;
+static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
+				struct rdt_domain_hdr *hdr,
+				struct rdt_resource *r, struct rdtgroup *prgrp)
+{
+	struct kernfs_node *kn;
+	char name[32];
 
-		ret = mon_add_all_files(ckn, hdr, r, prgrp, false);
-		if (ret)
-			goto out_destroy;
-	}
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (r->rid == RDT_RESOURCE_L3 && r->mon_scope == RESCTRL_L3_NODE)
+		return mkdir_mondata_subdir_snc(parent_kn, hdr, r, prgrp);
+
+	sprintf(name, "mon_%s_%02d", r->name, hdr->id);
+	kn = _mkdir_mondata_subdir(parent_kn, name, hdr, r, prgrp, hdr->id);
+	if (IS_ERR(kn))
+		return PTR_ERR(kn);
 
 	kernfs_activate(kn);
 	return 0;
-
-out_destroy:
-	kernfs_remove(kn);
-	return ret;
 }
 
 /*
-- 
2.51.0


