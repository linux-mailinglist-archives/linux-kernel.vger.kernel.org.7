Return-Path: <linux-kernel+bounces-876697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF03BC1C0F9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55B218925BB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D65234DCFE;
	Wed, 29 Oct 2025 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KfP6evUx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA3F34405D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754891; cv=none; b=DBirSyRvhofTn0A8UnUlnQUngTtLQXvWlvAdHBp7Flt/Pcyx6FZMEfj5EQ87saAZEKi9XUF3vflKeEfBbWeL5oTeQmv99tI82nIIKjKaLFCn9PUJLYUAj0jcnDHtQCKtvzhGfYjqCzxeTEU3hGoc0Fwky9gd8ZLY/UEDU6QH8KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754891; c=relaxed/simple;
	bh=tDEtEYNpg2Pinhhrh8+qQi8181DrUvWIWzbK5RYCZx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0q9fgTAK43ZHsqvHfhB4MH0uPU70+S3veetFa4OF/mz6geFL0criNy/7+LjAstrueusSl17v8snUemfYXY/xpreLcvU4NCtwIpIPN3jcCWaL6HR05jkbJlcdDZdd3ei1JR4ZVfq/9vIshqJtA0pOUmbJthH4nfb2VE3AzFVQhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KfP6evUx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761754889; x=1793290889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tDEtEYNpg2Pinhhrh8+qQi8181DrUvWIWzbK5RYCZx4=;
  b=KfP6evUx+z8yzKzSCQ9NCUbM7p76bAGR9z+/CWJQoEgtNhm9IYUfDffI
   GloK/CovZiw/2OU6dTcKzZm0cc9+9E6m9EBjjY2/dUZT0X+wx+f4FIRM5
   UulSrpnmpTpYog778hptQ2iGd/i+QIugkEg4iVmwT/ZrD6Hzsb7ptzduO
   /PqIE7gehTPPmct6SUM5Du+yzyksV7NZ8LaLmeo9DQRiJqAU1E5alGusD
   XXTSmQxCErOyToID0qYdIh9/d8vsS0CwraPMiKU09bx8yzmzL1smIK4ss
   5euAqp5Qk4UC57bWRqYsREYgLkFMuNsQ+9vlnafGV8KjzGWnRZSkbY9ZY
   g==;
X-CSE-ConnectionGUID: 5e+SQ57yRIeujOflQ1KrVw==
X-CSE-MsgGUID: wYSF7wwKSQCZLf2z9vmSbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75331002"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="75331002"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:27 -0700
X-CSE-ConnectionGUID: SL8f90/STMCRlRGIhimiTA==
X-CSE-MsgGUID: u8Jk+DvfRVed3P/4qOzgXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="184901319"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.223.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:27 -0700
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
Subject: [PATCH v13 07/32] x86,fs/resctrl: Use struct rdt_domain_hdr when reading counters
Date: Wed, 29 Oct 2025 09:20:50 -0700
Message-ID: <20251029162118.40604-8-tony.luck@intel.com>
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

Convert the whole call sequence from mon_event_read() to resctrl_arch_rmid_read()
to pass resource independent struct rdt_domain_hdr instead of an L3 specific
domain structure to prepare for monitoring events in other resources.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h               |  4 +--
 fs/resctrl/internal.h                 | 18 ++++++-----
 arch/x86/kernel/cpu/resctrl/monitor.c | 12 +++++--
 fs/resctrl/ctrlmondata.c              |  9 +-----
 fs/resctrl/monitor.c                  | 46 +++++++++++++++++----------
 5 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 0b55809af5d7..1a33d5e6ae23 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -514,7 +514,7 @@ void resctrl_offline_cpu(unsigned int cpu);
  * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
  *			      for this resource and domain.
  * @r:			resource that the counter should be read from.
- * @d:			domain that the counter should be read from.
+ * @hdr:		Header of domain that the counter should be read from.
  * @closid:		closid that matches the rmid. Depending on the architecture, the
  *			counter may match traffic of both @closid and @rmid, or @rmid
  *			only.
@@ -535,7 +535,7 @@ void resctrl_offline_cpu(unsigned int cpu);
  * Return:
  * 0 on success, or -EIO, -EINVAL etc on error.
  */
