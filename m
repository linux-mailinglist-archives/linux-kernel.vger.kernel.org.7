Return-Path: <linux-kernel+bounces-888016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB15C3995A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05E344E1E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AACA302141;
	Thu,  6 Nov 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oaACdWU1"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1427301709;
	Thu,  6 Nov 2025 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762417710; cv=none; b=asWJ+R6brfKGGjbGvRpLjhvTJ5/Jn7u8HVCnnA3iZjxD6wBVhcNMIeVDApED2I6MMnrkVYvA2XQiaZBBqS/HWhLKusKsaKnxWPaapKwjz3C7j/D97UQ0rfiThnLsPskPzOlgd2p+TPpBhnq9lBciOOk6e3+5xlsBKJyheCAjyGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762417710; c=relaxed/simple;
	bh=pVgfYk4/hjf8v16hm1avg00MTUjmZ/jX7QzVe0yu1M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghAM7i5Cn0g5QxiBFgMaGqXyYtKGK6iJ7ceAX0W5+CCgZEpxQgrFjtQdBc9jbF1e/ubfpq+GltSMbFfHtjkX70ulzO9msOGy8rwIhbrwnwBYh3VL7e8yROBM+3KpiZPO2zInSfqirRKrb7pPE64vrP/cB+Amg64GUEFoVH3Ifjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=oaACdWU1; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WwUoGTNmbk4GL2R/z8jgKT7x4qoL8qPfVciTM25oRN4=; b=oaACdWU11vzx7y9yl+WQ7YyetM
	aoDWzy+EKCf1wJQvAgAUOGwGawC75YrhbT7KaMu0Vc49ukacvQeSVxo3+h8EnpRfMSQ3VA1r2D3iM
	fLuSkbX8cni9zYAHuflPh1YTWVsY1bF1kYQVQri4E1+KMOPb49SQ/C/524oD0vr1dPAYfYokC4iIw
	MBIwiyRpuE5ZFALUA05JXrv2gm2I739cxXzA0nv4gjwOsimS/73pe87c42sFK0/wNTjoS9pQSt6l1
	g1L1YWEuVAd2B0qPzBMw2dLJYGqVddYrCaaJhz3xm+B67gPY1eAjmasMdyi3qKuDQ9vA+JNhMdiwU
	ydoU65GA==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vGvLt-002sf6-3a; Thu, 06 Nov 2025 09:28:17 +0100
Message-ID: <f935574c-67d1-4a7c-bd8e-e9dff7aa97ea@igalia.com>
Date: Thu, 6 Nov 2025 08:28:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Fix @alloc_flags description
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>,
 Linux Intel Graphics <intel-gfx@lists.freedesktop.org>
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui
 <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Zack Rusin <zack.rusin@broadcom.com>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20251106005217.14026-1-bagasdotme@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20251106005217.14026-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06/11/2025 00:52, Bagas Sanjaya wrote:
> Stephen Rothwell reports htmldocs warnings when merging drm-misc tree:
> 
> Documentation/gpu/drm-mm:40: include/drm/ttm/ttm_device.h:225: ERROR: Unknown target name: "ttm_allocation". [docutils]
> Documentation/gpu/drm-mm:43: drivers/gpu/drm/ttm/ttm_device.c:202: ERROR: Unknown target name: "ttm_allocation". [docutils]
> Documentation/gpu/drm-mm:73: include/drm/ttm/ttm_pool.h:68: ERROR: Unknown target name: "ttm_allocation_pool". [docutils]
> Documentation/gpu/drm-mm:76: drivers/gpu/drm/ttm/ttm_pool.c:1070: ERROR: Unknown target name: "ttm_allocation_pool". [docutils]
> 
> Fix these by adding missing wildcard on TTM_ALLOCATION_* and
> TTM_ALLOCATION_POOL_* in @alloc_flags description.

Interesting, I did not realize it would see special meaning in text 
followed by underscore. Thanks for fixing it up!

Acked-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

I assume no one merged it yet to any branch so I can push it to 
drm-misc-next?

Regards,

Tvrtko

> Fixes: 0af5b6a8f8dd ("drm/ttm: Replace multiple booleans with flags in pool init")
> Fixes: 77e19f8d3297 ("drm/ttm: Replace multiple booleans with flags in device init")
> Fixes: 402b3a865090 ("drm/ttm: Add an allocation flag to propagate -ENOSPC on OOM")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20251105161838.55b962a3@canb.auug.org.au/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>   drivers/gpu/drm/ttm/ttm_device.c | 2 +-
>   drivers/gpu/drm/ttm/ttm_pool.c   | 2 +-
>   include/drm/ttm/ttm_device.h     | 2 +-
>   include/drm/ttm/ttm_pool.h       | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
> index 5c10e5fbf43b7f..9a51afaf0749e2 100644
> --- a/drivers/gpu/drm/ttm/ttm_device.c
> +++ b/drivers/gpu/drm/ttm/ttm_device.c
> @@ -199,7 +199,7 @@ EXPORT_SYMBOL(ttm_device_swapout);
>    * @dev: The core kernel device pointer for DMA mappings and allocations.
>    * @mapping: The address space to use for this bo.
>    * @vma_manager: A pointer to a vma manager.
> - * @alloc_flags: TTM_ALLOCATION_ flags.
> + * @alloc_flags: TTM_ALLOCATION_* flags.
>    *
>    * Initializes a struct ttm_device:
>    * Returns:
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 97e9ce505cf68d..18b6db015619c0 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -1067,7 +1067,7 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
>    * @pool: the pool to initialize
>    * @dev: device for DMA allocations and mappings
>    * @nid: NUMA node to use for allocations
> - * @alloc_flags: TTM_ALLOCATION_POOL_ flags
> + * @alloc_flags: TTM_ALLOCATION_POOL_* flags
>    *
>    * Initialize the pool and its pool types.
>    */
> diff --git a/include/drm/ttm/ttm_device.h b/include/drm/ttm/ttm_device.h
> index d016360e5cebbc..5618aef462f21b 100644
> --- a/include/drm/ttm/ttm_device.h
> +++ b/include/drm/ttm/ttm_device.h
> @@ -221,7 +221,7 @@ struct ttm_device {
>   	struct list_head device_list;
>   
>   	/**
> -	 * @alloc_flags: TTM_ALLOCATION_ flags.
> +	 * @alloc_flags: TTM_ALLOCATION_* flags.
>   	 */
>   	unsigned int alloc_flags;
>   
> diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
> index 67c72de913bb9d..233581670e7825 100644
> --- a/include/drm/ttm/ttm_pool.h
> +++ b/include/drm/ttm/ttm_pool.h
> @@ -64,7 +64,7 @@ struct ttm_pool_type {
>    *
>    * @dev: the device we allocate pages for
>    * @nid: which numa node to use
> - * @alloc_flags: TTM_ALLOCATION_POOL_ flags
> + * @alloc_flags: TTM_ALLOCATION_POOL_* flags
>    * @caching: pools for each caching/order
>    */
>   struct ttm_pool {
> 
> base-commit: c553832116b8d0039b13ae84d1ed06e7ee4f1fdf


