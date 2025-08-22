Return-Path: <linux-kernel+bounces-781506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A00B31355
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC1D5C3FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7174C2F5474;
	Fri, 22 Aug 2025 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="spy5cHP5"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FBE2F4A13
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854933; cv=none; b=mMLq7YKlxdKTsAKrFm0yzL7J/gpZkv86AIHml0BbWoWW32oL6BuhRKSqIT8McV2RgMVwqxH2fTcRaotDYBj1xyo9JJzac20SpiWcaofrByokWlrSt34tHQEnRua0IGQ/j0UqdiFEYMs9Jeji0/DFY60TK3cgzOxggeu0rK5jglI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854933; c=relaxed/simple;
	bh=PXzH6D27ejnFW1kfBtz8z7koA1/45HNd1QgE8a5IH60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KRTAU1967FxJW0NOEQ64BVWH9bPrARadRDAdUC6ildE9wVbUPBXpL01QW8WJCfwMSLXGPduMJkUXdH7SvLALu1GWEPD5I8Z2Wa4bRFUvVzRSPZmyAHm3LoAbDKbbGo7+cmT8kLCTt6/dcMZihcH3dAfNj6NGxYRP3TDUM8vn7sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=spy5cHP5; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-6188b5b20efso1634110a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755854930; x=1756459730; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e+7jovikICPfeDBh9+sigj3WevDGgGN+HdnZFDA9m7c=;
        b=spy5cHP5P5KBANNvhzeAyuk4I+ZYxFl4PjfLR3KqYTok8x6l9aPH5NMLsr2dL19uH0
         Czex0p3yhsnM/WnDerkxyU7bQNVRNGqg5llg/YWi9O4m1sJaX27HeXk4ciBxuAD8lf95
         kMOr0VRhtWVYpleps/2b+5h9aFMYajRV4gOacU46yqnWzOcoVLzyx7tDIN7sH3bSNaDE
         mObHxua7CWqjCJtLSeEq87jaLourXY0S+e2VMnWm87qyWPaKqgkcUfdkYxgY+TH9lvwl
         fPSURrXlCV64JLl/8L8CMUbVdfVZ1aV4f7vtesBRNLkxJzMaUQwaQ+ELmRHSIiBjrwKl
         aKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854930; x=1756459730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+7jovikICPfeDBh9+sigj3WevDGgGN+HdnZFDA9m7c=;
        b=kvWKoDq3Deu6DTMG6VGDuHN58UcHnTsObWwP2e4wLOAe6CAwhxj1LGmvprTSfnGSF4
         evnw/c2mTbHkXv1xbUNmhLKhqG/Gb3DCrB/sXfwI1Ltc0ST7m+81W3jWxbxP1M9/a2BR
         TVKdsuVr1i1lVKBsUQZyN13XM/b0/brDsO+juz8CJjXGFh0rSH/EHFGeB+LdfY2ywh5w
         k3DTtPqMPr2Oruc5k4cKNV9l7KwNwOu4EeOmszHt4D55PQsNkRo94MHmB6ibs0Oc8fJk
         F0N+dEgB8s0F5mWVjJd26gJc+1OC+aGEQ4EDJwgtructndTHB/eJgpO988PJ42CYytqo
         OGYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnaR5vHdscXCmwF8Z9J7/aQFZkSw8MGC5EPtHjZHuY8oBC1/PTX5POq6L6jAeqkCteUlRk2ZeZ3uh8A/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhupnHDOfY9eGxzJAV83myog02r6xmi5Tmx3KAq2MjX0rGHBgZ
	x1C5xe+dqrGrCZtd9qpJ0LNKEnU3MCIc89KdL/soq+gBF8eWrpm9eIKbW+U5lOMRonoVKLkOMMn
	vz/GmRf2B3HQxmjLHng==
