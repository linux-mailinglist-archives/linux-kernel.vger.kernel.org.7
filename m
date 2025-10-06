Return-Path: <linux-kernel+bounces-842968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B81BBBE178
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7FC18970C6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4EB281371;
	Mon,  6 Oct 2025 12:49:45 +0000 (UTC)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841EB278E5D
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759754985; cv=none; b=k5l8mU8EW/bWBcmdbkGXzixI427tXIHiO6xN3Xrrax8XC0UfEpyJ8hLKEjk5Vrj2aqG68FiHfgytf1oZFibbIXBINEq5676CG4wPm+8IdUXNdCIUi7bdg64Fz6RAGKDm5J4uYyXRqMTYK8Ky4lfis2dEV/Ay2BhNFkC9kXCsdh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759754985; c=relaxed/simple;
	bh=W/ngLzzEijzJIH8PvuzO5TM2e6lsyzUmai6PG+VNePA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEduLPPLPFiddQOWkWq9v9xUmys1atvv/vyKsk5vPcKlAhIlDykXRHmzPyRaoXPfGKwXRt0PkLS+Dbz2GZq6PGu7OI3SZZaDusJkJKxFNrPi3r7hRIM361dyVUF4xT6H/HAgTqf967ZSMmKeOtPAlpEyvmirBptUoDH+gaEKI1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-54aa0792200so3716153e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 05:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759754982; x=1760359782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OwPjpMz/0J4A8goGwBvaeTijAxI7KyJ1C6GbFZyEwbs=;
        b=dYMDsAEuyOvjuS+U/kiv2+DKStlSL1iQ4tn6DjljAP9CnlJx3r/tsQpN0ke03K1cFh
         j5OF9+C4Mc1pNzqrYW5I65RfLquCF4gcHJepD9iAfk69hRvrnzfxuhHfkYrWxh66BHcH
         NDYG44rBOAgftvXw1EudQBXEwZxYqt5RVlRRY8BJdRjW/wlGhLwfgY0A4H9iUhypmdCA
         ykmE0RQT//Ii9A4uTYj4V5ki09tJjDp5Er8kjUbNlVRGM0HozqdaqzlO6J2aDl4y5e8H
         K0Oo7mH4l7oaXHDtbYhLmGjjKRJRQu4/B8e+rvmCpqnQGOYJbo9SICRDgYbr07es+7gI
         Qpdw==
X-Forwarded-Encrypted: i=1; AJvYcCU6ucV9YGA4mOQfrJ/zlUWoTiTqLi89HkKew6939mL7StcmCyhxiCZFbpoFbfl523IDr+rFI8R7REnEGN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaEI/NZFNuJIZk6wX+MXPJnQPN4vXWwnM9ZGmZxU/cMgZeooxm
	plZX0S6XnEBsx/wZSXKbNh23QmQfrTrnx7KJx+H5uiSJiDGu1g9Y/v0PS1B278dV
X-Gm-Gg: ASbGncupc8R2f5C6nVd62j7Wm8Os3666LNY2nOlHiQZMbFDZ2dbg31PWaU1ny26wcxl
	uyBlXWio6Kpt0m4aUvw+LbhQJ83yPHsjCt+SRIZWTdMgPyq8BaG0d1yvHjN2eY0uz1x6TgfiMSP
	hyGPpdRyjrut+6vvV+YOHRQh2tJ5ITQBFrHlzcvjD1XnwsB8jTZ16iBVBq8xspjL00Uz9HvNXvd
	ZFCPAkZEqT33YYUNeaqHFuEIVoH4vFMwsx3ChzPNSx/k91cQPg2nOYQvilUh7ItWORtJkwCrmuB
	a08ycQkW6crkM6iiwhBDdIa3zV7vrWpJ9JfW7hdizT9xO/3Zax5Eb7mFeNtft5h22HbNFhIS1Ul
	7ii6TYU+XD/+7N2UjVa/L+w45j0Ag8coTAX916gxeLAlRrlViHOMsyMgw0soAYXLrnb2ZIio5cY
	bCjQ8FO6m7
X-Google-Smtp-Source: AGHT+IEYpaAeiibyNu5uXhlugGzMszid4B4Pkh1knogZLBAQHpARyo8y5CCbD4guO6wVDurReQoBQQ==
X-Received: by 2002:a05:6122:208d:b0:54a:a30e:188a with SMTP id 71dfb90a1353d-5524eaa38f9mr4548790e0c.14.1759754982159;
        Mon, 06 Oct 2025 05:49:42 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb4f08a7fsm2970616241.17.2025.10.06.05.49.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 05:49:41 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5a0d17db499so4683417137.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 05:49:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQnwdJTmcfGu1zbFn1PZooiEcjaH6c7gzZKZHL2q5JqYq2zSxhcSji9HmjcWPCjbm8efOrLOeQfbhXvUA=@vger.kernel.org
X-Received: by 2002:a05:6102:1620:b0:520:c4ea:4bcd with SMTP id
 ada2fe7eead31-5d41d055f58mr4323006137.9.1759754980548; Mon, 06 Oct 2025
 05:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002161728.186024-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251002161728.186024-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251002161728.186024-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Oct 2025 14:49:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUugFOOvHqjRyoPErh6rqpVuAS_Yr6mGqerKT0VQ-Y6KQ@mail.gmail.com>
X-Gm-Features: AS18NWBb9B-DekEKpQfUFSovMcE6-nb-Pn4OxZ0U_p0Jp7pux_ucj5r-aIzp9-s
Message-ID: <CAMuHMdUugFOOvHqjRyoPErh6rqpVuAS_Yr6mGqerKT0VQ-Y6KQ@mail.gmail.com>
Subject: Re: [PATCH v9 6/6] drm: renesas: rz-du: mipi_dsi: Add support for
 RZ/V2H(P) SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
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

On Thu, 2 Oct 2025 at 18:17, Prabhakar <prabhakar.csengg@gmail.com> wrote:
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
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> ---
> v8->v9:
> - Updated Kconfig to select CLK_RZV2H
> - Updated to use renesas.h
> - Added reviewed-by tag from Tomi

Thanks for the update!

> --- a/drivers/gpu/drm/renesas/rz-du/Kconfig
> +++ b/drivers/gpu/drm/renesas/rz-du/Kconfig
> @@ -19,6 +19,7 @@ config DRM_RZG2L_USE_MIPI_DSI
>         depends on DRM_BRIDGE && OF
>         depends on DRM_RZG2L_DU || COMPILE_TEST
>         default DRM_RZG2L_DU
> +       select CLK_RZV2H

As the kernel test robot has already told you, this is not a good idea.
RZ/V2H support is optional, just rely on (dummy) rzv2h_get_pll_*()
helpers returning false if CLK_RZV2H is not enabled.

>         help
>           Enable support for the RZ/G2L Display Unit embedded MIPI DSI encoders.
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

