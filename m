Return-Path: <linux-kernel+bounces-863884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD91BF9688
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C94584C58
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1679E2DECAA;
	Tue, 21 Oct 2025 23:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3iPObukC"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3B92DF122;
	Tue, 21 Oct 2025 23:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090950; cv=fail; b=T4J8TT06AB7Wf401gwlMSP9mPU19u2SZmGThjHxbirHKyEUKLSDM2yO36DmFaK0DsRNpClHJtOKmocaH/MTtKGcNYFlEDjU9vuOVJD3AHmex8ZY0Gp+uR7axRe+gTApP5lCS4hXAu59N+BU+uT1gexwYZLGNT4bwZp/p3TAcOZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090950; c=relaxed/simple;
	bh=mea6nx2u8kkMtkSSjnKY5OOIAHpFG76HeddVaODv51o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGGsE43NuYjXOIFAXTHWsEH+AmtoCCdS0FONgm9NpopkCupw1KvsROXAr5J2hYTzSY/r9VoA3hHhxwQZLEQWPTjivW1mjpWDUjpASod1urMRFADz0vRvwB/4ODc38E+Od4BMpRse7eODRMY2gnmsDWPYrnXVDHx60OeKfGpR9JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3iPObukC; arc=fail smtp.client-ip=52.101.46.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2SwG7pmxjLrPvSVC2K5+aE0Y3+NM9loWg4u3ZX8FFxdsi5R88SFanBvH6QLTA4i9c/VeEZuXM2pbfRPxzMR6RUros6m+sRyv0S+r6wbONEiHTqrOGm1usMRMxl2LU9P9LMvwFVauiGSi3StARYpiYLzOi+jlQWxUz3YqVCMp8TpCDy5F/u2+C7QYTtU/yliZemPMViE+U5dMxOYLfxhcLi6wIE9+tMH/X7tGCElJXNBI3IX58FvSMuk8hLDntzt59KJVAxzwD4T+IY/YZLF+2qFKQPsvwCbeKcU/lBLrX5V8pR8aE92GpEg+xuR9h6DGj63C02lsOp1tmz2yTfbQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTwl6OU+7/3d/kpJW3oUkMAUx4hkIUrgUS2kvPykZok=;
 b=e5diIO0JR6eUhGIUNo/kOaQDMxF27ywGSryKZ0avlyKpUXQcLaYnoPpGlV4rwBlD3OByZQ/7ar9wgbKK+Wnb+MygK0iG6jaGuytZ+U//vbDATg4J3AbbYyvpTO0nzWojJWQL1gyQKQktl7J1dIQdq7sWUic8mzl5W7it8Bx5V0NVMLztempALFABBK66ENKfEqN7W5dOcDuTfRFlDDreuCRV6ZmGSWj92HjnauPX4jDGkluA9j18UzCjdW+e067hroFgctu6kluxrS7W/q8V5v/so2XUjpq+ZltNelL1hycn/H5Fh96m1GYEKloo/ynSYa4vgFGhzGVtpVAARze06Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTwl6OU+7/3d/kpJW3oUkMAUx4hkIUrgUS2kvPykZok=;
 b=3iPObukCACk7+xYifVtHeUMEIrmeUBOqOiBcaWDDQeopeONKLy4qvhDxGm+lal9c+euhTmufvkL65Ol7MlmmFrSlbkwgOf7O6ZAw4emjSGGtN1a95yO9ahniyETQm3jLSIvf3bVHDEFWRGr0fBOraORAg4xDnRmr8c9Gk2kW3KI=
