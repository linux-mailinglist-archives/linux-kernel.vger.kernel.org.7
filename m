Return-Path: <linux-kernel+bounces-810446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7BFB51AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684DA164242
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A532B327A31;
	Wed, 10 Sep 2025 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AVgYDj/D"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FC7298994
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515911; cv=fail; b=QRKDom76NvKl4tXmQSQ0tNS3KwL2oXvcej4H8gCJt0q2KCmAFRSX69R+vgbX3vQ3awAuUx77vVkDoBYgZm6Rd0DzeCHC7MKvnRdIFDZO8TZrHkcKSE5+foblIsWc0rPD0Nc+gNXg1AbgLlmtk7EzK5t0NtF7ugLVTrKbEPDDaTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515911; c=relaxed/simple;
	bh=+vUNeFcS6G2U8ac4ec/lkMQpnRtMm/5yMPtpi6OGqHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grqshW93EaQ3k1FNynTyljzfsLe6MYLJL9KbRiNNKOfqvWswChnKPApzlbAX5MjrT7fa96dyrkgZgVDrWw6miLx/Ks2EKQdwAaJugdh7IqB4tzDByFHEUIb4HQXN94A6nWqITzulEcnQ0vlOxRgUz/2JVwYX1ovQLqGpuuw3QXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AVgYDj/D; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpgg8yiW0o9AvxvGbjsUssXuIstFMG4CaWKeVKlpRSxOBFKMwvRBUpG01FxG7szPU5ZP0sBLi+j18aL5rrjPBhHMn8MC17XAvugqDaYf64ObaL5NYxTxFHMKg5iMYdiQDOpr0KHaEnofHGVQkfKvBklBUWA/25UuQUNEzN+HDPQ8xG2Enq+lp6MkfJusmhZ55OU+YEG5pXImTt6+DPRP1d4s1WJD9GrPhvJoXooL1knoD3KdCWAUXgDDNf3K7Sq+auw18JEk4EHo8qq4/z+SFWZFMgEaMC9HZOnALfac64ctpb0THArCXtIZ+aUJOadesgg0D0EWenEC8t8/L6xWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jo0BVZS4QvRHXjRZwR9uesfzjUOpTBvJUQpBpLK1Syo=;
 b=nY3E8yVsP5BnFiG7ZSEcqxUJBEhsEfbhUO23jcKORYxkBdJodbmqghty05xei83r3vHw0ua9hA7zotDcqO0WRV08SnUzJEnaL14V0idGL9wPo3lDTTkYm/CZmMuvwgnqRmcQdHChu8v02EwnKWPq5Y5OUrGu+L+tGqtSkOlRkg/FN9zEvJvhjeHxmCcu17UsGe0OweyVOdMAGGBuBdC+Tdoy1PSfIu4EzCga/bxuWgCK72e2v5lEiMHExzYjYZW0YuV0YjDiEVo0+/RQD+yhE0nGYoVpWPKH7BN8usXP139wEq7Xe8b1dhoFsf/HiGasdoNc1b5+K2S83IxQHh58og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jo0BVZS4QvRHXjRZwR9uesfzjUOpTBvJUQpBpLK1Syo=;
 b=AVgYDj/DgmgQZ/nof69aWDCJdZuMPMa+8Gr5dqhlDPygd8/aiyEuXUtZ4Q9v2ABxPPbufEcZPyIK1BuywL4vD/W+8kCREMCcUXPuhgMtbRUofYwjKUjfRVPy+LYUrecsgkrkOBZZHXDNdEh+ctliCCBU643n17XPMBuT00IiQHo=
