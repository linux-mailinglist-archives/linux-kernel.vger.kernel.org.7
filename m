Return-Path: <linux-kernel+bounces-757225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0265BB1BF6C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F8C1803B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938E21E521B;
	Wed,  6 Aug 2025 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vl45v73j"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BCA4C83;
	Wed,  6 Aug 2025 03:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754452178; cv=none; b=Wf0IOg/GO2qhE2UQB05oTw7CeKcE8GbaPtd0C9i/LADemoXGbSYt/KWgtYx+zzna0voLlvRkPNpGAbVsd8KqsT6pBKKOAbYklytJbcKcrmGlLKQJu3rzmIkX7OrfbX7yJOE3twwhWG0IvzItEwFxXtBkzyxAKiRdEmKEHeuJGr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754452178; c=relaxed/simple;
	bh=/eThyBwqlypjw9B0wVY8pPwiqsRKSHertsxnoMv0UjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3D6fZthCYQe/H/9ckxN7deUyy/NNfV7ZBUf1jK9AooTyxwIWTqLgCidHZlB3VQzubRnX+0ZfwD0AG67QrFO3Lv7XIKeueijH2rVHqShz5FQzSQ8NdNqq2MLlGv4hXvKakU39u15f/pxUP7o68l5hbhlWRhJ5wMOaKszJV7GLZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vl45v73j; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-875acfc133dso182083539f.1;
        Tue, 05 Aug 2025 20:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754452176; x=1755056976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toHeBxW3Azwu1yyrWjwubjRf82OP0uQV7/qOwz2vGTU=;
        b=Vl45v73juXCDQl2WBIG46I6G9mUb2AJch1hEHJY08iO7RtsQ9nZJrS28/FA4izaWch
         r3KinBCM/aw0OLTR/14AjXpd6VN/HVTuEkvxsDUig/+Cie368gjgLQPRA824tXjggzDJ
         jLcQtjqAvL2Ckfc0idebPk4luC6Th2ArVZGD1Tel0m2C/VLfkG3cl2Urs+dxjcWJGmuh
         Ko32mUOaLg5iRiKmHR49bDdnzRtWv5gAwc1cHTNJ6y5TRRz0ZLmjZnKefl0SeZT1khbn
         R5MwdmTT+i2BS8L+qT0+VQgzI7ZFIAMRklc/fFH+B1oJz00etASLs/HdcCgu8u3mA7Gw
         hJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754452176; x=1755056976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toHeBxW3Azwu1yyrWjwubjRf82OP0uQV7/qOwz2vGTU=;
        b=BIOIhkkKSkv+7qoQzXYES3enqfHve8COg+v5Pf7Z0Zlp7merdsTSrTXW0d0HpQUiSN
         j1bFA919jPwiP8v2n3jLLZYcJlDnf0ka3/hALMq2wuH7mSvaV8Ul1RTo0wh7wCpHD5Kv
         5VOn8rtv3CAJ0rdpayiOuUMDeyEXTrMkdfIijlPjnNZhbX6KyVun5v99d+TASEJE1iAT
         JAE7WpR8eL1mj/xeoRMySOxx9tbOOLLjJuZ+KePAgSa05FpjUJyfx+6mSIY5CnyyG52S
         UgVlkXN9Ifl04O7kRZW+Og/zeky0bDyRGMYK2QXoG3bxVwjc/NjiB3C748T4qJwZZyUB
         WTqw==
X-Forwarded-Encrypted: i=1; AJvYcCUyxUpsWEtDI8XLhLuWcXn8GOKg2h19ve2FkutV2jAavZOs8zf8bPEa/cvzw7QTXjsai5pmJJcs2rddC8+a@vger.kernel.org, AJvYcCVTS/f+Hni3SZisCzna1m0aSNZpuzDy2qYIyTOyGSwurKlYpGaY01WCk9ZHBW36b+3Fz4I+/QcqwbuB@vger.kernel.org, AJvYcCVbBYaJVgfV+i4U9QceQ5nxR6BYhK+aRtO16DX4yPBPQqGERmw7YwhBIMiu1i+IHnLsAOpRpAivbrO8BcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBV6kJThtwSjQxVkVZ4Fg02IHP+CHzk4TIl6UsqjjSB0le8C1c
	DVjqaQ1jZhad0vGxJ/H8y0ufeYcDGFyCQ778DochpsQW5+a6amaBKuYTcz+0c8kpEJNs+g4YcRt
	mFG0YOQeRostxlvt4r0uKDP8whDR11Wo=
