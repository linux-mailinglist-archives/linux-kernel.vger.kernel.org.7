Return-Path: <linux-kernel+bounces-738653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D61DCB0BB78
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6A9179D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE7E20C461;
	Mon, 21 Jul 2025 03:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/SMbkyR"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3DB8F5A;
	Mon, 21 Jul 2025 03:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753069316; cv=none; b=aEhu0y6ECySN4BrfYK0CwyRPQIt/uZkscvJhIOGrNMe2vFv7ZX0AG9n396Ef6Q+eY/mJ4JlNt1hwolcviG+O9mZ2egrREu5P/zh0UzTXgWvrHugCdaVJSTYy9mletFz+kGqSRiL7ro9Osft9CnX20umXaVGbDk6qTCbxKocClh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753069316; c=relaxed/simple;
	bh=PdwN+W/0HAlt8xaOCuhaJJOixsQEau5j8G7WO3zy1SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aC+7Q5yDLZbiGzY4oc9YBkQ66970se+0fDoPfYxkroKp9XAEDz9vmz+8oMqC2yIF4A3OKAdBCJ2qG1SxWjhrIk/xc3TpyAWqjEhPlBaygBFjnXD1pMA9ypbhTni5+gZXzXROA0oPy6U4GAh+2RuwunoArXR1nigXRYqCLKuYmo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/SMbkyR; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ddd2710d14so35654985ab.2;
        Sun, 20 Jul 2025 20:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753069313; x=1753674113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxOupiP+AzDKFj9Eqf69444hP/4a0m824WZ/8vreM8A=;
        b=J/SMbkyR5P99r+9mWcnU+kT67Z7nUzQShKDqQIHGxqW2lCZ+0orsF/x/TbBt3KTkz6
         Pid5JhzJgWtzb2maJameGUF8KqXPFFXy/AlC72R0gyASeYfUEOllQ1W6pYWRUBImqZlF
         RFiCh9AUBE7zjxQ01K0zfrpdalwkI0hZgXJcSdx1hGs5BkxjDmABSM+25tMTQfOUcSrl
         bYI/Wp0R/jeb3Sx9UwhkZN5lwmoc76h7jtV/AzLvRUKRA1nduOorRrtApbKb61J0rmCd
         5O84C/+JIw8un8yTZ8M8QFQLaeVt8ox2m7fL2Toj5UmWQjf6kA7zY+I2QL5G0iZzhGMJ
         wNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753069313; x=1753674113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxOupiP+AzDKFj9Eqf69444hP/4a0m824WZ/8vreM8A=;
        b=pd1ZjP7kZfsGIOrdABttVgtrnTLZvyL9XT6yAiU3qY2gfh0UacrdnOWnczoo4gD4Fr
         Kvsmx4VCP4qqG7WZ0CvmjrdlBbDQUM6agmFiEaGXpNxxxfXLu7ch5hpZHDUb/Iv548Is
         A35uO75sMKTyHp7G3raUZFKI/KDcRSfruEszmfHQUV4/Ukf/ZUN28I1cyy29gj90snzl
         EX49V/fi1V5SQA6/RTYEFrfd/jdVfjQRZAd7d1jvqz2nag9juSqUlNVUsvSjzXMTWUwO
         htaVcUEBAkwV6TrDPGojVdLx1hagK7foj0FiaAXAFDXN3pDU0j5qdBDok+uoyY3qNrMk
         AXAg==
X-Forwarded-Encrypted: i=1; AJvYcCWLFaupQH3OHUEXOTYiVzLdi89aD87sgvSBNcPK1o+emctgiDEP1gQjQ7SvlQ20tHxN2Mt+F6B6h3j2@vger.kernel.org, AJvYcCWdPkmozYsSqJc7RtvnUkS8/C4vk7XaFo+6ky/bO2DCSErCNkifN+I/n5dn5zs2AfepHxTTo427DpiDqxZs@vger.kernel.org
X-Gm-Message-State: AOJu0YwLEZroyzxI177BktW01iDWoRMF3LgFQVzyIpySLmx6SHjuz3aC
	ADqyUaZo31XUIYSHmTUJBuZ3UH9fsNskx3KhhpSnr7BElzCWGUcQxrMS0BIqOXb75xb7bSkLaDR
	pOspr2QIZ6q6g9xIvo8s4NsvZV5dafd0=
X-Gm-Gg: ASbGncvEBbemvIG6Rrl8+la39PTkmzof405RIVz5XwPYYloHIzG1eWm0vlval7JP5ZX
	bwopXTZpdvJTl/lxCrH8A1FyhvmUsXSfLVE84L9opVVX7fz7Hp7UAHkhC4b6XGziLMRF8mErvLE
	RAubIxp4LD2JIwDVM75DMrr+K4IMqfALERt14RcxnXfqhZFLLyd1rlBgjtM6zWBovjZ3KaCm8Pf
	KVfXLI=