-int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hdr,
 			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
 			   u64 *val, void *arch_mon_ctx);
 
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 22fdb3a9b6f4..698ed84fd073 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -106,24 +106,26 @@ struct mon_data {
  *	   resource group then its event count is summed with the count from all
  *	   its child resource groups.
  * @r:	   Resource describing the properties of the event being read.
- * @d:	   Domain that the counter should be read from. If NULL then sum all
- *	   domains in @r sharing L3 @ci.id
+ * @hdr:   Header of domain that the counter should be read from. If NULL then
+ *	   sum all domains in @r sharing L3 @ci.id
  * @evtid: Which monitor event to read.
  * @first: Initialize MBM counter when true.
- * @ci:    Cacheinfo for L3. Only set when @d is NULL. Used when summing domains.
+ * @ci:    Cacheinfo for L3. Only set when @hdr is NULL. Used when summing
+ *	   domains.
  * @is_mbm_cntr: true if "mbm_event" counter assignment mode is enabled and it
  *	   is an MBM event.
  * @err:   Error encountered when reading counter.
- * @val:   Returned value of event counter. If @rgrp is a parent resource group,
- *	   @val includes the sum of event counts from its child resource groups.
- *	   If @d is NULL, @val includes the sum of all domains in @r sharing @ci.id,
- *	   (summed across child resource groups if @rgrp is a parent resource group).
+ * @val:   Returned value of event counter. If @rgrp is a parent resource
+ *	   group, @val includes the sum of event counts from its child
+ *	   resource groups.  If @hdr is NULL, @val includes the sum of all
+ *	   domains in @r sharing @ci.id, (summed across child resource groups
+ *	   if @rgrp is a parent resource group).
  * @arch_mon_ctx: Hardware monitor allocated for this read request (MPAM only).
  */
 struct rmid_read {
 	struct rdtgroup		*rgrp;
 	struct rdt_resource	*r;
-	struct rdt_mon_domain	*d;
+	struct rdt_domain_hdr	*hdr;
 	enum resctrl_event_id	evtid;
 	bool			first;
 	struct cacheinfo	*ci;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index fe1a2aa53c16..982dcf23183c 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -238,19 +238,25 @@ static u64 get_corrected_val(struct rdt_resource *r, struct rdt_mon_domain *d,
 	return chunks * hw_res->mon_scale;
 }
 
-int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hdr,
 			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
 			   u64 *val, void *ignored)
 {
-	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
-	int cpu = cpumask_any(&d->hdr.cpu_mask);
+	struct rdt_hw_mon_domain *hw_dom;
 	struct arch_mbm_state *am;
+	struct rdt_mon_domain *d;
 	u64 msr_val;
 	u32 prmid;
+	int cpu;
 	int ret;
 
 	resctrl_arch_rmid_read_context_check();
+	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
+		return -EINVAL;
 
+	d = container_of(hdr, struct rdt_mon_domain, hdr);
+	hw_dom = resctrl_to_arch_mon_dom(d);
+	cpu = cpumask_any(&hdr->cpu_mask);
 	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
 	ret = __rmid_read_phys(prmid, eventid, &msr_val);
 
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index a2ea6a66fa67..ad347ab4ed29 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -550,25 +550,18 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_domain_hdr *hdr, struct rdtgroup *rdtgrp,
 		    cpumask_t *cpumask, int evtid, int first)
 {
-	struct rdt_mon_domain *d = NULL;
 	int cpu;
 
 	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
 
-	if (hdr) {
-		if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
-			return;
-		d = container_of(hdr, struct rdt_mon_domain, hdr);
-	}
-
 	/*
 	 * Setup the parameters to pass to mon_event_count() to read the data.
 	 */
 	rr->rgrp = rdtgrp;
 	rr->evtid = evtid;
 	rr->r = r;
-	rr->d = d;
+	rr->hdr = hdr;
 	rr->first = first;
 	if (resctrl_arch_mbm_cntr_assign_enabled(r) &&
 	    resctrl_is_mbm_event(evtid)) {
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 179962a81362..911a10aa6920 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -159,7 +159,7 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free)
 			break;
 
 		entry = __rmid_entry(idx);
-		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
+		if (resctrl_arch_rmid_read(r, &d->hdr, entry->closid, entry->rmid,
 					   QOS_L3_OCCUP_EVENT_ID, &val,
 					   arch_mon_ctx)) {
 			rmid_dirty = true;
@@ -413,19 +413,19 @@ static void mbm_cntr_free(struct rdt_mon_domain *d, int cntr_id)
 	memset(&d->cntr_cfg[cntr_id], 0, sizeof(*d->cntr_cfg));
 }
 
-static int __l3_mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
+static int __l3_mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr,
+				struct rdt_mon_domain *d)
 {
 	int cpu = smp_processor_id();
 	u32 closid = rdtgrp->closid;
 	u32 rmid = rdtgrp->mon.rmid;
-	struct rdt_mon_domain *d;
 	int cntr_id = -ENOENT;
 	struct mbm_state *m;
 	int err, ret;
 	u64 tval = 0;
 
 	if (rr->is_mbm_cntr) {
-		cntr_id = mbm_cntr_get(rr->r, rr->d, rdtgrp, rr->evtid);
+		cntr_id = mbm_cntr_get(rr->r, d, rdtgrp, rr->evtid);
 		if (cntr_id < 0) {
 			rr->err = -ENOENT;
 			return -EINVAL;
@@ -434,24 +434,24 @@ static int __l3_mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 
 	if (rr->first) {
 		if (rr->is_mbm_cntr)
-			resctrl_arch_reset_cntr(rr->r, rr->d, closid, rmid, cntr_id, rr->evtid);
+			resctrl_arch_reset_cntr(rr->r, d, closid, rmid, cntr_id, rr->evtid);
 		else
-			resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
-		m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
+			resctrl_arch_reset_rmid(rr->r, d, closid, rmid, rr->evtid);
+		m = get_mbm_state(d, closid, rmid, rr->evtid);
 		if (m)
 			memset(m, 0, sizeof(struct mbm_state));
 		return 0;
 	}
 
-	if (rr->d) {
+	if (d) {
 		/* Reading a single domain, must be on a CPU in that domain. */
-		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
+		if (!cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
 			return -EINVAL;
 		if (rr->is_mbm_cntr)
-			rr->err = resctrl_arch_cntr_read(rr->r, rr->d, closid, rmid, cntr_id,
+			rr->err = resctrl_arch_cntr_read(rr->r, d, closid, rmid, cntr_id,
 							 rr->evtid, &tval);
 		else
-			rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
+			rr->err = resctrl_arch_rmid_read(rr->r, rr->hdr, closid, rmid,
 							 rr->evtid, &tval, rr->arch_mon_ctx);
 		if (rr->err)
 			return rr->err;
@@ -480,7 +480,7 @@ static int __l3_mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 			err = resctrl_arch_cntr_read(rr->r, d, closid, rmid, cntr_id,
 						     rr->evtid, &tval);
 		else
-			err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
+			err = resctrl_arch_rmid_read(rr->r, &d->hdr, closid, rmid,
 						     rr->evtid, &tval, rr->arch_mon_ctx);
 		if (!err) {
 			rr->val += tval;
@@ -497,8 +497,18 @@ static int __l3_mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 {
 	switch (rr->r->rid) {
-	case RDT_RESOURCE_L3:
-		return __l3_mon_event_count(rdtgrp, rr);
+	case RDT_RESOURCE_L3: {
+		struct rdt_mon_domain *d = NULL;
+
+		if (rr->hdr) {
+			if (!domain_header_is_valid(rr->hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3)) {
+				rr->err = -EIO;
+				return -EINVAL;
+			}
+			d = container_of(rr->hdr, struct rdt_mon_domain, hdr);
+		}
+		return __l3_mon_event_count(rdtgrp, rr, d);
+	}
 
 	default:
 		rr->err = -EINVAL;
@@ -523,9 +533,13 @@ static void mbm_bw_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 	u64 cur_bw, bytes, cur_bytes;
 	u32 closid = rdtgrp->closid;
 	u32 rmid = rdtgrp->mon.rmid;
+	struct rdt_mon_domain *d;
 	struct mbm_state *m;
 
-	m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
+	if (!domain_header_is_valid(rr->hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
+		return;
+	d = container_of(rr->hdr, struct rdt_mon_domain, hdr);
+	m = get_mbm_state(d, closid, rmid, rr->evtid);
 	if (WARN_ON_ONCE(!m))
 		return;
 
@@ -698,7 +712,7 @@ static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *
 	struct rmid_read rr = {0};
 
 	rr.r = r;
-	rr.d = d;
+	rr.hdr = &d->hdr;
 	rr.evtid = evtid;
 	if (resctrl_arch_mbm_cntr_assign_enabled(r)) {
 		rr.is_mbm_cntr = true;
-- 
2.51.0


