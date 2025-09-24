Return-Path: <linux-kernel+bounces-830573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD60BB9A018
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746B92A42C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31B82FC012;
	Wed, 24 Sep 2025 13:19:26 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9947F2D541B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719966; cv=none; b=lj52SBjiJO5QG0w3Kew2pVk4IjlYOlb9zVGxYlzwQ/IxcqnGY7+zUGSO02mGM7cYhb2razBHANJersD+syd/13k5qQur+5wmHEQ6p1ismZqqlYKgPjAgARy8AmqxbkDT5paXeAKD0Ec9abPfcKRFEZLVO2NLLHkat2Tsm6i3Wb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719966; c=relaxed/simple;
	bh=z/C4wkQC8gaVbvYtfUOzohgsubPk5RoreYsa0amGnQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JiiTUbeBBo6IkfHJKiVgzK8UFB53o0YEaWqwk+uiWCYXTw2YoE780o5CryesrlhNiCr1VyBSe6d8Smo4Q97AxYR8/FlkRs0fuzCUuI00I8WCauzRxXPNXkFpzTwKf5mg/ys1t4XXHMcM/iyBD37UJ/cpMKTtUtiN70ex+bnz0kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2445806e03cso89094405ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758719963; x=1759324763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tIlYzxGhD3l9eBjwM++AWTKEOipfMDPpBnbYVK8JQsQ=;
        b=YU7GZMp+oQaDK1XugBdJdWdkCydpDCpsK8KIL3f7p7r3Rq0Pzdessqf9hFIpusr025
         wDRrY1tVuLWViTW3xvRU231CJ5+O5MeNyGT8GO2+gjGsjFz6oyhOHuS3GGfUt39Sicnt
         9zHNbSQ6IZW7jdrqfg+kADIZXWI7oEBOlHPij3IeetoLqrqi5+BuOFbSpWCwJzeq88uk
         m9oH8P25dgKIdKWWVfWZDSwhPl609fwkClhjAF6BCG6mFF6fQ82hv0nPZYflnV0nm4ZU
         0M2UNLLij2Iagzy0OPbcEOknWygDgzVwhXBsjxh5UwCboMabOVfZZlHolMlo4O6Rn/8Q
         8Yug==
X-Forwarded-Encrypted: i=1; AJvYcCWAtr2jzK3nWM4FXqcte93hUUAvDJ3zjfzqVKptzDNyBaSpN0ghiyiYi1oevcM/lTQ8HlaUnD1mdKfqvbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBQMgsgaQDGSJsRIbrQl2EmI9GO898+C5589GZQk9EgS34VUb5
	XpJpPqBKJUUfsW4noxvweAtfwbxlFeOPGRWJHh39xAVl1vpxm6OdVb//8Cpl4Qa+
X-Gm-Gg: ASbGnctZBm6D4fxQu3GKyEWafjUTjQPD6SA1TejTLieF/fd5HdjgSXdnkxe45ILJrVK
	TgxNizyntrA+xtTt3ilGPiYqx7wpGDvND9uHi/gcEbnFItG0zOl3UcYjQvT+yW1iqfU1d55nFm0
	p8YPC7LzvveG+fT+omzQVMgSExau022mkXp68nFAt7K+YpicYRJPg6vibxhNrEVpzlxjqCekq0l
	RmLUvuuTtcxxtKt2sq5LK765iINIWnnrqApSxmHfUd69KCdbn86oL9Hn3ULK5GGbY4/QXfV/RYp
	XUjXanCAQoJDeNVEleb53xAdYZN6kdWjslKpnMOeEhyGkQlfQQFGofFi8z5Gt8R4Yzf+OuUaSus
	fdjbp6kbuGEYc+TuuUT3rxgO1JAAfE2uD5IiwatX6cpu+a1kVmqh3t31iM1bWH96d
