Return-Path: <linux-kernel+bounces-800177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547F8B43449
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2046617E3C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB042D9EC9;
	Thu,  4 Sep 2025 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SsoYk+7l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7783C2D8781;
	Thu,  4 Sep 2025 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971219; cv=none; b=VB4Z6hW3i+wJ+rOt1Yu5vNS0UymOe4b35USf/3bI+QP3ZcYhaYz0LMUw/0FfbNKePkhaife0XvfF2+6Lfmd2VJYAPCGfT0xFyAykqinzMiVRUxCjBoy+s3Jyrl4/lA8Mehrlex+sOrHXmuQVS6zvBEvT7ekQ54aPRibofM7bhQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971219; c=relaxed/simple;
	bh=H61z2NonCvlgcGkc+m/zzHM6ka1MurtUbR3vVk9tS+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXL+3RqV5WJIvBJZjZ8CUokFVX7mzTjqCM3JhPE2gJgz51NV4S7+CnXLBUHlNCr6baOzDJkITCQEW3OEnZuDuoKVFFKPFKuk8sAXHf3g5K92Ua25TqXoFo2MDX6dX+mG53O/Gv+y1odRXsx5djT9p03ycjFO9qbg6l7+5nLwTVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SsoYk+7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8C9C4CEF0;
	Thu,  4 Sep 2025 07:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756971218;
	bh=H61z2NonCvlgcGkc+m/zzHM6ka1MurtUbR3vVk9tS+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SsoYk+7l8227znG5+DBzWr4VrQ8XPH93wNyByQYTtHg5EVjdnvHi/ao3aDEuYDRm9
	 7t6M/e6WR6W5VQUz645kF/Mh9IzQTiwE+BVgXJlXpFiGfXuq2eEZ+YZIJMlKTPzut0
	 Vw7LGElVbxcyjUUcWF5qibAzownaYzYZQeP7aIQc=
Date: Thu, 4 Sep 2025 09:33:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuen-Han Tsai <khtsai@google.com>
Cc: krzysztof.kozlowski@linaro.org, prashanth.k@oss.qualcomm.com,
	Thinh.Nguyen@synopsys.com, s.hauer@pengutronix.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_ecm: Fix ecm_opts->bound logic in bind
 path
Message-ID: <2025090429-snooze-womankind-77fb@gregkh>
References: <20250904065203.1162629-1-khtsai@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904065203.1162629-1-khtsai@google.com>

On Thu, Sep 04, 2025 at 02:52:00PM +0800, Kuen-Han Tsai wrote:
> The bound flag in ecm_opts is being set to true even if
> gether_register_netdev() failed.
> 
> Move the assignment of ecm_opts->bound to after the success check to
> ensure the flag only reflects the true state. The race condition on this
> flag is not a concern because the caller, configfs_composite_bind(),
> binds functions sequentially.
> 
> Fixes: d65e6b6e884a ("usb: gadget: f_ecm: Always set current gadget in ecm_bind()")
> Cc: stable@kernel.org
> Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> ---
>  drivers/usb/gadget/function/f_ecm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
> index 027226325039..9f5ed6f32a62 100644
> --- a/drivers/usb/gadget/function/f_ecm.c
> +++ b/drivers/usb/gadget/function/f_ecm.c
> @@ -690,13 +690,14 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
>  
>  	if (!ecm_opts->bound) {
>  		status = gether_register_netdev(ecm_opts->net);
> -		ecm_opts->bound = true;
>  	}
>  
>  	mutex_unlock(&ecm_opts->lock);
>  	if (status)
>  		return status;
>  
> +	ecm_opts->bound = true;
> +
>  	ecm_string_defs[1].s = ecm->ethaddr;
>  
>  	us = usb_gstrings_attach(cdev, ecm_strings,
> -- 
> 2.51.0.338.gd7d06c2dae-goog
> 
> 


Hi,

This is the friendly semi-automated patch-bot of Greg Kroah-Hartman.
You have sent him a patch that has triggered this response.

Right now, the development tree you have sent a patch for is "closed"
due to the timing of the merge window.  Don't worry, the patch(es) you
have sent are not lost, and will be looked at after the merge window is
over (after the -rc1 kernel is released by Linus).

So thank you for your patience and your patches will be reviewed at this
later time, you do not have to do anything further, this is just a short
note to let you know the patch status and so you don't worry they didn't
make it through.

thanks,

greg k-h's patch email bot

