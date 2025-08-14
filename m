Return-Path: <linux-kernel+bounces-769193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 899DDB26B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763821CC0B76
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EED423BD04;
	Thu, 14 Aug 2025 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IWs6HFFr"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7E1225A4F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185758; cv=fail; b=gGylKDSAEr6o+5pyIOCzOoC+7NDLHcu330j7Xv6xfOwTcJYZwEJxEpsFTy+2MEc62UGuJ8WJh1917/79aCCyzEOANVBfcjqLwA1OjFNg0eG/9BIb+wu5XgY6YPZGo4i08nQXQfeK+XDuwpEjZC4JNI67bY1DLKXhZPaVlBccPGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185758; c=relaxed/simple;
	bh=a2VjCsMDF1M9pxkDJhsM/9s6/6Su7pJL9W2C0WlJ6/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kp68b2bpGyLpQBnPStwAZiqI6y10pD9mUbrABaj3+ntUNzmoqEG0U6rWmpiZyajFHtXYOgOA99kDo29bu+gKHXddaf0tH9ngk8IsREpembwlU1eqiSgC4nTm6DhvXkMYCU08jdEBZna/BRPZzxoM/6fJ+sYQAgPXHwKxZG4UE0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IWs6HFFr; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STBahrl88GG1Dw7Xn9NnhYJ0AO4Z9sxo5dCW9ARRtb9wejqFICJgCThV2lKIiLw/+hiH0MMSSLAvJwamRt1zLvXuPC3apNTSeQASjiXI//KBUeF6xlJeInnovlduKHBdJIvgXqMdRQ7g3LcHkzan4Im9jWaIvFMR9tE2rVHZgSw+1p80z/Fod+jlCiE2cJ1T5k3YouUOLJ6CGqL7o5/wNNUtt5DERD8yziorGxu9I4kDlDT6cuTmPyne54+ZLSOEzqG/qQcYdI5NmBfXo89cDI6FXWZXUG6E9OUoHUktapG3+4YAVe/BRRS0pRr6UVpDNCq/MUiT4hJSir7/mC97aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hE+4BNyN+gD/VwJCW/xU/rYEKf9T8D51JEHv+tgwhY=;
 b=FcqWg9XBgMltvTk78PAjMsIw2RIo7rqfjZZtAxu1cO5qAuNBu21ictaFcDhdP2QZoSiL1QDCqMjNj8EX65uHRxBatsQIE3SBI1a4US8z7f5rrapeiQqdcW7lc5tQKFV9SIg2I4oRFYQIf8kviem3aGtgeGkOwZa2RVESvsNVHQ02aYtIHymPuhSDZDQv8xXS3dW5myvA6iSymvSRNprOrrhlMxBzIcIzMhwXvxcpw/MLx9snfuhidjlurDJ+zX+9ehZPVKc48Algd1WCUMqCcHfitoL9XcymoLUF7QoN+ym1Om8u1JbNp4AThqUf+klmOTMZiMlpLJ4Yc9wo2j53tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hE+4BNyN+gD/VwJCW/xU/rYEKf9T8D51JEHv+tgwhY=;
 b=IWs6HFFr4yqec5o3FS6ht58dm8o33a1nw2+AQ1c17ONX0UTVIrFONibkVV8e1dUOWDA0tSYtS5Pw3xjDV9fuKQpElhhC1hurvVz7HFXs5T+tnrbvdgv8D54d3qR3VInD33TYf0hkVmZrfjjNP1EWQBzYBnWVAUvwHCC9P21bsz0=