X-Gm-Gg: ASbGnctHH6Wsf0D7TewzV84cMJYtBtj5yfpZF+zJktqtgFJb9ek/i06JQfN2pcYZoni
	GoSVRqapmW19Dvwj8+QaHmUPkIkpbgs/Q4D+F9G6ryunoeW+VDfNs22SaLdAI09hk7f7LCM/PlW
	RSHq43p0SppU8VIqWuEBE84HKD3td47FQPt7xMcB1N6ALtNSvza2UBQnI4IsTiR05KCWRM69azr
	ThpacUWIQDxKPdk9Q==
X-Google-Smtp-Source: AGHT+IHU72GflNLWgGzugcJpRvJnP3K4YrEag2LU8nXIBhskmNox+Xe/nJtCsnm3EVMDsPweoIbpsq2TH5Wh11E14k8=
X-Received: by 2002:a05:6602:1548:b0:864:68b0:60b3 with SMTP id
 ca18e2360f4ac-8819f176c36mr272485839f.12.1754452173629; Tue, 05 Aug 2025
 20:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804104722.601440-1-shengjiu.wang@nxp.com>
 <20250804104722.601440-6-shengjiu.wang@nxp.com> <2380862.ElGaqSPkdT@steina-w>
In-Reply-To: <2380862.ElGaqSPkdT@steina-w>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 6 Aug 2025 11:49:13 +0800
X-Gm-Features: Ac12FXyEs3-bGcZle45sx5ifYYb-YL4J_vkwdItY5DLqaTtCDeVvRWfMNHX5uag
Message-ID: <CAA+D8AMqBqfRuR7oGLwH4CUrAdY4q1XGmnPXGQYUGndY0eS=yw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] drm/bridge: imx: add driver for HDMI TX Parallel
 Audio Interface
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org, 
	cristian.ciocaltea@collabora.com, luca.ceresoli@bootlin.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	victor.liu@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, 
	l.stach@pengutronix.de, perex@perex.cz, tiwai@suse.com, 
	linux-sound@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 3:09=E2=80=AFPM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi,
