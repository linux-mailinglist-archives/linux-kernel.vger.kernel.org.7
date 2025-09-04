Return-Path: <linux-kernel+bounces-799865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30ABB43109
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB9A07A58F6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3B81F1313;
	Thu,  4 Sep 2025 04:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HJynRKVz"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA4A3AC1C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959539; cv=fail; b=sRp78qSgwsZSUoe5jqggxYtD8bkNuNYNNxo3e0QWZyOiwtgnH6XedPs+B+YC7BymqC23KLvwl81+8xfc3Zaq39ZZaUI0rhzwMJ0ThbBc/E4LU1R8mbrR1PtHatFx8atbpn3IwzxNe7RzRVLZ/0FyiSMI6ln9IHi8wOQi9dkBWvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959539; c=relaxed/simple;
	bh=lAuwVVELkkpVc3SQWpma2f1S3qy8Nx6YBjKyWBEwovw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtJn5uecz7b3zCG+TRmoUe30esur1n2B9J6+ldE3DmplDKkuurz97t+yTvVUbQSe3f8Nb3F5TPWL8TnrWcSMA/my2vskAt8kGA1Cb2vQSGbo2xRMmncQfxj3pkbntsaOJnj0uRkhS/1XYdNwzjK4R46OwJUMqDBu5cAArImgxFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HJynRKVz; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/KElIIcj7P559fVRZpqJu3phnxQJfgACCaUWyMAq7FFnzubbdLLD4YgYSic59zleREm9Hp+1ojXdimcn+hmYj+Vudu0Hv7rUajFg8tVzs7kl01G9BHRvKQJS+FYfie8g1JqMzLXdE4F+3bfGftgrMUwYtCFjlDAQzBp/AdxEq1ML2E6KloQ8ys3OhBHApq4tHqq6UTFz7H2spr59PVMz+r9grgmORGHBDlEKS3zM7qcOxdK1kth8GxdeD5BZQAaR67nyv4Iq2IlAN+00LHcDggf5R/kJ7aCz1+ilygzRZziMyOKMNJfyhSqK8oFwnT0y70ZXRKV3XXGerzsQ5hTag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZYVaoL89n3tfHmcj34wYeNmwbgqIJz/jop3Fy3ncV4=;
 b=wuAbqbibSLsbD8qJdvLo2a8VbPeE3irc54bTEbYf1N/KONu9Wvilm2clHf1RgkSCT21YqP6OC4uVcnoN1bo2AKxxoDzjtpkMWxNwB/MZBqiyoCkMYk1YvYlRH2smtMZ/W458qeYmKtpMFf+3S0Sye7YT072EPv5GS2O4UDsTJw2ddw5dNcfNwGetNQVWA3wKxxDxmmWT4ov99saMB73CzQYx+JZS8zCun3iuJUxK0CqRBEzXB59go4zwLobQNYuCTKwLhQ36KI80fO0toiQED59xxVfAUJ5T+6a1g14dPTdS4UGhXfCZSJAWh7oFTalJE3WTJnhV4kt9Qjrx//1sFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZYVaoL89n3tfHmcj34wYeNmwbgqIJz/jop3Fy3ncV4=;
 b=HJynRKVzmBprrs0kSFCIOWEo13XqUAqe9NbSRJ3pnmqvSE1KzQyzMQs44yvZZQypU48yXYWmpirIxC6ap2j02RTGzCP/67jvxeBzsJi69/NpEFl8l5B7cKP/GRFEIPw3FIQ/4eIjBgdCJBngI4RVpNEY91SiAf4LMOhX/DoQydg=
