Return-Path: <linux-kernel+bounces-833741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 294F1BA2EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE51382C87
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE7728BAB1;
	Fri, 26 Sep 2025 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NaVJ0jWt"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ADF10942
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758874782; cv=fail; b=Mxq+AbIzpHm75OV7Z0b/esEkqjgE7tY+LBn9ntZ6Z8J4px4YIqcY3RR5OClBhbEjcm0KbnR1eg/ajHETFdvKNWJ6Vgrrmsz8yMbOdkdPpiiBSmD1Z/KneUO+rippVEGy2D0ZeSzofAVNm1zLs6vjTiiryDF35lwtAe+0Gi0YOBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758874782; c=relaxed/simple;
	bh=Jb8Q3Ogza4Hg4vA5KS4JoMBFu0/kf997Xs5mk5Eu9Bo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8rsCS7Gutsr+haYl2NlLAXyJ1cLWYsL2WUluj7uvl/kYuGnVEtzM1hjDjoPtuZTScIOcWuoBpuZSEloc1DutWDuTSS0PIuseoFY3/G95JX674zpxo1YYiUEcibCNKfUUIaWjyq+ijcLkk2BgfXSU/jSRngWgFMlPDV79f70GYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NaVJ0jWt; arc=fail smtp.client-ip=40.107.208.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jz+wskYRjKF3LU0H4sSBPVhFq7+YtwGrPBnzGxjKRHKVp7pV59/rPHVav31H+LURHWrGjUgk+SZUL9b0AOgSDwywbIneEIZ/CVJvugR6/mtKq8DEL6r3hY/rvMi0aT+Ro23jaopmnJfbpPNW48mObIKklHGZyHDJvxbtqjYVSoKbl3yyKp9tdkHbKDKaPNWEFTz6L5Vn0GHE40L8dC4eIlAvA6vudPBX15+XdN4sg+eUPdEcd8JYz7gaRbZlpKm6tL5lmOe8Com9XlUXm2jTY7j4/mJT29ozsfrCStfwZWjS00cKR00PNcJ9HkhS6H+l54qxfK2fvthwlTOiBROIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxuFeJAfUyyKihK8n2msMX4wYV7rdc0WK7ZWAUrlUQU=;
 b=LKTPG29SO12yofPcYrv4iEKlv51H77toXoLmzBJy9OzuWrJNxo6cxKJY4D7wCibZbwjnqcRTU/lVmkzC4yB1CDNGnDU1f0ooZkLnJ0eofqnsEx3FDgbU4k4i2bZfSrdn0WAvXpl1OweBsu+aZqApQU6v/4ZOufXsp8aKAZjLfhazBEooFf8xJJm5MVzHnZxKQX1t2NvmiZYXwhTPBneOLb3sJjyPwaFUMXmjj/h84TKLE5H/JLk5a/sv1hLi+h3wACI2Wbg6quKPG/KNB1DmrDlppv0JBfB0XmvPvB4feoECmnx3OXRJEijXCsw5W5uWnZFvyKat6wQxChgZHmnlqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxuFeJAfUyyKihK8n2msMX4wYV7rdc0WK7ZWAUrlUQU=;
 b=NaVJ0jWtNFaViPFSJRaLtBHuXr3998ZbawVI2qYkamHctN3IPIoJSzowvud4AindSnRnPr7JsPX8YLpbvfM9MSwhpa5Vr4PwOsguTIDbHYh2ddoqgQv6uydYCkFE0EmYrbdz4PwOaKJio4ZnYIx3AwbCCpy0YodE19DRACw5RvU=
