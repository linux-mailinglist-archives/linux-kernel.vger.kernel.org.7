Return-Path: <linux-kernel+bounces-726220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF08B009B3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD4A5A229F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3964A3C;
	Thu, 10 Jul 2025 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XPJV8V/4"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E755E274B2A;
	Thu, 10 Jul 2025 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167823; cv=fail; b=A6M7CUZnW/ffloqbPRtFiW3229uS//blBaUmGdSaUzxKveFYMXTA1UVZuq4fvzdbjQ7u4W4X97BgbxLxWgTkO0hIKVI8gcDaMUki7D2f1XcJ7zZTI31LbSZ5YDPA3gzeYc9d2Sic1YOlInUBhZNiD2kH8CbhgjbqN+XqJrgt1EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167823; c=relaxed/simple;
	bh=SWJ7SVjPYEsR8uN2PivcKTONHMwGGUJCqOSqEigbZtc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjkK2NBjaTAefB/UmTIpkj6Imi8NIMejK/J4lfbC0hp1greYa0GHZTmjAZ8NcW+LWlOZCDzFoqllJIAGT/cxyjjrM+qpouWD5yJtJh9G540hEg45+tq15Jp73JOZ3cgHTnHBRc08lgEed8FO4vTWDz6grOJg1pGpFv/6ggFylZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XPJV8V/4; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cz1YHU42ubs2ySUHwHj54CkUZcICtEGyBpUo3vk+4JThYVcua0DPI0bKUXd83mY4KjPW8LLjZ7KWnYNmybty4kz4hfI3J5CkW+nvivDvB+s5itl+LGptv+ZVbT5v+qpz97WCo0KwofvbeQLC66vlrdfrHvJM3bi0OgNuShQ+PLaTQBGfY3qBORO4RDhr0JGTwyYWxGXADOJ5LlvHy0QszXIkWlXK8+cLPR41gt2fT076nUEvNkvPiURUdRT5m9C/GC/HaPX4dAnGopsI/WJI79FFvsjagM/evKMaT3J2B63IJMn51ciKHLYqepA1l8uWPTqPjpG4v05nhp4TDwFlfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlj6z9xppHdazIjOylpjfqmKb6BtZs9xxp2akWYx2sQ=;
 b=RE4LfrfkztBQtDEom+tf9GulkFw6E4EUhKrP3gLo5BT2nHyHFNciPaAJcpCBstjBLvXlbdE6k1p4iumSGXFNzxXPY1fhCzxn14nJts+/oM08iOA48yn+MTPi+4aAvRuSrKmher7qqDSczZKgWbNpLiTWoQfxr/hWySejHTT7RjcreLyEGRUF41BIM0uh/W0V4T5EgPn2xeP0V3w638B2erioArxnO+NgUgV9qzFoe76mhJMHpQZdVogRs3k2ZDoj/rPGOG5+qz84GbzSZr7sUL3h4NM/quHQwboldfO2Ute4jR2kRR1IuFuB0TX4q20eXctgVjVF6/hi+Y957hGxdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlj6z9xppHdazIjOylpjfqmKb6BtZs9xxp2akWYx2sQ=;
 b=XPJV8V/46odMJND/h0MGGryD8UlA4+aKoR5ciIRlgTUb9Vzmb1U4QZZ3MHFprtAXgBY6ubkqqg1x8w+GRZF31mRvFV0rSZKIquR6aNd7BhYzczSo6/OQXML/uNKYLbNyfGRFCDPOtd7zDzZ5Y4H6p8Tpd2LUn9piMEQ4CI4VkcE=
