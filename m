Return-Path: <linux-kernel+bounces-778988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 909D5B2ED8B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010E63A8631
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE76028C011;
	Thu, 21 Aug 2025 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aO1lalnG"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADBC270572
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755753607; cv=fail; b=WEXhO/nQBOCESiN7CkkDHo8WKVPcAoXnULFYIPhqsSc+X28B8Dvv/fG1HtpPFDquDhIQbC3mgYnhLGcqazefcac7Xh1axyBa9dYOLVyYiT5vGZti0Mmho734jsB441XuNeqeH9WBh1AVACvjnoEtoOeVxAl6Dl+gV/zlDAKmJjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755753607; c=relaxed/simple;
	bh=TeYyjtQeo7TGetHkig2nUBEIDSwvlvTJXwevAS2IHrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=giCWF6DtNMzNeO9GPSnQNdcvGciudDxHZCkbmh1snilKLMpbZhQyyT6U3RkVGZ5X/7cJpderUME+dm4f4gh4Iwxz/Wa1vq2lcfTVweoasnbHGuGEiy16dcm+lvYGyrPCKz6pXfROB5raMeVcXBGVAXGha+xyxKHN4McSs3biWFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aO1lalnG; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRbvo8LeuWYc+RiEEzab/usqeY2Exu0G9ngYDZ3ilB017XoWCwe/BXRZh2/R80kNvdcEVFalycSJykyoCy6DdM8kvis8Fa7KYakWIwEX9lqqXO+XAkggwdRKao5Oiz8pt27EOrj45nfgAbz61hjwfT55FWgaxP6p4JT/6f+5yY80027I6gF+sPREoz5xAnAohL3eMIGJlym4opEp+ltLBezNWXKbyohEvcBx7Q/gJNJNKABsBPaZfHVdN1Y4eW4z2+rsenuxZQ99sLiUgAzxUunBb5lBX+KZTC83YYlrjrJ6OqGWVS8TjIUewHk+uVEYXSEUPdoSMaDL9SmvbaO6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVdBTGyTrMz7EtcVe4YjLJLJ5qxDc+Yyj923KuDE0ig=;
 b=Uq+eGCEiRXEucEa8fRdovf3hu6j8fKL59ZXGxptDWcDkEi6T9MWEgCHsAw6uXagvuFFFGAt6snpO8rd7Mz51ulu/uOuFd0sxwKyl092Bm7WyxUnxS5KOCiCXzt45CNS/NR9A1WEoO4H+m+4hJ11T4yJq//Dj5el9hFztSQYDzFf+aUVUmfC/NBfduSNgiDw1Mhk0icx9V2IRi6JDK8gcWP3thaFRlaTXI6Tpx3vRaRLtGowOgzCajxLnISwfVi0+gNIDegH6g91tK3wnhJ8RqpvD5k7YjRg19A0kdEjrC6iHL0h/xDXmKK7o9txtgQzwmhHPAI5/ppyEEa40ZBFl1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVdBTGyTrMz7EtcVe4YjLJLJ5qxDc+Yyj923KuDE0ig=;
 b=aO1lalnGFBA4afNV09VUlhtQMRnU7cH5k/DYx6KCk7j7IKagR0PKmtOdtRUsZenvrObewcPO+zsh6bHrMDVSz9ys8GPw3aPQFjyh7uM69yfaceqOAho///hwemhiO7+Yg5ZxWdvmoNxMBCEqqC+nxHHRqqLaUtfm2XtGfphGTcU=
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 05:20:01 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::18) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Thu,
 21 Aug 2025 05:20:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Thu, 21 Aug 2025 05:20:00 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 00:19:52 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, "Ahmed S. Darwish"
	<darwi@linutronix.de>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 1/2] x86/cpu/cacheinfo: Convert get_cache_id() to use APIC ID and return Cache ID
