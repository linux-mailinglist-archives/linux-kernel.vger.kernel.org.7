Return-Path: <linux-kernel+bounces-838734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8A6BB0097
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 12:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19081C2F48
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 10:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC6C2C08DB;
	Wed,  1 Oct 2025 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NefCMG1H"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1006C26B2D7
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759315313; cv=none; b=MvmSJN2meAomRcPhG12JmzafOLQm1S0kb6fH1zFzb98QWYfOaLQ2M6zNGkMU4rQKZAsce3rbk7l2oJK8WzmdFpjjgrAFP+xuztL0Sr0ar3rMqj4iNu0llbbOxz+yHeM5N5SBHgtsgynmvmFMwkQ5gI5XIWcHczXNv855lNS+2WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759315313; c=relaxed/simple;
	bh=xbXmpmRdsU8b8NZ3taDqhMtUywk4XL8xmoamv/7M38M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TREn5YoyVSS9AeKg7WWMuAvynAPWL3yhRTk+72UtZhPK++NnwpR93q/CqcJ5973/pXgLS0ZX3sEcKL4ICxqfehXDkB4UwvkogF1vE+xt267eeEinGeFTZAF054O7pouU6lUjEUmp97sNAgSNIb2tjLeRRFbQUqpwpzrJfef4Sk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NefCMG1H; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b3d6645acd3so270800366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 03:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759315309; x=1759920109; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QBpG64BMA+n3mUB7jPVwGE8MpSp12Y17XaQpGfu9n7I=;
        b=NefCMG1HhsZiP7iX32NsbRL0Min/O2tcUW3RII9HRPkg3/0XxFC6o+0toOXniB3ICo
         3Tp9MSs9hcnAHs2fSC/uL3oFnNRr2fWsAUl5VMaCMUAoeOWS7sohsCP9MO9MTO7QzSCx
         WF7kScKDW7HwIKhKoaW8TPL8EX+Daj4+z34X4MtRJ10Ml9Z7aI8BUwnrU2Bw2adcM6Ci
         33y388D/5uZQy7XLuWVObyPzmm5UMqxZEAn3rV/ZzEcED8Epx3Sq2HRD++Co9oN7WKwJ
         kIFh0f1n5ozxOChHgN1oGGAp/iEHjEBC+Kl3qPi4GWVGKvkjm17wb8tkN3HblEzEOXCV
         xogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759315309; x=1759920109;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBpG64BMA+n3mUB7jPVwGE8MpSp12Y17XaQpGfu9n7I=;
        b=TLUr08RHECtsC9sVfzg4Cgn7FBY+muxscNDrSxRCBIVSqHJ2e6PGpRkZRdJYJEQIqV
         peitTC7ZNdonZwl2/2Xr+iLRFLGiTw7d2fZXE6hTYfTUPTkIjteFB71CLdOWm2Yf71YC
         Zb/9MMfBNYABSDENK55ztYAqzNjWcTSxFBt43jenuiHgVKXopSa+Swe7/rLa93pJaO0t
         LLnpVEgTxJWPX6vYNBWPXiNwqtcHZ2PPPExe2GaZMg+RkJR5f1w8CDpFkj45L3suFyUW
         h9QoEbyajaFWsErf0YSGD+hf3sXJ71dEL8Jxx1sCDLJ4fWyy08r8r2/ctGJNjAFa3HS3
         lmwg==
X-Forwarded-Encrypted: i=1; AJvYcCVk5jWSXvsenwJzP8jgqlHshGY9Jj4vfJpyOBWydkxRq1MNqlDi0C4VMRq1B4RJKS56Zvyb4Lz5gbF557A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRmqrR2WyoKZHjqR4aoodXYGMjV0XKJ+McBfHOusiE9BbVebUh
	Zv3BGTsvhjRAReiseJu/08rJzfNCb0x/rfzB/fErAqACeM1wZBCrmG28miRRtUXVH1fQg9VfdZ/
	gzV4MEzE9ZQQM4fhsvA==
