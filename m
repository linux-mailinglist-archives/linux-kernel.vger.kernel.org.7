Return-Path: <linux-kernel+bounces-781942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBCFB318F0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE6B1CC48EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DC62FC01D;
	Fri, 22 Aug 2025 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvX/B2sg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6892FB600
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868157; cv=none; b=J16Kr1YQv+6lhuSkzV27W3t24LJFh2++8TtMwLMknilnDM1ZGVzImlSXnF7WN5zQW3LkEt37XFJ35+D+gQeGp6rz9qH1h4931EZuV39yX7LH/J74EM66JQzEGwhfr+btcQD2tqAFzoDr70ET2vE2B8148PR2GcrtCL/F1FJ7c3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868157; c=relaxed/simple;
	bh=O0asdK8SeOVtorPLNtX9IHFVw5PwpWz+Y/IXMS4KmCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTtf8BmbsHg7nD2bz0RV0ClNvgMhkwNdTYBGNxcHOibceZ8A48IInzpKK8zG2R4UX8C+EtLHyVewZq5D9Snp3PQ2BQoqghYyE+XnPVwMWZxwKOmahm7IX5q+ilc4KuxmiNTpQGQXQJ4qGPHAnVNoA/oVSXECelGXRQIp4r6sYnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvX/B2sg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755868154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a26YwWriI/cAZNSFk7MZK1EJDFmLtTh5uMUvUQRBu1c=;
	b=dvX/B2sgVlZySMIlGcvJxowKE7/OILbkA9Q0VHTynR50RQmO+WXlaGRbVXBeskVfHkR20S
	x7bxmbHCy9ZgeDB1FO+Yr1Zlz3J/8xQp1NM488bZm0m9mmbdBWMtzmp3GSCPfGQ4RMjVhD
	UplyDEbchy9pcLZseG341WVGjzONYds=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-pFFOs2CvNLy1VXsDqEIKzA-1; Fri, 22 Aug 2025 09:09:13 -0400
X-MC-Unique: pFFOs2CvNLy1VXsDqEIKzA-1
X-Mimecast-MFC-AGG-ID: pFFOs2CvNLy1VXsDqEIKzA_1755868153
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e8704e0264so566710285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755868153; x=1756472953;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a26YwWriI/cAZNSFk7MZK1EJDFmLtTh5uMUvUQRBu1c=;
        b=XB5CAXQtYWVMWgJGqpR0Ey6cfwswY/qeD2wK2UiQvj6oyvXbLjq6O7W3tGUlzXG0PY
         rlLlT+7qVe8IxcKLqHzQjPZyr5766G+aD1Clzt9X9hSRJ2y27T4g7nE9JxeSqyk6V0Bh
         o3nCKAY4xRjLh0x3C5mQgb4JNmrGCHG84BfoPzoKnIc12atTRWyvcXFfPfWAaiBD1nb6
         OJL9T4+wEnlg0P7+WipGKqA8T+quFVuQGB3H0e1ujz37cHJxWP5DNKndW6Bq64NV2L9x
         NEY0WHqaRoV0uK8rslLqBx2xuZ04taeghl1QcgU6Fon3Y2Cm0xJS72km7qViCX+BVBHT
         EY+g==
X-Forwarded-Encrypted: i=1; AJvYcCWXTZxLYjjl9IllSFISJZvd7rOoeRYMGq1YARW6bHSJbuIt/AiNhfbp5PFCWscOYf7a15xwqqxdsE0oVsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcbuGyr33by3v1CCHfWBdNinF9tCWE0OeukGQn3jM0g4mLDVId
	usR97H7+hSmCFGH7Vp/BmGD8HUf7ZR8KdaSxHnViBOGJQXN1g7JT6ASsIQLe72Nkx9Jr8oYm9/r
	OoGLhkTNxhD3stBGQtL1Y5VHruYJvzH1sgSLeS5ZAPaQ1P6Fibl/lv6c2bNWOKT/5qg==
