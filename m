Return-Path: <linux-kernel+bounces-842281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 065C8BB967F
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 15:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98753B91E0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 13:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055AB26463A;
	Sun,  5 Oct 2025 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SQZHt57C"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6FC7483
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669396; cv=none; b=W8N0sZZ6hUXk1nwMXJ1syJ1tPbxeEuiAIi83t2aQNQck+vs0ix1NmqdJfaHaTJm9lp0KT+SQ9fETYi1FaKpZai5nq7n32AbBBaSPSw7/34h97FsrLZkBtkrl/wqLuqqf/qkxuAj9dwL6YtgTj7B4l/LzLFgg/t81RbSF8bM2UoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669396; c=relaxed/simple;
	bh=FvrH+3aJxrA4aLXH/Nmy63niNBpgyQ0KUCdej2/z7eU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l9Bfu8qY1uB1igP6GXAa68KAVVkdVeOxsSqoxKVrfqT4guM1T2GWlrPKvNdWqWqohhGR+fYI5rcuvGIgfzNLuKtQUaPercXumYnbGQRdWQiUC3FGKJxMxtBcbR6Js36hIJK6/zFNO16ti6mCo8nHl/1wjJyL39erWN/cTlOEd30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SQZHt57C; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759669386;
	bh=FvrH+3aJxrA4aLXH/Nmy63niNBpgyQ0KUCdej2/z7eU=;
	h=From:To:Cc:Subject:Date:From;
	b=SQZHt57C+EwgKJpvzLH+8UZFz3MG6bL7pho9WA6Jz/iThwWDQzrEXxu6LYij8/YzZ
	 qA1k3driC6QgNHjrrW7pISAsB7Xf3pMtp95WvSYaLNb6b1HhsZupuDN9ClEdGT+h8B
	 wy2thHPCN1D4Bz16MpMnBVB7kaS4y1RkCC/yZSnsNkXLbkoJqvfTgewvIJExxPG3ba
	 yGNW8vnPQB6uCWuQwiijfK3A3eV1VhCsc72ndKf69FsbwErTDY9cE5sGTH6oAMuB2J
	 JQMxLnhHyyuA2sycfcnaXA0eO+m424ow2N+wJFZDHafRQ/x1I+/qtzukBg8craCh/J
	 EZFfopqbxnEyA==
