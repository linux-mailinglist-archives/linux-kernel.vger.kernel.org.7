Return-Path: <linux-kernel+bounces-799861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BBCB43104
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70C61C241D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B401DED4C;
	Thu,  4 Sep 2025 04:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gAlbyeqp"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DBE1A9F88
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959468; cv=fail; b=PGoEatedq/5M4rTZlcWE6UYFKKjuBPB8Pe6lHkgAUn23iyW5JmFyt1dJH0Ab7ULGC0mE9hy7yQH4/HcvVyYtv79bJf/1Fp559kwFmb8zXFnULSAdlhpklHRw3enLqPpuZLtH583nJateJZnc9rIfoHSz0yyfQd9eUeiazcLk9pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959468; c=relaxed/simple;
	bh=KV17BgO5tesOUBSvGkSR6Vqjs7Zr7ODWAyCNzKz/XtE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJuiQHkOvrC7S3iW91IN6dbYgFaetdzh/TlqbyE3hzjVXRIFy9B4zICaMWuwTrhpatIDpnYiDuLB4w8ZmTZQWFSwckNg9yjvjNWENkb+KLZ8Eqcehmlej1D4NxGPU9eHn/NOzUGswBocan90hD3I5poeFF9Rla8iJVdYJ74TCOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gAlbyeqp; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMnC/7OEqTZ6jJAXB3wL8dxWf+fuXGt2NrExqnzFNrIhVf8DIzZviojDFqXs+4W+OSpTEn1IHTOH0EMKAuJf8vPPB8QaTWrtLbtj7pGmTC+jjtTX2EzoiqjZAAD4liiMvsIJEuXlYxLp2ceXv+k9wIJo0yooqYzIJ2SDZ2LvhgPWQ0/BZEfk66wnQ9qoCpWxyxOAPuqOu3KDCMsxw/+sjZc4KjAWZhaRlvFTKLmMHDZmP75K1FTFRJN3gwPotOFyppQ5rHMI4woh1c/5MQwYmuKBLzvzeAcInHrw103G/oiyuGFEG6ncbd7IkqTxt20IVLQdQ41CqgFlXDZNFo7cNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqCcg5TpGZ9gEDApA/kQbKXVkLe96lj0Fj0Wtg0Nq+w=;
 b=YCqviRZy7CeKtxgkBhov9IVvwmywjPbQGc9F0DamH7MNC5wRfu67N0Prh0C4XZAFwAqL6Vl9Lb78vJxw+nGs7z7+lAyeK35UCUgGGKu0mMk+gUlkjWxskw7NPkvqEDhn6b+jbWcGQUsv9uAqsL/bK2ROwa7n7q6m0naIG1F+QEI+Ok8S55fHvwswHmgr1nRZiCg4cdinhygpXY5TtZ7KPAhgHuesbzDHF6X/Z3lncoZScP/ZtnVoqaWDotZMpMajVRq7e33TbPR21vFiQX4rSCEDTTzkLe/vOwHO0MbsLxBoTpjqODDl5oqivrSwafIxa2uJHoyotkkKcVK9OlVcPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqCcg5TpGZ9gEDApA/kQbKXVkLe96lj0Fj0Wtg0Nq+w=;
 b=gAlbyeqpfSvckT6v5YEJAOEni+/YjLAtUDE8D3l2yfv5txPd2FhrVO1lynn4Ck+CgJw1/lxagUma6Vf4lY6O0JNA7GSb3C8IgcC6um5Q7Az23obIroIoFGUj7+gbAZbjzAJVb7NsTwLfODMAvnNRb0Nkby50selOki9wgJMr+XI=
