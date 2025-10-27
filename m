Return-Path: <linux-kernel+bounces-871001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7902C0C363
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB91A4F0E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F25D2E54B2;
	Mon, 27 Oct 2025 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QgFOZJaJ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32AB2E54AA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761551818; cv=none; b=IQiUcA/22YYrXQuw8xsF+6HZ0BSFI7mFoITBUjrIKV5fFbPxHLK/p21Z24ck/YzH31jjbBVZqVVZ+dm1QM5d9yLKKnUjYmJsdEJumaPrNarDSp4b7UkxxJFD55VqQXxBNWMu+gP/+xvZmhwWWhbNYmJyYYXCYnNWH5fp2y6mEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761551818; c=relaxed/simple;
	bh=lJ/3SAcM3T8zTwBQdR+lRVXwTM1fm1eO6zXcNGCaGec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttMFEufBDJDNWofW/g02RsvfYPmpeLn8NZSS7r5Oav2CJwsBYMVJiuODrHw3xhYsB3l/dEa+xar5KhVIVi7IjmxurrO28nMfj/AZ6oor5KWIm+pkhHorcTLGiGZGTSwsFwbD6bZJzAzoDI59XJOkoqnPJuseSSwQQ1QQl248Tp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QgFOZJaJ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-592f600acb3so78595e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761551814; x=1762156614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EYCA50IEKptJTAvmVGiOlvBf9mu8auYxLp0+T6tKlkE=;
        b=QgFOZJaJJgBvGzO5ccm3RMMpttEQcyiUSs/V/nlU3MX+zQ1rsUdgQ3zK/nD0DwUht9
         LSOwQhlmUR86BqDQ7iw5b4YGgGa7tI0CyENylKaIw8LTXjK8Eh2QL1N00seHnohpfFwT
         Hs7eKMByd+lRNAK6tzaYA9QzwMhBmcfDn2Nx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761551814; x=1762156614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYCA50IEKptJTAvmVGiOlvBf9mu8auYxLp0+T6tKlkE=;
        b=ls9HvlYvhsiAkPfNb/bYIp5FcChasjBZYBgNHENAyo+VTdNOv62P/6h8KQ+visXiaT
         G6Z9TG5Nw2OWpg9D8be37sKPtf3ctgcijC/llbJN5K9buT013xUG0CtuWKjo8UBI6jP0
         hELaL+0nGxyLap2sN700UmPQEcvwXk3aN8vxjvrJ8XXme8BmwkPWRO+YQI2wJ67XqqGI
         yFkk6IM3q2hzbGXPz/xuJW3K/xfXQPV782j1+4Hx3jMeT3ZeMtPrRAHLW0zQbdJ3iHL+
         h8a+t+x+2Zfexo4DFOFEjjCziHsap7VZnrzIcYYBUe0dAjEkC5hbEuIq4R51T2OYcrCs
         LFdw==
X-Forwarded-Encrypted: i=1; AJvYcCXzsWTWAWGb5ThIbpNUtLqvXrr/OSTJoITGTJVeWIvzrWX01khdJU2RM2tOPxrIBfrwHOsdh6B/NCvtAiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7C9mr+iaYMWHK0VvJDpQ6NicbWwPLoaww2ci8DdJ3Iwz+M/+
	DuLBA9oGQoTJr609dDmGHGc8yy4aXs0VQBHsxx+dudHAJ0j0H2Nko7MKXiRd3jkSz9l/HdFm0FV
	ob98=
