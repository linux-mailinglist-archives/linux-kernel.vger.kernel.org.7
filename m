Return-Path: <linux-kernel+bounces-578381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D10AA72F04
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 12:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316E03B63C6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 11:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C335B212B21;
	Thu, 27 Mar 2025 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1PQ4CES"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C461FF7BC
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074731; cv=none; b=XFcw8CQqvsk1tmHiOONu/hRG2EGmO+58OzO8i3InWQN3NeYmE4S7VwjudRwMNOIUtSK5A3kljDPXTpPgPcsAX6eOh8gxh5qeDocg6K8QPWJApgc1dwIEv/nBIFGPgwBsu4dovdpJN3vcogod3szb8xTu+s8YMCNRmC+VPXhrWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074731; c=relaxed/simple;
	bh=j6WgPFmzS+DJvy5hZDMNvnCM+EO7f4jVp5BIXkPoFcw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D4/s0sR/DVTrOaMroZVnkoe/iiCVgRBx1KzOCHzP37zOp5lzU1i4H2We5P56+ej7dmppB68g9vfGyrtfNQOuk4rFqLrf+Ed5d3c0fPfBkT37PzDLBKj9cfzVplQ9/24pPNiRiEmFcUd+Rnxbw/HS6/eHFpfedaqHdsuj1nuFnr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1PQ4CES; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743074729; x=1774610729;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=j6WgPFmzS+DJvy5hZDMNvnCM+EO7f4jVp5BIXkPoFcw=;
  b=n1PQ4CESjaZZqID3DD0aIeCzlYzj6hSk8JKL0XqsQL06fey6Vk02Hj27
   GMEPUdOQdqkUYlzcEzEEhlQ2ZE8NBl6KXrhYunGGK0GaxZDC9VdwK3XaM
   P564eOIHWBPSbDAYVTlalEvMDDD4pARTgs6EsQZ6QsVkVRcKBWyUZWRyC
   zz7/+XXl2THPPZiQ8pNyHp0Ee8XFSyjVBT9LU/ye//olxN3w4ah+OmzTS
   +UgbE05t/2kjb7U6k2RF+ewNiZ/JNcwAphb0iUyY2/PCH9mgVxX6e+ExU
   8RM0Ioq+F9FViTV0cHIA0uaqJlQpk1ZbAARdbVh064qLF5zWMovLKbYVW
   g==;
X-CSE-ConnectionGUID: IsNDO+ZoQ3uw2e1yxCqK3w==
X-CSE-MsgGUID: QGCNOaMZQxuMOn32yH4bDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44319202"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="44319202"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 04:25:27 -0700
X-CSE-ConnectionGUID: 8ItsIo0IT36ycLRXzUDQlA==
X-CSE-MsgGUID: 235PMXDjSCqDwU1Ja70ebA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="125326296"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.17])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 04:25:22 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>, Gerd Hoffmann <kraxel@redhat.com>, Qiang Yu
 <yuq825@gmail.com>, Steven Price <steven.price@arm.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Frank Binns <frank.binns@imgtec.com>,
 Matt Coster <matt.coster@imgtec.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v20 05/10] drm/shmem-helper: Refactor locked/unlocked
 functions
In-Reply-To: <20250322212608.40511-6-dmitry.osipenko@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250322212608.40511-1-dmitry.osipenko@collabora.com>
 <20250322212608.40511-6-dmitry.osipenko@collabora.com>
Date: Thu, 27 Mar 2025 13:25:18 +0200
Message-ID: <87iknu67hd.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, 23 Mar 2025, Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> Add locked and remove unlocked postfixes from drm-shmem function names,
> making names consistent with the drm/gem core code.

This breaks the build for drivers/accel/ivpu/ivpu_gem.c.

Please enable CONFIG_DRM_ACCEL_IVPU=m and fix the fallout.

BR,
Jani.