X-Google-Smtp-Source: AGHT+IGIc/5EP8Nd2Afd3tOQFvfLlxRTUQitQMc2enRdTKW5CTHrmcS6Yc4HzNTyKXacib/+tNY4Sw==
X-Received: by 2002:a17:903:196b:b0:24e:e5c9:ecfd with SMTP id d9443c01a7336-27cc79c8a81mr72702345ad.42.1758719963534;
        Wed, 24 Sep 2025 06:19:23 -0700 (PDT)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com. [209.85.210.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551b31ebb2sm14160988a12.6.2025.09.24.06.19.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 06:19:23 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77d94c6562fso6818480b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:19:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXaBOjb+7f0lTe9gLptWkDIDqoJmVABcoowE3II6BIU9gla+w8xVf/mUy895aEdSXUy+qpTCrS2rn9Yrig=@vger.kernel.org
X-Received: by 2002:a05:6102:4426:b0:5a1:17e3:ea9d with SMTP id
 ada2fe7eead31-5a578c96363mr2082608137.25.1758719489139; Wed, 24 Sep 2025
 06:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903161718.180488-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20250903161718.180488-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20250903161718.180488-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 15:11:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUT2Nv9cEw1VsSeRQfNsK7-CxWqDN+S=Txkv6DXMDdCOQ@mail.gmail.com>
X-Gm-Features: AS18NWB3LiRE7h2GD3dAO4aR_IhRpZe13Ufoocoh6CaSUdYv9A8x5d9icvSRroc
Message-ID: <CAMuHMdUT2Nv9cEw1VsSeRQfNsK7-CxWqDN+S=Txkv6DXMDdCOQ@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] drm: renesas: rz-du: mipi_dsi: Add support for
 RZ/V2H(P) SoC
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
> Add MIPI DSI support for the Renesas RZ/V2H(P) SoC. Compared to the
> RZ/G2L family, the RZ/V2H(P) requires dedicated D-PHY PLL programming,
> different clock configuration, and additional timing parameter handling.
> The driver introduces lookup tables and helpers for D-PHY timings
> (TCLK*, THS*, TLPX, and ULPS exit) as specified in the RZ/V2H(P) hardware
> manual. ULPS exit timing depends on the LPCLK rate and is now handled
> explicitly.
>
> The implementation also adds support for 16 bpp RGB format, updates the
> clock setup path to use the RZ/V2H PLL divider limits, and provides new
> .dphy_init, .dphy_conf_clks, and .dphy_startup_late_init callbacks to
> match the RZ/V2H sequence.
>
> With these changes, the RZ/V2H(P) can operate the MIPI DSI interface in
> compliance with its hardware specification while retaining support for
> existing RZ/G2L platforms.
>
> Co-developed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c

> +/**
> + * rzv2h_dphy_find_timings_val - Find timing parameter value from lookup tables
> + * @freq: Input frequency in Hz
> + * @index: Index to select timing parameter table (see enum rzv2h_dsi_timing_idx)
> + *
> + * Selects the timing table for the requested parameter, finds the
> + * frequency range entry and returns the register value to program:
> + *
> + *   register_value = timings->base_value + table_index
> + *
> + * Note: frequency table entries are stored as small integers (units of 10):
> + *       threshold_in_hz = (unsigned long)table_entry * 10 * MEGA
> + *
> + * Return: timing register value to be programmed into hardware
> + */
> +static u16 rzv2h_dphy_find_timings_val(unsigned long freq, u8 index)
> +{
> +       const struct rzv2h_mipi_dsi_timings *timings;
> +       u16 i;
> +
> +       /* Get the timing table structure for the requested parameter */
> +       timings = &rzv2h_dsi_timings_tables[index];
> +
> +       /*
> +        * Search through frequency table to find appropriate range
> +        * timings->hsfreq[i] contains frequency values from HW manual
> +        * Convert to Hz by multiplying by 10 * MEGA.
> +        */
> +       for (i = 0; i < timings->len; i++) {
> +               unsigned long hsfreq = timings->hsfreq[i] * 10 * MEGA;
> +
> +               if (freq <= hsfreq)
> +                       break;
> +       }
> +
> +       /* If frequency exceeds table range, use the last entry */
> +       if (i == timings->len)
> +               i--;
> +
> +       /*
> +        * Calculate final register value:
> +        * - timings->base_value: base value for this timing parameter
> +        * - i: index into frequency table (0-based)
> +        * Combined they give the exact register value to program
> +        */
> +       return timings->base_value + i;
> +};

Unneeded semicolon.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

