Return-Path: <linux-kernel+bounces-779987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 839B2B2FC01
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369C9AE520D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FD22472B5;
	Thu, 21 Aug 2025 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CA7TRDPg"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5552823D7C1;
	Thu, 21 Aug 2025 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785156; cv=none; b=hVmx/Lb71Y/+LqI/MUvjrEYyK+eluc+zgSzwQGe0RyGDnAxcyIM+Q2TbS5wLX9YgPTi7+1/UFVCtf5gABX0SkCCv9qz6/UoZNBIJZLV1CoYPlxPbvMSRATtbkpUUNkyeaPeVl/n7aRueP1a1lnle3DJLlBlamFrZih0wvsFM5Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785156; c=relaxed/simple;
	bh=jrXTHilw3YCqitwncsxp/TnZdD5rGMxx9B9FTLWgRX0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLUIpiffDwu8u+6CA5tw9jG+GHOrh6EsPB6byhA2IwPTjgbuz03WsSyMoN+gLWnzBRTkqkKVT7wGUEqXOPvZVzSyE8mT6h1f4wCOjt+YJOgRNGdkAzIXQqNf/7emoSNqk4gLXY1X9076hrdvEAmqRGHY8+ZQ5xen7tC1Q2fvPAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CA7TRDPg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755785152;
	bh=jrXTHilw3YCqitwncsxp/TnZdD5rGMxx9B9FTLWgRX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CA7TRDPgsbu4SZkkpOsuoBMb7/o5GpaMacoUWRKtBv2Bhi4jmLvZmSGQSFPvHgIcx
	 V445SguZi0r43f5a3s2y2OOsbbtP40RkKVdYkPJ/NkdRyPYNKfO1vQ1GNAMbUk50p3
	 Td/Xvf9RFR6SEg2zICOXViekYhmtW8L7pFs5P18Q5y+j1gCrGD/LYqko4vXXCibOV9
	 fZcEJBcyeGZfkmD6MkOvaDGHwa2byicyQrBG+Xy6XPKPmBtVh88P1FsjyI9+i/mlKl
	 CUdsWMNeXWD9cg0rFjV8lnQ6csjWrSrGi0YPOKnls76pWj1WeTuPIilRtpgFuf84Lj
	 nT139QBbyiB4g==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9FAE817E03B0;
	Thu, 21 Aug 2025 16:05:51 +0200 (CEST)
Date: Thu, 21 Aug 2025 16:05:45 +0200
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
Subject: Re: [PATCH 2/2] panthor: use drm_gem_object.gpuva.lock instead of
 gpuva_list_lock
Message-ID: <20250821160545.70ca8d02@fedora>
In-Reply-To: <20250814-gpuva-mutex-in-gem-v1-2-e202cbfe6d77@google.com>
References: <20250814-gpuva-mutex-in-gem-v1-0-e202cbfe6d77@google.com>
	<20250814-gpuva-mutex-in-gem-v1-2-e202cbfe6d77@google.com>
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

