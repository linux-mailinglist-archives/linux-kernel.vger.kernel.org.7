Return-Path: <linux-kernel+bounces-775318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73103B2BDDF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D441964758
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A55431CA4B;
	Tue, 19 Aug 2025 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7CjSAxR"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A6531A057
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596857; cv=none; b=TpdZDgP7sbNLyFUla+ozUbmLZE4/wO3p2EZPIFo9zmJtowTW2crDA5O0Qvf9IhkMNl+uX/9z4ODuABecm8h1s8atLNyVkuS28e95sSCA0HFtSxZzd1m2RIJT6sj7ctqOV2OlZ0VI+Ds0JgjtJxvZvuCJaKKJ+VGzvLrW13mrGRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596857; c=relaxed/simple;
	bh=RdTVW2acL3x4TY+q3fiwzcKJmZ14PXDkj8EpJokxAbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTScIt6X2K7YyF8OZaI2ozD+sE1PCiaoJvTW3YtnPe3TJDiTSCcDqrkWK+jmdrf3/ZekllmTkUA6+u/tnDeQX8Uh+JKy8ZyMp6nVCQUGaK84LVviR3khTQ6tD3gTvp9cRnkbYboNeMIGw71JmNyLro8+RZB8L8JdSX+uQJKEm14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R7CjSAxR; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-333f92cb94eso39493321fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755596853; x=1756201653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdTVW2acL3x4TY+q3fiwzcKJmZ14PXDkj8EpJokxAbo=;
        b=R7CjSAxR0SKigMJF92+IG4arICNf+bYM3a0PT09TwwgVJ0fevbid0lUF4QIKu0/Q5P
         9AGRr/VuxpP6G32aKpi5VYR1rPmsiIMgJs0dR7kCQIBHGhnAx+TdNuH595f0SwLn5djq
         MtQnoZ6pYNnm/ZrC+uSGQKTaRRblyN9rrvOhIVSCBPRdEiBU9BGuSW/4B29ph7ZbBCOO
         1NejzfzXWfxmF5cHj+JBVt23PyBejugUsJUM2RQvXU8GQs1ms3DNgVxpaIHM/POISiNs
         DOfkqdTUMMwXzsG3IcNKjz6sCXRQwSbriB2JC8dRDOkzt0jqWQKnL0mbTZMoMCbTv+34
         t5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596853; x=1756201653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdTVW2acL3x4TY+q3fiwzcKJmZ14PXDkj8EpJokxAbo=;
        b=ilKh3fPH3IvtMprcmvGjCt4eKm7mQ470Obz3jbqBNsYkUCFNTyNUmvG2zXh91ZpmDb
         Ix7Jv+CJ1OfG2ecpUt/QSh3zncizJJSqM59aXNQRxTGYC25LiDTWeaQcHlI7QlY1JhAM
         B5eu0Jv6ea0sdXXDKdOBbxR5026zGTfQWjeOhKJVCksms3fhLtgekLmoMjb8y56SJnnG
         wyrA6guGCcB71FFAOBxN+sqxiQCOVQFm/s8XJbbc9HMovMk4uvcNGutSSbu59C2SnHMO
         d8etervjqguP8VrMMFfFXz4QTMuXBrYaR/s52MQ05bhjJP3Svu1CdF+fmmifHVkGMp1A
         WMZA==
X-Forwarded-Encrypted: i=1; AJvYcCXsy4xoS1eIW1Bqdb7cuxdmINLwPTyjfKdteI/+6ygTdUeJJpWB/EkzJYPOg6oT+nClnmd8uJjOjUdm6OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIWblv4sNukr/aN6lnO0dEz6f2X1rBX3+3CxZKTRYn7U0AFJjZ
	0HPl2YOApsHFYVDLyixLSSwO2T3xYqkbU1ZIsGUC6UgHdX41juYexMgun4LUkAz4tYv7u+dk/O7
	a6MjClEIWWd544hC+kvbtvrIWZZZGIU2a7HctQOuqFw==
X-Gm-Gg: ASbGncvNsLgsM42tkbwDL6ACsdGbaBzwCIhtzXluiZGVWSw7SkCY/pIzpzJUETLAolf
	Bt6aSLUAYbWz/73dIRMp6A2IG4zNel76+l5AhMaXtmqd+BKyYyg+JR5t9vIQGHf2GgyWVh1Ujst
	LqESc66xmzUpk/lY9y3z42JuB3RDJq9hY1Itd+ZtE9ZS2y2777LQg5qBW8017IhKWTdWHKtiXML
	QbvDBCVtaEG
X-Google-Smtp-Source: AGHT+IFaAkF1r4GWgj+j3Xeyk0sBgHgQuFXAyBRPToaJvqEtDi6Qt1cFt8RtILv6l5mltG8+0huqL2sCrZ81MI3EBAM=
X-Received: by 2002:a05:651c:b2c:b0:333:ad0c:a44e with SMTP id
 38308e7fff4ca-335305347dbmr5252501fa.7.1755596852940; Tue, 19 Aug 2025
 02:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-clk-for-stephen-round-rate-v1-0-b3bf97b038dc@redhat.com> <20250811-clk-for-stephen-round-rate-v1-105-b3bf97b038dc@redhat.com>
In-Reply-To: <20250811-clk-for-stephen-round-rate-v1-105-b3bf97b038dc@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 11:47:21 +0200
X-Gm-Features: Ac12FXwQ8ZNlahHw5FRReJn3coSNBp0waFbtb0dR-jKWl_cQ9vhC2BCpFgBry0M
Message-ID: <CACRpkdZ3M65bKzaHcKPRhEFCy+TvHUq8bZ-8Zr_7HSRKsk_TWQ@mail.gmail.com>
Subject: Re: [PATCH 105/114] clk: ux500: prcmu: convert from round_rate() to determine_rate()
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
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Daniel Palmer <daniel@thingy.jp>, 
	Romain Perier <romain.perier@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Heiko Stuebner <heiko@sntech.de>, 
	Andrea della Porta <andrea.porta@suse.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Qin Jian <qinjian@cqplus1.com>, 
	Viresh Kumar <vireshk@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Alex Helms <alexander.helms.jy@renesas.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
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
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:19=E2=80=AFPM Brian Masney via B4 Relay
<devnull+bmasney.redhat.com@kernel.org> wrote:

> From: Brian Masney <bmasney@redhat.com>
>
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
>
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

