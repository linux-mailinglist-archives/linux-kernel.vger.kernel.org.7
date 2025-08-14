Return-Path: <linux-kernel+bounces-769184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5D7B26B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60ED91BC7909
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA7822FDEA;
	Thu, 14 Aug 2025 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s5Bi/G9a"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983152BD11
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185682; cv=fail; b=aa19Z0JxRVCfCZffakLaSfzsTFne176FSL3wn6O/Vls3rMfuDMu9E7/pw8vyI9ZrH32KSNp8qhyTZyEMqwOIGLj31L8ivJgJoMSychukmj/UWnL/7qhnX5GUKttvkLRUvh0Y35MxIaM/U2a5MvwFRpCIRe7g8s3MqjAXc1AgdgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185682; c=relaxed/simple;
	bh=XjdqJoTVuWnAQvu9U7GhTZmPY5ZvlJ+9YL69b3I9wdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOr4kz26ipAqNq57nrI/NOiSY7EgloNqtc6eixQH/WoM33w65kncA9zqaYyLZOBfz9uSx2JnCMaD7Dwlp7cbQUUo6911APlXGsFb36DQ/qOdsyd55nqg0xQMvfy+sWxgxcJdVSARRttP/BnEm+FzuqFFb9oX1Qiy0na8GaPuP4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s5Bi/G9a; arc=fail smtp.client-ip=40.107.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6PweDl9X/qb8/frCmiBvCoCextbq0U56AcXCWYior6ZVEmfOqtz0SXnu67Mibdm5XVJgwlApabG4bw6O19Ozj5dahvTgpWMNrkum00E4XaZ1Brej2TXp1G/IiqqLSj7Xj+0hVLqfpb8jOfiPNyJWNXfLhfSma8NSdDGa1mVWeWIVF1GKuKeUs0US8b3L/E1BYJipo+rcMzNcFfpyiCJtFuYw9rHb/O8k8/c0UIEoPsZ/nejtiM1B9pYDRA24EWgaFmfDpiV3SKKB5R6WZpigd5Np3bj0Zhcsv4Z6wqOGLA8S2jlwCYyxtevd4908DlytDcXiA87CJIkg9ieMFyPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rs8kACRyEGPKQvnLaHlhDH+kmdQbaBr+b8USTRmdZl4=;
 b=PnmdhObwsH5PXXya0UQQqVayI1/wj4cSZILtJtsB8/Og9+GYliPpKtcOv3HPBJnYqWjZNXTKzwrP1JA+QLlqesj1OIcfu4TjpKR7gvQIef1pa5pE3I7SBBzdVPq+JsXTIkvCsQpf99G0KNUY1lW1ilrF3Uxnap9h2NCLTw1AnH9llekcUlHAhw8gKQ3NHMMZVW9XTepZO0q7/tPMCICaK9+cDOmtaGjmqzXcjnIU+Kkzo9As/Y3UCv3OZJdPMEnynZ29UdfqWV4BdvfdrDTR7H1DcGQEfusdW13gSE4lI91jBRyea9okqSVbAp9gpOP/IVlXWPk1HhsqOx+ButGYww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rs8kACRyEGPKQvnLaHlhDH+kmdQbaBr+b8USTRmdZl4=;
 b=s5Bi/G9aTDLKECvSprbDIn7g4eOxIbxTE9FAx34qcs5o67uVdeZ/pFJoV6+p/d7Gcss9n76Hj1mM5OKdEfQy2GhcuHOkXpd6GaX2otEj6Q39sFG/qrI1Kdw/3GASbJCxjIEgSohJJ6qQb6BMhrsKFXVT1FPkCEDx/iwOb6DsOBM=
