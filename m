Return-Path: <linux-kernel+bounces-811907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E69C2B52FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFBE177666
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBB03126C5;
	Thu, 11 Sep 2025 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="sxHpqSMq"
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C831283F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589119; cv=none; b=oQIkcTVKzI6FyBU0VZEN5ifsoxCjh59/sNsxbqVL+EZ5eN2l62vGWogbK+aynJi0m08qvGSzxykfzIabVX+wRrV5/jGcpzt0NbKPruJFv3UXQ51cRIw+6+a47sHUTf3lo3fXKxf8llCUzj3voIgTrvscIzQr8ZZci9ZPYrjtREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589119; c=relaxed/simple;
	bh=gVFXcbZQ+9b0oRAjYg149MD2xbFgWe31Cp48AQ8Ym5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoQUsWSysyzn/klwucyjc9I2IYaEAQybWMRVhdkyVMb/9KbFdoK0iVpf0oqhzKKvmrzOTZ7SWNF4Yei6ZKsAFs7Gm3f/aAx8A5qZTDyjLmiiMWIE+SR1is5B3eFNqaGevYpXI2jOXoNzuYofNa6hg4COVAOxQEnFqHrx8EJC2Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=sxHpqSMq; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-60f476e97f1so163297d50.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1757589116; x=1758193916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=efbdMdx8ppc0y57jvJ/WyQmejsRqkjVJNHYS/A58AwU=;
        b=sxHpqSMqb9ka0iiLV3hdG66SvoXg/qEh8SrOQugbdoOGfZpcu+wpRethOzFV+BPOJJ
         zWR22diHkCNFat05VlrQhpIvQeOEwHOJCNbQ17yS6u4GGqQi0BM1NFTope6KzWhp8LaO
         j/blGLAfLPkZeFZ49m+0sYf6UXwlYAdp4QnchU7ikmK+BJZsE0K5QvaEbaf2JkIYuMVi
         t9N4HCIwXxZNn627IP2hS94H9HimDMlTX5rmCorP+cLhiLf2/FOvF1Awpk7oO1gdtZI4
         JlIcnEHOpiOXZDEDLpP/B083+jOfvpSfjt0ktPNxZR3NhQDGtCpRw0ZAOSBvxq6XrGPy
         nFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757589116; x=1758193916;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efbdMdx8ppc0y57jvJ/WyQmejsRqkjVJNHYS/A58AwU=;
        b=mVOgKWkChn4iyRTPClL1YWasS8hkmhiMx8CidfS7sDcmQwnj2cIOunp3k6INxGkFt8
         kC9eMJyxIkJc8H6VK6rvENYizCk8rk5IHCotDazyVCrFIy/lM4Sl3oeKg7RI1hXca282
         tcFlRBk7OTBlJeE59OwpXeIOFAs6L+9MMP2DiOY7GUPX1ZblUkK9duKxkuxKrKdYEWBO
         Rykizf8bfM/3/tSCGw6dwhet+JOmY/YPgrG2FE9OUorFsD8IPbtH19YOqlvIYCgXQoDo
         44lF8Q3nEk8Uxv8yE6203CZkGuG24RfG/lxqV8TVCZELqDka3/vT918gbhSsfCJL6+VI
         cZhA==
X-Forwarded-Encrypted: i=1; AJvYcCV2/ZKwbYbyMiK7wzAUNIjIsaEqKhrO64Hg6uDVK2U0hBKgJ3OKcSTTkp0QnrtRTzCIkbVXATlUKnvus6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHKl9gfKxanAvVFFE9Kh5j7EkMUMWXZDEaSgXvvM68TKDsvtxg
	jxCXJtsnh9Zx9D86N48a9tJ0F3Db12/nB2z0dHbRjA+gv/7bg8qrKQJ80MxoOvrW8dOIdQ3XCGg
	1gbDX4jcef0x6DGO9433dz73DhdbijXFH7xkQMwQl9Q==
X-Gm-Gg: ASbGncv0XgQBwH5kuV4PPA4o3vUl9XLcz9BaMeuXZZQ1q/Mdpkkhr60W/3MK7W0tUiD
	FHIK/Sgsk+6MKrc/FJ02klVIw6GXYlUeclVbRNgf80MC0SlSr99kCXaUsSvCWGdwAEhuqvaFZvC
	0i5fM1MwiyuB55PE7dRXpBL6LdRbaXKuruQl2r8sDwMQfjpMmL8JLwUL+LxEXmGq1Vh7oH7cKV9
	NmD9nIR59meVPGkigTnEq/Tu67btjeInWFoP/E68pSXBY49y84VJ2/4Tv3y
