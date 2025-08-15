Return-Path: <linux-kernel+bounces-769995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05900B275BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2B45E4AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC99A29AAEF;
	Fri, 15 Aug 2025 02:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GY4tUYFX"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2451298CA6;
	Fri, 15 Aug 2025 02:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224821; cv=fail; b=Vt2FFxpNtAOpJAFJek4c2INaQBJInls+jJGzQ5SV1Cn0xomErLAUoUgHLpwLevwrML2jF73y+9hokZFWn2hBXsPrTVsMbbBw9sSTuHtutGrTIUeAMnff/g6S79xlatojVdS2i0KcYefYhoQUj5zDUrNxx67klxeo0XLTiInHB2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224821; c=relaxed/simple;
	bh=LExdk9E5VkV7HPshsMcLTeNcOwDQPZdXcajEvddkkOc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gz80XM5N0q3m3bcalIGvKyAvedMesvv1TwTAI+I5ZCDpO/T9cjaXqD9A8V+8vWZ+8wgcEdzZtDJohYXr/On3MmXYynnVgoV8K/jJqzY+8ixV+T0xVES7q/Zq5w/EpLgN2EdyNzzUJk7uxmRKLWDjfT8J4oJzy8/u55CBGK+nOYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GY4tUYFX; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PP16oJcUccPo4e9wY/jAkxv73y+Glqo9oVBpJyOZlek/yRMpXzxfHzEI48uJwSo7B6KYicpGVWsbSd3xmiCxOeXIKzPmsueiuadQwsXKef6i+KjhAXsvYPMWuvSMyYanab131svyTEaOPDg/6Jdat1wcLNdSp6TDjBncAf4vP/IHAT7vnp47zTJ4smK89aJo7tNXp4yfJ9rXtHgaO3rEMhVNOD72yogAYDxEyHOsD8vYXTBZCjjMRFXOlRnqp2cEsIlZMR03JMkS7QKNlgmeFU+VLjr3m7raT86TFt8zHzNOt5vnSOj52XA2VdypNzV80i8BuCylbi+YebWuoVvsMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esPUQBJQokeR59R5QzE+liFE2un0NQ7WtX4AGE2xTps=;
 b=MrOaRMC4Fj76mRXRyUxctuGylDrmsabAuwbCnNQnhWZLND7QIci4s31wxuNk2AHFRocNhwS0B1kpSujUzh7/cXCGNpmhWQAlPg0v2nz/rsbEF6j76XUhJzUBrXfAC5gVhGQiRrRqS7APCmAx8zegHE60INiYkkpmfX8Fp3mQ9wA5nAOyjHe+ELQ3Oya9h23bqrSF6e5EdEgQhhyKWRVfYlOqm18/vvLD56pQ4jWO3B8VezSRyJKQqV+2rk9v+7mNgM83DTVvRqRSM7ERtl82m1vrrGNdAozxU201KN/ddz0WgNv4jREMIR8bP/IzAYlvzNR3TGav1uTFLOLJlkAXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esPUQBJQokeR59R5QzE+liFE2un0NQ7WtX4AGE2xTps=;
 b=GY4tUYFXp8tl7gp5jGa3uxEJO0De0FdZ/TfKtLg75RnnVHotBgC8/jME+WR2OczmyQhddllQroOwWYU4wE7xT5xAftWY1Rg1OHsJ1iB2XXtyMaVMpTSu+R3V3xh5/eTtYrYPOBElORYfXydA4hDEdKfkITVPBNferDfppgz3C4I=
