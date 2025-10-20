Return-Path: <linux-kernel+bounces-861125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D135BF1D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50B864E7C97
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D2631DD82;
	Mon, 20 Oct 2025 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DTyneNx/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D043E31986F;
	Mon, 20 Oct 2025 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970460; cv=none; b=sJXOoylFwb3OmJ+pWDgXjk8GVB1BGNfwGcHPiAA0Fo9tC9rASie69M5IsKQQDU6N+K95rk2zsBAJZW5+PV1cU0u96cuVwluPlE+hgCDbvlS0FW8X+f7mMLwlFjJ1Tvqtr2Egz7AqCanbVXo0egar618uotAxf2QIW48IW9IAx0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970460; c=relaxed/simple;
	bh=Z+Jk2n3KQE2PXcZ2LSy+OKXke9czfkMyq1d/vRHQvWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOmmLSLBwgjeaBP0V687ogDIXFGc/ahVWC/O2hYTddLRWZkEVwx3wEtu/rdVoEq6E0hwLJnYVXmw8Jb5VcyUV/9Vg757Rsg6YPnNOo59doWzGszbaOIPHhY0F5Wednj5sViSFWh94xtUcH/ufVra/hY6kR9Vy3MIPBkAWTDZdo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DTyneNx/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760970455;
	bh=Z+Jk2n3KQE2PXcZ2LSy+OKXke9czfkMyq1d/vRHQvWM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DTyneNx/KHQy2qFPL/YkilQtY9GUGNh1gDJY1/46Wg8FGzsDPlqT2/gJbLtP57CcB
	 YVnXKSeevBpyNtg/oK3TyBGdh3pcZwpB/iY4lRccPGS07iCMVIpRF4wePE0GzDKa/u
	 LF8Sz5Yh6DGm3j+za8zBYh3+uvHLRTjI8M5dELv0TbwibS9+OnRbXKiKVTI6bnGHzF
	 uTI71zBNOw3o9pnGCzJ9v/2A6BuzBntcWmXu88irLOMaYcyDKEupPcnSeyMNA+bOT7
	 aJO42FEpScVdxPVeQuGgx3/4/ZOWBl9wvQu5Uh4uOieV9G9H8gNL96bRkkFHjW7zLc
	 o18mw5+r79iOw==
Received: from [IPV6:2a01:e0a:5e3:6100:7aed:fe0e:8590:cbaa] (unknown [IPv6:2a01:e0a:5e3:6100:7aed:fe0e:8590:cbaa])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E2CFC17E0E90;
	Mon, 20 Oct 2025 16:27:34 +0200 (CEST)
Message-ID: <85b2c930-54e3-4172-b46b-54bd408271ff@collabora.com>
Date: Mon, 20 Oct 2025 16:27:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/13] drm/v3d: Use huge tmpfs mount point helper
To: Tvrtko Ursulin <tursulin@ursulin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Melissa Wen <mwen@igalia.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, =?UTF-8?Q?Miko=C5=82aj_Wasiak?=
 <mikolaj.wasiak@intel.com>, Christian Brauner <brauner@kernel.org>,
 Nitin Gote <nitin.r.gote@intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Christopher Healy <healych@amazon.com>, Matthew Wilcox
 <willy@infradead.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, kernel@collabora.com
References: <20251015153018.43735-1-loic.molinari@collabora.com>
 <20251015153018.43735-8-loic.molinari@collabora.com>
 <0130b962-6cd7-4f2c-8fd0-809a21495e03@ursulin.net>
Content-Language: fr
From: =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>
Organization: Collabora Ltd
In-Reply-To: <0130b962-6cd7-4f2c-8fd0-809a21495e03@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/10/2025 11:33, Tvrtko Ursulin wrote:
> 
> On 15/10/2025 16:30, Loïc Molinari wrote:
>> Make use of the new drm_gem_huge_mnt_create() helper to avoid code
>> duplication. Now that it's just a few lines long, the single function
>> in v3d_gemfs.c is moved into v3d_gem.c.
>>
>> v3:
>> - use huge tmpfs mountpoint in drm_device
>> - move v3d_gemfs.c into v3d_gem.c
>>
>> v4:
>> - clean up mountpoint creation error handling
>>
>> Signed-off-by: Loïc Molinari <loic.molinari@collabora.com>
>> ---
>>   drivers/gpu/drm/v3d/Makefile    |  3 +-
>>   drivers/gpu/drm/v3d/v3d_bo.c    |  5 ++-
>>   drivers/gpu/drm/v3d/v3d_drv.c   |  2 +-
>>   drivers/gpu/drm/v3d/v3d_drv.h   | 11 +-----
>>   drivers/gpu/drm/v3d/v3d_gem.c   | 27 +++++++++++++--
>>   drivers/gpu/drm/v3d/v3d_gemfs.c | 60 ---------------------------------
>>   6 files changed, 30 insertions(+), 78 deletions(-)
>>   delete mode 100644 drivers/gpu/drm/v3d/v3d_gemfs.c
>>
>> diff --git a/drivers/gpu/drm/v3d/Makefile b/drivers/gpu/drm/v3d/Makefile
>> index fcf710926057..b7d673f1153b 100644
>> --- a/drivers/gpu/drm/v3d/Makefile
>> +++ b/drivers/gpu/drm/v3d/Makefile
>> @@ -13,8 +13,7 @@ v3d-y := \
>>       v3d_trace_points.o \
>>       v3d_sched.o \
>>       v3d_sysfs.o \
>> -    v3d_submit.o \
>> -    v3d_gemfs.o
>> +    v3d_submit.o
>>   v3d-$(CONFIG_DEBUG_FS) += v3d_debugfs.o
>> diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
>> index c41476ddde68..6b9909bfce82 100644
>> --- a/drivers/gpu/drm/v3d/v3d_bo.c
>> +++ b/drivers/gpu/drm/v3d/v3d_bo.c
>> @@ -112,7 +112,7 @@ v3d_bo_create_finish(struct drm_gem_object *obj)
>>       if (IS_ERR(sgt))
>>           return PTR_ERR(sgt);
>> -    if (!v3d->gemfs)
>> +    if (!obj->dev->huge_mnt)
> 
> Maybe it would be a good idea to add a helper for this check. Keeping 
> aligned with drm_gem_huge_mnt_create() something like 
> drm_gem_has_huge_mnt()? That would then hide the optional drm_device 
> struct member if you decide to go for that.

