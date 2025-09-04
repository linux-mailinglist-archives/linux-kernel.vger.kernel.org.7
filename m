Return-Path: <linux-kernel+bounces-799866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C5FB4310A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540BC4853D2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ED41F1313;
	Thu,  4 Sep 2025 04:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U5mkfzaL"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3246084039
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959561; cv=fail; b=Zjunqlex8opYshYCKBFAO+zxRdwkn1XqK5vz/6Bn8NRYl8emvAPVT/SYkPsOgCbSIJb9sNcvgKqwUpOORlD3ZF5ih3wR+NqOrZYY0DPGVQoUmFprLrDu7KuX0mDxLekiUxAUy8mh0h9DvbqrZd8b4XNaeBgsrFYNVqhPhRzu6go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959561; c=relaxed/simple;
	bh=UbqNP7yzxxuzDE2T8HMFDkKIIvDtIBhspd5b+NsRs/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uj90DQGYTqMaxCw/brcY0kjsQ1m+CvsOPufmCjy4DvDX3ILmAfxeoXHx4LeFyYxizXVgRqPLOO23JAh0SzsrFY18GCpL7nH3fF2tDse3X/tR3QkcxE1cpK3seJzOJJ1eKzNWOeUscXUb9zTWQEG/N90tB1VByik5Hgd/UEuxwzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U5mkfzaL; arc=fail smtp.client-ip=40.107.212.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIjZN1lJcR273b5RnA+OpNiCC9gx29FbYZmUTK4Mew/8pVjVbjRaeO+o1IZ+i2zV1FoS0+q1MSCVqcChXk1+TXL7wIkJJbS9bl71BXN3D4gAzZP90ELoXrj1y49P5+rATey0h1i8PMee44uNvTZUWB6AtV6T1wYRYBbog71wyRTNI1OZmtdZSGAZrLxqb9hlijgIP1heTH/UlrADhRykzKZKE/WHj0+Ehjq6ANsXW5dqKt8O0hRABec2HK6LuJBkRq0YHo186aPqCouZZA+FqeIxl+4KjhW/q/Kw0rplhL+QiMsFc0MYJ9ChjRteaFQZkKQ2/kxcQN+TKpF+TRsfEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzBm82KMAqIwzEzZLuqU9WZuysTXUdwisIWz+YG+CYg=;
 b=OnbKv9j1ra7Y63smaPZbCRtqhERL/DUXaIKZQGuxVvJMr0JDr6ZXFIhfMuVCrXAm7jPV3uPTVQhUzYTVgGW+A7zWiZcnjYrfs/w3F5vrPC2+oY9XqN0bqmOeWRXCEmTnrSeRKLK89kFi4xeQXRjOlGQVaMNlA6Bc7W5oFHlW+l0lfVcRMZe38SLskxJnLQW35v4dvxt99v3/EtjmN2gI9PTrqH5QEiKuUDOvGb70/JKwHaXjqQj2HBZZ3kfv/pq6nKtlgn8uLj64uGryHsJRKgiJzcTtcKWKdcQIsH8uEti7MO4gyWWv37dfFG0ZL7AN2Os9OJpaZN0IfecgP2qW2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzBm82KMAqIwzEzZLuqU9WZuysTXUdwisIWz+YG+CYg=;
 b=U5mkfzaLEZffYQEmvYKhkMQPxuTl1efsK6qaW8ZwPRpR4ysXgLXeDYFuXYcOfSdAEmnzy46s0dTFyYxDLQqL+G8gV0VWdlT958anqLcnDoFwM53P+UhWxro7UFOcmwTQWJ0BovDP+MjgwhX78HE0KFpK8AZ9y1F7HIhfAk9oHsE=