Received: from MW4PR03CA0146.namprd03.prod.outlook.com (2603:10b6:303:8c::31)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 02:26:54 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::4c) by MW4PR03CA0146.outlook.office365.com
 (2603:10b6:303:8c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Fri,
 15 Aug 2025 02:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:26:53 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:26:50 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <babu.moger@amd.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<rostedt@goodmis.org>, <paulmck@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <thomas.lendacky@amd.com>,
	<yosry.ahmed@linux.dev>, <xin@zytor.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<mario.limonciello@amd.com>, <xin3.li@intel.com>, <perry.yuan@amd.com>,
	<chang.seok.bae@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<eranian@google.com>, <gautham.shenoy@amd.com>
Subject: [PATCH v17 07/33] x86,fs/resctrl: Consolidate monitoring related data from rdt_resource
Date: Thu, 14 Aug 2025 21:25:11 -0500
Message-ID: <c356f03c82e88c3e3c7defd56754544efa1cf75a.1755224735.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755224735.git.babu.moger@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bccb4fa-0cd9-41cd-3722-08dddba332f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kFJEu7FttvEry8xg6vObb3GsuHJAecnhHWSV53MNXBOOm7LBMAI/OfECBwt1?=
 =?us-ascii?Q?defM4shYXPvIslzkyg+sD4gvxbXSwiCN9POu2/3RfuUH4Kp9I08n29tnZhZZ?=
 =?us-ascii?Q?AkBq7AVq606XztNn6akaeb8MLGobTRWlj3JxJqbwS/7Ubx2OrzvwqGVNlMz6?=
 =?us-ascii?Q?LZ0OdhRtor1ZITV/fwpKJSKsZwppgM0VArds5gOBIgo4GLRjLTOKXtPhl2bW?=
 =?us-ascii?Q?LAnO/QiQaFvoa/LG+3LynuTFteZXZuXcoWlLHyCxDkFFBVnWwkGOyXdGjl2f?=
 =?us-ascii?Q?lxj2dL1iy7HJb+vdkcejR2U6q/icJFTgH85r23o35IYifWsAMv19SwmXIssR?=
 =?us-ascii?Q?51SmpNCwmIJCJoVmLirm8Bz2Tq8ONW0O+CICGOFTg3pqLgtMCQ9aFcFt8tB1?=
 =?us-ascii?Q?/gf/R2i8viBXFcRaVItZVJKW/PmUt5xhOZCpL45vX3uTqSq1goAY+QFQNdvs?=
 =?us-ascii?Q?x8tJU5QdmpHVb87lc/+ZfrccW2kx2RltyVCh0y3krUaYcnYDCaOf9t6D+vpe?=
 =?us-ascii?Q?+Y6NhZUn6jzrXRtuedAnlEGM69LrAwyU7iUshEkGx23X4qeuiUMOEkcfJtge?=
 =?us-ascii?Q?jkqjYu2+43Xt79guMlg7nug4qnykmaIcuQl9gZ+ASkqHHJ/5FFCpw5D7NVoZ?=
 =?us-ascii?Q?WQAJFw/OCoEBi5ih+WgXLg/lINoj9PIi3Ichaj/utWdK6W6V9ha+NcQtq289?=
 =?us-ascii?Q?0FsxNvOe49EkiTvgrr3zsYdePYj7JPgNOxVRVoWzw8h4kNXflxCebM8daEgj?=
 =?us-ascii?Q?x+3eM3jgAhTjVhu4t1184a83SJO/5LaRqs1JUsjpxmUHWmk9VF7BVem0Ia7Z?=
 =?us-ascii?Q?0aKo8Jn/t5sy9L3y70g+7Off4JZyDGt3UPEFWfr7dM2ojMabH7TgTBVIyG7I?=
 =?us-ascii?Q?BiPFUkhFGZU/qEBU/doFAiYcf523CvgUuocjhO70LtsSIPhgWcUpZALDXoqc?=
 =?us-ascii?Q?8fYNc4V1talrURCmwSS1nBqnJ3XALM/nKlCjey6UaNpOUrYS40hN0/alPLCB?=
 =?us-ascii?Q?kuQG+oMxYnmoCM9ojpDD1GqwRNbWIYayQhyh7j0m538vg7WopywZaM496G1T?=
 =?us-ascii?Q?sgeCRcbLLuN6fEG4hDfNBA4f3UVuKi7kHsLFhks9WNSc+az0CVrzY8k5PL5k?=
 =?us-ascii?Q?jbt7/LWydbxMwK0zNwsEjue3YYcXUCAuME+Wp4XO0l9WOQJ+/VlPlDy9W1Wh?=
 =?us-ascii?Q?c3DBWWQ5MzIyhQkXBO0RZqXAdl2xnTnoI/pnS4GfhiGvE5MkzC9pQEjVgOJT?=
 =?us-ascii?Q?afKmfsORj3Sz14VcmE8YBpqKXNLLtyS0oLiyDvVka9BnSx4tQ2kM2W3mA+Li?=
 =?us-ascii?Q?xzYF6rvr2Fuyrox/hrEVKgq1/nRk4enI1I4iwwp+5jfWWVAobAAQxx9IEGjN?=
 =?us-ascii?Q?1ZrkzP3UI+Dx7hjYkI58rAODjAhf0dKr8dNMv4QbDfZe1YYeobMpdXtg4bOk?=
 =?us-ascii?Q?zaTzum4pt3C5Rw/RfwwNg+gOGb+RxmQpSYLs7zGOgecssa7frylrM1q1PPmu?=
 =?us-ascii?Q?6yT5BClZWafZT1mxBzDW7BgVSQ32o/oa+PpE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:26:53.6509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bccb4fa-0cd9-41cd-3722-08dddba332f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978

The cache allocation and memory bandwidth allocation feature properties
are consolidated into struct resctrl_cache and struct resctrl_membw
respectively.

In preparation for more monitoring properties that will clobber the
existing resource struct more, re-organize the monitoring specific
properties to also be in a separate structure.

Also switch "bandwidth sources" term to "memory transactions" to use
consistent term within resctrl for related monitoring features.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v17: No changes.

v16: Added the Reviewed-by tag.

v15: Updated changelog.
     Minor update in code comment in resctrl.h.

v14: Updated the code comment in resctrl.h.

v13: Changes due to FS/ARCH restructure.

v12: Fixed the conflicts due to recent changes in rdt_resource data structure.
     Added new mbm_cfg_mask field to resctrl_mon.
     Removed Reviewed-by tag as patch has changed.

v11: No changes.

v10: No changes.

v9: No changes.

v8: Added Reviewed-by from Reinette. No other changes.

v7: Added kernel doc for data structure. Minor text update.

v6: Update commit message and update kernel doc for rdt_resource.

v5: Commit message update.
    Also changes related to data structure updates does to SNC support.

v4: New patch.
---
 arch/x86/kernel/cpu/resctrl/core.c    |  4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c | 10 +++++-----
 fs/resctrl/rdtgroup.c                 |  6 +++---
 include/linux/resctrl.h               | 18 +++++++++++++-----
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b07b12a05886..267e9206a999 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -107,7 +107,7 @@ u32 resctrl_arch_system_num_rmid_idx(void)
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 
 	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
-	return r->num_rmid;
+	return r->mon.num_rmid;
 }
 
 struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
