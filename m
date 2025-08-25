Return-Path: <linux-kernel+bounces-784624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 155D1B33EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95F41A83F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B59326E6FB;
	Mon, 25 Aug 2025 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2SVbpaLj"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985AE26D4DD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123393; cv=fail; b=aNG47JALUy9iTmikNSuXGb47bHKmux+MTvnB4mFKwtB+pSY1V9LBaFfwDFSrHzGqEIyyjN3tosTQvYhQ99+VtpysKkyd6NWid8aBwA6zr/7WuBCFAy8IYktfJtXQSJmzIrQVTNbzzPVJDCSM+0Ctu5mi6CR7AS5F41W/Mni8cBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123393; c=relaxed/simple;
	bh=ozRYCs6djXtwWLwmB1YyHWgBBkuKD5ViP5gJNEMjid0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uXf+7rR/ZiTQfewlfqmlehRG0mw2PqsxKV5DFikg8DVMIXkzMC5KdW4Jhbaf5f98WDf7BgoPosENmN2pOOpSPQqUIPAj+erR+ACNNxHdnvYnMHvEBGCG3h4hV1v3SwL5Ly+Og6SjuF4Pl25rRcttRx3jA0Hr4kCrsSGTYk0NOcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2SVbpaLj; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIft+yqe0K4Y27VKrABqc5VBCb9BfG7ajSMleDHgZdRfxlUim4Cly7uVeLtNrmw6NQ/eRxnuKhsbUuVLf99gPMXycmmwpm76otBko4EfkOK4zNzOfOJcdaF30g1OM3emzts9OvTI8NEXlWL7S+2HxfD68/fUEK6m8mMjsnAOwS+n7wIOERvP8I65LCZOTmMsZNJ1qdUZ6E4coI+P0lmXD1En12e2hFKessLNXWcTeJE+TPPWTTh/YFWyhIG/OJybtUqML0/7hb+oHqX2dnRfape8E6//M40SjBlgA0FFX3p402K7VKmoqXW5b1tPrNfoMiYzQxiv8yYTmlVyZEVdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbto1LD7mLC+z0oQpxpUvYfueASx1jnMaUkX2JarT0U=;
 b=KMmUkYCrMMv2Mipr6V8WoPKpMtZtJydjDcvxNjrVCTuc9j+fD9ZaW3d9Tm5fs/yYAwdtw6+QrxpCnqlvl7gZLQphz4Ef24ZAwRnZKPwtvxeQmUa+XopFpPTyLO9m0k0lfcnazj26MsJzCe14DbOdp7UG7Ml3DMC/KIXRd5Rsw8/htWBybiX2NfYM015AdkU27wDQp87x62wFBx0tusKa4ayBHu0AUHZllCaGCkHl7hhI7O01NLhFWhaATAEPfxicmHcN19XZhidr+gdEav+lpMfv+okQRQwPMdKmTsntopbszmIcG9vX5rm2WgNbMQWMGN+yC1d5TBrI87XqwVPZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbto1LD7mLC+z0oQpxpUvYfueASx1jnMaUkX2JarT0U=;
 b=2SVbpaLj0tCXdpXBuCF4pYjmb8rLObmdaBqcBlUiVIZ3YVLsIaEwb6UivAhQWVJAShDOgo57T13B0r3FmD+DrGH6Somqky7LJaT3U8QGxlbq9qGUs2/KyfEcKcxgicRSfI9D78pBGu15v9rQsZoTpCT0+1+gU57lO/MKgHnf5qw=