X-Google-Smtp-Source: AGHT+IE7y61jt3BTlrPRKkVkpCYFN38tMn+ivWJPXhndffSVM4yTnzAa+3i9UFwR0NwUlApg9Hm4vAD5GYaII64RmTA=
X-Received: by 2002:a53:bb8c:0:b0:5f5:1097:6eb5 with SMTP id
 956f58d0204a3-61028ea0f6cmr13119918d50.31.1757589115637; Thu, 11 Sep 2025
 04:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911-csi-bgr-rgb-v2-0-e6c6b10c1040@kernel.org> <20250911-csi-bgr-rgb-v2-3-e6c6b10c1040@kernel.org>
In-Reply-To: <20250911-csi-bgr-rgb-v2-3-e6c6b10c1040@kernel.org>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 11 Sep 2025 12:11:36 +0100
X-Gm-Features: Ac12FXwM4P6Wgf9tLO5WbK4KrfQkMtG4PtgDAGpSmTQ1XNJtyPSZGehGiSIImmA
Message-ID: <CAPY8ntBG=ghLmFGkA4-Tg4pAzAv6jWARkyiZU-4uCVhQuwZa9Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] media: tc358743: Fix the RGB MBUS format
To: Maxime Ripard <mripard@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Mats Randgaard <matrandg@cisco.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>
Content-Type: text/plain; charset="UTF-8"

Hi Maxime

On Thu, 11 Sept 2025 at 10:15, Maxime Ripard <mripard@kernel.org> wrote:
>
> The tc358743 is an HDMI to MIPI-CSI2 bridge. It supports two of the
> three HDMI 1.4 video formats: RGB 4:4:4 and YCbCr 422.

It accepts 3 HDMI video formats: 24bpp RGB 4:4:4, 24bpp YCbCr 4:4:4,
or 16bpp YCbCr 4:2:2.

It supports outputting the incoming video data as either 24bpp RGB
4:4:4 or 16bpp YCbCr 4:2:2, and will convert the incoming HDMI video
data to either of these.
(Rereading the datasheet it can also send YCbCr 4:4:4, but that's
non-standard as it by default reuses data type 0x24 which is RGB888,
but says it uses RAW12 packing!)

> RGB 4:4:4 is converted to the MIPI-CSI2 RGB888 video format, and listed
> in the driver as MEDIA_BUS_FMT_RGB888_1X24.
>
> Most CSI2 receiver drivers then map MEDIA_BUS_FMT_RGB888_1X24 to
> V4L2_PIX_FMT_RGB24.
>
> However, V4L2_PIX_FMT_RGB24 is defined as having its color components in
> the R, G and B order, from left to right. MIPI-CSI2 however defines the
> RGB888 format with blue first.
>
> This essentially means that the R and B will be swapped compared to what
> V4L2_PIX_FMT_RGB24 defines.
>
> The proper MBUS format would be BGR888, so let's use that.
>
> Fixes: d32d98642de6 ("[media] Driver for Toshiba TC358743 HDMI to CSI-2 bridge")
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/media/i2c/tc358743.c | 51 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 42 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
> index 1cc7636e446d77d7c6266ca86517496261d2b039..a3054cd823da4cf3db24c6b2bfbf0fcaa43f2814 100644
> --- a/drivers/media/i2c/tc358743.c
> +++ b/drivers/media/i2c/tc358743.c
> @@ -693,11 +693,21 @@ static void tc358743_set_csi_color_space(struct v4l2_subdev *sd)
>                 i2c_wr16_and_or(sd, CONFCTL, ~MASK_YCBCRFMT,
>                                 MASK_YCBCRFMT_422_8_BIT);
>                 mutex_unlock(&state->confctl_mutex);
>                 break;
>         case MEDIA_BUS_FMT_RGB888_1X24:
> -               v4l2_dbg(2, debug, sd, "%s: RGB 888 24-bit\n", __func__);
> +               /*
> +                * The driver was initially introduced with RGB888
> +                * support, but CSI really means BGR.
> +                *
> +                * Since we might have applications that would have
> +                * hard-coded the RGB888, let's support both.
> +                */
> +               v4l2_warn(sd, "RGB format isn't actually supported by the hardware. The application should be fixed to use BGR.");