Received: from BL6PEPF00016412.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:a) by DM4PR12MB6230.namprd12.prod.outlook.com
 (2603:10b6:8:a7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Thu, 14 Aug
 2025 15:34:36 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2a01:111:f403:c803::4) by BL6PEPF00016412.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 15:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 15:34:35 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 10:34:24 -0500
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
Subject: [RFC PATCH V3 06/17] mm/migration: migrate accessed folios to toptier node
Date: Thu, 14 Aug 2025 15:32:56 +0000
Message-ID: <20250814153307.1553061-7-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: be27cdc8-f3c8-4d6c-8ac7-08dddb4812d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RVdPMYKyC8i7bOBnRlBS/XCYAGJez1uIFMd2NPzpoLVzoWJYQ5oDqrMkjyzj?=
 =?us-ascii?Q?xtZn6fkXKBogKGPbtXh91IXS783ug5d3x2HJ65j/Jr4JOU3TZ3ZiuncLKg6l?=
 =?us-ascii?Q?PL8o7faXhgTZvfTZlkwy58XE7xmHYOZznF0suLS+l1xdG5eSMuV2YWH5VKgv?=
 =?us-ascii?Q?SY9h+ygTeRtbUlRd1AKWh/NfMNODqAV14oFES63sNUoj5xTZ0um9OkQs2xX8?=
 =?us-ascii?Q?ytWghkGaZwhaEW40pro1G5gO/FT0+i+6n3nq2gIVirkpt+Puy7Z7Jj4qTn8S?=
 =?us-ascii?Q?PwTAZL3DRUtalyQO7LOYAP0m+jXjk/svOe6DmUj4FYsEvJaBIc16NWwQCsWm?=
 =?us-ascii?Q?VQAfe35MpPMKiJQO3/bUchVlVbrRcUMLUsW2KtPhAbyH92xb408yldYv6ios?=
 =?us-ascii?Q?2Q5DYqunD+58hezUn7NwjmrKg7uwEukPb2SX4Mzdt3/JVQsBMcqYo9q3qLJl?=
 =?us-ascii?Q?IZHjrjTLexqlXv/GQkvPxwEAw6HW5zBhx2hUSYAEwbVqSRccGmPWYq82AAN6?=
 =?us-ascii?Q?tOdkfhCuyDEf6MdoGxWianc9xCw2HcZfmZeMNJkJoOkYyFMwewqdSI/2a9u2?=
 =?us-ascii?Q?v1RHBIKDLQdNlniXpPe9pdrK5exNx1tFho3GUcsRqEvqWEKNNrsEy7+ZvI7k?=
 =?us-ascii?Q?GvFn7W8ehjj1v0eRDnzRqLPW9cupC9VxIZix2fEXZTJS1FKP4ImMJeiFEVCH?=
 =?us-ascii?Q?TFdlTK2RtpVBQL3dS2orboqf4o3s4ywVCKBnIIzN2gt8QkKFU0/KHWBXDdSl?=
 =?us-ascii?Q?vW3cqDfwHKcXwiSEh1AHGL1qIoFk/RS/YvwuOq9ovTIgadCkASC2e69DDdHw?=
 =?us-ascii?Q?d1zDFshiTWDFP+I4Ahhc3U/jeMorPe9cHkyjfJOK16AvafWlk3nXGnEei+Xn?=
 =?us-ascii?Q?IxLFdnHE9ttpI72FVbpXE9T/frjT8IYSiQtVx7PoTrjyJtQAuoYBK4sYMCR/?=
 =?us-ascii?Q?wpe1QrkNIGD53w5zVCldQsB+3YSpFYe5KPMLVSYwLeQznxHLq9SmHDjPVKvX?=
 =?us-ascii?Q?Y9qJt6i6ZbriFCfimyUThmVxky6zGMz2JIo33gYZ0w9Sr5YfkXomgQDFggq6?=
 =?us-ascii?Q?WJO80jQiU/HgBAXdoy3nBlca7qPfsVOxCLEs3IS1A1AdAY9kq7rLo1HS5QUk?=
 =?us-ascii?Q?zHyme3FegNlLweR5069fGjTH7jrf9ZgfyH2vn0G89DCbviD66dMTCh1S70Vu?=
 =?us-ascii?Q?d1099V0pl6dvX7zrxUiYMeCoA9wNtUV2v5jCEobBWnrFOzPpSDgXv+gAsGz1?=
 =?us-ascii?Q?pLuTQn6FQix6Vp1QATpwNVjW/FeHNVsgnbfetn2nqrFmjIa4nIZc0Nf1Fit/?=
 =?us-ascii?Q?ZNTTgxfULqXAnhSkOS7qTuEaXs1jFlZSRXSxZetASWFPOkSEj4I8gXPiJyjX?=
 =?us-ascii?Q?IJm6+LQ9W6fV/F8toSys1vC1AwWgIW8nnE21soZYEHx7mGqRlf+D+FEeVvYh?=
 =?us-ascii?Q?KEf6WwmXqf0Eq+jwMUg/9qEdJ1cd0qwHtsVC4tb5CVtgJS4yCxNKkPgog0iU?=
 =?us-ascii?Q?n3v4G8SWBWd6qj1BwcnSDxmt8OhWWzybOI6n?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:34:35.6163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be27cdc8-f3c8-4d6c-8ac7-08dddb4812d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230

