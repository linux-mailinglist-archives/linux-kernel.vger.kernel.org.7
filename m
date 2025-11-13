Return-Path: <linux-kernel+bounces-899520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7FCC58033
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1386D4E842F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB49C2727E3;
	Thu, 13 Nov 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GahRMcoJ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5C51BDCF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044804; cv=none; b=d2WOyRVnsqSgdFHstoDFEGW0XsEBmWDRu67sT1mPOtTx7KjYPZ1WdJSjjf/1eDABXOjh5qeNfuYAMU9fTSXdF9C9FTcvHUhA+m1iduYqh2lzrhb/qjhrJKgMjNmBpC8qCpz9vCmvAYAI6n9bztAPPL/lo+MR/25Isuwbd+0pO8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044804; c=relaxed/simple;
	bh=LghFzzgYBjyF4DUix/4QjpTX8Cu2IkIHbWjtdoIpPok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtrFFLdhPp+nae2biIiPWbPD04UBPpwR7ciAT7bA7gFGCIYhH3X6n5rx8Pvwsh314LzMDEaMjYAWedFD9/hhL89i9aq0H6gZUjtYaB2in/UM1pZ5fhUb9ASQRTlN7Vv0Oe9uI2e9/5laj3VtVCApFH3zxbADjlTodEyy0kVXnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GahRMcoJ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-595819064cdso857703e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763044800; x=1763649600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wl4571SxJAzignqkvu+iEEF0Pe+/jqH/UWVoWMdIiw4=;
        b=GahRMcoJi3n7zVWIHvX+LiLzkfo+HKvHAaJJzWiW91ExIvEDeInJDw0hhQSvy3pJtB
         74l030XK/02bd/yErd+bcq3e02xbBXSRPforr+q6sGYgacQoNvEUzRWVRDopRyCXKsx1
         oHFFjHx3hfza3oim4JACBu6zmcWSsyUmjlBRtEkUjXvLGPWWM6dCRyfkT4VMovtJROJ5
         K0iybyc9NVMDnAi50uSHZBJe/2N0t7foBl82mpQSQZSIgweyhgfogdl+OMijlZtN3NZ5
         Lr2m2Ei+w+r7ncHV3yOHot/YFXNdp+z5dqjyFPr9JhEYQRRZWqiMvO30c7O9iI/98eL3
         c2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763044800; x=1763649600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wl4571SxJAzignqkvu+iEEF0Pe+/jqH/UWVoWMdIiw4=;
        b=ICuPcvBvDc6FMGD5p+9sO+/ILk0O56G1pq66xcDSPeuZ/3gniq4lfgnisaYLdwCHaP
         IvKhpEBBos/xxgW/xPJ3AUxGFM3PXn6LA1mOVD6yjFFiD8HOtDQ52VseoHStmjhFvKeH
         Ara/SBIhzRIfmqyyFGvr2U41tSyTZIfl5iyt32agpgtJQwWCe1uCAHLDpuWg6vkUPgHL
         Lofbq4gU7gcju3Bux2EpRMBQmuQPrshgF4ithfqxf4BkSRGQHjP6ZobQYC+fHeULat7o
         wlBjSHO46Q+TXhczpjLUE/YbYKzj410F3etw+3PbTfzQwdsP0MpDGjb9ZCUxgnp6w7VP
         C9kw==
X-Forwarded-Encrypted: i=1; AJvYcCUBKXxP+g4p9A9gTplrRlf1Rj0N9Q0lpIO3CXiUMKDIaZ5Ra3OF9JxX4JrlTuOsZxGfMQrKOFdCauKb4PE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY35zCsitp0bhP0B8u1nqtXsyxiri05PXbG5gb5rkrMyYrjrbi
	x3rGZB2OCnBoRJbdJnmMY+H7PnHOUcb1Xjq2VNc1vi64b0SrCJuv5+6erQPeloS/a3myThEGnhn
	GqtAoxxe+67d4yJjgY7pYBS8NeJzZ1ZPdRDYc6llCvQ==
