Return-Path: <linux-kernel+bounces-865076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 730D4BFC2A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF91B56226E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9F7341661;
	Wed, 22 Oct 2025 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CnWTa0qZ"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF453128D4
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139573; cv=none; b=uGDbbqefoyJVDmKYmV7CRyAIq/d/nXLmSwfUX3X3LTrAV5WARjwnotIKt0PWZkXEkQfMSzR82m+pr9iefd8DhxHsxTwm6YZdYrcb1e56SEa47aa92Z2TYPkYY+bR7hbMsJ3Jcr786rM//k4rXcbF/QYSm/woQzFU8XbNRF9K64s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139573; c=relaxed/simple;
	bh=aeSnv2R+QvfgKhY4GETbAHxtHzvxRwrgVzVkc2LVmdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxKaqH4tlPoQ/gljCMA2T37xOdOPS6Hy7ebzMP+BhF3hG5MGhfNhdK0xxYFN5te3pP/q8lY9JJuDjCFHbkgnHlkovswv60H/UYYxtO6HikEZjZg8atHhU8pviBuEdm1REMQQb+BQqcdA844tsxp8KeyFV/JjlLFq1fsvVJw0Izw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CnWTa0qZ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57b35e176dbso8380510e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761139569; x=1761744369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dIa8OXN6SN0lvvT1+dcibGIeK+e86K1JnNlx8c4XPTY=;
        b=CnWTa0qZLAtjAggLBV3xI3UhewMnIl+2Me3lC2fuQz+Cu/XxRM+xoPd4SxH/CLkCZK
         N0P+QZydCKC6ty8lDShUnQUD2B/0GLxD10t96toTTxiPcEx9BPFcQVz/3/9Ui1t6qrl9
         Ht4CMUWxSzJ/9u6jzhbquQNQhqDCuzvjvUgyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761139569; x=1761744369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIa8OXN6SN0lvvT1+dcibGIeK+e86K1JnNlx8c4XPTY=;
        b=GNi8sm2fgR2aIWi9qX/l1VWdI2bMUkXconc3BjQpxKabAg/eCiyS2XjT3BJV6BXSqL
         qPMqDlvNv6W/om8bqTB24BZQZWhKfQKhP6kO/qvLdArOcLeNW6NditkJlBHcV0SMlZHm
         Yx+VPJvCE+/kmLzvRAA09WHciwvpydwrO8mrnWnJVPP74Ba/AmbyuoagdrN3Itcrolgf
         JJ8Vm3cUhXYQ2AJsWGjf8lrtBBMf+1ZjbQzmiwWhbGrRyeS6x/n7dIvpNe7KqqeDrcl2
         wYzB2aO9lSBE49VPLq1NLRHMYail82j9C69jDxKB46RsN7VLFbM8ia15VJi5Wp+rHtwj
         e1Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUoSqJVnE+yENB4SyQ+Yi1BNSIyx24AynZFp73mmd2YnhsUfy5JCtuFhbmpVTBsCThV1pS9U8Z0cDPG6tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY44djRitLO0lprgAvsyFWsBv19oZ1TjmOaNN30aeCCNYxMlUc
	z3VQuZYqgjqEdXSnUMdVo1zJ8XxsKV16NVtThRdNCWGkT0evgNWSKKGwPV+fKBKxYuVxBO4H1G2
	JqY3e1g==
X-Gm-Gg: ASbGncvBZLoya5d+3UgvxgjPUD0C51/Ah77PuccJlHAbGCRsmkgZA6rTYIwzL7g3IPu
	xJGmumhY6Rjc0mM0O/82AaGPAqzLQJrKQVtxYnXLmpKWRYN5iRcIc3um78XdqDdYmyz0Z8cFX+B
	pdlkiaAPlAdxor+GJjx8/nn6PDES3A++x6BR7uDDJatxbB2rVAMfEMUqEwnHzGILlo+wKuERNF6
	ythM/4LUS6cEEfGcl1BwKXPjh2Gfv/FCxnTlLdqp9OwALFNOI3ZgZSID19QMCtjHjBZLJs1ODrQ
	ZV/p21PQhE0QgpzViwT2RESIZ4L6vTLkVH7/P1nTk9sFksYij0nwHlx2s+F/OfMHTMoLegXRuoP
	+QpKAwQQK9ezcRWTczZcvXW7BHFTU0VDFKrYaWtLfoV4RgNfi9IsYZnvSjwGFhGKlIQE3w/+kdx
	CHLAW2MPxwYHo209nQL0n3WgLaJWx55lrzoHgg0DXFOe4N8mwU