X-Google-Smtp-Source: AGHT+IFz1HGhNEidAOsOni/rjfsNvb1evXBa1c+HDuQzYd0asweyMsVHkfpWiKwkdYQQRpPesF4vdrwP3e7ac96hFQs=
X-Received: by 2002:a05:6e02:3c86:b0:3e2:a366:c125 with SMTP id
 e9e14a558f8ab-3e2a366c42bmr93375905ab.18.1753069313428; Sun, 20 Jul 2025
 20:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718101150.3681002-1-shengjiu.wang@nxp.com>
 <20250718101150.3681002-3-shengjiu.wang@nxp.com> <4668607.LvFx2qVVIh@steina-w>
In-Reply-To: <4668607.LvFx2qVVIh@steina-w>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 21 Jul 2025 11:41:38 +0800
X-Gm-Features: Ac12FXytZWevTn3X9nBgcYpx1xuFdbioGQ2AJMdPLLsLdh8ViabsDJrmMi_DxPU
Message-ID: <CAA+D8ANQdOuEiHrOWAbqVN2oFAAop2agBzKB2_YsoQ3_SFYYNw@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/bridge: imx: add driver for HDMI TX Parallel
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
	l.stach@pengutronix.de, Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 7:51=E2=80=AFPM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi,
>
> thanks for sending this path.
>
> Am Freitag, 18. Juli 2025, 12:11:48 CEST schrieb Shengjiu Wang:
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
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  drivers/gpu/drm/bridge/imx/Kconfig           |   7 +
> >  drivers/gpu/drm/bridge/imx/Makefile          |   1 +
> >  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.c | 134 +++++++++++++++++++
> >  include/drm/bridge/dw_hdmi.h                 |   6 +
> >  4 files changed, 148 insertions(+)
> >  create mode 100644 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.c
> >
> > diff --git a/drivers/gpu/drm/bridge/imx/Kconfig b/drivers/gpu/drm/bridg=
e/imx/Kconfig
> > index 9a480c6abb85..d95fa84a8dcd 100644
> > --- a/drivers/gpu/drm/bridge/imx/Kconfig
> > +++ b/drivers/gpu/drm/bridge/imx/Kconfig
> > @@ -24,6 +24,13 @@ config DRM_IMX8MP_DW_HDMI_BRIDGE
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
> > index 000000000000..f09ee2622e57
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.c
> > @@ -0,0 +1,134 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2025 NXP
> > + */
> > +
> > +#include <drm/bridge/dw_hdmi.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +
> > +#define HTX_PAI_CTRL                   0x00
> > +#define HTX_PAI_CTRL_EXT               0x04
> > +#define HTX_PAI_FIELD_CTRL             0x08
> > +#define HTX_PAI_STAT                   0x0c
> > +#define HTX_PAI_IRQ_NOMASK             0x10
> > +#define HTX_PAI_IRQ_MASKED             0x14
> > +#define HTX_PAI_IRQ_MASK               0x18
> > +
> > +#define CTRL_ENABLE                    BIT(0)
> > +
> > +#define CTRL_EXT_WTMK_HIGH_MASK                GENMASK(31, 24)
> > +#define CTRL_EXT_WTMK_HIGH             (0x3 << 24)
> > +#define CTRL_EXT_WTMK_LOW_MASK         GENMASK(23, 16)
> > +#define CTRL_EXT_WTMK_LOW              (0x3 << 16)
> > +#define CTRL_EXT_NUM_CH_MASK           GENMASK(10, 8)
> > +#define CTRL_EXT_NUM_CH_SHIFT          8
> > +
> > +#define FIELD_CTRL_B_FILT              BIT(31)
> > +#define FIELD_CTRL_PARITY_EN           BIT(30)
> > +#define FIELD_CTRL_END_SEL             BIT(29)
> > +#define FIELD_CTRL_PRE_SEL             GENMASK(28, 24)
> > +#define FIELD_CTRL_PRE_SEL_SHIFT       24
> > +#define FIELD_CTRL_D_SEL               GENMASK(23, 20)
> > +#define FIELD_CTRL_D_SEL_SHIFT         20
> > +#define FIELD_CTRL_V_SEL               GENMASK(19, 15)
> > +#define FIELD_CTRL_V_SEL_SHIFT         15
> > +#define FIELD_CTRL_U_SEL               GENMASK(14, 10)
> > +#define FIELD_CTRL_U_SEL_SHIFT         10
> > +#define FIELD_CTRL_C_SEL               GENMASK(9, 5)
> > +#define FIELD_CTRL_C_SEL_SHIFT         5
> > +#define FIELD_CTRL_P_SEL               GENMASK(4, 0)
> > +#define FIELD_CTRL_P_SEL_SHIFT         0
> > +
> > +struct imx8mp_hdmi_pai {
> > +     struct device   *dev;
> > +     void __iomem    *base;
> > +};
> > +
> > +static void imx8mp_hdmi_pai_enable(struct dw_hdmi *dw_hdmi, int channe=
l,
> > +                                int width, int rate, int non_pcm)
> > +{
> > +     const struct dw_hdmi_plat_data *pdata =3D dw_hdmi_to_plat_data(dw=
_hdmi);
> > +     struct imx8mp_hdmi_pai *hdmi_pai =3D (struct imx8mp_hdmi_pai *)pd=
ata->priv_audio;
> > +     int val;
> > +
> > +     /* PAI set */
> > +     val =3D CTRL_EXT_WTMK_HIGH | CTRL_EXT_WTMK_LOW;
> > +     val |=3D ((channel - 1) << CTRL_EXT_NUM_CH_SHIFT);
> > +     writel(val, hdmi_pai->base + HTX_PAI_CTRL_EXT);
> > +
> > +     /* IEC60958 format */
> > +     val =3D 31 << FIELD_CTRL_P_SEL_SHIFT;
> > +     val |=3D 30 << FIELD_CTRL_C_SEL_SHIFT;
> > +     val |=3D 29 << FIELD_CTRL_U_SEL_SHIFT;
> > +     val |=3D 28 << FIELD_CTRL_V_SEL_SHIFT;
> > +     val |=3D 4 << FIELD_CTRL_D_SEL_SHIFT;
> > +     val |=3D 0 << FIELD_CTRL_PRE_SEL_SHIFT;
>
> You can use FIELD_PREP_CONST() for these shifts as the GENMASK are
> already available.

Ok.

> But where do these numbers come from? I can see that downstream kernel
> sets these bits depending on audio config being passed.

These numbers are defined in standard IEC958 spec.

The implementation in downstream kernel may not good enough, which can't
distinguish between the raw PCM and IEC958 PCM. Even raw PCM can work,
but in RM, the supported format is IEC958.

So later we need to update the aud2htx driver to only support IEC958 format=
.
Make the alignment between PAI driver and aud2htx driver.

>
> > +
> > +     writel(val, hdmi_pai->base + HTX_PAI_FIELD_CTRL);
> > +     /* PAI start running */
> > +     writel(CTRL_ENABLE, hdmi_pai->base + HTX_PAI_CTRL);
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
> > +     writel(0, hdmi_pai->base + HTX_PAI_CTRL);
> > +}
> > +
> > +static int imx8mp_hdmi_pai_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct dw_hdmi_plat_data *plat_data;
> > +     struct imx8mp_hdmi_pai *hdmi_pai;
> > +     struct device_node *remote;
> > +     struct platform_device *hdmi_tx;
> > +     struct resource *res;
> > +
> > +     hdmi_pai =3D devm_kzalloc(dev, sizeof(*hdmi_pai), GFP_KERNEL);
> > +     if (!hdmi_pai)
> > +             return -ENOMEM;
> > +
> > +     hdmi_pai->base =3D devm_platform_get_and_ioremap_resource(pdev, 0=
, &res);
> > +     if (IS_ERR(hdmi_pai->base))
> > +             return PTR_ERR(hdmi_pai->base);
> > +
> > +     hdmi_pai->dev =3D dev;
> > +
> > +     remote =3D of_graph_get_remote_node(pdev->dev.of_node, 0, -1);
> > +     if (!remote)
> > +             return -EINVAL;
> > +
> > +     hdmi_tx =3D of_find_device_by_node(remote);
> > +     if (!hdmi_tx)
> > +             return -EINVAL;
> > +
> > +     plat_data =3D platform_get_drvdata(hdmi_tx);
>
> How do you ensure hdmi_tx has been probed so that drvdata is set?
> Also hdmi_tx needs to be dropped.

