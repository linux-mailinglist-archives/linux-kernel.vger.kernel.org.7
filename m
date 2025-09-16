Return-Path: <linux-kernel+bounces-819186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9C7B59C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A74E7AEED8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C324371E8D;
	Tue, 16 Sep 2025 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZcT1ORf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF9919E992
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038125; cv=none; b=JRLllUlAJinmjxsue0qf6LvMJDCfJjBStDXxdg6JwXZjKr4fVrnIzkMqMWCcSMMOSBanxol/dAgvumOfP0rS89K8OTXZ9+BtNiaZWprIH+QMd9n6zutO9xp9S5P/si+wWiD96yQ14X8orMKU314/BF5zf0S99HCLxHAYKT6uEm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038125; c=relaxed/simple;
	bh=ejGimSrqJ4B5tkiLt5URRUekzamq8tqyslt/pMg8kOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYBTYdRW8m3RW+PzwBNTTZpdwtpvW5NlE9tZAibnWeDE0jrh36SLSQw+GNiaGUChaEp79WhmBcI3MSvyy22G3rZuIrGYBRi7e1CHoZmS6KLFaeSbB0qsvXB+s97I9uN5xG6WO2y60Jpk8yNUsUScMp5YzHapCarv20lAb8YRs0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZcT1ORf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758038124; x=1789574124;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ejGimSrqJ4B5tkiLt5URRUekzamq8tqyslt/pMg8kOw=;
  b=YZcT1ORfY6vRN8r692mTc/ferH2dczk1ORu721sI4Fp6xikli8pm0bTs
   i9ionXbvKE6SuulV5hCCvtrtVZEshettq0NDzYddj7xGsJeCPM2b5by3y
   7VCZQn1y6+BW5SnRRvR5JvHv6UFDeTqFtRTUkiKgqaZqDRRDqKUS4JBO6
   4cFUisDzTDHw0OadHc8PDWfEfeJr1YJp0FY/9TZOm0e3bowXf1octxcrB
   rzwwZ9hRT4xzv1+w9pIAuZ/xh/CvQ/pNuSSDjySGlQ2m3Omt60D8p5o1k
   oeM02I8/2LCl/u/YbKSHQWPEURN0HLlOnO+uFrkrbyIvQ84KzdEi6vpvQ
   g==;
X-CSE-ConnectionGUID: iPawiFcnRbuv6Th7ZHctQQ==
X-CSE-MsgGUID: RMmKf8Y1Sjq+6iRPCCl6EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64127064"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64127064"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 08:55:22 -0700
X-CSE-ConnectionGUID: sP87AbSOQQqivrWYBPa4tw==
X-CSE-MsgGUID: roSA1V6PQw+zPai7xl0ktg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="175757352"
Received: from mfalkows-mobl.ger.corp.intel.com (HELO [10.245.121.109]) ([10.245.121.109])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 08:55:18 -0700
Message-ID: <50380149-c9cd-4478-9fe0-93d95a1016af@linux.intel.com>
Date: Tue, 16 Sep 2025 17:55:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH V1] accel/amdxdna: Call dma_buf_vmap_unlocked() for
 imported object
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com,
 mario.limonciello@amd.com
References: <20250915161046.135243-1-lizhi.hou@amd.com>
Content-Language: en-US
From: "Falkowski, Maciej" <maciej.falkowski@linux.intel.com>
In-Reply-To: <20250915161046.135243-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/2025 6:10 PM, Lizhi Hou wrote:

