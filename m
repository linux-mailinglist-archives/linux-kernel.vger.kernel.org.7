Return-Path: <linux-kernel+bounces-799869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 349D2B4310D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4DA3B946B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEB41F1313;
	Thu,  4 Sep 2025 04:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sUQ/G012"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F683AC1C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959614; cv=fail; b=peupvB6XuvOdwp/CjfFraVe235bTGXp2M+52PIEbDiAFQUArdj1nopmuHEpvN99QMaq9udI71VL/XKwUsoJcLYzGGDoPrK2qDZq6fBC+oNtyRJ4WbFgDFk/Qm3noG9qJy5eXl56IFv9o1XyE1o8fuPmxrJHPdCQurahPNi+q+KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959614; c=relaxed/simple;
	bh=YMWp1oAGAUdWbY6heSmOcfug0aiKkQSvG+khnJXT8hk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K194IX/tDqRusvHodeLlvpnXi3OkGwgFlwi7/Z8ijnjrsB4Nl1r7P1dOkZaGQhG4e35ohLjWs1WRwFGphf/KUYAbZeIHZ3D+rh5Xtp5G9rpDTGV7yJLCF/pUAJbD8jOXbDIi1GAC9YxPwNTQOmEai6axyvDgF/ddakCTbndxufY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sUQ/G012; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wikI6gprCm7salNKLXorcoquHuArAQPwgraH7nE/kdy4S57UvZ51G5tXfks06Ydd4hp9441A3/d04wr3Rfd/uwqfITKSx7/cxdfLh/B6b1SEjxpMegTd/OOn1EnwNrWYiGtuVxpWUDK8RLoVjYPsjDJvGVzFh846o6OYouxa+Bv7dyGhKcTX7bThDtmnW32Gta5SN5mZFoChY0Q0sie5kTI7G1qF/yGQKZtpsD3IHLHZVVd8T+MJv4DI2HlINCNOOQNjnkztTyC0dPQW1ZhBKZPxu8k9u4ANtVjM9CQs11YHhWUNqU59AigB3VWm6ULGfaSzQAQMnWEkQOpWvIDfSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6ZH8cUYPxMEF6gJh4Qvdm7EFKssCP9kvh6CreJngeo=;
 b=H8d+8H7JQjVv8JGEWk6tWXVH6saR326PRsKxZDnkqNSnuLUH1a4gML3hMlFDu8sCaDvkSptAyge4vnsU/CJx5l4ayUpWnYk76oHxYP7sI5ao1StlIO7y3C7INVdjfAHo3UK25fiZ7xmWF8QaZqzxxnbn7JfnbtEJSkHyLfnZ7DR+ofKDQhHWsgU8TsKUPHBrir/+vLIwmOAeXZo/z7VjMujLQtQ6gLuw3VidsKYgBRJSoqvSdTF5skRlM9nELeGiTFtk47JktIpXa+5t7GVzxuUO1ohrfLhiLtUPSkPA3/+wN+c4Gp7SL4RJTD1b3905mJVo147knZDfmsLp25gZVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6ZH8cUYPxMEF6gJh4Qvdm7EFKssCP9kvh6CreJngeo=;
 b=sUQ/G012CaTUsfdx2weybWBSt537MBtoae5Plu4v7ZEpAkbqLcAZkFh7pRfo1nFOztCkFj40JpCgqYQ1wnfWCI1I18Rug3151iShbJImPfwuD+gIjzlAzunqymcckWHgFfaeX6PLMEysYKvK8/I+xkf2i19/+PzFZJwpy5zAMpw=
