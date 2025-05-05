Return-Path: <linux-kernel+bounces-632301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D440AA959F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 16:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F078167F78
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 14:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA76E259C85;
	Mon,  5 May 2025 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OmFc+L4H"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35AB846C
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455040; cv=none; b=ArmyavcZ7PWR9uZ9dDny2VFa5T6IYg/8+uoGnrDyGwIJ+3qZR4C39LafkjmNhIBv0o3xCNK5mEJD7jKVrYdTaqqDgpVFZ2KLh5VJc0EiJZwvkUNLUIf6h/J24JyXbW0Syxbu9OcR5MIE7c6hJHwlWHYfIg5FruQ4Kss+Yr61BWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455040; c=relaxed/simple;
	bh=z7dsfY2lM1SYdkcVryXiSRG0n+U92EFnmvQLFxE57sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFBAcQ4ILWmuV7MY8aNY7yc/YQ/e+7XRWMYfFrsVBx4gJQ4EBF9xhBLvjoS0H1PFr5UnX9xHL+POAWQ9mhAt8E1DRKSdPGTmekUc9JLr75mDTbV82ASIiOxKS0TMIPbkohYl6ybJey/Zi49QHyx3Kw1HyplU/+yTbi10PXkCGTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OmFc+L4H; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=3y/rMwTX7/q52MQT8W3rwgpcVh3Foflvbog5MQz9n0g=;
	b=OmFc+L4HoEYxoBsF6wnygtoYUbwLHIeKHfkYNv4jtJ0nlrCx6eZTJAbTC/u02f
	zKjD67G+EoazxT6TvxPwv7Pp4+BqUET7olojlO8aGm3BRZzvXumLTqjqshCw+7EJ
	uchm2e2qeQzNbQYNvlRzlqhvASGSYkeDYV2NuiQCU8Fjw=
Received: from [192.168.124.17] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wA3kieyyRhoQoOrEg--.36304S2;
	Mon, 05 May 2025 22:22:43 +0800 (CST)
Message-ID: <a681cfd8-0c8c-4ffe-9f42-f0e54ee2539d@163.com>
Date: Mon, 5 May 2025 22:22:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/shmem-helper: Import dmabuf without mapping its
 sg_table
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sean Paul <sean@poorly.run>,
 Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
References: <20250501064324.398650-1-oushixiong1025@163.com>
 <71ec7bd1-be90-462e-8a07-e56fccae4096@suse.de>
 <8e4f60ec-caa8-431a-88f8-aee8183d96e5@amd.com>
From: oushixiong <oushixiong1025@163.com>
In-Reply-To: <8e4f60ec-caa8-431a-88f8-aee8183d96e5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3kieyyRhoQoOrEg--.36304S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw1ftrWxZF43AF4xWr1Dtrb_yoW3Kw1rpF
	s8AFWUKrW5tryqgrZ7ZF1vva4Ygw48Kr1Iqry3J3yY9F1ktFnFyF1Fkr98uFW7AryUGr1F
	qr1UCFWfGryYyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UOa9-UUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbBYxBED2gYnjclMAABs1

Hi Christian,

My patch is based on linux-next, so this patch is not based on the 
latest code. Then, I'd like to ask which patch resolved the issue with 
sg-tables?


Thanks and Regards,

Shixiong.


