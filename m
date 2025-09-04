Return-Path: <linux-kernel+bounces-799870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A30B4310E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD159487793
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811CC1F1313;
	Thu,  4 Sep 2025 04:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GGx92Cln"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE081DED4C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959635; cv=fail; b=KeuOEjASPvYydWwdF2DQhKWKbDvfq6UnuaVzrs0mX/3sthX5I/abyMBQOPyNjdNxo2uCa/Q36sO7BKYeZCqfU9Hg3IalrvwIwjTHDpvbwCJYcQWQSfC/rTLYGacZlH+fepy3B7jLS5mzCo6sP3PW+Yi6uuBUV9ikC3EhDveVj0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959635; c=relaxed/simple;
	bh=F3E3zYBbHyopIXwqIxcJek4bfuJ7LiBQO4n/7nIjFdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcJ+3wlMxirOk7M2kktqxAQnRNemK34jv1+xbgkw+MG9S7DXfkfZOFFZCy8KMPaQZgGCf4jqKWQSTd6Dc7paw5bjCNtxXzjiP0pOh89+CMBUDpiRfB2zC90PydfcMDDgOFYEHih17vCb2BhhLX+7z7geCemgVdadg7L5oW0OTXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GGx92Cln; arc=fail smtp.client-ip=40.107.100.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpQG77PaqLcA5N8lvC2T+VxPXnzgMd22FGBOd1IgDkUsdy8BA1taXFVTs/quiKj8hFffOC/5mslM94vqXvOaAMJTjcy+wqK+CZD/fX1+n2dCLLe/418/kvlAG181JydBc+RJ9r+F9YYw04EgHUGM0m4VLxJW7qNFgSFW79yvxIcv8G86smfWVBrvsq4xsk8fkSLyimo3/Y9mEuwncVru7IoNOK0qbfVzu+wO8/7LYcQlZauexUfwAlQEhUOkyaOQAjsaw+lKsSoBkvN1mAJTyTBZ2HKRuJ6N2cux15o8jHUlCuj4KJmygGRjiYhNJCMhsKKcEeBe0j3TL2gpBoATug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YoPxriIVapTGkqMB7FGQ9QL2f5SA2AMi4KllrwrYZc=;
 b=TQTA+XF0OQW+WtxVByYqtxuczrh5+m50q+Gl07ysieiG9c1LqtdWWzXhcHOQoretZf5UUykHTkx1aJXi9zcCl+Qxc3rxZ2z4pgtp0SZqJCvkzwqomOFxlMSR4AI9ssKOOjSo45IYJUUTqfsPGeQpUuFLMgo7wIZkjM/6/lT77QWhFh7gOA2uHGWqnhucMEhyP95GrICT9oAb6VHcTjEvWF7BvBoDLwdbL7i91GX0EAE8a9t4WOudyYZHn5XjqA06nFoxnIh0XEVK1CMVSvo1S6Oz7jiFAOH6YT9oz3wUTHGwFZK5rriS3EUOxZDr5cUVPrh1nTk57cGeY7R0oLzjIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YoPxriIVapTGkqMB7FGQ9QL2f5SA2AMi4KllrwrYZc=;
 b=GGx92ClnJNpz5vi4QwXZH8ewgoz5wiZda1pFhv6ZEJNkjhzpAipRo+PwqCOQJ4cqYNjCQoUryMf4hpPB7Hakk3BGjxRvmbaASLK+GzrKoG+uxsUyJw8VjmFSnloHcpBabv521CcsBq53GOwXWEM3bB1mWTh2SEEmCUPcr3H8ZBY=
