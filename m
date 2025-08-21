Return-Path: <linux-kernel+bounces-779673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE56AB2F70C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770521CE15E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136BF2DFA48;
	Thu, 21 Aug 2025 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8trKXeg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49A0311961
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776826; cv=none; b=MmVmGOBOHAup5YvqPW0Vie5ztWJcK1ZBcBQHVJ8943ufM5QY49s4TF2ZvShiv2n8T3aXZWet9edqCDOmoG5Cog0D1Lw08TNTsGC8Nujtr2pu6AD43LeUvlBeJK3FJG1f6jveIoz8q14FYN3OAjgXbePlU7RW2L4Jt6tz5lz+7Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776826; c=relaxed/simple;
	bh=iJneFFGjQzLecO0NbP6dLUmEON+W6rvWnRMxdzIQpkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMPpPlIkEtXzpf5hX0LCkYYQ4Ub2C3DthO6afOh2RD0giBQIo6fWrYgt+iGPITm+MKmYQAxKk9xa1w0Lqc5IJWk9bs02BQ6aQ4CQef5oKOzPA83jAHBe2uWNZVfubiOSD3L9yIrFRxmjpXswx6gMU74IoLls389tlbbuiY1MYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8trKXeg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755776825; x=1787312825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iJneFFGjQzLecO0NbP6dLUmEON+W6rvWnRMxdzIQpkM=;
  b=l8trKXegGvDTJpgBYQlgtz2Ku6AVBrpCxmLutEE/CSl129AbsxeQ+4Xn
   iiRiUtL0AEYnVaxWoMYdCFEy/m3Nsr988I1zO2fT8afmKfLefiGfIO/do
   RPuruct6CWcMkpH5MfivLwaPtx8oiH4Y+KuSKX0Ci+Uo71RfWLWtETd4U
   um7KyGGMLbkxg4T338MgXiD+7lHJseyuTgA5Hm0wbIK+zEOiHgJp/4bCv
   pGD1qfnA5B4qpXHnoTFWD71pqo8u+q+zD3djUgMJlPKJCd3bMZavjFBa0
   72UjBJdmREBLU5RRDXpTyRdim8kTX0C59ltRSC2/TnB/IEFLkjp5r4tA0
   Q==;
X-CSE-ConnectionGUID: JNBKTwhoT2eZk9rpzNv4+w==
X-CSE-MsgGUID: D/SHWDEsSl2x0Em1tVsV/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57989491"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="57989491"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 04:47:05 -0700
X-CSE-ConnectionGUID: m/oDoepnQumFqMGRpcZkOw==
X-CSE-MsgGUID: xiY/gQ3BRTuN2LEm+B2oOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172613664"
Received: from johunt-mobl9.ger.corp.intel.com (HELO fedora) ([10.245.245.201])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 04:47:02 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dave Airlie <airlied@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] drm/xe: Implement two pass MMU notifiers for SVM
Date: Thu, 21 Aug 2025 13:46:26 +0200
Message-ID: <20250821114626.89818-7-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821114626.89818-1-thomas.hellstrom@linux.intel.com>
References: <20250821114626.89818-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

Implement two-pass MMU notifiers for SVM, enabling multiple VMs or
devices with GPU mappings to pipeline costly TLB invalidations by
issuing them in the first pass and waiting for completion in the second.

v1:
- Adjust naming.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_svm.c | 73 +++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 5ef673b70575..a278c9dc5306 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -144,15 +144,8 @@ xe_svm_range_notifier_event_begin(struct xe_vm *vm, struct drm_gpusvm_range *r,
 	 * invalidations spanning multiple ranges.
 	 */
 	for_each_tile(tile, xe, id)
-		if (xe_pt_zap_ptes_range(tile, vm, range)) {
+		if (xe_pt_zap_ptes_range(tile, vm, range))
 			tile_mask |= BIT(id);
-			/*
-			 * WRITE_ONCE pairs with READ_ONCE in
-			 * xe_vm_has_valid_gpu_mapping()
-			 */
-			WRITE_ONCE(range->tile_invalidated,
-				   range->tile_invalidated | BIT(id));
-		}
 
 	return tile_mask;
 }
