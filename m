Return-Path: <linux-kernel+bounces-799857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3F0B430FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2BE3B645E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9FA1E9919;
	Thu,  4 Sep 2025 04:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UDe/kQ4W"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730031A9F88
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959392; cv=fail; b=OXLBy3gq5UWPWLefF1Bt6vzLnUWOO/Hmbq+sJ047qZxJxW/e5w5eptvxkO34mejxOmsmoDP01dDjhiZjG/HoQFxPpaQc7N8enhTDueolAWwC8SsVebu/GFU2+cyVXnDX7X6ugjmb9pRJCH7fo48RcF5t9FMCmaanLqFcDSIueXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959392; c=relaxed/simple;
	bh=Qr1WRu9cKpi/2lsCmhnKlIDO48HzMf0bYugwkA84dPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikG/MgeQHHFrMmRvah0X3r8B2M00LBBDNCEhFMPrPtidYIiv67/VA7yy2BSllZX643X839/XipPSZudPOqa4cXEZwRy6PA1Mz2mXadkUbEnX6eipdXs3+wryUs18Mp0VI+tBGDmEUK6EMlJVgoPlyrMjSnbCj3HFrgbjuveM6rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UDe/kQ4W; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHD/QzSXF0mWMxu08Frwc8vZQOtFrriow5dYANVcWyskJNIJ7txm8ohOGox5qJBCnFIa9AZrAOG0XubSZ92qd1KyI/lPerWJ0GW6geXuMgWVcLCrOYUFX9RpbjRZKRM+BT7KTib2yzWcNMNZO4BWknAbm78iL0GkjIYA8BDyhOPotcpomC7nlQgZI4/rOSrf0rd6hsv1FbJ+xFV4plxthOZ+BVMGz/gw0uI1pcLwWDuXxrfDD+/MbzYUeEq/YUaioYCGIBRoJhOUryNKTq/F29XjkjuPzHbVTGvrsYDUKSCBKs/r14ZU7G5QKoIpjYolBQfl8xVwqAuvJEKyFShRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Li9NRlPeSt6+5NzF4+XuWwqei7SmM/TmdtydgazBA2k=;
 b=WTD2KZHqmqucrYNA1L0hW9lS7utKtF9u3akRxPA9afbaH0b7RjBu6l/93wAaiMeNpTd/Hs17PW47kCAhjIdQA6JOrnCh8foLpC/uCdlMOZOk2FtXEddCLCTkIbe3m1TSlfNVx9c2vZOzWAZYrbol2r2IZEXBpd82476UzDlMlwLT6+jrmgXaqW2g1FDVm+J5FfCkFXfrk8QZDoULlNa5imFQGYznxePBPkK9D47E2zbJI3qeVakFHWfRnVrYahpW679J/gO6Wo2qL7NdKVKSYGiLS7GcaisqUcwmM5Bun2o97qwyFuW7dAGmjDObNLdPZ58jpa9N/TfQrsulzNm9Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li9NRlPeSt6+5NzF4+XuWwqei7SmM/TmdtydgazBA2k=;
 b=UDe/kQ4WznmNQu1G8ffJpOJLvHw1oQKDMDK7PclZ6fbiVUj8/R5OnkVss+PGEKI8ZqU25bP7JtofydO8aWkBnRZDdOIEIO5VE/eW6v0s3QcOCd0rsve5HHHm49gIreDtM8RMTtT3l8oBPWQSCiLY44VHgM3pA2tKKIDQ8dfENbw=
