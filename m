Return-Path: <linux-kernel+bounces-800180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D9AB43450
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDC97C3114
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175802BDC10;
	Thu,  4 Sep 2025 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zHNtuccX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C61529C33F;
	Thu,  4 Sep 2025 07:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971237; cv=none; b=ANY1Jkv6tmQfRLAoKDcSGtKzRgYudmyc5IQN8KiA4+fvPClFLp2jvtTaOgQ2vNqNcRUkq2+vT7geetqjs1TQR1J0auFyFes+rMuM3YmUAClLNU74XjtdrEp5G9+9jFuPNwgeovLYpNwP43QVIBuyp67dxOXck470l0ti87XDFcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971237; c=relaxed/simple;
	bh=Qr04LJto2UZzgwUz5dPBMi+5BZlYNfRAH2bzLTO8lKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYFecv48vuuIml0yeGHhRFJI/WGiTUzdF4mnCbz4LHsJsnJLPPyN16C3GY7bkELVl9UiSGdRhgAEej+B3NekzIBHAKlKP0s5I17Uw/pmC2WHpTIhsG3p4Olr9IducbA0prAnUbWXoygj05L4rGKp1xEzwJpeFFQFAon7n9P+rBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zHNtuccX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F070C4CEF0;
	Thu,  4 Sep 2025 07:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756971236;
	bh=Qr04LJto2UZzgwUz5dPBMi+5BZlYNfRAH2bzLTO8lKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zHNtuccXkJxCUDj+r3HS2Nfya69B7GqPu4E5Q9rS9V4mR/bTzsGwVXbIv6YcAJRPE
	 zqz0J6ETw198sFSpPQC5MDNwZXBuXQgsNV0PiQfIwtmCiN9smB0lB3aLcOjdXY53hd
	 smpwcSlm5Xwfz6/NA+iFJ/FixmgpZlWnIinHU70k=
Date: Thu, 4 Sep 2025 09:33:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuen-Han Tsai <khtsai@google.com>
Cc: krzysztof.kozlowski@linaro.org, prashanth.k@oss.qualcomm.com,
	Thinh.Nguyen@synopsys.com, s.hauer@pengutronix.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_ecm: Fix ecm_opts->bound logic in bind
 path
Message-ID: <2025090436-baffle-clubbing-1a20@gregkh>
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

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