Received: from BN0PR04CA0134.namprd04.prod.outlook.com (2603:10b6:408:ed::19)
 by CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 23:55:45 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::25) by BN0PR04CA0134.outlook.office365.com
 (2603:10b6:408:ed::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Tue,
 21 Oct 2025 23:55:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Tue, 21 Oct 2025 23:55:44 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Oct
 2025 16:55:42 -0700
From: Babu Moger <babu.moger@amd.com>
To: <tony.luck@intel.com>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <corbet@lwn.net>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<babu.moger@amd.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rdunlap@infradead.org>,
	<pmladek@suse.com>, <kees@kernel.org>, <arnd@arndb.de>, <fvdl@google.com>,
	<seanjc@google.com>, <pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<thomas.lendacky@amd.com>, <sohil.mehta@intel.com>, <jarkko@kernel.org>,
	<chang.seok.bae@intel.com>, <ebiggers@google.com>,
	<elena.reshetova@intel.com>, <ak@linux.intel.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>
Subject: [PATCH v10 03/10] x86,fs/resctrl: Detect io_alloc feature
Date: Tue, 21 Oct 2025 18:54:46 -0500
Message-ID: <1dfef99de948815922da59185f3693b944db9f6f.1761090860.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1761090859.git.babu.moger@amd.com>
References: <cover.1761090859.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|CY3PR12MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3187b4-7096-41b2-1389-08de10fd5995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M9fikORHiCvapacgig1DbpH0CwDIorqn0MBykbtFS9vE34iy9ZKrF880qDVa?=
 =?us-ascii?Q?64Zq82wXxXQ7Es6HzSqYK8Wlc1UuwLBNH6UgarbfCNxD408qQoAbBtyPqZzr?=
 =?us-ascii?Q?sDNoVjMfzrUpi2ppZOMEzdJ06HRUB9DIaA0k5dXWuaZjWYmuMWarvh5Fz6Do?=
 =?us-ascii?Q?jQ/OeQCD+L+2vMMPNdo9fy8HK1IkEY7bmRs9oKhofY7YNpQMSiooUpfmEd60?=
 =?us-ascii?Q?brfaTqKgEeQJE2izGgD7kx9cCQaGNY5BOTv4yAcQ2a2Bv4qAZprl2Sc2dv5O?=
 =?us-ascii?Q?3o8joXbFpY1n03D10A0zLmubm/3lLHCTiFnlueonRgzql2cqzwUaUHKgyzh+?=
 =?us-ascii?Q?RdZb8j5gWsuDfBelTNztiiTaLkk50VSna3FTqzma131YA3fnJ8zkTzhVVKPm?=
 =?us-ascii?Q?DcQpaTBcJ7o9heUPuEGusMn52WCibTymw84/GfvAJBKl9PRNhocwEVZPX3+1?=
 =?us-ascii?Q?Se4dmm8zyNZWPlgM7kVkKjDkkhq7ZtbGrlZXgbjTT0ej64sbzH+gyJKLwQ/1?=
 =?us-ascii?Q?n9TdLt4VAij7yh9qmp5EFfMAXRHU7NkVZKakVDuw8Hi5V0yzuUT7cd3vXkb8?=
 =?us-ascii?Q?lD8iF34gEovKHqUHi+3wBBZSE/YA2agls3gxrnt+GvOTcw++Fiq2O5nMVgsd?=
 =?us-ascii?Q?uBezCgVlZmBJXiSLWZ8Pv8HseKdjaSMjrXvcsA9HUdYwVT+jaDbpmTfdvW+0?=
 =?us-ascii?Q?gBHKNl1bx3i9alf/1Hnb/teKu1qBVYQVtlQdw7SCHOIU7PpO/pPo/H6NzEM6?=
 =?us-ascii?Q?f5CTbGCUo6i3DS/sQC/Olg7yoodTlh6bTPTT1RGKWBw7nedOc/S3SFeAMw0t?=
 =?us-ascii?Q?HoQ2b2VV8NF4RaudHCEmXDijEUZHX+BlxxouJBIFuMw0GgvUJyJUmvoE2nvu?=
 =?us-ascii?Q?XcaFVMwP21+vnqfFgDwdxbSd6tV8ZrqAmnO4bfZdSQvGDrzRM0cfMDpaYoQH?=
 =?us-ascii?Q?lFt8pdiEoRY0DoY/tLSDgUyDj9FREILBCBEANGaa+42m7nVfJ8yVSalRLsZA?=
 =?us-ascii?Q?x8uXT+6uz5NBcTuqWI6neJzYcMD4tdotPQgp6lDbr9iyX0SGYj8BCvop8nYh?=
 =?us-ascii?Q?Rzz2qO475rJdhyNiBbF/8BqBjXpJXtTrk9ZIS9DtC8vWBnxdAAkSNITV0fs1?=
 =?us-ascii?Q?HpdtkZaviamdNBt0M0YWddz95b6hb2UYmjQ5Ux9CFajSOzVjklNW/JI2NVdK?=
 =?us-ascii?Q?ixpmoEqAh+Mq5kI4bjet2f1M26Q3tavtNpGK8wQP6tVe2aDWh1smLyee5dGo?=
 =?us-ascii?Q?Ey3BgDyKU7mvCPrbuIL2T5bG4dO8CBV0yCUp3mQYK2MkJ8dXAgj8juhm+52v?=
 =?us-ascii?Q?LBvpMD9MN2NIB8YYWHD7KE7NhTCoy+RpFvYfqVe5zCvgygOk99kj2LiojoH1?=
 =?us-ascii?Q?gwUQZYW0YDHYXKfJXUKkUQqXydcJT1NivpkH7jN+XBxzw6gOdtwjeuwscbnA?=
 =?us-ascii?Q?G8bjQXCqnUwfTp+vOsiIMkmELAlJbZOx37pjHnFiSQ6hNpd9GpkxpNhdmxi0?=
 =?us-ascii?Q?dtcNgMQxo+sSE5ivBL4AKH2aiVQwHjUtMX+cviyuFzm3IvbrBkSUhAyIC7FE?=
 =?us-ascii?Q?vn722dh+pqy5TsGwbAo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 23:55:44.8479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3187b4-7096-41b2-1389-08de10fd5995
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9630

AMD's SDCIAE (SDCI Allocation Enforcement) PQE feature enables system software
to control the portions of L3 cache used for direct insertion of data from I/O
devices into the L3 cache.

Introduce a generic resctrl cache resource property "io_alloc_capable" as the
first part of the new "io_alloc" resctrl feature that will support AMD's
SDCIAE. Any architecture can set a cache resource as "io_alloc_capable" if a
portion of the cache can be allocated for I/O traffic.

Set the "io_alloc_capable" property for the L3 cache resource on x86 (AMD)
systems that support SDCIAE.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v10: Updated the changelog.

v9: No changes.

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
index 2b2935b3df8d..3792ab4819dc 100644
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
@@ -855,6 +860,8 @@ static __init bool get_rdt_alloc_resources(void)
 		rdt_get_cache_alloc_cfg(1, r);
 		if (rdt_cpu_has(X86_FEATURE_CDP_L3))
 			rdt_get_cdp_l3_config();
+		if (rdt_cpu_has(X86_FEATURE_SDCIAE))
+			rdt_set_io_alloc_capable(r);
 		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CAT_L2)) {
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index a7d92718b653..533f240dbe21 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -206,6 +206,8 @@ struct rdt_mon_domain {
  * @arch_has_sparse_bitmasks:	True if a bitmask like f00f is valid.
  * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache
  *				level has CPU scope.
+ * @io_alloc_capable:	True if portion of the cache can be configured
+ *			for I/O traffic.
  */
 struct resctrl_cache {
 	unsigned int	cbm_len;
@@ -213,6 +215,7 @@ struct resctrl_cache {
 	unsigned int	shareable_bits;
 	bool		arch_has_sparse_bitmasks;
 	bool		arch_has_per_cpu_cfg;
+	bool		io_alloc_capable;
 };
 
 /**
-- 
2.34.1


