Return-Path: <linux-kernel+bounces-799867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C57B4310B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EC11C243E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC72F1D5CC7;
	Thu,  4 Sep 2025 04:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="09QWxHS6"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3D63AC1C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959577; cv=fail; b=RkV6cNFH0WIcda+eIHrcb9kUVca/Uc/Yx+Yr1LX16zjFB9F/j2s8wLgitbKDvzl87aLaEFTFUJgJ2Mf+K91TWn6XrostNUy4z/6YxrCi5C+upyfcXo5esKbVcEBgZSsnw3yGMozwydrCSBf6Z2juHgH/qo2kYbKoPMb2iP3n27g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959577; c=relaxed/simple;
	bh=+MBlvRSUrxHwtgwrrTINLPkcr6Me5Ls2RofZtN38uDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QV7zND6PfU9m3aVBBS8DitXn3Gzfy7CAj3Qm/RTXETOqTxssl1hHAtGViLBLsAS1x+WEmplUZr3WZ64TbGr2UBduWK01Hy8KEDZqJILq08ofQjt0S1ijoy0zdW4CTrJBMKrh/SPFoV1qQ19XdHAfMwTQiyHZiiGtS8AzAnVmf1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=09QWxHS6; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaICA3io8uoZIrnvtKtbMAq70sCDgS0A+FfFCrIdxPb6Z4O9FICVrZkDlT+fM+/8X0kRQjZGTpjm06/xZI9Vs4L0qW5XPTf6F/ufu9Em/3jktUAddvTcl8eUklNiB99K+KSwV7HkpiO8NBOdzoGh3sdSeu7aQcILLa4UsRdNU0Lk8GM4k8RU6MNyjQN9gT2inHD8FhInuf8OT+0/X7tmL0PnHd4mUSfJqjOkSEhSZL73HYAu6E3VfNEuI4cbMpn5H4z7ZifOYVlvjGKLJYlK1PNwzOkRvbga3ot6Y8ImXgnEZBabjepZe4jGN+mJlZTc9oXZ4Z0ECT9UQE4Sm1kBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4kRASR9h/lsud7FqOIhspyz8BQBgl63gSC5rs21WTw=;
 b=nMocNtQcnqJ3s6014LR4fVbBHJUF1FQw+og97bs8FQdfYF9GKFeZGqMC6rfLLaDiwjRFtujVDLtDA6R9meLKpf0XxooJuZZMndDpsHeZAGv0QK67A+EdZQ1Air6ZYD9ZYlUT6M3Qf1Q6KTaXqtS4tE1Q5jD4b71I1iDt9V/H69QUci+eiU1P9ywFX/0Pgt780vA4s1YEvGpJWnKaqbgt5/6AcqqCehOyWdjNw6YQQcwIUFhor5YNI/Y9gbxGwlOxgbGT/odPsajD42a2CY6VfmRIT4ijQxcHSKqzdSn4sI4+uVRITvQoxtno7C5ek0nHzHu+pINCDDbH/DCxolxuQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4kRASR9h/lsud7FqOIhspyz8BQBgl63gSC5rs21WTw=;
 b=09QWxHS6L1E1yNcpm1R6b/zI4wqEHGEFMCwH32ctU4mjivMh0AZ7ZC2tz5atBa97XikKDorwa8kjih1X6pAlsafNURzcAx6UrTm8Diqz36s15e9psmcvGySJz4ChiAeiWsMWK1LDyNOI+qVWq7v2j4MZ1SF/zkpaNuiQCxLPIMs=
