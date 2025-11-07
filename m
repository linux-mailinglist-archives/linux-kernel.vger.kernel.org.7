Return-Path: <linux-kernel+bounces-890016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D558C3F129
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB16188D635
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E021A3164DC;
	Fri,  7 Nov 2025 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4vBT4tP1"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8F731813F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506299; cv=fail; b=GWupqYCG7SZ8U89/RhknyGh89kFxJAYUhFaN7XeEsePWOov9YCc9WTbx4oPvIDmmwTtnLY1f0OE4VDv4JynoP7ebYazcKe8CoUAEvz+6Cb6NzSg2QMjZ8COShu5VORM6Y6ae0fFvoNdSLFKfuzItqhvC9D2SeH3XqFZhtJpnSy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506299; c=relaxed/simple;
	bh=yNpEjlAf8nRCx8H/sdywhUoftFvWmcAgaUNsAjvRkYY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ms8vAxW3AwjyT1wcDjrrdX4rc5B93fIny9QZSXDU4XkdN/sbZ+GBiAEHhreH99i1bvWrsLZv4gWhlcW2OodUHw/7jDba0wwXNEdIYInB7zUaCRDvlFBJIMccNrZ8G88+7eWKNasV47gZ5FgrUIiBaMb7GnmwYmahSld73K2q4UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4vBT4tP1; arc=fail smtp.client-ip=52.101.53.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDHUYdnhs1fJUylJixYH9dnmu8v9s/ThkWVxFvKARol2k21zoxA0PDMkXmkdiUA3APjLAm217aRjPxujOH9PA8y4xT2rMPpYmJHtNOgUrE1BCn30ESAJo5V1IEWQhZ0CcBWqAYTdaaBvcF8BB4gguSPvCiPiPqzJCtGyqbF2lWfxQBEeysNrlt8OYI3v7Yj+IYwOgeyhZ5d44SFAuT8UJMLSBb8yw0ZY/BzIdNUHZ4XLu/M5WxNi4xY7H85p0VP2KZ9WFb1V85evdTgH7p4tlyMMNPx9m1CBAeElakupgp1h1RhL6jeJAZl//PnZh9OfvyZALJaUwlTmQ+Wu58BzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXrNHS15Oc+aLAyZTvxM2zv1RUe2LqRA48kRYTAeZYs=;
 b=FncWqaz2XB3yfC8fMHRIuM2wf7KldVoLeE+sLeFG09YDN5/rwBb01ZCSbTClvwTDSU3quDuAtrDF4qEprAg4b8HRNhiHJOUdajOpGMJRnQTFCFwAz5VCM0BlAmDXKu2UCvfjABOj3B3N7ba37lv8rcCrut8US2U19W6bWKyeDqMM/wDdf/0xDef27GXS10fqv4F/fYsPS2vdzElt9SO3nHs2UlZRS9c1597jM+sS8uwNZmFh53iywxZapcEhRMTIxJeq7rvvyiVkFjqCnFPP6Txwal2lSt7WhsSg+rDDPi6py4WxXc5PHaifN85EUijONS1WREjAvt28btSHn9s5uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXrNHS15Oc+aLAyZTvxM2zv1RUe2LqRA48kRYTAeZYs=;
 b=4vBT4tP1RPYLKOuhWPRGjlFIBoFqeRhD7X/TyCBokjFUPFd5xBqa8G+QjMS+e0eax6jVkVIPuax1IC9SycMcynDrTXohUDmJbRFYd48Kmmfchr1Bnw58963Cs2EY13oY0P9OwEjDkpXHLDxba6KbZekeZtXXEPihJFqIIbGs5M8=
