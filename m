Return-Path: <linux-kernel+bounces-811866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBF1B52ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F3EA002C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB513101C8;
	Thu, 11 Sep 2025 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="niutcR0L"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18FF25EFBC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587395; cv=none; b=MaqIFT5puNkHRAXOsuZ0RFNtUVMXq7+v6mDrsPqeYDxoonCTOTCoPHJ773FLT7vYOv5wYZVjvOVqI9BaC6kQsE7+5qyIavpOPq/UbWB1rh7Js0ADmA/j4LmvGJ4CCGm6Kaw5J8M5MzAnBzG18tAwF0GHbtHO7rb5HeD7/3CpHUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587395; c=relaxed/simple;
	bh=QFKViAjOG3H/hgnZlrnf/Z4V6RV0blUEL+OHo6KTQds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgIImw6Ynu252nz4apMTVdrg9PmfOOoURA3QVnemNft5LFHWGg0hKGyy1ZdVhOFz+TqQ3C1/H151eZc1kHkPN0avjophIJx1afR5V7mX6V0jLTxa7juk8epwig20pHDi1qlbadX5rZzuTFQlzH6qGHiWP8aSDpz8DG5T7NkwLik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=niutcR0L; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f6507bd53so579768e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1757587392; x=1758192192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sQ8zR2jNRGppYAXj1O97RaDcas8CMIEn6huE/U9BL9g=;
        b=niutcR0LQoSo/O7iVZedla4sa+9dRgXy8mWIW1mV9Ag3fdmkhwMbupkJrpsN7c+9lz
         6P8YXhD3LvavWRoMemh3wRW2IqfO6vdlc9df5Vr8SiXOT0+nJ57kKSIcsFkDVnboKXoc
         VZaADaxK2fgJfQFOFSMnF9o6w0fOrJwCwdSP6FcmPHxXqR3s3+CVureGMuYf2POMTO8y
         dpWQtnZr65cFJ3wwVTeWs0UUOdGxG90BicA/4MBegTQi6LwhQJJGJcZNq4fZMnKZjaed
         VloSmX1uCbdDp9jFdXfuk3v2p1bOZTPcP4wNIADzigxvb22QEgWJXuxWKlhTEFgv2Cxp
         xL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757587392; x=1758192192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQ8zR2jNRGppYAXj1O97RaDcas8CMIEn6huE/U9BL9g=;
        b=gL1I38rjUgOpGh06ajc3A+gTelYbcEzFip1aYbJ/bEI0gMuJjSm7vQsQu+SlHUVrRf
         PN3o9nt+1PLTHGcvsrUtdoVZ2hSG7NmuXh2e0G/wxK0q4winjSkQjPeLANi3TWFoKqic
         MMRw37Nw3EyJqVnYB4SO3FCG+71BXzGVp53T1FJ5Z/qsXUv9JklDQV2njJWZnD75mUtn
         P0IyJy/leOOuca+PvAqyY31axvz+BmSQQtMci6eyMMLkXxVolfupEOJLjBzY2JRyDiqN
         jzJ4UY5oZDkwY1MtS3QddKTmIG6KK+LYz40I/UPWuhhMeaFgRo6TFaQaO9NyYMfiBBA6
         +h5w==
X-Forwarded-Encrypted: i=1; AJvYcCVJAKVExDMkGPBZmEUDQrrFl3kJAPK4u3N/JY3PiKjlbjBQ+2VfPuoHbaV+1AQVxINWnodZGWxBqdAsZzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2V3FDPELZU2KV8PFHflfZGskT83n0DX+PXo6QfNjmsoQ6t+8j
	sKphYQm/g0O/IjyrFzeF1GX7/h119zcORgUbN2NG1md3S8MRuyoz1SGPv7vvYTbs009wSjX23zE
	F7dvKvh0UwlnQbmxNNrUvbuiQoestlcSwrzton/3sAYhg+Y2zCsM8
X-Gm-Gg: ASbGncsvQvziYClWqYAYfVY4IEpryoEwQ7witgFh9P8YpslDwAw2wqtcQAY/Ar3RFR4
	nWVz5Q/SQgQZwvTqH8jmcIiLy5pX8l80CP2a1zsFA9F4ynHDXbHle08gpjhSViHU8OU1OxgsU14
	zPLTDg/5TMsuztmJU6PBQYkRBGkfAjJQnRF/xUgeDyBVp0Sbv6U49OHXHVv9lYt50iFuztpVvaf
	ycW7lGPNaxK1MlRmXY08EGebBvI8bIMG4zb6vsWbwJ0atPC9A==
X-Google-Smtp-Source: AGHT+IFnSGxhdwCR8iE6c8FwVANCs9n2+6BmMkbEgz9s8UIOohokeDBv0pW7TXrOLJSzl1Zx3vQMtku6NYV8J1/rhPk=
X-Received: by 2002:a05:6512:b91:b0:55b:92f9:c625 with SMTP id
 2adb3069b0e04-56260e41a41mr6286742e87.20.1757587391645; Thu, 11 Sep 2025
 03:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911-csi-bgr-rgb-v2-0-e6c6b10c1040@kernel.org> <20250911-csi-bgr-rgb-v2-2-e6c6b10c1040@kernel.org>