Received: from MN2PR03CA0013.namprd03.prod.outlook.com (2603:10b6:208:23a::18)
 by CY1PR12MB9603.namprd12.prod.outlook.com (2603:10b6:930:108::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 12:03:06 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::67) by MN2PR03CA0013.outlook.office365.com
 (2603:10b6:208:23a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 12:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 12:03:06 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 07:02:59 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Valentin Schneider <vschneid@redhat.com>, "Leon
 Romanovsky" <leon@kernel.org>, <linux-kernel@vger.kernel.org>
CC: Steve Wahl <steve.wahl@hpe.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Tim Chen <tim.c.chen@linux.intel.com>, "Vinicius
 Costa Gomes" <vinicius.gomes@intel.com>
Subject: [PATCH v6] sched/fair: Get rid of sched_domains_curr_level hack for tl->cpumask()
Date: Mon, 25 Aug 2025 12:02:44 +0000
Message-ID: <20250825120244.11093-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|CY1PR12MB9603:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a8bea6-5c58-43d1-d3d9-08dde3cf59c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pQv/a/T9nJKgPetefDwgjmjjxB60XiU1ACZizQKhVysh+eXYiBqkWy05hi+H?=
 =?us-ascii?Q?smUhJbzevk1r6cc3u/nKqBe7OavTDayUoDnBPumpRNxs5ChVGYeBKyU/tNI6?=
 =?us-ascii?Q?dkprFaiJC90/jAD1Ajse8C32YzztRHhXH9H820j46Nv/4s4N5F+1moatVpdb?=
 =?us-ascii?Q?vYbYxFwsnLaVDpceg+mVdCK7cDZEbMfVx1ZrzrCUZLunajNd/6TXTDQlUaYf?=
 =?us-ascii?Q?smTORGfvGPx+ceLL7mKdq1XYBBpBLn4/jlhebICusXu3U476FrVA0RKPt3LN?=
 =?us-ascii?Q?TMotJtTnKi7WrFiDlYlf40/kLvsss0Im6blviA6AjIkkndaC8PozF0cSCs4D?=
 =?us-ascii?Q?2Ry4pUo9mSkn9hS7vszZ7rpMMz5pZj6ChOWPk6KzMcqS1m7ovSQ4ugn6hkax?=
 =?us-ascii?Q?6ozjYFStpLWJHGgVTfLRO5ijRJZ08LLjdYCMnkD4xpU/NMjkWaqFPn8bi3q0?=
 =?us-ascii?Q?NeSEMMoubwoID3zEyShiWmjIlk9G+Tg4ZXrMnraNzik7c20Z49BLjr1D3MeL?=
 =?us-ascii?Q?9zOos+eLYboLJiMFcK4o8dD8AOKIaFW3ZeORZQyf+pEw//2jBjwlKAcr2aF2?=
 =?us-ascii?Q?VTQmN76GN+ijggAUE6fgH24IOZXw3f7cEgvDi01mdRvlXVA3KYTmqAQFOgjC?=
 =?us-ascii?Q?+zhSlGUwICpgyXJf4NozHkO4DJYhUwFLAvA1CP9oH5S/kba7sA7thzdLwHVg?=
 =?us-ascii?Q?5GkUT64ybWD4ncvpEgNwR49GKqr6wbwt37CxS+ozGHzEeDyzDIMxnPWju2PK?=
 =?us-ascii?Q?BbXhy4R7ydSNPhtCZYa+vTu0pdDFNb1CgJZrRSSmHLeQGCePuxWFjVjiNuns?=
 =?us-ascii?Q?yuBhP714nEZwdmgG0sJd24MX7Fs+jz746bthe7k9oiKyIs5465XvaOi7ocC2?=
 =?us-ascii?Q?VvhD0pa9rEdjsVDKfWPSyl13Iq0TiB9aJ633jKkkE2q7LlhMMAJdKlhOy7/n?=
 =?us-ascii?Q?inSDUNHArio8MRdDPXZufg5twepYuD0s5hES45uhRsGVNRhTaVvk9L4Wm1U/?=
 =?us-ascii?Q?4PDgZB366iB45jzKKeXCHlFBoXoA7VD7/Awe3Cd7FVFHLARtwhRAlfZeL896?=
 =?us-ascii?Q?jE/W6vmdOmcYGiyR0ggCqVFSHeTDYrcst6JvF3kMeGA5m2Y2TjZJHqt2aoRS?=
 =?us-ascii?Q?hyGEHRumv/5/+Ovg2lbPzXBhaMl/vX9NEh7/NecbABZc3Q7bU6ruE/sfZZcq?=
 =?us-ascii?Q?7Drbg3wx3o75tooTDD52/EqHO0GGCFzopQv7CTwWrRA3oPO7G4ZvGPGGiy5n?=
 =?us-ascii?Q?TqQkt9LB8qDzdMXfoI8vyuFyN1PnGww2JaN7eujTxH16Szvza8sUfQ6s+cnI?=
 =?us-ascii?Q?KKFN1kuEQC+HQIj3Ojx3SqI2qPzBjNsp7tXYTxJzc3IXmqeiN6tS6zvzJDrt?=
 =?us-ascii?Q?P9bjl6VAG++YTA/m4/5NgVSOficFk//gUtNT9+Nmh8Hg5slWMIZQ7elBjoy7?=
 =?us-ascii?Q?R0a90bmYT0PYiWC22cbK1pNectBwCooA4t/7nZgh0Q1KVUPeGTsXyvXctlU4?=
 =?us-ascii?Q?HcyXOc2Mt0eFxQtHlF6Apnyn9JveMydU1pfKJWD9GizcOaxj87CIET/yZw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 12:03:06.0124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a8bea6-5c58-43d1-d3d9-08dde3cf59c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9603

From: Peter Zijlstra <peterz@infradead.org>

Leon [1] and Vinicius [2] noted a topology_span_sane() warning during
their testing starting from v6.16-rc1. Debug that followed pointed to
the tl->mask() for the NODE domain being incorrectly resolved to that of
the highest NUMA domain.

tl->mask() for NODE is set to the sd_numa_mask() which depends on the
global "sched_domains_curr_level" hack. "sched_domains_curr_level" is
set to the "tl->numa_level" during tl traversal in build_sched_domains()
calling sd_init() but was not reset before topology_span_sane().

Since "tl->numa_level" still reflected the old value from
build_sched_domains(), topology_span_sane() for the NODE domain trips
when the span of the last NUMA domain overlaps.

Instead of replicating the "sched_domains_curr_level" hack, get rid of
it entirely and instead, pass the entire "sched_domain_topology_level"
object to tl->cpumask() function to prevent such mishap in the future.

sd_numa_mask() now directly references "tl->numa_level" instead of
relying on the global "sched_domains_curr_level" hack to index into
sched_domains_numa_masks[].

The original warning was reproducible on the following NUMA topology
reported by Leon:

    $ sudo numactl -H
    available: 5 nodes (0-4)
    node 0 cpus: 0 1
    node 0 size: 2927 MB
    node 0 free: 1603 MB
    node 1 cpus: 2 3
    node 1 size: 3023 MB
    node 1 free: 3008 MB
    node 2 cpus: 4 5
    node 2 size: 3023 MB
    node 2 free: 3007 MB
    node 3 cpus: 6 7
    node 3 size: 3023 MB
    node 3 free: 3002 MB
    node 4 cpus: 8 9
    node 4 size: 3022 MB
    node 4 free: 2718 MB
    node distances:
    node   0   1   2   3   4
      0:  10  39  38  37  36
      1:  39  10  38  37  36
      2:  38  38  10  37  36
      3:  37  37  37  10  36
      4:  36  36  36  36  10

The above topology can be mimicked using the following QEMU cmd that was
used to reproduce the warning and test the fix:

     sudo qemu-system-x86_64 -enable-kvm -cpu host \
     -m 20G -smp cpus=10,sockets=10 -machine q35 \
     -object memory-backend-ram,size=4G,id=m0 \
     -object memory-backend-ram,size=4G,id=m1 \
     -object memory-backend-ram,size=4G,id=m2 \
     -object memory-backend-ram,size=4G,id=m3 \
     -object memory-backend-ram,size=4G,id=m4 \
     -numa node,cpus=0-1,memdev=m0,nodeid=0 \
     -numa node,cpus=2-3,memdev=m1,nodeid=1 \
     -numa node,cpus=4-5,memdev=m2,nodeid=2 \
     -numa node,cpus=6-7,memdev=m3,nodeid=3 \
     -numa node,cpus=8-9,memdev=m4,nodeid=4 \
     -numa dist,src=0,dst=1,val=39 \
     -numa dist,src=0,dst=2,val=38 \
     -numa dist,src=0,dst=3,val=37 \
     -numa dist,src=0,dst=4,val=36 \
     -numa dist,src=1,dst=0,val=39 \
     -numa dist,src=1,dst=2,val=38 \
     -numa dist,src=1,dst=3,val=37 \
     -numa dist,src=1,dst=4,val=36 \
     -numa dist,src=2,dst=0,val=38 \
     -numa dist,src=2,dst=1,val=38 \
     -numa dist,src=2,dst=3,val=37 \
     -numa dist,src=2,dst=4,val=36 \
     -numa dist,src=3,dst=0,val=37 \
     -numa dist,src=3,dst=1,val=37 \
     -numa dist,src=3,dst=2,val=37 \
     -numa dist,src=3,dst=4,val=36 \
     -numa dist,src=4,dst=0,val=36 \
     -numa dist,src=4,dst=1,val=36 \
     -numa dist,src=4,dst=2,val=36 \
     -numa dist,src=4,dst=3,val=36 \
     ...

  [ prateek: Moved common functions to include/linux/sched/topology.h,
    reuse the common bits for s390 and ppc, commit message ]

Reported-by: Leon Romanovsky <leon@kernel.org>
Closes: https://lore.kernel.org/lkml/20250610110701.GA256154@unreal/ [1]
Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap") # ce29a7da84cd, f55dac1dafb3
Link: https://lore.kernel.org/lkml/a3de98387abad28592e6ab591f3ff6107fe01dc1.1755893468.git.tim.c.chen@linux.intel.com/ [2]
Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Peter, I replaced the cpu_thread_mask() for s390 with tl_smt_mask().

include/linux/topology.c defines an explicit cpu_smt_mask() wrapper
around topology_sibling_cpumask() when cpu_smt_mask() is not defined by
the arch/ bits and on s390, topology_sibling_cpumask() returns
&cpu_topology[cpu].thread_mask.

changelog v5..v6:

o New (read correct) approach using the diff that Peter suggested in
  https://lore.kernel.org/lkml/20250825091910.GT3245006@noisy.programming.kicks-ass.net/
  with some cleanup on top.

o Tested the changes on x86.

v5: https://lore.kernel.org/lkml/20250715040824.893-1-kprateek.nayak@amd.com/
---
 arch/powerpc/kernel/smp.c      | 19 +++++++------------
 arch/s390/kernel/topology.c    | 16 +++++-----------
 arch/x86/kernel/smpboot.c      |  8 ++++----
 include/linux/sched/topology.h | 28 +++++++++++++++++++++++++++-
 include/linux/topology.h       |  2 +-
 kernel/sched/topology.c        | 28 ++++++++++------------------
 6 files changed, 54 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index f59e4b9cc207..a0eeb6e39304 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1028,13 +1028,13 @@ static int powerpc_shared_proc_flags(void)
  * We can't just pass cpu_l2_cache_mask() directly because
  * returns a non-const pointer and the compiler barfs on that.
  */
-static const struct cpumask *shared_cache_mask(int cpu)
+static const struct cpumask *shared_cache_mask(struct sched_domain_topology_level *tl, int cpu)
 {
 	return per_cpu(cpu_l2_cache_map, cpu);
 }
 
 #ifdef CONFIG_SCHED_SMT
-static const struct cpumask *smallcore_smt_mask(int cpu)
+static const struct cpumask *smallcore_smt_mask(struct sched_domain_topology_level *tl, int cpu)
 {
 	return cpu_smallcore_mask(cpu);
 }
@@ -1054,11 +1054,6 @@ static bool has_coregroup_support(void)
 	return coregroup_enabled;
 }
 
