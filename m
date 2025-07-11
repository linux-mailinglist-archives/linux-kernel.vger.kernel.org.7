Return-Path: <linux-kernel+bounces-728426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DBCB027FF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048381CC1B40
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6753244688;
	Fri, 11 Jul 2025 23:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KMzGXU7d"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F312417D9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752278051; cv=none; b=ni064sCoiOLxmnisBy0+QoWEGyy/6Cr159oqBE2LWu3u6EcjZRMfWEVrDGw9L5WEGpuAo8ArTyEiw5KBpSvjV94yevYOcVYdQNs0CGjwA98c4X2fCXTmdhnLNkIXT4fqOFVfpXMQ81Uqmb2mr3xLKhvc9eG1QtJttM0m5wpopg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752278051; c=relaxed/simple;
	bh=t4lJiKVuSimJ6dXBjUGC8FhHCkw6xQkX2uUinMYC5RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u36nv+dnpMuTZHm2tndI0LddERFG5/lZzUH8QpG6catQHTy2SSJ5sPb1tGT/tgVDYfE5WTEzekTrjauTmLXcFOOjcygzHWiqZlrgLpE4Qs2q6cGuVpROtMjkKPZNvi0fmOYJepzK/EUQm77ybpLPLzL78qBucSKMhKnvVihaiu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KMzGXU7d; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752278049; x=1783814049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t4lJiKVuSimJ6dXBjUGC8FhHCkw6xQkX2uUinMYC5RA=;
  b=KMzGXU7dE3OR5aqqR8O+jotmasB8tpN/r+K/cdBjS3XciFm0acNUEW2+
   bsMuEA5hPvn22tVfWA0PtBCK0k45bXRJTHFwOQg5GO16XFRprqAND2Sfo
   ZsBVRexA8/vwJFYII7OmA7yfBpqH2adSOQB7xvtHKpxnoxsmSGQ3D9eRg
   VHJI5on6+uIz8kwBfeFdhvAJVxVRXqn1GgEHJJyj+cBvtWCtb/0tXcnyW
   h10/EUeXzafGVZpyJfnO3nZqZ3wPcmDU3PgB4IdbDWJmehIoHF1qPF2o/
   ruoncJVVTMe571kPvN8OqvguuoslWWAlEQnLj8KN6CwRs1QguIrmd/e1q
   w==;
X-CSE-ConnectionGUID: Orpo/zaUTTGw3xous4+oaA==
X-CSE-MsgGUID: NXKnImZnSgeqotpt33x7QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54292758"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="54292758"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:54:04 -0700
X-CSE-ConnectionGUID: eNwrslmVQtuYWpc7OICtNQ==
X-CSE-MsgGUID: EURWCQKXTOWaiNcWUAnTeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="155902157"
Received: from agluck-desk3.sc.intel.com ([172.25.103.51])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:54:04 -0700
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
Subject: [PATCH v7 23/31] x86/resctrl: Handle domain creation/deletion for RDT_RESOURCE_PERF_PKG
Date: Fri, 11 Jul 2025 16:53:30 -0700
Message-ID: <20250711235341.113933-24-tony.luck@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711235341.113933-1-tony.luck@intel.com>
References: <20250711235341.113933-1-tony.luck@intel.com>
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

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 41 ++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 63baab53821a..c954171073c7 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -547,6 +547,38 @@ static void l3_mon_domain_setup(int cpu, int id, struct rdt_resource *r, struct
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
@@ -574,6 +606,9 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	case RDT_RESOURCE_L3:
 		l3_mon_domain_setup(cpu, id, r, add_pos);
 		break;
+	case RDT_RESOURCE_PERF_PKG:
+		setup_intel_aet_mon_domain(cpu, id, r, add_pos);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -670,6 +705,12 @@ static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
 		synchronize_rcu();
 		l3_mon_domain_free(hw_dom);
 		break;
+	case RDT_RESOURCE_PERF_PKG:
+		resctrl_offline_mon_domain(r, hdr);
+		list_del_rcu(&hdr->list);
+		synchronize_rcu();
+		kfree(container_of(hdr, struct rdt_perf_pkg_mon_domain, hdr));
+		break;
 	default:
 		pr_warn_once("Unknown resource rid=%d\n", r->rid);
 		break;
-- 
2.50.0


