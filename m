Return-Path: <linux-kernel+bounces-781507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5F8B31356
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7745E08DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7852F549F;
	Fri, 22 Aug 2025 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rocDaoLG"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19CA2F5320
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854936; cv=none; b=Y8ofzu23uxOPLAq/DBKzI2n6IZHZxQOllGH5Q9a3R62nRXWyeDLMiELxiqW4B1Klvd6XkgJKy1chY59Kt4+D9UZXMAiyMpmeTEC2ioFvUl5Hofya9+x8QU+UI+pf0phw7TUKo7SiqbvUGTuO3EHZnMP42seM2JGZzwix+gFQESg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854936; c=relaxed/simple;
	bh=k9/xP2hkYInqqac45oA3gCzuPA512fZCIHyvxtWcpMg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DBxQDcLzvOB46sfQGnQZE1UmTWYOv0e4BBYKHw8iBkh0cefRHzbFCuudeTBdXu1OUNe0oyt3a04232W0+n/tjZtK+Tq0IsALDjSpKeduHJ8Oirjo0BkK8gcUYtPBjAZK+EKelRanCdtk4/PO/Xaq+mUuM4m9JQp91LDfWTE4cq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rocDaoLG; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1ba17bbcso9816105e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755854931; x=1756459731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ow6XvHySGVB+W2kkd4+T1fvI3S18fIKSk8k0aXDVNI=;
        b=rocDaoLGg4w6MEC0kAzihMVq8zutH7wlGcpJKH2AG1WCuV56dqi1WZYABMP9C5pHFE
         dMiRvPPTlU4YmELay9dA8Zlb4TDHrJzhbvCxlJkFiBMz6JP4xPKUhVbK0OME0/b/Quut
         YU7ExiffmD9xHnZ+XPFy66KG6vBhwjLjFHOvKm7lAILsOy0Mxa/q1IqfDrhFj0YoTNY4
         4WonJeakbGVfuyjWgyQJcV1281YtA2UWWqeP5AXcnVJk/2Rvmcy2iKittGmq3aZeX9ce
         7TxrDA7M0KjVYLiQGGQK2gDPwZrVmPhzxcAxJU6DlMTPQhAbX36ScbLWsSQmZ8Xr891t
         Mtgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854931; x=1756459731;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ow6XvHySGVB+W2kkd4+T1fvI3S18fIKSk8k0aXDVNI=;
        b=qICOaDBnUdH6BZ80u1dOYwMcWUvdl5FRvIHdNQxQ/L30rgOxu4V7BjizFmWmddpqhI
         aNZv7w7QaN4jyhOtjlMgt4ah3cWoU9w58Fp+V16mz3p8B3LJ05TVGFdXZQbpFQXIrEmS
         SswPj0jkdG5svh7QWH3LkZTAoqNoBdCQTIH9FO3nhagMGfZNYVXeBeAblKx2ELLn261a
         eQxReLfb8IkOQEhtFB9WpNDzzeyiFf6cHd+ODCDuK7SjknB5D8UNhu+nydVAhnXyIMKs
         jcc47ClXSeTk/wxJTketjI+OozTvI5xcg4vN161JB76Rwat7dbsxrfApGcaZ55TwKtxK
         0OKg==
X-Forwarded-Encrypted: i=1; AJvYcCX7fLyiIApP2Av4DqpUM4LijU8lGE3eQhugqUcnrrP9J5XYptCf2RXOc55jXtEDAFQdU18gBqq4+cwS+pM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo/HU1DLYuiVmAHFeaNSXKwIKxH62Ut5/PZg6e9BSXzRri36vt
	6DDGD9wliBrZnLqqncCP2h0JN51cbP0leRkLVbAxPSC8VB8nocPJoBGQNND3Z5DlHW+GiK6LurZ
	2Lb48MaEp0yec+xL5Sg==
X-Google-Smtp-Source: AGHT+IF8c3P0Z1vVWG+q1H8oB/tl+UK9nbE+C7bMQrs2JLINSn9yU5stP/o7VIvQ7k/31mTwRHsWj+ndEZHzbog=
X-Received: from wmbfp14.prod.google.com ([2002:a05:600c:698e:b0:459:dd85:efda])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46cb:b0:458:bf7c:f744 with SMTP id 5b1f17b1804b1-45b517c2d5fmr15962175e9.32.1755854931287;
 Fri, 22 Aug 2025 02:28:51 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:28:26 +0000
