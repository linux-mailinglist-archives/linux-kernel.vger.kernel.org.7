Return-Path: <linux-kernel+bounces-802817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ECBB4575F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7EB5C2D51
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D272634DCF1;
	Fri,  5 Sep 2025 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WKd3WOvV"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC03234AB04
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074301; cv=none; b=bXvSgOkjKOS6yGeXvfwddCrv3yx7O11q8UpCFlxtQKzRuaND3KmTqv3NBoPUDsGGr8aFgQB0TySUWm0MdMuseMDnivnphFFqJJaMxD+B88Q2Ik7pdQmKiIiIQM5425wYLWgDvb6XysgSYvvU3pSi1f4e7U3i28UbTMIiWTK5J7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074301; c=relaxed/simple;
	bh=s2GWvmQHUwyjohU1GP99f3t5sldgnhLD+nr53UBS7jk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GRq/QIL5Xeb70lB9odJOZxcRq0B6rFPKFdNE9y8kdtK4GYUEm9JwwbkABJOPy09uLk5S0xMXyAsjFfWUnPXD8sjzoGbAMVJ8XpH2sjUaoFH2hWMUqiJbzt6gMkd6bfFlG5QwvAVkhFqo05oF/XZWBxlVTnnx2dXPvnFz4UrPmAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WKd3WOvV; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3db89e4f443so1250466f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 05:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757074298; x=1757679098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rlxAeSfJx82pksd3I0ixRoBKWGI7viD6A795f500XFc=;
        b=WKd3WOvV/fX9A/edpAjQmhgiha+Y5JvK5wP98yYI4l2HqBBd8Jqb9FQFDiOk+O8dQZ
         4pbfz1JywqRx6H9QTMEW7mtjIMe1GhC4Iiu7H+AF2JMXTD6mgpVapjRxSmlxt8uGTgyN
         6NIDiP+S5asiVsBMSwu81kH+I6sPTYYB//JVWc0hfAyl52++6iQYtP7UFJYOGsfXORO6
         DOauCPvyrpJSOq3L/GYfi0D+llwK5sXV4FF3KQzaEPEpbPgXZF3ssC3R4mXYOXb9/sYt
         nAJfYm5W1P/kpIUkaWDB8LtOgbAgSAobDdrw7IOjnTxU3mqqaLygE+m/KDrgtCbhVmEC
         u9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757074298; x=1757679098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rlxAeSfJx82pksd3I0ixRoBKWGI7viD6A795f500XFc=;
        b=C9Y+259DoPhKPV6TJW29w+MvU1LnLo8+i79BggvMLS/B/dJXmhorjDvgzAf1sglRPm
         OWDHbCfXv47Ub11heUAEJfrvCA3gsjc0Imzh9YWePb7uX06b7blQuIwT/9oLFo0OSFRK
         RDtMClBsiMkV9lg1OvDXzzTyYRXMqRCp6Kr3Mn0FDDliaPvQeemJnqY/PM1M0UJHqwS9
         Cu/wSsn8zQHNlTCTlQqmmpIJAmt2GacFHaI8EygZgjK99xajlVG+UfDMcYetqzO9Q7AU
         8XZQNAFgXehpzQq6REloSkaLYstQqOx6OPQY46KrdC0dkjfy+L55PpE9vlFxLYFLAmzl
         aNOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK87WB2doAQCf1tCOjGpuHRocu1fadaLTWlZcQzMCpI0lelIKeh5JbEwsxDvWKJLFQHPYgWubDWvIqG14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYofXHJdzdbaZuEc0n1FlNqeXF4jUlfnwnUGAQJRA46rWcRo2P
	VYyqGKp+oP8zK4PuzUsxdYMV4OyTtjmnWO462jjU4hYIQThpHdBczwCW6oC+CCSUNhkD1RU6uLT
	sk54tWLIHK2foYrrIxw==
X-Google-Smtp-Source: AGHT+IG8jYGvzO4xJ5XE6YjDlUyoq7XkUoX06psrVfvh6sWFTCcB4r+O6TwY74/lyIP1l3hTEjNDm+Em6qNSRZg=
X-Received: from wrml12.prod.google.com ([2002:adf:e58c:0:b0:3d5:28fd:8822])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2008:b0:3e4:e4e:343c with SMTP id ffacd0b85a97d-3e40e4e3a79mr1309181f8f.31.1757074298331;
 Fri, 05 Sep 2025 05:11:38 -0700 (PDT)