X-Google-Smtp-Source: AGHT+IFlcRonXnEVXM7LiFkcI8yiCsyrjiVhLgytwJ4+7gyIbeVhDSedPQb647sB4Ho+OROeap4q9Pvclg7Ig3o=
X-Received: from ejzk25.prod.google.com ([2002:a17:906:a399:b0:b3e:29cf:4535])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3ea1:b0:b44:2d0:e05f with SMTP id a640c23a62f3a-b46e6339e30mr379109666b.33.1759315309379;
 Wed, 01 Oct 2025 03:41:49 -0700 (PDT)
Date: Wed, 01 Oct 2025 10:41:36 +0000
In-Reply-To: <20251001-vmbo-defer-v3-0-a3fe6b6ae185@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001-vmbo-defer-v3-0-a3fe6b6ae185@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=10607; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=xbXmpmRdsU8b8NZ3taDqhMtUywk4XL8xmoamv/7M38M=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo3QVqUkkzy4DuMBpN9FQPoar2swWTfjVpaVFb/
 tFNDOIKugSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaN0FagAKCRAEWL7uWMY5
 Rs0TD/9lrVMbSb4Cr2bI0B3d2ON1GMlTQwPaSe7Jwepe16hCvKFW2G/SjlzKsjIFJ1+teLGpc3o
 lOlvb4B2qbXyYyhFaArhitXEHGUbZX5jUdJlh2oQsoZZhFK5zSb9ficDKxp1mqZSKLLL9OdTk3G
 hMO2vxf0+kRuGMtefOLUzdrpJqscCFJOYQ7tMBJraj/sPbbI9spLKj3IMKh/GRweK+6MWHjxCKh
 Ezd/RgC+OUWW8ZeFL10blrlXlUYT+jEm6+nLlt5W1U+n5+BcIZ1l3cv7vJvQdYdAjuP+EviNUi5
 SvlzTnfJurhGiEBBdexzNrJCqLE44pkQaJpopb6JWZxgoDcrYI5KmHjX/eJ7TJ+kRJPjtMiSed+
 ndrLNLUYIVp7vvS1DIKe1FheQ1Q3LPZs6NU6loL4S4akIOpoQMClMDkYGc5kQC8fT0o5XYdRfK+
 k99W1J92rgcXnEOJKMzgsuQrjTmrlA7ehmf6kt4C5qe5IjPBRXh/ylVK5M1V99X5zPjLo6+uY91
 ND/DJABBqAqXw71CAJL+i+OTwrnfUoI3DcMlDsd3SpcZ1ESwbMMF0SaJb+/KdnLPxhJLhs0O1WH
 A+gF2b/Z7pdrUTMd8x9T8/Li+8vjk4TxwtAg9yJLBwUGIomqZua8kU1PS5+pHhbYiZTboLn7KqX qY66LN4E/jfJgmg==
X-Mailer: b4 0.14.2
Message-ID: <20251001-vmbo-defer-v3-1-a3fe6b6ae185@google.com>
Subject: [PATCH v3 1/2] drm/gpuvm: add deferred vm_bo cleanup
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

When using GPUVM in immediate mode, it is necessary to call
drm_gpuvm_unlink() from the fence signalling critical path. However,
unlink may call drm_gpuvm_bo_put(), which causes some challenges:

1. drm_gpuvm_bo_put() often requires you to take resv locks, which you
   can't do from the fence signalling critical path.
2. drm_gpuvm_bo_put() calls drm_gem_object_put(), which is often going
   to be unsafe to call from the fence signalling critical path.

To solve these issues, add a deferred version of drm_gpuvm_unlink() that
adds the vm_bo to a deferred cleanup list, and then clean it up later.

The new methods take the GEMs GPUVA lock internally rather than letting
the caller do it because it also needs to perform an operation after
releasing the mutex again. This is to prevent freeing the GEM while
holding the mutex (more info as comments in the patch). This means that
the new methods can only be used with DRM_GPUVM_IMMEDIATE_MODE.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 184 ++++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_gpuvm.h     |  16 ++++
 2 files changed, 200 insertions(+)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index a52e95555549a16c062168253477035679d4775b..a530cf0864c5dd837840f31d3e698d4a82c58d3c 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -876,6 +876,27 @@ __drm_gpuvm_bo_list_add(struct drm_gpuvm *gpuvm, spinlock_t *lock,
 	cond_spin_unlock(lock, !!lock);
 }
 
