Return-Path: <linux-kernel+bounces-878772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C98C21726
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEB584F0020
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EAB32B9B3;
	Thu, 30 Oct 2025 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eiXL/tc9"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011028.outbound.protection.outlook.com [40.93.194.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A5736839F;
	Thu, 30 Oct 2025 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844580; cv=fail; b=I2Jrm1VlKXUW5w6jRRaCB4YAIJ9pUgalSMJJ/rgrk9TgPCfQ89tWvyNFhDiIhHnMPfpliW2Hhk2cyT/SwYQoqaXtMRkqgH0bueYmRKEQaVtb2Uh6ek7lg5REeqLYw8ixB/waMfq5ItApybc5iZBinRkN2/WFIYiYUyT01cRGCLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844580; c=relaxed/simple;
	bh=hceZeNYB4I6GDFAvFcHwTUG5qSslYLzoeYAQKK+2lbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S114/Ko5CZ+vLeecggKubekoQm9mkCtY8gE9JgyoThFM4R+9a2ScVt9OhPH3CwCB8pHKgGKsVcnqEF2C17cbskeMok+Xn4ctgaTJsq/aqiZ2S3Qxe3YqMf4hbt2cJNUM8GwJEK625ty/fu65E0MMK45yxJzChHsFtA7yDWKnKFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eiXL/tc9; arc=fail smtp.client-ip=40.93.194.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXsx0yy4mfRxN2nCFWPiBJU/EfDVmznuNcINOO6uhNYbpTXwUKeSisw0sm/cxIxcUMOPZfLlU12tbOrGwrrmtYgrsAZRJG0dlCirmncavH7z/HB1YAoAwCKaWv8cOKDncBS20ORrwFVM8drPgpNxlVWyo3EoIdoSfF6WzjpCEPlHujEwhxHZ3ST9PvGNuTcXchxH0ipLwsL/Q92T/FzGp/QwpR9lV3X26Rl7CAXnKzYm8wfma4Nmxl30i1pPanbordrci+tjVmvv1yvjR7jiVFjvo6x/qcLjMJZf1NmoUsbLE+mmx8zShHa0tDS9Nu1rOSLJ7Cpa6T64yA2UlqtQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Olim9tqpWvHYKDaG0eXdDe5rsRQ6r2z/MKr+DOQpO4=;
 b=CCtWhNhqKCn0iqubKRID3g+ziWbIzjyzqbJSk/TwshpQrQysa+0KR68KlaH6s5VeSTySkDV9VjTHso8SnP3lfvsGd5gugVU7wvrAZURk9KTf4L7u7xNEST93Iubp7dKWwIbrXmqG9MZbePMizoOeo8o3rctvR3sOEVSxi0LgqvRiKJSUeB5QeNPBA76ELuYHKHvLho00EL8t+JrN/gV91TLA6M39xS11wzoeYgKErdebIPaW7cnwISyQIKPAzTcHm3vHxsqC7s2lc5g+eEyfYOjvj91YvSQu9zFF7NPJ4sSbxhghPBBMEdXBgTT8BFUaZ+dJx5vkDnDOAzCpxli6lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Olim9tqpWvHYKDaG0eXdDe5rsRQ6r2z/MKr+DOQpO4=;
 b=eiXL/tc9oCq2vVMvQGnHq4mJbxZEZlSCNGtfqXy+x2MWCJPhbnvgiINmHFztlbb2kutESr2H77nwsV80FK0c31x/weP3tdyZpLgAMPs1iaaUHoWwpBUN8TZYgxGClzA7HfnO6WKNTPDqlvU9OHhc9Jz1l9jg4Fak/pVjfn4t+Js=
