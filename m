Return-Path: <linux-kernel+bounces-899779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC03BC58BED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1543BC804
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468BF3587A4;
	Thu, 13 Nov 2025 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gr02ud1O"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75D42FBE02
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050416; cv=fail; b=VdTFd21VxgXd+kXC13x7+9DYfxDOp5bIYKwkob9kSAApNfSsYlMgvyryFIWvOTu1IBuwQbp7KU2ZvHCs90Dzdcpqap1rHslUt2iD2ltVYXV/lzChgsTUy97hkdfiFwDtkZlos97IKFuE47I2BQrHdZVMevsFC2SeT5Jb6sUgnEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050416; c=relaxed/simple;
	bh=PETjoXFidHj0PH18mHb8KeQ5KlSkK6G9kF+BEc0sFQE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2Ia3OJiprgU03TfISK+3qaL3V1NRKBUolEdRKM0wzzg9ggJ7jvO3j6DV8jPfmCqBOsl+C+LQ9Dlo/wlp1u606XYCMMLJOP31d9laX1SVUMMwGa6w/1rIe1GOaL5i9Z6Qw8qdedAv90Wiv7DeMvwhStjLL2pdWLVbjA/89vO9qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gr02ud1O; arc=fail smtp.client-ip=52.101.46.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMJL9NXhBQr2wB0FY2n37HDCJShS9rF5HieJIPERvCGPLSOGwbkZHzA9ObbyGFEjLHdHHyWAjkxbyGVQXLMRKAcklfwz4qH2ynUEkq9z5yStjdpyGJPfFsK/ENPOiy9d2HlaDjcnoNJs14IITsoxNVDx27E0+p5fG2Iuc2V++/gKYyfVM9TknEKzLkI8WEHHDijanByrVad2PZ1+PXrkPBODQDTm9GvUZYpEbC5x6ipoQiC/XPwGOzTzMtH3mkftdpAZcxlh01C31zB8HzMXu65NZWr3rGMsX7+j8AWmdM75gigvxB66y2ouiIxoVUlSXMjpLTA5clUy3PUa3NeVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0T82WTMi7SxGbNMQ9NDDhT18PDINzlXKl/s7c1FVMT0=;
 b=Jyzz0+pwphJoCTW/jE8bnmocy8MBTn4oLxO9EWz2vHal1fMgKWxZ2usBgUgfXisrvec7+/BL0n7Mt6weho8B2MhOd9ekIoSiwm1oCHPA4PLv0tBQ7iDlSLwelvHDXjRGGHv7yki3EIdRjS6NbhMlY/veeGxt8/0ywCs00ydrXOsKFAVgyA8GWY4Y1rzorRjZKcTT6ZLqm98JmIpxq9ghjss9/I5jdrKWmfGScmzzW8RUFrLYiV+bWFce9xtxeZ84E+bme9GP5ipV07ALzNNTE2YTvhkwaZDayStRN9nFWOc153/BukINTODRqfIDwajbUrSPlOKaQyjo58/lO6uQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0T82WTMi7SxGbNMQ9NDDhT18PDINzlXKl/s7c1FVMT0=;
 b=Gr02ud1O3tk7mHLMof25ep4tQv1QzeQApRbY5qasvXWA4ArRz1CPDQjO5F/YqktBbAohLDie0Gsh2GuTnDi/Hvk20rybt2xU1ePtGGV0b4KTeVlAAknkUm7mzNVGflr66yNuCdz2AH7+yszuq+2DheH8YwOG1J10lh5RXt7RmFE=
