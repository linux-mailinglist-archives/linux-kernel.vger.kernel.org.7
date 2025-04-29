Return-Path: <linux-kernel+bounces-625608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 303A2AA1A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 20:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96EE61739F9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 18:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B5625335B;
	Tue, 29 Apr 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i1Xbpg6R"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7F51A5BBB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 18:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950925; cv=none; b=tTNzB5RwRb4ik7cYqIMges3aLresUeZTfnawpgm3yIASp5I8HP2/WsDCPK6q7Pn8+aRdgAENs78RjXUbVvXR2ZJKSszjxkqbR4lhY47ihAc13qWxWvHlqDkN8RnK3fsybcdscjKl5B7MKTq0+ZyQ+/+ZfOXvNKJyt2c78x1L6jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950925; c=relaxed/simple;
	bh=mkXDubZTtGjdsVqB/m8cDnv6+zvYQ+MLCYStp7lXc9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jaV5hStywRBgCNDhFmIkyBUctU6xha8g83XFvSM8VhALZeXXSfqKWAaO6dedQPf5esOQNsaKGTAqxlrErGwlod9gCp7o08TxQ3cwrVc3d273zwsxrsp0l8uoaUKGuVh0lDL67FuiVYKlbm7cS2Pk93bKBoNHrNILG7h9d8tdjss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i1Xbpg6R; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30effbfaf61so1624741fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 11:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1745950920; x=1746555720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BlQVHM9+ACV5wsklWYH5VrfoL8z198r/GHX4ua1YlzU=;
        b=i1Xbpg6RN4sOwFNhekvto+4qYClruX6Q5Tfq8O3HV+2CHg9WPLKaE0ofVmRNz2GNKe
         5mAMJ7PqkjwjvrBi0kRNg0DAX1ZISuSJSl0s6qpzULeb7pwaIoVTgfMpQEzdvntRHssw
         3MLC+ApA1LwFcMExpF3MOrmBJaEnZkr6kz6F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745950920; x=1746555720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlQVHM9+ACV5wsklWYH5VrfoL8z198r/GHX4ua1YlzU=;
        b=SHAwduQLXLJrNpFS2oZreOVXRKjnHTdH5fk/L3bcg6h8dTF3jDXDTcFkTnmyHwOSlC
         SDm0te2uX1f77Dtc9RNviGRmflSrssZcLWQmuCoE/q3Tsv7/nXossdBhTU4nE4Uv83lp
         CLfgShmSiAw4VKhSeKLNEGfprBeCjORm0snXWIj1Z/TAaUf3EylluV9mRHfJkwqvg0kk
         WF6WaizqPl0N+UyNTnDflR7p2yA7ytjtTT2ZT7zFK1VWdTBzR1naketKaHa7O3P4EmeS
         IlebtWVvA1yjM8RVgXvQLJG+qbC2xJsp+Tyxn8ZTdYJSEQuEJXZxqI9RwNMEgDwwx5I0
         6rCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW33o67wRyCE5Rv3RGwEJJCQVYy8FXa+Cs85TTZyqPpFbLVSSp2XdtO5sGRDKupbYzTuth2Cumlm7WUejg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhfk4EjvOJKViIqJpRnZVEF43RLFUESpeHQcHpfn6gy5V4T6uu
	Wf0hdswhU5C43FC1vKN+oqci7H88tHM3B1ShBkYwSuxIOHENIMEk7a51n90hGlKUSzXFEYFl7CA
	=
X-Gm-Gg: ASbGncvZPsvHdPxRvhJkntVsU+UKQj2+7JYjTc8Nb5aIAIJTNa7xSUoJHt3AEpI8xj1
	8M3DCAYR2lTYDBiVsQrDX+wG3/oYcVb0D0BpWT1MFFTvS4o2Fy1jW+WtMcQ/hxciX4GjnLnB6NV
	8KUUeMPG26kBsRX+alWnCS1MtJObC2pH/CzkjNXETQUhESOz/poHx9gncgwDoudEC5ZJvlJQ5GX
	eBSLQMIxrXFSFjcmha963xIBfJxtkuK1pUcXrqqdI2xvy9pvz9l5OjOqEBLHhae9Bs1FgvY20Bl
	mkBvTsgXTArj2qAxmpc7uae6PCn4YncVh13E3+GfS+j+DWKipWfkX+C8eAXOARnj+dZpXhyDnGQ
	GsUEL40CC/+4wFHM5JA==
