Return-Path: <linux-kernel+bounces-871402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50721C0D25A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A25C44E9E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581082F83B8;
	Mon, 27 Oct 2025 11:29:15 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDF3145B16
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564554; cv=none; b=bfPu8iIwJNGqHVdclayoNO4e8Jo+UYYLljgq1zyrSlOVQAAarIdndo1Juef2Klvjgq9lO0oZHDJ6ZzDgKx8UP2uiIPBllNmNRTkxoHFXcDFNnsP+AFnt2693N01pXUd8cPVznuvxjdcRpK2SAzrYuGnB9mLMvWmBeoddlkPAcf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564554; c=relaxed/simple;
	bh=LCFinbYaaa5T1vbOy/YjHc9/jV/eLUmsdTmf3uq5Qlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFwp5HSsL7ofKWikgkDo92sohV7EXzHphh9Mw6adCpXdxcZlIM8oGo3lQmPsotFLiuphP6WnG2byEhdNNYFaTtri16iefs31MU/K5VBHJoz8vujbU87zqcuN56W7nojW6w9VCR4jMRBIy0uFzfOwbnz3p8mL4QDTZ8XXzmnktOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e89ac45e61so44543901cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761564552; x=1762169352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgNtIcnn6eENaUFz3K0ARDS/soEXQSArUyONWZnfjlQ=;
        b=E9Ry7DaP9KNYiR5/SL0PXD4vPq/y1IZ1qbeWJn4ckp99REwx/8UkFmM8Rj6C99p6k6
         jg2AA+qrzZ/OIAX2HS/QfE+xZhBZEtTRKaqOgUQ+pGU0O8NOfi6Xan18GX1e4natRFAB
         p8LLO5BOyN9oGOgAnO5p0PzijxMiHnXt9vOC1w2sKRq8cq18wxVR8W3Chuh9EseyClKa
         o+IkVxP3kq3ZCZZ7Tf3YydIH2NesE/CXpbedr8t3Wup9BaWAwGADJt6GC2Sg4/OrPEks
         nXHz6E8tiDld6ILB+aQpPOCHUwuO0iL02XNZsqJlzcPLO3N7EAeXnCjoy8BwrLnSLqpe
         zeUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNyryegR5h8zKxWhTsa3Ha/yfjqJ++3M9PkOP+FlMyn9IxUwHhLPgw2hS+av3xSLz22JswgdEnUJNl1x8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbe+sWDXkyvVWTWpAJmdE7Ren3zUs5A3WnsJBEGGPhuBZdC35Z
	xrh+y45Jpl7ZHqoERjZBebZr8Hqht91PruFaiPgEHZqfCKCg7mtCnW4tT3zVGZH8
X-Gm-Gg: ASbGncumV0LgOo6Hj7j7SR+7a+9WDyOymKeD1tpbNqXGM3ZYl11OCb9ak2qnKCkNdcC
	n0AbzooAvD/uH5ZZoomoXFznBu5/6GX1KixMRUKBZfanDnuXnJFhZKawum6S4XBBwYGDnM5/ZtE
	pCwgqpMIXjnAAYn92rthfMDCu/SyhcSC/VpRRUo7y4a8rCpHXZty1zEQrgKiW+em9YTdcFwyPAV
	qdgXxNllCZC1HrFe1g1m0HKvKe21Xxp1ji9f8Kipx/wEpCsEI1a2Ae0rKqQSKT9ugGvU6Mln24Z
	SguO1oy6m+bFHlzxbh7KFrtw9ID4Jd54ebaGiSUmr3XAlpyGXjnanZIS5tQ/QeCFQooCrdBjtSd
	41fI5+m9t661Oh+tv0s1snJ5V/vIlDRZGIVvDBYb3YcJeZgCBlotwPmrBTN6OnklerrxVx4fUen
	LC2rlwuvkywV7ZGTpBjOOeFQncV0uXS0SEdgeMoKfIeQ==
X-Google-Smtp-Source: AGHT+IEar5vAwI8HCMVurgwLZH9ZBx4gWKu2Iu7OXQWJHR7llZ0+3a9KTao6MXFmRcGis8+T8E+3Iw==
X-Received: by 2002:a05:622a:138a:b0:4e8:838d:1992 with SMTP id d75a77b69052e-4eb81580e3cmr183442731cf.63.1761564551947;
        Mon, 27 Oct 2025 04:29:11 -0700 (PDT)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f243142b5sm590294085a.8.2025.10.27.04.29.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 04:29:11 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-89ead335934so282648385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:29:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKlKpFCJMjim8M7zmUE2tB0MiqU3c2xXEEHxVUB52htZKlS+PfTk/0B6vZ/A4ieMuroa07sZaYs7AMWEs=@vger.kernel.org
X-Received: by 2002:a05:6102:2921:b0:59d:458d:b629 with SMTP id
 ada2fe7eead31-5db2e58fe50mr3946640137.30.1761564193435; Mon, 27 Oct 2025
 04:23:13 -0700 (PDT)
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
Date: Mon, 27 Oct 2025 12:23:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVrfVP1XZbQVNwEEP8L69mVzNN2yLSjNyHO7o2zqBuY0w@mail.gmail.com>
X-Gm-Features: AWmQ_blPQXHDdcv3HEZmR70Xe3WDxqjStucPirJolGtaGc9WMslN79O8Z1NYVMM
Message-ID: <CAMuHMdVrfVP1XZbQVNwEEP8L69mVzNN2yLSjNyHO7o2zqBuY0w@mail.gmail.com>
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

Done:

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787=
:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
tags/clk-renesas-rzv2h-plldsi-tag

for you to fetch changes up to f864e4b721e386be132cc973eadefe5d52cdfd94:

  clk: renesas: rzv2h: Add support for DSI clocks (2025-10-27 11:58:03 +010=
0)

----------------------------------------------------------------
clk: renesas: rzv2h: Add support for DSI clocks

RZ/V2H Clock Pulse Generator PLLDSI API, shared by clock and MIPI DSI
driver source files.

----------------------------------------------------------------
Lad Prabhakar (3):
      clk: renesas: rzv2h: Add instance field to struct pll
      clk: renesas: rzv2h: Use GENMASK for PLL fields
      clk: renesas: rzv2h: Add support for DSI clocks

 drivers/clk/renesas/rzv2h-cpg.c | 512 ++++++++++++++++++++++++++++++++++++=
+++-
 drivers/clk/renesas/rzv2h-cpg.h |  26 +-
 include/linux/clk/renesas.h     | 145 ++++++++++++
 3 files changed, 672 insertions(+), 11 deletions(-)

> > >   2. I queue patch 4 on top of 1 in renesas-clk for v6.19,

Done.

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
> will need to merge the branch (either branch 1. as prepared by Geert, on
> top of which you can them push patches 5-7 yourself, or a branch you'll
> prepare on top of 1. with patches 5-7).

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

