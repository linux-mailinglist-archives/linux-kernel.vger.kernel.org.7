Return-Path: <linux-kernel+bounces-850684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FFDBD380B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55BF3B7D96
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478781D8E01;
	Mon, 13 Oct 2025 14:27:11 +0000 (UTC)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2091A19E97A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760365630; cv=none; b=JW0No7vm8WFgXv2JUvmZrP+QX6+4yA1inf1glQ0Mqb1cCD45yfKHFJ8MGdnV4q5p0L2KCUcpdzbD8gprury3jA/yP3JGGTppfisxj9LJ2bn8+iduCjeaTnxzxQIXI5Sn1Y1Fe+I8bhaFTZACfO7uw11fC8cQmln/l/X6+oEpARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760365630; c=relaxed/simple;
	bh=zlA57FXRk3iS29Kzv4WEft+U6fVs9xyP1OQ8Cp0Brq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAtr591XDWvYMJ2fGN0yH0mEUn4D3DwUUw10G0HaFqiVpKkE6ORDc0PcKSVDyhbGvAn0gfSne5pBqCAPK50lb+SBu+WQWtFToIvIG5IrLJdOykv8w8Q5yUlmzbXCrFwbYOGYqcPYuilfuGP5t9If7zIvI6OMs0Od/Tm40lPARMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-54aa0792200so3096265e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760365628; x=1760970428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wM5BKo03UXTKAaO0inlA90fZOzSgvU3v+GhQ9ytzuNM=;
        b=j0rilndMCv5PN7O+PgUD/ZQ8OZKk3JH4zZB50lyMKTwXd4Dm8rZH98XCTAbjuXBztq
         I5grqjUvMOaSdMIuWUZnDNi1pTnYbITESkPS5qbim/1Kdwr1YChxangmzjph7g9cQhmN
         OOCdsi+0zPoqRBJkWLm9VliyuM5+AkpmKlJUeF6MOW0VR6lK1IhXfL+u75GbqTkvQH2R
         cQUo53m/Z7RExoHTZu4lE64JWBVvEaUvQDGmWCANrXJEjtdEX5RudZDplMl2HSLy3hdm
         HBI0H8OMNMdvX5iN6J2YnmcM1XQrKyl8NZj9sXYVNfiTMlgEdmvmu3bLZs9d8mts7A72
         hN0A==
X-Forwarded-Encrypted: i=1; AJvYcCXAOoX0Vh7XJXr9NSKfpgWPC2gmnVU/cW0CEOdXirpiSYgQJZl/ngp17mQtAplJHeBH0Z/tpeDw/EeZ8Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYGf8IRyh40bzGoJI5FmbNZaaOSl4/DISoFQxRZB1EWF8SmsHA
	rK2qxQzt0eUpNEqkq8Df/Fx+zCzrKMi4Ia/XrfDrEGuFk58dqRxWRBkj4ddlJjoT
X-Gm-Gg: ASbGncv0JLkK3zqVfSwQsUhDgJ3iCRwaM19JDQjSFO+f+pw+Ha1KV5ufVKjVYDAPrAR
	A3uiZofl1e54r0QH1aDMhX4BVyqyJCihzcTrBMVNFnInFTLbBVBcms7C0U9vefZ+GrOW2R2n7sD
	6VW/pZebQQlQiNChR3e5j0uIKj5jh05fhIImeSGezjtuaAkF/VM9Isk0hCrkoVkjsgixgGQuj70
	uWmzvN0du0jTaEBK9Lb5mpfp1oR9O9JyBY2afulxKPVsPjQb4VF733F3ShtO8Iz5hk/Ec0jD4Bp
	8/q9jhWToHXWitFaWQRiTB56GH/HnjIHubgDNxxasJzDkL3FV7bItVcQ6zIknYvGxwR+v91tfNi
	AUUbEEXKY73SJqe2J4Em5v3y+RIfDNFfmNRhJh1Az5RAAASAmH6rE+Ss0yLMyIpjx4ZghK+/hY8
	Idc3TE4OP6JYV1Sg==
X-Google-Smtp-Source: AGHT+IEcUNKrRxYGoJixaJTg13kv2IBHlTzGN3cY/CrURFa81HB72ijmITxjek49SmkWHxuxnVLSgA==
X-Received: by 2002:a05:6122:1d02:b0:54a:721a:608f with SMTP id 71dfb90a1353d-554b8a84b11mr7544201e0c.3.1760365627873;
        Mon, 13 Oct 2025 07:27:07 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d81148c6sm3096228e0c.26.2025.10.13.07.27.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 07:27:07 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-8e2e9192a0aso2627952241.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:27:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtc/GnqCQNz88KwkW59RLv35Fio4NoM2/0F93eEa4nzysqyCMi3HUY9KCZl1vJhZcDO2XTZdLkCIURakE=@vger.kernel.org
