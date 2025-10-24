Return-Path: <linux-kernel+bounces-868733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B489C06073
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F03FD568EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93A4314A8E;
	Fri, 24 Oct 2025 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GVxAglh9"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A54314A6C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761304092; cv=none; b=hTNU+6nzwj/eUz6L7/x2WcM0ep9WwRfr8xIMYe4VB0jzX5/ZqSatgyb75O8kOylofg4UuKZqxRzBPHihWuxW7N6z4MgdKOFe/+orMJNwCytzOXGOrQlKud3yQNcpZ4bBKz1hxLP8qfN5s6YcZ5N5FkEirt7E61x4qN65+jO6zBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761304092; c=relaxed/simple;
	bh=p2vBATbd4W/6Sx+oB+xHju2R48GBsbHzZDyRWOOtH5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rS3hHoy9L03yWlNTncxYViA+woZotNPSf+rvU/qjSefVRz0no6KoqDx5YbsCgeeu3iXKhSAGPbGtWE5tHxuXab+SvzlclmcwbYnohSN4suKadXhwRI00viF3aqTW9kC0qfCJz1No04Ni5yneo+wE85rMIqIJEIRoBCkkRx9Yf1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GVxAglh9; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57f0aa38aadso1990646e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761304089; x=1761908889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uwxjq6N0Oa6a9ky64rya2i0xqHHd4nBhVfCEWqAzE1w=;
        b=GVxAglh9dcK5hpqZRm9WvehRc5+gLc5e6/SP1eaG7oOfJp3FA2RJmD7UgUPhL4pFzx
         cpPvfavOWNKgbh2BecRh+WfMwf1NblQnZl1+gVWez80d20eq3wa2VuRi6bCrap3IrgcM
         I+3C7BiV6RvBB/vHLbEg5UQ7YNBDcoYeqjjK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761304089; x=1761908889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uwxjq6N0Oa6a9ky64rya2i0xqHHd4nBhVfCEWqAzE1w=;
        b=vMls5j5Eavs8Cb2R42wJuwNOf3f23sfVHr15+Eq8hbdr42yIF80cBcmQy7BtON+AaU
         wsCyuZJnBTi+qhuVlyrhl3tIx/GKDDBjVAvSOvLhMO/qXWrEIZ7y6zdWCGSo6phYafyS
         tZlNJriCu42QUEHZ0dXeK4L/FlhVGOsvfGFzesq/khfnpVlp3udOxPyOY/R7nu0QTFMp
         gzolFEyWp1fEK3QcOwew3EiKJAaauaiX17Rv7xt7AgAyIlBBA6t2pr8Lx9pNQVyjFBwt
         3ll4+6C3UcERnfx2zGpsksF7s1UTTquAGLqnwh6f1W6r3+vI9djhpRRPr+C8FpRH4N9H
         1SkA==
X-Forwarded-Encrypted: i=1; AJvYcCXyiQiADfnvUpR3zCQxP2/pbaKQWZoMllMnXMK/OInBZnccGJ+jd4tbJdjL4dm73gtoK/bfxIJIdGbTfUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYNVA77iTNhtTUexeRYHnBtuK3RIfKzrl0mrL9CB2ZiEK4VDnW
	NBM5AkYA5h/Gsz9TB/9Dl3ELm2vl10kTpCnhZtXODWgqhwmlTk9LfonXVZpu9c6BiycfwZBbgBS
	zvyM=
X-Gm-Gg: ASbGncvfABo1RV94bdS0uFhN36IBz97k5FMh0YWi0/HdwN1mfVWR/ByKtGsFBfMwA2m
	NXfpqHwMxS+5l9+d3/d6RgGMiKNraXqGjW63A1uhiG7M9kaElA0twf1KzbFrTwXkO7MFYgO6Fh4
	UG3btIzcJZ3a1Pp0dKbm3U+tYFuNBDyIzrHJ6/jzTZkHBWqiP4oImeeOkboV3oHLQGD8Plo7ot7
	a1q8fIC4+y75hIV5Hk5dSIzMziY2psJbc3sOadJjE/axoL30xve+RySYdAn60otgJtT79qTcL0k
	OCbDLgGyqUXCh6Y7qy80PmqLoDAPrXZ5AVNey1LuTYOsi1oOM7HOXKhSlpDTDvzcYjJtu22gXCa
	dqnYpXzgVcJhSWSuOHkIEuqYx8VXFN9juXrIbtqggPxNxPzwJ9mauUHu4bcFIyzaC8jsnbdrLoR
	d/Mj6Y5c1F6pcsSsiRNwIvqLywwBSr9C6eenrRAQRSDjcH2A+5
