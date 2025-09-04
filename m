Return-Path: <linux-kernel+bounces-799871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53276B4310F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4718D5E55A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A9F3AC1C;
	Thu,  4 Sep 2025 04:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oAJw9VpN"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FD684039
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959647; cv=fail; b=vAvXhgWaB2yqjEPX5/0Rsd0i7Ii+3wm/1r4Wrk59pTXz+o3KXdNzJDwWjVZUbb3k0JFt3ps9AYFkJGxoMIyProxV5yABXx+BPUiCKQtQNuYcHGlIertsNsl+0HytxD5Wzf6BvXoFVU4gc3HIDmBU8qty90r+uaQpmOm6Pq9pNRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959647; c=relaxed/simple;
	bh=hKyvYl5PTn64DXXq3r80m8W91MQZPadx1o9nxdUukA0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITGT2kaPQ7389jpqGtl2e5jbrwHXkHUbKDRkqo0hcobDbwH43O0hz7oI6av7LVFB9gaU5QLM9/VTPT53KmaT43xZc96k792SBEVBC6Gb3miT1cwenYhZoLwC1en0BC6EgthX4e4LGG0reO2EGb7bBx13/4o7rSEdE6T9NDK/yhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oAJw9VpN; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ja/gDHhcyftlx6ez1Wasvuv+fMlNGf5IJJcRcT2Ylk5GUxY4z3R8aitHgQ/cpMrSF+f9QKzdytCyuy474LdBjo/kXgM+9fVq+HApBwz0Ki6kdBFWAfdw+hnMB6Q16STo7erRTlZZFSRL2nXfPQzhsxPpwZ6tPyTHCYOMGrby4gfFmdcXU38jnI4rxE6MDp9GwxwzNkwD2lcxr5FSJ2y31JChgxOAhNzrIRogsmMF/pMO7Pnjx19jnBXr2KE3psgNjozR6cuJFAl2IoE2ij36WriKutA/7uDsiq9bF4uVvIiqCf/eRBUuh0908xjZSS0F3GQrOV0T6vwZpxUzwypjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/twyjNUGVacluBbzZ/TgA9cups/thiEJLF5ODhc6u8=;
 b=xOaMObeL1T+6dHbqal6w7Xz8m/r6Pxt5tF/mZSSOA4azY00sUvI/DPOvFa04ZfYEI35v4IPGfb3YGu0iZpMHyB+Jj3IPme24NISx6AoAeWTNd0iOaglVAmO2wwJPs/Gq/yfq1M+3mFz/3fJc1qnDODFUipfKnttxMrtKe2UhT1Rt+nrDaLmFGriqYuK6RC3e07ZesFfmtLuDH5Bgcomd5z/6bIP+XyKoePgmlYUdQRPSKvXovyjfK4mAeYt0eimSgtaFhfbhypRoSiwi9lMnrDUeVOo/9bHOrAF5S75QOwWyuz1i232liJRIHYASu7xqsIeZnzRbI1JIN3kJM0fywA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/twyjNUGVacluBbzZ/TgA9cups/thiEJLF5ODhc6u8=;
 b=oAJw9VpNNLb0gxwQ+hMpe91zbSh6UJ3RuLtMmd1hffPBpUBkBhM2E5uLoTljh5eYteJrEKubyMeUaksJcgdD+V862m4oTtys7M5fDPl+Veh566SKTpJFS4JC0cIHMvUYPRNNZgxZr0XOcO2Esfu1PyhRkMQfuFZ/Rm8mtz5FzPA=
