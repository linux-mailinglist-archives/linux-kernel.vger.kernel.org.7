Return-Path: <linux-kernel+bounces-781613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 980ABB3148B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AEFE1CC575B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2900D2EB86B;
	Fri, 22 Aug 2025 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nB2uBX1d"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21978239E9A;
	Fri, 22 Aug 2025 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856349; cv=none; b=TemBs056PuEP4t0N+pDTi3Lg2aGjGwq0RJqUH08BKdteu93c8xF0lExUpoxbA8uxmgBb/aGiV9gsViecRcdtuQlpEj9rJPWkld/Ulc+rIkLizY4kSzCd2F38+qy24975sfL6aZ1yXjhN2fOOkjWlNQeNorxFWUsuEUnjm3w8pGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856349; c=relaxed/simple;
	bh=jfoOjycqNQZf36ZYHkgozD3Xli5JPO0u/7CtBBxQepM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dF8s3PkEDI/f6qaFb0+dFuODH0/8RrdNeonTr+sCXVVvphqnZIb9PlZiZHOdm158Y6KZUx7ZUs2v5lq6OwmYzRumU0kwsJViXla3wIAxDD+I5aDbz3/ma1ViIeR/1/DJcv/bw8ytTzydvw1oy/ki2jxAgfTEd4y9FczzBrXTYJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nB2uBX1d; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755856345;
	bh=jfoOjycqNQZf36ZYHkgozD3Xli5JPO0u/7CtBBxQepM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nB2uBX1dLFPHsb2pBHVJLB2rWMp1MNNQblPU5wKU4NrOafY69EQUymKMaEDYUijfn
	 r14fTSx+VMDqDRTv4X0bD33n1jK20CF19KndGdDKBILph0d0JQDJGuoeKOKHLVGDOh
	 HzwJcqox/BrPqYqqa9tNHxNH+xnqWBK/e0b9LmkLY/gsgPK9g1QTKFAdXBrDadtXxB
	 aZnpiyQSA0dD8lnHwNCwXWCLFGGy2wJOt/Nfo7TlNe2zZ9aIXt6J6hzjYnECK7p/uB
	 K6frOh6zeJW8Lh74ssTwTIPXNosM9oyukAZpCivKyhS9yqwrrWdN4fvR4T1wFuLvWv
	 O9Jvh6fTAKXvA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6826217E12DF;
	Fri, 22 Aug 2025 11:52:24 +0200 (CEST)
Date: Fri, 22 Aug 2025 11:52:21 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Danilo Krummrich
 <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Steven
 Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm_gem: add mutex to drm_gem_object.gpuva
Message-ID: <20250822115221.24fffc2c@fedora>
In-Reply-To: <20250822-gpuva-mutex-in-gem-v2-1-c41a10d1d3b9@google.com>
References: <20250822-gpuva-mutex-in-gem-v2-0-c41a10d1d3b9@google.com>
	<20250822-gpuva-mutex-in-gem-v2-1-c41a10d1d3b9@google.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 09:28:24 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> There are two main ways that GPUVM might be used:
> 
> * staged mode, where VM_BIND ioctls update the GPUVM immediately so that
>   the GPUVM reflects the state of the VM *including* staged changes that
>   are not yet applied to the GPU's virtual address space.
> * immediate mode, where the GPUVM state is updated during run_job(),
>   i.e., in the DMA fence signalling critical path, to ensure that the
>   GPUVM and the GPU's virtual address space has the same state at all
>   times.
> 
> Currently, only Panthor uses GPUVM in immediate mode, but the Rust
> drivers Tyr and Nova will also use GPUVM in immediate mode, so it is
> worth to support both staged and immediate mode well in GPUVM. To use
> immediate mode, the GEMs gpuva list must be modified during the fence
> signalling path, which means that it must be protected by a lock that is
> fence signalling safe.
> 
> For this reason, a mutex is added to struct drm_gem_object that is
> intended to achieve this purpose. Adding it directly in the GEM object
> both makes it easier to use GPUVM in immediate mode, but also makes it
> possible to take the gpuva lock from core drm code.
> 
> As a follow-up, another change that should probably be made to support
> immediate mode is a mechanism to postpone cleanup of vm_bo objects, as
> dropping a vm_bo object in the fence signalling path is problematic for
> two reasons:
> 
> * When using DRM_GPUVM_RESV_PROTECTED, you cannot remove the vm_bo from
>   the extobj/evicted lists during the fence signalling path.
> * Dropping a vm_bo could lead to the GEM object getting destroyed.
>   The requirement that GEM object cleanup is fence signalling safe is
>   dubious and likely to be violated in practice.
> 
> Panthor already has its own custom implementation of postponing vm_bo
> cleanup.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

One minor thing below.

> ---
>  drivers/gpu/drm/drm_gem.c | 2 ++
>  include/drm/drm_gem.h     | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 4a89b6acb6af39720451ac24033b89e144d282dc..8d25cc65707d5b44d931beb0207c9d08a3e2de5a 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -187,6 +187,7 @@ void drm_gem_private_object_init(struct drm_device *dev,
>  	kref_init(&obj->refcount);
>  	obj->handle_count = 0;
>  	obj->size = size;
> +	mutex_init(&obj->gpuva.lock);
>  	dma_resv_init(&obj->_resv);
>  	if (!obj->resv)
>  		obj->resv = &obj->_resv;
> @@ -210,6 +211,7 @@ void drm_gem_private_object_fini(struct drm_gem_object *obj)
>  	WARN_ON(obj->dma_buf);
>  
>  	dma_resv_fini(&obj->_resv);
> +	mutex_destroy(&obj->gpuva.lock);
>  }
>  EXPORT_SYMBOL(drm_gem_private_object_fini);
>  
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index d3a7b43e2c637b164eba5af7cc2fc8ef09d4f0a4..5934d8dc267a65aaf62d2d025869221cd110b325 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -403,11 +403,13 @@ struct drm_gem_object {
>  	 * Provides the list of GPU VAs attached to this GEM object.
>  	 *
>  	 * Drivers should lock list accesses with the GEMs &dma_resv lock
> -	 * (&drm_gem_object.resv) or a custom lock if one is provided.
> +	 * (&drm_gem_object.resv) or a custom lock if one is provided. The
> +	 * mutex inside this struct may be used as the custom lock.
>  	 */
>  	struct {
>  		struct list_head list;
>  
> +		struct mutex lock;

Maybe it's time we start moving some bits of the gpuva field docs next
to the fields they describe:

	/**
	 * @gpuva: Fields used by GPUVM to manage mappings pointing to this GEM object.
	 */
	struct {
		/**
		 * @gpuva.list: list of GPU VAs attached to this GEM object.
		 *
		 * Drivers should lock list accesses with the GEMs &dma_resv lock
		 * (&drm_gem_object.resv) or &drm_gem_object.gpuva.lock if the
		 * list is being updated in places where the resv lock can't be
		 * acquired (fence signalling path).
		 */
		struct list_head list;

		/**
		 * @gpuva.lock: lock protecting access to &drm_gem_object.gpuva.list
		 * when the resv lock can't be used.
		 *
		 * Should only be used when the VM is being modified in a fence
		 * signalling path, otherwise you should use &drm_gem_object.resv to
		 * protect accesses to &drm_gem_object.gpuva.list.
		 */
		struct mutex lock;

		...
	};

>  #ifdef CONFIG_LOCKDEP
>  		struct lockdep_map *lock_dep_map;
>  #endif
> 