-static const struct cpumask *cpu_mc_mask(int cpu)
-{
-	return cpu_coregroup_mask(cpu);
-}
-
 static int __init init_big_cores(void)
 {
 	int cpu;
@@ -1448,7 +1443,7 @@ static bool update_mask_by_l2(int cpu, cpumask_var_t *mask)
 		return false;
 	}
 
-	cpumask_and(*mask, cpu_online_mask, cpu_cpu_mask(cpu));
+	cpumask_and(*mask, cpu_online_mask, cpu_node_mask(cpu));
 
 	/* Update l2-cache mask with all the CPUs that are part of submask */
 	or_cpumasks_related(cpu, cpu, submask_fn, cpu_l2_cache_mask);
@@ -1538,7 +1533,7 @@ static void update_coregroup_mask(int cpu, cpumask_var_t *mask)
 		return;
 	}
 
-	cpumask_and(*mask, cpu_online_mask, cpu_cpu_mask(cpu));
+	cpumask_and(*mask, cpu_online_mask, cpu_node_mask(cpu));
 
 	/* Update coregroup mask with all the CPUs that are part of submask */
 	or_cpumasks_related(cpu, cpu, submask_fn, cpu_coregroup_mask);
@@ -1601,7 +1596,7 @@ static void add_cpu_to_masks(int cpu)
 
 	/* If chip_id is -1; limit the cpu_core_mask to within PKG */
 	if (chip_id == -1)