Received: from SA1PR04CA0021.namprd04.prod.outlook.com (2603:10b6:806:2ce::24)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 14:51:45 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::39) by SA1PR04CA0021.outlook.office365.com
 (2603:10b6:806:2ce::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.23 via Frontend Transport; Wed,
 10 Sep 2025 14:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 14:51:44 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 07:51:33 -0700
From: Bharata B Rao <bharata@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC: <Jonathan.Cameron@huawei.com>, <dave.hansen@intel.com>,
	<gourry@gourry.net>, <hannes@cmpxchg.org>, <mgorman@techsingularity.net>,
	<mingo@redhat.com>, <peterz@infradead.org>, <raghavendra.kt@amd.com>,
	<riel@surriel.com>, <rientjes@google.com>, <sj@kernel.org>,
	<weixugc@google.com>, <willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>, <dave@stgolabs.net>, <nifan.cxl@gmail.com>,
	<xuezhengchu@huawei.com>, <yiannis@zptcorp.com>, <akpm@linux-foundation.org>,
	<david@redhat.com>, <byungchul@sk.com>, <kinseyho@google.com>,
	<joshua.hahnjy@gmail.com>, <yuanchu@google.com>, <balbirs@nvidia.com>,
	<alok.rathore@samsung.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH v2 8/8] mm: sched: Move hot page promotion from NUMAB=2 to kpromoted
Date: Wed, 10 Sep 2025 20:16:53 +0530
Message-ID: <20250910144653.212066-9-bharata@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910144653.212066-1-bharata@amd.com>
References: <20250910144653.212066-1-bharata@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 800f0eeb-2c4b-4985-b7d4-08ddf0798fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fyI+GY6ldRDEcDfoHr7s/qWMoMU0oj8aMjaU5i7MdhPyKSzZ6oFIlaX7FQN8?=
 =?us-ascii?Q?0val73d97aWdXUQOTQXuBQzklZTlOOo68oIjhzzPlNiCmADIqP69MJKJQfH6?=
 =?us-ascii?Q?Y9G6BXaMcF1YMPoCvqNg5W1GnAb0jhPmyBAd/ATocivJgNWveUZYSKGkHgjF?=
 =?us-ascii?Q?mZdRY5iAWdoWLE/G6Apn3jizaDjT9agRro5w4bYF5JPerq/v/xbeaThuTXdw?=
 =?us-ascii?Q?IzR5INOaV5KhA/XnZ37Sf3IDjOsGfIBM9FLOWlXx1zdtNbxnLhcaYMxLNQKG?=
 =?us-ascii?Q?59aXY5D8GHr1pRQjWNTDJl5RwerikPdg+dkLGW4x0veKbkLXzD0LRLiFYR1e?=
 =?us-ascii?Q?9jnyK9UW4LolrqJoyR4iPsMtSU2Ipn89x+Y2kCjnWIOACS029PPS34QXgWcA?=
 =?us-ascii?Q?yYskPrCe6pXmDF25a0QY0/TyeT4k0wsIO/qbj5VtWLLeGpHTMM2JaiNrQf7f?=
 =?us-ascii?Q?VXViJ0qes02ZQ/u9684dOflJrWckDjwpnZfD4Hzj/TbOutcDyY3PbX6jRXag?=
 =?us-ascii?Q?cIKhrzEVlNwOE80bt1mmbKn5fPvY6WLzDrovo0NehIBRiUq4DQI/o0r/Y0Qr?=
 =?us-ascii?Q?SdJNaZwETySVAn65HlpHvjTPdtQ3GDxQGdx0cFzTMyfTLdrv7z05inZTrWr7?=
 =?us-ascii?Q?juZLeGXYKaU6agoMqp0Q28LQJ0TcbuOXh1KOhIE2dGgzpBQmBwEae6iV87Po?=
 =?us-ascii?Q?61Nke7c2BZxefm/oMYOa3p4jJw6dOlGtOyj9VnaNQvU2Hn9QF5IngPwQZVDc?=
 =?us-ascii?Q?mEuSA/jr1fJCHftHn3iBfg+wMADyiSYinG/8v1I5bvELq/P6/OaYoMj7kR/l?=
 =?us-ascii?Q?91Kdev5C+8pIY93JLhAGXGLhReRfSBZReOX4chv76wK2KMmsdkumFEDREh6G?=
 =?us-ascii?Q?lhbRO2w8lcllnefodIWB9ThJheYn2Rtgr4p552E6bA2ndjYlDQuppBQmP4by?=
 =?us-ascii?Q?uGKSIhcC5/dZw1IEFwuXi0XuI0YGi9piwR69eyOx+uyljk6Okxbxin9miu0F?=
 =?us-ascii?Q?AhNFgmdoU3DRxlwXlJ80gWAs+joR+MSmlaZWcQx9LeOTyxCvHPoSryR+Nzux?=
 =?us-ascii?Q?LcwyvBVZ2rYTg+/zvOP5TzwiZ6dX5ipIWnEyWnPRCDM6+vIHGPfhZgDHLyBU?=
 =?us-ascii?Q?+XrHCEsYhYn0S1+OYgAj0bVJ9wEGb07UKtnWDKiRW67ZhYM1E99GjelIBTxf?=
 =?us-ascii?Q?fZ4/4Y72xYcrGsQbumgPr5C/kG+9NtIpaO49TkSkjdLDH+yAw5SetqPPUDhF?=
 =?us-ascii?Q?TDMsHyMwV1xewQ9Uk6Jh8YJcAzbnrt1tnBUW0gtXCNHuQPgeYYaTyGVt3OrT?=
 =?us-ascii?Q?AiMBqDABc+4TenM6aZKbtazMgNHeOkq2aQjB/WYkmgjuD1UNcFa+rxdQrI82?=
 =?us-ascii?Q?H3EVmXlebpJNwTQb8BlbA7SRTQ7wQmVd1qqcqDDoZ27kRnJhuiiSSWDfKWcW?=
 =?us-ascii?Q?TwpIwqiiJy26R44lDUfTj9El9TbYohl72U5CH0sOh3vmq/BrxVrSpjRVOfSe?=
 =?us-ascii?Q?zyNp8zFasrwitWsjIMY+w12ZSTrBGbYHYyfq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:51:44.7393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 800f0eeb-2c4b-4985-b7d4-08ddf0798fa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290

