Return-Path: <linux-kernel+bounces-768947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2F5B2683D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05871BC4A17
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3094C2FFDDE;
	Thu, 14 Aug 2025 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ve7b3z4T"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C43002DA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179528; cv=fail; b=p0Jv5NSHqG+1Tsq0D0MOdXz0HH1v9vwx9yteML5XaQdi07Ffk4nS6TsQz3fdcf5Ud6v+6YqmUMpo8xahxhEr7YRavO+l/V3qq5MPV8C6QYQkMt4I/rhPPrqzBi27pk2EwCIi+QLansQ1Paw6m+dsBkClkzUVriF2Vu27ccSB9fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179528; c=relaxed/simple;
	bh=8eBnjdXdPGHsQUEPBA0cAmFoUNp+FnwkNib0vyXqwjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQUOMuJgns74oJ5GSMttO3reaOWnwhomGCAcw51CIa2IWnSu4PGz3VJktfDjyN2ItI3Pj4X7XYaRAbvLYExp+3Cezydobad+sL1kZWKwe9Lo+/CrNraaJ5956WaMQ0V5n32jrZC4a57+VyyzSRXNPuYO5kbwriH9pHbnA+1Op30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ve7b3z4T; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEUvl4Hg/OoUCnTVvQrg0e/FpT+wwybquJyXTTiI4rXR8jU5HmCdd0fil5CMdWAgHqI2omm+bHzyOEPJpRF7omVs1HJvnJJdM33znNwQ7WA0EdETXQNk3LdN3sl20p7NLa26Zw0ktN0wr2+/1W0DOUe+w2HL2blFgOZlXasrw31NzMUlIB6T733UAMtGR+a7WMAzFoZagge41iHlhNQYQ+cUVOZz7XTiQbDSgqtxbhkdA0RdJ/P57je4bO+RQyF1WyKVcYtTF3qWkft6kckVfjtxmscqq3rlQ0oWC6ylf+v12emNduDp/K3c6mNJChhX8BgYe4O5n/FW8kI5RvP4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASDDVWBlvpWk8ylFhtNpksGQPki3w5626qkyrBfz2EA=;
 b=bg+vyPwuCcNPiu58dVzH6Lk4yJUO/0Z2wlxet79lYAP8TMAIxlrG1Y1pNoVfn16dWze2HtzJkU7WCukBVCareR+l5bMDaLq7oH62tB2Zj+iSXI+ghlidAZbstNUoipvHHakkDFLjxH3jOueMoOVePdIng7x7BgYtwEDR2X5Lo4vYoy9ta2Ppr1ur8UPCLlJllhniYs5q7l2oq8jFC5k6oJs4k6znauNOK4xsetfcgc00vQG0ISO2fHPiXNS/3dekI79RmuTP36fGIp01YatWA2GjosoYRPPCpuqN0F/WqLSDRHmY2jyuAM+Co1Qf1xA8NOWkv+XRn3tIGIO3SVwLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASDDVWBlvpWk8ylFhtNpksGQPki3w5626qkyrBfz2EA=;
 b=Ve7b3z4Tjqk1ixC6eDWWb2wBGbM7aSuJahs5QETbUe76wArYaiXJ512cjPkykOmIrUn/oteBUtGnuBCbvSJcLuljSf5rVf0t2eB383WKnST0zco9VBqWMJtG7OwF67mkICSfXQmZifa+v2jGJrYvqhAaMzGWUJziIxckA7TBMYE=
Received: from DS7PR03CA0291.namprd03.prod.outlook.com (2603:10b6:5:3ad::26)
 by SA3PR12MB7857.namprd12.prod.outlook.com (2603:10b6:806:31e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 13:52:01 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::e6) by DS7PR03CA0291.outlook.office365.com
 (2603:10b6:5:3ad::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Thu,
 14 Aug 2025 13:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 13:52:01 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 08:51:53 -0500
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
	Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH v1 7/7] mm: klruscand: use mglru scanning for page promotion