X-Gm-Gg: ASbGncvb/1jKheDKtaxpMYp6hdtghctkPx8dSgxTh8EvQ/kIxX9VaJV1BAusDOOU+jU
	5r2/400VJsVXAZkCYscpMCGnHeZuCCXa96qIEwDtzLUnGX1Sm/GgVswQgiFZiP/SPKoGfYBKiQc
	gs3Wxsnb95QYlChlA7fZ3/RO1pQ+/BDkEh9CrWGcJt7QDdghoFZBzz5sUoGUMPdJtg8YxpS0zWF
	n4TIDXIsnJwjE/vH2zBIYKZ1k0nweeuqs8i0SwBn1WIBsOcB5KWX9fXx60CjcaZCFUj00NoU3ce
	ylYoxJyEURZQ6OqekAWm6l8MUm+qX9pUG4Bx3EhcaS/heKU+b8LBGb/IK7iKySzxOJlL5IznP8Y
	qVxuW+BZj+gqDNf0Q0udiiyJmM3vKjP9v+6+1p4dL03PO5MI60xPV4EoWZ97MoD8Qjrcnsn2Rki
	3NqLEuhIN0QWpQN17COXHjTJnXHy4lNswl+GkYzmzAKg==
X-Google-Smtp-Source: AGHT+IGQkXwZNEF5FTIPJvPxhYuE6H9pwS5X/0GTtOiyr0rDFwo+HI08ftIkuGmgAp9eRAPkjBY7uA==
X-Received: by 2002:a05:6512:3d91:b0:57d:720:9ebb with SMTP id 2adb3069b0e04-592f5a6f84cmr4267710e87.55.1761551814152;
        Mon, 27 Oct 2025 00:56:54 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f74b9bsm2178834e87.88.2025.10.27.00.56.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 00:56:53 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3637d6e9923so42118101fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 00:56:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmINVUmHzICHs5ertueVoMIUYXeOTR8+GzJe87e0twsChT+a6zR+amsGkso2j7YHQAAxTzpFkmb9k+JbI=@vger.kernel.org
X-Received: by 2002:a2e:b889:0:b0:378:ec14:f79d with SMTP id
 38308e7fff4ca-378ec14fc0amr22232901fa.22.1761551813136; Mon, 27 Oct 2025
 00:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026-fix-uvc-v4-0-610eb1329600@realsenseai.com> <20251026-fix-uvc-v4-2-610eb1329600@realsenseai.com>
In-Reply-To: <20251026-fix-uvc-v4-2-610eb1329600@realsenseai.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 27 Oct 2025 08:56:41 +0100
X-Gmail-Original-Message-ID: <CANiDSCtkhaVN_7FawWYVX_DX0anLtU1tkJdRyEDinbkLdR8WDg@mail.gmail.com>
X-Gm-Features: AWmQ_bmdylxnXvGozSI-9olS9rUjE38ysBuzOnS-jfp_ekh1UPYFoPJfi-5xoUY
Message-ID: <CANiDSCtkhaVN_7FawWYVX_DX0anLtU1tkJdRyEDinbkLdR8WDg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] media: uvcvideo: Add D436 and D555 cameras
 metadata support
To: yogev.modlin@realsenseai.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

HI Yogev

On Sun, 26 Oct 2025 at 17:43, ymodlin via B4 Relay
<devnull+yogev.modlin.realsenseai.com@kernel.org> wrote:
>
> From: ymodlin <yogev.modlin@realsenseai.com>
>
> Add support for Intel RealSense D436 and D555 depth cameras metadata.
> These cameras use the D4XX metadata format for transmitting depth and
> sensor information.
>
> The D555 camera uses UVC protocol version 1.5, while the D436 uses
> an undefined protocol version. Both cameras require the D4XX metadata
> format flag to properly handle their metadata streams.

This is the lsusb -v output previously sent to the ML:
https://lore.kernel.org/linux-media/wm5gfxhvifqamhatze5pfeyzfm6hnyknd4ww2bf75nwmw3okyn@7jmk66eibia5/

>
> Signed-off-by: ymodlin <yogev.modlin@realsenseai.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index dbdacc64ea6b..cf3ee33cdfd4 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -3196,6 +3196,15 @@ static const struct usb_device_id uvc_ids[] = {
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
>         /* Intel Realsense D405 Depth Camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> @@ -3223,6 +3232,15 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +       /* Intel Realsense D436 Camera */
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

