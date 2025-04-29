Return-Path: <linux-kernel+bounces-624069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5869FA9FE5B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 02:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C26C9211D3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 00:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1612E20CCEB;
	Tue, 29 Apr 2025 00:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OX2IUPFc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32D638F80
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 00:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745886865; cv=none; b=RELg+OpVcPOuQHo2YlYi/yI2qFvYy/LI9cQn3HRpkWsUk5q/szk4Gv8RwMDo5qgeaG8hBTQYohbm8lS7p/I1aIES2HSJyNecfwEjpXzG0cyQOAjwCEQGIRdQLZXcfh3AB03gsi66aXt8oF6KpJ7P1/QaIcY7NpAlA5Y1ei0BVbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745886865; c=relaxed/simple;
	bh=DBNWvEwmeMeKU8j2/lRh512Z9DrD7XKVYbh9X8sJzag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lb7uZUz5qf9ATAQkyTNTQEBH8nFqgkjkdDlQ2Zjyku71IQvAF1EZKPnr22NVorGWHu7e9nCmtK1ukif9nU2ffSPl3V90w+9tZ7yJRu+fO+eddaJN3Q5TiSDf5No2YmQxsQCEP8KYAMc/AiiFuMjAMpwOe6/+JFudENs8Wet0qCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OX2IUPFc; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745886863; x=1777422863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DBNWvEwmeMeKU8j2/lRh512Z9DrD7XKVYbh9X8sJzag=;
  b=OX2IUPFcc50kdOd/aNd7mFFytVlQVJhvxXKj8VQMZhOiWgKoYy/hbOsp
   mMgQTp2P0wuN3qwO7XyoygZdAr94bVnmw1vrhB/ttkqlHwrwcrtCZECAc
   +g4NbKZTBnPPOrnBfGrr64x5iekQauJ2rZ3KS4FsjMtBwprk6BF2QsvTE
   er9cyTJx/YrkHvxAGaNbQDJmCP1f5XLacn0EL6qH230odZlf7gwe4e+VA
   RZnM09Kq0pwC13D4IZT+p0V66ONHvmVBcVcnkpbjfA5CTbf8d2PM5zHqf
   PhURmvuNozR6ojQv620lZwIknK4gZRM7fveI8EkvikJCQ7WP7Yefh0JDa
   Q==;
X-CSE-ConnectionGUID: kcBC4YT0QmyOu2rPZIt1BA==
X-CSE-MsgGUID: cuU+AzwTR3OZd+C2ETfdsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58148196"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="58148196"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:34:17 -0700
X-CSE-ConnectionGUID: 1l3tv4A6Q8GRiWCaI8RI/Q==
X-CSE-MsgGUID: 5MvWLbtbQ7iPfZ490DL4gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="133394024"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:34:16 -0700
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
Subject: [PATCH v4 17/31] x86/resctrl: Add second part of telemetry event enumeration
Date: Mon, 28 Apr 2025 17:33:43 -0700
Message-ID: <20250429003359.375508-18-tony.luck@intel.com>
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

There may be multiple telemetry aggregators per package, each enumerated
by a telemetry region structure in the feature group.

Scan the array of telemetry region structures and count how many are
in each package in preparation to allocate structures to save the MMIO
addresses for each in a convenient format for use when reading event
counters.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index dda44baf75ae..a0365c3ce982 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -52,6 +52,27 @@ static struct event_group *known_event_groups[] = {
 
 static bool configure_events(struct event_group *e, struct pmt_feature_group *p)
 {
+	int *pkgcounts __free(kfree) = NULL;
+	struct telemetry_region *tr;
+	int num_pkgs;
+
+	num_pkgs = topology_max_packages();
+	pkgcounts = kcalloc(num_pkgs, sizeof(*pkgcounts), GFP_KERNEL);
+	if (!pkgcounts)
+		return false;
+
+	/* Get per-package counts of telemetry_region for this guid */
+	for (int i = 0; i < p->count; i++) {
+		tr = &p->regions[i];
+		if (tr->guid != e->guid)
+			continue;
+		if (tr->plat_info.package_id >= num_pkgs) {
+			pr_warn_once("Bad package %d\n", tr->plat_info.package_id);
+			continue;
+		}
+		pkgcounts[tr->plat_info.package_id]++;
+	}
+
 	return false;
 }
 
-- 
2.48.1


