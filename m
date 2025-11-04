Return-Path: <linux-kernel+bounces-885042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB998C31CEB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66264189AFA2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DEF258CDA;
	Tue,  4 Nov 2025 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="B1mtm+bD"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C424888A;
	Tue,  4 Nov 2025 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269712; cv=none; b=D1IUnzeBGUXkjeSSvYTV876q2jD6Obe6TKzAeLMESejPaHNCRS+j6GCpxSnd6xVgmQVMAqy8q7CV0iEC8GbFrglH8gb0QP4JZcSn3NnEgW3jp0j+CsbFpLoDYwWMq3zocDxWMBBp7fLkiWorXyNOWZFiZRUv6Igi3z6lIS/i4G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269712; c=relaxed/simple;
	bh=6LXznxR2BwU8Z9YC9RYhzfAgtDIv5B8KIKF2ao3iAY4=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=fWwW8ROagH8RZoB5tEYgrBdnnihoEF4j0N12Ss0frO4Wt79Abc/rG7/Sgx1rgLfNz/T7+eRI+PE1L5w5mFf/IWLoRuq0dy0b1tlWiRxOuNZpaRJXiOpSQYyz5T7hmwWNGxePbexivNwyAGezCA9s+/l28dg5x6AuGuTCtxqvDUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=B1mtm+bD; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from thinkpad.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 055C422A;
	Tue,  4 Nov 2025 16:19:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762269594;
	bh=6LXznxR2BwU8Z9YC9RYhzfAgtDIv5B8KIKF2ao3iAY4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=B1mtm+bDKyrhASTQJIaOWjxUmG6QUZK32rkt3W6xXzxLosPVRgd5KhZKELIlwRJ/1
	 VTjLFdWBOoCyXd57WR0OmkeDP+15uiJrEX4lCnlQYnKx7oXK7EABc2vZkA9TeJkeCz
	 9n6rN3QkJkUQM/8IE9ILGfLuyGl0P0ORGvtLRYwA=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251031114835.113026-2-tarang.raval@siliconsignals.io>
References: <20251031114835.113026-1-tarang.raval@siliconsignals.io> <20251031114835.113026-2-tarang.raval@siliconsignals.io>
Subject: Re: [PATCH v1 1/2] media: i2c: imx219: Propagate errors from control range updates
From: Isaac Scott <isaac.scott@ideasonboard.com>
Cc: Tarang Raval <tarang.raval@siliconsignals.io>, Dave Stevenson <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
To: Tarang Raval <tarang.raval@siliconsignals.io>, sakari.ailus@linux.intel.com
Date: Tue, 04 Nov 2025 15:21:44 +0000
Message-ID: <176226970472.106261.8875678531563586397@isaac-ThinkPad-T16-Gen-2>
User-Agent: alot/0.10

Hi Tarang,

Thank you for the patch!

Quoting Tarang Raval (2025-10-31 11:48:34)
> Propagate return values from __v4l2_ctrl_modify_range() and
> __v4l2_ctrl_s_ctrl() in imx219_set_ctrl() and imx219_set_pad_format().
> This ensures proper error handling instead of ignoring possible
> failures. Also return the result of imx219_set_pad_format() from
> imx219_init_state().
>=20
> Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>

Reviewed-by: Isaac Scott <isaac.scott@ideasonboard.com>

> ---
>  drivers/media/i2c/imx219.c | 61 +++++++++++++++++++++++++-------------
>  1 file changed, 40 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> index 48efdcd2a8f9..40693635c0c3 100644
> --- a/drivers/media/i2c/imx219.c
> +++ b/drivers/media/i2c/imx219.c
> @@ -453,10 +453,14 @@ static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
>                 exposure_max =3D format->height + ctrl->val - 4;
>                 exposure_def =3D (exposure_max < IMX219_EXPOSURE_DEFAULT)=
 ?