Received: from SJ0PR03CA0333.namprd03.prod.outlook.com (2603:10b6:a03:39c::8)
 by SJ5PPF1C7838BF6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Fri, 26 Sep
 2025 08:19:35 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::57) by SJ0PR03CA0333.outlook.office365.com
 (2603:10b6:a03:39c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Fri,
 26 Sep 2025 08:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 08:19:35 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 01:19:31 -0700
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
Subject: [PATCH] sched/fair: Start a cfs_rq on throttled hierarchy with PELT clock throttled
Date: Fri, 26 Sep 2025 08:19:17 +0000
Message-ID: <20250926081918.30488-1-kprateek.nayak@amd.com>
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SJ5PPF1C7838BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 03de3a4d-ed29-4168-14e9-08ddfcd56da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6eA+S5IHSmtfzeKznBFcDeqx3AUzsLiOOyarJ8LDn0GVeDpH36sLrOiFYXM5?=
 =?us-ascii?Q?wa5oHjZeJhCQGp+VfJ2XvEWMWxg29RtCqXZHldllSJBTx1vxlA8R5lMWRrGG?=
 =?us-ascii?Q?arZBowaB9vcJiVzkE8svdoQkfxCj0limVPmDtmxX4qNS6LDIet8gcG29f+a1?=
 =?us-ascii?Q?ZNrs7o6LbJ+Da6XTw8cQ6fZBMcl0gvntmMbmVfUoE0rT9CSb0NZnhYzcmGrq?=
 =?us-ascii?Q?zu3cifxH++5bIpezotMjHo6N+Zvt/jSOZ8GWJVLrtF4lznPxFqi671AgK9Pt?=
 =?us-ascii?Q?VTYDGwKEUeSA7bH/jnSyV6+BL3X3eCqXKAPXL3om49ZrIAwtDG76yRcpB1Lk?=
 =?us-ascii?Q?Ngn62lVv/0S3VdcQDUCmXv0J8qtCGeDxufb4D+V76YGg4dc+JbeQY9UQFs/W?=
 =?us-ascii?Q?P2+dfgUMVd0VcFeBg4TTAWgqDpythAFQ9+GEzhk8YYlrHTHm44ETsjcLMAD9?=
 =?us-ascii?Q?Ek2yEJ9DfQPhKYxnaFt4SazDfky4NfgeobO7Pu6+C93Wcdvk+QJ6j4oG5WyU?=
 =?us-ascii?Q?gfYHFmuVlM88BnXORRVT3cKoK3nzTiCW6eGb9VW01QQ8z2MZc+n7B82Hrxsa?=
 =?us-ascii?Q?Mlz4dsVhBNcCeMTMs+UkhUkRsfA1ZE6fnxbg824g+VnN1H6mpN6oKtUIUhe1?=
 =?us-ascii?Q?koruBGoYmp+xe0PiSX0p9PxJ6hFq3/8G4XWBo0/KA8GjcbJ152I07nCzA4MH?=
 =?us-ascii?Q?+6qOKuReXvujbRPp64b48EEZjYsAYlk9zkfq6eEWyarUP6woIfLTSOjKUWwc?=
 =?us-ascii?Q?VdXx/eTGUAgbFxzU2L5EVWRIFPoQyNRVm94nJKT6UXb4imbibBwsGw0hs6b9?=
 =?us-ascii?Q?PTUJQ4lyFBGJnh0t/4pwlqjsmxTIJVxnUBPH4l/+TMt+zn7yDQbFuP1ZhCMe?=
 =?us-ascii?Q?JIT4qy3Rc9LLr5NSOqO8VG/f+jvcbvCxKTUdGSXImgBuJd7AwqqD6FyzuqiY?=
 =?us-ascii?Q?XO1qXVmiP0sdrUROKhwC7Xp2Lp1KR3+zD8m3/88gLl+SzmefMMkj7I7JCu1g?=
 =?us-ascii?Q?wkB/4vjhOQG7rwYcLoE9e+q0hHNQXY996u1xKL8GHKZVVDKLHfn+RArDfGc7?=
 =?us-ascii?Q?69X2SXqKS8CCtSrcLf7hR/5JpEzm5f+GwWkz8H4f2jadSMcSYA5Z16jPExqt?=
 =?us-ascii?Q?Ti0oyGb++GNpaff6C+6WoAdpw4WaKsgjr3m7ug20K/lcALN6MEDkQlwQJ68+?=
 =?us-ascii?Q?7ftEosM0JptZ/qTA2uoh7k1qFPYwNYU31bjnr9rZmduGs4gEHSYwfpPfBu7I?=
 =?us-ascii?Q?jPq286jHOuFqL59uJzX+gXcgM/sgE9ZSznW0Ou4Yhwhzj9m/gvwSHA9qT6AY?=
 =?us-ascii?Q?ID4Z5lJ8E3D2lUDiuQsK2XbxAxT+Wgp1/Hu6vx4DuZMTr5yPnfQptQhbKTKz?=
 =?us-ascii?Q?kvFFQyPu+zn54bcxz+SMtPrAtIfGgbcCvft2Dqq33iPymeo/v2otWjEo4bdb?=
 =?us-ascii?Q?jBmQ0UiNA5yzi3zU1n5h+4BX18JELCk7YdZEZfxGj4ETx7HZfNareg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 08:19:35.3026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03de3a4d-ed29-4168-14e9-08ddfcd56da7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1C7838BF6

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
Fixes: eb962f251fbb ("sched/fair: Task based throttle time accounting")
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Stress test included running sched-messaging in nested hierarchy with
various quota set alongside a continuous loop of cgroup creation and
deletion, as well as another loop of continuous movement of a busy loop
between cgroups.

No splats have been observed yet with this patch.

Aaron, Matteo,

I've not added any "Tested-by" tags since the final diff is slightly
different from the diff shared previously. The previous diff led to this
splat during my test with the newly added assert:

  ------------[ cut here ]------------
  WARNING: CPU: 6 PID: 22912 at kernel/sched/fair.c:400 propagate_entity_cfs_rq+0x1f9/0x270
  CPU: 6 UID: 0 PID: 22912 Comm: bash Not tainted 6.17.0-rc4-test+ #50 PREEMPT_{RT,(full)}
  Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.7.3 03/30/2022
  RIP: 0010:propagate_entity_cfs_rq+0x1f9/0x270
  Code: ...
  RSP: 0018:ffffd4a203713928 EFLAGS: 00010087
  RAX: ffff8ea4714b1e00 RBX: 0000000000000000 RCX: 0000000000000001
  RDX: ffff8ea4714b28e8 RSI: 0000003570150cf8 RDI: ffff8e65abc69400
  RBP: ffff8ea4714b1f00 R08: 0000000000006160 R09: 0000000000016d5a
  R10: 000000000000009c R11: 0000000000000000 R12: ffff8ea4714b1e00
  R13: ffff8e6586df1a00 R14: 0000000000000001 R15: 0000000000000246
  FS:  00007f73a6a7f740(0000) GS:ffff8e64d0689000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000562b9791d461 CR3: 000000010d875003 CR4: 0000000000f70ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   sched_move_task+0xc2/0x280
   cpu_cgroup_attach+0x37/0x70
   cgroup_migrate_execute+0x3b8/0x560
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? rt_spin_unlock+0x60/0xa0
   cgroup_attach_task+0x15b/0x200
   ? cgroup_attach_permissions+0x17e/0x1e0
   __cgroup_procs_write+0x105/0x170
   cgroup_procs_write+0x17/0x30
   kernfs_fop_write_iter+0x127/0x1c0
   vfs_write+0x305/0x420
   ksys_write+0x6b/0xe0
   do_syscall_64+0x85/0xb30
   ? __x64_sys_close+0x3d/0x80
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? do_syscall_64+0xbe/0xb30
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __x64_sys_fcntl+0x80/0x110
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? do_syscall_64+0xbe/0xb30
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __x64_sys_fcntl+0x80/0x110
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? rt_spin_unlock+0x60/0xa0
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? wp_page_reuse.constprop.0+0x7c/0x90
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? do_wp_page+0x3df/0xd70
   ? set_close_on_exec+0x31/0x70
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? rt_spin_unlock+0x60/0xa0
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? do_fcntl+0x3f6/0x760
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? do_syscall_64+0xbe/0xb30
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __handle_mm_fault+0x375/0x380
   ? __x64_sys_fcntl+0x80/0x110
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? count_memcg_events+0xd9/0x1c0
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? handle_mm_fault+0x1af/0x290
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? do_user_addr_fault+0x2d0/0x8c0
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? srso_alias_return_thunk+0x5/0xfbef5
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7f73a6b968f7
  Code: ...
  RSP: 002b:00007ffebcfdc688 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
  RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007f73a6b968f7
  RDX: 0000000000000006 RSI: 0000562b9791d460 RDI: 0000000000000001
  RBP: 0000562b9791d460 R08: 00007f73a6c53460 R09: 000000007fffffff
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
  R13: 00007f73a6c9d780 R14: 00007f73a6c99600 R15: 00007f73a6c98a00
   </TASK>
  ---[ end trace 0000000000000000 ]---


... which happens because we can have:

	  A (*throttled; PELT is not frozen)
        /   \
 (new) C     B (contains runnable tasks)

C is a new cgroup but is not enqueued on cfs_rq of A yet. B is another
cfs_rq with tasks and is enqueued on cfs_rq of A. Entire hierarchy shown
above is throttled.

When all tasks on B leaves, PELT of A and B is frozen but since C was
never queued on A and A's PELT wasn't throttled when it was created, C
still has pelt_clock_throttled as 0.

Next propagate_entity_cfs_rq() on C will see C doesn't have PELT clock
throttled, adding it to "rq->tmp_alone_branch" but then it sees A has
its PELT clock throttled which leads to the dangling reference, or
worse, incorrect ordering in leaf cfs_rq list.

Changes are prepared on top of tip:sched/core at commit 45b7f780739a
("sched: Fix some typos in include/linux/preempt.h")
---
 kernel/sched/fair.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 18a30ae35441..9af82e214312 100644
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
+	 * and leave it to the first enqueue, or distribution to
+	 * unthrottle the PELT clock and add us on the leaf_cfs_rq_list.
+	 */
+	if (cfs_rq->throttle_count)
+		cfs_rq->pelt_clock_throttled = 1;
 }
 
 /* conditionally throttle active cfs_rq's from put_prev_entity() */
@@ -13192,6 +13202,8 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 		if (!cfs_rq_pelt_clock_throttled(cfs_rq))
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
+
+	assert_list_leaf_cfs_rq(rq_of(cfs_rq));
 }
 #else /* !CONFIG_FAIR_GROUP_SCHED: */
 static void propagate_entity_cfs_rq(struct sched_entity *se) { }

base-commit: 45b7f780739a3145aeef24d2dfa02517a6c82ed6
-- 
2.34.1