Received: from BLAPR03CA0019.namprd03.prod.outlook.com (2603:10b6:208:32b::24)
 by BN5PR12MB9463.namprd12.prod.outlook.com (2603:10b6:408:2a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 16:13:32 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::ff) by BLAPR03CA0019.outlook.office365.com
 (2603:10b6:208:32b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Thu,
 13 Nov 2025 16:13:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 16:13:32 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 13 Nov 2025 08:13:29 -0800
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 19/20] drm/amdgpu: use larger gart window when possible
Date: Thu, 13 Nov 2025 17:06:00 +0100
Message-ID: <20251113160632.5889-20-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113160632.5889-1-pierre-eric.pelloux-prayer@amd.com>
References: <20251113160632.5889-1-pierre-eric.pelloux-prayer@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|BN5PR12MB9463:EE_
X-MS-Office365-Filtering-Correlation-Id: 0063a849-5fe2-4fdb-f846-08de22cf9755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wb4W3kaj1mooOJ+XQI031r9pZnFvJLNRZXwAztzqJe35Wvr3QM7MlOqfe/5V?=
 =?us-ascii?Q?BeBULaJLUAKNkKgvTPzJHdA6z8PXbudTVIcqMWJ+HUm/S525pIM/Mq0adRva?=
 =?us-ascii?Q?CpZGAMNy+CPU09B0ssT7oR5M9/5wsE9pWAlJX8gmVPXYxXUwGDM69NwPXKSq?=
 =?us-ascii?Q?2i4xfrSMHCn60MoUohR+PUQVemO1uU8D+/Od4JBcJx7u0LWnTxQfm47eWy+o?=
 =?us-ascii?Q?501GA8sa78mf0IG27OG7mUQHe3DvAnh2H0cBM186Fe9zE6E8/aEPTcBlwtvl?=
 =?us-ascii?Q?Ua68jnF6G1jGvkU9Dgay9As3l9SK3QKqY2pDgSNZjjuHde8JXLJMJIu3dvbF?=
 =?us-ascii?Q?djRilUX09Bydp4gvHeAIWkOAWLNkbk5aHGrjRIFqkfbe6/Rtaf/6770a6bCr?=
 =?us-ascii?Q?JEK5I3iMdtHG1ZK9fSFzttCwDkjm/iZulA23Vqrct4xWSV12jZPGckXhu0Wi?=
 =?us-ascii?Q?6GZWvC/n0LwT160d0IIx7c0vbLSvXSnYax6xPf+0pVm5WbQhd9Tu4IgZ2L5Y?=
 =?us-ascii?Q?vGA/LJNR0fXNirRU7hlrY1L+0++IlaAGWvguCHUgUO+fQSUL7vqVKgE0I8LK?=
 =?us-ascii?Q?bgMVxtHUHowHi9OGfupT4FQclN4b4AfGa79dajhCW0KEAIOLZYED94E2j2vw?=
 =?us-ascii?Q?oW5BPvqH3GbtcXr5PiWR3N0jRMrkIJgaElzwObDsNNAWC2PAdVAbzRxbwb6X?=
 =?us-ascii?Q?4Q3U204s2StnH1qjZwdnDZGLFR/INWJEP7VVH8A35SLXPM2SVe4JvHy31yYo?=
 =?us-ascii?Q?NguqSxalqNmHM3NxkTjRi2PNxohjHv99/UPKI40ATZ8XJkAz9ew138v+dvoE?=
 =?us-ascii?Q?9wDyCAuw4z6E/oLugyuQB8+P1c5tr+mFP+FxewKoPMAXTeI63E8MZU57+f6R?=
 =?us-ascii?Q?ueHpoyTa7elHGJJelrcQWOqXvG4YhbP8PvsRLiyWML7D6gLj6vnSIPrLqYV/?=
 =?us-ascii?Q?J4qnmETXd7wdp5hr77XQHvM2tSz1vKRI+1fgSYKV05WZPBa+LzpKcFku49yB?=
 =?us-ascii?Q?5P7f9pLEjrXtkuVapPAAq1BVrdooa7yxJipvKfNEjOrwQRLd/GOAUGMHMbaD?=
 =?us-ascii?Q?hS26JkpQGksNPl0tdDGXXGQ69xWCiVdAXc1iPILsWUJUrpDmhAxJ7DofK5Vl?=
 =?us-ascii?Q?LHPtV9hDpygpUF6Gud/INLIWY2iqj1MZt5XSIJYfWHamPqqHWCi7rGtINSTi?=
 =?us-ascii?Q?UjtRadLhh71E3tgOGfawSu9Hiv6ZjxK+64pOxQc0u6bkgoYXNf+0ALg7Lesl?=
 =?us-ascii?Q?OduAOWKRTTaJ/WKIgv1XcKk9nTc1gNbrQ6lzI+aige4qkxUJ0myvwnkSP9+w?=
 =?us-ascii?Q?SpB3aYcbOs5NYqC4STcoN3WAEhVzTSxA7O4i16m1qQmF830tWHmlp+mbJF7l?=
 =?us-ascii?Q?NCEjqott3udRvhypw/utfMiO1XBF4D2iuHuRgi8HmUePXG6e452FZ2WOvTOL?=
 =?us-ascii?Q?JNPipQke7mYxPyO0bgWjatPq/ROB02mt7iSnapvJ3rD/jmkqGv1hKhsudJAI?=
 =?us-ascii?Q?yVdw+1V8Ya5ZWLAOFsxpljH1Ilw/q30NNRLUvlkZ893rxhG3BTWf9THDsSdb?=
 =?us-ascii?Q?ChYEg7NE2UbdSIM5fXA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 16:13:32.5322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0063a849-5fe2-4fdb-f846-08de22cf9755
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9463

