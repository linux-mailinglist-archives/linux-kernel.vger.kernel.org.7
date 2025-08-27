Return-Path: <linux-kernel+bounces-788399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C9DB383CF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A521B20F39
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181993568F3;
	Wed, 27 Aug 2025 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OkKj6aAB"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9311356900
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756301935; cv=none; b=J7jOw/jBA+00fu7/mtNvvMqNxnWubz5FiOdClKDp+3Zl5sglHtoYPowct8AlxXN0Sh2uZ/K9DbBA9a2QAfDlubsHW3qEnzNYChkb7el7VyeOHlUxT1luyUjjaJQn2GIwlxzWN5lhSmjtwqh/v5O8OGcnAGxdholIUkEPmGAMX+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756301935; c=relaxed/simple;
	bh=0L5MN7VLrW13EBhcSJi1X2pbD/XrBvsXZWa3W9t+9eA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KjoaHgcyFnN8zZ8UXW6MA9kMu6d3tt+fkZF0bqH2v3040VQCL/8xmlKMt6kzGjCka+vc9GcFAr8sTjK1z31ztKPeyE05S99XAzyjBGQOrbNmc1GvfvoXb7emlqRhTAuwni9CAjeKKa11BocAb8BPf81puokgNhgFztD3IZL0eHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OkKj6aAB; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0cfbafso43120485e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756301931; x=1756906731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5NR1f1V0qJQoAZC32JpbQQDn0jnSX+Eb3gQ3cjs7iX0=;
        b=OkKj6aAB029wP8lPWo79mlb2JyBH5hQyxQBSf19s2XKJ4bshaEbol4TVRYBMO1AYFY
         d7SGkk5EbgQXKTaqxdJbER9yPt3RDThzgqFz+Bu2sRDbC1w4CiVrGLu2UK1RsVT9yQZc
         TThZUqyMm1Bix43v0T65Mcpy1MI8tjE6W7A59FTDxBgT09+bocQFlganGzjz/XGc+dox
         oZd+uk7l0LFJ0DqReq8oENPK0WzoH1wLNpsOZXxUJ74+UcU02CbsmyEW0B5wqu+aj32C
         kr6iWcEVzJP9scn5S2M7vnMM40BB+chCI1/0lls1c2WQ171+a8yZSYMeWtAAaml7jrFb
         9Gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756301931; x=1756906731;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NR1f1V0qJQoAZC32JpbQQDn0jnSX+Eb3gQ3cjs7iX0=;
        b=iRVglIxLNodPQtUJEYnYYjMbRrYLrdvvY9B2JDVsxiI+XVItzI6OvhriDPH0RYaZlp
         AmttuCcFRqpCszuMDtJKQlywxhKQXQ9lU+QcFnCAJOAozhSvD98WK8x6YxuGZ1bBeJ2s
         jRaTAICefOPnTZKekJH2K+HpZSclcPtUV5hWrqMt2vDegZdf1ihyryFNStkpM6EjsoVr
         n4g2HZwTvbfpncE6dcs4S76pokxW/rZc6m/HLH3cIPDSUJ2PybXIaQHenu44lNxubOFe
         ev/IzbCNUyal0tdpG6FqFeMYZe9lO7zhPtMGE46CdQGqk4bQvVe1si0M4Uzvd/kU3hyS
         ci0w==
X-Forwarded-Encrypted: i=1; AJvYcCU1u8pSB7+w+b3yCQWWnFZCwTfUsZaXPWEFlUVfb4x98qCVWMJZr4QlGgfCEPpw2qNNI5vSQl3v91JCnO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxURjq6pq01fvNfP6oJK7Z452kjouFNCnguDaKg2Ss5ZmH3RDU1
	qKT8QIzrPtwtpnALuomHa5q3285H4aGLPqze8eN2jrQxTdfx63B21rtk0NzVAE19UW8RZDK+gJO
	OoQc+6yiF9FttVJZ70A==
X-Google-Smtp-Source: AGHT+IFafGlP8UFqOxDnT4Yuf1Es+Hvy3FyMKmTpfS06X1hgk36wVUBbP6/S61siqr7xDliXKPIBZu+fKI/tOkQ=
X-Received: from wmbea5.prod.google.com ([2002:a05:600c:6745:b0:45b:4777:8063])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b23:b0:45b:47e1:f600 with SMTP id 5b1f17b1804b1-45b517dc59bmr170516715e9.36.1756301930996;
 Wed, 27 Aug 2025 06:38:50 -0700 (PDT)
