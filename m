Return-Path: <linux-kernel+bounces-897161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAE7C522AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FF9188FF37
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0628831C576;
	Wed, 12 Nov 2025 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="U+gzFIU/"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0D831B809;
	Wed, 12 Nov 2025 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948620; cv=none; b=crcNvTvEPHUllQh+LurtBpQO92qHcYUlLe4P6YnlL+beLwnRdqxuBASMDtKvfrOW6STmr/ckPfvAYOavWnt9hqVqZXRCFHTIoSqjTvZqkzjQ6opPu9bWQMGiZZ3S6PtNU8tEd7RKcWJFTch4ix9qz1DDnUzglwC3fMa84HHGW/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948620; c=relaxed/simple;
	bh=zTcg7shsgAiP9rYLs4tmSZysIL5InAg9GgS9Auum/1g=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=g9WeOvMeL54sPqPq/7BYH2Lh8AVCy3FsTgfyVxLmFhzKFilOLQONTjgZUXZs1Bolv8MzR6/RZb4oUYusCv3MYWqmsMO+gvJyZCIM1fyMs8JLaCIwHkkkIdBtPfjPyOAUuAVUkrI0L2tNxVgKfE4RKbShvzHslVCiVMsjvMrwtWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=U+gzFIU/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c66:d4c7:f5bd:b015:f4e9:fab0])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4DB2810D;
	Wed, 12 Nov 2025 12:54:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762948495;
	bh=zTcg7shsgAiP9rYLs4tmSZysIL5InAg9GgS9Auum/1g=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=U+gzFIU/u8sFPmIBKK580Od3XgB1TTGe311pWVIHJQv1b/Xg3sZA6ij3aqLlHJs6x
	 G44f/fEwrqiNwYoHyzi3on6Z3MBATIcWOdOQxaevxGivOJGg3LyYqR/eVKrpnUDlOD
	 uwnztIL1BOb3rSnlLUSFdO2XPhzmFE2sx7APFQdo=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <u5wdva6kk5n6q5myj3wuy4bxqhaqyhk2ngentrj4p3v5447y2a@3kujjl3nnwea>
References: <20251028-b4-rpi-ov5647-v1-0-098413454f5e@ideasonboard.com> <20251028-b4-rpi-ov5647-v1-6-098413454f5e@ideasonboard.com> <u5wdva6kk5n6q5myj3wuy4bxqhaqyhk2ngentrj4p3v5447y2a@3kujjl3nnwea>
Subject: Re: [PATCH 06/13] media: i2c: ov5647: Support HFLIP and VFLIP
From: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, Jacopo Mondi <jacopo@jmondi.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Kieran Bingham <kieran.bingham@ideasonboard.com>, David Plowman <david.plowman@raspberrypi.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Peter Robinson <pbrobinson@gmail.com>, Stefan Wahren <wahrenst@gmx.net>, Ivan T. Ivanov <iivanov@suse.de>
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Date: Wed, 12 Nov 2025 17:26:50 +0530
Message-ID: <176294861029.13219.15475344635093672267@freya>
User-Agent: alot/0.12.dev28+gd2c823fe

Hi Jacopo,

Thanks a lot for the review.

