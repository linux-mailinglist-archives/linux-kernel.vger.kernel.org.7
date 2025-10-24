Return-Path: <linux-kernel+bounces-868569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD0CC05849
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E736A3AE2A9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E63930E0FD;
	Fri, 24 Oct 2025 10:08:47 +0000 (UTC)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDE91624C5
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761300526; cv=none; b=c9s7O5ziFhZlb8XyBiwYstqDVM7ZXTSJkFcDzDb4KPI8/W1vVIImCSUp7v+Y4XfFHtzDPtpFMTzfexAWGEvsRzBn5LEqSPQgkPQPnEb+mnpqcu1bUk+z632+nlIFByAOJQaMel5vNWxoLyvfJgHQnpFWmPe1ElVdkpc3aoiUQB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761300526; c=relaxed/simple;
	bh=elTVsWdrRVyZXb9CeT0gn7vy7OzlSmdqPnuj0bdN97A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZCaF5XGOUxeMy48rCQMdethDcn1c++/xNvzzZlDA7IG39C80Z6Cf6Qs1zVSVKIjRSArf4HK+ReOqWsWJpshwbAzYueKbKgfkwfzV7F0CIDKNsYV9Zn1VRfmH6hfoAxR0Ad7BDrM2IfpMQKOkHk9FjWkqLUm594/k00424xMmf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-89019079fbeso713743241.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761300523; x=1761905323;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUKThFRYge9/VpHdBSfe3W40P3TpedrdMNHqtfWCInw=;
        b=NKtLLc1Wpk1QbTk+uoZAWljn4SJAPi0uieAQu84wqgf8Ml9+wOUHrrIhV3+QvM1DT2
         NmL9k09l15uUj8x+5nmge7LwLgmoNGoznlEdAh5X9sn4Dl1UFK7IA+TGPd2gw6D3GdP8
         fb4tJlQuC21vP0DcAwO2qnR0VPz0fJJbZ/MkzpXJjz+xQZm5DQ2ZV08ByTD3u0pcKZmX
         oodReTJsEDOc+m2/CWWpZyYXh0vFU3Jg4Xyoa+wD/Yh/lrW8nPjL/hVGfKqTcU+9Od8H
         eWnZ3qWyjrpRSLqcf83sKRYPSH3U2qyTMW7F9FkorB8e528wG10nKdxoOk8YhE9mmDhz
         EpeA==
X-Forwarded-Encrypted: i=1; AJvYcCUSNMaZ9+b5LBFdz7P/6fV1n+WmQhAP3TYHkBoKwAe8YUHMRfPDr2j3fLBm7FnmVzBM4BbIOF0gMJAgGfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf4iWXF02eQkvdZBe90y8eADnVFYKjpnQJfUau3TTs9uHF+qQ1
	7fDybD4T/dwuRsGOTZCQ1P+X4yJRDJ4Jy8IWIYV64epXMR7C58XPsXGYWRbRdrWi
X-Gm-Gg: ASbGncsqABubDABb8F+6GaPnmXavLkWSSfj1cfE9WzaKjtf3+53LaTOhnL/97YvmBha
	uJd7euUaYP2UDcL8IRHuul795RLVnFcuQ9AQOe6NrSRymqgCQaF/FT7XmYlDL9H/B2vcJLQM5Te
	hK844zr6ohTBvOJoSfQ0Rb4pa5hj5z0iPQRSzYMZLxmmacYWZpXqyUZTP/8taviwITcWUTmjpYy
	swq8CqVLqCMZwM/JBwNd4qCkGhRFkPRnMlrHBIqCgfBa4R/WYCyBw6+Tdi4SbP1UhtNd5OZk1C1
	8YY5eqYxG4OHwpPx3Kptzu+069pxGLfH0zF5uXPk2lGoMxvCXemCDOEUEYYuXK1kYNG1cV4XhqU
	pbP7nJnqSnq7HpemxaeeBQA683sfV0LM+Vc+gNvp6sVKxOaZ1+bhE3Bq6gUwyZe/1btzqOIkouA
	cxFd/h0tkU/e86HIQboL53hNQ6YkLIbtIqt0vvnQUr9IFBxMdW
X-Google-Smtp-Source: AGHT+IEt/X+B+eImOnLA2co+rNWiwPRBSHcS1gIoJYLopXuF2xeAp8Y3awDSzFvQA6taOC3wgVaxjA==
X-Received: by 2002:a05:6122:8d4:b0:54a:71f6:900f with SMTP id 71dfb90a1353d-5564eca636emr7702251e0c.0.1761300523532;
        Fri, 24 Oct 2025 03:08:43 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557bdbb82f4sm1780728e0c.15.2025.10.24.03.08.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 03:08:41 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5d758dba570so1354553137.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:08:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTSNbMOB3ggAoQXFEe4RDhI8J+gvaMdeZSXSIoYUIAuECamHirrlYm9dknbDeSJTWb4AxcgxvAZHQjAa8=@vger.kernel.org
