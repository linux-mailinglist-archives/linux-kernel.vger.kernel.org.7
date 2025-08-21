Return-Path: <linux-kernel+bounces-778989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287CAB2ED8A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEFD563BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CA428C011;
	Thu, 21 Aug 2025 05:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f9qqJV7/"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2149252910
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755753620; cv=fail; b=hV04Ng/y13GxL25b6abCAHKB01VDsCQCdnxTzd8x3ie6qP0mkBhdMUo7uf8pZ3v01V/+tOOVD8vB+nKB489jGLrna019Zs/t5i1MufOWheo2Gbp0LPvfZ9/xsyN4mJkOgadAkS8Z6FwzBeQCcOa6y2a87P6C5HvSjNoGbSwPoEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755753620; c=relaxed/simple;
	bh=xgIqo97F6wbY54hZrrA1FW0KcV6Xjm3+Yo8zgnWUR9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iparx0gZPRM+tW7cp7Gt4Ha4MVQC/Ten6YlykRqW/Q2ZtYFD5V3EockDuR48tI74oSmetHsGy11eAk/8t3K2BdGLPFazeLGt1VRbI66fMSa5dBuLjkAHZc5t9O7TzTTdosS7LrrX9eey18n2fglVjg0X11t7dhfa6ROMgPCZ09w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f9qqJV7/; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILaJYL4MZRuBHDd7aONzVijzezWqHAKvO3AbgIcAvuC8WMovkqqgRcduadZzKPW09WSYpoC5EtIapqL+FojFMRWqvqgHtwVZ/GDq2HZ5yc6hkkuWcQ7VQZDwuOgt2FrrFcb8zoQalYzMC2JyhAOfTnaIRvJj76X13Bxr0C43dP8NPRKQnmNZB7v2cPVvDDceuLdfvhcTeQ578dOQGXqsrspdgLGRVJ+mZ4uYanXArEwDsCrvO7aO8Sf2sG2dk3td7H8bFon9EJrlvd/y/N7UMsa39QE/rNh5dnf2yx7AA21MwnQfqQfmWx8cENZ8Omyh70fO1gsSKm8MY1URUueQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NBGag++oN3VbwzJ62i1lVOv6gCNJtzLlwmfqrVjo/E=;
 b=Ju5BCHwuZ5h7AwtjDInK+wF5byQyzLd7LRJNxwiXxlwC2JeT/2brNCes2U4GQe5xQVD04zvOpUEXQ10HumzP0zn9gFKbjHlt77P5f2VuBHAN1SBPCokjulxsMml6x1A2YYBO/uVHKhZnjs/QtwfID4ZcbijK2uq7+GlcxEUOPu4QyV67iJ18zILHg+5gxl10qJG+5jm9IgVqLh4Snv7ICXpy1aztoBjZnytwcDfcbNJmpMgVu0VHUkqNBxpCGZD4u1bwzQs+a8qXpzyAXO1fmQgG3lUwY08j2gT1APkWdpzU+f5L3tbga0U1XpLaBQaENugAFYs3P6k4A8GNH4H0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NBGag++oN3VbwzJ62i1lVOv6gCNJtzLlwmfqrVjo/E=;
 b=f9qqJV7/0kUeE1iL1QDud0WzKtKq7/8fwQ1zlv0cR5/6oFgpWV6BT2tCdZA3D2aMQlvQSfeymJBwyJTaUfazbY31wEad02zoM7V26mBVGJt3mRECjd8MKFJEEffQFkzYBYVcW/7HO3HLhwt3OMBbW362z12KkSt/Hf1zcmjhuZU=
Received: from BYAPR01CA0022.prod.exchangelabs.com (2603:10b6:a02:80::35) by
 CH8PR12MB9838.namprd12.prod.outlook.com (2603:10b6:610:270::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.15; Thu, 21 Aug 2025 05:20:13 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:a02:80:cafe::e5) by BYAPR01CA0022.outlook.office365.com
 (2603:10b6:a02:80::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Thu,
 21 Aug 2025 05:20:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Thu, 21 Aug 2025 05:20:12 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 00:20:07 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, "Ahmed S. Darwish"
	<darwi@linutronix.de>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 2/2] x86/cpu/cacheinfo: Simplify cacheinfo_amd_init_llc_id() using _cpuid4_info
