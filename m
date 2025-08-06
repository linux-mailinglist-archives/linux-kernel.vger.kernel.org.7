Return-Path: <linux-kernel+bounces-757264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ECAB1C007
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB0262081D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696301FCFEF;
	Wed,  6 Aug 2025 05:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFBoqon3"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF001F0E26;
	Wed,  6 Aug 2025 05:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754458960; cv=none; b=BVDof2I9pi0LBP7bIlFuHZQuxXz3HkzMIycOPa6fTX9iTd0x8nue4jbGvVHzeqD1EqEUq/Q3KkvXQgyeBJHprssSs62c0prskGDQxAqDhPIdERGpG7Muamx6Qu85rF7IcAoiE5B2fH831dIyATbAtKPm2q9e+nNGcq2Hgr+q51c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754458960; c=relaxed/simple;
	bh=XEFDjwxyGn7GRK2szJGynViSzaqmC6nMvkN1KXCrqjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hT4NkIpT5+BhdqpLBv/cedTKS0pqGbSOpKipoSI9bO/fIsICjqGFXN6wN95+glMxFgvNulmgRyIxPSvHbaYM9hQYzVyf8DVojuPl5U+NBnaR2hVqxGdTeMI1ieo5b1qdhWN5VvjwhJ4Hp+EJ2Z+2+u+457GI1JZMj7NKCfwLy2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFBoqon3; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-86cdb330b48so428326639f.0;
        Tue, 05 Aug 2025 22:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754458956; x=1755063756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHauIS8VslQcBTCDTTdkK4LmnH1Wk0DYHNjYnbBqri4=;
        b=DFBoqon3YkkZ0dpUw1hUNTad3HOeyT1VVEnfZXvGPagj/mjPicI/tsRd8sGygOYrO7
         NmxVprTLycY9FHKmlZ4XfHayceclKipmjzmD6t+BmSxPC8qHXf/jkSH7leGBpv2YvNxh
         9b5IcK2cY47J1LKH8ZjESD4PvHh4Pk4AlF5i+I+BeIAZrdVsOrAIgl9ttCj6bbo3F/H0
         vvLJhFdiAcKQdGxrAAFQ8v3FoC8PAbYQCFeO3lPh1PLAoPvEpNkNHXSGeLsDtC8++6Uy
         DST+kFFiwOyvZeUcX2r4r4nzuwXxxIOioH0jFEh5jTMRZt96h/BJpyfaruaSX+qRgslv
         dHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754458956; x=1755063756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHauIS8VslQcBTCDTTdkK4LmnH1Wk0DYHNjYnbBqri4=;
        b=AINLYES3VcO+Iv5iotFwwZ1F117ZzsUd1VseuskiC2ABBWeeSbjF35PZwjhEQD/S6l
         ByBtMk87xX1tS9lkb2mzzPNzSOObgnrioB9dPD8ZlhrkZlmQq/4Edg7AXwODQcQ/GfIm
         fnTmgS+GLeksNAcSrzRpy09D3FdOvxdonheaN/kq1iFD9yentuJ/7YbvGjFWSkNLmk/B
         6TzbP1VZs81DpT7jn7+yK/vknYx8OVXk4RAzt0lnLvyr0QHBk8qudytpIpI4XmEyUBof
         9r9r2zE9J6H/dcC+vPVYB2pQ+OilmxFsvBM0s5jTi4pzEQP+HYokQaiTYzRwciqyLYLX
         TIdg==
X-Forwarded-Encrypted: i=1; AJvYcCVSFl340QKhU43+v7VgU1mVSJITOHu5WCB1gciCLeoh2xGblR7LyMhgyOjx1OYkwJWN8pVRh8D1UR76ZlJN@vger.kernel.org, AJvYcCVy6DymoUJEo1afOWCYdZS0qmwGVhZubqgXfltKrehvRj86/7x0Ia8cMLBVFCeP9aa0KPrnyQUe0CXJ@vger.kernel.org, AJvYcCXz2b+41dFL4zaKPAangVScXMA4xelFQehM60azE1saUbcrXYSBN1VN1Y6TKzzDcJpaQkq5pUEr9u4mmuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY+sX3DPzblBeGEuRJy3djAvWhpq6BDSUytXMq/BEUFDBLwn+y
	dG2bEjoIHPW/mef79Kul/zB2l4aYKrfxTNXOaLKlbA3dQuX9xdFAvBriZOau3oRrDgjHjDufeF8
	S2hSa6N67/6bVG0xNB/yxsHXPpboTBqw=
X-Gm-Gg: ASbGnctvGe/XdImFCp1qb75GTp05Gi/sd4VcDO3/NLRmS8+f8Rn2IZeRr6by7Su5uzK
	ajrhIfG7d6X4yChFw6SHChEbs1vL2Gl9JHrtWaR13uN6qOcVd+zO28eQAJJM2/cJnICNjY1o8oC
	O64ZSmgFF0WHQ7+UKoWl6FUzYfXZMNKxmANrGNnvxWI1VJ96ANg7v0jaiedZ523MyDGLjP0eU8W
	fkd5x4=