Date: Wed, 27 Aug 2025 13:38:39 +0000
In-Reply-To: <20250827-gpuva-mutex-in-gem-v3-0-bd89f5a82c0d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827-gpuva-mutex-in-gem-v3-0-bd89f5a82c0d@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=12017; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=0L5MN7VLrW13EBhcSJi1X2pbD/XrBvsXZWa3W9t+9eA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBorwplYbAcdiliRpBBT2QIxKVqMqUGR0RUIpvla
 8hVDTugYNSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaK8KZQAKCRAEWL7uWMY5
 Rqr4D/9MGT4tqnMGQjdUfHmVfVdREPNuTUPIZSoetgv8+tMy2zoPRVzB7MC+qiaH14b6g8rWz8p
 lTm7bPzCsw8/PEq+VQtQPhUnQEiOelg50xefigjWY6PC1+NPKSqZSXLJ9wIRxGJWZ3xes0yHe6F
 u9fJjBYyE1SSpC3ZrCaxsRyVVRis3+mW+LqbdeCdHZ1EV4hdOOMLfbhcHyFdEOkvWrF2LAyfzok
 bkz1SqJ3gCNl01D0mhidXbRtMjXURqR/4OVxHh4weI+dH1eR3+X7dYyD2B/XZDOnnfjpwKj26eA
 4sJXLTwd/NhzAd7UO/9zNv20ijg6c5X7ristIWhOfznBYbFB+TKCbh5YAv5gbxg411vWDv4f8Vg
 Gg2ZAVodpk6+uQgzjoUWd3ttXxdcdhxI7zFSzf7nG0cXBNQfFcNwEfnv2SgLvGi7nI9hzYR2t4a
 sVseb6Ds8zSenQBX1YEvD4T7m2TbiZaVrJB+kOo0k0oE8XC2PbGKkU3C+4Lxe8eqH0tFGIWqStl
 VfhiIVYZQ7KeNzf1Ad0nKmoBRuMnN6R5016QsboI4NIlHYRvjOHezZ+fkrs7umQj2OV4RlpEtQ8
 DY5+EfJRbURVze+UTXwAHn8L4qziXGIo8dvX9hL3UlW8dkRM2iGEfnR/GdqO+nMW10H66Ymaq+k u/RowLSTFcUbIUA==
X-Mailer: b4 0.14.2
Message-ID: <20250827-gpuva-mutex-in-gem-v3-3-bd89f5a82c0d@google.com>
Subject: [PATCH v3 3/3] gpuvm: remove gem.gpuva.lock_dep_map
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

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/gpu/drm/drm_gpuvm.c           | 30 ++++++++++++-------------
 drivers/gpu/drm/panthor/panthor_gem.c |  1 -
 drivers/gpu/drm/panthor/panthor_mmu.c |  5 +++--
 include/drm/drm_gem.h                 | 41 +++++++++++++----------------------
 include/drm/drm_gpuvm.h               | 30 ++++++++++++++++++++++---
 5 files changed, 59 insertions(+), 48 deletions(-)

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
index a995c0c1b63c5946b1659cec08c360a5bb9e9fba..f197ed6b3dfa91b8e44c5fa8cc308c7a09b0fb3b 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -399,6 +399,12 @@ struct drm_gem_object {
 
 	/**
 	 * @gpuva: Fields used by GPUVM to manage mappings pointing to this GEM object.
+	 *
+	 * When DRM_GPUVM_IMMEDIATE_MODE is set, this list is protected by the
+	 * mutex. Otherwise, the list is protected by the GEMs &dma_resv lock.
+	 *
+	 * Note that all entries in this list must agree on whether
+	 * DRM_GPUVM_IMMEDIATE_MODE is set.
 	 */
 	struct {
 		/**
@@ -412,17 +418,14 @@ struct drm_gem_object {
 
 		/**
 		 * @gpuva.lock: lock protecting access to &drm_gem_object.gpuva.list
-		 * when the resv lock can't be used.
+		 * when DRM_GPUVM_IMMEDIATE_MODE is used.
 		 *
-		 * Should only be used when the VM is being modified in a fence
-		 * signalling path, otherwise you should use &drm_gem_object.resv to
-		 * protect accesses to &drm_gem_object.gpuva.list.
+		 * Only used when DRM_GPUVM_IMMEDIATE_MODE is set. It should be
+		 * safe to take this mutex during the fence signalling path, so
+		 * do not allocate memory while holding this lock. Otherwise,
+		 * the &dma_resv lock should be used.
 		 */
 		struct mutex lock;
-
-#ifdef CONFIG_LOCKDEP
-		struct lockdep_map *lock_dep_map;
-#endif
 	} gpuva;
 
 	/**
@@ -607,26 +610,12 @@ static inline bool drm_gem_is_imported(const struct drm_gem_object *obj)
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
index 4a22b9d848f7b3d5710ca554f5b01556abf95985..727b8f336fad0d853998e4379cbd374155468e18 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -196,10 +196,20 @@ enum drm_gpuvm_flags {
 	 */
 	DRM_GPUVM_RESV_PROTECTED = BIT(0),
 
+	/**
+	 * @DRM_GPUVM_IMMEDIATE_MODE: use the locking scheme for GEMs designed
+	 * for modifying the GPUVM during the fence signalling path
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
2.51.0.261.g7ce5a0a67e-goog