Currently hot page promotion (NUMA_BALANCING_MEMORY_TIERING
mode of NUMA Balancing) does hot page detection (via hint faults),
hot page classification and eventual promotion, all by itself and
sits within the scheduler.

With the new hot page tracking and promotion mechanism being
available, NUMA Balancing can limit itself to detection of
hot pages (via hint faults) and off-load rest of the
functionality to the common hot page tracking system.

pghot_record_access(PGHOT_HINT_FAULT) API is used to feed the
hot page info. In addition, the migration rate limiting and
dynamic threshold logic are moved to kpromoted so that the same
can be used for hot pages reported by other sources too.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 include/linux/pghot.h |   2 +
 kernel/sched/fair.c   | 149 ++----------------------------------------
 mm/memory.c           |  32 ++-------
 mm/pghot.c            | 132 +++++++++++++++++++++++++++++++++++--
 4 files changed, 142 insertions(+), 173 deletions(-)

diff --git a/include/linux/pghot.h b/include/linux/pghot.h
index 1443643aab13..98a72e01bdd6 100644
--- a/include/linux/pghot.h
+++ b/include/linux/pghot.h
@@ -47,6 +47,8 @@ enum pghot_src {
 #define PGHOT_HEAP_PCT		25
 
 #define KPROMOTED_MIGRATE_BATCH	1024
+#define KPROMOTED_MIGRATION_ADJUST_STEPS	16
+#define KPROMOTED_PROMOTION_THRESHOLD_WINDOW	60000
 
 /*
  * If target NID isn't available, kpromoted promotes to node 0
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..54eeddb6ec23 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -125,11 +125,6 @@ int __weak arch_asym_cpu_priority(int cpu)
 static unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
 #endif
 
-#ifdef CONFIG_NUMA_BALANCING
-/* Restrict the NUMA promotion throughput (MB/s) for each target node. */
-static unsigned int sysctl_numa_balancing_promote_rate_limit = 65536;
-#endif
-
 #ifdef CONFIG_SYSCTL
 static const struct ctl_table sched_fair_sysctls[] = {
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -142,16 +137,6 @@ static const struct ctl_table sched_fair_sysctls[] = {
 		.extra1         = SYSCTL_ONE,
 	},
 #endif
-#ifdef CONFIG_NUMA_BALANCING
-	{
-		.procname	= "numa_balancing_promote_rate_limit_MBps",
-		.data		= &sysctl_numa_balancing_promote_rate_limit,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
-#endif /* CONFIG_NUMA_BALANCING */
 };
 
 static int __init sched_fair_sysctl_init(void)
@@ -1800,108 +1785,6 @@ static inline bool cpupid_valid(int cpupid)
 	return cpupid_to_cpu(cpupid) < nr_cpu_ids;
 }
 
-/*
- * For memory tiering mode, if there are enough free pages (more than
- * enough watermark defined here) in fast memory node, to take full
- * advantage of fast memory capacity, all recently accessed slow
- * memory pages will be migrated to fast memory node without
- * considering hot threshold.
- */
-static bool pgdat_free_space_enough(struct pglist_data *pgdat)
-{
-	int z;
-	unsigned long enough_wmark;
-
-	enough_wmark = max(1UL * 1024 * 1024 * 1024 >> PAGE_SHIFT,
-			   pgdat->node_present_pages >> 4);
-	for (z = pgdat->nr_zones - 1; z >= 0; z--) {
-		struct zone *zone = pgdat->node_zones + z;
-
-		if (!populated_zone(zone))
-			continue;
-
-		if (zone_watermark_ok(zone, 0,
-				      promo_wmark_pages(zone) + enough_wmark,
-				      ZONE_MOVABLE, 0))
-			return true;
-	}
-	return false;
-}
-
-/*
- * For memory tiering mode, when page tables are scanned, the scan
- * time will be recorded in struct page in addition to make page
- * PROT_NONE for slow memory page.  So when the page is accessed, in
- * hint page fault handler, the hint page fault latency is calculated
- * via,
- *
- *	hint page fault latency = hint page fault time - scan time
- *
- * The smaller the hint page fault latency, the higher the possibility
- * for the page to be hot.
- */
-static int numa_hint_fault_latency(struct folio *folio)
-{
-	int last_time, time;
-
-	time = jiffies_to_msecs(jiffies);
-	last_time = folio_xchg_access_time(folio, time);
-
-	return (time - last_time) & PAGE_ACCESS_TIME_MASK;
-}
-
-/*
- * For memory tiering mode, too high promotion/demotion throughput may
- * hurt application latency.  So we provide a mechanism to rate limit
- * the number of pages that are tried to be promoted.
- */
-static bool numa_promotion_rate_limit(struct pglist_data *pgdat,
-				      unsigned long rate_limit, int nr)
-{
-	unsigned long nr_cand;
-	unsigned int now, start;
-
-	now = jiffies_to_msecs(jiffies);
-	mod_node_page_state(pgdat, PGPROMOTE_CANDIDATE, nr);
-	nr_cand = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
-	start = pgdat->nbp_rl_start;
-	if (now - start > MSEC_PER_SEC &&
-	    cmpxchg(&pgdat->nbp_rl_start, start, now) == start)
-		pgdat->nbp_rl_nr_cand = nr_cand;
-	if (nr_cand - pgdat->nbp_rl_nr_cand >= rate_limit)
-		return true;
-	return false;
-}
-
-#define NUMA_MIGRATION_ADJUST_STEPS	16
-
-static void numa_promotion_adjust_threshold(struct pglist_data *pgdat,
-					    unsigned long rate_limit,
-					    unsigned int ref_th)
-{
-	unsigned int now, start, th_period, unit_th, th;
-	unsigned long nr_cand, ref_cand, diff_cand;
-
-	now = jiffies_to_msecs(jiffies);
-	th_period = sysctl_numa_balancing_scan_period_max;
-	start = pgdat->nbp_th_start;
-	if (now - start > th_period &&
-	    cmpxchg(&pgdat->nbp_th_start, start, now) == start) {
-		ref_cand = rate_limit *
-			sysctl_numa_balancing_scan_period_max / MSEC_PER_SEC;
-		nr_cand = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
-		diff_cand = nr_cand - pgdat->nbp_th_nr_cand;
-		unit_th = ref_th * 2 / NUMA_MIGRATION_ADJUST_STEPS;
-		th = pgdat->nbp_threshold ? : ref_th;
-		if (diff_cand > ref_cand * 11 / 10)
-			th = max(th - unit_th, unit_th);
-		else if (diff_cand < ref_cand * 9 / 10)
-			th = min(th + unit_th, ref_th * 2);
-		pgdat->nbp_th_nr_cand = nr_cand;
-		pgdat->nbp_threshold = th;
-	}
-}
-
 bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 				int src_nid, int dst_cpu)
 {
@@ -1917,33 +1800,11 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 
 	/*
 	 * The pages in slow memory node should be migrated according
-	 * to hot/cold instead of private/shared.
-	 */
-	if (folio_use_access_time(folio)) {
-		struct pglist_data *pgdat;
-		unsigned long rate_limit;
-		unsigned int latency, th, def_th;
-
-		pgdat = NODE_DATA(dst_nid);
-		if (pgdat_free_space_enough(pgdat)) {
-			/* workload changed, reset hot threshold */
-			pgdat->nbp_threshold = 0;
-			return true;
-		}
-
-		def_th = sysctl_numa_balancing_hot_threshold;
-		rate_limit = sysctl_numa_balancing_promote_rate_limit << \
-			(20 - PAGE_SHIFT);
-		numa_promotion_adjust_threshold(pgdat, rate_limit, def_th);
-
-		th = pgdat->nbp_threshold ? : def_th;
-		latency = numa_hint_fault_latency(folio);
-		if (latency >= th)
-			return false;
-
-		return !numa_promotion_rate_limit(pgdat, rate_limit,
-						  folio_nr_pages(folio));
-	}
+	 * to hot/cold instead of private/shared. Also the migration
+	 * of such pages are handled by kpromoted.
+	 */
+	if (folio_use_access_time(folio))
+		return true;
 
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
 	last_cpupid = folio_xchg_last_cpupid(folio, this_cpupid);
diff --git a/mm/memory.c b/mm/memory.c
index 0ba4f6b71847..eeb34e8d9b8e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -75,6 +75,7 @@
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/sysctl.h>
+#include <linux/pghot.h>
 
 #include <trace/events/kmem.h>
 
@@ -5864,34 +5865,12 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 
 	target_nid = numa_migrate_check(folio, vmf, vmf->address, &flags,
 					writable, &last_cpupid);
+	nid = target_nid;
 	if (target_nid == NUMA_NO_NODE)
 		goto out_map;
-	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
-		flags |= TNF_MIGRATE_FAIL;
-		goto out_map;
-	}
-	/* The folio is isolated and isolation code holds a folio reference. */
-	pte_unmap_unlock(vmf->pte, vmf->ptl);
+
 	writable = false;
 	ignore_writable = true;
