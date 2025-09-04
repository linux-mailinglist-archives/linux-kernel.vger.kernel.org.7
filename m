Return-Path: <linux-kernel+bounces-799862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01698B43106
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E5717588B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63811F542A;
	Thu,  4 Sep 2025 04:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ii+YSO6h"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ECA1BC58
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959485; cv=fail; b=W9JHtNy+JhuXis8c4CvgiTtURQ8fpjOYCMnFAsMT6QGwrQq4PTDLIDMVJWiWFRlZr8BagieAQb5hCZ2ijtm0reKlcqp9+6jYpQGzmNZ1+sDaYgDM3iM+gna4nblhEEiRb94eQH11IblunLWXOA5PLC+Iu+uGzkgogWNCypF5pvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959485; c=relaxed/simple;
	bh=FMew96lDjvFWNRmBL380KbU2s36MMaSFDFrK5Iczs3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmjjQIBFcIntOvwpv+IxSLw7B0s+MSwGvE+pUehHJGmGUQRqlCFRUAEjWr4TGKHaJg9zHlDQUR4Bp1SfhG+Slwy7dU2yeXYomfKRjxUaf2nH41ZQ84tDBXb8qgiILkreylgElho4g12lYp8eFz+tWkxgm6QN3uOFV05CVNn+e9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ii+YSO6h; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vscVgU2glzJBHW8tXqAELLDoJ7k71p7kZKl/xbeANy6BjM2P7XweG1YSQX8SPO5ZGaKqQzbj22hfFpaveypSyw8QEaWDwDcP1dvY28wIQdJFpbaftQXpVg4+Tv1VPNCf2b7PGbEROIvXqQx3Vtc9x3X1Cl5RIOGOgcntE4U56V+XMkgcOVM7UNTKyC7fvt6NICbh0P7c6Wy7lF2X3pb31MqFt5Pif4YkkySAKGWThpF+kMEpjjNR5y1f7px1qD/bljBRzY2ESAIpKXsWg2CFi/So+J4V75tbZMWqjiyrFaEZF+HCdrvUpgFbWVOncwPKqTRVUYbdeiCNl3MSDzEPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxjoBt4iA7Xgr2dFS05ErOIFnuKyixnANaUEZp/wI4Y=;
 b=ZaOnNeieViXIGKu6vepBaP0TL509W2szheB2FH76GYqBcepZ8liJJfzE8cIRGqvIDZ66+NMGbzDHtnl229kVOHP8EOjfpUWor8se5Gv1nC6tiPcPU7MjCajTpLjin9xKHc6gUxKPVEpCrD2nJXw91sfPjOHO5GbrMAyupXOtLLjjSZxfNdLMk2pSK92T+qwMIPjZgevujCeLYvQi8W6MyeQDZkWQW7F8h3ZSHgJYn6YE2ueeUxRpzniroZGpQSxWRSxY0NYRs3sEFnSK6zq0qrEyIec6e5ZDw41pCf7KUEyxhuop2VsoMRNV6GSfjG1kmwk9So5gSaKRY7WWTwEE3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxjoBt4iA7Xgr2dFS05ErOIFnuKyixnANaUEZp/wI4Y=;
 b=Ii+YSO6hikpn7XwF98Bz0LdHeC1Ei3KmIRJALLjKZxATkAN5i+JsOzxu/EoDsiXzmTb2QhBQwQzsuts5bri0fMj5q9sT8J1vD7PmBIMt2bXGATx23+oXlfJPoIqg/EpYkkSquRv52CfKJApdikOZ6mH03B57ttqDUmEBvENf42o=