Received: from SN7PR04CA0186.namprd04.prod.outlook.com (2603:10b6:806:126::11)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 04:19:28 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::e3) by SN7PR04CA0186.outlook.office365.com
 (2603:10b6:806:126::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 04:19:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:19:28 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:19:27 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:19:23 -0700
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [RFC PATCH 13/19] sched/fair: Extract the main _nohz_idle_balance() loop into a helper
Date: Thu, 4 Sep 2025 04:15:09 +0000
Message-ID: <20250904041516.3046-14-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904041516.3046-1-kprateek.nayak@amd.com>
References: <20250904041516.3046-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DM6PR12MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4c066c-e5dc-4338-6a12-08ddeb6a3d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|30052699003|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OiFO0qQcHvmw3qabiYE7FLazWdvi9Us1JDphIbDHOy3oMKaIfCI5zqihcsQC?=
 =?us-ascii?Q?poWYmh6VZdwNJgdbeHsd4C56duEmTCzi7aH629jZmjaTtL8j9KoNkJGTQ6oV?=
 =?us-ascii?Q?lH0rHyUK/y5Bolaol9WL+/tf0QOKzejT9ZNFuoWyhAKD8c5t6SUxJDmpvuX5?=
 =?us-ascii?Q?c4Hw8IzH9Lj6+T6TGYy2/icyEfQrNzwKcDv/YFQRmkrIVFLmAyWcixnczLSw?=
 =?us-ascii?Q?56a8Q44gFPg2kqV6OA//hQKk1rurCM8LrGw8ZHSU78Ihvj1xWPLJBBrLTkCJ?=
 =?us-ascii?Q?fMEwe599/HOk7KozY0k3tCSxlYKOZ1shNwFNXfZl53Qde9uy2iNT8rF20BTS?=
 =?us-ascii?Q?DMN6BeF0TZBnkDvQ891YVXzrj9E9oZNYwzWv+s2aBI/S+yVD2jQYv66hNWTg?=
 =?us-ascii?Q?HlCNmUxWb+HaD+xi6PkVK8UOZVOvcj2Fc5z6VHDcf/PL+5jBjlInm+th9NHl?=
 =?us-ascii?Q?NyFhCz1tsmrIiVfSCma8gh5WwOJ+jPo22ae3tVAWGCK/P0bF3Wlwv79nlxpI?=
 =?us-ascii?Q?jEDU78LpIpNkxcDt+ZhGAeCPt8x+XodT2+64JFq3pJGqlyzAxXgiknAnUioT?=
 =?us-ascii?Q?EbBXsJRPBV6YH7VDxkxRcDqfA8D5nEs+2Mc4F7qNRlLLzqqRehv59JBxOGue?=
 =?us-ascii?Q?t3Ekuf41yGYRXH5f8MIsnsry8Gac285o9BR37SzM1nS79sr+S9x1LpzjrXyW?=
 =?us-ascii?Q?BC9hijWfSFNpEFIQiTarmApwY1AuNEzUcjO/XO70J7W2OcyFsJm/J1u27nKx?=
 =?us-ascii?Q?hqiFG1MviDIlSYkgVyxo/Tm75h5xxV1gQODV0ebSobPtw9Q3NyicZ28Av4Av?=
 =?us-ascii?Q?6V/dEnedp2zJ1KzDLJdE6h7dEJr/r/4iV/vWeMpo6P2V/3GP5/sL2qacjOtu?=
 =?us-ascii?Q?+dmUEv+iLxGHxZxk0XwZ0wMoJahOVmIszzFhOAfkCSVpVfhpZ7Xsc1q5dypD?=
 =?us-ascii?Q?023u0cT6hppwGqj2FHWZIj09avEDjRWqUe37OoEzwTKOwgDd/2UT0XR5qPY0?=
 =?us-ascii?Q?DD7rKXF3pcV6UkODnBxXTs1qOIjbiH45XZrgA5hNrjsw6H8L63z3BSyZiYZ9?=
 =?us-ascii?Q?j5Svr0iSCPLLappb/iOnBMV/W+U/+o1jHU+hikiqpAEm5ksDz1xwOjkP7TY6?=
 =?us-ascii?Q?BWB505OVu1c/Z23qnDjTin/LibRctyjpvbpwVC47PkFTSLOaoRGRqKKvXA3h?=
 =?us-ascii?Q?L7jyZWVf6uLtLnRBjd3WJtG9kQcNxXURysjzd+rGtQuBbQxb8DPCcpYmGAIl?=
 =?us-ascii?Q?1H/YUjh8GmIsTpCqsBscEWDzWK990odQ3ZdXxvs4+YmdaEGk1MvHYzJs5nA+?=
 =?us-ascii?Q?ITlF41tAG7XLD9kexGMl6/o/lkZLWIML3Fr+Gy164tVs75uFXZR5T1ESQzSW?=
 =?us-ascii?Q?PZtGBP2E4OTpNhIuaQxZsBIYkI4RqctXtZ2B2cQRUKVNKyNJ5fh2A2QQi9lS?=
 =?us-ascii?Q?L3rROSwZx1NV3z3Qy/HWc5r3dcboe+0HOJV0dGfdnd8Wy0Qk7DN5Q+bzlVar?=
 =?us-ascii?Q?HZNBxQzeIj61PB4wnOEUw3ePKydKqYsaygdK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(30052699003)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:19:28.1742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4c066c-e5dc-4338-6a12-08ddeb6a3d35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107

With the distributed nohz idle CPU tracking using the
"nohz_shared_list", the trick to do the load balancing for the CPU
in charge of the nohz idle balance at the very end using
for_each_cpu_warp() will no longer work.

Extract the main loop and the loop body doing the load balancing on
behalf of an idle target into two separate helpers -
sched_balance_nohz_idle() and sched_balance_idle_rq() respectively
keeping consistent with the naming convention in fair.c.

This will help transitioning _nohz_idle_balance() to use the
"nohz_shared_list" in the subsequent commit.

No functional changes intended.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 161 ++++++++++++++++++++++++++++----------------
 1 file changed, 102 insertions(+), 59 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d13de6feb467..ad6e97be97d5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12580,6 +12580,97 @@ static bool update_nohz_stats(struct rq *rq)
 	return rq->has_blocked_load;
 }
 