+/**
+ * drm_gpuvm_bo_is_zombie() - check whether this vm_bo is scheduled for cleanup
+ * @vm_bo: the &drm_gpuvm_bo
+ *
+ * When a vm_bo is scheduled for cleanup using the bo_defer list, it is not
+ * immediately removed from the evict and extobj lists if they are protected by
+ * the resv lock, as we can't take that lock during run_job() in immediate
+ * mode. Therefore, anyone iterating these lists should skip entries that are
+ * being destroyed.
+ *
+ * Checking the refcount without incrementing it is okay as long as the lock
+ * protecting the evict/extobj list is held for as long as you are using the
+ * vm_bo, because even if the refcount hits zero while you are using it, freeing
+ * the vm_bo requires taking the list's lock.
+ */
+static bool
+drm_gpuvm_bo_is_zombie(struct drm_gpuvm_bo *vm_bo)
+{
+	return !kref_read(&vm_bo->kref);
+}
+
 /**
  * drm_gpuvm_bo_list_add() - insert a vm_bo into the given list
  * @__vm_bo: the &drm_gpuvm_bo
@@ -1081,6 +1102,8 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
 	INIT_LIST_HEAD(&gpuvm->evict.list);
 	spin_lock_init(&gpuvm->evict.lock);
 
+	init_llist_head(&gpuvm->bo_defer);
+
 	kref_init(&gpuvm->kref);
 
 	gpuvm->name = name ? name : "unknown";
@@ -1122,6 +1145,8 @@ drm_gpuvm_fini(struct drm_gpuvm *gpuvm)
 		 "Extobj list should be empty.\n");
 	drm_WARN(gpuvm->drm, !list_empty(&gpuvm->evict.list),
 		 "Evict list should be empty.\n");
+	drm_WARN(gpuvm->drm, !llist_empty(&gpuvm->bo_defer),
+		 "VM BO cleanup list should be empty.\n");
 
 	drm_gem_object_put(gpuvm->r_obj);
 }
@@ -1217,6 +1242,9 @@ drm_gpuvm_prepare_objects_locked(struct drm_gpuvm *gpuvm,
 
 	drm_gpuvm_resv_assert_held(gpuvm);
 	list_for_each_entry(vm_bo, &gpuvm->extobj.list, list.entry.extobj) {
+		if (drm_gpuvm_bo_is_zombie(vm_bo))
+			continue;
+
 		ret = exec_prepare_obj(exec, vm_bo->obj, num_fences);
 		if (ret)
 			break;
@@ -1460,6 +1488,9 @@ drm_gpuvm_validate_locked(struct drm_gpuvm *gpuvm, struct drm_exec *exec)
 
 	list_for_each_entry_safe(vm_bo, next, &gpuvm->evict.list,
 				 list.entry.evict) {
+		if (drm_gpuvm_bo_is_zombie(vm_bo))
+			continue;
+
 		ret = ops->vm_bo_validate(vm_bo, exec);
 		if (ret)
 			break;
@@ -1560,6 +1591,7 @@ drm_gpuvm_bo_create(struct drm_gpuvm *gpuvm,
 
 	INIT_LIST_HEAD(&vm_bo->list.entry.extobj);
 	INIT_LIST_HEAD(&vm_bo->list.entry.evict);
+	init_llist_node(&vm_bo->list.entry.bo_defer);
 
 	return vm_bo;
 }
@@ -1621,6 +1653,124 @@ drm_gpuvm_bo_put(struct drm_gpuvm_bo *vm_bo)
 }
 EXPORT_SYMBOL_GPL(drm_gpuvm_bo_put);
 
+/*
+ * Must be called with GEM mutex held. After releasing GEM mutex,
+ * drm_gpuvm_bo_defer_free_unlocked() must be called.
+ */
+static void
+drm_gpuvm_bo_defer_free_locked(struct kref *kref)
+{
+	struct drm_gpuvm_bo *vm_bo = container_of(kref, struct drm_gpuvm_bo,
+						  kref);
+	struct drm_gpuvm *gpuvm = vm_bo->vm;
+
+	if (!drm_gpuvm_resv_protected(gpuvm)) {
+		drm_gpuvm_bo_list_del(vm_bo, extobj, true);
+		drm_gpuvm_bo_list_del(vm_bo, evict, true);
+	}
+
+	list_del(&vm_bo->list.entry.gem);
+}
+
+/*
+ * GEM mutex must not be held. Called after drm_gpuvm_bo_defer_free_locked().
+ */
+static void
+drm_gpuvm_bo_defer_free_unlocked(struct drm_gpuvm_bo *vm_bo)
+{
+	struct drm_gpuvm *gpuvm = vm_bo->vm;
+
+	llist_add(&vm_bo->list.entry.bo_defer, &gpuvm->bo_defer);
+}
+
+static void
+drm_gpuvm_bo_defer_free(struct kref *kref)
+{
+	struct drm_gpuvm_bo *vm_bo = container_of(kref, struct drm_gpuvm_bo,
+						  kref);
+
+	mutex_lock(&vm_bo->obj->gpuva.lock);
+	drm_gpuvm_bo_defer_free_locked(kref);
+	mutex_unlock(&vm_bo->obj->gpuva.lock);
+
+	/*
+	 * It's important that the GEM stays alive for the duration in which we
+	 * hold the mutex, but the instant we add the vm_bo to bo_defer,
+	 * another thread might call drm_gpuvm_bo_deferred_cleanup() and put
+	 * the GEM. Therefore, to avoid kfreeing a mutex we are holding, we add
+	 * the vm_bo to bo_defer *after* releasing the GEM's mutex.
+	 */
+	drm_gpuvm_bo_defer_free_unlocked(vm_bo);
+}
+
+/**
+ * drm_gpuvm_bo_put_deferred() - drop a struct drm_gpuvm_bo reference with
+ * deferred cleanup
+ * @vm_bo: the &drm_gpuvm_bo to release the reference of
+ *
+ * This releases a reference to @vm_bo.
+ *
+ * This might take and release the GEMs GPUVA lock. You should call
+ * drm_gpuvm_bo_deferred_cleanup() later to complete the cleanup process.
+ *
+ * Returns: true if vm_bo is being destroyed, false otherwise.
+ */
+bool
+drm_gpuvm_bo_put_deferred(struct drm_gpuvm_bo *vm_bo)
+{
+	if (!vm_bo)
+		return false;
+
+	drm_WARN_ON(vm_bo->vm->drm, !drm_gpuvm_immediate_mode(vm_bo->vm));
+
+	return !!kref_put(&vm_bo->kref, drm_gpuvm_bo_defer_free);
+}
+EXPORT_SYMBOL_GPL(drm_gpuvm_bo_put_deferred);
+
+/**
+ * drm_gpuvm_bo_deferred_cleanup() - clean up BOs in the deferred list
+ * deferred cleanup
+ * @gpuvm: the VM to clean up
+ *
+ * Cleans up &drm_gpuvm_bo instances in the deferred cleanup list.
+ */
+void
+drm_gpuvm_bo_deferred_cleanup(struct drm_gpuvm *gpuvm)
+{
+	const struct drm_gpuvm_ops *ops = gpuvm->ops;
+	struct drm_gpuvm_bo *vm_bo;
+	struct drm_gem_object *obj;
+	struct llist_node *bo_defer;
+
+	bo_defer = llist_del_all(&gpuvm->bo_defer);
+	if (!bo_defer)
+		return;
+
+	if (drm_gpuvm_resv_protected(gpuvm)) {
+		dma_resv_lock(drm_gpuvm_resv(gpuvm), NULL);
+		llist_for_each_entry(vm_bo, bo_defer, list.entry.bo_defer) {
+			drm_gpuvm_bo_list_del(vm_bo, extobj, false);
+			drm_gpuvm_bo_list_del(vm_bo, evict, false);
+		}
+		dma_resv_unlock(drm_gpuvm_resv(gpuvm));
+	}
+
+	while (bo_defer) {
+		vm_bo = llist_entry(bo_defer,
+			struct drm_gpuvm_bo, list.entry.bo_defer);
+		bo_defer = bo_defer->next;
+		obj = vm_bo->obj;
+		if (ops && ops->vm_bo_free)
+			ops->vm_bo_free(vm_bo);
+		else
+			kfree(vm_bo);
+
+		drm_gpuvm_put(gpuvm);
+		drm_gem_object_put(obj);
+	}
+}
+EXPORT_SYMBOL_GPL(drm_gpuvm_bo_deferred_cleanup);
+
 static struct drm_gpuvm_bo *
 __drm_gpuvm_bo_find(struct drm_gpuvm *gpuvm,
 		    struct drm_gem_object *obj)