Received: from CY5PR13CA0026.namprd13.prod.outlook.com (2603:10b6:930::20) by
 CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 04:18:54 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::85) by CY5PR13CA0026.outlook.office365.com
 (2603:10b6:930::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.6 via Frontend Transport; Thu, 4
 Sep 2025 04:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:18:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:18:53 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:18:48 -0700
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
Subject: [RFC PATCH 11/19] sched/topology: Introduce "nohz_shared_list" to keep track of sd->shared
Date: Thu, 4 Sep 2025 04:15:07 +0000
Message-ID: <20250904041516.3046-12-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b7d49a-2074-4bca-679d-08ddeb6a28b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ibvqfUQ89E6tm/cbsI1XSUPYVczYZRkRiyljg9/VAnE805uQyowAXyLiPynW?=
 =?us-ascii?Q?1Qkv2z6pH1OGId835rRirEoW6eldabePp0/xprfHbn66W4K5/rukiT6jsTzV?=
 =?us-ascii?Q?fpQOpaEJvy97W02FklyITannGguerbWn9QmSOx+gk9Jyr4DE7DjNCXb22i5C?=
 =?us-ascii?Q?9jckpD2MuMjo1o5xMhxwqQngcyE9mZdswCioJa0X9N1x7CitfpuqvmeT3TVC?=
 =?us-ascii?Q?jBfHCJYl7O+meaNsHES2tJr+2HGZAbNdZX9pZJfr0uwDtKJsOgXy+vh+PN6G?=
 =?us-ascii?Q?S/0XUed7JdL5MbOu8OEMP9Js0Q1qlPZwgPI4JN03zW8l3l4XlFCvr8gOt0HF?=
 =?us-ascii?Q?Vho+wMu64zhfSxKpkriFvZ1xreVpxQ3domYazdiKPJFqvZveQtWQNxkFwrlg?=
 =?us-ascii?Q?HtjBmLoCispJB6ZJj8ySLYIESMJOOWoiQXnYM1G7/lWFD3lh5UoiULGFriif?=
 =?us-ascii?Q?2EAh5+zfUXY8+aoze6/t8Uo2oIyruVaQ8A9JOGdv48pY+8pJGmtZppKYqiJf?=
 =?us-ascii?Q?ea6FHltbmaUzJoqR7J6kiQGvfNy2FBOqtqxuv4xsHLwmf21QSDriU6AWDMTY?=
 =?us-ascii?Q?M+RL9FYguAew3kkpBTPJEDk0nfzz42fSLy40nws4n1weD6qkDU9qQxonUGtm?=
 =?us-ascii?Q?U5DiltTMyHdj5F/6dXMVZzSWNP3XJlipF1kXGpjI+kuy+qVl3jhi+BiCU4Y9?=
 =?us-ascii?Q?sSXAifYsdugdbNFkdjfKe6YszXLm82h0SbgcacFeMG9kjGGdxcVfoDyI62qt?=
 =?us-ascii?Q?LeKggAfglJ28UKcerk9IVNYKhT1he7O44wUgzWQ5CkSS408YjJAM/8es2Oml?=
 =?us-ascii?Q?PRByrQTBN1DRn1O94q+7wj0iscqmYTvzyFFJNGzqD39obeC+u9q9q5SbemWn?=
 =?us-ascii?Q?JCXLYkUnTcslkAqoobmErK5ECLPekMRVN70AKdySCTPzNEsoMh712js9dbT7?=
 =?us-ascii?Q?Egj5H4Vj/nZJJV6R2EG6HdX8Ju0UjhW8WhfcyMLBdRUbCWWhowmB4wusPGv9?=
 =?us-ascii?Q?SsghFU98mhPRRM6Hcm13J4kNi78S5dkCnIzJdPyEKai910feapmdJirTAcpB?=
 =?us-ascii?Q?qvZhhtM7HzhSTRyrTlyiQQeZNIe77jRCjeUja1w1Xs5LsyYHM2SHYSf5jdYV?=
 =?us-ascii?Q?c4FqsLpJJbLzUI2UMV6kI5Ep+L7BsgvvTufrJnelDvzwvwaxfX+jatFYXVhh?=
 =?us-ascii?Q?6cnzcOzopycatKsz4cjSGNZRiTjuJUOQXsppo6xFw7SJZgxzY3pwPbp+DGlf?=
 =?us-ascii?Q?iFuHwF7lmxyt/3FHh6IErSbvcgJ1lbHIq0NSf/8/KpVFUzMKNCuRbPSdfNWN?=
 =?us-ascii?Q?eeA4xmh/aFZ+btw47fj1C3q+LWH92iCb5SSznZj7R535Msz8yYKOm1mIlA3U?=
 =?us-ascii?Q?D5e8Ej6/EB5EneFM0yUiKUeUxHiChtn0n0063C7GFVMnO8EnpAIcZd6kYnJR?=
 =?us-ascii?Q?35vtoTtXJS60c8wP8sq17APhs9qrHQsjEPGiTfeGWOWSUqjYW9eeaZWtmKi8?=
 =?us-ascii?Q?/2mMTQkAQxc9vy32YrLAMrj+TOtgLKYsXMcV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:18:53.7572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b7d49a-2074-4bca-679d-08ddeb6a28b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353

Chain together all the "sd_nohz->shared" objects in a RCU protected
"nohz_shared_list" to get the full view of system for nohz idle
balancing. Since __sds_nohz_idle_alloc() is also responsible for
initializing the list_head, rename it to __sds_nohz_idle_alloc_init() to
fit the bill.

List modifications are protected by the "nohz_shared_list_lock" and
freeing of sd->shared on the list is delayed by one grace period to
ensure all the untracked references to the shared object under RCU are
dropped.

Users of "nohz_shared_list" will be added in subsequent patches where
all the current users of "nohz.idle_cpus" will be converted to use the
distributed tracking.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched/topology.h | 12 ++++---
 kernel/sched/sched.h           |  1 +
 kernel/sched/topology.c        | 62 +++++++++++++++++++++++++++++++---
 3 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 6db3448e2f00..8400961c1c61 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -64,13 +64,15 @@ extern int sched_domain_level_max;
 struct sched_group;
 
 struct sched_domain_shared {
-	atomic_t	ref;
+	atomic_t		ref;
 #ifdef CONFIG_NO_HZ_COMMON
-	atomic_t	nr_idle_cpus;
-	struct cpumask	*idle_cpus_mask;
+	atomic_t		nr_idle_cpus;
+	struct cpumask		*idle_cpus_mask;
+	struct list_head	nohz_list_node;
+	struct rcu_head		rcu;
 #endif
-	int		has_idle_cores;
-	int		nr_idle_scan;
+	int			has_idle_cores;
+	int			nr_idle_scan;
 };
 
 struct sched_domain {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 35ffb3926334..9cffcfbef1ae 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3098,6 +3098,7 @@ extern void cfs_bandwidth_usage_dec(void);
 #define nohz_flags(cpu)		(&cpu_rq(cpu)->nohz_flags)
 
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_nohz);
+extern struct list_head nohz_shared_list;
 
 extern void nohz_balance_exit_idle(struct rq *rq);
 #else /* !CONFIG_NO_HZ_COMMON: */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c2832445c578..86e33ed07254 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -468,8 +468,12 @@ struct s_data {
 
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_nohz);
 