A per mm migration list is added and a kernel thread iterates over
each of them.

For each recently accessed slowtier folio in the migration list:
 - Isolate LRU pages
 - Migrate to a regular node.

The rationale behind whole migration is to speedup the access to
recently accessed pages.

Currently, PTE A bit scanning approach lacks the information about
exact destination node to migrate to.

Reason:
 PROT_NONE hint fault based scanning is done in a process context. Here
when the fault occurs, source CPU of the fault associated the task is
known. Time of page access is also accurate.
With the lack of above information, migration is done to node 0 by default.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/migrate.h |   2 +
 mm/kscand.c             | 448 +++++++++++++++++++++++++++++++++++++++-
 mm/migrate.c            |   2 +-
 3 files changed, 440 insertions(+), 12 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index aaa2114498d6..59547f72d150 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -142,6 +142,8 @@ const struct movable_operations *page_movable_ops(struct page *page)
 }
 
 #ifdef CONFIG_NUMA_BALANCING
+bool migrate_balanced_pgdat(struct pglist_data *pgdat,
+				   unsigned long nr_migrate_pages);
 int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node);
 int migrate_misplaced_folio(struct folio *folio, int node);
diff --git a/mm/kscand.c b/mm/kscand.c
index 55efd0a6e5ba..5cd2764114df 100644
--- a/mm/kscand.c
+++ b/mm/kscand.c
@@ -52,9 +52,18 @@ static DEFINE_MUTEX(kmigrated_mutex);
 static DECLARE_WAIT_QUEUE_HEAD(kmigrated_wait);
 static unsigned long kmigrated_sleep_expire;
 
+/* mm of the migrating folio entry */
+static struct mm_struct *kmigrated_cur_mm;
+
+/* Migration list is manipulated underneath because of mm_exit */
+static bool  kmigrated_clean_list;
+
 static unsigned long kscand_sleep_expire;
+#define KSCAND_DEFAULT_TARGET_NODE	(0)
+static int kscand_target_node = KSCAND_DEFAULT_TARGET_NODE;
 
 static DEFINE_SPINLOCK(kscand_mm_lock);
+static DEFINE_SPINLOCK(kscand_migrate_lock);
 static DECLARE_WAIT_QUEUE_HEAD(kscand_wait);
 
 #define KSCAND_SLOT_HASH_BITS 10
@@ -62,6 +71,10 @@ static DEFINE_READ_MOSTLY_HASHTABLE(kscand_slots_hash, KSCAND_SLOT_HASH_BITS);
 
 static struct kmem_cache *kscand_slot_cache __read_mostly;
 