Date: Thu, 14 Aug 2025 19:18:26 +0530
Message-ID: <20250814134826.154003-8-bharata@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814134826.154003-1-bharata@amd.com>
References: <20250814134826.154003-1-bharata@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|SA3PR12MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9696a4-47aa-47b1-7991-08dddb39be6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FNwLF82c9D5b+X7qTKERz89nWUq2zFgnttWBqUXYAyibW7mfPyBQFp6pYC6W?=
 =?us-ascii?Q?J4chg++ci1/OglgCzTUYhJCVRtP4miE0iml1ybd8QO78f9bGTrB6bVdDhgdD?=
 =?us-ascii?Q?Foc8bXdtMgpMLBsGuHSxtNo6qZtk4ItsRFTkCsdCzUaTEUenxf97v+HUs06I?=
 =?us-ascii?Q?BWUOzJQJv3DFC1or4+67ijSPw44YHfnLnMZGsIxAL1KfZ1ZgfrlsweqIrNGP?=
 =?us-ascii?Q?eMLMNbiNPPuPZIR76oflydSLU+kyTLOfu1Ixzk8x4r7w05d1M26ICzZpfLu/?=
 =?us-ascii?Q?VCZNeSRLPRsoYmS7gZzR90lfX1jnrtFgFrtRd5UD2A134aU81RPZIL1Fq/0x?=
 =?us-ascii?Q?TnFEZRZoHBw8VNvx2zojY2hjve3ud8TbrQZTTxSGfovC/4RnM69WKT3HPfq+?=
 =?us-ascii?Q?Z0wWsu5HTpcA6uks5jng3fesqikek4PYriCIo++ipj1S3twdt5iqtPSplC39?=
 =?us-ascii?Q?QG8zjdJjesIzWdrJNXXD2109UmA+0Qx1FgWtZpd311/sOqJ5XTY5GnVuwewI?=
 =?us-ascii?Q?k8GUAMW5+9EJ2dEfTCWBRqX9Y2ZFCINO0CHpG+g1BntdVg6sEZR3ztqhHXRV?=
 =?us-ascii?Q?BQSD9g9nM2d/vyiScWpoHGQO0HdGsWw3r2DTTrwiGtKtjijOao4pB7sKz6L0?=
 =?us-ascii?Q?HeD8x0oIu8ZdeaUSRx9+RNuuFhdRzDpv/HNWCTNTbCXDYBBsfz1qZU2F8vpM?=
 =?us-ascii?Q?rPuxFHlhjy6iyIFz5GKXR+Pa1WbdMZLXdHPMOC47zs2zFr0XaRwwh558tlTY?=
 =?us-ascii?Q?Pkty8HBsygFJNjfCUBOXIZccEcVrsm4ZeVutJ1AShz0fRLcRjOjw86Ky6iSp?=
 =?us-ascii?Q?Fh7DvMoIw5F8J85OZtpFlvBLyVIqke0uwByGXBuOolZvZkh8DR3quJoWDrkA?=
 =?us-ascii?Q?ndfBeAiCWZ6crudAm8E4jlES8h60SJlPsh7SnTH2k5O2g/9wgrhnLR2c2URv?=
 =?us-ascii?Q?V9ye5uVdCArCjVBYkVeKIn+CpItqixwJzYAuQ4JMqWIDZR058HYyvgOGm6+d?=
 =?us-ascii?Q?wtcMqD2heQrY9VcVNegWzh60bUZVkIeZO5sZgl9/Yd/dMbrfiIbSnTf39Uy5?=
 =?us-ascii?Q?o19fFe52GdLmkEa9fQUR6Y2dF6L94YPLRDRYF9lZCBX04lwuSsaPiZwm17cy?=
 =?us-ascii?Q?Z8DDlF0QDcoxoXAFw3nOQ948+Ua+NOMopzdmYslAo3S7EJkSU7HSQNk0a27L?=
 =?us-ascii?Q?VdwAqR7tG91dmGluJhXnJDUe+qtMt16JE49l+a1dLfJX78MLgq6PbGs7SmQ5?=
 =?us-ascii?Q?esscIdbTPVnJPk08qhbuP8wKLn45ApyR9DQNL/V7G7xshAdGXframmNzAhC/?=
 =?us-ascii?Q?u3ZAZFDzveXfPO56ipNDkEfN69PrWW23kVZBOfHbh/t8pkSe9ny5fYSalXPn?=
 =?us-ascii?Q?sYof/7rvKj3r/s2A6u+dEYAuYLs6GMXDMxrVpehiXPeUf9O/KqYZqIAQljVN?=
 =?us-ascii?Q?1JP8o1cJCyfYhwPNITTUb2ufmpgJ6qoyDnnV31eQI0t8EouC6rQUGEpp+YV3?=
 =?us-ascii?Q?s5nZ2RufWcecIZiecjmJwRVYfbEQh0ww2q6T?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:52:01.0194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9696a4-47aa-47b1-7991-08dddb39be6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7857

From: Kinsey Ho <kinseyho@google.com>

Introduce a new kernel daemon, klruscand, that periodically invokes the
MGLRU page table walk. It leverages the new callbacks to gather access
information and forwards it to the pghot hot page tracking sub-system
for promotion decisions.

This benefits from reusing the existing MGLRU page table walk
infrastructure, which is optimized with features such as hierarchical
scanning and bloom filters to reduce CPU overhead.

