Return-Path: <linux-kernel+bounces-866476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9D5BFFDF9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FDC3A601A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BBA2FB0B3;
	Thu, 23 Oct 2025 08:20:58 +0000 (UTC)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50592FB607
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207657; cv=none; b=AQV4B6W9W1UIv5TO/qo+DpG4J2+c0AXFn6eKVh0/qzi3uJDB4+S+RUxSa9a6Eo8n/NcBl1Bl9xYTm8XP4mJNSLoxct3uEuEeke5Pw6Uc6Xpwa1ESYklWQ0ubwP+L9daDOaUgoh8prs70zUxQBbjOS4MuxaRH6/4SASE56xDktEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207657; c=relaxed/simple;
	bh=riOWBoniluYmZkJSNiPD51TALJtz2J5b6wiQtNSND7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osnasXi1AV4erdfQNcpf+XELXSWHWfQhWwqoe9Qz1sFZTbR7f4X9G+Fh7ayEsQL7HncWukVLTppDpEdXlSklg9pnuystEEkYQMs5E1i57I4d2d70lfaZkny8UFDKnaYgJ/tb3KHf3HJjCMqUceuv8Rn8+LmhgBVRnaee5dBjzg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-557bf688086so49640e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761207653; x=1761812453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECYIxuT82Q/NafhPkuUWEytQEjZXJcXQfJX7HoJHHBY=;
        b=VPzNijt8K9hNULizUlL2uQvIf526J7DcWOxoWzpwBU04VeozSWqq7IlLKyYD6GmGv0
         ohQFxNOfhN8N+xoJJ2qX96hyaJE3uc2bc/R0X9xWt6KrXnUiWJyxGHaspsxLjRrfte52
         YxY9VhHK1Z27lK24Nsco9HHPu4t8IfiXoBHcfHxVIBeEdncQyIbmL/47ZedlWI+NRzJ7
         nB8ScfIodP6MyxhTf4uipLTqQjysiK+CR8w4qhgXS+4lSy5YAkb2n0WQ+2pqsAySVUHg
         ijK2dg1deVirNCzxk+Fo1iKuARQIxF7VIsN6h2DKrN2jTs5hy4F1YxCk5Dqj1/6vrhv8
         bnkg==
X-Forwarded-Encrypted: i=1; AJvYcCW5Qf/B7plc8i3OUAAP5eG5CbGKUbNnQL3uN4iJ+BaCIFuNAupky8pJQ0cr/0PGA8CE7NWD7Bk0SKEZlVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YygljL0uC/XhgCmc5kFpIsYIulK2cTEqKpJWZx1fmLfncFMCp/N
	uz+cP9XPzAnLps1cCO32GpLMeD3iTP2a7sMAdnihQq9Wmqf5EtXvRUB5WvoTgLOd
X-Gm-Gg: ASbGncsxhOrVH+19sBIM84GtpICU2BNECDYScreKdOrtn95e+J3yDl26SYFKqu/P4hh
	2AuxQZ84e1jWO0dWgJDlmW/Tlp+/KY8ytGT2AonVpZI7Sp3yxj96iCkqF2V9BPxef2cZzMRKMYC
	A4EiaJDdp3Nxl5hq4iXlMRzlErdBw4rMiJBxD5ZXOT8DFdg3DVscJnxFVSuc0Awy96khThlN8pU
	wNQlCqcs8QHiFvOyBvrQGYcCWLdli9dWyhSpG/hl7HXwdmEzlT5sNb1IPP4gUg5WltzdG3YowQG
	2nTqd+CcBKFF7kBXhRUNshHkGWnUp+IoP9V5z2u4vLxFKFIekpWNp50xPWt5Iz2uWpXwHkWV4eb
	elcbz85Uyrto8deL/PK1fvuMRIoPwm8gFpuZz3OAqGrMe2yQAf1QvC8MSs8CsoFMYvRzZafLnJK
	e6UKv/7uVIsBs8ohQ1lL62h4keuNMOJqm49FsNeQ==
X-Google-Smtp-Source: AGHT+IFfQI30DVJr4nRXCeZn+peMFXvEm2K6CFMhemWlKpOzXydhzoUA+zJOJy9ZmPXP8Ybd5DyA6w==
X-Received: by 2002:a05:6122:3183:b0:54a:9927:7ab7 with SMTP id 71dfb90a1353d-5564ee4b9b8mr8238333e0c.4.1761207653371;
        Thu, 23 Oct 2025 01:20:53 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557bef22a61sm551858e0c.24.2025.10.23.01.20.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:20:52 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5d40e0106b6so278538137.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:20:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3qiMH+I9vbylCEH3mD4l1eiON7PSrwUcAH+9vaX450gbdeLVL6FM2IyG9Q8VrnYXbpNUwv3xDw/BQ1+c=@vger.kernel.org
