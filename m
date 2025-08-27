Return-Path: <linux-kernel+bounces-788398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7E4B383CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C93427A8472
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C403568F0;
	Wed, 27 Aug 2025 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PndUlE39"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A33568EF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756301933; cv=none; b=ilzlNDi8Yt3jkHnUUlGm7jfgZ+ms5vVZ0yu7gIzBGdAhkuzT4WYNzlTNbeBhs9d63ZLdccj0lWLdit1sB3OP2tZ/evOST8+4QT2v6A7WNWgGzIDzcMaMd6ZOYrnXLMia87Mgz3xF1vo0+rSkVsyNDp3zFc/39v0jelpxkqp+IOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756301933; c=relaxed/simple;
	bh=fxqCLepdjJoG2i/XMA26WTvgMhHanXo5UFmP/6SmsUc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C+aIledu2sqncLQSDALwSSgvz8IF4l61MMdYs5iCtOfuVQ39TKrKp8ZfdLl5sHmu5T+uImiytxE3+A+JVE/VGiu+ojad84uioAdHhTzFaSshM3Ruc5ClhlbfGhG+A5UIrjl+S36hgsMcvjrkiNOg/6DlJOPqnUYf7KgV+39rJvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PndUlE39; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3c79f0a6084so1617292f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756301929; x=1756906729; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H0LUjaJNCERfnIpEXLt7qPeqC8Z8QMcmQ0x5DWubTsE=;
        b=PndUlE39BLn0MR5UT41jXfhA6+YitDW++i5WOOxAM6KgHELU1ZuRJCd9pqIe0sxhaj
         630gRgde0uylLNirJ17TvB0oNWkNX7PvwEVGRIkQVzduKG8GOlyf3d4UB6ljf0gP2+/4
         Av3l3HciBt28EomslByC0u8j0qIvN9sg9iEXrYzJ+XFTj36EZAOhYWRozyRqNWe7dwAX
         7RdZMzZVkehmFxqDzP2tPh6h2c9pdnEj90VtkI1VVY4H/aPFDzwcb4SN0jS5ts/LGLSQ
         2F5R4pIXf5KaiKEVdejkgYBLeRHgbBcK0UjJS5EZ8u19Nn0wXdLNBQ9Colni0Zfvxg1c
         Cmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756301929; x=1756906729;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0LUjaJNCERfnIpEXLt7qPeqC8Z8QMcmQ0x5DWubTsE=;
        b=UUEmw/fsv8DPDTFQcQ+JHEiFOhrPO4hKfuicEj5hDlRDMR7uGSjIm2ecIJdgy9dB7k
         uxcUjz7wIbtJS37omDhlfAWxo5+pm2cxAxJgpcHNuPTtbm4HBpYVBpjBM0KvXhvbFgik
         +VAXR2ZPk+OvXRkXd+QurURB1VbACwK6HF8dR6uSbSwrYwX0Xq9B1oGhM8nH/JNXbXbx
         WH5jd2sur2U42hWR8AZRLT/yvTNw4SxQPoV4SCq6JrotFpXGLO1A0+TtEOFivzROHYdB
         cwIEB/mkk0fakCRo3DmY2But0TTsACt4dbYCnnwYAt6bN2AAnkE8LMHktawNnOgw+8CK
         Wq9w==
X-Forwarded-Encrypted: i=1; AJvYcCXYrvNFGXEhr5cknBJcg9Kz63VhPSAOb4aH6vtobmZNUsOUAQfQwL6alUcy++g/nDMNVVGw6YkOijwMTjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPz6ZTEjCfIk2AHpXFRLJWkW13EYdOB2pp0COWxK7CZ6q1ct1t
	YApGrRUdtQIISVyqlJ2EfYo3gL4JLp/suMFEdGYuRpNI6Hk7lg/NJ3pEq95CD4DBJMkhDvEFb7a
	J3p73kZoGHNMMBQJ0Rw==
X-Google-Smtp-Source: AGHT+IGVa7PVy7PXjMz+41KLvLfZ57z1pdtrUqa1nAKHnMHdUPl5XgMWkTXVPv1ZKDQNau4tVBq+F8KPCgsVFPo=
X-Received: from wrsa14.prod.google.com ([2002:adf:face:0:b0:3bb:8d5d:f554])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:f249:0:b0:3cd:4936:7222 with SMTP id ffacd0b85a97d-3cd49367a57mr844329f8f.32.1756301929456;
 Wed, 27 Aug 2025 06:38:49 -0700 (PDT)
Date: Wed, 27 Aug 2025 13:38:38 +0000
In-Reply-To: <20250827-gpuva-mutex-in-gem-v3-0-bd89f5a82c0d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827-gpuva-mutex-in-gem-v3-0-bd89f5a82c0d@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4667; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=fxqCLepdjJoG2i/XMA26WTvgMhHanXo5UFmP/6SmsUc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBorwplBwqLgr6P1T9aVSwRfXFaYBCf/imiAkWRB
 GK0A7i8iw+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaK8KZQAKCRAEWL7uWMY5
 Rj52D/wLX0TgtsFem9qRKwgampx8gBAoARjToXXgEsXq4iETGWCHsmsHkLXw15V6qgAz8heVyjb
 gQA417sWwug0le+2dg/dYL5wpWsEFZfC0xAQuWW0LBORi9EWfww3IFU5Ek3R6Z3FME/7cqcJr0P
 ecKJbLGlOeDS4+OrMkfgNsOOzQbXoJuojnlWn2aMDbOnSV2TZvIbZzEn2dbtpVHh2uI+u0+8WvL
 4Nq+GwThibopA8/vsa1W64m03ys0skYBrhRk/z/F4RIDQaWigH8N8NaA9yEG0zQTaqi2sADSgYI
 ktfDbR8tikcbRyPG7IO+nQHtRpxSh5avxWYxfX8nmaPCMyGT/MW8ptpNZZ/YTS2PGPuCnwt/pco
 02tgrWzHzZaf/6SDLjexaadzjgzyrPqRp1YIcaf73NOL+oAnx0PiQa932dn3aK9uJzrjGm221di
 AZjWf6KajMziBCDDb+OhyhLtHCvHdQoMxs2V10I3NdvM78EosQoQieMMs7UYsrjStlVF7PoM7zg
 6A/QfckmicXhdRxmj1k9Z1porMrNMq7W/RHkV0Hrz1xgwCeexTww+OavJUZkHHFpn/nV074vFRK
 s3RWXt6MknVJc+YWFwK5/qJBQlQd129OOlAHBoiupO01wH+25GCYe83ihVJGn04NjJX6AQZSDeW TEUQbFa9rodBQiw==
X-Mailer: b4 0.14.2
Message-ID: <20250827-gpuva-mutex-in-gem-v3-2-bd89f5a82c0d@google.com>
Subject: [PATCH v3 2/3] panthor: use drm_gem_object.gpuva.lock instead of gpuva_list_lock
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
2.51.0.261.g7ce5a0a67e-goog


