Return-Path: <linux-kernel+bounces-761136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CFFB1F4D6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 15:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315D97B420B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BFE27781E;
	Sat,  9 Aug 2025 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHyazKfH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C510029DB81
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754747538; cv=none; b=bkcIYtqfKDjp7AaXQ5Cm3RPs16pPkDxyU1rxQ+b2SiWAKOzjQ23LgeY5dgJw5ukYWMoXbWu4fv2OYNzCR+c33Jqdv2kaUDwM8fBcjDpTuuNDCjUTFh19V4kNFGfvGYe6vU6G+sZUlv9MjnYClJiu5p5EBdIERE7yGwPO/hQqp74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754747538; c=relaxed/simple;
	bh=M1dPRbREHCZNm03J/0kaw2ckl1FuinNQkvsu+9otm4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyoZe5W2s2jBBxwQw4ckZOqg4djCXuFzbzT2TLyZZruL4EBsWYmZAbDBT+fWh3eGmvpBtD9PR6DvxF+JEL9n5XSl2t9kEX3ROJgOkf3iMtAM2TGN5nVGEUyVLy4UkW0QYTkmOTJkQxXl97qFIVLocg+3dJqcp6rkeH7CrLkK1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHyazKfH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754747537; x=1786283537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M1dPRbREHCZNm03J/0kaw2ckl1FuinNQkvsu+9otm4E=;
  b=KHyazKfHOVdFBagKMI6boSzRKAElOs5EtZ57CpK90ETS2B+9pRx9t7UK
   DwBmzeMozNc1tzUYhUhj7nBSLcNqYL5khbLKxe5OsVgEhoJcYB8riOxtp
   sOqkGRgPhr9d7ReHshZQJwXYSI4ZVqgZGhqmfbycYlx6Lzq2IxUFQk7mn
   w1Y81pxHW3WgAY9+Ro/FGLC9ughpaHw5FKkW+2XCV3i5Ic/P/DSPC/RPQ
   VFPpKKa2+IhZjlGMpNy6cy3+aleNrPww2OWTPwG+nYTz5tOgsz4XcEN9z
   al1JvWQUXWPK9PhsE8qiAc1JDtfKZFvpE92S41/qWfXKww6I90Qr3T3su
   w==;
X-CSE-ConnectionGUID: zxytRrHmRtm9r45FIoEfbA==
X-CSE-MsgGUID: X3lsUGLwSGyRRwe/os6CbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="68153555"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68153555"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2025 06:52:16 -0700
X-CSE-ConnectionGUID: wW5KpTcnRz+LewKSRZMlhQ==
X-CSE-MsgGUID: axquRza3SkGznZ/c7UT2LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165903751"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fedora) ([10.245.244.28])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2025 06:52:14 -0700
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
Subject: [RFC PATCH 2/6] drm/gpusvm: Update GPU SVM / Xe to twopass MMU notifier
Date: Sat,  9 Aug 2025 15:51:33 +0200
Message-ID: <20250809135137.259427-3-thomas.hellstrom@linux.intel.com>
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

Update GPU SVM and Xe to use two-pass MMU notifiers, enabling pipelined
TLB invalidations across VMs or multiple devices.

The driver-side (Xe) implementation is not yet implemented.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 18 +++++++++++-------
 drivers/gpu/drm/xe/xe_svm.c  |  9 +++++----
 include/drm/drm_gpusvm.h     | 11 +++++++----
 3 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 661306da6b2d..92dc7d2bd6cf 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -374,10 +374,13 @@ notifier_iter_first(struct rb_root_cached *root, unsigned long start,
 	     (notifier__) = (next__), (next__) = __drm_gpusvm_notifier_next(notifier__))
 
 /**
- * drm_gpusvm_notifier_invalidate() - Invalidate a GPU SVM notifier.
+ * drm_gpusvm_notifier_invalidate_twopass() - Invalidate a GPU SVM notifie,
+ * fist pass.
+ *
  * @mni: Pointer to the mmu_interval_notifier structure.
  * @mmu_range: Pointer to the mmu_notifier_range structure.
  * @cur_seq: Current sequence number.
+ * @pass: First pass of MMU notifier
  *
  * This function serves as a generic MMU notifier for GPU SVM. It sets the MMU
  * notifier sequence number and calls the driver invalidate vfunc under
@@ -386,9 +389,10 @@ notifier_iter_first(struct rb_root_cached *root, unsigned long start,
  * Return: true if the operation succeeds, false otherwise.
  */
 static bool
