Return-Path: <linux-kernel+bounces-892396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 729DEC4501D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C937D3A1A60
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F378B2E7F03;
	Mon, 10 Nov 2025 05:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="12TEiNsQ"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5D13D76
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762752441; cv=fail; b=Ek/Ay8H/iMQFlExIdWkGKPUPcMqCZL9LUdmOAbKVwsndTYKYzggUUQ5uT6aUutNd19MAatVYBLDtA8riZ4cYXuQpbKyUSXD2G//0ReoVkoYc/591cawIkqMw+JNCDAvctpICeJz0Wfu4eJ8ViuaLhyg5OgJVYvE8HbsiqMmSQVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762752441; c=relaxed/simple;
	bh=7MrTjsp5HaibBY9vNCrLABljIzHGT7XyKFcKHCrBT8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGD9r+SDQ0f7h4tCW2FToH0A7iG4tklH8QYWvFi/GvHd3oSEio5YLhJG+/iDIeP8tNY7BC6Bkgg+6PwFvoUpvbVGpPtb8AE1bor5FeblnY5Q5X1R/abqU2RQW/yfFHa7aPycLcHzQ6PRNhLrOD/YyEhd+NqbjkrGzBn8FSrNgW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=12TEiNsQ; arc=fail smtp.client-ip=52.101.52.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfISrsE4UqfGm2WadkEScEQLdiedcSKk5KTRakGOTIFO8v5pyKjHXauqkbA0WgI2nB/4LJeF1y5PpJL3Xx3Lze81SU7ojCtld3oXUmHdYHr3KB2csgRsTCTNOf3wG65UA8jmSdySsZM8WGdNdEhj/m62NZCvxV1jkK1FtatfvN8Y7/V9t+9NJOsL804pglrbofUfrvT/jD6o3V0loyJuZbOA8ko90loYqn35wSAPJU8+G/bjcN4B2L3+AXiMZKCr7qGjdHTZG8l7ibWNPqVmTlSKF2sa1VSi9Pc6bpWrlOD3Fbb1UAOxx4fKjQeXkmVINbAq1HMe9F9J+OkZHAk3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RXKS7x2FQ6mJS0EUq5g6aDyJjBgpdjgOVW6lopD1IA=;
 b=TbkA+jQDjX9PC6sqm0XrSBFfl3vi0lbQVv3H6J5T7T4+ilg9nB42diu33c4mUkIshf/pE9IB195v3p+E3PlW2Pmn7A8oq8RDTi4kURsrlQk5esyIVVm8fYEQFarLYPriKbPqnG1jJefuDNcUz83+3apwtDEQ7m19sHS9dVj0C7m0m0hbY3qF3l+5a6zqt+p3qqgjH8FVoBYJluIDnpjuIRsbDLtxLxzVEaC75VVbcBrm9QmnQnhtnc0N5POaxHp4RPjkI5JE8JaQvIFddNomQCBHRas5DDeUopjSdrIap2nfmx27INLNrnsuhmD+ubAm8s9N4Rv7wK8ro9hv1eof/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RXKS7x2FQ6mJS0EUq5g6aDyJjBgpdjgOVW6lopD1IA=;
 b=12TEiNsQJ6VX2O5p705qfY6objkOHLAcl9mNu2ztEig5vDbAopYMe1euhOm5om4B/qzT2BQDGGzHaPsKHFFnvZgKjih3rDFgn7wEEjS+Q+mV3bZPfWYF+5prf1seFiJuH0Sm30IuQpBYkmYRF73CoIgjjr0nKHxDUi3GUqxAfD4=
Received: from SN7PR04CA0045.namprd04.prod.outlook.com (2603:10b6:806:120::20)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 05:27:15 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:120:cafe::e4) by SN7PR04CA0045.outlook.office365.com
 (2603:10b6:806:120::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 05:27:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 05:27:14 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 9 Nov
 2025 21:27:07 -0800
From: Bharata B Rao <bharata@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC: <Jonathan.Cameron@huawei.com>, <dave.hansen@intel.com>,
	<gourry@gourry.net>, <mgorman@techsingularity.net>, <mingo@redhat.com>,
	<peterz@infradead.org>, <raghavendra.kt@amd.com>, <riel@surriel.com>,
	<rientjes@google.com>, <sj@kernel.org>, <weixugc@google.com>,
	<willy@infradead.org>, <ying.huang@linux.alibaba.com>, <ziy@nvidia.com>,
	<dave@stgolabs.net>, <nifan.cxl@gmail.com>, <xuezhengchu@huawei.com>,
	<yiannis@zptcorp.com>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<byungchul@sk.com>, <kinseyho@google.com>, <joshua.hahnjy@gmail.com>,
	<yuanchu@google.com>, <balbirs@nvidia.com>, <alok.rathore@samsung.com>,
	<shivankg@amd.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH v3 7/8] mm: klruscand: use mglru scanning for page promotion
