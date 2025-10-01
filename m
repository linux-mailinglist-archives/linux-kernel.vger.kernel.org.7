Return-Path: <linux-kernel+bounces-838735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A43BB009A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 12:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E271C491F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 10:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA912C0F9C;
	Wed,  1 Oct 2025 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xxwpYG5h"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CDB2BFC8F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759315314; cv=none; b=MKV6yIsbQAF8VSMR4txGF5hNcbiwqUVTiU5rbkXX479hyiQt8u9pzPwGy/ip2YUlhnOIaBD5lPV5EPHMCwbb9glS4WBBhaicVvKy7HYZF9Kigsb9BP/N8gjLXhbwzYbscbsFOMbhO2Ows4BC7gvZmqzx52APaOW3okk4ExgkWSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759315314; c=relaxed/simple;
	bh=4RxPmpuVab/SUToij6BLFwj/Hu99zhmAE3I8jyKJVCU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mLGGVsXOtM8M4SSrTwJ3A8iRoO0KWH1qsFZ15Xk6c3pTiPvv262+jmz32PmLRmoUDfjgPRcWk9gfVO53lo1cvTFvnBwmwIYrPu4ntIh6yPi4ACnLdXSAV9eRrKsy4sIPImHuQg3s/YQtREBvAGqZfanI0t5ZlsZ9CgnS4cQpnxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xxwpYG5h; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b3a879bd254so78982566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 03:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759315310; x=1759920110; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HWeScriFeGl10P14+57g/pqOB/HqHy1iDGONUOl5TKE=;
        b=xxwpYG5hL9ZQ2lkEhAfyuPJzWi3wE6RoCwmMbhq76VbDBdROPpyaQDl4EkhMOJZq0M
         eqz6r1CVaa9eqo3oHncoATzxp4AlzZF6JtKBLLrtMYoPRwOJxrOpGl6TV/ewAhd9vxgt
         MkV8mhpx40C5Tz60Bbp5bcLwI4eM4j9gNMWebSaAPqTxTJExdEBK+NY2MXQr7jPhah7N
         elDy7Xi2DI3ft2rfBDT1hr+4E2Pkym+hYkVmQgEgkkpUvlVPks63sR/feia3BrFQT9RP
         5758JemhdbQdTteof8Nrl4evXrdfCzfBofElXNyqsVtxgnDhSiTqP8aNVl2zbVJfv+LR
         q5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759315310; x=1759920110;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWeScriFeGl10P14+57g/pqOB/HqHy1iDGONUOl5TKE=;
        b=wonBKkaEETiiAohFEQiio+hDGVQK8NDwblKZxa+5qOg0nvN34utfZChaWQdvpWC6XO
         8bZnm5FXo0MGAz+YeELLg+yP1kRPdo//8QhCTPSlMuul3riKq101+j6tyKDaduJMuWWb
         cv//nobsNWdBBjbe195WrrmfAhM798khjJ6iro2sHtxv9crGWzp+qwtWqfk3yRsHR0Kz
         9dRBNjdjwJDprHTp7Aq8Go6ENVnO7+P1niIBNA8oZhKiLnyFmnNxw3dgkkFGK51mJgee
         pId+daqU3f2FTupzEZ/s/DLQyLcQaZQuxguKiUBvR8wVAAy32/w6OPYtIY6mt0dPyZ4s
         EzIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJx/OisV2wAhOCGrZGXQ56KqoYklUMmheuCETHRyyraafRcP5K/AhH41GD3Fs91Ts/RQ6XI/CgbIWWfD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3XFai5e20Vo4haQMZWOItyudP46AqXMOgEujBuT3VrjnoU1nx
	fx3pfUGyokGiyJ+A+W6D1Yua3jjAeCb/WqcvBYwSyu/yAG2CsShNZDrgqsKd/Cptvlc6e8aPcZh
	kwPNU1zkIsnFK0f7ufw==
