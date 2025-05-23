Return-Path: <linux-kernel+bounces-660799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 077D8AC2240
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 13:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713681BC1F43
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 11:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9679C23644F;
	Fri, 23 May 2025 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pZ660yKS"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2585D8F0;
	Fri, 23 May 2025 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748001490; cv=none; b=iNHh/Rnf7IfJWTnZHddlqim85YaV5xIZNilBWtU6VbmLm4C0gck7W2NL77rAXfSV/vpXpol/TiHZmuCu+1rMBbRyVZtpLbdp/cos6CH/SS/C3AfNciQ8lN6E0BHbOUSoHCSkahHuTI/kWp3m8CD5hx/IxUK3YWq8uH5r08LwC/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748001490; c=relaxed/simple;
	bh=oZdBrUDQJxhkkByP6dZ6MpPgQvI+YM5e4E3Ow5GMCLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnXqkGrX1fZeiaJLMi4vFxnYMiPLITpulKz9Zm2AF/yR/Aq2MUf1Jc5tBKSydyUSWCFnDDSw1KdPjtrWYFygomS8ZiSOznJOhEH6vHC4y/P/vvlUlF7k+NjE+LNJJmUL09gx+ja2KA2LFm5NQXVgco2Nq+XuQUGx3cD04WSi72A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pZ660yKS; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (179.218-130-109.adsl-dyn.isp.belgacom.be [109.130.218.179])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 27F7D6B5;
	Fri, 23 May 2025 13:57:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1748001464;
	bh=oZdBrUDQJxhkkByP6dZ6MpPgQvI+YM5e4E3Ow5GMCLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZ660yKSlqNL2sfP2IDEBNQAg0vHL9jKEaChdpCDLTSxESHAYbAJEwZ4YtZQNHp8M
	 is3Kbazk1kj01rgUsGvtBYYdnge7ToVYEnf/G6pJwXYiFGRWUWkimIlxH7rO/bPXFV
	 qdSEqg3b70xoZlw3DIp7MoUYT4s171LPJ8ZALGYk=
Date: Fri, 23 May 2025 13:57:59 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] media: uvcvideo: Populate all errors in uvc_probe()
Message-ID: <20250523115759.GE12514@pendragon.ideasonboard.com>
References: <20250509-uvc-followup-v1-0-73bcde30d2b5@chromium.org>
 <20250509-uvc-followup-v1-4-73bcde30d2b5@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250509-uvc-followup-v1-4-73bcde30d2b5@chromium.org>

Hi Ricardo,

On Fri, May 09, 2025 at 06:24:16PM +0000, Ricardo Ribalda wrote:
> Now we are replacing most of the error codes with -ENODEV.
> Instead, Populate the error code from the functions called by
> uvc_probe().
> 
> Take this opportunity to replace a generic error code from
> uvc_scan_device() into something more meaningful.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index da24a655ab68cc0957762f2b67387677c22224d1..cdf4bbe582272277a6a95267e9752010adc51b6b 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1866,7 +1866,7 @@ static int uvc_scan_device(struct uvc_device *dev)
>  
>  	if (list_empty(&dev->chains)) {
>  		dev_info(&dev->udev->dev, "No valid video chain found.\n");
> -		return -1;
> +		return -ENODEV;
>  	}
>  
>  	/* Add GPIO entity to the first chain. */
> @@ -2239,7 +2239,6 @@ static int uvc_probe(struct usb_interface *intf,
>  	/* Parse the Video Class control descriptor. */
>  	ret = uvc_parse_control(dev);
>  	if (ret < 0) {
> -		ret = -ENODEV;
>  		uvc_dbg(dev, PROBE, "Unable to parse UVC descriptors\n");
>  		goto error;
>  	}
> @@ -2275,22 +2274,16 @@ static int uvc_probe(struct usb_interface *intf,
>  		goto error;
>  
>  	/* Scan the device for video chains. */
> -	if (uvc_scan_device(dev) < 0) {
> -		ret = -ENODEV;
> +	if (uvc_scan_device(dev) < 0)

That's not going to work. You probably meant

	ret = uvc_scan_device(dev);
	if (ret < 0)

Same elsewhere where applicable.

>  		goto error;
> -	}
>  
>  	/* Initialize controls. */
> -	if (uvc_ctrl_init_device(dev) < 0) {
> -		ret = -ENODEV;
> +	if (uvc_ctrl_init_device(dev) < 0)
>  		goto error;
> -	}
>  
>  	/* Register video device nodes. */
> -	if (uvc_register_chains(dev) < 0) {
> -		ret = -ENODEV;
> +	if (uvc_register_chains(dev) < 0)
>  		goto error;
> -	}
>  
>  #ifdef CONFIG_MEDIA_CONTROLLER
>  	/* Register the media device node */

-- 
Regards,

Laurent Pinchart

