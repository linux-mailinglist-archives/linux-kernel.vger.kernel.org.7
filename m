Return-Path: <linux-kernel+bounces-840141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A711BB3ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCABF19C1E8E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183E030B531;
	Thu,  2 Oct 2025 10:41:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAE22D839C
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759401704; cv=none; b=i0risPko1oo67Wld4FJrVMYvm9kX+4hUpWT/qajijvTYscakeZlhNDe49JUB06JfvJzPYiwYIxNArvFDFLKtomw4nirZuPIMe6AVGO1/DL+T4DDFYy5dRiTI+ONiurVeJEwVkow5Q3X2AAo9CXY/3Zw+P3bmiczprQl2EuMxWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759401704; c=relaxed/simple;
	bh=0AZ3P8KDPNdeFITDZIhVU5Ni3wfTmMbeNZFIexs0sJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OhELcGnUACMVRhO9EHi2VcQuPYJYY1kVXGJmglem4Xm+RnlL31zV5QJ6l907jUz7vmk5KBT8HerK5EaIaoYyeEapr9n99bSw1F2yCylJoflp6QofyNIQP4LZvNohUUW64Nf/zvHaVLlzOax6RcYIIbjAWXk4HXOzq1F/VaU5py8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 702B11692;
	Thu,  2 Oct 2025 03:41:34 -0700 (PDT)
Received: from [10.57.2.240] (unknown [10.57.2.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0AA53F66E;
	Thu,  2 Oct 2025 03:41:38 -0700 (PDT)
Message-ID: <504751cf-9ffe-47e5-bdb0-5cdb8e65ee5f@arm.com>
Date: Thu, 2 Oct 2025 11:41:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] drm/panthor: remove write_cmd
To: Chia-I Wu <olvaffe@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250916210823.4033529-1-olvaffe@gmail.com>
 <20250916210823.4033529-7-olvaffe@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250916210823.4033529-7-olvaffe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/09/2025 22:08, Chia-I Wu wrote:
> Call mmu_hw_wait_ready explicitly instead.

You're missing the why here again. I can see the intention from the
following patch is to remove some "wait ready" calls that you think are
unnecessary. But you need to put that in the description of this patch.

Otherwise reviewing this patch on it's own it clearly makes the code worse.

Thanks,
Steve

> 
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 46 +++++++++++++++------------
>  1 file changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 7d1645a24129d..373871aeea9f4 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -533,18 +533,6 @@ static int mmu_hw_wait_ready(struct panthor_device *ptdev, u32 as_nr)
>  	return ret;
>  }
>  
> -static int write_cmd(struct panthor_device *ptdev, u32 as_nr, u32 cmd)
> -{
> -	int status;
> -
> -	/* write AS_COMMAND when MMU is ready to accept another command */
> -	status = mmu_hw_wait_ready(ptdev, as_nr);
> -	if (!status)
> -		gpu_write(ptdev, AS_COMMAND(as_nr), cmd);
> -
> -	return status;
> -}
> -
>  /**
>   * mmu_hw_cmd_update() - Issue an UPDATE command
>   * @ptdev: Device.
> @@ -556,14 +544,14 @@ static int write_cmd(struct panthor_device *ptdev, u32 as_nr, u32 cmd)
>   * Issue an UPDATE command to invalidate MMU caches and update the translation
>   * table.
>   */
> -static int mmu_hw_cmd_update(struct panthor_device *ptdev, u32 as_nr, u64 transtab, u64 transcfg,
> -			     u64 memattr)
> +static void mmu_hw_cmd_update(struct panthor_device *ptdev, u32 as_nr, u64 transtab, u64 transcfg,
> +			      u64 memattr)
>  {
>  	gpu_write64(ptdev, AS_TRANSTAB(as_nr), transtab);
>  	gpu_write64(ptdev, AS_MEMATTR(as_nr), memattr);
>  	gpu_write64(ptdev, AS_TRANSCFG(as_nr), transcfg);
>  
> -	return write_cmd(ptdev, as_nr, AS_COMMAND_UPDATE);
> +	gpu_write(ptdev, AS_COMMAND(as_nr), AS_COMMAND_UPDATE);
>  }
>  
>  /**
> @@ -606,7 +594,7 @@ static void mmu_hw_cmd_lock(struct panthor_device *ptdev, u32 as_nr, u64 region_
>  
>  	/* Lock the region that needs to be updated */
>  	gpu_write64(ptdev, AS_LOCKADDR(as_nr), region);
> -	write_cmd(ptdev, as_nr, AS_COMMAND_LOCK);
> +	gpu_write(ptdev, AS_COMMAND(as_nr), AS_COMMAND_LOCK);
>  }
>  
>  /**
> @@ -619,7 +607,7 @@ static void mmu_hw_cmd_lock(struct panthor_device *ptdev, u32 as_nr, u64 region_
>   */
>  static void mmu_hw_cmd_unlock(struct panthor_device *ptdev, u32 as_nr)
>  {
> -	write_cmd(ptdev, as_nr, AS_COMMAND_UNLOCK);
> +	gpu_write(ptdev, AS_COMMAND(as_nr), AS_COMMAND_UNLOCK);
>  }
>  
>  /**
> @@ -664,7 +652,9 @@ static int mmu_hw_flush_caches(struct panthor_device *ptdev, int as_nr, u64 iova
>  	 * power it up
>  	 */
>  
> -	mmu_hw_cmd_lock(ptdev, as_nr, iova, size);
> +	ret = mmu_hw_wait_ready(ptdev, as_nr);
> +	if (!ret)
> +		mmu_hw_cmd_lock(ptdev, as_nr, iova, size);
>  
>  	ret = mmu_hw_wait_ready(ptdev, as_nr);
>  	if (ret)
> @@ -679,7 +669,9 @@ static int mmu_hw_flush_caches(struct panthor_device *ptdev, int as_nr, u64 iova
>  	 * at the end of the GPU_CONTROL cache flush command, unlike
>  	 * AS_COMMAND_FLUSH_MEM or AS_COMMAND_FLUSH_PT.
>  	 */
> -	mmu_hw_cmd_unlock(ptdev, as_nr);
> +	ret = mmu_hw_wait_ready(ptdev, as_nr);
> +	if (!ret)
> +		mmu_hw_cmd_unlock(ptdev, as_nr);
>  
>  	/* Wait for the unlock command to complete */
>  	return mmu_hw_wait_ready(ptdev, as_nr);
> @@ -707,7 +699,13 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
>  	if (ret)
>  		return ret;
>  
> -	return mmu_hw_cmd_update(ptdev, as_nr, transtab, transcfg, memattr);
> +	ret = mmu_hw_wait_ready(ptdev, as_nr);
> +	if (ret)
> +		return ret;
> +
> +	mmu_hw_cmd_update(ptdev, as_nr, transtab, transcfg, memattr);
> +
> +	return 0;
>  }
>  
>  static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
> @@ -718,7 +716,13 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
>  	if (ret)
>  		return ret;
>  
> -	return mmu_hw_cmd_update(ptdev, as_nr, 0, AS_TRANSCFG_ADRMODE_UNMAPPED, 0);
> +	ret = mmu_hw_wait_ready(ptdev, as_nr);
> +	if (ret)
> +		return ret;
> +
> +	mmu_hw_cmd_update(ptdev, as_nr, 0, AS_TRANSCFG_ADRMODE_UNMAPPED, 0);
> +
> +	return 0;
>  }
>  
>  static u32 panthor_mmu_fault_mask(struct panthor_device *ptdev, u32 value)


