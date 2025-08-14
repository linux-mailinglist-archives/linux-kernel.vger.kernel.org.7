Return-Path: <linux-kernel+bounces-767919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E89B25A88
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13ED71C208A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA114202990;
	Thu, 14 Aug 2025 04:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="kfBrl5m3"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53AE204598
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 04:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755146152; cv=none; b=klaYU+RaInCShT6fQsjKagE8j//FbSxmneacNVTwLWxkA0ikG+wI+9qa3n8+zuTG/Pxql485xPJfdNoLeJjdmCd+uJ/RDK2qPPT99pGoAVWMvyNhWwiNc2rwRaq1e5jAtHwK1TpiEjwhDc/ivaY7o/8/2o7IpcK1+vS2zsZQDUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755146152; c=relaxed/simple;
	bh=QGb/WSxQrkoalS0PQR6chjMqXIC8l1e9Dtd3KAUUo7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQcPfmvrLxtWka4jxabHX6tpq1TTFLpYdumO9Nl+fS18ChKU2Lkdw6nSlI34Z6JYONCxosLfdqwPYaFoVWd4fpz9r0IRzVYX+APNIa8M+/3pqUm5tOJgAu97ARvlD9v7+O3krxMa7mMMtH2ZwNHRRE+8HpnT0IHY+PTl0qBEkis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=kfBrl5m3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-323267b98a4so546146a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1755146148; x=1755750948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W68wJmIpwZKYrhZj9rQMZlkUfiQu51PmIXBdt9PMw2k=;
        b=kfBrl5m3X3pUKzeASIa5uThvSEb/zB82C2JruDgTOivhhSjhUjMBmcPL8IhJVxAjVG
         6qON9Ajt9fHHBWQKEfYsoV1u4jSeEE0qNkZh6VuTz41gtP/7s1I8dBc/NuAwLu/lt9KT
         CKKBnN/q50LzlMJEeWPS0cO85J+8t6tbmlZGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755146148; x=1755750948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W68wJmIpwZKYrhZj9rQMZlkUfiQu51PmIXBdt9PMw2k=;
        b=agY6C347sQ77XwLKGX0pnwHVa9GfOUIliR8Om2nWJBjjXA6lFH+1s5x17pWtPFESou
         0faK/sjUEoips33w7nU5bhjkuEPtHzvFUkJL4nR1FgeJSVf4I+pp4Da1GZMz1mny6U/y
         yyD0RjPlGLw4sXzt92dVOdfMNhldP8nSb7m4Ub/MOFEU+srQBoexmnRR4d4LiiNchkd9
         UfNuhniGUfsQlv1TzzWC6G1zeo9+Zi9PYasicxwK2zRi7/oWazky5F7wss6eXTS5G1z2
         5g7t9ItGNQ8HfS3wWY6p/49hFu3aOES31zzFRBktZ5FOz61Kn1FCoGmdLF3tdr6uNOCj
         YRAw==
X-Forwarded-Encrypted: i=1; AJvYcCVYJjARTe0Oxcz+1v6WFEB+enkVhNqeT5cCu5nM0vIkLWds474sZytg6u/sxWhtk1wQ+Xxp8wkKLMRmEBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa2nmZjRVJFwfLctO1FO6Ph7VX2p862ghVryGOXxaaotA9VQeW
	V0B3Qolb/7beVxzSMx3qgPaATBs9naucGeov7f3zTyNoSZVb+sWH/JE92KaH/yK1dRYsiGNAhAT
	Q6Q2qal2O7aMkR31dCgr65FFZp97Zwc0eeyQnfcAnOA==
X-Gm-Gg: ASbGncvP3x6jQVFZldNA6KVJtiRLIM9hhXjnMhPPUyIO+i/J43awtrMdXGM6DMjlhj2
	2X1eVpwjdGr+EKNqxMrBw0WoHAIikCjvEcRF/mEGdV3gaAvXhv090Iy1muhRVqSe/o22lcVBevA
	19iweTBcc7E0DCKtSklt+pYOAzTlFxqQwTftgnDK9lAOEeFsk6OdGTmKtM8A3w5CQ89uihVG52M
	iIfdkYF90aH
X-Google-Smtp-Source: AGHT+IFjwIWeQGe9GR6r4b2M90JJvm8sY4wwHgdbP9dAwNnEibxW+RtNYUEdWU1EXNpbiBYlhjSbLxcOxiikHu61EP4=
X-Received: by 2002:a17:90b:58e7:b0:31f:6682:bd28 with SMTP id
 98e67ed59e1d1-32327a52880mr2616043a91.16.1755146147789; Wed, 13 Aug 2025
 21:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-clk-for-stephen-round-rate-v1-0-b3bf97b038dc@redhat.com> <20250811-clk-for-stephen-round-rate-v1-84-b3bf97b038dc@redhat.com>