-static int __sds_nohz_idle_alloc(struct sched_domain_shared *sds, int node)
+static DEFINE_RAW_SPINLOCK(nohz_shared_list_lock);
+LIST_HEAD(nohz_shared_list);
+
+static int __sds_nohz_idle_alloc_init(struct sched_domain_shared *sds, int node)
 {
+	sds->nohz_list_node = (struct list_head)LIST_HEAD_INIT(sds->nohz_list_node);
 	sds->idle_cpus_mask = kzalloc_node(cpumask_size(), GFP_KERNEL, node);
 
 	if (!sds->idle_cpus_mask)
@@ -483,6 +487,7 @@ static void __sds_nohz_idle_free(struct sched_domain_shared *sds)
 	if (!sds)
 		return;
 
+	WARN_ON_ONCE(!list_empty(&sds->nohz_list_node));
 	kfree(sds->idle_cpus_mask);
 }
 
@@ -509,7 +514,7 @@ static int __fallback_sds_alloc(struct s_data *d, unsigned long *visited_nodes)
 
 		d->fallback_nohz_sds[j] = sds;
 
-		if (__sds_nohz_idle_alloc(sds, j))
+		if (__sds_nohz_idle_alloc_init(sds, j))
 			return -ENOMEM;
 	}
 
@@ -560,6 +565,7 @@ static void claim_fallback_sds(struct s_data *d)
 static void update_nohz_domain(int cpu)
 {
 	struct sched_domain *sd = highest_flag_domain(cpu, SD_SHARE_LLC);
+	struct sched_domain_shared *sds = NULL;
 
 	/*
 	 * If sd_llc doesn't exist, use the lowest sd for nohz idle
@@ -570,13 +576,52 @@ static void update_nohz_domain(int cpu)
 	if (!sd)
 		sd = rcu_dereference(cpu_rq(cpu)->sd);
 
-	WARN_ON_ONCE(sd && !sd->shared);
+	if (sd)
+		sds = sd->shared;
+
+	if (sds && list_empty(&sds->nohz_list_node)) {
+		/*
+		 * IRQs should be disabled by the caller since they
+		 * hold the rq_lock.
+		 */
+		lockdep_assert_irqs_disabled();
+
+		guard(raw_spinlock)(&nohz_shared_list_lock);
+		list_add_rcu(&sds->nohz_list_node, &nohz_shared_list);
+	}
+
+	WARN_ON_ONCE(sd && !sds);
 	rcu_assign_pointer(per_cpu(sd_nohz, cpu), sd);
 }
 
