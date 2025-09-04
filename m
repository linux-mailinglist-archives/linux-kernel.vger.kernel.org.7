Return-Path: <linux-kernel+bounces-799872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB81B43110
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA056841D6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1941DED4C;
	Thu,  4 Sep 2025 04:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zKFTV3zg"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7B31D5CC7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959666; cv=fail; b=opuKk/li8tfq2PwyQx0NRDJ0Wuz5CIhtVTLrzE56QEe2tMBGIVEsmdOJH1T2UmCgVekWHBTAIzkPfVSvBDYddD+dYH6v5dLRVC/ELwMKFWlGxW0az93gh731q+54emR2hPFWCABJJUvkApy713pOa2URHJ+xYCQVpOQ2Pc/qh9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959666; c=relaxed/simple;
	bh=nr17AjcVe1HiZTAB3y0lXa8nBZWVA5M1AJIb8/yEQwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAkxh+eRr/UhGPlv2a9f/8SO5OVqIRjFb2N/d8cWhdAPktn49SdmVoVfU5UVf63/l7apDz2Y8Y1v62fFgDJpXmC5qRfBzh3tH0h6XNiks28ii2uYDjM3uz7mEHPKIslHPa3JzbKeKd4yBKG7aYC7EFyYb3i42TnIrRH6cR3+Dkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zKFTV3zg; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9cvvz5XUu+ryNAOoTBjT5xVAl2IPs9yF1AjZbv1fwBEQ7/WcZAnyTUYDMz/eD2ImKbNW98r3D0JjtG1fXvLuudCiEL7pdalqOiE/Emvv2jF4hiR+C4j/xfvOlHQGoRH1jkQnMNVG7z10s6/dF/gc3lXEH7SAwWKaQNDuHrl+4DrUnIP2oRYpu7gBd1IrOEkshPNt5FejWE4QVcYZ06GwRx9GJXSXFn9xQ+dmVp+EfzGMcOpilXDbiQhdKrHZ7qKHhlZ+Wt35Nnny7qMs1rT7Fgz3nmXNVjCS+Q2azMz4R/24+mIC+Sdm0Fl3RJa1ghTN3encuY6/2ZG6MqpT5Oozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vv1JvgBBI7j1I+4EsOc/0xkP3+S5VtDpVyOtvLrYIIw=;
 b=Seni9SA1lLsVokRL/BuY2daHiZhUchdlsj7gMBqBQk5gbINnfIng9EKYdBgiExwYzSGb3gQinwELHsJ5Q/hcXMoTepW7Im75XfXVGJZ4X07GvI1H7SPlqornv8RNlUJE61Fw7QNRHSa0A23FWQhMjoeGdKC/mAi3bmNjahDYrPJchaDWa1oKUzfh9kCKnuUAnU0ThdfiaBGqCaTvui/pxdZI14xKLr23EbPxF3uwak9FenOp1VlMf4w9digDnmmUemZQfAxTAwjU7TDw44oQme1x8w1hkeTIHua7gMADiyZU9rgcJU0m8E+lBatUnMrTcutpiJVEqXx0Jvuv/KLRXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv1JvgBBI7j1I+4EsOc/0xkP3+S5VtDpVyOtvLrYIIw=;
 b=zKFTV3zgdqY1tDAoG/tjd3PImBidn945ZtRi2YWhPSd+76rrzdEpD8rd+iTJzAzWVuACmWqYIjZ0q5ZchkckYTVvX0Y6ijXUzYAooO8BCLJHujMNhk+NeY9C8CaRAX250vLwDx1t/4yhrHiXBC3J4TZ5y0p/Z03GmWx5kvjhyJI=