Received: from LV3P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::7)
 by CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 09:04:53 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::b3) by LV3P220CA0020.outlook.office365.com
 (2603:10b6:408:234::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 09:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 09:04:53 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 7 Nov 2025 01:04:50 -0800
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich
	<dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Tvrtko
 Ursulin" <tvrtko.ursulin@igalia.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/3] drm/sched: Limit sched score update to jobs change
Date: Fri, 7 Nov 2025 10:04:21 +0100
Message-ID: <20251107090425.23199-3-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107090425.23199-1-pierre-eric.pelloux-prayer@amd.com>
References: <20251107090425.23199-1-pierre-eric.pelloux-prayer@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|CH3PR12MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: 0433d955-ad0d-4ae3-480c-08de1ddcb70a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x06nJPvVy9Z2WbCDwZyRI6AKqNB8AduMe6sHqz8cLxMgM06qAfiqYY0ZwPyy?=
 =?us-ascii?Q?dLMXI0jfaSwLfak7hs2c1do60y+P/jtQIQAAtNAt5wufJTu8ohliFax9SImT?=
 =?us-ascii?Q?Rx+CZyUS0FLvW+qJEU+UWKOjIXW5HY/VH7LJjYPDfUuKmBHvFPpwHgVv9WIz?=
 =?us-ascii?Q?GD8201K/12IcbIlN7j8cpbvT6wAAJOcvVZIO66N17FitYfu59cVOnMNRa7+5?=
 =?us-ascii?Q?YAUNHrmBKuX5V8ZOQuA3pSB36JJ5I/0vu4xW6j7i5CYDejETarJbJLtEkiN9?=
 =?us-ascii?Q?KhcF8gJTOU8+MOx221BtJQPfBrmiqIjf/45F3BJ7+Y8v6rVikepIrwr3kgZE?=
 =?us-ascii?Q?f8zn8IVMhy4/X53jt2b4cKyvr/VfjkHVbjDTAXiQKf2Ux9rWUQs6wGOxmn7t?=
 =?us-ascii?Q?VMn+HySSLuX9gvqZ6+CB/5ktioikXm6VlHdvS8zsCWSbxxgYxFMBOan8gTdr?=
 =?us-ascii?Q?yqCX17PoV5+l8L7bUyk5pWUrF1Gji96qLgiDBddHxed5wwkECsFOWSM1t9Tf?=
 =?us-ascii?Q?Sq6tTbm5GaOGFnDEPFg0vIzgmVp+g0cgA46lpccyjJ/hAgMjwDtIHezRdard?=
 =?us-ascii?Q?V536KKdsyqkQhIq0DWC9Y2CX+Kv08eBVzAAuYGB4B0GsUY3D4ANm3EXBFRVe?=
 =?us-ascii?Q?MKSBiX8l9CpVfynBKUiERd8BB+sDrGgOoh+ijoc9SYJh/0WuCKqWkMD74Uw9?=
 =?us-ascii?Q?TQB4GjTGAOK1Ckxs8rnC/z0ibfTYLu/Qx2zK0By36LG+Xx80h9Ugss2FtN5k?=
 =?us-ascii?Q?WUpPtZ5cOvTrmo68MENDn2gvLdQf+FPRrIFDJjPNl8YWsGUe+qDmdtW2AjTK?=
 =?us-ascii?Q?dmmQhRTC/Xb1XycbkQ6WiETpzf+pUtsycOlOgzbp7w2zUODMwLiYI3gAJgnl?=
 =?us-ascii?Q?MVVrL5vgVBRn7r0MGCNv5N2xX+f+/BtX6Ew/VQae2zS5MfP2s/TEQNAr6lWo?=
 =?us-ascii?Q?ukqZrdMAbsYPpGPgXgrV9+bOLSB8rtnFTNZqlw9HruD7AseeXr3SBsfv5WUr?=
 =?us-ascii?Q?iQPeCOxetu6iq6aI2d1UUdgpWmPuuQQeCNggzdqy/6YdO4NyQp2tKssCt8DV?=
 =?us-ascii?Q?hRSAXAGdOaCHD4JDRTGZhXxNWVxFzq+C4Jg5mIhjVqYXVZGzBzsAEJcXNPxA?=
 =?us-ascii?Q?V3DrAZimHExNeuxyTsr/QshkaIA0llhIc4l4LTxRiFZIQJ+oS6e9N54fT6Ye?=
 =?us-ascii?Q?zzX4PpSRHt3IT7XUYw2ocUiSRTBgvJPu/Nl3ltfmJPorvttxc+b1nPsfMuPS?=
 =?us-ascii?Q?i7uflvCkB69/gdmgyi+bN//MfhY8Ko9LLyTXcy+2u0WYL1mrntnSFbcCTiRT?=
 =?us-ascii?Q?7xZb6FshCK7ViTA1w/JyOiGn9fVABhJTEMtgKjW3vwr6xaZbW6MHzkFODajI?=
 =?us-ascii?Q?uQDoYmf1h1vUxMzZXPjo66QmQyIi3N4kAGJtaf+RamYtpXBKBT4zIAc+bm+/?=
 =?us-ascii?Q?M0FuISqLnEibNq3I50aMI0wCnIDfasN0+P3sMgNuPtzJO6hGyV77Uhf2S5f1?=
 =?us-ascii?Q?ICZZxT5/5TqKuH2KTmZ+mbrYJt/VNjJP5uqko52Zk7VfpMMqybooUlNAVUGT?=
 =?us-ascii?Q?X5j799kkQQ3P326ndI0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 09:04:53.3675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0433d955-ad0d-4ae3-480c-08de1ddcb70a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9026

Currently, the scheduler score is incremented when a job is pushed to an
entity and when an entity is attached to the scheduler.

This leads to some bad scheduling decision where the score value is
largely made of idle entities.

For instance, a scenario with 2 schedulers and where 10 entities submit
a single job, then do nothing, each scheduler will probably end up with
a score of 5.
Now, let's imagine 5 userspace apps exit, so their entities will be dropped. In
the worst case, these apps' entities were all attached to the same
scheduler and we end up with score=5 (the 5 remaining entities) and
score=0, despite the 2 schedulers being idle.
When new entities show up, they will all select the second scheduler
based on its low score value, instead of alternating between the 2.

Some amdgpu rings depended on this feature, but the previous commit
implemented the same thing in amdgpu directly so it can be safely
removed from drm/sched.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Acked-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Acked-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index c39f0245e3a9..8a3d99a86090 100644
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


