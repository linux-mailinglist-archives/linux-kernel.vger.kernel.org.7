Return-Path: <linux-kernel+bounces-781505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 565FEB31353
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67779B00222
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B2B2F49ED;
	Fri, 22 Aug 2025 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gqCfs67q"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBDB2EE262
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854932; cv=none; b=uERoU9svRGiVqgjmkaAMo9pYDf4hDbWoHIRoCr6unq+QzkdPFwFnF6C0Wz6HoO689Xr2kM1bFAyqQK+GroU0fI5rOIHVIKKizepjcbcgq8IckxFkODMZqHDBMXTFKFi7ng9XGdXzqpEG4YSdX7EnL6t7yqduMg+zD5XPMKa2Tyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854932; c=relaxed/simple;
	bh=Kl3w8GhwSkTKnL4gpM3EUOD9jKMCH83Id+WyJ393gAc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mIfFCxWPHUOMaTgR4seymMSSD7Qg31V/oYZiOoy8cnj3T55yusvn/Tcn/65iSHQUb3Z5AZRrz33vqOsPPtIkllGEoxS/TgQjA3JEjzXlUr9VLIdXe01LeQfRM4h10jHVfLNNFLK2+hgki4TbastAsquha66H5dnevDova/1S4X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gqCfs67q; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b05d31cso9955045e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755854928; x=1756459728; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TrBXsBfJN9Hl0C60LtHP8goa7t5Q56hpklQFi7rDf1M=;
        b=gqCfs67qxC/11CqwR68IeUZpwPkblykzHz2CJDsysjfKGTyHmU/coT38Ji2gwx9joj
         JbxGt13kBucD+OL5SXdja7ow44QoqE6MKiQqUklSSJGVjOlPWjByO4uiVaw2Y6Gh095H
         n2arGU6qZe4UEMcL/b1G6sEwitypj0b1M6SwAAar0zDT4YX749tbhbghO+6Gwom+bBzs
         In18sExNS6Ywo2KPFKfkxD4i/UdZyKs+6wfcVKaCDqRFilvqEMNXBEnutuYZWpZTnmAy
         j7hj8naWMbwmPb+vRiTyRBgdYN7jvgNioEGYQMoWXlJTpZqlQrgiyV5zqicqN/DjlwaS
         Q6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854928; x=1756459728;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TrBXsBfJN9Hl0C60LtHP8goa7t5Q56hpklQFi7rDf1M=;
        b=TPAasPyihZAWOl8Aen3y4CgCmpaARvXAGSzSRNWS5/uknFEoqQwu5/9OSidoupYPIF
         +0K5hOr8qZrAOt/CX0MGkVbEY4OECZT9+8wuKIVRcNNFD5+rlujvwD68DzJUME95sy37
         AEmsW1bSKq2Kh9krqwFzzqpcazdIO51tUOB0S2/ZLIPbwFq+NbHZUBqGo4t3nu89lNvT
         Dtf6rC7CQqMMEYu+6guGCQawcybQXNUeic+EACRqXsj+vKObMlxvnnT2AMF/jGrfdwp3
         DnhjemjiDER2Z5mR5Cf3GyfzeTh6MmcTgQU0nd4JsXyT8z9R9Jn27J9IRcftxw40QS+A
         1kLg==
X-Forwarded-Encrypted: i=1; AJvYcCU9EjAwMBnKuQVRRkDFEOc4EDmgKZ2v+RdbWVvhWgR7GeROmPkojgXZoDjpVMhh4FEWbj2hQfUaHnQvrjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwkydWXrcQCGX2Q9Z4brlHit0pbI7ObPtetJzPbjlQaG+IgcK6
	gER7dpnpUHWnEpiil03JP0ztr6Ogxa5/mRpvplQ0Q14sI/7xTgRKyX4crdUq5pKfmeyHUvKBo5C
	9ov72A2PgbwdUokytIg==
X-Google-Smtp-Source: AGHT+IED8wcDTUn+Pl5RltIzM8gjl/tmIptfRKwT5dyprtog5nBFWSTOA4EQbWXFpewTcpCsnhP5UIL7y4PF/Bo=
X-Received: from wmbeu9.prod.google.com ([2002:a05:600c:81c9:b0:459:dd37:a6bf])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35c9:b0:458:b7d1:99f9 with SMTP id 5b1f17b1804b1-45b517a0655mr17952605e9.11.1755854928516;
 Fri, 22 Aug 2025 02:28:48 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:28:24 +0000
