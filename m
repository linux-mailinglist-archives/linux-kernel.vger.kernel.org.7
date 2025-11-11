Return-Path: <linux-kernel+bounces-895461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F22C4E017
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 322814F6A25
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8445324703;
	Tue, 11 Nov 2025 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNsEAXUR"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F33246F0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762865648; cv=none; b=PunKOhMzRvWqZ+3pMO0jWiLtJOUR6YpwOjAFbcIvEK03JbuCyRs2MaLvC+4qWc/PVDXasZNl7kbZwo59us3Q9eJWdGFraop/eIgZSpwh7LFDy6q0R6YYMJRB8wmfGFN02L2KzeEDQZfBZ7cJzR6tnwc/4At3I1PkLZal0cMt7xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762865648; c=relaxed/simple;
	bh=unPRQlRCJ21nxfJRMtud04497uOiOiOlZ2lRqQFcIcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jC0f/hFbHUqxqW2ZM2SPSy3F+seqMmt/JkFJl8Wx9+QLSNJnhnpC3HE9QswQCXhEMvXzqFWP6vX/oAksXf7B0MWEJsIE4PgoUCm1PluiLPnrc4Y7r66mPs4jI6x2doDF9VS7+LP1lWwrinXaiv86amio6qDZUyHb0A7SqCp7zjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNsEAXUR; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b379cd896so1375668f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762865644; x=1763470444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pixwuy1Oa1ogyBxcT1j1wEd+TT+wyOXiJagDOyZSIQ4=;
        b=FNsEAXURcTFyTUkbRwvcZ4w2qeI3XtaMjXxHo32MFQm0f/+t28CVzuqqmAxR+IZfWs
         BbFj4p37er3X0GKQD/3BjgGpeluVPlKx+bAWM6cJDLtt0N7ZMCjznYrcYUWsUHikHxpi
         uTc45PjnndVraslmw8MAStIuPLHcFV15honrjPip52DBiLKZFID3XrBmEAe3yhBgQUPS
         /Ot0SbRz5gDaz9NNpCoZiKC2RfROvg0BxZYw+J2bK0pZlibLxCSxJHu3OMj4+vLBClf8
         QufKS1lrqmWofaIOLo3LxsMX1a8Z0jTphrNqjyUiPQR4G307QXTj+isUMxle4OpBTVfY
         FTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762865644; x=1763470444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pixwuy1Oa1ogyBxcT1j1wEd+TT+wyOXiJagDOyZSIQ4=;
        b=qnwwJWxYEehr83+b5KhrE5ghuUax5I4UYMDYty5wbyOqf6tRhp70Tw0pNtbPpZZ3/h
         +YZnGm02OPSRzhGFJxJ/hWbdwitFJVd0a2kZExnGBPTRvNZBZa5ZRh0FQYmwXyHCIA7r
         6ukM+Ze31PDx9UGBc4BrPEGFa6ovV66TFHsKzU4EzspBJWp7jWB/7y3poxIeBbhH+0W1
         P8m/GM4pETX48AXLnvnVA3GoLjWblT/fzpS3s9JNQMsvlL6YIjI9TBs56li1swPONbxa
         /YvXyGR6dGXInSYOCzljo2TNJ2k0teeHQ7SII2m9V+2XvB+zNSDHKNno3226oTHV0pL0
         YHQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlz5sq2+0BPsn00CgNuBG72M9Vv0mhZCCsfM5Rw/Gs24UDOYNaapihFUB3qY/zXsAyc75w7GaPQo8Uuz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM7nziGTIRvtdBUrZlxL+Y75+qSNNAE9bmi0s92T9h3FUjDmDf
	eYP9STxZXuZRYQ2by2DDjioHkVJgG8mMKXANcVoEjUjyeJzikgIBAzN/8R0cCR0b4n5tG0CmHeU
	A1BUSqOF1iUazoL3Jbj2OEvHXUomd4d8=
