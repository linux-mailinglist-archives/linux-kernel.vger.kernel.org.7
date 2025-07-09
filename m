Return-Path: <linux-kernel+bounces-723179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5F4AFE40F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6915A7B4D8C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D187284B3F;
	Wed,  9 Jul 2025 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJVkVogT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D710628466F;
	Wed,  9 Jul 2025 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053297; cv=none; b=M7FqFmrlcb0qSjHWh6NvVk0LSXCS4QTVrG7OM9/o/D0VYqK7FeZvKH9G+P+dcbfkROat3Gz6zwIG34o/lz0+vt4YVQ0Eynmh/4AVFRI9Pil52OfBANsaUsohwtwahLUhllXVUJiDR4Bkpy9oHju0037qUPApspp8tcm3qYHPf14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053297; c=relaxed/simple;
	bh=YGLRzooRqwe/wzG87DcNhxwHzkAJwO4orqDPY2gzF5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gq0bimfksodyeMU4ifUGOSV06VHXFz7lKTtj4isiN3EKLBcA0TUvR/OmrenuIeFoQHn/OhZ8J3UBuKVfjM2O9YmKwBPp/t51khfaLV5WUw4uOSZlzh7Buc0C3lXFvpqv8ncXRGBmPTUlvcOdJYav4Idxv5f7mt94pFypyGUgIfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJVkVogT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DFCC4CEEF;
	Wed,  9 Jul 2025 09:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752053297;
	bh=YGLRzooRqwe/wzG87DcNhxwHzkAJwO4orqDPY2gzF5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJVkVogT9CEbbbC8a5k8BBzytvvu+Sp1BHmIXBq/rNVWhk0YnOAbJYWWE5P/uxNp/
	 Yf/d8sexxpOS5B74Whuhck18GHh8HaJyEErlGzZ6VSz83eSICEPIDwkSIjlfYoPZG+
	 xRm3nDWhzOxGdcBpRYcnTRtODeSsR0IBi5YifppdJEaGC1RpMIlOxdBzM/qfHDCCi1
	 80kpz8cqUW/BejoMUxUwbvuISL43dE5/5C7+c6vDn9S+2b17POgUQSsfkT3t24MrNC
	 GX3FSkCL13mK83nwIks3DEtxWEPiQ9iMaAGTx7sArSJ1esukFTNQyrV73pXYBh3IWr
	 lD1KZju4Z8DSA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZR61-000000001ML-34yz;
	Wed, 09 Jul 2025 11:28:10 +0200
Date: Wed, 9 Jul 2025 11:28:09 +0200
From: Johan Hovold <johan@kernel.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/1] USB: serial: option: add GosunCn GM800 series
Message-ID: <aG42KblIHdoCxddQ@hovoldconsulting.com>
References: <20250701100002.798372-1-amadeus@jmu.edu.cn>
 <20250701100002.798372-2-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701100002.798372-2-amadeus@jmu.edu.cn>

On Tue, Jul 01, 2025 at 06:00:02PM +0800, Chukun Pan wrote:
> Add support for GosunCn GM800 series which are based on Qualcomm
> SDX55 chip. The ID of MBIM/ECM/RNDIS mode is the same as GM500.
> 
> Download mode:
> 0x1402: DIAG + AT + MODEM
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=305a ProdID=1402 Rev= 4.14
> S:  Manufacturer=GSW
> S:  Product=GSW_GM800_123456
> S:  SerialNumber=12345678
> C:* #Ifs= 3 Cfg#= 1 Atr=80 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option

This line no longer reflects what the kernel binds to after you made the
matching more specific in v2.

But why not bind to the DIAG port here and in the other compositions?

> RmNet mode (old):

What do you mean by "old" here?

> 0x1403: DIAG + AT + MODEM + RMNET + ADB

> RNDIS mode:
> 0x1404: DIAG + AT + MODEM + RNDIS + ADB
> T:  Bus=08 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=5000 MxCh= 0
> D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
> P:  Vendor=305a ProdID=1404 Rev= 4.14
> S:  Manufacturer=QCOM
> S:  Product=SDXPRAIRIE-MTP _SN:12345678
> S:  SerialNumber=12345678
> C:* #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=896mA
> A:  FirstIf#= 0 IfCount= 2 Cls=ef(misc ) Sub=04 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=ef(misc ) Sub=04 Prot=01 Driver=rndis_host
> E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
> E:  Ad=8e(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=0f(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=(none)
> E:  Ad=82(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> E:  Ad=04(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms

This is one of the PIDs shared with GM500 and which, since your v2, will
no longer bind to the ff/ff/ff interface that it has.

Is that intentional or a bug in v2? Either way, this needs to be
addressed in some way (e.g. explained in the commit message).

> @@ -2382,9 +2382,13 @@ static const struct usb_device_id option_ids[] = {
>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0xff, 0x40) },	/* MeiG Smart SRM825L */
>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0xff, 0x60) },	/* MeiG Smart SRM825L */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
> -	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
> -	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
> -	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x305a, 0x1402, 0xff, 0, 0) },		/* GosunCn GM800 (Download) */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x305a, 0x1403, 0xff, 0, 0) },		/* GosunCn GM800 (RMNET, old) */

> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x305a, 0x1404, 0xff, 0, 0) },		/* GosunCn GM500/GM800 RNDIS */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x305a, 0x1405, 0xff, 0, 0) },		/* GosunCn GM500/GM800 MBIM */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x305a, 0x1406, 0xff, 0, 0) },		/* GosunCn GM500/GM800 ECM */

According to commit 08d4ef5cc920 ("USB: serial: option: add GosunCn
GM500 series") all of these have an ff/ff/ff interface on GM500 which
will no longer be bound after this change.

> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x305a, 0x1421, 0xff, 0, 0) },		/* GosunCn GM800 (RMNET) */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x305a, 0x1422, 0xff, 0, 0) },		/* GosunCn GM800 (EAP) */
>  	{ USB_DEVICE(0x33f8, 0x0104),						/* Rolling RW101-GL (laptop RMNET) */
>  	  .driver_info = RSVD(4) | RSVD(5) },
>  	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x01a2, 0xff) },			/* Rolling RW101-GL (laptop MBIM) */

Johan

