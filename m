Return-Path: <linux-kernel+bounces-759261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 561AFB1DB33
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDBB6168A94
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C890926CE22;
	Thu,  7 Aug 2025 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zR9GowDS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8B8146A72;
	Thu,  7 Aug 2025 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582509; cv=none; b=FWE8qBYCh1uJD+dKsJONSgRJJWMPRLptWHbVUVfStvgINKSvLmLDabxDYdF6Z6eMuG5R3CGo9W2MbryLBp3NSbkpCL1Egc7ZWglDfkoXkqozSDJeZ5vPKPPO1OjWzb7XWoX8HVcGD8qUjpf/GcMH1v1Sl0DpRFNH6J8iupT0jT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582509; c=relaxed/simple;
	bh=wq7wqugvIqjqCxopMNH39lNGQpVS+BTLfMQGNt2Jktc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzG63iFGc1Ka0mSKQ8wAHbEB4lTEFkchrlfEOra/Ul82C9Gpo1dA5RujM7Qk30QK7mSfpQdtTU8IXIlTWLvEyL1aEaLRzSLnPyaxvEGQ7VNk1IkShZICEFdCa/ARpVobCR6WnHm5rF7VD6JJj5qungj5HnUvEbYiH1r5w5cDQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zR9GowDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770C0C4CEF1;
	Thu,  7 Aug 2025 16:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754582508;
	bh=wq7wqugvIqjqCxopMNH39lNGQpVS+BTLfMQGNt2Jktc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zR9GowDSHV8D1Eoccfvl1faJC/k3U645jNINu/Urz9BZ/WKBTN848DR4HDihkYBWf
	 baHycq7cmVOcMlJymAUNmtL2IRI0loL/Z1BVlrrMbBZi5RJHVgqrRZ7iHL5FqgYFm5
	 83EcS1J20ZYQkeaiTKrTbd+9paJYjqbcecwfe6kI=
Date: Thu, 7 Aug 2025 17:01:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "xiaowei.li" <xiaowei.li@simcom.com>
Cc: Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add SIMCom 8230C compositions
Message-ID: <2025080754-sarcasm-guileless-2bdc@gregkh>
References: <20250807075215.300961-1-xiaowei.li@simcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807075215.300961-1-xiaowei.li@simcom.com>

On Thu, Aug 07, 2025 at 03:52:15PM +0800, xiaowei.li wrote:
> Add the following SIMCom 8230C compositions:
> 0x9071: tty (DM) + tty (NMEA) + tty (AT) + rmnet
> T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=02 Dev#=  5 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1e0e ProdID=9071 Rev= 5.15
> S:  Manufacturer=SIMCOM
> S:  Product=SDXBAAGHA-IDP _SN:D744C4C5
> S:  SerialNumber=0123456789ABCDEF
> C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
> E:  Ad=86(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> 0x9078: tty (DM) + tty (NMEA) + tty (AT) + ECM
> T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=02 Dev#=  6 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=1e0e ProdID=9078 Rev= 5.15
> S:  Manufacturer=SIMCOM
> S:  Product=SDXBAAGHA-IDP _SN:D744C4C5
> S:  SerialNumber=0123456789ABCDEF
> C:* #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
> E:  Ad=86(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
> I:  If#= 4 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> I:* If#= 4 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> 0x907b: RNDIS + tty (DM) + tty (NMEA) + tty (AT)
> T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=02 Dev#=  7 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1e0e ProdID=907b Rev= 5.15
> S:  Manufacturer=SIMCOM
> S:  Product=SDXBAAGHA-IDP _SN:D744C4C5
> S:  SerialNumber=0123456789ABCDEF
> C:* #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
> A:  FirstIf#= 0 IfCount= 2 Cls=ef(misc ) Sub=04 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=ef(misc ) Sub=04 Prot=01 Driver=rndis_host
> E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> ---
>  drivers/usb/serial/option.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index e5cd33093423..8c4d28dfd64e 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -2097,6 +2097,12 @@ static const struct usb_device_id option_ids[] = {
>  	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9003, 0xff) },	/* Simcom SIM7500/SIM7600 MBIM mode */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9011, 0xff),	/* Simcom SIM7500/SIM7600 RNDIS mode */
>  	  .driver_info = RSVD(7) },
> +	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x907b, 0xff),
> +	  .driver_info = RSVD(5) },
> +	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9078, 0xff),
> +	  .driver_info = RSVD(5) },
> +	{ USB_DEVICE(0x1e0e, 0x9071),
> +	  .driver_info = RSVD(3) | RSVD(4) },
>  	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9205, 0xff) },	/* Simcom SIM7070/SIM7080/SIM7090 AT+ECM mode */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9206, 0xff) },	/* Simcom SIM7070/SIM7080/SIM7090 AT-only mode */
>  	{ USB_DEVICE(ALCATEL_VENDOR_ID, ALCATEL_PRODUCT_X060S_X200),
> -- 
> 2.34.1
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

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