Received: from DM5PR07CA0075.namprd07.prod.outlook.com (2603:10b6:4:ad::40) by
 PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 15:35:53 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:4:ad:cafe::58) by DM5PR07CA0075.outlook.office365.com
 (2603:10b6:4:ad::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 15:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 15:35:52 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 10:35:39 -0500
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <raghavendra.kt@amd.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Michael.Day@amd.com>,
	<akpm@linux-foundation.org>, <bharata@amd.com>, <dave.hansen@intel.com>,
	<david@redhat.com>, <dongjoo.linux.dev@gmail.com>, <feng.tang@intel.com>,
	<gourry@gourry.net>, <hannes@cmpxchg.org>, <honggyu.kim@sk.com>,
	<hughd@google.com>, <jhubbard@nvidia.com>, <jon.grimm@amd.com>,
	<k.shutemov@gmail.com>, <kbusch@meta.com>, <kmanaouil.dev@gmail.com>,
	<leesuyeon0506@gmail.com>, <leillc@google.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<mgorman@techsingularity.net>, <mingo@redhat.com>, <nadav.amit@gmail.com>,
	<nphamcs@gmail.com>, <peterz@infradead.org>, <riel@surriel.com>,
	<rientjes@google.com>, <rppt@kernel.org>, <santosh.shukla@amd.com>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>, <vbabka@suse.cz>,
	<weixugc@google.com>, <willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>, <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
	<yuanchu@google.com>, <kinseyho@google.com>, <hdanton@sina.com>,
	<harry.yoo@oracle.com>
Subject: [RFC PATCH V3 13/17] mm/vmstat: Add vmstat counters
Date: Thu, 14 Aug 2025 15:33:03 +0000
Message-ID: <20250814153307.1553061-14-raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814153307.1553061-1-raghavendra.kt@amd.com>
References: <20250814153307.1553061-1-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|PH8PR12MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: ffdcd589-b38e-4b0f-640d-08dddb4840dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uIjbIYhhnyNi1qXMJlwYkw+KmmJxXnfu/AWeZQUjjRl/JMvFDAtLQsOyZtlv?=
 =?us-ascii?Q?+QyCrtDRUA+YEqJliZLKmC+fnmXErmHhfHhmoq1vp1FZivPYcQluRCtra9m7?=
 =?us-ascii?Q?H4qJMCJ8zcBnPu2aaBgzYnFKEBRxqmXyO5VsanaMsMtnA1RdZ330ufpZ63YD?=
 =?us-ascii?Q?0ICCkRBdTYWVe4dHKioB1TAxwWvIKfFntjHzTqncJmMzgy1jw3sPviEc4PRZ?=
 =?us-ascii?Q?qLPmSfI4ixHJhYo2Vp3tSrRULZyujWUzYXeD5tOL5zbYCJPXJgTgyJGpGdO0?=
 =?us-ascii?Q?z1YHi1vYQoD9JxR95oGdpOhQKTO4pHxBwZHxM6NZF/w9OhTF6Xar+eWXn79R?=
 =?us-ascii?Q?PjGghqBoAPtNgONA6xXf1AOTQqlzQkM2MgQevv067xb5jKOG0PleAI+Pk1ml?=
 =?us-ascii?Q?WwZjeqfh5sDm1RAKnYk8bHsweao54TcFo2T8zMYMQUrpT6Ot/ZsjfUKcbUZS?=
 =?us-ascii?Q?y5FzkH6LHOK1A7GIP2w18EyMWtdv6tLrh0D5IPIcuzpHTWjCISiKNfAu7SAM?=
 =?us-ascii?Q?IVLLro73e8wfILailNpQb9RAztA0GkyN93FkvC53MTMdS7Iu7sgwygIdgGlv?=
 =?us-ascii?Q?fi6xJn23O0xVyEysYJ4wt78hZVjDC30p4qjU9kzigt0QaGGigQQ0XNYgvNXT?=
 =?us-ascii?Q?oyO+a/ojpV7pR/FL8e7FTSu6Q6VlFviabPfB5EFGApTaX9ESS3bLZn0s5AnB?=
 =?us-ascii?Q?ji9Ao+QyTivVElQO9XMV3Mx4wSlzZnb1ERcBVEgrP1l4mv+xvhuG1AIyvOnM?=
 =?us-ascii?Q?ajHXmqgNdlKY5BNTerlj1crj0gKI9v0hT08UTQeOt3WkaAH8TD+B6G92TeMh?=
 =?us-ascii?Q?6AjusS8BBpQ3ropfBXSeIrBGHTQ6Z+4Sek/XHuJ1fg/Ndtb0xwRKiFxSX+fT?=
 =?us-ascii?Q?mDO9o8ojKFC3+N8IAyg6YuICOZSl0/8ZUZ/X/7WdTcMTUoM1WdQpKYzwCIIq?=
 =?us-ascii?Q?gYCWX3WDmQbkwgbVLsQScdtbr4ovp+TbeykKfOWzTC6Hf1T5ScFod+Rk2Nh1?=
 =?us-ascii?Q?6+r4TrdE+4oFKLLaCnoWtREjQdZeWwrlwosM4BjpRRWx1kD+fVMkBoHGWs/m?=
 =?us-ascii?Q?CDzYiMbejnSs8a+5JgPXH5MPwCEL+TUlbWOXJ2OKYAIWnNQRrGoiT3qKFwLn?=
 =?us-ascii?Q?Ftz8zFZHccG1rrZe1Lfbmsg03mYx1zq42fuNhplau5wJBtCQDU6OVa2uHJrd?=
 =?us-ascii?Q?Jr+Wo2RdlSXiD8UeRARzeRNg2LBO7a3PRCEF7bM1rmpyNN4JpRXcHUOKpcIL?=
 =?us-ascii?Q?KONFU6hSxjFcyGMqpNa6fQCICftzXB1L0RRhAyz2jbW2UVrnlwvkv/TcWsrB?=
 =?us-ascii?Q?73AQcLxblRWDYuB+dSWYvkUzQ1ECvjPB6AlcMN/+Hw2a6KMFp/dZYDUtNgJI?=
 =?us-ascii?Q?mN+XS5RBKNN5GRudRk6waVsAuTIUYQvGa4TvGH2YTA6DWbxOoEREEFxFltxH?=
 =?us-ascii?Q?S9slVoBgBFDKq9M7IJud5MUPzo2DfExcZsERd3EDCTwqBUYfjZeSPAYCt/AP?=
 =?us-ascii?Q?ypkqDOFBI0ixakNxC69LJC/MVsEmKeDhJddJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:35:52.7976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdcd589-b38e-4b0f-640d-08dddb4840dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279

Add vmstat counter to track scanning, migration and
type of pages.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm.h            | 13 ++++++++
 include/linux/vm_event_item.h | 12 +++++++
 mm/kscand.c                   | 63 +++++++++++++++++++++++++++++++++--
 mm/vmstat.c                   | 12 +++++++
 4 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fa538feaa8d9..0d579d0294bf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -655,6 +655,19 @@ struct vm_operations_struct {
 					  unsigned long addr);
 };
 