+#define KMIGRATED_SLOT_HASH_BITS 10
+static DEFINE_READ_MOSTLY_HASHTABLE(kmigrated_slots_hash, KMIGRATED_SLOT_HASH_BITS);
+static struct kmem_cache *kmigrated_slot_cache __read_mostly;
+
 /* Per mm information collected to control VMA scanning */
 struct kscand_mm_slot {
 	struct mm_slot slot;
@@ -90,6 +103,26 @@ struct kscand_scanctrl {
 
 struct kscand_scanctrl kscand_scanctrl;
 
+/* Per mm migration list */
+struct kmigrated_mm_slot {
+	/* Tracks mm that has non empty migration list */
+	struct mm_slot mm_slot;
+	/* Per mm lock used to synchronize migration list */
+	spinlock_t migrate_lock;
+	/* Head of per mm migration list */
+	struct list_head migrate_head;
+};
+
+/* System wide list of mms that maintain migration list */
+struct kmigrated_daemon {
+	struct list_head mm_head;
+	struct kmigrated_mm_slot *mm_slot;
+};
+
+struct kmigrated_daemon kmigrated_daemon = {
+	.mm_head = LIST_HEAD_INIT(kmigrated_daemon.mm_head),
+};
+
 /* Per folio information used for migration */
 struct kscand_migrate_info {
 	struct list_head migrate_node;
@@ -108,6 +141,11 @@ static inline int kscand_has_work(void)
 	return !list_empty(&kscand_scan.mm_head);
 }
 
+static inline int kmigrated_has_work(void)
+{
+	return !list_empty(&kmigrated_daemon.mm_head);
+}
+
 static inline bool kscand_should_wakeup(void)
 {
 	bool wakeup = kthread_should_stop() || need_wakeup ||
@@ -118,6 +156,16 @@ static inline bool kscand_should_wakeup(void)
 	return wakeup;
 }
 
+static inline bool kmigrated_should_wakeup(void)
+{
+	bool wakeup = kthread_should_stop() || migrated_need_wakeup ||
+	       time_after_eq(jiffies, kmigrated_sleep_expire);
+
+	migrated_need_wakeup = false;
+
+	return wakeup;
+}
+
 static void kscand_wait_work(void)
 {
 	const unsigned long scan_sleep_jiffies =
@@ -133,6 +181,85 @@ static void kscand_wait_work(void)
 			scan_sleep_jiffies);
 }
 
+static void kmigrated_wait_work(void)
+{
+	const unsigned long migrate_sleep_jiffies =
+		msecs_to_jiffies(kmigrate_sleep_ms);
+
+	if (!migrate_sleep_jiffies)
+		return;
+
+	kmigrated_sleep_expire = jiffies + migrate_sleep_jiffies;
+	wait_event_timeout(kmigrated_wait, kmigrated_should_wakeup(),
+			migrate_sleep_jiffies);
+}
+
+/*
+ * Do not know what info to pass in the future to make
+ * decision on taget node. Keep it void * now.
+ */
+static int kscand_get_target_node(void *data)
+{
+	return kscand_target_node;
+}
+
+extern bool migrate_balanced_pgdat(struct pglist_data *pgdat,
+					unsigned long nr_migrate_pages);
+
+/*XXX: Taken from migrate.c to avoid NUMAB mode=2 and NULL vma checks*/
+static int kscand_migrate_misplaced_folio_prepare(struct folio *folio,
+		struct vm_area_struct *vma, int node)
+{
+	int nr_pages = folio_nr_pages(folio);
+	pg_data_t *pgdat = NODE_DATA(node);
+
+	if (folio_is_file_lru(folio)) {
+		/*
+		 * Do not migrate file folios that are mapped in multiple
+		 * processes with execute permissions as they are probably
+		 * shared libraries.
+		 *
+		 * See folio_maybe_mapped_shared() on possible imprecision
+		 * when we cannot easily detect if a folio is shared.
+		 */
+		if (vma && (vma->vm_flags & VM_EXEC) &&
+		    folio_maybe_mapped_shared(folio))
+			return -EACCES;
+		/*
+		 * Do not migrate dirty folios as not all filesystems can move
+		 * dirty folios in MIGRATE_ASYNC mode which is a waste of
+		 * cycles.
+		 */
+		if (folio_test_dirty(folio))
+			return -EAGAIN;
+	}
+
+	/* Avoid migrating to a node that is nearly full */
+	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
+		int z;
+
+		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
+			if (managed_zone(pgdat->node_zones + z))
+				break;
+		}
+
+		if (z < 0)
+			return -EAGAIN;
+
+		wakeup_kswapd(pgdat->node_zones + z, 0,
+			      folio_order(folio), ZONE_MOVABLE);
+		return -EAGAIN;
+	}
+
+	if (!folio_isolate_lru(folio))
+		return -EAGAIN;
+
+	node_stat_mod_folio(folio, NR_ISOLATED_ANON + folio_is_file_lru(folio),
+			    nr_pages);
+
+	return 0;
+}
+
 static inline bool is_valid_folio(struct folio *folio)
 {
 	if (!folio || !folio_mapped(folio) || !folio_raw_mapping(folio))
@@ -145,18 +272,113 @@ static inline bool is_valid_folio(struct folio *folio)
 	return true;
 }
 
