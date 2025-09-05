Return-Path: <linux-kernel+bounces-803227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3A9B45C5E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8DB63BA2AA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AE123BF91;
	Fri,  5 Sep 2025 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjmV76Of"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3EA23D7F4;
	Fri,  5 Sep 2025 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085591; cv=none; b=AzaQAkZOqLxScHXnF/iyaNt4MpvSdRlLs967sVQ5M9L8C5fLiuhj/3Th/NBv36wm9Aau2m5DBzhlZIZt+/83qGvcQuqIc3kBBjeuvARGQF1rfWKusS3mRFY25jHQcsqfmLJQqeBm3vfwWzCVo9f/W6uhWYa8VUS+e8Oju7mrK4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085591; c=relaxed/simple;
	bh=y5FWRAJBx3f/xXiDDwXlkp5hhXm0zlSYbUucIyHKar4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwv2Pa74CAPYkbydtRY9so/2ZmPeF1W8hJfU8m2Ovz9F8nXtjighpEEsZXcMhbIpNSDSZReOJr4CSao0calxgNOYIhbHUnTZWMd3UKTBbmrjTKU3ydc1Cho5gEueJZRh81a5YdWpR3bT+kQcKeopbpeV3ho0G014EQFzPjUg+3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjmV76Of; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002FCC4CEFA;
	Fri,  5 Sep 2025 15:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757085591;
	bh=y5FWRAJBx3f/xXiDDwXlkp5hhXm0zlSYbUucIyHKar4=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=qjmV76OfZ4aFiVBxWMcc28e9cu8DpRCFGWaTUiodlQ//bhKP2NpP8O0Tzl/+ehHti
	 HN/v1y1hL0NQtYQF7jLa4leC1Mof5lL0SeAMqPyfqbk3eBiLc8ur9JxhIEMZl1RItX
	 sHVJNKr2Krivkm+B/kvc3ILpCGPRVj52q2uB2UxBU7iTVQus2G1TNOH8iQtVM+Mw5p
	 8wz12P04C0GeEW74/nNScQxjKHJbygQOZHGgo16bNoseCCZGefUSQ8ODGo7CGnnAoz
	 dlBoYkatZqGqP2w4Clvgn3XZYSxYiUlAFG0CHWxPsroZEeVQ12tpFbFO75BiYO38uQ
	 dlxfSDXBKx5qg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-33730e1cda7so21639001fa.3;
        Fri, 05 Sep 2025 08:19:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVoXOWPJLIh4IiCRURx6d0GUGlZZO9UtLdTEY9DdcLB+pFl6gYG3dC5kguBEwtwsp6/SFfVf9ieROYcXq5c@vger.kernel.org, AJvYcCWM/+m5S5OKA4567K3GU6fiO6qM7qCD6/8A6sNv8s3MSGLab2dA9SET1Evdp+kXz9QIryy8x9NT1k7E@vger.kernel.org, AJvYcCWouPurGDfGpHgzjgeQxArp4DbRejJNjWc9vT9QidUCup8MBauGVTBHyfpjQAhRIVU4WIPspG8zsZQi@vger.kernel.org
X-Gm-Message-State: AOJu0Yws0YMszrLogTgKzkey2/Bd6u1RfFDWmJnXD5Osrp36Spqljc6J
	6qu3SBjygkvbGM5KFuSlFb+Dixdn/HElnuiZrjqhHJ818/1IsMmwWs2TBBxhUSKpNycbWEZsYbk
	NpqF8PQg5zP6SeG4EoVPxKmoYNONJi58=
X-Google-Smtp-Source: AGHT+IGw5JL+ddMtdE3BQh71M7lhvXq9J8ApGrLUEWl3SKfWxfjfiN2RBYCBDlu9iDRVCU4h8u56mOEq1l3VDv70LW8=
X-Received: by 2002:a2e:a7ca:0:b0:338:1286:bc77 with SMTP id
 38308e7fff4ca-3381286c3cfmr19018051fa.42.1757085589283; Fri, 05 Sep 2025
 08:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830170901.1996227-1-wens@kernel.org> <20250830170901.1996227-5-wens@kernel.org>
 <20250905161418.30562637@donnerap>
In-Reply-To: <20250905161418.30562637@donnerap>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 5 Sep 2025 23:19:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v64DmDXaduf7RrYynb+v7TCFA+ni6xPHfyCrwduYW0g=HA@mail.gmail.com>
X-Gm-Features: Ac12FXz4TVFzN3HD-VOVeq3SjMBNL_nE1S2Xp7SCIBD9qEo_VYAnoswTc0k_Tws
Message-ID: <CAGb2v64DmDXaduf7RrYynb+v7TCFA+ni6xPHfyCrwduYW0g=HA@mail.gmail.com>
Subject: Re: [PATCH 4/8] clk: sunxi-ng: sun55i-a523-ccu: Add missing NPU
 module clock
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 11:14=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> On Sun, 31 Aug 2025 01:08:57 +0800
> Chen-Yu Tsai <wens@kernel.org> wrote:
>
> Hi,
>
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > The main clock controller on the A523/T527 has the NPU's module clock.
> > It was missing from the original submission, likely because that was
> > based on the A523 user manual; the A523 is marketed without the NPU.
>
> Ah, sorry, I missed that one. I think I spotted writable bits in that
> register, but didn't find a clue what this clock was about. Anyway, check=
ed
> the bits against the T527 manual, they match up.
>
> > Also, merge the private header back into the driver code itself. The
> > header only contains a macro containing the total number of clocks.
> > This has to be updated every time a missing clock gets added. Having
> > it in a separate file doesn't help the process. Instead just drop the
> > macro, and thus the header no longer has any reason to exist.
>
> Interesting, looks nice, and solves Krzysztof's complaint the other
> day about the binding header inclusion missing from the driver as well.
> Just one thought:
>
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 21 ++++++++++++++++++---
> >  drivers/clk/sunxi-ng/ccu-sun55i-a523.h | 14 --------------
> >  2 files changed, 18 insertions(+), 17 deletions(-)
> >  delete mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523.h
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi=
-ng/ccu-sun55i-a523.c
> > index 1a9a1cb869e2..88405b624dc5 100644
> > --- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> > +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> > @@ -11,6 +11,9 @@
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >
> > +#include <dt-bindings/clock/sun55i-a523-ccu.h>
> > +#include <dt-bindings/reset/sun55i-a523-ccu.h>
> > +
>
> Should we have the number #define here, at a more central location? Seems=
 a