Received: from localhost.localdomain (unknown [92.206.120.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gerddie)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 23CED17E0AC3;
	Sun,  5 Oct 2025 15:03:06 +0200 (CEST)
From: Gert Wollny <gert.wollny@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Gert Wollny <gert.wollny@collabora.com>
Subject: [PATCH] drm/radeon: fix allocation of ring memory in *copy_dma
Date: Sun,  5 Oct 2025 15:04:54 +0200
Message-ID: <20251005130454.11322-1-gert.wollny@collabora.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running e.g. many deqp-gles31 tests in parallel kernel
warnings
 "radeon: writing more dwords to the ring than expected!"
are issued.
On evergree this happens because in evengreen_copy_dma not
enough space is allocated in the ring memory, i.e. the amount
of allocated memory only accounts for one possible wait
semaphore and doesn't take the padding of the ring buffer
into account.
The code suggest that in r600_copy_dma and rv770_copy_dma
the same problem exists.

Fix this by assuming the worst case, i.e. that RADEON_NUM_SYNCS
wait semaphores need to be emitted and take also the padding
into account.

The patch fixes the issue in evengreen_copy_dma, r600_copy_dma,
and rv770_copy_dma.

Signed-off-by: Gert Wollny <gert.wollny@collabora.com>
---
 drivers/gpu/drm/radeon/evergreen_dma.c | 13 +++++++++++--
 drivers/gpu/drm/radeon/r600_dma.c      | 13 +++++++++++--
 drivers/gpu/drm/radeon/rv770_dma.c     | 13 +++++++++++--
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen_dma.c b/drivers/gpu/drm/radeon/evergreen_dma.c
index 52c79da1ecf5..1f07ee6f3f6a 100644
--- a/drivers/gpu/drm/radeon/evergreen_dma.c
+++ b/drivers/gpu/drm/radeon/evergreen_dma.c
@@ -113,7 +113,7 @@ struct radeon_fence *evergreen_copy_dma(struct radeon_device *rdev,
 	struct radeon_sync sync;
 	int ring_index = rdev->asic->copy.dma_ring_index;
 	struct radeon_ring *ring = &rdev->ring[ring_index];
-	u32 size_in_dw, cur_size_in_dw;
+	u32 size_in_dw, cur_size_in_dw, ring_size_reserve;
 	int i, num_loops;
 	int r = 0;
 
@@ -121,7 +121,16 @@ struct radeon_fence *evergreen_copy_dma(struct radeon_device *rdev,
 
 	size_in_dw = (num_gpu_pages << RADEON_GPU_PAGE_SHIFT) / 4;
 	num_loops = DIV_ROUND_UP(size_in_dw, 0xfffff);
-	r = radeon_ring_lock(rdev, ring, num_loops * 5 + 11);
+
+	/* Worst case needed dwords:
+	 *  - 3 * RADEON_NUM_SYNCS for semaphore waits
+	 *  - 5 * num_loops for copy packages
+	 *  - 8 for fence
+	 * Finally, the block align block size to account for padding.
+	 */
+	ring_size_reserve = __ALIGN_MASK(RADEON_NUM_SYNCS * 3 + num_loops * 5 + 8,
+					 ring->align_mask);
+	r = radeon_ring_lock(rdev, ring, ring_size_reserve);
 	if (r) {
 		DRM_ERROR("radeon: moving bo (%d).\n", r);
 		radeon_sync_free(rdev, &sync, NULL);
diff --git a/drivers/gpu/drm/radeon/r600_dma.c b/drivers/gpu/drm/radeon/r600_dma.c
index 89ca2738c5d4..d55b0d721fb0 100644
--- a/drivers/gpu/drm/radeon/r600_dma.c
+++ b/drivers/gpu/drm/radeon/r600_dma.c
@@ -449,7 +449,7 @@ struct radeon_fence *r600_copy_dma(struct radeon_device *rdev,
 	struct radeon_sync sync;
 	int ring_index = rdev->asic->copy.dma_ring_index;
 	struct radeon_ring *ring = &rdev->ring[ring_index];
-	u32 size_in_dw, cur_size_in_dw;
+	u32 size_in_dw, cur_size_in_dw, ring_size_reserve;
 	int i, num_loops;
 	int r = 0;
 
@@ -457,7 +457,16 @@ struct radeon_fence *r600_copy_dma(struct radeon_device *rdev,
 
 	size_in_dw = (num_gpu_pages << RADEON_GPU_PAGE_SHIFT) / 4;
 	num_loops = DIV_ROUND_UP(size_in_dw, 0xFFFE);
-	r = radeon_ring_lock(rdev, ring, num_loops * 4 + 8);
+
+	/* Worst case needed dwords:
+	 *  - 3 * RADEON_NUM_SYNCS for semaphore waits
+	 *  - 4 * num_loops for copy packages
+	 *  - 5 for fence
+	 * Finally, the block align block size to account for padding.
+	 */
+	ring_size_reserve = __ALIGN_MASK(RADEON_NUM_SYNCS * 3 + num_loops * 4 + 5,
+					 ring->align_mask);
+	r = radeon_ring_lock(rdev, ring, ring_size_reserve);
 	if (r) {
 		DRM_ERROR("radeon: moving bo (%d).\n", r);
 		radeon_sync_free(rdev, &sync, NULL);
diff --git a/drivers/gpu/drm/radeon/rv770_dma.c b/drivers/gpu/drm/radeon/rv770_dma.c
index 4c91614b5e70..c28c11a91e07 100644
--- a/drivers/gpu/drm/radeon/rv770_dma.c
+++ b/drivers/gpu/drm/radeon/rv770_dma.c
@@ -48,7 +48,7 @@ struct radeon_fence *rv770_copy_dma(struct radeon_device *rdev,
 	struct radeon_sync sync;
 	int ring_index = rdev->asic->copy.dma_ring_index;
 	struct radeon_ring *ring = &rdev->ring[ring_index];
-	u32 size_in_dw, cur_size_in_dw;
+	u32 size_in_dw, cur_size_in_dw, ring_size_reserve;
 	int i, num_loops;
 	int r = 0;
 
@@ -56,7 +56,16 @@ struct radeon_fence *rv770_copy_dma(struct radeon_device *rdev,
 
 	size_in_dw = (num_gpu_pages << RADEON_GPU_PAGE_SHIFT) / 4;
 	num_loops = DIV_ROUND_UP(size_in_dw, 0xFFFF);
-	r = radeon_ring_lock(rdev, ring, num_loops * 5 + 8);
+
+	/* Worst case needed dwords:
+	 *  - 3 * RADEON_NUM_SYNCS for semaphore waits
+	 *  - 5 * num_loops for copy packages
+	 *  - 5 for fence
+	 * Finally, the block align block size to account for padding.
+	 */
+	ring_size_reserve = __ALIGN_MASK(
+		RADEON_NUM_SYNCS * 3 + num_loops * 5 + 5, ring->align_mask);
+	r = radeon_ring_lock(rdev, ring, ring_size_reserve);
 	if (r) {
 		DRM_ERROR("radeon: moving bo (%d).\n", r);
 		radeon_sync_free(rdev, &sync, NULL);
-- 
2.49.1


