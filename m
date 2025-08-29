Return-Path: <linux-kernel+bounces-792360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992B0B3C317
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6115A564C55
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9A325485F;
	Fri, 29 Aug 2025 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gp1ZrEmv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740CF243956
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496039; cv=none; b=UlOdFdfDhxe4WvHjSq4OwsqIRT6UFCB4b6/olNVrgchcVxqYs/d87fDhXA4qySHzj6P8RxhamuiQjfdNR9SOeJZVSlXqVYz6zWEBr+ekIOHpUphPrOwLNsEhJ0FT4ON6bIKrcY/ZEG41cWF30B2wxcsKuCZRlRzPWS5gHK80C1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496039; c=relaxed/simple;
	bh=6gfm0wDY243aV02xOCkOFGfT7wJ/5Vw+iNp5AHcj97U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqhdM5vI2oLq+Qmfse+fR5JRXWqpl9PxdZCAytDZ5rlAcuc4BB9MTskiw5hDaaVd1E39kMQ0Mw/oygpvubqLFuFjIKBiu51LCfdZy7rjS5gGExILRd1AkM6Ak1S5jFCw+EqM9dPo+UuT4lpwUW1BxbG1dyUT5RqY+H/ywJuq3Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gp1ZrEmv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756496037; x=1788032037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6gfm0wDY243aV02xOCkOFGfT7wJ/5Vw+iNp5AHcj97U=;
  b=Gp1ZrEmvDI/+dEyPEBXQzHDBgyQUfasCzCuc1J0QVqID/6sYXOHaqDL6
   +6E6OhUYAmXHpy2GMI5ULH42H4LtxUHf9Y5sKFtknuqtm08I6zD3rZ2za
   mjB1ZSjaXqwcOmuM+DQ/IUHpUBdT3Cl9sN0/9bwUC37jn4kU8diT7F8MP
   NjukipIqf3KiUB7KferJsgXzXLGEKpXO14xOv3PW8aRQRz5gLwX4Tx5P6
   +iW6o/8WYVxfmQJVVTpwt89XM2cvf+cslBUQDbEZNktvPBiJB1/ss+hhl
   URLmprMvrDBKXqG2CSdh8ckPu57yLUtKkkGuHFL33KOI4DN0yyBt1zfwl
   Q==;
X-CSE-ConnectionGUID: SZBUStc4QICnutIMcQuLcg==
X-CSE-MsgGUID: FMsT9kbZR727Jbz0qzdISg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62625173"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62625173"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:33:53 -0700
X-CSE-ConnectionGUID: rkLYAzj1RF2TCBWOhBA0tg==
X-CSE-MsgGUID: uD5+aldJRQ6Mvys+t7K0UQ==
X-ExtLoop1: 1
Received: from ldmartin-desk2.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.220.202])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:33:53 -0700
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
Subject: [PATCH v9 05/31] x86,fs/resctrl: Improve domain type checking
Date: Fri, 29 Aug 2025 12:33:17 -0700
Message-ID: <20250829193346.31565-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829193346.31565-1-tony.luck@intel.com>
References: <20250829193346.31565-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rdt_domain_hdr structure is used in both control and monitor
domain structures to provide common methods for operations such as
adding a CPU to a domain, removing a CPU from a domain, accessing
the mask of all CPUs in a domain.

rdt_domain_hdr::type provides a simple check whether a domain is a
control or monitor domain so that programming errors operating
on domains will be quickly caught. This is insufficient to
catch errors when other resources besides L3 support monitor
events.

Add rdt_domain_hdr::rid to contain the resource id and initialize it
as part of domain structure allocation done by CPU online handler. Call
domain_header_is_valid() to sanity check both the type and resource id
before using container_of() to get a pointer to the associated domain.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h            |  9 +++++++++
 arch/x86/kernel/cpu/resctrl/core.c | 10 ++++++----
 fs/resctrl/ctrlmondata.c           |  2 +-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 478d7a935ca3..091135eca2b8 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -131,15 +131,24 @@ enum resctrl_domain_type {
  * @list:		all instances of this resource
  * @id:			unique id for this instance
  * @type:		type of this instance
+ * @rid:		resource id for this instance
  * @cpu_mask:		which CPUs share this resource
  */
 struct rdt_domain_hdr {
 	struct list_head		list;
 	int				id;
 	enum resctrl_domain_type	type;
+	enum resctrl_res_level		rid;
 	struct cpumask			cpu_mask;
 };
 
+static inline bool domain_header_is_valid(struct rdt_domain_hdr *hdr,
+					  enum resctrl_domain_type type,
+					  enum resctrl_res_level rid)
+{
+	return !WARN_ON_ONCE(hdr->type != type || hdr->rid != rid);
+}
+
 /**
  * struct rdt_ctrl_domain - group of CPUs sharing a resctrl control resource
  * @hdr:		common header for different domain types
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index fbf019c1ff11..420e4eb7c160 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -459,7 +459,7 @@ static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
 
 	hdr = resctrl_find_domain(&r->ctrl_domains, id, &add_pos);
 	if (hdr) {
-		if (WARN_ON_ONCE(hdr->type != RESCTRL_CTRL_DOMAIN))
+		if (!domain_header_is_valid(hdr, RESCTRL_CTRL_DOMAIN, r->rid))
 			return;
 		d = container_of(hdr, struct rdt_ctrl_domain, hdr);
 
@@ -476,6 +476,7 @@ static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
 	d = &hw_dom->d_resctrl;
 	d->hdr.id = id;
 	d->hdr.type = RESCTRL_CTRL_DOMAIN;
+	d->hdr.rid = r->rid;
 	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
 
 	rdt_domain_reconfigure_cdp(r);
@@ -515,7 +516,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 
 	hdr = resctrl_find_domain(&r->mon_domains, id, &add_pos);
 	if (hdr) {
-		if (WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN))
+		if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, r->rid))
 			return;
 		d = container_of(hdr, struct rdt_mon_domain, hdr);
 
@@ -530,6 +531,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	d = &hw_dom->d_resctrl;
 	d->hdr.id = id;
 	d->hdr.type = RESCTRL_MON_DOMAIN;
+	d->hdr.rid = r->rid;
 	ci = get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
 	if (!ci) {
 		pr_warn_once("Can't find L3 cache for CPU:%d resource %s\n", cpu, r->name);
@@ -586,7 +588,7 @@ static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	if (WARN_ON_ONCE(hdr->type != RESCTRL_CTRL_DOMAIN))
+	if (!domain_header_is_valid(hdr, RESCTRL_CTRL_DOMAIN, r->rid))
 		return;
 
 	d = container_of(hdr, struct rdt_ctrl_domain, hdr);
@@ -632,7 +634,7 @@ static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	if (WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN))
+	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, r->rid))
 		return;
 
 	d = container_of(hdr, struct rdt_mon_domain, hdr);
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index ad7ffc6acf13..a7d60e74a29d 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -643,7 +643,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		 * the resource to find the domain with "domid".
 		 */
 		hdr = resctrl_find_domain(&r->mon_domains, domid, NULL);
-		if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN)) {
+		if (!hdr || !domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, resid)) {
 			ret = -ENOENT;
 			goto out;
 		}
-- 
2.50.1