X-Received: by 2002:a05:6102:4496:b0:5db:2715:d01c with SMTP id
 ada2fe7eead31-5db2715d982mr2364430137.10.1761300521275; Fri, 24 Oct 2025
 03:08:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014151325.160062-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251014151325.160062-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251014151325.160062-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Oct 2025 12:08:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXU_aOg+bfRBJ7UOQW59QUxqa4a7WXTj27RyCyiNHV8qA@mail.gmail.com>
X-Gm-Features: AS18NWDbAhl5j_H8OBpJGyjSPEBVaeQiqbN7vBJIAehOjNFs55YsioHkWFr2qYM
Message-ID: <CAMuHMdXU_aOg+bfRBJ7UOQW59QUxqa4a7WXTj27RyCyiNHV8qA@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: renesas: r9a09g077: Add xSPI core and module clocks
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Tue, 14 Oct 2025 at 17:13, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add module and core clocks used by xSPI (Expanded SPI) IP on the
> R9A09G077 SoC.
>
> The xSPI block uses PCLKH as its bus clock, while the operation clock
> (XSPI_CLKn) is derived from PLL4. To support this, define new selectors
> and dividers (FSELXSPI0/1 and DIVSEL_XSPI0/1) in SCKCR.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/r9a09g077-cpg.c
> +++ b/drivers/clk/renesas/r9a09g077-cpg.c

> @@ -105,6 +113,15 @@ static const struct clk_div_table dtable_1_2[] = {
>         {0, 0},
>  };
>
> +static const struct clk_div_table dtable_6_8_16_32_64[] = {
> +       {6, 64},
> +       {5, 32},
> +       {4, 16},
> +       {3, 8},
> +       {2, 6},
> +       {0, 0},
> +};
> +
>  static const struct clk_div_table dtable_24_25_30_32[] = {
>         {0, 32},
>         {1, 30},
> @@ -119,6 +136,7 @@ static const char * const sel_clk_pll0[] = { ".loco", ".pll0" };
>  static const char * const sel_clk_pll1[] = { ".loco", ".pll1" };
>  static const char * const sel_clk_pll2[] = { ".loco", ".pll2" };
>  static const char * const sel_clk_pll4[] = { ".loco", ".pll4" };
> +static const char * const sel_clk_pll4d1_div3_div4[] = { ".pll4d1_div3", ".pll4d1_div4" };
>
>  static const struct cpg_core_clk r9a09g077_core_clks[] __initconst = {
>         /* External Clock Inputs */
> @@ -154,6 +172,15 @@ static const struct cpg_core_clk r9a09g077_core_clks[] __initconst = {
>         DEF_DIV(".sci5async", CLK_SCI5ASYNC, CLK_PLL4D1, DIVSCI5ASYNC,
>                 dtable_24_25_30_32),
>
> +       DEF_FIXED(".pll4d1_div3", CLK_PLL4D1_DIV3, CLK_PLL4D1, 3, 1),
> +       DEF_FIXED(".pll4d1_div4", CLK_PLL4D1_DIV4, CLK_PLL4D1, 4, 1),
> +       DEF_MUX(".divselxspi0", CLK_DIVSELXSPI0_SCKCR, DIVSEL_XSPI0,
> +               sel_clk_pll4d1_div3_div4,
> +               ARRAY_SIZE(sel_clk_pll4d1_div3_div4), CLK_MUX_HIWORD_MASK),
> +       DEF_MUX(".divselxspi1", CLK_DIVSELXSPI1_SCKCR, DIVSEL_XSPI1,
> +               sel_clk_pll4d1_div3_div4,
> +               ARRAY_SIZE(sel_clk_pll4d1_div3_div4), CLK_MUX_HIWORD_MASK),
> +
>         /* Core output clk */
>         DEF_DIV("CA55C0", R9A09G077_CLK_CA55C0, CLK_SEL_CLK_PLL0, DIVCA55C0,
>                 dtable_1_2),
> @@ -178,9 +205,15 @@ static const struct cpg_core_clk r9a09g077_core_clks[] __initconst = {
>         DEF_FIXED("ETCLKC", R9A09G077_ETCLKC, CLK_SEL_CLK_PLL1, 10, 1),
>         DEF_FIXED("ETCLKD", R9A09G077_ETCLKD, CLK_SEL_CLK_PLL1, 20, 1),
>         DEF_FIXED("ETCLKE", R9A09G077_ETCLKE, CLK_SEL_CLK_PLL1, 40, 1),
> +       DEF_DIV("XSPI_CLK0", R9A09G077_XSPI_CLK0, CLK_DIVSELXSPI0_SCKCR,
> +               FSELXSPI0, dtable_6_8_16_32_64),
> +       DEF_DIV("XSPI_CLK1", R9A09G077_XSPI_CLK1, CLK_DIVSELXSPI1_SCKCR,
> +               FSELXSPI1, dtable_6_8_16_32_64),
>  };

Perhaps we need a custom clock for this?
According to Section 7.3.1 "SCKCR : System Clock Control Register",
some divider combinations are prohibited:
  - 4 x 6,
  - 4 x 32,
  - 4 x 64.
The last two are probably not an issue iff the xSPI driver never tries
to set the corresponding clock rates.
However, the first one may be an issue, as both 3 x 8 (valid) and 4 x 6
(prohibited) yield the same resulting divider, and I believe we cannot
be sure the clock core will never pick the prohibited combination.

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