Date: Thu, 21 Aug 2025 05:19:09 +0000
Message-ID: <20250821051910.7351-2-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 7063836d-26b7-477e-61cb-08dde0726079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SWtOlKW0ci/GuxuEXxr3dNZS09jYslcvWBEkGHdxdFlYWvo3E7P+WPIfzHPT?=
 =?us-ascii?Q?RgPGbWjKay1NG+BTF7/+ORIvZFWB/nj2Vzq3D9Q34obi9uUBRzdAJ2lDdBVW?=
 =?us-ascii?Q?JT60v3ml+hVPOsmubc1UhaN+K8gW6jm9CHrFxuS05AuBUuCyAoVcDRUevttZ?=
 =?us-ascii?Q?AH7pIE2jIgsgtwAgAWCBzyUeKvUztyEr3nbF2Rf00XyRNVkLkWBh8J5xzGrC?=
 =?us-ascii?Q?VGcXr/YjGnfzNXlirQexMPyTD00lsYJIqYsklw/qygvhoH3Ocygb5cmCdMad?=
 =?us-ascii?Q?EgCZx4XbOclfEZOg9o0nCp5BmkrzuLttLgMveLtHqX6ffR7aWhn2YQZqyf6z?=
 =?us-ascii?Q?PWJFKk892ydhLZlacYuUEucZd6s/P61YL3d5x3iw/5o5SfvHriOYQ7QvP0Qo?=
 =?us-ascii?Q?WbrkXAT9QIE5AH04w9RnoIZU7Jcm5YL8keBF7bzgcrmCuaTHvU/jZdDlkZn8?=
 =?us-ascii?Q?ehYyACU7cGbhwo75yVtz11EhC1W/xzT6PeBGRB0PuhUzi9BDpvt3tOkuwLrP?=
 =?us-ascii?Q?hSH/GYhR1krGhSR0AjNFn/XirjlrBrHbsGpGRwG9W8BhFZIbTdlXGhOMfBFr?=
 =?us-ascii?Q?K+IItZp/DSAGenDxyy3v7ufQ6X6esuYtwpWc8biB5UgRv6fEBhPBc1vgwTx4?=
 =?us-ascii?Q?vOGmYtnkgHhvd0D35ngVkqEju7O5rgw4QFchdqecwBlmC9A13U3/eA4HM/UQ?=
 =?us-ascii?Q?d9ctbPK2cBugnpKA78jx+ATaZfvk6W9cEPjoJhP3mKhcSLtRUkcbLcUDdzxd?=
 =?us-ascii?Q?1ZeTLpWVFbz62IJEuJ3DDNYl6Bfeh4BdVrAeZumj1K7N8cd1oNyVfQLcitB3?=
 =?us-ascii?Q?P49ikrCHD16RN4tAPLk9Yy89Oa1ubwT6pESAZVN9EjWK3d9THpwzOqbocjry?=
 =?us-ascii?Q?U97C0Z2r6PoxbXGyozigfZHDXqMNNYVfmqvRzm/ISPccIdT5+HSRGTU2PeCu?=
 =?us-ascii?Q?K/td9IPLaiDVtnxRLl1tl0bkKH4Qn8A+CvUsH+Oh8LElagGiLRdXxQysdADZ?=
 =?us-ascii?Q?oMRRlevrhSGj3s2OCDEXF273r8BDK6oGlLbrvjrY/oM21BXRBu2x8k6hXBDC?=
 =?us-ascii?Q?zlkOq8+87CD3zSjb4630Pwvu4813deUMh9IK5+MdKzQeJrxhCJso0FMOz32D?=
 =?us-ascii?Q?yjGEIt5vaZ56xbK6ixGJ6v2s3r91j1lQ7MyQL18bd10rftrvxppQl03VGzvW?=
 =?us-ascii?Q?0oz6SdzsiGhqVZRcbdcF6KbgRiIqPMeKk7rJRrKqUZOpOzpZcNhfPXBqccoz?=
 =?us-ascii?Q?Mu+p6OLTwh8D6yQ4hju+9aBjFu3F0dNrvJtbnpGh12as9B8IH2Jz6qdQHIZp?=
 =?us-ascii?Q?WzA4v4AkMgC2xpV9rP7/po6hXP84WDy0ugPX1mEu+payP4faL2F4vpiFo5cg?=
 =?us-ascii?Q?8/jgbYxpBoVENxvz8++0NCXG82ey/Lkg+VTABoUA6m+JADp5Q2L5/OuC/CDL?=
 =?us-ascii?Q?um7nn5oarEFbG/uHeFd17UJMv6cpEm+sWLQu74mxT5wU8OZqPu4r5JVafXlR?=
 =?us-ascii?Q?CDZPersh6p1yWSRbgTX0NK3X7F3JqL9G2ACV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 05:20:00.4604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7063836d-26b7-477e-61cb-08dde0726079
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084

Avoid reading the cpu_data() everytime get_cache_id() is called and
instead pass the APIC ID necessary to return the _cpuid4_info.id from
get_cache_id().

get_cache_id() will be used in the subsequent commit to assign llc_id
and not just the _cpuid4_info.id.

No functional changes intended.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/x86/kernel/cpu/cacheinfo.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index adfa7e8bb865..e7b10a612c6f 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -603,15 +603,15 @@ int init_cache_level(unsigned int cpu)
  * ECX as cache index. Then right shift apicid by the number's order to get
  * cache id for this cache node.
  */
-static void get_cache_id(int cpu, struct _cpuid4_info *id4)
+static unsigned int get_cache_id(u32 apicid, struct _cpuid4_info *id4)
 {
-	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	unsigned long num_threads_sharing;
 	int index_msb;
 
 	num_threads_sharing = 1 + id4->eax.split.num_threads_sharing;
 	index_msb = get_count_order(num_threads_sharing);
-	id4->id = c->topo.apicid >> index_msb;
+
+	return apicid >> index_msb;
 }
 
 int populate_cache_leaves(unsigned int cpu)
@@ -619,6 +619,7 @@ int populate_cache_leaves(unsigned int cpu)
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci = this_cpu_ci->info_list;
 	u8 cpu_vendor = boot_cpu_data.x86_vendor;
+	u32 apicid = cpu_data(cpu).topo.apicid;
 	struct amd_northbridge *nb = NULL;
 	struct _cpuid4_info id4 = {};
 	int idx, ret;
@@ -628,7 +629,7 @@ int populate_cache_leaves(unsigned int cpu)
 		if (ret)
 			return ret;
 
-		get_cache_id(cpu, &id4);
+		id4.id = get_cache_id(apicid, &id4);
 
 		if (cpu_vendor == X86_VENDOR_AMD || cpu_vendor == X86_VENDOR_HYGON)
 			nb = amd_init_l3_cache(idx);
-- 
2.34.1


