Return-Path: <linux-kernel+bounces-769177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D9FB26B22
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF84A2657A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22604230D1E;
	Thu, 14 Aug 2025 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NVXcTV8I"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEA222CBD3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185629; cv=fail; b=q8hOMcyfWixocOwR4g3t/Gz1Vm8DkXkDr67Sdp/cX4YehNSYr12Z4sTgzcEyG4+uQ0m0I+aHg1T+ss7Z2zLBIgdQHwrrJ8sB4LErc05KkxBkPb5f/CmA5FPIDdMo8ULI/dj8E8fmnicTxFyBeg7EXn0+1z3fsnyyu3SjA5bMJCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185629; c=relaxed/simple;
	bh=WFHzEkmBJPmOUQBndk9D31F/Lx/AhrKCtA1eXPm0vEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8sYi2vfBOVAbRlLQHRYD8K7zhoKIKXhwkYdYfRHapZwauFzRujBPJRr57hftY8X0M8xQhDrHRu31rK95lhWz0brv+EbzanJLaWge2KpE9Y1nvc4FJe1JhsBILQ0EvxX3x3ao6OzNe4cWrTX7TQkDUeJQcoOpDfPmIL8ppL5Wsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NVXcTV8I; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdUU7Ck7x6dZNShMXaxIVekgHrFGGe8PAlfgjtY9hom+hUANsJSBedsvrEx2zFtixFA/V6zuvQgHHBVWttWpVLEtajYtx6Kcon269mCN+oYB8HeoCRFwHpb7of1PCo3t/j6FwZ99zNE1ZECz8DfZaUEJt1uhTloGp+fVAT799xYd1Q/QNnJBKqN07uXgZCY8+IArU+EcpAAeMehmNBYTHChZ6zFnoLnkEiIZwwblypSAU4n/jb4Yi+JJM82ZwWujXNClMS3GoKdyktNsEsh5+CWpLBLMtyGH4jbuRnOEuRoLIuPuzmh8CzjxJALCypOp63Dbv63HlMroJCSZLzz+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8ZBHsg2ICU7iooyE/1e0HC8I4bKgZSlDZ7JgRXUGVc=;
 b=nv51vOeQR3zgDkhN88W0/2MwSjkAKBMsiyYri9/JBaQY4gS1gNUeSQ4VUKL5ZbhXCnaXLHichFijyHVr6or5Epp/qNSrWfWg17oJzb4WkVUA15Q+vnzke7hLCuTvNVTZSPLQofGmcLPAoNeqk9Bu6FytLtVkH6HJR3kUCYDaIZhz/llJvQcnx+O8+1YiNzAP3EknfGhQy9RNetlyse/xSZUtXAZVrLC79Rcc0vd8yeNrAkU9bbTiZo6U0e/M/aA+pZ7+E3sxAAnRXeKZwYcflM6wPW+7ieA+fc+qiln6vp9p+jtYfLOl8qdquwjtzvC2yRz2L1jU2EkRj5GWswcrFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8ZBHsg2ICU7iooyE/1e0HC8I4bKgZSlDZ7JgRXUGVc=;
 b=NVXcTV8I79svMtDXpPLQXb3A+MMjtT5kcOjUsP6sgXtuianhYbnKy4U5N8wkZW4+D7+63bvJJUXrc56k4tQxksXzWdnftBrdTjo8XCEtsUbrn/08D1ye+f2EItnaMC0wZXRFQoUxXlj/g8SVV83uUScOU2VAAYXm/KKr6GQMyzo=
