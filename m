Return-Path: <linux-kernel+bounces-898908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36705C56490
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3016342558
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907CA3314D1;
	Thu, 13 Nov 2025 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="WfB+OxT6"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CCB3161A6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022731; cv=none; b=UTYLaZuVyncmbOgxUJxH8O9ocyH7kEagwdKZj0RJZWaQXKqRG8mDziAK0XMzb3jLpZOu1KWP8i27FpXAvpVchjGd3fy/19z5hAym/hLEcMcNGu1ui+XTYhCyxkIY+devUGql2soYzX9lvXGz32U6e7gorGRIbhqdBB2BJOzxZDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022731; c=relaxed/simple;
	bh=OgWNIIefK/Bxavg1P3orFpWhUAM1C6ft9JTiD9//q5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IE5vnrYXMHrRq+pt5bBbtCZ/7jZ6RqaJZPKmbngPA2Dz/BDLlnXBhQuZt8LuGNPX2B3qti10mUBd8vCUNJpuD9G+DtkRzkU1fKBy3x8OklWTjFQqGoMdLBDXUrlZPoOwUkqBV2z1mJJhannRVttiYUbPI/iUWPuhzOBFGRPES6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=WfB+OxT6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso294418f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1763022727; x=1763627527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfukhjueqtZooUC/G//3QoUA+cHzS0R+6tZVZXxzXXs=;
        b=WfB+OxT6ySJHJXUWUam8Jye/GVtJq9tFJaR71dmPzhpYHtI65O7vFSK3lvh/dDt1Lm
         9xC5775pgewO9RC+hs0JUKq4O1EUCH422un2t8z48roMyLinob5ZZhCblo09GKSJ7RGy
         MvgY3IAehhDG9WxCB9WqxcV/tkytQ6IIV4klzo/JpeP2fEI10WTvpcEP/gTLx1xHBThH
         RgMocWn6TxPybBno0b7Le2DlYi5Pw3dOoC4qy/zM/EbDGIYQhC53ZD6r7ncLhnONV5Nh
         yNk/7u8CR5UG9lAdG3Lfz38rBoXDGuhg12Wqm8sR19evxm65+LYlzR2tvSJz0dHvg6or
         lJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763022727; x=1763627527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfukhjueqtZooUC/G//3QoUA+cHzS0R+6tZVZXxzXXs=;
        b=XLaPD1FYUN5rvwrEyPbOrBSVYiBB3L1xyEC8EfXUGZvOPtxtpy4MfVp8ZmWRpK5hbv
         bKndNs5q8lefwY9vNJBJ2yTDhpj17gLCAwOcfrYYYmpTbc8SjsiTfTI1Kl4Y5gTJCd8Z
         jaPAzGKhsGuyxzw9FSvfssUYQrH5ki438rrDEmwy5gqyCElIIwZOWmfYyh4YMDw3GgQb
         Z1h4q7PaqVcnBVJXw3TB7aFlDxQwZJX7vlTYTSIp9qmnniwMJtGaGVSO51xrMNBTEO/c
         m9jfdTPfWZj7mzDb7d1SVFlOCBzJGvDnbEJ8BecG9q7Aw07yVEZu+AhkAUw0Zm80WKIE
         AIjA==
X-Gm-Message-State: AOJu0YyUUs2F070HhUbOaWipkiCF2cHx1jFtHkuu44ut/XG1m4Ol9Id/
	StowPGtkLk8ZdKFbzp9L0w/DETv5mqj1oXMYDm2n2BVWgUcR83ZW/CvtjwtiORjPFXw=
X-Gm-Gg: ASbGncsU1cp+GQ5csI93/nAsSIZfSIlIM48YvglA8qbDI/Mjr9Dc4kB2X6qzQwnTrTb
	WtalDSvPafKVU9qMWpd3jgIxCRKGAGP3panNxuvssGumV3YeDsC/0e8ev75dhF24up7wHVxR+sd
	OR0/GWRtqHjbHffZ2boKfGZnfRRMPonlkWrRchH7Ae948OU1hEBxGQo8m8UsIZJl9D9L33vJHIW
	YojZf1+Uq+DRGL+5gabz5W8oDsMwiw11RWQunlYQ2JuiJo6/aH5xps0WLgzwGNU61h0gyzcWexF
	xr2B556BI59kNGSDYO7LzZVgJoywLvJtbR3+SMQA/dWJBSSDj7OTSsS8kUemlZlNa0luUt76Cnd
	KCnMZYosN+XoTWxDDQIu880GWV7tTaJg48fRst6ESH6dePoXN7VCzG9I/2MT+eJmmMy64RwrXTO
	E/p4axtOBTTWaDkQdTqr8fLC5KA5RCIt7L
