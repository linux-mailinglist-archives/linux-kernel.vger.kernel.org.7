Return-Path: <linux-kernel+bounces-757069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4C9B1BD55
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6468418C00D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BE8243399;
	Tue,  5 Aug 2025 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nZXeDgaY"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10BC241686;
	Tue,  5 Aug 2025 23:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436685; cv=fail; b=aJ9EEMlFB5NhQbToxIOmtxGIcKzDli5Q01oZ3XPsNd2egFV8/LLnZQKg/xeWRabf3nDD2BijsZvZvSWJ0Qym4l6umSjkPbEs/DpaorgwRy1CCFIXrHTHTTCH3twEBLHq63qtrJLv3zcXkUvTGXMl31IKZIImn9t652oJC89vMPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436685; c=relaxed/simple;
	bh=PVrWIwl1FEAfTrsQBS5UGjHqC3SYKGNUrQ55WY1gFjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZmMY7ETl+NrqOL1UwHLrI1whIbu81cpe+Pm7gsKgJYJWvPpANJfgL0JasnDrA1/G3IHZinYkOSy9cwVI7SJXDlLNtozJRAOe417SB76GwouphHukGkIoKBHaVlbIbtkWca3eldPfanVkaHe6lML2Ce2dMOg4CbmbsVsEmNpqx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nZXeDgaY; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9ymIKl82l1cwFYTN7RCpYNgV6atWiPt97a6RAU/7UeR4KQkeCF32z/vQNZrsJLBFsrkJyUDBQ0KVYS1FLAlcs8yPB4HLG/5TxZxzM8lWOFC5wS9xa2vQHhVngcuT2RddbeVRQUGi4JDE4CFDlW5paT+mGnB+Yd5UCEYBK2/5NpMZ9rP2pnZNaz33w85N1RNB0gJD1A2RH4iwUQYVfyqCHjeuG08H1/GDh3Ffu5maC5t5bsFI3yDgdY09ZWtUSvrFnfeMNIeXZwsBKCLRkYIcsTJnhOJoF4stALFO0KWBVqJQqjSCzDxFRSG3BENKfDMP5FX6yGe+5eH5KO8QC5/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSlFDkjtF0gE35QNWjQaTheHMed+XQnqQZcGicGBSBM=;
 b=YaJU4k6aJCjzJlQlg43K+qiQkro+n+D+U3crUzIlHQEZpd7yfXAA951QMVj6Ebvoi+4xSJ2FWW657hirjypakhSck8gZ9KkRNfDLChzWDyDeigNIwM7crO2wPvF1PYRLiHSl1185vLQ8LWAqoHPeCZBnkIjKTR8ZHfJWN7K3aasn0YRlJN+8l1I20St/0nC9VhpWvIN/eJ686Ut34mO+ZnJhzDeO78GBGDBpMzuMjy+N4XR2ve16qJGQM5/f8kNlMJw6iJm+idQ2ZyA+DR52pbVyM7GP2OYe/1PmA2xk52Lr7K0IjPPxUaOVsASGr04sjyJfrEyn8n1+z329bHwhQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSlFDkjtF0gE35QNWjQaTheHMed+XQnqQZcGicGBSBM=;
 b=nZXeDgaYagzrHs2LWlh1Owlg7rgvMHTNa4DORFxmGT3l73unaAzMu4vewT92ak5nH/W9JQrooQO41Zt+Q1j+3UCPFkQNZv5jPEFtnDRnKjKvITsYjGV5kIncuel5B6TrRgNIASwjcvH8rz6D50Y6Xxa61cNt0yBj5oylJXCVS4Y=