Received: from MW4PR04CA0206.namprd04.prod.outlook.com (2603:10b6:303:86::31)
 by LV9PR12MB9806.namprd12.prod.outlook.com (2603:10b6:408:2ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 17:16:59 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::d5) by MW4PR04CA0206.outlook.office365.com
 (2603:10b6:303:86::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 17:16:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 17:16:59 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 12:16:56 -0500
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
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 03/10] x86,fs/resctrl: Detect io_alloc feature
Date: Thu, 10 Jul 2025 12:16:17 -0500
Message-ID: <998f42d5c92cce9d7d83bcd54d25761242839b4a.1752167718.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1752167718.git.babu.moger@amd.com>
References: <cover.1752167718.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|LV9PR12MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8ccb06-163b-4e50-ee7e-08ddbfd5944e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vV40I+TDepr15nAPCsPhzJXGxBAUQEjE/zWt4/9QLp52ZBk5vtBzlBLmWZyx?=
 =?us-ascii?Q?l6IH5vY88CwzJX2qVfLT0DiVl7m+QGlbvjKeU2AdrF9gMQ1xoTReHzVXQD6+?=
 =?us-ascii?Q?LPbumRjmlF5f/KLRKecZT7FZmVaKs6E5AczSU77rSGnEMDyn39AUQoHriGWw?=
 =?us-ascii?Q?VL3RmwsLakfJxCvXeD3E3UWMcdoyPeC3KOeaCZX1QD4CqUqQidzTUoiLoD07?=
 =?us-ascii?Q?jVl+0DS5c35X6+HqLlmWYW0K+KM99o6K+/yvSffLzsSJetx7Vnf0TsKNTUkF?=
 =?us-ascii?Q?A18C70GrXRr+HBzQGZo67g1/PCa7yq0ITH5J2/aWdGSfM7iG1DYcD9pFC6lG?=
 =?us-ascii?Q?rPYp9qcOqu9O4BYFvynFBUOQW5cihe3Q46rSLbD3gilQYTVJeByxnD16A6RQ?=
 =?us-ascii?Q?oUM/kZfDPCCYyWFEGnyo7ktwLau/tY4XyyhiYp0soSKDQTSVNBVSq2VsnnYg?=
 =?us-ascii?Q?MS3n/Y2njydDyBukOEiDxuCWh2++hDZAaDEVcSOo5LfGjALRlUieoUyRPN5W?=
 =?us-ascii?Q?wRLFiHpPzAFRMAOFydiJtcYxLhpiIacXjRrblFHefHXNtt5/kclbg06F+PHd?=
 =?us-ascii?Q?53oWgPPAtAqXoCpuFSxbc7X0FbVGmWyBtChUOHhBd2bH+G7tonvlfvc4yHrj?=
 =?us-ascii?Q?npMMYBY/zg2IqsQzRUjVRnNYvPbr/m7wFeP+7uRXFUNP0G/KiYalKzCSlZsU?=
 =?us-ascii?Q?eqW6Vkf5gtxoHInXbVCPgeRIaNE3sesx09+KHqMHPKLgUwEEQjkOteLJP5Q7?=
 =?us-ascii?Q?DEvtA2Xg1ip5UvY72Alc9WjCzkb6dBC7AXInRUeh8WH1xfgjlV8eBspfRKjC?=
 =?us-ascii?Q?U6L8zUcSyb2Ik2A4eJIepECFYIUqTxiVu2c2wpK9qf0POKeT+cDaaiRtclXc?=
 =?us-ascii?Q?xippVqrRftTeoqI7DGYMbdtFrwPM4CQgro5vnMBWF3Sqflu7Ou+MadPWi5ub?=
 =?us-ascii?Q?dnalAf7aZOE+N9pMdadNf/gGJz4XVvb4QMN39li2ywBSELYBqoB5GCBfskX9?=
 =?us-ascii?Q?IWMAC6RLamNLk6aikIF+jy4yA+U9tMpg/ffJ6IeyOoXK+hLNoFXRK95FukzJ?=
 =?us-ascii?Q?yIB/oRSbW5v3VgxYXHRwWr6f4r6It/+mzH6c0vEe0/H07LzoY4QnAp6d+7sG?=
 =?us-ascii?Q?CF5TeyEmpnUYIP9zWMnVu7bv0bPQqXs7B2S4DcmfZRYcrnRcPsic5/AdSZ9u?=
 =?us-ascii?Q?UnPdVAM/SYIhu/6cXiOpWfl/hKA4GyP45R//xANRbDL0cqa/LlN3QOlNQiY5?=
 =?us-ascii?Q?F9fAh/O8hUonLb2Ktb2FQtc4AsCyRlTeGiJ4YdGJFTKeoc8tyuvP2hjXxF8F?=
 =?us-ascii?Q?R4up3Gj22QL3WsT3dicb5td20M6Hi6M8iU0yCiCm8H2VhxHzbY3LxuY1/eZk?=
 =?us-ascii?Q?LuQqbO5AcSoTf2dd2gwrSLyz/yJipKcJhcDFNGeoBOnF14Q8vNKUYbpfgkwo?=
 =?us-ascii?Q?Ap5zW0oSEMKUpejskFHU3GaD0FiC+7z0SYIOF7PhHuU8CxoD4OmoV5kh7bMc?=
 =?us-ascii?Q?mxkDZZcRe3GMb0Fnp77KhWPv6J/6lZPY5F77?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:16:59.2323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8ccb06-163b-4e50-ee7e-08ddbfd5944e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9806

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
---
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


