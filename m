Return-Path: <linux-kernel+bounces-799860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B902B43103
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C26C1C241AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250621A9F88;
	Thu,  4 Sep 2025 04:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B+mm/QTL"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0576F78F43
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959451; cv=fail; b=YmRn+hrIgaWJjg7YL/wdwGl92oUWK9NLg075tRZ6jyhPtBNh5AcQ2qrxF6TXREoTgN19m1SOEk+87SfCxqh6BZ39yWmQue3FvapsF+F7ng7/fybkZ652EEKXKl7E1HR+Y5I7IOh79xsahjYDd31OrW2RANHuVRJZX89nIKIk/Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959451; c=relaxed/simple;
	bh=GHKWNttjmgO6HBz0z21b5sn4FzPQlp7mD1Hfv0XtmiM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3mTcftSLi3zF7DZz7s8Mez8qAk2gFJZZpv5KygKgh+aDXH03glxmGBcIQa7unN6Un4Wl2RWmeB5naUl+M6Gdbe20TDHFiz3gLtAnx6anmu9V/2rDqerVfHaBaFixVHCh8vHaEiASQE0sn8ShjHSHmvPy7k8es2ROPgqaI43Qa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B+mm/QTL; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmJ3K85oSJN+onjPYdXGQ3e5OTBPF8VHGZJuhWfAt39kkHlKcyrWYWIbQVeHm13l91pvKUhYtgyai8IWcgOWL6CoWnQ1/LM68pbF/IiN5Fnot40wTweIvR0BWmFZy/nsk1TvHEKZXhm3zMyCH6UlFt3uLAtZFi4/bvJtKnbWIyEByiKq8wMKkJ++nWUVXRBtaE4IY52mmfERYSxTpgcgphlUgArH/mGVUd/goDTdN5jnUcUlBlJ+U/VQsCqRELUjDnJL/wLowtY80idwb1AQZFsHMjMlj5d4qAq2fW7jbxjiZ/gMHsqrqLu8j2zpEHA4glshpUXiNLPlDKiiqhnzUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/aJryXXOgpMbyU6L9uyW2Xw08Ihh1aMO5fgxttBzTc=;
 b=AfNGKnEOLO+GVd16bit8sRURdXcSE5p6+eNhZlkqNoUz8SOFf/PNrgcrw2w+DEZkQX8eMKBFAPgOQ4109HvJFwTSLnTbFSsFRRC3HR0sgtA1Gebr8NPTWWXMyepph80X3MBvmnimczS0yRN1Skd8LLO6nPacwLDoQcnbl1/kCS1CU/LyNsOik1FGd1y6vTe3UYXt6T5Yu/65zmWYEOH/Kuy/4lZMaRHqr6VEyq5e91ZRPj9mw299eVOPKvo7HD8gZBrf285485bJpgcgMYpKmUPKIosWHj6BAUGfjPBK8IrOl1xwUcjQJEIf+G+Cmb6vdZ+QClOU8aoV0meOooHsSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/aJryXXOgpMbyU6L9uyW2Xw08Ihh1aMO5fgxttBzTc=;
 b=B+mm/QTLEuNMBut/WDJsUNAj9oCwRnV2xB3TXQha/X+SPJ+7fXc3AR7yxBGIdoKGLCWaiPXr0avNIwVtncIbk+Y9g1K9zGiFqQVktSLQp4tEPaoOOngtT6LYh8Vo7TMRIOpdrsjN75CIwoIcJbGyIbYbMw4ghWQzo3p0AKlYAfc=