-static inline void kmigrated_wait_work(void)
+enum kscand_migration_err {
+	KSCAND_NULL_MM = 1,
+	KSCAND_EXITING_MM,
+	KSCAND_INVALID_FOLIO,
+	KSCAND_NONLRU_FOLIO,
+	KSCAND_INELIGIBLE_SRC_NODE,
+	KSCAND_SAME_SRC_DEST_NODE,
+	KSCAND_PTE_NOT_PRESENT,
+	KSCAND_PMD_NOT_PRESENT,
+	KSCAND_NO_PTE_OFFSET_MAP_LOCK,
+	KSCAND_NOT_HOT_PAGE,
+	KSCAND_LRU_ISOLATION_ERR,
+};
+
+
+static bool is_hot_page(struct folio *folio)
 {
-	const unsigned long migrate_sleep_jiffies =
-		msecs_to_jiffies(kmigrate_sleep_ms);
+	bool ret = false;
 
-	if (!migrate_sleep_jiffies)
-		return;
+	if (!folio_test_idle(folio))
+		ret = folio_test_referenced(folio) || folio_test_young(folio);
 
-	kmigrated_sleep_expire = jiffies + migrate_sleep_jiffies;
-	wait_event_timeout(kmigrated_wait,
-			true,
-			migrate_sleep_jiffies);
+	return ret;
+}
+
+static int kmigrated_promote_folio(struct kscand_migrate_info *info,
+					struct mm_struct *mm,
+					int destnid)
+{
+	unsigned long pfn;
+	unsigned long address;
+	struct page *page;
+	struct folio *folio = NULL;
+	int ret;
+	pmd_t *pmd;
+	pte_t *pte;
+	spinlock_t *ptl;
+	pmd_t pmde;
+	int srcnid;
+
+	if (mm == NULL)
+		return KSCAND_NULL_MM;
+
+	if (mm == READ_ONCE(kmigrated_cur_mm) &&
+		READ_ONCE(kmigrated_clean_list)) {
+		WARN_ON_ONCE(mm);
+		return KSCAND_EXITING_MM;
+	}
+
+	pfn = info->pfn;
+	address = info->address;
+	page = pfn_to_online_page(pfn);
+
+	if (page)
+		folio = page_folio(page);
+
+	if (!page || PageTail(page) || !is_valid_folio(folio))
+		return KSCAND_INVALID_FOLIO;
+
+	if (!folio_test_lru(folio))
+		return KSCAND_NONLRU_FOLIO;
+
+	if (!is_hot_page(folio))
+		return KSCAND_NOT_HOT_PAGE;
+
+	folio_get(folio);
+
+	srcnid = folio_nid(folio);
+
+	/* Do not try to promote pages from regular nodes */
+	if (!kscand_eligible_srcnid(srcnid)) {
+		folio_put(folio);
+		return KSCAND_INELIGIBLE_SRC_NODE;
+	}
+
+	/* Also happen when it is already migrated */
+	if (srcnid == destnid) {
+		folio_put(folio);
+		return KSCAND_SAME_SRC_DEST_NODE;
+	}
+
+	address = info->address;
+	pmd = pmd_off(mm, address);
+	pmde = pmdp_get(pmd);
+
+	if (!pmd_present(pmde)) {
+		folio_put(folio);
+		return KSCAND_PMD_NOT_PRESENT;
+	}
+
+	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
+	if (!pte) {
+		folio_put(folio);
+		WARN_ON_ONCE(!pte);
+		return KSCAND_NO_PTE_OFFSET_MAP_LOCK;
+	}
+
+	ret = kscand_migrate_misplaced_folio_prepare(folio, NULL, destnid);
+
+	folio_put(folio);
+	pte_unmap_unlock(pte, ptl);
+
+	if (ret)
+		return KSCAND_LRU_ISOLATION_ERR;
+
+
+	return  migrate_misplaced_folio(folio, destnid);
 }
 
 static bool folio_idle_clear_pte_refs_one(struct folio *folio,
@@ -302,6 +524,115 @@ static inline int kscand_test_exit(struct mm_struct *mm)
 	return atomic_read(&mm->mm_users) == 0;
 }
 
