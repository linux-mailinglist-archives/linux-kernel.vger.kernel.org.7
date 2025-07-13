Return-Path: <linux-kernel+bounces-729101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B26F6B031BD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 17:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00DD1891ACB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 15:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDC9277CBC;
	Sun, 13 Jul 2025 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="oAq5JOJN"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E95E27933A
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752420342; cv=none; b=J+3xCdkG5IUJJdYt3oHpxxP565l1cUHV04CYHvVkpbLl90TZzcJqSNbWDtGPldDozWKEhd0YkBlvBowKNXu+uKSy+KvtZoB2NHmK4pcPQwsrQieTYnOKrUhC07Pw1WCoAD7vcXJfm1uot1jgsAsSOtOzrV8rjuzG4s3URcLDGFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752420342; c=relaxed/simple;
	bh=KJK/eU3vWyI0nfIUbbfl4FnVoZQdOD8YNkbUY5g2VzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dCVHqeNqlROo9auwCCTPN1JQPMQsPj4oKdxSLRe6iL8ZjMWWMZ05AZSVNxpu0wotcw70TrIeFT2CogAWpStng7f2dZLAnTAAi7+jgnHzdnztJXqa8M7hKSvURZVQhByh2N9sSHNDMAW20GrsDC/dgzeNTNfARd2r8FpLKWHuNHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=oAq5JOJN; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=hrUEXgHrTFqR2/M0VCKko4fRT0H3nYWu5evkl7GPZJU=; b=oAq5JOJNqcvnZEQO
	CRHFT1z/n9pD8hLRqH/Ta5/V0QAacxQvRxKRewAP4hdLxdCBj2/CTD2NbweedqPHpAlnMF/7e4xSh
	B2jeYar1pgD265IjjJAd1j4mHR0qJj9I08A4rSG4ayD6fHirf5jgInC0KVeek6hhlEKN4rBQr9rpS
	1S78vHSVHxTT0UZTrsV4iGnEbmMGuIeQ2y3FyQsF0f1fq9k8M5WOYY2oj+rAwjCGuOWBub8lc51zh
	Qs41+e00BOVXUEEOPeR2dCxBvh3FiAP11OyjPJNa4zn404eG8FJYN6q0WwqD1Utv7MMBIgsNVctLh
	BbaqviksuN3tHM9SiA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uaya4-00FnPv-19;
	Sun, 13 Jul 2025 15:25:32 +0000
From: linux@treblig.org
To: lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] drm/xe: Remove unused functions
Date: Sun, 13 Jul 2025 16:25:31 +0100
Message-ID: <20250713152531.219326-1-linux@treblig.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