Received: from SA0PR11CA0064.namprd11.prod.outlook.com (2603:10b6:806:d2::9)
 by DS5PPF2FA070BDF.namprd12.prod.outlook.com (2603:10b6:f:fc00::649) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 4 Sep
 2025 04:17:23 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::3c) by SA0PR11CA0064.outlook.office365.com
 (2603:10b6:806:d2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Thu,
 4 Sep 2025 04:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:17:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:17:22 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:17:17 -0700
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
Subject: [RFC PATCH 06/19] sched/fair: Fixup sd->nohz_idle state during hotplug / cpuset
Date: Thu, 4 Sep 2025 04:15:02 +0000
Message-ID: <20250904041516.3046-7-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DS5PPF2FA070BDF:EE_
X-MS-Office365-Filtering-Correlation-Id: 3257cafa-fdc0-4c92-6206-08ddeb69f25d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GVcyFjv4Y9bd8+V4mH6BpKhBLbkZQ/bbTIKt4iVYOy7g5Bw+aLZmNsG4AriB?=
 =?us-ascii?Q?mSNrb+cUWhu8TBxi5aQ0fClUuTkXlc1rcCBMe6iS/73cV3HbIyjVcdeTRyCn?=
 =?us-ascii?Q?9+yckekjFFUu3ASFQ/BBw7Tl0GwIy9mP8tlh3X3h5adaHVoDlof9dy8f3Psp?=
 =?us-ascii?Q?JP3HL9ChP/DnsCOzjxuJZ6g+mrfGRAcAgJMuRmLNXXvt7kcjYSgvJTx9jc5j?=
 =?us-ascii?Q?gsysIZHtu3RPSlAjpteFonEGSQB4MjNzOF6OpZu99jPB/MRGlxUaI1RiFUTL?=
 =?us-ascii?Q?0Z4kzpcE4gpVDpyW4qb/VKCyJ6YryhJeFz0Z1BMDwF7bFGRZqq/pXWo1QjOS?=
 =?us-ascii?Q?cxfFvLnpa0+YUdqzsZQ68GwLRyvavtgepSoG5cFa1HD/O0wo9EeLgMIDGt8A?=
 =?us-ascii?Q?bwY3epw6brtp0SF1VT13i5Mo6gD1gk/hK/BsgMQ/Q9GFxIhzU7iCSNWJt/O+?=
 =?us-ascii?Q?zFEAqpTCzr3Hsn6g9H3V0Fb9pWDllik+8F4C3HolkuluqRyMqt3yf++jZ7VZ?=
 =?us-ascii?Q?WrccM69+EsE+ujO7EQhnZYK1dR0LGjMVQFwisbNZG+g6wFt/Gh0XKKj17/Bw?=
 =?us-ascii?Q?FOQFQtjMPjfdf//WXflu8aXHzuQbpjF8ly3UyPjmdPFuATKAK8Dh+tZ4MseP?=
 =?us-ascii?Q?cTl4dUuwRzMZJT6lLuGw5EKA/Kgfi6qY+VdkdlETbBkXW9EEDZciY+TpKC9d?=
 =?us-ascii?Q?T9cfWbcAqKwQNhc5a3Xt09ju3D6JcF2raOEgFidRgip2KJ2HkSYedXumWqgz?=
 =?us-ascii?Q?ovSRJ9xrT+JbPAJseO2rjrDtEBLK4tztbHwZAi+cjo5vfx/OiaCP97G1nAWK?=
 =?us-ascii?Q?azSXLMaw9scWSD7Zxt9fz9ce5FtDR2ZrbGjpEz19kvs9wd1KrDvRw/Jl9z0n?=
 =?us-ascii?Q?297EcuSpqkJbOOXxD5aMobEHZYoYY11KD4oi7vDz+lIdKUvNKLtM/QWgXnY8?=
 =?us-ascii?Q?cajytL3y+ECqJGnhmIwJQswiyDYZnEgnXs4Io2dY8wg80HUhWqpT8Bj4x6Nd?=
 =?us-ascii?Q?YzZ7pJ3k7+wQVs+7TnLlBqjjWFzDzggaSzi2/ScC6HdOYv5uxuLHuEddoHyC?=
 =?us-ascii?Q?EU3Onagw/tM6UWTuRPCZw5D7+gQlwYKN0BSMC0eW1yWg0bd91kE5/ejqUm+B?=
 =?us-ascii?Q?Y+WStQZ0vLIIBuLyvHa80k4zZo4x1HSMOzbncnD3w5YMESSiPtv1bGBsV1e8?=
 =?us-ascii?Q?Vm/Ep8dxUctjHAp5dG3x2jIYAHelxVqSCL7QjJWZhlOD8v5i5nSQ1p3SSwm2?=
 =?us-ascii?Q?ncztc91Gcnd+/02EoueA0w/raughGwQWM3oPjWnlhmCRZLPw00IHGw6mi+pL?=
 =?us-ascii?Q?tc7g2KCAFlGnZ5VgGBKCguyrbsWP5ZShQ8bOxPHntsb+dfOd8xm9DjsASlHG?=
 =?us-ascii?Q?ooQ+l7ORIuUT52gmno/gXF+aGbKCFU5PHOAgQnp89VA+OVkB4nzKRIXTursK?=
 =?us-ascii?Q?0lBeEapJhSxNs9NdblMLNoXPLqMI056npcgQhobSm2my3rOmARYTzw2xSYq9?=
 =?us-ascii?Q?/JE0zZ7PzXAIdCQyPw6YbNAvkG2exFLYvIUw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:17:22.6077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3257cafa-fdc0-4c92-6206-08ddeb69f25d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF2FA070BDF

When CPUs are transitioned offline, set_cpu_sd_state_busy() is called
to exclude the CPU from nohz idle balancing. Currently, it is done
independently via sched_cpu_deactivate() but subsequent transition of
the nohz idle tracking into the sched domain hierarchy would require
each CPU's status to be updated in the new hierarchy generated during
hotplug / cpuset.

Call set_cpu_sd_state_{idle,busy}() from the fair_sched_class' offline()
and online() callback respectively to ensure "sd->nohz_idle" of the
updated hierarchy reflects the same state as "rq->nohz_tick_stopped".

The changes from the prior commit to always update the rq->sd and the
top cache domains from rq_attach_root() ensures that the offline()
callback works on the older hierarchy and the online() callback works on
the updated hierarchy.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0e68371365a5..61e1b4deb3e8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12491,6 +12491,18 @@ static void set_cpu_sd_state_idle(int cpu)
 	atomic_dec(&sd->shared->nr_busy_cpus);
 }
 
