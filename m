Return-Path: <linux-kernel+bounces-883507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1B6C2DA0C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E27A04E8129
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3821271451;
	Mon,  3 Nov 2025 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="lFgd8s97"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59546191F92
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193875; cv=none; b=C0Y1wIURs64DqusMC3/JzSGkUBMmxXaeeup6f1e6YC4VSxV3F9WjEPTjesQ9K/SVn9Qy/BKf1CMDkLaox9s5vTKmTYGifC8/RPV/x541MqTjNOoo9eKZWiKZrlK33z2yLrYHgU8ORBTTwcx+4/mbMdJsCOHFpL/7iMOdJBcfSiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193875; c=relaxed/simple;
	bh=q3logXzsizlE7vxCDEHKIRUBbcalhSKwMKCC5YbOdeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2IV7n0mVdU8wIAIWvmUjso+qlSaGoeFgEpMV63Oe85S1ZCJbOmrwp/AfBNm3fx9xwdxHWlDSjLniuB2J9cVHH0Tx2y5a9okyZZXrXA8zLq61+OfmhcPx1x8evyIT4WaE8VNvegrn+qoGfZemdIqpQsONHY6/if04lRQIwBMyuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=lFgd8s97; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7866dcf50b1so14377077b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1762193871; x=1762798671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/xmAK/aryaCve4zg5te4EbYXs5XtAGc70a0N7jrOVis=;
        b=lFgd8s976x7GSAgtbxgIha2fcT43XDvV8skZh1K4878SKJWRK+x26KBg8J6OwIlAc/
         Qlo0KgIMGBdU/lMRXPL1ytvkimGW24FD8rNIMzRGXmWA0yMP9oj3s1v0kGUz/9czj2kW
         J9DAXu8LvnLVsfEgLq3YHo+tNZqVaQO8EHsQUU2JNnkrdaPPmFND+KKqg5b45khIKcWX
         eO8NIefBS7d++6RU7Xd+AVJavdbGjDbFu9Vx95lg73pfhuXrHxEtJ+9wNRYKxlk6YxD1
         ZW+Xvv+1gcEdZiIbQJ7GVHTOT2p0anF+r/kPpuFnI/qTNRJqCYsLMXITGZoIRqN4bXLC
         Pa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762193871; x=1762798671;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xmAK/aryaCve4zg5te4EbYXs5XtAGc70a0N7jrOVis=;
        b=un4vSMCavlTsC5UenS6WBXbN8mGhVcKCyAgtVTY9OrvdAAqWwX2DZnVGQdO1yJWyC1
         PetByokN2sPGVELx0QaZmIiJqwIygGILjx8R7bjhER9DPIU3m5UbS8987CpIApzT1kmy
         kIE1IXPcTLD46kbIgjsqI4z9fQg6utLJGr7uJnmcB/vy5lz5HlGpXUc6nfPqGaJIwE69
         Jwp7WZ1drz85zqGBNYF1X53Hdjv724A+0GaRXBWAOF9De9pxChnl2p70Z3WIjxeOWyA8
         x1kaXj+4ozLu3uNtaiAI3ctKLOk44Ze6+XH+zddylryoF0dIoyL5LrZT4xGtIUP2IO+p
         MxuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBH9Iymkjty2cpGgOjoNql7JnfEfxjgXod/R4BvMy+3sNrwc533xZtWR+RXxfz6lsOGJQihHZDHz7xKhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTCKjaA0hsUJ7660ng+5yScQ56mmFFrlmepwZcEszUfK1N9dBk
	jlv4GdXnqCs0BW7IKEVJ28/1NcDVkB/Fk0NvGpSfKyCjfm51FmjcfoiHkzcopn+3qNZB2GX42tK
	sx2yTNGuiM7g6KGZfs6wtQsZcR2ytPtbC8Qc5sQLJIg==