@@ -541,7 +541,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 
 	arch_mon_domain_online(r, d);
 
-	if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
+	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
 		mon_domain_free(hw_dom);
 		return;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f01db2034d08..2558b1bdef8b 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -130,7 +130,7 @@ static int logical_rmid_to_physical_rmid(int cpu, int lrmid)
 	if (snc_nodes_per_l3_cache == 1)
 		return lrmid;
 
-	return lrmid + (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->num_rmid;
+	return lrmid + (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->mon.num_rmid;
 }
 
 static int __rmid_read_phys(u32 prmid, enum resctrl_event_id eventid, u64 *val)
@@ -205,7 +205,7 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *
 			continue;
 		idx = MBM_STATE_IDX(eventid);
 		memset(hw_dom->arch_mbm_states[idx], 0,
-		       sizeof(*hw_dom->arch_mbm_states[0]) * r->num_rmid);
+		       sizeof(*hw_dom->arch_mbm_states[0]) * r->mon.num_rmid);
 	}
 }
 
@@ -344,7 +344,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 
 	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
 	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale / snc_nodes_per_l3_cache;
-	r->num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_l3_cache;
+	r->mon.num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_l3_cache;
 	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
 
 	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
@@ -359,7 +359,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	 *
 	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
 	 */
-	threshold = resctrl_rmid_realloc_limit / r->num_rmid;
+	threshold = resctrl_rmid_realloc_limit / r->mon.num_rmid;
 
 	/*
 	 * Because num_rmid may not be a power of two, round the value
@@ -373,7 +373,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 
 		/* Detect list of bandwidth sources that can be tracked */
 		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
