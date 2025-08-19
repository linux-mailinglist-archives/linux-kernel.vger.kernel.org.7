Return-Path: <linux-kernel+bounces-775316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3273B2BDD7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B6C685CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E1B31A057;
	Tue, 19 Aug 2025 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zmi1XXK4"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EED319864
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596807; cv=none; b=DJlQ3wV/GQNuG+vOavQ+EpuPUA4g9+ctG7vKoznJkh//g9BnQFMzZ8l7f7y+r06QMmYy9Tlt4qPAOTPyyNksYQ8y3lxkyiph7MIBSyfcjr2a0CMcQRe1/nh4Wr0OElj/1Db4BpP3/WUaM8TNvtcPNz/I1ppy7pPF17MOIKRvRQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596807; c=relaxed/simple;
	bh=CnJekPM0wQKG9e7pS0aBHZul0jrDqWHtRHfFM2JeVrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t51xBGCmVMT25SLgUptIpZ5ywaksR0640xlM35hAHQPHIPTqyKK30R2rREkgrdrN1Rpa0atjtcNsPXqBnXUtyR7NSnEK2uYwBK5Apopj6sEENiIz0l8PD+DDitm39w+6F10RgrQzdkwpABQPMKBQ2Irw+xuT6VNeVA1k7wo+xrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zmi1XXK4; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55ce509127bso3967192e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755596803; x=1756201603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnJekPM0wQKG9e7pS0aBHZul0jrDqWHtRHfFM2JeVrQ=;
        b=Zmi1XXK4wKmRuynbrwT8fn72i6E5QZzEJ6LCdcveQ4hFn9whcKtHfr87ay8H4Y+9KV
         lng10Yu1G/9gConL0pN/9mlwVgCgz//l3Px/GwqISBFVaAR93O6sOLumX9p01ykV25TX
         NYzgrhIuOGKm1/dSx6jB33sij3qY19lEC4qaBVyBFx2H9c1CVtmU1IO3I+JGAQR/syBW
         V4nHpsU1JTUQgDv9K65CovKkelbqDhfscqVbIucyf4TQVtHBUgNIefr4QDVOOlThsH4o
         QD/zEu919Zitm4lEL3BSv7hjdX0YxJzt7L6f5y6HkhgmSxUNLcq51f8vAlc+yCO31urf
         rPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596803; x=1756201603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnJekPM0wQKG9e7pS0aBHZul0jrDqWHtRHfFM2JeVrQ=;
        b=X5q/cpyFQDH4EBOyIQqaJfS5nszJGPwRC6Xf4BTK40X//ZFCOMZwS3ZCbNJh7gcH3V
         NdwAYni71sBPCovIgGd+lX2U7rQm5SBI/lslECpgOHUk8GP5C25tKgzJa2/Hs89u7nma
         12ri8Awbsh+JpttNx1Ii59DAxqAPXhYngZE1fkv0ROTxn88R15Dtj4hYid5FqI7I+T7L
         GZsP0E7sEyrZ3YcQ5bqjvfK8BGwo3pAhdv7Wlob0YSfjeUnLBXcsWS+9UyYrhcUdfOtg
         MIS3w6rPAiO6CCGZrK5/BggaxlLNrHHme7ujU3plwv/17HB0iU/aI0/WGJgkxDh+hx/K
         LlRA==
X-Forwarded-Encrypted: i=1; AJvYcCXEjSArS4uP7IjzgpESDtTN1UVpkyU1SF+qpJnlYA+8fqwWYzSKre8dBgE8kq5ADK/XqGgTt2gXzi/Rtuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyskQlufTIWAAeSw0wXX2YEVxT7uNmlGqEalXxyp24rbTUTdTds
	2N5gb+WG+BXh3m2Qp8U6XM4nVrZsAoh9rz2X5+g26qTnIefgNiLSAV901jSebyVYKGJUDj4WGXy
	yilffKDOyfMLGjaYw0WPaen76hdoxEOzaEz290cckNg==
X-Gm-Gg: ASbGnctzZq+9PMByM8fLEiVaNWtw8b0Mz2BELgdvttzjgvCXHiUDwaUMIlCMaCy7hS6
	wPLzrSSax/OLbW2kdLpBbi/JJk49JPCfFTZ7MOjmRhRRPYNXbi3pdh4mbgvIJg4WYM820XT9Xxw
	CNgx/qx/jCrpPNAZuKLEZ2oUYkheRgYVyoI8ucRJI+FX8OD9SuRpkFgyKXaf1hIuuwYP82yoFQ8
	QsQzJ4=
X-Google-Smtp-Source: AGHT+IEnhi69VygT7g84GFEWBMGYd/u/z/IkVXlUwHEo4DfM7Y7k8WnKy5jP9SBDHCTX2vCUgNODYTsIltctm9ywUhA=
X-Received: by 2002:a05:6512:61d4:20b0:55c:c9d5:d337 with SMTP id
 2adb3069b0e04-55e007aecbfmr398443e87.24.1755596802917; Tue, 19 Aug 2025
 02:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-clk-for-stephen-round-rate-v1-0-b3bf97b038dc@redhat.com> <20250811-clk-for-stephen-round-rate-v1-16-b3bf97b038dc@redhat.com>
In-Reply-To: <20250811-clk-for-stephen-round-rate-v1-16-b3bf97b038dc@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 11:46:31 +0200
X-Gm-Features: Ac12FXzd6X-i_It645W5rQicFyi-TYZe6vnFChkDKrkqPz2wrPccuV5zYO_EO9M
Message-ID: <CACRpkdaeF5VueC44jQZzdJjVJXj2F7cDsOzb6aa6bHLgQJXS7Q@mail.gmail.com>
Subject: Re: [PATCH 016/114] clk: gemini: convert from round_rate() to determine_rate()
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

On Mon, Aug 11, 2025 at 5:18=E2=80=AFPM Brian Masney via B4 Relay
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

