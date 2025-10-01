Return-Path: <linux-kernel+bounces-838796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DB0BB02AC
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D8737A33A2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37672D0607;
	Wed,  1 Oct 2025 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eCR9ggcm"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D42C08D0;
	Wed,  1 Oct 2025 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318297; cv=none; b=E3oVdBHqSHD5hhkhIdByNd7w84px+xb0/ure5qZ+aiXk0oxzObRSBvNd/8lvyphPCNcEbR368RZrJfs3Mm4od9b16jzDsmqeRHwAJBqav47p+ZgNkcb1jaUN1wfon+ExgeFzj/Vqun4Q4VDp9/OvrmSgVxO3vU7XIGZjpqXs39A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318297; c=relaxed/simple;
	bh=bNVCo2nWEs3lYwi8RXZaWvjzi9kENnkYxE+jsbtrk4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhFPfiOJtFocb3dLmM0Pb9HIjua4R4k02Hd7C9koHbI6tiul5BaLk3u71Uanw7N9nKjOFw+SBk8bXHjSE+G9C9KqEBgEpOYovkpsABFriV6h0FmgervjCVy5PKFTj40iTySWZpNsFbh7lxush+CL+eoWjtKEstwoaw5+gzMMMfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eCR9ggcm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759318293;
	bh=bNVCo2nWEs3lYwi8RXZaWvjzi9kENnkYxE+jsbtrk4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eCR9ggcmxADnb/4CLIwx8pj4wmAeZ0oHiqiNWMQgYguTCNQZIF0K9NZTo5GKjigdZ
	 1DoT1kLTzbDgC1DZFS40mgjzsnH+AOpC5YcXcdhKLkfDGco5/VXMJOzEvW/85vmdgo
	 U48aHCnF2n2aJrucb72yu8u7oVP4v2PMx46A9m+f4U6H9kUbgA0U/GowdzcpOH9pi5
	 H4pEeVQe6W7ueVPsZxpJLvuvBsi181TRRBGGffMUnQSLA83HDZrCklAakxR6cxUBQr
	 SrE6oin8LQdWtVRsrEg9n05IQ6SPy9XyhjcDH0lawBVoNct1nNBON2TE3cIKhetPOT
	 XlPRxQvQzc00Q==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8E26817E00AC;
	Wed,  1 Oct 2025 13:31:32 +0200 (CEST)
Date: Wed, 1 Oct 2025 13:31:26 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, "Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?="
 <thomas.hellstrom@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Steven Price <steven.price@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, Liviu Dudau
 <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 2/2] panthor: use drm_gpuva_unlink_defer()
Message-ID: <20251001133126.5f9e3cd8@fedora>
In-Reply-To: <20251001-vmbo-defer-v3-2-a3fe6b6ae185@google.com>
References: <20251001-vmbo-defer-v3-0-a3fe6b6ae185@google.com>
	<20251001-vmbo-defer-v3-2-a3fe6b6ae185@google.com>
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

