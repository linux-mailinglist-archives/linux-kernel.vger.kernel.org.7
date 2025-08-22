Return-Path: <linux-kernel+bounces-782037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAEBB31A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B8916ED4A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F35C2D480B;
	Fri, 22 Aug 2025 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OrzIh7Ax"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D905630276A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870279; cv=fail; b=GULPEMpIDyEPe89MXCLgtTfQAmJPGU9oMzhzBI0ebSCFHpQ5Rhefahgz/qj4Az0/u5Q6Sbdp2Ms0FMIZnwS/2ADNATKNecQhkOpT7xhJDTa0rFjKUDpHcn7MD/lXKRriJuW5kO4iIf+u9cDny1RClB5Yo4yyRL/RYJHEu1+8ta8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870279; c=relaxed/simple;
	bh=Gl+eLzrVoXPvs5u1BRaJz3nkDYw95NPHPFMkS3nk9Uc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3EwVZlTBy4v3uni3SGOhwGpceBb+cX2mlL78iGk9ZeRsYsebhe3Rhw8yS/rJTqYyuT4yFm0ACptd4H/dgNKo2A+rLVS5gpa1AYHWMXyWiOGBZj9zLPP3Vmq6WkDi5t3GCYt35TltaDYe/9v9HqfWHyOUjGz0lS4FOb+g+EmYbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OrzIh7Ax; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pov7l47q9O16deyHzdCmAt+VcXX5fC3dudv5U4KVLJWf2XludYJEQkYrJyfiYi5tZzTLXWlcAjxM/qfVXbYDCguFlP3LJZjU9G66LSuZ/gTJ0xHpVVSrEsfCzP7Fn38yQC0/ywHDDlpOseOaCgBudWa+bv2AGSxvt02VYFn8sQJ5QvuqJNfESUVeYBOdWVK3KMF7BILsB9bPdOl+CiPL0aIhA69vlHn5jgHKqH91QwWcUhuBY/w8XRlr9GU8u0QS0scXrnGf1gwk2XEvrbt/W/zjfZhZqywvbr3isddNEehmuUb3lFojf7fAwdLfDD8TZlEbHiQVMQMIvJRnH/aJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uo15/LPDPedwbP1VjFvhnI8DDB0Y2WOZmQHMS8uj1rI=;
 b=VBrdONF1n2rnvbzYajzexpNDmwe5SYPUEEOGI5nipRs4WaIkzhq3fxmsuj3MO1XUv5TnKY4biChiYsgmYZGhWbUEcL1yMJtuqFpPyweXuZzCgsmw2YpBSc6KtGaGUVKf3EvWSb87M9NHZSr6NlHASXsKDf+f31L4Q5ePPGTbT5Nwtg5OFHi4psgrs6fWnDZRDllJmoymRZAs0Y5fFV0oMu+BiIFpAISDSttRL9QclHo/B0ll8IoT4J+OUN38czc1R/9yf4IcwfonjcJiAh0cUdvHZfhibOc7KM0i8VjCvnQpifSOiWC1WyOxQfAgEtTldFmFYf6Ba6t159LtrqiHDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo15/LPDPedwbP1VjFvhnI8DDB0Y2WOZmQHMS8uj1rI=;
 b=OrzIh7AxlUnmfDbyLKe7FWZMa4lPc1Y9O1aV+XjgwlBfMXpgpEfgdLWcIJK7pgsCii1G66gMmQVzK+mW4t0XPVLZpQEBcYkkuNRfKi0eJZP9HnidJvDedg5yNJEjTEm539d33qf9yWKCAwa2Be4XjZy/UM/z+BHUDbHOd9T25T8=
Received: from SJ0PR13CA0138.namprd13.prod.outlook.com (2603:10b6:a03:2c6::23)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Fri, 22 Aug
 2025 13:44:34 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::63) by SJ0PR13CA0138.outlook.office365.com
 (2603:10b6:a03:2c6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.9 via Frontend Transport; Fri,
 22 Aug 2025 13:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 13:44:33 +0000
Received: from FRAPPELLOUX01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 08:44:30 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich
	<dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] drm/sched: limit sched score update to jobs change
