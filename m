Return-Path: <linux-kernel+bounces-871003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6C2C0C35A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 94EC834882E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331242E5B08;
	Mon, 27 Oct 2025 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KqHI9Mfl"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE1A2DF710
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761551854; cv=none; b=QrNPEiHR60G3vufNeHZyBoK9OVR7VZ2DPeQ4/4lmZPwidjcCiYLc5oa3slO2tiD6PZfOLd6Wh12R+vasQmri1c/PcozWcuCw8baax/WPXvYgBONlkC6/FJeH37raHWPlSdHuUSXLj0sTh2kU831BH4H8GneuXjcdozS+C69T5ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761551854; c=relaxed/simple;
	bh=Z1okCuulMLIr1YTQJjrqsE4HKq0fhd6AoRVUWKoq970=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5eruMgw9cYX4jEz8w6u80mw7y4lP54ORmDm0QJNumHZaEeRyi6z9+xnWB4Fnb+hVxuYUyAh0YvbBtnpvcxfRQWHy6jVS9hRaBdEx1E3uiw8YGNMpFeRsnEvgpQFOBYf8xY+0tm3VQcyN3zh1ong5wHAzh9OkIPuTd8HdCvxAIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KqHI9Mfl; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-592f9400b04so3730318e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 00:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761551851; x=1762156651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ayv+21ceSp1bYlkzspFJkEJSM3a78Z5afjxNdRx5mpY=;
        b=KqHI9MflLL6rhxXRmmhN8cCDpF1OhBONpUcgsCZyAOJtPauJQsFt1gH6jY/1m3pRsv
         1prLq+PszT25li4BJ5qp9KwBXchLGS5D7MdJ/a8t4A3Ps1/S2cEzDYyuatz+6fcsJgTW
         xJTyzk1L7vdN0htVBTv2BVjT+HPjvxaE+zWfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761551851; x=1762156651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayv+21ceSp1bYlkzspFJkEJSM3a78Z5afjxNdRx5mpY=;
        b=PX3fpupBt4FBQLL5Qe1EOpOnjuXOHyfQ89xwiW2+/WbuLJe1eVu17mqhKwU2lA/Y6S
         w7cpIFNkT2qkBbGWyn3pVRjKToVrCRduaf7aJyjLYFmz8QjSsf8PCnHyqIOSGK5nTQKi
         8Ujzmt6O2bUw78tIJe1ECSEHtCzbD0rhISrDpLOZFU3L+2nF5AB206AsNu6TC3oV7srf
         iN6Yp/gjFLKWp6uYdwR9KmscPZw1ecDB1MVuSW/7n50GHZ9BMnhANvD0TY/+vOL8xJkq
         CsfKb1fC98bFHfh8pmCUnWWAYh4fMaatvUpBUZSuxyc+9poldzum2u9N8BFvOJVVERa/
         Uvlw==
X-Forwarded-Encrypted: i=1; AJvYcCUB0dXiTbHtXVaOIWvR4NPUSaOjXRDyyO0kRqqRDTED3xQqxSxaKfV6eCiaB4g6Ct95FLgppi43Y87gYLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNHiLwDUCIfCM6d8X2NLlnkgcsafyNRuuk2ywupeo+NupFJscv
	+7WSZRUdXIsBYc3i+mhOtAbEnqYnZ1GEklb6x4+WfjV0Kc2LnTRMwwJZYgNvP1JHRPcDMv+FwNA
	+5VM=
X-Gm-Gg: ASbGncu77aC6DcXMnlQSJigqvSJ1XcJ4UsGRbFcYJBqbL2AL50yzMjSon26paRuPr7X
	zn8XVfHbS8ng32Vt1v5ZmK4ZlJxKM99j5Kxlt83vYvPrUPZfiA5qRz1tu+vgJHcFSUefuGXrWSS
	a5KcxtWLP+db9BFNJpwW5o/vajiW4aRQuaL51UXx+giCkoYQVmAuc+jvZDJkeTISSXfxO8zHDDD
	9+qRKgq/y4opeI+rD2iwU5itH/PpWfAUJfgVWwkuGXHrNXiZEP7RAwjJ+LyT6hpsY4rWOY3IpNC
	WvLUic5TJeNxN00i4c4jsd4a55raz8Uni5bOrooZ9ajyCZc9EMA6W4Ob5n3PZbeZJOMJrt0h44K
	XLg98y0JnQZT9wd0+y1B5e9/Tr0OVDI1w0JlFyYVn4ydJlWtnbpTHK3YxCPT/rmCJQGqoy733X9
	daZdRHI79A+w2GZl0q+4R2bcDELtWVnW9fPncjgzm9p56VmtlErJDI
