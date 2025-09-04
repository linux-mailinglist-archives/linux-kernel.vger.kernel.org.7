Return-Path: <linux-kernel+bounces-799859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A4BB43102
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B18144E4A13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEEB1DED4C;
	Thu,  4 Sep 2025 04:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zzucrq9e"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE1B1B5EB5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959427; cv=fail; b=lsQkRHdSeaOlCX/w00jjhSJj4pt3cETSSMaXZzVlPIhINAy/CSBp7kG3FHuYizjP7p6AHNM3eFltyqvL2rsFpPJInz/eMYRKNIRFhaxBGLS21rOFYoItTf15Gx2wnH8iRAE0PL/s/EdfB+4uJWWxaXN7rrP56Q59mMHtYfMqIVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959427; c=relaxed/simple;
	bh=X34noNQN9mCC9jCbTMYj0D5mEZF04aqfSRYeFAIQJnY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1mvW3Sm4qItFeKzZjUJmt5TW7envEZB+8j/83Py0z40wne7lbFSFU0sD73lHPJ0EWXuShuuqc5wpyQ2v3RhGL0eslIfsMBeew8ovN0puCPII3bklwQr4jRX4pE64lay6EqOxxF2ziX5Z4plYx3hF9Ray0VkkUVfchViSzPP2YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zzucrq9e; arc=fail smtp.client-ip=40.107.96.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwArl+otluOUi0BUHXej3j2wwkeXvVec2zGMFK5ohs5m3doemEf5MCH30NnYIo9DtKQUrgrom5Uz2JfD1wKGu6Ao5foUDh8g6UlLiVx6pehTSUMU8wKUfSz6hA7M7g4RmHKku11KKxpeJA8BVIx1OU5fEjM7KgsFFwpY5zW//SWgYDjr/tHsmatPWQ6UpSBvYiMUu58oxxvy+UABW0uFA5DmRFtmT1MWHROYshhGAtIi7b6yTxjkBA9MXgBCQtn357e/0MRecZfKzE3HKli6H3ZmT1xOe3dKJoGm97ea7OXZbHXh9dK9ClUPFco3x5MJmfaaHdIxH1vWzf8OPYLDGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wc0WjoBf3x2IP2fefgHf3CXq8vQRZN8N8Xx2UulOBtM=;
 b=YKpqEqU2TalNSRi+19RCSK1YFq+Py20MVlIjwXCXiQO/6a2IbSLJjmKIdWu0OFmsq9D7vHtf5iYoCn2gTKlKGewMCD1VcdFZrKDeODdsQZFYZ317HZO2+qwN/oP6GjqJ0wZ23WqJAzVaAE63fIE7yZnx3yhlqxdBUDZhoJBM1t0/PeX/hPU374thXW6P/M3FGDsZ1upNPuVd9yip4oxPudm2ET+W3FWnkVu+B3HxqNJUjQjjdVpAQos5qnMucL4Ht55SyUVPR9rue4iobwSS3xXAQGUJirl9h/IIRsR9pFBxs96uQKpL0KT6YOOv0rZvdlOGJgMFPi22spjCiZiJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wc0WjoBf3x2IP2fefgHf3CXq8vQRZN8N8Xx2UulOBtM=;
 b=Zzucrq9eV/9G2XApvzZ2jgUFvD1qGvjtMOWoMulRQmvCnQdNykTrNCdqQPnEqFrYrNc04x2SnZWhJXI8as8KKxfNI5NzSInJGP6zlGescn5EuOD/9hl0nxe5W/dibjmGkJWYWMcmcY4m/gf1xHB/ofd0SLuDtkCTfmHIUNgAn6k=
