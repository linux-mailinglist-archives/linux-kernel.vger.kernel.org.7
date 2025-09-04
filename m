Return-Path: <linux-kernel+bounces-799856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C62FB430FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCE83B64A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8301FA272;
	Thu,  4 Sep 2025 04:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M6SLL1mM"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982EA78F43
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959376; cv=fail; b=NUcxeClpgTPlgdBKxBcQ7lCBexaPPrkYM8I0uWZeZym9SnPXi2/vgfIwuDv21CAwLcxCy2IXEBXvZTTnPqjdrn+or0DevKWZh8G/zVTBqoTX1Iy2JKqN9TqIKJAgwZkIUK2cZl0tDpItVTO2o3aHzeTUEK8dw5JKlZXArRf18gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959376; c=relaxed/simple;
	bh=5CMoVeo+lSr2x/LAY3GtJa9hw+58CYHL1tEr8k0q2r4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+dGrFmw9I4ibvjcSTc7vW2jRCoZplrF5GajKeZ3udhuRdAtsOPsc3FgD5rebVP/w30Ltp/GMgwBFV3ElCq5Fb7zeGIq4RAcm/ryBOg6ulSBfSOWIJ2sxmIxzaka+n6yBZAnBldRiMK9SPw03oCwyfO1ffrYLdzLUZKFLdZN4fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M6SLL1mM; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIANTpL60iB+Yipy/YAYwDefWTQYt9Wk+m4sUEQEu5WnCYSW1mybiMRyUqQF1kJFdLa2oZtQvSG/79usW9LaVANaJNaBmkU77hvGPpo6Gtqqs1EDpllMu9iCvXNBhovpaCpURoWlkYYahy9Q97ViaFPtT66c4pz4NqNKL4Ip9BK1JAuovhbynGvQHE1EvyBjXPzg907Ezja0ZnxYnXATfNNe+s4vqFrJgFH00fYUzXyVfpNuavunX7Yn+7F2XCdvUoIZU+OjUsnhRoqxmSxx+OvIXm3RpahNyxOcTw5dO5SAYCW3e4gDCMwPEe8fpNbm0BQxb/cCvwKbVV5tQHeN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZm5hOD2EeqPbqgTIlFeXFjiImSIw5UtCsLCiAciRA8=;
 b=UXq0v7PVrv9GAn97FZULM5PA9zTnyqPtH9ICYbwlvORLsZZUVikoyMzPntc0X0NhM72VndLkvTCOOr94R65TaelQKkYMfa5HXCarjbR9rwVO8ScqCwCoUlH/JUFfqhGJbKJkQ3rwwtT1mf0gJHghxIuNO2XLdLffTRlel9uVA6l+auMFiz65lEfWSZfcxHCjHrPaZ0S1BwUmcY70rjp2Ir7xGdV8OKWTuEwDpzjvDaI5DiMt5lLuEzt4MQllBBcGxLO++1py6DX5eBSXME1pscC+UK9JXUzC384GkLXjfcrMeS65L2Ktrox5kDDwmInC3EImFuNKFpoivG3O1/zsXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZm5hOD2EeqPbqgTIlFeXFjiImSIw5UtCsLCiAciRA8=;
 b=M6SLL1mMSv/q3d6DY71eWqfnHWZcdVj0bZltfwTX1G/TcVjmbFoNrwKY6XYis/1F8ELtvcaE12wA2BcmOcDTz9zPkDj2D5jUS+rJQs2FlfvvWo9jOhNTz9jAv2BF/aBO6iS0Kc0LP+oIJ2XQg+bUWEdLecy2VfL+0+owszIap7g=
