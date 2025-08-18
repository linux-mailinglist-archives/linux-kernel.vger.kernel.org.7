Return-Path: <linux-kernel+bounces-773079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20F7B29B37
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E2A3AB22F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3570B28688A;
	Mon, 18 Aug 2025 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="lUNTVzOx"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC5A286D60;
	Mon, 18 Aug 2025 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503288; cv=none; b=RTqXgToXCXYXpNcohCiUavkM+H/3Gls5YTDS651RsAwlVmXgcmDmpYtPdrYgAzhS3BPogPrGepJjBB6IK6jUrUED+TXGSzT8UYjgwtR0JL8VskBaZ0qA+5ug9ms94zxC3S1RG5Di6BCXrea3jZSixAM24MRFTG4DDr24pRiMcDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503288; c=relaxed/simple;
	bh=G7Dc1qiWhMrpF3YucbzoCB3UoF+2xeRx3XGtdDkAnUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6iE40PJKNfOJv8mt/ernSrKqq7yc71KaO7dtQV0eBmDJzo2wBp29w9wZQTi0hsDP5brRMW8ZOarAIvma0NZDbWLORCHbms+ZfF9JZ1mP2tSHeQ8jnU6DsOTBJUbykbdl9icz6Ucpnj5enitJZpuwptX9p2HZAzX/6s0fAD85yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=lUNTVzOx; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755503149;
	bh=ZoS2EI4Zzr8UNkvT28OeXQyqNfv81mVfEDuYTE9zSb4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=lUNTVzOxyBLQpytcxJqNZTYcOT0RkSi2VtOb8GPfJbwUYQsa67iVHxzaoGhU4Fj4D
	 4Z3T0akAouFOFSxxvt8xL/DCZyEfEiNgseau9TTDCSIRZjEuVTHcR3uuvqGocwv0Ke
	 wZzZbZ2aaY1Uk5G1KfM3FA9G/W0+nSXnEEwJPrfI=
X-QQ-mid: esmtpgz14t1755503147t6aaf9395
X-QQ-Originating-IP: yP/GhzIIW7KtDXl1ugZehVOJ05GCdTxziUtHS3a2AF8=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 15:45:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7680891694613958301
EX-QQ-RecipientCnt: 29
Date: Mon, 18 Aug 2025 15:45:45 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Icenowy Zheng <uwu@icenowy.me>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Han Gao <rabenda.cn@gmail.com>, Yao Zi <ziyao@disroot.org>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [RFC PATCH 5/8] drm/bridge: add a driver for T-Head TH1520 HDMI
 controller
