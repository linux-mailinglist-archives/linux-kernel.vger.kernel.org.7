Return-Path: <linux-kernel+bounces-882818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 782AEC2B944
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4FD6188DEC3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9E93093C6;
	Mon,  3 Nov 2025 12:13:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F69D1DE3B5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762171995; cv=none; b=Z5oqhAgbuqAnh8wI5GQka66k9ufnciE41Y+X0obc/JZv3f4ko2soD7tBg3O7qbJTjyk9dvEr3tH920yuZrZlcA4DG2kCKw+KrBOQVF9/YZ1xCveLz9B5NRnU2MJ4RGpAqFtHMhjNVsv0N9Jf9RQyEJFYmnIRKtDUhs66HpVx1tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762171995; c=relaxed/simple;
	bh=cKDv2X4DK0tbk0FPi80niRf4hyzMN/offfJRi+lWso0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIawt+qsSB3nDEdTZC0s6qLFTi7oT/l9bF8OK1UzA95Vl5ugUpfO23jJR4AnAqZX9ZBLhTxT8TrLsbR9aHxhTG9dvSc3K2BbsNEbrROvhEdBZPGV+z2EF5LsHwRDivLABR8l5AVv2glrNk4VJzV/3U1xATw6w1ZISiYMUeJ8Qbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EAE61D13
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 04:12:57 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC8233F694
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 04:13:04 -0800 (PST)
Date: Mon, 3 Nov 2025 12:12:50 +0000
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
Subject: Re: [PATCH v3] drm/panthor: Fix UAF race between device unplug and
 FW event processing
Message-ID: <aQicQqpYYRvukRM0@e110455-lin.cambridge.arm.com>
References: <20251027140217.121274-1-ketil.johnsen@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251027140217.121274-1-ketil.johnsen@arm.com>

On Mon, Oct 27, 2025 at 03:02:15PM +0100, Ketil Johnsen wrote:
> The function panthor_fw_unplug() will free the FW memory sections.
> The problem is that there could still be pending FW events which are yet
> not handled at this point. process_fw_events_work() can in this case try
> to access said freed memory.
> 
> Simply call disable_work_sync() to both drain and prevent future
> invocation of process_fw_events_work().
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
> 
> v3:
> - New approach, one single call to disable_work_sync()
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 0cc9055f4ee52..b7595beaa0205 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3880,6 +3880,7 @@ void panthor_sched_unplug(struct panthor_device *ptdev)
>  	struct panthor_scheduler *sched = ptdev->scheduler;
>  
>  	cancel_delayed_work_sync(&sched->tick_work);
> +	disable_work_sync(&sched->fw_events_work);
>  
>  	mutex_lock(&sched->lock);
>  	if (sched->pm.has_ref) {
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