Received: from DM6PR07CA0067.namprd07.prod.outlook.com (2603:10b6:5:74::44) by
 BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 04:20:42 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:74:cafe::bf) by DM6PR07CA0067.outlook.office365.com
 (2603:10b6:5:74::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 04:20:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:20:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:20:41 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:20:37 -0700
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
Subject: [RFC PATCH 17/19] sched/fair: Remove "nohz.idle_cpus_mask"
Date: Thu, 4 Sep 2025 04:15:13 +0000
Message-ID: <20250904041516.3046-18-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: a5aee6b6-14ea-42c6-9bd4-08ddeb6a694a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YQOo/4bH00sLg/wmd0KXttX4Jb32jap1rpH0RjBoScPsb7uytSk7LqwCKQ7I?=
 =?us-ascii?Q?Cy5p4p4qOHn1ipz8JPrFW7WBH9mgHtxpSAr+U8Iy6Wj3ucilqs+CYqaCo0RM?=
 =?us-ascii?Q?WxI1d8QHJcmtw0kVBTbYWDv4+yJMLsX/5hMP6E8xWhs4xIB89jtielGkwvvw?=
 =?us-ascii?Q?HRbXGPE3XA8G7xpbIoE+sJOIvOWkOwaQzF6yOdZJ0sNnmj8SjW924FrNbU6k?=
 =?us-ascii?Q?VXwW7wG42ngDCmN1fd2vxAjUeXl/+mHrsT40diCXt3Rbe4fXQwa+Bo0lLDTv?=
 =?us-ascii?Q?0bzMeAUfu648TmeO7BmxA4mwMhMgiTghGEVHPXhcpeidaNBDXfQeKGBMu6Rv?=
 =?us-ascii?Q?OQkmQGrOlQy9XbU2U4yXCHJd+B5AFmOxGPhYiuZN5cZ+A56eO/g8A7GUlwVr?=
 =?us-ascii?Q?cwmUv9IuPQLqbEWwKhJTmfZjMQHhBF7SvbRx7ob39eYOJO3zB2dGe8LgThU4?=
 =?us-ascii?Q?MD/IVOwqhxJCxUpZwotD4mJLkZtsioq1aXr1gfsWLyTHmdr8ItncHQpcKdso?=
 =?us-ascii?Q?7cJIUwFTiwRPofaj4rDqHtv3KTmL60WKNit1JoMCvoJKdnJhlfLakS6p3eDs?=
 =?us-ascii?Q?0Sy4dVBhksGrK/NbLVK0yNfPJvMphuV3drACkxhmNJIpcDmOcBqcd3vDS9yy?=
 =?us-ascii?Q?QetjuWxFDtDrX9prsEd/Vl76c9GjKtNWk5qf4NRsGzHsMS+rL0qROr+wKb4G?=
 =?us-ascii?Q?I8gwgkccxRSZgu6kzpABWR7cWVRnIVtB3sjt8NWdVCL5PejYT/7K3JT/5+vq?=
 =?us-ascii?Q?jkY96mX8OA0OTdVQ4k3Jwv4n+3dHL0gQuUv4Ft5JKHD3NBVVGtq/n6WkDTcz?=
 =?us-ascii?Q?q91hcNAUG1JsPwL0LQb/dyy26pm5PTKTwMSwPAn26A+vLPHFRTer6KIogCqF?=
 =?us-ascii?Q?EOt3ywuj1jxpNBMYGJZ1vBHEyVDbbSA+dTrpYpgBO+BSPsWxld2f5Tp7eRtV?=
 =?us-ascii?Q?5G4qbylc14KPDkQ4P4HB2lzxIAcZbrL0rNkM/1hq/OCXUZtnDOW9no2uv0J2?=
 =?us-ascii?Q?dbvyNG/Itm2vfQ1zcuI8/PvaZZJkc65evaSqj6XJtcMXGD1rJgepjGhiOuOG?=
 =?us-ascii?Q?EpxwJUZh3Xn0/0PtQWJ1EpjnLVq05HvPBCu3I09kluECeI7VAEKq8q0/Y3CK?=
 =?us-ascii?Q?/zEKvvEDetkoR68DI+LkoshWGSVTSzALId5hFldlfV7TgQrgFTINW/iTTw38?=
 =?us-ascii?Q?riGF856jILQo7KKLsBnGbDWX31LJw9Ezxl75G7BX0SVqXWhJivTUuWZ6FuNv?=
 =?us-ascii?Q?/UQBoc4Mo0udrag44XGYhHg+yZ1nRw7/rR9TQt5EQj6XKoKdwD8yAR0Rbyjp?=
 =?us-ascii?Q?hpTCkzRR9jgTvIoiTvqszd0YzIH+ixPm1HwSqx6tuOUCQDGbS3Na/rHI3BTK?=
 =?us-ascii?Q?KEpldIZBsDNYPx4iyHU15r5VfHMWKX/dVB9aKLuhHbBXgPLLb6eFBIAJ1ilH?=
 =?us-ascii?Q?BxTkGJnOs/VE4zsl3x2RN9npCAaaRIcJBYMjxSd7mpHub15kE0FWFyPmMpGX?=
 =?us-ascii?Q?//V9odBbW18kX9KclqoKi67M8Y55s12N5/40?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:20:42.1148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5aee6b6-14ea-42c6-9bd4-08ddeb6a694a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

All users of "nohz.idle_cpus_mask" have been converted to use the
distributed nohz idle tracking using "nohz_shared_list". Get rid of the
centralized "nohz.idle_cpus_mask" based tracking.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c7ac8e7094ed..5b693bd0fab4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7169,7 +7169,6 @@ static DEFINE_PER_CPU(cpumask_var_t, should_we_balance_tmpmask);
 #ifdef CONFIG_NO_HZ_COMMON
 
 static struct {
-	cpumask_var_t idle_cpus_mask;
 	atomic_t nr_cpus;
 	int has_blocked;		/* Idle CPUS has blocked load */
 	int needs_update;		/* Newly idle CPUs need their next_balance collated */
@@ -12517,7 +12516,6 @@ void nohz_balance_exit_idle(struct rq *rq)
 		return;
 
 	WRITE_ONCE(rq->nohz_tick_stopped, 0);
-	cpumask_clear_cpu(rq->cpu, nohz.idle_cpus_mask);
 	atomic_dec(&nohz.nr_cpus);
 
 	set_cpu_sd_state_busy(rq->cpu);
@@ -12576,8 +12574,9 @@ void nohz_balance_enter_idle(int cpu)
 	/*
 	 * The tick is still stopped but load could have been added in the
 	 * meantime. We set the nohz.has_blocked flag to trig a check of the
-	 * *_avg. The CPU is already part of nohz.idle_cpus_mask so the clear
-	 * of nohz.has_blocked can only happen after checking the new load
+	 * *_avg. The CPU is already part of sd_nohz->idle_cpus_mask so the
+	 * clear of nohz.has_blocked can only happen after checking the new
+	 * load
 	 */
 	if (READ_ONCE(rq->nohz_tick_stopped))
 		goto out;
@@ -12588,7 +12587,6 @@ void nohz_balance_enter_idle(int cpu)
 
 	WRITE_ONCE(rq->nohz_tick_stopped, 1);
 
-	cpumask_set_cpu(cpu, nohz.idle_cpus_mask);
 	atomic_inc(&nohz.nr_cpus);
 
 	set_cpu_sd_state_idle(cpu);
@@ -12832,15 +12830,15 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
  * entering idle state. Here we run ILB directly without issuing IPIs.
  *
  * Note that when this function is called, the tick may not yet be stopped on
- * this CPU yet. nohz.idle_cpus_mask is updated only when tick is stopped and
- * cleared on the next busy tick. In other words, nohz.idle_cpus_mask updates
- * don't align with CPUs enter/exit idle to avoid bottlenecks due to high idle
- * entry/exit rate (usec). So it is possible that _nohz_idle_balance() is
- * called from this function on (this) CPU that's not yet in the mask. That's
- * OK because the goal of nohz_run_idle_balance() is to run ILB only for
- * updating the blocked load of already idle CPUs without waking up one of
- * those idle CPUs and outside the preempt disable / IRQ off phase of the local
- * cpu about to enter idle, because it can take a long time.
+ * this CPU yet. sd_nohz->idle_cpus_mask is updated only when tick is stopped
+ * and cleared on the next busy tick. In other words, sd_nohz->idle_cpus_mask
+ * updates don't align with CPUs enter/exit idle to avoid bottlenecks due to
+ * high idle entry/exit rate (usec). So it is possible that
+ * _nohz_idle_balance() is called from this function on (this) CPU that's not
+ * yet in the mask. That's OK because the goal of nohz_run_idle_balance() is to
+ * run ILB only for updating the blocked load of already idle CPUs without
+ * waking up one of those idle CPUs and outside the preempt disable / IRQ off
+ * phase of the local cpu about to enter idle, because it can take a long time.
  */
 void nohz_run_idle_balance(int cpu)
 {
@@ -13841,6 +13839,5 @@ __init void init_sched_fair_class(void)
 #ifdef CONFIG_NO_HZ_COMMON
 	nohz.next_balance = jiffies;
 	nohz.next_blocked = jiffies;
-	zalloc_cpumask_var(&nohz.idle_cpus_mask, GFP_NOWAIT);
 #endif
 }
-- 
2.34.1