Sounds good. This would prevent cluttering code with ifdefs in drivers 
while still removing the huge_mnt field in drm_device in builds with 
CONFIG_TRANSPARENT_HUGEPAGE=n. I'll propose a new version doing so.

> 
>>           align = SZ_4K;
>>       else if (obj->size >= SZ_1M)
>>           align = SZ_1M;
>> @@ -148,12 +148,11 @@ struct v3d_bo *v3d_bo_create(struct drm_device 
>> *dev, struct drm_file *file_priv,
>>                    size_t unaligned_size)
>>   {
>>       struct drm_gem_shmem_object *shmem_obj;
>> -    struct v3d_dev *v3d = to_v3d_dev(dev);
>>       struct v3d_bo *bo;
>>       int ret;
>>       shmem_obj = drm_gem_shmem_create_with_mnt(dev, unaligned_size,
>> -                          v3d->gemfs);
>> +                          dev->huge_mnt);
> 
> Okay this one goes away by the end of the series.
> 
>>       if (IS_ERR(shmem_obj))
>>           return ERR_CAST(shmem_obj);
>>       bo = to_v3d_bo(&shmem_obj->base);
>> diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/ 
>> v3d_drv.c
>> index c5a3bbbc74c5..19ec0ea7f38e 100644
>> --- a/drivers/gpu/drm/v3d/v3d_drv.c
>> +++ b/drivers/gpu/drm/v3d/v3d_drv.c
>> @@ -106,7 +106,7 @@ static int v3d_get_param_ioctl(struct drm_device 
>> *dev, void *data,
>>           args->value = v3d->perfmon_info.max_counters;
>>           return 0;
>>       case DRM_V3D_PARAM_SUPPORTS_SUPER_PAGES:
>> -        args->value = !!v3d->gemfs;
>> +        args->value = !!dev->huge_mnt;
>>           return 0;
>>       case DRM_V3D_PARAM_GLOBAL_RESET_COUNTER:
>>           mutex_lock(&v3d->reset_lock);
>> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/ 
>> v3d_drv.h
>> index 1884686985b8..99a39329bb85 100644
>> --- a/drivers/gpu/drm/v3d/v3d_drv.h
>> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
>> @@ -158,11 +158,6 @@ struct v3d_dev {
>>       struct drm_mm mm;
>>       spinlock_t mm_lock;
>> -    /*
>> -     * tmpfs instance used for shmem backed objects
>> -     */
>> -    struct vfsmount *gemfs;
>> -
>>       struct work_struct overflow_mem_work;
>>       struct v3d_queue_state queue[V3D_MAX_QUEUES];
>> @@ -569,6 +564,7 @@ extern const struct dma_fence_ops v3d_fence_ops;
>>   struct dma_fence *v3d_fence_create(struct v3d_dev *v3d, enum 
>> v3d_queue q);
>>   /* v3d_gem.c */
>> +extern bool super_pages;
>>   int v3d_gem_init(struct drm_device *dev);
>>   void v3d_gem_destroy(struct drm_device *dev);
>>   void v3d_reset_sms(struct v3d_dev *v3d);
>> @@ -576,11 +572,6 @@ void v3d_reset(struct v3d_dev *v3d);
>>   void v3d_invalidate_caches(struct v3d_dev *v3d);
>>   void v3d_clean_caches(struct v3d_dev *v3d);
>> -/* v3d_gemfs.c */
>> -extern bool super_pages;
>> -void v3d_gemfs_init(struct v3d_dev *v3d);
>> -void v3d_gemfs_fini(struct v3d_dev *v3d);
>> -
>>   /* v3d_submit.c */
>>   void v3d_job_cleanup(struct v3d_job *job);
>>   void v3d_job_put(struct v3d_job *job);
>> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/ 
>> v3d_gem.c
>> index bb110d35f749..635ff0fabe7e 100644
>> --- a/drivers/gpu/drm/v3d/v3d_gem.c
>> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
>> @@ -258,6 +258,30 @@ v3d_invalidate_caches(struct v3d_dev *v3d)
>>       v3d_invalidate_slices(v3d, 0);
>>   }
>> +static void
>> +v3d_huge_mnt_init(struct v3d_dev *v3d)
>> +{
>> +    int err = 0;
>> +
>> +    /*
>> +     * By using a huge shmemfs mountpoint when the user wants to
>> +     * enable Super Pages, we can pass in mount flags that better
>> +     * match our usecase.
>> +     */
>> +
>> +    if (super_pages)
>> +        err = drm_gem_huge_mnt_create(&v3d->drm, "within_size");
> 
> If it is this patch that is creating the build failure then the two 
> should be squashed.
> 
> Then in "drm/v3d: Fix builds with CONFIG_TRANSPARENT_HUGEPAGE=n" this 
> ends up a bit ugly:
> 
> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>       if (super_pages)
> #endif
>           err = drm_gem_huge_mnt_create(&v3d->drm, "within_size");
> 
> Does this not work:
> 
>       if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && super_pages)
>           err = drm_gem_huge_mnt_create(&v3d->drm, "within_size");
> 
> ?

I've got a new version ready that does exactly that (after discussing 
with Boris).