@@ -161,16 +154,59 @@ static void
 xe_svm_range_notifier_event_end(struct xe_vm *vm, struct drm_gpusvm_range *r,
 				const struct mmu_notifier_range *mmu_range)
 {
+	struct xe_svm_range *range = to_xe_range(r);
 	struct drm_gpusvm_ctx ctx = { .in_notifier = true, };
 
 	xe_svm_assert_in_notifier(vm);
 
+	/*
+	 * WRITE_ONCE pairs with READ_ONCE in xe_vm_has_valid_gpu_mapping()
+	 */
+	WRITE_ONCE(range->tile_invalidated, range->tile_present);
+
 	drm_gpusvm_range_unmap_pages(&vm->svm.gpusvm, r, &ctx);
 	if (!xe_vm_is_closed(vm) && mmu_range->event == MMU_NOTIFY_UNMAP)
 		xe_svm_garbage_collector_add_range(vm, to_xe_range(r),
 						   mmu_range);
 }
 
+struct xe_svm_invalidate_finish {
+	struct drm_gpusvm *gpusvm;
+	struct drm_gpusvm_notifier *notifier;
+#define XE_SVM_INVALIDATE_FENCE_COUNT	\
+	(XE_MAX_TILES_PER_DEVICE * XE_MAX_GT_PER_TILE)
+	struct xe_gt_tlb_invalidation_fence fences[XE_SVM_INVALIDATE_FENCE_COUNT];
+	struct mmu_interval_notifier_finish f;
+};
+
+static void
+xe_svm_invalidate_finish(struct mmu_interval_notifier_finish *final,
+			 const struct mmu_notifier_range *mmu_range,
+			 unsigned long cur_seq)
+{
+	struct xe_svm_invalidate_finish *xe_final = container_of(final, typeof(*xe_final), f);
+	struct drm_gpusvm *gpusvm = xe_final->gpusvm;
+	struct drm_gpusvm_notifier *notifier = xe_final->notifier;
+	struct drm_gpusvm_range *r = NULL;
+	struct xe_vm *vm = gpusvm_to_vm(gpusvm);
+	u64 adj_start = mmu_range->start, adj_end = mmu_range->end;
+	int id;
+
+	/* Adjust invalidation to notifier boundaries */
+	adj_start = max(drm_gpusvm_notifier_start(notifier), adj_start);
+	adj_end = min(drm_gpusvm_notifier_end(notifier), adj_end);
+
+	for (id = 0; id < XE_SVM_INVALIDATE_FENCE_COUNT; ++id)
+		xe_gt_tlb_invalidation_fence_wait(&xe_final->fences[id]);
+
+	drm_gpusvm_in_notifier_lock(gpusvm);
+	drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
+		xe_svm_range_notifier_event_end(vm, r, mmu_range);
+	drm_gpusvm_in_notifier_unlock(gpusvm);
+
+	kfree(xe_final);
+}
+
 static void xe_svm_invalidate_start(struct drm_gpusvm *gpusvm,
 				    struct drm_gpusvm_notifier *notifier,
 				    const struct mmu_notifier_range *mmu_range,
@@ -179,6 +215,8 @@ static void xe_svm_invalidate_start(struct drm_gpusvm *gpusvm,
 	struct xe_vm *vm = gpusvm_to_vm(gpusvm);
 	struct xe_device *xe = vm->xe;
 	struct drm_gpusvm_range *r, *first;
+	struct xe_svm_invalidate_finish *xe_final = NULL;
+	struct xe_gt_tlb_invalidation_fence *fences = NULL;
 	u64 adj_start = mmu_range->start, adj_end = mmu_range->end;
 	u8 tile_mask = 0;
 	long err;
@@ -226,14 +264,25 @@ static void xe_svm_invalidate_start(struct drm_gpusvm *gpusvm,
 
 	xe_device_wmb(xe);
 
-	err = xe_vm_range_tilemask_tlb_invalidation(vm, NULL, adj_start,
+	xe_final = kzalloc(sizeof(*xe_final), GFP_NOWAIT);
+	if (xe_final) {
+		xe_final->gpusvm = gpusvm;
+		xe_final->notifier = notifier;
+		xe_final->f.finish = xe_svm_invalidate_finish;
+		fences = xe_final->fences;
+		*final = &xe_final->f;
+	}
+
+	err = xe_vm_range_tilemask_tlb_invalidation(vm, fences, adj_start,
 						    adj_end, tile_mask);
 	WARN_ON_ONCE(err);
 
 range_notifier_event_end:
-	r = first;
-	drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
-		xe_svm_range_notifier_event_end(vm, r, mmu_range);
+	if (!xe_final) {
+		r = first;
+		drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
+			xe_svm_range_notifier_event_end(vm, r, mmu_range);
+	}
 }
 
 static int __xe_svm_garbage_collector(struct xe_vm *vm,
-- 
2.50.1


