Return-Path: <linux-kernel+bounces-773097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11760B29B65
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17AC918A5D48
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EB12C08A1;
	Mon, 18 Aug 2025 07:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="gg1Uggjv"
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1161298CBC;
	Mon, 18 Aug 2025 07:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503753; cv=none; b=CVs9GnCt20Z8kXD5g31TK+YV4BOjg7ZPorRdIDr/mxj+CtpUEgKxeEDjY8eTfCpi9neAiM4CLXnLHukqzdE9lcpOL7MEnlnkj9fVo9xUKOvifaudUjv1aDBLYuXQDdes52jTTLbqsM6ZTWguhJF2h+aY1GrUZhmBqTPMHDeN7sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503753; c=relaxed/simple;
	bh=UAwd3z5zLQbxIssyTRv6RPq2/tnFXT2CmIJCJoDte7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8g03ekyd5HxPukwk293CZCgG2un6/fR/NMLW7EaBeGkW2Xp4oKsw8+ph8v6+qrIvLR+tUc9wRjLiNhs65SqcEOvqohlcWntFMSAGhY8zXOxwgSojbe5DtWyUXEfzBkULGgzeA3+PARR60ieccaSTRKg6GB1MpG+mUxGKhl4Cdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=gg1Uggjv; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755503661;
	bh=M7FG8rcP3ahTEEVM6NGqGjxSRQwruFZ03rYRJPa/Wxk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=gg1Uggjv+rScTKYJEhC0aZqoipSbtYZDQpOPdmkzZw8c284UDUjVzAHf79ReQyGN1
	 mxczeH2WTAa9ih2qOMeucPAYEQInxWU7xvGd0BkA9zFjt2/bTKjLifa8J2rROXSni6
	 frn7drJfCaeaIZh8kNOCgZiuyxHJwar5+UUdaR5o=
X-QQ-mid: esmtpgz14t1755503659t78ac8189
X-QQ-Originating-IP: ZO7sqOcVCqag9e3u+tTDpLwUHxzVsU3LE4vNP/SahMk=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 15:54:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8049969608128099302
EX-QQ-RecipientCnt: 29
Date: Mon, 18 Aug 2025 15:54:17 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Icenowy Zheng <uwu@icenowy.me>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
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
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH 5/8] drm/bridge: add a driver for T-Head TH1520 HDMI
 controller
Message-ID: <A3089DC4F031A2C0+aKLcKYtWzpLdB0lH@LT-Guozexi>
References: <20250814164048.2336043-1-uwu@icenowy.me>
 <20250814164048.2336043-6-uwu@icenowy.me>
 <sp2pdifimqych5zn3mt7pnba3vl25qflgiys76s7dwmyt3jd72@bmwkc7s6p6c4>
 <63b2ac72fe1d15d214e880f223bb3035e177a07b.camel@icenowy.me>
 <F2C43938B17FA1E1+aKLaKQfN1Ax8Blcx@LT-Guozexi>
 <7ad9a700dce9342d720740525626340237eb8d9f.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ad9a700dce9342d720740525626340237eb8d9f.camel@icenowy.me>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: N8/bw4T4KgrY8E2VabFdwkTvdJpURSV7nDa1ndj/F+oPkwtMYzQUF8hC
	G1msqSQ+reszEkKdpfpG0vsBIjFkbcKiDJkBdkqUaef0OURmKA0faIT5vkOMQiV3dFKAjeL
	qpyY9TBzUY5Mfv2ohqMbMYQrGgxTcjCY1qwvOHM/aiUyArI5NKFP410fSoUmCnsGZ/okVJy
	kgPM78zENrx7h75GTeYjWkEloBt9pBEwAPnGZoILHK8DsAojx1CWjbDfz6iRPusxHKaYZjM
	v78GrsS4ZJmgPg1yT2YMdsxUKOq60VhUEcBVOUku68YN+9Dw8/kCDPYS1gweLymPr6vRotJ
	6BaWPu7CbCOhGHWbF5QhxmEJY9d7brZ4IR0CVlI2HOLtCpIzEFLKwBJKHP5Mju72cwZ4a2y
	VRDYV+abFne92ZlPV5IplMJ+0qgrhxpVVs857C5/pDZC1gxLijqLN8vO22sNiIih7uOHPRc
	WPL0fZYKe5xAq898bnOgzJfBaM8wT4q0LSo/CoXNLE7BfWyEbX/7eLcoGR8hhaQ1Xqx7+Bs
	1tt1TkA9woN+zvjcOioZ9WyaJ0kTNJnuVRYK267Qk4vzP1w5VapOptBPHrL64z+FoEuKar4
	WJkQshHKAvlywWMMd5uj65nX/p64PRsrQJIsZNz/UKh9rnfzk2Edp46+0uP0Cw0kjAsgT+V
	jX599PlBid2ZuLqbUWHECGPExQvuXnapQa0g/7ee9pnVdw3Pd08YqAsPBDF7f9m3DVxvPwD
	P2GyJKcT3Xgl0NfxB6RkJF1cEnqnRgijO1VsGaAFkiWZJ744m4GSbn6aq6olJXo2sWeGtWR
	FWeq3rSZ2cZo7ptYeWXTOE6F/2k02rPsHTMjGq3ZpcDOKUU7W6xaGgxmwvXyK+a51wrcl/X
	Ovh+aGeQXZDOtOr751lM0f1vUHZUj5AGCcDJeRn57dh2EQqARIZTrSKslg/8mc54NgdUqn0
	GOuPmsi9sjg7uGPiGF9VoS6c4BV1gcZ5kt5QxLTQK10jIqMBXtrkds0fAmFMIPYvKe5mlBp
	rc9PWAE5yqjZnpWMxIrSdPaikhF0EBQNEUn7HpJ5akPECDLVKZcfkFr45n16IhbHnciZvqn
	uSwfsktk8OzFbevttzE323qPsVG+Vb7fQ==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Mon, Aug 18, 2025 at 03:47:28PM +0800, Icenowy Zheng wrote:
