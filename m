Return-Path: <linux-kernel+bounces-723222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E35D8AFE49E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D72189CAA4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD78288509;
	Wed,  9 Jul 2025 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3qeLASa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B832877E2;
	Wed,  9 Jul 2025 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054853; cv=none; b=t7/c0QuCWK1qnB5Gv7xATDIgsvjLVdUcBopN6dsLzm47Kqgp1ZzWchJmYYFeqhsjtAkc3+YjHmIQZZ8OGdqzIrLDB6wvwVdJXaNEO+wl8hDh/YoviZTiElzFmC0RemFMHj5yvRg2ypyBDXCrkccpblO4v23uAAshU4EMic/nmsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054853; c=relaxed/simple;
	bh=Cm2c3J7Uf/hL7IW4HuPxLzbo6FU8AzX/Hvb15wde1f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWUklDMR0JszaRnPoF65NpU7orYF4jjJRFDwTdiFOnq10fGD43228HFE2Q/XR72PxFBLMfG1qCNv3gD6tlD5/P4BBaeEV3KuzT/asl4LF/EPTaxGWRNTN7iz5kRK3cUVd6Pa7yi3ns7Y4g+MHmM9WVACi1OfWnvO0IlnQR04eM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3qeLASa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEA0C4CEEF;
	Wed,  9 Jul 2025 09:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752054852;
	bh=Cm2c3J7Uf/hL7IW4HuPxLzbo6FU8AzX/Hvb15wde1f0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3qeLASaWgKzb9eA/weQrvoYIms/5ntLE/hQRJ0JVMEHsOORUUrNg34yLQhKGYvCe
	 5VzjSl/77TLe/4FIE4ttPXLXxsvqde11mijUlMtyu7WvXc1EesSGCtRb5zKDxL4RyY
	 Ti35JHP3ZBcrQhPlxkjo0+wT749IjiKtbh+UPBjDA85mC9EjD9Ieh3PeoTHvrDyGfI
	 VRTqL1YrC8/Ws0Nto2Y7emJsCe/+oBKrxLf/7IP5PF/AIjKx7ANtxb1lhZ2oWZHePP
	 0D22dmah/sEAt+1U7AXItRY0luTw20HxSAI1CroBT02cF0shfHZnElX+/1UyCk7gzC
	 o38Ta5YmyJ+ZQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZRV7-000000001mx-3Nrq;
	Wed, 09 Jul 2025 11:54:05 +0200
Date: Wed, 9 Jul 2025 11:54:05 +0200
From: Johan Hovold <johan@kernel.org>
To: Ryan Mann <rmann@ndigital.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] NDI FTDI USB driver support
Message-ID: <aG48PYdWZXwbrd5S@hovoldconsulting.com>
References: <YQXPR01MB4987FF89C01297FA6F1B0C9FDF42A@YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQXPR01MB4987FF89C01297FA6F1B0C9FDF42A@YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM>

On Fri, Jul 04, 2025 at 05:25:43PM +0000, Ryan Mann wrote:
> From: Ryan Mann (NDI) <rmann@ndigital.com>
> 
> NDI (Northern Digital Inc.) is introducing a new product called the 
> EMGUIDE GEMINI that will use an FTDI chip for USB serial communications.

> Remove the use of the baud rate mapping for NDI Aurora.

Your commit message should explain *why* a change is done.

This bit also looks like an unrelated change that should go in it's own
patch. It also no longer reflects what the patch does.

> Add the NDI VID definition as "FTDI_NDI_VID" into the ftdi_sio_ids.h.
> Add the NDI EMGUIDE GEMINI PID definition into the ftdi_sio_ids.h.

No need to be this specific, just say something about the adding the
device id which uses a new vendor define unlike the older products.

> Add the NDI VID/EMGUIDE GEMINI PID combination to the USB_DEVICE list.

Not needed.

> Signed-off-by: Ryan Mann <rmann@ndigital.com>
> ---
> V1 -> V2: Email-to issues fixed
> V2 -> V3: Email formatting issues fixed
> V3 -> V4: Email formatting issues fixed

You clearly left out some changes here since your initial submission
also added ids for "future" devices.

There was also some changes related to the two NID quirks.

>  drivers/usb/serial/ftdi_sio.c     | 4 ++--
>  drivers/usb/serial/ftdi_sio_ids.h | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> index 6ac7a0a5cf07..e5d7cce83a72 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
> @@ -801,8 +801,8 @@ static const struct usb_device_id id_table_combined[] = {
>                 .driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
>         { USB_DEVICE(FTDI_VID, FTDI_NDI_FUTURE_3_PID),
>                 .driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
> -       { USB_DEVICE(FTDI_VID, FTDI_NDI_AURORA_SCU_PID),
> -               .driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },

Why are you removing the old product from the id table which will
prevent the driver from binding to it?

> +       { USB_DEVICE(NDI_VID, FTDI_NDI_EMGUIDE_GEMINI_PID),
> +         .driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },

Your patch is also white space damaged (e.g. tabs replaced with spaces,
which prevents it from being applied.

Try sending the patch to yourself first and make sure you can apply it
with git am.

>         { USB_DEVICE(TELLDUS_VID, TELLDUS_TELLSTICK_PID) },
>         { USB_DEVICE(NOVITUS_VID, NOVITUS_BONO_E_PID) },
>         { USB_DEVICE(FTDI_VID, RTSYSTEMS_USB_VX8_PID) },
> diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
> index 9acb6f837327..0cb33d257973 100644
> --- a/drivers/usb/serial/ftdi_sio_ids.h
> +++ b/drivers/usb/serial/ftdi_sio_ids.h
> @@ -203,6 +203,8 @@
>  #define FTDI_NDI_FUTURE_2_PID          0xDA72  /* NDI future device #2 */
>  #define FTDI_NDI_FUTURE_3_PID          0xDA73  /* NDI future device #3 */
>  #define FTDI_NDI_AURORA_SCU_PID                0xDA74  /* NDI Aurora SCU */

Please include a newline here to separate the two sections.

> +#define FTDI_NDI_VID                   0x23F2  /* NDI Vendor ID */

And drop the comment here.

> +#define FTDI_NDI_EMGUIDE_GEMINI_PID    0x0003  /* NDI Emguide Gemini */
> 
>  /*
>   * ChamSys Limited (www.chamsys.co.uk) USB wing/interface product IDs

Johan