X-Gm-Gg: ASbGncv2XwRRyXFT2S+PeN+1dZIGflh0LAVnGz8R6hM5I79+v2wMkBSsY92EPB3Rexz
	DFo9cX3mWI57z0Lp2yVYr2I6KsJfKM3EAKubX+0DDLwd2hXHU4gYOdfkrbaKPGvQKUF6g5NBeNU
	Eg9wezAyPFTq1Stp1JJ2TXeHSSHwW0T3DArjRd7ZWJ4buMM/8Gr3DzjS4IBNuaT0P/qyXLPpABU
	n78QyB2G57yCqqVClpYv4kaguA8JuLqATP+4fVdqmIki3GjH9GlFJvCsb6NE17esRPjw4y/k8sR
	CBu/xMpKifUiyjeb
X-Google-Smtp-Source: AGHT+IHcp5RL49BzQ/EwQ2Jax7wwd/a8PEM1WoZpid3JGwwdtlpJzBmzwt/P9jvyh9TplD5Nus8fFpsIw/K4cuDWoP0=
X-Received: by 2002:a05:6512:104f:b0:594:2876:c901 with SMTP id
 2adb3069b0e04-5957ececcc7mr1012811e87.25.1763044799557; Thu, 13 Nov 2025
 06:39:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107-qcom-sa8255p-emac-v5-0-01d3e3aaf388@linaro.org>
 <20251107-qcom-sa8255p-emac-v5-8-01d3e3aaf388@linaro.org> <aRMiafCQNPVDOljU@horms.kernel.org>
In-Reply-To: <aRMiafCQNPVDOljU@horms.kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 13 Nov 2025 15:39:45 +0100
X-Gm-Features: AWmQ_bmyO0__RPwdcHgOIMRaFCfnIoYFER6JzR_p2Qqf8fR68sQPWn6kw1o5zWY
Message-ID: <CAMRc=MfEuAhichw-tPJkj_BKxy7AzvfmVJJyXzHsqa2wf=2EKw@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] net: stmmac: qcom-ethqos: add support for sa8255p
To: Simon Horman <horms@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Vinod Koul <vkoul@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Matthew Gerlach <matthew.gerlach@altera.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Keguang Zhang <keguang.zhang@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com, 
	Romain Gantois <romain.gantois@bootlin.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Heiko Stuebner <heiko@sntech.de>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Emil Renner Berthing <kernel@esmil.dk>, Minda Chen <minda.chen@starfivetech.com>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, Shuang Liang <liangshuang@eswincomputing.com>, 
	Zhi Li <lizhi2@eswincomputing.com>, Shangjuan Wei <weishangjuan@eswincomputing.com>, 
	"G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	Linux Team <linux-imx@nxp.com>, Frank Li <Frank.Li@nxp.com>, David Wu <david.wu@rock-chips.com>, 
	Samin Guo <samin.guo@starfivetech.com>, 
	Christophe Roullier <christophe.roullier@foss.st.com>, Swathi K S <swathi.ks@samsung.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Drew Fustini <dfustini@tenstorrent.com>, 
	linux-sunxi@lists.linux.dev, linux-amlogic@lists.infradead.org, 
	linux-mips@vger.kernel.org, imx@lists.linux.dev, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 12:48=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Fri, Nov 07, 2025 at 11:29:58AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> ...
