Return-Path: <linux-kernel+bounces-799863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAF2B43107
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BC24847F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE1B1F131A;
	Thu,  4 Sep 2025 04:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4s/JzYjr"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706E91BC58
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959501; cv=fail; b=BfimGFOTpXKiNc1U1rlIGOhJXDxDVYv4dhV7D7PD2rLk/a9TuHxikiprGu2hhbhkcfXC6ZKNqGS3acFjUJD7oaCB41v4KgNyCYc94E9hg0bPbrlwMZ7efJhwcQX13haVVfs8wfcOlQFGLpl5/5bWoPh4l4vDO/o0ufIFUhEPwWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959501; c=relaxed/simple;
	bh=u2rNDdKkP0SQ0ttI1YOun7g1iJXrLG5/q0Gf95Y4H3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FnPb0h7JgLGczMMC9JV5+me1l3zx8CUO2pQDQuuq2iUL+2mCxP92cnyCLlwgCujFN7hI+Qj5lOFBzozSsOL9adklSmMTEvBXX43nw7r+b3kMrEWVdgxtSeMBICheHTV01zTAVUNqmzLl4v79n2x9D9d8Z4oDfVKkLf0a8NmIIC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4s/JzYjr; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKzN6czCfgYnrh6YB/TZNDdlgjsEi8TpbtCJpyuONI6edDpp8B2e9FlDY1LKHt9eOZxukYGBLtQY1NyNDFA3G33Eis5XsFmr8+I+/Uj+CIfYOfU0WQx74g3rECt064D6nbfdNku9bu7i4LD+AfAFD4AX/ivts4GDP0toS93xWVQIkTV55b16DPVdsL10qqr3nqJi6hT4nIp3bviHbHHtsXtBccpdvBhJXn6VwYN53asmeDFQ7BRzQa6iU9/ZlRy4XEWNTymyjv5PpgkI/pR9K7hYBfNdoXPU7CtkjIHwv7+xMvjbDqQXFkz+YX+mYwVBszEytKG8XtRPwAK/5L2EEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAfcEeA5Mf6rl7zoeQLTaVVhpW5455LMFPvJ1SEQB1g=;
 b=WM0abD+SmF04Bwz5dJPsSrt6j3OmLirtwQc/q+fGCS99GG/d8SRBZZ7TwgK9xx8RJsNjqug9RGG1zPLToVl8Uf3DNVD3OhQiYtB5PxzqL5S+CZAwJ8pEdO/NDBnPtZnUy7Xtn9xUxVG7t8jvw7XD74s8Jp/TR1S0nVGXs1YoOq9zXFiDP63MytFWMJwv3ZeAcasMOeSLqPR0ggkgmU5FazHmu+koc2qv4mPqSNdD8HvNg1rnS9t0k7OBN/MpEsulvxP7p8khZjSpZg/O40Nq5dCwU/9vQDOQAhDHRqHVoeVOKLZ2gvG2d4dHZ0x9sgc7afMiZ8iFf4E8i92moKZv3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAfcEeA5Mf6rl7zoeQLTaVVhpW5455LMFPvJ1SEQB1g=;
 b=4s/JzYjrcEpfMuO1Z/FQif07Id3/WGP7uQj8U033xUL3pAtIPAPO2V7s2B/RfF2ohsi5YilRi0vhOPyLgYW491NhIZ7DngYY07ICNRfv8fDfwV/PrFhuPXqrlPLIXpwxdk0gbC7p0H5FNY/FJZAeMnnFrJt4sTnkkQvXOw21fLM=