X-Google-Smtp-Source: AGHT+IHGZzHC1/Fjr6ckLfPp2RGdIPbPqAxQ1dwSTFf0TjjpKYRL71TCDBHfId1hG7BRYyvHJmiIUA==
X-Received: by 2002:a05:6512:1324:b0:592:f77d:88f7 with SMTP id 2adb3069b0e04-592f77d8ac5mr1523117e87.52.1761304088966;
        Fri, 24 Oct 2025 04:08:08 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4cd20a0sm1541188e87.38.2025.10.24.04.08.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 04:08:08 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57f0aa38aadso1990610e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:08:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtxoVHOE8WnRRqDtwkFiOxi1iQU6tbb47UsyMLRT2/oXdA4aoQ9odBMfFN2v9VEaP2od0bCFVSXY9OidA=@vger.kernel.org
X-Received: by 2002:a05:6512:3c82:b0:592:f830:d0d7 with SMTP id
 2adb3069b0e04-592f830d2e6mr1226989e87.40.1761304087473; Fri, 24 Oct 2025
 04:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024-fix-uvc-v3-0-b7f83c012ca7@realsenseai.com> <20251024-fix-uvc-v3-2-b7f83c012ca7@realsenseai.com>
In-Reply-To: <20251024-fix-uvc-v3-2-b7f83c012ca7@realsenseai.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 24 Oct 2025 13:07:54 +0200
X-Gmail-Original-Message-ID: <CANiDSCst5=72g8weBzLRo5k=O=qvO84+yBCx_tY-5GMzkq+ivg@mail.gmail.com>
X-Gm-Features: AS18NWAc92aCGMlUJx-7jrM34bFeIt68Ze5yd1pN1PVW5M0fhF7qUYTHdu9w5Qw
Message-ID: <CANiDSCst5=72g8weBzLRo5k=O=qvO84+yBCx_tY-5GMzkq+ivg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] media: uvc: Add RealSense vendor prefix to Intel
 camera comments
To: yogev.modlin@realsenseai.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Yogev

Thanks for your patch
On Fri, 24 Oct 2025 at 07:50, ymodlin via B4 Relay
<devnull+yogev.modlin.realsenseai.com@kernel.org> wrote:
>
> From: ymodlin <yogev.modlin@realsenseai.com>
>
> Update comment strings for 'Intel RealSense' depth cameras to include
> the "RealSense" vendor prefix for better identification.

Please squash 2/3 into 1/3 and update the commit message accordingly.

remember that the subject should start with:

media: uvcvideo:

not
change:

Thanks!

>
> Signed-off-by: ymodlin <yogev.modlin@realsenseai.com>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index b1457678833e..dbdacc64ea6b 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -3142,7 +3142,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_DISABLE_AUTOSUSPEND) },
> -       /* Realsense D410/ASR depth camera */
> +       /* Intel Realsense D410/ASR depth camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3151,7 +3151,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Realsense D415/ASRC depth camera */
> +       /* Intel Realsense D415/ASRC depth camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3160,7 +3160,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Realsense D430/AWG depth camera */
> +       /* Intel Realsense D430/AWG depth camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3169,7 +3169,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Realsense RealSense D4M */
> +       /* Intel Realsense RealSense D4M */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3178,7 +3178,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Realsense D435/AWGC depth camera */
> +       /* Intel Realsense D435/AWGC depth camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3187,7 +3187,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Realsense D435i depth camera */
> +       /* Intel Realsense D435i depth camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3196,7 +3196,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Realsense D405 Depth Camera */
> +       /* Intel Realsense D405 Depth Camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3205,7 +3205,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Realsense D455 Depth Camera */
> +       /* Intel Realsense D455 Depth Camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3214,7 +3214,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Realsense D421 Depth Module */
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

