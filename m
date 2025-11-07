Return-Path: <linux-kernel+bounces-890184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB836C3F6B9
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F4A3A238C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB0A2E88A7;
	Fri,  7 Nov 2025 10:26:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3BF3043D6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511214; cv=none; b=nz1r6Mnj+MzZshtGB5ccUBG8SZpmoRlhy9kMjrMTf+9VWEQZ9e44WT/Y9/CG5ZU8Sbn9AWIxaMhqBWrEzANvJ9AB6UdhknEKBI9ChSNkrWNA4klKJO58ITq/PRuIvtSAt3409MQk/N0OA731tzFSPQnr1QAAwH53rP0zGAVqVW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511214; c=relaxed/simple;
	bh=VRJiIr8lUE9n27ypcw1Cscd9T/Bzt7XKBtseL1Lr4dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sn6Vm+Su6jYOTU5x7oRhnS5BnbCc/xQry2Gx20SKP8J732pb+LanxN/mlaeDrOoloy9bElMHrrMzYEKBjNldbPX6dpqzcNuPfycvCkxUHKgDBHdzTVyLwKbBej3JAmEeryrJJ8H3V6s99WGmnV2aicTX44BkW6LvTQ5vUhPG5Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A8DC1515;
	Fri,  7 Nov 2025 02:26:44 -0800 (PST)
Received: from [10.57.72.216] (unknown [10.57.72.216])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E1EF3F66E;
	Fri,  7 Nov 2025 02:26:48 -0800 (PST)
Message-ID: <4d23e26a-17db-42f8-bbf2-78acbe6925b8@arm.com>
Date: Fri, 7 Nov 2025 10:26:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] drm/panthor: Implement soft reset via PWR_CONTROL
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20251027161334.854650-1-karunika.choo@arm.com>
 <20251027161334.854650-6-karunika.choo@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251027161334.854650-6-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/10/2025 16:13, Karunika Choo wrote:
> Add helpers to issue reset commands through the PWR_CONTROL interface
> and wait for reset completion using IRQ signaling. This enables support
> for RESET_SOFT operations with timeout handling and status verification.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
> v2:
>  * Dropped RESET_FAST implementation as it is not currently being used.
>  * Renamed reset_completed to reset_pending to align with underlying
>    logic and fixed the logic of its callers accordingly.
>  * Improved readability of panthor_pwr_reset() and removed inline
>    ternary expressions.
> ---
>  drivers/gpu/drm/panthor/panthor_pwr.c | 50 +++++++++++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_pwr.h |  2 ++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
> index cd529660a276..4edb818c7ac4 100644
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
>  #define PWR_RETRACT_TIMEOUT_US		(2ULL * USEC_PER_MSEC)
> 
> +#define PWR_RESET_TIMEOUT_MS		500
> +
>  /**
>   * struct panthor_pwr - PWR_CONTROL block management data.
>   */
> @@ -75,6 +78,43 @@ static void panthor_pwr_write_command(struct panthor_device *ptdev, u32 command,
>  	gpu_write(ptdev, PWR_COMMAND, command);
>  }
> 
> +static bool reset_irq_raised(struct panthor_device *ptdev)
> +{
> +	return gpu_read(ptdev, PWR_INT_RAWSTAT) & PWR_IRQ_RESET_COMPLETED;
> +}
> +
> +static bool reset_pending(struct panthor_device *ptdev)
> +{
> +	return (ptdev->pwr->pending_reqs & PWR_IRQ_RESET_COMPLETED);
> +}
> +
> +static int panthor_pwr_reset(struct panthor_device *ptdev, u32 reset_cmd)
> +{
> +	scoped_guard(spinlock_irqsave, &ptdev->pwr->reqs_lock) {
> +		if (reset_pending(ptdev)) {
> +			drm_WARN(&ptdev->base, 1, "Reset already pending");
> +		} else {
> +			ptdev->pwr->pending_reqs |= PWR_IRQ_RESET_COMPLETED;
> +			gpu_write(ptdev, PWR_INT_CLEAR, PWR_IRQ_RESET_COMPLETED);
> +			panthor_pwr_write_command(ptdev, reset_cmd, 0);
> +		}
> +	}
> +
> +	if (!wait_event_timeout(ptdev->pwr->reqs_acked, !reset_pending(ptdev),
> +				msecs_to_jiffies(PWR_RESET_TIMEOUT_MS))) {
> +		guard(spinlock_irqsave)(&ptdev->pwr->reqs_lock);
> +
> +		if (reset_pending(ptdev) && !reset_irq_raised(ptdev)) {
> +			drm_err(&ptdev->base, "RESET timed out (0x%x)", reset_cmd);
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
> @@ -428,6 +468,16 @@ int panthor_pwr_init(struct panthor_device *ptdev)
>  	return 0;
>  }
> 
> +int panthor_pwr_reset_soft(struct panthor_device *ptdev)
> +{
> +	if (!(gpu_read64(ptdev, PWR_STATUS) & PWR_STATUS_ALLOW_SOFT_RESET)) {
> +		drm_err(&ptdev->base, "RESET_SOFT not allowed");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return panthor_pwr_reset(ptdev, PWR_COMMAND_RESET_SOFT);
> +}
> +
>  void panthor_pwr_l2_power_off(struct panthor_device *ptdev)
>  {
>  	const u64 l2_allow_mask = PWR_STATUS_DOMAIN_ALLOWED(PWR_COMMAND_DOMAIN_L2);
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.h b/drivers/gpu/drm/panthor/panthor_pwr.h
> index 3c834059a860..adf1f6136abc 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.h
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.h
> @@ -10,6 +10,8 @@ void panthor_pwr_unplug(struct panthor_device *ptdev);
> 
>  int panthor_pwr_init(struct panthor_device *ptdev);
> 
> +int panthor_pwr_reset_soft(struct panthor_device *ptdev);
> +
>  void panthor_pwr_l2_power_off(struct panthor_device *ptdev);
> 
>  int panthor_pwr_l2_power_on(struct panthor_device *ptdev);
> --
> 2.49.0
> 