Received: from SN4PR0501CA0066.namprd05.prod.outlook.com
 (2603:10b6:803:41::43) by DS0PR12MB7927.namprd12.prod.outlook.com
 (2603:10b6:8:147::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 04:18:14 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:803:41:cafe::2) by SN4PR0501CA0066.outlook.office365.com
 (2603:10b6:803:41::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.6 via Frontend Transport; Thu, 4
 Sep 2025 04:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:18:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:18:13 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:18:09 -0700
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
Subject: [RFC PATCH 09/19] sched/topology: Introduce percpu sd_nohz for nohz state tracking
Date: Thu, 4 Sep 2025 04:15:05 +0000
Message-ID: <20250904041516.3046-10-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DS0PR12MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 7686ed8d-2667-4cbf-6804-08ddeb6a1117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nyuhlNXy+NXArKsGa3HF07VAS9ajcp7aj7jgaw6udApppjZJT2J0rypBIhGQ?=
 =?us-ascii?Q?GjoWVAVZbTtMAygJPfvjKxXGs6/vn8SXUxPN64d9BMVT5u7WKS3gr3WJTbnl?=
 =?us-ascii?Q?gUGGmPp9r1KCHL+zegMMHAaXm6UZrGuPbn/Pmr5JHqYTIJn34ve+EkfSBA77?=
 =?us-ascii?Q?CDbYZEim7TssFpoftgloUpC9+wMWt4Ml5y3khU2U6dFg0U8YID3ctlkrMsr/?=
 =?us-ascii?Q?QX7xgwv94+Knyovx4Hy9RmJ6epnRGMmY8qIYSxapNPhhNT8WRHBI8wxOLFDF?=
 =?us-ascii?Q?D8SlaO5zXPIwOEuuNl8aEFXqvxELq2u8WJxeh4ohhQVwW/YMU3m+DLPsbYdI?=
 =?us-ascii?Q?TkwIg7rMOS9joaTANym4jnZjCuXltFi7F0rlPNMkj+BhxPnhyNufGfgl2O3Q?=
 =?us-ascii?Q?+jcPQ6HGGRKpeJQ1SjZua47xEvwOKG+iYF7qrhvu2NO7UMvssvCePo4Ykc1i?=
 =?us-ascii?Q?heoP8XIv1csgqFKVyYc5Ewuikn6VSE+ilkk40AJD6N4Y5Xn/FmnQQYxM+v9f?=
 =?us-ascii?Q?8pQ18vNOgv8Fte4pllQELXP+eEXARsJKeqNL8YF95oXqjxYSQ4aojVQSM/Ty?=
 =?us-ascii?Q?IF5hZzT0Rv6yFY1hBfa2QR6xUaw+EEViTGhSFOoAo2o3/AJsvolnFiXnuutg?=
 =?us-ascii?Q?tqTvRZqUUPRcFjuWczIAMSxOaCcSr07WZaF/D23GH1d3CcmurXcmCUmCSalx?=
 =?us-ascii?Q?PQ27bKt3Pwo6f1R/j9fw4cQrO0GD4ZQxtrz0lVHx4qFybNMG5By8EVCa3buP?=
 =?us-ascii?Q?8tXtaH5NWluy2fPzvgWWduU84okoYEi4Y1pZqUiLn1nzKOOz4wZjgDY7XYCu?=
 =?us-ascii?Q?ASo9pwRCZisa2kzEqLFq9sx0YkO8EZymiDLSFT9KfzDNc20IVR4Sk1hX8/lT?=
 =?us-ascii?Q?5def8wylbtVjeC1VZtI3IawUUGxPDp5mg+FdeAo9xF4auBtVkszgoleEW3PX?=
 =?us-ascii?Q?Bn5PFY5RT0/GjYXwtGXayMyul9dYmWcTeFokgbZJ2YpgtD3PFxB8fwjD+NZW?=
 =?us-ascii?Q?odWo6Q/Ha6p3zK95cI3BZpmeOpTyB8jkpVSratoO+RkYgHam1T0tn7eVvWq6?=
 =?us-ascii?Q?Q+4MXsLMWjxrq8gfdyZ7EMmaGM2k7E+GPVIMfZKrNi7TKaKYZgYFeT0FeFx2?=
 =?us-ascii?Q?xdEp4u3qcgVgT+h1356shB490GxhToLks9zpoWPxDw/HtwCVOEMyeeSylGvz?=
 =?us-ascii?Q?x1dK6tERF4Thqqyf/lZ/KY/olkEqEcCDCX+qhEFbvnXLyN9GbHmX5sHtM6lK?=
 =?us-ascii?Q?5SDaWVsuLuQe0s9CWVwf2ASgvZKFecfUu4/JAi46UevkzPQVDg2Me5i/hVU/?=
 =?us-ascii?Q?KhkXXIkxFJqYIakX4pOOIE2DbyrH7ZRPHKqqTSnZ7fSYtqlX1/+lgzfHEaQz?=
 =?us-ascii?Q?iupGAwsirjoNEh5m3F98tjduTRIuUOZU3RDZ7Wj9wHL3eFrHagQz7W/idw7g?=
 =?us-ascii?Q?ju3p1dEJ38TIxvNZyVclJYiik+YEWmTf7zLKUoUyhG+WgQR0XvYZno1+kFJQ?=
 =?us-ascii?Q?3xPTZRytDvc4q7O2ZqMZ82q7WCp2jblN+NFr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:18:14.1547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7686ed8d-2667-4cbf-6804-08ddeb6a1117
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927

Add a per-CPU "sd_nohz" variable to track domains in the local CPU's
hierarchy that have "sd->shared" set for nohz idle tracking.

Convert cpu_set_sd_state_*() to use "sd_nohz" instead of "sd_llc"
increasing the scope of tracking to all CPUs with non-NULL sd hierarchy
attached as opposed to just those CPUs with a "sd_llc" domain.

"sd_nohz" will be used in a subsequent commit to transition
nohz_balancer_kick() to use the distributed nohz idle tracking.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c     |  4 ++--
 kernel/sched/sched.h    |  2 ++
 kernel/sched/topology.c | 22 ++++++++++++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dee0ded7f40d..624b3753c818 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12451,7 +12451,7 @@ static void set_cpu_sd_state_busy(int cpu)
 
 	guard(rcu)();
 
-	sd = rcu_dereference(per_cpu(sd_llc, cpu));
+	sd = rcu_dereference(per_cpu(sd_nohz, cpu));
 	if (!sd || !sd->nohz_idle)
 		return;
 
@@ -12481,7 +12481,7 @@ static void set_cpu_sd_state_idle(int cpu)
 
 	guard(rcu)();
 
-	sd = rcu_dereference(per_cpu(sd_llc, cpu));
+	sd = rcu_dereference(per_cpu(sd_nohz, cpu));
 	if (!sd || sd->nohz_idle)
 		return;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9ae3e2993641..35ffb3926334 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3097,6 +3097,8 @@ extern void cfs_bandwidth_usage_dec(void);
 
 #define nohz_flags(cpu)		(&cpu_rq(cpu)->nohz_flags)
 
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_nohz);
+
 extern void nohz_balance_exit_idle(struct rq *rq);
 #else /* !CONFIG_NO_HZ_COMMON: */
 static inline void nohz_balance_exit_idle(struct rq *rq) { }
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d71c60d99313..f230892528c7 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -466,6 +466,8 @@ struct s_data {
 
 #ifdef CONFIG_NO_HZ_COMMON
 
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_nohz);
+
 static int __fallback_sds_alloc(struct s_data *d, unsigned long *visited_nodes)
 {
 	int j;
@@ -532,6 +534,23 @@ static void claim_fallback_sds(struct s_data *d)
 	}
 }
 
