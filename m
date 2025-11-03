Return-Path: <linux-kernel+bounces-883079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED94C2C6FB
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA121892842
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0147A2E2665;
	Mon,  3 Nov 2025 14:38:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA464280332
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180681; cv=none; b=CI4dI4LpAclKyv5tAp6axmdAuAMP6DagxjH+miLe7D1teFIIQtLxc+hvnmzWSremwk25nEZy67cAN3yvMEPkpJ2nai3vu31vD8mqBqvYZ+1D8g/wRxoSyKS0tbM++tKZjrKUnjr4VZucjwT3ZW/CVHiTktgJtKqi25u0uid3VrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180681; c=relaxed/simple;
	bh=xy+sK4cT8xQZO6wL3vpZh5n6Yp1pK6MmHg/IHcj3gTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSCbtUcT2QkY9kisK6Xl0pu/zonVkseckg+aR9Uo8+8iHFeZ2Qb5awZ3tiF0KJLXDHS2tdXBubF5aetgZvmTpBfRIV/XmeAozPt1aJ8llS4IgO/UdV1crVag3wss7McRV7icaL4lOY3Nygj33d4qj1ooZx5N7bofXDcnF9Tc8yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 322771D14
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:37:51 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BD68B3F694
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:37:58 -0800 (PST)
Date: Mon, 3 Nov 2025 14:37:48 +0000
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
Message-ID: <aQi-PGCe8q3FHszH@e110455-lin.cambridge.arm.com>
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

Pushed the patch to drm-misc-next.

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