Quoting Jacopo Mondi (2025-11-02 16:20:36)
> Hi Jai
>=20
> On Tue, Oct 28, 2025 at 12:57:17PM +0530, Jai Luthra wrote:
> > From: David Plowman <david.plowman@raspberrypi.com>
> >
> > Add missing controls for horizontal and vertical flipping.
> >
> > Signed-off-by: David Plowman <david.plowman@raspberrypi.com>
> > Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
> > ---
> >  drivers/media/i2c/ov5647.c | 77 ++++++++++++++++++++++++++++++++++++++=
++++----
> >  1 file changed, 71 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
> > index 977b878b0d4b8cd5f39f510ebd8b33c9163f7da2..a33e2d8edc114d302e83063=
9cb7cb161f16a6208 100644
> > --- a/drivers/media/i2c/ov5647.c
> > +++ b/drivers/media/i2c/ov5647.c
> > @@ -54,6 +54,8 @@
> >  #define OV5647_REG_GAIN_LO           0x350b
> >  #define OV5647_REG_VTS_HI            0x380e
> >  #define OV5647_REG_VTS_LO            0x380f
> > +#define OV5647_REG_VFLIP             0x3820
> > +#define OV5647_REG_HFLIP             0x3821
> >  #define OV5647_REG_FRAME_OFF_NUMBER  0x4202
> >  #define OV5647_REG_MIPI_CTRL00               0x4800
> >  #define OV5647_REG_MIPI_CTRL14               0x4814
> > @@ -109,6 +111,8 @@ struct ov5647 {
> >       struct v4l2_ctrl                *hblank;
> >       struct v4l2_ctrl                *vblank;
> >       struct v4l2_ctrl                *exposure;
> > +     struct v4l2_ctrl                *hflip;
> > +     struct v4l2_ctrl                *vflip;
> >  };
> >
> >  static inline struct ov5647 *to_sensor(struct v4l2_subdev *sd)
> > @@ -150,7 +154,7 @@ static struct regval_list ov5647_2592x1944_10bpp[] =
=3D {
> >       {0x3036, 0x69},
> >       {0x303c, 0x11},
> >       {0x3106, 0xf5},
> > -     {0x3821, 0x06},
> > +     {0x3821, 0x00},
> >       {0x3820, 0x00},
>=20
> That's interesting, as the datasheet says that by default
>=20
>         3820 =3D 0x40
>         3821 =3D 0x00
>=20
> And
> - BIT[2] =3D flip ISP
> - BIT[1] =3D flip SNR
>=20
> The implementation of ov5647_s_flip() toggles BIT(1) and ignores
> BIT(2) while the modes definition have both (BIT(2) | BIT(1)) set
>=20
> More interestingly the datasheet says:
>=20
> In flip mode, the OV5647 does not need additional settings because the
> ISP block will auto-detect whether the pixel is in the red line or
> blue line and make the necessary adjustments
>=20
> Might this suggest that if we flip using BIT(2) we don't need to
> change the bayer pattern ordering ?

Indeed! That was a great find, I am now able to set BIT(2) to get flips
without needing to modify the pixelarray layout.

Will do that in v2.

>=20
> Now, I admit I'm not sure what are the ISP functions on the ov5647 and
> this patch is super-duper-tested as it comes from the RPi BSP, so if
> you don't have answers to the above questions, I'm fine with this
> patch!
>=20
> >       {0x3827, 0xec},
> >       {0x370c, 0x03},
> > @@ -239,7 +243,7 @@ static struct regval_list ov5647_1080p30_10bpp[] =
=3D {
> >       {0x3036, 0x62},
> >       {0x303c, 0x11},
> >       {0x3106, 0xf5},
> > -     {0x3821, 0x06},
> > +     {0x3821, 0x00},
> >       {0x3820, 0x00},
> >       {0x3827, 0xec},
> >       {0x370c, 0x03},
> > @@ -403,7 +407,7 @@ static struct regval_list ov5647_2x2binned_10bpp[] =
=3D {
> >       {0x4800, 0x24},
> >       {0x3503, 0x03},
> >       {0x3820, 0x41},
> > -     {0x3821, 0x07},
> > +     {0x3821, 0x01},
> >       {0x350a, 0x00},
> >       {0x350b, 0x10},
> >       {0x3500, 0x00},
> > @@ -419,7 +423,7 @@ static struct regval_list ov5647_640x480_10bpp[] =
=3D {
> >       {0x3035, 0x11},
> >       {0x3036, 0x46},
> >       {0x303c, 0x11},
> > -     {0x3821, 0x07},
> > +     {0x3821, 0x01},
> >       {0x3820, 0x41},
> >       {0x370c, 0x03},
> >       {0x3612, 0x59},
> > @@ -935,6 +939,26 @@ static const struct v4l2_subdev_video_ops ov5647_s=
ubdev_video_ops =3D {
> >       .s_stream =3D             ov5647_s_stream,
> >  };
> >
> > +/*
> > + * This function returns the mbus code for the current settings of the=
 HFLIP
> > + * and VFLIP controls.
> > + */
> > +static u32 ov5647_get_mbus_code(struct v4l2_subdev *sd)
> > +{
> > +     struct ov5647 *sensor =3D to_sensor(sd);
> > +     /* The control values are only 0 or 1. */
> > +     int index =3D  sensor->hflip->val | (sensor->vflip->val << 1);
> > +
> > +     static const u32 codes[4] =3D {
> > +             MEDIA_BUS_FMT_SGBRG10_1X10,
> > +             MEDIA_BUS_FMT_SBGGR10_1X10,
> > +             MEDIA_BUS_FMT_SRGGB10_1X10,
> > +             MEDIA_BUS_FMT_SGRBG10_1X10
> > +     };
> > +
> > +     return codes[index];
> > +}
> > +
> >  static int ov5647_enum_mbus_code(struct v4l2_subdev *sd,
> >                                struct v4l2_subdev_state *sd_state,
> >                                struct v4l2_subdev_mbus_code_enum *code)
> > @@ -942,7 +966,7 @@ static int ov5647_enum_mbus_code(struct v4l2_subdev=
 *sd,
> >       if (code->index > 0)
> >               return -EINVAL;
> >
> > -     code->code =3D MEDIA_BUS_FMT_SBGGR10_1X10;
> > +     code->code =3D ov5647_get_mbus_code(sd);
> >
> >       return 0;
> >  }
> > @@ -953,7 +977,7 @@ static int ov5647_enum_frame_size(struct v4l2_subde=
v *sd,
> >  {
> >       const struct v4l2_mbus_framefmt *fmt;
> >
> > -     if (fse->code !=3D MEDIA_BUS_FMT_SBGGR10_1X10 ||
> > +     if (fse->code !=3D ov5647_get_mbus_code(sd) ||
> >           fse->index >=3D ARRAY_SIZE(ov5647_modes))
> >               return -EINVAL;
> >
> > @@ -986,6 +1010,8 @@ static int ov5647_get_pad_fmt(struct v4l2_subdev *=
sd,
> >       }
> >
> >       *fmt =3D *sensor_format;
> > +     /* The code we pass back must reflect the current h/vflips. */
> > +     fmt->code =3D ov5647_get_mbus_code(sd);
> >       mutex_unlock(&sensor->lock);
> >
> >       return 0;
> > @@ -1033,6 +1059,8 @@ static int ov5647_set_pad_fmt(struct v4l2_subdev =
*sd,
> >                                        exposure_def);
> >       }
> >       *fmt =3D mode->format;
> > +     /* The code we pass back must reflect the current h/vflips. */
> > +     fmt->code =3D ov5647_get_mbus_code(sd);
> >       mutex_unlock(&sensor->lock);
> >
> >       return 0;
> > @@ -1208,6 +1236,25 @@ static int ov5647_s_exposure(struct v4l2_subdev =
*sd, u32 val)
> >       return ov5647_write(sd, OV5647_REG_EXP_LO, (val & 0xf) << 4);
> >  }
> >
> > +static int ov5647_s_flip(struct v4l2_subdev *sd, u16 reg, u32 ctrl_val)
> > +{
> > +     int ret;
> > +     u8 reg_val;
> > +
> > +     /* Set or clear bit 1 and leave everything else alone. */
> > +     ret =3D ov5647_read(sd, reg, &reg_val);
> > +     if (ret =3D=3D 0) {
> > +             if (ctrl_val)
> > +                     reg_val |=3D 2;
> > +             else
> > +                     reg_val &=3D ~2;
> > +
> > +             ret =3D ov5647_write(sd, reg, reg_val);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> >  static int ov5647_s_ctrl(struct v4l2_ctrl *ctrl)
> >  {
> >       struct ov5647 *sensor =3D container_of(ctrl->handler,
> > @@ -1270,6 +1317,14 @@ static int ov5647_s_ctrl(struct v4l2_ctrl *ctrl)
> >               /* Read-only, but we adjust it based on mode. */
> >               break;
> >
> > +     case V4L2_CID_HFLIP:
> > +             /* There's an in-built hflip in the sensor, so account fo=
r that here. */
> > +             ov5647_s_flip(sd, OV5647_REG_HFLIP, !ctrl->val);
> > +             break;
> > +     case V4L2_CID_VFLIP:
> > +             ov5647_s_flip(sd, OV5647_REG_VFLIP, ctrl->val);
> > +             break;
>=20
> The modes definition used to set
>=20
>         0x3820 =3D 0x00
>         0x3821 =3D 0x06
>=20
> Is this the built-in hflip ?
>=20
> Or does it mean that setting the registers value to 1 'disabled' flips ?
>=20

Yes, this particular sensor flips the image horizontally if 0x3820 =3D 0x00,
resulting in a mirrored image.

But now that userspace can control flips, I am a bit confused on how to
report this in the controls.

> > +
> >       default:
> >               dev_info(&client->dev,
> >                        "Control (id:0x%x, val:0x%x) not supported\n",
> > @@ -1341,6 +1396,16 @@ static int ov5647_init_controls(struct ov5647 *s=
ensor, struct device *dev)
> >                                    ARRAY_SIZE(ov5647_test_pattern_menu)=
 - 1,
> >                                    0, 0, ov5647_test_pattern_menu);
> >
> > +     sensor->hflip =3D v4l2_ctrl_new_std(&sensor->ctrls, &ov5647_ctrl_=
ops,
> > +                                       V4L2_CID_HFLIP, 0, 1, 1, 0);
> > +     if (sensor->hflip)
> > +             sensor->hflip->flags |=3D V4L2_CTRL_FLAG_MODIFY_LAYOUT;
>=20
> I wonder if hflip is enabled by default we shouldn't register the
> control with default value of 1 ?
>=20

My preference is to let the driver toggle the value for HFLIP before
writing to the sensor, as it is done currently in this patch.

This makes this sensor behave like others, where you get a normal
non-mirrored image when you set HFLIP =3D 0, and mirrored if HFLIP =3D 1.

The alternative is to keep the driver transparent by reporting the register
values as-is in the control. In that case, we should make horizontal_flip =
=3D
1 the default value for the control. But I'm not aware if any userspace
applications will override the default value resulting in bad experience
for the users.

WDYT?

Thanks,
    Jai

> > +
> > +     sensor->vflip =3D v4l2_ctrl_new_std(&sensor->ctrls, &ov5647_ctrl_=
ops,
> > +                                       V4L2_CID_VFLIP, 0, 1, 1, 0);
> > +     if (sensor->vflip)
> > +             sensor->vflip->flags |=3D V4L2_CTRL_FLAG_MODIFY_LAYOUT;
> > +
> >       v4l2_fwnode_device_parse(dev, &props);
> >
> >       v4l2_ctrl_new_fwnode_properties(&sensor->ctrls, &ov5647_ctrl_ops,
> >
> > --
> > 2.51.0
> >