Good catch. need to update to

        hdmi_tx =3D of_find_device_by_node(remote);
        of_node_put(remote);
        if (!hdmi_tx)
                return -ENODEV;

        plat_data =3D platform_get_drvdata(hdmi_tx);
        put_device(&hdmi_tx->dev);
        if (!plat_data)
                return -EPROBE_DEFER;

>
> > +     plat_data->enable_audio =3D imx8mp_hdmi_pai_enable;
> > +     plat_data->disable_audio =3D imx8mp_hdmi_pai_disable;
> > +     plat_data->priv_audio =3D hdmi_pai;
>
> How do you connect this device to aud2htx?

aud2htx -> hdmi_codec -> dw-hdmi-gp-audio
hdmi_codec is sound/soc/codecs/hdmi-codec.c

gp-audio will call this plat_data->enable(disable)_audio().
So need to register the plat_data->enable(disable)_audio in this driver.

Best regards
Shengjiu Wang
>
> Best regards,
> Alexander
>
> > +
> > +     return 0;
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
> > +     .driver         =3D {
> > +             .name   =3D "imx8mp-hdmi-pai",
> > +             .of_match_table =3D imx8mp_hdmi_pai_of_table,
> > +     },
> > +};
> > +module_platform_driver(imx8mp_hdmi_pai_platform_driver);
> > +
> > +MODULE_DESCRIPTION("i.MX8MP HDMI PAI driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.=
h
> > index a56a3519a22a..9ca70ce80cc5 100644
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
> >                            int width, int rate, int non_pcm);
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