+static void update_nohz_domain(int cpu)
+{
+	struct sched_domain *sd = highest_flag_domain(cpu, SD_SHARE_LLC);
+
+	/*
+	 * If sd_llc doesn't exist, use the lowest sd for nohz idle
+	 * tracking. cpu_attach_domain() already ensures sd->shared is
+	 * assigned for the lowest domain if sd_llc doesn't exist after
+	 * degeneration of the hierarchy.
+	 */
+	if (!sd)
+		sd = rcu_dereference(cpu_rq(cpu)->sd);
+
+	WARN_ON_ONCE(sd && !sd->shared);
+	rcu_assign_pointer(per_cpu(sd_nohz, cpu), sd);
+}
+
 #else /* !CONFIG_NO_HZ_COMMON */
 
 static inline int __fallback_sds_alloc(struct s_data *d, unsigned long *visited_nodes)
@@ -542,6 +561,7 @@ static inline int __fallback_sds_alloc(struct s_data *d, unsigned long *visited_
 static inline void __fallback_sds_free(struct s_data *d) { }
 static inline void assign_fallback_sds(struct s_data *d, struct sched_domain *sd, int cpu) { }
 static inline void claim_fallback_sds(struct s_data *d) { }
+static inline void update_nohz_domain(int cpu) { }
 
 #endif /* CONFIG_NO_HZ_COMMON */
 
@@ -804,6 +824,8 @@ static void update_top_cache_domain(int cpu)
 
 	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY_FULL);
 	rcu_assign_pointer(per_cpu(sd_asym_cpucapacity, cpu), sd);
+
+	update_nohz_domain(cpu);
 }
 
 /*
-- 
2.34.1