>                         exposure_max : IMX219_EXPOSURE_DEFAULT;
> -               __v4l2_ctrl_modify_range(imx219->exposure,
> -                                        imx219->exposure->minimum,
> -                                        exposure_max, imx219->exposure->=
step,
> -                                        exposure_def);
> +               ret =3D __v4l2_ctrl_modify_range(imx219->exposure,
> +                                              imx219->exposure->minimum,
> +                                              exposure_max,
> +                                              imx219->exposure->step,
> +                                              exposure_def);
> +               if (ret)
> +                       return ret;
> +
>         }
> =20
>         /*
> @@ -848,6 +852,7 @@ static int imx219_set_pad_format(struct v4l2_subdev *=
sd,
>         struct v4l2_rect *crop;
>         u8 bin_h, bin_v, binning;
>         u32 prev_line_len;
> +       int ret;
> =20
>         format =3D v4l2_subdev_state_get_format(state, 0);
>         prev_line_len =3D format->width + imx219->hblank->val;
> @@ -883,19 +888,28 @@ static int imx219_set_pad_format(struct v4l2_subdev=
 *sd,
>                 int pixel_rate;
> =20
>                 /* Update limits and set FPS to default */
> -               __v4l2_ctrl_modify_range(imx219->vblank, IMX219_VBLANK_MI=
N,
> -                                        IMX219_FLL_MAX - mode->height, 1,
> +               ret =3D __v4l2_ctrl_modify_range(imx219->vblank, IMX219_V=
BLANK_MIN,
> +                                              IMX219_FLL_MAX - mode->hei=
ght, 1,
> +                                              mode->fll_def - mode->heig=
ht);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D __v4l2_ctrl_s_ctrl(imx219->vblank,
>                                          mode->fll_def - mode->height);
> -               __v4l2_ctrl_s_ctrl(imx219->vblank,
> -                                  mode->fll_def - mode->height);
> +               if (ret)
> +                       return ret;
> +
>                 /* Update max exposure while meeting expected vblanking */
>                 exposure_max =3D mode->fll_def - 4;
>                 exposure_def =3D (exposure_max < IMX219_EXPOSURE_DEFAULT)=
 ?
>                         exposure_max : IMX219_EXPOSURE_DEFAULT;
> -               __v4l2_ctrl_modify_range(imx219->exposure,
> -                                        imx219->exposure->minimum,
> -                                        exposure_max, imx219->exposure->=
step,
> -                                        exposure_def);
> +               ret =3D __v4l2_ctrl_modify_range(imx219->exposure,
> +                                              imx219->exposure->minimum,
> +                                              exposure_max,
> +                                              imx219->exposure->step,
> +                                              exposure_def);
> +               if (ret)
> +                       return ret;
> =20
>                 /*
>                  * With analog binning the default minimum line length of=
 3448
> @@ -906,9 +920,12 @@ static int imx219_set_pad_format(struct v4l2_subdev =
*sd,
>                 imx219_get_binning(state, &bin_h, &bin_v);
>                 llp_min =3D (bin_h & bin_v) =3D=3D IMX219_BINNING_X2_ANAL=
OG ?
>                                   IMX219_BINNED_LLP_MIN : IMX219_LLP_MIN;
> -               __v4l2_ctrl_modify_range(imx219->hblank, llp_min - mode->=
width,
> -                                        IMX219_LLP_MAX - mode->width, 1,
> -                                        llp_min - mode->width);
> +               ret =3D __v4l2_ctrl_modify_range(imx219->hblank,
> +                                              llp_min - mode->width,
> +                                              IMX219_LLP_MAX - mode->wid=
th, 1,
> +                                              llp_min - mode->width);
> +               if (ret)
> +                       return ret;
>                 /*
>                  * Retain PPL setting from previous mode so that the
>                  * line time does not change on a mode change.
> @@ -917,13 +934,17 @@ static int imx219_set_pad_format(struct v4l2_subdev=
 *sd,
>                  * mode width subtracted.
>                  */
>                 hblank =3D prev_line_len - mode->width;
> -               __v4l2_ctrl_s_ctrl(imx219->hblank, hblank);
> +               ret =3D __v4l2_ctrl_s_ctrl(imx219->hblank, hblank);
> +               if (ret)
> +                       return ret;
> =20
>                 /* Scale the pixel rate based on the mode specific factor=
 */
>                 pixel_rate =3D imx219_get_pixel_rate(imx219) *
>                              imx219_get_rate_factor(state);
> -               __v4l2_ctrl_modify_range(imx219->pixel_rate, pixel_rate,
> -                                        pixel_rate, 1, pixel_rate);
> +               ret =3D __v4l2_ctrl_modify_range(imx219->pixel_rate, pixe=
l_rate,
> +                                              pixel_rate, 1, pixel_rate);
> +               if (ret)
> +                       return ret;
>         }
> =20
>         return 0;
> @@ -972,9 +993,7 @@ static int imx219_init_state(struct v4l2_subdev *sd,
>                 },
>         };
> =20
> -       imx219_set_pad_format(sd, state, &fmt);
> -
> -       return 0;
> +       return imx219_set_pad_format(sd, state, &fmt);
>  }
> =20
>  static const struct v4l2_subdev_video_ops imx219_video_ops =3D {
> --=20
> 2.34.1
>=20
>