+struct destroy_list_work {
+	struct list_head migrate_head;
+	struct work_struct dwork;
+};
+
+static void kmigrated_destroy_list_fn(struct work_struct *work)
+{
+	struct destroy_list_work *dlw;
+	struct kscand_migrate_info *info, *tmp;
+
+	dlw = container_of(work, struct destroy_list_work, dwork);
+
+	if (!list_empty(&dlw->migrate_head)) {
+		list_for_each_entry_safe(info, tmp, &dlw->migrate_head,	migrate_node) {
+			list_del(&info->migrate_node);
+			kfree(info);
+		}
+	}
+
+	kfree(dlw);
+}
+
+static void kmigrated_destroy_list(struct list_head *list_head)
+{
+	struct destroy_list_work *destroy_list_work;
+
+
+	destroy_list_work = kmalloc(sizeof(*destroy_list_work), GFP_KERNEL);
+	if (!destroy_list_work)
+		return;
+
+	INIT_LIST_HEAD(&destroy_list_work->migrate_head);
+	list_splice_tail_init(list_head, &destroy_list_work->migrate_head);
+	INIT_WORK(&destroy_list_work->dwork, kmigrated_destroy_list_fn);
+	schedule_work(&destroy_list_work->dwork);
+}
+
+static struct kmigrated_mm_slot *kmigrated_get_mm_slot(struct mm_struct *mm, bool alloc)
+{
+	struct kmigrated_mm_slot *mm_slot = NULL;
+	struct mm_slot *slot;
+
+	guard(spinlock)(&kscand_migrate_lock);
+
+	slot = mm_slot_lookup(kmigrated_slots_hash, mm);
+	mm_slot = mm_slot_entry(slot, struct kmigrated_mm_slot, mm_slot);
+
+	if (!mm_slot && alloc) {
+		mm_slot = mm_slot_alloc(kmigrated_slot_cache);
+		if (!mm_slot) {
+			spin_unlock(&kscand_migrate_lock);
+			return NULL;
+		}
+
+		slot = &mm_slot->mm_slot;
+		INIT_LIST_HEAD(&mm_slot->migrate_head);
+		spin_lock_init(&mm_slot->migrate_lock);
+		mm_slot_insert(kmigrated_slots_hash, mm, slot);
+		list_add_tail(&slot->mm_node, &kmigrated_daemon.mm_head);
+	}
+
+	return mm_slot;
+}
+
+static void kscand_cleanup_migration_list(struct mm_struct *mm)
+{
+	struct kmigrated_mm_slot *mm_slot;
+	struct mm_slot *slot;
+
+	mm_slot = kmigrated_get_mm_slot(mm, false);
+
+	slot = &mm_slot->mm_slot;
+
+	if (mm_slot && slot && slot->mm == mm) {
+		spin_lock(&mm_slot->migrate_lock);
+
+		if (!list_empty(&mm_slot->migrate_head)) {
+			if (mm == READ_ONCE(kmigrated_cur_mm)) {
+				/* A folio in this mm is being migrated. wait */
+				WRITE_ONCE(kmigrated_clean_list, true);
+			}
+
+			kmigrated_destroy_list(&mm_slot->migrate_head);
+			spin_unlock(&mm_slot->migrate_lock);
+retry:
+			if (!spin_trylock(&mm_slot->migrate_lock)) {
+				cpu_relax();
+				goto retry;
+			}
+
+			if (mm == READ_ONCE(kmigrated_cur_mm)) {
+				spin_unlock(&mm_slot->migrate_lock);
+				goto retry;
+			}
+		}
+		/* Reset migrated mm_slot if it was pointing to us */
+		if (kmigrated_daemon.mm_slot == mm_slot)
+			kmigrated_daemon.mm_slot = NULL;
+
+		hash_del(&slot->hash);
+		list_del(&slot->mm_node);
+		mm_slot_free(kmigrated_slot_cache, mm_slot);
+
+		WRITE_ONCE(kmigrated_clean_list, false);
+
+		spin_unlock(&mm_slot->migrate_lock);
+		}
+}
+
 static void kscand_collect_mm_slot(struct kscand_mm_slot *mm_slot)
 {
 	struct mm_slot *slot = &mm_slot->slot;
@@ -313,11 +644,77 @@ static void kscand_collect_mm_slot(struct kscand_mm_slot *mm_slot)
 		hash_del(&slot->hash);
 		list_del(&slot->mm_node);
 
+		kscand_cleanup_migration_list(mm);
+
 		mm_slot_free(kscand_slot_cache, mm_slot);
 		mmdrop(mm);
 	}
 }
 
