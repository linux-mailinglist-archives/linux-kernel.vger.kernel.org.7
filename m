Return-Path: <linux-kernel+bounces-769122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F6CB26A68
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7F81885B58
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2797220A5EA;
	Thu, 14 Aug 2025 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwJY7R5Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C511C5486;
	Thu, 14 Aug 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183589; cv=none; b=q+t7CvTuEtXuXbwWK91W99YQAHmz9EPBANBc7Bb6GIWMNPbIlnmIdqDKdE5Dh8v/UuQVgv0BzzHi6qg4KRkP5pz6+RRCF6OayGOJp1g09HQtHOAZgUUVq/o3sbqdbFOnF4/nN6cJ0wAL4DMfqLliwgJ8cvcX3c/xdi9f69d91zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183589; c=relaxed/simple;
	bh=nhCkSzRoamaC2x6YatM8AEEAlKpcan3l13anynVtDVs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=iwsj8DvcFghJmW8hWRmDr8NEnvhDNO1PMnvkKT9lVGMfaYL/m+lt00cfo6Ib860WXCtNtuDZVwUc3jDR9pnuHuOCekAwhDAe0EPM7rdrRr4hbm/HnR/k4Dy3HNLn3oRiFG8BK7n+SVVq+q52ukJq3hjxT9xx/HxlUDJaiX/jdRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwJY7R5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC0AC4CEED;
	Thu, 14 Aug 2025 14:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755183588;
	bh=nhCkSzRoamaC2x6YatM8AEEAlKpcan3l13anynVtDVs=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=HwJY7R5YAC0+cWuEW9IFGPuZ262x7OjBrTIbVN0pPGtIcJ7DR8tQEVn+khZflTm9R
	 XIHsEG4IVQmAUeK64NTGVkFV9GX6RwpNjdEU9J48Z6IAujyEc3s5baikGQPqi2upgu
	 puZAdm3EQEV2HmByevPQPy6tpSqBoJY5FBGQ9k4w+AA33Ctcd9USN5U7auncolSa2e
	 wSltFxJf1P/WCvSapNAZDZPQevT382REwfSRcfy0sSYpsJUN8/eFjNPqZRAz9I4ME1
	 x6YHN2/9e/wkxwKHgd7R5Yk4DUVEQxAd2gOorEbQAVS6MmYfTu+CAoRg5z2zu9g8NU
	 sL2O+KCX7t19A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Aug 2025 16:59:42 +0200
Message-Id: <DC28NIMIPF5I.2P17OZFA06GXL@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/2] drm_gem: add mutex to drm_gem_object.gpuva
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Boris
 Brezillon" <boris.brezillon@collabora.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Steven Price" <steven.price@arm.com>,
 "Liviu Dudau" <liviu.dudau@arm.com>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Rob Herring" <robh@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
References: <20250814-gpuva-mutex-in-gem-v1-0-e202cbfe6d77@google.com>
 <20250814-gpuva-mutex-in-gem-v1-1-e202cbfe6d77@google.com>
In-Reply-To: <20250814-gpuva-mutex-in-gem-v1-1-e202cbfe6d77@google.com>

On Thu Aug 14, 2025 at 3:53 PM CEST, Alice Ryhl wrote:
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
> ---
>  drivers/gpu/drm/drm_gem.c | 2 ++
>  include/drm/drm_gem.h     | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 6a44351e58b7741c358406c8a576b6660b5ca904..24c109ab3fadd5af2e5d9de3f=
e330b105217a9ce 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -187,6 +187,7 @@ void drm_gem_private_object_init(struct drm_device *d=
ev,
>  	kref_init(&obj->refcount);
>  	obj->handle_count =3D 0;
>  	obj->size =3D size;
> +	mutex_init(&obj->gpuva.lock);
>  	dma_resv_init(&obj->_resv);
>  	if (!obj->resv)
>  		obj->resv =3D &obj->_resv;
> @@ -1057,6 +1058,7 @@ drm_gem_object_free(struct kref *kref)
>  	if (WARN_ON(!obj->funcs->free))
>  		return;
> =20
> +	mutex_destroy(&obj->gpuva.lock);
>  	obj->funcs->free(obj);

I really can't think of a valid case where we need to access this mutex fro=
m the
GEM's free() callback, yet it probably doesn't hurt to mention it in the
documentation of struct drm_gem_object_funcs.

>  }
>  EXPORT_SYMBOL(drm_gem_object_free);
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index d3a7b43e2c637b164eba5af7cc2fc8ef09d4f0a4..5934d8dc267a65aaf62d2d025=
869221cd110b325 100644
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
> =20
> +		struct mutex lock;
>  #ifdef CONFIG_LOCKDEP
>  		struct lockdep_map *lock_dep_map;
>  #endif

We should remove this and the corresponding functions (i.e.
drm_gem_gpuva_set_lock(), drm_gem_gpuva_assert_lock_held()) in a subsequent
patch and let GPUVM assert for this mutex directly rather than for the
lockdep_map.