>
> Am Montag, 4. August 2025, 12:47:21 CEST schrieb Shengjiu Wang:
> > The HDMI TX Parallel Audio Interface (HTX_PAI) is a digital module that
> > acts as the bridge between the Audio Subsystem to the HDMI TX Controlle=
r.
> > This IP block is found in the HDMI subsystem of the i.MX8MP SoC.
> >
> > Data received from the audio subsystem can have an arbitrary component
> > ordering. The HTX_PAI block has integrated muxing options to select whi=
ch
> > sections of the 32-bit input data word will be mapped to each IEC60958
> > field. The HTX_PAI_FIELD_CTRL register contains mux selects to
> > individually select P,C,U,V,Data, and Preamble.
> >
> > Use component helper that imx8mp-hdmi-tx will be aggregate driver,
> > imx8mp-hdmi-pai will be component driver, then imx8mp-hdmi-pai can use
> > bind() ops to get the plat_data from imx8mp-hdmi-tx device.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  drivers/gpu/drm/bridge/imx/Kconfig           |   8 +
> >  drivers/gpu/drm/bridge/imx/Makefile          |   1 +
> >  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.c | 205 +++++++++++++++++++
> >  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c  |  55 +++++
> >  include/drm/bridge/dw_hdmi.h                 |   6 +
> >  5 files changed, 275 insertions(+)
> >  create mode 100644 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.c
> >
> > diff --git a/drivers/gpu/drm/bridge/imx/Kconfig b/drivers/gpu/drm/bridg=
e/imx/Kconfig
> > index 9a480c6abb85..6c1a8bc5d4a0 100644
> > --- a/drivers/gpu/drm/bridge/imx/Kconfig
> > +++ b/drivers/gpu/drm/bridge/imx/Kconfig
> > @@ -18,12 +18,20 @@ config DRM_IMX8MP_DW_HDMI_BRIDGE
> >       depends on OF
> >       depends on COMMON_CLK
> >       select DRM_DW_HDMI
> > +     imply DRM_IMX8MP_HDMI_PAI
> >       imply DRM_IMX8MP_HDMI_PVI
> >       imply PHY_FSL_SAMSUNG_HDMI_PHY
> >       help
> >         Choose this to enable support for the internal HDMI encoder fou=
nd
> >         on the i.MX8MP SoC.
> >
> > +config DRM_IMX8MP_HDMI_PAI
> > +     tristate "Freescale i.MX8MP HDMI PAI bridge support"
> > +     depends on OF
> > +     help
> > +       Choose this to enable support for the internal HDMI TX Parallel
> > +       Audio Interface found on the Freescale i.MX8MP SoC.
> > +
> >  config DRM_IMX8MP_HDMI_PVI
> >       tristate "Freescale i.MX8MP HDMI PVI bridge support"
> >       depends on OF
> > diff --git a/drivers/gpu/drm/bridge/imx/Makefile b/drivers/gpu/drm/brid=
ge/imx/Makefile
> > index dd5d48584806..8d01fda25451 100644
> > --- a/drivers/gpu/drm/bridge/imx/Makefile
> > +++ b/drivers/gpu/drm/bridge/imx/Makefile
> > @@ -1,6 +1,7 @@
> >  obj-$(CONFIG_DRM_IMX_LDB_HELPER) +=3D imx-ldb-helper.o
> >  obj-$(CONFIG_DRM_IMX_LEGACY_BRIDGE) +=3D imx-legacy-bridge.o
> >  obj-$(CONFIG_DRM_IMX8MP_DW_HDMI_BRIDGE) +=3D imx8mp-hdmi-tx.o
> > +obj-$(CONFIG_DRM_IMX8MP_HDMI_PAI) +=3D imx8mp-hdmi-pai.o
> >  obj-$(CONFIG_DRM_IMX8MP_HDMI_PVI) +=3D imx8mp-hdmi-pvi.o
> >  obj-$(CONFIG_DRM_IMX8QM_LDB) +=3D imx8qm-ldb.o
> >  obj-$(CONFIG_DRM_IMX8QXP_LDB) +=3D imx8qxp-ldb.o
> > diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.c b/drivers/gpu=
/drm/bridge/imx/imx8mp-hdmi-pai.c
> > new file mode 100644
> > index 000000000000..9002974073ca
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.c
> > @@ -0,0 +1,205 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2025 NXP
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/component.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <drm/bridge/dw_hdmi.h>
> > +#include <sound/asoundef.h>
> > +
> > +#define HTX_PAI_CTRL                 0x00
> > +#define   ENABLE                     BIT(0)
> > +
> > +#define HTX_PAI_CTRL_EXT             0x04
> > +#define   WTMK_HIGH_MASK             GENMASK(31, 24)
> > +#define   WTMK_LOW_MASK                      GENMASK(23, 16)
> > +#define   NUM_CH_MASK                        GENMASK(10, 8)
> > +#define   WTMK_HIGH(n)                       FIELD_PREP(WTMK_HIGH_MASK=
, (n))
> > +#define   WTMK_LOW(n)                        FIELD_PREP(WTMK_LOW_MASK,=
 (n))
