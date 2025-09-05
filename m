Return-Path: <linux-kernel+bounces-802816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CBEB4575E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6593A5EEB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D257D34DCCE;
	Fri,  5 Sep 2025 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zRhkz7SY"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9CE34A334
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074300; cv=none; b=RiVBpIEoZz7665uT/yxdVnPP+1HcI8O2LWIAn1FywG0XmzWaXbi8nhZ6sf/0wQnX64mfu1fCudTIn0sXQvXbfJMLKZmERib+58pjd3mKCp6/QDbXotaDLlF2k9DCtYoVR/KztHZCr3Qox8d6WEssflZ7zm4h4bFVgd68mzScR6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074300; c=relaxed/simple;
	bh=52WoN1Pmy2AcHTRvbpGs0/D/mgk8eznKWIWJ1Q2Pcg4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j4kPZCKnKoFNnPCNv0vJuSxIBnAZd2P/Mtxlh3OnVx87S+aPTd3KfLaXJ6sm9qKZ1HNtv1aV1mI5DoNelOl3fkyK7133IJzx5fABPw4Vuz6J0b5edYey3gpSIqU/G/PK9Di6nIbCHeTX8tjEbONl5TjapADHn9xTB9xXY5EEHk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zRhkz7SY; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a15f10f31so20023705e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 05:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757074297; x=1757679097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F/D7fTGTthHcMtHgbv0id3peMuyGmzlJ6a/8BhjfUeI=;
        b=zRhkz7SYWR2r67nn2p9xVLJO+chaZS+CNQDTQzbsL+z3o4szefiHwNty1LDcbrIOJ2
         fkSLeRERxSmYpSZPt19DYBS7HTbUkYfUHPvN4K5O4Fu7H2FSjqcsR+Aou6u09ZwTmE1i
         pgwxx5DnUmQPTMvyVepi3fV3X0kC7JTcHx3DutLEYWKkWqpfwgGaida4OVL+BO5BY1wd
         Ya6d2LQz3BwUJNldqUan3a6MCjJ9+ZEOHq/8VK6InegYMKbLKFoBrqVCCaSFOArDqudA
         nAdZBegqTq6u/4BR+RENGUmaQRSW8z1kr5zt1xYz1m0Uh1EyCYyJ+hOtdN/5rSmo9vOv
         kB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757074297; x=1757679097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/D7fTGTthHcMtHgbv0id3peMuyGmzlJ6a/8BhjfUeI=;
        b=LvHe7FySMAUGmSpaS5qTuYpPtzklK+E1pXZuviQrEugIjoJsFut2Dj+LcH/j8saqBG
         leObFl4wBZw3+uOyWEd2L1Jv5XLlzT8FXZ7OzipOTIItrWIdPohNxt/sYnJUI3KpW2AC
         OqAl3YNp0+SsheW/Mzg2KdiEyJpdy/bQaa6GB70P1LMUB5K7pA4Uoy3dL3lI/h5Mv8Fi
         ONZQblgvNUdUG4Ki+Xhv3alU8D+tGQdk+OMQbnexUrTISQTBEAA7eOJY4UWbdwG9ETxR
         CZrqBFJFpmLbpK30ODVY1sXKo4/0HzRqKsPnvy3WdAQRLiraQkdNX9q4Q1b3rchLiU/C
         QLmg==
X-Forwarded-Encrypted: i=1; AJvYcCVnHGcm77Aov/RDV/i7SKKN5ae3swSkIW7jf59Hjjg5p05O4VzgFlmHSqr5ZKRbqA0M0FeR40uvaZwBMJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1OQSO9lcmX2gDXyXBMyQLgy9JJnB0lniS0P6G4gJ3HEEf0Qd+
	/PlmjZTUAoiWk0J0ftzTwznFXnf+2uAcWVMCUjfUhDY5eCnYA5UmiLe8SV45O5cJL9XwaISLGqP
	XEyw1i5yrDaZcCrA0dg==
