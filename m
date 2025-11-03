Return-Path: <linux-kernel+bounces-883080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B908C2C70A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EF664E58AB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E0B28032D;
	Mon,  3 Nov 2025 14:38:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0AB26B75B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180730; cv=none; b=I4lJOwA2ny3uVNKkbQw8Ex6zvpGM18LeqUDtamTcM4v68zgU8Vc0U/5X4LDx4IWAUkMYXzJwRKBGLFQ++WPtf+B8JRKfSIOzJeE/2b2QVahm+p4h2FBRloNB+dAMpmXjMXTNgM9Ydet3m8lyq2BGqM+onNivf7h1n1spkPR59Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180730; c=relaxed/simple;
	bh=A++XHiJIVw4LHZhYoNUGEiZvW7FPjXuGqSwYOnzbL2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHP8CtO5fL24Unorod12s7cBI4cZDmZECm4PrtabadfDeiDy7VWXW7HQXSrAVtBvwp/BejZ15o46YIdoB4j4gZQmG2mTJeuS9+8Ol2N0F4rWYK6zAaRXuYuQXwDB6GuW4R5NunmAeoSzzVs9iIojYXyo6V5zjtE6DtntgHS2j98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7A3F1D14
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:38:39 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3E82E3F694
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:38:47 -0800 (PST)
Date: Mon, 3 Nov 2025 14:38:34 +0000
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
Message-ID: <aQi-agymuWjgJA3h@e110455-lin.cambridge.arm.com>
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

Pushed to drm-misc-next.

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