Received: from DM6PR07CA0098.namprd07.prod.outlook.com (2603:10b6:5:337::31)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 04:17:57 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::ec) by DM6PR07CA0098.outlook.office365.com
 (2603:10b6:5:337::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Thu,
 4 Sep 2025 04:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:17:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:17:56 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:17:52 -0700
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
Subject: [RFC PATCH 08/19] sched/topology: Introduce fallback sd->shared assignment
Date: Thu, 4 Sep 2025 04:15:04 +0000
Message-ID: <20250904041516.3046-9-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|BL1PR12MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc1ce7e-6d8e-4227-fb8d-08ddeb6a06e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C6s1F37DBprAgDADoNr3cz4uFa/MMOkfmWtXqwQSw62m4PCVRz5EFVGE+qMe?=
 =?us-ascii?Q?gC5nlf+ozSZ3AWIJS3bYQHlkzBP34UwqC4gF72LqFuVIeYFT273SrnHQy6IA?=
 =?us-ascii?Q?VdEADTxo3ffM4PpYyg6XbYKzxuuWQDuZnM0Rh3QCtRIfCja6X90zUvm6tEYd?=
 =?us-ascii?Q?z1tgbhdahh0tVRi5UHuOwGg+pC6a7P7Bp5N1dXHF32Hh3/Zm1wbx4NbLz+Cj?=
 =?us-ascii?Q?MAPtE0lduS32xCz5d1FhlVVsvoG8o3yll0NPq3LSWsqZ1XTotGvuLBj9Y6sV?=
 =?us-ascii?Q?s8OMZ1xvmFestl5vLs9uVP4euckCQutO7B9LcEOWraB3Lx9nMIODXhlxx3gw?=
 =?us-ascii?Q?MlP5m29i8vDCI9iM4x+m4WZXIFp/Y0SIoyA4XgTIMrCA5Hm3casqC0rn0Ct6?=
 =?us-ascii?Q?g+5b2WdFjaUr9sAgcsbFRB3I8wmLSDXLQYdjLIhg25AtdB6DFH+r4GLAVgPG?=
 =?us-ascii?Q?mq0aNrC/KROtgWM3xRkwrwzVOepT8EENYstlCQi6080VjKeQ3pio6COMxQM+?=
 =?us-ascii?Q?SvNa9KR8kW5vvEwdf7zsjJofr5U+RkQfGLgkN4/IbF372NGOo9u/lGqbMZu1?=
 =?us-ascii?Q?c33xOlD8dOBRcPRFsUHJXW+rjuEG1GIP+gYuQCswkB9NOZB2/BdI82I8VKOk?=
 =?us-ascii?Q?o/apUxu3j5Wi47xzXhL6Fv2ym3GowUGUMc4LWKFDD/Rabxh5kgM/HNcsyKjo?=
 =?us-ascii?Q?+o5t1ay8HOyONUGmfTCM22i+wbAUZeD+Qdynvsdlp6FvQXgiHfvfuGk/SYe4?=
 =?us-ascii?Q?KvU8LgmLjimN4CJQ+eHgg2aiqou7Hl4n5he2S+TtP0HvkeuUu5PLzYI/191Z?=
 =?us-ascii?Q?CpmG7m5Wlxdy4DmT+/nQxJof+ujBaaq3khWeo2bJ56pzmHxqEwAKKxLcw/jj?=
 =?us-ascii?Q?8m6yMsKoBDTXUNG0wbINPTK+rd3r6a8DQ54NSBzdoI3TyhxMPf4tPlysU2cd?=
 =?us-ascii?Q?8R/c4tO11NvUC6Xh3tmMfAY6tl7eI+fSVZZhlt/A5cNJO6VgRrcOJhgaWytv?=
 =?us-ascii?Q?z5a5GvpU9LJfqlgNtL7UFEOPWW07WfH2BTtq4vrb/panb4lVG+PzxFFJ9nIC?=
 =?us-ascii?Q?u+ZyYJw8IKp6cqIZxJGU8+vwraEBQ5nznSlqVaY2JcMwLHGYvbyEK8RdjXA1?=
 =?us-ascii?Q?yA4UQo7DiL7WHOdqVvH5fl8hs3gHheBa6/hqRqklag5E8Qz8baF6roZHOCo6?=
 =?us-ascii?Q?aEKd7PteesprFqm5kxLEaEdtSR4GnEPJsQ6qcjgUErk7IBjzbzVRnjyp9jGD?=
 =?us-ascii?Q?CxaxH31LKtzdxG2WCqMSLCFMrdRLhhle658/4JVjwVcIAn/DEMW+Kul94X3w?=
 =?us-ascii?Q?p0+ucN73Mltrz917qB3ypP8R02uYicxz8k9/R6Avb0qS+dPB/DWmIxRDUXzV?=
 =?us-ascii?Q?FIYOvXRHLCIX30b22Tb4PP9R8xb4na513fB4mC6Bj86bXv0JAkpewxIzphkD?=
 =?us-ascii?Q?VXqYNu2dY7PEkYjUXdE7GqvfJB5nzg5iJG/Hx2MGp9y4fMGmNK0pj1WXn7Vk?=
 =?us-ascii?Q?yIJGewSqqGXdmCGFHoHZiHEv+UEa6ucsX4TF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:17:57.0060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc1ce7e-6d8e-4227-fb8d-08ddeb6a06e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947

Going forward, tying the nohz balancing to "sd->shared" will require
each CPU's hierarchy to have at least one "sd->shared" object tracking
its idle status.

If the lowest domain of the hierarchy after degeneration does not have
the SD_SHARE_LLC flag set, assign a per-Node fallback shared object to
the lowest domain on CONFIG_NO_HZ_COMMON. !CONFIG_NO_HZ_COMMON kernels
will always have tick enabled on idle CPUs and will not require nohz
idle tracking.

An example scenario where the fallback shared object is used is as
follows - Consider a cpuset with 17CPUs where 16CPUs are from the same
LLC and a singleton CPU from another LLC:

  CPU0:
  domain0: MC {0-15}
    groups: {0} {1} ... {15}
    domain1: PKG {0-16}
      groups: {0-15} {16}
  ...
  CPU15:
  domain0: MC {0-15}
    groups: {15} {0} {1} ... {14}
    domain1: PKG {0-16}
      groups: {0-15} {16}
  CPU16:
  # MC is degenerated since {16} is the only CPU is the domain
  domain0: PKG {0-15}
    groups: {16} {0-15}
  # Assign sd[PKG]->shared = fallback_dhared[cpu_to_node(16)]

If the lowest domain is a SD_OVERLAP domain, "sd->shared" is only shared
by the CPUs on the same node and not the entire domain. This is
acceptable since the fallback shared object is only keeping track of the
CPU's idle status unlike sd_llc_shared which also tracks
"has_idle_cores" and "nr_idle_scan".

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/topology.c | 123 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 117 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 0b0257937a97..d71c60d99313 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -455,6 +455,96 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
 static void free_pd(struct perf_domain *pd) { }
 #endif /* !(CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL) */
 
+struct s_data {
+#ifdef CONFIG_NO_HZ_COMMON
+	struct sched_domain_shared **fallback_nohz_sds;
+#endif
+	struct sched_domain_shared * __percpu *sds;
+	struct sched_domain * __percpu *sd;
+	struct root_domain	*rd;
+};
+
+#ifdef CONFIG_NO_HZ_COMMON
+
+static int __fallback_sds_alloc(struct s_data *d, unsigned long *visited_nodes)
+{
+	int j;
+
+	d->fallback_nohz_sds = kcalloc(nr_node_ids,
+			sizeof(*d->fallback_nohz_sds), GFP_KERNEL);
+	if (!d->fallback_nohz_sds)
+		return -ENOMEM;
+
+	/*
+	 * Allocate a fallback sd->shared object
+	 * for each node covered by the cpu_map.
+	 */
+	for_each_set_bit(j, visited_nodes, nr_node_ids) {
+		struct sched_domain_shared *sds;
+
+		sds = kzalloc_node(sizeof(struct sched_domain_shared),
+				GFP_KERNEL, j);
+		if (!sds)
+			return -ENOMEM;
+
+		d->fallback_nohz_sds[j] = sds;
+	}
+
+	return 0;
+}
+
+static void __fallback_sds_free(struct s_data *d)
+{
+	int j;
+
+	if (!d->fallback_nohz_sds)
+		return;
+
+	for (j = 0; j < nr_node_ids; ++j)
+		kfree(d->fallback_nohz_sds[j]);
+
+	kfree(d->fallback_nohz_sds);
+	d->fallback_nohz_sds = NULL;
+}
+
+static void assign_fallback_sds(struct s_data *d, struct sched_domain *sd, int cpu)
+{
+	struct sched_domain_shared *sds;
+
+	sds = d->fallback_nohz_sds[cpu_to_node(cpu)];
+	sd->shared = sds;
+	atomic_inc(&sd->shared->ref);
+}
+
+static void claim_fallback_sds(struct s_data *d)
+{
+	int j;
+
+	/*
+	 * Claim allocations for the fallback shared objects
+	 * if they were assigned during cpu_attach_domain().
+	 */
+	for (j = 0; j < nr_node_ids; ++j) {
+		struct sched_domain_shared *sds = d->fallback_nohz_sds[j];
+
+		if (sds && atomic_read(&sds->ref))
+			d->fallback_nohz_sds[j] = NULL;
+	}
+}
+
+#else /* !CONFIG_NO_HZ_COMMON */
+
+static inline int __fallback_sds_alloc(struct s_data *d, unsigned long *visited_nodes)
+{
+	return 0;
+}
+
+static inline void __fallback_sds_free(struct s_data *d) { }
+static inline void assign_fallback_sds(struct s_data *d, struct sched_domain *sd, int cpu) { }
+static inline void claim_fallback_sds(struct s_data *d) { }
+
+#endif /* CONFIG_NO_HZ_COMMON */
+
 static void free_rootdomain(struct rcu_head *rcu)
 {
 	struct root_domain *rd = container_of(rcu, struct root_domain, rcu);
@@ -716,12 +806,6 @@ static void update_top_cache_domain(int cpu)
 	rcu_assign_pointer(per_cpu(sd_asym_cpucapacity, cpu), sd);
 }
 
-struct s_data {
-	struct sched_domain_shared * __percpu *sds;
-	struct sched_domain * __percpu *sd;
-	struct root_domain	*rd;
-};
-
 /*
  * Attach the domain 'sd' to 'cpu' as its base domain. Callers must
  * hold the hotplug lock.
@@ -790,6 +874,14 @@ cpu_attach_domain(struct s_data *d, int cpu)
 		}
 	}
 
+	/*
+	 * Ensure there is at least one domain in the
+	 * hierarchy with sd->shared attached to
+	 * ensure participation in nohz balancing.
+	 */
+	if (sd && !(sd->flags & SD_SHARE_LLC))
+		assign_fallback_sds(d, sd, cpu);
+
 	sched_domain_debug(sd, cpu);
 
 	tmp = rq->sd;
@@ -2387,12 +2479,19 @@ static void __sdt_free(const struct cpumask *cpu_map)
 
 static int __sds_alloc(struct s_data *d, const struct cpumask *cpu_map)
 {
+	unsigned long *visited_nodes;
 	int j;
 
+	visited_nodes = bitmap_alloc(nr_node_ids, GFP_KERNEL);
+	if (!visited_nodes)
+		return -ENOMEM;
+
 	d->sds = alloc_percpu(struct sched_domain_shared *);
 	if (!d->sds)
 		return -ENOMEM;
 
+	bitmap_zero(visited_nodes, nr_node_ids);
+
 	for_each_cpu(j, cpu_map) {
 		struct sched_domain_shared *sds;
 
@@ -2401,9 +2500,13 @@ static int __sds_alloc(struct s_data *d, const struct cpumask *cpu_map)
 		if (!sds)
 			return -ENOMEM;
 
+		bitmap_set(visited_nodes, cpu_to_node(j), 1);
 		*per_cpu_ptr(d->sds, j) = sds;
 	}
 
+	if (__fallback_sds_alloc(d, visited_nodes))
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -2417,6 +2520,8 @@ static void __sds_free(struct s_data *d, const struct cpumask *cpu_map)
 	for_each_cpu(j, cpu_map)
 		kfree(*per_cpu_ptr(d->sds, j));
 
+	__fallback_sds_free(d);
+
 	free_percpu(d->sds);
 	d->sds = NULL;
 }
@@ -2655,6 +2760,12 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		if (lowest_flag_domain(i, SD_CLUSTER))
 			has_cluster = true;
 	}
+
+	/*
+	 * Claim allocations for the fallback shared objects
+	 * if they were assigned during cpu_attach_domain().
+	 */
+	claim_fallback_sds(&d);
 	rcu_read_unlock();
 
 	if (has_asym)
-- 
2.34.1