xe_bo_create_from_data() last use was removed in 2023 by
commit 0e1a47fcabc8 ("drm/xe: Add a helper for DRM device-lifetime BO
create")

xe_rtp_match_first_gslice_fused_off() last use was removed in 2023 by
commit 4e124151fcfc ("drm/xe/dg2: Drop pre-production workarounds")

Remove them, and xe_dss_mask_empty whose last use was by
xe_rtp_match_first_gslice_fused_off().

(Xe has a bunch ofother symbols that have been added but not used,
given how new it is, I've left those, as opposed to these that
had the code that used them removed).

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/xe/xe_bo.c          | 15 ---------------
 drivers/gpu/drm/xe/xe_bo.h          |  3 ---
 drivers/gpu/drm/xe/xe_gt_topology.c |  5 -----
 drivers/gpu/drm/xe/xe_gt_topology.h |  2 --
 drivers/gpu/drm/xe/xe_rtp.c         | 15 ---------------
 drivers/gpu/drm/xe/xe_rtp.h         | 11 -----------
 6 files changed, 51 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 7aa2c17825da..6bd1287869b4 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -2156,21 +2156,6 @@ struct xe_bo *xe_bo_create_pin_map(struct xe_device *xe, struct xe_tile *tile,
 	return xe_bo_create_pin_map_at(xe, tile, vm, size, ~0ull, type, flags);
 }
 
-struct xe_bo *xe_bo_create_from_data(struct xe_device *xe, struct xe_tile *tile,
-				     const void *data, size_t size,
-				     enum ttm_bo_type type, u32 flags)
-{
-	struct xe_bo *bo = xe_bo_create_pin_map(xe, tile, NULL,
-						ALIGN(size, PAGE_SIZE),
-						type, flags);
-	if (IS_ERR(bo))
-		return bo;
-
-	xe_map_memcpy_to(xe, &bo->vmap, 0, data, size);
-
-	return bo;
-}
-
 static void __xe_bo_unpin_map_no_vm(void *arg)
 {
 	xe_bo_unpin_map_no_vm(arg);
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 02ada1fb8a23..89b6e1487971 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -118,9 +118,6 @@ struct xe_bo *xe_bo_create_pin_map_at_aligned(struct xe_device *xe,
 					      size_t size, u64 offset,
 					      enum ttm_bo_type type, u32 flags,
 					      u64 alignment);
-struct xe_bo *xe_bo_create_from_data(struct xe_device *xe, struct xe_tile *tile,
-				     const void *data, size_t size,
-				     enum ttm_bo_type type, u32 flags);
 struct xe_bo *xe_managed_bo_create_pin_map(struct xe_device *xe, struct xe_tile *tile,
 					   size_t size, u32 flags);
 struct xe_bo *xe_managed_bo_create_from_data(struct xe_device *xe, struct xe_tile *tile,
diff --git a/drivers/gpu/drm/xe/xe_gt_topology.c b/drivers/gpu/drm/xe/xe_gt_topology.c
index 516c81e3b8dd..b325eb9d3890 100644
--- a/drivers/gpu/drm/xe/xe_gt_topology.c
+++ b/drivers/gpu/drm/xe/xe_gt_topology.c
@@ -288,11 +288,6 @@ xe_dss_mask_group_ffs(const xe_dss_mask_t mask, int groupsize, int groupnum)
 	return find_next_bit(mask, XE_MAX_DSS_FUSE_BITS, groupnum * groupsize);
 }
 
-bool xe_dss_mask_empty(const xe_dss_mask_t mask)
-{
-	return bitmap_empty(mask, XE_MAX_DSS_FUSE_BITS);
-}
-
 /**
  * xe_gt_topology_has_dss_in_quadrant - check fusing of DSS in GT quadrant
  * @gt: GT to check
diff --git a/drivers/gpu/drm/xe/xe_gt_topology.h b/drivers/gpu/drm/xe/xe_gt_topology.h
index a72d26ba0653..c8140704ad4c 100644
--- a/drivers/gpu/drm/xe/xe_gt_topology.h
+++ b/drivers/gpu/drm/xe/xe_gt_topology.h
@@ -41,8 +41,6 @@ xe_gt_topology_mask_last_dss(const xe_dss_mask_t mask)
 unsigned int
 xe_dss_mask_group_ffs(const xe_dss_mask_t mask, int groupsize, int groupnum);
 
-bool xe_dss_mask_empty(const xe_dss_mask_t mask);
-
 bool
 xe_gt_topology_has_dss_in_quadrant(struct xe_gt *gt, int quad);
 
diff --git a/drivers/gpu/drm/xe/xe_rtp.c b/drivers/gpu/drm/xe/xe_rtp.c
index 29e694bb1219..cc6636f6cd98 100644
--- a/drivers/gpu/drm/xe/xe_rtp.c
+++ b/drivers/gpu/drm/xe/xe_rtp.c
@@ -326,21 +326,6 @@ bool xe_rtp_match_first_render_or_compute(const struct xe_gt *gt,
 		hwe->engine_id == __ffs(render_compute_mask);
 }
 
-bool xe_rtp_match_first_gslice_fused_off(const struct xe_gt *gt,
-					 const struct xe_hw_engine *hwe)
-{
-	unsigned int dss_per_gslice = 4;
-	unsigned int dss;
-
-	if (drm_WARN(&gt_to_xe(gt)->drm, xe_dss_mask_empty(gt->fuse_topo.g_dss_mask),
-		     "Checking gslice for platform without geometry pipeline\n"))
-		return false;
-
-	dss = xe_dss_mask_group_ffs(gt->fuse_topo.g_dss_mask, 0, 0);
-
-	return dss >= dss_per_gslice;
-}
-
 bool xe_rtp_match_not_sriov_vf(const struct xe_gt *gt,
 			       const struct xe_hw_engine *hwe)
 {
diff --git a/drivers/gpu/drm/xe/xe_rtp.h b/drivers/gpu/drm/xe/xe_rtp.h
index 4fe736a11c42..86a3f1e4b3dc 100644
--- a/drivers/gpu/drm/xe/xe_rtp.h
+++ b/drivers/gpu/drm/xe/xe_rtp.h
@@ -465,17 +465,6 @@ bool xe_rtp_match_even_instance(const struct xe_gt *gt,
 bool xe_rtp_match_first_render_or_compute(const struct xe_gt *gt,
 					  const struct xe_hw_engine *hwe);
 
-/*
- * xe_rtp_match_first_gslice_fused_off - Match when first gslice is fused off
- *
- * @gt: GT structure
- * @hwe: Engine instance
- *
- * Returns: true if first gslice is fused off, false otherwise.
- */
-bool xe_rtp_match_first_gslice_fused_off(const struct xe_gt *gt,
-					 const struct xe_hw_engine *hwe);
-
 /*
  * xe_rtp_match_not_sriov_vf - Match when not on SR-IOV VF device
  *
-- 
2.50.1


