Return-Path: <linux-kernel+bounces-799864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA75AB43108
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C81484FD0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD2C1D5CC7;
	Thu,  4 Sep 2025 04:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W9K+24vI"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878B978F43
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959522; cv=fail; b=cEpo7ZyiumjJxj6uCjfZlEOFqjP91Oey81/XRkviWitmPm6RoWhs7M8hiecZfY5rLih1UzHsZFG1sNxulKvt1nHKg4Fd0SNlJYug3SsVKmyJYsv173zODpQEmMAIVUmgLyFc+W7PN9UrY8L/VeQ+w8SobRIZBAwUn+5cDzLgl60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959522; c=relaxed/simple;
	bh=pJy7wI1F71X+agKOfh19SZeOvb2WnGFidEWwCxybO4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnFyL62xKd+i8NpZ4jdYkG6rqHAMrA/Ti/5hFad7ZDOLqpKLMEv5I34o6Khh+Z1lC+iJNa6eZWd64tG/Q4ngHM0MLhG6MLErWqnbN+jNOmAjx5CTwjVinLBmobBz50KD+O6iz6gZwSJH+/vpx9DiDQxAF6bIiL6gt4I4lOe9pus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W9K+24vI; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vocmWAJ+YBMuIiRbh84mwhsn4/iqRbAJRtV1iN56bGMWMUQqKpBv6m9pZy/cdtvOiQqFcr4IZeA995gPw3zCXWIGhhAEPm9A120ZY4SJI+nFNxNmBCI+T8loJSdQq8TGWobzwxdB+MWI4kXhZoatXH7MumAQb206rAEOCy2KE5lU73gmXJc6G8a3ts8uEqQMUd/Y9C+LCWesuqQViYnoAaTnvZmlZtg06XT94kjynYsb6eVriiRnrPaIu4KkYjl9iXM2Rp/3U6a3xFZvZZNuRxck3iU4RgsvwbELne9Jbw5JxXmnzacVywGHPrZzn6FOJFAF9aNcKCuth8307xMJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKTbjyymihfZs+a1XKLkRhsraQkuiKw2YH1W29dLrr4=;
 b=DB8Fv2X5sBA6DZBbYgBxaKxnw7cwj/PKXjiayvAGrZZ1qsmB7UhalHrzLNBk0B+I7+yeUOvdT5BP4VUae43YLiQvTb4IqKFYemGryQmBv6oq+nWsnnJiVdyu1SlWqpOLm6DDZO2nD4a+5nDTTJEGyz008iSSIR3eQkZfvSHMJZH3TfTVqg8H+bhCKGdc0uh+wotPCOXJ46xrvEBE+m1ZKSg7LCxt0dDQBd44DJegDxokRioC3crvYL4kJjWkoMImNZBMVxCK8+gbBuzSH+pnP91Cc82FNipiMrqgdCVti2s6BrkzSD+T9wBsRNc5Q09svy6wAF02YbTMLs1aAEPbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKTbjyymihfZs+a1XKLkRhsraQkuiKw2YH1W29dLrr4=;
 b=W9K+24vILXz8PYK5+YC/u4V3LbU8fjWHgYZM6HQy7yogZh2arYRY5wLf2G0iG127ncQZDXwRBEU0Z/eZSP7XX/FCLRCcZ0BsbJ6EgfqP6KzywC/jW8BT3Voxt8shE6oRyI20TyGkNmvoksox4/AMu8vJy6rU5QOoLV+tdGP/oXs=
