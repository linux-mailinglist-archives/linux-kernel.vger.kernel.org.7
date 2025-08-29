Return-Path: <linux-kernel+bounces-792380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 838F5B3C32B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D5E1CC3A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC69734A32C;
	Fri, 29 Aug 2025 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7gFnAD7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90BD321445
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496052; cv=none; b=mdhnWRto0a7wNmBUFSIPvsJWCvGdM4C9UrszoO0MtQR8IQZxKRrhHCdv6Ve8OJiE87LUVx6k8Fo3jf6720YCzbHIK6xVBbKCJoj0SGKAKqsq2O0W3Tuhq0Spu6F7dC7E+4ECSJwmQ+W5O5x3TSrionbZXC/LoH/c4klVDkwqOEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496052; c=relaxed/simple;
	bh=ntO/opyyiJMsNvbOMD75APDmDVxJMO/enXmVwd6H8AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7qQPWzaCDuLtM1P0FzRdiDYykPshwtPN+5QnJA6MLoPhgzoGnnVq/vsS9Tjs9CzkXwFkT6uvhg5VokmvUuiS5fR8EPRIwjybz0hJuDiKLriL02L6bfPG1lBu7EsBOaOd1p48YIIitYEzx3XReyJe8njkVmt/vWoF35pLtJO8/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7gFnAD7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756496050; x=1788032050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ntO/opyyiJMsNvbOMD75APDmDVxJMO/enXmVwd6H8AY=;
  b=J7gFnAD7I9V6Zy64kUa2CQtu2sLh6GBFzSuzwxi43tQvjX9uB9nXzZGP
   QMrlMld5AXah32rOap80tFLvvYdznKPYYvk4F+YjtriBKA9IiQTB0iS1O
   mR9EgS3M1k3SfjllotC4pgHdKDe6XFdqYES+uoMjVi796XdK8avbV00tT
   Ayu2Z8cdX5ENNREZTE+e9yMQwyjcYEpgRJBozTN+BUstixVt69OTK59Xd
   tzjQ47cBF5sjWrpu9XUfKLoPikmaoOhQRDNYZ/HNxCu2n7eGNBCOBKI3m
   QVcp/Ne0IFgtzbzZp9LjTPgqlXuU0g0s833L6tSrOG4Afe1xHxDikPO+m
   A==;
X-CSE-ConnectionGUID: XK5kKwdrROmRyr/gK4Cltg==
X-CSE-MsgGUID: YOVfRyWBQbatAUxdF5kOkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62625350"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62625350"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:33:56 -0700
X-CSE-ConnectionGUID: LiSFqCuJRaygbcrcYpUBfw==
X-CSE-MsgGUID: iA2dgFL6SSeZz3Z1bT5l6A==
X-ExtLoop1: 1
Received: from ldmartin-desk2.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.220.202])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:33:56 -0700
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
Subject: [PATCH v9 26/31] fs,x86/resctrl: Compute number of RMIDs as minimum across resources
Date: Fri, 29 Aug 2025 12:33:38 -0700
Message-ID: <20250829193346.31565-27-tony.luck@intel.com>
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

resctrl assumes that only the L3 resource supports monitor events, so
it simply takes the rdt_resource::num_rmid from RDT_RESOURCE_L3 as
the system's number of RMIDs.

The addition of telemetry events in a different resource breaks that
assumption.

Compute the number of available RMIDs as the minimum value across
all mon_capable resources (analogous to how the number of CLOSIDs
is computed across alloc_capable resources).

Note that mount time enumeration of the telemetry resource means that
this number can be reduced. If this happens, then some memory will
be wasted as the allocations for rdt_l3_mon_domain::states[] will be
larger than needed.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 15 +++++++++++++--
 fs/resctrl/rdtgroup.c              |  5 +++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index dbad8d301e03..8aa7d9105971 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -110,12 +110,23 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 	},
 };
 
+/**
+ * resctrl_arch_system_num_rmid_idx - Compute number of supported RMIDs
+ *				      (minimum across all mon_capable resource)
+ *
+ * Return: Number of supported RMIDs at time of call. Note that mount time
+ * enumeration of resources may reduce the number.
+ */
 u32 resctrl_arch_system_num_rmid_idx(void)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	u32 num_rmids = U32_MAX;
+	struct rdt_resource *r;
+
+	for_each_mon_capable_rdt_resource(r)
+		num_rmids = min(num_rmids, r->num_rmid);
 
 	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
-	return r->num_rmid;
+	return num_rmids == U32_MAX ? 0 : num_rmids;
 }
 
 struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 01e42130e98b..3201e9cad8da 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -4116,6 +4116,11 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain_hdr *h
  * During boot this may be called before global allocations have been made by
  * resctrl_l3_mon_resource_init().
  *
+ * This routine is called at resctrl init time. The number of supported RMIDs
+ * may be reduced if additional mon_capable resources are enumerated at mount
+ * time. This means the rdt_l3_mon_domain::mbm_states[] and
+ * rdt_l3_mon_domain::rmid_busy_llc allocations may be larger than needed.
+ *
  * Returns 0 for success, or -ENOMEM.
  */
 static int domain_setup_l3_mon_state(struct rdt_resource *r, struct rdt_l3_mon_domain *d)
-- 
2.50.1


