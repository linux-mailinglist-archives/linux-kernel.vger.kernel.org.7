Return-Path: <linux-kernel+bounces-799868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9C1B4310C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 731637A7560
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B241F2C45;
	Thu,  4 Sep 2025 04:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N+dH5AoI"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB21BC58
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959593; cv=fail; b=P7edYPDu3nkXCPMsQrOkwrALU6wwXcwm5tVmkb2hAHfc9VJtgrsP7RZidDFW2upJ/0iLXDDraufa/MXp/2a9Y4WpXHZM3rMacFed0Wgr3NZj92onH9ttRbYY8feCg87JjR44Wrfpp7lahJN4HGfayjOIqlK/vHyT9mW294YLQd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959593; c=relaxed/simple;
	bh=WqdP7UJjy009eMZBoQZNzqqvQDceWZ9gL3Ezc8E+4ko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmjr9OOOrG/5S+amJnN4Gt9/C+3SYLN6wWFmbROE7lmfj/JuS32/LTA1vjziousevLN/EmweTdxFJDhF7TKYpIm+/cMW7iMXCDHzqQ4Ud8AV6ogq/beuu02Bs0iyXbyDjm95tL2CTR0AasU1pVqVF1HJmLnwVut7eVyaMOzn2tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N+dH5AoI; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4QhUsbmet9W2iT2I+x6DFdJFhGFgcWauQTBy/YyzSn/GoeRSAKcgiveU32VULg/VocDUEAj3XxGZgpXLXpR+gVoLdq19RxHNJpnjsfz6ksGO2DdGKPox/YxHMS4rRWPI0Hz29C0YE5RXzTDGZZvRsdY2PyZHOw984SaNWc2mxfZ6esL4OxdKyxATBIQBiafaRglLmryeXgLtUh6zNbcdQkmufMOnQQ5n6yEIJdVKEYGv1E4mICNM9BBWZv9hSDqJvlp1Igdb72PNh0URKr5xEPlGONAcxOk+ealUAdpwGAU0DJwXiunuALh78IbKCd/0t0Ckk4/vGBkJfn6GjIO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LKqP2qbbpTwvj2ay+7dEWLveJOHWMQlyYSE1RzOPic=;
 b=uyqkzUoNzk7czIFey9Njg46K4MpWZgsLR74AehGV4yDdWOsWaXlLiAta6vvKkxeDVs5M8x+hpidloAOENl9Ldmssn5s+CZJr6z5GyaffixVO1pWbQ1uc6AhKNU4J73pA6zqT0x/ozddk4tASZ1UXvRRSaAwWBopORhdgJTy4Fs6zkjsUrsj8KuIHt9aqcq+oPgT5D7zx7E0kXnJurPRbfZ8iFkOi9pqquBXWsSyI8lQB/l4GBczTjUJYGiFh0OCAYUyczbY4fNtiLC8Ham3fBbPdszCSjPdy1H/4vk6kQecKc8C+cy1raRd7yZn0fHxVQGpmQWisqS0VzF+1hQF/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LKqP2qbbpTwvj2ay+7dEWLveJOHWMQlyYSE1RzOPic=;
 b=N+dH5AoIs4NVCrjvVdS5EPNnmKIbQ0AIuk0hsDdNGH6mWU5MkdNR6bU7E8MGipB99Ta1mco8uscriRutRn3AyoiWIKcOKUO4gk2sSUWxaBs6KSiXt416QFDcfgofODFQ9dwPKgL/jxj9wuX/6UdZLxMuOb0TGNTdtT9+TVtaQAM=