Received: from BN1PR14CA0027.namprd14.prod.outlook.com (2603:10b6:408:e3::32)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 04:20:27 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::51) by BN1PR14CA0027.outlook.office365.com
 (2603:10b6:408:e3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Thu,
 4 Sep 2025 04:20:27 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:20:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:20:24 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:20:20 -0700
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
Subject: [RFC PATCH 16/19] sched/fair: Convert sched_balance_nohz_idle() to use nohz_shared_list
Date: Thu, 4 Sep 2025 04:15:12 +0000
Message-ID: <20250904041516.3046-17-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c34108-41e9-4754-699d-08ddeb6a5fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w86NuQ/cutBXzR4nOZZEhUXgDgZfduaghkzEw9XEQWWP8xHJdJMAcE1mcW61?=
 =?us-ascii?Q?FMw+zu2+LCmDAOEGcIGv0g4vT66QerJ4kgTxXLYaN3bjudmgtHSlw3RNOjYu?=
 =?us-ascii?Q?0H+mZPCzAcSvb8CV5t3ZA9pn430+p03zyyIFlsCaTYK4fh+7vwQ1oKeAae+e?=
 =?us-ascii?Q?0NQ2Psw062UTFFL+ZuXG5k30N7kelesYLgcIfEs/mqfD0DxyKNUlEh3SRlLr?=
 =?us-ascii?Q?Fks+nVlYE3cHJCGWeFAhTsyPQO9soIibyuZhnw+34H3jpKXQbTMWa3Tyzjn2?=
 =?us-ascii?Q?L7oRqn4CRYJGBUolouuTL1QR/1aGE9D1CAPU8h7wdy2iLH3TuQRwOqrTDd6E?=
 =?us-ascii?Q?8u0DRxKKiSeVgrkIZFrNGqM1jMZc9kD1cFGzIg46/2S+T/S+bV3tLefyadAr?=
 =?us-ascii?Q?nMGITvd5sxeoOE3PtPrwrqFABtDwuxwRrK+FRoCoPngrNSigASgwUNRqkXp5?=
 =?us-ascii?Q?CiL1g7nwt1K7qMpDkkWb80QlJrxFm0vpVdG3sSAC/4VI5y7EEFDZuQVbDlt8?=
 =?us-ascii?Q?eSs3SZTZRGWWFSVVhE65l7W7L93KRwv30/hHtiwo1NYyYqqIEDXgOf5hDHwh?=
 =?us-ascii?Q?Ex6kkliK6vEt/uJIzvQhXVgxjwNobnLuZTJHRZh9uIHvBY5422kvs6QCjcnk?=
 =?us-ascii?Q?DKMV+sKg+PWqjKXBvcX0vGnZDaYKqcBLJ8grNRlkkMtPtvthhZ1oPFtc3S3s?=
 =?us-ascii?Q?LrUhiDPMq1QrgsaWQq/28hyU8VDem+pw5nUiB1C3iCsJDprLO8eXlWU4HkVC?=
 =?us-ascii?Q?KOrBzgEV7eI7HVTmiJcaj434roYbyCu0/BQi1W5IGfzEUxJTuklyUebHIrko?=
 =?us-ascii?Q?5YD/6jW0mv2h39BVNEkqd8RIYu7tCxZ11jHqvsEYjCgutP523VrC/5eGw4qM?=
 =?us-ascii?Q?I5x7IWJb/VvbPcuOWn3OG7e5emzWy+mikV2xeRRrQ8xm3e4AMjG6/C/9CU3J?=
 =?us-ascii?Q?HNWe4IDsBqqRr53roIsX9rbrOez0d/XiohjvHrckDRpha2cYHQYAK6hU9P8S?=
 =?us-ascii?Q?XOiv5JmtyE4Et2zlX5No/N03jKUhwKoBiMPotWcKIIcI/3DsCI5W2EZxoZCo?=
 =?us-ascii?Q?7xHEXgHp5blh4Gu5A8oUlt2fJ1Sx0zmUcw35ZS4FaC8qyG72WQ+3r96pU8Z3?=
 =?us-ascii?Q?h9P7HAH5b+P3R0ejfbDS8/GCbDINGBVN705soglFMuSUu7LX4V3IZDtDhQku?=
 =?us-ascii?Q?2/HWZ3xjKnHHhTETv97gb8N/muIqGfB9S8Blcot/8Ef8l+6RHrYcUq91N7Wt?=
 =?us-ascii?Q?hISRvchwqyLrq27fDSZBO72LxPsqB1sBxvxKbSVIerOIT9cjwutRmd8Kgd1E?=
 =?us-ascii?Q?J1x92JrnRTP7TOoFr6XpoVNtEhcZV2qFV/DBmF9j4MmFauhI/9VG23MC1FwF?=
 =?us-ascii?Q?uF3AQXvdyIcDuscYvIPh8siIGif6osTo2opMusn3Ez0FbU5zxzfCI7ioqHDq?=
 =?us-ascii?Q?nkxYBxuBAhnTzZdcuI0cSOpL8toqiwFl2UD/wSqVN1GLgx2Zd+jJzzNIAS7L?=
 =?us-ascii?Q?EbzDnWKiJSOU/fyHFkqAHz6fkjLSj/tIuxi3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:20:26.4229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c34108-41e9-4754-699d-08ddeb6a5fe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619

Convert the main nohz idle load balancing loop in
sched_balance_nohz_idle() to use the distributed nohz idle tracking
mechanism via "nohz_shared_list".

The nifty trick to balance the nohz owner at the very end using
for_each_cpu_wrap() is lost during this transition. Special care is
taken to ensure nohz.{needs_update,has_blocked} are set correctly for a
reattempt if the balance_cpu turns bust towards the end of nohz
balancing preserving the current behavior.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 62 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d309cb73d428..c7ac8e7094ed 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12685,27 +12685,59 @@ static int sched_balance_nohz_idle(int balancing_cpu, unsigned int flags, unsign
 {
 	/* Earliest time when we have to do rebalance again */
 	unsigned long next_balance = start + 60*HZ;
+	struct sched_domain_shared *sds;
 	unsigned int update_flags = 0;
-	int target_cpu;
 
-	/*
-	 * Start with the next CPU after the balancing CPU so we will end with
-	 * balancing CPU and let a chance for other idle cpu to pull load.
-	 */
-	for_each_cpu_wrap(target_cpu, nohz.idle_cpus_mask, balancing_cpu + 1) {
-		if (!idle_cpu(target_cpu))
+	rcu_read_lock();
+	list_for_each_entry_rcu(sds, &nohz_shared_list, nohz_list_node) {
+		int target_cpu;
+
+		/* No idle CPUs in this domain */
+		if (!atomic_read(&sds->nr_idle_cpus))
 			continue;
 
-		/*
-		 * If balancing CPU gets work to do, stop the load balancing
-		 * work being done for other CPUs. Next load balancing owner
-		 * will pick it up.
-		 */
-		if (!idle_cpu(balancing_cpu) && need_resched())
-			return -EBUSY;
+		for_each_cpu(target_cpu, sds->idle_cpus_mask) {
+			/* Deal with the balancing CPU at the end. */
+			if (balancing_cpu == target_cpu)
+				continue;
+
+			if (!idle_cpu(target_cpu))
+				continue;
 
-		update_flags |= sched_balance_idle_rq(cpu_rq(target_cpu), flags, &next_balance);
+			/*
+			 * If balancing CPU gets work to do, stop the load balancing
+			 * work being done for other CPUs. Next load balancing owner
+			 * will pick it up.
+			 */
+			if (!idle_cpu(balancing_cpu) && need_resched()) {
+				rcu_read_unlock();
+				return -EBUSY;
+			}
+
+			update_flags |= sched_balance_idle_rq(cpu_rq(target_cpu),
+						flags, &next_balance);
+		}
 	}
+	rcu_read_unlock();
+
+	/*
+	 * If we reach here, all CPUs have been balance and it is time
+	 * to balance the balancing_cpu.
+	 *
+	 * If coincidentally the balancing CPU turns busy at this point
+	 * and is the only nohz idle CPU, we still need to set
+	 * nohz.{needs_update,has_blocked} since the CPU can transition
+	 * back to nohz idle before the tick hits.
+	 *
+	 * In the above case, rq->nohz_tick_stopped is never cleared and
+	 * nohz_balance_enter_idle() skips setting nohz.has_blocked.
+	 * Return -EBUSY instructing the caller to reset the nohz
+	 * signals allowing a reattempt.
+	 */
+	if (!idle_cpu(balancing_cpu) && need_resched())
+		return -EBUSY;
+
+	update_flags |= sched_balance_idle_rq(cpu_rq(balancing_cpu), flags, &next_balance);
 
 	/*
 	 * next_balance will be updated only when there is a need.
-- 
2.34.1