Date: Fri, 22 Aug 2025 15:43:47 +0200
Message-ID: <20250822134348.6819-2-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822134348.6819-1-pierre-eric.pelloux-prayer@amd.com>
References: <20250822134348.6819-1-pierre-eric.pelloux-prayer@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|MN0PR12MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: 52db2537-5bf3-4d6f-2efb-08dde18206e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WNLelK7geSt4aOMJkwNsLZ5FLc4LiNIBLXuVzsEZgSFTO+8t28i1jUJ6jDox?=
 =?us-ascii?Q?+BFJF+CN9Vqzf6A6nDJisNKYH6N09a0vKxifkQzt3nshSEKJb9k1kod2st0n?=
 =?us-ascii?Q?msHaSM7eL1KhPEc6AcNEayYegrAXy8g+7GHDe2mF+9quqOhjyK4/vqKUqJuy?=
 =?us-ascii?Q?AxxWUbgbIoC1sK34mVTeQhWp8GX3lDDDXsZ8otHE+6mLyjHbRZP4focPReyZ?=
 =?us-ascii?Q?OMNqrwnBMcUGZTN3VDVXf3TSsoehhTrm4m0kQRs8oP/k+Z4zVqiEvjLDttBR?=
 =?us-ascii?Q?QChUyZExsIiZNaNvP96sqpdz8qqI8fG+StUCwP35ytxXw4AGF4xccArCdgtP?=
 =?us-ascii?Q?B94OpbZbCZvEvWdVW9PJ1FNJz7MDAyacfyi8UYomgJG2wFUltgPifFKNZnK4?=
 =?us-ascii?Q?X5YX91azZvfdpyvNlOWbneyF0t6NRywRyrly9GGn3cs3RYLueY2iYxmBWeEf?=
 =?us-ascii?Q?YgrqmbcA0/c2ZqbDE4jdsFOJAPIlpSdwEds4/6sa1JcAV4moEt6lEKfYWJHY?=
 =?us-ascii?Q?8jdTUSQAYyHYMoOunHtFSvEFsZ4KlYitPdnZJiunhUbHBvc9amnPZDbSWmge?=
 =?us-ascii?Q?uf4qx9nHf2f3AfpmcVoYK7zrTuxIbfYTap/k9LZ7H7HPA4WwhccLG577bxgd?=
 =?us-ascii?Q?QkYVjzZQKB0Ud0Y6Ddn/QZVmE0Uh1PPrC+YhGKvOiTb+Q/kN4EXOxBn2rhAD?=
 =?us-ascii?Q?dKMD2MUKrPU+3p2HzvBIBLAYjalp9I6yPeYidjpJ5SIBPUGF4JEj4ifefG5o?=
 =?us-ascii?Q?nwNy2OHDcclNxTPH9QZ4/rlDi+0/4Y3ZcSHfVMWoPDFwYQLsSOvKGOFSOk+Z?=
 =?us-ascii?Q?kwvZ8krPZR2ah9JnN2R7mPseU1AJ6hHo0IKkqNaJEDXEjsNRy6OgCUloQ+Y0?=
 =?us-ascii?Q?/I+GTGu7fWTV2gOwZ4V5fMPIR8aCPg3yGPFZYSd/jEbryunH7nPPV/pkQT59?=
 =?us-ascii?Q?7Vqbd/vfVFrknIm1F/S0KDJJyUy/ZUK8sVks10NIFIRsyyIuOVA21HXakezG?=
 =?us-ascii?Q?07ddnwwa9a02lcrjyKP+9PFNlW7fJCJ4eAQKrb80wz0MwhBoA8WdBdpmLRvq?=
 =?us-ascii?Q?SyvYLMVH6DjE0JuADHzWIqjl/byBTGD6yMVWJg/bRgWiRQ3zGSxqCV6huY1e?=
 =?us-ascii?Q?D+LIOweKukkpNiYELA6rTj9rePMnF7apyI6ABV3oTHJ1VlotNuAziw248LE0?=
 =?us-ascii?Q?9tKhVZixN2KKtC2otEcO1AIHRqOlLN1XkGU/tAlx+oQ+MAjbEgLQ1iVm0q2Y?=
 =?us-ascii?Q?pfPxmi/BqPsiPjsJ2FsKdtRjHMcKk3mVJkqfd8bNwS/VVt1O+jAre01Xvxny?=
 =?us-ascii?Q?ntN2o5BTrz2FW0kFvd8xDrHYQ2AfcH3xI6zjGk1syAp/IQK1mrI7WKwYm+6J?=
 =?us-ascii?Q?atIcjChKs2KXAT1Yys6dJ3IbCVYvFu67dqAaCdV1+fPtTTjToXVdXFn7vXhn?=
 =?us-ascii?Q?UooWz8gF5l/uskt1sGWv8JFcSgWFkr+scRtojXcLwOVPEam/m0F7Eh07pnx1?=
 =?us-ascii?Q?c/FgL0UhkbRyIk1QcgueGq7bELULucnWkU17?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 13:44:33.3047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52db2537-5bf3-4d6f-2efb-08dde18206e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956

Currently, the scheduler score is incremented when a job is pushed to an
entity and when an entity is attached to the scheduler.

This leads to some bad scheduling decision where the score value is
largely made of idle entities.

For instance, a scenario with 2 schedulers and where 10 entities submit
a single job, then do nothing, each scheduler will probably end up with
a score of 5.
Now, 5 userspace apps exit, so their entities will be dropped. In
the worst case, these apps' entities where all attached to the same
scheduler and we end up with score=5 (the 5 remaining entities) and
score=0, despite the 2 schedulers being idle.
When new entities show up, they will all select the second scheduler
based on its low score value, instead of alternating between the 2.

Some amdgpu rings depended on this feature, but the previous commit
implemented the same thing in amdgpu directly so it can be safely
removed from drm/sched.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 5a550fd76bf0..e6d232a8ec58 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -206,7 +206,6 @@ void drm_sched_rq_add_entity(struct drm_sched_rq *rq,
 	if (!list_empty(&entity->list))
 		return;
 
-	atomic_inc(rq->sched->score);
 	list_add_tail(&entity->list, &rq->entities);
 }
 
@@ -228,7 +227,6 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
 
 	spin_lock(&rq->lock);
 
-	atomic_dec(rq->sched->score);
 	list_del_init(&entity->list);
 
 	if (rq->current_entity == entity)
-- 
2.43.0