X-Google-Smtp-Source: AGHT+IG2SeRPWMsiL9zuUs2c2ocFI9JsErB6+BrUPNjHuxeAaM3WNmhD/2nXfY7bsii5RDvnBjLVfg==
X-Received: by 2002:a05:651c:146c:b0:30b:ef8f:cc94 with SMTP id 38308e7fff4ca-31d46be313cmr14023081fa.16.1745950919559;
        Tue, 29 Apr 2025 11:21:59 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-317d16a84a7sm25650531fa.80.2025.04.29.11.21.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 11:21:58 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30effbfaf61so1624561fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 11:21:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWbJ0VLjjllMCMyeyCBM/SU2+vL2tRMA+ea7sDdQWDX3GDr3IFpYohS+EngSERbwDghhEcmT1ZgYug/zco=@vger.kernel.org
X-Received: by 2002:a2e:bcc8:0:b0:30b:ee0c:8475 with SMTP id
 38308e7fff4ca-31e669627ccmr941941fa.15.1745950918375; Tue, 29 Apr 2025
 11:21:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429-keep-sorted-v1-0-2fa3538c0315@chromium.org> <20250429-keep-sorted-v1-1-2fa3538c0315@chromium.org>
In-Reply-To: <20250429-keep-sorted-v1-1-2fa3538c0315@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 29 Apr 2025 20:21:45 +0200
X-Gmail-Original-Message-ID: <CANiDSCt-v2VUAuNKDk43Cf8MF+_xuaxTkw4reupcfH7VzFPnWQ@mail.gmail.com>
X-Gm-Features: ATxdqUEdv7pXiTC1YfEzM0o9ZFpTlZAODeIyOdjsrykfx7v40dmQ6VVhMlIUAOg
Message-ID: <CANiDSCt-v2VUAuNKDk43Cf8MF+_xuaxTkw4reupcfH7VzFPnWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: uvcvideo: Rewrite uvc_ids for keep-sorted.
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hans@jjverkuil.nl>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Apr 2025 at 15:47, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> keep-sorted is a tool to check if the code is sorted. If we enable it in
> media-ci we will automate some of the boring comments.
>
> This is a preparation patch to enable keep-sorted. No functional change
> is expected. It has been tested with objdump:
> ribalda@ribalda:~/work/linux$ diff drivers/media/usb/uvc/uvc_driver.o.S drivers/media/usb/uvc/uvc_driver.o.new.S
> 2c2
> < drivers/media/usb/uvc/uvc_driver.o:     file format elf64-x86-64

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 618 +++++++++++++++++++++++--------------
>  1 file changed, 386 insertions(+), 232 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 107e0fafd80f54ec98c9657e5d58d17a6ed8c02f..7ced8980543af5a207938d12a5eb833ee8a34c38 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2501,8 +2501,7 @@ static const struct uvc_device_info uvc_quirk_force_y8 = {
>   */
>  static const struct usb_device_id uvc_ids[] = {
>         /* Quanta ACER HD User Facing */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> -                               | USB_DEVICE_ID_MATCH_INT_INFO,
> +       {
>           .idVendor             = 0x0408,
>           .idProduct            = 0x4033,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
> @@ -2510,10 +2509,12 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceProtocol   = UVC_PC_PROTOCOL_15,
>           .driver_info          = (kernel_ulong_t)&(const struct uvc_device_info){
>                 .uvc_version = 0x010a,
> -         } },
> -       /* Quanta ACER HD User Facing */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         },
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Quanta ACER HD User Facing */
> +       {
>           .idVendor             = 0x0408,
>           .idProduct            = 0x4035,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
> @@ -2521,530 +2522,648 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceProtocol   = UVC_PC_PROTOCOL_15,
>           .driver_info          = (kernel_ulong_t)&(const struct uvc_device_info){
>                 .uvc_version = 0x010a,
> -         } },
> -       /* LogiLink Wireless Webcam */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         },
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* LogiLink Wireless Webcam */
> +       {
>           .idVendor             = 0x0416,
>           .idProduct            = 0xa91a,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax },
> -       /* Genius eFace 2025 */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Genius eFace 2025 */
> +       {
>           .idVendor             = 0x0458,
>           .idProduct            = 0x706e,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax },
> -       /* Microsoft Lifecam NX-6000 */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Microsoft Lifecam NX-6000 */
> +       {
>           .idVendor             = 0x045e,
>           .idProduct            = 0x00f8,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax },
> -       /* Microsoft Lifecam NX-3000 */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Microsoft Lifecam NX-3000 */
> +       {
>           .idVendor             = 0x045e,
>           .idProduct            = 0x0721,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_def },
> -       /* Microsoft Lifecam VX-7000 */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_def,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Microsoft Lifecam VX-7000 */
> +       {
>           .idVendor             = 0x045e,
>           .idProduct            = 0x0723,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax },
> -       /* Logitech, Webcam C910 */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Logitech, Webcam C910 */
> +       {
>           .idVendor             = 0x046d,
>           .idProduct            = 0x0821,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_WAKE_AUTOSUSPEND)},
> -       /* Logitech, Webcam B910 */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_WAKE_AUTOSUSPEND),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Logitech, Webcam B910 */
> +       {
>           .idVendor             = 0x046d,
>           .idProduct            = 0x0823,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_WAKE_AUTOSUSPEND)},
> -       /* Logitech Quickcam Fusion */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_WAKE_AUTOSUSPEND),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Logitech Quickcam Fusion */
> +       {
>           .idVendor             = 0x046d,
>           .idProduct            = 0x08c1,
>           .bInterfaceClass      = USB_CLASS_VENDOR_SPEC,
>           .bInterfaceSubClass   = 1,
> -         .bInterfaceProtocol   = 0 },
> -       /* Logitech Quickcam Orbit MP */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .bInterfaceProtocol   = 0,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Logitech Quickcam Orbit MP */
> +       {
>           .idVendor             = 0x046d,
>           .idProduct            = 0x08c2,
>           .bInterfaceClass      = USB_CLASS_VENDOR_SPEC,
>           .bInterfaceSubClass   = 1,
> -         .bInterfaceProtocol   = 0 },
> -       /* Logitech Quickcam Pro for Notebook */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .bInterfaceProtocol   = 0,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Logitech Quickcam Pro for Notebook */
> +       {
>           .idVendor             = 0x046d,
>           .idProduct            = 0x08c3,
>           .bInterfaceClass      = USB_CLASS_VENDOR_SPEC,
>           .bInterfaceSubClass   = 1,
> -         .bInterfaceProtocol   = 0 },
> -       /* Logitech Quickcam Pro 5000 */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .bInterfaceProtocol   = 0,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Logitech Quickcam Pro 5000 */
> +       {
>           .idVendor             = 0x046d,
>           .idProduct            = 0x08c5,
>           .bInterfaceClass      = USB_CLASS_VENDOR_SPEC,
>           .bInterfaceSubClass   = 1,
> -         .bInterfaceProtocol   = 0 },
> -       /* Logitech Quickcam OEM Dell Notebook */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .bInterfaceProtocol   = 0,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Logitech Quickcam OEM Dell Notebook */
> +       {
>           .idVendor             = 0x046d,
>           .idProduct            = 0x08c6,
>           .bInterfaceClass      = USB_CLASS_VENDOR_SPEC,
>           .bInterfaceSubClass   = 1,
> -         .bInterfaceProtocol   = 0 },
> -       /* Logitech Quickcam OEM Cisco VT Camera II */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .bInterfaceProtocol   = 0,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Logitech Quickcam OEM Cisco VT Camera II */
> +       {
>           .idVendor             = 0x046d,
>           .idProduct            = 0x08c7,
>           .bInterfaceClass      = USB_CLASS_VENDOR_SPEC,
>           .bInterfaceSubClass   = 1,
> -         .bInterfaceProtocol   = 0 },
> -       /* Logitech HD Pro Webcam C920 */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .bInterfaceProtocol   = 0,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Logitech HD Pro Webcam C920 */
> +       {
>           .idVendor             = 0x046d,
>           .idProduct            = 0x082d,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT
> -                                              | UVC_QUIRK_INVALID_DEVICE_SOF) },
> -       /* Logitech HD Pro Webcam C922 */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +                                              | UVC_QUIRK_INVALID_DEVICE_SOF),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Logitech HD Pro Webcam C922 */
> +       {
>           .idVendor             = 0x046d,
>           .idProduct            = 0x085c,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_INVALID_DEVICE_SOF) },
> -       /* Logitech Rally Bar Huddle */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_INVALID_DEVICE_SOF),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Logitech Rally Bar Huddle */
> +       {
>           .idVendor             = 0x046d,
>           .idProduct            = 0x087c,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_NO_RESET_RESUME) },
> -       /* Logitech Rally Bar */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_NO_RESET_RESUME),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Logitech Rally Bar */
> +       {
>           .idVendor             = 0x046d,
>           .idProduct            = 0x089b,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_NO_RESET_RESUME) },
> -       /* Logitech Rally Bar Mini */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_NO_RESET_RESUME),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Logitech Rally Bar Mini */
> +       {
>           .idVendor             = 0x046d,
>           .idProduct            = 0x08d3,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_NO_RESET_RESUME) },
> -       /* Chicony CNF7129 (Asus EEE 100HE) */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_NO_RESET_RESUME),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Chicony CNF7129 (Asus EEE 100HE) */
> +       {
>           .idVendor             = 0x04f2,
>           .idProduct            = 0xb071,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_RESTRICT_FRAME_RATE) },
> -       /* Alcor Micro AU3820 (Future Boy PC USB Webcam) */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_RESTRICT_FRAME_RATE),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Alcor Micro AU3820 (Future Boy PC USB Webcam) */
> +       {
>           .idVendor             = 0x058f,
>           .idProduct            = 0x3820,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax },
> -       /* Dell XPS m1530 */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Dell XPS m1530 */
> +       {
>           .idVendor             = 0x05a9,
>           .idProduct            = 0x2640,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_def },
> -       /* Dell SP2008WFP Monitor */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_def,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Dell SP2008WFP Monitor */
> +       {
>           .idVendor             = 0x05a9,
>           .idProduct            = 0x2641,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_def },
> -       /* Dell Alienware X51 */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_def,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Dell Alienware X51 */
> +       {
>           .idVendor             = 0x05a9,
>           .idProduct            = 0x2643,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_def },
> -       /* Dell Studio Hybrid 140g (OmniVision webcam) */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_def,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Dell Studio Hybrid 140g (OmniVision webcam) */
> +       {
>           .idVendor             = 0x05a9,
>           .idProduct            = 0x264a,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_def },
> -       /* Dell XPS M1330 (OmniVision OV7670 webcam) */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_def,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Dell XPS M1330 (OmniVision OV7670 webcam) */
> +       {
>           .idVendor             = 0x05a9,
>           .idProduct            = 0x7670,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_def },
> -       /* Apple Built-In iSight */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_def,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Apple Built-In iSight */
> +       {
>           .idVendor             = 0x05ac,
>           .idProduct            = 0x8501,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_PROBE_MINMAX
> -                                       | UVC_QUIRK_BUILTIN_ISIGHT) },
> -       /* Apple FaceTime HD Camera (Built-In) */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +                               | UVC_QUIRK_BUILTIN_ISIGHT),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Apple FaceTime HD Camera (Built-In) */
> +       {
>           .idVendor             = 0x05ac,
>           .idProduct            = 0x8514,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_def },
> -       /* Apple Built-In iSight via iBridge */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_def,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Apple Built-In iSight via iBridge */
> +       {
>           .idVendor             = 0x05ac,
>           .idProduct            = 0x8600,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_def },
> -       /* Foxlink ("HP Webcam" on HP Mini 5103) */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_def,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Foxlink ("HP Webcam" on HP Mini 5103) */
> +       {
>           .idVendor             = 0x05c8,
>           .idProduct            = 0x0403,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_fix_bandwidth },
> -       /* Genesys Logic USB 2.0 PC Camera */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_fix_bandwidth,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Genesys Logic USB 2.0 PC Camera */
> +       {
>           .idVendor             = 0x05e3,
>           .idProduct            = 0x0505,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid },
> -       /* Hercules Classic Silver */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Hercules Classic Silver */
> +       {
>           .idVendor             = 0x06f8,
>           .idProduct            = 0x300c,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_fix_bandwidth },
> -       /* ViMicro Vega */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_fix_bandwidth,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* ViMicro Vega */
> +       {
>           .idVendor             = 0x0ac8,
>           .idProduct            = 0x332d,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_fix_bandwidth },
> -       /* ViMicro - Minoru3D */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_fix_bandwidth,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* ViMicro - Minoru3D */
> +       {
>           .idVendor             = 0x0ac8,
>           .idProduct            = 0x3410,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_fix_bandwidth },
> -       /* ViMicro Venus - Minoru3D */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_fix_bandwidth,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* ViMicro Venus - Minoru3D */
> +       {
>           .idVendor             = 0x0ac8,
>           .idProduct            = 0x3420,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_fix_bandwidth },
> -       /* Ophir Optronics - SPCAM 620U */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_fix_bandwidth,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Ophir Optronics - SPCAM 620U */
> +       {
>           .idVendor             = 0x0bd3,
>           .idProduct            = 0x0555,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax },
> -       /* Sonix Technology Co. Ltd. - 292A IPC AR0330 */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Sonix Technology Co. Ltd. - 292A IPC AR0330 */
> +       {
>           .idVendor             = 0x0c45,
>           .idProduct            = 0x6366,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_MJPEG_NO_EOF) },
> -       /* MT6227 */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_MJPEG_NO_EOF),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* MT6227 */
> +       {
>           .idVendor             = 0x0e8d,
>           .idProduct            = 0x0004,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_PROBE_MINMAX
> -                                       | UVC_QUIRK_PROBE_DEF) },
> -       /* IMC Networks (Medion Akoya) */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +                               | UVC_QUIRK_PROBE_DEF),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* IMC Networks (Medion Akoya) */
> +       {
>           .idVendor             = 0x13d3,
>           .idProduct            = 0x5103,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid },
> -       /* JMicron USB2.0 XGA WebCam */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* JMicron USB2.0 XGA WebCam */
> +       {
>           .idVendor             = 0x152d,
>           .idProduct            = 0x0310,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax },
> -       /* Kurokesu C1 PRO */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Kurokesu C1 PRO */
> +       {
>           .idVendor             = 0x16d0,
>           .idProduct            = 0x0ed1,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_MJPEG_NO_EOF) },
> -       /* Syntek (HP Spartan) */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_MJPEG_NO_EOF),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Syntek (HP Spartan) */
> +       {
>           .idVendor             = 0x174f,
>           .idProduct            = 0x5212,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid },
> -       /* Syntek (Samsung Q310) */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Syntek (Samsung Q310) */
> +       {
>           .idVendor             = 0x174f,
>           .idProduct            = 0x5931,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid },
> -       /* Syntek (Packard Bell EasyNote MX52 */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Syntek (Packard Bell EasyNote MX52 */
> +       {
>           .idVendor             = 0x174f,
>           .idProduct            = 0x8a12,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid },
> -       /* Syntek (Asus F9SG) */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Syntek (Asus F9SG) */
> +       {
>           .idVendor             = 0x174f,
>           .idProduct            = 0x8a31,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid },
> -       /* Syntek (Asus U3S) */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Syntek (Asus U3S) */
> +       {
>           .idVendor             = 0x174f,
>           .idProduct            = 0x8a33,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid },
> -       /* Syntek (JAOtech Smart Terminal) */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Syntek (JAOtech Smart Terminal) */
> +       {
>           .idVendor             = 0x174f,
>           .idProduct            = 0x8a34,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid },
> -       /* Miricle 307K */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Miricle 307K */
> +       {
>           .idVendor             = 0x17dc,
>           .idProduct            = 0x0202,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid },
> -       /* Lenovo Thinkpad SL400/SL500 */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Lenovo Thinkpad SL400/SL500 */
> +       {
>           .idVendor             = 0x17ef,
>           .idProduct            = 0x480b,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid },
> -       /* Aveo Technology USB 2.0 Camera */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_stream_no_fid,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Aveo Technology USB 2.0 Camera */
> +       {
>           .idVendor             = 0x1871,
>           .idProduct            = 0x0306,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_PROBE_MINMAX
> -                                       | UVC_QUIRK_PROBE_EXTRAFIELDS) },
> -       /* Aveo Technology USB 2.0 Camera (Tasco USB Microscope) */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +                               | UVC_QUIRK_PROBE_EXTRAFIELDS),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Aveo Technology USB 2.0 Camera (Tasco USB Microscope) */
> +       {
>           .idVendor             = 0x1871,
>           .idProduct            = 0x0516,
>           .bInterfaceClass      = USB_CLASS_VENDOR_SPEC,
>           .bInterfaceSubClass   = 1,
> -         .bInterfaceProtocol   = 0 },
> -       /* Ecamm Pico iMage */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .bInterfaceProtocol   = 0,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Ecamm Pico iMage */
> +       {
>           .idVendor             = 0x18cd,
>           .idProduct            = 0xcafe,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_PROBE_EXTRAFIELDS) },
> -       /* Manta MM-353 Plako */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_PROBE_EXTRAFIELDS),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Manta MM-353 Plako */
> +       {
>           .idVendor             = 0x18ec,
>           .idProduct            = 0x3188,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax },
> -       /* FSC WebCam V30S */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* FSC WebCam V30S */
> +       {
>           .idVendor             = 0x18ec,
>           .idProduct            = 0x3288,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax },
> -       /* Arkmicro unbranded */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Arkmicro unbranded */
> +       {
>           .idVendor             = 0x18ec,
>           .idProduct            = 0x3290,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_def },
> -       /* The Imaging Source USB CCD cameras */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_def,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* The Imaging Source USB CCD cameras */
> +       {
>           .idVendor             = 0x199e,
>           .idProduct            = 0x8102,
>           .bInterfaceClass      = USB_CLASS_VENDOR_SPEC,
>           .bInterfaceSubClass   = 1,
> -         .bInterfaceProtocol   = 0 },
> -       /* Bodelin ProScopeHR */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> -                               | USB_DEVICE_ID_MATCH_DEV_HI
> +         .bInterfaceProtocol   = 0,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Bodelin ProScopeHR */
> +       {
>           .idVendor             = 0x19ab,
>           .idProduct            = 0x1000,
>           .bcdDevice_hi         = 0x0126,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_STATUS_INTERVAL) },
> -       /* MSI StarCam 370i */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_STATUS_INTERVAL),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +                               | USB_DEVICE_ID_MATCH_DEV_HI
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* MSI StarCam 370i */
> +       {
>           .idVendor             = 0x1b3b,
>           .idProduct            = 0x2951,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax },
> -       /* Generalplus Technology Inc. 808 Camera */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Generalplus Technology Inc. 808 Camera */
> +       {
>           .idVendor             = 0x1b3f,
>           .idProduct            = 0x2002,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax },
> -       /* Shenzhen Aoni Electronic Co.,Ltd 2K FHD camera */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Shenzhen Aoni Electronic Co.,Ltd 2K FHD camera */
> +       {
>           .idVendor             = 0x1bcf,
>           .idProduct            = 0x0b40,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
> @@ -3052,152 +3171,187 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceProtocol   = 0,
>           .driver_info          = (kernel_ulong_t)&(const struct uvc_device_info){
>                 .uvc_version = 0x010a,
> -         } },
> -       /* SiGma Micro USB Web Camera */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         },
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* SiGma Micro USB Web Camera */
> +       {
>           .idVendor             = 0x1c4f,
>           .idProduct            = 0x3000,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_PROBE_MINMAX
> -                                       | UVC_QUIRK_IGNORE_SELECTOR_UNIT) },
> -       /* Actions Microelectronics Co. Display capture-UVC05 */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +                               | UVC_QUIRK_IGNORE_SELECTOR_UNIT),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Actions Microelectronics Co. Display capture-UVC05 */
> +       {
>           .idVendor             = 0x1de1,
>           .idProduct            = 0xf105,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_DISABLE_AUTOSUSPEND) },
> -       /* NXP Semiconductors IR VIDEO */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_DISABLE_AUTOSUSPEND),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* NXP Semiconductors IR VIDEO */
> +       {
>           .idVendor             = 0x1fc9,
>           .idProduct            = 0x009b,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax },
> -       /* Oculus VR Positional Tracker DK2 */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Oculus VR Positional Tracker DK2 */
> +       {
>           .idVendor             = 0x2833,
>           .idProduct            = 0x0201,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_force_y8 },
> -       /* Oculus VR Rift Sensor */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_force_y8,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Oculus VR Rift Sensor */
> +       {
>           .idVendor             = 0x2833,
>           .idProduct            = 0x0211,
>           .bInterfaceClass      = USB_CLASS_VENDOR_SPEC,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = (kernel_ulong_t)&uvc_quirk_force_y8 },
> -       /* GEO Semiconductor GC6500 */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = (kernel_ulong_t)&uvc_quirk_force_y8,
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* GEO Semiconductor GC6500 */
> +       {
>           .idVendor             = 0x29fe,
>           .idProduct            = 0x4d53,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_FORCE_BPP) },
> -       /* Insta360 Link */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_FORCE_BPP),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Insta360 Link */
> +       {
>           .idVendor             = 0x2e1a,
>           .idProduct            = 0x4c01,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_DISABLE_AUTOSUSPEND) },
> -       /* Intel D410/ASR depth camera */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_DISABLE_AUTOSUSPEND),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Intel D410/ASR depth camera */
> +       {
>           .idVendor             = 0x8086,
>           .idProduct            = 0x0ad2,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D415/ASRC depth camera */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Intel D415/ASRC depth camera */
> +       {
>           .idVendor             = 0x8086,
>           .idProduct            = 0x0ad3,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D430/AWG depth camera */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Intel D430/AWG depth camera */
> +       {
>           .idVendor             = 0x8086,
>           .idProduct            = 0x0ad4,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel RealSense D4M */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Intel RealSense D4M */
> +       {
>           .idVendor             = 0x8086,
>           .idProduct            = 0x0b03,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D435/AWGC depth camera */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Intel D435/AWGC depth camera */
> +       {
>           .idVendor             = 0x8086,
>           .idProduct            = 0x0b07,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D435i depth camera */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Intel D435i depth camera */
> +       {
>           .idVendor             = 0x8086,
>           .idProduct            = 0x0b3a,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D405 Depth Camera */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Intel D405 Depth Camera */
> +       {
>           .idVendor             = 0x8086,
>           .idProduct            = 0x0b5b,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D455 Depth Camera */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Intel D455 Depth Camera */
> +       {
>           .idVendor             = 0x8086,
>           .idProduct            = 0x0b5c,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D421 Depth Module */
> -       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
> +       /* Intel D421 Depth Module */
> +       {
>           .idVendor             = 0x8086,
>           .idProduct            = 0x1155,
>           .bInterfaceClass      = USB_CLASS_VIDEO,
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
> -         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +         .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX),
> +         .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +                               | USB_DEVICE_ID_MATCH_INT_INFO,
> +       },
>         /* Generic USB Video Class */
>         { USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_UNDEFINED) },
>         { USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_15) },
>
> --
> 2.49.0.901.g37484f566f-goog
>


-- 
Ricardo Ribalda

