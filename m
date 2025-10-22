Return-Path: <linux-kernel+bounces-864775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8BEBFB84E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CAF24EBC2B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C4C31B810;
	Wed, 22 Oct 2025 11:02:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2D819D074
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130969; cv=none; b=KtpzEtVDR+K3fneE/u9SAd25TaPotIaF+S6u6rB8ofSJ2TX+RJY+X6Rk/wl4koVccsycrZj0eBb3tnd8irECdx8I3Mw6Y570s1BrzV0O2R8WSOmTvDA3tSGGWmvR+Jz4ohRgEg20qk85C7DfSitqw0sqYly4llLOQD2aRr4RXJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130969; c=relaxed/simple;
	bh=ZyEF/RL1pft+ckVefYF1LGuyMxaoM8RNwGAC+KmPfSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNyXFF8kOu6WiB6D57jn2CCe3u7XaWLKv3kW3ocy8bc+IuPd4tMciQbQNbEdYy908kRRUMTZES5dGaiqlR+BTtkiMTjgBkTGfS+xx6myyR9u+XiQ4t/tPvAyVsUHaMEZz0IwHXZaUsyZ88YbASutJcZVKkYOU42bDB9RNV0v1aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24B7C1C00
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:02:39 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE5D83F59E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:02:46 -0700 (PDT)
Date: Wed, 22 Oct 2025 12:02:34 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panthor: Fix UAF race between device unplug and
 FW event processing
Message-ID: <aPi5yi9oND0b-7g5@e110455-lin.cambridge.arm.com>
References: <20251022103014.1082629-1-ketil.johnsen@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022103014.1082629-1-ketil.johnsen@arm.com>

On Wed, Oct 22, 2025 at 12:30:13PM +0200, Ketil Johnsen wrote:
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

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

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