Received: from DS7PR03CA0314.namprd03.prod.outlook.com (2603:10b6:8:2b::26) by
 DS5PPF8002542C7.namprd12.prod.outlook.com (2603:10b6:f:fc00::657) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 04:16:27 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::e1) by DS7PR03CA0314.outlook.office365.com
 (2603:10b6:8:2b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Thu,
 4 Sep 2025 04:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:16:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:16:25 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:16:21 -0700
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
Subject: [RFC PATCH 03/19] sched/fair: Use rq->nohz_tick_stopped in update_nohz_stats()
Date: Thu, 4 Sep 2025 04:14:59 +0000
Message-ID: <20250904041516.3046-4-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS5PPF8002542C7:EE_
X-MS-Office365-Filtering-Correlation-Id: f2072109-96ff-4545-052e-08ddeb69d11a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0NJ2Hi2jGJSoIKhqtB4/UMCKSjVwK/hAx4bhj1aLKpZSea0g26gBCp+rzEK/?=
 =?us-ascii?Q?cJLEO+/mRfYfXsBQFG4JCmwQz1QAK+9/64soshrOiJkU/kSodDt+aoeDGDg7?=
 =?us-ascii?Q?LLMcKVfiJ3fPRcNJuqxER5mCnQQEAaKFJOaG5MwpBO7Qe6z9cfzvFZxcQbgi?=
 =?us-ascii?Q?GTbexLRg1UcVMjsnPxue1EkGg+g/vcZGy+flVvk/9J//e0dGb6H5b7Ll43cB?=
 =?us-ascii?Q?1jHM2SaZEdJolJow5WMOb6nh6gI4UaIEpAeHtocIlNfc2Jto+EBtMRg/cUq4?=
 =?us-ascii?Q?gcmFc0vVPHJX5igBo3szAfUDlZWgHUP8jmBEP+xbZd1Kupn3M8JlnHJvdXlT?=
 =?us-ascii?Q?nlJqy0QEB8gGBizcuhBfblBHfY3Eo2VWu06XuGl0l7uJnzCZD9YIosy6JRhY?=
 =?us-ascii?Q?6g66eFlv/KT8lJxEMXRbzAkikxmF4AfPIuGGiPj7rUKvPBVIVHgtb5uP5uEZ?=
 =?us-ascii?Q?Cv+nBPjmuLMRoSTH7YSHq8iDGOIvqFP7JSNcJUL7QxhJb0bG5bqa5LYttdJB?=
 =?us-ascii?Q?W/5ozuAKEJsLcgeisNWOJiVA/gdUlDS06E1uM9PXxD+UhD0L3sWRxO+OA2sD?=
 =?us-ascii?Q?Br2e5gcAR6WjnG2x6XkXk7ZOSYETcddfrWclpxmLAYsBHL9vEHkhYHm0aBCh?=
 =?us-ascii?Q?zTuwx24bGz9DDWjLEAcbnEPI+/oCR5cOC5tcbuUaZcFb4uqLMZnPLEaT+qx8?=
 =?us-ascii?Q?Wh+QcpZe8IVhqO5P3356UCYmJ3RXjASPGAcLUvUC7F/lcYG3YlTX8Fcme3jr?=
 =?us-ascii?Q?NBnJO1oK7yT/nB+fqUJW20p7dBptIY95mT9dIekPsk2HZWsdyshP8GPBalWG?=
 =?us-ascii?Q?v/PoJixUb/lae+W2LeMHGWpthaweuVDveXKlC7EiJTdukJuecvUype1hfcCV?=
 =?us-ascii?Q?AT1R615ek7ZYLgBk44bdtLaSUc6QtLxlaTXKw0i+F8MhooFiU7nrxVTbgydw?=
 =?us-ascii?Q?XR/lW6xRXG1FV1YsF2RsTqwqrvgdxykAUlM/NfbpTjgi9MMFbVjgE9M7GPMn?=
 =?us-ascii?Q?laLmIYv00vCFb82k8mnqeHV+X1WXldDxEjmzcgk1pHJwKha6e43x+sP1/bX1?=
 =?us-ascii?Q?ZVlGAaHAAXvya8B2RRtRspZ+tZcaQw/B5I2RBHSI3XSPiUl9RWinysuymjEA?=
 =?us-ascii?Q?jLbVIaMmGovisGe+lLR1qldDE3HTyBLf6dyDOCFq9e1LsARafgyGahNuepRk?=
 =?us-ascii?Q?IA5UCLWn8Po5kEeoLnGx806N1NBciJCQ3lM7CWBrjWFGmammWFle76WhNwMc?=
 =?us-ascii?Q?fW068dUzg+Zdk5wrPwbbZLOXKbf6FMUeStnBQcvbRtynoVAXpA7WijrlASzd?=
 =?us-ascii?Q?KEVZ20J3EsjGULqlKsAHxFyDsyruRa19vCn19Tl1Nv1vTeNweoacSY5xeDC6?=
 =?us-ascii?Q?XsHXDaB+Gxy8Qtm7jOdTxcfH/xZ+tnblFnDDjARG/Z4oqKFJANfmuoDcapSP?=
 =?us-ascii?Q?YjQK/wJV9L0tVBlPnP05Zjla+XnQ/Qsmr0WvqzxG3kBp1WxWiB3RPjGwdFfJ?=
 =?us-ascii?Q?IusiljHE7+GDbmXKYa4Y7gUmg3RJfHJKsY6d?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:16:26.7826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2072109-96ff-4545-052e-08ddeb69d11a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8002542C7

"rq->nohz_tick_stopped" always follows the state of CPU on
"nohz.idle_cpus_mask". Use the local rq indicator instead of checking
for the CPU on the "idle_cpus_mask".

Use READ_ONCE() and WRITE_ONCE() for "rq->nohz_tick_stopped" to ensure
update_nohz_stats() always sees the latest value.

This cleanup is necessary to avoid the number of references to the
global "nohz.idle_cpus_mask" to ease the transition to a distributed
nohz idle tracking strategy.

No functional changes intended.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 61b59fd75ced..af9f2c1e93f8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12463,10 +12463,10 @@ void nohz_balance_exit_idle(struct rq *rq)
 {
 	WARN_ON_ONCE(rq != this_rq());
 
-	if (likely(!rq->nohz_tick_stopped))
+	if (likely(!READ_ONCE(rq->nohz_tick_stopped)))
 		return;
 
-	rq->nohz_tick_stopped = 0;
+	WRITE_ONCE(rq->nohz_tick_stopped, 0);
 	cpumask_clear_cpu(rq->cpu, nohz.idle_cpus_mask);
 	atomic_dec(&nohz.nr_cpus);
 
@@ -12514,14 +12514,14 @@ void nohz_balance_enter_idle(int cpu)
 	 * *_avg. The CPU is already part of nohz.idle_cpus_mask so the clear
 	 * of nohz.has_blocked can only happen after checking the new load
 	 */
-	if (rq->nohz_tick_stopped)
+	if (READ_ONCE(rq->nohz_tick_stopped))
 		goto out;
 
 	/* If we're a completely isolated CPU, we don't play: */
 	if (on_null_domain(rq))
 		return;
 
-	rq->nohz_tick_stopped = 1;
+	WRITE_ONCE(rq->nohz_tick_stopped, 1);
 
 	cpumask_set_cpu(cpu, nohz.idle_cpus_mask);
 	atomic_inc(&nohz.nr_cpus);
@@ -12551,7 +12551,7 @@ static bool update_nohz_stats(struct rq *rq)
 	if (!rq->has_blocked_load)
 		return false;
 
-	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
+	if (!READ_ONCE(rq->nohz_tick_stopped))
 		return false;
 
 	if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))
-- 
2.34.1