Received: from DS7PR03CA0260.namprd03.prod.outlook.com (2603:10b6:5:3b3::25)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 4 Sep
 2025 04:19:13 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::27) by DS7PR03CA0260.outlook.office365.com
 (2603:10b6:5:3b3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Thu,
 4 Sep 2025 04:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:19:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:19:10 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:19:06 -0700
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
Subject: [RFC PATCH 12/19] sched/fair: Reorder the barrier in nohz_balance_enter_idle()
Date: Thu, 4 Sep 2025 04:15:08 +0000
Message-ID: <20250904041516.3046-13-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: e8fa31cd-6fa6-429a-c12a-08ddeb6a3403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vsdjT5snjYEg+jL4k88Q19uzwFWiru0JDIA+l7XqVv13JOS731oaFRMHSuuA?=
 =?us-ascii?Q?UMhF6lmcua8eo2PFerMmgdt25M2ctg/OGnDYRdBoG09o1SrS6LTMOCu4GEqA?=
 =?us-ascii?Q?AUVxbugvXiQMDX8L60t33ixAh3fPs4QhQrs+jS539jYX31vEbmIA1iDhoWFq?=
 =?us-ascii?Q?hT6umqTTytpgZulJqUNSLB3eGa462y0rh3FZP3SaoY8edukGa99aC9scF/j0?=
 =?us-ascii?Q?s0xmT65EjfuX2AA2dgj3oIEtYoLSjU4k9fIKvDGbq6AEKj/Bad3Ntgg6nEa4?=
 =?us-ascii?Q?ngxMVSuCpBBMiGJdwQNQ7JlHEbZ9cgMhxV6+s+qHQ+B6ZU8mCtn0k6zgsqnt?=
 =?us-ascii?Q?IhP7xF5EyRQFa/KXsmAb0mYbd3Nq6PbbsBTRqKXOWqpIRnEuRSxvU5Fn4k3n?=
 =?us-ascii?Q?1eE011iNQAsDF5vq0y+9fCyO/JEdFF9ePD/UNRyXJdMlHSCHUj9Am2Ig7DHu?=
 =?us-ascii?Q?GBzoQPRn/R9CJPA/m2nnMz1QNxOpfbv+oMU8EWeRcK6Y+eOFNSHqw+/cwgbf?=
 =?us-ascii?Q?80L4siUDyyEsyfM8fJTQc/LmsPSDBJpddkNObzvDCrxwDkWQV6MMvpshSLMb?=
 =?us-ascii?Q?ZGiUQGxth34HyUQBi/eJvav1wLEt/O4Xo2l0IKAvewU+crHxhiIg7jjJmQ8r?=
 =?us-ascii?Q?HfOyTqsQLTMXIld/C5AfQTiBKHyInQZII51oz8ETY/BpUg4XxamwOoF3w5Xr?=
 =?us-ascii?Q?m5VV6At0iVFP2lCPh1549oJuZLiRCi/dh0lFWKmF0RVFcDRyaAxMgi5ryXUp?=
 =?us-ascii?Q?va2IH7D6SSdNfK4hv90szcdd36p4GfR1hyM/pZnjaEGQCjDwVNtwxMh61IJM?=
 =?us-ascii?Q?cxh41/dfdEr6OHIG1jlMUAgKiHmTAj8w69veKeXrRMsmWYdems1nPxxr96uK?=
 =?us-ascii?Q?niK7sT5J3/m1mwIj05StOUr7zXizpKYscp6wNHI1Bag3BBehxdUZmWbev/gp?=
 =?us-ascii?Q?Vco9Ouw8fX+AY1tG0kOcbv4cA23FHSdC5xsTqsOu5QoOekMPUdKxqfFqykmn?=
 =?us-ascii?Q?24ZJyNNcq99kfXnLJyTfz8RNMKMa1X9ltBfe79gIQmXaC/kH4TpJ2caaiJ0L?=
 =?us-ascii?Q?I7/bbyRBOzOnpXrUajpQV0zR5M78UpNUQeP9Xy//CIlvyFTf7rqhvnBPT709?=
 =?us-ascii?Q?yH7a8qhP1c04Qca+VYaG/shP+XQFqg8/SpXCxMEOr+Vq6wV6afvWhZmp0HUY?=
 =?us-ascii?Q?JEXMJXScTC4Pzm34BDvvC0zh/XV8P6Lx36WG+jPbHMBgKhUf0HeJDAX9HAmw?=
 =?us-ascii?Q?30PAlLKEKskHkV1LC05p1WSsdQ/214lBgCl3Z3NksuhrGWhWOvrLDd+T+fx4?=
 =?us-ascii?Q?nQp00aivX7c19jhri4GaZbVlnXxSyJeLlbRSD31HhhKzEl7F+G6Lxms3iBuT?=
 =?us-ascii?Q?rpctvQ32lrQL42RosBNzvaTOX+0k4pjiPrsIOfG9vQ75Rf0sJ2yEfItDH374?=
 =?us-ascii?Q?BF/PPJbQfYILosKuHBGPsjvN6f1D22S/Yodrl2MjLv6DIc/O10+kYdVfg4eV?=
 =?us-ascii?Q?h7YvzEyigdcW90l2zWcwnageaS2cdtXG4wKS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:19:12.7324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fa31cd-6fa6-429a-c12a-08ddeb6a3403
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431

The smp_mb__after_atomic() in nohz_balance_enter_idle() is used to order
the setting of the nohz idle CPU on the "nohz.idle_cpus_mask" with the
write to "nohz.needs_update" as per the comment.

Since set_cpu_sd_state_idle() is now responsible for idle tracking using
"sd_nohz->shared", reorder the call to set_cpu_sd_state_idle() to come
before the barrier ensuring the CPU is tracked on the idle mask before
the update to "nohz.needs_update" is observed.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c8226520758d..d13de6feb467 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12544,6 +12544,8 @@ void nohz_balance_enter_idle(int cpu)
 	cpumask_set_cpu(cpu, nohz.idle_cpus_mask);
 	atomic_inc(&nohz.nr_cpus);
 
+	set_cpu_sd_state_idle(cpu);
+
 	/*
 	 * Ensures that if nohz_idle_balance() fails to observe our
 	 * @idle_cpus_mask store, it must observe the @has_blocked
@@ -12551,8 +12553,6 @@ void nohz_balance_enter_idle(int cpu)
 	 */
 	smp_mb__after_atomic();
 
-	set_cpu_sd_state_idle(cpu);
-
 	WRITE_ONCE(nohz.needs_update, 1);
 out:
 	/*
-- 
2.34.1