In-Reply-To: <20250822-gpuva-mutex-in-gem-v2-0-c41a10d1d3b9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822-gpuva-mutex-in-gem-v2-0-c41a10d1d3b9@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=11713; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=k9/xP2hkYInqqac45oA3gCzuPA512fZCIHyvxtWcpMg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBoqDhOQQ087NxYuUsEEHxVqXjk/V0HkIsZnfuwq
 OpQGacdCY2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaKg4TgAKCRAEWL7uWMY5
 Rkh1EACbdGSW+CooCJs/PhJwX0poaGeozdfxI18YoRFDYpQ24dqxZ5tp818A8OpttybLAT1/xto
 gxrudf7pULaUyz2tyAeny8BWOuwL5u4g2zwrEJtMu3L9+jKoS2nbzLe9QuL3uUuW/NH0ibvxR22
 Sxl8QnTJiJKoQE8EMituIZxAdNo/QzTWRavUtyvcN7KWZ8chRhz+NVvBpJwJKsWmOWH5vaqZBxU
 XZsUXR8vPGkJZBA2e9XDgxPpX3qWsTcGFXhRLpzz0LneulEX52MCUrxqvxD+A1133XKddm081me
 yGN85EA4HJ5psOPm5SQhmqhEu4Yrw5J5FJLy/SQpMGQ4q9EdOXOyioISu1bvvlvDIEJ1uophX4Q
 FdpaNhiQyQjCn7eej8N2HrlxQtmn+XUbLn7fmmmeE9Mo7k1OfSLu8i4tIyTyaXW8LM76xb84TaN
 n2iIeRU1pIOWE+IvoDqfxx1AXeLufMRnfGYPskc4kTSFBmMNGf4/n5QdIQb7to9Oabsk8jKFOkb
 2H9MKo7UnjFG2K6SANiT493HJceFM/Jv8h2YQUH86o2wWds6frpG+a/yjuaFaWYIcYFRe1BYj30
 RLSaPMoiSuOwrZnkD0CH2eq2b+LOaDWSC+K48q9pUZIWVGZQE2M7Qdf1HSiVnfc3oskTwQxyx89 dkLbygBbPlgWnpw==
X-Mailer: b4 0.14.2
Message-ID: <20250822-gpuva-mutex-in-gem-v2-3-c41a10d1d3b9@google.com>
Subject: [PATCH v2 3/3] gpuvm: remove gem.gpuva.lock_dep_map
From: Alice Ryhl <aliceryhl@google.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Danilo Krummrich <dakr@kernel.org>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Since all users of gem.gpuva.lock_dep_map now rely on the mutex directly
in gpuva, we may remove it. Whether the mutex is used is now tracked by
a flag in gpuvm rather than by whether lock_dep_map is null.

Note that a GEM object may not be pushed to multiple gpuvms that
disagree on the value of this new flag. But that's okay because a single
driver should use the same locking scheme everywhere, and a GEM object
is driver specific (when a GEM is exported with prime, a new GEM object
instance is created from the backing dma-buf).

The flag is present even with CONFIG_LOCKDEP=n because the intent is
that the flag will also cause vm_bo cleanup to become deferred. However,
that will happen in a follow-up patch.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/gpu/drm/drm_gpuvm.c           | 30 +++++++++++++--------------
 drivers/gpu/drm/panthor/panthor_gem.c |  1 -
 drivers/gpu/drm/panthor/panthor_mmu.c |  5 +++--
 include/drm/drm_gem.h                 | 39 ++++++++++++++---------------------
 include/drm/drm_gpuvm.h               | 30 ++++++++++++++++++++++++---
 5 files changed, 59 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index d6bea8a4fffd7613fb9b9ed5c795df373da2e7b6..78a1a4f095095e9379bdf604d583f6c8b9863ccb 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -497,8 +497,7 @@
  * DRM GPUVM also does not take care of the locking of the backing
  * &drm_gem_object buffers GPU VA lists and &drm_gpuvm_bo abstractions by
  * itself; drivers are responsible to enforce mutual exclusion using either the
- * GEMs dma_resv lock or alternatively a driver specific external lock. For the
- * latter see also drm_gem_gpuva_set_lock().
+ * GEMs dma_resv lock or the GEMs gpuva.lock mutex.
  *
  * However, DRM GPUVM contains lockdep checks to ensure callers of its API hold
  * the corresponding lock whenever the &drm_gem_objects GPU VA list is accessed
