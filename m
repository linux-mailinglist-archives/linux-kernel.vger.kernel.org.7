Return-Path: <linux-kernel+bounces-868738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA53EC05F38
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4FFE235BF12
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2286315D27;
	Fri, 24 Oct 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CDUp7TWv"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A34F315789
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761304424; cv=none; b=lSVJFPrUo3avyAjoRS8TXQYf8mNN3xcBEvcG1nbdXjhzqK/OV92Bm1JVel8QVEsIIFd/0XYDHY5cZfeDBmVwwQIL1wgcSbVpCslQAR3D26ZKkKGmv/4oHs97h8+md/YZB0GsPpBFl3hYbdqUWS9WS1bA22e8LuY7Q8HcRrxaXws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761304424; c=relaxed/simple;
	bh=/Cs+7CZojpdYOYGDL2af4FDZmEZBa/hcfB21X1zR8RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ob+NkUoP+5Ep/UwKuoKj7UWk5uDq4BVgMsSdVeoVwY+AbEJYJ0OHngiYtCIw5gSTq4o2pU/d0GhgwJNTwes1N1w9U2+Gwa4LU08cUk/QQaUVeZHMs02u2g+mESk7ac4OkJqbAV3kLrC0RPusKwBu3mvc4QC2hcOjBOhhWweZJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CDUp7TWv; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-58d29830058so1996881e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761304420; x=1761909220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iyyWCavapnD3yJLeJKy1rToQ+CHIPizLFi9XGHTmR1Q=;
        b=CDUp7TWvdasXTJDmmUFpL0rTw4FkxayTlgjKLhPltkwFkVh/q9A5shFbe7UVvJaMnl
         Xn5n5fWjhd9SwlvWrWhO1l8uUTnvgfQzK3kuaIKH5EWcFFx/NBOdzTigJGjEvVCsrH8b
         nA7j2FM5w3CIFOseLxvEbWhQAzoWMBG1PTEfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761304420; x=1761909220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyyWCavapnD3yJLeJKy1rToQ+CHIPizLFi9XGHTmR1Q=;
        b=mpUxIvWdRlyH6s6w1UdgoLO7ys8YRSD7dTS+sW6OHdeqelBicrQfHHMN57X3rwCZLu
         Z2924/NnGXZ0DYN8gudYOWWVJzmrsog+WZXl09HrQuJHs5HnUeHp7WoaVPZYkBIWb5T3
         VdBhr40lBqsh6roQvCsParZUtDLDC0n7w84rUIqU6RKcnj6rdS+mm9NL8sjW5XH5auj1
         D7Xz9MuzWaTMiFfL5fDy4rd5Ab7e3MaxD4OvM//rNVU0m1WanCWB4J+dOlauxNCXdHBa
         lvyuxfNtRNGcZA2u+6eu3cWJ4hIGaE9LPBUiwMvE78Ludjf25JlLeyuL0GvAO1RLicXi
         +uhA==
X-Forwarded-Encrypted: i=1; AJvYcCW+egNPoKH5eviBQHwAI6yBp3l9r76YTxFdKL9puFibBW/8QkFYhxWIm6y+fzEMgL39KlApMgi+FgfQwxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcuEhMzpskjMEJBX1CDwKCjuCjEU7q+8sTpqO4knFgObkht4cz
	7/WEgeuGXdy2Y4WHonbKjyjtBQv316HDRW65mP1thVDa7R63cEggL1jheL8oUzz4qBixRszdVOv
	nB/g=
X-Gm-Gg: ASbGncuK/xRXhnfuuhrrz8t6yoKu9yeydFY40LKbFVAxOzz7JRTFtZaJvwwEbHJKWD5
	a/P9a5+Wc7Tma1QndOaWocGwWANKXwYcWBSXbP+pmMb6bb0oD7s+yx3O9hGPha+CcIKw5gXn1eN
	y2xso26xfJIODzVbGAC5xJv6hH2WjBgmTp0bEEDztG41dxnmEa8TUpxfocuNMklogFqHk5c3fC3
	C3VCEXPcYOnzjgZv3Pdw8vPzUP0BJhoSS4YL/xr5K2RBIC2isXebTVqmwcaLLMMKFWMgbNk3KCP
	y/xkWSBgMp9ZIgL6xjgDy1Sql9k+zMC/12VepXv+TxFDJ3zfV6eanB9Evnw3bwL0uLrHEJCJAo8
	sw5DZIAijkU3qMvtpSP3QgS0+YrAGS/GoVXDdt8Yskle7iNEeHkPJALpB5JiGRS35i0ah3Yp+/6
	tNM1zvqX1j2r4kYz4r4q3mLwtuU7y3OdctoV8GAw==