X-Google-Smtp-Source: AGHT+IECmzK2OYEDadcx1xb2ZQCI3OV3aypgzNJvM+m1QQlytd+LfV9SXOQitTe7El49SPBkrrzfxhGitycgVD/2o3g=
X-Received: by 2002:a05:6602:3fd3:b0:881:9412:c917 with SMTP id
 ca18e2360f4ac-8819eda4411mr351161239f.0.1754458955859; Tue, 05 Aug 2025
 22:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804104722.601440-1-shengjiu.wang@nxp.com>
 <20250804104722.601440-6-shengjiu.wang@nxp.com> <fa455148-a071-4433-8c9c-26add3872604@nxp.com>
In-Reply-To: <fa455148-a071-4433-8c9c-26add3872604@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 6 Aug 2025 13:42:16 +0800
X-Gm-Features: Ac12FXzE8ELOd9wvaEtNxu_4hqBHJ1GNH1m_A1__IZXWyAfic17tlm42XJMvvFE
Message-ID: <CAA+D8AN4n0H6M_0EqX4z_37ViSCyThKbmtMgqPmipintJ8Wtwg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] drm/bridge: imx: add driver for HDMI TX Parallel
 Audio Interface
To: Liu Ying <victor.liu@nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org, 
	cristian.ciocaltea@collabora.com, luca.ceresoli@bootlin.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, devicetree@vger.kernel.org, l.stach@pengutronix.de, 
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 4:55=E2=80=AFPM Liu Ying <victor.liu@nxp.com> wrote:
>
> On 08/04/2025, Shengjiu Wang wrote:
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
>
> s/that/so that/
>
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
>
> select REGMAP
> select REGMAP_MMIO
>
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
>
> #include <linux/regmap.h>
>
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
>
> Add NUM_CH(n) and use it when programming HTX_PAI_CTRL_EXT.
> #define NUM_CH(n)                       FIELD_PREP(NUM_CH_MASK, (n - 1))
>
> > +#define   WTMK_HIGH(n)                       FIELD_PREP(WTMK_HIGH_MASK=
, (n))
> > +#define   WTMK_LOW(n)                        FIELD_PREP(WTMK_LOW_MASK,=
 (n))
> > +
> > +#define HTX_PAI_FIELD_CTRL           0x08
> > +#define   B_FILT                     BIT(31)
> > +#define   PARITY_EN                  BIT(30)
> > +#define   END_SEL                    BIT(29)
>
> The above 3 bits are unused.  Drop.
>
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
>
> The above 4 registers are not pratically used.  Drop.
>
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
>
> I don't think you need to convert type explicitly.  Same for the other
> explicit conversions in this driver.
>
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
>
> Why 'width - 24'?  Can it be expressed by a helper or macro?
>
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
>
> Do you really need to set these ptrs to NULL?

yes.  below code in dw-hdmi.c use the pdata->enable_audio as condition.

        if (pdata->enable_audio)
                pdata->enable_audio(hdmi,
                                    hdmi->channels,
                                    hdmi->sample_width,
                                    hdmi->sample_rate,
                                    hdmi->sample_non_pcm,
                                    hdmi->sample_iec958);


>
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
>
> Now that DT binding says there is an APB clock, use devm_regmap_init_mmio=
_clk()
> to ensure registers can be accessed with clock enabled even via debugfs.
>
> > +     if (IS_ERR(hdmi_pai->regmap)) {
> > +             dev_err(dev, "regmap init failed\n");
> > +             return PTR_ERR(hdmi_pai->regmap);
> > +     }
> > +
> > +     dev_set_drvdata(dev, hdmi_pai);
> > +
> > +     return component_add(dev, &imx8mp_hdmi_pai_ops);
>
> Imagine that users could enable this driver without enabling imx8mp-hdmi-=
tx
> driver, you may add the component in this probe() callback only and move =
all
> the other stuff to bind() callback to avoid unnecessary things being done=
 here.

component helper functions don't have such dependency that the aggregate
driver or component driver must be probed or not.  if imx8mp-hdmi-tx is not
enabled, there is no problem, just the bind() callback is not called.

>
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
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "component_bind_all failed=
!\n");
>
> As component_bind_all() would bind imx8mp-hdmi-pai and hence set
> {enable,disable}_audio callbacks, you need to call dw_hdmi_probe() after
> component_bind_all() instead of too early in probe() callback.

There is no such dependency.
Maybe you mixed the hdmi->enable_audio() with pdata->enable_audio().

>
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
> As Alexander pointed out, this needs to be set to NULL.
> See how other drivers which are component masters do.
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
>
> Doesn't of_graph_get_remote_node() ensure that remote is avaiable?

No.  'remote' is the node,  not the 'device'.

>
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
>
> No, since PAI node is available here, it has to be bound.  Yet you still =
need
> to properly handle the case where PAI node is inavailable.

This is for aggregate driver registration,  not for bind()

The bind() is called after both drivers have been registered.  again there =
is no
dependency for both aggregate driver and component driver should be
registered or probed.

best regards
shengjiu wang

>
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
>
>
> --
> Regards,
> Liu Ying

