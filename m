Return-Path: <linux-kernel+bounces-883082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C98EAC2C736
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93ABC3B542C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B4D280338;
	Mon,  3 Nov 2025 14:39:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284BD26B75B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180794; cv=none; b=mdyL+UyY1mNTU+IMacgDbPGIwxjP6O5ZflN9o06sNVnMRq8Hwxwftk/mboXG43RbL1SKfi3N2kKROYuykIK4WzcJtzcBXUk2KSHn2wNopM3Co/CemODAKBRHkA0cY1pGr5SN/Jmgrvo5jLOop7C7SoMVr1OG98IqFker6XpS10o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180794; c=relaxed/simple;
	bh=CTsEAuV2mG5BjZ8hAOPQFrDaO3YHZE0wzaQCZUFxi4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XC8qDiSt1/j6INLzOP1+tvZSpCyJuCMM5Od429dz2Qi2JZ5iIrKv+BZGlkZq00hRZUF8VN11i0YSYwHLLWWx+EyX0ady5K1l+SYLKBKMPJONBHObCe2QgCXRg7tTZVkwp20fdr2TqJbMnngnJwkV6VAwjn3dLHS3ugx+s9FnbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF0E71D14
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:39:44 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 462543F694
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:39:52 -0800 (PST)
Date: Mon, 3 Nov 2025 14:39:39 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>,
	Grant Likely <grant.likely@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Fix race with suspend during unplug
Message-ID: <aQi-q-cWv2tzNX9F@e110455-lin.cambridge.arm.com>
References: <20251022103242.1083311-1-ketil.johnsen@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022103242.1083311-1-ketil.johnsen@arm.com>

On Wed, Oct 22, 2025 at 12:32:41PM +0200, Ketil Johnsen wrote:
> There is a race between panthor_device_unplug() and
> panthor_device_suspend() which can lead to IRQ handlers running on a
> powered down GPU. This is how it can happen:
> - unplug routine calls drm_dev_unplug()
> - panthor_device_suspend() can now execute, and will skip a lot of
>   important work because the device is currently marked as unplugged.
> - IRQs will remain active in this case and IRQ handlers can therefore
>   try to access a powered down GPU.
> 
> The fix is simply to take the PM ref in panthor_device_unplug() a
> little bit earlier, before drm_dev_unplug().
> 
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
> Fixes: 5fe909cae118a ("drm/panthor: Add the device logical block")

Pushed to drm-misc-next.

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 81df49880bd87..962a10e00848e 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -83,6 +83,8 @@ void panthor_device_unplug(struct panthor_device *ptdev)
>  		return;
>  	}
>  
> +	drm_WARN_ON(&ptdev->base, pm_runtime_get_sync(ptdev->base.dev) < 0);
> +
>  	/* Call drm_dev_unplug() so any access to HW blocks happening after
>  	 * that point get rejected.
>  	 */
> @@ -93,8 +95,6 @@ void panthor_device_unplug(struct panthor_device *ptdev)
>  	 */
>  	mutex_unlock(&ptdev->unplug.lock);
>  
> -	drm_WARN_ON(&ptdev->base, pm_runtime_get_sync(ptdev->base.dev) < 0);
> -
>  	/* Now, try to cleanly shutdown the GPU before the device resources
>  	 * get reclaimed.
>  	 */
> -- 
> 2.47.2
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

