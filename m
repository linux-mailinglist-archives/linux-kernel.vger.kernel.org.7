Return-Path: <linux-kernel+bounces-878137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFCAC1FDE4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48C70349BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225DC336EEC;
	Thu, 30 Oct 2025 11:44:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6CF23D2B2
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824666; cv=none; b=YNptu76rTqDHi+fRts3zs3R0ckH8KXNfCymiqcE+Qpudj4jsrWv1ZMWNinlF3zo0jCCDcWpiG4y92PsTOfroyxFPeooeFt+viub9VgkJjeZZNdkzGbLIrCrBlS7uThCvS52hkLMqmjPbJg5olRHb5C8+WVSwwCDL8aO0tMEyQ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824666; c=relaxed/simple;
	bh=N+YAL6XpnAh4+ncUptXbSh7wbry6o0CPhA56NXZwAeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svrGVzdvDCFgQfZqPzIQ8EXI08j76iSWHQOQjIbYc+v8wY+Id6ZYiVpnipopuVZxiw4Rn42y/Z6e5Tjv/HFOOMqTWngTfaxk4t9m3tLKuH4R5Hf9x0B5qazNYpsOLw8F/iMu4TrkWaXgz1I3ITbRT7EkbxyK/+nX/lOM4pusQA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D81252C40
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:44:15 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 794653F673
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:44:23 -0700 (PDT)
Date: Thu, 30 Oct 2025 11:44:13 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: disable async work during unplug
Message-ID: <aQNPjYdp4XOlk0Ej@e110455-lin.cambridge.arm.com>
References: <20251029111412.924104-1-ketil.johnsen@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251029111412.924104-1-ketil.johnsen@arm.com>

On Wed, Oct 29, 2025 at 12:14:10PM +0100, Ketil Johnsen wrote:
> A previous change, "drm/panthor: Fix UAF race between device unplug and
> FW event processing", fixes a real issue where new work was unexpectedly
> queued after cancellation. This was fixed by a disable instead.
> 
> Apply the same disable logic to other device level async work on device
> unplug as a precaution.
> 
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_device.c | 2 +-
>  drivers/gpu/drm/panthor/panthor_fw.c     | 2 +-
>  drivers/gpu/drm/panthor/panthor_sched.c  | 5 ++---
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 962a10e00848e..c4ae78545ef03 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -120,7 +120,7 @@ static void panthor_device_reset_cleanup(struct drm_device *ddev, void *data)
>  {
>  	struct panthor_device *ptdev = container_of(ddev, struct panthor_device, base);
>  
> -	cancel_work_sync(&ptdev->reset.work);
> +	disable_work_sync(&ptdev->reset.work);
>  	destroy_workqueue(ptdev->reset.wq);
>  }
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 9bf06e55eaeea..ceb249da8b336 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1162,7 +1162,7 @@ void panthor_fw_unplug(struct panthor_device *ptdev)
>  {
>  	struct panthor_fw_section *section;
>  
> -	cancel_delayed_work_sync(&ptdev->fw->watchdog.ping_work);
> +	disable_delayed_work_sync(&ptdev->fw->watchdog.ping_work);
>  
>  	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev)) {
>  		/* Make sure the IRQ handler cannot be called after that point. */
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index b7595beaa0205..278434da8926d 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3879,8 +3879,9 @@ void panthor_sched_unplug(struct panthor_device *ptdev)
>  {
>  	struct panthor_scheduler *sched = ptdev->scheduler;
>  
> -	cancel_delayed_work_sync(&sched->tick_work);
> +	disable_delayed_work_sync(&sched->tick_work);
>  	disable_work_sync(&sched->fw_events_work);
> +	disable_work_sync(&sched->sync_upd_work);
>  
>  	mutex_lock(&sched->lock);
>  	if (sched->pm.has_ref) {
> @@ -3898,8 +3899,6 @@ static void panthor_sched_fini(struct drm_device *ddev, void *res)
>  	if (!sched || !sched->csg_slot_count)
>  		return;
>  
> -	cancel_delayed_work_sync(&sched->tick_work);
> -
>  	if (sched->wq)
>  		destroy_workqueue(sched->wq);
>  
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