> 在 2025-08-18星期一的 15:45 +0800，Troy Mitchell写道：
> > On Sun, Aug 17, 2025 at 01:10:44AM +0800, Icenowy Zheng wrote:
> > > 在 2025-08-16星期六的 19:24 +0300，Dmitry Baryshkov写道：
> > > > On Fri, Aug 15, 2025 at 12:40:45AM +0800, Icenowy Zheng wrote:
> > > > > T-Head TH1520 SoC contains a Synopsys DesignWare HDMI
> > > > > controller
> > > > > (paired
> > > > > with DesignWare HDMI TX PHY Gen2) that takes the "DP" output
> > > > > from
> > > > > the
> > > > > display controller.
> > > > > 
> > > > > Add a driver for this controller utilizing the common
> > > > > DesignWare
> > > > > HDMI
> > > > > code in the kernel.
> > > > > 
> > > > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > > > ---
[...]
> > > > > +static int th1520_hdmi_phy_configure(struct dw_hdmi *hdmi,
> > > > > void
> > > > > *data,
> > > > > +                                    unsigned long mpixelclock)
> > > > > +{
> > > > > +       const struct th1520_hdmi_phy_params *params =
> > > > > th1520_hdmi_phy_params;
> > > > > +
> > > > > +       for (; params->mpixelclock != ~0UL; ++params) {
> > > > > +               if (mpixelclock <= params->mpixelclock)
> > > > > +                       break;
> > > > 
> > > > for (...) {
> > > >         if (mpixelclock <= params->mpixelclock)
> > > >                 return th1520_program_phy();
> > > 
> > > There's no such a function here, and this check isn't used for
> > > another
> > > time, so having the matching code and programming code extracted
> > > out
> > > can help nothing.
> > I think Dmitry meant that the following code should be moved into
> > a new function, th1520_program_phy().  
> > 
> > This makes the code cleaner and also avoids one extra if check.
> 
> As there's no code reuse, it does not make code cleaner.
I respect your opinion, but let's also see what Dmitry has to say.

                - Troy
> 
> > 
> >                 - Troy
> > > 
> > > > }
> > > > 
> > > > return -EINVAL;
> > > > 
> > > > > +       }
> > > > > +
> > > > > +       if (params->mpixelclock == ~0UL)
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       dw_hdmi_phy_i2c_write(hdmi, params->opmode_pllcfg,
> > > > > +                             TH1520_HDMI_PHY_OPMODE_PLLCFG);
> > > > > +       dw_hdmi_phy_i2c_write(hdmi, params->pllcurrgmpctrl,
> > > > > +                             TH1520_HDMI_PHY_PLLCURRGMPCTRL);
> > > > > +       dw_hdmi_phy_i2c_write(hdmi, params->plldivctrl,
> > > > > +                             TH1520_HDMI_PHY_PLLDIVCTRL);
> > > > > +       dw_hdmi_phy_i2c_write(hdmi, params->vlevctrl,
> > > > > +                             TH1520_HDMI_PHY_VLEVCTRL);
> > > > > +       dw_hdmi_phy_i2c_write(hdmi, params->cksymtxctrl,
> > > > > +                             TH1520_HDMI_PHY_CKSYMTXCTRL);
> > > > > +       dw_hdmi_phy_i2c_write(hdmi, params->txterm,
> > > > > +                             TH1520_HDMI_PHY_TXTERM);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static int th1520_dw_hdmi_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +       struct th1520_hdmi *hdmi;
> > > > > +       struct dw_hdmi_plat_data *plat_data;
> > > > > +       struct device *dev = &pdev->dev;
> > > > > +
> > > > > +       hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
> > > > > +       if (!hdmi)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       plat_data = &hdmi->plat_data;
> > > > > +
> > > > > +       hdmi->pixclk = devm_clk_get_enabled(dev, "pix");
> > > > > +       if (IS_ERR(hdmi->pixclk))
> > > > > +               return dev_err_probe(dev, PTR_ERR(hdmi-
> > > > > >pixclk),
> > > > > +                                    "Unable to get pixel
> > > > > clock\n");
> > > > > +
> > > > > +       hdmi->mainrst =
> > > > > devm_reset_control_get_exclusive_deasserted(dev, "main");
> > > > > +       if (IS_ERR(hdmi->mainrst))
> > > > > +               return dev_err_probe(dev, PTR_ERR(hdmi-
> > > > > >mainrst),
> > > > > +                                    "Unable to get main
> > > > > reset\n");
> > > > > +
> > > > > +       hdmi->prst =
> > > > > devm_reset_control_get_exclusive_deasserted(dev, "apb");
> > > > > +       if (IS_ERR(hdmi->prst))
> > > > > +               return dev_err_probe(dev, PTR_ERR(hdmi->prst),
> > > > > +                                    "Unable to get apb
> > > > > reset\n");
> > > > > +
> > > > > +       plat_data->output_port = 1;
> > > > > +       plat_data->mode_valid = th1520_hdmi_mode_valid;
> > > > > +       plat_data->configure_phy = th1520_hdmi_phy_configure;
> > > > > +       plat_data->priv_data = hdmi;
> > > > > +
> > > > > +       hdmi->dw_hdmi = dw_hdmi_probe(pdev, plat_data);
> > > > > +       if (IS_ERR(hdmi))
> > > > > +               return PTR_ERR(hdmi);
> > > > > +
> > > > > +       platform_set_drvdata(pdev, hdmi);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static void th1520_dw_hdmi_remove(struct platform_device
> > > > > *pdev)
> > > > > +{
> > > > > +       struct dw_hdmi *hdmi = platform_get_drvdata(pdev);
> > > > > +
> > > > > +       dw_hdmi_remove(hdmi);
> > > > > +}
> > > > > +
> > > > > +static const struct of_device_id th1520_dw_hdmi_of_table[] = {
> > > > > +       { .compatible = "thead,th1520-dw-hdmi" },
> > > > > +       { /* Sentinel */ },
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(of, th1520_dw_hdmi_of_table);
> > > > > +
> > > > > +static struct platform_driver th1520_dw_hdmi_platform_driver =
> > > > > {
> > > > > +       .probe          = th1520_dw_hdmi_probe,
> > > > > +       .remove         = th1520_dw_hdmi_remove,
> > > > > +       .driver         = {
> > > > > +               .name   = "th1520-dw-hdmi",
> > > > > +               .of_match_table = th1520_dw_hdmi_of_table,
> > > > > +       },
> > > > > +};
> > > > > +
> > > > > +module_platform_driver(th1520_dw_hdmi_platform_driver);
> > > > > +
> > > > > +MODULE_AUTHOR("Icenowy Zheng <uwu@icenowy.me>");
> > > > > +MODULE_DESCRIPTION("T-Head TH1520 HDMI Encoder Driver");
> > > > > +MODULE_LICENSE("GPL");
> > > > > -- 
> > > > > 2.50.1
> > > > > 
> > > > 
> > > 
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

