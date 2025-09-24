Return-Path: <linux-kernel+bounces-830554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40695B99F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF960380EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA67A2FD1A5;
	Wed, 24 Sep 2025 13:05:36 +0000 (UTC)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5672E4241
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719136; cv=none; b=a6hS0tr+RDudra0wu7ew4BsE0kClkQq64hbaMI6b+J4CyDrGseF+H5XRt1zRaqJ/O389vavaQ3G/r6TzJzIvDmVatfgGsSPGmyJW84sBVdea/OyWK9NZd+BqdQpRGJsVlWFmO0ubQjprbR4o8AFo1vM3Vh1eacRwHJvjua67VRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719136; c=relaxed/simple;
	bh=5CKhCzt8uwTRTXN1dt78wJGzG2xEgCNEZ1R79yBCn7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZo/XiuhGPMSnN//2ahYljOrlr9022q+pyb+maDCRCuUgPMSwyMC3u540iGS0g8WK7BnWjJZUn8Xg+eBTZx6q26efH1m+y++ReCVfhkv2snGqypneyQlyUph2RYUueus6uy4u852wQ3Z8e3v6mE0g8wgC6Iv6RffUU7LXIL9KEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ea3dbcc5410so4858034276.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758719133; x=1759323933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dt3FE+JEfBgU4GvIduSmfD+mr673puEsHTiT0sBkYwI=;
        b=liQGlFAsEKtXQAJ6RKSOM3qtG6PX+m1LHE1aYoRK9K04t/6z1A6QsQshg8x9RD8qPg
         yHZeHf6ap69jgj5hBIGShP+ZIJAAp3c1JOas2J1NU2tiWwq12uBjMGG9bVOo17g1IvKk
         6s3BRqtr9BXOk8f20iHIisMd8i3Pvzd/9KiEVQijG+WmJhjaI0178yXZqY8s5OtSO3mx
         U7yvixg4Pq2hPW5R50Vs3nE6T3iSdsq6ds6DCgbz9JrSqr8stbPoHmync718KPf0BDCh
         CA1E1nBfGrTEK+MC0SYjyOHLnO4/b1qcU2AiStiI/cH+tS0czb5Qm+wkdhX4Qzgq0AY3
         SwfA==
X-Forwarded-Encrypted: i=1; AJvYcCVqNn/fW4ztBxkyI1m22rAeWQnp4tYoBXHpTHhp0dryQjqlUFFXKIO2V1olwOP3GiKxw7Ji6z69MoytDNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7aRidq312UW8hT/C3wZ9LtjdEo+JxsEhciOp8Jtjo+wuQtH6q
	2X6259Ggx3aGdTeB8f7RDVMGsIaFKa4WwuW4GTf8p2EOm1fEQFXo/gSkS1Erkt9G
X-Gm-Gg: ASbGncvTnNHAsK8O40xOXJQYnAjb3lC2RX+6bEtvHqWSD+wg+RtvmIqu7HEKrS2fzuL
	3dKfRD3eZet3/FCcaP2qU2v7fazj3qmMcQpk9DNxcGF25XuvC0o92Pru0AxdFV2NUHgi0qJk4SY
	z0UQ1fUndyEwlD45rdSo8dVHCHBAEuYHeZ1uZYaX5KtgNjQxt63OmA9Tc/tVvWKmHwzXMmYx/1s
	4BQ922pZG9yyBotRpgz0vQmdvpQYxrYgVWEBOfIdQl6D07n+t7ualZVt5eOsTt7EOxWnYRcPE9Q
	+56CfcLAaXdzQ5aarpMF2wYq3stOrP5/4GdISuU4bAi4NJcB8dTmjd0tx47gg+z+kkIv8GcuIxn
	mL7mZvPGmt/ogB2Cl2m5DhKOeuAkIFMrJFr7j1vRfBNm+0s4xf8+fIC7YJKAs