In-Reply-To: <20250822-gpuva-mutex-in-gem-v2-0-c41a10d1d3b9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822-gpuva-mutex-in-gem-v2-0-c41a10d1d3b9@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3464; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Kl3w8GhwSkTKnL4gpM3EUOD9jKMCH83Id+WyJ393gAc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBoqDhNzfZv5dJM175fnbqNeGceTMeDRW5pDdq+k
 uA1ND5WFxOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaKg4TQAKCRAEWL7uWMY5
 Rlf2D/4/xi0frU0yUeXbZcDX1ScUrrZ9zjuUgR8Ow3W8K1zQqyzFnU07/S7HCg/80TBBvLfDsTb
 U8rKOyiqaOMkIJxi/CQ/QQ3zKZTKPJlUUwzWroZ48SzkjbGZ9ONBcua6H6qna6Zs2a9Mjj4UsGU
 879eChTLDjFwsOir565HgrdVVD2LC3S67e6np8Y8D7Ma8I6edYhq/vIKMU1nOlu8Zh9KhPq9sNW
 Q2mAhyB9JndoKQW/drIemw2iArNDnS0i25+MBR+6fJzfHfwv/ZkQyH+0M0R/n9VCLkXLZH16c0u
 EZFjs9/7UlkOoOgF522g5Qic/+hRDWLFpL+0dduz2Qzj63YQ0Iw5IihTM2eYKSr2FxF0ngI87Yk
 2MSSd+Mbn7RfCHp7oOLsnA/3o5F/ByIiE1UuOuziOffja/SbazXtuUijUEx9AUvCLOQftAZQ4mJ
 GAaaBQrXVwm14fxr+tPlkyEgtObdXzO2uKkVRoPpMHe1tEzkQZVqj+pNPJIsol0PJKb8ahK15la
 IxGzUej4znW0rwkkgjwEhNqXmNMhAQZQYgdQtYvSFe1AxBiBb4zRbqw+0+mG8XytrFHz9OLnK2A
 Txn6S1/a3nJfFCSFjinfwkUm1lFF1GQarGz2bgTR7kj39g6xwMI3+d7QbHB4n7WeR/KvrtMwvQ/ VfbKwcalfrR0+Kw==
X-Mailer: b4 0.14.2
Message-ID: <20250822-gpuva-mutex-in-gem-v2-1-c41a10d1d3b9@google.com>
Subject: [PATCH v2 1/3] drm_gem: add mutex to drm_gem_object.gpuva
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

There are two main ways that GPUVM might be used:

* staged mode, where VM_BIND ioctls update the GPUVM immediately so that
  the GPUVM reflects the state of the VM *including* staged changes that
  are not yet applied to the GPU's virtual address space.
* immediate mode, where the GPUVM state is updated during run_job(),
  i.e., in the DMA fence signalling critical path, to ensure that the
  GPUVM and the GPU's virtual address space has the same state at all
  times.

Currently, only Panthor uses GPUVM in immediate mode, but the Rust
drivers Tyr and Nova will also use GPUVM in immediate mode, so it is
worth to support both staged and immediate mode well in GPUVM. To use
immediate mode, the GEMs gpuva list must be modified during the fence
signalling path, which means that it must be protected by a lock that is
fence signalling safe.

For this reason, a mutex is added to struct drm_gem_object that is
intended to achieve this purpose. Adding it directly in the GEM object
both makes it easier to use GPUVM in immediate mode, but also makes it
possible to take the gpuva lock from core drm code.

As a follow-up, another change that should probably be made to support
immediate mode is a mechanism to postpone cleanup of vm_bo objects, as
dropping a vm_bo object in the fence signalling path is problematic for
two reasons:

* When using DRM_GPUVM_RESV_PROTECTED, you cannot remove the vm_bo from
  the extobj/evicted lists during the fence signalling path.
* Dropping a vm_bo could lead to the GEM object getting destroyed.
  The requirement that GEM object cleanup is fence signalling safe is
  dubious and likely to be violated in practice.

Panthor already has its own custom implementation of postponing vm_bo
cleanup.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/gpu/drm/drm_gem.c | 2 ++
 include/drm/drm_gem.h     | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 4a89b6acb6af39720451ac24033b89e144d282dc..8d25cc65707d5b44d931beb0207c9d08a3e2de5a 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -187,6 +187,7 @@ void drm_gem_private_object_init(struct drm_device *dev,
 	kref_init(&obj->refcount);
 	obj->handle_count = 0;
 	obj->size = size;
+	mutex_init(&obj->gpuva.lock);
 	dma_resv_init(&obj->_resv);
 	if (!obj->resv)
 		obj->resv = &obj->_resv;
@@ -210,6 +211,7 @@ void drm_gem_private_object_fini(struct drm_gem_object *obj)
 	WARN_ON(obj->dma_buf);
 
 	dma_resv_fini(&obj->_resv);
+	mutex_destroy(&obj->gpuva.lock);
 }
 EXPORT_SYMBOL(drm_gem_private_object_fini);
 
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index d3a7b43e2c637b164eba5af7cc2fc8ef09d4f0a4..5934d8dc267a65aaf62d2d025869221cd110b325 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -403,11 +403,13 @@ struct drm_gem_object {
 	 * Provides the list of GPU VAs attached to this GEM object.
 	 *
 	 * Drivers should lock list accesses with the GEMs &dma_resv lock
-	 * (&drm_gem_object.resv) or a custom lock if one is provided.
+	 * (&drm_gem_object.resv) or a custom lock if one is provided. The
+	 * mutex inside this struct may be used as the custom lock.
 	 */
 	struct {
 		struct list_head list;
 
+		struct mutex lock;
 #ifdef CONFIG_LOCKDEP
 		struct lockdep_map *lock_dep_map;
 #endif

-- 
2.51.0.rc2.233.g662b1ed5c5-goog


