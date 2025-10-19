Return-Path: <linux-kernel+bounces-859733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC51BEE72B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E1694349386
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ECE2E62A8;
	Sun, 19 Oct 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X0zEXi7N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D721C8606
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760884504; cv=none; b=SDbfRdgU1t/sED8Oxqx6PlEetKZ+7OSqrNJaKNCrB4yQSROc9hhkMHIiPJapGcdyqxqELHlDno6Hh8C48LWdYj43rufCzbILF6YLqWIG70Lp63JJsZnqtZOGGVya2J9BhliD6ACXCk8vERBVmob+HvR5stfBlrifJmJOpQBL4sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760884504; c=relaxed/simple;
	bh=y7cvxQqQD1a5PHENO82BrDOOIH5qq6OOuxFThXQ36dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvy1BnEwfLQDzczPfiBwpScUPXPtE9PXGo6XvdnsusIrqlFk9fIPje4SkObiMFRj/3YDz4yF4d22Xpbo2kXs1iYcHJV+zYkQ0dQFbI7Z6c+y7cYRehsV3oWQ8qGOa/YhZNAxUd09ITq2RXIWLK896Y/htGDhiGfbUj3JEcER+RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X0zEXi7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DD1C4CEE7;
	Sun, 19 Oct 2025 14:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760884502;
	bh=y7cvxQqQD1a5PHENO82BrDOOIH5qq6OOuxFThXQ36dI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X0zEXi7N3qg02EN+vP29+2Xg0tUW8RV04086pk5OctIKpkZsAyHOhF65hE39ixzHd
	 uvvrMnkIse3YPY3kk9GECQYSES85PYMYwoyiidT65itCGuc44chhgAmb3gfrE635ld
	 J/E3x1hwHAh5ajLFb6x8hV7s09PjKrGAmkgmgSLk=
Date: Sun, 19 Oct 2025 16:34:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: lanzano.alex@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] drm/tiny: Use kmalloc_array() instead of kmalloc()
Message-ID: <2025101910-dipper-suburb-1755@gregkh>
References: <20251019151247.171558-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251019151247.171558-1-mehdi.benhadjkhelifa@gmail.com>

On Sun, Oct 19, 2025 at 04:12:28PM +0100, Mehdi Ben Hadj Khelifa wrote:
> Replace kmalloc() with kmalloc_array() to correctly
> handle array allocations and benefit from built-in overflow checking[1].
> 
> [1]:https://docs.kernel.org/process/deprecated.html
> 
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
>  drivers/gpu/drm/tiny/repaper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
> index 4824f863fdba..290132c24ff9 100644
> --- a/drivers/gpu/drm/tiny/repaper.c
> +++ b/drivers/gpu/drm/tiny/repaper.c
> @@ -534,7 +534,7 @@ static int repaper_fb_dirty(struct drm_framebuffer *fb, const struct iosys_map *
>  	DRM_DEBUG("Flushing [FB:%d] st=%ums\n", fb->base.id,
>  		  epd->factored_stage_time);
>  
> -	buf = kmalloc(fb->width * fb->height / 8, GFP_KERNEL);
> +	buf = kmalloc_array(fb->height / 8, fb->width, GFP_KERNEL);

This isn't an array, so this function change doesn't seem to make much
sense, right?  The size should have already been checked earlier in the
call change to be correct.

thanks,

greg k-h

