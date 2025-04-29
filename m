Return-Path: <linux-kernel+bounces-624075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13828A9FE61
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 02:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749BF463ED9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 00:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B250E216E05;
	Tue, 29 Apr 2025 00:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2XFTE22"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CAD1CAA90
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 00:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745886869; cv=none; b=u97uOlnnxwXmuiMGZVTvJdobynfmCguyOxP/ybyCaeeF+XsU1slKMFK/nOJqc9RnSLyEG4HaQDuIKzfZpr5OPU5+3yHlb/w1Yq8EN2Ih+GQzZCRBr5gOmw3zFXT6p2InJVLDM0ULjzyUB4Rsn74TUBY3u48HJh2w1XPL3l2T2zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745886869; c=relaxed/simple;
	bh=NDR7vXDn/AXv08PVU0Ra2XFtF46qLg6h6Xut6cwotbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gA9g9M5VmD7wcZWT4q6kGaeD5nbAmI4g32rkmcOG+/mp8Cgl0B9xaXy+f9Y9U74h7Enyx28WDPYNbeY/zwCM2XQ+9cdEQx2LW+y2vRSC/f+C8epUoDhJ+AhwXVKmRunjCxJbbV7WY+QjOr+iZus6X/rGorgG7gvmSj+2X1dC0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2XFTE22; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745886868; x=1777422868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NDR7vXDn/AXv08PVU0Ra2XFtF46qLg6h6Xut6cwotbo=;
  b=d2XFTE22HG7HYH9P18HtRfYban5YD+gLsArJGcJuYaiCXT8gcg2Xwp9u
   twYFXfrKKPC5yFh9oAWN7qsfLzf5YYmsHz8UtXhqHms3Lh6Zx46epRzg8
   /S5HYL8lTVWZrdut9D5r2qSK8dcNDG2eChwYFH4rXbc/eKmUZ30JdApx+
   ZzBeZGMAPdOAdpBBRMozl4wP7Z1EM6GSQvdjYsXeyEDu33geTtTNTzFmj
   itZoSsQa/kWQuhZPewW/WbSIWpedc4DIKN0WIe7kl+BUWraKNU7mgv3z5
   6s4tJKtEHts6lJM0a4sxQnKQT18fRUxkSsgRdqu03F6MPjoGgXEkPxzZx
   A==;
X-CSE-ConnectionGUID: 1En6XosYTYGHmwXLgDxKYA==
X-CSE-MsgGUID: x+YdhMycTE6pG2Q5PQWu2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58148257"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="58148257"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:34:21 -0700
X-CSE-ConnectionGUID: NBwkPYgnQW2XCE7GgSXXNw==
X-CSE-MsgGUID: iglkXtJqTNO3ASzBUdoWlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="133394055"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:34:20 -0700
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
Subject: [PATCH v4 23/31] x86,fs/resctrl: Handle domain creation/deletion for RDT_RESOURCE_PERF_PKG
Date: Mon, 28 Apr 2025 17:33:49 -0700
Message-ID: <20250429003359.375508-24-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429003359.375508-1-tony.luck@intel.com>
References: <20250429003359.375508-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The L3 resource has several requirements for domains. There are structures
that hold the 64-bit values of counters, and elements to keep track of
the overflow and limbo threads.

None of these are needed for the PERF_PKG resource. The hardware counters
are wide enough that they do not wrap around for decades.

Define a new rdt_perf_pkg_mon_domain structure which just consists of
the standard rdt_domain_hdr to keep track of domain id and CPU mask.

Change domain_add_cpu_mon(), domain_remove_cpu_mon(),
resctrl_offline_mon_domain(), and resctrl_online_mon_domain() to check
resource type and perform only the operations needed for domsins in the
PERF_PKG resource.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 41 ++++++++++++++++++++++++++++++
 fs/resctrl/rdtgroup.c              |  4 +++
 2 files changed, 45 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 0103f577e4ca..97fb2001c8d8 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -543,6 +543,38 @@ static void setup_l3_mon_domain(int cpu, int id, struct rdt_resource *r, struct
 	}
 }
 
+/**
+ * struct rdt_perf_pkg_mon_domain - CPUs sharing an Intel-PMT-scoped resctrl monitor resource
+ * @hdr:	common header for different domain types
+ */
+struct rdt_perf_pkg_mon_domain {
+	struct rdt_domain_hdr   hdr;
+};
+
+static void setup_intel_aet_mon_domain(int cpu, int id, struct rdt_resource *r,
+				       struct list_head *add_pos)
+{
+	struct rdt_perf_pkg_mon_domain *d;
+	int err;
+
+	d = kzalloc_node(sizeof(*d), GFP_KERNEL, cpu_to_node(cpu));
+	if (!d)
+		return;
+
+	d->hdr.id = id;
+	d->hdr.type = RESCTRL_MON_DOMAIN;
+	d->hdr.rid = r->rid;
+	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
+	list_add_tail_rcu(&d->hdr.list, add_pos);
+
+	err = resctrl_online_mon_domain(r, &d->hdr);
+	if (err) {
+		list_del_rcu(&d->hdr.list);
+		synchronize_rcu();
+		kfree(d);
+	}
+}
+
 static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 {
 	int id = get_domain_id_from_scope(cpu, r->mon_scope);
@@ -567,6 +599,9 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	case RDT_RESOURCE_L3:
 		setup_l3_mon_domain(cpu, id, r, add_pos);
 		break;
+	case RDT_RESOURCE_PERF_PKG:
+		setup_intel_aet_mon_domain(cpu, id, r, add_pos);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -664,6 +699,12 @@ static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
 		synchronize_rcu();
 		free_l3_mon_domain(hw_dom);
 		break;
+	case RDT_RESOURCE_PERF_PKG:
+		resctrl_offline_mon_domain(r, hdr);
+		list_del_rcu(&hdr->list);
+		synchronize_rcu();
+		kfree(container_of(hdr, struct rdt_perf_pkg_mon_domain, hdr));
+		break;
 	}
 }
 
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index da71057f3ff4..5e0d1777f162 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -4167,6 +4167,8 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain_hdr *hdr
 
 	mutex_lock(&rdtgroup_mutex);
 
+	if (r->rid == RDT_RESOURCE_PERF_PKG)
+		goto do_mkdir;
 	if (r->rid != RDT_RESOURCE_L3)
 		goto out_unlock;
 
@@ -4187,6 +4189,8 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain_hdr *hdr
 	if (resctrl_is_mon_event_enabled(QOS_L3_OCCUP_EVENT_ID))
 		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
 
+do_mkdir:
+	err = 0;
 	/*
 	 * If the filesystem is not mounted then only the default resource group
 	 * exists. Creation of its directories is deferred until mount time
-- 
2.48.1