X-Received: by 2002:a05:6102:5110:b0:5db:27e9:933e with SMTP id
 ada2fe7eead31-5db27e9988cmr1196188137.38.1761207652096; Thu, 23 Oct 2025
 01:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015192611.241920-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdW1B7Yk1hUU9MSJsiL8wSmjAUGN7Qd_wgBHv8Ct=-wi4Q@mail.gmail.com>
 <CA+V-a8uY11uWoQ_en5QC=W4HPHRwT6rKQQJ-knT8Gi-+czm05w@mail.gmail.com> <20251021184502.GD19043@pendragon.ideasonboard.com>
In-Reply-To: <20251021184502.GD19043@pendragon.ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Oct 2025 10:20:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUU-2ugmA-VcRuYOsriUKtAEQXmWEwJSwuCsSTa3ySTZg@mail.gmail.com>
X-Gm-Features: AS18NWACo5Ab6gaObSrlb5u0ift86EnuHySc5nm6Ey8p5bDoFaPy9DC0cq8vSBg
Message-ID: <CAMuHMdUU-2ugmA-VcRuYOsriUKtAEQXmWEwJSwuCsSTa3ySTZg@mail.gmail.com>
Subject: Re: [PATCH v11 0/7] Add support for DU/DSI clocks and DSI driver
 support for the Renesas RZ/V2H(P) SoC
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Tue, 21 Oct 2025 at 20:45, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tue, Oct 21, 2025 at 07:26:49PM +0100, Lad, Prabhakar wrote:
> > On Tue, Oct 21, 2025 at 11:26=E2=80=AFAM Geert Uytterhoeven wrote:
> > > On Wed, 15 Oct 2025 at 21:26, Prabhakar <prabhakar.csengg@gmail.com> =
wrote:
> > > > This patch series adds DU/DSI clocks and provides support for the
> > > > MIPI DSI interface on the RZ/V2H(P) SoC.
> > > >
> > > > v10->v11:
> > > > - Split CPG_PLL_CLK1_K/M/PDIV macro change into separate patch
> > > > - Updated rzv2h_cpg_plldsi_div_determine_rate()
> > > >   while iterating over the divider table
> > > > - Added Acked-by tag from Tomi for patch 2/7 and 3/7
> > > > - Added Reviewed-by tag from Geert for patch 2/7 and 3/7
> > >
> > > I think this series is ready for merging.
> >
> > \o/
> >
> > > > Lad Prabhakar (7):
> > > >   clk: renesas: rzv2h-cpg: Add instance field to struct pll
> > > >   clk: renesas: rzv2h-cpg: Use GENMASK for PLL fields
> > > >   clk: renesas: rzv2h-cpg: Add support for DSI clocks
> > > >   clk: renesas: r9a09g057: Add clock and reset entries for DSI and =
LCDC
> > > >   dt-bindings: display: bridge: renesas,dsi: Document RZ/V2H(P) and
> > > >     RZ/V2N
> > > >   drm: renesas: rz-du: mipi_dsi: Add LPCLK clock support
> > > >   drm: renesas: rz-du: mipi_dsi: Add support for RZ/V2H(P) SoC
> > >
> > > As this touches both clk and drm, let's discuss the merge strategy.
> > > My proposal:
> > >   1. I queue patches 1-3 in an immutable branch with a signed tag,
> > >      to be used as a base for the remaining patches,
> > >   2. I queue patch 4 on top of 1 in renesas-clk for v6.19,
> > >   3. The DRM people queue patches 5-7 on top of 1.
> > >
> > > Does that sound fine for you?
> > Sounds good to me.
> >
> > Biju/Tomi, are you OK with the above?
>
> The plan seems good to me. Note that you won't be able to push this
> yourself to drm-misc as committers are limited to pushing linear
> branches. We need an ack from the drm-misc maintainers, and one of them

Do you mean new commits must be in a single branch, or drm-misc
itself must be linear? In case of the former, 5-7 can be applied on top of
my immutable branch, without involving a merge?

> will need to merge the branch (either branch 1. as prepared by Geert, on
> top of which you can them push patches 5-7 yourself, or a branch you'll
> prepare on top of 1. with patches 5-7).

Note that another change to include/linux/clk/renesas.h,
and thus a dependency of drm on clk, is coming in
"[PATCH v3 0/2] Remove hard coded values for MIPI-DSI"
https://lore.kernel.org/20251022235903.1091453-1-chris.brandt@renesas.com

Would it be worthwhile to wait on/speed up review of the latter?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