In-Reply-To: <20250811-clk-for-stephen-round-rate-v1-84-b3bf97b038dc@redhat.com>
From: Daniel Palmer <daniel@thingy.jp>
Date: Thu, 14 Aug 2025 13:35:36 +0900
X-Gm-Features: Ac12FXxr3rvVXpJVntmlzZatJLppeB52b6KjThcDVumW6l6FaIvxvyr3Ex-UBYM
Message-ID: <CAFr9PXn=jJPKzMcTa-TJSNuNQknauEttNZg=jV3sBwkTYqxLcw@mail.gmail.com>
Subject: Re: [PATCH 084/114] clk: mstar: msc313-cpupll: convert from
 round_rate() to determine_rate()
To: bmasney@redhat.com
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Paul Cercueil <paul@crapouillou.net>, Keguang Zhang <keguang.zhang@gmail.com>, 
	Taichi Sugaya <sugaya.taichi@socionext.com>, Takao Orito <orito.takao@socionext.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	Vladimir Zapolskiy <vz@mleia.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Yixun Lan <dlan@gentoo.org>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Michal Simek <michal.simek@amd.com>, 
	Maxime Ripard <mripard@kernel.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <mani@kernel.org>, Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Romain Perier <romain.perier@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Heiko Stuebner <heiko@sntech.de>, 
	Andrea della Porta <andrea.porta@suse.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Qin Jian <qinjian@cqplus1.com>, 
	Viresh Kumar <vireshk@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Alex Helms <alexander.helms.jy@renesas.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, sophgo@lists.linux.dev, 
	linux-mips@vger.kernel.org, imx@lists.linux.dev, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, patches@opensource.cirrus.com, 
	linux-actions@lists.infradead.org, asahi@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, soc@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Brian,

On Tue, 12 Aug 2025 at 00:18, Brian Masney via B4 Relay
<devnull+bmasney.redhat.com@kernel.org> wrote:
>
> From: Brian Masney <bmasney@redhat.com>
>
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
>
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/clk/mstar/clk-msc313-cpupll.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/mstar/clk-msc313-cpupll.c b/drivers/clk/mstar/clk-msc313-cpupll.c
> index a93e2dba09d3523199263494efd2bf6987bb4156..3e643be02fe2a79c043c1b79a5e95c869b757ba1 100644
> --- a/drivers/clk/mstar/clk-msc313-cpupll.c
> +++ b/drivers/clk/mstar/clk-msc313-cpupll.c
> @@ -140,20 +140,22 @@ static unsigned long msc313_cpupll_recalc_rate(struct clk_hw *hw, unsigned long
>                                              parent_rate);
>  }
>
> -static long msc313_cpupll_round_rate(struct clk_hw *hw, unsigned long rate,
> -                                    unsigned long *parent_rate)
> +static int msc313_cpupll_determine_rate(struct clk_hw *hw,
> +                                       struct clk_rate_request *req)
>  {
> -       u32 reg = msc313_cpupll_regforfrequecy(rate, *parent_rate);
> -       long rounded = msc313_cpupll_frequencyforreg(reg, *parent_rate);
> +       u32 reg = msc313_cpupll_regforfrequecy(req->rate, req->best_parent_rate);
> +       long rounded = msc313_cpupll_frequencyforreg(reg, req->best_parent_rate);
>
>         /*
>          * This is my poor attempt at making sure the resulting
>          * rate doesn't overshoot the requested rate.
>          */
> -       for (; rounded >= rate && reg > 0; reg--)
> -               rounded = msc313_cpupll_frequencyforreg(reg, *parent_rate);
> +       for (; rounded >= req->rate && reg > 0; reg--)
> +               rounded = msc313_cpupll_frequencyforreg(reg, req->best_parent_rate);
>
> -       return rounded;
> +       req->rate = rounded;
> +
> +       return 0;
>  }
>
>  static int msc313_cpupll_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long parent_rate)
> @@ -168,7 +170,7 @@ static int msc313_cpupll_set_rate(struct clk_hw *hw, unsigned long rate, unsigne
>
>  static const struct clk_ops msc313_cpupll_ops = {
>         .recalc_rate    = msc313_cpupll_recalc_rate,
> -       .round_rate     = msc313_cpupll_round_rate,
> +       .determine_rate = msc313_cpupll_determine_rate,
>         .set_rate       = msc313_cpupll_set_rate,
>  };
>
>
> --
> 2.50.1
>
>

Only visually inspected but seems correct.

Reviewed-by: Daniel Palmer <daniel@thingy.jp>

Thanks,

Daniel

