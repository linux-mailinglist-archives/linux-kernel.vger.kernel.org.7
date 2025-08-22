Return-Path: <linux-kernel+bounces-781111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A46EB30DAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999EF1CC7C68
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD71278E7B;
	Fri, 22 Aug 2025 04:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VUag2PQi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC68223507C;
	Fri, 22 Aug 2025 04:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755837910; cv=none; b=clLX65kSxwGgGyTRFoustmCvpUtyjHfdMZRs//UY+8scx0cju0VSBDj6yT/bxIrn7cTHEF734ly75YZM9A2JxzyOVr5Agv0xeBHMUMfevjxVoG9So+rurBh7n9ogQa5Tm/oTZ97D5ftPL6gP7tI42HAZJVhLyAFikwCNjnOoG3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755837910; c=relaxed/simple;
	bh=xr9HAgxXfe1LuG2e1xdt+RJHcAoEpm5QP45MW7qu8PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEWaYC1r/K4P1YIZRCgmuXjuFA68yHJpOZBufSfgjZ2tjl90/kVT/LXhdLj8TInFGTGBYVIKzN7jLnDonZhGspFPpnVhjhxQCvTLrhMaTcBJry1leVRFyVckUo1ia6hfFYnD7yyfXuMwPCAh8ItgBZUHhmLbPmqMJ0cxtnhHxa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VUag2PQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD8CC4CEF1;
	Fri, 22 Aug 2025 04:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755837909;
	bh=xr9HAgxXfe1LuG2e1xdt+RJHcAoEpm5QP45MW7qu8PA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUag2PQikMSCxt+pmRY4xpu1udTUdmHuBtHqKJ9v96X2xES9SDzV8aSu422xN0QNB
	 XXFuG7cwtAAPuf2asy46I+O84+dS6U9PLr0Zh/35HcS7puEXGmu8Ck83Fb3qZVt2Oh
	 hOw+QQHOFaSjrmRRC9IU7fVVJf7/j4xP5GHA+hQY=
Date: Fri, 22 Aug 2025 06:45:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Wu <william.wu@rock-chips.com>
Cc: Chris.Wulff@biamp.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, frank.wang@rock-chips.com,
	jianwei.zheng@rock-chips.com, yue.long@rock-chips.com
Subject: Re: [PATCH] usb: gadget: f_hid: Fix zero length packet transfer
Message-ID: <2025082235-fondness-destruct-f8f6@gregkh>
References: <1755828118-21640-1-git-send-email-william.wu@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1755828118-21640-1-git-send-email-william.wu@rock-chips.com>

On Fri, Aug 22, 2025 at 10:01:58AM +0800, William Wu wrote:
> If the hid transfer with size divisible to EPs max packet
> size, it needs to set the req->zero to true, then the usb
> controller can transfer a zero length packet at the end
> according to the USB 2.0 spec.
> 
> Signed-off-by: William Wu <william.wu@rock-chips.com>
> ---
>  drivers/usb/gadget/function/f_hid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> index 8e1d1e8..8021af3 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -511,7 +511,7 @@ static ssize_t f_hidg_write(struct file *file, const char __user *buffer,
>  	}
>  
>  	req->status   = 0;
> -	req->zero     = 0;
> +	req->zero     = ((count % hidg->in_ep->maxpacket) == 0);
>  	req->length   = count;
>  	req->complete = f_hidg_req_complete;
>  	req->context  = hidg;
> @@ -967,7 +967,7 @@ static int hidg_setup(struct usb_function *f,
>  	return -EOPNOTSUPP;
>  
>  respond:
> -	req->zero = 0;
> +	req->zero = ((length % cdev->gadget->ep0->maxpacket) == 0);
>  	req->length = length;
>  	status = usb_ep_queue(cdev->gadget->ep0, req, GFP_ATOMIC);
>  	if (status < 0)

What commit id does this fix?

thanks,

greg k-h