X-Gm-Gg: ASbGncvZi0AycLRkBact6OQSyFBfX+C1eIbYXuN5+8uM0/H/3aKkp7jYgD3jaOG3kf/
	Gg5NFjCGiQgLcJ1KfCd+hVAuGjvvhpMdXwjPJzf3b6XnHTEVELIsybRizntIF6um6SEW//sMhht
	efNd76I2gnHUNllJ4iiysLCKUb5OUbIEHP+OphcpeCRt+u/YvBaN/jHZB370Ma7WB4/OyRuy5oF
	OhXRDvm43ssZwT1TCkbsaGqDrvxqyFgRhcrWFfLJNDcbVbXmqhvf45A1b0QdA==
X-Google-Smtp-Source: AGHT+IEj7gx0ZiIu8BHrdAC+RVKzNHGyLsGQt9LcZaen6jm13AdkSwj5HFslTJBizBUrMSWhJo2iezYgOwIO6CC4P5o=
X-Received: by 2002:a05:6000:420b:b0:429:d66b:508f with SMTP id
 ffacd0b85a97d-42b2dc856admr9311463f8f.30.1762865644130; Tue, 11 Nov 2025
 04:54:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103145629.21588-1-clamor95@gmail.com> <20251103145629.21588-3-clamor95@gmail.com>
 <aRMw_Qre1FY94soi@kekkonen.localdomain>
In-Reply-To: <aRMw_Qre1FY94soi@kekkonen.localdomain>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 11 Nov 2025 14:53:52 +0200
X-Gm-Features: AWmQ_bkRG5HIb_qQVszAElxxq_kW24NtTOJeleHHATd4PPO2npHibxTgWHp68Qw
Message-ID: <CAPVz0n1MokJq6d4s0cS3UdevRt2n-HaicPpwiBu=3HVSKfnzfg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] media: i2c: add Sony IMX111 CMOS camera sensor driver
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	Sylvain Petinot <sylvain.petinot@foss.st.com>, 
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>, Dongcheng Yan <dongcheng.yan@intel.com>, 
	Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>, Tarang Raval <tarang.raval@siliconsignals.io>, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 11 =D0=BB=D0=B8=D1=81=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 14:5=