-		r->mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
+		r->mon.mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
 	}
 
 	r->mon_capable = true;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 77336d5e4915..ca0475b75390 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1135,7 +1135,7 @@ static int rdt_num_rmids_show(struct kernfs_open_file *of,
 {
 	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
 
-	seq_printf(seq, "%d\n", r->num_rmid);
+	seq_printf(seq, "%d\n", r->mon.num_rmid);
 
 	return 0;
 }
@@ -1731,9 +1731,9 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 	}
 
 	/* Value from user cannot be more than the supported set of events */
-	if ((val & r->mbm_cfg_mask) != val) {
+	if ((val & r->mon.mbm_cfg_mask) != val) {
 		rdt_last_cmd_printf("Invalid event configuration: max valid mask is 0x%02x\n",
-				    r->mbm_cfg_mask);
+				    r->mon.mbm_cfg_mask);
 		return -EINVAL;
 	}
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 478d7a935ca3..fe2af6cb96d4 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -255,38 +255,46 @@ enum resctrl_schema_fmt {
 	RESCTRL_SCHEMA_RANGE,
 };
 
+/**
+ * struct resctrl_mon - Monitoring related data of a resctrl resource.
+ * @num_rmid:		Number of RMIDs available.
+ * @mbm_cfg_mask:	Memory transactions that can be tracked when bandwidth
+ *			monitoring events can be configured.
+ */
+struct resctrl_mon {
+	int			num_rmid;
+	unsigned int		mbm_cfg_mask;
+};
+
 /**
  * struct rdt_resource - attributes of a resctrl resource
  * @rid:		The index of the resource
  * @alloc_capable:	Is allocation available on this machine
  * @mon_capable:	Is monitor feature available on this machine
- * @num_rmid:		Number of RMIDs available
  * @ctrl_scope:		Scope of this resource for control functions
  * @mon_scope:		Scope of this resource for monitor functions
  * @cache:		Cache allocation related data
  * @membw:		If the component has bandwidth controls, their properties.
+ * @mon:		Monitoring related data.
  * @ctrl_domains:	RCU list of all control domains for this resource
  * @mon_domains:	RCU list of all monitor domains for this resource
  * @name:		Name to use in "schemata" file.
  * @schema_fmt:		Which format string and parser is used for this schema.
- * @mbm_cfg_mask:	Bandwidth sources that can be tracked when bandwidth
- *			monitoring events can be configured.
  * @cdp_capable:	Is the CDP feature available on this resource
  */
 struct rdt_resource {
 	int			rid;
 	bool			alloc_capable;
 	bool			mon_capable;
-	int			num_rmid;
 	enum resctrl_scope	ctrl_scope;
 	enum resctrl_scope	mon_scope;
 	struct resctrl_cache	cache;
 	struct resctrl_membw	membw;
+	struct resctrl_mon	mon;
 	struct list_head	ctrl_domains;
 	struct list_head	mon_domains;
 	char			*name;
 	enum resctrl_schema_fmt	schema_fmt;
-	unsigned int		mbm_cfg_mask;
 	bool			cdp_capable;
 };
 
-- 
2.34.1