Date: Mon, 10 Nov 2025 10:53:42 +0530
Message-ID: <20251110052343.208768-8-bharata@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110052343.208768-1-bharata@amd.com>
References: <20251110052343.208768-1-bharata@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 8295be7e-de1c-4b15-4c7b-08de2019ce8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RftUtVlMzDGtWD9M3b0vdDq8lfKx54rKzoTGS0g0CmJU53mfl85EoruD6xVf?=
 =?us-ascii?Q?q6Hoy4iqofYKItVcQwo2fj0aVSBRFIqW4B/3VuRC3Lb1Sc1WEBCsM9xLTsie?=
 =?us-ascii?Q?Sd9da/6AkNpuQegFvkyfouCsACNOMhpnxqH2T18nlr4E7IRMhPf7xEWndJR1?=
 =?us-ascii?Q?bIPHXCpSMUJRE+SrVaK0E1IZCQ345IKr3MqBzGtJyAIgYvaor3qd3zJusqei?=
 =?us-ascii?Q?ggJqoHybugd3cw1OmEuPV0kx8TSNFaOgNDfCaMi8TFd16LI5sLcZndGa4vGs?=
 =?us-ascii?Q?8HneStj4qG6bHKG0o18Sg2F7ky3rjaeh4raRHwzMtiu8tcZxAmqiZpz550ic?=
 =?us-ascii?Q?wNbkh8vh6abdLK602PLg9a7gx+49y8/JbPDEY6xCJFnGXZOGJ84LLUGQlTY9?=
 =?us-ascii?Q?VsoW6aGYuEsgau7dEGre5M94g4vl+RB02zz21Joir2KTAlcveLeT+WRuqRhK?=
 =?us-ascii?Q?o1WfVYVr3Gv8im7SsJ5xxmwiikSPn3wDgk2p7CHY3U1Dh9OAoTwqwtdGd6Z2?=
 =?us-ascii?Q?jqgmzgKrpjcC/g0TkVnJXfP4udHIVPoVkavTjmtSekYVOeBt4Z95GRYJekEY?=
 =?us-ascii?Q?JYyEdkP2Rhl4SRKJn/Uw2+Z/xAnfct5qLdfiu1JGGIaQnvP2yPIMxYqlR3gr?=
 =?us-ascii?Q?P7GnEeJMTXA4YxnNnShRKp8yJT7k/aWq40xF1/OlnqP5rA2cU738L1AneDep?=
 =?us-ascii?Q?Zb87fcA8NCDz7ZDICpPAMG64ecyseax4TLwKiUDQzbe7s5ueuJI8dZHwCaYe?=
 =?us-ascii?Q?J7XcByqtNsJ/LUD+J6qGHdUhzxp/5LWYf9uUVNMXProzCai3M3XexJj05ZKK?=
 =?us-ascii?Q?IEYQ80n8ZDq3nFfcvhHgenaT/ftHmOr4HVZdYop8OYVh+ivl3ghwRpTrFlpd?=
 =?us-ascii?Q?w7IPsIMhF/sATraauxwbQOwn7u3gRPCxK+gK+BPvk+98ugQPeichebg0XyIv?=
 =?us-ascii?Q?BMt9CaMzBcAIW93KYvtBkjH5qmouwE8Y+5BQkjFIyfynH8G6TaSTHPA3SP5t?=
 =?us-ascii?Q?U+Sq9VG1GyatgwDCtN1fsogaAuwmSAfDjW3nocoLoXy/q3nnHut8+mrH0MHi?=
 =?us-ascii?Q?f2XEDS3cWnpCUdel/3+iLUP1Q+MUnTlaWxw5N9hB2CRMep8DU5zzpsjk80B2?=
 =?us-ascii?Q?/XCUYKrE0I4j/eLikZ9Dk9hqytCM9U2zlOYdUFS2zVWtYo8NY2+r7cJn4s9f?=
 =?us-ascii?Q?pxkq8diGyf7SQmCHAnYzWeatxmjr8OwJw5mzAVaQXcWgKPg5mRuT+6k8J01W?=
 =?us-ascii?Q?dxiT37GX+RVMd9f61Z085fS5q6SVmrlJkZpO64tXHg1vxkufgH7RcXW6wA3z?=
 =?us-ascii?Q?++cQYJuuT00cFRZMr/PuKPKY2rUzZWG5mBb0n0DQi6gnXGR+vcWYklvg28tG?=
 =?us-ascii?Q?Bs1yi4Fdjz090e0ieJt/qa8tX7GtIUlafqbsfxIVztq3Gj4VyhZ3GlHIPxPx?=
 =?us-ascii?Q?CHOgkLJJopPnCQ2M0u8bxg3JFZzYvw7d5YbBV0bxpf0x1t7hDdKXlbhEHGM1?=
 =?us-ascii?Q?iwMmJkiqbGP2bS0hNb1Ct0wuNAoHaqgNOuvoN1RiY/mZpjuDI5J2wNEKBl3t?=
 =?us-ascii?Q?9RPxMxQ4WXRr8QOEx2Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 05:27:14.3970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8295be7e-de1c-4b15-4c7b-08de2019ce8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064