+#ifdef CONFIG_KSCAND
+void count_kscand_mm_scans(void);
+void count_kscand_vma_scans(void);
+void count_kscand_migadded(void);
+void count_kscand_migrated(void);
+void count_kscand_migrate_failed(void);
+void count_kscand_slowtier(void);
+void count_kscand_toptier(void);
+void count_kscand_idlepage(void);
+void count_kscand_hotpage(void);
+void count_kscand_coldpage(void);
+#endif
+
 #ifdef CONFIG_NUMA_BALANCING
 static inline void vma_numab_state_init(struct vm_area_struct *vma)
 {
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 9e15a088ba38..b5643be5dd94 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -67,6 +67,18 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NUMA_HINT_FAULTS_LOCAL,
 		NUMA_PAGE_MIGRATE,
 #endif
+#ifdef CONFIG_KSCAND
+		KSCAND_MM_SCANS,
+		KSCAND_VMA_SCANS,
+		KSCAND_MIGADDED,
+		KSCAND_MIGRATED,
+		KSCAND_MIGRATE_FAILED,
+		KSCAND_SLOWTIER,
+		KSCAND_TOPTIER,
+		KSCAND_IDLEPAGE,
+		KSCAND_HOTPAGE,
+		KSCAND_COLDPAGE,
+#endif
 #ifdef CONFIG_MIGRATION
 		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
 		THP_MIGRATION_SUCCESS,
diff --git a/mm/kscand.c b/mm/kscand.c
index a73606f7ca3c..e14645565ba7 100644
--- a/mm/kscand.c
+++ b/mm/kscand.c
@@ -339,6 +339,47 @@ struct attribute_group kscand_attr_group = {
 };
 #endif
 
+void count_kscand_mm_scans(void)
+{
+	count_vm_numa_event(KSCAND_MM_SCANS);
+}
+void count_kscand_vma_scans(void)
+{
+	count_vm_numa_event(KSCAND_VMA_SCANS);
+}
+void count_kscand_migadded(void)
+{
+	count_vm_numa_event(KSCAND_MIGADDED);
+}
+void count_kscand_migrated(void)
+{
+	count_vm_numa_event(KSCAND_MIGRATED);
+}
+void count_kscand_migrate_failed(void)
+{
+	count_vm_numa_event(KSCAND_MIGRATE_FAILED);
+}
+void count_kscand_slowtier(void)
+{
+	count_vm_numa_event(KSCAND_SLOWTIER);
+}
+void count_kscand_toptier(void)
+{
+	count_vm_numa_event(KSCAND_TOPTIER);
+}
+void count_kscand_idlepage(void)
+{
+	count_vm_numa_event(KSCAND_IDLEPAGE);
+}
+void count_kscand_hotpage(void)
+{
+	count_vm_numa_event(KSCAND_HOTPAGE);
+}
+void count_kscand_coldpage(void)
+{
+	count_vm_numa_event(KSCAND_COLDPAGE);
+}
+
 static inline int kscand_has_work(void)
 {
 	return !list_empty(&kscand_scan.mm_head);
@@ -653,6 +694,8 @@ static int kmigrated_promote_folio(struct kscand_migrate_info *info,
 
 	if (!is_hot_page(folio))
 		return KSCAND_NOT_HOT_PAGE;
+	else
+		count_kscand_hotpage();
 
 	folio_get(folio);
 
@@ -803,12 +846,15 @@ static int hot_vma_idle_pte_entry(pte_t *pte,
 	}
 
 	if (!kscand_eligible_srcnid(srcnid)) {
+		count_kscand_toptier();
 		if (folio_test_young(folio) || folio_test_referenced(folio)
 				|| pte_young(pteval)) {
 			scanctrl->nodeinfo[srcnid]->nr_accessed++;
 		}
 		folio_put(folio);
 		return 0;
+	} else {
+		count_kscand_slowtier();
 	}
 	if (!folio_test_idle(folio) && !prev_idle &&
 		(folio_test_young(folio) || folio_test_referenced(folio))) {
@@ -820,7 +866,14 @@ static int hot_vma_idle_pte_entry(pte_t *pte,
 			info->pfn = folio_pfn(folio);
 			info->address = addr;
 			list_add_tail(&info->migrate_node, &scanctrl->scan_list);
+			count_kscand_migadded();
 		}
+		folio_put(folio);
+		return 0;
+	} else {
+		if (prev_idle)
+			count_kscand_coldpage();
+		count_kscand_idlepage();
 	}
 
 	folio_put(folio);
@@ -1045,10 +1098,13 @@ static void kmigrated_migrate_mm(struct kmigrated_mm_slot *mm_slot)
 			mstat_counter--;
 
 			/* TBD: encode migrated count here, currently assume folio_nr_pages */
-			if (!ret)
+			if (!ret) {
+				count_kscand_migrated();
 				msuccess++;
-			else
+			} else {
+				count_kscand_migrate_failed();
 				mfailed++;
+			}
 
 			kfree(info);
 
@@ -1269,6 +1325,7 @@ static unsigned long kscand_scan_mm_slot(void)
 
 	for_each_vma(vmi, vma) {
 		kscand_walk_page_vma(vma, &kscand_scanctrl);
+		count_kscand_vma_scans();
 		vma_scanned_size += vma->vm_end - vma->vm_start;
 
 		if (vma_scanned_size >= mm_slot_scan_size ||
@@ -1304,6 +1361,8 @@ static unsigned long kscand_scan_mm_slot(void)
 
 	update_mmslot_info = true;
 
+	count_kscand_mm_scans();
+
 	total = get_slowtier_accesed(&kscand_scanctrl);
 	target_node = get_target_node(&kscand_scanctrl);
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index a78d70ddeacd..5ba82d2ffe71 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1347,6 +1347,18 @@ const char * const vmstat_text[] = {
 	"numa_hint_faults_local",
 	"numa_pages_migrated",
 #endif
+#ifdef CONFIG_KSCAND
+	"nr_kscand_mm_scans",
+	"nr_kscand_vma_scans",
+	"nr_kscand_migadded",
+	"nr_kscand_migrated",
+	"nr_kscand_migrate_failed",
+	"nr_kscand_slowtier",
+	"nr_kscand_toptier",
+	"nr_kscand_idlepage",
+	"nr_kscand_hotpage",
+	"nr_kscand_coldpage",
+#endif
 #ifdef CONFIG_MIGRATION
 	"pgmigrate_success",
 	"pgmigrate_fail",
-- 
2.34.1


