Return-Path: <linux-kernel+bounces-742036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF9BB0EC37
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C2F17DCD3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFA7278E63;
	Wed, 23 Jul 2025 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FP+u8BKe"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47A1277C88;
	Wed, 23 Jul 2025 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256741; cv=none; b=QS1cS1yQVFcgj8ANUSiZAOZkL1VeLPmd55ID4Sl9vhbMOaslKbhYYK7xEMfxp/YMTCygWPBLM7VVJjoIunmn2P66uYOfq8CeVf2HxA9W3h8/4Y1S0uHyXvA4v7c3bNon8BYNuoEtYZjWr/21pabA0CX2zobOHrhllDx9K/+pjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256741; c=relaxed/simple;
	bh=Nz1OtXkc17F8zCv2wkGXeGK/UKT9+ptmSVh2dQ+go7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUNpJYfhHX4KRiPsgE1lkJ8QIPzKe6gE31MI2eHN0CyBMJVGXo3AT8A2nhr8F/Qsyp9rqifDOPBt/gKfYl/qGoSPuSdWueVVf/9FNulMvaAGxrFUoVbItIyhaU6Hp98DbMTxDt8VilK7ec/96p3We09IQuSpCtCdL6xDie+DCiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FP+u8BKe; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3df210930f7so3361025ab.1;
        Wed, 23 Jul 2025 00:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753256739; x=1753861539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Z2c1E2HlWEomA33WDGgiqLFYGCrGr/mjGJf+DEuvUc=;
        b=FP+u8BKePvpgnz7C5nUG4MMS6V1ZP/JILQLMOFOYhiz/2lESG8/K8mubolEkmY2ZOw
         f67FSSMFQHZvFUEBqYGfr7sdvVhdrLB/ExKOKJ9QKgcPZwJL7g3sKovyunbztggphFbe
         kNwpBbeOwGVsImlvpTKMDnCxQflV8fJVWwtnuAPXiDF0Zfl3XnVEebFVNzoeOVT/VmGq
         d/Q2AfGMsT3kKGatVH8OlV6PlKtjFiA86Wh3J81wtsFhbRKKmtjuqTx95yzCYsFcI3+y
         L1t2JNJ5GHT0GsSwwcCfL1GtMdzKm8K1fLSV71gQgGfQS7zrMTqCnONkIVlJzb5mGhpi
         LooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753256739; x=1753861539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Z2c1E2HlWEomA33WDGgiqLFYGCrGr/mjGJf+DEuvUc=;
        b=wbdwi5+6gAt9zPGbKw4yGSSiR0bqpMqn1dOgKwvUAEIOS6/7dOeYNNEr5Z2CcKEG1v
         zm+e0e9lImtudKw+YE/BwyNp/7rwbL9ckp0V9IjbLXCoZyuv0riToKFcg+e1QtTRThks
         LazZT+QJt2y7rana97cV4ixapfHEko6Dym32ekqKrCVFpUt4WSNhPmC4vKIJ5DL8wrix
         mZZnxnAlVacNZY6mXweA6MsTNvb1g+dt0zuPdwbSrUT5pVb+ZUt450kL9Qyd4oCp91vA
         QXS/v5eV28c4HHlx4xwDXLaq0Z8OTxrDYr2kKIrSDfuKujA4eouN0+JWzh+ZWBbcGta/
         R+KA==
X-Forwarded-Encrypted: i=1; AJvYcCUlMh54MoOY09wzgWmeVeyNDXXk91XZPR4BmHfw1gjRkkxBnhAhR/6+aydExQHHxyk8zFXFDxSkuYO8509i@vger.kernel.org, AJvYcCVLc6jm++n13Vecnx7O4uwxvvBqb7rzQDcl3WwTugbq74XWTgFgH6f3x5nPPUjZxYjOWNSucxjXd7hk@vger.kernel.org
X-Gm-Message-State: AOJu0YxygsQ/UFeQKLAKQacMgUIDCZrlNPVy/NX/VX/KMs1iy6Q78GtX
	0jpLMLa3DkTBywiyXejXBHj73RK1wvv/gGqyoXELgsbx8edTMOTtw++agtbNFiqKx85/6TYTsAd
	KM9VVBDHU7piJSnRDVckmC+VIK3LYrOM=
X-Gm-Gg: ASbGncvs+BDT1+BFkhDTzIzPtkrgXvt9o7EYKo6qm2dXOvcvEFuy3es+0nWkuPtDsS9
	Gx2wcGFjBOp8YPBNmNsAYvoYoRE1XLAWHfZ6ipTp571hahOIKbC+BgANYJlvkP47Kn9bj34gatc
	QHNNSBEx8dW8U6QbU5GHIALCL+KYMXsoH4proPZffNGPYch6/4vUgfbnkh8ALVWqyIHHlFOrqGq
	aBy144=
X-Google-Smtp-Source: AGHT+IFICg7g8jaxZZ+Em4CTXub/ZgcFu74MTTIlrlGcvffuXbT96y1FY09GFVR1OYxPAAaXugobzPmygdQsHFOlJHM=
X-Received: by 2002:a05:6e02:2162:b0:3d9:2992:671b with SMTP id
 e9e14a558f8ab-3e2be6d8bf0mr95356415ab.4.1753256738796; Wed, 23 Jul 2025
 00:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718101150.3681002-1-shengjiu.wang@nxp.com>
 <20250718101150.3681002-3-shengjiu.wang@nxp.com> <e7c90b0c-8aec-4fe0-85ef-a629e67a56a0@nxp.com>