X-Google-Smtp-Source: AGHT+IHJt+vaMoLu70YLJmOKS97ySBGkjbGIaAgMwVhJtVp7X5sZ86XcNi9rxszYUZbTLu25hqmQkA==
X-Received: by 2002:a05:6512:3d0d:b0:57d:a4e9:5b00 with SMTP id 2adb3069b0e04-591d8552b69mr8813202e87.30.1761304420402;
        Fri, 24 Oct 2025 04:13:40 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4cd12f4sm1567047e87.26.2025.10.24.04.13.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 04:13:39 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-58b025fce96so1684116e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:13:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXseikD1/MzNkyokzHPpxbKNoX4wApzwX2TaWAQFapdV75gidSwdP6L/3/Xzhv/w+vCjMLDEvPOL8lLI5Y=@vger.kernel.org
X-Received: by 2002:a05:6512:1549:b0:591:ec77:2c9f with SMTP id
 2adb3069b0e04-591ec772e83mr3852138e87.36.1761304419304; Fri, 24 Oct 2025
 04:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024-fix-uvc-v3-0-b7f83c012ca7@realsenseai.com> <20251024-fix-uvc-v3-3-b7f83c012ca7@realsenseai.com>
In-Reply-To: <20251024-fix-uvc-v3-3-b7f83c012ca7@realsenseai.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 24 Oct 2025 13:13:26 +0200
X-Gmail-Original-Message-ID: <CANiDSCt30UjEEZd8-8Qsuqn_Ks2pOBE1awOwmZVsHPnPHVQ6FA@mail.gmail.com>
X-Gm-Features: AS18NWB81SOOrW67C5lrHubwLteemy12mYDThqflKnvj3xYCkQLGwSJmGHydKqE
Message-ID: <CANiDSCt30UjEEZd8-8Qsuqn_Ks2pOBE1awOwmZVsHPnPHVQ6FA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] media: uvc: Add D436 and D555 cameras metadata support
To: yogev.modlin@realsenseai.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Yogev

Thanks for the patch. Some minor nitpicks inlined.


BTW, is there a way to programmatically detect if a device is
RealSense with D4XX metadata?

I am thinking that maybe all have a special entity id, or any other
way besides vid/pid.

I am asking you this, because if you could find a way to identify the
camera you could implement something like uvc_meta_detect_msxu:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/usb/uvc/uvc_metadata.c#n170
Instead of creating quirks for every model.


Regards!
On Fri, 24 Oct 2025 at 07:50, Yogev Modlin via B4 Relay
<devnull+yogev.modlin.realsenseai.com@kernel.org> wrote:
>
> From: Yogev Modlin <yogev.modlin@realsenseai.com>
>
> Add support for Intel RealSense D436 and D555 depth cameras metadata.
> These cameras use the D4XX metadata format for transmitting depth and
> sensor information.
>
> The D555 camera uses UVC protocol version 1.5, while the D436 uses
> an undefined protocol version. Both cameras require the D4XX metadata
> format flag to properly handle their metadata streams.

We ask the lsusb -v output for every quirk we add. Could you provide that?

Thanks!

>
> Signed-off-by: Yogev Modlin <yogev.modlin@realsenseai.com>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index dbdacc64ea6b..6f0053a78123 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -3223,6 +3223,24 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +       /* Intel Realsense D555 Depth Camera */
> +       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +                               | USB_DEVICE_ID_MATCH_INT_INFO,
> +         .idVendor             = 0x8086,
> +         .idProduct            = 0x0b56,
> +         .bInterfaceClass      = USB_CLASS_VIDEO,
> +         .bInterfaceSubClass   = 1,
> +         .bInterfaceProtocol   = UVC_PC_PROTOCOL_15,
> +         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +       /* Intel Realsense D436 Camera */

The list is sorted by vid:pid

Please move the definition to the correct site.

> +       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +                               | USB_DEVICE_ID_MATCH_INT_INFO,
> +         .idVendor             = 0x8086,
> +         .idProduct            = 0x1156,
> +         .bInterfaceClass      = USB_CLASS_VIDEO,
> +         .bInterfaceSubClass   = 1,
> +         .bInterfaceProtocol   = UVC_PC_PROTOCOL_UNDEFINED,
> +         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
>         /* Generic USB Video Class */
>         { USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_UNDEFINED) },
>         { USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_15) },
>
> --
> 2.43.0
>
>
>


-- 
Ricardo Ribalda