X-Received: by 2002:a05:6102:512b:b0:5d3:ff01:363d with SMTP id
 ada2fe7eead31-5d5e2323bc3mr8711756137.21.1760365279124; Mon, 13 Oct 2025
 07:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009160732.1623262-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251009160732.1623262-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251009160732.1623262-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Oct 2025 16:21:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV2-YrktT+=D2LVFw5oR+6EOLcPB_Yuh5wnos099W9YHQ@mail.gmail.com>
X-Gm-Features: AS18NWACXzl9qHe2hLpg2jHp4NfY_rtfyBAoBdwcOf1UGmjWi7aFUHns305Ee_M
Message-ID: <CAMuHMdV2-YrktT+=D2LVFw5oR+6EOLcPB_Yuh5wnos099W9YHQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/6] clk: renesas: rzv2h-cpg: Add support for DSI clocks
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, 
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Magnus Damm <magnus.damm@gmail.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Oct 2025 at 18:07, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add support for PLLDSI and its post-dividers to the RZ/V2H CPG driver and
> export a set of helper APIs to allow other consumers (notably the DSI
> driver) to compute and select PLL parameter combinations.
>
> Introduce per-PLL-DSI state in the CPG private structure and implement
> clk ops and registration for PLLDSI and PLLDSI divider clocks. Implement
> rzv2h_cpg_plldsi_determine_rate and rzv2h_cpg_plldsi_set_rate to drive
> PLL programming via the new per-PLL state and add a plldsi divider clk
> with determine/set/recalc operations that cooperate with the PLL
> algorithm.
>
> Centralize PLL parameter types and limits by moving definitions into a
> shared header (include/linux/clk/renesas.h). Add struct rzv2h_pll_limits,
> struct rzv2h_pll_pars and struct rzv2h_pll_div_pars, plus the
> RZV2H_CPG_PLL_DSI_LIMITS() macro to declare DSI PLL limits.
>
> Provide two exported helper functions, rzv2h_get_pll_pars() and
> rzv2h_get_pll_divs_pars(), that perform iterative searches over PLL
> parameters (M, K, P, S) and optional post-dividers to find the best (or
> exact) match for a requested frequency. Export these helpers in the
> "RZV2H_CPG" namespace for use by external drivers.
>
> This change centralizes DSI PLL rate selection logic, prevents duplicate
> implementations in multiple drivers, and enables the DSI driver to
> request accurate PLL rates and program the hardware consistently.
>
> Co-developed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v9->v10:
> - Dropped rzv2h_get_pll_div_pars() helper and opencoded instead.
> - Dropped rzv2h_get_pll_dtable_pars() helper and opencoded instead.
> - Added dummy helpers rzv2h_get_pll_pars() and rzv2h_get_pll_divs_pars()
>   in renesas.h for !CONFIG_CLK_RZV2H case.
> - Updated commit message.

Thanks for the update!

> --- a/drivers/clk/renesas/rzv2h-cpg.c
> +++ b/drivers/clk/renesas/rzv2h-cpg.c

> +static int rzv2h_cpg_plldsi_div_determine_rate(struct clk_hw *hw,
> +                                              struct clk_rate_request *req)
> +{
> +       struct rzv2h_plldsi_div_clk *dsi_div = to_plldsi_div_clk(hw);
> +       struct pll_clk *pll_clk = to_pll(clk_hw_get_parent(hw));
> +       struct rzv2h_cpg_priv *priv = dsi_div->priv;
> +       u8 table[RZV2H_MAX_DIV_TABLES] = { 0 };
> +       struct rzv2h_pll_div_pars *dsi_params;
> +       struct rzv2h_pll_dsi_info *dsi_info;
> +       const struct clk_div_table *div;
> +       u64 rate_millihz;
> +       unsigned int i;
> +
> +       dsi_info = &priv->pll_dsi_info[pll_clk->pll.instance];
> +       dsi_params = &dsi_info->pll_dsi_parameters;
> +
> +       rate_millihz = mul_u32_u32(req->rate, MILLI);
> +       if (rate_millihz == dsi_params->div.error_millihz + dsi_params->div.freq_millihz)
> +               goto exit_determine_rate;
> +
> +       div = dsi_div->dtable;

This belongs inside the for-initializer below.

> +       i = 0;

Ditto; or better: in the variable declaration at the top of the function.

> +       for (; div->div; div++) {
> +               if (i >= RZV2H_MAX_DIV_TABLES)
> +                       return -EINVAL;
> +               table[i++] = div->div;
> +       }
> +
> +       if (!rzv2h_get_pll_divs_pars(dsi_info->pll_dsi_limits, dsi_params, table, i,
> +                                    rate_millihz)) {
> +               dev_err(priv->dev, "failed to determine rate for req->rate: %lu\n",
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
> +}

The rest LGTM, so with the above fixed, and the field changes factored
out into a separate patch:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

