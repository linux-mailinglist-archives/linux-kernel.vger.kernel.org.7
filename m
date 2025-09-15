Return-Path: <linux-kernel+bounces-816816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F13B57891
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6CC3ACE44
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F2C2FF17B;
	Mon, 15 Sep 2025 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GGxBo0sx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786C02F546D;
	Mon, 15 Sep 2025 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936177; cv=none; b=hg5HQsh6VD1J2IFthUMYVPzK5xiiuV7BqianzlLPWrVfn67SWne1yTjXMQS3g+FdwktPOK2dyCOT22nRolt4SedtdP9+mzjzigrnBbIk++RfsH8lBAQAjON/i4eCqgFR36lTEBWaD4Zkp4qlQCBT9x7L2b3o/ItlN1gx21uUBcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936177; c=relaxed/simple;
	bh=vgNszQL4Q5rLJBGzUTEvV8qBt+LzKlCj8gFwWLLEP4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmvCrGTb/oUG9zdmKj+nFZakPQWIbay28j6mT9c1K96Pb4yftKWxC46NrxGlpJLfhrsElSxiODmgM65uGBqbSYu/9ueNyV7/BiIXeX1/LamXHj8IUe8qnQARMfuJ8bub6QBk0nirPjyZ9pdPp1b0KrK3+fROh04g2htn0IdpKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GGxBo0sx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B75C4CEF1;
	Mon, 15 Sep 2025 11:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757936177;
	bh=vgNszQL4Q5rLJBGzUTEvV8qBt+LzKlCj8gFwWLLEP4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGxBo0sxHOfOc6PBerLwe1+1VmnOUmPORPn9inmKEarolKO4L/SuE+Re29zoldlAt
	 hJI6tpWgBtp3zjaA+odnR2FtlfZycQv/80Fk0famFVKTnuzrWDRaw+rh35VqVXzWd1
	 rKISUeZcPYyGoi+ZGfZVMEiSTPvxfMfDxCQA54dY=
Date: Mon, 15 Sep 2025 13:36:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: tglx@linutronix.de, mingo@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, jun.li@nxp.com
Subject: Re: [PATCH] usb: gadget: zero: add function wakeup support
Message-ID: <2025091545-effort-trolling-e7cb@gregkh>
References: <20250915090230.1280460-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915090230.1280460-1-xu.yang_2@nxp.com>

On Mon, Sep 15, 2025 at 05:02:30PM +0800, Xu Yang wrote:
> When the device working at enhanced superspeed, it needs to send function
> remote wakeup signal to the host instead of device remote wakeup. Add
> function wakeup support for the purpose.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  drivers/usb/gadget/legacy/zero.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/gadget/legacy/zero.c b/drivers/usb/gadget/legacy/zero.c
> index a05785bdeb30..fe286b597f9f 100644
> --- a/drivers/usb/gadget/legacy/zero.c
> +++ b/drivers/usb/gadget/legacy/zero.c
> @@ -147,6 +147,12 @@ static struct usb_gadget_strings *dev_strings[] = {
>  	NULL,
>  };
>  
> +static struct usb_function *func_lb;
> +static struct usb_function_instance *func_inst_lb;
> +
> +static struct usb_function *func_ss;
> +static struct usb_function_instance *func_inst_ss;
> +
>  /*-------------------------------------------------------------------------*/
>  
>  static struct timer_list	autoresume_timer;
> @@ -156,6 +162,7 @@ static void zero_autoresume(struct timer_list *unused)
>  {
>  	struct usb_composite_dev	*cdev = autoresume_cdev;
>  	struct usb_gadget		*g = cdev->gadget;
> +	int status;
>  
>  	/* unconfigured devices can't issue wakeups */
>  	if (!cdev->config)
> @@ -165,10 +172,18 @@ static void zero_autoresume(struct timer_list *unused)
>  	 * more significant than just a timer firing; likely
>  	 * because of some direct user request.
>  	 */
> -	if (g->speed != USB_SPEED_UNKNOWN) {
> -		int status = usb_gadget_wakeup(g);
> -		INFO(cdev, "%s --> %d\n", __func__, status);
> +	if (g->speed == USB_SPEED_UNKNOWN)
> +		return;
> +
> +	if (g->speed >= USB_SPEED_SUPER) {
> +		if (loopdefault)
> +			status = usb_func_wakeup(func_lb);
> +		else
> +			status = usb_func_wakeup(func_ss);
> +	} else {
> +		status = usb_gadget_wakeup(g);
>  	}
> +	INFO(cdev, "%s --> %d\n", __func__, status);

Is this INFO() call still needed?  Shouldn't that be removed?

thanks,

greg k-h