@@ -1582,7 +1581,7 @@ drm_gpuvm_bo_destroy(struct kref *kref)
 	drm_gpuvm_bo_list_del(vm_bo, extobj, lock);
 	drm_gpuvm_bo_list_del(vm_bo, evict, lock);
 
-	drm_gem_gpuva_assert_lock_held(obj);
+	drm_gem_gpuva_assert_lock_held(gpuvm, obj);
 	list_del(&vm_bo->list.entry.gem);
 
 	if (ops && ops->vm_bo_free)
@@ -1603,7 +1602,8 @@ drm_gpuvm_bo_destroy(struct kref *kref)
  * If the reference count drops to zero, the &gpuvm_bo is destroyed, which
  * includes removing it from the GEMs gpuva list. Hence, if a call to this
  * function can potentially let the reference count drop to zero the caller must
- * hold the dma-resv or driver specific GEM gpuva lock.
+ * hold the lock that the GEM uses for its gpuva list (either the GEM's
+ * dma-resv or gpuva.lock mutex).
  *
  * This function may only be called from non-atomic context.
  *
@@ -1627,7 +1627,7 @@ __drm_gpuvm_bo_find(struct drm_gpuvm *gpuvm,
 {
 	struct drm_gpuvm_bo *vm_bo;
 
-	drm_gem_gpuva_assert_lock_held(obj);
+	drm_gem_gpuva_assert_lock_held(gpuvm, obj);
 	drm_gem_for_each_gpuvm_bo(vm_bo, obj)
 		if (vm_bo->vm == gpuvm)
 			return vm_bo;
@@ -1686,7 +1686,7 @@ drm_gpuvm_bo_obtain(struct drm_gpuvm *gpuvm,
 	if (!vm_bo)
 		return ERR_PTR(-ENOMEM);
 
-	drm_gem_gpuva_assert_lock_held(obj);
+	drm_gem_gpuva_assert_lock_held(gpuvm, obj);
 	list_add_tail(&vm_bo->list.entry.gem, &obj->gpuva.list);
 
 	return vm_bo;
@@ -1722,7 +1722,7 @@ drm_gpuvm_bo_obtain_prealloc(struct drm_gpuvm_bo *__vm_bo)
 		return vm_bo;
 	}
 
-	drm_gem_gpuva_assert_lock_held(obj);
+	drm_gem_gpuva_assert_lock_held(gpuvm, obj);
 	list_add_tail(&__vm_bo->list.entry.gem, &obj->gpuva.list);
 
 	return __vm_bo;
@@ -1894,8 +1894,7 @@ EXPORT_SYMBOL_GPL(drm_gpuva_remove);
  * reference of the latter is taken.
  *
  * This function expects the caller to protect the GEM's GPUVA list against
- * concurrent access using either the GEMs dma_resv lock or a driver specific
- * lock set through drm_gem_gpuva_set_lock().
+ * concurrent access using either the GEM's dma-resv or gpuva.lock mutex.
  */
 void
 drm_gpuva_link(struct drm_gpuva *va, struct drm_gpuvm_bo *vm_bo)
@@ -1910,7 +1909,7 @@ drm_gpuva_link(struct drm_gpuva *va, struct drm_gpuvm_bo *vm_bo)
 
 	va->vm_bo = drm_gpuvm_bo_get(vm_bo);
 
-	drm_gem_gpuva_assert_lock_held(obj);
+	drm_gem_gpuva_assert_lock_held(gpuvm, obj);
 	list_add_tail(&va->gem.entry, &vm_bo->list.gpuva);
 }
 EXPORT_SYMBOL_GPL(drm_gpuva_link);
@@ -1930,8 +1929,7 @@ EXPORT_SYMBOL_GPL(drm_gpuva_link);
  * the latter is dropped.
  *
  * This function expects the caller to protect the GEM's GPUVA list against
- * concurrent access using either the GEMs dma_resv lock or a driver specific
- * lock set through drm_gem_gpuva_set_lock().
+ * concurrent access using either the GEM's dma-resv or gpuva.lock mutex.
  */
 void
 drm_gpuva_unlink(struct drm_gpuva *va)
@@ -1942,7 +1940,7 @@ drm_gpuva_unlink(struct drm_gpuva *va)
 	if (unlikely(!obj))
 		return;
 
-	drm_gem_gpuva_assert_lock_held(obj);
+	drm_gem_gpuva_assert_lock_held(va->vm, obj);
 	list_del_init(&va->gem.entry);
 
 	va->vm_bo = NULL;
@@ -2943,8 +2941,8 @@ EXPORT_SYMBOL_GPL(drm_gpuvm_prefetch_ops_create);
  * After the caller finished processing the returned &drm_gpuva_ops, they must
  * be freed with &drm_gpuva_ops_free.
  *
- * It is the callers responsibility to protect the GEMs GPUVA list against
- * concurrent access using the GEMs dma_resv lock.
+ * This function expects the caller to protect the GEM's GPUVA list against
+ * concurrent access using either the GEM's dma-resv or gpuva.lock mutex.
  *
  * Returns: a pointer to the &drm_gpuva_ops on success, an ERR_PTR on failure
  */
@@ -2956,7 +2954,7 @@ drm_gpuvm_bo_unmap_ops_create(struct drm_gpuvm_bo *vm_bo)
 	struct drm_gpuva *va;
 	int ret;
 
-	drm_gem_gpuva_assert_lock_held(vm_bo->obj);
+	drm_gem_gpuva_assert_lock_held(vm_bo->vm, vm_bo->obj);
 
 	ops = kzalloc(sizeof(*ops), GFP_KERNEL);
 	if (!ops)
diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index c654a3377903cf7e067becdb481fb14895a4eaa5..156c7a0b62a231219645095d6012a5b108130bbc 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -245,7 +245,6 @@ struct drm_gem_object *panthor_gem_create_object(struct drm_device *ddev, size_t
 
 	obj->base.base.funcs = &panthor_gem_funcs;
 	obj->base.map_wc = !ptdev->coherent;
-	drm_gem_gpuva_set_lock(&obj->base.base, &obj->base.base.gpuva.lock);
 	mutex_init(&obj->label.lock);
 
 	panthor_gem_debugfs_bo_init(obj);
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 2881942ab5115686803fb9d9036bc059d56b7fa3..ee9e94448b76ffd31a97d82a857fa925c4cf0cb5 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2420,8 +2420,9 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 	 * to be handled the same way user VMAs are.
 	 */
 	drm_gpuvm_init(&vm->base, for_mcu ? "panthor-MCU-VM" : "panthor-GPU-VM",
-		       DRM_GPUVM_RESV_PROTECTED, &ptdev->base, dummy_gem,
-		       min_va, va_range, 0, 0, &panthor_gpuvm_ops);
+		       DRM_GPUVM_RESV_PROTECTED | DRM_GPUVM_IMMEDIATE_MODE,
+		       &ptdev->base, dummy_gem, min_va, va_range, 0, 0,
+		       &panthor_gpuvm_ops);
 	drm_gem_object_put(dummy_gem);
 	return vm;
 
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 5934d8dc267a65aaf62d2d025869221cd110b325..85a25bbb387c4590678e4ba243b51acd94b008ed 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -402,17 +402,22 @@ struct drm_gem_object {
 	 *
 	 * Provides the list of GPU VAs attached to this GEM object.
 	 *
-	 * Drivers should lock list accesses with the GEMs &dma_resv lock
-	 * (&drm_gem_object.resv) or a custom lock if one is provided. The
-	 * mutex inside this struct may be used as the custom lock.
+	 * When DRM_GPUVM_IMMEDIATE_MODE is set, this list is protected by the
+	 * mutex. Otherwise, the list is protected by the GEMs &dma_resv lock.
+	 *
+	 * Note that all entries in this list must agree on whether
+	 * DRM_GPUVM_IMMEDIATE_MODE is set.
 	 */
 	struct {
 		struct list_head list;
 
+		/**
+		 * @gpuva.lock: Only used when DRM_GPUVM_IMMEDIATE_MODE is set.
+		 * It should be safe to take this mutex during the fence
+		 * signalling path, so do not allocate memory while holding
+		 * this lock.
+		 */
 		struct mutex lock;
-#ifdef CONFIG_LOCKDEP
-		struct lockdep_map *lock_dep_map;
-#endif
 	} gpuva;
 
 	/**
@@ -597,26 +602,12 @@ static inline bool drm_gem_is_imported(const struct drm_gem_object *obj)
 }
 
 #ifdef CONFIG_LOCKDEP
-/**
- * drm_gem_gpuva_set_lock() - Set the lock protecting accesses to the gpuva list.
- * @obj: the &drm_gem_object
- * @lock: the lock used to protect the gpuva list. The locking primitive
- * must contain a dep_map field.
- *
- * Call this if you're not proctecting access to the gpuva list with the
- * dma-resv lock, but with a custom lock.
- */
-#define drm_gem_gpuva_set_lock(obj, lock) \
-	if (!WARN((obj)->gpuva.lock_dep_map, \
-		  "GEM GPUVA lock should be set only once.")) \
-		(obj)->gpuva.lock_dep_map = &(lock)->dep_map
-#define drm_gem_gpuva_assert_lock_held(obj) \
-	lockdep_assert((obj)->gpuva.lock_dep_map ? \
-		       lock_is_held((obj)->gpuva.lock_dep_map) : \
+#define drm_gem_gpuva_assert_lock_held(gpuvm, obj) \
+	lockdep_assert(drm_gpuvm_immediate_mode(gpuvm) ? \
+		       lock_is_held(&(obj)->gpuva.lock.dep_map) : \
 		       dma_resv_held((obj)->resv))
 #else
-#define drm_gem_gpuva_set_lock(obj, lock) do {} while (0)
-#define drm_gem_gpuva_assert_lock_held(obj) do {} while (0)
+#define drm_gem_gpuva_assert_lock_held(gpuvm, obj) do {} while (0)
 #endif
 
 /**
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 4a22b9d848f7b3d5710ca554f5b01556abf95985..598ba376b9430cdd4ab7bacdc15de031a887cf71 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -196,10 +196,20 @@ enum drm_gpuvm_flags {
 	 */
 	DRM_GPUVM_RESV_PROTECTED = BIT(0),
 
+	/**
+	 * @DRM_GPUVM_IMMEDIATE_MODE: use the locking scheme that makes it safe
+	 * to modify the GPUVM during the fence signalling path
+	 *
+	 * When set, gpuva.lock is used to protect gpuva.list in all GEM
+	 * objects associated with this GPUVM. Otherwise, the GEMs dma-resv is
+	 * used.
+	 */
+	DRM_GPUVM_IMMEDIATE_MODE = BIT(1),
+
 	/**
 	 * @DRM_GPUVM_USERBITS: user defined bits
 	 */
-	DRM_GPUVM_USERBITS = BIT(1),
+	DRM_GPUVM_USERBITS = BIT(2),
 };
 
 /**
@@ -369,6 +379,19 @@ drm_gpuvm_resv_protected(struct drm_gpuvm *gpuvm)
 	return gpuvm->flags & DRM_GPUVM_RESV_PROTECTED;
 }
 
+/**
+ * drm_gpuvm_immediate_mode() - indicates whether &DRM_GPUVM_IMMEDIATE_MODE is
+ * set
+ * @gpuvm: the &drm_gpuvm
+ *
+ * Returns: true if &DRM_GPUVM_IMMEDIATE_MODE is set, false otherwise.
+ */
+static inline bool
+drm_gpuvm_immediate_mode(struct drm_gpuvm *gpuvm)
+{
+	return gpuvm->flags & DRM_GPUVM_IMMEDIATE_MODE;
+}
+
 /**
  * drm_gpuvm_resv() - returns the &drm_gpuvm's &dma_resv
  * @gpuvm__: the &drm_gpuvm
@@ -742,9 +765,10 @@ drm_gpuvm_bo_gem_evict(struct drm_gem_object *obj, bool evict)
 {
 	struct drm_gpuvm_bo *vm_bo;
 
-	drm_gem_gpuva_assert_lock_held(obj);
-	drm_gem_for_each_gpuvm_bo(vm_bo, obj)
+	drm_gem_for_each_gpuvm_bo(vm_bo, obj) {
+		drm_gem_gpuva_assert_lock_held(vm_bo->vm, obj);
 		drm_gpuvm_bo_evict(vm_bo, evict);
+	}
 }
 
 void drm_gpuvm_bo_extobj_add(struct drm_gpuvm_bo *vm_bo);

-- 
2.51.0.rc2.233.g662b1ed5c5-goog