Received: from SN6PR05CA0022.namprd05.prod.outlook.com (2603:10b6:805:de::35)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 23:31:18 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::de) by SN6PR05CA0022.outlook.office365.com
 (2603:10b6:805:de::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Tue,
 5 Aug 2025 23:31:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 23:31:17 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 18:31:15 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<babu.moger@amd.com>, <yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>,
	<xin@zytor.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <me@mixaill.net>, <mario.limonciello@amd.com>,
	<xin3.li@intel.com>, <ebiggers@google.com>, <ak@linux.intel.com>,
	<chang.seok.bae@intel.com>, <andrew.cooper3@citrix.com>,
	<perry.yuan@amd.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <manali.shukla@amd.com>,
	<gautham.shenoy@amd.com>
Subject: [PATCH v8 03/10] x86,fs/resctrl: Detect io_alloc feature
Date: Tue, 5 Aug 2025 18:30:23 -0500
Message-ID: <e7f2569d1dff40f8691053aa92c345560168ee9a.1754436586.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1754436586.git.babu.moger@amd.com>
References: <cover.1754436586.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: 864ec592-3ee0-456b-5966-08ddd4782d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oUNSwKTaPdJRyVfk1vqUBje1PchWe3y0G58ha+Ix25egQVOZXig1kwGwyOQa?=
 =?us-ascii?Q?YJHULAtGpbBzUVv3jRt1GzOxsAtcXQMWCLf8U5y+z+Wf2MJcTUBBmwob3B9w?=
 =?us-ascii?Q?UTYh6BfKSl/cGkscAgCDBw9tPzQSHvsQK5BQFso3kxaQdrtos6LV8ZiMEwiT?=
 =?us-ascii?Q?yxpCM8khiMnhYQKT+tThS4IdU6HDlYvM6xFqq/GKwZ7mAxTfEcvSEhbdwJq2?=
 =?us-ascii?Q?daohhWVJzuozut/Dmsy46FNL5M04GyHCzNLb3iMIolxS+CXbHPb0PTxnekEN?=
 =?us-ascii?Q?rZYIz3OyLZTaWMynwvIwuTAIG0XDfzxJz+4JZI5EiYUn1dhRYMDFoOwnyCH6?=
 =?us-ascii?Q?L4mGDrF+VuVR1RZJ+zHIqOWKgCT/j37buVBQDMbudSrgw0qmMZWUHBy03034?=
 =?us-ascii?Q?ocLNMGl7dN/QewZsF4Em+0hfw1wbB7FctSWy0fbhKhPzLJbuwifHqM8demIH?=
 =?us-ascii?Q?z46KEMc4jYtdNMVTA2JE/3kOKGlgOyzkT8C3NtPHpAhhPl1NmPDdr8WUVJj2?=
 =?us-ascii?Q?LMXDFrrTvRSANMWfNSaAo9k8hZylWXj94qrdBWC4TJmr4OuDceh8bLX3qZA4?=
 =?us-ascii?Q?PhyAng0ZA22cE4y7N+unU8L0Yrq6wK2WSPPt/myMBzvHfP+uaTT3PM4MgamD?=
 =?us-ascii?Q?mtwweKhoJImTJklcXMfxt0GOEr26nBCC7KKABDPPz5yMwT4HR6TFE05wpFDB?=
 =?us-ascii?Q?6kKLrMuN8zSm/WkIITethlc82v0H+Hs5UhpyI8NCeHqmDcPKgQMjWp7L2ESv?=
 =?us-ascii?Q?aYE4Ru0HVZm6zKrkwTLi3+ddA/iC4mCB9JamzqspzIX2D/PAWpeERnucDJeC?=
 =?us-ascii?Q?PJfS4siKrsyRPGR82aJqNuJzBu90XgsZdBoOrErzrAdUdgY2lnVuKRxgkLZ7?=
 =?us-ascii?Q?w6go2bez8D9xWpFnvC9P1aBhhX5Od1qBWtFH5MPeK/XAIybu8SXbsxdZ2mHQ?=
 =?us-ascii?Q?hypiQi+fjEnh/S7pAUMKeOHruvUYUUARftwMxQ9/Ka+mLuL/Q3xH0QxWIlRh?=
 =?us-ascii?Q?zOTXKBgLoobUb9N3NhRfZjQQAUz1QQSbCMuDkC/RrNpznaytgbYySeXh6OY4?=
 =?us-ascii?Q?c25WyLRQDHZmNU+pEwf7x0GhzTs26fFpg8kSuFTBf7bMb8cXifiIEgXwd5Ir?=
 =?us-ascii?Q?qXDGlIVYg28CniK5ozxvZvwJcv36bRS8SJQzEva9qIHnE+4o1J4LoFpI+BOL?=
 =?us-ascii?Q?7F2mAtjHV4ej758Lbb8M/jY9nPKh8fKaq/btSGQxRG+TfNrO7A2P6FTRTRrE?=
 =?us-ascii?Q?qFyf9Zd07Lc0pXnLR+x1aLGQg/FAKxHqTcdOwuyXslFt+4f2c+uUZLwmCupS?=
 =?us-ascii?Q?oeT2cfyMngmDGMsuIWCi0NVj5tHNPHbKX4pINtZ7LJyT203dWNlNribztqIV?=
 =?us-ascii?Q?pCW8fVb10RURYVKpbrkHlw9xUcDvuMwzGAqbKUIbSF4Qg+RRpfZ6P8jSDD+S?=
 =?us-ascii?Q?lwsdUeat/e8sN160GTK+4tQTE/3uniqpVTSqfmonU1fudYtAZCV4qhcdLDN/?=
 =?us-ascii?Q?RemCw16ZgZv7Qgeyl22uqh66L5/9drGUTPJU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 23:31:17.5850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 864ec592-3ee0-456b-5966-08ddd4782d3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616

Smart Data Cache Injection (SDCI) is a mechanism that enables direct
insertion of data from I/O devices into the L3 cache. It can reduce the
demands on DRAM bandwidth and reduces latency to the processor consuming
the I/O data.

Introduce cache resource property "io_alloc_capable" that an architecture
can set if a portion of the cache can be allocated for I/O traffic.

Set this property on x86 systems that support SDCIAE (L3 Smart Data Cache
Injection Allocation Enforcement). This property is set only for the L3
cache resource on systems that support SDCIAE.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v8: Added Reviewed-by tag.

v7: Few text updates in changelog and resctrl.h.

v6: No changes.

v5: No changes.

v4: Updated the commit message and code comment based on feedback.

v3: Rewrote commit log. Changed the text to bit generic than the AMD specific.
    Renamed the rdt_get_sdciae_alloc_cfg() to rdt_set_io_alloc_capable().
    Removed leftover comment from v2.

v2: Changed sdciae_capable to io_alloc_capable to make it generic feature.
    Also moved the io_alloc_capable in struct resctrl_cache.
---
 arch/x86/kernel/cpu/resctrl/core.c | 7 +++++++
 include/linux/resctrl.h            | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index f6d84882cc4e..1d1002526745 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -274,6 +274,11 @@ static void rdt_get_cdp_config(int level)
 	rdt_resources_all[level].r_resctrl.cdp_capable = true;
 }
 