-
-	/* Migrate to the requested node */
-	if (!migrate_misplaced_folio(folio, target_nid)) {
-		nid = target_nid;
-		flags |= TNF_MIGRATED;
-		task_numa_fault(last_cpupid, nid, nr_pages, flags);
-		return 0;
-	}
-
-	flags |= TNF_MIGRATE_FAIL;
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-				       vmf->address, &vmf->ptl);
-	if (unlikely(!vmf->pte))
-		return 0;
-	if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
-		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		return 0;
-	}
 out_map:
 	/*
 	 * Make it present again, depending on how arch implements
@@ -5905,8 +5884,11 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 					    writable);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 
-	if (nid != NUMA_NO_NODE)
+	if (nid != NUMA_NO_NODE) {
+		pghot_record_access(folio_pfn(folio), nid, PGHOT_HINT_FAULT,
+				    jiffies);
 		task_numa_fault(last_cpupid, nid, nr_pages, flags);
+	}
 	return 0;
 }
 
diff --git a/mm/pghot.c b/mm/pghot.c
index 9f7581818b8f..9f5746892bce 100644
--- a/mm/pghot.c
+++ b/mm/pghot.c
@@ -9,6 +9,9 @@
  *
  * kpromoted is a kernel thread that runs on each toptier node and
  * promotes pages from max_heap.
+ *
+ * Migration rate-limiting and dynamic threshold logic implementations
+ * were moved from NUMA Balancing mode 2.
  */
 #include <linux/pghot.h>
 #include <linux/kthread.h>