From: Kinsey Ho <kinseyho@google.com>

Introduce a new kernel daemon, klruscand, that periodically invokes the
MGLRU page table walk. It leverages the new callbacks to gather access
information and forwards it to pghot sub-system for promotion decisions.

This benefits from reusing the existing MGLRU page table walk
infrastructure, which is optimized with features such as hierarchical
scanning and bloom filters to reduce CPU overhead.

As an additional optimization to be added in the future, we can tune
the scan intervals for each memcg.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
[Reduced the scan interval to 500ms, KLRUSCAND to default n in config]
Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 mm/Kconfig     |   8 ++++
 mm/Makefile    |   1 +
 mm/klruscand.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 mm/klruscand.c

diff --git a/mm/Kconfig b/mm/Kconfig
index b5e84cb50253..84ec9a9aca13 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1383,6 +1383,14 @@ config PGHOT
 	  by various sources. Asynchronous promotion is done by per-node
 	  kernel threads.
 
+config KLRUSCAND
+	bool "Kernel lower tier access scan daemon"
+	default n
+	depends on PGHOT && LRU_GEN_WALKS_MMU
+	help
+	  Scan for accesses from lower tiers by invoking MGLRU to perform
+	  page table walks.
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index a6fac171c36e..1c0c79fec106 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -147,3 +147,4 @@ obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
 obj-$(CONFIG_PGHOT) += pghot.o
+obj-$(CONFIG_KLRUSCAND) += klruscand.o
diff --git a/mm/klruscand.c b/mm/klruscand.c
new file mode 100644
index 000000000000..13a41b38d67d
--- /dev/null
+++ b/mm/klruscand.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/memcontrol.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/memory-tiers.h>
+#include <linux/pghot.h>
+
+#include "internal.h"
+
+#define KLRUSCAND_INTERVAL 500
+#define BATCH_SIZE (2 << 16)
+
+static struct task_struct *scan_thread;
+static unsigned long pfn_batch[BATCH_SIZE];
+static int batch_index;
+
+static void flush_cb(void)
+{
+	int i;
+
+	for (i = 0; i < batch_index; i++) {
+		unsigned long pfn = pfn_batch[i];
+
+		pghot_record_access(pfn, NUMA_NO_NODE, PGHOT_PGTABLE_SCAN, jiffies);
+
+		if (i % 16 == 0)
+			cond_resched();
+	}
+	batch_index = 0;
+}
+
+static bool accessed_cb(unsigned long pfn)
+{
+	WARN_ON_ONCE(batch_index == BATCH_SIZE);
+
+	if (batch_index < BATCH_SIZE)
+		pfn_batch[batch_index++] = pfn;
+
+	return batch_index == BATCH_SIZE;
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
+		next_wake_time = jiffies + msecs_to_jiffies(KLRUSCAND_INTERVAL);
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
+				lru_gen_scan_lruvec(lruvec, max_seq, accessed_cb, flush_cb);
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