+static void kmigrated_migrate_mm(struct kmigrated_mm_slot *mm_slot)
+{
+	int ret = 0, dest = -1;
+	struct mm_slot *slot;
+	struct mm_struct *mm;
+	struct kscand_migrate_info *info, *tmp;
+
+	spin_lock(&mm_slot->migrate_lock);
+
+	slot = &mm_slot->mm_slot;
+	mm = slot->mm;
+
+	if (!list_empty(&mm_slot->migrate_head)) {
+		list_for_each_entry_safe(info, tmp, &mm_slot->migrate_head,
+				migrate_node) {
+			if (READ_ONCE(kmigrated_clean_list))
+				goto clean_list_handled;
+
+			list_del(&info->migrate_node);
+
+			spin_unlock(&mm_slot->migrate_lock);
+
+			dest = kscand_get_target_node(NULL);
+			ret = kmigrated_promote_folio(info, mm, dest);
+
+			kfree(info);
+
+			cond_resched();
+			spin_lock(&mm_slot->migrate_lock);
+		}
+	}
+clean_list_handled:
+	/* Reset  mm  of folio entry we are migrating */
+	WRITE_ONCE(kmigrated_cur_mm, NULL);
+	spin_unlock(&mm_slot->migrate_lock);
+}
+
+static void kmigrated_migrate_folio(void)
+{
+	/* for each mm do migrate */
+	struct kmigrated_mm_slot *kmigrated_mm_slot = NULL;
+	struct mm_slot *slot;
+
+	if (!list_empty(&kmigrated_daemon.mm_head)) {
+
+		scoped_guard (spinlock, &kscand_migrate_lock) {
+			if (kmigrated_daemon.mm_slot) {
+				kmigrated_mm_slot = kmigrated_daemon.mm_slot;
+			} else {
+				slot = list_entry(kmigrated_daemon.mm_head.next,
+						struct mm_slot, mm_node);
+
+				kmigrated_mm_slot = mm_slot_entry(slot,
+						struct kmigrated_mm_slot, mm_slot);
+				kmigrated_daemon.mm_slot = kmigrated_mm_slot;
+			}
+			WRITE_ONCE(kmigrated_cur_mm, kmigrated_mm_slot->mm_slot.mm);
+		}
+
+		if (kmigrated_mm_slot)
+			kmigrated_migrate_mm(kmigrated_mm_slot);
+	}
+}
+
 static unsigned long kscand_scan_mm_slot(void)
 {
 	bool next_mm = false;
@@ -331,6 +728,7 @@ static unsigned long kscand_scan_mm_slot(void)
 	struct vm_area_struct *vma = NULL;
 	struct kscand_mm_slot *mm_slot;
 
+	struct kmigrated_mm_slot *kmigrated_mm_slot = NULL;
 
 	spin_lock(&kscand_mm_lock);
 
@@ -360,13 +758,23 @@ static unsigned long kscand_scan_mm_slot(void)
 
 	VMA_ITERATOR(vmi, mm, address);
 
+	kmigrated_mm_slot = kmigrated_get_mm_slot(mm, false);
+
 	for_each_vma(vmi, vma) {
 		kscand_walk_page_vma(vma, &kscand_scanctrl);
 		vma_scanned_size += vma->vm_end - vma->vm_start;
 
 		if (vma_scanned_size >= kscand_scan_size) {
 			next_mm = true;
-			/* TBD: Add scanned folios to migration list */
+
+			if (!list_empty(&kscand_scanctrl.scan_list)) {
+				if (!kmigrated_mm_slot)
+					kmigrated_mm_slot = kmigrated_get_mm_slot(mm, true);
+				spin_lock(&kmigrated_mm_slot->migrate_lock);
+				list_splice_tail_init(&kscand_scanctrl.scan_list,
+						&kmigrated_mm_slot->migrate_head);
+				spin_unlock(&kmigrated_mm_slot->migrate_lock);
+			}
 			break;
 		}
 	}
@@ -462,6 +870,8 @@ static int kscand(void *none)
 static inline void kscand_destroy(void)
 {
 	kmem_cache_destroy(kscand_slot_cache);
+	/* XXX: move below to kmigrated thread */
+	kmem_cache_destroy(kmigrated_slot_cache);
 }
 
 void __kscand_enter(struct mm_struct *mm)
@@ -497,7 +907,7 @@ void __kscand_exit(struct mm_struct *mm)
 {
 	struct kscand_mm_slot *mm_slot;
 	struct mm_slot *slot;
-	int free = 0;
+	int free = 0, serialize = 1;
 
 	spin_lock(&kscand_mm_lock);
 	slot = mm_slot_lookup(kscand_slots_hash, mm);
@@ -512,10 +922,15 @@ void __kscand_exit(struct mm_struct *mm)
 		free = 1;
 		/* TBD: Set the actual next slot */
 		kscand_scan.mm_slot = NULL;
+	} else if (mm_slot && kscand_scan.mm_slot == mm_slot && mm_slot->is_scanned) {
+		serialize = 0;
 	}
 
 	spin_unlock(&kscand_mm_lock);
 
+	if (serialize)
+		kscand_cleanup_migration_list(mm);
+
 	if (free) {
 		mm_slot_free(kscand_slot_cache, mm_slot);
 		mmdrop(mm);
@@ -567,6 +982,8 @@ static int kmigrated(void *arg)
 		WRITE_ONCE(migrated_need_wakeup, false);
 		if (unlikely(kthread_should_stop()))
 			break;
+		if (kmigrated_has_work())
+			kmigrated_migrate_folio();
 		msleep(20);
 		kmigrated_wait_work();
 	}
@@ -607,7 +1024,9 @@ static int stop_kmigrated(void)
 static inline void init_list(void)
 {
 	INIT_LIST_HEAD(&kscand_scanctrl.scan_list);
+	spin_lock_init(&kscand_migrate_lock);
 	init_waitqueue_head(&kscand_wait);
+	init_waitqueue_head(&kmigrated_wait);
 }
 
 static int __init kscand_init(void)
@@ -621,6 +1040,13 @@ static int __init kscand_init(void)
 		return -ENOMEM;
 	}
 
+	kmigrated_slot_cache = KMEM_CACHE(kmigrated_mm_slot, 0);
+
+	if (!kmigrated_slot_cache) {
+		pr_err("kmigrated: kmem_cache error");
+		return -ENOMEM;
+	}
+
 	init_list();
 	err = start_kscand();
 	if (err)
diff --git a/mm/migrate.c b/mm/migrate.c
index 2c88f3b33833..1f74dd5e6776 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2541,7 +2541,7 @@ SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,
  * Returns true if this is a safe migration target node for misplaced NUMA
  * pages. Currently it only checks the watermarks which is crude.
  */
-static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
+bool migrate_balanced_pgdat(struct pglist_data *pgdat,
 				   unsigned long nr_migrate_pages)
 {
 	int z;
-- 
2.34.1


