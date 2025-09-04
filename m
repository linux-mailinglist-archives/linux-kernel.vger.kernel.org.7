Return-Path: <linux-kernel+bounces-799858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0965B43100
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409601C2421F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D111E9919;
	Thu,  4 Sep 2025 04:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V/38qBk7"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1126F1BC58
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959408; cv=fail; b=XPSCIKdwIDbnYdj9SZjmwjhFqFL51bZOvkxHiv/hNA21pkOSdxHd8LLwa0UHwILqYLFHt6IOu8UiE+au8EKLDFrsIxuD8/bbxGq0hYKfDJ9jLgr761v3afxhyAeNW4wpdkf7NDdHhfzXx5bTdeUnv6OsXer9yA037h9I4dS1Cro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959408; c=relaxed/simple;
	bh=4X1hzMA9LoxxJLjHySPzE9yRiy/3COiZd5nNx6dHtu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9QU0vipYxj6N9XEn7FlqLw9BDuACoxM0z+xlfZgpGIHnKl7+lP/BXoCbbZ06eC+lz8IwOdImO2vuz5eMVS5YJhi05IMlU3rBXxBWYI4OXbYvfo3mlVDA9EffwvR3unizb6ObDjo1c3Wy55bavfF7jArejm6+DlIwQFg5OGM0rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V/38qBk7; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEOlVUwjlcBHw1hhzoVBSq3/gB8CfuoUCFqRA/i46TCN9QWAJ6w8PR2CDRGS2RVUKXztzFARLZI2d8C19HH7S3iU5z34GM3vRxB3oW/uDhrsGw5VnBUCPK9vXQSHMe+B5bK3uFjzwAYDnvUE7ZJlM9LYjxETfbXRXUNi6pJZXfgu+YvWl8+6M6LqQwZWEN8Cugr3voY8AOp3ugad/Z8TAIRLggd1X8ZbxycmS37wksaPmlZftrv7GYzBuD7cxdPIlwY1vZ0STs//kQhf9sExuKkGp8btBZn58Q+xQgHfR5LSZivxTfjlhxHR6+KrVav4Lk5gmHxm8VQw8+S0QMfKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0s3Ux2Bq68yPW2jHFW5iBJUmDlzPyQHlo4vWJiZn5U=;
 b=tMxnapLneCCfVBUCfmE8yiXANie2cyEM5DMTD1wfdqrmydeSwTVBlIVKSQ4hIJuM296Z99pJnbvGcpTXIQNhSHenwHh8lyNJrLIqKQNlsCs/rvxo85bM+dfu6XlICLSIc5OlwRmcmFL8IHkYsmYRufZpj/Bjf865ATLtBMitVdYeUpSi7aE5XdTiyladHjTY89xxCEPsU/zY6x5vBLipsmsoS8fKE634Nzpi3kGDJEjtCS+VfmDQe95wThcsNZwFiUWva6s58mW9i0PnPuatNyXNcpHE1YXrtxCi2aGr0UIegfPnUO5j8oUtJmzMWUBGqqsAHYtRUfVeRmsV0r5CHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0s3Ux2Bq68yPW2jHFW5iBJUmDlzPyQHlo4vWJiZn5U=;
 b=V/38qBk7MvP963SkR5ga4HWrpJvYKAZg/cv9W4a2EibbQXDwiP4N5mXx1a4RGFfhv5UwtqIzsok0PYh3+2lfHZ4VGKCZunvQrib0/Zkykn0XVv2ijbEPG+qg/B7XL995AK+jxbJXou6nRVqYnClZC4/EjVfPj7gOz0bG5EVohtY=