As an additional optimization to be added in the future, we can tune
the scan intervals for each memcg.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
Signed-off-by: Bharata B Rao <bharata@amd.com>
	[Reduced the scan interval to 100ms, pfn_t to unsigned long]
---
 mm/Kconfig     |   8 ++++
 mm/Makefile    |   1 +
 mm/klruscand.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 mm/klruscand.c

diff --git a/mm/Kconfig b/mm/Kconfig
index 8b236eb874cf..6d53c1208729 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1393,6 +1393,14 @@ config PGHOT
 	  by various sources. Asynchronous promotion is done by per-node
 	  kernel threads.
 
+config KLRUSCAND
+	bool "Kernel lower tier access scan daemon"
+	default y
+	depends on PGHOT && LRU_GEN_WALKS_MMU
+	help
+	  Scan for accesses from lower tiers by invoking MGLRU to perform
+	  page table walks.
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 8799bd0c68ed..1d39ef55f3e5 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -148,3 +148,4 @@ obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
 obj-$(CONFIG_PGHOT) += kpromoted.o
+obj-$(CONFIG_KLRUSCAND) += klruscand.o
diff --git a/mm/klruscand.c b/mm/klruscand.c
new file mode 100644
index 000000000000..1a51aab29bd9
--- /dev/null
+++ b/mm/klruscand.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/memcontrol.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/random.h>
+#include <linux/migrate.h>
+#include <linux/mm_inline.h>
+#include <linux/slab.h>
+#include <linux/sched/clock.h>
+#include <linux/memory-tiers.h>
+#include <linux/sched/mm.h>
+#include <linux/sched.h>
+#include <linux/pghot.h>
+
+#include "internal.h"
+
+#define KLRUSCAND_INTERVAL_MS 100
+#define BATCH_SIZE (2 << 16)
+
+static struct task_struct *scan_thread;
+static unsigned long pfn_batch[BATCH_SIZE];
+static int batch_index;
+
+static void flush_cb(void)
+{
+	int i = 0;
+
+	for (; i < batch_index; i++) {
+		u64 pfn = pfn_batch[i];
+
+		pghot_record_access((unsigned long)pfn, NUMA_NO_NODE,
+					PGHOT_PGTABLE_SCAN, jiffies);
+
+		if (i % 16 == 0)
+			cond_resched();
+	}
+	batch_index = 0;
+}
+
+static int accessed_cb(unsigned long pfn)
+{
+	if (batch_index >= BATCH_SIZE)
+		return -EAGAIN;
+
+	pfn_batch[batch_index++] = pfn;
+	return 0;
+}
+
+static int klruscand_run(void *unused)
+{
+	struct lru_gen_mm_walk *walk;
+
+	walk = kzalloc(sizeof(*walk),
+		       __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
+	if (!walk)
+		return -ENOMEM;
+
+	while (!kthread_should_stop()) {
+		unsigned long next_wake_time;
+		long sleep_time;
+		struct mem_cgroup *memcg;
+		int flags;
+		int nid;
+
+		next_wake_time = jiffies + msecs_to_jiffies(KLRUSCAND_INTERVAL_MS);
+
+		for_each_node_state(nid, N_MEMORY) {
+			pg_data_t *pgdat = NODE_DATA(nid);
+			struct reclaim_state rs = { 0 };
+
+			if (node_is_toptier(nid))
+				continue;
+
+			rs.mm_walk = walk;
+			set_task_reclaim_state(current, &rs);
+			flags = memalloc_noreclaim_save();
+
+			memcg = mem_cgroup_iter(NULL, NULL, NULL);
+			do {
+				struct lruvec *lruvec =
+					mem_cgroup_lruvec(memcg, pgdat);
+				unsigned long max_seq =
+					READ_ONCE((lruvec)->lrugen.max_seq);
+
+				lru_gen_scan_lruvec(lruvec, max_seq,
+						    accessed_cb, flush_cb);
+				cond_resched();
+			} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
+
+			memalloc_noreclaim_restore(flags);
+			set_task_reclaim_state(current, NULL);
+			memset(walk, 0, sizeof(*walk));
+		}
+
+		sleep_time = next_wake_time - jiffies;
+		if (sleep_time > 0 && sleep_time != MAX_SCHEDULE_TIMEOUT)
+			schedule_timeout_idle(sleep_time);
+	}
+	kfree(walk);
+	return 0;
+}
+
+static int __init klruscand_init(void)
+{
+	struct task_struct *task;
+
+	task = kthread_run(klruscand_run, NULL, "klruscand");
+
+	if (IS_ERR(task)) {
+		pr_err("Failed to create klruscand kthread\n");
+		return PTR_ERR(task);
+	}
+
+	scan_thread = task;
+	return 0;
+}
+module_init(klruscand_init);
-- 
2.34.1