On Thu, 14 Aug 2025 13:53:15 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Now that drm_gem_object has a dedicated mutex for the gpuva list that is
> intended to be used in cases that must be fence signalling safe, use it
> in Panthor.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  drivers/gpu/drm/panthor/panthor_gem.c |  4 +---
>  drivers/gpu/drm/panthor/panthor_gem.h | 12 ------------
>  drivers/gpu/drm/panthor/panthor_mmu.c | 16 ++++++++--------
>  3 files changed, 9 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> index a123bc740ba1460f96882206f598b148b64dc5f6..c654a3377903cf7e067becdb481fb14895a4eaa5 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -74,7 +74,6 @@ static void panthor_gem_free_object(struct drm_gem_object *obj)
>  	mutex_destroy(&bo->label.lock);
>  
>  	drm_gem_free_mmap_offset(&bo->base.base);
> -	mutex_destroy(&bo->gpuva_list_lock);
>  	drm_gem_shmem_free(&bo->base);
>  	drm_gem_object_put(vm_root_gem);
>  }
> @@ -246,8 +245,7 @@ struct drm_gem_object *panthor_gem_create_object(struct drm_device *ddev, size_t
>  
>  	obj->base.base.funcs = &panthor_gem_funcs;
>  	obj->base.map_wc = !ptdev->coherent;
> -	mutex_init(&obj->gpuva_list_lock);
> -	drm_gem_gpuva_set_lock(&obj->base.base, &obj->gpuva_list_lock);
> +	drm_gem_gpuva_set_lock(&obj->base.base, &obj->base.base.gpuva.lock);

I guess this will go away in the previous patch in you follow Danilo's
advice to get rid of drm_gem_gpuva_set_lock(). The rest looks good to
me, so feel free to add

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

on the next version.

>  	mutex_init(&obj->label.lock);
>  
>  	panthor_gem_debugfs_bo_init(obj);
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
> index 8fc7215e9b900ed162e03aebeae999fda00eeb7a..80c6e24112d0bd0f1561ae4d2224842afb735a59 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.h
> +++ b/drivers/gpu/drm/panthor/panthor_gem.h
> @@ -79,18 +79,6 @@ struct panthor_gem_object {
>  	 */
>  	struct drm_gem_object *exclusive_vm_root_gem;
>  
> -	/**
> -	 * @gpuva_list_lock: Custom GPUVA lock.
> -	 *
> -	 * Used to protect insertion of drm_gpuva elements to the
> -	 * drm_gem_object.gpuva.list list.
> -	 *
> -	 * We can't use the GEM resv for that, because drm_gpuva_link() is
> -	 * called in a dma-signaling path, where we're not allowed to take
> -	 * resv locks.
> -	 */
> -	struct mutex gpuva_list_lock;
> -
>  	/** @flags: Combination of drm_panthor_bo_flags flags. */
>  	u32 flags;
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 4140f697ba5af5769492d3bbb378e18aec8ade98..49ca416c7c2c5a01ab0513029697ba9c7a35832d 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1074,9 +1074,9 @@ static void panthor_vm_bo_put(struct drm_gpuvm_bo *vm_bo)
>  	 * GEM vm_bo list.
>  	 */
>  	dma_resv_lock(drm_gpuvm_resv(vm), NULL);
> -	mutex_lock(&bo->gpuva_list_lock);
> +	mutex_lock(&bo->base.base.gpuva.lock);
>  	unpin = drm_gpuvm_bo_put(vm_bo);
> -	mutex_unlock(&bo->gpuva_list_lock);
> +	mutex_unlock(&bo->base.base.gpuva.lock);
>  	dma_resv_unlock(drm_gpuvm_resv(vm));
>  
>  	/* If the vm_bo object was destroyed, release the pin reference that
> @@ -1249,9 +1249,9 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  	 * calling this function.
>  	 */
>  	dma_resv_lock(panthor_vm_resv(vm), NULL);
> -	mutex_lock(&bo->gpuva_list_lock);
> +	mutex_lock(&bo->base.base.gpuva.lock);
>  	op_ctx->map.vm_bo = drm_gpuvm_bo_obtain_prealloc(preallocated_vm_bo);
> -	mutex_unlock(&bo->gpuva_list_lock);
> +	mutex_unlock(&bo->base.base.gpuva.lock);
>  	dma_resv_unlock(panthor_vm_resv(vm));
>  
>  	/* If the a vm_bo for this <VM,BO> combination exists, it already
> @@ -2003,10 +2003,10 @@ static void panthor_vma_link(struct panthor_vm *vm,
>  {
>  	struct panthor_gem_object *bo = to_panthor_bo(vma->base.gem.obj);
>  
> -	mutex_lock(&bo->gpuva_list_lock);
> +	mutex_lock(&bo->base.base.gpuva.lock);
>  	drm_gpuva_link(&vma->base, vm_bo);
>  	drm_WARN_ON(&vm->ptdev->base, drm_gpuvm_bo_put(vm_bo));
> -	mutex_unlock(&bo->gpuva_list_lock);
> +	mutex_unlock(&bo->base.base.gpuva.lock);
>  }
>  
>  static void panthor_vma_unlink(struct panthor_vm *vm,
> @@ -2015,9 +2015,9 @@ static void panthor_vma_unlink(struct panthor_vm *vm,
>  	struct panthor_gem_object *bo = to_panthor_bo(vma->base.gem.obj);
>  	struct drm_gpuvm_bo *vm_bo = drm_gpuvm_bo_get(vma->base.vm_bo);
>  
> -	mutex_lock(&bo->gpuva_list_lock);
> +	mutex_lock(&bo->base.base.gpuva.lock);
>  	drm_gpuva_unlink(&vma->base);
> -	mutex_unlock(&bo->gpuva_list_lock);
> +	mutex_unlock(&bo->base.base.gpuva.lock);
>  
>  	/* drm_gpuva_unlink() release the vm_bo, but we manually retained it
>  	 * when entering this function, so we can implement deferred VMA
> 


