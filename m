Return-Path: <linux-kernel+bounces-592765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 122F3A7F125
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 01:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A860F7A600E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 23:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF75722DFB2;
	Mon,  7 Apr 2025 23:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diOjcwz6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11FA22ACC6
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069255; cv=none; b=sR0KTKCm80EcB7J+KMP1jdCUDX8gCACObKNbbZQtiEV6kasxlPhxJXDbPMvq7X8bpa5yHNI+urSbOmOM2n8uWmzUV+oUtqRl03Uhr1K0EOVcjuGOLvuWk3AqlszGqR/NIueZnCBthoXUlub/QYMvL0TTht7tvlVtbBtz9USeEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069255; c=relaxed/simple;
	bh=8bSyQDBrTZBN7cp28ibrq0ETKIdFfTZjXF1wTd0d0Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7CiY5VmakzM9lyfpYY5+ohTLJjyliaH/LRJ9fO5Ti8i3Ug/EXp0Vt07vgA/5NU/VxW7VIg3Fp1e+GcOr7dN1ghg0a0CV9FIh/3DICLf3xEcyJ2RsM0JoBEc8xmX7VinmUKNznIb6aFYYYY9uPfNmozAkqBbNN5XYuKQ+ACQ00w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diOjcwz6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744069253; x=1775605253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8bSyQDBrTZBN7cp28ibrq0ETKIdFfTZjXF1wTd0d0Qg=;
  b=diOjcwz6FaaM2dboS7a2bTKUVWhRtmkSd1gCif23l1ObXTGoyyovVDF+
   +q0OZGzT9BJSIYu69YG+nKJ94VZRcToYkojO8jKfOW785vl4pjzTO7Qnb
   HRM6MD9yO1RBHkeTu/DwzRib4q9VVpkKVRKIKeE9eAt3TmbGyYLS/lmXW
   GZsP5ondXkmm9LY6vEnFJtduy+8y6EtqarlThL6UJCkVENt1idLV0Yty4
   4fOQKJIYcekLP/lqt8BevdkSldih5F+aYv7vpbF/4bijt+7k2BX3olzrq
   7kX8O8BAfpRBF/T0azaRix3twynBHqOD5ihyM+fVPQAm3pNBaQUNbsr4N
   w==;
X-CSE-ConnectionGUID: bz5YQc7lTfWhK5nloTuoGg==
X-CSE-MsgGUID: 71bDPaVzSaqerhFO2Zr57A==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="48193187"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="48193187"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 16:40:49 -0700
X-CSE-ConnectionGUID: B8QZ5sIKQmKaPwtbpfRQIQ==
X-CSE-MsgGUID: xJG7wdgvQO2gR/NL0VS+mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="165315476"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 16:40:49 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 10/26] fs/resctrl: Improve handling for events that can be read from any CPU
Date: Mon,  7 Apr 2025 16:40:12 -0700
Message-ID: <20250407234032.241215-11-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407234032.241215-1-tony.luck@intel.com>
References: <20250407234032.241215-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a flag to each instance of struct mon_event to indicate that there
is no need for cross-processor interrupts to read this event from a CPU
in a specific rdt_mon_domain.

The flag is copied to struct mon_data for ease of access when a user
reads an event file invoking rdtgroup_mondata_show().

Copied again into struct rmid_read in mon_event_read() for use by
sanity checks in  __mon_event_count().

When the flag is set allow choice from cpu_online_mask. This makes the
smp_call*() functions default to the current CPU.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 fs/resctrl/internal.h    |  8 +++++++-
 fs/resctrl/ctrlmondata.c | 10 +++++++---
 fs/resctrl/monitor.c     |  4 ++--
 fs/resctrl/rdtgroup.c    |  1 +
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 08dbf89939ac..74a77794364d 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -72,6 +72,7 @@ static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
  * @evtid:		event id
  * @name:		name of the event
  * @configurable:	true if the event is configurable