Received: from SA9PR13CA0143.namprd13.prod.outlook.com (2603:10b6:806:27::28)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 04:20:07 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:27:cafe::48) by SA9PR13CA0143.outlook.office365.com
 (2603:10b6:806:27::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.10 via Frontend Transport; Thu,
 4 Sep 2025 04:20:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:20:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:20:02 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:19:58 -0700
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
Subject: [RFC PATCH 15/19] sched/fair: Introduce sched_asym_prefer_idle() for ILB kick
Date: Thu, 4 Sep 2025 04:15:11 +0000
Message-ID: <20250904041516.3046-16-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce241c9-19c2-4949-31f7-08ddeb6a549f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0NMpEag1ccNi1xzst5ezdXxnVyFijKuardFZQq5poZJruT3OS7+L79iZwaRF?=
 =?us-ascii?Q?qUOM6CcKRdR0n0jk0jhUg5CVKd0+UahysgxF5Q74/5Pjr5FceQm6CASZFOJm?=
 =?us-ascii?Q?gwSms4o3zr9eKsYIZNEfXA+jG2UKlAyT/sXyCYoKWBtAneIHYGw53qigIv6Z?=
 =?us-ascii?Q?p7SewT3sNo0nDbfQQ/UmmMj3zURkEIcguFqYWxgfwv3+cbxZBHeCG9m6jXfQ?=
 =?us-ascii?Q?qzy2X0SBf74mhPlkcWicN24oH+aelRbgNs4UG8zpfaD2bqRrHX7Uv8cQP9s1?=
 =?us-ascii?Q?jaQzx5CNw9GQIABXI5XmT/Z5Pc7m7k/0aRCG34Ncjui4V6q4h6DxedtRIs4t?=
 =?us-ascii?Q?xAyqEmb05K7AfDCgOvrddwsk3+Qttr+ppkBSU89/oZzSHTkIYi2k/JzeWSyT?=
 =?us-ascii?Q?QdteZK400Ig8QWvYvyl5eRMSG+EtPvRV21c9RIs+Rj2AFmK4KyVb0wRPf+E+?=
 =?us-ascii?Q?jTjNqbRaOCjbMJWYTMEi+uups6VUHTaqbAOuk0YkOs9MyKNfKdzzAp4dhgsG?=
 =?us-ascii?Q?bVgNNrfiGwanZJrNtZ46bWlzhZR4bvc4FUkcbOoGEL+RsxsMgWizI2vlvEUq?=
 =?us-ascii?Q?11KStMPv1uyJORnPtiEVirzYFEvtDutdtiyYg1kcf7rSSAV7nKts0/Oz6dHy?=
 =?us-ascii?Q?RyFYdzebUQUvqy84XvlYuyypRnoJfSSUchozWidbxBu3Ik1ORuad9X2QfFmU?=
 =?us-ascii?Q?QBtkz1MN2Oq1po5GHjfy75i6nTKRyQIoIcUm7adv8zqb6/BkmwzhZce5BF85?=
 =?us-ascii?Q?XBYa88jVriZv3wENE75A7DSOP1R3BM6SwP3y0cbAA+mHlGydXqGYiYOin/9g?=
 =?us-ascii?Q?+9W8PfSFDiZM+m9vt3HLH1MerqDlr3Js49rGTdIcbc0EB5AIkF1aOjkiO7Gj?=
 =?us-ascii?Q?30giAEyC3m/O+ayZ0zO1DdMnnLlGzcFj2/3PoC9jMtcAamMDLNobnTSqe6+n?=
 =?us-ascii?Q?joQPfqZhCN5Jy00bKe+h6KX4VUUwuXkNtK8F95njHV6yVcK1ARi2TGEAnalg?=
 =?us-ascii?Q?h9fydgab3Ab8Acpzlkme/9ikB0W9mB2VG72Y05Ms9b81Qgeahj0xj0tETTLM?=
 =?us-ascii?Q?GyHMP59EOzW0Vajlevn/BZEDFnSwQmPTYH21A4vVV5vphZjfOIDQzS4hcEaQ?=
 =?us-ascii?Q?9dMm1KHeJKcm+WVHTjz766EHbFrlQ0+RkizdjSNAAc01XSudrCaPicoMNHr4?=
 =?us-ascii?Q?3/+E1U+ronGDDB9O5BXCTEfnhZUs571OUdaJw4HNkTn01E8nlS1f9bwr/rFq?=
 =?us-ascii?Q?8Zgk91mVZ5aQ43W1zFxegx541WKLZ0JwS4YCt3tQUxsS4Jaz2ROIWPvJ3lGf?=
 =?us-ascii?Q?t8+Kwek7WfuJrvlIvEhzKBvKUshGRg2fjJqUEwqnGqbZiX4LOrRbI7zHOYnX?=
 =?us-ascii?Q?YQ2XC3CB+IulWjlN1RTEO6JG9ctC50quM369OMl0K7R1zfRdjp13jt9YVt8q?=
 =?us-ascii?Q?j3hSKmRAzEm2um5jIv42dIDsc8p2im4xPvVGzxDN1IyDx3MSf40GVnMasrL0?=
 =?us-ascii?Q?+zZubzn0yOr0VYourjC1fNoAQ3UXbb+McfdE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:20:07.4603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce241c9-19c2-4949-31f7-08ddeb6a549f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111

nohz_balancer_kick() currently depends on "nohz.idle_cpus_maks" to kick
off an idle balance if it finds a more preferred CPU in nohz idle state.

Move the detection logic into sched_asym_prefer_idle() and use the
distributed "sd->shared" based nohz tracking to kick ILB if a more
preferred CPU is found idle.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 70 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5e7198078d19..d309cb73d428 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12289,6 +12289,56 @@ static inline int find_new_ilb(void)
 	return -1;
 }
 
