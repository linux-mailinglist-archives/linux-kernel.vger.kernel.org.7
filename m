Return-Path: <linux-kernel+bounces-794573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA973B3E382
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A013A160952
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564C83126B7;
	Mon,  1 Sep 2025 12:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vw04YyHP"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DA02727E0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730466; cv=fail; b=TZIszgZEv4SARIlJFzwluxJKtaoSS1Z4Jo49bfH/zregeLxOjtSWpg6LqdCwKtaOPicpXYi8fcGFmVliAs/m9Wkdf2pJalMe/qDK3lNSAx9JvuQHKJasmksKL116hU3dPtU9wKF0zNw0Xy6tlmqz+FagzZQVuCTKE+LPa6XkhmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730466; c=relaxed/simple;
	bh=31mprnuYkxwTmWyBNTqdu4VL6GIfpRCvZ8IfVlIDsGg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DhuMcNNVzZyiUypBxZyKNyHR1R1jXkiA33fePr9zQHtDTxl7AHf9L57DjQRaiF3GIJ03FJPOaI94FWkCeaFjZrvvE4ZyhqR2qtBei5CX6dfIVo0WTQf1tyhEJa/xM+v48c8jMLW/ozp7hNbo2PiJh6uU2Wq0qyyNFOQol81s22o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vw04YyHP; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMxUG1/ePboqByE4TxNBuEZ2s1O33r40bZjgAQj6zDMNylnFUuTYv31ROY6qpaFs+qG8Lccgx7l1pY8Ehwq/NIYx3gDrfVPB27f73ief57yv1PPQ/ftXb8NkvHc+mVVusoX8YImr2T4rSHk+4aGTt6zI+mtFZ9dXnk44ru71AtKbnrdEg8+ZMrigD5sdxA9R1Ib6tHFh3jxQCayZj8C910PdtoW/D2OL7B09zKXpiJ2UdhtNoyw7CP4dT9Ghj9T9lXmOudrsCo1tZ31idXrI2Kxp6SvyjFwLZVQPvvx6oWLV8xBfGRXzGcd1/mpEeKARdggOqGjmufgzZ6yY364fOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLyATpXHvMFMiL3ehqCSbtvIsXHanifKLU7Jb+m3/98=;
 b=GtFni7aR5l1mlFZ9whLEZzLuQRrCIJLjV1e29oYYacSpEYnSCk/ZTd0iFT7M6OUWESbr8LJuMdVsaz83O4P+Cs3cBPBSV9XuKaveeIXGVu5eo1FroTRe0NQ44FkDpnQmq4oou0H/xUzP5D+p1CTzq3LJIpkS9LNNrZkbWLAH7tzV2MDpXnjhGwUj8qc2i/fNomyuldXokqQloVbBAeJW0niyyEoUF6CqAwEQrOVYkIcA2Y0Kg46JTWQaEW2tripsDoxxgle9tPWOvJg1f80FHuiDv2TtKrCz9PoV/9S2GgD3CarUeo/5i2j0P/VGNWklJvvy9FeureQ2X/tx53Q98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLyATpXHvMFMiL3ehqCSbtvIsXHanifKLU7Jb+m3/98=;
 b=Vw04YyHPXFq6i4yZLWWLXP6RIYEWJxv21xvqJIfTJkwEmTHcp4My0+kJ0dsemrLeV3dfzB7joa/4v9M3vJ//zLg0FlPkKSySXRajpp/D6YRS72Mei+iXhKuxxS7yVsNIe1CNMWXlVWvCZh1ifgRD1/Ml4YdDd7Uvp5DuD49TotY=