+static void rdt_set_io_alloc_capable(struct rdt_resource *r)
+{
+	r->cache.io_alloc_capable = true;
+}
+
 static void rdt_get_cdp_l3_config(void)
 {
 	rdt_get_cdp_config(RDT_RESOURCE_L3);
@@ -842,6 +847,8 @@ static __init bool get_rdt_alloc_resources(void)
 		rdt_get_cache_alloc_cfg(1, r);
 		if (rdt_cpu_has(X86_FEATURE_CDP_L3))
 			rdt_get_cdp_l3_config();
+		if (rdt_cpu_has(X86_FEATURE_SDCIAE))
+			rdt_set_io_alloc_capable(r);
 		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CAT_L2)) {
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 6fb4894b8cfd..010f238843b2 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -191,6 +191,8 @@ struct rdt_mon_domain {
  * @arch_has_sparse_bitmasks:	True if a bitmask like f00f is valid.
  * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache
  *				level has CPU scope.
+ * @io_alloc_capable:	True if portion of the cache can be configured
+ *			for I/O traffic.
  */
 struct resctrl_cache {
 	unsigned int	cbm_len;
@@ -198,6 +200,7 @@ struct resctrl_cache {
 	unsigned int	shareable_bits;
 	bool		arch_has_sparse_bitmasks;
 	bool		arch_has_per_cpu_cfg;
+	bool		io_alloc_capable;
 };
 
 /**
-- 
2.34.1