Date: Thu, 21 Aug 2025 05:19:10 +0000
Message-ID: <20250821051910.7351-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821051910.7351-1-kprateek.nayak@amd.com>
References: <20250821051910.7351-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|CH8PR12MB9838:EE_
X-MS-Office365-Filtering-Correlation-Id: 83aed064-bfb1-4f3a-bf8c-08dde07267a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8a+FeRYwSiDojuXjwfYWsufTZtsriwbdeNj6JrtccH8JFbl2dZSu4QgSuVp0?=
 =?us-ascii?Q?JwedN3ca91NNmU+7QJTxkEAa+9CDq5FM5kQEzo+qE6MqY3XgObWPjFAxzI5Z?=
 =?us-ascii?Q?K7uAjO4sjPflc1adhLmA11axyiMZJ3WrnkPEV3D2gmJL3cxBAw43wZ/XwEDD?=
 =?us-ascii?Q?p8ysa6ps3wa80KzqvntWWSxRzbE01OwLanYBOOJxgub9H9N5f/plt3Oi/LA7?=
 =?us-ascii?Q?loS3OyqbWVW3+sPrVXo0LeN5CXgNokTfOGXKvBjPkZIqCTIfO/2qSjx3Sh7W?=
 =?us-ascii?Q?cJ60JdjTw44PcFYXh+7kAA1EtXtRYvQxZaySKbukBl/Q77psC27XR9C+1fXI?=
 =?us-ascii?Q?Sr3xs6R3kdk/A5Vu6xYaWqnoOIzMS5+KL5jJRi59HrpOabw7XlRYQjPmzHfj?=
 =?us-ascii?Q?fIWkRSuTDkICt614JnzsqvAbf4IE+2Sze+F/R0pvt0mFGp8ckEK8ZrVpraAl?=
 =?us-ascii?Q?YwVf4KHEhum/hbSr081/L2bN0rt9PjWFrXTpLGiY06Kj22z/Ly4bM7IiK5dq?=
 =?us-ascii?Q?nSCVaBmuv5YSCxwBeTvr+5V2F+MPPSeGYVgHVzzAEdIG1uob15PlrJnUqNrA?=
 =?us-ascii?Q?3N81xSPcWyZUP0fHNWQpquxoT+gyEf1x9D5zIsKTq6ulnAPmilRJZNmXDJJt?=
 =?us-ascii?Q?7KI+3uXgsAVi3oF19pyKz+tYncC8bWesU5WmEQJEgbH3a55eTrmGspaEfrsn?=
 =?us-ascii?Q?ukJVgd3taYkGW5IPDsqRey4aC9diWzsYtSKhz/0QcrzcDMNTbZ1RFCHAfNyO?=
 =?us-ascii?Q?A7G0OgyoIbB9428wl8TqnpfiownEi2ZrkNHYnaMUcEXGuX78Xz5ezUQE7MRF?=
 =?us-ascii?Q?x7x2sfyqi854XAVeA9lr0uLfi0wYRvjJ+mfKC0oxxx00AzpAhRv8bPlI8zJR?=
 =?us-ascii?Q?FVOcVabYcu/VE1ACWFheDcgsZhnyOd5mZIwtjSJrtbVhpTIi4Ofn55Qk8Bd1?=
 =?us-ascii?Q?bBoK27La2xWsorO3Dn/izT13UBaeawtSrn1Zl30DTMKoi4uWN0/KBg8HhSO4?=
 =?us-ascii?Q?qthRZCSD13+NFapFdGnQu3W+9payLKYdVVP8YoiMew294CYZh2q23vh2LibW?=
 =?us-ascii?Q?OyLHoPtvFcJ8DzHW3zB/7ZlDodGO6xOUv1f9I6OD6XAxwDDR0k6jbjfK0O+y?=
 =?us-ascii?Q?tLxEknQm5oFjPHuktuv8o9elIavBt8IpZoseIAM4LecInTly0yUMifeIIo5i?=
 =?us-ascii?Q?D3FsvhyHShbx2G0HuO4nHrrvlHpLkAlwi8HVJdB4v97WIVSNCZvcJbjSG4S5?=
 =?us-ascii?Q?nhVUnWNrmr5CLb9JY+U51x/+qp5skTFISXHnpS67M5pSjx/QUuv3EtGoGxYS?=
 =?us-ascii?Q?GB3h6onioq3WrDYAsa9y3R3Lahrl+4Lm51RS9hGjOassl/gbD/qn6uO9I5ip?=
 =?us-ascii?Q?sP/v8matxgf0SeiHKd0FG7YF8+jDpQqaUWTpEw5VmWm0suS5hm3jyPmvMbY4?=
 =?us-ascii?Q?Ql8ZL+of/SrqPEk4Oz8ZhGrc3wE+5QXAlMmeeAqrt878JkPN3Bo+WKXglEsh?=
 =?us-ascii?Q?0H2/7dhZvDVJS20zs+wE3y4Jb7MA1gn7afAt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 05:20:12.5202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83aed064-bfb1-4f3a-bf8c-08dde07267a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9838