Received: from BL1P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::11)
 by PH7PR12MB6610.namprd12.prod.outlook.com (2603:10b6:510:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 04:20:59 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::39) by BL1P221CA0013.outlook.office365.com
 (2603:10b6:208:2c5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 04:20:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:20:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:20:58 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:20:54 -0700
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
Subject: [RFC PATCH 18/19] sched/fair: Optimize global "nohz.nr_cpus" tracking
Date: Thu, 4 Sep 2025 04:15:14 +0000
Message-ID: <20250904041516.3046-19-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c05353d-f4e8-40b7-0d42-08ddeb6a737b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2VOnH9mwmPdHIqDXNxEhQXwZrzyCC4OSGcPlnwjsv94UTySd5LbU4FD0Rih7?=
 =?us-ascii?Q?y84mzmJthnM7jlGnzWkT4HUwQ3SjtBs2QclvmEVAsbkp+P1shzn17hP3ECZG?=
 =?us-ascii?Q?746WZRN5+wRr1e5wJj6JRgClWUBuB6y/UulIfmrvdRP4Ktw3e7TtZN22Q8ma?=
 =?us-ascii?Q?N0CypAscZQJUxCr6OCQDYNPtOXHm8pI7KZtdQvSsxryPHeOyWotPy3KDyjsC?=
 =?us-ascii?Q?irKZjJQLq957vmZvPWLfGhQ4x94G0oKepA+eOa523kgP73C+Cer70MHh6+ca?=
 =?us-ascii?Q?rBmey7DpT/1n+wKcAgjrVYMSLlJ0DXdJWr31SFSyi3gr8rCjPYwUJPbMkASj?=
 =?us-ascii?Q?UpZ1OBBriXaVEgdg/JVqfLKX0Vx1B+uQ+43uxMAjq2d0hiukOcsjXG4KqoIb?=
 =?us-ascii?Q?sL4QnqI214Q2g7kRL9CY2mSxHVR5BYR7ZeqjJT+05WppPSJpTB9nmyLY/5XK?=
 =?us-ascii?Q?X7z2fkoFTF72dVfcncr3NjoFU/xJi7OZ1gLZ9hLZ3A+d7bt1Iz+wzN5iIu/l?=
 =?us-ascii?Q?LZtyLhMFkPYbebYeNXHAXE47IB6RW3g2vBrh4OIDhVbchUDcB2RyzMjwRlzC?=
 =?us-ascii?Q?ysYR+roh27iybncACvTpzpE6FCQ1WPmiFjn3LqGlGOHp4uXSYbwKMoyICzqh?=
 =?us-ascii?Q?mIJJuiD8kqdLVCzJDHiYRnkrrZ8nP5JfTgLWPrrmnfLrHvIbWu8aqq+65Ypf?=
 =?us-ascii?Q?VCYzPjQ3qTBy2xf1kprssgLVELz1GN6/AESdTI9S1FmbRZozi4yLFqR4oMPn?=
 =?us-ascii?Q?Q8UkHEVhWKlRrzeRw+A/1rteVf/NyyOuhYiE5U+Ru6ATdxvkbTTQ2YrJVxbn?=
 =?us-ascii?Q?ogcVhK+M6q6lZsYwIA5li/Cxsqx9TSc6VxmSenGpIIkIF0XDTZpI1cNuDMJm?=
 =?us-ascii?Q?GB0TAqWDf3YJ+HWCfcLieqMnG1WRSdyhafbHFaC8YRPpqy8MWsM2M75E3z7R?=
 =?us-ascii?Q?VLLy+/U6HR22JG6vbjhu5jevoLCzSl9ueblKwQC7//rB8r+tdTz6c6M6x+VU?=
 =?us-ascii?Q?iomkzRlRUBl+JY6O/0WcctNlHmiDZcHSGupaT2ZpHM5ExgrPm8BERT6pQgTj?=
 =?us-ascii?Q?WZnXGmr5rbKH4tqaSpNnZ2MWFvCdDTFkzzvbuwqlx88vLOLM5WeBwxzhJgQ+?=
 =?us-ascii?Q?BQjtekcpV5vJhkvC6T5c4qnTcdzF/LFVTPzy+Q13XkH/G0cNrE2AIcqKF8Hr?=
 =?us-ascii?Q?WShD2/AjzAqW7ISLp1olgaD7OfuM8hi3e4X+WylkKpng+yJQ8fVpohzlIpT5?=
 =?us-ascii?Q?24GMDBB7R5a2jbNUTvAobTBowgrhRvaiiEjLhPySiW1OLln/hfVOicoOrLLC?=
 =?us-ascii?Q?hRBJpkIuIsm7f9zA7PPlB4ZC2uO7qjq8G30WYGz4sh/86nGk0LyRvPWxs60Z?=
 =?us-ascii?Q?GpaRWwT5AhjAbhZCL8MUgMCUg7NYz6ozoLp7SSwsnTng53TYSCr/JeBogxck?=
 =?us-ascii?Q?7XEOZn0SAd3QKXKBBDOScGCXtqUV7jMXjUXyUkLAZrMSGVsOLPjqwO52KKwi?=
 =?us-ascii?Q?Mmv42UI3yGWkWukDPktIX8I+eFlkM5hafQGl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:20:59.2547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c05353d-f4e8-40b7-0d42-08ddeb6a737b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610

Optimize "nohz.nr_cpus" by tracking number of "sd_nohz->shared" with
non-zero "nr_idle_cpus" count via "nohz.nr_doms" and only updating at
the boundary of "sd_nohz->shared->nr_idle_cpus" going from 0 -> 1 and
back from 1 -> 0.

This also introduces a chance of double accounting when a nohz idle
entry or the tick races with hotplug or cpuset as described in
__nohz_exit_idle_tracking().

__nohz_exit_idle_tracking() called when the sched_domain_shared nodes
tracking idle CPUs are freed is used to correct any potential double
accounting which can unnecessarily trigger nohz idle balances even when
all the CPUs have tick enabled.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c     | 63 ++++++++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h    |  1 +
 kernel/sched/topology.c |  1 +
 3 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5b693bd0fab4..d65acf7ea12e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7169,7 +7169,7 @@ static DEFINE_PER_CPU(cpumask_var_t, should_we_balance_tmpmask);
 #ifdef CONFIG_NO_HZ_COMMON
 
 static struct {
-	atomic_t nr_cpus;
+	atomic_t nr_doms;
 	int has_blocked;		/* Idle CPUS has blocked load */
 	int needs_update;		/* Newly idle CPUs need their next_balance collated */
 	unsigned long next_balance;     /* in jiffy units */
@@ -12408,7 +12408,7 @@ static void nohz_balancer_kick(struct rq *rq)
 	 * None are in tickless mode and hence no need for NOHZ idle load
 	 * balancing:
 	 */
-	if (likely(!atomic_read(&nohz.nr_cpus)))
+	if (likely(!atomic_read(&nohz.nr_doms)))
 		return;
 
 	if (READ_ONCE(nohz.has_blocked) &&
@@ -12505,7 +12505,8 @@ static void set_cpu_sd_state_busy(int cpu)
 		return;
 
 	cpumask_clear_cpu(cpu, sd->shared->idle_cpus_mask);
-	atomic_dec(&sd->shared->nr_idle_cpus);
+	if (!atomic_dec_return(&sd->shared->nr_idle_cpus))
+		atomic_dec(&nohz.nr_doms);
 }
 
 void nohz_balance_exit_idle(struct rq *rq)
@@ -12516,7 +12517,6 @@ void nohz_balance_exit_idle(struct rq *rq)
 		return;
 
 	WRITE_ONCE(rq->nohz_tick_stopped, 0);
-	atomic_dec(&nohz.nr_cpus);
 
 	set_cpu_sd_state_busy(rq->cpu);
 }
@@ -12535,7 +12535,58 @@ static void set_cpu_sd_state_idle(int cpu)
 		return;
 
 	cpumask_set_cpu(cpu, sd->shared->idle_cpus_mask);
-	atomic_inc(&sd->shared->nr_idle_cpus);
+	if (!atomic_fetch_inc(&sd->shared->nr_idle_cpus))
+		atomic_inc(&nohz.nr_doms);
+}
+
+/*
+ * Correct nohz.nr_doms if sd_nohz->shared was found to have non-zero
+ * nr_idle_cpus when freeing. No local references to sds remain at
+ * this point and the only reference possible via "nohz_shared_list"
+ * will be dropped after the grace period.
+ */
+void __nohz_exit_idle_tracking(struct sched_domain_shared *sds)
+{
+
+	/*
+	 * It is possible for a idle entry to race with sched domain rebuild like:
+	 *
+	 *  CPU0 (hotplug)			CPU1 (nohz idle)
+	 *
+	 *  rq->offline(CPU1)
+	 *    set_cpu_sd_state_busy()
+	 *    rq->sd = sdd;			# Processes IPI, re-enters nohz idle
+	 *    ...				# For old sd_nohz
+	 *    ...				atomic_fetch_inc(&sd_nohz->shared->nr_idle_cpus);
+	 *    ...				atomic_inc(&nohz.nr_doms); # XXX: Accounted once
+	 *    update_top_cache_domains()
+	 *  rq->online(CPU1)
+	 *  # rq->nohz_tick_stopped is true
+	 *  set_cpu_sd_state_idle()
+	 *    # For new sd_nohz
+	 *    atomic_fetch_inc(&sd_nohz->shared->nr_idle_cpus);
+	 *    atomic_inc(&nohz.nr_doms); # XXX: Accounted twice
+	 *  ...
+	 *
+	 * "nohz.nr_doms" is used as an entry criteria in nohz_balancer_kick()
+	 * and this double accounting can lead to wasted idle balancing
+	 * triggers. Use this path to correct the accounting:
+	 *
+	 *  # In sds_delayed_free()
+	 *  __nohz_exit_idle_tracking(sds)
+	 *    # sd->shared->nr_idle_cpus is != 0
+	 *    atomic_dec(&nohz.nr_doms); # XXX: Fixes nohz.nr_doms
+	 */
+	if (atomic_read(&sds->nr_idle_cpus)) {
+		/*
+		 * Reset the "nr_idle_cpus" indicator to prevent
+		 * existing readers from traversing the idle mask
+		 * to reduce chances of traversing the same CPU
+		 * twice.
+		 */
+		atomic_set(&sds->nr_idle_cpus, 0);
+		atomic_dec(&nohz.nr_doms);
+	}
 }
 
 static void cpu_sd_exit_nohz_balance(struct rq *rq)
@@ -12587,8 +12638,6 @@ void nohz_balance_enter_idle(int cpu)
 
 	WRITE_ONCE(rq->nohz_tick_stopped, 1);
 
-	atomic_inc(&nohz.nr_cpus);
-
 	set_cpu_sd_state_idle(cpu);
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9cffcfbef1ae..fcf4503caada 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3100,6 +3100,7 @@ extern void cfs_bandwidth_usage_dec(void);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_nohz);
 extern struct list_head nohz_shared_list;
 
+extern void __nohz_exit_idle_tracking(struct sched_domain_shared *sds);
 extern void nohz_balance_exit_idle(struct rq *rq);
 #else /* !CONFIG_NO_HZ_COMMON: */
 static inline void nohz_balance_exit_idle(struct rq *rq) { }
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 86e33ed07254..ee9eed8470ba 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -615,6 +615,7 @@ static int sds_delayed_free(struct sched_domain_shared *sds)
 	scoped_guard(raw_spinlock_irqsave, &nohz_shared_list_lock)
 		list_del_rcu(&sds->nohz_list_node);
 
+	__nohz_exit_idle_tracking(sds);
 	call_rcu(&sds->rcu, destroy_sched_domain_shared_rcu);
 	return 1;
 }
-- 
2.34.1