X-Google-Smtp-Source: AGHT+IHFbrkfCQFcNk6bb2vCkoEy+Jo+99SJ0Tqqy456cPB0dsshgXKqM8xPJSaYDimaeBgCaAT6wFW4fL0Ztw0=
X-Received: from wrvl7.prod.google.com ([2002:a5d:5607:0:b0:3dc:3108:9843])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e54a:0:b0:3d3:6525:e320 with SMTP id ffacd0b85a97d-3e304081e46mr2546666f8f.29.1757074297183;
 Fri, 05 Sep 2025 05:11:37 -0700 (PDT)
Date: Fri, 05 Sep 2025 12:11:28 +0000
In-Reply-To: <20250905-vmbo-defer-v1-0-7ae1a382b674@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905-vmbo-defer-v1-0-7ae1a382b674@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=10160; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=52WoN1Pmy2AcHTRvbpGs0/D/mgk8eznKWIWJ1Q2Pcg4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBoutN2OiuZdQO4gp5wu1ljn6MvQsNIGoViW/w4U
 RZyLKQ5AYuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaLrTdgAKCRAEWL7uWMY5
 RgFjEACvjAx+tNXXFceeuwIqU31O8s/mpB4mbeFsSl4CCDlIN653zQ4ptgdjjAvEqUtyAaVSx5t
 mhdV25A7NbxJLBHXFKzsc/4gnKep3lg9S6xo9Kw3uiRCVcEYawvnmGb6BqEP1yvG/LJqgquwjR/
 JJmO0BFuYbRwezEYGi66bG3Yqnuu34wEoqO4xF8OMPbpX9f1G82DGwnIwynuSHbA/yzmwiaul29
 bnCK7b3rtGIdXig3V/rLr07kyumjD2w0hGcgdcaIE9TLdGFOOm4lokPLVAxO/Tr5lLT4+4Ae2hq
 E+oEpSvHSHfFJcNgvutlVLFxwe5KbbklCHHMr2N8NJQMpcFqYroUoFs6X16Px0tJ20IQLc6ZT9v
 BHadwmO5rbN+535q3pCHYBGkVskIZkhbP0i1HgtEfhB4sg+EtuaJZrZ4LCNaLCvavn8u2eb6zHh
 gdZuWFlTJ846eHTOTqJf0B4110waR690rF2A+7yhkNCx5cgYdRH2cVs1ds//Jd8pslFIVyuV9VO
 ZB2D07DlJn0TzqCNmU/4hvt+P1CraMup3MZT8bQTBdlIlrFux7cQlZkcjSHQ01ZFwsP3X9pRzes
 cVoaQnEy5Ch6TFov9ywTY2zKWbGfW4TlpdHrAUVcXqg59Y4DPaazD3Gy6F8GvZkWF3kC5uXgB6x Yuz8Dh1/dl4uytA==
X-Mailer: b4 0.14.2
Message-ID: <20250905-vmbo-defer-v1-1-7ae1a382b674@google.com>
Subject: [PATCH 1/2] drm/gpuvm: add deferred vm_bo cleanup
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

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 167 ++++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_gpuvm.h     |  26 +++++++
 2 files changed, 193 insertions(+)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 78a1a4f095095e9379bdf604d583f6c8b9863ccb..849b6c08f83dcba832eda372bd3ce62b540e144b 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -876,6 +876,25 @@ __drm_gpuvm_bo_list_add(struct drm_gpuvm *gpuvm, spinlock_t *lock,
 	cond_spin_unlock(lock, !!lock);
 }
 