X-Gm-Gg: ASbGncupk7Wi5AmYvBs+WZnu2JtUPiaXqANi3iJ3Io9uPxh0xTA3tF8T9qYkrqohEGX
	wRGisL0G6D3sthlevBC31ESg/ksJbi3UHztWTPQdjlsXvtcc5C6Ihy03W9nXNo7DUP4TuiZlWEP
	NGd7dziAgfVAtr6RY8aPSpteydG3lYj3XyDy1uS0ufQpQ47XdK6pcoBEewZeiIOJ/wfyklExyZ/
	TMmx7Fs2gevypWxfqC2PdOqFYPoomCX7DumDTBTrILXOmmzgJMpZtNGhDDzkZ6FFJpZl4yLRUP8
	Ee1vOlByNrZgADMVI5hlibvydbIE7N1nvcpAcisWjQrF4uj8UnJJ7pRkfWPWv8+0Ace5I5ME0pE
	YLACpOa8j+UVu6A1wMSs=
X-Received: by 2002:a05:620a:6cc2:b0:7e3:6a01:e6ba with SMTP id af79cd13be357-7ea10f538ddmr299221185a.8.1755868152197;
        Fri, 22 Aug 2025 06:09:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW1uvjDvOlgb0eZoGZSzJHV+ZTat1aB9dEJTqNDB/h4VuJNJ3Q109+V4G1CkIe7Ilb4zQPqA==
X-Received: by 2002:a05:620a:6cc2:b0:7e3:6a01:e6ba with SMTP id af79cd13be357-7ea10f538ddmr299210885a.8.1755868151398;
        Fri, 22 Aug 2025 06:09:11 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1c9b9dsm1332247685a.70.2025.08.22.06.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:09:10 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:09:04 -0400
From: Brian Masney <bmasney@redhat.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Paul Cercueil <paul@crapouillou.net>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Yixun Lan <dlan@gentoo.org>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com, Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Michal Simek <michal.simek@amd.com>,
	Maxime Ripard <mripard@kernel.org>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Qin Jian <qinjian@cqplus1.com>, Viresh Kumar <vireshk@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Alex Helms <alexander.helms.jy@renesas.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	sophgo@lists.linux.dev, linux-mips@vger.kernel.org,
	imx@lists.linux.dev, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
	patches@opensource.cirrus.com, linux-actions@lists.infradead.org,
	asahi@lists.linux.dev, linux-mediatek@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, soc@lists.linux.dev
Subject: Re: [PATCH 000/114] clk: convert drivers from deprecated
 round_rate() to determine_rate()
Message-ID: <aKhr8NYhei59At0s@x1>
References: <20250811-clk-for-stephen-round-rate-v1-0-b3bf97b038dc@redhat.com>
 <1907e1c7-2b15-4729-8497-a7e6f0526366@kernel.org>
 <aKhVVJPEPxCoKKjI@x1>
 <4d31df9e-62c9-4988-9301-2911ff7de229@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d31df9e-62c9-4988-9301-2911ff7de229@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Fri, Aug 22, 2025 at 02:23:50PM +0200, Krzysztof Kozlowski wrote:
> On 22/08/2025 13:32, Brian Masney wrote:
> > 7 of the 114 patches in this series needs a v2 with a minor fix. I see
> > several paths forward to merging this. It's ultimately up to Stephen how
> > he wants to proceed.
> > 
> > - I send Stephen a PULL request with all of these patches with the minor
> >   cleanups to the 7 patches. Depending on the timing, Stephen can merge
> >   the other work first, and I deal with cleaning up the merge conflicts.
> >   Or he can if he prefers to instead.
> > 
> > - Stephen applies everyone else's work first to his tree, and then the
> >   good 107 patches in this series. He skips anything that doesn't apply
> >   due to other people's work and I follow up with a smaller series.
> 
> Both cause cross tree merge conflicts. Anyway, please document clearly
> the dependencies between patches.

This series only touches drivers/clk, so it shouldn't cause any issues
with other subsystems, unless there's a topic branch somewhere, or I'm
missing something?

There are some drivers under drivers/clk/ where there is an entry in the
MAINTAINERS file that's not Stephen, although it wasn't clear to me if
all of those people will send PULL requests to Stephen. I described on
the cover how how the series was broken up.

  - Patches 4-70 are for drivers where there is no clk submaintainer
  - Patches 71-110 are for drivers where this is an entry in MAINTAINERS
    (for drivers/clk)

For the clk subdirectories that had say more than 3 patches, I sent
those off as separate patch series. The ones in this series have an
entry in MAINTAINERS only have a few patches for each maintainer.

As for patch dependencies, patches 111 (clk/divider) and
114 (clk/fixed-factor) should go in last. It doesn't matter the order
everything else goes in.

Brian


