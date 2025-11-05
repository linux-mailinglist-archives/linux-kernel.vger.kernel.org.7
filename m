Return-Path: <linux-kernel+bounces-885978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ACCC346ED
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514BA189AD16
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026C1283CBF;
	Wed,  5 Nov 2025 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNySGCvw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524A22135D7;
	Wed,  5 Nov 2025 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762330785; cv=none; b=qAkzHTc6vNNA+mJOprP6wF5AuXhi/6VuLDj1uLnmzsCYCakI7X3MXjpIPWcnAVbAn1zkEqLSQSjsCAIiFVy8aMwJZctRdnxCiyr2+/7Fp9BOrDB+XCEJukEEM/27H7p05U6mc6LYGWeBOFHl1OQgzcTPjlK88xISGFqwA1hZQpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762330785; c=relaxed/simple;
	bh=9dErL4q16sN8S0y6Frq09VMabnJQCAfgk5EISiOS/4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDejVibmM+ogpcQQGGAvZsgyIJQWxpPW+6ntAvB2GyLsiMsKDSgz7hhdI6Q3J8SvPU6wmpUPibU6U63zInqb8/AOETFgXAkRlQfaCqiWDV0ZkIL5WOsJgMgPSg3BF78rN6vZOEohhNzdQ5VBtUjXBXVzWBcNi586f8XYggGqUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNySGCvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F82C4CEF8;
	Wed,  5 Nov 2025 08:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762330784;
	bh=9dErL4q16sN8S0y6Frq09VMabnJQCAfgk5EISiOS/4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNySGCvwSueGVgCwVThm39anicSvPAx0TGqkexnMozGJnMd/XxMt0yjdr9SloQg42
	 zZTxGF6i2FYvZgFE0iACPRFdq1vISK4JQjCt4YI1rFG83bd+rTgYN6NzmXuEOWr4lr
	 pu5X7Jm+LJeCK1kWHbtRTPsRwsj4oquFK2omQkI0EhyI2o+k78FBVARdUshDExyjat
	 mPuJlroDG0U3jEREYBJkyiQvCdk1sI/VVpuUgBvB7vDuSS9EegDu96yehoT0MNjwUX
	 OJszUSRiFdIoAOKXtQMN/XYdQeGSQO1cTGYcldkpdOSVjaJrW1EU2WONrZ/JQv2yqB
	 wa0/bw3/HqeKQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vGYk6-0000000058W-08tX;
	Wed, 05 Nov 2025 09:19:46 +0100
Date: Wed, 5 Nov 2025 09:19:46 +0100
From: Johan Hovold <johan@kernel.org>
To: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Telit FN920C04 RNDIS
 compositions
Message-ID: <aQsIov60LnWcKaz6@hovoldconsulting.com>
References: <20251105034833.4152008-1-Qing-wu.Li@leica-geosystems.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105034833.4152008-1-Qing-wu.Li@leica-geosystems.com.cn>

On Wed, Nov 05, 2025 at 03:48:33AM +0000, LI Qingwu wrote:

Please also mention which port is used for what (e.g. as you did for
FN920C04).

> T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  4 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1bc7 ProdID=10a1 Rev= 5.15
> S:  Manufacturer=Telit Cinterion
> S:  Product=FN920
> S:  SerialNumber=76e7cb38
> C:* #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
> A:  FirstIf#= 0 IfCount= 2 Cls=ef(misc ) Sub=04 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=ef(misc ) Sub=04 Prot=01 Driver=option
> E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

The driver should not be binding to this port, and there's no need to
reserve it since you're matching on the interface class below.

The lsusb output must have been generated with an earlier version of the
patch.

> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
> E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Is this interface that needs NCTRL perhaps (i.e. 4 rather than 3)?

> T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  5 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1bc7 ProdID=10a6 Rev= 5.15
> S:  Manufacturer=Telit Cinterion
> S:  Product=FN920
> S:  SerialNumber=76e7cb38
> C:* #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
> A:  FirstIf#= 0 IfCount= 2 Cls=ef(misc ) Sub=04 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=ef(misc ) Sub=04 Prot=01 Driver=(none)
> E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms

No need to reserve interface 0 below here either.

> I:* If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=(none)
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=(none)
> E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=(none)
> E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=(none)
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Similar here.

> Upstream-Status: Submitted [https://lkml.org/lkml/2025/10/23/130]

Why are you referencing an older patch for a different device here?

Please drop.

> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/usb/serial/option.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 5de856f65f0d..f8bb94f20143 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -1401,12 +1401,16 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = NCTRL(0) | RSVD(1) },
>  	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a0, 0xff),	/* Telit FN20C04 (rmnet) */
>  	  .driver_info = RSVD(0) | NCTRL(3) },
> +	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a1, 0xff),	/* Telit FN20C04 (RNDIS) */
> +	  .driver_info = RSVD(0) | NCTRL(3) },
>  	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a2, 0xff),	/* Telit FN920C04 (MBIM) */
>  	  .driver_info = NCTRL(4) },
>  	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a3, 0xff),	/* Telit FN920C04 (ECM) */
>  	  .driver_info = NCTRL(4) },
>  	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a4, 0xff),	/* Telit FN20C04 (rmnet) */
>  	  .driver_info = RSVD(0) | NCTRL(3) },
> +	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a6, 0xff),	/* Telit FN20C04 (RNDIS) */
> +	  .driver_info = RSVD(0) | NCTRL(3) },
>  	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a7, 0xff),	/* Telit FN920C04 (MBIM) */
>  	  .driver_info = NCTRL(4) },
>  	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a8, 0xff),	/* Telit FN920C04 (ECM) */

Johan