X-Gm-Gg: ASbGncuvNnl3+ZD5WuRzY/2Ut1buwKRTydeQNjDxDIiLUImM6m39COe9z/6oDneVLlg
	vElDegC4Z/Prn+QDhZidys0HaevBqkuDiFFnRF7Cdt1Uk1KSFg7d+xL9iPQF9we4zPkQbtfyCw7
	xRTvQVL26CanxrgACP6X/NbbVMeCQcegfr1JUHD4729IhBdsZqVdXEcknxDmSiUsOOEYMjGjfiE
	E8KsRsfFC9QdHM/CaE3nfE1UqhnspPCu3G+ruk8tFVZIPwBjgjTFKwtMvqQqsgTpGMmhk+bUQUZ
	uX4Pxk7SZ7GQEy+Jq4vX5ZO7Avo=
X-Google-Smtp-Source: AGHT+IFqE8B94Mp2/FJ4pe8YGqharK3QI0mj5qNCj+r9MNVvDf2hJB3l7zQZO5XO9mTAk+uegLHpNOSHPzCdeHMMZAU=
X-Received: by 2002:a05:690c:62c4:b0:786:5789:57df with SMTP id
 00721157ae682-78657895902mr97319357b3.45.1762193871162; Mon, 03 Nov 2025
 10:17:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031114835.113026-1-tarang.raval@siliconsignals.io> <20251031114835.113026-2-tarang.raval@siliconsignals.io>
In-Reply-To: <20251031114835.113026-2-tarang.raval@siliconsignals.io>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 3 Nov 2025 18:17:31 +0000
X-Gm-Features: AWmQ_bmurtv0JEn9tphiJaL2oYCvaL0iF7Drv_num1dn1VxlUEctW68r9rEtJqs
Message-ID: <CAPY8ntDy0NmU5D6Q=v+X0nN9beGFLWHQp0jpfNYq+shGaam87g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] media: i2c: imx219: Propagate errors from control
 range updates
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: sakari.ailus@linux.intel.com, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tarang

On Fri, 31 Oct 2025 at 11:49, Tarang Raval
<tarang.raval@siliconsignals.io> wrote:
>
> Propagate return values from __v4l2_ctrl_modify_range() and
> __v4l2_ctrl_s_ctrl() in imx219_set_ctrl() and imx219_set_pad_format().
> This ensures proper error handling instead of ignoring possible
> failures. Also return the result of imx219_set_pad_format() from
> imx219_init_state().

It should be impossible for a number of these to fail unless someone
has messed up in updating the driver, but it does little harm in
returning the error code back out.

The slight hesitation would be that in imx219_set_pad_format you could
have updated the ranges/values of one or more controls, and then fail
leaving a partially implemented mode change. It has returned an error,
but an application would be reasonable in thinking that the previous
working state has been retained when it hasn't.
As long as it would only trigger due to a driver bug rather than user
interaction, I would *not* propose that all values have to be saved
and have to be restored on failure. It just gets too ugly.

> Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/media/i2c/imx219.c | 61 +++++++++++++++++++++++++-------------
>  1 file changed, 40 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> index 48efdcd2a8f9..40693635c0c3 100644
> --- a/drivers/media/i2c/imx219.c
> +++ b/drivers/media/i2c/imx219.c
> @@ -453,10 +453,14 @@ static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
>                 exposure_max = format->height + ctrl->val - 4;
>                 exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
>                         exposure_max : IMX219_EXPOSURE_DEFAULT;
> -               __v4l2_ctrl_modify_range(imx219->exposure,
> -                                        imx219->exposure->minimum,
> -                                        exposure_max, imx219->exposure->step,
> -                                        exposure_def);
> +               ret = __v4l2_ctrl_modify_range(imx219->exposure,
> +                                              imx219->exposure->minimum,
> +                                              exposure_max,
> +                                              imx219->exposure->step,
> +                                              exposure_def);
> +               if (ret)
> +                       return ret;
> +
>         }
>
>         /*
> @@ -848,6 +852,7 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
>         struct v4l2_rect *crop;
>         u8 bin_h, bin_v, binning;
>         u32 prev_line_len;
> +       int ret;
>
>         format = v4l2_subdev_state_get_format(state, 0);
>         prev_line_len = format->width + imx219->hblank->val;
> @@ -883,19 +888,28 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
>                 int pixel_rate;
>
>                 /* Update limits and set FPS to default */
> -               __v4l2_ctrl_modify_range(imx219->vblank, IMX219_VBLANK_MIN,
> -                                        IMX219_FLL_MAX - mode->height, 1,
> +               ret = __v4l2_ctrl_modify_range(imx219->vblank, IMX219_VBLANK_MIN,
> +                                              IMX219_FLL_MAX - mode->height, 1,
> +                                              mode->fll_def - mode->height);
> +               if (ret)
> +                       return ret;
> +
> +               ret = __v4l2_ctrl_s_ctrl(imx219->vblank,
>                                          mode->fll_def - mode->height);
> -               __v4l2_ctrl_s_ctrl(imx219->vblank,
> -                                  mode->fll_def - mode->height);
> +               if (ret)
> +                       return ret;
> +
>                 /* Update max exposure while meeting expected vblanking */
>                 exposure_max = mode->fll_def - 4;
>                 exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
>                         exposure_max : IMX219_EXPOSURE_DEFAULT;
> -               __v4l2_ctrl_modify_range(imx219->exposure,
> -                                        imx219->exposure->minimum,
> -                                        exposure_max, imx219->exposure->step,
> -                                        exposure_def);
> +               ret = __v4l2_ctrl_modify_range(imx219->exposure,
> +                                              imx219->exposure->minimum,
> +                                              exposure_max,
> +                                              imx219->exposure->step,
> +                                              exposure_def);
> +               if (ret)
> +                       return ret;
>
>                 /*
>                  * With analog binning the default minimum line length of 3448
> @@ -906,9 +920,12 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
>                 imx219_get_binning(state, &bin_h, &bin_v);
>                 llp_min = (bin_h & bin_v) == IMX219_BINNING_X2_ANALOG ?
>                                   IMX219_BINNED_LLP_MIN : IMX219_LLP_MIN;
> -               __v4l2_ctrl_modify_range(imx219->hblank, llp_min - mode->width,
> -                                        IMX219_LLP_MAX - mode->width, 1,
> -                                        llp_min - mode->width);
> +               ret = __v4l2_ctrl_modify_range(imx219->hblank,
> +                                              llp_min - mode->width,
> +                                              IMX219_LLP_MAX - mode->width, 1,
> +                                              llp_min - mode->width);
> +               if (ret)
> +                       return ret;
>                 /*
>                  * Retain PPL setting from previous mode so that the
>                  * line time does not change on a mode change.
> @@ -917,13 +934,17 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
>                  * mode width subtracted.
>                  */
>                 hblank = prev_line_len - mode->width;
> -               __v4l2_ctrl_s_ctrl(imx219->hblank, hblank);
> +               ret = __v4l2_ctrl_s_ctrl(imx219->hblank, hblank);
> +               if (ret)
> +                       return ret;
>
>                 /* Scale the pixel rate based on the mode specific factor */
>                 pixel_rate = imx219_get_pixel_rate(imx219) *
>                              imx219_get_rate_factor(state);
> -               __v4l2_ctrl_modify_range(imx219->pixel_rate, pixel_rate,
> -                                        pixel_rate, 1, pixel_rate);
> +               ret = __v4l2_ctrl_modify_range(imx219->pixel_rate, pixel_rate,
> +                                              pixel_rate, 1, pixel_rate);
> +               if (ret)
> +                       return ret;
>         }
>
>         return 0;
> @@ -972,9 +993,7 @@ static int imx219_init_state(struct v4l2_subdev *sd,
>                 },
>         };
>
> -       imx219_set_pad_format(sd, state, &fmt);
> -
> -       return 0;
> +       return imx219_set_pad_format(sd, state, &fmt);
>  }
>
>  static const struct v4l2_subdev_video_ops imx219_video_ops = {
> --
> 2.34.1
>