>
> > +static int qcom_ethqos_pd_init(struct platform_device *pdev, void *pri=
v)
> > +{
> > +     struct qcom_ethqos *ethqos =3D priv;
> > +     int ret;
> > +
> > +     /*
> > +      * Enable functional clock to prevent DMA reset after timeout due
> > +      * to no PHY clock being enabled after the hardware block has bee=
n
> > +      * power cycled. The actual configuration will be adjusted once
> > +      * ethqos_fix_mac_speed() is called.
> > +      */
> > +     ethqos_set_func_clk_en(ethqos);
> > +
> > +     ret =3D qcom_ethqos_domain_on(ethqos, ETHQOS_PD_CORE);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D qcom_ethqos_domain_on(ethqos, ETHQOS_PD_MDIO);
> > +     if (ret) {
> > +             qcom_ethqos_domain_off(ethqos, ETHQOS_PD_CORE);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void qcom_ethqos_pd_exit(struct platform_device *pdev, void *da=
ta)
> > +{
> > +     struct qcom_ethqos *ethqos =3D data;
> > +
> > +     qcom_ethqos_domain_off(ethqos, ETHQOS_PD_MDIO);
> > +     qcom_ethqos_domain_off(ethqos, ETHQOS_PD_CORE);
> > +}
> > +
> >  static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
> >  {
> >       struct plat_stmmacenet_data *plat_dat =3D priv->plat;
>
> ...
>
> > @@ -852,28 +993,63 @@ static int qcom_ethqos_probe(struct platform_devi=
ce *pdev)
> >       ethqos->rgmii_config_loopback_en =3D drv_data->rgmii_config_loopb=
ack_en;
> >       ethqos->has_emac_ge_3 =3D drv_data->has_emac_ge_3;
> >       ethqos->needs_sgmii_loopback =3D drv_data->needs_sgmii_loopback;
> > -
> > -     ethqos->pm.link_clk =3D devm_clk_get(dev, clk_name);
> > -     if (IS_ERR(ethqos->pm.link_clk))
> > -             return dev_err_probe(dev, PTR_ERR(ethqos->pm.link_clk),
> > -                                  "Failed to get link_clk\n");
> > -
> > -     ret =3D ethqos_clks_config(ethqos, true);
> > -     if (ret)
> > -             return ret;
> > -
> > -     ret =3D devm_add_action_or_reset(dev, ethqos_clks_disable, ethqos=
);
> > -     if (ret)
> > -             return ret;
> > -
> > -     ethqos->pm.serdes_phy =3D devm_phy_optional_get(dev, "serdes");
> > -     if (IS_ERR(ethqos->pm.serdes_phy))
> > -             return dev_err_probe(dev, PTR_ERR(ethqos->pm.serdes_phy),
> > -                                  "Failed to get serdes phy\n");
> > -
> > -     ethqos->set_serdes_speed =3D ethqos_set_serdes_speed_phy;
> >       ethqos->serdes_speed =3D SPEED_1000;
> > -     ethqos_update_link_clk(ethqos, SPEED_1000);
> > +
> > +     if (pm_data && pm_data->use_domains) {
> > +             ethqos->set_serdes_speed =3D ethqos_set_serdes_speed_pd;
> > +
> > +             ret =3D devm_pm_domain_attach_list(dev, &pm_data->pd,
> > +                                              &ethqos->pd.pd_list);
> > +             if (ret < 0)
> > +                     return dev_err_probe(dev, ret, "Failed to attach =
power domains\n");
> > +
> > +             plat_dat->clks_config =3D ethqos_pd_clks_config;
> > +             plat_dat->serdes_powerup =3D qcom_ethqos_pd_serdes_poweru=
p;
> > +             plat_dat->serdes_powerdown =3D qcom_ethqos_pd_serdes_powe=
rdown;
> > +             plat_dat->exit =3D qcom_ethqos_pd_exit;
>
> Hi Bartosz,
>
> It seems that the intention of this is to ensure
> that domains turned on by qcom_ethqos_pd_init()
> are turned off again on exit or clean-up in error paths.
>
> > +             plat_dat->init =3D qcom_ethqos_pd_init;
> > +             plat_dat->clk_ptp_rate =3D pm_data->clk_ptp_rate;
> > +
> > +             ret =3D qcom_ethqos_pd_init(pdev, ethqos);
> > +             if (ret)
> > +                     return ret;
>
> And here those domains are turned on.
>
> > +
> > +             ret =3D qcom_ethqos_domain_on(ethqos, ETHQOS_PD_SERDES);
> > +             if (ret)
>
> But it seems that if we reach this error path then the cleanup is not
> performed. This is because plat_dat and thus it's exit callback are
> registered until the call to devm_stmmac_pltfr_probe() towards the end of
> this function.

We can only reach this if devm_stmmac_pltfr_probe() fails. Yeah it
probably warrants a devres action.

Bartosz