Received: from DS7PR03CA0262.namprd03.prod.outlook.com (2603:10b6:5:3b3::27)
 by DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Thu, 4 Sep 2025 04:18:36 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::92) by DS7PR03CA0262.outlook.office365.com
 (2603:10b6:5:3b3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 04:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:18:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:18:35 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:18:31 -0700
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
Subject: [RFC PATCH 10/19] sched/topology: Introduce "idle_cpus_mask" in sd->shared
Date: Thu, 4 Sep 2025 04:15:06 +0000
Message-ID: <20250904041516.3046-11-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DS7PR12MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: 6544d648-d94e-41a5-2cbb-08ddeb6a1e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0+Y5DOmsopDjHBf3Zjrip0m08/4MDP/w/gwMz4A2A4I9norcW+hnAKPsdICq?=
 =?us-ascii?Q?sfyJrWmav5gD///QjSM9cHWafRtZe554CFUgvrLJ/HsNRUQyeEY7zLMEgUMn?=
 =?us-ascii?Q?M/evHvB2OXdzD/diIq0d1r+hHOF1pEZ2VPlW/c9xlLDzz2N/XnVA8AkQ8ybX?=
 =?us-ascii?Q?lZ02sle358LtRO6pEPSYzel9U/kX2H1jZ4aih9BrhfUjMV9pJnmQ+dKTR9dT?=
 =?us-ascii?Q?HOMWnlyzBKMiGofvzKy1rEY+LEjQz+JIi9skaYacrhYV1Tx/R5oqlpxT8nl0?=
 =?us-ascii?Q?lSz/7SLYe7rIFi63yEjc/WcqXm80aYcoqtT+n8PwX3Tyg7q1Q4EYTVMFvWtQ?=
 =?us-ascii?Q?tjuCOAMbeGxWsF37Mf9n/EAe1TU2gJBLGWmWB/Oo2pBuu711e4iQcTRIJiFw?=
 =?us-ascii?Q?oN4vIFg2+FvyvUZ6GrDO4XyNP2TQDRtXjEygqIs7rFexYloPHfS3F/bOeGqC?=
 =?us-ascii?Q?4bUzIWJXixw1zPR9UtbbwFJcr+QKBKwJw9M0njSn/kNeEmUU2ajJvPedIu8r?=
 =?us-ascii?Q?KQkZ8bGZ7EuhJcjmTzsOfMhaTdv3VBj86Y0xBwmw1C2DDPZYddmn6TgnE4fe?=
 =?us-ascii?Q?KmwINQPKlXVInWDk3vUT2xknYtkS8zLutdfiP4ckOTIWYKk/S+l1cFqQ/6jd?=
 =?us-ascii?Q?JWGA6NZ8TweaJa5tDB+hKSiX+Z3dqYN/NZc/orMZHYuTwnyE4QWILOMZJdS/?=
 =?us-ascii?Q?z3bGYwxUqbg7jbOf6whq7BAKC4fPSa83UiPl+LWbdaHCp2YCFAZkNfAE4tEp?=
 =?us-ascii?Q?CC1EG7YntuxsSxmelTX8saP9ohHc7dmafla7ksZuVgsh7WtU0BUp72OKPvsu?=
 =?us-ascii?Q?R5HNJymopftZqEarP0sMfbEbuZarFFrNoMkwSZ80QAS5fF7gr3R1X/a5Xv9n?=
 =?us-ascii?Q?6cBhRUhwaGjLq/NOPXGA4emWtDa+iPRzmcMVP7W7BaGgHJ/Di1dPdyHKavdd?=
 =?us-ascii?Q?V9UVLkwQpwzOM/J5AiAHlA6cz9tou0xtzpuqWwHTRNONaV1/9KTmldK6YJre?=
 =?us-ascii?Q?xVJagvxP/514v/+JC8hihMNj6PzDUQv79Hhdvzq+QzIwOrIQG2fRPk9r8UM+?=
 =?us-ascii?Q?FhqIM7sfefEzm7CnNUddIMlGRGyGPjbhF0NFbEcDRgjcKus0/8D5nVLi/v4C?=
 =?us-ascii?Q?Pd2Sq2DRL+JucPq+iiPLtqV4S3BBpti3dB3xhWtFlVxHCIcWbN+1085BtXrP?=
 =?us-ascii?Q?8NJwTyl/hafwyla6yWDdM1Wp7muVUEDd7N/8qU4a8vwTUAv/GcTJdnH2RAgA?=
 =?us-ascii?Q?aOVFYRfBOibPdeS2Zu3IWPt90tiG8n4PsIab8J1dRwXW0JrLbgFqghIBhBH8?=
 =?us-ascii?Q?0p/xg5cPHH0lvJxrE+rJn4DNzssV4nKjIlVxfSCWR+JDM15wmOHpcq/+Bkbh?=
 =?us-ascii?Q?Ofp1erFIWf2zrTtTjnGNxwcU4JT/T4nBUTZryuGtM6DcPcKe1quWSFViApcm?=
 =?us-ascii?Q?a3A3y9+2y3YVDwc9BQsHMpbJlykvOmtu+dMgs8Y8LrOjv9y4hdOymnDkmcUD?=
 =?us-ascii?Q?+ishk4DyCNx5Do6FG1aXsPRTxR7beyPHWb8d?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:18:36.3895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6544d648-d94e-41a5-2cbb-08ddeb6a1e5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837

Introduce "idle_cpus_mask" to track idle CPUs within the sd_nohz
domains. This mask will eventually replace the need for the global
"nohz.idle_cpus" mask for nohz idle balancing.

Convert cpu_set_sd_state_*() to set / clear the CPU from the mask when
transitioning to / out of nohz idle state.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched/topology.h |  1 +
 kernel/sched/fair.c            |  2 ++
 kernel/sched/topology.c        | 48 +++++++++++++++++++++++++++++++---
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 2f0d8ecea427..6db3448e2f00 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -67,6 +67,7 @@ struct sched_domain_shared {
 	atomic_t	ref;
 #ifdef CONFIG_NO_HZ_COMMON
 	atomic_t	nr_idle_cpus;
+	struct cpumask	*idle_cpus_mask;
 #endif
 	int		has_idle_cores;
 	int		nr_idle_scan;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 624b3753c818..c8226520758d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12458,6 +12458,7 @@ static void set_cpu_sd_state_busy(int cpu)
 	if (!xchg(&sd->nohz_idle, 0))
 		return;
 
+	cpumask_clear_cpu(cpu, sd->shared->idle_cpus_mask);
 	atomic_dec(&sd->shared->nr_idle_cpus);
 }
 
@@ -12488,6 +12489,7 @@ static void set_cpu_sd_state_idle(int cpu)
 	if (xchg(&sd->nohz_idle, 1))
 		return;
 
+	cpumask_set_cpu(cpu, sd->shared->idle_cpus_mask);
 	atomic_inc(&sd->shared->nr_idle_cpus);
 }
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f230892528c7..c2832445c578 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -468,6 +468,24 @@ struct s_data {
 
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_nohz);
 
