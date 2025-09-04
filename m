Return-Path: <linux-kernel+bounces-799855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 590B6B430FD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBDA58185E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E1D1C84B9;
	Thu,  4 Sep 2025 04:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UJdplAaJ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8F11CEAC2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959359; cv=fail; b=cawdTlifYWoPfvafDahtceeELXdfWZ4aXu3VXHNz+DmbSIP0X4kICvezlH5F3uTgWRcvsXy06yNQAz4nAXIGf5e7bMm67mQIpw0R8WId/EvNnBW6i2SvSZkNr7Suk8MpPxP4uNDqZsBdf4A81/2Vli1/Gn3GKS+vAyttPfc6F2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959359; c=relaxed/simple;
	bh=lVd/Q0UzB5u+uCv1OfF+NpEYbjWt9DS1IhGsvc+i5cA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OG28TtpMcHXzMnrOWY1VELoojgJulaEFhtKbbDk/SXtvJKrVeI9eKVoiJ3lG+ZjLLRF6mK/8Ka9nuhTQWzUWg3hxmOvRHEeAxel2kmBNKDqVemTUM7wGOojWAlDX3wxA9D0fxPqKWzvjzNIO+qVbGZc8JJf1hnEYgJfhvJ3APXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UJdplAaJ; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDW/vclnPNv5P3RCUfwnxqnAuB/f0tX8hziOCs/qp39++SIcalpvJ4JklSwkxgLmhsZDe739DKG4qfmmDJ+XU1s6kgXXLj+FALh5OvroIUvmJ95r/qS3OTKatqqyYVbB5l/wCydcxPOzvjXvtcG8nObRaN1yPmXAPuWuREKXyJkvLbRAKCkaDb4G9WAGcx+rVnFVORGkcnJMUw7ZgnrRk9S+pIzdF+qBRisfllHJDZ5AxiSXrfKXpXAK9gRlyAqoSCOUB0bOpinojb9kCU/9TJYVyXy/U+quSfXLxXPffqEu8TxJAIP5F1Vz0NhNoQMU8nRvEzmXDZC1L1s/Ht0dYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDw1dWtOCM7UJwk1ahY7d7+pDXERIyhgrIaZuD8fGC8=;
 b=nxliWrg/D5AFNsDAlwLK1rHjpb9rcw0Dvg+9mOE6C2IL1dB/D2Mu9gC+SzCy7TLND1bgqtpwNOxiXfifw42YvN4W0fMUjZdln/fNV0r7T7k+X+P5of3s6bnFfHa3Bp+OOTFM0rUYETTewfWzui3dVV8S4zQfDe87JsvX2DkHvlgBzbmUJDyMAUGlXCRaAjOye2rgsIClQgy83vW4XErEBPhyEycMbJWJV2giDlFcs9PHmCLTDFfphi/2B5l+9B6NW0zh/+iAEH+JV0hiEaOsVSZTL8C3B2GaBBkJoRP9Nx3X1lXKf0k9iUUE0J/0BMY402tAwFfxFNsvC9PupLgPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDw1dWtOCM7UJwk1ahY7d7+pDXERIyhgrIaZuD8fGC8=;
 b=UJdplAaJLledK7QULYGRRj0Bhfg05N6n/2LvMSlxTrzmHV+QGVAKoJTmCaxCRBAGHlvX5khQVTjsucceWSBhnsO5MFwXSHLNcAkBowq46LhD7mLuDCc7fx4IzruoQoSbTJ5jUSiWqUxkFnWVtYuzBjO2clwCGwylfWMkX0vMj4g=