-drm_gpusvm_notifier_invalidate(struct mmu_interval_notifier *mni,
-			       const struct mmu_notifier_range *mmu_range,
-			       unsigned long cur_seq)
+drm_gpusvm_notifier_invalidate_twopass(struct mmu_interval_notifier *mni,
+				       const struct mmu_notifier_range *mmu_range,
+				       unsigned long cur_seq,
+				       struct mmu_interval_notifier_pass **pass)
 {
 	struct drm_gpusvm_notifier *notifier =
 		container_of(mni, typeof(*notifier), notifier);
@@ -399,7 +403,7 @@ drm_gpusvm_notifier_invalidate(struct mmu_interval_notifier *mni,
 
 	down_write(&gpusvm->notifier_lock);
 	mmu_interval_set_seq(mni, cur_seq);
-	gpusvm->ops->invalidate(gpusvm, notifier, mmu_range);
+	gpusvm->ops->invalidate_twopass(gpusvm, notifier, mmu_range, pass);
 	up_write(&gpusvm->notifier_lock);
 
 	return true;
@@ -409,7 +413,7 @@ drm_gpusvm_notifier_invalidate(struct mmu_interval_notifier *mni,
  * drm_gpusvm_notifier_ops - MMU interval notifier operations for GPU SVM
  */
 static const struct mmu_interval_notifier_ops drm_gpusvm_notifier_ops = {
-	.invalidate = drm_gpusvm_notifier_invalidate,
+	.invalidate_twopass = drm_gpusvm_notifier_invalidate_twopass,
 };
 
 /**
@@ -440,7 +444,7 @@ int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
 		    const struct drm_gpusvm_ops *ops,
 		    const unsigned long *chunk_sizes, int num_chunks)
 {
-	if (!ops->invalidate || !num_chunks)
+	if (!ops->invalidate_twopass || !num_chunks)
 		return -EINVAL;
 
 	gpusvm->name = name;
diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index e35c6d4def20..23c5b363261c 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -171,9 +171,10 @@ xe_svm_range_notifier_event_end(struct xe_vm *vm, struct drm_gpusvm_range *r,
 						   mmu_range);
 }
 
-static void xe_svm_invalidate(struct drm_gpusvm *gpusvm,
-			      struct drm_gpusvm_notifier *notifier,
-			      const struct mmu_notifier_range *mmu_range)
+static void xe_svm_invalidate_twopass(struct drm_gpusvm *gpusvm,
+				      struct drm_gpusvm_notifier *notifier,
+				      const struct mmu_notifier_range *mmu_range,
+				      struct mmu_interval_notifier_pass **p)
 {
 	struct xe_vm *vm = gpusvm_to_vm(gpusvm);
 	struct xe_device *xe = vm->xe;
@@ -553,7 +554,7 @@ static const struct drm_pagemap_devmem_ops dpagemap_devmem_ops = {
 static const struct drm_gpusvm_ops gpusvm_ops = {
 	.range_alloc = xe_svm_range_alloc,
 	.range_free = xe_svm_range_free,
-	.invalidate = xe_svm_invalidate,
+	.invalidate_twopass = xe_svm_invalidate_twopass,
 };
 
 static const unsigned long fault_chunk_sizes[] = {
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index 8d613e9b2690..8b5e159857fc 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -63,17 +63,20 @@ struct drm_gpusvm_ops {
 	void (*range_free)(struct drm_gpusvm_range *range);
 
 	/**
-	 * @invalidate: Invalidate GPU SVM notifier (required)
+	 * @invalidate_twopass: Invalidate first pass GPU SVM notifier (required)
 	 * @gpusvm: Pointer to the GPU SVM
 	 * @notifier: Pointer to the GPU SVM notifier
 	 * @mmu_range: Pointer to the mmu_notifier_range structure
+	 * @pass: Pass of MMU notifier, optionally populated driver side
+	 * if a second pass of MMU notifier is desired
 	 *
 	 * Invalidate the GPU page tables. It can safely walk the notifier range
 	 * RB tree/list in this function. Called while holding the notifier lock.
 	 */
-	void (*invalidate)(struct drm_gpusvm *gpusvm,
-			   struct drm_gpusvm_notifier *notifier,
-			   const struct mmu_notifier_range *mmu_range);
+	void (*invalidate_twopass)(struct drm_gpusvm *gpusvm,
+				   struct drm_gpusvm_notifier *notifier,
+				   const struct mmu_notifier_range *mmu_range,
+				   struct mmu_interval_notifier_pass **pass);
 };
 
 /**
-- 
2.50.1