+static int __sds_nohz_idle_alloc(struct sched_domain_shared *sds, int node)
+{
+	sds->idle_cpus_mask = kzalloc_node(cpumask_size(), GFP_KERNEL, node);
+
+	if (!sds->idle_cpus_mask)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void __sds_nohz_idle_free(struct sched_domain_shared *sds)
+{
+	if (!sds)
+		return;
+
+	kfree(sds->idle_cpus_mask);
+}
+
 static int __fallback_sds_alloc(struct s_data *d, unsigned long *visited_nodes)
 {
 	int j;
@@ -490,6 +508,9 @@ static int __fallback_sds_alloc(struct s_data *d, unsigned long *visited_nodes)
 			return -ENOMEM;
 
 		d->fallback_nohz_sds[j] = sds;
+
+		if (__sds_nohz_idle_alloc(sds, j))
+			return -ENOMEM;
 	}
 
 	return 0;
@@ -502,8 +523,10 @@ static void __fallback_sds_free(struct s_data *d)
 	if (!d->fallback_nohz_sds)
 		return;
 
-	for (j = 0; j < nr_node_ids; ++j)
+	for (j = 0; j < nr_node_ids; ++j) {
+		__sds_nohz_idle_free(d->fallback_nohz_sds[j]);
 		kfree(d->fallback_nohz_sds[j]);
+	}
 
 	kfree(d->fallback_nohz_sds);
 	d->fallback_nohz_sds = NULL;
@@ -553,6 +576,13 @@ static void update_nohz_domain(int cpu)
 
 #else /* !CONFIG_NO_HZ_COMMON */
 
+static int __sds_nohz_idle_alloc(struct sched_domain_shared *sds, int node)
+{
+	return 0;
+}
+
+static void __sds_nohz_idle_free(struct sched_domain_shared *sds) { }
+
 static inline int __fallback_sds_alloc(struct s_data *d, unsigned long *visited_nodes)
 {
 	return 0;
@@ -740,8 +770,10 @@ static void destroy_sched_domain(struct sched_domain *sd)
 	 */
 	free_sched_groups(sd->groups, 1);
 
-	if (sd->shared && atomic_dec_and_test(&sd->shared->ref))
+	if (sd->shared && atomic_dec_and_test(&sd->shared->ref)) {
+		__sds_nohz_idle_free(sd->shared);
 		kfree(sd->shared);
+	}
 	kfree(sd);
 }
 
@@ -2524,6 +2556,9 @@ static int __sds_alloc(struct s_data *d, const struct cpumask *cpu_map)
 
 		bitmap_set(visited_nodes, cpu_to_node(j), 1);
 		*per_cpu_ptr(d->sds, j) = sds;
+
+		if (__sds_nohz_idle_alloc(sds, cpu_to_node(j)))
+			return -ENOMEM;
 	}
 
 	if (__fallback_sds_alloc(d, visited_nodes))
@@ -2539,8 +2574,13 @@ static void __sds_free(struct s_data *d, const struct cpumask *cpu_map)
 	if (!d->sds)
 		return;
 
-	for_each_cpu(j, cpu_map)
-		kfree(*per_cpu_ptr(d->sds, j));
+	for_each_cpu(j, cpu_map) {
+		struct sched_domain_shared *sds;
+
+		sds = *per_cpu_ptr(d->sds, j);
+		__sds_nohz_idle_free(sds);
+		kfree(sds);
+	}
 
 	__fallback_sds_free(d);
 
-- 
2.34.1


