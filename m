Return-Path: <linux-kernel+bounces-840139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92612BB3AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFE719C1DEE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90A330BBA6;
	Thu,  2 Oct 2025 10:41:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0AA30AD1B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759401698; cv=none; b=YxELSmAI1ou3XykMN/eIvY1UuQ8yaD88DCm9xKWWcPOIgtox9pticoy1f1IOPwMiXoA+qRlNCFnKm55yNSjcCwkzQ/s+X/aJdxokGisqivZ2dShBwSyFXrkYmf3eafxWiAHuv96j8WmG+S0Dp58m4zUA8zWGxMltqKIl5dRzAW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759401698; c=relaxed/simple;
	bh=5hwOy7NtlhUup/J0vjLplF7gUvRqOnxHWOoP+zffjtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X3zBWXL9rqN8XJN7P8R58VybmV9yTDiB2kWD+IQDLaEKOiDSi9tsKaeuqGr9T1RttFMGgjwpx8LEvEXh7AhWNdgeEjhX4ZIW7Vb7VDvKaWx6GY0tnDMLunJrb329FyL8yDVoBT47wds7NSoAWwDcB1YOTIr7I1aSGtz6oBROoaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B927C1A00;
	Thu,  2 Oct 2025 03:41:27 -0700 (PDT)
Received: from [10.57.2.240] (unknown [10.57.2.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71EC53F66E;
	Thu,  2 Oct 2025 03:41:33 -0700 (PDT)
Message-ID: <c4f100fe-88a5-4409-a728-6b296ce23877@arm.com>
Date: Thu, 2 Oct 2025 11:41:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] drm/panthor: add mmu_hw_cmd_update
To: Chia-I Wu <olvaffe@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250916210823.4033529-1-olvaffe@gmail.com>
 <20250916210823.4033529-5-olvaffe@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250916210823.4033529-5-olvaffe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/09/2025 22:08, Chia-I Wu wrote:
> Add a simple helper for the UPDATE command.

Why? There's only two call sites, so we're not saving much (indeed the
diffstat shows we've got over twice as many lines)...

> 
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 33 +++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 953348f9afdb8..727339d80d37e 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -545,6 +545,27 @@ static int write_cmd(struct panthor_device *ptdev, u32 as_nr, u32 cmd)
>  	return status;
>  }
>  
> +/**
> + * mmu_hw_cmd_update() - Issue an UPDATE command
> + * @ptdev: Device.
> + * @as_nr: AS to issue command to.
> + * @transtab: Addr of the translation table.
> + * @transcfg: Bitmask of AS_TRANSCFG_*.
> + * @memattr: Bitmask of AS_MEMATTR_*.
> + *
> + * Issue an UPDATE command to invalidate MMU caches and update the translation
> + * table.
> + */
> +static int mmu_hw_cmd_update(struct panthor_device *ptdev, u32 as_nr, u64 transtab, u64 transcfg,
> +			     u64 memattr)
> +{
> +	gpu_write64(ptdev, AS_TRANSTAB(as_nr), transtab);
> +	gpu_write64(ptdev, AS_MEMATTR(as_nr), memattr);
> +	gpu_write64(ptdev, AS_TRANSCFG(as_nr), transcfg);
> +
> +	return write_cmd(ptdev, as_nr, AS_COMMAND_UPDATE);
> +}
> +
>  /**
>   * mmu_hw_cmd_lock() - Issue a LOCK command
>   * @ptdev: Device.
> @@ -674,11 +695,7 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
>  	if (ret)
>  		return ret;
>  
> -	gpu_write64(ptdev, AS_TRANSTAB(as_nr), transtab);
> -	gpu_write64(ptdev, AS_MEMATTR(as_nr), memattr);
> -	gpu_write64(ptdev, AS_TRANSCFG(as_nr), transcfg);
> -
> -	return write_cmd(ptdev, as_nr, AS_COMMAND_UPDATE);
> +	return mmu_hw_cmd_update(ptdev, as_nr, transtab, transcfg, memattr);
>  }
>  
>  static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
> @@ -689,11 +706,7 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
>  	if (ret)
>  		return ret;
>  
> -	gpu_write64(ptdev, AS_TRANSTAB(as_nr), 0);
> -	gpu_write64(ptdev, AS_MEMATTR(as_nr), 0);
> -	gpu_write64(ptdev, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
> -
> -	return write_cmd(ptdev, as_nr, AS_COMMAND_UPDATE);
> +	return mmu_hw_cmd_update(ptdev, as_nr, 0, AS_TRANSCFG_ADRMODE_UNMAPPED, 0);

... and here in particular the code is less clear. It's no longer
obvious which registers we're writing 0 to.

Thanks,
Steve

>  }
>  
>  static u32 panthor_mmu_fault_mask(struct panthor_device *ptdev, u32 value)


