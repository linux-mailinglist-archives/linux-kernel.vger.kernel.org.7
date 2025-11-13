Return-Path: <linux-kernel+bounces-899421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A72C57ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D1764E72F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0731E1A3D;
	Thu, 13 Nov 2025 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RLf5/szz"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA9917DFE7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040698; cv=none; b=rl/CfCdBTjllr06pA8R1pG8oPyJJlnrMBtml2H8nV0+E+RDxFjdw0bPJW+u3d7mIW7sS7sRieVnogHjpurZg/lt1ek2ofyqyagT+RaB8SZMxqqhN9i6/r2DL9/P2CXLk80BzunUrlFUKRNhSlZvx0fRK0vTWIr7/xNVx8Ybm+D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040698; c=relaxed/simple;
	bh=ozyIZ+DRAXgcmWNPabI3QVCnzbiWETR79BPnKWOg1ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHPSqlLJxwGug9fgCgkwnsBLQfCp6LL6AHfFQCsZj5jna6ePPrnzF8XwjLd7+Si7i9dpXj6C4PbrFVbIdUZNXjwkA09+cTKenlxXHevkTQTy40v48DBZhwV3gb9F9RP0ZGLJ46h0W0DBj6aK86TYL5Z8wcPt9esyxWF03HQNzuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RLf5/szz; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-595819064cdso743305e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763040694; x=1763645494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73kr7nUrOWZMw2Xrq3JK7B68+7C7ERu+i4U/2oSeqZY=;
        b=RLf5/szzPsqFeDCV3opzXWfb0Ldojdtec8pQE3xNDEhETeIs/yOkZbdXLVp4EEkrIZ
         QpfBvawPoegB/EtYhzVvIJ/MrYSSmoZu+Gf9comaIWAEujb8gSPYXnUf8geDlOoaVqcw
         8H+HesTJqMQZgCfvj7IxVvMtG8EcJGGB1sXixe4YycCb8i6CeKb9120eRoL00JKYeeTv
         42bNPTNAZwbL3pvkZthRqGeGKSWfFpRIosZE8uJJtkg/JFfBsc8A4GoG43jnXGFqGPrW
         4SbyByIn6hDOGX77lIH0wiTKLqhsSS2rxX7EKezvibn4f8vmrDs+Xx1Ka9R7u7nhY3yM
         yXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763040694; x=1763645494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=73kr7nUrOWZMw2Xrq3JK7B68+7C7ERu+i4U/2oSeqZY=;
        b=s8dW/Y84dla1xj7GR83d1JbBrI/gPFf0jrCYAZd0xVPJHk4rTkP3jPVGnQrcMVXAfo
         GRzTfE9nvU5fUqq/rXQ8aBZqScwzPfdXmsA7wfx5J/eeAPC2tpRg6oAtuTep62PPVXpu
         peL6XqvSZaHFNTBfZlu68MVbTmKEY7B7Z3KYaKTWDm8LXjhdeZIsopfRbp/gy0SRW5OJ
         B8tuhAgcNsAGiDWmo5QingTqUKplO5hVNJZoetobUQysVrlaBio8+n0XX5Iy5rnG0uoF
         9XxjJojqst8TF5IpcXA0OvP+2uPr4TTyOE7oyb14Is0Hqxzn46NaqfEkc5d6JMV/VLqZ
         gsBg==
X-Forwarded-Encrypted: i=1; AJvYcCXXkkTurIvO4NXFseE2V9/mZX4AzodhdFkoHpQac0oA2sRepUYszavpMY6jvE7dB6ABbE5k8jhKwjr9Ch8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNnJiwj4Vmp5K9wpWvh2s5a8dWGmvuM4Ybv9gcegC5xv7SA9UX
	pTyIIkC05BT80DWLg4LVB7G/uPLqMB6jKCB+07f9zSZ9vIa9+9OT0LQktfQSkNXbb2r72g4ScBN
	Y7loZwRm5gTm9+S95xRkBDRxaaQgc34vl0IaOu+0wkw==
X-Gm-Gg: ASbGncuq6kqA9Zq/CfX+db8jfzRUl2spN2ZJCY2yl8D5aYdsb56sML0hyy22/J9H88+
	cgl4JT3/1CIWbAB7Dc8dyeOr2Y6wj/a5r0oJCaLcV6SBZvvjRkCgUOTKI/Te2ViOCSgsx3pkdNL
	uP3pucmnsFQoxlZi4TrOtnjveroOzSTdEROYjKs6FB+1/J5s9UE1cKIwSRoC/y6cJYjpnToIKGL
	V4tPVHr5HFYDWZk4Lz7THVPbgW3EMFxaVIrxov7eIjXL5qjjURG0ECZWjhCDRv9ay0sBZg/iYtG
	FpJymSIGHOraB+Sj
X-Google-Smtp-Source: AGHT+IFmYGYaNrPxFWU0ghXUofhzNye14/5vushtgIFDWSfgA/MklzOW/JNoBE9rLO+zgbK8iJzH+WbW5agg2UGK7Co=
X-Received: by 2002:a05:6512:144d:20b0:595:7b24:d352 with SMTP id
 2adb3069b0e04-5957ececb1fmr730185e87.24.1763040694032; Thu, 13 Nov 2025
 05:31:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107-qcom-sa8255p-emac-v5-0-01d3e3aaf388@linaro.org>
 <20251107-qcom-sa8255p-emac-v5-3-01d3e3aaf388@linaro.org> <9805b902-95bb-4b18-b65f-f6efdfb6807a@oss.qualcomm.com>
In-Reply-To: <9805b902-95bb-4b18-b65f-f6efdfb6807a@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 13 Nov 2025 14:31:22 +0100
X-Gm-Features: AWmQ_bmfo87z1zTXv8LP-M-WOLEoIFCS2S60P9_2zq_qXBjBuZTULdbiMAAMcS0
Message-ID: <CAMRc=MdWu5x5bgh4CfPsowJnF0Qh1W770KTDtTFMkGkQf4_LKg@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] net: stmmac: qcom-ethqos: improve typing in devres callback
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

On Fri, Nov 7, 2025 at 11:50=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 11/7/25 11:29 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > It's bad practice to just directly pass void pointers to functions whic=
h
> > expect concrete types. Make it more clear what type ethqos_clks_config(=
)
> > expects.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/=
drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > index 8578a2df8cf0d1d8808bcf7e7b57c93eb14c87db..8493131ca32f5c6ca7e1654=
da0bbf4ffa1eefa4e 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > @@ -726,7 +726,9 @@ static int ethqos_clks_config(void *priv, bool enab=
led)
> >
> >  static void ethqos_clks_disable(void *data)
> >  {
> > -     ethqos_clks_config(data, false);
> > +     struct qcom_ethqos *ethqos =3D data;
> > +
> > +     ethqos_clks_config(ethqos, false);
>
> ethqos_clks_config() takes a voidptr too
>
> Konrad

Right. I think I had something in mind when I wrote it but I'm not
sure what anymore. Best drop this.

Bart

