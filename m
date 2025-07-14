Return-Path: <linux-kernel+bounces-729819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00ECB03BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA103BD93E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0AA244696;
	Mon, 14 Jul 2025 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQU4Z5G0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078002459FD
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489217; cv=none; b=NHPQvVRp5euRpQ0zibH+OWZr0PuMTLEtPvj9l6udY/WK8Da0CGh9YHUrScjQDaFHS3gcrIj6oGVjaoFFcIHLyzro44caI49wTrg07d+lB3gOsUm8iUBo/LV2kf8BAvyerva8SoyKqqeaZSHbIGmZzR7sBzMBT+7Ar47bSW18XdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489217; c=relaxed/simple;
	bh=vv7fGGrYXgqf+0G61s83sX4FAonBqcjR+Ufn/7gpKao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvFhPauscCQA9bjhYs6q7aKnzTzGJYocYU4LF0Rfev4ODoUeZZdhpuFNZPKR0vE39ZOfkZEoWvsN9Lbm26F5xCILnNjZgO7D6Ie0+bnOPJvWXM7+d2/zGyZeY1XhcrGMM+W5Anvu2ZBkZ2v/WTBLVvQ4BIZ5f4gTRofifMdp+EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQU4Z5G0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752489216; x=1784025216;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vv7fGGrYXgqf+0G61s83sX4FAonBqcjR+Ufn/7gpKao=;
  b=TQU4Z5G0jDCO9O1NsYKZUiZxIoFbGbQBO8AACrYy+SJfsUuSep/09yoW
   bfYFuYavWCA++KqdbQ4UosRHyRfCYvRR4KW1G57DteJ6PSK+AA+kYFfPT
   CeygZfaGRucdqaMMXFjJxCX3ctygqUkqFWAjIl1qBN9xDDIoR5FtaiaYT
   uQK7jvLvkwv7j227BJky4DZI6DbaioSeQXrp7fkADrUIgwN+C7qecqlW+
   Ohy2xapYIg17CXagjmOayRk4TH5kY8ooTuM3T9CWOAmdoH+XggZW2tI3z
   3GOrUbKzLpUVpCOb/AfayLPRmcfgc+05Z2U9l4080Cj04DMQnBCcN37zj
   w==;
X-CSE-ConnectionGUID: JimIQmYhRc+3/BBEro8oig==
X-CSE-MsgGUID: A23mXkpsR4yZsnPrPv2X3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58338228"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="58338228"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 03:33:34 -0700
X-CSE-ConnectionGUID: H7xFvF40TNKoUTvBAnuqEg==
X-CSE-MsgGUID: YsvNVlbrSqe99UIfvuQpaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="187893452"
Received: from geumanao-mobl3.amr.corp.intel.com (HELO [10.245.86.244]) ([10.245.86.244])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 03:33:31 -0700
Message-ID: <1499278a-bc89-4c63-a6d3-54b3a7f87626@linux.intel.com>
Date: Mon, 14 Jul 2025 12:33:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Support user space allocated buffer
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com,
 mario.limonciello@amd.com
References: <20250707193813.880281-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20250707193813.880281-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

This looks very interesting. It's a clever way of adding userptr on top of existing gem code.