Received: from SN7PR04CA0212.namprd04.prod.outlook.com (2603:10b6:806:127::7)
 by DS0PR12MB8044.namprd12.prod.outlook.com (2603:10b6:8:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Thu, 4 Sep
 2025 04:19:46 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::4c) by SN7PR04CA0212.outlook.office365.com
 (2603:10b6:806:127::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 04:19:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:19:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:19:45 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:19:40 -0700
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
Subject: [RFC PATCH 14/19] sched/fair: Convert find_new_ilb() to use nohz_shared_list
Date: Thu, 4 Sep 2025 04:15:10 +0000
Message-ID: <20250904041516.3046-15-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DS0PR12MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 506b5b1a-5b19-414f-4971-08ddeb6a47b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z2YNYiQe/a8nFVucLrCEdxtB4N6ZMI+RRIRV2QklQ52wRgS+H7t7BfuW6j1c?=
 =?us-ascii?Q?eWHvjFxZ7tN3961wtIAGuU8dJew6pa/SEu2I1oABreMInCr41cD7S1CrJrzO?=
 =?us-ascii?Q?fyxZEw3yaKteRBl94k4FnSAyjypPZNyROcHAoDaEymFMQMRO7cms2fWbz461?=
 =?us-ascii?Q?CgOsuQ778OYrLgJgL53wF7K3tW377vMulsyQBN+dylLSgQ+yPAZ100fq6BOY?=
 =?us-ascii?Q?QfkTiHYAuLu+u4QK/IBZqshMuOQRzykCxjZli4eH4KiQTmBOcsFZeWqKJGFu?=
 =?us-ascii?Q?6qUC20IBSZPhfV4gFzz1tQh6jWdT5CGO79EFNq0H67cUDtpfifH97SO3EuqF?=
 =?us-ascii?Q?uwB6gtqciZyH8/b1Vd5njPj26wwslkslO62Xa74LsZb/ZIzac0rRqEHvO1+9?=
 =?us-ascii?Q?yxSc6P0XqazIa41dL58taKBR5PDroMy6tAx/dwnWgKMwJIjxcmhsxOYIyhvV?=
 =?us-ascii?Q?X9NpHA+3LnpNTh7OYmCo2Q223rbq78VLFG4JYXhJEyJfITY+r//OCNfE0QVR?=
 =?us-ascii?Q?pJsFn5nA5hWVtzb6Ky//159W1pBCJMoUibPeK34LEDxHs2bIR9hBwEQgBfk5?=
 =?us-ascii?Q?aTovEZYNnL2ubkJuLGD2DN8ZJ3D14SMs5iBciP/CrMv0TLxHWJw0zG9FAEZC?=
 =?us-ascii?Q?V1JnuN+NV3GkC46A8Wek186Rzvrd1sjGfIA76aM8JG0MePxQZOB5d8JyTRhk?=
 =?us-ascii?Q?Vq5nSGnXclBACUtINtlbA0y/hMWGa3QFgrH1+egXJofn0foHANhvDdU1Je37?=
 =?us-ascii?Q?VER9NNR0wT6dr8b2miEIjDFLekGA1Owet9uIuBU5864+gpdnKXiTiQvlu3ZS?=
 =?us-ascii?Q?d4Cs1dUFMzStMzkR7cgQUbdt4h7r96NdLMC0MlQMyZgjFFrr5wwolcsWSmM+?=
 =?us-ascii?Q?6A59Yfv1qt6/4y56XiccemTT38wvGborPmEgRNNzpKfhehpM7iazib5MfUnC?=
 =?us-ascii?Q?x035nRrqLJh1Xkt5rMIGNEn/V5IcEmnIP8neq+z0RJJ8lFZptT1VH7O1gCMf?=
 =?us-ascii?Q?VaY1UXXWF9UPPD2vLs6cMqZ6Te5drrv4y59ECezo0rUK0QSxNnZmAIfLv1q1?=
 =?us-ascii?Q?zMT7IDYZcZiwKYqAtvQEjNdFi1isSgUZ56Y6CZN76Ka480xY3J3djkwEk5Kq?=
 =?us-ascii?Q?fJI3JTvcIYcPOH8iyXt7rTNPS90fcKoAX4nxjI75BnNe49s2NJyAwvG5eH77?=
 =?us-ascii?Q?D1dkfR6zzChS2VM5n91d1NuShYcdFN8yEn8RiOvkkiRda4WBWHHFQp/T6Chd?=
 =?us-ascii?Q?q16buUMgulLY/i2aoUbCJiTFytiufO50sfHad31qA5itI5drun1uhARjco4d?=
 =?us-ascii?Q?u0xNMjBI90Xipqp26rL+cf8fHBjuFd89tDmrwGD4kYEuP/N0IvazeqOVRKyA?=
 =?us-ascii?Q?rDKObZ/rOkKMxtGj4DU778NvGSji3tMxnjVKuwP/ikOF8mmwkStfZWODQVFJ?=
 =?us-ascii?Q?tFrMp4rS8wlLyWdDa6I4oXAjTyrLTrIFUah5LrmWFpdcOhhxpqZJxcU7Kk5V?=
 =?us-ascii?Q?Z5+zqQBv73V+L+I4swM+YDjLCcG4wkMwkks7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:19:45.7959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 506b5b1a-5b19-414f-4971-08ddeb6a47b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8044

Use "nohz_shared_list" in find_new_ilb() instead of the global
"nohz.idle_cpus_mask".

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ad6e97be97d5..5e7198078d19 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12263,18 +12263,27 @@ static inline int on_null_domain(struct rq *rq)
  */
 static inline int find_new_ilb(void)
 {
+	struct sched_domain_shared *sds;
 	const struct cpumask *hk_mask;
-	int ilb_cpu;
 
 	hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
 
-	for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
+	guard(rcu)();
+
+	list_for_each_entry_rcu(sds, &nohz_shared_list, nohz_list_node) {
+		int ilb_cpu;
 
-		if (ilb_cpu == smp_processor_id())
+		/* No idle CPUs in this domain */
+		if (!atomic_read(&sds->nr_idle_cpus))
 			continue;
 
-		if (idle_cpu(ilb_cpu))
-			return ilb_cpu;
+		for_each_cpu_and(ilb_cpu, sds->idle_cpus_mask, hk_mask) {
+			if (ilb_cpu == smp_processor_id())
+				continue;
+
+			if (idle_cpu(ilb_cpu))
+				return ilb_cpu;
+		}
 	}
 
 	return -1;
-- 
2.34.1