Received: from MN2PR05CA0002.namprd05.prod.outlook.com (2603:10b6:208:c0::15)
 by SA0PR12MB7478.namprd12.prod.outlook.com (2603:10b6:806:24b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 17:16:15 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::be) by MN2PR05CA0002.outlook.office365.com
 (2603:10b6:208:c0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.5 via Frontend Transport; Thu,
 30 Oct 2025 17:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 17:16:15 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 10:16:13 -0700
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
	<peternewman@google.com>, <feng.tang@linux.alibaba.com>
Subject: [PATCH v11 03/10] x86,fs/resctrl: Detect io_alloc feature
Date: Thu, 30 Oct 2025 12:15:32 -0500
Message-ID: <1f47c6596f9804d1a2ca4907462f6edd1f6e6b42.1761844489.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1761844489.git.babu.moger@amd.com>
References: <cover.1761844489.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SA0PR12MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c4d1b1-73c7-47f0-6ef7-08de17d8082c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zObPxk17OcmZqHlk7wdPqE4dPcnVRZSi1YKlohWaIAtuEhNRPkt/mSEtQNEX?=
 =?us-ascii?Q?ixobuqB/081sEKSJO0vQQ3SGoIvYQwnfEnxqQ7nLkffQ4GP7YPmIgcOw9JdA?=
 =?us-ascii?Q?Jsdh0CXOPMRor/C7hpdIhwlowEcy5aq+pClot/nv6GMChPglkzsmYO7dx5bv?=
 =?us-ascii?Q?7TSIvU9ZEZARs9zCL6jlb/3r1Pf6kvkJ3LS9n0FZcPUUO8zdcnfP93GVXdtF?=
 =?us-ascii?Q?7JT0x5w9ghRgLu24E73p28vxTEnW7qV+Q38HGJcTAiXVu+zWEoIQU2qbOrbU?=
 =?us-ascii?Q?CVyS8BAySxWUnx1xRY/Vf9NvDnrn7oIhuDCzixjMzOiltXb9WUXi2k7xLGTW?=
 =?us-ascii?Q?RsGokfmk3S/4OLrbx88U/wv1DSzRpPOOILTYu5jFeWWCW6XuSznYTw2Ttv+5?=
 =?us-ascii?Q?bgKSljlhmsEyhWoDAyTwP3aBUI00vacmYOKOQQvPPD9pCaeyHfbXjOkzZ5Wo?=
 =?us-ascii?Q?oiLT8Xlxbj7lrZsidThNbZQ5rtxJ9isjklwvs6fx3tXP6/kGr9lhIswa/7HF?=
 =?us-ascii?Q?IM40kPFkDgebhV+Gy3EzYFnWCXmL1oryTuNUs9lKjQzqZZ4x6aU6ksqDdKhi?=
 =?us-ascii?Q?vyo2LMFDQagNRwSXtqiy1XhILHnDGAtuB7LVu5MZnsaw3svDYFbYK+Z7kGpN?=
 =?us-ascii?Q?YmKBdQzJar1Alla9x7rCsueGCcupm4h6BTpoH0sXd3jjt1i6brMMT1PUajLQ?=
 =?us-ascii?Q?oaiTt2/YYECMrdKgjXUVGVj9dKPmg+DAbt7yCZF9QOCF/NGZWT5va+l1Y3mS?=
 =?us-ascii?Q?yqvNmYHZ+B2GuCG/xxErMVddb3DpNp75GuubUmyNhyG2K2wv9sWys3X5AiYm?=
 =?us-ascii?Q?o1+zSbLXFbXo4/M0eIPbwFCBgw/zFqTZDjghRj+0xUxEctw0CkznmVj2Y59k?=
 =?us-ascii?Q?CetvnY4Y/RrDFcHB+zYUE4vWa2Gq09TGYGoQFC53fo8ZGmwNrPVhBCbcoK9U?=
 =?us-ascii?Q?rds/7QTku0ZoFM5V6sgAnHop6gWCE2eqGfic88DFSGDa0sDXlaCRPfHThKxr?=
 =?us-ascii?Q?jJRQb3Y3tZUvchIPrY1cD4K70MG4BR/dlHbFdVNUI75CIKzChrGsa/aChteT?=
 =?us-ascii?Q?36njfNkZZqOQSKS/wMDd6GBYkjuMx1ORXDRfFcNbrtPbBRyzAg7I6+jAcRT5?=
 =?us-ascii?Q?7KEw0SJ0AG8QNRHS5Kf9KdPeVD5Q+bfC3s4+VOlFeOHoqV3Z7KBEIPwsX6Zg?=
 =?us-ascii?Q?BFn2q+jdqHFo/cOO5JE07VkCm0DO0eDPfeiYtTzCspd9MdfEfGzTi5oOfSTZ?=
 =?us-ascii?Q?rGPu9k5DL5VfzjjK3yhn6J3uLowVBCb4oIiZ0P+BM7EU7F2ZdqMrsGQDWJOe?=
 =?us-ascii?Q?RQMLFE0BwbvIjQW7HBucnanyiyBupWlWRTV9QeWj7IjJK85pSJzD0c9lgVIm?=
 =?us-ascii?Q?GisHwMRkc+1dE3Ku0Xgyp1T/fwwaXp/zTY94QQCIOUIU+vHQAKe0mFi0qOyy?=
 =?us-ascii?Q?w31KHqIDeD9l/ecK9rAKGreLHxYvM7XSJvea9kmg+Rg+lXGPG85B/59AyHSb?=
 =?us-ascii?Q?sKOJGACZw4nIGeVRFX/MkoWFGKTECMXe5pfUleGm+VDxr1KPT4SVs4sUAtf3?=
 =?us-ascii?Q?p3nZ6so2k09F7W1wwhc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:16:15.0255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c4d1b1-73c7-47f0-6ef7-08de17d8082c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7478

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
v11: No changes.

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