Entities' gart windows are contiguous so when copying a buffer
and src doesn't need a gart window, its window can be used to
extend dst one (and vice versa).

This doubles the gart window size and reduces the number of jobs
required.

---
v2: pass adev instead of ring to amdgpu_ttm_needs_gart_window
---

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 84 ++++++++++++++++++-------
 1 file changed, 62 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0a55bc4ea91f..9397459ec462 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -162,6 +162,21 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 	*placement = abo->placement;
 }
 
+static bool amdgpu_ttm_needs_gart_window(struct amdgpu_device *adev,
+					 struct ttm_resource *mem,
+					 struct amdgpu_res_cursor *mm_cur,
+					 bool tmz,
+					 uint64_t *addr)
+{
+	/* Map only what can't be accessed directly */
+	if (!tmz && mem->start != AMDGPU_BO_INVALID_OFFSET) {
+		*addr = amdgpu_ttm_domain_start(adev, mem->mem_type) +
+			mm_cur->start;
+		return false;
+	}
+	return true;
+}
+
 /**
  * amdgpu_ttm_map_buffer - Map memory into the GART windows
  * @entity: entity to run the window setup job
@@ -169,6 +184,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
  * @mem: memory object to map
  * @mm_cur: range to map
  * @window: which GART window to use
+ * @use_two_windows: if true, use a double window
  * @ring: DMA ring to use for the copy
  * @tmz: if we should setup a TMZ enabled mapping
  * @size: in number of bytes to map, out number of bytes mapped
@@ -182,7 +198,9 @@ static int amdgpu_ttm_map_buffer(struct drm_sched_entity *entity,
 				 struct ttm_buffer_object *bo,
 				 struct ttm_resource *mem,
 				 struct amdgpu_res_cursor *mm_cur,
-				 unsigned int window, struct amdgpu_ring *ring,
+				 unsigned int window,
+				 bool use_two_windows,
+				 struct amdgpu_ring *ring,
 				 bool tmz, uint64_t *size, uint64_t *addr,
 				 struct dma_fence *dep,
 				 struct dma_resv *resv)
@@ -202,13 +220,8 @@ static int amdgpu_ttm_map_buffer(struct drm_sched_entity *entity,
 	if (WARN_ON(mem->mem_type == AMDGPU_PL_PREEMPT))
 		return -EINVAL;
 
-	/* Map only what can't be accessed directly */
-	if (!tmz && mem->start != AMDGPU_BO_INVALID_OFFSET) {
-		*addr = amdgpu_ttm_domain_start(adev, mem->mem_type) +
-			mm_cur->start;
+	if (!amdgpu_ttm_needs_gart_window(adev, mem, mm_cur, tmz, addr))
 		return 0;
-	}
-
 
 	/*
 	 * If start begins at an offset inside the page, then adjust the size
@@ -217,7 +230,8 @@ static int amdgpu_ttm_map_buffer(struct drm_sched_entity *entity,
 	offset = mm_cur->start & ~PAGE_MASK;
 
 	num_pages = PFN_UP(*size + offset);
-	num_pages = min_t(uint32_t, num_pages, AMDGPU_GTT_MAX_TRANSFER_SIZE);
+	num_pages = min_t(uint32_t,
+		num_pages, AMDGPU_GTT_MAX_TRANSFER_SIZE * (use_two_windows ? 2 : 1));
 
 	*size = min(*size, (uint64_t)num_pages * PAGE_SIZE - offset);
 
@@ -308,8 +322,11 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 				      struct dma_resv *resv,
 				      struct dma_fence **f)
 {
+
+	bool src_needs_gart_window, dst_needs_gart_window, use_two_gart_windows;
 	struct amdgpu_ring *ring;
 	struct amdgpu_res_cursor src_mm, dst_mm;
+	int src_gart_window, dst_gart_window;
 	struct dma_fence *fence = NULL;
 	int r = 0;
 	uint32_t copy_flags = 0;
@@ -335,20 +352,43 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 		/* Never copy more than 256MiB at once to avoid a timeout */
 		cur_size = min3(src_mm.size, dst_mm.size, 256ULL << 20);
 