Received: from BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::11)
 by PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 04:16:09 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::15) by BY1P220CA0011.outlook.office365.com
 (2603:10b6:a03:59d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 04:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:16:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:16:08 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:16:04 -0700
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
Subject: [RFC PATCH 02/19] sched/topology: Optimize sd->shared allocation and assignment
Date: Thu, 4 Sep 2025 04:14:58 +0000
Message-ID: <20250904041516.3046-3-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ca6ff4-8702-4b44-d31d-08ddeb69c6c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B/LZSVNZwfDsiUSzn07+TzFc3PAXM+80n5L7JawkW/Hash8c19BtNKdtbGEB?=
 =?us-ascii?Q?kwwteHyv5+LTqas1jIzQO/F5VwL4q9E8gQRWPMEb5wMcyro0Y496xp1SdcBx?=
 =?us-ascii?Q?m0+ANfAEUQ855il9CcyjBCI6FnKVhDuF2WOIm0JKpdm5i1AuCyH7+EWS7RKx?=
 =?us-ascii?Q?nyCw70DaOw4Bm6Z7iqznRZ84rQDPDAhD4lqxehdc7h1PrmrnKq5nRhOPp+zT?=
 =?us-ascii?Q?m27OYLvin07b/AFonUkObVlBySlnD+1UFQTbQzjlSrpRqW6PdHQjmg/9oTpS?=
 =?us-ascii?Q?RFZYLsFBXKGyHay3iqth8ohSGm2g3PNpTm/CGEY+f4pl9z74+Yq7PbXUmOZf?=
 =?us-ascii?Q?ydA4QhHq/0b2+fQwKNozeU80eN5HauMLflx1J6Xp/+txZn6/COoke3qyaQ4B?=
 =?us-ascii?Q?3oQ2l1Xxk4C6zPkFI3aWWXiRPlCUBfZH0PNjJJWP+V6R7Mav0gaKjWWB2IfO?=
 =?us-ascii?Q?ThbE6m0326L279/fdFzf9CoqxTMBnDZWsGmjbWgW632ujqCsXNuQUeh6wtQ3?=
 =?us-ascii?Q?90PSL/m4/+4rYk3VZv/VQbICYrB2BEb6FpI6YKkPVx5p+ia3zshTcnYqg8Jj?=
 =?us-ascii?Q?Zipmw5UFLFph6iDMCIpjLsSppldf0+3so8459CBB0DEqg/LTXwWVpaJcIgyw?=
 =?us-ascii?Q?CmQ24qcDs0mWdM1XajiDzARZKVwK5Vw/92z9H8mskYscEjaf9gzUuMzIPTls?=
 =?us-ascii?Q?7QsOqJih3NdHASFqplEneLvHn7pfd5sTvBuyz+ADo1qfOIQM1WVflKzUMYhx?=
 =?us-ascii?Q?UcVj/dB2RHrkO2tXyk8noMIRQPJT90bg7rwbDRnOM/qIqXrhGrai2ZhAZ0eA?=
 =?us-ascii?Q?t8chYiXwj0h2LT1Bf2m+PF+C5RR6+CHS8+wGCP6uf8Tfjs1kOe+wQ3JQ4xnC?=
 =?us-ascii?Q?loWJXyMgOnKyfHvmg8f53H1v14La27gD7CqR1VeY0jtgu1rD4JxGxqanRixI?=
 =?us-ascii?Q?IIrEiRzOrsHHVxupo71cxP/ZBchT69qHtWMDh+FDEoB7mG6m0iIBNC5AWI4k?=
 =?us-ascii?Q?STumVL+uucRcg1GtGscDGqfSMnCx81KmL3Yjk4k7e5pih3S8iehGd23/Yn3v?=
 =?us-ascii?Q?08zY5tPjVliM9np86Hz33tst3vzFDXk3pyfyoe07Fo3PGsjm2uq25Hhxgo8c?=
 =?us-ascii?Q?q6RWgyvLpzIO/BTGg/wKHX686Yyuky/TmN5/UTQWPxCWAcLQUPAvmGBKfGoi?=
 =?us-ascii?Q?+gdFo3FoxilNGslMsxmWQGhpWHUCVnTrAtQACoIO/9DDCmAgaOLLWjZRe0hd?=
 =?us-ascii?Q?bf72EuO9gORaatmGJENquJm1O89RrU1tuklYsS/ODoCxWffanzJUlFSuHpU7?=
 =?us-ascii?Q?sm4gPKM7BX5i7GTMrNj1UWPNMiTX4eNZDHWNi4L2Uin6cI7LiCh1MTr7q/w3?=
 =?us-ascii?Q?M/VNlyaBvrn7ZJOB9iHiuVu8c3wfUy5iFfh4aEV2uCHjqtN00AP47XXHEHZs?=
 =?us-ascii?Q?ATYBeEoH0GglgbYl0SSthSqH2UxdfYzdZY6F3SV7XcNgqhkG2WBQPMkVL7U0?=
 =?us-ascii?Q?H94aSKNy0WQNU3GZD06mNuj49mafrEajH673?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:16:09.4212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ca6ff4-8702-4b44-d31d-08ddeb69c6c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818

sd->shared is ever only used for sd_llc_shared and the sd->shared of
lower domains are never referenced by the scheduler. Subsequent
optimization will bloat the size of sd->shared and allocation of
redundant "sd->shared" can be expensive.

sd_llc is always a !SD_OVERLAP domain and it's children are always a
subset of the domain, thus the degeneration of a SD_SHARE_LLC  domain
implies that it either contains a single CPU, or its span matches with
that of a its child domain.

Initialize a single level of per-CPU sched_domain_shared objects instead
of doing it for each topology level. Assign sd->shared to the highest
SD_SHARE_LLC domain and rely on the degeneration path to pass it to the
correct topology level.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Valentin, Peter,

Was this ever attempted in the past? Is there some interesting topology
out there that I'm missing where this wouldn't work?
---
 include/linux/sched/topology.h |   1 -
 kernel/sched/topology.c        | 101 +++++++++++++++++++++++----------
 2 files changed, 71 insertions(+), 31 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index bbcfdf12aa6e..d816911de435 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -168,7 +168,6 @@ typedef int (*sched_domain_flags_f)(void);
 
 struct sd_data {
 	struct sched_domain *__percpu *sd;
-	struct sched_domain_shared *__percpu *sds;
 	struct sched_group *__percpu *sg;
 	struct sched_group_capacity *__percpu *sgc;
 };
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 1104d931c015..f3ebb9e8fe00 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -679,6 +679,9 @@ static void update_top_cache_domain(int cpu)
 	if (sd) {
 		id = cpumask_first(sched_domain_span(sd));
 		size = cpumask_weight(sched_domain_span(sd));
+
+		/* If sd_llc exists, sd_llc_shared should exist too. */
+		WARN_ON_ONCE(!sd->shared);
 		sds = sd->shared;
 	}
 
@@ -727,6 +730,13 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 		if (sd_parent_degenerate(tmp, parent)) {
 			tmp->parent = parent->parent;
 
+			/* Pick reference to parent->shared. */
+			if (parent->shared) {
+				WARN_ON_ONCE(tmp->shared);
+				tmp->shared = parent->shared;
+				parent->shared = NULL;
+			}
+
 			if (parent->parent) {
 				parent->parent->child = tmp;
 				parent->parent->groups->flags = tmp->flags;
@@ -776,6 +786,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 }
 
 struct s_data {
+	struct sched_domain_shared * __percpu *sds;
 	struct sched_domain * __percpu *sd;
 	struct root_domain	*rd;
 };
@@ -783,6 +794,7 @@ struct s_data {
 enum s_alloc {
 	sa_rootdomain,
 	sa_sd,
+	sa_sd_shared,
 	sa_sd_storage,
 	sa_none,
 };
@@ -1529,6 +1541,9 @@ static void set_domain_attribute(struct sched_domain *sd,
 static void __sdt_free(const struct cpumask *cpu_map);
 static int __sdt_alloc(const struct cpumask *cpu_map);
 
+static void __sds_free(struct s_data *d, const struct cpumask *cpu_map);
+static int __sds_alloc(struct s_data *d, const struct cpumask *cpu_map);
+
 static void __free_domain_allocs(struct s_data *d, enum s_alloc what,
 				 const struct cpumask *cpu_map)
 {
@@ -1540,6 +1555,9 @@ static void __free_domain_allocs(struct s_data *d, enum s_alloc what,
 	case sa_sd:
 		free_percpu(d->sd);
 		fallthrough;
+	case sa_sd_shared:
+		__sds_free(d, cpu_map);
+		fallthrough;
 	case sa_sd_storage:
 		__sdt_free(cpu_map);
 		fallthrough;
@@ -1555,9 +1573,11 @@ __visit_domain_allocation_hell(struct s_data *d, const struct cpumask *cpu_map)
 
 	if (__sdt_alloc(cpu_map))
 		return sa_sd_storage;
+	if (__sds_alloc(d, cpu_map))
+		return sa_sd_shared;
 	d->sd = alloc_percpu(struct sched_domain *);
 	if (!d->sd)
-		return sa_sd_storage;
+		return sa_sd_shared;
 	d->rd = alloc_rootdomain();
 	if (!d->rd)
 		return sa_sd;
@@ -1577,9 +1597,6 @@ static void claim_allocations(int cpu, struct sched_domain *sd)
 	WARN_ON_ONCE(*per_cpu_ptr(sdd->sd, cpu) != sd);
 	*per_cpu_ptr(sdd->sd, cpu) = NULL;
 
-	if (atomic_read(&(*per_cpu_ptr(sdd->sds, cpu))->ref))
-		*per_cpu_ptr(sdd->sds, cpu) = NULL;
-
 	if (atomic_read(&(*per_cpu_ptr(sdd->sg, cpu))->ref))
 		*per_cpu_ptr(sdd->sg, cpu) = NULL;
 
@@ -1709,16 +1726,6 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->cache_nice_tries = 1;
 	}
 
-	/*
-	 * For all levels sharing cache; connect a sched_domain_shared
-	 * instance.
-	 */
-	if (sd->flags & SD_SHARE_LLC) {
-		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
-		atomic_inc(&sd->shared->ref);
-		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
-	}
-
 	sd->private = sdd;
 
 	return sd;
@@ -2295,10 +2302,6 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 		if (!sdd->sd)
 			return -ENOMEM;
 
-		sdd->sds = alloc_percpu(struct sched_domain_shared *);
-		if (!sdd->sds)
-			return -ENOMEM;
-
 		sdd->sg = alloc_percpu(struct sched_group *);
 		if (!sdd->sg)
 			return -ENOMEM;
@@ -2309,7 +2312,6 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 
 		for_each_cpu(j, cpu_map) {
 			struct sched_domain *sd;
-			struct sched_domain_shared *sds;
 			struct sched_group *sg;
 			struct sched_group_capacity *sgc;
 
@@ -2320,13 +2322,6 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 
 			*per_cpu_ptr(sdd->sd, j) = sd;
 
-			sds = kzalloc_node(sizeof(struct sched_domain_shared),
-					GFP_KERNEL, cpu_to_node(j));
-			if (!sds)
-				return -ENOMEM;
-
-			*per_cpu_ptr(sdd->sds, j) = sds;
-
 			sg = kzalloc_node(sizeof(struct sched_group) + cpumask_size(),
 					GFP_KERNEL, cpu_to_node(j));
 			if (!sg)
@@ -2368,8 +2363,6 @@ static void __sdt_free(const struct cpumask *cpu_map)
 				kfree(*per_cpu_ptr(sdd->sd, j));
 			}
 
-			if (sdd->sds)
-				kfree(*per_cpu_ptr(sdd->sds, j));
 			if (sdd->sg)
 				kfree(*per_cpu_ptr(sdd->sg, j));
 			if (sdd->sgc)
@@ -2377,8 +2370,6 @@ static void __sdt_free(const struct cpumask *cpu_map)
 		}
 		free_percpu(sdd->sd);
 		sdd->sd = NULL;
-		free_percpu(sdd->sds);
-		sdd->sds = NULL;
 		free_percpu(sdd->sg);
 		sdd->sg = NULL;
 		free_percpu(sdd->sgc);
@@ -2386,6 +2377,42 @@ static void __sdt_free(const struct cpumask *cpu_map)
 	}
 }
 
+static int __sds_alloc(struct s_data *d, const struct cpumask *cpu_map)
+{
+	int j;
+
+	d->sds = alloc_percpu(struct sched_domain_shared *);
+	if (!d->sds)
+		return -ENOMEM;
+
+	for_each_cpu(j, cpu_map) {
+		struct sched_domain_shared *sds;
+
+		sds = kzalloc_node(sizeof(struct sched_domain_shared),
+				GFP_KERNEL, cpu_to_node(j));
+		if (!sds)
+			return -ENOMEM;
+
+		*per_cpu_ptr(d->sds, j) = sds;
+	}
+
+	return 0;
+}
+
+static void __sds_free(struct s_data *d, const struct cpumask *cpu_map)
+{
+	int j;
+
+	if (!d->sds)
+		return;
+
+	for_each_cpu(j, cpu_map)
+		kfree(*per_cpu_ptr(d->sds, j));
+
+	free_percpu(d->sds);
+	d->sds = NULL;
+}
+
 static struct sched_domain *build_sched_domain(struct sched_domain_topology_level *tl,
 		const struct cpumask *cpu_map, struct sched_domain_attr *attr,
 		struct sched_domain *child, int cpu)
@@ -2537,8 +2564,19 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		unsigned int imb_span = 1;
 
 		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
+			struct sched_domain *parent = sd->parent;
 			struct sched_domain *child = sd->child;
 
+			/* Attach sd->shared to the topmost SD_SHARE_LLC domain. */
+			if ((sd->flags & SD_SHARE_LLC) &&
+			    (!parent || !(parent->flags & SD_SHARE_LLC))) {
+				int llc_id = cpumask_first(sched_domain_span(sd));
+
+				sd->shared = *per_cpu_ptr(d.sds, llc_id);
+				atomic_set(&sd->shared->nr_busy_cpus, sd->span_weight);
+				atomic_inc(&sd->shared->ref);
+			}
+
 			if (!(sd->flags & SD_SHARE_LLC) && child &&
 			    (child->flags & SD_SHARE_LLC)) {
 				struct sched_domain __rcu *top_p;
@@ -2591,6 +2629,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		if (!cpumask_test_cpu(i, cpu_map))
 			continue;
 
+		if (atomic_read(&(*per_cpu_ptr(d.sds, i))->ref))
+			*per_cpu_ptr(d.sds, i) = NULL;
+
 		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
 			claim_allocations(i, sd);
 			init_sched_groups_capacity(i, sd);
-- 
2.34.1