Received: from SA0PR11CA0144.namprd11.prod.outlook.com (2603:10b6:806:131::29)
 by SA1PR12MB9472.namprd12.prod.outlook.com (2603:10b6:806:45b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 04:15:51 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:131:cafe::a8) by SA0PR11CA0144.outlook.office365.com
 (2603:10b6:806:131::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 04:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:15:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:15:51 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:15:46 -0700
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
Subject: [RFC PATCH 01/19] sched/fair: Simplify set_cpu_sd_state_*() with guards
Date: Thu, 4 Sep 2025 04:14:57 +0000
Message-ID: <20250904041516.3046-2-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SA1PR12MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: ca12334e-5a69-4c80-939f-08ddeb69bc18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F0v6tci659NoL1CglMBFye4twJGKfxkNBrwyu9qzCh7trZKbmARP+2SitiWC?=
 =?us-ascii?Q?gR7GOEDSn1NyAaSudIcyu3ReBJ3IaHvGpwaXWwyAD0it0VeBLkIdQwEl7yuk?=
 =?us-ascii?Q?t1lQx6OR9cncEHEJe8t9wLDfmWXsHtjB6R2WTdenywVIcU6CQvn9K5xJfJMq?=
 =?us-ascii?Q?q9RJZis6nnXUasVPJw9rtWw1n0VK6uxeTSboL4qd7SWyT/tTmesX0MyZEs/H?=
 =?us-ascii?Q?bDgVO3pDkMbjhryAIFfhp2mGKxUvTsbp+Su05L8tpsOZpSxPmFL9/X6PKv9a?=
 =?us-ascii?Q?sxogRHySyRwj34hjBTX6SfncNLQriX8YKCFtchcXtntG8Uc5+krqXDP7Qf2o?=
 =?us-ascii?Q?I0L44Ny9Wu2KKsPluF4x8VKrFiEwwzZEwNNJ9wIy8t67x7Mgk+bf9eV09Hhl?=
 =?us-ascii?Q?y18g+qlFtHwR+LjTf0XuYMlMF/38ZzjXjc48zXAhfihJVJoQyPBsqbq7M+J7?=
 =?us-ascii?Q?SnpMVi1xhthXX9w30NYn1UJIu1w4WTqMyFfIg04/xxUtXUCssbI5i7INDCNB?=
 =?us-ascii?Q?lbmrhJH1tfDuhb1j/EK/M3Mbi9mjBC6TIYP3zj5Wi7OszI6zZBytEc9z/ja5?=
 =?us-ascii?Q?7frXdBY3qcZhWjNZ4ItV1bLFJnVOG0Z4d5xph/p+gX7hXsiDtO2TVukwP5Pd?=
 =?us-ascii?Q?SyBcGMDqMELyHtJzIn9qjfDoCMRNFwrBAo2qJQH6/AUQXFOPSPLLkUFzBflQ?=
 =?us-ascii?Q?lIH1QYyaMZcogQHd/8r1tWjHGu1lNkgAPkTrs/VN25kX4N2O0FO7nAA8Orbh?=
 =?us-ascii?Q?L4KJ7QKiosuDBAS23tyAKwOCRyWtBJyM08XvSIdo0tIhF/gnbsSE2pmYWbgT?=
 =?us-ascii?Q?61evkYE5Oi7aAGJgSvj8cNZBuW+ZXIRweClVu9dtyZAk8rLNjwgqa523sp/n?=
 =?us-ascii?Q?2C+58FLh/zD6ORsra9swWsWJ8Mggob6bcMUBB9NXivtbd+y1Q9Ew1BLrbTio?=
 =?us-ascii?Q?nSGTmszeZoQ68rSM+ftNjOIxtKM4OKfJMtwzfrhocJP6p2hqwGEad4TPPVn0?=
 =?us-ascii?Q?QioroSIWk6+uOJd4T5ekTXCF83/Xve6vZeccu214LM4CF7n2jSAUHQV033bi?=
 =?us-ascii?Q?LKKQ0PM73BrJANxCpGEp7wOsHeaIcE/3Nlho49U8kbL05T2g6XTZSvRKujcN?=
 =?us-ascii?Q?1XRXZpQ6kjo3kmsqDYlSvkmpdlqMyGT+oZ3ytA7cK8ObXPp9qUKsGky98hYw?=
 =?us-ascii?Q?E3FgUMXt3/rX4ZQx6wYGHc3KX7VJJkgJh/gAhL06fQQ+CPtUPGlgIcdP4LJs?=
 =?us-ascii?Q?gWcCCChXXORCeLcO8xmRphPWIp2OYvB0V4La+tS9BRJ+LZ0GD42eAKGv7Ycm?=
 =?us-ascii?Q?ytLZgMau9aB/z0+iVS+up5e1XdAbcxNIXeD9ENOTfzclKWpo6PCyckoFqt7d?=
 =?us-ascii?Q?YIaknozNPTUUUV2FXpQf/ZNaGMC7EXrWKEYTKEZGn4WnO4sYHlExsQsBvWkz?=
 =?us-ascii?Q?Gn+6lgrDBCdgxS2zL707QfsPHG2FGMnjs4dpATA/zg5ThCYAhZ7xapYIaAuO?=
 =?us-ascii?Q?bibLVshu106PEkyBrOK1hjxPva/+klK3kfAh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:15:51.5675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca12334e-5a69-4c80-939f-08ddeb69bc18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9472

Simplify set_cpu_sd_state_{busy,idle}() using guard(rcu).

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index df8dc389af8e..61b59fd75ced 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12449,16 +12449,14 @@ static void set_cpu_sd_state_busy(int cpu)
 {
 	struct sched_domain *sd;
 
-	rcu_read_lock();
-	sd = rcu_dereference(per_cpu(sd_llc, cpu));
+	guard(rcu)();
 
+	sd = rcu_dereference(per_cpu(sd_llc, cpu));
 	if (!sd || !sd->nohz_idle)
-		goto unlock;
-	sd->nohz_idle = 0;
+		return;
 
+	sd->nohz_idle = 0;
 	atomic_inc(&sd->shared->nr_busy_cpus);
-unlock:
-	rcu_read_unlock();
 }
 
 void nohz_balance_exit_idle(struct rq *rq)
@@ -12479,16 +12477,14 @@ static void set_cpu_sd_state_idle(int cpu)
 {
 	struct sched_domain *sd;
 
-	rcu_read_lock();
-	sd = rcu_dereference(per_cpu(sd_llc, cpu));
+	guard(rcu)();
 
+	sd = rcu_dereference(per_cpu(sd_llc, cpu));
 	if (!sd || sd->nohz_idle)
-		goto unlock;
-	sd->nohz_idle = 1;
+		return;
 
+	sd->nohz_idle = 1;
 	atomic_dec(&sd->shared->nr_busy_cpus);
-unlock:
-	rcu_read_unlock();
 }
 
 /*
-- 
2.34.1