>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c        | 60 +++++++++----------
>  drivers/gpu/drm/imagination/pvr_gem.c         |  4 +-
>  drivers/gpu/drm/lima/lima_gem.c               |  2 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c       |  2 +-
>  .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |  2 +-
>  drivers/gpu/drm/tests/drm_gem_shmem_test.c    | 14 ++---
>  include/drm/drm_gem_shmem_helper.h            | 28 ++++-----
>  7 files changed, 56 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 98c68999d61a..a9e35a46e72b 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -174,7 +174,7 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
>  			kfree(shmem->sgt);
>  		}
>  		if (shmem->pages)
> -			drm_gem_shmem_put_pages(shmem);
> +			drm_gem_shmem_put_pages_locked(shmem);
>  
>  		drm_WARN_ON(obj->dev, shmem->pages_use_count);
>  
> @@ -186,7 +186,7 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_free);
>  
> -static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
> +static int drm_gem_shmem_get_pages_locked(struct drm_gem_shmem_object *shmem)
>  {
>  	struct drm_gem_object *obj = &shmem->base;
>  	struct page **pages;
> @@ -220,12 +220,12 @@ static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
>  }
>  
>  /*
> - * drm_gem_shmem_put_pages - Decrease use count on the backing pages for a shmem GEM object
> + * drm_gem_shmem_put_pages_locked - Decrease use count on the backing pages for a shmem GEM object
>   * @shmem: shmem GEM object
>   *
>   * This function decreases the use count and puts the backing pages when use drops to zero.
>   */
> -void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem)
> +void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
>  {
>  	struct drm_gem_object *obj = &shmem->base;
>  
> @@ -247,7 +247,7 @@ void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem)
>  			  shmem->pages_mark_accessed_on_put);
>  	shmem->pages = NULL;
>  }
> -EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages);
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
>  
>  int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
>  {
> @@ -257,7 +257,7 @@ int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
>  
>  	drm_WARN_ON(shmem->base.dev, drm_gem_is_imported(&shmem->base));
>  
> -	ret = drm_gem_shmem_get_pages(shmem);
> +	ret = drm_gem_shmem_get_pages_locked(shmem);
>  
>  	return ret;
>  }
> @@ -267,7 +267,7 @@ void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem)
>  {
>  	dma_resv_assert_held(shmem->base.resv);
>  
> -	drm_gem_shmem_put_pages(shmem);
> +	drm_gem_shmem_put_pages_locked(shmem);
>  }
>  EXPORT_SYMBOL(drm_gem_shmem_unpin_locked);
>  
> @@ -318,7 +318,7 @@ void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem)
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_unpin);
>  
>  /*
> - * drm_gem_shmem_vmap - Create a virtual mapping for a shmem GEM object
> + * drm_gem_shmem_vmap_locked - Create a virtual mapping for a shmem GEM object
>   * @shmem: shmem GEM object
>   * @map: Returns the kernel virtual address of the SHMEM GEM object's backing
>   *       store.
> @@ -327,13 +327,13 @@ EXPORT_SYMBOL_GPL(drm_gem_shmem_unpin);
>   * exists for the buffer backing the shmem GEM object. It hides the differences
>   * between dma-buf imported and natively allocated objects.
>   *
> - * Acquired mappings should be cleaned up by calling drm_gem_shmem_vunmap().
> + * Acquired mappings should be cleaned up by calling drm_gem_shmem_vunmap_locked().
>   *
>   * Returns:
>   * 0 on success or a negative error code on failure.
>   */
> -int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem,
> -		       struct iosys_map *map)
> +int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
> +			      struct iosys_map *map)
>  {
>  	struct drm_gem_object *obj = &shmem->base;
>  	int ret = 0;
> @@ -356,7 +356,7 @@ int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem,
>  			return 0;
>  		}
>  
> -		ret = drm_gem_shmem_get_pages(shmem);
> +		ret = drm_gem_shmem_get_pages_locked(shmem);
>  		if (ret)
>  			goto err_zero_use;
>  
> @@ -379,28 +379,28 @@ int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem,
>  
>  err_put_pages:
>  	if (!drm_gem_is_imported(obj))
> -		drm_gem_shmem_put_pages(shmem);
> +		drm_gem_shmem_put_pages_locked(shmem);
>  err_zero_use:
>  	shmem->vmap_use_count = 0;
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(drm_gem_shmem_vmap);
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_vmap_locked);
>  
>  /*
> - * drm_gem_shmem_vunmap - Unmap a virtual mapping for a shmem GEM object
> + * drm_gem_shmem_vunmap_locked - Unmap a virtual mapping for a shmem GEM object
>   * @shmem: shmem GEM object
>   * @map: Kernel virtual address where the SHMEM GEM object was mapped
>   *
>   * This function cleans up a kernel virtual address mapping acquired by
> - * drm_gem_shmem_vmap(). The mapping is only removed when the use count drops to
> - * zero.
> + * drm_gem_shmem_vmap_locked(). The mapping is only removed when the use count
> + * drops to zero.
>   *
>   * This function hides the differences between dma-buf imported and natively
>   * allocated objects.
>   */
> -void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem,
> -			  struct iosys_map *map)
> +void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
> +				 struct iosys_map *map)
>  {
>  	struct drm_gem_object *obj = &shmem->base;
>  
> @@ -416,12 +416,12 @@ void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem,
>  			return;
>  
>  		vunmap(shmem->vaddr);
> -		drm_gem_shmem_put_pages(shmem);
> +		drm_gem_shmem_put_pages_locked(shmem);
>  	}
>  
>  	shmem->vaddr = NULL;
>  }
> -EXPORT_SYMBOL_GPL(drm_gem_shmem_vunmap);
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_vunmap_locked);
>  
>  static int
>  drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
> @@ -449,7 +449,7 @@ drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
>  /* Update madvise status, returns true if not purged, else
>   * false or -errno.
>   */
> -int drm_gem_shmem_madvise(struct drm_gem_shmem_object *shmem, int madv)
> +int drm_gem_shmem_madvise_locked(struct drm_gem_shmem_object *shmem, int madv)
>  {
>  	dma_resv_assert_held(shmem->base.resv);
>  
> @@ -460,9 +460,9 @@ int drm_gem_shmem_madvise(struct drm_gem_shmem_object *shmem, int madv)
>  
>  	return (madv >= 0);
>  }
> -EXPORT_SYMBOL_GPL(drm_gem_shmem_madvise);
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_madvise_locked);
>  
> -void drm_gem_shmem_purge(struct drm_gem_shmem_object *shmem)
> +void drm_gem_shmem_purge_locked(struct drm_gem_shmem_object *shmem)
>  {
>  	struct drm_gem_object *obj = &shmem->base;
>  	struct drm_device *dev = obj->dev;
> @@ -476,7 +476,7 @@ void drm_gem_shmem_purge(struct drm_gem_shmem_object *shmem)
>  	kfree(shmem->sgt);
>  	shmem->sgt = NULL;
>  
> -	drm_gem_shmem_put_pages(shmem);
> +	drm_gem_shmem_put_pages_locked(shmem);
>  
>  	shmem->madv = -1;
>  
> @@ -492,7 +492,7 @@ void drm_gem_shmem_purge(struct drm_gem_shmem_object *shmem)
>  
>  	invalidate_mapping_pages(file_inode(obj->filp)->i_mapping, 0, (loff_t)-1);
>  }
> -EXPORT_SYMBOL_GPL(drm_gem_shmem_purge);
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_purge_locked);
>  
>  /**
>   * drm_gem_shmem_dumb_create - Create a dumb shmem buffer object
> @@ -589,7 +589,7 @@ static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
>  	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
>  
>  	dma_resv_lock(shmem->base.resv, NULL);
> -	drm_gem_shmem_put_pages(shmem);
> +	drm_gem_shmem_put_pages_locked(shmem);
>  	dma_resv_unlock(shmem->base.resv);
>  
>  	drm_gem_vm_close(vma);
> @@ -639,7 +639,7 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
>  		return -EINVAL;
>  
>  	dma_resv_lock(shmem->base.resv, NULL);
> -	ret = drm_gem_shmem_get_pages(shmem);
> +	ret = drm_gem_shmem_get_pages_locked(shmem);
>  	dma_resv_unlock(shmem->base.resv);
>  
>  	if (ret)
> @@ -707,7 +707,7 @@ static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_
>  
>  	drm_WARN_ON(obj->dev, drm_gem_is_imported(obj));
>  
> -	ret = drm_gem_shmem_get_pages(shmem);
> +	ret = drm_gem_shmem_get_pages_locked(shmem);
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> @@ -729,7 +729,7 @@ static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_
>  	sg_free_table(sgt);
>  	kfree(sgt);
>  err_put_pages:
> -	drm_gem_shmem_put_pages(shmem);
> +	drm_gem_shmem_put_pages_locked(shmem);
>  	return ERR_PTR(ret);
>  }
>  
> diff --git a/drivers/gpu/drm/imagination/pvr_gem.c b/drivers/gpu/drm/imagination/pvr_gem.c
> index 6a8c81fe8c1e..d9d7c6d1a138 100644
> --- a/drivers/gpu/drm/imagination/pvr_gem.c
> +++ b/drivers/gpu/drm/imagination/pvr_gem.c
> @@ -203,7 +203,7 @@ pvr_gem_object_vmap(struct pvr_gem_object *pvr_obj)
>  
>  	dma_resv_lock(obj->resv, NULL);
>  
> -	err = drm_gem_shmem_vmap(shmem_obj, &map);
> +	err = drm_gem_shmem_vmap_locked(shmem_obj, &map);
>  	if (err)
>  		goto err_unlock;
>  
> @@ -257,7 +257,7 @@ pvr_gem_object_vunmap(struct pvr_gem_object *pvr_obj)
>  			dma_sync_sgtable_for_device(dev, shmem_obj->sgt, DMA_BIDIRECTIONAL);
>  	}
>  
> -	drm_gem_shmem_vunmap(shmem_obj, &map);
> +	drm_gem_shmem_vunmap_locked(shmem_obj, &map);
>  
>  	dma_resv_unlock(obj->resv);
>  }
> diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
> index 9bb997dbb4b9..609221351cde 100644
> --- a/drivers/gpu/drm/lima/lima_gem.c
> +++ b/drivers/gpu/drm/lima/lima_gem.c
> @@ -195,7 +195,7 @@ static int lima_gem_vmap(struct drm_gem_object *obj, struct iosys_map *map)
>  	if (bo->heap_size)
>  		return -EINVAL;
>  
> -	return drm_gem_shmem_vmap(&bo->base, map);
> +	return drm_gem_shmem_vmap_locked(&bo->base, map);
>  }
>  
>  static int lima_gem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 0f3935556ac7..a731f6b59a42 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -476,7 +476,7 @@ static int panfrost_ioctl_madvise(struct drm_device *dev, void *data,
>  		}
>  	}
>  
> -	args->retained = drm_gem_shmem_madvise(&bo->base, args->madv);
> +	args->retained = drm_gem_shmem_madvise_locked(&bo->base, args->madv);
>  
>  	if (args->retained) {
>  		if (args->madv == PANFROST_MADV_DONTNEED)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> index 3d9f51bd48b6..02b60ea1433a 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> @@ -51,7 +51,7 @@ static bool panfrost_gem_purge(struct drm_gem_object *obj)
>  		goto unlock_mappings;
>  
>  	panfrost_gem_teardown_mappings_locked(bo);
> -	drm_gem_shmem_purge(&bo->base);
> +	drm_gem_shmem_purge_locked(&bo->base);
>  	ret = true;
>  
>  	dma_resv_unlock(shmem->base.resv);
> diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> index fd4215e2f982..98884966bb92 100644
> --- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> +++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> @@ -173,7 +173,7 @@ static void drm_gem_shmem_test_vmap(struct kunit *test)
>  	ret = kunit_add_action_or_reset(test, drm_gem_shmem_free_wrapper, shmem);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
>  
> -	ret = drm_gem_shmem_vmap(shmem, &map);
> +	ret = drm_gem_shmem_vmap_locked(shmem, &map);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
>  	KUNIT_ASSERT_NOT_NULL(test, shmem->vaddr);
>  	KUNIT_ASSERT_FALSE(test, iosys_map_is_null(&map));
> @@ -183,7 +183,7 @@ static void drm_gem_shmem_test_vmap(struct kunit *test)
>  	for (i = 0; i < TEST_SIZE; i++)
>  		KUNIT_EXPECT_EQ(test, iosys_map_rd(&map, i, u8), TEST_BYTE);
>  
> -	drm_gem_shmem_vunmap(shmem, &map);
> +	drm_gem_shmem_vunmap_locked(shmem, &map);
>  	KUNIT_EXPECT_NULL(test, shmem->vaddr);
>  	KUNIT_EXPECT_EQ(test, shmem->vmap_use_count, 0);
>  }
> @@ -281,17 +281,17 @@ static void drm_gem_shmem_test_madvise(struct kunit *test)
>  	ret = kunit_add_action_or_reset(test, drm_gem_shmem_free_wrapper, shmem);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
>  
> -	ret = drm_gem_shmem_madvise(shmem, 1);
> +	ret = drm_gem_shmem_madvise_locked(shmem, 1);
>  	KUNIT_EXPECT_TRUE(test, ret);
>  	KUNIT_ASSERT_EQ(test, shmem->madv, 1);
>  
>  	/* Set madv to a negative value */
> -	ret = drm_gem_shmem_madvise(shmem, -1);
> +	ret = drm_gem_shmem_madvise_locked(shmem, -1);
>  	KUNIT_EXPECT_FALSE(test, ret);
>  	KUNIT_ASSERT_EQ(test, shmem->madv, -1);
>  
>  	/* Check that madv cannot be set back to a positive value */
> -	ret = drm_gem_shmem_madvise(shmem, 0);
> +	ret = drm_gem_shmem_madvise_locked(shmem, 0);
>  	KUNIT_EXPECT_FALSE(test, ret);
>  	KUNIT_ASSERT_EQ(test, shmem->madv, -1);
>  }
> @@ -319,7 +319,7 @@ static void drm_gem_shmem_test_purge(struct kunit *test)
>  	ret = drm_gem_shmem_is_purgeable(shmem);
>  	KUNIT_EXPECT_FALSE(test, ret);
>  
> -	ret = drm_gem_shmem_madvise(shmem, 1);
> +	ret = drm_gem_shmem_madvise_locked(shmem, 1);
>  	KUNIT_EXPECT_TRUE(test, ret);
>  
>  	/* The scatter/gather table will be freed by drm_gem_shmem_free */
> @@ -329,7 +329,7 @@ static void drm_gem_shmem_test_purge(struct kunit *test)
>  	ret = drm_gem_shmem_is_purgeable(shmem);
>  	KUNIT_EXPECT_TRUE(test, ret);
>  
> -	drm_gem_shmem_purge(shmem);
> +	drm_gem_shmem_purge_locked(shmem);
>  	KUNIT_EXPECT_NULL(test, shmem->pages);
>  	KUNIT_EXPECT_NULL(test, shmem->sgt);
>  	KUNIT_EXPECT_EQ(test, shmem->madv, -1);
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index cef5a6b5a4d6..0609e336479d 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -102,19 +102,19 @@ struct drm_gem_shmem_object *drm_gem_shmem_create_with_mnt(struct drm_device *de
>  							   struct vfsmount *gemfs);
>  void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem);
>  
> -void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem);
> +void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem);
>  int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem);
>  void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem);
> -int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem,
> -		       struct iosys_map *map);
> -void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem,
> -			  struct iosys_map *map);
> +int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
> +			      struct iosys_map *map);
> +void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
> +				 struct iosys_map *map);
>  int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct *vma);
>  
>  int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem);
>  void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem);
>  
> -int drm_gem_shmem_madvise(struct drm_gem_shmem_object *shmem, int madv);
> +int drm_gem_shmem_madvise_locked(struct drm_gem_shmem_object *shmem, int madv);
>  
>  static inline bool drm_gem_shmem_is_purgeable(struct drm_gem_shmem_object *shmem)
>  {
> @@ -123,7 +123,7 @@ static inline bool drm_gem_shmem_is_purgeable(struct drm_gem_shmem_object *shmem
>  		!shmem->base.dma_buf && !drm_gem_is_imported(&shmem->base);
>  }
>  
> -void drm_gem_shmem_purge(struct drm_gem_shmem_object *shmem);
> +void drm_gem_shmem_purge_locked(struct drm_gem_shmem_object *shmem);
>  
>  struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem);
>  struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_object *shmem);
> @@ -214,12 +214,12 @@ static inline struct sg_table *drm_gem_shmem_object_get_sg_table(struct drm_gem_
>  }
>  
>  /*
> - * drm_gem_shmem_object_vmap - GEM object function for drm_gem_shmem_vmap()
> + * drm_gem_shmem_object_vmap - GEM object function for drm_gem_shmem_vmap_locked()
>   * @obj: GEM object
>   * @map: Returns the kernel virtual address of the SHMEM GEM object's backing store.
>   *
> - * This function wraps drm_gem_shmem_vmap(). Drivers that employ the shmem helpers should
> - * use it as their &drm_gem_object_funcs.vmap handler.
> + * This function wraps drm_gem_shmem_vmap_locked(). Drivers that employ the shmem
> + * helpers should use it as their &drm_gem_object_funcs.vmap handler.
>   *
>   * Returns:
>   * 0 on success or a negative error code on failure.
> @@ -229,7 +229,7 @@ static inline int drm_gem_shmem_object_vmap(struct drm_gem_object *obj,
>  {
>  	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
>  
> -	return drm_gem_shmem_vmap(shmem, map);
> +	return drm_gem_shmem_vmap_locked(shmem, map);
>  }
>  
>  /*
> @@ -237,15 +237,15 @@ static inline int drm_gem_shmem_object_vmap(struct drm_gem_object *obj,
>   * @obj: GEM object
>   * @map: Kernel virtual address where the SHMEM GEM object was mapped
>   *
> - * This function wraps drm_gem_shmem_vunmap(). Drivers that employ the shmem helpers should
> - * use it as their &drm_gem_object_funcs.vunmap handler.
> + * This function wraps drm_gem_shmem_vunmap_locked(). Drivers that employ the shmem
> + * helpers should use it as their &drm_gem_object_funcs.vunmap handler.
>   */
>  static inline void drm_gem_shmem_object_vunmap(struct drm_gem_object *obj,
>  					       struct iosys_map *map)
>  {
>  	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
>  
> -	drm_gem_shmem_vunmap(shmem, map);
> +	drm_gem_shmem_vunmap_locked(shmem, map);
>  }
>  
>  /**

-- 
Jani Nikula, Intel

