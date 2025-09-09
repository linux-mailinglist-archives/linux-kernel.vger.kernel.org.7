Return-Path: <linux-kernel+bounces-808284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1696FB4FD63
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1C1C4E2E75
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D64A342CA7;
	Tue,  9 Sep 2025 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XiO9CFMS"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85193375AE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425000; cv=none; b=TxAY9NUo2VHDdFIXwN9GVLWKmQXi+7X4CPWt48EVwshEvGl1rKAjGUVIxUQTIRu8kHfjD5AH61Cy71hk3Su6x9OJJH/gk2ONuBkbK+MTRIkv818iJT9wRrqqDHo+O8Tl+CHk2Yk/5TwYw0maeUY/lrCPQ37Ci0+RkUukU58bgCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425000; c=relaxed/simple;
	bh=WI82kuEYUQ/DPEWsSvq70ZbnanfAbLU9MPBdQKjIz5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WrpEpHkeKeW29zDAhXhetZKhFr2bnWlrMTCK3YtXbNXHGVl100o+pSnz0dEJ+lOXf3gq0nvU7kCEMO5lDyBUH6enrNgZ7W0GpC9471ZLAgyq14V/ZHqpwa+SvgarBdVaGqtwecFduYQL+m4isYajpUthTUd8zKV4X2JOrfGg9Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XiO9CFMS; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3e4a8e6df10so1813306f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757424997; x=1758029797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A3K2CGHvkwip2S9fXZslbCnN2dA9eSP+jmcVGuT7SlY=;
        b=XiO9CFMSmdqbQFkM7mfH32LxM2v/LFNSETGrXBi2K3v9LlCbiS3aHdP/2rEfBIna6g
         dXYBXRQiwj2uenaPPps0DC++SIG/Gq7nyGB69UMi/WMLIC5aztTlWGz8sTIp6d7vZm1c
         QIj+YxGkp7GNs+Oe14OACW0yI002hMJqOSY5eHbnKwD6rdku7ntQSwovwXrjVkjrhQEi
         PWKyRYZ1GZGD158u40Lg8z5pq1BnDPZE7hBhe4O4d8HK6TiWfzm0zZnWYq1PiD3NJ340
         lVe6H003cojdl/7BzZF0aiTBRO17rAJt0neiPsHOeIGaL8NW2XwtZ82lM2h8Fd3lfjcl
         PVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424997; x=1758029797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3K2CGHvkwip2S9fXZslbCnN2dA9eSP+jmcVGuT7SlY=;
        b=nbpi3nayNmaAmiF8ABVrupepIyYWujsWUXlwO9rZ9pGYXKk/sQ9aLLecQWvbGYLyRI
         7b9j7BOEqRcwr6VdzWWjMwpfWVQwXA6ivML86GxAPx2tNHPa+0shIONrq8hrCL+O6/bS
         783wE0x/uZfcnMYX1Gse2OdeINwo/F1F0bJVRR/OfJ3YdobvYy/rR/ATopn2gcMzGa/j
         FIecHfn3TpbPl+EfmMMYVmP99Mbm665cXQTW3aLD0Mc8c4OctNxdUxOTi4ANc78VmtUM
         Xq7aT48XWY+kUQfy5nH+lKToHrAheqOeSqMENvOLoWoCQcfPS/IekxyyaNnHf4Hbg7AH
         2+ng==
X-Forwarded-Encrypted: i=1; AJvYcCUWzGViTlVMkOaFLdByDZhLvtFIY3BzIndsB9bYuhNpVTeIYZFCifFH+4mNSoz+S4S/cSJS6eLVphoUd44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw/6PDj5i08mitp1Z3d37KhgMzWWzRTRllkyRpF0clkao+qqS7
	n7ziEQ4dC5ebptRKpcl/KtOEMSZnnEZ8zjxkFNFMuGc4tCLAUkXDrUMAh4lxKVwJDB08wPXfELS
	oyybSvvYOo2SRZxQngA==