0 Sakari Ailus <sakari.ailus@linux.intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> A few comments below...
>
> On Mon, Nov 03, 2025 at 04:56:29PM +0200, Svyatoslav Ryhel wrote:
>
> ...
>
> > +static int imx111_set_format(struct v4l2_subdev *sd,
> > +                          struct v4l2_subdev_state *state,
> > +                          struct v4l2_subdev_format *format)
> > +{
> > +     struct imx111 *sensor =3D sd_to_imx111(sd);
> > +     struct v4l2_mbus_framefmt *mbus_fmt =3D &format->format;
> > +     struct v4l2_mbus_framefmt *fmt;
> > +     const struct imx111_mode *mode;
> > +
> > +     mode =3D v4l2_find_nearest_size(imx111_modes, ARRAY_SIZE(imx111_m=
odes),
> > +                                   width, height,
> > +                                   mbus_fmt->width, mbus_fmt->height);
> > +
> > +     fmt =3D v4l2_subdev_state_get_format(state, format->pad);
>
> You should set the fields below after changing the controls. Albeit... it
> won't be perfect in that case either, as only some controls may have been
> applied. How about just moving the lines below after changing the control=
s?
>
> > +
> > +     fmt->code =3D imx111_get_format_code(sensor, mbus_fmt->code, fals=
e);
> > +     fmt->width =3D mode->width;
> > +     fmt->height =3D mode->height;
> > +     fmt->colorspace =3D V4L2_COLORSPACE_RAW;
> > +
> > +     *mbus_fmt =3D *fmt;
> > +
> > +     if (format->which =3D=3D V4L2_SUBDEV_FORMAT_ACTIVE) {
> > +             int ret;
> > +
> > +             sensor->cur_mode =3D mode;
> > +             sensor->data_depth =3D imx111_get_format_bpp(fmt);
> > +
> > +             ret =3D __v4l2_ctrl_s_ctrl_int64(sensor->pixel_rate,
> > +                                            div_u64(sensor->pixel_clk_=
raw,
> > +                                                    2 *
> > +                                                    sensor->data_depth=
));
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D __v4l2_ctrl_modify_range(sensor->vblank,
> > +                                            IMX111_VBLANK_MIN,
> > +                                            IMX111_VTL_MAX - mode->hei=
ght,
> > +                                            1,
> > +                                            mode->vtl_def - mode->heig=
ht);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D __v4l2_ctrl_s_ctrl(sensor->vblank, mode->vtl_def =
-
> > +                                      mode->height);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D __v4l2_ctrl_modify_range(sensor->hblank,
> > +                                            IMX111_HBLANK_MIN,
> > +                                            IMX111_HTL_MAX - mode->wid=
th,
> > +                                            1,
> > +                                            mode->htl_def - mode->widt=
h);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D __v4l2_ctrl_s_ctrl(sensor->hblank, mode->htl_def =
-
> > +                                      mode->width);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
>
> ...
>
> > +static int imx111_probe(struct i2c_client *client)
> > +{
> > +     struct device *dev =3D &client->dev;
> > +     struct imx111 *sensor;
> > +     int ret;
> > +
> > +     sensor =3D devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
> > +     if (!sensor)
> > +             return -ENOMEM;
> > +
> > +     sensor->regmap =3D devm_cci_regmap_init_i2c(client, 16);
> > +     if (IS_ERR(sensor->regmap))
> > +             return dev_err_probe(dev, PTR_ERR(sensor->regmap),
> > +                                  "Failed to allocate register map\n")=
;
> > +
> > +     sensor->extclk =3D devm_v4l2_sensor_clk_get(dev, NULL);
> > +     if (IS_ERR(sensor->extclk))
> > +             return dev_err_probe(dev, PTR_ERR(sensor->extclk),
> > +                                  "Failed to get clock\n");
> > +
> > +     sensor->reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT=
_LOW);
> > +     if (IS_ERR(sensor->reset))
> > +             return dev_err_probe(dev, PTR_ERR(sensor->reset),
> > +                                  "Failed to get reset GPIO\n");
> > +
> > +     ret =3D devm_regulator_bulk_get_const(dev, ARRAY_SIZE(imx111_supp=
lies),
> > +                                         imx111_supplies,
> > +                                         &sensor->supplies);
> > +     if (ret < 0)
> > +             return dev_err_probe(dev, ret, "Failed to get regulators\=
n");
> > +
> > +     ret =3D imx111_parse_dt(sensor);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D imx111_clk_init(sensor);
> > +     if (ret < 0)
> > +             goto error_ep_free;
> > +
> > +     ret =3D imx111_power_on(sensor);
> > +     if (ret < 0) {
> > +             dev_err_probe(dev, ret, "Could not power on the device\n"=
);
> > +             goto error_ep_free;
> > +     }
> > +
> > +     ret =3D imx111_identify_module(sensor);
> > +     if (ret < 0) {
> > +             dev_err_probe(dev, ret, "Could not identify module\n");
> > +             goto error_power_off;
> > +     }
> > +
> > +     sensor->cur_mode =3D &imx111_modes[IMX111_MODE_3280x2464];
> > +     sensor->data_depth =3D IMX111_DATA_DEPTH_RAW10;
> > +
> > +     ret =3D imx111_initialize(sensor);
> > +     if (ret < 0)
> > +             goto error_power_off;
> > +
> > +     ret =3D imx111_init_subdev(sensor, client);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to init controls: %d", ret);
> > +             goto error_v4l2_ctrl_handler_free;
> > +     }
> > +
> > +     ret =3D v4l2_subdev_init_finalize(&sensor->sd);
> > +     if (ret)
> > +             goto error_v4l2_ctrl_handler_free;
> > +
> > +     pm_runtime_set_active(dev);
> > +     pm_runtime_enable(dev);
> > +
> > +     ret =3D v4l2_async_register_subdev_sensor(&sensor->sd);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to register V4L2 subdev: %d", ret);
> > +             goto error_pm;
> > +     }
> > +
> > +     pm_runtime_idle(dev);
> > +     pm_runtime_set_autosuspend_delay(dev, 1000);
> > +     pm_runtime_use_autosuspend(dev);
>
> The autosuspend should be set before pm_runtime_idle() call(), shouldn't
> it?
>
> I can make the two changes before applying, too, if that's ok.

If you don't mind adjusting commit on your own before applying I have
no objections. Thank you very much!

Best regards,
Svyatoslav R.

>
> --
> Regards,
>
> Sakari Ailus