+/**
+ * drm_gpuvm_bo_is_dead() - check whether this vm_bo is scheduled for cleanup
+ * @vm_bo: the &drm_gpuvm_bo
+ *
+ * When a vm_bo is scheduled for cleanup using the bo_defer list, it is not
+ * immediately removed from the evict and extobj lists. Therefore, anyone
+ * iterating these lists should skip entries that are being destroyed.
+ *
+ * Checking the refcount without incrementing it is okay as long as the lock
+ * protecting the evict/extobj list is held for as long as you are using the
+ * vm_bo, because even if the refcount hits zero while you are using it, freeing
+ * the vm_bo requires taking the list's lock.
+ */
+static bool
+drm_gpuvm_bo_is_dead(struct drm_gpuvm_bo *vm_bo)
+{
+	return !kref_read(&vm_bo->kref);
+}
+
 /**
  * drm_gpuvm_bo_list_add() - insert a vm_bo into the given list
  * @__vm_bo: the &drm_gpuvm_bo
@@ -1081,6 +1100,9 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
 	INIT_LIST_HEAD(&gpuvm->evict.list);
 	spin_lock_init(&gpuvm->evict.lock);
 
+	INIT_LIST_HEAD(&gpuvm->bo_defer.list);
+	spin_lock_init(&gpuvm->bo_defer.lock);
+
 	kref_init(&gpuvm->kref);
 
 	gpuvm->name = name ? name : "unknown";
@@ -1122,6 +1144,8 @@ drm_gpuvm_fini(struct drm_gpuvm *gpuvm)
 		 "Extobj list should be empty.\n");
 	drm_WARN(gpuvm->drm, !list_empty(&gpuvm->evict.list),
 		 "Evict list should be empty.\n");
+	drm_WARN(gpuvm->drm, !list_empty(&gpuvm->bo_defer.list),
+		 "VM BO cleanup list should be empty.\n");
 
 	drm_gem_object_put(gpuvm->r_obj);
 }
@@ -1217,6 +1241,9 @@ drm_gpuvm_prepare_objects_locked(struct drm_gpuvm *gpuvm,
 
 	drm_gpuvm_resv_assert_held(gpuvm);
 	list_for_each_entry(vm_bo, &gpuvm->extobj.list, list.entry.extobj) {
+		if (drm_gpuvm_bo_is_dead(vm_bo))
+			continue;
+
 		ret = exec_prepare_obj(exec, vm_bo->obj, num_fences);
 		if (ret)
 			break;
@@ -1460,6 +1487,9 @@ drm_gpuvm_validate_locked(struct drm_gpuvm *gpuvm, struct drm_exec *exec)
 
 	list_for_each_entry_safe(vm_bo, next, &gpuvm->evict.list,
 				 list.entry.evict) {
+		if (drm_gpuvm_bo_is_dead(vm_bo))
+			continue;
+
 		ret = ops->vm_bo_validate(vm_bo, exec);
 		if (ret)
 			break;
@@ -1560,6 +1590,7 @@ drm_gpuvm_bo_create(struct drm_gpuvm *gpuvm,
 
 	INIT_LIST_HEAD(&vm_bo->list.entry.extobj);
 	INIT_LIST_HEAD(&vm_bo->list.entry.evict);
+	INIT_LIST_HEAD(&vm_bo->list.entry.bo_defer);
 
 	return vm_bo;
 }
@@ -1621,6 +1652,106 @@ drm_gpuvm_bo_put(struct drm_gpuvm_bo *vm_bo)
 }
 EXPORT_SYMBOL_GPL(drm_gpuvm_bo_put);
 
+static void
+drm_gpuvm_bo_defer_locked(struct kref *kref)
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
+	mutex_unlock(&vm_bo->obj->gpuva.lock);
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
+	bool defer;
+
+	drm_WARN_ON(vm_bo->vm->drm, !drm_gpuvm_immediate_mode(vm_bo->vm));
+
+	if (!vm_bo)
+		return false;
+
+	defer = kref_put_mutex(&vm_bo->kref, drm_gpuvm_bo_defer_locked,
+			       &vm_bo->obj->gpuva.lock);
+
+	/*
+	 * It's important that the GEM stays alive for the duration in which
+	 * drm_gpuvm_bo_defer_locked() holds the mutex, but the instant we add
+	 * the vm_bo to bo_defer, another thread might call
+	 * drm_gpuvm_bo_deferred_cleanup() and put the GEM. For this reason, we
+	 * add the vm_bo to bo_defer after releasing the GEM's mutex.
+	 */
+	if (defer)
+		drm_gpuvm_bo_list_add(vm_bo, bo_defer, true);
+
+	return defer;
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
+	LIST_HEAD(bo_defer);
+
+	spin_lock(&gpuvm->bo_defer.lock);
+	list_replace_init(&gpuvm->bo_defer.list, &bo_defer);
+	spin_unlock(&gpuvm->bo_defer.lock);
+
+	if (drm_gpuvm_resv_protected(gpuvm)) {
+		dma_resv_lock(drm_gpuvm_resv(gpuvm), NULL);
+		list_for_each_entry(vm_bo, &bo_defer, list.entry.bo_defer) {
+			drm_gpuvm_bo_list_del(vm_bo, extobj, false);
+			drm_gpuvm_bo_list_del(vm_bo, evict, false);
+		}
+		dma_resv_unlock(drm_gpuvm_resv(gpuvm));
+	}
+
+	while (!list_empty(&bo_defer)) {
+		vm_bo = list_first_entry(&bo_defer,
+			struct drm_gpuvm_bo, list.entry.bo_defer);
+		obj = vm_bo->obj;
+
+		list_del(&vm_bo->list.entry.bo_defer);
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
@@ -1948,6 +2079,42 @@ drm_gpuva_unlink(struct drm_gpuva *va)
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
+	 * This is drm_gpuvm_bo_put_deferred() slightly modified since we
+	 * already hold the mutex. It's important that we add the vm_bo to
+	 * bo_defer after releasing the mutex for the same reason as in
+	 * drm_gpuvm_bo_put_deferred().
+	 */
+	if (kref_put(&vm_bo->kref, drm_gpuvm_bo_defer_locked))
+		drm_gpuvm_bo_list_add(vm_bo, bo_defer, true);
+	else
+		mutex_unlock(&obj->gpuva.lock);
+
+	va->vm_bo = NULL;
+}
+EXPORT_SYMBOL_GPL(drm_gpuva_unlink_defer);
+
 /**
  * drm_gpuva_find_first() - find the first &drm_gpuva in the given range
  * @gpuvm: the &drm_gpuvm to search in
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 727b8f336fad0d853998e4379cbd374155468e18..1f80389e14312f552a8abc95d12f52f83beb9be8 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -152,6 +152,7 @@ void drm_gpuva_remove(struct drm_gpuva *va);
 
 void drm_gpuva_link(struct drm_gpuva *va, struct drm_gpuvm_bo *vm_bo);
 void drm_gpuva_unlink(struct drm_gpuva *va);
+void drm_gpuva_unlink_defer(struct drm_gpuva *va);
 
 struct drm_gpuva *drm_gpuva_find(struct drm_gpuvm *gpuvm,
 				 u64 addr, u64 range);
@@ -331,6 +332,22 @@ struct drm_gpuvm {
 		 */
 		spinlock_t lock;
 	} evict;