On 7/7/2025 9:38 PM, Lizhi Hou wrote:
> Enhance DRM_IOCTL_AMDXDNA_CREATE_BO to accept user space allocated
> buffer pointer. The buffer pages will be pinned in memory. Unless
> the CAP_IPC_LOCK is enabled for the application process, the total
> pinned memory can not beyond rlimit_memlock.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>  drivers/accel/amdxdna/Makefile       |   1 +
>  drivers/accel/amdxdna/amdxdna_gem.c  | 139 +++++++++++++---
>  drivers/accel/amdxdna/amdxdna_ubuf.c | 232 +++++++++++++++++++++++++++
>  drivers/accel/amdxdna/amdxdna_ubuf.h |  19 +++
>  include/uapi/drm/amdxdna_accel.h     |  25 +++
>  5 files changed, 391 insertions(+), 25 deletions(-)
>  create mode 100644 drivers/accel/amdxdna/amdxdna_ubuf.c
>  create mode 100644 drivers/accel/amdxdna/amdxdna_ubuf.h
> 
> diff --git a/drivers/accel/amdxdna/Makefile b/drivers/accel/amdxdna/Makefile
> index 0e9adf6890a0..6797dac65efa 100644
> --- a/drivers/accel/amdxdna/Makefile
> +++ b/drivers/accel/amdxdna/Makefile
> @@ -15,6 +15,7 @@ amdxdna-y := \
>  	amdxdna_mailbox_helper.o \
>  	amdxdna_pci_drv.o \
>  	amdxdna_sysfs.o \
> +	amdxdna_ubuf.o \
>  	npu1_regs.o \
>  	npu2_regs.o \
>  	npu4_regs.o \
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 0f85a0105178..d407a36eb412 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -18,6 +18,7 @@
>  #include "amdxdna_ctx.h"
>  #include "amdxdna_gem.h"
>  #include "amdxdna_pci_drv.h"
> +#include "amdxdna_ubuf.h"
>  
>  #define XDNA_MAX_CMD_BO_SIZE	SZ_32K
>  
> @@ -296,7 +297,7 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
>  
>  	vma->vm_private_data = NULL;
>  	vma->vm_ops = NULL;
> -	ret = dma_buf_mmap(to_gobj(abo)->dma_buf, vma, 0);
> +	ret = dma_buf_mmap(abo->dma_buf, vma, 0);
>  	if (ret) {
>  		XDNA_ERR(xdna, "Failed to mmap dma buf %d", ret);
>  		return ret;
> @@ -391,10 +392,47 @@ static const struct dma_buf_ops amdxdna_dmabuf_ops = {
>  	.vunmap = drm_gem_dmabuf_vunmap,
>  };
>  
> +static int amdxdna_gem_obj_vmap(struct drm_gem_object *obj, struct iosys_map *map)
> +{
> +	struct amdxdna_gem_obj *abo = to_xdna_obj(obj);
> +
> +	iosys_map_clear(map);
> +
> +	dma_resv_assert_held(obj->resv);
> +
> +	if (is_import_bo(abo))
> +		dma_buf_vmap(abo->dma_buf, map);
> +	else
> +		drm_gem_shmem_object_vmap(obj, map);
> +
> +	if (!map->vaddr)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void amdxdna_gem_obj_vunmap(struct drm_gem_object *obj, struct iosys_map *map)
> +{
> +	struct amdxdna_gem_obj *abo = to_xdna_obj(obj);
> +
> +	dma_resv_assert_held(obj->resv);
> +
> +	if (is_import_bo(abo))
> +		dma_buf_vunmap(abo->dma_buf, map);
> +	else
> +		drm_gem_shmem_object_vunmap(obj, map);
> +}
> +
>  static struct dma_buf *amdxdna_gem_prime_export(struct drm_gem_object *gobj, int flags)
>  {
> +	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
>  	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>  
> +	if (abo->dma_buf) {
> +		get_dma_buf(abo->dma_buf);
> +		return abo->dma_buf;
> +	}
> +
>  	exp_info.ops = &amdxdna_dmabuf_ops;
>  	exp_info.size = gobj->size;
>  	exp_info.flags = flags;
> @@ -451,8 +489,8 @@ static const struct drm_gem_object_funcs amdxdna_gem_shmem_funcs = {
>  	.pin = drm_gem_shmem_object_pin,
>  	.unpin = drm_gem_shmem_object_unpin,
>  	.get_sg_table = drm_gem_shmem_object_get_sg_table,
> -	.vmap = drm_gem_shmem_object_vmap,
> -	.vunmap = drm_gem_shmem_object_vunmap,
> +	.vmap = amdxdna_gem_obj_vmap,
> +	.vunmap = amdxdna_gem_obj_vunmap,
>  	.mmap = amdxdna_gem_obj_mmap,
>  	.vm_ops = &drm_gem_shmem_vm_ops,
>  	.export = amdxdna_gem_prime_export,
> @@ -494,6 +532,68 @@ amdxdna_gem_create_object_cb(struct drm_device *dev, size_t size)
>  	return to_gobj(abo);
>  }
>  
> +static struct amdxdna_gem_obj *
> +amdxdna_gem_create_shmem_object(struct drm_device *dev, size_t size)
> +{
> +	struct drm_gem_shmem_object *shmem = drm_gem_shmem_create(dev, size);
> +
> +	if (IS_ERR(shmem))
> +		return ERR_CAST(shmem);
> +
> +	shmem->map_wc = false;
> +	return to_xdna_obj(&shmem->base);
> +}
> +
> +static struct amdxdna_gem_obj *
> +amdxdna_gem_create_ubuf_object(struct drm_device *dev, struct amdxdna_drm_create_bo *args)
> +{
> +	struct amdxdna_dev *xdna = to_xdna_dev(dev);
> +	enum amdxdna_ubuf_flag flags = 0;
> +	struct amdxdna_drm_va_tbl va_tbl;
> +	struct drm_gem_object *gobj;
> +	struct dma_buf *dma_buf;
> +
> +	if (copy_from_user(&va_tbl, u64_to_user_ptr(args->vaddr), sizeof(va_tbl))) {
> +		XDNA_DBG(xdna, "Access va table failed");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (va_tbl.num_entries) {
> +		if (args->type == AMDXDNA_BO_CMD)
> +			flags |= AMDXDNA_UBUF_FLAG_MAP_DMA;
Does it make sense to create a ubuf without AMDXDNA_UBUF_FLAG_MAP_DMA?
Seems like without dma_map, the buffer cannot be used by the device.

> +
> +		dma_buf = amdxdna_get_ubuf(dev, flags, va_tbl.num_entries,
> +					   u64_to_user_ptr(args->vaddr + sizeof(va_tbl)));
> +	} else {
> +		dma_buf = dma_buf_get(va_tbl.dmabuf_fd);
> +	}
> +
> +	if (IS_ERR(dma_buf))
> +		return ERR_CAST(dma_buf);
> +
> +	gobj = amdxdna_gem_prime_import(dev, dma_buf);
> +	if (IS_ERR(gobj)) {
> +		dma_buf_put(dma_buf);
> +		return ERR_CAST(gobj);
> +	}
> +
> +	dma_buf_put(dma_buf);
> +
> +	return to_xdna_obj(gobj);
> +}
> +
> +static struct amdxdna_gem_obj *
> +amdxdna_gem_create_object(struct drm_device *dev,
> +			  struct amdxdna_drm_create_bo *args)
> +{
> +	size_t aligned_sz = PAGE_ALIGN(args->size);
> +
> +	if (args->vaddr)
> +		return amdxdna_gem_create_ubuf_object(dev, args);
> +
> +	return amdxdna_gem_create_shmem_object(dev, aligned_sz);
> +}
> +
>  struct drm_gem_object *
>  amdxdna_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf)
>  {
> @@ -545,16 +645,12 @@ amdxdna_drm_alloc_shmem(struct drm_device *dev,
>  			struct drm_file *filp)
>  {
>  	struct amdxdna_client *client = filp->driver_priv;
> -	struct drm_gem_shmem_object *shmem;
>  	struct amdxdna_gem_obj *abo;
>  
> -	shmem = drm_gem_shmem_create(dev, args->size);
> -	if (IS_ERR(shmem))
> -		return ERR_CAST(shmem);
> -
> -	shmem->map_wc = false;
> +	abo = amdxdna_gem_create_object(dev, args);
> +	if (IS_ERR(abo))
> +		return ERR_CAST(abo);
>  
> -	abo = to_xdna_obj(&shmem->base);
>  	abo->client = client;
>  	abo->type = AMDXDNA_BO_SHMEM;
>  
> @@ -569,7 +665,6 @@ amdxdna_drm_create_dev_heap(struct drm_device *dev,
>  	struct amdxdna_client *client = filp->driver_priv;
>  	struct iosys_map map = IOSYS_MAP_INIT_VADDR(NULL);
>  	struct amdxdna_dev *xdna = to_xdna_dev(dev);
> -	struct drm_gem_shmem_object *shmem;
>  	struct amdxdna_gem_obj *abo;
>  	int ret;
>  
> @@ -586,14 +681,12 @@ amdxdna_drm_create_dev_heap(struct drm_device *dev,
>  		goto mm_unlock;
>  	}
>  
> -	shmem = drm_gem_shmem_create(dev, args->size);
> -	if (IS_ERR(shmem)) {
> -		ret = PTR_ERR(shmem);
> +	abo = amdxdna_gem_create_object(dev, args);
> +	if (IS_ERR(abo)) {
> +		ret = PTR_ERR(abo);
>  		goto mm_unlock;
>  	}
>  
> -	shmem->map_wc = false;
> -	abo = to_xdna_obj(&shmem->base);
>  	abo->type = AMDXDNA_BO_DEV_HEAP;
>  	abo->client = client;
>  	abo->mem.dev_addr = client->xdna->dev_info->dev_mem_base;
> @@ -657,7 +750,6 @@ amdxdna_drm_create_cmd_bo(struct drm_device *dev,
>  {
>  	struct iosys_map map = IOSYS_MAP_INIT_VADDR(NULL);
>  	struct amdxdna_dev *xdna = to_xdna_dev(dev);
> -	struct drm_gem_shmem_object *shmem;
>  	struct amdxdna_gem_obj *abo;
>  	int ret;
>  
> @@ -671,12 +763,9 @@ amdxdna_drm_create_cmd_bo(struct drm_device *dev,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	shmem = drm_gem_shmem_create(dev, args->size);
> -	if (IS_ERR(shmem))
> -		return ERR_CAST(shmem);
> -
> -	shmem->map_wc = false;
> -	abo = to_xdna_obj(&shmem->base);
> +	abo = amdxdna_gem_create_object(dev, args);
> +	if (IS_ERR(abo))
> +		return ERR_CAST(abo);
>  
>  	abo->type = AMDXDNA_BO_CMD;
>  	abo->client = filp->driver_priv;
> @@ -691,7 +780,7 @@ amdxdna_drm_create_cmd_bo(struct drm_device *dev,
>  	return abo;
>  
>  release_obj:
> -	drm_gem_shmem_free(shmem);
> +	drm_gem_object_put(to_gobj(abo));
>  	return ERR_PTR(ret);
>  }
>  
> @@ -702,7 +791,7 @@ int amdxdna_drm_create_bo_ioctl(struct drm_device *dev, void *data, struct drm_f
>  	struct amdxdna_gem_obj *abo;
>  	int ret;
>  
> -	if (args->flags || args->vaddr || !args->size)
> +	if (args->flags)
>  		return -EINVAL;
>  
>  	XDNA_DBG(xdna, "BO arg type %d vaddr 0x%llx size 0x%llx flags 0x%llx",
> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
> new file mode 100644
> index 000000000000..c19167ecd963
> --- /dev/null
> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025, Advanced Micro Devices, Inc.
> + */
> +
> +#include <drm/amdxdna_accel.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_print.h>
> +#include <linux/dma-buf.h>
> +#include <linux/pagemap.h>
> +#include <linux/vmalloc.h>
> +
> +#include "amdxdna_pci_drv.h"
> +#include "amdxdna_ubuf.h"
> +
> +struct amdxdna_ubuf_priv {
> +	struct page **pages;
> +	u64 nr_pages;
> +	enum amdxdna_ubuf_flag flags;
> +	struct mm_struct *mm;
> +};
> +
> +static struct sg_table *amdxdna_ubuf_map(struct dma_buf_attachment *attach,
> +					 enum dma_data_direction direction)
> +{
> +	struct amdxdna_ubuf_priv *ubuf = attach->dmabuf->priv;
> +	struct sg_table *sg;
> +	int ret;
> +
> +	sg = kzalloc(sizeof(*sg), GFP_KERNEL);
> +	if (!sg)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = sg_alloc_table_from_pages(sg, ubuf->pages, ubuf->nr_pages, 0,
> +					ubuf->nr_pages << PAGE_SHIFT, GFP_KERNEL);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	if (ubuf->flags & AMDXDNA_UBUF_FLAG_MAP_DMA) {
> +		ret = dma_map_sgtable(attach->dev, sg, direction, 0);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
> +	return sg;
> +}
> +
> +static void amdxdna_ubuf_unmap(struct dma_buf_attachment *attach,
> +			       struct sg_table *sg,
> +			       enum dma_data_direction direction)
> +{
> +	struct amdxdna_ubuf_priv *ubuf = attach->dmabuf->priv;
> +
> +	if (ubuf->flags & AMDXDNA_UBUF_FLAG_MAP_DMA)
> +		dma_unmap_sgtable(attach->dev, sg, direction, 0);
> +
> +	sg_free_table(sg);
> +	kfree(sg);
> +}
> +
> +static void amdxdna_ubuf_release(struct dma_buf *dbuf)
> +{
> +	struct amdxdna_ubuf_priv *ubuf = dbuf->priv;
> +
> +	unpin_user_pages(ubuf->pages, ubuf->nr_pages);
> +	kvfree(ubuf->pages);
> +	atomic64_sub(ubuf->nr_pages, &ubuf->mm->pinned_vm);
> +	mmdrop(ubuf->mm);
> +	kfree(ubuf);
> +}
> +
> +static vm_fault_t amdxdna_ubuf_vm_fault(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct amdxdna_ubuf_priv *ubuf;
> +	unsigned long pfn;
> +	pgoff_t pgoff;
> +
> +	ubuf = vma->vm_private_data;
> +	pgoff = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
> +
> +	pfn = page_to_pfn(ubuf->pages[pgoff]);
> +	return vmf_insert_pfn(vma, vmf->address, pfn);
> +}
> +
> +static const struct vm_operations_struct amdxdna_ubuf_vm_ops = {
> +	.fault = amdxdna_ubuf_vm_fault,
> +};
> +
> +static int amdxdna_ubuf_mmap(struct dma_buf *dbuf, struct vm_area_struct *vma)
> +{
> +	struct amdxdna_ubuf_priv *ubuf = dbuf->priv;
> +
> +	vma->vm_ops = &amdxdna_ubuf_vm_ops;
> +	vma->vm_private_data = ubuf;
> +	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> +
> +	return 0;
> +}
> +
> +static int amdxdna_ubuf_vmap(struct dma_buf *dbuf, struct iosys_map *map)
> +{
> +	struct amdxdna_ubuf_priv *ubuf = dbuf->priv;
> +	void *kva;
> +
> +	kva = vmap(ubuf->pages, ubuf->nr_pages, VM_MAP, PAGE_KERNEL);
> +	if (!kva)
> +		return -EINVAL;
> +
> +	iosys_map_set_vaddr(map, kva);
> +	return 0;
> +}
> +
> +static void amdxdna_ubuf_vunmap(struct dma_buf *dbuf, struct iosys_map *map)
> +{
> +	vunmap(map->vaddr);
> +}
> +
> +static const struct dma_buf_ops amdxdna_ubuf_dmabuf_ops = {
> +	.map_dma_buf = amdxdna_ubuf_map,
> +	.unmap_dma_buf = amdxdna_ubuf_unmap,
> +	.release = amdxdna_ubuf_release,
> +	.mmap = amdxdna_ubuf_mmap,
Why mmap user memory? You will end up with two user space virtual addresses.

> +	.vmap = amdxdna_ubuf_vmap,
> +	.vunmap = amdxdna_ubuf_vunmap,
> +};
> +
> +struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
> +				 enum amdxdna_ubuf_flag flags,
> +				 u32 num_entries, void __user *va_entries)
> +{
> +	struct amdxdna_dev *xdna = to_xdna_dev(dev);
> +	unsigned long lock_limit, new_pinned;
> +	struct amdxdna_drm_va_entry *va_ent;
> +	struct amdxdna_ubuf_priv *ubuf;
> +	u32 npages, start = 0;
> +	struct dma_buf *dbuf;
> +	int i, ret;
> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +
> +	if (!can_do_mlock())
> +		return ERR_PTR(-EPERM);
> +
> +	ubuf = kzalloc(sizeof(*ubuf), GFP_KERNEL);
> +	if (!ubuf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ubuf->flags = flags;
> +	ubuf->mm = current->mm;
> +	mmgrab(ubuf->mm);
> +
> +	va_ent = kvcalloc(num_entries, sizeof(*va_ent), GFP_KERNEL);
> +	if (!va_ent) {
> +		ret = -ENOMEM;
> +		goto free_ubuf;
> +	}
> +
> +	if (copy_from_user(va_ent, va_entries, sizeof(*va_ent) * num_entries)) {
> +		XDNA_DBG(xdna, "Access va entries failed");
> +		ret = -EINVAL;
> +		goto free_ent;
> +	}
> +
> +	for (i = 0, exp_info.size = 0; i < num_entries; i++) {
> +		if ((va_ent[i].vaddr & (PAGE_SIZE - 1)) ||
> +		    (va_ent[i].len & (PAGE_SIZE - 1))) {
I would use IS_ALIGNED(x, PAGE_SIZE) for readability.

> +			XDNA_ERR(xdna, "Invalid address or len %llx, %llx",
> +				 va_ent[i].vaddr, va_ent[i].len);
> +			ret = -EINVAL;
> +			goto free_ent;
> +		}
> +
> +		exp_info.size += va_ent[i].len;
> +	}
> +
> +	ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
> +	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +	new_pinned = atomic64_add_return(ubuf->nr_pages, &ubuf->mm->pinned_vm);
> +	if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
> +		XDNA_DBG(xdna, "New pin %ld, limit %ld, cap %d",
> +			 new_pinned, lock_limit, capable(CAP_IPC_LOCK));
> +		ret = -ENOMEM;
> +		goto sub_pin_cnt;
> +	}
> +
> +	ubuf->pages = kvmalloc_array(ubuf->nr_pages, sizeof(*ubuf->pages), GFP_KERNEL);
> +	if (!ubuf->pages) {
> +		ret = -ENOMEM;
> +		goto sub_pin_cnt;
> +	}
> +
> +	for (i = 0; i < num_entries; i++) {
> +		npages = va_ent[i].len >> PAGE_SHIFT;
> +
> +		ret = pin_user_pages_fast(va_ent[i].vaddr, npages,
> +					  FOLL_WRITE | FOLL_LONGTERM,
> +					  &ubuf->pages[start]);
> +		if (ret < 0 || ret != npages) {
> +			ret = -ENOMEM;
> +			XDNA_ERR(xdna, "Failed to pin pages ret %d", ret);
> +			goto destroy_pages;
> +		}
> +
> +		start += ret;
> +	}
> +
> +	exp_info.ops = &amdxdna_ubuf_dmabuf_ops;
> +	exp_info.priv = ubuf;
> +	exp_info.flags = O_RDWR;
I would consider adding O_CLOEXEC.

> +
> +	dbuf = dma_buf_export(&exp_info);
> +	if (IS_ERR(dbuf)) {
> +		ret = PTR_ERR(dbuf);
> +		goto destroy_pages;
> +	}
> +	kvfree(va_ent);
> +
> +	return dbuf;
> +
> +destroy_pages:
> +	if (start)
> +		unpin_user_pages(ubuf->pages, start);
> +	kvfree(ubuf->pages);
> +sub_pin_cnt:
> +	atomic64_sub(ubuf->nr_pages, &ubuf->mm->pinned_vm);
> +free_ent:
> +	kvfree(va_ent);
> +free_ubuf:
> +	mmdrop(ubuf->mm);
> +	kfree(ubuf);
> +	return ERR_PTR(ret);
> +}
> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.h b/drivers/accel/amdxdna/amdxdna_ubuf.h
> new file mode 100644
> index 000000000000..e5cb3bdb3ec9
> --- /dev/null
> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2025, Advanced Micro Devices, Inc.
> + */
> +#ifndef _AMDXDNA_UBUF_H_
> +#define _AMDXDNA_UBUF_H_
> +
> +#include <drm/drm_device.h>
> +#include <linux/dma-buf.h>
> +
> +enum amdxdna_ubuf_flag {
> +	AMDXDNA_UBUF_FLAG_MAP_DMA = 1,
> +};
> +
> +struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
> +				 enum amdxdna_ubuf_flag flags,
> +				 u32 num_entries, void __user *va_entries);
> +
> +#endif /* _AMDXDNA_UBUF_H_ */
> diff --git a/include/uapi/drm/amdxdna_accel.h b/include/uapi/drm/amdxdna_accel.h
> index a706ead39082..ce523e9ccc52 100644
> --- a/include/uapi/drm/amdxdna_accel.h
> +++ b/include/uapi/drm/amdxdna_accel.h
> @@ -153,6 +153,31 @@ enum amdxdna_bo_type {
>  	AMDXDNA_BO_CMD,
>  };
>  
> +/**
> + * struct amdxdna_drm_va_entry
> + * @vaddr: Virtual address.
> + * @len: Size of entry.
> + */
> +struct amdxdna_drm_va_entry {
> +	__u64 vaddr;
> +	__u64 len;
> +};
> +
> +/**
> + * struct amdxdna_drm_va_tbl
> + * @dmabuf_fd: The fd of dmabuf.
> + * @num_entries: Number of va entries.
> + * @va_entries: Array of va entries.
> + *
> + * The input can be either a dmabuf fd or a virtual address entry table.
> + * When dmabuf_fd is used, num_entries must be zero.
> + */
> +struct amdxdna_drm_va_tbl {
> +	__s32 dmabuf_fd;
Isn't this already implemented by drm_prime_fd_to_handle_ioctl?

> +	__u32 num_entries;
> +	struct amdxdna_drm_va_entry va_entries[];
> +};
> +
>  /**
>   * struct amdxdna_drm_create_bo - Create a buffer object.
>   * @flags: Buffer flags. MBZ.

Regards,
Jacek

