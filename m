Return-Path: <linux-kernel+bounces-862192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0813BF4A62
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79BC818C3DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ECD244669;
	Tue, 21 Oct 2025 05:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="27GmMl06"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010069.outbound.protection.outlook.com [40.93.198.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0403D1BFE00
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761024963; cv=fail; b=qPbQ1ZbaD8sZxjPIyW7mcaq7Htz4+lFkX88kq1bd9UPkmANrfCSaWF60QDusAUqyILXgsu5WBoeoYQ0VJJQttfk+tRX+cAQdRw4nbalS14fWpSrS7/2Epzmw9ztgBTtqxKuyDXoW1XNifTWevE1vcM2qHmBloJlE1N3H8SJYMOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761024963; c=relaxed/simple;
	bh=CGxlzFknzOuI8alHSH6vhDHsJX6YKA2cTXB8JHI0lBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g81ZWJ7Vpb2L1FjOt1hAeSWLgIO2/F8baCEb6pt7sMLk49B4ViBDbvpFqTxq2S3CGcQQzW7Gxs1X40Mavzna95YBH/oxlfhbfDmbGLtHoWKl7JArR4mzjYz7TGdtfJo/ZGttxKt1OqL1ycUVb/7Y73D0pcUl815lYOeNBuTqlO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=27GmMl06; arc=fail smtp.client-ip=40.93.198.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxQTF5uw2RfdX/3ezLmxj7H1n9jfFTTPYznuk1b92iCtl3MmcM1CT6K2TDwDb9R9+BWtn0nxqveTuI510gxV1zKY9gBYQWhPS9Vxa14t+fUz5npn9P70XMJqfvwR+5Haei4X1DYKx6GzT93qWbZONpW/HHN1MtCYMEzXQtHsdrjWbKIvS+mU8ZOzvyIvcAoIwMMFk++0qDrN/vIY5Sn7DpmQLxhsDRV0m/eAsFYhKx4fdLZ28PF8fEm7ArZ8itkwGUd+Kpcf8q0Z9VKBTSlfThvnHtwiTjn7lAP+V2tMXZ1xnIHEwKwipBAE2woLdrLyaMzof5fCUEHIUD3+A318cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndsEHZ3VEzfZVznEmN350WUwgJ4iggB5ni2mgLSh6a4=;
 b=EpikQSSue/qdA5m1RxJLG5vCj4yERDO6/SkhYzX6gLkdRtbsiq7LuZADByH/tyGxxImAkd7fJ/TbmUlR6d8KItc9x+3mAjlpnzMSYAFYLrFuriIKqfdM6KGpIjDrNxz79CKvH/Jfn2JcRIeyw/Okp8C4UhdQOpuayk0btLTjmglTGfWZqZcQecAdgY1Nwwalj/VnkSrC+yREALw/tyQ5+KQtykCMyItVADdqk5YpXFLlfuQoKVjvOY9BnUjN42jD2cbUGK05jMn6OGE78NxydQx4+8ur6i8ysXGSr+are+U+Vc09nIx8cJVi10Eng978EsfZ2IgDYcoTJsd7+qPTsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndsEHZ3VEzfZVznEmN350WUwgJ4iggB5ni2mgLSh6a4=;
 b=27GmMl06VvTP2wRgTLQY4fhdSrP2sOzNEAI/BdgTIiSgZe3yNpvE7JdSc8K16QpeZ7B+2zmsRml9fFarArjWgkpjsC2xfru5RBdn3/CPAbfOgSIp0eLfl61YQqAKQS3HTDvXL2FC2884LnqavQ4f0cOh6Jrg45/NkyrGqIWr0t0=
Received: from DM6PR07CA0071.namprd07.prod.outlook.com (2603:10b6:5:74::48) by
 MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.17; Tue, 21 Oct 2025 05:35:57 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com (2603:10b6:5:74::4)
 by DM6PR07CA0071.outlook.office365.com (2603:10b6:5:74::48) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17
 via Frontend Transport; Tue, 21 Oct 2025 05:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 05:35:57 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 22:35:43 -0700
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Matteo Martelli
	<matteo.martelli@codethink.co.uk>, Aaron Lu <ziqianlu@bytedance.com>,
	<linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>
Subject: [PATCH v2] sched/fair: Start a cfs_rq on throttled hierarchy with PELT clock throttled
Date: Tue, 21 Oct 2025 05:35:22 +0000
Message-ID: <20251021053522.37583-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e2e558b863c929c5019264b2ddefd4c0@codethink.co.uk>
References: <e2e558b863c929c5019264b2ddefd4c0@codethink.co.uk>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 09bf0c67-e5d5-4289-6b8c-08de1063b5fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|30052699003|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rxzbgG4dLEo9LixvtoeBHy+2fAj+aQcV1uNF+mkpFkUFhgQSxUyfjmejvuCL?=
 =?us-ascii?Q?w1WZocZdeXyYe4nFSy2fKMtatwpsEtvVJQ0D1MsTo448jStpFafYYFoJ274r?=
 =?us-ascii?Q?Jc6BGNy2z4EmO2T2yfxWXDlxJR3O0w5Es0hsGQKB99/2mcrx9g0nDZfB7DjR?=
 =?us-ascii?Q?WQjFwWX1FwYdXHa68errj8ioAF57Lq77okYdgOCmoccL5IpSfm3Zn1tdPISA?=
 =?us-ascii?Q?1H46o8KdBtHyhApotrtLCQB3EgEZfGdQMCtqnFT0ZgEVm2bVmTfelsbpmz8d?=
 =?us-ascii?Q?OQU7C7RXWFY4cNKiqJ7UiqvbNjj/FQt3RpcbikaF84ZGQkAuIhoW88hk1dY7?=
 =?us-ascii?Q?udWs3Y/ogB6a3Vb6VWrxr7FIREqMUE7/k0jOL/d6SIcmEl71yK3hlG88Vkpt?=
 =?us-ascii?Q?9uvYMwOGpnZbaJB3BkekcnTyx1YspemkSDVz0vCHOZ3SLUOU6lRJ1HMu2iUp?=
 =?us-ascii?Q?7H4m4KBF3lm7yEw6j+Gq/CNvENDiauF/A9xF9l+pZSOdvRALtM9j/hX2+igH?=
 =?us-ascii?Q?zVOx13dglIp21KBj8LqGBHfyVIjS/1Vh5GmglcUtSlPhH6PhO5veG6lSvC2T?=
 =?us-ascii?Q?cJHizcD3r68ngUsa04e84vOT828Nx9RYa/aIdWgp/Q+qW3q0G9k9S0NOcrWk?=
 =?us-ascii?Q?PVkH9D+NTvREn8f/YOOm2CyGt9x7VJld/5dAd3X935o0m+1034Czj9Jlx38M?=
 =?us-ascii?Q?xMiPQI1vaKzUTpP+efyCgGAnsa4+zO+qr8PzhrGZbaO0r/otN0veUNbOmrVu?=
 =?us-ascii?Q?vnuDfVP/h3yawJGoNsjk1/XNa7ap9uM/HC/srRbwz3q7yaoIm9Eu48nSvAJb?=
 =?us-ascii?Q?/beQdm/X9OHFjaLpRsXCCq6NcXYz8d77UQins6rH4Kk63GvdH5KvIrzpjsW0?=
 =?us-ascii?Q?uXoX0MBTXWgNgBxwImyH8L/Oss7mxUhkuoeD8Z0gYqvFDH1R9smUTdSsQVHx?=
 =?us-ascii?Q?1TQoOFtv1CTVWjT1mXHJBTMaU6sbdNnvLE1BHPq4RqsGxClpdWIL3wP60eeS?=
 =?us-ascii?Q?qQbBOYTSEcHxVXSVNNgFJn2/Y6OixGN73a3/aalj3FCU1vEUmlZAux1JHPaY?=
 =?us-ascii?Q?fFvCP7DZ14P+kWDIyFQ5sMK40x4c6ib1uQBkooJqGSBlrU8MuoZjm8AeXYIS?=
 =?us-ascii?Q?oLvvbs629/a0T0pfn9e4x8mzLKO7spEgk3dD9lC8SXGco+lN8iw90W72KOqw?=
 =?us-ascii?Q?LODwf4drvf+XiRbCsLzOQSSTYaKa7cdMVgZoifaEAwpPHuNlBQmzPRp6Ogna?=
 =?us-ascii?Q?B1Vfux76svSmLVnNVRVdNemi7gWMzvw093WsDWiQq0FmyCxk77jR2ma2bSHt?=
 =?us-ascii?Q?gz+bN+gvoI51GwfA0uDvW1Y0wqBha62xrMHk2A0R8dOlx4l+9cOAzNHpESXy?=
 =?us-ascii?Q?SiAQHaMdpM5Jc/IqRdZs0lY+O4b7W3EZaMkn/5xN00Yw9vByVMaBh58h3AjV?=
 =?us-ascii?Q?W0Pv2r2OzrrgYEH04MEKC3LF26DKAmIClV8hmiG92YGfXarjS4q+dBRY06Tx?=
 =?us-ascii?Q?VWxUQJvN6NT11Ee+xsqubgf/GCxqTPqYe9HZmU16UrqBH5/6/gXB/dRX9Ycn?=
 =?us-ascii?Q?I3/SpGArDxAbAWNm/rYPXg8xcnCqkGPA1LUGG29o?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(30052699003)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 05:35:57.3475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bf0c67-e5d5-4289-6b8c-08de1063b5fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443

Matteo reported hitting the assert_list_leaf_cfs_rq() warning from
enqueue_task_fair() post commit fe8d238e646e ("sched/fair: Propagate
load for throttled cfs_rq") which transitioned to using
cfs_rq_pelt_clock_throttled() check for leaf cfs_rq insertions in
propagate_entity_cfs_rq().

The "cfs_rq->pelt_clock_throttled" flag is used to indicate if the
hierarchy has its PELT frozen. If a cfs_rq's PELT is marked frozen, all
its descendants should have their PELT frozen too or weird things can
happen as a result of children accumulating PELT signals when the
parents have their PELT clock stopped.

Another side effect of this is the loss of integrity of the leaf cfs_rq
list. As debugged by Aaron, consider the following hierarchy:

    root(#)
   /    \
  A(#)   B(*)
         |
         C <--- new cgroup
         |
         D <--- new cgroup

  # - Already on leaf cfs_rq list
  * - Throttled with PELT frozen

The newly created cgroups don't have their "pelt_clock_throttled" signal
synced with cgroup B. Next, the following series of events occur:

1. online_fair_sched_group() for cgroup D will call
   propagate_entity_cfs_rq(). (Same can happen if a throttled task is
   moved to cgroup C and enqueue_task_fair() returns early.)

   propagate_entity_cfs_rq() adds the cfs_rq of cgroup C to
   "rq->tmp_alone_branch" since its PELT clock is not marked throttled
   and cfs_rq of cgroup B is not on the list.

   cfs_rq of cgroup B is skipped since its PELT is throttled.

   root cfs_rq already exists on cfs_rq leading to
   list_add_leaf_cfs_rq() returning early.

   The cfs_rq of cgroup C is left dangling on the
   "rq->tmp_alone_branch".

2. A new task wakes up on cgroup A. Since the whole hierarchy is already
   on the leaf cfs_rq list, list_add_leaf_cfs_rq() keeps returning early
   without any modifications to "rq->tmp_alone_branch".

   The final assert_list_leaf_cfs_rq() in enqueue_task_fair() sees the
   dangling reference to cgroup C's cfs_rq in "rq->tmp_alone_branch".

   !!! Splat !!!

Syncing the "pelt_clock_throttled" indicator with parent cfs_rq is not
enough since the new cfs_rq is not yet enqueued on the hierarchy. A
dequeue on other subtree on the throttled hierarchy can freeze the PELT
clock for the parent hierarchy without setting the indicators for this
newly added cfs_rq which was never enqueued.

Since there are no tasks on the new hierarchy, start a cfs_rq on a
throttled hierarchy with its PELT clock throttled. The first enqueue, or
the distribution (whichever happens first) will unfreeze the PELT clock
and queue the cfs_rq on the leaf cfs_rq list.

While at it, add an assert_list_leaf_cfs_rq() in
propagate_entity_cfs_rq() to catch such cases in the future.

Suggested-by: Aaron Lu <ziqianlu@bytedance.com>
Reported-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
Closes: https://lore.kernel.org/lkml/58a587d694f33c2ea487c700b0d046fa@codethink.co.uk/
Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
Reviewed-by: Aaron Lu <ziqianlu@bytedance.com>
Tested-by: Aaron Lu <ziqianlu@bytedance.com>
Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v1..v2:

o Fixed the commit in "Fixes:" tag. (Aaron)
o Collected tags from Aaron and Matteo. (Thanks a ton!)
o Rebased on tip:sched/urgent.

v1: https://lore.kernel.org/lkml/20250926081918.30488-1-kprateek.nayak@amd.com/
---
 kernel/sched/fair.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cee1793e8277..25970dbbb279 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6437,6 +6437,16 @@ static void sync_throttle(struct task_group *tg, int cpu)
 
 	cfs_rq->throttle_count = pcfs_rq->throttle_count;
 	cfs_rq->throttled_clock_pelt = rq_clock_pelt(cpu_rq(cpu));
+
+	/*
+	 * It is not enough to sync the "pelt_clock_throttled" indicator
+	 * with the parent cfs_rq when the hierarchy is not queued.
+	 * Always join a throttled hierarchy with PELT clock throttled
+	 * and leaf it to the first enqueue, or distribution to
+	 * unthrottle the PELT clock.
+	 */
+	if (cfs_rq->throttle_count)
+		cfs_rq->pelt_clock_throttled = 1;
 }
 
 /* conditionally throttle active cfs_rq's from put_prev_entity() */
@@ -13187,6 +13197,8 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 		if (!cfs_rq_pelt_clock_throttled(cfs_rq))
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
+
+	assert_list_leaf_cfs_rq(rq_of(cfs_rq));
 }
 #else /* !CONFIG_FAIR_GROUP_SCHED: */
 static void propagate_entity_cfs_rq(struct sched_entity *se) { }

base-commit: 17e3e88ed0b6318fde0d1c14df1a804711cab1b5
-- 
2.34.1