+
+	/**
+	 * @bo_defer: structure holding vm_bos that need to be destroyed
+	 */
+	struct {
+		/**
+		 * @bo_defer.list: &list_head storing &drm_gpuvm_bos that need
+		 * to be destroyed
+		 */
+		struct list_head list;
+
+		/**
+		 * @bo_defer.lock: spinlock to protect the bo_defer list
+		 */
+		spinlock_t lock;
+	} bo_defer;
 };
 
 void drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
@@ -714,6 +731,12 @@ struct drm_gpuvm_bo {
 			 * &drm_gpuvms evict list.
 			 */
 			struct list_head evict;
+
+			/**
+			 * @list.entry.bo_defer: List entry to attach to
+			 * the &drm_gpuvms bo_defer list.
+			 */
+			struct list_head bo_defer;
 		} entry;
 	} list;
 };
@@ -746,6 +769,9 @@ drm_gpuvm_bo_get(struct drm_gpuvm_bo *vm_bo)
 
 bool drm_gpuvm_bo_put(struct drm_gpuvm_bo *vm_bo);
 
+bool drm_gpuvm_bo_put_deferred(struct drm_gpuvm_bo *vm_bo);
+void drm_gpuvm_bo_deferred_cleanup(struct drm_gpuvm *gpuvm);
+
 struct drm_gpuvm_bo *
 drm_gpuvm_bo_find(struct drm_gpuvm *gpuvm,
 		  struct drm_gem_object *obj);

-- 
2.51.0.355.g5224444f11-goog