Received: from DS7PR03CA0316.namprd03.prod.outlook.com (2603:10b6:8:2b::17) by
 SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 04:17:00 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::c) by DS7PR03CA0316.outlook.office365.com
 (2603:10b6:8:2b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Thu,
 4 Sep 2025 04:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:17:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:16:59 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:16:55 -0700
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
Subject: [RFC PATCH 05/19] sched/topology: Attach new hierarchy in rq_attach_root()
Date: Thu, 4 Sep 2025 04:15:01 +0000
Message-ID: <20250904041516.3046-6-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 6596bd8b-bad1-4762-c779-08ddeb69e521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0a5XeIyW9pIgEHBVwth1GCUynV6kNjG1pOSAsHUmwcYz3YQn2nv38OmpUGeU?=
 =?us-ascii?Q?nqC8o6Ylr5+STRVRhUkbanfbgxmEm/zepBvtV8ZHq2sG2D24QSIdBbwyCTrZ?=
 =?us-ascii?Q?XgfZizCAWJgxb4QROUb93xUZOPa86H3aDMweLDLiGzuFQW/5q+00O9P7t/Tg?=
 =?us-ascii?Q?/HojKdLQvyWsM8pYghJkf0wjoCfBg1yFuifsVOnjlgJoCzxeVyiPU7U5pFwT?=
 =?us-ascii?Q?4ITJ4F6FsvGdAG9rrBh35bsKc3wpR7aDtxNJiFd7fDO1pLvCV63k1r7lYOCe?=
 =?us-ascii?Q?oRiT4p+WVnZiP1BzRV3fpmNqzx4I42O/sPeRjCYUzcRe5xDsXyYJheq8o9mr?=
 =?us-ascii?Q?zi1XbGqUfonmwAcj4tKF+2xgYa+SZ13osJbREKvvhRYdwASuk9jglsPK1zBF?=
 =?us-ascii?Q?EMdjUX8W1PYu8duuyo3OWOaEPf4AZeXCvn1kx4OoB668beMapJDcR2SbnG+u?=
 =?us-ascii?Q?6PFX26xEgHZL/Da2XImYusQsa6veACbLrVnKGZxYL+m8gvDuwp5SDHwlaCa6?=
 =?us-ascii?Q?JH2OyB1X8XK20KMz335OeP+9CXXdZ8eKAbSUj6MCwYhPP3grPzdFxhulTUrV?=
 =?us-ascii?Q?7MyHa1m28uUR52HW8FPX6AAxpNrauTK/dv8nb/bQsHg23qMKTINTBMT8xhUW?=
 =?us-ascii?Q?R8rGsRK/N58RH3qP/SS7a0VJaUfjz+OTeH40p/1fynjTlj+u7b3T8O5H9j77?=
 =?us-ascii?Q?QUxNU8ElqiCpXA0R8tLnKpFeW4N6GWC633lNVBOfNo9NJ7jVpMJO/8UWuedi?=
 =?us-ascii?Q?D/Xr1LIYheKz3AADk5LqWXVkM1NkfsDlmnlQAOaBhkIPyXMmsz77w/eLO2G/?=
 =?us-ascii?Q?DzpAKesaUX3hrAuP6btLasK6gpdF9rcd/1Ml26R7+7aYqgdrXGRwRpKrgCK+?=
 =?us-ascii?Q?I3xg4Fv969YZefEjkeNUStJS8tR1VoPw8VVdUnL+63fEuLi8GvjFPqiid8Cl?=
 =?us-ascii?Q?/sfK5DMhlMQZDACKR1Q3hdVHP/LsXmdl3WKkfQOcYwW7Fkm0mmXg6GjWa0Dp?=
 =?us-ascii?Q?NtjPTnRMgNyXXGdDI1XFiozCzIGneH2crbg6/iuQdY0aFlQVgsqC6RoMFKIT?=
 =?us-ascii?Q?7i0ARujCO8XhsvVbZUsMFkfaOcSuAIeQJIXhZLWD5T9egWGN8efW09h2dyAR?=
 =?us-ascii?Q?kpwZN5om/yVJaHcn/2JtOnEuuqxLp7TUPtQ0mPPxGGqLRNxtbFZg25wvU/DE?=
 =?us-ascii?Q?nXTIp7p8mS9pp0dpW8+eN1N+tFKytTjhVhLdox3EpmwNpY4xduAZyURxL+gp?=
 =?us-ascii?Q?VsWNP1B6+TVn+DSKqZXO9CRforrG+48AwccvDQbCnSHkN+T8ZiSjmMveBJDD?=
 =?us-ascii?Q?D/6mSe/jX4pYxe935o/cjFPoG4EW2p6tFo3XQOV0/G03MNNoIZHsRW2Ya1f/?=
 =?us-ascii?Q?fy7lix39KCrM107Z+PEQj2xXhVR5iADSRocgTZKhniVmPvf7fU6f/gU0XutY?=
 =?us-ascii?Q?aO2OOWYqksuVijJTLIXwZ/IOdxUWCb8Ar2e8fz4RQ43tHZtbDCgOxKTOCnaX?=
 =?us-ascii?Q?uvov3I/3AWhbbNUeFkfSLHnFV8Si2Zj0N3Fa?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:17:00.3882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6596bd8b-bad1-4762-c779-08ddeb69e521
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918

Gregory Haskins introduced the concept of root domain in commit
57d885fea0da ("sched: add sched-domain roots") which put
rq_attach_root() before rcu_assign_pointer(rq->sd, sd).

Further development around dynamic sched domain allocation, and
update_top_cache_domain() that came later relied on the new sched
domain hierarchy and was naturaturally done after rq->sd was updated.

Since subsequent changes around nohz idle CPU tracking creates a
dependency for the fair_sched_class->offline() callback to use the old
hierarchy and the fair_sched_class->online() callback to use the
updated hierarchy, update rq->sd and the top cache domains within
rq_attach_root() between the two callbacks.

This modifies the flow as follows:

       old flow                              new flow
       ========                              ========

  rq_attach_root()                   rq_attach_root()
    set_rq_offline();                  set_rq_offline(); /* Operate on old sd_llc */
    set_rq_online();                   rq->sd = sd;
  rq->sd = sd;                         update_top_cache_domain()
  update_top_cache_domain()            set_rq_online(); /* Operate on new sd_llc */

No functional changes intended.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/core.c     |  2 +-
 kernel/sched/sched.h    |  2 +-
 kernel/sched/topology.c | 38 ++++++++++++++++++++++++--------------
 3 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index feb750aae71b..771fc6239386 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8798,7 +8798,7 @@ void __init sched_init(void)
 
 		INIT_LIST_HEAD(&rq->cfs_tasks);
 
-		rq_attach_root(rq, &def_root_domain);
+		rq_attach_root(rq, &def_root_domain, NULL);
 #ifdef CONFIG_NO_HZ_COMMON
 		rq->last_blocked_load_update_tick = jiffies;
 		atomic_set(&rq->nohz_flags, 0);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b5367c514c14..9ae3e2993641 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1020,7 +1020,7 @@ struct root_domain {
 
 extern void init_defrootdomain(void);
 extern int sched_init_domains(const struct cpumask *cpu_map);
-extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
+extern void rq_attach_root(struct rq *rq, struct root_domain *rd, struct sched_domain *sd);
 extern void sched_get_rd(struct root_domain *rd);
 extern void sched_put_rd(struct root_domain *rd);
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f3ebb9e8fe00..a059641e12e5 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -469,9 +469,12 @@ static void free_rootdomain(struct rcu_head *rcu)
 	kfree(rd);
 }
 
-void rq_attach_root(struct rq *rq, struct root_domain *rd)
+static void update_top_cache_domain(int cpu);
+
+void rq_attach_root(struct rq *rq, struct root_domain *rd, struct sched_domain *sd)
 {
 	struct root_domain *old_rd = NULL;
+	int cpu = cpu_of(rq);
 	struct rq_flags rf;
 
 	rq_lock_irqsave(rq, &rf);
@@ -494,6 +497,8 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	}
 
 	atomic_inc(&rd->refcount);
+	rcu_assign_pointer(rq->sd, sd);
+	update_top_cache_domain(cpu);
 	rq->rd = rd;
 
 	cpumask_set_cpu(rq->cpu, rd->span);
@@ -711,16 +716,27 @@ static void update_top_cache_domain(int cpu)
 	rcu_assign_pointer(per_cpu(sd_asym_cpucapacity, cpu), sd);
 }
 