Received: from MN0PR04CA0003.namprd04.prod.outlook.com (2603:10b6:208:52d::15)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 15:33:43 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::bf) by MN0PR04CA0003.outlook.office365.com
 (2603:10b6:208:52d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 15:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 15:33:42 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 10:33:31 -0500
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
Subject: [RFC PATCH V3 01/17] mm: Add kscand kthread for PTE A bit scan
Date: Thu, 14 Aug 2025 15:32:51 +0000
Message-ID: <20250814153307.1553061-2-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc26e38-0182-48ea-8adc-08dddb47f338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IaI4EpwIE6SWNJTbatCz3Wi+R1Xlop3wsKrgg0M1U5/S1ha6cNrVgdX4ievG?=
 =?us-ascii?Q?ZJLJfMEYAgEWbHJxPx1QPCOiN0H/WMBvq/whI1bhh1QIb4OCmld4dUzTU3tG?=
 =?us-ascii?Q?wWNFAlACBmoeaTHdHhoslkmBYptFmwzvvihRWd1Znkv2909Bl/334zbyeLEp?=
 =?us-ascii?Q?UY5TrpryA1PFlt8viKQGrmDwJuJ9dw5KansFCnY76OjowNawnN/Qqr9rBErr?=
 =?us-ascii?Q?O309mR1XtFVrheMprlOXHiFNYjATYSTgiXxouFdiZo7RHG+1AGvwRkuUyzYg?=
 =?us-ascii?Q?S1h4pZpldhwoGzQFHtD8AQruQmBsTvJltmZzeQ3cntaVqHnDjQasYkwov2Po?=
 =?us-ascii?Q?N2dAIDv8dt1aZqFWvpBP/gTDXazU04BMKyKx16T+/veuPN19v7zowK2PstPD?=
 =?us-ascii?Q?WYRYF/obZw5Eg7mN7bbwXnu/rhPteT7VeseSoiWwg4Fh2sbIYsgLKDpSbPF+?=
 =?us-ascii?Q?H/u7ztZVqCUMctGLLfMshF3zGWDH4XIPFjVRng3JxwLghD/s0VsL0yc1fpq4?=
 =?us-ascii?Q?3USosIKgaLQtit6ud4FSweUOeQivSIHzfvAWyX+BB/UglfZqQun0h93sle4P?=
 =?us-ascii?Q?IidrbormP1foLGa+8tQP2IVCQCp3VRBHim0aYmXddYijcjARDhj8aAn8fwSJ?=
 =?us-ascii?Q?hhJWNr4R+bQA+4U7ZTlJCAH/9Y877u9Mxpmakr5GNuJVX4twKD1OApuoQeLP?=
 =?us-ascii?Q?9Egb/cAeCUvIQLcHhIFZI+N+7rJcsaXB8ESolYL6XVYoj2/vn8w28QL9zsQB?=
 =?us-ascii?Q?EEbithZnjU+3aO0Ytvqrsa/Cxb83YDscN0qiW4nr6C7otMhGjkjcuWacP7PC?=
 =?us-ascii?Q?bgdaS6Ew45W/HfiuKDI42zlYXYobbEJAihS4udRnRwuCqwxnvrXzXU+KWtMc?=
 =?us-ascii?Q?YaIOOgiyrb1Nbzzye19Nq5muv2kJzbSvyT1n0mV+HIphzmKKUS5Kl8qfY02o?=
 =?us-ascii?Q?vKm1+bWJme6xv6c7YB/w42NTKqFnhtvdy9KFmzwcn7D322vCTvIQG1Rgh1kE?=
 =?us-ascii?Q?F3J/FKF/wg0j2UEstQjuEcahifNHm4sJ4EsIqz3X6emNu5nxfmPoU4FLWgXO?=
 =?us-ascii?Q?hbNOS3h0LOA5bnCf3leqA1da5w2i3SWvdz8ttFcXhBlg/emARgiqGmp5EpIg?=
 =?us-ascii?Q?Uk0GM9jYNz3x0qHj3D0gw6cz8d3wqXOT5baEUb2TBzGO0nFJ0Ptl/fqUbydj?=
 =?us-ascii?Q?bU0CaXGDohI73rluqAyTjeatzzXSr5cmNw8yTww/HH4LppMhE7refstdHyIy?=
 =?us-ascii?Q?K4faDjBaghNOx8owR9Sa7G+mUYkgLZ3pEa8ZC4PgYPu1wE8OKoxYGgBx6W/z?=
 =?us-ascii?Q?LJtWgfHBesSDEDVP4w8ZGwtEtphxC+o6F+PAptmoGmdPDsvviI7spOZkdkMa?=
 =?us-ascii?Q?l2rR5GGuh25lPSz2kkXmHuKWFAvP1yyoSpP/Whk0RRJJq4WE9r/8SCRKhbNh?=
 =?us-ascii?Q?XN2AU36ItT6P2EmDqnIpsA60U+WG/sYc299XpfmH2rw8l8MjDOTSy35CiZWp?=
 =?us-ascii?Q?BSqbxoW05eNlKOYvwrFFRkKm792Ehsm6E2hX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:33:42.5792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc26e38-0182-48ea-8adc-08dddb47f338
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417

Also add a config option for the same.

High level design:

While (1):
  Scan the slowtier pages belonging to VMAs of a task.
  Add to migation list.

A separate thread:
  Migrate scanned pages to a toptier node based on heuristics.

The overall code is influenced by khugepaged design.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/Kconfig  |   8 +++
 mm/Makefile |   1 +
 mm/kscand.c | 163 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+)
 create mode 100644 mm/kscand.c

diff --git a/mm/Kconfig b/mm/Kconfig
index 781be3240e21..d1e5be76a96e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -750,6 +750,14 @@ config KSM
 	  until a program has madvised that an area is MADV_MERGEABLE, and
 	  root has set /sys/kernel/mm/ksm/run to 1 (if CONFIG_SYSFS is set).
 
+config KSCAND
+	bool "Enable PTE A bit scanning and Migration"
+	depends on NUMA_BALANCING
+	help
+	  Enable PTE A bit scanning of page. The option creates a separate
+	  kthread for scanning and migration. Accessed slow-tier pages are
+	  migrated to a regular NUMA node to reduce hot page access latency.
+
 config DEFAULT_MMAP_MIN_ADDR
 	int "Low address space to protect from user allocation"
 	depends on MMU