X-Google-Smtp-Source: AGHT+IG1jXj9WOpZKP5A98dBgWUSDwFpTndbNqwRMq+kEEUzVOIbtYIm48ChlrMGy1eaw/7Py1DEUQ==
X-Received: by 2002:a05:6902:4a82:b0:eb0:2379:5412 with SMTP id 3f1490d57ef6-eb32de6397cmr4887767276.10.1758719133274;
        Wed, 24 Sep 2025 06:05:33 -0700 (PDT)
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com. [74.125.224.53])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-eb374757c48sm483690276.16.2025.09.24.06.05.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 06:05:31 -0700 (PDT)
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-635283199a9so1808331d50.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:05:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/63JWmiiQWANitdAzYzGnu/6uHX2m6OAJQnC9anjStrcOj3KT5NljHvQzw2xZ/HxRW84dLCahRZq1IH0=@vger.kernel.org
X-Received: by 2002:a05:690e:2593:b0:5fc:53ab:a49c with SMTP id
 956f58d0204a3-636045f7a94mr3388326d50.11.1758719130471; Wed, 24 Sep 2025
 06:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903161718.180488-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20250903161718.180488-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20250903161718.180488-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 15:05:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUacF5UfiLTXuWOXAZZvEJ-St5+awkWML_HDp9b38=sXw@mail.gmail.com>
X-Gm-Features: AS18NWC94EGYcxjMXs4Deenf7S5F9QjlUjLF0OPIzRnfMxCF0EhsIC5PeV3xDXg
Message-ID: <CAMuHMdUacF5UfiLTXuWOXAZZvEJ-St5+awkWML_HDp9b38=sXw@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] clk: renesas: rzv2h-cpg: Add support for DSI clocks
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Magnus Damm <magnus.damm@gmail.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Wed, 3 Sept 2025 at 18:17, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add support for PLLDSI and PLLDSI divider clocks.
>
> Introduce the `renesas-rzv2h-cpg-pll.h` header to centralize and share
> PLLDSI related data structures, limits, and algorithms between the
> RZ/V2H(P) CPG and DSI drivers.
>
> The DSI PLL is functionally similar to the CPG's PLLDSI, but has slightly
> different parameter limits and omits the programmable divider present in
> CPG. To ensure precise frequency calculations, especially for milliHz-level
> accuracy needed by the DSI driver, the shared algorithm allows both drivers
> to compute PLL parameters consistently using the same logic and input
> clock.
>
> Co-developed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/clk/renesas/rzv2h-cpg.c
> +++ b/drivers/clk/renesas/rzv2h-cpg.c

> +static int rzv2h_cpg_plldsi_div_determine_rate(struct clk_hw *hw,
> +                                              struct clk_rate_request *req)
> +{
> +       struct rzv2h_plldsi_div_clk *dsi_div = to_plldsi_div_clk(hw);
> +       struct pll_clk *pll_clk = to_pll(clk_hw_get_parent(hw));
> +       struct rzv2h_cpg_priv *priv = dsi_div->priv;
> +       struct rzv2h_pll_div_pars *dsi_params;
> +       struct rzv2h_pll_dsi_info *dsi_info;
> +       u64 rate_millihz;
> +
> +       dsi_info = &priv->pll_dsi_info[pll_clk->pll.instance];
> +       dsi_params = &dsi_info->pll_dsi_parameters;
> +
> +       rate_millihz = mul_u32_u32(req->rate, MILLI);
> +       if (rate_millihz == dsi_params->div.error_millihz + dsi_params->div.freq_millihz)
> +               goto exit_determine_rate;
> +
> +       if (!rzv2h_get_pll_dtable_pars(dsi_info->pll_dsi_limits, dsi_params, dsi_div->dtable,
> +                                      rate_millihz)) {
> +               dev_err(priv->dev,
> +                       "failed to determine rate for req->rate: %lu\n",
> +                       req->rate);
> +               return -EINVAL;
> +       }
> +
> +exit_determine_rate:
> +       req->rate = DIV_ROUND_CLOSEST_ULL(dsi_params->div.freq_millihz, MILLI);
> +       req->best_parent_rate = req->rate * dsi_params->div.divider_value;
> +       dsi_info->req_pll_dsi_rate = req->best_parent_rate;
> +
> +       return 0;
> +};

Unneeded semicolon (there are three more below).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