> > +
> > +#define HTX_PAI_FIELD_CTRL           0x08
> > +#define   B_FILT                     BIT(31)
> > +#define   PARITY_EN                  BIT(30)
> > +#define   END_SEL                    BIT(29)
> > +#define   PRE_SEL                    GENMASK(28, 24)
> > +#define   D_SEL                              GENMASK(23, 20)
> > +#define   V_SEL                              GENMASK(19, 15)
> > +#define   U_SEL                              GENMASK(14, 10)
> > +#define   C_SEL                              GENMASK(9, 5)
> > +#define   P_SEL                              GENMASK(4, 0)
> > +
> > +#define HTX_PAI_STAT                 0x0c
> > +#define HTX_PAI_IRQ_NOMASK           0x10
> > +#define HTX_PAI_IRQ_MASKED           0x14
> > +#define HTX_PAI_IRQ_MASK             0x18
> > +
> > +struct imx8mp_hdmi_pai {
> > +     struct device   *dev;
> > +     struct regmap   *regmap;
> > +};
> > +
> > +static void imx8mp_hdmi_pai_enable(struct dw_hdmi *dw_hdmi, int channe=
l,
> > +                                int width, int rate, int non_pcm,
> > +                                int iec958)
> > +{
> > +     const struct dw_hdmi_plat_data *pdata =3D dw_hdmi_to_plat_data(dw=
_hdmi);
> > +     struct imx8mp_hdmi_pai *hdmi_pai =3D (struct imx8mp_hdmi_pai *)pd=
ata->priv_audio;
> > +     int val;
> > +
> > +     /* PAI set control extended */
> > +     val =3D  WTMK_HIGH(3) | WTMK_LOW(3);
> > +     val |=3D FIELD_PREP(NUM_CH_MASK, channel - 1);
> > +     regmap_write(hdmi_pai->regmap, HTX_PAI_CTRL_EXT, val);
> > +
> > +     /* IEC60958 format */
> > +     if (iec958) {
> > +             val =3D FIELD_PREP_CONST(P_SEL,
> > +                                    __bf_shf(IEC958_SUBFRAME_PARITY));
> > +             val |=3D FIELD_PREP_CONST(C_SEL,
> > +                                     __bf_shf(IEC958_SUBFRAME_CHANNEL_=
STATUS));
> > +             val |=3D FIELD_PREP_CONST(U_SEL,
> > +                                     __bf_shf(IEC958_SUBFRAME_USER_DAT=
A));
> > +             val |=3D FIELD_PREP_CONST(V_SEL,
> > +                                     __bf_shf(IEC958_SUBFRAME_VALIDITY=
));
> > +             val |=3D FIELD_PREP_CONST(D_SEL,
> > +                                     __bf_shf(IEC958_SUBFRAME_SAMPLE_2=
4_MASK));
> > +             val |=3D FIELD_PREP_CONST(PRE_SEL,
> > +                                     __bf_shf(IEC958_SUBFRAME_PREAMBLE=
_MASK));
> > +     } else {
> > +             /* PCM choose 24bit*/
> > +             val =3D FIELD_PREP(D_SEL, width - 24);
> > +     }
> > +
> > +     regmap_write(hdmi_pai->regmap, HTX_PAI_FIELD_CTRL, val);
> > +
> > +     /* PAI start running */
> > +     regmap_write(hdmi_pai->regmap, HTX_PAI_CTRL, ENABLE);
> > +}
> > +
> > +static void imx8mp_hdmi_pai_disable(struct dw_hdmi *dw_hdmi)
> > +{
> > +     const struct dw_hdmi_plat_data *pdata =3D dw_hdmi_to_plat_data(dw=
_hdmi);
> > +     struct imx8mp_hdmi_pai *hdmi_pai =3D (struct imx8mp_hdmi_pai *)pd=
ata->priv_audio;
> > +
> > +     /* Stop PAI */
> > +     regmap_write(hdmi_pai->regmap, HTX_PAI_CTRL, 0);
> > +}
> > +
> > +static int imx8mp_hdmi_pai_bind(struct device *dev, struct device *mas=
ter, void *data)
> > +{
> > +     struct dw_hdmi_plat_data *plat_data =3D (struct dw_hdmi_plat_data=
 *)data;
> > +     struct imx8mp_hdmi_pai *hdmi_pai;
> > +
> > +     hdmi_pai =3D dev_get_drvdata(dev);
> > +
> > +     plat_data->enable_audio =3D imx8mp_hdmi_pai_enable;
> > +     plat_data->disable_audio =3D imx8mp_hdmi_pai_disable;
> > +     plat_data->priv_audio =3D hdmi_pai;
> > +
> > +     return 0;
> > +}
> > +
> > +static void imx8mp_hdmi_pai_unbind(struct device *dev, struct device *=
master, void *data)
> > +{
> > +     struct dw_hdmi_plat_data *plat_data =3D (struct dw_hdmi_plat_data=
 *)data;
> > +
> > +     plat_data->enable_audio =3D NULL;
> > +     plat_data->disable_audio =3D NULL;
> > +     plat_data->priv_audio =3D NULL;
> > +}
> > +
> > +static const struct component_ops imx8mp_hdmi_pai_ops =3D {
> > +     .bind   =3D imx8mp_hdmi_pai_bind,
> > +     .unbind =3D imx8mp_hdmi_pai_unbind,
> > +};
> > +
> > +static bool imx8mp_hdmi_pai_volatile_reg(struct device *dev, unsigned =
int reg)
> > +{
> > +     switch (reg) {
> > +     case HTX_PAI_IRQ_NOMASK:
> > +     case HTX_PAI_IRQ_MASKED:
> > +             return true;
> > +     default:
> > +             return false;
> > +     }
> > +}
> > +
> > +static bool imx8mp_hdmi_pai_writeable_reg(struct device *dev, unsigned=
 int reg)
