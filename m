Return-Path: <linux-kernel+bounces-761139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E85FB1F4D9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 15:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2D056610E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 13:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1754D29CB40;
	Sat,  9 Aug 2025 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrZcuPEB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46BF2BD001
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754747545; cv=none; b=FXc0AkL2DGSxOHDJJbSOcty0JsMpccjTJlT5fBX5WSSKqfUXKV8JIgmov7xHkCsqvf9C2FxzerDD3v72sxv2k3GdLousd1OKEjQqITKJIO04arESPo7/z/i142zhv5Ypg1whNIbIOsRr6xQbKJ3t8nGo63q1I7pHtbic1k+4228=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754747545; c=relaxed/simple;
	bh=bt+QjLeCHx2Rrs4pAwueu1ZrAv3yQzvpcrOLeaDiagU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnLPIjDuUtVURuu2qSQW0aWu2jODx/oLY5xybu2B1GueuE0zktMC1PJdW1QThtdhIY64rUZVVuu7LRjASWO3g351H9LxnZGoi11A9eag/8uzkpbTNUVNhQLwkPT52uF0PO4q1ICSK2uK7kAIgYCGxcvprztA4lrI+1ve3mDiySw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrZcuPEB; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754747544; x=1786283544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bt+QjLeCHx2Rrs4pAwueu1ZrAv3yQzvpcrOLeaDiagU=;
  b=BrZcuPEBSO+MoCrXGLfHSg+CXjNp1MLPZuMFQX+vclW/aZ99WPIO5/X2
   NlY9WdOF7pQnRr+eZyM2PTjnQu5fcdbguqkKS1UQr/hvadIsMKTBGwdPV
   nD+Tbs8ZoHORASvdyvrE0AY7YVDmj1MTV3YChhBvSe0q5VHgtfOx0jTHY
   D7PvV5S3268PxlLZCOfOWprbdnLH9cKEzE1tt4BE6UpO2Q8S/DRXBEfgo
   HbDMWLyoYtCe+455amDpWdTSapBWIBWPqBIZCXgcxvXXhrhFmnlOiXIj2
   hTti9HCyDwknY/bQb+mK00EYGqfsnql7a+OgFauGo20QnKU1AjZxUOo2z
   g==;
X-CSE-ConnectionGUID: W4t88IFNTsGHKG/ZxKktYA==
X-CSE-MsgGUID: XQu1XBJvRVa1KiqyGqfE0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="68153585"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68153585"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2025 06:52:24 -0700
X-CSE-ConnectionGUID: 6+wTSiSvTz+Kr2Xn8p5B7A==
X-CSE-MsgGUID: UD2z8XlYQ1+G0MlHcfjemQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165903771"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fedora) ([10.245.244.28])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2025 06:52:21 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dave Airlie <airlied@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/6] drm/xe: Add fences argument to xe_vm_range_tilemask_tlb_invalidation
Date: Sat,  9 Aug 2025 15:51:36 +0200
Message-ID: <20250809135137.259427-6-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250809135137.259427-1-thomas.hellstrom@linux.intel.com>
References: <20250809135137.259427-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