-		cpumask_and(mask, mask, cpu_cpu_mask(cpu));
+		cpumask_and(mask, mask, cpu_node_mask(cpu));
 
 	for_each_cpu(i, mask) {
 		if (chip_id == cpu_to_chip_id(i)) {
@@ -1713,10 +1708,10 @@ static void __init build_sched_topology(void)
 
 	if (has_coregroup_support()) {
 		powerpc_topology[i++] =
-			SDTL_INIT(cpu_mc_mask, powerpc_shared_proc_flags, MC);
+			SDTL_INIT(tl_mc_mask, powerpc_shared_proc_flags, MC);
 	}
 
-	powerpc_topology[i++] = SDTL_INIT(cpu_cpu_mask, powerpc_shared_proc_flags, PKG);
+	powerpc_topology[i++] = SDTL_INIT(tl_pkg_mask, powerpc_shared_proc_flags, PKG);
 
 	/* There must be one trailing NULL entry left.  */
 	BUG_ON(i >= ARRAY_SIZE(powerpc_topology) - 1);
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 46569b8e47dd..161beaf767ff 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -509,33 +509,27 @@ int topology_cpu_init(struct cpu *cpu)
 	return rc;
 }
 
-static const struct cpumask *cpu_thread_mask(int cpu)
-{
-	return &cpu_topology[cpu].thread_mask;
-}
-
-
-const struct cpumask *cpu_coregroup_mask(int cpu)
+const struct cpumask *cpu_coregroup_mask(struct sched_domain_topology_level *tl, int cpu)
 {
 	return &cpu_topology[cpu].core_mask;
 }
 
-static const struct cpumask *cpu_book_mask(int cpu)
+static const struct cpumask *cpu_book_mask(struct sched_domain_topology_level *tl, int cpu)
 {
 	return &cpu_topology[cpu].book_mask;
 }
 
-static const struct cpumask *cpu_drawer_mask(int cpu)
+static const struct cpumask *cpu_drawer_mask(struct sched_domain_topology_level *tl, int cpu)
 {
 	return &cpu_topology[cpu].drawer_mask;
 }
 
 static struct sched_domain_topology_level s390_topology[] = {
-	SDTL_INIT(cpu_thread_mask, cpu_smt_flags, SMT),
+	SDTL_INIT(tl_smt_mask, cpu_smt_flags, SMT),
 	SDTL_INIT(cpu_coregroup_mask, cpu_core_flags, MC),
 	SDTL_INIT(cpu_book_mask, NULL, BOOK),
 	SDTL_INIT(cpu_drawer_mask, NULL, DRAWER),
-	SDTL_INIT(cpu_cpu_mask, NULL, PKG),
+	SDTL_INIT(tl_pkg_mask, NULL, PKG),
 	{ NULL, },
 };
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 33e166f6ab12..eb289abece23 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -479,14 +479,14 @@ static int x86_cluster_flags(void)
 static bool x86_has_numa_in_package;
 
 static struct sched_domain_topology_level x86_topology[] = {
-	SDTL_INIT(cpu_smt_mask, cpu_smt_flags, SMT),
+	SDTL_INIT(tl_smt_mask, cpu_smt_flags, SMT),
 #ifdef CONFIG_SCHED_CLUSTER
-	SDTL_INIT(cpu_clustergroup_mask, x86_cluster_flags, CLS),
+	SDTL_INIT(tl_cls_mask, x86_cluster_flags, CLS),
 #endif
 #ifdef CONFIG_SCHED_MC
-	SDTL_INIT(cpu_coregroup_mask, x86_core_flags, MC),
+	SDTL_INIT(tl_mc_mask, x86_core_flags, MC),
 #endif
-	SDTL_INIT(cpu_cpu_mask, x86_sched_itmt_flags, PKG),
+	SDTL_INIT(tl_pkg_mask, x86_sched_itmt_flags, PKG),
 	{ NULL },
 };
 
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 5263746b63e8..c7457ccf05c4 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -30,11 +30,19 @@ struct sd_flag_debug {
 };
 extern const struct sd_flag_debug sd_flag_debug[];
 
+struct sched_domain_topology_level;
+
 #ifdef CONFIG_SCHED_SMT
 static inline int cpu_smt_flags(void)
 {
 	return SD_SHARE_CPUCAPACITY | SD_SHARE_LLC;
 }
+
+static const __maybe_unused
+struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_smt_mask(cpu);
+}
 #endif
 
 #ifdef CONFIG_SCHED_CLUSTER