在 2025/5/5 19:25, Christian König 写道:
> Hi Thomas & Shixiong,
>
> first of all the patch is still based on outdated code. For example the cache_sgt_mapping member is already removed in drm-misc-next.
>
> So if I'm not completely mistaken the issue is already resolved upstream.
>
> Regards,
> Christian.
>
> On 5/5/25 13:12, Thomas Zimmermann wrote:
>> (cc'ing Christian)
>>
>> Hi,
>>
>> I don't feel qualified to fully review this patch.
>>
>> It would be good to have the issue with sg-tables solved, but I dislike the dedicated initializer macros. So my question is if this has any drawbacks. Or could we make this available and the default for all shmem-based drivers?
>>
>> Best regards
>> Thomas
>>
>> Am 01.05.25 um 08:43 schrieb oushixiong1025@163.com:
>>> From: Shixiong Ou <oushixiong@kylinos.cn>
>>>
>>> [WHY]
>>> 1. Drivers using DRM_GEM_SHADOW_PLANE_HELPER_FUNCS and
>>>      DRM_GEM_SHMEM_DRIVER_OPS (e.g., udl, ast) do not require
>>>      sg_table import.
>>>      They only need dma_buf_vmap() to access the shared buffer's
>>>      kernel virtual address.
>>>
>>> 2. On certain Aspeed-based boards, a dma_mask of 0xffff_ffff may
>>>      trigger SWIOTLB during dmabuf import. However, IO_TLB_SEGSIZE
>>>      restricts the maximum DMA streaming mapping memory, resulting in
>>>      errors like:
>>>
>>>      ast 0000:07:00.0: swiotlb buffer is full (sz: 3145728 bytes), total 32768 (slots), used 0 (slots)
>>>
>>> [HOW]
>>> Provide a gem_prime_import implementation without sg_table mapping
>>> to avoid issues (e.g., "swiotlb buffer is full"). Drivers that do not
>>> require sg_table can adopt this.
>>>
>>> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
>>> ---
>>>    drivers/gpu/drm/drm_gem_shmem_helper.c | 95 ++++++++++++++++++++++++++
>>>    include/drm/drm_gem_shmem_helper.h     | 24 +++++++
>>>    2 files changed, 119 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> index d99dee67353a..9e41e350ff6f 100644
>>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> @@ -39,6 +39,7 @@ MODULE_IMPORT_NS("DMA_BUF");
>>>    static const struct drm_gem_object_funcs drm_gem_shmem_funcs = {
>>>        .free = drm_gem_shmem_object_free,
>>>        .print_info = drm_gem_shmem_object_print_info,
>>> +    .export = drm_gem_shmem_object_prime_export,
>>>        .pin = drm_gem_shmem_object_pin,
>>>        .unpin = drm_gem_shmem_object_unpin,
>>>        .get_sg_table = drm_gem_shmem_object_get_sg_table,
>>> @@ -799,6 +800,100 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device *dev,
>>>    }
>>>    EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_import_sg_table);
>>>    +const struct dma_buf_ops drm_gem_shmem_prime_dmabuf_ops =  {
>>> +    .cache_sgt_mapping = true,
>>> +    .attach = drm_gem_map_attach,
>>> +    .detach = drm_gem_map_detach,
>>> +    .map_dma_buf = drm_gem_map_dma_buf,
>>> +    .unmap_dma_buf = drm_gem_unmap_dma_buf,
>>> +    .release = drm_gem_dmabuf_release,
>>> +    .mmap = drm_gem_dmabuf_mmap,
>>> +    .vmap = drm_gem_dmabuf_vmap,
>>> +    .vunmap = drm_gem_dmabuf_vunmap,
>>> +};
>>> +
>>> +/**
>>> + * drm_gem_shmem_prime_export - implementation of the export callback
>>> + * @shmem: shmem GEM object
>>> + */
>>> +struct dma_buf *drm_gem_shmem_prime_export(struct drm_gem_shmem_object *shmem,
>>> +                       int flags)
>>> +{
>>> +    struct drm_gem_object *obj = &shmem->base;
>>> +    struct drm_device *dev = obj->dev;
>>> +    struct dma_buf_export_info exp_info = {
>>> +        .exp_name = KBUILD_MODNAME, /* white lie for debug */
>>> +        .owner = dev->driver->fops->owner,
>>> +        .ops = &drm_gem_shmem_prime_dmabuf_ops,
>>> +        .size = obj->size,
>>> +        .flags = flags,
>>> +        .priv = obj,
>>> +        .resv = obj->resv,
>>> +    };
>>> +
>>> +    return drm_gem_dmabuf_export(dev, &exp_info);
>>> +}
>>> +
>>> +/**
>>> + * drm_gem_shmem_prime_import - Import dmabuf without mapping its sg_table
>>> + * @dev: Device to import into
>>> + * @dma_buf: dma-buf object to import
>>> + *
>>> + * Drivers that use the shmem helpers but also wants to import dmabuf without
>>> + * mapping its sg_table can use this as their &drm_driver.gem_prime_import
>>> + * implementation.
>>> + */
>>> +struct drm_gem_object *drm_gem_shmem_prime_import(struct drm_device *dev,
>>> +                          struct dma_buf *dma_buf)
>>> +{
>>> +    struct dma_buf_attachment *attach;
>>> +    struct drm_gem_shmem_object *shmem;
>>> +    size_t size;
>>> +    int ret;
>>> +
>>> +    if (dma_buf->ops == &drm_gem_shmem_prime_dmabuf_ops) {
>>> +        struct drm_gem_object *obj;
>>> +
>>> +        obj = dma_buf->priv;
>>> +        if (obj->dev == dev) {
>>> +            /*
>>> +             * Importing dmabuf exported from our own gem increases
>>> +             * refcount on gem itself instead of f_count of dmabuf.
>>> +             */
>>> +            drm_gem_object_get(obj);
>>> +            return obj;
>>> +        }
>>> +    }
>>> +
>>> +    attach = dma_buf_attach(dma_buf, dev->dev);
>>> +    if (IS_ERR(attach))
>>> +        return ERR_CAST(attach);
>>> +
>>> +    get_dma_buf(dma_buf);
>>> +
>>> +    size = PAGE_ALIGN(attach->dmabuf->size);
>>> +
>>> +    shmem = __drm_gem_shmem_create(dev, size, true, NULL);
>>> +    if (IS_ERR(shmem)) {
>>> +        ret = PTR_ERR(shmem);
>>> +        goto fail_detach;
>>> +    }
>>> +
>>> +    drm_dbg_prime(dev, "size = %zu\n", size);
>>> +
>>> +    shmem->base.import_attach = attach;
>>> +    shmem->base.resv = dma_buf->resv;
>>> +
>>> +    return &shmem->base;
>>> +
>>> +fail_detach:
>>> +    dma_buf_detach(dma_buf, attach);
>>> +    dma_buf_put(dma_buf);
>>> +
>>> +    return ERR_PTR(ret);
>>> +}
>>> +EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_import);
>>> +
>>>    MODULE_DESCRIPTION("DRM SHMEM memory-management helpers");
>>>    MODULE_IMPORT_NS("DMA_BUF");
>>>    MODULE_LICENSE("GPL v2");
>>> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
>>> index cef5a6b5a4d6..78ef91593a8e 100644
>>> --- a/include/drm/drm_gem_shmem_helper.h
>>> +++ b/include/drm/drm_gem_shmem_helper.h
>>> @@ -110,6 +110,8 @@ int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem,
>>>    void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem,
>>>                  struct iosys_map *map);
>>>    int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct *vma);
>>> +struct dma_buf *drm_gem_shmem_prime_export(struct drm_gem_shmem_object *shmem,
>>> +                          int flags);
>>>      int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem);
>>>    void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem);
>>> @@ -168,6 +170,18 @@ static inline void drm_gem_shmem_object_print_info(struct drm_printer *p, unsign
>>>        drm_gem_shmem_print_info(shmem, p, indent);
>>>    }
>>>    +/**
>>> + * drm_gem_shmem_object_prime_export - GEM object function for export()
>>> + * @obj: GEM object
>>> + *
>>> + */
>>> +static inline struct dma_buf *drm_gem_shmem_object_prime_export(struct drm_gem_object *obj,
>>> +                                int flags)
>>> +{
>>> +    struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
>>> +
>>> +    return drm_gem_shmem_prime_export(shmem, flags);
>>> +}
>>>    /**
>>>     * drm_gem_shmem_object_pin - GEM object function for drm_gem_shmem_pin()
>>>     * @obj: GEM object
>>> @@ -276,6 +290,8 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device *dev,
>>>                        struct sg_table *sgt);
>>>    int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
>>>                      struct drm_mode_create_dumb *args);
>>> +struct drm_gem_object *drm_gem_shmem_prime_import(struct drm_device *dev,
>>> +                          struct dma_buf *buf);
>>>      /**
>>>     * DRM_GEM_SHMEM_DRIVER_OPS - Default shmem GEM operations
>>> @@ -287,4 +303,12 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
>>>        .gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table, \
>>>        .dumb_create           = drm_gem_shmem_dumb_create
>>>    +/**
>>> + * This macro provides a shmem GEM operations that implementate a simple
>>> + * gem_prime_import.
>>> + */
>>> +#define DRM_GEM_SHMEM_SIMPLE_DRIVER_OPS \
>>> +    .gem_prime_import    = drm_gem_shmem_prime_import, \
>>> +    .dumb_create        = drm_gem_shmem_dumb_create
>>> +
>>>    #endif /* __DRM_GEM_SHMEM_HELPER_H__ */