+struct s_data {
+	struct sched_domain_shared * __percpu *sds;
+	struct sched_domain * __percpu *sd;
+	struct root_domain	*rd;
+};
+
 /*
  * Attach the domain 'sd' to 'cpu' as its base domain. Callers must
  * hold the hotplug lock.
  */
 static void
-cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
+cpu_attach_domain(struct s_data *d, int cpu)
 {
+	struct root_domain *rd = d->rd;
+	struct sched_domain *sd = NULL;
 	struct rq *rq = cpu_rq(cpu);
 	struct sched_domain *tmp;
 
+	if (d->sd)
+		sd = *per_cpu_ptr(d->sd, cpu);
+
 	/* Remove the sched domains which do not contribute to scheduling. */
 	for (tmp = sd; tmp; ) {
 		struct sched_domain *parent = tmp->parent;
@@ -776,21 +792,13 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 
 	sched_domain_debug(sd, cpu);
 
-	rq_attach_root(rq, rd);
 	tmp = rq->sd;
-	rcu_assign_pointer(rq->sd, sd);
+	rq_attach_root(rq, rd, sd);
 	dirty_sched_domain_sysctl(cpu);
 	destroy_sched_domains(tmp);
 
-	update_top_cache_domain(cpu);
 }
 
-struct s_data {
-	struct sched_domain_shared * __percpu *sds;
-	struct sched_domain * __percpu *sd;
-	struct root_domain	*rd;
-};
-
 enum s_alloc {
 	sa_rootdomain,
 	sa_sd,
@@ -2642,9 +2650,8 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	rcu_read_lock();
 	for_each_cpu(i, cpu_map) {
 		rq = cpu_rq(i);
-		sd = *per_cpu_ptr(d.sd, i);
 
-		cpu_attach_domain(sd, d.rd, i);
+		cpu_attach_domain(&d, i);
 
 		if (lowest_flag_domain(i, SD_CLUSTER))
 			has_cluster = true;
@@ -2749,6 +2756,9 @@ int __init sched_init_domains(const struct cpumask *cpu_map)
 static void detach_destroy_domains(const struct cpumask *cpu_map)
 {
 	unsigned int cpu = cpumask_any(cpu_map);
+	struct s_data d = {
+		.rd = &def_root_domain,
+	};
 	int i;
 
 	if (rcu_access_pointer(per_cpu(sd_asym_cpucapacity, cpu)))
@@ -2759,7 +2769,7 @@ static void detach_destroy_domains(const struct cpumask *cpu_map)
 
 	rcu_read_lock();
 	for_each_cpu(i, cpu_map)
-		cpu_attach_domain(NULL, &def_root_domain, i);
+		cpu_attach_domain(&d, i);
 	rcu_read_unlock();
 }
 
-- 
2.34.1