Introduce a fences argument to xe_vm_range_tilemask_tlb_invalidation,
allowing callers to provide fences and defer waiting to a later point.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_svm.c |  3 ++-
 drivers/gpu/drm/xe/xe_vm.c  | 26 +++++++++++++++++---------
 drivers/gpu/drm/xe/xe_vm.h  |  6 ++++--
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 23c5b363261c..82a598c8d56e 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -226,7 +226,8 @@ static void xe_svm_invalidate_twopass(struct drm_gpusvm *gpusvm,
 
 	xe_device_wmb(xe);
 
-	err = xe_vm_range_tilemask_tlb_invalidation(vm, adj_start, adj_end, tile_mask);
+	err = xe_vm_range_tilemask_tlb_invalidation(vm, NULL, adj_start,
+						    adj_end, tile_mask);
 	WARN_ON_ONCE(err);
 
 range_notifier_event_end:
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 148a2425006f..52242fac6969 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3846,6 +3846,7 @@ void xe_vm_unlock(struct xe_vm *vm)
  * xe_vm_range_tilemask_tlb_invalidation - Issue a TLB invalidation on this tilemask for an
  * address range
  * @vm: The VM
+ * @fences: Caller provided fences, caller owns waiting if non-NULL
  * @start: start address
  * @end: end address
  * @tile_mask: mask for which gt's issue tlb invalidation
@@ -3854,10 +3855,12 @@ void xe_vm_unlock(struct xe_vm *vm)
  *
  * Returns 0 for success, negative error code otherwise.
  */
-int xe_vm_range_tilemask_tlb_invalidation(struct xe_vm *vm, u64 start,
-					  u64 end, u8 tile_mask)
+int xe_vm_range_tilemask_tlb_invalidation(struct xe_vm *vm,
+					  struct xe_gt_tlb_invalidation_fence *fences,
+					  u64 start, u64 end, u8 tile_mask)
 {
 	struct xe_gt_tlb_invalidation_fence fence[XE_MAX_TILES_PER_DEVICE * XE_MAX_GT_PER_TILE];
+	struct xe_gt_tlb_invalidation_fence *__fence = fences ?: fence;
 	struct xe_tile *tile;
 	u32 fence_id = 0;
 	u8 id;
@@ -3869,37 +3872,41 @@ int xe_vm_range_tilemask_tlb_invalidation(struct xe_vm *vm, u64 start,
 	for_each_tile(tile, vm->xe, id) {
 		if (tile_mask & BIT(id)) {
 			xe_gt_tlb_invalidation_fence_init(tile->primary_gt,
-							  &fence[fence_id], true);
+							 __fence, true);
 
 			err = xe_gt_tlb_invalidation_range(tile->primary_gt,
-							   &fence[fence_id],
+							   __fence,
 							   start,
 							   end,
 							   vm->usm.asid);
 			if (err)
 				goto wait;
 			++fence_id;
+			++__fence;
 
 			if (!tile->media_gt)
 				continue;
 
 			xe_gt_tlb_invalidation_fence_init(tile->media_gt,
-							  &fence[fence_id], true);
+							  __fence, true);
 
 			err = xe_gt_tlb_invalidation_range(tile->media_gt,
-							   &fence[fence_id],
+							   __fence,
 							   start,
 							   end,
 							   vm->usm.asid);
 			if (err)
 				goto wait;
 			++fence_id;
+			++__fence;
 		}
 	}
 
 wait:
-	for (id = 0; id < fence_id; ++id)
-		xe_gt_tlb_invalidation_fence_wait(&fence[id]);
+	if (!fences) {
+		for (id = 0; id < fence_id; ++id)
+			xe_gt_tlb_invalidation_fence_wait(&fence[id]);
+	}
 
 	return err;
 }
@@ -3958,7 +3965,8 @@ int xe_vm_invalidate_vma(struct xe_vma *vma)
 
 	xe_device_wmb(xe);
 
-	ret = xe_vm_range_tilemask_tlb_invalidation(xe_vma_vm(vma), xe_vma_start(vma),
+	ret = xe_vm_range_tilemask_tlb_invalidation(xe_vma_vm(vma), NULL,
+						    xe_vma_start(vma),
 						    xe_vma_end(vma), tile_mask);
 
 	/* WRITE_ONCE pairs with READ_ONCE in xe_vm_has_valid_gpu_mapping() */
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index 3475a118f666..d1c3c9aa8d03 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -22,6 +22,7 @@ struct dma_fence;
 
 struct xe_exec_queue;
 struct xe_file;
+struct xe_gt_tlb_invalidation_fence;
 struct xe_sync_entry;
 struct xe_svm_range;
 struct drm_exec;
@@ -228,8 +229,9 @@ struct dma_fence *xe_vm_range_rebind(struct xe_vm *vm,
 struct dma_fence *xe_vm_range_unbind(struct xe_vm *vm,
 				     struct xe_svm_range *range);
 
-int xe_vm_range_tilemask_tlb_invalidation(struct xe_vm *vm, u64 start,
-					  u64 end, u8 tile_mask);
+int xe_vm_range_tilemask_tlb_invalidation(struct xe_vm *vm,
+					  struct xe_gt_tlb_invalidation_fence *fences,
+					  u64 start, u64 end, u8 tile_mask);
 
 int xe_vm_invalidate_vma(struct xe_vma *vma);
 
-- 
2.50.1


