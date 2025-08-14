Return-Path: <linux-kernel+bounces-768952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 829C4B2684B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4761C24138
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398A230148D;
	Thu, 14 Aug 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IVm5lz9W"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC24C2FD7C4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179612; cv=none; b=o8+4kJbuu/b2sw5lqZWzDW7Pf/AYiNIIxbFPtIY6z38+Y888PUwR2w64oLfgXpnD6i4L+ioOcFx34yl0neDZrNK0SrsJP3CTwJ8eJOKeo//aUE7hjbpfolGeKHgyfxomTn6XYWksk5tQed4fr89V32FgviKUq9u0kOfRjQOLKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179612; c=relaxed/simple;
	bh=LR+wrgMUBZJQVPTupv5LRDIZs0SCFocRvp1imSI22LU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ex2lwSyhM0FQKpc2mj/4PnRHimrKYiVArXR/a1U2HWVgrSWAohRMQg+Kj0C4MwDbmLll6OoSf7RUuRRCFNTFqmAcbjCMi6vsKvPnUCTQ5ULUO5caIGCh/DPQoLNb4HFl3Q8FRWtvQR1KQ932RnVVo/OPuZkzzL/nPWPTgW1UkXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IVm5lz9W; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-afcb732ec92so82638366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755179609; x=1755784409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOHsmkNZ6ajiFO4LnWXyqljxEE3s9K8Dypjb6+pFT1w=;
        b=IVm5lz9W/ZLnL0pgL1K808HrRmae1TAvGBxXb2t1TtcOJecn0DCRq4B5YefC+qqSe6
         LnfCaBAEVbNLGaL9eHo2LJ3xVYPHbeJcYL6DCVD38p/XzFaDHMC61hSsd9Fy/QHcrkyz
         esnf41qKHjV5hTHC4NEqACv54QuAvr0QPGGxuQ5uuEsh2NBENK2DZ9P/WcXyc3R1WZVh
         vT6Ou6+AYiySS3RNOeRQyGF1FwY7xzFolPrB/e9wiLp4hK2fuJkgOoBLQ7Dyy0MRI3oC
         h3SDMgiqMDXz1E+eXMHlwfXXoCiFgIXwCk67B1RJ3Yq4qK/1Ttp3u4OLP57czgcvB7OT
         3aNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755179609; x=1755784409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOHsmkNZ6ajiFO4LnWXyqljxEE3s9K8Dypjb6+pFT1w=;
        b=sb9lH11y9SnMo79Sq2/AH5YF7gAdbn9XglPoD8IxeUWJqlnTltb8xo69WxCNoeMvfK
         cmG701J4DAXEkX1/tCd9rFtesMH89ugUGbIzVEzMUZ4TeAYtJHxRH3B2Yi0x0Ff15UZB
         UpjGfiql0Zu7YfAjKoXQH82psnOi2/MSmtcNzeNKaMqUg7twU8ZkWvuuYGaywTxdsiUW
         j3biV9AgS4ZGhlh1GnaiKx4Ui4W3JqfXgTzkzLbEe16xK4nrucTq131mQOmpNWmc6c8O
         eB6+NTBdyimcoVP8bgOsvLD8ZpqS3Q/bWGH8zFIhrinNA8xIlcIKd4P9ESvsVNBqa5Iu
         d+Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVNOTeML0Ol48nLlOMF4Cniayz0aEdxTKwxdcb2L49j2nHjVb3/YQADJfSUdwCyi1BPUiZ8gYImx+0CfGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsdDFOOms3Mdtsz5i3KfA6OTmBBlvdAKp/cCT8L/r89kAL8DgM
	v/k4KHmiFLpISKMTIj2jrO9USQ0uI7XogRoQX/XKSAZzuvu63qv7vmCJM0nZ+TJOJFG92+anq55
	6OCWES69Mw4j95fmCgw==
X-Google-Smtp-Source: AGHT+IGbuvX24KRWZ6BDbArlEBg7fmfllPH+dSU87Bq+ZSteDZmPgx1B2ORVZuBFNuAwNPDP9arsBIXuELAxObY=
X-Received: from ejbs11.prod.google.com ([2002:a17:906:60b:b0:afc:aee2:e5da])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:dc90:b0:af9:acc3:823f with SMTP id a640c23a62f3a-afcb995ef91mr274963466b.58.1755179609031;
 Thu, 14 Aug 2025 06:53:29 -0700 (PDT)
Date: Thu, 14 Aug 2025 13:53:14 +0000
In-Reply-To: <20250814-gpuva-mutex-in-gem-v1-0-e202cbfe6d77@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250814-gpuva-mutex-in-gem-v1-0-e202cbfe6d77@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3449; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=LR+wrgMUBZJQVPTupv5LRDIZs0SCFocRvp1imSI22LU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBonepU63zgWq1jyZcLcDi0DX7eH+EAfW46ZdNlP
 8SCm8KSwyuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaJ3qVAAKCRAEWL7uWMY5
 RlqsD/4+7Y/iv8bYMd0BjxVyNgatNJPVJAFR+qKXoPveykuk7AXM2x+xiCFS3vfWHYcIpjBD6Oy
 6T2EDV0Jqy+kgXYsRAbq8pTYZWldvqK7Fwukdva5AxF5CRdICX2Grb6giEi5aa4MRT+ta9RYefp
 EpEb5ID7iY2EltD4VTC0OKmWaYtUmcy2Qp3GvdxPXqv8q2o7CA5en8K6UX2nDo7F1wIvbomS6eC
 IAIc9RRJYDPrnXTu04BFtYtC33QEojuaFc2vrQQB9BrxFmHv+9c6s24k9oXtCqSdm9MB6coB9AQ
 /b8vk2wEWMJOjQFIeM6jji2dlDPVhc54JzslQTFpwImr1LIRfbNHtN+L0dob9obXG0FJ3FT6JWH
 LPTL2QpcNPj3oZbou4DnngHGhy4wbjmhwdRq3pVv0ortoPRYWeGtVC2J6ALbEZgRnZThKYzOEAv
 6rjCsIyf2d/Fc3YSo1+b20qPj2KwC8FpIxsdQHAR/1v7dXi1ipYTINbio00blE4NLdM/gwe6MDm
 DwcOlTyrD34tM2KxYB4Vfeavw7fgZcGbK8T8F+Q+Y22mmalWYLTGDHE1EWaJ+HAbpvSdZd+kWob
 tPH+UQ8J7oNbaUPX5cw65NcVeeul9u1Rx68XKmQu4S0nCcG2MBnQ0sLmF+n0homLUZqjo9nNQCt mt1mwbpwiRnhGUQ==
X-Mailer: b4 0.14.2
Message-ID: <20250814-gpuva-mutex-in-gem-v1-1-e202cbfe6d77@google.com>
Subject: [PATCH 1/2] drm_gem: add mutex to drm_gem_object.gpuva
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
index 6a44351e58b7741c358406c8a576b6660b5ca904..24c109ab3fadd5af2e5d9de3fe330b105217a9ce 100644
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
@@ -1057,6 +1058,7 @@ drm_gem_object_free(struct kref *kref)
 	if (WARN_ON(!obj->funcs->free))
 		return;
 
+	mutex_destroy(&obj->gpuva.lock);
 	obj->funcs->free(obj);
 }
 EXPORT_SYMBOL(drm_gem_object_free);
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
2.51.0.rc0.215.g125493bb4a-goog