Received: from SN7PR04CA0186.namprd04.prod.outlook.com (2603:10b6:806:126::11)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 04:16:43 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::a5) by SN7PR04CA0186.outlook.office365.com
 (2603:10b6:806:126::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 04:16:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:16:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:16:42 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:16:38 -0700
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
Subject: [RFC PATCH 04/19] sched/fair: Use xchg() to set sd->nohz_idle state
Date: Thu, 4 Sep 2025 04:15:00 +0000
Message-ID: <20250904041516.3046-5-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 68947a0e-bd88-44d9-0b09-08ddeb69dad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DoF+/udD/rmKRjyZOwiIkCQAOTpLUv3MPwIMP5xdpJPXNux1fwqyM9O5Bzgr?=
 =?us-ascii?Q?9FDHUsNE5dUe3jg207h/rTmz6zUbLd0CfYbZg5PMVjurkRtp3bVB45uZPXkH?=
 =?us-ascii?Q?4Dxk69wHJh3bDlSPeGiLGohu3iIFdyELJXAVbWHl6MNBaG4qwlfGWCDkk+qn?=
 =?us-ascii?Q?3N+BSdDcZ2M21/h0cs2p7tae9qiEli0e4zXsc6GsofeAEutREnUbEu8T4XCU?=
 =?us-ascii?Q?jE0ASzf7eRnjE2xZHhzbK8vo4qPNpyieeo9JnE776EtMt0JIdFBm0hQ8yxML?=
 =?us-ascii?Q?D1Y/TQszT1Sx61fPvgJB6vEn5goA04wjL+HPMGyLxKyNyeMI52NFWz9tLiwz?=
 =?us-ascii?Q?+ToFTs0SBv9GOBRIT1jGJdIfjQAD+UvQl2ppyhcT0LeHFHA7L30PaMiUYlnb?=
 =?us-ascii?Q?/mxYHOfQX+8k1Yq+s7pz/0qUiD+DJNDn70/PbDkz7OOm/JLZqZOrCXcRDq07?=
 =?us-ascii?Q?B4/VMWQfrfv8NUolqZKU1+d562f9gY5KuT1ou6ZoZ4E7ldXqiBqhyX82c4uP?=
 =?us-ascii?Q?Ae679IGzua34E6RtbgVObMLg9A91jOoHj48SdBDHuSAr9bHXVq8Z5M63jyLN?=
 =?us-ascii?Q?XejZFXXynilVg8AYMbjEXQaRoiI1ZRWs4YGDzOtBR7NXTsd3yaIiwtT/hJtr?=
 =?us-ascii?Q?/QQ1keDP2tX3VK+5qXThAvvUuShqW1y+bMICBy+TvmF81X22GBtf324Frilh?=
 =?us-ascii?Q?dvDJ5KiUWHybNl/0L/LEv4nu5sowa1A2/FsYDaH8pruZMm82rp56Y3lLPxTH?=
 =?us-ascii?Q?fYqg3ctzCzeee0EIQSXstnyawS3kz0U8vI5YLHb0CrdCetpn7VQFYq52KOYS?=
 =?us-ascii?Q?9bCQfJJRis5w7a0urIbGH7fr5hOPtNzNW6kdDkFj7FXu7RQKYdKkrhRScOM5?=
 =?us-ascii?Q?cH9omqlBgOpj7h/yQ4WLc+v8i/KzV1JH43mNhAlqU7efufmPmtijBXffA02M?=
 =?us-ascii?Q?nFNr0/Mq9NHN2/KWCxJK4eUqvPsrr98EMM9ehD+MWAeIuMXqtfx7UWuREJ4F?=
 =?us-ascii?Q?/Bze6I8y4um5SAdQihmoP+8pMbAg07IJCWeI5suxxyuiaYZ74nAz6OnEnBjn?=
 =?us-ascii?Q?Rjs1QWv9qeC/fAiUvMFnbiqd3YVwzvq5EnvBUjBt6kaWOULKGb7ZtGnvMinz?=
 =?us-ascii?Q?14iXDIV8Fz1Z2gIPscWCVZ6QYzXWdDyDyNLWOlgHzpBd70PfycbOzckVtdeX?=
 =?us-ascii?Q?z1GJumwlkClrvVFBERaDsXN0f+7423v+hLzWrhkjOo8l52tamlUy6P/A4yxW?=
 =?us-ascii?Q?eQ1sn76VY6xZG54grM/fVGodR0h9WGxGUEKjaXm+j7kV1iv8dc7WwyoE5uPt?=
 =?us-ascii?Q?OjMG3QihF5X1T81+DX4HfKlhKNIy8SoZWEAGV/cbfrvGBdhPQDZ1dxlG+AmU?=
 =?us-ascii?Q?NZAmKM8U4l+GTDUnqfp3knzZhcwOQZ7dNZII0I0druT0TPmgQOxrkPpqPEdj?=
 =?us-ascii?Q?vB+urgH0z6uOiZVvmy7iWOnqL1SXqSOtoA70Q5lNUOhLsVghHJfgnfbqHuq8?=
 =?us-ascii?Q?r35wa/scVQubKZf8bZMbXZEqsyzFHu+FyFPm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:16:43.1269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68947a0e-bd88-44d9-0b09-08ddeb69dad4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874

"sd->nohz_idle" currently relies on the fact that it is always modified
from the local CPU to keep consistency however, the subsequent commits
will use the rq->online() callback to correct the "sd->nohz_idle" status
from a remote CPU during sched domain rebuild.

Use xchg() instead to prevent double accounting of "nr_busy_cpus" if the
status update on the local CPU races with a correction from a remote
CPU.

No functional changes intended.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index af9f2c1e93f8..0e68371365a5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12455,7 +12455,9 @@ static void set_cpu_sd_state_busy(int cpu)
 	if (!sd || !sd->nohz_idle)
 		return;
 
-	sd->nohz_idle = 0;
+	if (!xchg(&sd->nohz_idle, 0))
+		return;
+
 	atomic_inc(&sd->shared->nr_busy_cpus);
 }
 
@@ -12483,7 +12485,9 @@ static void set_cpu_sd_state_idle(int cpu)
 	if (!sd || sd->nohz_idle)
 		return;
 
-	sd->nohz_idle = 1;
+	if (xchg(&sd->nohz_idle, 1))
+		return;
+
 	atomic_dec(&sd->shared->nr_busy_cpus);
 }
 
-- 
2.34.1