@@ -42,6 +50,12 @@ static inline int cpu_cluster_flags(void)
 {
 	return SD_CLUSTER | SD_SHARE_LLC;
 }
+
+static const __maybe_unused
+struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_clustergroup_mask(cpu);
+}
 #endif
 
 #ifdef CONFIG_SCHED_MC
@@ -49,8 +63,20 @@ static inline int cpu_core_flags(void)
 {
 	return SD_SHARE_LLC;
 }
+
+static const __maybe_unused
+struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_coregroup_mask(cpu);
+}
 #endif
 
+static const __maybe_unused
+struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_node_mask(cpu);
+}
+
 #ifdef CONFIG_NUMA
 static inline int cpu_numa_flags(void)
 {
@@ -172,7 +198,7 @@ bool cpus_equal_capacity(int this_cpu, int that_cpu);
 bool cpus_share_cache(int this_cpu, int that_cpu);
 bool cpus_share_resources(int this_cpu, int that_cpu);
 
-typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
+typedef const struct cpumask *(*sched_domain_mask_f)(struct sched_domain_topology_level *tl, int cpu);
 typedef int (*sched_domain_flags_f)(void);
 
 struct sd_data {
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 33b7fda97d39..6575af39fd10 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -260,7 +260,7 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
 
 #endif
 
-static inline const struct cpumask *cpu_cpu_mask(int cpu)
+static inline const struct cpumask *cpu_node_mask(int cpu)
 {
 	return cpumask_of_node(cpu_to_node(cpu));
 }
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 977e133bb8a4..18889bd97e22 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1591,7 +1591,6 @@ static void claim_allocations(int cpu, struct sched_domain *sd)
 enum numa_topology_type sched_numa_topology_type;
 
 static int			sched_domains_numa_levels;
-static int			sched_domains_curr_level;
 
 int				sched_max_numa_distance;
 static int			*sched_domains_numa_distance;
@@ -1632,14 +1631,7 @@ sd_init(struct sched_domain_topology_level *tl,
 	int sd_id, sd_weight, sd_flags = 0;
 	struct cpumask *sd_span;
 
-#ifdef CONFIG_NUMA
-	/*
-	 * Ugly hack to pass state to sd_numa_mask()...
-	 */
-	sched_domains_curr_level = tl->numa_level;
-#endif
-
-	sd_weight = cpumask_weight(tl->mask(cpu));
+	sd_weight = cpumask_weight(tl->mask(tl, cpu));
 
 	if (tl->sd_flags)
 		sd_flags = (*tl->sd_flags)();
@@ -1677,7 +1669,7 @@ sd_init(struct sched_domain_topology_level *tl,
 	};
 
 	sd_span = sched_domain_span(sd);
-	cpumask_and(sd_span, cpu_map, tl->mask(cpu));
+	cpumask_and(sd_span, cpu_map, tl->mask(tl, cpu));
 	sd_id = cpumask_first(sd_span);
 
 	sd->flags |= asym_cpu_capacity_classify(sd_span, cpu_map);
@@ -1737,17 +1729,17 @@ sd_init(struct sched_domain_topology_level *tl,
  */
 static struct sched_domain_topology_level default_topology[] = {
 #ifdef CONFIG_SCHED_SMT
-	SDTL_INIT(cpu_smt_mask, cpu_smt_flags, SMT),
+	SDTL_INIT(tl_smt_mask, cpu_smt_flags, SMT),
 #endif
 
 #ifdef CONFIG_SCHED_CLUSTER
-	SDTL_INIT(cpu_clustergroup_mask, cpu_cluster_flags, CLS),
+	SDTL_INIT(tl_cls_mask, cpu_cluster_flags, CLS),
 #endif
 
 #ifdef CONFIG_SCHED_MC
-	SDTL_INIT(cpu_coregroup_mask, cpu_core_flags, MC),
+	SDTL_INIT(tl_mc_mask, cpu_core_flags, MC),
 #endif
-	SDTL_INIT(cpu_cpu_mask, NULL, PKG),
+	SDTL_INIT(tl_pkg_mask, NULL, PKG),
 	{ NULL, },
 };
 
@@ -1769,9 +1761,9 @@ void __init set_sched_topology(struct sched_domain_topology_level *tl)
 
 #ifdef CONFIG_NUMA
 
-static const struct cpumask *sd_numa_mask(int cpu)
+static const struct cpumask *sd_numa_mask(struct sched_domain_topology_level *tl, int cpu)
 {
-	return sched_domains_numa_masks[sched_domains_curr_level][cpu_to_node(cpu)];
+	return sched_domains_numa_masks[tl->numa_level][cpu_to_node(cpu)];
 }
 
 static void sched_numa_warn(const char *str)
@@ -2411,7 +2403,7 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
 		 * breaks the linking done for an earlier span.
 		 */
 		for_each_cpu(cpu, cpu_map) {
-			const struct cpumask *tl_cpu_mask = tl->mask(cpu);
+			const struct cpumask *tl_cpu_mask = tl->mask(tl, cpu);
 			int id;
 
 			/* lowest bit set in this mask is used as a unique id */
@@ -2419,7 +2411,7 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
 
 			if (cpumask_test_cpu(id, id_seen)) {
 				/* First CPU has already been seen, ensure identical spans */
-				if (!cpumask_equal(tl->mask(id), tl_cpu_mask))
+				if (!cpumask_equal(tl->mask(tl, id), tl_cpu_mask))
 					return false;
 			} else {
 				/* First CPU hasn't been seen before, ensure it's a completely new span */
-- 
2.34.1