+static void cpu_sd_exit_nohz_balance(struct rq *rq)
+{
+	if (READ_ONCE(rq->nohz_tick_stopped))
+		set_cpu_sd_state_busy(cpu_of(rq));
+}
+
+static void cpu_sd_reenter_nohz_balance(struct rq *rq)
+{
+	if (READ_ONCE(rq->nohz_tick_stopped))
+		set_cpu_sd_state_idle(cpu_of(rq));
+}
+
 /*
  * This routine will record that the CPU is going idle with tick stopped.
  * This info will be used in performing idle load balancing in the future.
@@ -12741,6 +12753,8 @@ static void nohz_newidle_balance(struct rq *this_rq)
 }
 
 #else /* !CONFIG_NO_HZ_COMMON: */
+static inline void cpu_sd_exit_nohz_balance(struct rq *rq) { }
+static inline void cpu_sd_reenter_nohz_balance(struct rq *rq) { }
 static inline void nohz_balancer_kick(struct rq *rq) { }
 
 static inline bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
@@ -12940,6 +12954,9 @@ static void rq_online_fair(struct rq *rq)
 	update_sysctl();
 
 	update_runtime_enabled(rq);
+
+	/* Fixup nr_busy_cpus and nohz stats. */
+	cpu_sd_reenter_nohz_balance(rq);
 }
 
 static void rq_offline_fair(struct rq *rq)
@@ -12951,6 +12968,9 @@ static void rq_offline_fair(struct rq *rq)
 
 	/* Ensure that we remove rq contribution to group share: */
 	clear_tg_offline_cfs_rqs(rq);
+
+	/* Fixup nr_busy_cpus and nohz stats. */
+	cpu_sd_exit_nohz_balance(rq);
 }
 
 #ifdef CONFIG_SCHED_CORE
-- 
2.34.1