Received: from DS7PR06CA0025.namprd06.prod.outlook.com (2603:10b6:8:54::31) by
 IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 12:40:59 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::f4) by DS7PR06CA0025.outlook.office365.com
 (2603:10b6:8:54::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Mon,
 1 Sep 2025 12:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 12:40:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 07:40:52 -0500
Received: from FRAPPELLOUX01.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 1 Sep
 2025 05:40:50 -0700
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich
	<dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin
	<tvrtko.ursulin@igalia.com>, Pierre-Eric Pelloux-Prayer
	<pierre-eric.pelloux-prayer@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/sched: Fix racy access to drm_sched_entity.dependency
Date: Mon, 1 Sep 2025 14:40:32 +0200
Message-ID: <20250901124032.1955-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e449e69-3c3e-4565-572d-08dde954cdc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GUklaJtqpfHSLd4HDJZ7FQN/auMGJyRNeFNKc+3LpfwB2Mo5l16IgzgRge+R?=
 =?us-ascii?Q?CIdaaHw3Dy7DK176urLGNGAMoEc3kBLnJnEAFZZigxnuRRio1Yhh0rDPRAfA?=
 =?us-ascii?Q?V9cT7MJvxu4yIA83KT40Zbgb8Zh1j7PiAKlT1tGcJfUazUZKDulqJCfOVM/8?=
 =?us-ascii?Q?Ka1SBNeW3w87tI8LLrX/xpQjIbmPfyCsAhvNhBAqGkydXsvRcjHHNeOG7F7I?=
 =?us-ascii?Q?2Ubrb66FXcJ6F1PJTVypTz5YDEkuwoZdXOwaO+Z2e1qx7TLNGFTtfpNNqbdd?=
 =?us-ascii?Q?WoMijAylN52vHpgnxFaS+Df4HL4XyVKMu+ns4SvzBnkf7CLc3u5jb3MbKxwu?=
 =?us-ascii?Q?QAiGKekmVI+ajOv6qhNeRIrpRH15y8vZj4yoeSfMbsIuXPg7s84rjyFFb+IN?=
 =?us-ascii?Q?QN92beimWw7jPnh6CYY9Bcx6rBQ/LbW6RM9kMsi7fH14Yv2EchlE3xeOEkek?=
 =?us-ascii?Q?x0eh687A3Odwyi4RAmcn1HSiyBAe7SoPs6rTUMwzahmWo+hiTg8pdR3AhtUp?=
 =?us-ascii?Q?uW+CYLC+Rv5TdipMQTi/6dssiM519nKmBTzCmdMETjdyq8LwnAKEmyinxPrU?=
 =?us-ascii?Q?zDQG0cA5Ps9G2V0nV9GEDoMAQlfG3oC2ryisb0iRkopZZ1OU8zHeiCCcmWQB?=
 =?us-ascii?Q?QP7l1mNOb3KHzt6z62eprf4+MWUC60j+oLvDHF0/cb6F3brT3UoJMr8NJBIv?=
 =?us-ascii?Q?zclxc/5H0Xlwyf+zxZLwzl5ohQW7NWUBRgA63j4ZU5JcBzGLL+IV5pxqnlQS?=
 =?us-ascii?Q?8TnE16ea+TLhK8k14DmAwIw1RAC6J57HuWonqcYOHoUv1O2MeaqP0W3VMRUd?=
 =?us-ascii?Q?GDetdPBMteabQ0Jq2ELIOxyQyOGN8uSaMwBUSWWJOgF37DES7TW61xvoS1T/?=
 =?us-ascii?Q?ivkOtojq8g44WLxvGnn6vkT+sjbXJT/qeMZskbvkPm4A/GlHxR87CBf5JKnL?=
 =?us-ascii?Q?og/hqiu6CjwnqjbQmitBBkEuNsVkzxI3FZQRDnDYHwv7o7TkR1GPmmM8eiMJ?=
 =?us-ascii?Q?cyrn3yXDogWQB7OLqSunoAtOgOpxWXlvSdEOVY+2hAiiL+cIRSO1c42SCNQu?=
 =?us-ascii?Q?8YaLP7SU6aRgm32tggwRszzGAdR/WzkX5IP+odKmcCVSXSio3mNNQ1NQAMl8?=
 =?us-ascii?Q?vWbjw8LIDnytt+VRblRuNLC11WiaiPT/nXzhLvWsZkGfJogeWQdKo4ISS0/T?=
 =?us-ascii?Q?DEdb1XVZ4FG8AGfCHrjr9rMKT59I3if1jwyV8zptzu04utU5JZdYNVwRIAkE?=
 =?us-ascii?Q?1bAI/3rTRK4vSVwUGAZg5xEXBX6EhnfskJV4MnZQ3GyRWrtQRRI4yLGXyu0R?=
 =?us-ascii?Q?xbHsg/jMYfo/Tugza69hpssIMBFNuh1odHOZMT1fWIOP47PF3W05Di+hDI/g?=
 =?us-ascii?Q?YWZGztB23iyJN6pf+USg65s10CdW+31/wFkUp/l7V7/zzV/ykXAKsEBVN1pn?=
 =?us-ascii?Q?tZUkNguU25w8WJdTAMxDnCL4p01mTU/vDP53b4pvOa+59p1rcsfxZQwsvjUv?=
 =?us-ascii?Q?JKCKe99LDR/gtbV2fX5OO96wHZGqXPt2jgxu1a/CsuOApiLRpCcF8Agx5g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 12:40:59.4711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e449e69-3c3e-4565-572d-08dde954cdc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359

The drm_sched_job_unschedulable trace point can access
entity->dependency after it was cleared by the callback
installed in drm_sched_entity_add_dependency_cb, causing:

BUG: kernel NULL pointer dereference, address: 0000000000000020
[...]
Workqueue: comp_1.1.0 drm_sched_run_job_work [gpu_sched]
RIP: 0010:trace_event_raw_event_drm_sched_job_unschedulable+0x70/0xd0 [gpu_sched]

To fix this we either need to keep a reference to the fence before
setting up the callbacks, or move the trace_drm_sched_job_unschedulable
calls into drm_sched_entity_add_dependency_cb where they can be
done earlier.

Fixes: 76d97c870f29 ("drm/sched: Trace dependencies for GPU jobs")

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 8867b95ab089..3d06f72531ba 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -391,7 +391,8 @@ EXPORT_SYMBOL(drm_sched_entity_set_priority);
  * Add a callback to the current dependency of the entity to wake up the
  * scheduler when the entity becomes available.
  */
-static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
+static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity,
+					       struct drm_sched_job *sched_job)
 {
 	struct drm_gpu_scheduler *sched = entity->rq->sched;
 	struct dma_fence *fence = entity->dependency;
@@ -421,6 +422,10 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
 		entity->dependency = fence;
 	}
 
+	if (trace_drm_sched_job_unschedulable_enabled() &&
+	    !test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &entity->dependency->flags))
+		trace_drm_sched_job_unschedulable(sched_job, entity->dependency);
+
 	if (!dma_fence_add_callback(entity->dependency, &entity->cb,
 				    drm_sched_entity_wakeup))
 		return true;
@@ -461,10 +466,8 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 
 	while ((entity->dependency =
 			drm_sched_job_dependency(sched_job, entity))) {
-		if (drm_sched_entity_add_dependency_cb(entity)) {
-			trace_drm_sched_job_unschedulable(sched_job, entity->dependency);
+		if (drm_sched_entity_add_dependency_cb(entity, sched_job))
 			return NULL;
-		}
 	}
 
 	/* skip jobs from entity that marked guilty */
-- 
2.43.0