Date: Fri, 05 Sep 2025 12:11:29 +0000
In-Reply-To: <20250905-vmbo-defer-v1-0-7ae1a382b674@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905-vmbo-defer-v1-0-7ae1a382b674@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=9037; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=s2GWvmQHUwyjohU1GP99f3t5sldgnhLD+nr53UBS7jk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBoutN24be3/jGNmEoz+LMXQuVQHZUNhQi1vI/sM
 vYnnqGZy56JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaLrTdgAKCRAEWL7uWMY5
 RnFLD/4rxL4E5zD6NMkjopiwv+rIBm+fmYOSzbi9ShMG5wEXGT4QaQJ+TE+y3VvWuCZOh3JDa+C
 /QgvOypoW/eu9nRIWFJBqv4IOHI95WV5lkqr7IA0UGuXUY/Zg/Gcy0wWj4xWigAZa6jw/mpNToU
 +W8LpBpz8qYuUzY/bpjDLndzUDrym7j18IZ8b/zayd8x2Il+/Zjdal4o0CH0UXH/avk+5Fsiiz+
 JtLFl8SSJEzVtweaL7x06H7+/yIN5ReqckjUv4ivszj6THkoi/iyCyBOtHu/sFkTY7+gVAS24Ak
 Jv2cOSuEdMOiJ88XgijiMFOfnw3WWW+ZiiT3Akk+lMiohEPanm7/pcJezQhDIljbkljNTewf7Ny
 vaQhnVKdAkqr4wh0eXJkAdj9E7JAK0UpyuZ7JpcjGSygEsPS5wVM7gGnWfOWd54RIQqIB5Tybua
 ZTshg2aOXcrpt8Fac24t45e00wSuhFCK3W6WMfu88bXG0IlJF2mhKNiUrxQ+IwEJekwKQHvhqLo
 uRmIvBykWbMPCn6fsX2w2CdtN5lYHA4xy1uzcv66t3kBpbDeJQ57/U3EGrZOQGOUj+Rl8EOTjYH
 tsSLFgPM+0nsr+KOl8x8hfwbfYVKw71Ou6ywZvfBIfFwFD6AyMMvCqv7To3iHeu82gUkEZ3NYS+ ywfT3BM2QDRI5Yg==
X-Mailer: b4 0.14.2
Message-ID: <20250905-vmbo-defer-v1-2-7ae1a382b674@google.com>
Subject: [PATCH 2/2] panthor: use drm_gpuva_unlink_defer()
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
 drivers/gpu/drm/panthor/panthor_mmu.c | 112 ++++++----------------------------
 1 file changed, 18 insertions(+), 94 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 6dec4354e3789d17c5a87fc8de3bc86764b804bc..4922da0b106aec2bdf657ce4c596acb9c63797ce 100644
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
+		 * once we call drm_gpuvm_bo_create(), GPUVM will take care of
+		 * dropping the pin for us.
 		 */
 		ret = drm_gem_shmem_pin(&bo->base);
 		if (ret)
@@ -1263,9 +1217,6 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 
 	preallocated_vm_bo = drm_gpuvm_bo_create(&vm->base, &bo->base.base);
 	if (!preallocated_vm_bo) {
-		if (!drm_gem_is_imported(&bo->base.base))
-			drm_gem_shmem_unpin(&bo->base);
-
 		ret = -ENOMEM;
 		goto err_cleanup;
 	}
@@ -1282,16 +1233,6 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
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
@@ -1339,7 +1280,6 @@ static int panthor_vm_prepare_unmap_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	int ret;
 
 	memset(op_ctx, 0, sizeof(*op_ctx));
-	INIT_LIST_HEAD(&op_ctx->returned_vmas);
 	op_ctx->va.range = size;
 	op_ctx->va.addr = va;
 	op_ctx->flags = DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP;
@@ -1387,7 +1327,6 @@ static void panthor_vm_prepare_sync_only_op_ctx(struct panthor_vm_op_ctx *op_ctx
 						struct panthor_vm *vm)
 {
 	memset(op_ctx, 0, sizeof(*op_ctx));
-	INIT_LIST_HEAD(&op_ctx->returned_vmas);
 	op_ctx->flags = DRM_PANTHOR_VM_BIND_OP_TYPE_SYNC_ONLY;
 }
 
@@ -2033,26 +1972,12 @@ static void panthor_vma_link(struct panthor_vm *vm,
 
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
 }
 
 static void panthor_vma_init(struct panthor_vma *vma, u32 flags)
@@ -2084,12 +2009,12 @@ static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
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
 
@@ -2128,16 +2053,14 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
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
 
@@ -2154,12 +2077,13 @@ static int panthor_gpuva_sm_step_unmap(struct drm_gpuva_op *op,
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
2.51.0.355.g5224444f11-goog