-		/* Map src to window 0 and dst to window 1. */
-		r = amdgpu_ttm_map_buffer(&entity->base,
-					  src->bo, src->mem, &src_mm,
-					  entity->gart_window_id0, ring, tmz, &cur_size, &from,
-					  NULL, NULL);
-		if (r)
-			goto error;
+		/* If only one direction needs a gart window to access memory, use both
+		 * windows for it.
+		 */
+		src_needs_gart_window =
+			amdgpu_ttm_needs_gart_window(adev, src->mem, &src_mm, tmz, &from);
+		dst_needs_gart_window =
+			amdgpu_ttm_needs_gart_window(adev, dst->mem, &dst_mm, tmz, &to);
 
-		r = amdgpu_ttm_map_buffer(&entity->base,
-					  dst->bo, dst->mem, &dst_mm,
-					  entity->gart_window_id1, ring, tmz, &cur_size, &to,
-					  NULL, NULL);
-		if (r)
-			goto error;
+		if (src_needs_gart_window) {
+			src_gart_window = entity->gart_window_id0;
+			use_two_gart_windows = !dst_needs_gart_window;
+		}
+		if (dst_needs_gart_window) {
+			dst_gart_window = src_needs_gart_window ?
+				entity->gart_window_id1 : entity->gart_window_id0;
+			use_two_gart_windows = !src_needs_gart_window;
+		}
+
+		if (src_needs_gart_window) {
+			r = amdgpu_ttm_map_buffer(&entity->base,
+						  src->bo, src->mem, &src_mm,
+						  src_gart_window, use_two_gart_windows,
+						  ring, tmz, &cur_size, &from,
+						  NULL, NULL);
+			if (r)
+				goto error;
+		}
+
+		if (dst_needs_gart_window) {
+			r = amdgpu_ttm_map_buffer(&entity->base,
+						  dst->bo, dst->mem, &dst_mm,
+						  dst_gart_window, use_two_gart_windows,
+						  ring, tmz, &cur_size, &to,
+						  NULL, NULL);
+			if (r)
+				goto error;
+		}
 
 		abo_src = ttm_to_amdgpu_bo(src->bo);
 		abo_dst = ttm_to_amdgpu_bo(dst->bo);
@@ -2476,7 +2516,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
 
 		r = amdgpu_ttm_map_buffer(&entity->base,
 					  &bo->tbo, bo->tbo.resource, &dst,
-					  entity->gart_window_id1, ring, false,
+					  entity->gart_window_id1, false, ring, false,
 					  &cur_size, &to,
 					  dependency,
 					  resv);
-- 
2.43.0