X-Google-Smtp-Source: AGHT+IFAubry/0qwONsA4adPN6khdrUjf+lNKZZR1FdSZY4FFmr1BujENdi73jWuaB2Kb5600Ng0qA==
X-Received: by 2002:a05:6512:3405:b0:591:c898:e82b with SMTP id 2adb3069b0e04-591d84cf8d6mr6521307e87.8.1761139568524;
        Wed, 22 Oct 2025 06:26:08 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f1d2d0d6sm391899e87.49.2025.10.22.06.26.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 06:26:08 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-592f22b1e49so356796e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:26:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXW15aq7ZAbKeEFBQJNbU2ORZgs29qeoakKiwkcxlERn5gf/h1rBDn5gCr/r59G2czwcP3F55SMXRy+kUE=@vger.kernel.org
X-Received: by 2002:a05:6512:12c2:b0:587:7f2d:2580 with SMTP id
 2adb3069b0e04-591d85357d6mr7835358e87.32.1761139567504; Wed, 22 Oct 2025
 06:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-fix-uvc-v1-1-e4cd03606735@realsenseai.com>
In-Reply-To: <20251022-fix-uvc-v1-1-e4cd03606735@realsenseai.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 22 Oct 2025 15:25:55 +0200
X-Gmail-Original-Message-ID: <CANiDSCvc8ssEruBX+sRcn70dB-XkJie80nGGzvEy73++jTC3Dg@mail.gmail.com>
X-Gm-Features: AS18NWCARYb3Ee9APeYWCQm8P8GoE-Fvu3BrW22Lp7RL_ycBh0q5_V3w0hfycPo
Message-ID: <CANiDSCvc8ssEruBX+sRcn70dB-XkJie80nGGzvEy73++jTC3Dg@mail.gmail.com>
Subject: Re: [PATCH] change: drop 'Intel' from RealSense camera comments
To: yogev.modlin@realsenseai.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Yogev

On Wed, 22 Oct 2025 at 13:15, ymodlin via B4 Relay
<devnull+yogev.modlin.realsenseai.com@kernel.org> wrote:
>
> From: ymodlin <yogev.modlin@realsenseai.com>
>
> RealSense branding is now independent of Intel. Update all driver
> comments referencing "Intel RealSense" to just "RealSense" to reflect
> current ownership. No code logic changes.

I think it is more useful that the comments match the output of lsusb
than the legal name of its manufacturer.

What about something like this:

Realsense/Intel D415/ASRC depth camera

?

Regards

PS: The CI complain about two things, please take care of those as well

>
> Signed-off-by: Yogev Modlin <yogev.modlin@realsenseai.com>
> ---
> Since Realsense has been spin-off Intel, the comment should be change.
>
> Signed-off-by: ymodlin <yogev.modlin@realsenseai.com>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index fb6afb8e84f0..b1457678833e 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -3142,7 +3142,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_DISABLE_AUTOSUSPEND) },
> -       /* Intel D410/ASR depth camera */
> +       /* Realsense D410/ASR depth camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3151,7 +3151,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D415/ASRC depth camera */
> +       /* Realsense D415/ASRC depth camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3160,7 +3160,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D430/AWG depth camera */
> +       /* Realsense D430/AWG depth camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3169,7 +3169,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel RealSense D4M */
> +       /* Realsense RealSense D4M */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3178,7 +3178,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D435/AWGC depth camera */
> +       /* Realsense D435/AWGC depth camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3187,7 +3187,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D435i depth camera */
> +       /* Realsense D435i depth camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3196,7 +3196,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D405 Depth Camera */
> +       /* Realsense D405 Depth Camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3205,7 +3205,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D455 Depth Camera */
> +       /* Realsense D455 Depth Camera */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
> @@ -3214,7 +3214,7 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = UVC_INFO_META(V4L2_META_FMT_D4XX) },
> -       /* Intel D421 Depth Module */
> +       /* Realsense D421 Depth Module */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
>           .idVendor             = 0x8086,
>
> ---
> base-commit: 552c50713f273b494ac6c77052032a49bc9255e2
> change-id: 20251022-fix-uvc-2937db31ca93
>
> Best regards,
> --
> ymodlin <yogev.modlin@realsenseai.com>
>
>
>


-- 
Ricardo Ribalda

