Return-Path: <linux-kernel+bounces-779668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391ABB2F70E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9741A178E01
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B21F2E11DC;
	Thu, 21 Aug 2025 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSLWgY+v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF6C2E03E6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776814; cv=none; b=s+g8m99D6dkzfe0Rsw+q4luMteS9vOtidn+0RICzKJG34uFEU/rd83j+93QEycCWRXTvkK6E9lMqaYnseaYP5WeyDZ+GfSG/spz4nRKUVdQGat+zLz4V9ykttymcejRSnR98uznXw89FQ8A+BeBgZl140yFGAln/OoXVL3Hk+l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776814; c=relaxed/simple;
	bh=9zPtk0Fd79KtAXSij4bOxVEarAOiqZpcZDvJQ12K1oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOdr9gZ29b7IjeTCetvqo4Yi+03VHaTce1FoknWNVdLB3BtOMNJ5wMHhAU6XGw5tO9PnLdjZkaKxEwMTDBv+FDqT+n/HcF5ShQH4QGntoBkWY1RglwlNHk9xXqMuKGqZ3TmBAZP5r74zrDsNLqZQbKN11KVFYILY9s+oe7DBprU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSLWgY+v; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755776813; x=1787312813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9zPtk0Fd79KtAXSij4bOxVEarAOiqZpcZDvJQ12K1oA=;
  b=nSLWgY+v1XWDOafNHzIibu0pcOiyDQaWT3NQgLy5tDoCzJH7vpB4bqJC
   eXXhOc5Hmx9gt77vltuMB4byv5DG7MgQPw9nCe1d4FGzbF14LP+29gdEd
   wa9tRQe3qEMteezdRuxW7XWWnojH8rhX6bL9Z5QqA8jKqW5BwrBniKo3g
   ihPIzwu8yGnQhUI0ifg37eA+Q9vt752XjLvOe6r6xssgq3/R3578G9Iph
   +d26Zpwzi9dCcBQuT+prKZMeXINRrMG0792twwDD78rqiasTrsiifxX0D
   k9CfBUSCptD+jH50WJdefMk46oXzc5lB8R04NODmIYDGmdI3x1zAQslLS
   A==;
X-CSE-ConnectionGUID: j1cQZwY+QemP8oV7AuJpag==
X-CSE-MsgGUID: p9+VvM/4SqWU9SUEVuqH2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57989447"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="57989447"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 04:46:53 -0700
X-CSE-ConnectionGUID: kf1KpAspTQWu/4QcTxvEiA==
X-CSE-MsgGUID: eqUmgzk0RWyZZNS4TzRRwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172613632"
Received: from johunt-mobl9.ger.corp.intel.com (HELO fedora) ([10.245.245.201])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 04:46:50 -0700
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
Subject: [PATCH 2/6] drm/gpusvm, drm/xe: Update GPU SVM / Xe to twopass MMU notifier
Date: Thu, 21 Aug 2025 13:46:22 +0200
Message-ID: <20250821114626.89818-3-thomas.hellstrom@linux.intel.com>
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

Update GPU SVM and Xe to use two-pass MMU notifiers, enabling pipelined
TLB invalidations across VMs or multiple devices.

The driver-side (Xe) implementation is not yet implemented.