On Wed, 01 Oct 2025 10:41:37 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Instead of manually deferring cleanup of vm_bos, use the new GPUVM
> infrastructure for doing so.
> 
> To avoid manual management of vm_bo refcounts, the panthor_vma_link()
> and panthor_vma_unlink() methods are changed to get and put a vm_bo
> refcount on the vm_bo. This simplifies the code a lot. I preserved the
> behavior where panthor_gpuva_sm_step_map() drops the refcount right away
> rather than letting panthor_vm_cleanup_op_ctx() do it later.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 110 ++++++----------------------------
>  1 file changed, 19 insertions(+), 91 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 6dec4354e3789d17c5a87fc8de3bc86764b804bc..9f5f4ddf291024121f3fd5644f2fdeba354fa67c 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -181,20 +181,6 @@ struct panthor_vm_op_ctx {
>  		u64 range;
>  	} va;
>  
> -	/**
> -	 * @returned_vmas: List of panthor_vma objects returned after a VM operation.
> -	 *
> -	 * For unmap operations, this will contain all VMAs that were covered by the
> -	 * specified VA range.
> -	 *
> -	 * For map operations, this will contain all VMAs that previously mapped to
> -	 * the specified VA range.
> -	 *
> -	 * Those VMAs, and the resources they point to will be released as part of
> -	 * the op_ctx cleanup operation.
> -	 */
> -	struct list_head returned_vmas;
> -
>  	/** @map: Fields specific to a map operation. */
>  	struct {
>  		/** @map.vm_bo: Buffer object to map. */
> @@ -1081,47 +1067,18 @@ void panthor_vm_free_va(struct panthor_vm *vm, struct drm_mm_node *va_node)
>  	mutex_unlock(&vm->mm_lock);
>  }
>  
> -static void panthor_vm_bo_put(struct drm_gpuvm_bo *vm_bo)
> +static void panthor_vm_bo_free(struct drm_gpuvm_bo *vm_bo)
>  {
>  	struct panthor_gem_object *bo = to_panthor_bo(vm_bo->obj);
> -	struct drm_gpuvm *vm = vm_bo->vm;
> -	bool unpin;
> -
> -	/* We must retain the GEM before calling drm_gpuvm_bo_put(),
> -	 * otherwise the mutex might be destroyed while we hold it.
> -	 * Same goes for the VM, since we take the VM resv lock.
> -	 */
> -	drm_gem_object_get(&bo->base.base);
> -	drm_gpuvm_get(vm);
> -
> -	/* We take the resv lock to protect against concurrent accesses to the
> -	 * gpuvm evicted/extobj lists that are modified in
> -	 * drm_gpuvm_bo_destroy(), which is called if drm_gpuvm_bo_put()
> -	 * releases sthe last vm_bo reference.
> -	 * We take the BO GPUVA list lock to protect the vm_bo removal from the
> -	 * GEM vm_bo list.
> -	 */
> -	dma_resv_lock(drm_gpuvm_resv(vm), NULL);
> -	mutex_lock(&bo->base.base.gpuva.lock);
> -	unpin = drm_gpuvm_bo_put(vm_bo);
> -	mutex_unlock(&bo->base.base.gpuva.lock);
> -	dma_resv_unlock(drm_gpuvm_resv(vm));
>  
> -	/* If the vm_bo object was destroyed, release the pin reference that
> -	 * was hold by this object.
> -	 */
> -	if (unpin && !drm_gem_is_imported(&bo->base.base))
> +	if (!drm_gem_is_imported(&bo->base.base))
>  		drm_gem_shmem_unpin(&bo->base);
> -
> -	drm_gpuvm_put(vm);
> -	drm_gem_object_put(&bo->base.base);
> +	kfree(vm_bo);
>  }
>  
>  static void panthor_vm_cleanup_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  				      struct panthor_vm *vm)
>  {
> -	struct panthor_vma *vma, *tmp_vma;
> -
>  	u32 remaining_pt_count = op_ctx->rsvd_page_tables.count -
>  				 op_ctx->rsvd_page_tables.ptr;
>  
> @@ -1134,16 +1091,12 @@ static void panthor_vm_cleanup_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  	kfree(op_ctx->rsvd_page_tables.pages);
>  
>  	if (op_ctx->map.vm_bo)
> -		panthor_vm_bo_put(op_ctx->map.vm_bo);
> +		drm_gpuvm_bo_put_deferred(op_ctx->map.vm_bo);
>  
>  	for (u32 i = 0; i < ARRAY_SIZE(op_ctx->preallocated_vmas); i++)
>  		kfree(op_ctx->preallocated_vmas[i]);
>  
> -	list_for_each_entry_safe(vma, tmp_vma, &op_ctx->returned_vmas, node) {
> -		list_del(&vma->node);
> -		panthor_vm_bo_put(vma->base.vm_bo);
> -		kfree(vma);
> -	}
> +	drm_gpuvm_bo_deferred_cleanup(&vm->base);
>  }
>  
>  static struct panthor_vma *
> @@ -1232,7 +1185,6 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  		return -EINVAL;
>  
>  	memset(op_ctx, 0, sizeof(*op_ctx));
> -	INIT_LIST_HEAD(&op_ctx->returned_vmas);
>  	op_ctx->flags = flags;
>  	op_ctx->va.range = size;
>  	op_ctx->va.addr = va;
> @@ -1243,7 +1195,9 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  
>  	if (!drm_gem_is_imported(&bo->base.base)) {
>  		/* Pre-reserve the BO pages, so the map operation doesn't have to
> -		 * allocate.
> +		 * allocate. This pin is dropped in panthor_vm_bo_free(), so
> +		 * once we have successfully called drm_gpuvm_bo_create(),
> +		 * GPUVM will take care of dropping the pin for us.
>  		 */
>  		ret = drm_gem_shmem_pin(&bo->base);
>  		if (ret)
> @@ -1282,16 +1236,6 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  	mutex_unlock(&bo->base.base.gpuva.lock);
>  	dma_resv_unlock(panthor_vm_resv(vm));
>  
> -	/* If the a vm_bo for this <VM,BO> combination exists, it already
> -	 * retains a pin ref, and we can release the one we took earlier.
> -	 *
> -	 * If our pre-allocated vm_bo is picked, it now retains the pin ref,
> -	 * which will be released in panthor_vm_bo_put().
> -	 */
> -	if (preallocated_vm_bo != op_ctx->map.vm_bo &&
> -	    !drm_gem_is_imported(&bo->base.base))
> -		drm_gem_shmem_unpin(&bo->base);
> -
>  	op_ctx->map.bo_offset = offset;
>  
>  	/* L1, L2 and L3 page tables.
> @@ -1339,7 +1283,6 @@ static int panthor_vm_prepare_unmap_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  	int ret;
>  
>  	memset(op_ctx, 0, sizeof(*op_ctx));
> -	INIT_LIST_HEAD(&op_ctx->returned_vmas);
>  	op_ctx->va.range = size;
>  	op_ctx->va.addr = va;
>  	op_ctx->flags = DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP;
> @@ -1387,7 +1330,6 @@ static void panthor_vm_prepare_sync_only_op_ctx(struct panthor_vm_op_ctx *op_ctx
>  						struct panthor_vm *vm)
>  {
>  	memset(op_ctx, 0, sizeof(*op_ctx));
> -	INIT_LIST_HEAD(&op_ctx->returned_vmas);
>  	op_ctx->flags = DRM_PANTHOR_VM_BIND_OP_TYPE_SYNC_ONLY;
>  }
>  
> @@ -2033,26 +1975,13 @@ static void panthor_vma_link(struct panthor_vm *vm,
>  
>  	mutex_lock(&bo->base.base.gpuva.lock);
>  	drm_gpuva_link(&vma->base, vm_bo);
> -	drm_WARN_ON(&vm->ptdev->base, drm_gpuvm_bo_put(vm_bo));
>  	mutex_unlock(&bo->base.base.gpuva.lock);
>  }
>  
> -static void panthor_vma_unlink(struct panthor_vm *vm,
> -			       struct panthor_vma *vma)
> +static void panthor_vma_unlink(struct panthor_vma *vma)
>  {
> -	struct panthor_gem_object *bo = to_panthor_bo(vma->base.gem.obj);
> -	struct drm_gpuvm_bo *vm_bo = drm_gpuvm_bo_get(vma->base.vm_bo);
> -
> -	mutex_lock(&bo->base.base.gpuva.lock);
> -	drm_gpuva_unlink(&vma->base);
> -	mutex_unlock(&bo->base.base.gpuva.lock);
> -
> -	/* drm_gpuva_unlink() release the vm_bo, but we manually retained it
> -	 * when entering this function, so we can implement deferred VMA
> -	 * destruction. Re-assign it here.
> -	 */
> -	vma->base.vm_bo = vm_bo;
> -	list_add_tail(&vma->node, &vm->op_ctx->returned_vmas);
> +	drm_gpuva_unlink_defer(&vma->base);
> +	kfree(vma);
>  }
>  
>  static void panthor_vma_init(struct panthor_vma *vma, u32 flags)
> @@ -2084,12 +2013,12 @@ static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
>  	if (ret)
>  		return ret;
>  
> -	/* Ref owned by the mapping now, clear the obj field so we don't release the
> -	 * pinning/obj ref behind GPUVA's back.
> -	 */
>  	drm_gpuva_map(&vm->base, &vma->base, &op->map);
>  	panthor_vma_link(vm, vma, op_ctx->map.vm_bo);
> +
> +	drm_gpuvm_bo_put_deferred(op_ctx->map.vm_bo);
>  	op_ctx->map.vm_bo = NULL;
> +
>  	return 0;
>  }
>  
> @@ -2128,16 +2057,14 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
>  		 * owned by the old mapping which will be released when this
>  		 * mapping is destroyed, we need to grab a ref here.
>  		 */
> -		panthor_vma_link(vm, prev_vma,
> -				 drm_gpuvm_bo_get(op->remap.unmap->va->vm_bo));
> +		panthor_vma_link(vm, prev_vma, op->remap.unmap->va->vm_bo);
>  	}
>  
>  	if (next_vma) {
> -		panthor_vma_link(vm, next_vma,
> -				 drm_gpuvm_bo_get(op->remap.unmap->va->vm_bo));
> +		panthor_vma_link(vm, next_vma, op->remap.unmap->va->vm_bo);
>  	}
>  
> -	panthor_vma_unlink(vm, unmap_vma);
> +	panthor_vma_unlink(unmap_vma);
>  	return 0;
>  }
>  
> @@ -2154,12 +2081,13 @@ static int panthor_gpuva_sm_step_unmap(struct drm_gpuva_op *op,
>  		return ret;
>  
>  	drm_gpuva_unmap(&op->unmap);
> -	panthor_vma_unlink(vm, unmap_vma);
> +	panthor_vma_unlink(unmap_vma);
>  	return 0;
>  }
>  
>  static const struct drm_gpuvm_ops panthor_gpuvm_ops = {
>  	.vm_free = panthor_vm_free,
> +	.vm_bo_free = panthor_vm_bo_free,
>  	.sm_step_map = panthor_gpuva_sm_step_map,
>  	.sm_step_remap = panthor_gpuva_sm_step_remap,
>  	.sm_step_unmap = panthor_gpuva_sm_step_unmap,
> 