> In amdxdna_gem_obj_vmap(), calling dma_buf_vmap() triggers a kernel
> warning if LOCKDEP is enabled. So for imported object, use
> dma_buf_vmap_unlocked(). Then, use drm_gem_vmap() for other objects.
> The similar change applies to vunmap code.
>
> Fixes: bd72d4acda10 ("accel/amdxdna: Support user space allocated buffer")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 38 +++++++++++------------------
>   1 file changed, 14 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index d407a36eb412..50950be189ae 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -392,35 +392,25 @@ static const struct dma_buf_ops amdxdna_dmabuf_ops = {
>   	.vunmap = drm_gem_dmabuf_vunmap,
>   };
>   
> -static int amdxdna_gem_obj_vmap(struct drm_gem_object *obj, struct iosys_map *map)
> +static int amdxdna_gem_obj_vmap(struct amdxdna_gem_obj *abo, struct iosys_map *map)
>   {
> -	struct amdxdna_gem_obj *abo = to_xdna_obj(obj);
> -
>   	iosys_map_clear(map);
>   
> -	dma_resv_assert_held(obj->resv);
> -
>   	if (is_import_bo(abo))
> -		dma_buf_vmap(abo->dma_buf, map);
> -	else
> -		drm_gem_shmem_object_vmap(obj, map);
> -
> -	if (!map->vaddr)
> -		return -ENOMEM;
> +		return dma_buf_vmap_unlocked(abo->dma_buf, map);
Hi,

The dma_buf_vmap_unlocked() will call iosys_map_clear at its start so that
in this case it will be called twice. Probably it will be optimize out, 
but maybe
its something to better omit.
>   
> -	return 0;
> +	return drm_gem_vmap(to_gobj(abo), map);
>   }
>   
> -static void amdxdna_gem_obj_vunmap(struct drm_gem_object *obj, struct iosys_map *map)
> +static void amdxdna_gem_obj_vunmap(struct amdxdna_gem_obj *abo, struct iosys_map *map)
>   {
> -	struct amdxdna_gem_obj *abo = to_xdna_obj(obj);
> -
> -	dma_resv_assert_held(obj->resv);
> +	if (iosys_map_is_null(map))
> +		return;
>   
>   	if (is_import_bo(abo))
> -		dma_buf_vunmap(abo->dma_buf, map);
> -	else
> -		drm_gem_shmem_object_vunmap(obj, map);
> +		return dma_buf_vunmap_unlocked(abo->dma_buf, map);
I do also wonder what is the convention here on clearing iosys_map when 
returning.
The function drm_gem_vunmap will clear the map for callers while the 
other not.
I think at least comment explaining the logic will be necessary.

Best regards,
Maciej

> +
> +	return drm_gem_vunmap(to_gobj(abo), map);
>   }
>   
>   static struct dma_buf *amdxdna_gem_prime_export(struct drm_gem_object *gobj, int flags)
> @@ -468,7 +458,7 @@ static void amdxdna_gem_obj_free(struct drm_gem_object *gobj)
>   	if (abo->type == AMDXDNA_BO_DEV_HEAP)
>   		drm_mm_takedown(&abo->mm);
>   
> -	drm_gem_vunmap(gobj, &map);
> +	amdxdna_gem_obj_vunmap(abo, &map);
>   	mutex_destroy(&abo->lock);
>   
>   	if (is_import_bo(abo)) {
> @@ -489,8 +479,8 @@ static const struct drm_gem_object_funcs amdxdna_gem_shmem_funcs = {
>   	.pin = drm_gem_shmem_object_pin,
>   	.unpin = drm_gem_shmem_object_unpin,
>   	.get_sg_table = drm_gem_shmem_object_get_sg_table,
> -	.vmap = amdxdna_gem_obj_vmap,
> -	.vunmap = amdxdna_gem_obj_vunmap,
> +	.vmap = drm_gem_shmem_object_vmap,
> +	.vunmap = drm_gem_shmem_object_vunmap,
>   	.mmap = amdxdna_gem_obj_mmap,
>   	.vm_ops = &drm_gem_shmem_vm_ops,
>   	.export = amdxdna_gem_prime_export,
> @@ -692,7 +682,7 @@ amdxdna_drm_create_dev_heap(struct drm_device *dev,
>   	abo->mem.dev_addr = client->xdna->dev_info->dev_mem_base;
>   	drm_mm_init(&abo->mm, abo->mem.dev_addr, abo->mem.size);
>   
> -	ret = drm_gem_vmap(to_gobj(abo), &map);
> +	ret = amdxdna_gem_obj_vmap(abo, &map);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Vmap heap bo failed, ret %d", ret);
>   		goto release_obj;
> @@ -770,7 +760,7 @@ amdxdna_drm_create_cmd_bo(struct drm_device *dev,
>   	abo->type = AMDXDNA_BO_CMD;
>   	abo->client = filp->driver_priv;
>   
> -	ret = drm_gem_vmap(to_gobj(abo), &map);
> +	ret = amdxdna_gem_obj_vmap(abo, &map);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Vmap cmd bo failed, ret %d", ret);
>   		goto release_obj;