+static inline int
+__asym_prefer_idle(int cpu, struct sched_domain *sd_asym, struct cpumask *idle_mask)
+{
+	int i;
+
+	for_each_cpu_and(i, idle_mask, sched_domain_span(sd_asym)) {
+		if (sched_asym(sd_asym, i, cpu))
+			return 1;
+	}
+
+	return 0;
+}
+
+static int sched_asym_prefer_idle(int cpu, struct sched_domain *sd_asym)
+{
+	struct sched_domain *sd = rcu_dereference(per_cpu(sd_nohz, cpu));
+	struct sched_domain_shared *sds;
+
+	if (!sd)
+		return 0;
+
+	/*
+	 * If sd_asym_packing is a subset of sd_llc, don't traverse
+	 * the nohz_shared_list and directly use the mask from
+	 * sd_nohz->shared to find it a preferred CPU is idling.
+	 */
+	if (sd_asym->flags & SD_SHARE_LLC) {
+		sds = sd->shared;
+
+		if (sds &&
+		    atomic_read(&sds->nr_idle_cpus) &&
+		    __asym_prefer_idle(cpu, sd_asym, sds->idle_cpus_mask))
+			return 1;
+
+		return 0;
+	}
+
+	/* Try the entire list id sd_asym_packing is larger than sd_nohz. */
+	list_for_each_entry_rcu(sds, &nohz_shared_list, nohz_list_node) {
+		/* No idle CPUs in this domain */
+		if (!atomic_read(&sds->nr_idle_cpus))
+			continue;
+
+		if (__asym_prefer_idle(cpu, sd_asym, sds->idle_cpus_mask))
+			return 1;
+	}
+
+	return 0;
+}
+
 /*
  * Kick a CPU to do the NOHZ balancing, if it is time for it, via a cross-CPU
  * SMP function call (IPI).
@@ -12343,7 +12393,7 @@ static void nohz_balancer_kick(struct rq *rq)
 	unsigned long now = jiffies;
 	struct sched_domain_shared *sds;
 	struct sched_domain *sd;
-	int nr_busy, i, cpu = rq->cpu;
+	int nr_busy, cpu = rq->cpu;
 	unsigned int flags = 0;
 
 	if (unlikely(rq->idle_balance))
@@ -12389,21 +12439,9 @@ static void nohz_balancer_kick(struct rq *rq)
 	}
 
 	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
-	if (sd) {
-		/*
-		 * When ASYM_PACKING; see if there's a more preferred CPU
-		 * currently idle; in which case, kick the ILB to move tasks
-		 * around.
-		 *
-		 * When balancing between cores, all the SMT siblings of the
-		 * preferred CPU must be idle.
-		 */
-		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
-			if (sched_asym(sd, i, cpu)) {
-				flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
-				goto unlock;
-			}
-		}
+	if (sd && sched_asym_prefer_idle(cpu, sd)) {
+		flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
+		goto unlock;
 	}
 
 	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu));
-- 
2.34.1