+ * @any_cpu:		true if this event can be read from any CPU
  * @list:		entry in &rdt_resource->evt_list
  */
 struct mon_evt {
@@ -79,6 +80,7 @@ struct mon_evt {
 	enum resctrl_res_level	rid;
 	char			*name;
 	bool			configurable;
+	bool			any_cpu;
 	struct list_head	list;
 };
 
@@ -93,6 +95,7 @@ struct mon_evt {
  *                   the event file belongs. When @sum is one this
  *                   is the id of the L3 cache that all domains to be
  *                   summed share.
+ * @any_cpu:         true if this event can be read from any CPU
  *
  * Stored in the kernfs kn->priv field, readers and writers must hold
  * rdtgroup_mutex.
@@ -103,6 +106,7 @@ struct mon_data {
 	enum resctrl_event_id evtid;
 	unsigned int sum;
 	unsigned int domid;
+	bool any_cpu;
 };
 
 /**
@@ -115,6 +119,7 @@ struct mon_data {
  *	   domains in @r sharing L3 @ci.id
  * @evtid: Which monitor event to read.
  * @first: Initialize MBM counter when true.
+ * @any_cpu: When true read can be executed on any CPU.
  * @ci:    Cacheinfo for L3. Only set when @d is NULL. Used when summing domains.
  * @err:   Error encountered when reading counter.
  * @val:   Returned value of event counter. If @rgrp is a parent resource group,
@@ -129,6 +134,7 @@ struct rmid_read {
 	struct rdt_mon_domain	*d;
 	enum resctrl_event_id	evtid;
 	bool			first;
+	bool			any_cpu;
 	struct cacheinfo	*ci;
 	int			err;
 	u64			val;
@@ -358,7 +364,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
-		    cpumask_t *cpumask, int evtid, int first);
+		    const cpumask_t *cpumask, int evtid, int first);
 
 int resctrl_mon_resource_init(void);
 
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 0c245af0ff42..cd77960657f0 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -525,7 +525,7 @@ struct rdt_domain_hdr *resctrl_find_domain(struct list_head *h, int id,
 
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
-		    cpumask_t *cpumask, int evtid, int first)
+		    const cpumask_t *cpumask, int evtid, int first)
 {
 	int cpu;
 
@@ -571,6 +571,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	u32 resid, evtid, domid;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
+	const cpumask_t *mask;
 	struct mon_data *md;
 	int ret = 0;
 
@@ -589,6 +590,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	resid = md->rid;
 	domid = md->domid;
 	evtid = md->evtid;
+	rr.any_cpu = md->any_cpu;
 	r = resctrl_arch_get_resource(resid);
 
 	if (md->sum) {
@@ -601,8 +603,9 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		list_for_each_entry(d, &r->mon_domains, hdr.list) {
 			if (d->ci->id == domid) {
 				rr.ci = d->ci;
+				mask = md->any_cpu ? cpu_online_mask : &d->ci->shared_cpu_map;
 				mon_event_read(&rr, r, NULL, rdtgrp,
-					       &d->ci->shared_cpu_map, evtid, false);
+					       mask, evtid, false);
 				goto checkresult;
 			}
 		}
@@ -619,7 +622,8 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 			goto out;
 		}
 		d = container_of(hdr, struct rdt_mon_domain, hdr);
-		mon_event_read(&rr, r, d, rdtgrp, &d->hdr.cpu_mask, evtid, false);
+		mask = md->any_cpu ? cpu_online_mask : &d->hdr.cpu_mask;
+		mon_event_read(&rr, r, d, rdtgrp, mask, evtid, false);
 	}
 
 checkresult:
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 472754d082cb..1cf0b085e07a 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -375,7 +375,7 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 
 	if (rr->d) {
 		/* Reading a single domain, must be on a CPU in that domain. */
-		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
+		if (!rr->any_cpu && !cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
 			return -EINVAL;
 		rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
 						 rr->evtid, &tval, rr->arch_mon_ctx);
@@ -388,7 +388,7 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 	}
 
 	/* Summing domains that share a cache, must be on a CPU for that cache. */
-	if (!cpumask_test_cpu(cpu, &rr->ci->shared_cpu_map))
+	if (!rr->any_cpu && !cpumask_test_cpu(cpu, &rr->ci->shared_cpu_map))
 		return -EINVAL;
 
 	/*
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 5011e404798a..97c2ba8af930 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2926,6 +2926,7 @@ static struct mon_data *mon_get_kn_priv(int rid, int domid, struct mon_evt *mevt
 	priv->domid = domid;
 	priv->sum = do_sum;
 	priv->evtid = mevt->evtid;
+	priv->any_cpu = mevt->any_cpu;
 	list_add_tail(&priv->list, &kn_priv_list);
 
 	return priv;
-- 
2.48.1