X-Google-Smtp-Source: AGHT+IE81vOe3lF3Q9HAiE1tAlqMVP84gxQgFX6xDbenk+VWIFgDGNBFMwKCHBju2vp5v0tvD1PRFr8A05p7R1A=
X-Received: from edo22.prod.google.com ([2002:a05:6402:52d6:b0:617:9713:6b2c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:27c7:b0:617:b4ce:9d48 with SMTP id 4fb4d7f45d1cf-61c1b708c8amr1890750a12.26.1755854930000;
 Fri, 22 Aug 2025 02:28:50 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:28:25 +0000
In-Reply-To: <20250822-gpuva-mutex-in-gem-v2-0-c41a10d1d3b9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822-gpuva-mutex-in-gem-v2-0-c41a10d1d3b9@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4671; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=PXzH6D27ejnFW1kfBtz8z7koA1/45HNd1QgE8a5IH60=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBoqDhNFkdUCFnLCzTxX9L1OCDaI309mAZ5aNQku
 U139j2Nfe2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaKg4TQAKCRAEWL7uWMY5
 RgsNEACi3Y6feRIY6sBuKb23tinwq23L8T+85OmKG7u2LpgibYo6zXf6cZAkNCedH+eTv8OtlM/
 UvY+RcQNvuD+7H1g1FIP1OEP7PSS7j/DXvkyHoTM7Z6yAdEQ1z8oMsm2SUHSS+/7K5X38PQ8Q0G
 HrLQKdbgsKBQPrT7/S7TjZl1WMX5+ZbynZXzewuwX7ceyVdMrWKDzqr3CohBPWv74i1sC1rKcR8
 VmjEWJ34BXDlqqBdwOArqb6gjq+ssFz6YMI3X0Wtc0lzXNhS0mNWG5E+JGod06Cf+dAfF09DL8q
 7XcfDO2n3xDQQvhfPGtO/+mb2liLFFAPmsYzWKOtQhx921pQ/kP13KfRw1vujIB14kVYDluj/e7
 2eHwR9puo4BYOozLSSxNL8xnnivse/4G8NWATIBYSIB8nt2Qxkyc7zdIS4QPes08NUcKnUIqIW6
 0P7rJLzEOYMVs0ouQUI1m4R+4kguLNxen/rmAxXASIYKjhcGbA7NaaMVYWKvcbtESmAic/vInzq
 C7Rv6daJSKKA4yQs0Kbs1Hekxfuny0Ni/Bnh8IyDsVEzQCEe9GjNgSEa91iJNT7IQEE0yAg0JuJ
 APJv4fwGP3NSqB7Y+YbLgS1i0t4uEoXlaCmDLa+EZCC9pMKckt36wZ6YyIgE+Rlr0RXmxSZh9FS l7g8Fk1KYpNbA/g==
X-Mailer: b4 0.14.2
Message-ID: <20250822-gpuva-mutex-in-gem-v2-2-c41a10d1d3b9@google.com>
Subject: [PATCH v2 2/3] panthor: use drm_gem_object.gpuva.lock instead of gpuva_list_lock
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

Now that drm_gem_object has a dedicated mutex for the gpuva list that is
intended to be used in cases that must be fence signalling safe, use it
in Panthor.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c |  4 +---
 drivers/gpu/drm/panthor/panthor_gem.h | 12 ------------
 drivers/gpu/drm/panthor/panthor_mmu.c | 16 ++++++++--------
 3 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index a123bc740ba1460f96882206f598b148b64dc5f6..c654a3377903cf7e067becdb481fb14895a4eaa5 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -74,7 +74,6 @@ static void panthor_gem_free_object(struct drm_gem_object *obj)
 	mutex_destroy(&bo->label.lock);
 
 	drm_gem_free_mmap_offset(&bo->base.base);
-	mutex_destroy(&bo->gpuva_list_lock);
 	drm_gem_shmem_free(&bo->base);
 	drm_gem_object_put(vm_root_gem);
 }
@@ -246,8 +245,7 @@ struct drm_gem_object *panthor_gem_create_object(struct drm_device *ddev, size_t
 
 	obj->base.base.funcs = &panthor_gem_funcs;
 	obj->base.map_wc = !ptdev->coherent;
-	mutex_init(&obj->gpuva_list_lock);
-	drm_gem_gpuva_set_lock(&obj->base.base, &obj->gpuva_list_lock);
+	drm_gem_gpuva_set_lock(&obj->base.base, &obj->base.base.gpuva.lock);
 	mutex_init(&obj->label.lock);
 
 	panthor_gem_debugfs_bo_init(obj);
diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
index 8fc7215e9b900ed162e03aebeae999fda00eeb7a..80c6e24112d0bd0f1561ae4d2224842afb735a59 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.h
+++ b/drivers/gpu/drm/panthor/panthor_gem.h
@@ -79,18 +79,6 @@ struct panthor_gem_object {
 	 */
 	struct drm_gem_object *exclusive_vm_root_gem;
 
-	/**
-	 * @gpuva_list_lock: Custom GPUVA lock.
-	 *
-	 * Used to protect insertion of drm_gpuva elements to the
-	 * drm_gem_object.gpuva.list list.
-	 *
-	 * We can't use the GEM resv for that, because drm_gpuva_link() is
-	 * called in a dma-signaling path, where we're not allowed to take
-	 * resv locks.
-	 */
-	struct mutex gpuva_list_lock;
-
 	/** @flags: Combination of drm_panthor_bo_flags flags. */
 	u32 flags;
 
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 2003b91a84097d419484c284c2d6241a82b5cde2..2881942ab5115686803fb9d9036bc059d56b7fa3 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1107,9 +1107,9 @@ static void panthor_vm_bo_put(struct drm_gpuvm_bo *vm_bo)
 	 * GEM vm_bo list.
 	 */
 	dma_resv_lock(drm_gpuvm_resv(vm), NULL);
-	mutex_lock(&bo->gpuva_list_lock);
+	mutex_lock(&bo->base.base.gpuva.lock);
 	unpin = drm_gpuvm_bo_put(vm_bo);
-	mutex_unlock(&bo->gpuva_list_lock);
+	mutex_unlock(&bo->base.base.gpuva.lock);
 	dma_resv_unlock(drm_gpuvm_resv(vm));
 
 	/* If the vm_bo object was destroyed, release the pin reference that
@@ -1282,9 +1282,9 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	 * calling this function.
 	 */
 	dma_resv_lock(panthor_vm_resv(vm), NULL);
-	mutex_lock(&bo->gpuva_list_lock);
+	mutex_lock(&bo->base.base.gpuva.lock);
 	op_ctx->map.vm_bo = drm_gpuvm_bo_obtain_prealloc(preallocated_vm_bo);
-	mutex_unlock(&bo->gpuva_list_lock);
+	mutex_unlock(&bo->base.base.gpuva.lock);
 	dma_resv_unlock(panthor_vm_resv(vm));
 
 	/* If the a vm_bo for this <VM,BO> combination exists, it already
@@ -2036,10 +2036,10 @@ static void panthor_vma_link(struct panthor_vm *vm,
 {
 	struct panthor_gem_object *bo = to_panthor_bo(vma->base.gem.obj);
 
-	mutex_lock(&bo->gpuva_list_lock);
+	mutex_lock(&bo->base.base.gpuva.lock);
 	drm_gpuva_link(&vma->base, vm_bo);
 	drm_WARN_ON(&vm->ptdev->base, drm_gpuvm_bo_put(vm_bo));
-	mutex_unlock(&bo->gpuva_list_lock);
+	mutex_unlock(&bo->base.base.gpuva.lock);
 }
 
 static void panthor_vma_unlink(struct panthor_vm *vm,
@@ -2048,9 +2048,9 @@ static void panthor_vma_unlink(struct panthor_vm *vm,
 	struct panthor_gem_object *bo = to_panthor_bo(vma->base.gem.obj);
 	struct drm_gpuvm_bo *vm_bo = drm_gpuvm_bo_get(vma->base.vm_bo);
 
-	mutex_lock(&bo->gpuva_list_lock);
+	mutex_lock(&bo->base.base.gpuva.lock);
 	drm_gpuva_unlink(&vma->base);
-	mutex_unlock(&bo->gpuva_list_lock);
+	mutex_unlock(&bo->base.base.gpuva.lock);
 
 	/* drm_gpuva_unlink() release the vm_bo, but we manually retained it
 	 * when entering this function, so we can implement deferred VMA

-- 
2.51.0.rc2.233.g662b1ed5c5-goog