> bit buried down in there. And then use a plural name while at it:
>
> #define NUM_CLOCKS      CLK_NPU + 1
>
> Alternatively, put .num behind .hws below, so that the last clock and the
> number definition are close together?

I think this works better. One less place to look at.

ChenYu

> Cheers,
> Andre
>
> >  #include "../clk.h"
> >
> >  #include "ccu_common.h"
> > @@ -25,8 +28,6 @@
> >  #include "ccu_nkmp.h"
> >  #include "ccu_nm.h"
> >
> > -#include "ccu-sun55i-a523.h"
> > -
> >  /*
> >   * The 24 MHz oscillator, the root of most of the clock tree.
> >   * .fw_name is the string used in the DT "clock-names" property, used =
to
> > @@ -486,6 +487,18 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(ve_clk, "ve", =
ve_parents, 0x690,
> >
> >  static SUNXI_CCU_GATE_HWS(bus_ve_clk, "bus-ve", ahb_hws, 0x69c, BIT(0)=
, 0);
> >
> > +static const struct clk_hw *npu_parents[] =3D {
> > +     &pll_periph0_480M_clk.common.hw,
> > +     &pll_periph0_600M_clk.hw,
> > +     &pll_periph0_800M_clk.common.hw,
> > +     &pll_npu_2x_clk.hw,
> > +};
> > +static SUNXI_CCU_M_HW_WITH_MUX_GATE(npu_clk, "npu", npu_parents, 0x6e0=
,
> > +                                 0, 5,       /* M */
> > +                                 24, 3,      /* mux */
> > +                                 BIT(31),    /* gate */
> > +                                 CLK_SET_RATE_PARENT);
> > +
> >  static SUNXI_CCU_GATE_HWS(bus_dma_clk, "bus-dma", ahb_hws, 0x70c, BIT(=
0), 0);
> >
> >  static SUNXI_CCU_GATE_HWS(bus_msgbox_clk, "bus-msgbox", ahb_hws, 0x71c=
,
> > @@ -1217,6 +1230,7 @@ static struct ccu_common *sun55i_a523_ccu_clks[] =
=3D {
> >       &bus_ce_sys_clk.common,
> >       &ve_clk.common,
> >       &bus_ve_clk.common,
> > +     &npu_clk.common,
> >       &bus_dma_clk.common,
> >       &bus_msgbox_clk.common,
> >       &bus_spinlock_clk.common,
> > @@ -1343,7 +1357,7 @@ static struct ccu_common *sun55i_a523_ccu_clks[] =
=3D {
> >  };
> >
> >  static struct clk_hw_onecell_data sun55i_a523_hw_clks =3D {
> > -     .num    =3D CLK_NUMBER,
> > +     .num    =3D CLK_NPU + 1,
> >       .hws    =3D {
> >               [CLK_PLL_DDR0]          =3D &pll_ddr_clk.common.hw,
> >               [CLK_PLL_PERIPH0_4X]    =3D &pll_periph0_4x_clk.common.hw=
,
> > @@ -1524,6 +1538,7 @@ static struct clk_hw_onecell_data sun55i_a523_hw_=
clks =3D {
> >               [CLK_FANOUT0]           =3D &fanout0_clk.common.hw,
> >               [CLK_FANOUT1]           =3D &fanout1_clk.common.hw,
> >               [CLK_FANOUT2]           =3D &fanout2_clk.common.hw,
> > +             [CLK_NPU]               =3D &npu_clk.common.hw,
> >       },
> >  };
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.h b/drivers/clk/sunxi=
-ng/ccu-sun55i-a523.h
> > deleted file mode 100644
> > index fc8dd42f1b47..000000000000
> > --- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.h
> > +++ /dev/null
> > @@ -1,14 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0 */
> > -/*
> > - * Copyright 2024 Arm Ltd.
> > - */
> > -
> > -#ifndef _CCU_SUN55I_A523_H
> > -#define _CCU_SUN55I_A523_H
> > -
> > -#include <dt-bindings/clock/sun55i-a523-ccu.h>
> > -#include <dt-bindings/reset/sun55i-a523-ccu.h>
> > -
> > -#define CLK_NUMBER   (CLK_FANOUT2 + 1)
> > -
> > -#endif /* _CCU_SUN55I_A523_H */
>