In-Reply-To: <20250911-csi-bgr-rgb-v2-2-e6c6b10c1040@kernel.org>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 11 Sep 2025 11:42:51 +0100
X-Gm-Features: AS18NWC93t4oXLls60lv8ePkPquhgexq2dZUuW0bJvaMQTCfnOUGX2QFvXPSEXo
Message-ID: <CAPY8ntBv-yaYmhqbmMkSNVkADX4i0FpzD61N6pQtSZYZTSbjJw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] media: uapi: Introduce MEDIA_BUS_FMT_BGR565_1X16
To: Maxime Ripard <mripard@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Mats Randgaard <matrandg@cisco.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>
Content-Type: text/plain; charset="UTF-8"

Hi Maxime

On Thu, 11 Sept 2025 at 10:15, Maxime Ripard <mripard@kernel.org> wrote:
>
> MIPI-CSI2 sends its RGB format on the wire with the blue component
> first, then green, then red. MIPI calls that format "RGB", but by v4l2
> conventions it would be BGR.
>
> MIPI-CSI2 supports three RGB variants: 444, 555, 565, 666 and 888.
>
> We already have BGR666 and BGR888 media bus formats, we don't have any
> CSI transceivers using the 444 and 555 variants, but some transceivers
> use the CSI RGB565 format, while using the RGB656 media bus code.

Typo: 656 should be 565.

> That's a mistake, but since we don't have a BGR656 media bus code we

And here.

The patch looks fine to me otherwise.
  Dave

> need to introduce one before fixing it.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  .../userspace-api/media/v4l/subdev-formats.rst     | 37 ++++++++++++++++++++++
>  include/uapi/linux/media-bus-format.h              |  3 +-
>  2 files changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/userspace-api/media/v4l/subdev-formats.rst b/Documentation/userspace-api/media/v4l/subdev-formats.rst
> index 8e92f784abd8123f9ea950f954a60af56ee76dbe..def0d24ef6cdb1a2ec9395af1468f56adf31a8de 100644
> --- a/Documentation/userspace-api/media/v4l/subdev-formats.rst
> +++ b/Documentation/userspace-api/media/v4l/subdev-formats.rst
> @@ -625,10 +625,47 @@ The following tables list existing packed RGB formats.
>        - b\ :sub:`4`
>        - b\ :sub:`3`
>        - b\ :sub:`2`
>        - b\ :sub:`1`
>        - b\ :sub:`0`
> +    * .. _MEDIA-BUS-FMT-BGR565-1X16:
> +
> +      - MEDIA_BUS_FMT_BGR565_1X16
> +      - 0x1028
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      - b\ :sub:`4`
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
> +      - g\ :sub:`5`
> +      - g\ :sub:`4`
> +      - g\ :sub:`3`
> +      - g\ :sub:`2`
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +      - r\ :sub:`4`
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
>      * .. _MEDIA-BUS-FMT-BGR565-2X8-BE:
>
>        - MEDIA_BUS_FMT_BGR565_2X8_BE
>        - 0x1005
>        -
> diff --git a/include/uapi/linux/media-bus-format.h b/include/uapi/linux/media-bus-format.h
> index ff62056feed5b6588bfcfdff178f5b68eecd3a26..a73d91876d31844bf8c2da91ddea541181840bd2 100644
> --- a/include/uapi/linux/media-bus-format.h
> +++ b/include/uapi/linux/media-bus-format.h
> @@ -32,17 +32,18 @@
>   * new pixel codes.
>   */
>
>  #define MEDIA_BUS_FMT_FIXED                    0x0001
>
> -/* RGB - next is       0x1028 */
> +/* RGB - next is       0x1029 */
>  #define MEDIA_BUS_FMT_RGB444_1X12              0x1016
>  #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_BE      0x1001
>  #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_LE      0x1002
>  #define MEDIA_BUS_FMT_RGB555_2X8_PADHI_BE      0x1003
>  #define MEDIA_BUS_FMT_RGB555_2X8_PADHI_LE      0x1004
>  #define MEDIA_BUS_FMT_RGB565_1X16              0x1017
> +#define MEDIA_BUS_FMT_BGR565_1X16              0x1028
>  #define MEDIA_BUS_FMT_BGR565_2X8_BE            0x1005
>  #define MEDIA_BUS_FMT_BGR565_2X8_LE            0x1006
>  #define MEDIA_BUS_FMT_RGB565_2X8_BE            0x1007
>  #define MEDIA_BUS_FMT_RGB565_2X8_LE            0x1008
>  #define MEDIA_BUS_FMT_RGB666_1X18              0x1009
>
> --
> 2.50.1
>

