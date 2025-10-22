Return-Path: <linux-kernel+bounces-864757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E9ABFB78E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE1418884EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6214C30CDB6;
	Wed, 22 Oct 2025 10:53:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B251246762
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130393; cv=none; b=A+4sFMnXIVI2oX11RR9vZpbCvkdDPVJfW8pG495mkPcWXHf9CVC7FSzSwPiRJ5gCai/fxtkQ7agdUBi/308A+PjlSsmpqIdlWhDk4NV/whYGANLAwnZN9XRt4qJKvQCK/MD/48iKlqRykCwlBAEkT2iz1PvL0dY5qR/lbXWY+7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130393; c=relaxed/simple;
	bh=+WygW+gsyBNwDfW8vSYe1xrgueDZLOQVYUoCAtnWxfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fp+6QvBBmvYPNy06mZvn6BX4heRugPn+5eFnGWhl6+bqegypNzLczna5zfiW8QCAjcjPQQpynDNWIedTo7fqaCQ4LX0RTYDIq1NrR3s6AevI+u5nHmjksThCIKwa28Iaq2bABrBX6wa+3EoqrsxmnItVNlgPzuQ2E+9+mC/19gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D06EB1063;
	Wed, 22 Oct 2025 03:53:00 -0700 (PDT)
Received: from [10.57.33.187] (unknown [10.57.33.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 470F63F59E;
	Wed, 22 Oct 2025 03:53:06 -0700 (PDT)
Message-ID: <993e72bc-be83-48f0-bac5-eb49079aab57@arm.com>
Date: Wed, 22 Oct 2025 11:53:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panthor: Fix UAF race between device unplug and FW
 event processing
To: Ketil Johnsen <ketil.johnsen@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251022103014.1082629-1-ketil.johnsen@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251022103014.1082629-1-ketil.johnsen@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/2025 11:30, Ketil Johnsen wrote:
> The function panthor_fw_unplug() will free the FW memory sections.
> The problem is that there could still be pending FW events which are yet
> not handled at this point. process_fw_events_work() can in this case try
> to access said freed memory.
> 
> This fix introduces a destroyed state for the panthor_scheduler object,
> and we check for this before processing FW events.
> 
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
> Fixes: de85488138247 ("drm/panthor: Add the scheduler logical block")

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
> v2:
> - Followed Boris's advice and handle the race purely within the
>   scheduler block (by adding a destroyed state)
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 0cc9055f4ee52..4996f987b8183 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -315,6 +315,13 @@ struct panthor_scheduler {
>  		 */
>  		struct list_head stopped_groups;
>  	} reset;
> +
> +	/**
> +	 * @destroyed: Scheduler object is (being) destroyed
> +	 *
> +	 * Normal scheduler operations should no longer take place.
> +	 */
> +	bool destroyed;
>  };
>  
>  /**
> @@ -1765,7 +1772,10 @@ static void process_fw_events_work(struct work_struct *work)
>  	u32 events = atomic_xchg(&sched->fw_events, 0);
>  	struct panthor_device *ptdev = sched->ptdev;
>  
> -	mutex_lock(&sched->lock);
> +	guard(mutex)(&sched->lock);
> +
> +	if (sched->destroyed)
> +		return;
>  
>  	if (events & JOB_INT_GLOBAL_IF) {
>  		sched_process_global_irq_locked(ptdev);
> @@ -1778,8 +1788,6 @@ static void process_fw_events_work(struct work_struct *work)
>  		sched_process_csg_irq_locked(ptdev, csg_id);
>  		events &= ~BIT(csg_id);
>  	}
> -
> -	mutex_unlock(&sched->lock);
>  }
>  
>  /**
> @@ -3882,6 +3890,7 @@ void panthor_sched_unplug(struct panthor_device *ptdev)
>  	cancel_delayed_work_sync(&sched->tick_work);
>  
>  	mutex_lock(&sched->lock);
> +	sched->destroyed = true;
>  	if (sched->pm.has_ref) {
>  		pm_runtime_put(ptdev->base.dev);
>  		sched->pm.has_ref = false;