@@ -34,6 +37,9 @@ static bool kpromoted_started __ro_after_init;
 
 static unsigned int sysctl_pghot_freq_window = KPROMOTED_FREQ_WINDOW;
 
+/* Restrict the NUMA promotion throughput (MB/s) for each target node. */
+static unsigned int sysctl_pghot_promote_rate_limit = 65536;
+
 #ifdef CONFIG_SYSCTL
 static const struct ctl_table pghot_sysctls[] = {
 	{
@@ -44,8 +50,17 @@ static const struct ctl_table pghot_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 	},
+	{
+		.procname	= "pghot_promote_rate_limit_MBps",
+		.data		= &sysctl_pghot_promote_rate_limit,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
 };
 #endif
+
 static bool phi_heap_less(const void *lhs, const void *rhs, void *args)
 {
 	return (*(struct pghot_info **)lhs)->frequency >
@@ -94,11 +109,99 @@ static bool phi_heap_insert(struct max_heap *phi_heap, struct pghot_info *phi)
 	return true;
 }
 
+/*
+ * For memory tiering mode, if there are enough free pages (more than
+ * enough watermark defined here) in fast memory node, to take full
+ * advantage of fast memory capacity, all recently accessed slow
+ * memory pages will be migrated to fast memory node without
+ * considering hot threshold.
+ */
+static bool pgdat_free_space_enough(struct pglist_data *pgdat)
+{
+	int z;
+	unsigned long enough_wmark;
+
+	enough_wmark = max(1UL * 1024 * 1024 * 1024 >> PAGE_SHIFT,
+			   pgdat->node_present_pages >> 4);
+	for (z = pgdat->nr_zones - 1; z >= 0; z--) {
+		struct zone *zone = pgdat->node_zones + z;
+
+		if (!populated_zone(zone))
+			continue;
+
+		if (zone_watermark_ok(zone, 0,
+				      promo_wmark_pages(zone) + enough_wmark,
+				      ZONE_MOVABLE, 0))
+			return true;
+	}
+	return false;
+}
+
+/*
+ * For memory tiering mode, too high promotion/demotion throughput may
+ * hurt application latency.  So we provide a mechanism to rate limit
+ * the number of pages that are tried to be promoted.
+ */
+static bool kpromoted_promotion_rate_limit(struct pglist_data *pgdat,
+					   unsigned long rate_limit, int nr,
+					   unsigned long time)
+{
+	unsigned long nr_cand;
+	unsigned int now, start;
+
+	now = jiffies_to_msecs(time);
+	mod_node_page_state(pgdat, PGPROMOTE_CANDIDATE, nr);
+	nr_cand = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
+	start = pgdat->nbp_rl_start;
+	if (now - start > MSEC_PER_SEC &&
+	    cmpxchg(&pgdat->nbp_rl_start, start, now) == start)
+		pgdat->nbp_rl_nr_cand = nr_cand;
+	if (nr_cand - pgdat->nbp_rl_nr_cand >= rate_limit)
+		return true;
+	return false;
+}
+
+static void kpromoted_promotion_adjust_threshold(struct pglist_data *pgdat,
+						 unsigned long rate_limit,
+						 unsigned int ref_th,
+						 unsigned long now)
+{
+	unsigned int start, th_period, unit_th, th;
+	unsigned long nr_cand, ref_cand, diff_cand;
+
+	now = jiffies_to_msecs(now);
+	th_period = KPROMOTED_PROMOTION_THRESHOLD_WINDOW;
+	start = pgdat->nbp_th_start;
+	if (now - start > th_period &&
+	    cmpxchg(&pgdat->nbp_th_start, start, now) == start) {
+		ref_cand = rate_limit *
+			KPROMOTED_PROMOTION_THRESHOLD_WINDOW / MSEC_PER_SEC;
+		nr_cand = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
+		diff_cand = nr_cand - pgdat->nbp_th_nr_cand;
+		unit_th = ref_th * 2 / KPROMOTED_MIGRATION_ADJUST_STEPS;
+		th = pgdat->nbp_threshold ? : ref_th;
+		if (diff_cand > ref_cand * 11 / 10)
+			th = max(th - unit_th, unit_th);
+		else if (diff_cand < ref_cand * 9 / 10)
+			th = min(th + unit_th, ref_th * 2);
+		pgdat->nbp_th_nr_cand = nr_cand;
+		pgdat->nbp_threshold = th;
+	}
+}
+
+static inline unsigned int pghot_access_latency(struct pghot_info *phi, u32  now)
+{
+	return (now - phi->last_update);
+}
+
 static bool phi_is_pfn_hot(struct pghot_info *phi)
 {
 	struct page *page = pfn_to_online_page(phi->pfn);
-	unsigned long now = jiffies;
 	struct folio *folio;
+	struct pglist_data *pgdat;
+	unsigned long rate_limit;
+	unsigned int latency, th, def_th;
+	unsigned long now = jiffies;
 
 	if (!page || is_zone_device_page(page))
 		return false;
@@ -113,7 +216,24 @@ static bool phi_is_pfn_hot(struct pghot_info *phi)
 		return false;
 	}
 
-	return true;
+	pgdat = NODE_DATA(phi->nid);
+	if (pgdat_free_space_enough(pgdat)) {
+		/* workload changed, reset hot threshold */
+		pgdat->nbp_threshold = 0;
+		return true;
+	}
+
+	def_th = sysctl_pghot_freq_window;
+	rate_limit = sysctl_pghot_promote_rate_limit << (20 - PAGE_SHIFT);
+	kpromoted_promotion_adjust_threshold(pgdat, rate_limit, def_th, now);
+
+	th = pgdat->nbp_threshold ? : def_th;
+	latency = pghot_access_latency(phi, now & PGHOT_TIME_MASK);
+	if (latency >= th)
+		return false;
+
+	return !kpromoted_promotion_rate_limit(pgdat, rate_limit,
+					       folio_nr_pages(folio), now);
 }
 
 static struct folio *kpromoted_isolate_folio(struct pghot_info *phi)
@@ -351,9 +471,13 @@ int pghot_record_access(u64 pfn, int nid, int src, unsigned long now)
 	/*
 	 * If the previous access was beyond the threshold window
 	 * start frequency tracking afresh.
+	 *
+	 * Bypass the new window logic for NUMA hint fault source
+	 * as it is too slow in reporting accesses.
+	 * TODO: Fix this.
 	 */
-	if (((cur_time - phi->last_update) > msecs_to_jiffies(sysctl_pghot_freq_window)) ||
-	    (nid != NUMA_NO_NODE && phi->nid != nid))
+	if ((((cur_time - phi->last_update) > msecs_to_jiffies(sysctl_pghot_freq_window))
+	    && (src != PGHOT_HINT_FAULT)) || (nid != NUMA_NO_NODE && phi->nid != nid))
 		new_window = true;
 
 	if (new_entry || new_window) {
-- 
2.34.1