X-Google-Smtp-Source: AGHT+IGFvzVc3aIesqoTOhT0OxQ0rtyZmsWgewwTZSXuHJimiNrD8GtXGO2CvVsYw71iS6fE2JboaRH15VdZU54=
X-Received: from edbco8.prod.google.com ([2002:a05:6402:c08:b0:61d:4059:adf3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:8318:b0:b47:a9c7:3c2d with SMTP id a640c23a62f3a-b47a9c73f12mr116723666b.45.1759315310589;
 Wed, 01 Oct 2025 03:41:50 -0700 (PDT)
Date: Wed, 01 Oct 2025 10:41:37 +0000
In-Reply-To: <20251001-vmbo-defer-v3-0-a3fe6b6ae185@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001-vmbo-defer-v3-0-a3fe6b6ae185@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8737; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=4RxPmpuVab/SUToij6BLFwj/Hu99zhmAE3I8jyKJVCU=;
 b=owEBbAKT/ZANAwAKAQRYvu5YxjlGAcsmYgBo3QVq1IZjOdFhC3F3Qc9eOXo3Bu6l8QMJp9Jpx
 qBX3I5+kgWJAjIEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaN0FagAKCRAEWL7uWMY5
 Rif+D/Ym0It2vRMa9bOV//PIEi8SG2FRcX4KxBPqBYPCOJdUcVzVI8E8QGqoLsqI7/R7cvJn9XL
 kiyK08IlhHdyKCpd9ClwYCXugophGXjP09JQs2QR2YNLDNj8DPVqW0q6HvvBNPT1x3lnewKpSiX
 +/Q+8UzJbQx3DZiUkHkbCErnA0Cen26ay8EgGR2tFLEKuw7IlNBMc/6IPrrcCuUiToll5p5rJ9N
 q2I0BdR7+wEcUQq9p9a53EhT+YjyEA9QNUJyrxNBNFrRw62lektFcNQkTG9UIrQiPRoFIZLOm4n
 VU2IDyypLhxomO2Jnr0td2nuA+cFpT7m6fDHatDHDz7kaIkKal7pRg8yZ/02N7xpT2o6ZTtmWPH
 fwmjks/lv8jx5x/qKIPdTN+fB0D7aRf2aRUa06EGys5nRXfTH5VrbUsQiztka9ibi5E5bQ8l85P
 /wnqshlpLNrp97u2qoeyLVmscwjJIR0CHgkniX2niZ4kP3rR1hvZ4dDVEjdHYqorNV8DB/c51bf
 ZmyZNXOFPQ6XrVljxZWmO5TNuU9TrUil3MKTNIriQ9J8f8HXzS7xcTcUrhMjqMFWJMDExDOsrIl
 hu8gP11iQkfLxY3V4RFH4BU82MCE6q7tTz8iPj/JIck59RSIA2D4ahVKpbKTq2X2+/0l2UBt7xo XD4cjRODeBFa6
X-Mailer: b4 0.14.2
Message-ID: <20251001-vmbo-defer-v3-2-a3fe6b6ae185@google.com>
Subject: [PATCH v3 2/2] panthor: use drm_gpuva_unlink_defer()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	"=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Instead of manually deferring cleanup of vm_bos, use the new GPUVM
infrastructure for doing so.

To avoid manual management of vm_bo refcounts, the panthor_vma_link()
and panthor_vma_unlink() methods are changed to get and put a vm_bo
refcount on the vm_bo. This simplifies the code a lot. I preserved the
behavior where panthor_gpuva_sm_step_map() drops the refcount right away
rather than letting panthor_vm_cleanup_op_ctx() do it later.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 110 ++++++----------------------------
 1 file changed, 19 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 6dec4354e3789d17c5a87fc8de3bc86764b804bc..9f5f4ddf291024121f3fd5644f2fdeba354fa67c 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -181,20 +181,6 @@ struct panthor_vm_op_ctx {
 		u64 range;
 	} va;
 
-	/**
-	 * @returned_vmas: List of panthor_vma objects returned after a VM operation.
-	 *
-	 * For unmap operations, this will contain all VMAs that were covered by the
-	 * specified VA range.
-	 *
-	 * For map operations, this will contain all VMAs that previously mapped to
-	 * the specified VA range.
-	 *
-	 * Those VMAs, and the resources they point to will be released as part of
-	 * the op_ctx cleanup operation.
-	 */
-	struct list_head returned_vmas;
-
 	/** @map: Fields specific to a map operation. */
 	struct {
 		/** @map.vm_bo: Buffer object to map. */
@@ -1081,47 +1067,18 @@ void panthor_vm_free_va(struct panthor_vm *vm, struct drm_mm_node *va_node)
 	mutex_unlock(&vm->mm_lock);
 }
 
-static void panthor_vm_bo_put(struct drm_gpuvm_bo *vm_bo)
+static void panthor_vm_bo_free(struct drm_gpuvm_bo *vm_bo)
 {
 	struct panthor_gem_object *bo = to_panthor_bo(vm_bo->obj);
-	struct drm_gpuvm *vm = vm_bo->vm;
-	bool unpin;
-
-	/* We must retain the GEM before calling drm_gpuvm_bo_put(),
-	 * otherwise the mutex might be destroyed while we hold it.
-	 * Same goes for the VM, since we take the VM resv lock.
-	 */
-	drm_gem_object_get(&bo->base.base);
-	drm_gpuvm_get(vm);
-
-	/* We take the resv lock to protect against concurrent accesses to the
-	 * gpuvm evicted/extobj lists that are modified in
-	 * drm_gpuvm_bo_destroy(), which is called if drm_gpuvm_bo_put()
-	 * releases sthe last vm_bo reference.
-	 * We take the BO GPUVA list lock to protect the vm_bo removal from the
-	 * GEM vm_bo list.
-	 */
-	dma_resv_lock(drm_gpuvm_resv(vm), NULL);
-	mutex_lock(&bo->base.base.gpuva.lock);
-	unpin = drm_gpuvm_bo_put(vm_bo);
-	mutex_unlock(&bo->base.base.gpuva.lock);
-	dma_resv_unlock(drm_gpuvm_resv(vm));
 
-	/* If the vm_bo object was destroyed, release the pin reference that
-	 * was hold by this object.
-	 */
-	if (unpin && !drm_gem_is_imported(&bo->base.base))
+	if (!drm_gem_is_imported(&bo->base.base))
 		drm_gem_shmem_unpin(&bo->base);
-
-	drm_gpuvm_put(vm);
-	drm_gem_object_put(&bo->base.base);
+	kfree(vm_bo);
 }
 
 static void panthor_vm_cleanup_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 				      struct panthor_vm *vm)
 {
-	struct panthor_vma *vma, *tmp_vma;
-
 	u32 remaining_pt_count = op_ctx->rsvd_page_tables.count -
 				 op_ctx->rsvd_page_tables.ptr;
 
@@ -1134,16 +1091,12 @@ static void panthor_vm_cleanup_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	kfree(op_ctx->rsvd_page_tables.pages);
 
 	if (op_ctx->map.vm_bo)
-		panthor_vm_bo_put(op_ctx->map.vm_bo);
+		drm_gpuvm_bo_put_deferred(op_ctx->map.vm_bo);
 
 	for (u32 i = 0; i < ARRAY_SIZE(op_ctx->preallocated_vmas); i++)
 		kfree(op_ctx->preallocated_vmas[i]);
 
-	list_for_each_entry_safe(vma, tmp_vma, &op_ctx->returned_vmas, node) {
-		list_del(&vma->node);
-		panthor_vm_bo_put(vma->base.vm_bo);
-		kfree(vma);
-	}
+	drm_gpuvm_bo_deferred_cleanup(&vm->base);
 }
 
 static struct panthor_vma *
@@ -1232,7 +1185,6 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 		return -EINVAL;
 
 	memset(op_ctx, 0, sizeof(*op_ctx));
-	INIT_LIST_HEAD(&op_ctx->returned_vmas);
 	op_ctx->flags = flags;
 	op_ctx->va.range = size;
 	op_ctx->va.addr = va;
@@ -1243,7 +1195,9 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 
 	if (!drm_gem_is_imported(&bo->base.base)) {
 		/* Pre-reserve the BO pages, so the map operation doesn't have to
-		 * allocate.
+		 * allocate. This pin is dropped in panthor_vm_bo_free(), so
+		 * once we have successfully called drm_gpuvm_bo_create(),
+		 * GPUVM will take care of dropping the pin for us.
 		 */
 		ret = drm_gem_shmem_pin(&bo->base);
 		if (ret)
@@ -1282,16 +1236,6 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	mutex_unlock(&bo->base.base.gpuva.lock);
 	dma_resv_unlock(panthor_vm_resv(vm));
 
-	/* If the a vm_bo for this <VM,BO> combination exists, it already
-	 * retains a pin ref, and we can release the one we took earlier.
-	 *
-	 * If our pre-allocated vm_bo is picked, it now retains the pin ref,
-	 * which will be released in panthor_vm_bo_put().
-	 */
-	if (preallocated_vm_bo != op_ctx->map.vm_bo &&
-	    !drm_gem_is_imported(&bo->base.base))
-		drm_gem_shmem_unpin(&bo->base);
-
 	op_ctx->map.bo_offset = offset;
 
 	/* L1, L2 and L3 page tables.
@@ -1339,7 +1283,6 @@ static int panthor_vm_prepare_unmap_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	int ret;
 
 	memset(op_ctx, 0, sizeof(*op_ctx));
-	INIT_LIST_HEAD(&op_ctx->returned_vmas);
 	op_ctx->va.range = size;
 	op_ctx->va.addr = va;
 	op_ctx->flags = DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP;
@@ -1387,7 +1330,6 @@ static void panthor_vm_prepare_sync_only_op_ctx(struct panthor_vm_op_ctx *op_ctx
 						struct panthor_vm *vm)
 {
 	memset(op_ctx, 0, sizeof(*op_ctx));
-	INIT_LIST_HEAD(&op_ctx->returned_vmas);
 	op_ctx->flags = DRM_PANTHOR_VM_BIND_OP_TYPE_SYNC_ONLY;
 }
 
@@ -2033,26 +1975,13 @@ static void panthor_vma_link(struct panthor_vm *vm,
 
 	mutex_lock(&bo->base.base.gpuva.lock);
 	drm_gpuva_link(&vma->base, vm_bo);
-	drm_WARN_ON(&vm->ptdev->base, drm_gpuvm_bo_put(vm_bo));
 	mutex_unlock(&bo->base.base.gpuva.lock);
 }
 
-static void panthor_vma_unlink(struct panthor_vm *vm,
-			       struct panthor_vma *vma)
+static void panthor_vma_unlink(struct panthor_vma *vma)
 {
-	struct panthor_gem_object *bo = to_panthor_bo(vma->base.gem.obj);
-	struct drm_gpuvm_bo *vm_bo = drm_gpuvm_bo_get(vma->base.vm_bo);
-
-	mutex_lock(&bo->base.base.gpuva.lock);
-	drm_gpuva_unlink(&vma->base);
-	mutex_unlock(&bo->base.base.gpuva.lock);
-
-	/* drm_gpuva_unlink() release the vm_bo, but we manually retained it
-	 * when entering this function, so we can implement deferred VMA
-	 * destruction. Re-assign it here.
-	 */
-	vma->base.vm_bo = vm_bo;
-	list_add_tail(&vma->node, &vm->op_ctx->returned_vmas);
+	drm_gpuva_unlink_defer(&vma->base);
+	kfree(vma);
 }
 
 static void panthor_vma_init(struct panthor_vma *vma, u32 flags)
@@ -2084,12 +2013,12 @@ static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
 	if (ret)
 		return ret;
 
-	/* Ref owned by the mapping now, clear the obj field so we don't release the
-	 * pinning/obj ref behind GPUVA's back.
-	 */
 	drm_gpuva_map(&vm->base, &vma->base, &op->map);
 	panthor_vma_link(vm, vma, op_ctx->map.vm_bo);
+
+	drm_gpuvm_bo_put_deferred(op_ctx->map.vm_bo);
 	op_ctx->map.vm_bo = NULL;
+
 	return 0;
 }
 