X-Google-Smtp-Source: AGHT+IFdTmRJUn7P7rE+ZuiymmvBerTnrd4+CuT/SOOizgyUqJDXXM77ZnDWIxEhdDLFvPgLFnXIrw==
X-Received: by 2002:a05:6512:3e27:b0:571:1bdc:14d9 with SMTP id 2adb3069b0e04-591d84fc6f6mr11527027e87.24.1761551850643;
        Mon, 27 Oct 2025 00:57:30 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41d14sm2178776e87.9.2025.10.27.00.57.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 00:57:30 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-378e603f7e4so33054291fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 00:57:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWJgsAtxrjIml1o+1YwC78Q5ea2K8e0/WARn+81EJ2Zs38jly9pu+oLwcpx8sokYWuVOiif1gBuXmIX4M=@vger.kernel.org
X-Received: by 2002:a2e:b8d6:0:b0:378:e108:7b5b with SMTP id
 38308e7fff4ca-378e1087e28mr31341341fa.5.1761551849708; Mon, 27 Oct 2025
 00:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026-fix-uvc-v4-0-610eb1329600@realsenseai.com> <20251026-fix-uvc-v4-1-610eb1329600@realsenseai.com>
In-Reply-To: <20251026-fix-uvc-v4-1-610eb1329600@realsenseai.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 27 Oct 2025 08:57:14 +0100
X-Gmail-Original-Message-ID: <CANiDSCshOoYXh_HzCQyw_NMKs46vXb1LQhtwhM-OK7z7yz_nvQ@mail.gmail.com>
X-Gm-Features: AWmQ_bk_LATzLIgwIcd_8DVJum-MIVKytMBTGVubUq-bnzBKxTtqI7cwC8Qub7A
Message-ID: <CANiDSCshOoYXh_HzCQyw_NMKs46vXb1LQhtwhM-OK7z7yz_nvQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] media: uvcvideo: change comment to 'Intel RealSense'
To: yogev.modlin@realsenseai.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Oct 2025 at 17:43, ymodlin via B4 Relay
<devnull+yogev.modlin.realsenseai.com@kernel.org> wrote:
>
> From: ymodlin <yogev.modlin@realsenseai.com>
>
> RealSense branding is now independent of Intel. Update all driver
> comments referencing "Intel" to "Intel RealSense" to reflect
> current ownership. No code logic changes.
>
> Signed-off-by: ymodlin <yogev.modlin@realsenseai.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index fb6afb8e84f0..dbdacc64ea6b 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -3142,7 +3142,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_DISABLE_AUTOSUSPEND) },
> -       /* Intel D410/ASR depth camera */
> +       /* Intel Realsense D410/ASR depth camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3151,7 +3151,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D415/ASRC depth camera */
> +       /* Intel Realsense D415/ASRC depth camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3160,7 +3160,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D430/AWG depth camera */
> +       /* Intel Realsense D430/AWG depth camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3169,7 +3169,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel RealSense D4M */
> +       /* Intel Realsense RealSense D4M */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3178,7 +3178,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D435/AWGC depth camera */
> +       /* Intel Realsense D435/AWGC depth camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3187,7 +3187,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D435i depth camera */
> +       /* Intel Realsense D435i depth camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3196,7 +3196,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D405 Depth Camera */
> +       /* Intel Realsense D405 Depth Camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3205,7 +3205,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D455 Depth Camera */
> +       /* Intel Realsense D455 Depth Camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3214,7 +3214,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D421 Depth Module */
> +       /* Intel Realsense D421 Depth Module */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
>
> --
> 2.43.0
>
>
>


-- 
Ricardo Ribalda