X-Google-Smtp-Source: AGHT+IH0c2l5RRE+V35m+0cvDUuaufSmqRTK85FmE16+vXzvxBENUBvWli2MnoVwwrZQ3zZ9MhCvfw==
X-Received: by 2002:a05:6000:401e:b0:42b:3dbe:3a54 with SMTP id ffacd0b85a97d-42b4bb98aa5mr4746433f8f.17.1763022727108;
        Thu, 13 Nov 2025 00:32:07 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85cc0sm2715644f8f.17.2025.11.13.00.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 00:32:06 -0800 (PST)
Message-ID: <4a311b00-9d69-4f0f-8b82-5f6b7c4c9a9f@ursulin.net>
Date: Thu, 13 Nov 2025 08:32:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/11] drm/i915: Use huge tmpfs mountpoint helpers
To: =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
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
References: <20251110155000.2936-1-loic.molinari@collabora.com>
 <20251110155000.2936-6-loic.molinari@collabora.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251110155000.2936-6-loic.molinari@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/11/2025 15:49, Loïc Molinari wrote:
> Make use of the new drm_gem_huge_mnt_create() and
> drm_gem_has_huge_mnt() helpers to avoid code duplication. Now that
> it's just a few lines long, the single function in i915_gemfs.c is
> moved into v3d_gem_shmem.c.
> 
> v3:
> - use huge tmpfs mountpoint in drm_device
> - move i915_gemfs.c into i915_gem_shmem.c
> 
> v4:
> - clean up mountpoint creation error handling
> 
> v5:
> - use drm_gem_has_huge_mnt() helper
> 
> v7:
> - include <drm/drm_print.h> in i915_gem_shmem.c
> 
> Signed-off-by: Loïc Molinari <loic.molinari@collabora.com>
> ---
>   drivers/gpu/drm/i915/Makefile                 |  3 +-
>   drivers/gpu/drm/i915/gem/i915_gem_shmem.c     | 48 +++++++++----
>   drivers/gpu/drm/i915/gem/i915_gemfs.c         | 71 -------------------
>   drivers/gpu/drm/i915/gem/i915_gemfs.h         | 14 ----
>   .../gpu/drm/i915/gem/selftests/huge_pages.c   | 11 +--
>   drivers/gpu/drm/i915/i915_drv.h               |  5 --
>   6 files changed, 42 insertions(+), 110 deletions(-)
>   delete mode 100644 drivers/gpu/drm/i915/gem/i915_gemfs.c
>   delete mode 100644 drivers/gpu/drm/i915/gem/i915_gemfs.h
> 
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> index 84ec79b64960..b5a8c0a6b747 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -169,8 +169,7 @@ gem-y += \
>   	gem/i915_gem_ttm_move.o \
>   	gem/i915_gem_ttm_pm.o \
>   	gem/i915_gem_userptr.o \
> -	gem/i915_gem_wait.o \
> -	gem/i915_gemfs.o
> +	gem/i915_gem_wait.o
>   i915-y += \
>   	$(gem-y) \
>   	i915_active.o \
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> index 26dda55a07ff..9bba6f8cdee2 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -9,14 +9,16 @@
>   #include <linux/uio.h>
>   
>   #include <drm/drm_cache.h>
> +#include <drm/drm_gem.h>
> +#include <drm/drm_print.h>
>   
>   #include "gem/i915_gem_region.h"
>   #include "i915_drv.h"
>   #include "i915_gem_object.h"
>   #include "i915_gem_tiling.h"
> -#include "i915_gemfs.h"
>   #include "i915_scatterlist.h"
>   #include "i915_trace.h"
> +#include "i915_utils.h"
>   
>   /*
>    * Move folios to appropriate lru and release the batch, decrementing the
> @@ -515,9 +517,9 @@ static int __create_shmem(struct drm_i915_private *i915,
>   	if (BITS_PER_LONG == 64 && size > MAX_LFS_FILESIZE)
>   		return -E2BIG;
>   
> -	if (i915->mm.gemfs)
> -		filp = shmem_file_setup_with_mnt(i915->mm.gemfs, "i915", size,
> -						 flags);
> +	if (drm_gem_has_huge_mnt(&i915->drm))
> +		filp = shmem_file_setup_with_mnt(i915->drm.huge_mnt, "i915",
> +						 size, flags);
>   	else
>   		filp = shmem_file_setup("i915", size, flags);
>   	if (IS_ERR(filp))
> @@ -644,21 +646,41 @@ i915_gem_object_create_shmem_from_data(struct drm_i915_private *i915,
>   
>   static int init_shmem(struct intel_memory_region *mem)
>   {
> -	i915_gemfs_init(mem->i915);
> -	intel_memory_region_set_name(mem, "system");
> +	struct drm_i915_private *i915 = mem->i915;
> +	int err;
>   
> -	return 0; /* We have fallback to the kernel mnt if gemfs init failed. */
> -}
> +	/*
> +	 * By creating our own shmemfs mountpoint, we can pass in
> +	 * mount flags that better match our usecase.
> +	 *
> +	 * One example, although it is probably better with a per-file
> +	 * control, is selecting huge page allocations ("huge=within_size").
> +	 * However, we only do so on platforms which benefit from it, or to
> +	 * offset the overhead of iommu lookups, where with latter it is a net
> +	 * win even on platforms which would otherwise see some performance
> +	 * regressions such a slow reads issue on Broadwell and Skylake.
> +	 */
>   
> -static int release_shmem(struct intel_memory_region *mem)
> -{
> -	i915_gemfs_fini(mem->i915);
> -	return 0;
> +	if (GRAPHICS_VER(i915) < 11 && !i915_vtd_active(i915))
> +		goto no_thp;
> +
> +	err = drm_gem_huge_mnt_create(&i915->drm, "within_size");
> +	if (drm_gem_has_huge_mnt(&i915->drm))
> +		drm_info(&i915->drm, "Using Transparent Hugepages\n");
> +	else if (err)
> +		drm_notice(&i915->drm,
> +			   "Transparent Hugepage support is recommended for optimal performance%s\n",
> +			   GRAPHICS_VER(i915) >= 11 ? " on this platform!" :
> +						      " when IOMMU is enabled!");


Drm_gem_huge_mnt_create() will return 0, and drm_gem_has_huge_mnt() will 
return false.

So looking from the i915 perspective, when 
CONFIG_TRANSPARENT_HUGEPAGE=n, currently it will log the above notice 
message, and after the change it will not.

To preserve current behaviour it might be that "else if (err)" just 
needs to become a plan "else"?

Regards,

Tvrtko

> +
> + no_thp:
> +	intel_memory_region_set_name(mem, "system");
> +
> +	return 0; /* We have fallback to the kernel mnt if huge mnt failed. */
>   }
>   
>   static const struct intel_memory_region_ops shmem_region_ops = {
>   	.init = init_shmem,
> -	.release = release_shmem,
>   	.init_object = shmem_object_init,
>   };
>   
> diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.c b/drivers/gpu/drm/i915/gem/i915_gemfs.c
> deleted file mode 100644
> index 1f1290214031..000000000000
> --- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
> +++ /dev/null
> @@ -1,71 +0,0 @@
> -// SPDX-License-Identifier: MIT
> -/*
> - * Copyright © 2017 Intel Corporation
> - */
> -
> -#include <linux/fs.h>
> -#include <linux/mount.h>
> -#include <linux/fs_context.h>
> -
> -#include <drm/drm_print.h>
> -
> -#include "i915_drv.h"
> -#include "i915_gemfs.h"
> -#include "i915_utils.h"
> -
> -void i915_gemfs_init(struct drm_i915_private *i915)
> -{
> -	struct file_system_type *type;
> -	struct fs_context *fc;
> -	struct vfsmount *gemfs;
> -	int ret;
> -
> -	/*
> -	 * By creating our own shmemfs mountpoint, we can pass in
> -	 * mount flags that better match our usecase.
> -	 *
> -	 * One example, although it is probably better with a per-file
> -	 * control, is selecting huge page allocations ("huge=within_size").
> -	 * However, we only do so on platforms which benefit from it, or to
> -	 * offset the overhead of iommu lookups, where with latter it is a net
> -	 * win even on platforms which would otherwise see some performance
> -	 * regressions such a slow reads issue on Broadwell and Skylake.
> -	 */
> -
> -	if (GRAPHICS_VER(i915) < 11 && !i915_vtd_active(i915))
> -		return;
> -
> -	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> -		goto err;
> -
> -	type = get_fs_type("tmpfs");
> -	if (!type)
> -		goto err;
> -
> -	fc = fs_context_for_mount(type, SB_KERNMOUNT);
> -	if (IS_ERR(fc))
> -		goto err;
> -	ret = vfs_parse_fs_string(fc, "source", "tmpfs");
> -	if (!ret)
> -		ret = vfs_parse_fs_string(fc, "huge", "within_size");
> -	if (!ret)
> -		gemfs = fc_mount_longterm(fc);
> -	put_fs_context(fc);
> -	if (ret)
> -		goto err;
> -
> -	i915->mm.gemfs = gemfs;
> -	drm_info(&i915->drm, "Using Transparent Hugepages\n");
> -	return;
> -
> -err:
> -	drm_notice(&i915->drm,
> -		   "Transparent Hugepage support is recommended for optimal performance%s\n",
> -		   GRAPHICS_VER(i915) >= 11 ? " on this platform!" :
> -					      " when IOMMU is enabled!");
> -}
> -
> -void i915_gemfs_fini(struct drm_i915_private *i915)
> -{
> -	kern_unmount(i915->mm.gemfs);
> -}
> diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.h b/drivers/gpu/drm/i915/gem/i915_gemfs.h
> deleted file mode 100644
> index 16d4333c9a4e..000000000000
> --- a/drivers/gpu/drm/i915/gem/i915_gemfs.h
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -/* SPDX-License-Identifier: MIT */
> -/*
> - * Copyright © 2017 Intel Corporation
> - */
> -
> -#ifndef __I915_GEMFS_H__
> -#define __I915_GEMFS_H__
> -
> -struct drm_i915_private;
> -
> -void i915_gemfs_init(struct drm_i915_private *i915);
> -void i915_gemfs_fini(struct drm_i915_private *i915);
> -
> -#endif
> diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
> index bd08605a1611..2b9f7d86b46e 100644
> --- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
> +++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
> @@ -1316,7 +1316,7 @@ typedef struct drm_i915_gem_object *
>   
>   static inline bool igt_can_allocate_thp(struct drm_i915_private *i915)
>   {
> -	return i915->mm.gemfs && has_transparent_hugepage();
> +	return drm_gem_has_huge_mnt(&i915->drm);
>   }
>   
>   static struct drm_i915_gem_object *
> @@ -1761,7 +1761,8 @@ static int igt_tmpfs_fallback(void *arg)
>   	struct drm_i915_private *i915 = arg;
>   	struct i915_address_space *vm;
>   	struct i915_gem_context *ctx;
> -	struct vfsmount *gemfs = i915->mm.gemfs;
> +	struct vfsmount *huge_mnt =
> +		drm_gem_has_huge_mnt(&i915->drm) ? i915->drm.huge_mnt : NULL;
>   	struct drm_i915_gem_object *obj;
>   	struct i915_vma *vma;
>   	struct file *file;
> @@ -1782,10 +1783,10 @@ static int igt_tmpfs_fallback(void *arg)
>   	/*
>   	 * Make sure that we don't burst into a ball of flames upon falling back
>   	 * to tmpfs, which we rely on if on the off-chance we encounter a failure
> -	 * when setting up gemfs.
> +	 * when setting up a huge mountpoint.
>   	 */
>   
> -	i915->mm.gemfs = NULL;
> +	i915->drm.huge_mnt = NULL;
>   
>   	obj = i915_gem_object_create_shmem(i915, PAGE_SIZE);
>   	if (IS_ERR(obj)) {
> @@ -1819,7 +1820,7 @@ static int igt_tmpfs_fallback(void *arg)
>   out_put:
>   	i915_gem_object_put(obj);
>   out_restore:
> -	i915->mm.gemfs = gemfs;
> +	i915->drm.huge_mnt = huge_mnt;
>   
>   	i915_vm_put(vm);
>   out:
> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> index 95f9ddf22ce4..93a5af3de334 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -141,11 +141,6 @@ struct i915_gem_mm {
>   	 */
>   	atomic_t free_count;
>   
> -	/**
> -	 * tmpfs instance used for shmem backed objects
> -	 */
> -	struct vfsmount *gemfs;
> -
>   	struct intel_memory_region *regions[INTEL_REGION_UNKNOWN];
>   
>   	struct notifier_block oom_notifier;