@@ -2128,16 +2057,14 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 		 * owned by the old mapping which will be released when this
 		 * mapping is destroyed, we need to grab a ref here.
 		 */
-		panthor_vma_link(vm, prev_vma,
-				 drm_gpuvm_bo_get(op->remap.unmap->va->vm_bo));
+		panthor_vma_link(vm, prev_vma, op->remap.unmap->va->vm_bo);
 	}
 
 	if (next_vma) {
-		panthor_vma_link(vm, next_vma,
-				 drm_gpuvm_bo_get(op->remap.unmap->va->vm_bo));
+		panthor_vma_link(vm, next_vma, op->remap.unmap->va->vm_bo);
 	}
 
-	panthor_vma_unlink(vm, unmap_vma);
+	panthor_vma_unlink(unmap_vma);
 	return 0;
 }
 
@@ -2154,12 +2081,13 @@ static int panthor_gpuva_sm_step_unmap(struct drm_gpuva_op *op,
 		return ret;
 
 	drm_gpuva_unmap(&op->unmap);
-	panthor_vma_unlink(vm, unmap_vma);
+	panthor_vma_unlink(unmap_vma);
 	return 0;
 }
 
 static const struct drm_gpuvm_ops panthor_gpuvm_ops = {
 	.vm_free = panthor_vm_free,
+	.vm_bo_free = panthor_vm_bo_free,
 	.sm_step_map = panthor_gpuva_sm_step_map,
 	.sm_step_remap = panthor_gpuva_sm_step_remap,
 	.sm_step_unmap = panthor_gpuva_sm_step_unmap,

-- 
2.51.0.618.g983fd99d29-goog


