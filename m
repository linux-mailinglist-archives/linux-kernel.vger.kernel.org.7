Return-Path: <linux-kernel+bounces-624067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAEEA9FE58
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 02:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD15A1A88538
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 00:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF622036E4;
	Tue, 29 Apr 2025 00:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SK1j3S1+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA0E1E32A0
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745886863; cv=none; b=RBup5QY4jqPvUBlydd8orwQf/qbO+iFjU1p/JDEK/TU7H/opneT7AhIErW9piBG9DOXrSwYWqvSTi/ZqyvJy0cXOqqprbJPRMKMJQVfYMDoIA3+Emc1lb0frGtL/SNOd4t/x+pPhMuxoJih9umofFQ9ury6gbhYh54JxlR3ATD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745886863; c=relaxed/simple;
	bh=15VcvfROAR474ItBc9auyiDza59uw8Tb2NSQm0dC2f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7VhzTDt3leBHo79SAoy3aa6fC+vNmRp1xp/Z+S3h92hL1y0rv62UJ8bD3BHT2WxtrX5Q86VwZI+SSp0j3OqMiUJBLWIX1YVu1PMAQs+ym7QE5G+CF/FLTjH3OoDJ1rgA6l5qDnDwwWlDTrq5ZifqUXo/O8FuRRSm9wMJ3WbIpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SK1j3S1+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745886862; x=1777422862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=15VcvfROAR474ItBc9auyiDza59uw8Tb2NSQm0dC2f0=;
  b=SK1j3S1+KbgCCK+VOCPHWm6NewC3SvxD/sNN2f3jYXrYuzKz+hwKzRoA
   W1qV5xutSf+qvIS+fhlvTbZ6I6YeFUnLk+F6OeWRR9LyUmkyuWKecRpyc
   +WV23TtVwfSLpzfZZYA7YvPcV/M9z5AoRF3K9MM4BKUBRcpV5K5aCPdn5
   vp8rpoCgEFQw24nTUxucYGoEcU3jO3ziqa5E8k0BCn5+6w+pciEroGzWx
   /q+TSp1iPuBZLKuE5zTA/1MLSagsLRLyGvQia23bFDuWp0ZiDCC4o+eXD
   LyBQSUYrmqBp3UpUUkkiOy49EmXmvARLTlYARL80LJ55VDj/zxzR3HzRG
   w==;
X-CSE-ConnectionGUID: ci3vqIekRm6gNslJKPSZEQ==
X-CSE-MsgGUID: uVgmPZVqSueH5nfkAT3p+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58148176"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="58148176"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:34:16 -0700
X-CSE-ConnectionGUID: 7Dpxym4ORNm+cMY98A0EEg==
X-CSE-MsgGUID: vUPEr53IR0CjyehQ5vJJMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="133394016"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:34:15 -0700
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
Subject: [PATCH v4 15/31] x86/resctrl: Add and initialize rdt_resource for package scope core monitor
Date: Mon, 28 Apr 2025 17:33:41 -0700
Message-ID: <20250429003359.375508-16-tony.luck@intel.com>
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

Counts for each Intel telemetry event are periodically sent to one or
more aggregators on each package where accumulated totals are made
available in MMIO registers.

Add a new resource for monitoring these events with code to build
domains at the package granularity.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h            |  2 ++
 arch/x86/kernel/cpu/resctrl/core.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 6f424fffa083..3ae50b947a99 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -53,6 +53,7 @@ enum resctrl_res_level {
 	RDT_RESOURCE_L2,
 	RDT_RESOURCE_MBA,
 	RDT_RESOURCE_SMBA,
+	RDT_RESOURCE_PERF_PKG,
 
 	/* Must be the last */
 	RDT_NUM_RESOURCES,
@@ -250,6 +251,7 @@ enum resctrl_scope {
 	RESCTRL_L2_CACHE = 2,
 	RESCTRL_L3_CACHE = 3,
 	RESCTRL_L3_NODE,
+	RESCTRL_PACKAGE,
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 2f3efc4b1816..4d1556707c01 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -99,6 +99,15 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.schema_fmt		= RESCTRL_SCHEMA_RANGE,
 		},
 	},
+	[RDT_RESOURCE_PERF_PKG] =
+	{
+		.r_resctrl = {
+			.rid			= RDT_RESOURCE_PERF_PKG,
+			.name			= "PERF_PKG",
+			.mon_scope		= RESCTRL_PACKAGE,
+			.mon_domains		= mon_domain_init(RDT_RESOURCE_PERF_PKG),
+		},
+	},
 };
 
 u32 resctrl_arch_system_num_rmid_idx(void)
@@ -430,6 +439,8 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
 		return get_cpu_cacheinfo_id(cpu, scope);
 	case RESCTRL_L3_NODE:
 		return cpu_to_node(cpu);
+	case RESCTRL_PACKAGE:
+		return topology_physical_package_id(cpu);
 	default:
 		break;
 	}
-- 
2.48.1