> 
> Regards,
> 
> Tvrtko
> 
>> +
>> +    if (v3d->drm.huge_mnt)
>> +        drm_info(&v3d->drm, "Using Transparent Hugepages\n");
>> +    else if (err)
>> +        drm_warn(&v3d->drm, "Can't use Transparent Hugepages (%d)\n",
>> +             err);
>> +    else
>> +        drm_notice(&v3d->drm,
>> +               "Transparent Hugepage support is recommended for 
>> optimal performance on this platform!\n");
>> +}
>> +
>>   int
>>   v3d_gem_init(struct drm_device *dev)
>>   {
>> @@ -309,7 +333,7 @@ v3d_gem_init(struct drm_device *dev)
>>       v3d_init_hw_state(v3d);
>>       v3d_mmu_set_page_table(v3d);
>> -    v3d_gemfs_init(v3d);
>> +    v3d_huge_mnt_init(v3d);
>>       ret = v3d_sched_init(v3d);
>>       if (ret) {
>> @@ -329,7 +353,6 @@ v3d_gem_destroy(struct drm_device *dev)
>>       enum v3d_queue q;
>>       v3d_sched_fini(v3d);
>> -    v3d_gemfs_fini(v3d);
>>       /* Waiting for jobs to finish would need to be done before
>>        * unregistering V3D.
>> diff --git a/drivers/gpu/drm/v3d/v3d_gemfs.c b/drivers/gpu/drm/v3d/ 
>> v3d_gemfs.c
>> deleted file mode 100644
>> index c1a30166c099..000000000000
>> --- a/drivers/gpu/drm/v3d/v3d_gemfs.c
>> +++ /dev/null
>> @@ -1,60 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> -/* Copyright (C) 2024 Raspberry Pi */
>> -
>> -#include <linux/fs.h>
>> -#include <linux/mount.h>
>> -#include <linux/fs_context.h>
>> -
>> -#include "v3d_drv.h"
>> -
>> -void v3d_gemfs_init(struct v3d_dev *v3d)
>> -{
>> -    struct file_system_type *type;
>> -    struct fs_context *fc;
>> -    struct vfsmount *gemfs;
>> -    int ret;
>> -
>> -    /*
>> -     * By creating our own shmemfs mountpoint, we can pass in
>> -     * mount flags that better match our usecase. However, we
>> -     * only do so on platforms which benefit from it.
>> -     */
>> -    if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>> -        goto err;
>> -
>> -    /* The user doesn't want to enable Super Pages */
>> -    if (!super_pages)
>> -        goto err;
>> -
>> -    type = get_fs_type("tmpfs");
>> -    if (!type)
>> -        goto err;
>> -
>> -    fc = fs_context_for_mount(type, SB_KERNMOUNT);
>> -    if (IS_ERR(fc))
>> -        goto err;
>> -    ret = vfs_parse_fs_string(fc, "source", "tmpfs");
>> -    if (!ret)
>> -        ret = vfs_parse_fs_string(fc, "huge", "within_size");
>> -    if (!ret)
>> -        gemfs = fc_mount_longterm(fc);
>> -    put_fs_context(fc);
>> -    if (ret)
>> -        goto err;
>> -
>> -    v3d->gemfs = gemfs;
>> -    drm_info(&v3d->drm, "Using Transparent Hugepages\n");
>> -
>> -    return;
>> -
>> -err:
>> -    v3d->gemfs = NULL;
>> -    drm_notice(&v3d->drm,
>> -           "Transparent Hugepage support is recommended for optimal 
>> performance on this platform!\n");
>> -}
>> -
>> -void v3d_gemfs_fini(struct v3d_dev *v3d)
>> -{
>> -    if (v3d->gemfs)
>> -        kern_unmount(v3d->gemfs);
>> -}
> 