+static void destroy_sched_domain_shared_rcu(struct rcu_head *rcu)
+{
+	struct sched_domain_shared *sds = container_of(rcu, struct sched_domain_shared, rcu);
+
+	kfree(sds->idle_cpus_mask);
+	kfree(sds);
+}
+
+/*
+ * If sd->shared is on the rcu protected nohz_shared_list,
+ * remove it the list and wait once grace period before
+ * freeing.
+ */
+static int sds_delayed_free(struct sched_domain_shared *sds)
+{
+	if (list_empty(&sds->nohz_list_node))
+		return 0;
+
+	scoped_guard(raw_spinlock_irqsave, &nohz_shared_list_lock)
+		list_del_rcu(&sds->nohz_list_node);
+
+	call_rcu(&sds->rcu, destroy_sched_domain_shared_rcu);
+	return 1;
+}
+
 #else /* !CONFIG_NO_HZ_COMMON */
 
-static int __sds_nohz_idle_alloc(struct sched_domain_shared *sds, int node)
+static int __sds_nohz_idle_alloc_init(struct sched_domain_shared *sds, int node)
 {
 	return 0;
 }
@@ -592,6 +637,7 @@ static inline void __fallback_sds_free(struct s_data *d) { }
 static inline void assign_fallback_sds(struct s_data *d, struct sched_domain *sd, int cpu) { }
 static inline void claim_fallback_sds(struct s_data *d) { }
 static inline void update_nohz_domain(int cpu) { }
+static inline int sds_delayed_free(struct sched_domain_shared *sds) { return 0; }
 
 #endif /* CONFIG_NO_HZ_COMMON */
 
@@ -771,9 +817,15 @@ static void destroy_sched_domain(struct sched_domain *sd)
 	free_sched_groups(sd->groups, 1);
 
 	if (sd->shared && atomic_dec_and_test(&sd->shared->ref)) {
+		if (sds_delayed_free(sd->shared)) {
+			sd->shared = NULL;
+			goto out;
+		}
+
 		__sds_nohz_idle_free(sd->shared);
 		kfree(sd->shared);
 	}
+out:
 	kfree(sd);
 }
 
@@ -2557,7 +2609,7 @@ static int __sds_alloc(struct s_data *d, const struct cpumask *cpu_map)
 		bitmap_set(visited_nodes, cpu_to_node(j), 1);
 		*per_cpu_ptr(d->sds, j) = sds;
 
-		if (__sds_nohz_idle_alloc(sds, cpu_to_node(j)))
+		if (__sds_nohz_idle_alloc_init(sds, cpu_to_node(j)))
 			return -ENOMEM;
 	}
 
-- 
2.34.1