Message-ID: <F2C43938B17FA1E1+aKLaKQfN1Ax8Blcx@LT-Guozexi>
References: <20250814164048.2336043-1-uwu@icenowy.me>
 <20250814164048.2336043-6-uwu@icenowy.me>
 <sp2pdifimqych5zn3mt7pnba3vl25qflgiys76s7dwmyt3jd72@bmwkc7s6p6c4>
 <63b2ac72fe1d15d214e880f223bb3035e177a07b.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63b2ac72fe1d15d214e880f223bb3035e177a07b.camel@icenowy.me>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MWLCkAjnYYm5Yty7GN57wTW48nlFE6g4QNhTU4Sjb/WOogUbgdCtXV6O
	CfHQlQeiDlgkrAxlApeSNe0gDECO5FZM3XYMoGLVdK77mm4qdzp8bBf78/VbCDylZydYU3w
	rCbnuxq7+AgwoCpzUwe89nmHplt5D1FOZpG9hvKYM0wcyk6wV5v8mVsXAtI/Z/FpmjKEvzV
	lGvNtBiX8io/5evrMNgvyRp0ML/Pl++M7+29f3hZDPzSL4psn0RLcgyUcT6RRvodcpl22TH
	d7Gnt9rJQ3j8f64jOYCEOSBCln2BAdQSl5JWlHtR56xCQ3yxm4pnzK/WYMESbCfkhYjt6XG
	eQ/XoEU8RTPRFvi0yyYiJJYgDqosgvykr7g+12uqB0Gczyg99rTCxDG4KLm+t977rJ900HY
	47XyTXCszTZYFD1cMHVpi59XzFuzE7yoxs0TdwCELH7wrCynYOzFMWAwEUXMAopszq8NqBt
	NhGmUSn/qfeXABaPsWUc0XIU7QmJE/W10g+aDc3cYXOkG1yKmF6ZMUVc1lcqi27V9Sd2Zh4
	e1YvrrXK38i5bJH3ADqzwvERwwf8iBSxMVTkZHJtR51m9bwNjiyOTiL09yw+jw24iUa7erb
	GsbC3ahPW02lqv7lG35eiOxPdvH1GgBCEUrrVsJW4rdzgpNa3uAE2a5+6XrvIgmDEk140Zz
	X7hnPfmkiTfnhyLppq8vAyVxWdgHYmgUDZF+j79lKBLB5mM1gq9R1bhKBeaDJehGApiXEci
	nP+DWkY8/WE5119L+Is3LXTXdy66KHd21sgVzlQHx3K5cgoppFOpraJIpaiNURjgnAxKh5K
	x47VZnx27KuR6kf5vli+raV2u+eXX589wZQEV329Gb//luBOC3eUyvedZTjSriXaa+Hi97N
	wj9ycFEM++ivwATE8l3Fd52lpWf7RkvddtWl5kCIMmpBMzDq7RnZ3rUthNX/GNQli2vdlk8
	I2R0RWFeqV1O93xqpnkci0xuKpusWOi32/qH+VtB6S1P+bLN8Ah1ppj9GtJ7q04Uz64JgE8
	zXHOKWYuVU6ri1aIlkv5+RDaj4u3eeZh/Bb8RGGsSpm8cjVDYsvHAzbhhvOC0Yp+28f9beP
	Wxm4sETz7Md4KAkXHyoOGl49vcZ/fFgvmBzNGNcwqRX
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Sun, Aug 17, 2025 at 01:10:44AM +0800, Icenowy Zheng wrote:
> 在 2025-08-16星期六的 19:24 +0300，Dmitry Baryshkov写道：
> > On Fri, Aug 15, 2025 at 12:40:45AM +0800, Icenowy Zheng wrote:
> > > T-Head TH1520 SoC contains a Synopsys DesignWare HDMI controller
> > > (paired
> > > with DesignWare HDMI TX PHY Gen2) that takes the "DP" output from
> > > the
> > > display controller.
> > > 
> > > Add a driver for this controller utilizing the common DesignWare
> > > HDMI
> > > code in the kernel.
> > > 
> > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > ---
> > >  MAINTAINERS                             |   1 +
> > >  drivers/gpu/drm/bridge/Kconfig          |  10 ++
> > >  drivers/gpu/drm/bridge/Makefile         |   1 +
> > >  drivers/gpu/drm/bridge/th1520-dw-hdmi.c | 170
> > > ++++++++++++++++++++++++
> > >  4 files changed, 182 insertions(+)
> > >  create mode 100644 drivers/gpu/drm/bridge/th1520-dw-hdmi.c
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index fe168477caa45..eb84e36ded6d5 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -21728,6 +21728,7 @@
> > > F:      Documentation/devicetree/bindings/reset/thead,th1520-
> > > reset.yaml
> > >  F:     arch/riscv/boot/dts/thead/
> > >  F:     drivers/clk/thead/clk-th1520-ap.c
> > >  F:     drivers/firmware/thead,th1520-aon.c
> > > +F:     drivers/gpu/drm/bridge/th1520-dw-hdmi.c
> > >  F:     drivers/mailbox/mailbox-th1520.c
> > >  F:     drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > >  F:     drivers/pinctrl/pinctrl-th1520.c
> > > diff --git a/drivers/gpu/drm/bridge/Kconfig
> > > b/drivers/gpu/drm/bridge/Kconfig
> > > index b9e0ca85226a6..f75e6ad04179f 100644
> > > --- a/drivers/gpu/drm/bridge/Kconfig
> > > +++ b/drivers/gpu/drm/bridge/Kconfig
> > > @@ -322,6 +322,16 @@ config DRM_THINE_THC63LVD1024
> > >         help
> > >           Thine THC63LVD1024 LVDS/parallel converter driver.
> > >  
> > > +config DRM_THEAD_TH1520_DW_HDMI
> > > +       tristate "T-Head TH1520 DesignWare HDMI bridge"
> > > +       depends on OF
> > > +       depends on COMMON_CLK
> > > +       depends on ARCH_THEAD || COMPILE_TEST
> > > +       select DRM_DW_HDMI
> > > +       help
> > > +         Choose this to enable support for the internal HDMI
> > > bridge found
> > > +         on the T-Head TH1520 SoC.
> > > +
> > >  config DRM_TOSHIBA_TC358762
> > >         tristate "TC358762 DSI/DPI bridge"
> > >         depends on OF
> > > diff --git a/drivers/gpu/drm/bridge/Makefile
> > > b/drivers/gpu/drm/bridge/Makefile
> > > index 245e8a27e3fc5..421e445ff1cd9 100644
> > > --- a/drivers/gpu/drm/bridge/Makefile
> > > +++ b/drivers/gpu/drm/bridge/Makefile
> > > @@ -27,6 +27,7 @@ obj-$(CONFIG_DRM_SIL_SII8620) += sil-sii8620.o
> > >  obj-$(CONFIG_DRM_SII902X) += sii902x.o
> > >  obj-$(CONFIG_DRM_SII9234) += sii9234.o
> > >  obj-$(CONFIG_DRM_SIMPLE_BRIDGE) += simple-bridge.o
> > > +obj-$(CONFIG_DRM_THEAD_TH1520_DW_HDMI) += th1520-dw-hdmi.o
> > >  obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
> > >  obj-$(CONFIG_DRM_TOSHIBA_TC358762) += tc358762.o
> > >  obj-$(CONFIG_DRM_TOSHIBA_TC358764) += tc358764.o
> > > diff --git a/drivers/gpu/drm/bridge/th1520-dw-hdmi.c
> > > b/drivers/gpu/drm/bridge/th1520-dw-hdmi.c
> > > new file mode 100644
> > > index 0000000000000..f8dddf3cb0cca
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/bridge/th1520-dw-hdmi.c
> > > @@ -0,0 +1,170 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright (C) 2025 Icenowy Zheng <uwu@icenowy.me>
> > > + *
> > > + * Based on rcar_dw_hdmi.c, which is:
> > > + *   Copyright (C) 2016 Renesas Electronics Corporation
> > > + * Based on imx8mp-hdmi-tx.c, which is:
> > > + *   Copyright (C) 2022 Pengutronix, Lucas Stach
> > > <kernel@pengutronix.de>
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/reset.h>
> > > +
> > > +#include <drm/bridge/dw_hdmi.h>
> > > +#include <drm/drm_modes.h>
> > > +
> > > +#define TH1520_HDMI_PHY_OPMODE_PLLCFG  0x06    /* Mode of
> > > operation and PLL dividers */
> > > +#define TH1520_HDMI_PHY_CKSYMTXCTRL    0x09    /* Clock Symbol and
> > > Transmitter Control Register */
> > > +#define TH1520_HDMI_PHY_VLEVCTRL       0x0e    /* Voltage Level
> > > Control Register */
> > > +#define TH1520_HDMI_PHY_PLLCURRGMPCTRL 0x10    /* PLL current and
> > > Gmp (conductance) */
> > > +#define TH1520_HDMI_PHY_PLLDIVCTRL     0x11    /* PLL dividers */
> > > +#define TH1520_HDMI_PHY_TXTERM         0x19    /* Transmission
> > > Termination Register */
> > > +
> > > +struct th1520_hdmi_phy_params {
> > > +       unsigned long mpixelclock;
> > > +       u16 opmode_pllcfg;
> > > +       u16 pllcurrgmpctrl;
> > > +       u16 plldivctrl;
> > > +       u16 cksymtxctrl;
> > > +       u16 vlevctrl;
> > > +       u16 txterm;
> > > +};
> > > +
> > > +static const struct th1520_hdmi_phy_params
> > > th1520_hdmi_phy_params[] = {
> > > +       { 35500000,  0x0003, 0x0283, 0x0628, 0x8088, 0x01a0, 0x0007
> > > },
> > > +       { 44900000,  0x0003, 0x0285, 0x0228, 0x8088, 0x01a0, 0x0007
> > > },
> > > +       { 71000000,  0x0002, 0x1183, 0x0614, 0x8088, 0x01a0, 0x0007
> > > },
> > > +       { 90000000,  0x0002, 0x1142, 0x0214, 0x8088, 0x01a0, 0x0007
> > > },
> > > +       { 121750000, 0x0001, 0x20c0, 0x060a, 0x8088, 0x01a0, 0x0007
> > > },
> > > +       { 165000000, 0x0001, 0x2080, 0x020a, 0x8088, 0x01a0, 0x0007
> > > },
> > > +       { 198000000, 0x0000, 0x3040, 0x0605, 0x83c8, 0x0120, 0x0004
> > > },
> > > +       { 297000000, 0x0000, 0x3041, 0x0205, 0x81dc, 0x0200, 0x0005
> > > },
> > > +       { 371250000, 0x0640, 0x3041, 0x0205, 0x80f6, 0x0140, 0x0000
> > > },
> > > +       { 495000000, 0x0640, 0x3080, 0x0005, 0x80f6, 0x0140, 0x0000
> > > },
> > > +       { 594000000, 0x0640, 0x3080, 0x0005, 0x80fa, 0x01e0, 0x0004
> > > },
> > > +       { ~0UL,      0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000
> > > }
> > > +};
> > > +
> > > +struct th1520_hdmi {
> > > +       struct dw_hdmi_plat_data plat_data;
> > > +       struct dw_hdmi *dw_hdmi;
> > > +       struct clk *pixclk;
> > > +       struct reset_control *mainrst, *prst;
> > > +};
> > > +
> > > +static enum drm_mode_status
> > > +th1520_hdmi_mode_valid(struct dw_hdmi *hdmi, void *data,
> > > +                      const struct drm_display_info *info,
> > > +                      const struct drm_display_mode *mode)
> > > +{
> > > +       /*
> > > +        * The maximum supported clock frequency is 594 MHz, as
> > > shown in the PHY
> > > +        * parameters table.
> > > +        */
> > > +       if (mode->clock > 594000)
> > > +               return MODE_CLOCK_HIGH;
> > 
> > We should rewrite DW bridge into HDMI ops. It would help us to get
> > rid
> > of such functions. With it in place it will be handled by the generic
> > TMDS clock rate check.
> 
> Yes, but this mode_valid hook here is part of the private interface of
> DW bridge, instead of implementing anything for other parts of DRM
> subsystem.
> 
> Even if the TMDS clock rate check is utilized by the DW bridge, the
> bridge's interface should be modified to expose something to set the
> maximum clock rate.
> 
> > 
> > > +
> > > +       return MODE_OK;
> > > +}
> > > +
> > > +static int th1520_hdmi_phy_configure(struct dw_hdmi *hdmi, void
> > > *data,
> > > +                                    unsigned long mpixelclock)
> > > +{
> > > +       const struct th1520_hdmi_phy_params *params =
> > > th1520_hdmi_phy_params;
> > > +
> > > +       for (; params->mpixelclock != ~0UL; ++params) {
> > > +               if (mpixelclock <= params->mpixelclock)
> > > +                       break;
> > 
> > for (...) {
> >         if (mpixelclock <= params->mpixelclock)
> >                 return th1520_program_phy();
> 
> There's no such a function here, and this check isn't used for another
> time, so having the matching code and programming code extracted out
> can help nothing.
I think Dmitry meant that the following code should be moved into
a new function, th1520_program_phy().  

This makes the code cleaner and also avoids one extra if check.

                - Troy
> 
> > }
> > 
> > return -EINVAL;
> > 
> > > +       }
> > > +
> > > +       if (params->mpixelclock == ~0UL)
> > > +               return -EINVAL;
> > > +
> > > +       dw_hdmi_phy_i2c_write(hdmi, params->opmode_pllcfg,
> > > +                             TH1520_HDMI_PHY_OPMODE_PLLCFG);
> > > +       dw_hdmi_phy_i2c_write(hdmi, params->pllcurrgmpctrl,
> > > +                             TH1520_HDMI_PHY_PLLCURRGMPCTRL);
> > > +       dw_hdmi_phy_i2c_write(hdmi, params->plldivctrl,
> > > +                             TH1520_HDMI_PHY_PLLDIVCTRL);
> > > +       dw_hdmi_phy_i2c_write(hdmi, params->vlevctrl,
> > > +                             TH1520_HDMI_PHY_VLEVCTRL);
> > > +       dw_hdmi_phy_i2c_write(hdmi, params->cksymtxctrl,
> > > +                             TH1520_HDMI_PHY_CKSYMTXCTRL);
> > > +       dw_hdmi_phy_i2c_write(hdmi, params->txterm,
> > > +                             TH1520_HDMI_PHY_TXTERM);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int th1520_dw_hdmi_probe(struct platform_device *pdev)
> > > +{
> > > +       struct th1520_hdmi *hdmi;
> > > +       struct dw_hdmi_plat_data *plat_data;
> > > +       struct device *dev = &pdev->dev;
> > > +
> > > +       hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
> > > +       if (!hdmi)
> > > +               return -ENOMEM;
> > > +
> > > +       plat_data = &hdmi->plat_data;
> > > +
> > > +       hdmi->pixclk = devm_clk_get_enabled(dev, "pix");
> > > +       if (IS_ERR(hdmi->pixclk))
> > > +               return dev_err_probe(dev, PTR_ERR(hdmi->pixclk),
> > > +                                    "Unable to get pixel
> > > clock\n");
> > > +
> > > +       hdmi->mainrst =
> > > devm_reset_control_get_exclusive_deasserted(dev, "main");
> > > +       if (IS_ERR(hdmi->mainrst))
> > > +               return dev_err_probe(dev, PTR_ERR(hdmi->mainrst),
> > > +                                    "Unable to get main reset\n");
> > > +
> > > +       hdmi->prst =
> > > devm_reset_control_get_exclusive_deasserted(dev, "apb");
> > > +       if (IS_ERR(hdmi->prst))
> > > +               return dev_err_probe(dev, PTR_ERR(hdmi->prst),
> > > +                                    "Unable to get apb reset\n");
> > > +
> > > +       plat_data->output_port = 1;
> > > +       plat_data->mode_valid = th1520_hdmi_mode_valid;
> > > +       plat_data->configure_phy = th1520_hdmi_phy_configure;
> > > +       plat_data->priv_data = hdmi;
> > > +
> > > +       hdmi->dw_hdmi = dw_hdmi_probe(pdev, plat_data);
> > > +       if (IS_ERR(hdmi))
> > > +               return PTR_ERR(hdmi);
> > > +
> > > +       platform_set_drvdata(pdev, hdmi);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void th1520_dw_hdmi_remove(struct platform_device *pdev)
> > > +{
> > > +       struct dw_hdmi *hdmi = platform_get_drvdata(pdev);
> > > +
> > > +       dw_hdmi_remove(hdmi);
> > > +}
> > > +
> > > +static const struct of_device_id th1520_dw_hdmi_of_table[] = {
> > > +       { .compatible = "thead,th1520-dw-hdmi" },
> > > +       { /* Sentinel */ },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, th1520_dw_hdmi_of_table);
> > > +
> > > +static struct platform_driver th1520_dw_hdmi_platform_driver = {
> > > +       .probe          = th1520_dw_hdmi_probe,
> > > +       .remove         = th1520_dw_hdmi_remove,
> > > +       .driver         = {
> > > +               .name   = "th1520-dw-hdmi",
> > > +               .of_match_table = th1520_dw_hdmi_of_table,
> > > +       },
> > > +};
> > > +
> > > +module_platform_driver(th1520_dw_hdmi_platform_driver);
> > > +
> > > +MODULE_AUTHOR("Icenowy Zheng <uwu@icenowy.me>");
> > > +MODULE_DESCRIPTION("T-Head TH1520 HDMI Encoder Driver");
> > > +MODULE_LICENSE("GPL");
> > > -- 
> > > 2.50.1
> > > 
> > 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