Received: from SJ0PR03CA0342.namprd03.prod.outlook.com (2603:10b6:a03:39c::17)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 04:17:40 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::6e) by SJ0PR03CA0342.outlook.office365.com
 (2603:10b6:a03:39c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 04:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:17:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:17:39 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:17:35 -0700
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
Subject: [RFC PATCH 07/19] sched/fair: Account idle cpus instead of busy cpus in sd->shared
Date: Thu, 4 Sep 2025 04:15:03 +0000
Message-ID: <20250904041516.3046-8-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 952afbab-01a2-4505-90e3-08ddeb69fcaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SwVUQ9PmA3zHH2ByurCpDGyd4J6+WV8zhBngjMRPTK5Uv6ixmCkOkx3FmktB?=
 =?us-ascii?Q?FTf5TrBHoOgW2glabQnezE/RQmF9YaqguzjrDTzkaIqy268I6GvxdCuhv5Lx?=
 =?us-ascii?Q?GtIjx2ZBZwWOVXdSX2T9/u6846VxW1H0pljGSru8HdUsR88LnJZcDPmfDmlK?=
 =?us-ascii?Q?84oCBUKzz4ekqdFa6FN9aEezywOdrgNwVyPsNT4wyHlNR73lHdT+UOR2PblZ?=
 =?us-ascii?Q?nd5O1y5dvIivPS5s5Ynt9rI+NibOCQ6t/CSMpp6IcSK3JU7YvljpF9VF5Ajn?=
 =?us-ascii?Q?8yA4W4C1Fs228OJA+ID+gIKm5UnNLoBZ5ZenjKPT61KdvcfrDWzUDut0JkwT?=
 =?us-ascii?Q?Sb5iIqlFdGmvc9tudfLB9KcccOE51+soJJDmu2wavxC/WlS6WYot1v53iXma?=
 =?us-ascii?Q?pnzXveVgfE7BE29drz2jx88UMcXmTu3nitUs/UnquQiimmR78HWnitS1squp?=
 =?us-ascii?Q?WK9KrZEEYFvelunDFXSYP6ZAVYo4aI/xIj6PYAkGBDXUj8rsGp3tmioIDii6?=
 =?us-ascii?Q?2Pyo5KYAajYLXKap/CTzoPfYtNGgjccxHftP5UzIr8loB7dMCp1h4ZrOoOB5?=
 =?us-ascii?Q?e3cdYyqP4GqsVFfvfg6pde3BqX24LS2Rhxme5a8WlTpxPJ5DFZAm/3NeDlOR?=
 =?us-ascii?Q?Vm2ppHutcWgmqowOKOkC6a2mgM4BtLx5/KHX7OZGPSjsrIOHthtjTq7zv17H?=
 =?us-ascii?Q?zDZoVOJ8nnb6aBvAMkq3/LJ9a4TA4jmYKQYIBWRS8Trrr0caSQP9/SKcEI78?=
 =?us-ascii?Q?/otEqjt+Gpn/HWr/vk8tPFgz4jpyMs2fXSnrXV6bqhXLO8ukQ6kKqHRCEseO?=
 =?us-ascii?Q?DW43mVHziS4hfaozHU3jsaVSzRZVKvCPEbnP1bM+fqtL5+rcONhP+cw2YGW8?=
 =?us-ascii?Q?tJ/jg8dli3/SUF9x7jmX5BkjxNZ6/OugInYcxafV9shS5TZK64sLIsNRzbOQ?=
 =?us-ascii?Q?hU4Mr2PtqGou8a0SbjsBiDJLqEj11WZEEk/uLB2i/NPS5pkewOTEofkhCYu3?=
 =?us-ascii?Q?LhCmY+dCh1sYiUJyKO/kocYkRBQ2nqsVfMhrcQZu1BKNBPV/yuPBvsNUvaBK?=
 =?us-ascii?Q?zdFD4Qs8rgU0+Y4bGfLEJ0TDvu59iw+HPkN1/IZUd1iPWZ6XD3DtlXxXVc6E?=
 =?us-ascii?Q?Ct9f/61k4wW3dKIoaPPQMPlFG0wxIIdr0QQWQAxPn7S4hl6TU4blj9G6AZDs?=
 =?us-ascii?Q?rFA4Z4YkiFn/ljw1bBU/LQozGaWXAv7V+W20Ye+wS2ZXwfOlrxFmvIkYdTlN?=
 =?us-ascii?Q?wRCgIY04rpX4EK2tmN677MFhi09fTQ+biOjqkISh4Kv8/HxspAjZaXGaXWCe?=
 =?us-ascii?Q?C8oClkHYARd5VbWxx0WdQ0KbVTfANgzmYnp2VKi5ZliFRhgiGjslRYUWEN4T?=
 =?us-ascii?Q?ysoDjDYiEQeOIwFAI6NDcwgQEc2EWTif+aM7Sk01N+duBqrI99w9iiImYPW3?=
 =?us-ascii?Q?wM10Tf/cw025JVK2aONXeMj2Hia+mGNNqNG0G2CEescT9MCtyn05lScqY2m2?=
 =?us-ascii?Q?+KODXxmdJOKWjesvu0i/q8hOzMxI1hm3wZG8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:17:39.9059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 952afbab-01a2-4505-90e3-08ddeb69fcaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232

Switch to keeping track of "sd->shared->nr_idle_cpus" instead of
"nr_busy_cpus". Since previous commit corrected the "sd->nohz_idle"
state during sched domain rebuild, the nr_idle_cpus will reflect the
correct number of idle CPUs.

The idle CPUs accounting will be used for nohz idle balance in the
subsequent commits.

Races are possible during hotplug / cpuset where "nr_idle_cpus" might
be incorrectly accounted if the CPU enters exits out of nohz idle state
between the read of "rq->nohz_tick_stopped" and the subsequent update of
"sd->nohz_idle" in the hotplug path but these inaccuracies are transient
and will be corrected when the CPU enters idle or receives a tick.

  CPU0 (hotplug)                                    CPU1 (exits nohz idle)
  ==============                                    ======================
  online()
    if (rq->nohz_tick_stopped) /* True */
      ...                                          rq->nohz_tick_stopped = 0
      ...                                          set_cpu_sd_state_busy()
      ...
      set_cpu_sd_state_idle()

These situations are rare and should not have any long-term effect on
the nohz idle balancing since there isn't a case where a nohz idle CPU
is not set on the mask - either the hotplug thread sees that
"rq->nohz_tick_stopped" is set or the CPU going idle sees the updated
sched_domain hierarchy.

After the conversion, all the bits that use "nr_idle_cpus" are already
guarded behind CONFIG_NO_HZ_COMMON which makes it convenient to put the
declaration behind CONFIG_NO_HZ_COMMON as well.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched/topology.h |  4 +++-
 kernel/sched/fair.c            | 10 +++++-----
 kernel/sched/topology.c        |  1 -
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index d816911de435..2f0d8ecea427 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -65,7 +65,9 @@ struct sched_group;
 
 struct sched_domain_shared {
 	atomic_t	ref;
-	atomic_t	nr_busy_cpus;
+#ifdef CONFIG_NO_HZ_COMMON
+	atomic_t	nr_idle_cpus;
+#endif
 	int		has_idle_cores;
 	int		nr_idle_scan;
 };
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 61e1b4deb3e8..dee0ded7f40d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12429,7 +12429,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * the others are - so just get a NOHZ balance going if it looks
 		 * like this LLC domain has tasks we could move.
 		 */
-		nr_busy = atomic_read(&sds->nr_busy_cpus);
+		nr_busy = per_cpu(sd_llc_size, cpu) - atomic_read(&sds->nr_idle_cpus);
 		if (nr_busy > 1) {
 			flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 			goto unlock;
@@ -12458,7 +12458,7 @@ static void set_cpu_sd_state_busy(int cpu)
 	if (!xchg(&sd->nohz_idle, 0))
 		return;
 
-	atomic_inc(&sd->shared->nr_busy_cpus);
+	atomic_dec(&sd->shared->nr_idle_cpus);
 }
 
 void nohz_balance_exit_idle(struct rq *rq)
@@ -12488,7 +12488,7 @@ static void set_cpu_sd_state_idle(int cpu)
 	if (xchg(&sd->nohz_idle, 1))
 		return;
 
-	atomic_dec(&sd->shared->nr_busy_cpus);
+	atomic_inc(&sd->shared->nr_idle_cpus);
 }
 
 static void cpu_sd_exit_nohz_balance(struct rq *rq)
@@ -12955,7 +12955,7 @@ static void rq_online_fair(struct rq *rq)
 
 	update_runtime_enabled(rq);
 
-	/* Fixup nr_busy_cpus and nohz stats. */
+	/* Fixup nr_idle_cpus and nohz stats. */
 	cpu_sd_reenter_nohz_balance(rq);
 }
 
@@ -12969,7 +12969,7 @@ static void rq_offline_fair(struct rq *rq)
 	/* Ensure that we remove rq contribution to group share: */
 	clear_tg_offline_cfs_rqs(rq);
 
-	/* Fixup nr_busy_cpus and nohz stats. */
+	/* Fixup nr_idle_cpus and nohz stats. */
 	cpu_sd_exit_nohz_balance(rq);
 }
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index a059641e12e5..0b0257937a97 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2581,7 +2581,6 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 				int llc_id = cpumask_first(sched_domain_span(sd));
 
 				sd->shared = *per_cpu_ptr(d.sds, llc_id);
-				atomic_set(&sd->shared->nr_busy_cpus, sd->span_weight);
 				atomic_inc(&sd->shared->ref);
 			}
 
-- 
2.34.1