In-Reply-To: <e7c90b0c-8aec-4fe0-85ef-a629e67a56a0@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 23 Jul 2025 15:45:25 +0800
X-Gm-Features: Ac12FXyU9MWwc47HuNlLZ4wsOV8YjC_8os7rfcH7895czw6qE04EF09wd4hE6AY
Message-ID: <CAA+D8APjsiMnmnaAsxdcLi5g0hHgGSpFCgAxo042RK4yD-DraQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/bridge: imx: add driver for HDMI TX Parallel
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
	p.zabel@pengutronix.de, devicetree@vger.kernel.org, l.stach@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 4:47=E2=80=AFPM Liu Ying <victor.liu@nxp.com> wrote=
:
>
> Hi Shengjiu,
>
> On 07/18/2025, Shengjiu Wang wrote:
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
>
> Should DRM_IMX8MP_DW_HDMI_BRIDGE imply DRM_IMX8MP_HDMI_PAI as it implies
> DRM_IMX8MP_HDMI_PVI and PHY_FSL_SAMSUNG_HDMI_PHY?

yes.

>
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
>
> Usually, linux/*.h header files come before drm/*.h header files.
>
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
>
> The above 4 registers are unused.  Drop.
>
> > +
> > +#define CTRL_ENABLE                    BIT(0)
>
> Drop CTRL_ prefix.  Same for the other bits/fields.
>
> Define this bit under register HTX_PAI_CTRL.  Same for bits/fields of
> the other registers.

Ok, will update them.
>
> > +
> > +#define CTRL_EXT_WTMK_HIGH_MASK                GENMASK(31, 24)
> > +#define CTRL_EXT_WTMK_HIGH             (0x3 << 24)
>
> Add a parameter for the macro and use FIELD_PREP.
> Same for WTMK_LOW and NUM_CH.
>
> #define WTMK_HIGH(n)    FIELD_PREP(WTMK_HIGH_MASK, (n))
>
> > +#define CTRL_EXT_WTMK_LOW_MASK         GENMASK(23, 16)
> > +#define CTRL_EXT_WTMK_LOW              (0x3 << 16)
> > +#define CTRL_EXT_NUM_CH_MASK           GENMASK(10, 8)
> > +#define CTRL_EXT_NUM_CH_SHIFT          8
>
> This is not needed if FIELD_PREP is used.
>
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
>
> /* PAI set control extended */
>
> > +     val =3D CTRL_EXT_WTMK_HIGH | CTRL_EXT_WTMK_LOW;
> > +     val |=3D ((channel - 1) << CTRL_EXT_NUM_CH_SHIFT);
> > +     writel(val, hdmi_pai->base + HTX_PAI_CTRL_EXT);
>
> Can you use regmap API?

yes.

>
> > +
> > +     /* IEC60958 format */
> > +     val =3D 31 << FIELD_CTRL_P_SEL_SHIFT;
> > +     val |=3D 30 << FIELD_CTRL_C_SEL_SHIFT;
> > +     val |=3D 29 << FIELD_CTRL_U_SEL_SHIFT;
> > +     val |=3D 28 << FIELD_CTRL_V_SEL_SHIFT;
> > +     val |=3D 4 << FIELD_CTRL_D_SEL_SHIFT;
> > +     val |=3D 0 << FIELD_CTRL_PRE_SEL_SHIFT;
> > +
>
> Nit: remove this blank line.
>
> > +     writel(val, hdmi_pai->base + HTX_PAI_FIELD_CTRL);
>
> Nit: add a blank line here.
>
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
> > +     plat_data->enable_audio =3D imx8mp_hdmi_pai_enable;
> > +     plat_data->disable_audio =3D imx8mp_hdmi_pai_disable;
>
> {enable,disable}_audio callbacks could be set too late...
> You are trying to probe this driver after imx8mp_hdmi_tx is probed,
> i.e., after dw_hdmi_probe() is called in imx8mp_dw_hdmi_probe().
> Note that after dw_hdmi_probe() is called, the audio device could be
> functional soon, while this probe is called asynchronously.
>
> Also, what if imx8mp_hdmi_pai module is removed while imx8mp_hdmi_tx
> is running?  Leaking {enable,disable}_audio callbacks?
>
> I think that you may try to use component helper to take imx8mp_hdmi_tx
> as an aggregate driver and this driver as a component driver.  After
> the component is bound, you may set {enable,disable}_audio callbacks
> in imx8mp_hdmi_tx before calling dw_hdmi_probe().
> And, you need to export imx8mp_hdmi_pai_{enable,disable} symbols.

yes, will use component helper.  with component helper, we can assign
the {enable, disable}_audio in .bind() callback,  not matter which driver
probe first.

best regards
Shengjiu Wang
>
> > +     plat_data->priv_audio =3D hdmi_pai;
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
>
> --
> Regards,
> Liu Ying