v1:
- Update function naming and comments.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 18 +++++++++++-------
 drivers/gpu/drm/xe/xe_svm.c  |  9 +++++----
 include/drm/drm_gpusvm.h     | 11 +++++++----
 3 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 661306da6b2d..c8d74c728cdd 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -374,10 +374,13 @@ notifier_iter_first(struct rb_root_cached *root, unsigned long start,
 	     (notifier__) = (next__), (next__) = __drm_gpusvm_notifier_next(notifier__))
 
 /**
- * drm_gpusvm_notifier_invalidate() - Invalidate a GPU SVM notifier.
+ * drm_gpusvm_notifier_invalidate_start() - Invalidate a GPU SVM notifier,
+ * fist pass.
+ *
  * @mni: Pointer to the mmu_interval_notifier structure.
  * @mmu_range: Pointer to the mmu_notifier_range structure.
  * @cur_seq: Current sequence number.
+ * @final: First pass of MMU notifier
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
+drm_gpusvm_notifier_invalidate_start(struct mmu_interval_notifier *mni,
+				     const struct mmu_notifier_range *mmu_range,
+				     unsigned long cur_seq,
+				     struct mmu_interval_notifier_finish **final)
 {
 	struct drm_gpusvm_notifier *notifier =
 		container_of(mni, typeof(*notifier), notifier);
@@ -399,7 +403,7 @@ drm_gpusvm_notifier_invalidate(struct mmu_interval_notifier *mni,
 
 	down_write(&gpusvm->notifier_lock);
 	mmu_interval_set_seq(mni, cur_seq);
-	gpusvm->ops->invalidate(gpusvm, notifier, mmu_range);
+	gpusvm->ops->invalidate_start(gpusvm, notifier, mmu_range, final);
 	up_write(&gpusvm->notifier_lock);
 
 	return true;
@@ -409,7 +413,7 @@ drm_gpusvm_notifier_invalidate(struct mmu_interval_notifier *mni,
  * drm_gpusvm_notifier_ops - MMU interval notifier operations for GPU SVM
  */
 static const struct mmu_interval_notifier_ops drm_gpusvm_notifier_ops = {
-	.invalidate = drm_gpusvm_notifier_invalidate,
+	.invalidate_start = drm_gpusvm_notifier_invalidate_start,
 };
 
 /**
@@ -440,7 +444,7 @@ int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
 		    const struct drm_gpusvm_ops *ops,
 		    const unsigned long *chunk_sizes, int num_chunks)
 {
-	if (!ops->invalidate || !num_chunks)
+	if (!ops->invalidate_start || !num_chunks)
 		return -EINVAL;
 
 	gpusvm->name = name;
diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index e35c6d4def20..309bcf8a50dd 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -171,9 +171,10 @@ xe_svm_range_notifier_event_end(struct xe_vm *vm, struct drm_gpusvm_range *r,
 						   mmu_range);
 }
 
-static void xe_svm_invalidate(struct drm_gpusvm *gpusvm,
-			      struct drm_gpusvm_notifier *notifier,
-			      const struct mmu_notifier_range *mmu_range)
+static void xe_svm_invalidate_start(struct drm_gpusvm *gpusvm,
+				    struct drm_gpusvm_notifier *notifier,
+				    const struct mmu_notifier_range *mmu_range,
+				    struct mmu_interval_notifier_finish **final)
 {
 	struct xe_vm *vm = gpusvm_to_vm(gpusvm);
 	struct xe_device *xe = vm->xe;
@@ -553,7 +554,7 @@ static const struct drm_pagemap_devmem_ops dpagemap_devmem_ops = {
 static const struct drm_gpusvm_ops gpusvm_ops = {
 	.range_alloc = xe_svm_range_alloc,
 	.range_free = xe_svm_range_free,
-	.invalidate = xe_svm_invalidate,
+	.invalidate_start = xe_svm_invalidate_start,
 };
 
 static const unsigned long fault_chunk_sizes[] = {
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index 8d613e9b2690..48b90c44849b 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -63,17 +63,20 @@ struct drm_gpusvm_ops {
 	void (*range_free)(struct drm_gpusvm_range *range);
 
 	/**
-	 * @invalidate: Invalidate GPU SVM notifier (required)
+	 * @invalidate_start: Invalidate first pass GPU SVM notifier (required)
 	 * @gpusvm: Pointer to the GPU SVM
 	 * @notifier: Pointer to the GPU SVM notifier
 	 * @mmu_range: Pointer to the mmu_notifier_range structure
+	 * @final: Final pass of MMU notifier, optionally populated by the driver side
+	 * if a final pass of MMU notifier is desired
 	 *
 	 * Invalidate the GPU page tables. It can safely walk the notifier range
 	 * RB tree/list in this function. Called while holding the notifier lock.
 	 */
-	void (*invalidate)(struct drm_gpusvm *gpusvm,
-			   struct drm_gpusvm_notifier *notifier,
-			   const struct mmu_notifier_range *mmu_range);
+	void (*invalidate_start)(struct drm_gpusvm *gpusvm,
+				 struct drm_gpusvm_notifier *notifier,
+				 const struct mmu_notifier_range *mmu_range,
+				 struct mmu_interval_notifier_finish **final);
 };
 
 /**
-- 
2.50.1