X-Google-Smtp-Source: AGHT+IGELjPGrMVoKzyVUw7RU0RDMDA/udhduYMsi2Ny05IaHAZWA9G7vbWFWV28nhJqeqUpd5PBZtW0fZu0Yc0=
X-Received: from wmsr5.prod.google.com ([2002:a05:600c:8b05:b0:45d:e24a:b2c0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:584c:0:b0:3c8:29eb:732e with SMTP id ffacd0b85a97d-3e6441e514cmr9781857f8f.59.1757424996971;
 Tue, 09 Sep 2025 06:36:36 -0700 (PDT)
Date: Tue, 09 Sep 2025 13:36:22 +0000
In-Reply-To: <20250909-vmbo-defer-v2-0-9835d7349089@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909-vmbo-defer-v2-0-9835d7349089@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=10349; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=WI82kuEYUQ/DPEWsSvq70ZbnanfAbLU9MPBdQKjIz5Q=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBowC1ihsTIK0KfmYoahEtBClUCqBDpZSy4eSBFW
 bn6h/piDMWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaMAtYgAKCRAEWL7uWMY5
 Rg3OEACk8y9W/LM++xVMHDgjaYE0tPI91cweb2VqlDz/FHHEbJyCXHYd4I1FmJqEEpJjOq8bqKu
 6ZuD1M0R4/c7f33VUiduDBgSdKAehQ+qoJsMR1bxN812IuFv4OlqTTW7kyJSC85DKH75rvAimzJ
 +FW/7RTsE9z15EVuhNxWw+XE1fiydOtL+dJJa5LG5EcSDKzcSHgU9BwMRL0DHxgy9fXvtbWqBK8
 5OVp8yPx9igDr31b0iC4jPA20LjBSGenGjmnNHnZBxsubgvNR6s7xS7rW5eOTQYEc4ChvaU6s3A
 aaF+EOZcjk0Lgq1MxRWSR95VNaEAzJkTFs4QvsKrLyYVCtXspZtaiMYFgVjpx8l8b6FwkamhQzT
 YXZRTFDCsZbocLyKll9Ie2eOTe9FQKFvChHeUltbEgigLbsVsG2kOyFy3PSzJDT6BZP85BPkRu1
 0zHWZBrOWMIjzB+Kith0F/hY01kp8aEqjHbtSVzfkecKYW/L8mHfXMOhh4z3iwUpbu4+aR8NO18
 viHv5hj9IcIEbYFVEDA6CNVnrsdPRrWZBhImFyeoLegHuzR6+u8wUHVESGYZ+RMraseqlLyyrMX
 6IwAIWGGJoJP+3m0PWup08/LqNaTLjpoPasBUkGi/yBl6TzlrN27zy28HOTi4eAePPKyEfJwhSo Vcs8YIidK1Al+Vw==
X-Mailer: b4 0.14.2
Message-ID: <20250909-vmbo-defer-v2-1-9835d7349089@google.com>
Subject: [PATCH v2 1/2] drm/gpuvm: add deferred vm_bo cleanup
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
 drivers/gpu/drm/drm_gpuvm.c | 174 ++++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_gpuvm.h     |  26 +++++++
 2 files changed, 200 insertions(+)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 78a1a4f095095e9379bdf604d583f6c8b9863ccb..5aa8b3813019705f70101950af2d8fe4e648e9d0 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -876,6 +876,27 @@ __drm_gpuvm_bo_list_add(struct drm_gpuvm *gpuvm, spinlock_t *lock,
 	cond_spin_unlock(lock, !!lock);
 }
 
+/**
+ * drm_gpuvm_bo_is_dead() - check whether this vm_bo is scheduled for cleanup
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
+drm_gpuvm_bo_is_dead(struct drm_gpuvm_bo *vm_bo)
+{
+	return !kref_read(&vm_bo->kref);
+}
+
 /**
  * drm_gpuvm_bo_list_add() - insert a vm_bo into the given list
  * @__vm_bo: the &drm_gpuvm_bo
@@ -1081,6 +1102,9 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
 	INIT_LIST_HEAD(&gpuvm->evict.list);
 	spin_lock_init(&gpuvm->evict.lock);
 
+	INIT_LIST_HEAD(&gpuvm->bo_defer.list);
+	spin_lock_init(&gpuvm->bo_defer.lock);
+
 	kref_init(&gpuvm->kref);
 
 	gpuvm->name = name ? name : "unknown";
@@ -1122,6 +1146,8 @@ drm_gpuvm_fini(struct drm_gpuvm *gpuvm)
 		 "Extobj list should be empty.\n");
 	drm_WARN(gpuvm->drm, !list_empty(&gpuvm->evict.list),
 		 "Evict list should be empty.\n");
+	drm_WARN(gpuvm->drm, !list_empty(&gpuvm->bo_defer.list),
+		 "VM BO cleanup list should be empty.\n");
 
 	drm_gem_object_put(gpuvm->r_obj);
 }
@@ -1217,6 +1243,9 @@ drm_gpuvm_prepare_objects_locked(struct drm_gpuvm *gpuvm,
 
 	drm_gpuvm_resv_assert_held(gpuvm);
 	list_for_each_entry(vm_bo, &gpuvm->extobj.list, list.entry.extobj) {
+		if (drm_gpuvm_bo_is_dead(vm_bo))
+			continue;
+
 		ret = exec_prepare_obj(exec, vm_bo->obj, num_fences);
 		if (ret)
 			break;
@@ -1460,6 +1489,9 @@ drm_gpuvm_validate_locked(struct drm_gpuvm *gpuvm, struct drm_exec *exec)
 
 	list_for_each_entry_safe(vm_bo, next, &gpuvm->evict.list,
 				 list.entry.evict) {
+		if (drm_gpuvm_bo_is_dead(vm_bo))
+			continue;
+
 		ret = ops->vm_bo_validate(vm_bo, exec);
 		if (ret)
 			break;
@@ -1560,6 +1592,7 @@ drm_gpuvm_bo_create(struct drm_gpuvm *gpuvm,
 
 	INIT_LIST_HEAD(&vm_bo->list.entry.extobj);
 	INIT_LIST_HEAD(&vm_bo->list.entry.evict);
+	INIT_LIST_HEAD(&vm_bo->list.entry.bo_defer);
 
 	return vm_bo;
 }
@@ -1621,6 +1654,113 @@ drm_gpuvm_bo_put(struct drm_gpuvm_bo *vm_bo)
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
+}
+
+static void
+drm_gpuvm_bo_defer(struct kref *kref)
+{
+	struct drm_gpuvm_bo *vm_bo = container_of(kref, struct drm_gpuvm_bo,
+						  kref);
+
+	mutex_lock(&vm_bo->obj->gpuva.lock);
+	drm_gpuvm_bo_defer_locked(kref);
+	mutex_unlock(&vm_bo->obj->gpuva.lock);
+
+	/*
+	 * It's important that the GEM stays alive for the duration in which we
+	 * hold the mutex, but the instant we add the vm_bo to bo_defer,
+	 * another thread might call drm_gpuvm_bo_deferred_cleanup() and put
+	 * the GEM. Therefore, to avoid kfreeing a mutex we are holding, we add
+	 * the vm_bo to bo_defer *after* releasing the GEM's mutex.
+	 */
+	drm_gpuvm_bo_list_add(vm_bo, bo_defer, true);
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
+	return !!kref_put(&vm_bo->kref, drm_gpuvm_bo_defer);
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
+	if (list_empty(&bo_defer))
+		return;
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
@@ -1948,6 +2088,40 @@ drm_gpuva_unlink(struct drm_gpuva *va)
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
+	should_defer_bo = kref_put(&vm_bo->kref, drm_gpuvm_bo_defer_locked);
+	mutex_unlock(&obj->gpuva.lock);
+	if (should_defer_bo)
+		drm_gpuvm_bo_list_add(vm_bo, bo_defer, true);
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
2.51.0.384.g4c02a37b29-goog