diff --git a/mm/Makefile b/mm/Makefile
index 1a7a11d4933d..a16ef2ff3da1 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_FAIL_PAGE_ALLOC) += fail_page_alloc.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_NUMA) += memory-tiers.o
+obj-$(CONFIG_KSCAND) += kscand.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
diff --git a/mm/kscand.c b/mm/kscand.c
new file mode 100644
index 000000000000..f7bbbc70c86a
--- /dev/null
+++ b/mm/kscand.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/mm_types.h>
+#include <linux/sched.h>
+#include <linux/sched/mm.h>
+#include <linux/mmu_notifier.h>
+#include <linux/swap.h>
+#include <linux/mm_inline.h>
+#include <linux/kthread.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+#include <linux/cleanup.h>
+
+#include <asm/pgalloc.h>
+#include "internal.h"
+
+static struct task_struct *kscand_thread __read_mostly;
+static DEFINE_MUTEX(kscand_mutex);
+
+/* How long to pause between two scan cycles */
+static unsigned int kscand_scan_sleep_ms __read_mostly = 20;
+
+/* Max number of mms to scan in one scan cycle */
+#define KSCAND_MMS_TO_SCAN	(4 * 1024UL)
+static unsigned long kscand_mms_to_scan __read_mostly = KSCAND_MMS_TO_SCAN;
+
+bool kscand_scan_enabled = true;
+static bool need_wakeup;
+
+static unsigned long kscand_sleep_expire;
+
+static DECLARE_WAIT_QUEUE_HEAD(kscand_wait);
+
+/* Data structure to keep track of current mm under scan */
+struct kscand_scan {
+	struct list_head mm_head;
+};
+
+struct kscand_scan kscand_scan = {
+	.mm_head = LIST_HEAD_INIT(kscand_scan.mm_head),
+};
+
+static inline int kscand_has_work(void)
+{
+	return !list_empty(&kscand_scan.mm_head);
+}
+
+static inline bool kscand_should_wakeup(void)
+{
+	bool wakeup = kthread_should_stop() || need_wakeup ||
+	       time_after_eq(jiffies, kscand_sleep_expire);
+
+	need_wakeup = false;
+
+	return wakeup;
+}
+
+static void kscand_wait_work(void)
+{
+	const unsigned long scan_sleep_jiffies =
+		msecs_to_jiffies(kscand_scan_sleep_ms);
+
+	if (!scan_sleep_jiffies)
+		return;
+
+	kscand_sleep_expire = jiffies + scan_sleep_jiffies;
+
+	/* Allows kthread to pause scanning */
+	wait_event_timeout(kscand_wait, kscand_should_wakeup(),
+			scan_sleep_jiffies);
+}
+static void kscand_do_scan(void)
+{
+	unsigned long iter = 0, mms_to_scan;
+
+	mms_to_scan = READ_ONCE(kscand_mms_to_scan);
+
+	while (true) {
+		if (unlikely(kthread_should_stop()) ||
+			!READ_ONCE(kscand_scan_enabled))
+			break;
+
+		if (kscand_has_work())
+			msleep(100);
+
+		iter++;
+
+		if (iter >= mms_to_scan)
+			break;
+		cond_resched();
+	}
+}
+
+static int kscand(void *none)
+{
+	while (true) {
+		if (unlikely(kthread_should_stop()))
+			break;
+
+		while (!READ_ONCE(kscand_scan_enabled)) {
+			cpu_relax();
+			kscand_wait_work();
+		}
+
+		kscand_do_scan();
+
+		kscand_wait_work();
+	}
+	return 0;
+}
+
+static int start_kscand(void)
+{
+	struct task_struct *kthread;
+
+	guard(mutex)(&kscand_mutex);
+
+	if (kscand_thread)
+		return 0;
+
+	kthread = kthread_run(kscand, NULL, "kscand");
+	if (IS_ERR(kscand_thread)) {
+		pr_err("kscand: kthread_run(kscand) failed\n");
+		return PTR_ERR(kthread);
+	}
+
+	kscand_thread = kthread;
+	pr_info("kscand: Successfully started kscand");
+
+	if (!list_empty(&kscand_scan.mm_head))
+		wake_up_interruptible(&kscand_wait);
+
+	return 0;
+}
+
+static int stop_kscand(void)
+{
+	guard(mutex)(&kscand_mutex);
+
+	if (kscand_thread) {
+		kthread_stop(kscand_thread);
+		kscand_thread = NULL;
+	}
+
+	return 0;
+}
+
+static int __init kscand_init(void)
+{
+	int err;
+
+	err = start_kscand();
+	if (err)
+		goto err_kscand;
+
+	return 0;
+
+err_kscand:
+	stop_kscand();
+
+	return err;
+}
+subsys_initcall(kscand_init);
-- 
2.34.1