"_cpuid4_info" struct has the same layout as the CPUID leaf 0x8000001d.
Use the encoded definition and amd_fill_cpuid4_info(), get_cache_id()
helpers instead of open coding masks and shifts to calculate the llc_id.

cacheinfo_amd_init_llc_id() is only called on AMD systems that support
X86_FEATURE_TOPOEXT and amd_fill_cpuid4_info() uses the information from
CPUID leaf 0x8000001d on all these systems which is consistent with the
current open coded implementation.

No functional changes intended.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/x86/kernel/cpu/cacheinfo.c | 44 ++++++++++++++-------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index e7b10a612c6f..f4fbca6030ad 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -289,6 +289,21 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 	return i;
 }
 
+/*
+ * The max shared threads number comes from CPUID(0x4) EAX[25-14] with input
+ * ECX as cache index. Then right shift apicid by the number's order to get
+ * cache id for this cache node.
+ */
+static unsigned int get_cache_id(u32 apicid, struct _cpuid4_info *id4)
+{
+	unsigned long num_threads_sharing;
+	int index_msb;
+
+	num_threads_sharing = 1 + id4->eax.split.num_threads_sharing;
+	index_msb = get_count_order(num_threads_sharing);
+	return apicid >> index_msb;
+}
+
 /*
  * AMD/Hygon CPUs may have multiple LLCs if L3 caches exist.
  */
@@ -312,18 +327,11 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id)
 		 * Newer families: LLC ID is calculated from the number
 		 * of threads sharing the L3 cache.
 		 */
-		u32 eax, ebx, ecx, edx, num_sharing_cache = 0;
 		u32 llc_index = find_num_cache_leaves(c) - 1;
+		struct _cpuid4_info id4 = {};
 
-		cpuid_count(0x8000001d, llc_index, &eax, &ebx, &ecx, &edx);
-		if (eax)
-			num_sharing_cache = ((eax >> 14) & 0xfff) + 1;
-
-		if (num_sharing_cache) {
-			int index_msb = get_count_order(num_sharing_cache);
-
-			c->topo.llc_id = c->topo.apicid >> index_msb;
-		}
+		if (!amd_fill_cpuid4_info(llc_index, &id4))
+			c->topo.llc_id = get_cache_id(c->topo.apicid, &id4);
 	}
 }
 
@@ -598,22 +606,6 @@ int init_cache_level(unsigned int cpu)
 	return 0;
 }
 
-/*
- * The max shared threads number comes from CPUID(0x4) EAX[25-14] with input
- * ECX as cache index. Then right shift apicid by the number's order to get
- * cache id for this cache node.
- */
-static unsigned int get_cache_id(u32 apicid, struct _cpuid4_info *id4)
-{
-	unsigned long num_threads_sharing;
-	int index_msb;
-
-	num_threads_sharing = 1 + id4->eax.split.num_threads_sharing;
-	index_msb = get_count_order(num_threads_sharing);
-
-	return apicid >> index_msb;
-}
-
 int populate_cache_leaves(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-- 
2.34.1