+/*
+ * sched_balance_idle_rq(): Balance a target idle rq.
+ * @rq: rq of the idle CPU that may require stats update or balancing.
+ * @flags: nohz flags of the balancing CPU.
+ * @next_balance: Pointer to variable storing the time in jiffies to
+ *		  trigger the next nohz idle balancing.
+ *
+ * Returns: Update flags for caller to take appropriate actions.
+ * NOHZ_STATS_KICK indicates rq still has blocked load after the update.
+ * NOHZ_NEXT_KICK indicates that *next_balance was updated to rq->next_balance.
+ */
+static unsigned int sched_balance_idle_rq(struct rq *rq,
+					  unsigned int flags,
+					  unsigned long *next_balance)
+{
+	unsigned int update_flags = 0;
+
+	/* If rq has blocked load, indicate via NOHZ_STATS_KICK. */
+	if ((flags & NOHZ_STATS_KICK) && update_nohz_stats(rq))
+		update_flags |= NOHZ_STATS_KICK;
+
+	/* If time for next balance is due, do the balance. */
+	if (time_after_eq(jiffies, rq->next_balance)) {
+		struct rq_flags rf;
+
+		rq_lock_irqsave(rq, &rf);
+		update_rq_clock(rq);
+		rq_unlock_irqrestore(rq, &rf);
+
+		if (flags & NOHZ_BALANCE_KICK)
+			sched_balance_domains(rq, CPU_IDLE);
+	}
+
+	/* Indicate update to next_balance via NOHZ_NEXT_KICK. */
+	if (time_after(*next_balance, rq->next_balance)) {
+		*next_balance = rq->next_balance;
+		update_flags |= NOHZ_NEXT_KICK;
+	}
+
+	return update_flags;
+}
+
+/*
+ * sched_balance_nohz_idle(): Core nohz idle balancing loop.
+ * @balancing_cpu: CPU doing the balancing on behalf of all nohz idle CPUs.
+ * @flags: nohz flags of the balancing CPU.
+ * @start: Time in jiffies when nohz indicators were cleared.
+ *
+ * Returns:
+ * < 0 - The balancing CPU turned busy while balancing.
+ *   0 - All CPUs were balanced; No blocked load if @flags had NOHZ_STATS_KICK.
+ * > 0 - One or more idle CPUs still have blocked load if @flags had
+ *	 NOHZ_STATS_KICK.
+ */
+static int sched_balance_nohz_idle(int balancing_cpu, unsigned int flags, unsigned long start)
+{
+	/* Earliest time when we have to do rebalance again */
+	unsigned long next_balance = start + 60*HZ;
+	unsigned int update_flags = 0;
+	int target_cpu;
+
+	/*
+	 * Start with the next CPU after the balancing CPU so we will end with
+	 * balancing CPU and let a chance for other idle cpu to pull load.
+	 */
+	for_each_cpu_wrap(target_cpu, nohz.idle_cpus_mask, balancing_cpu + 1) {
+		if (!idle_cpu(target_cpu))
+			continue;
+
+		/*
+		 * If balancing CPU gets work to do, stop the load balancing
+		 * work being done for other CPUs. Next load balancing owner
+		 * will pick it up.
+		 */
+		if (!idle_cpu(balancing_cpu) && need_resched())
+			return -EBUSY;
+
+		update_flags |= sched_balance_idle_rq(cpu_rq(target_cpu), flags, &next_balance);
+	}
+
+	/*
+	 * next_balance will be updated only when there is a need.
+	 * When the CPU is attached to null domain for ex, it will not be
+	 * updated.
+	 */
+	if (likely(update_flags & NOHZ_NEXT_KICK))
+		nohz.next_balance = next_balance;
+
+	return update_flags & NOHZ_STATS_KICK;
+}
+
 /*
  * Internal function that runs load balance for all idle CPUs. The load balance
  * can be a simple update of blocked load or a complete load balance with
@@ -12587,14 +12678,8 @@ static bool update_nohz_stats(struct rq *rq)
  */
 static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 {
-	/* Earliest time when we have to do rebalance again */
 	unsigned long now = jiffies;
-	unsigned long next_balance = now + 60*HZ;
-	bool has_blocked_load = false;
-	int update_next_balance = 0;
-	int this_cpu = this_rq->cpu;
-	int balance_cpu;
-	struct rq *rq;
+	int ret;
 
 	WARN_ON_ONCE((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
 
@@ -12619,60 +12704,18 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 	 */
 	smp_mb();
 
-	/*
-	 * Start with the next CPU after this_cpu so we will end with this_cpu and let a
-	 * chance for other idle cpu to pull load.
-	 */
-	for_each_cpu_wrap(balance_cpu,  nohz.idle_cpus_mask, this_cpu+1) {
-		if (!idle_cpu(balance_cpu))
-			continue;
-
-		/*
-		 * If this CPU gets work to do, stop the load balancing
-		 * work being done for other CPUs. Next load
-		 * balancing owner will pick it up.
-		 */
-		if (!idle_cpu(this_cpu) && need_resched()) {
-			if (flags & NOHZ_STATS_KICK)
-				has_blocked_load = true;
-			if (flags & NOHZ_NEXT_KICK)
-				WRITE_ONCE(nohz.needs_update, 1);
-			goto abort;
-		}
-
-		rq = cpu_rq(balance_cpu);
-
-		if (flags & NOHZ_STATS_KICK)
-			has_blocked_load |= update_nohz_stats(rq);
-
-		/*
-		 * If time for next balance is due,
-		 * do the balance.
-		 */
-		if (time_after_eq(jiffies, rq->next_balance)) {
-			struct rq_flags rf;
-
-			rq_lock_irqsave(rq, &rf);
-			update_rq_clock(rq);
-			rq_unlock_irqrestore(rq, &rf);
-
-			if (flags & NOHZ_BALANCE_KICK)
-				sched_balance_domains(rq, CPU_IDLE);
-		}
-
-		if (time_after(next_balance, rq->next_balance)) {
-			next_balance = rq->next_balance;
-			update_next_balance = 1;
-		}
-	}
+	ret = sched_balance_nohz_idle(cpu_of(this_rq), flags, now);
 
 	/*
-	 * next_balance will be updated only when there is a need.
-	 * When the CPU is attached to null domain for ex, it will not be
-	 * updated.
+	 * The balancing CPU turned busy. Set nohz.{needs_update,has_blocked}
+	 * indicators to ensure next CPU observing them triggers nohz idle
+	 * balance again.
 	 */
-	if (likely(update_next_balance))
-		nohz.next_balance = next_balance;
+	if (ret < 0) {
+		if (flags & NOHZ_NEXT_KICK)
+			WRITE_ONCE(nohz.needs_update, 1);
+		goto abort;
+	}
 
 	if (flags & NOHZ_STATS_KICK)
 		WRITE_ONCE(nohz.next_blocked,
@@ -12680,7 +12723,7 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 
 abort:
 	/* There is still blocked load, enable periodic update */
-	if (has_blocked_load)
+	if (ret)
 		WRITE_ONCE(nohz.has_blocked, 1);
 }
 
-- 
2.34.1