> > +{
> > +     switch (reg) {
> > +     case HTX_PAI_CTRL:
> > +     case HTX_PAI_CTRL_EXT:
> > +     case HTX_PAI_FIELD_CTRL:
> > +     case HTX_PAI_IRQ_NOMASK:
> > +     case HTX_PAI_IRQ_MASKED:
> > +     case HTX_PAI_IRQ_MASK:
> > +             return true;
> > +     default:
> > +             return false;
> > +     }
> > +}
> > +
> > +static const struct regmap_config imx8mp_hdmi_pai_regmap_config =3D {
> > +     .reg_bits =3D 32,
> > +     .reg_stride =3D 4,
> > +     .val_bits =3D 32,
> > +     .max_register =3D HTX_PAI_IRQ_MASK,
> > +     .volatile_reg =3D imx8mp_hdmi_pai_volatile_reg,
> > +     .writeable_reg =3D imx8mp_hdmi_pai_writeable_reg,
> > +};
> > +
> > +static int imx8mp_hdmi_pai_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct imx8mp_hdmi_pai *hdmi_pai;
> > +     struct resource *res;
> > +     void __iomem *base;
> > +
> > +     hdmi_pai =3D devm_kzalloc(dev, sizeof(*hdmi_pai), GFP_KERNEL);
> > +     if (!hdmi_pai)
> > +             return -ENOMEM;
> > +
> > +     base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> > +     if (IS_ERR(base))
> > +             return PTR_ERR(base);
> > +
> > +     hdmi_pai->dev =3D dev;
> > +
> > +     hdmi_pai->regmap =3D devm_regmap_init_mmio(dev, base, &imx8mp_hdm=
i_pai_regmap_config);
> > +     if (IS_ERR(hdmi_pai->regmap)) {
> > +             dev_err(dev, "regmap init failed\n");
> > +             return PTR_ERR(hdmi_pai->regmap);
> > +     }
> > +
> > +     dev_set_drvdata(dev, hdmi_pai);
> > +
> > +     return component_add(dev, &imx8mp_hdmi_pai_ops);
> > +}
> > +
> > +static void imx8mp_hdmi_pai_remove(struct platform_device *pdev)
> > +{
> > +     component_del(&pdev->dev, &imx8mp_hdmi_pai_ops);
> > +}
> > +
> > +static const struct of_device_id imx8mp_hdmi_pai_of_table[] =3D {
> > +     { .compatible =3D "fsl,imx8mp-hdmi-pai" },
> > +     { /* Sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, imx8mp_hdmi_pai_of_table);
> > +
> > +static struct platform_driver imx8mp_hdmi_pai_platform_driver =3D {
> > +     .probe          =3D imx8mp_hdmi_pai_probe,
> > +     .remove         =3D imx8mp_hdmi_pai_remove,
> > +     .driver         =3D {
> > +             .name   =3D "imx8mp-hdmi-pai",
> > +             .of_match_table =3D imx8mp_hdmi_pai_of_table,
> > +     },
> > +};
> > +module_platform_driver(imx8mp_hdmi_pai_platform_driver);
> > +
> > +MODULE_DESCRIPTION("i.MX8MP HDMI PAI driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c b/drivers/gpu/=
drm/bridge/imx/imx8mp-hdmi-tx.c
> > index 1e7a789ec289..ee08084d2394 100644
> > --- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> > +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> > @@ -5,11 +5,13 @@
> >   */
> >
> >  #include <linux/clk.h>
> > +#include <linux/component.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  #include <drm/bridge/dw_hdmi.h>
> >  #include <drm/drm_modes.h>
> > +#include <drm/drm_of.h>
> >
> >  struct imx8mp_hdmi {
> >       struct dw_hdmi_plat_data plat_data;
> > @@ -79,11 +81,46 @@ static const struct dw_hdmi_phy_ops imx8mp_hdmi_phy=
_ops =3D {
> >       .update_hpd     =3D dw_hdmi_phy_update_hpd,
> >  };
> >
> > +static int imx8mp_dw_hdmi_bind(struct device *dev)
> > +{
> > +     struct dw_hdmi_plat_data *plat_data;
> > +     struct imx8mp_hdmi *hdmi;
> > +     int ret;
> > +
> > +     hdmi =3D dev_get_drvdata(dev);
> > +     plat_data =3D &hdmi->plat_data;
> > +
> > +     ret =3D component_bind_all(dev, plat_data);
>
> Do you really need plat_data variable?

yes,  it is used in imx8mp_hdmi_pai_bind()

>
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "component_bind_all failed=
!\n");
> > +
> > +     return 0;
> > +}
> > +
> > +static void imx8mp_dw_hdmi_unbind(struct device *dev)
> > +{
> > +     struct dw_hdmi_plat_data *plat_data;
> > +     struct imx8mp_hdmi *hdmi;
> > +
> > +     hdmi =3D dev_get_drvdata(dev);
> > +     plat_data =3D &hdmi->plat_data;
> > +
> > +     component_unbind_all(dev, plat_data);
>
> Do you really need plat_data variable?

yes,  it is used by imx8mp_hdmi_pai_unbind()

>
> > +}
> > +
> > +static const struct component_master_ops imx8mp_dw_hdmi_ops =3D {
> > +     .bind   =3D imx8mp_dw_hdmi_bind,
> > +     .unbind =3D imx8mp_dw_hdmi_unbind,
> > +};
> > +
> >  static int imx8mp_dw_hdmi_probe(struct platform_device *pdev)
> >  {
> >       struct device *dev =3D &pdev->dev;
> >       struct dw_hdmi_plat_data *plat_data;
> > +     struct component_match *match;
>
> Set match =3D NULL for drm_of_component_match_add (and subcalls) to alloc=
ate memory.

Ok.

best regards
Shengjiu wang.
>
> Best regards
> Alexander
>
> > +     struct device_node *remote;
> >       struct imx8mp_hdmi *hdmi;
> > +     int ret;
> >
> >       hdmi =3D devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
> >       if (!hdmi)
> > @@ -108,6 +145,22 @@ static int imx8mp_dw_hdmi_probe(struct platform_de=
vice *pdev)
> >
> >       platform_set_drvdata(pdev, hdmi);
> >
> > +     /* port@2 is for hdmi_pai device */
> > +     remote =3D of_graph_get_remote_node(pdev->dev.of_node, 2, 0);
> > +     if (remote && of_device_is_available(remote)) {
> > +             drm_of_component_match_add(dev, &match, component_compare=
_of, remote);
> > +
> > +             of_node_put(remote);
> > +
> > +             ret =3D component_master_add_with_match(dev, &imx8mp_dw_h=
dmi_ops, match);
> > +             if (ret)
> > +                     dev_warn(dev, "Unable to register aggregate drive=
r\n");
> > +             /*
> > +              * This audio function is optional for avoid blocking dis=
play.
> > +              * So just print warning message and no error is returned=
.
> > +              */
> > +     }
> > +
> >       return 0;
> >  }
> >
> > @@ -115,6 +168,8 @@ static void imx8mp_dw_hdmi_remove(struct platform_d=
evice *pdev)
> >  {
> >       struct imx8mp_hdmi *hdmi =3D platform_get_drvdata(pdev);
> >
> > +     component_master_del(&pdev->dev, &imx8mp_dw_hdmi_ops);
> > +
> >       dw_hdmi_remove(hdmi->dw_hdmi);
> >  }
> >
> > diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.=
h
> > index 095cdd9b7424..336f062e1f9d 100644
> > --- a/include/drm/bridge/dw_hdmi.h
> > +++ b/include/drm/bridge/dw_hdmi.h
> > @@ -143,6 +143,12 @@ struct dw_hdmi_plat_data {
> >                                          const struct drm_display_info =
*info,
> >                                          const struct drm_display_mode =
*mode);
> >
> > +     /*
> > +      * priv_audio is specially used for additional audio device to ge=
t
> > +      * driver data through this dw_hdmi_plat_data.
> > +      */
> > +     void *priv_audio;
> > +
> >       /* Platform-specific audio enable/disable (optional) */
> >       void (*enable_audio)(struct dw_hdmi *hdmi, int channel,
> >                            int width, int rate, int non_pcm, int iec958=
);
> >
>
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/
>
>