@@ -1948,6 +2098,40 @@ drm_gpuva_unlink(struct drm_gpuva *va)
 }
 EXPORT_SYMBOL_GPL(drm_gpuva_unlink);
 
+/**
+ * drm_gpuva_unlink_defer() - unlink a &drm_gpuva with deferred vm_bo cleanup
+ * @va: the &drm_gpuva to unlink
+ *
+ * Similar to drm_gpuva_unlink(), but uses drm_gpuvm_bo_put_deferred() and takes
+ * the lock for the caller.
+ */
+void
+drm_gpuva_unlink_defer(struct drm_gpuva *va)
+{
+	struct drm_gem_object *obj = va->gem.obj;
+	struct drm_gpuvm_bo *vm_bo = va->vm_bo;
+	bool should_defer_bo;
+
+	if (unlikely(!obj))
+		return;
+
+	drm_WARN_ON(vm_bo->vm->drm, !drm_gpuvm_immediate_mode(vm_bo->vm));
+
+	mutex_lock(&obj->gpuva.lock);
+	list_del_init(&va->gem.entry);
+
+	/*
+	 * This is drm_gpuvm_bo_put_deferred() except we already hold the mutex.
+	 */
+	should_defer_bo = kref_put(&vm_bo->kref, drm_gpuvm_bo_defer_free_locked);
+	mutex_unlock(&obj->gpuva.lock);
+	if (should_defer_bo)
+		drm_gpuvm_bo_defer_free_unlocked(vm_bo);
+
+	va->vm_bo = NULL;
+}
+EXPORT_SYMBOL_GPL(drm_gpuva_unlink_defer);
+
 /**
  * drm_gpuva_find_first() - find the first &drm_gpuva in the given range
  * @gpuvm: the &drm_gpuvm to search in
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 8890ded1d90752a2acbb564f697aa5ab03b5d052..81cc7672cf2d5362c637abfa2a75471e5274ed08 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -27,6 +27,7 @@
 
 #include <linux/dma-resv.h>
 #include <linux/list.h>
+#include <linux/llist.h>
 #include <linux/rbtree.h>
 #include <linux/types.h>
 
@@ -152,6 +153,7 @@ void drm_gpuva_remove(struct drm_gpuva *va);
 
 void drm_gpuva_link(struct drm_gpuva *va, struct drm_gpuvm_bo *vm_bo);
 void drm_gpuva_unlink(struct drm_gpuva *va);
+void drm_gpuva_unlink_defer(struct drm_gpuva *va);
 
 struct drm_gpuva *drm_gpuva_find(struct drm_gpuvm *gpuvm,
 				 u64 addr, u64 range);
@@ -331,6 +333,11 @@ struct drm_gpuvm {
 		 */
 		spinlock_t lock;
 	} evict;
+
+	/**
+	 * @bo_defer: structure holding vm_bos that need to be destroyed
+	 */
+	struct llist_head bo_defer;
 };
 
 void drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
@@ -714,6 +721,12 @@ struct drm_gpuvm_bo {
 			 * &drm_gpuvms evict list.
 			 */
 			struct list_head evict;
+
+			/**
+			 * @list.entry.bo_defer: List entry to attach to
+			 * the &drm_gpuvms bo_defer list.
+			 */
+			struct llist_node bo_defer;
 		} entry;
 	} list;
 };
@@ -746,6 +759,9 @@ drm_gpuvm_bo_get(struct drm_gpuvm_bo *vm_bo)
 
 bool drm_gpuvm_bo_put(struct drm_gpuvm_bo *vm_bo);
 
+bool drm_gpuvm_bo_put_deferred(struct drm_gpuvm_bo *vm_bo);
+void drm_gpuvm_bo_deferred_cleanup(struct drm_gpuvm *gpuvm);
+
 struct drm_gpuvm_bo *
 drm_gpuvm_bo_find(struct drm_gpuvm *gpuvm,
 		  struct drm_gem_object *obj);

-- 
2.51.0.618.g983fd99d29-goog


