Return-Path: <linux-kernel+bounces-860735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AB7BF0D14
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63BAB4F39B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAE92D6E5B;
	Mon, 20 Oct 2025 11:24:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA9916A956
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959478; cv=none; b=jfqxPjKOd2WZaH9kGwolz1+GVSju5LewDI+0zvYIZ6ESYxEnYrzB0IF43zYRsvwMxXV1m0ohjZ7K3da9/Rm7PZcQh2CZzp7XT1wwGczKeYQX+sZ2FiB6VoPC3A5RQ8LS/dX5BUaKjEEj7CpbAR0MEYW1w6dHP+fYoWx4OpMHya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959478; c=relaxed/simple;
	bh=4TiLXkXix3uIbo/RVViAtwO7joO4h5VXO9MX6QVoPao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CeIOa9TXuyaPDUThumyHLftMjrpEIR8Cxsuv7DwUVHzw2VHvVJXjcwtgh8NZaOoLWJdVay2kSlQjpRgojzaKL51ip30SbYZjJZRnHpWVKEsqfM6HUd4yPkSt9funrp34AkqkGPbBUdzFHKGJF73/FvT5LnFXWpp3dwSZaxf6KQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C61E11063;
	Mon, 20 Oct 2025 04:24:27 -0700 (PDT)
Received: from [10.57.36.117] (unknown [10.57.36.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF72A3F66E;
	Mon, 20 Oct 2025 04:24:33 -0700 (PDT)
Message-ID: <7be294e2-e6fe-4c47-8bf3-507443e3b1d5@arm.com>
Date: Mon, 20 Oct 2025 12:24:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/10] drm/panthor: Implement soft and fast reset via
 PWR_CONTROL
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20251014094337.1009601-1-karunika.choo@arm.com>
 <20251014094337.1009601-8-karunika.choo@arm.com>
Content-Language: en-GB
From: Steven Price <steven.price@arm.com>
In-Reply-To: <20251014094337.1009601-8-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2025 10:43, Karunika Choo wrote:
> Add helpers to issue reset commands through the PWR_CONTROL interface
> and wait for reset completion using IRQ signaling. This enables support
> for both RESET_SOFT and RESET_FAST operations with timeout handling and
> status verification.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_pwr.c | 62 ++++++++++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_pwr.h |  2 +
>  2 files changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
> index 594181aba847..ecb278824d06 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
> @@ -3,6 +3,7 @@
>  
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
> +#include <linux/cleanup.h>
>  #include <linux/iopoll.h>
>  #include <linux/wait.h>
>  
> @@ -31,6 +32,8 @@
>  
>  #define PWR_RETRACT_TIMEOUT_US		2000
>  
> +#define PWR_RESET_TIMEOUT_MS		500
> +
>  /**
>   * struct panthor_pwr - PWR_CONTROL block management data.
>   */
> @@ -80,6 +83,42 @@ static void panthor_pwr_write_command(struct panthor_device *ptdev, u32 command,
>  	gpu_write(ptdev, PWR_COMMAND, command);
>  }
>  
> +static bool reset_irq_raised(struct panthor_device *ptdev)
> +{
> +	return gpu_read(ptdev, PWR_INT_RAWSTAT) & PWR_IRQ_RESET_COMPLETED;
> +}
> +
> +static bool reset_completed(struct panthor_device *ptdev)
> +{
> +	return (ptdev->pwr->pending_reqs & PWR_IRQ_RESET_COMPLETED);
> +}
> +
> +static int panthor_pwr_reset(struct panthor_device *ptdev, u32 reset_cmd)
> +{
> +	scoped_guard(spinlock_irqsave, &ptdev->pwr->reqs_lock) {
> +		if (!drm_WARN_ON(&ptdev->base, !reset_completed(ptdev))) {
> +			ptdev->pwr->pending_reqs |= PWR_IRQ_RESET_COMPLETED;
> +			gpu_write(ptdev, PWR_INT_CLEAR, PWR_IRQ_RESET_COMPLETED);
> +			panthor_pwr_write_command(ptdev, reset_cmd, 0);
> +		}

This would be easier to read as:

if (reset_completed(ptdev)) {
	....
} else {
	drm_WARN(&ptdev->base, 1, "Hey, we're already resetting?");
}

[Message modified to taste ;) ]

I'm also wondering if things would be easier to read if you switched
from reset_completed() to reset_pending(). Certainly here it's the
'pending' test you are trying to do.

> +	}
> +
> +	if (!wait_event_timeout(ptdev->pwr->reqs_acked, reset_completed(ptdev),
> +				msecs_to_jiffies(PWR_RESET_TIMEOUT_MS))) {
> +		guard(spinlock_irqsave)(&ptdev->pwr->reqs_lock);
> +
> +		if (!reset_completed(ptdev) && !reset_irq_raised(ptdev)) {
> +			drm_err(&ptdev->base, "RESET_%s timed out",
> +				reset_cmd == PWR_COMMAND_RESET_SOFT ? "SOFT" : "FAST");
> +			return -ETIMEDOUT;
> +		}
> +
> +		ptdev->pwr->pending_reqs &= ~PWR_IRQ_RESET_COMPLETED;
> +	}
> +
> +	return 0;
> +}
> +
>  static const char *get_domain_name(u8 domain)
>  {
>  	switch (domain) {
> @@ -407,9 +446,30 @@ int panthor_pwr_init(struct panthor_device *ptdev)
>  	return 0;
>  }
>  
> +int panthor_pwr_reset_fast(struct panthor_device *ptdev)
> +{
> +	if (!ptdev->pwr)
> +		return 0;
> +
> +	if (!(panthor_pwr_read_status(ptdev) & PWR_STATUS_ALLOW_FAST_RESET)) {
> +		drm_err(&ptdev->base, "RESET_SOFT not allowed");

Copy/paste mistake on the error message.

> +		return -EOPNOTSUPP;
> +	}
> +
> +	return panthor_pwr_reset(ptdev, PWR_COMMAND_RESET_FAST);
> +}

I can't actually find a caller of this function within the series.

> +
>  int panthor_pwr_reset_soft(struct panthor_device *ptdev)
>  {
> -	return 0;
> +	if (!ptdev->pwr)
> +		return 0;

When would this happen? Is this not a programming error?

Thanks,
Steve

> +
> +	if (!(panthor_pwr_read_status(ptdev) & PWR_STATUS_ALLOW_SOFT_RESET)) {
> +		drm_err(&ptdev->base, "RESET_SOFT not allowed");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return panthor_pwr_reset(ptdev, PWR_COMMAND_RESET_SOFT);
>  }
>  
>  int panthor_pwr_l2_power_off(struct panthor_device *ptdev)
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.h b/drivers/gpu/drm/panthor/panthor_pwr.h
> index a4042c125448..2301c26dab86 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.h
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.h
> @@ -10,6 +10,8 @@ void panthor_pwr_unplug(struct panthor_device *ptdev);
>  
>  int panthor_pwr_init(struct panthor_device *ptdev);
>  
> +int panthor_pwr_reset_fast(struct panthor_device *ptdev);
> +
>  int panthor_pwr_reset_soft(struct panthor_device *ptdev);
>  
>  int panthor_pwr_l2_power_on(struct panthor_device *ptdev);