warn_once? Otherwise repeatedly setting the format to RGB888 will spam
the kernel log.
(Annoying that there doesn't appear to be a v4l2_warn_once macro)

> +               fallthrough;
> +       case MEDIA_BUS_FMT_BGR888_1X24:
> +               v4l2_dbg(2, debug, sd, "%s: BGR 888 24-bit\n", __func__);
>                 i2c_wr8_and_or(sd, VOUT_SET2,
>                                 ~(MASK_SEL422 | MASK_VOUT_422FIL_100) & 0xff,
>                                 0x00);
>                 i2c_wr8_and_or(sd, VI_REP, ~MASK_VOUT_COLOR_SEL & 0xff,
>                                 MASK_VOUT_COLOR_RGB_FULL);
> @@ -1354,15 +1364,28 @@ static int tc358743_log_status(struct v4l2_subdev *sd)
>                         (i2c_rd16(sd, CSI_STATUS) & MASK_S_RXACT) ?
>                         "yes" : "no");
>         v4l2_info(sd, "Stopped: %s\n",
>                         (i2c_rd16(sd, CSI_STATUS) & MASK_S_HLT) ?
>                         "yes" : "no");
> -       v4l2_info(sd, "Color space: %s\n",
> -                       state->mbus_fmt_code == MEDIA_BUS_FMT_UYVY8_1X16 ?
> -                       "YCbCr 422 16-bit" :
> -                       state->mbus_fmt_code == MEDIA_BUS_FMT_RGB888_1X24 ?
> -                       "RGB 888 24-bit" : "Unsupported");
> +
> +       switch (state->mbus_fmt_code) {
> +       case MEDIA_BUS_FMT_BGR888_1X24:
> +               /*
> +                * The driver was initially introduced with RGB888
> +                * support, but CSI really means BGR.
> +                *
> +                * Since we might have applications that would have
> +                * hard-coded the RGB888, let's support both.
> +                */
> +               fallthrough;
> +       case MEDIA_BUS_FMT_RGB888_1X24:
> +               v4l2_info(sd, "Color space: BGR 888 24-bit\n");
> +               break;
> +       case MEDIA_BUS_FMT_UYVY8_1X16:
> +               v4l2_info(sd, "Color space: YCbCr 422 16-bit\n");
> +               break;

This has lost printing "Unsupported" if not one of the supported
formats, however I don't think there is a way for that to ever happen.
As it's not an enum, the compiler shouldn't be complaining of
unhandled values.

> +       }
>
>         v4l2_info(sd, "-----%s status-----\n", is_hdmi(sd) ? "HDMI" : "DVI-D");
>         v4l2_info(sd, "HDCP encrypted content: %s\n",
>                         hdmi_sys_status & MASK_S_HDCP ? "yes" : "no");
>         v4l2_info(sd, "Input color space: %s %s range\n",
> @@ -1695,24 +1718,33 @@ static int tc358743_enum_mbus_code(struct v4l2_subdev *sd,
>                 struct v4l2_subdev_state *sd_state,
>                 struct v4l2_subdev_mbus_code_enum *code)
>  {
>         switch (code->index) {
>         case 0:
> -               code->code = MEDIA_BUS_FMT_RGB888_1X24;
> +               code->code = MEDIA_BUS_FMT_BGR888_1X24;
>                 break;
>         case 1:
>                 code->code = MEDIA_BUS_FMT_UYVY8_1X16;
>                 break;
> +       case 2:
> +               /*
> +                * We need to keep RGB888 for backward compatibility,
> +                * but we should list it last for userspace to pick BGR.
> +                */
> +               code->code = MEDIA_BUS_FMT_RGB888_1X24;
> +               break;
>         default:
>                 return -EINVAL;
>         }
>         return 0;
>  }
>
>  static u32 tc358743_g_colorspace(u32 code)
>  {
>         switch (code) {
> +       case MEDIA_BUS_FMT_BGR888_1X24:
> +               fallthrough;

Do we need a fallthrough when there is no extra code between the two cases?

Otherwise it looks good to me.

  Dave

>         case MEDIA_BUS_FMT_RGB888_1X24:
>                 return V4L2_COLORSPACE_SRGB;
>         case MEDIA_BUS_FMT_UYVY8_1X16:
>                 return V4L2_COLORSPACE_SMPTE170M;
>         default:
> @@ -1746,11 +1778,12 @@ static int tc358743_set_fmt(struct v4l2_subdev *sd,
>         struct tc358743_state *state = to_state(sd);
>
>         u32 code = format->format.code; /* is overwritten by get_fmt */
>         int ret = tc358743_get_fmt(sd, sd_state, format);
>
> -       if (code == MEDIA_BUS_FMT_RGB888_1X24 ||
> +       if (code == MEDIA_BUS_FMT_BGR888_1X24 ||
> +           code == MEDIA_BUS_FMT_RGB888_1X24 ||
>             code == MEDIA_BUS_FMT_UYVY8_1X16)
>                 format->format.code = code;
>         format->format.colorspace = tc358743_g_colorspace(format->format.code);
>
>         if (ret)
> @@ -2166,11 +2199,11 @@ static int tc358743_probe(struct i2c_client *client)
>         sd->entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
>         err = media_entity_pads_init(&sd->entity, 1, &state->pad);
>         if (err < 0)
>                 goto err_hdl;
>
> -       state->mbus_fmt_code = MEDIA_BUS_FMT_RGB888_1X24;
> +       state->mbus_fmt_code = MEDIA_BUS_FMT_BGR888_1X24;
>
>         sd->dev = &client->dev;
>
>         mutex_init(&state->confctl_mutex);
>
>
> --
> 2.50.1
>

