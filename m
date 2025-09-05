Return-Path: <linux-kernel+bounces-803327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B46AB45DB1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA681667E5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6B22F49E9;
	Fri,  5 Sep 2025 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuXn1ywr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD8530214C;
	Fri,  5 Sep 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088830; cv=none; b=fTOmWyMHo5OSxJiaiE5enEWL0qQmtLGMtiRz3XZnKF2B4NjE6ks5zMPshSJk/ZPll2w+UGUYh+ZpW0L2IhmHDTQO8HGGiPHNxvc9QI1NSvraiTlxl940/76tRQobuQuKXTF7y84bGED5/NR7Zh4/qPFrs5C8IiEzuXqh93zeSZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088830; c=relaxed/simple;
	bh=k4TgFmYLmdJJKcM6qK9KUBfCSsZBu+raH9M12NJX90I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvOXuBgA3RKhhX30iXDqTLaqnSoZ0/dDWj4puq2tPWrZRRK+SRt7iPeWlTiWh2/cGrQANdCWb0wx6OTWOw7QfGEJUBKM6WB95veoD0cCtoSrwt09daHzZ8xM3y1jV2Fmc5LfyZEhwNm+yvz432bLZ+3kjbH0TK5e2IN7QGn++88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuXn1ywr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1BAC4CEF1;
	Fri,  5 Sep 2025 16:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088830;
	bh=k4TgFmYLmdJJKcM6qK9KUBfCSsZBu+raH9M12NJX90I=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=AuXn1ywrE9/huvoLMcTZYt8UBEOcVZW5/tduaznm8kmPQ+s3aZjvQXqq9nfkySjQd
	 wlixE3hyKpkc6Q1uyH9EM1YMFMFGIE5FnZgbnIZoq+JesDTBo6A4lPUiacC8IxAdEB
	 Awc2h2vH8nqbIqQ51QR1P5trD2G7WkubPunzdCmxIiE/jiddP3ny46PhdxBi68aCEB
	 4mzM/xcdH/5lhj3z2teoz7cNWv2E5V7waMKEMV9h2Gfk4eCPSnp8HXZkzvMo+D+JAV
	 Rl589Xuby1QRaqDTXbaiN5hC40weipElxFBb6koO9jxuZsy9zWSY+n1CK7wBN9Z3Pr
	 cCwHyMPjonOAA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3381df3b950so11222761fa.0;
        Fri, 05 Sep 2025 09:13:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGPd/HObGM+soIL1/FibB/WdOGo01NZd98eVLKH4eNBU8ATdbdSwHHSqVrpRcodhewR1NxlKA/karN@vger.kernel.org, AJvYcCWPx7ehPGZSSNpcqV3YM4o24JmppbIijkCg/fxCMHDdtlcz+xwN41fQou8Fv/nqeMARsbXZ/7gQEluy@vger.kernel.org, AJvYcCWli2+V28cJamQl7EYBYCpDhiC6G7BYE72z9eRJ5aioW8NpJxVDrjjzM0iehexZWTig/VfXVp0PBCKHl9lA@vger.kernel.org
X-Gm-Message-State: AOJu0YzLur6nT6Tk06yfRn3Bi74hnCfsoQkYnQjjn28AdQSdhBmqUKQM
	BteoFlDnBZv+qAlZbKnkw1WmqrDTLMJ6buBfhNm/ctYCtTkWr2tplZ0Bzvw+RtZ+9kqDNmLpgN6
	fJVV1VzF1q2gnahWDjUhWvDUDzCT84EQ=
X-Google-Smtp-Source: AGHT+IGk1ZqdvrirssKZE3uulh/lei5iALwiluyrIhEnimsiP/84YkveqGi9g5CWAFmuc0MQ8si/cK0FLO7Wq0F/T+k=
X-Received: by 2002:a2e:ba09:0:b0:336:ba05:b07f with SMTP id
 38308e7fff4ca-336cab08ca0mr49257671fa.21.1757088828365; Fri, 05 Sep 2025
 09:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830170901.1996227-1-wens@kernel.org> <20250830170901.1996227-7-wens@kernel.org>
 <20250905161428.7747729e@donnerap>
In-Reply-To: <20250905161428.7747729e@donnerap>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sat, 6 Sep 2025 00:13:33 +0800
X-Gmail-Original-Message-ID: <CAGb2v67-s5kygq=4fUPKA_6csiUpkLd77Mh-4dFW4WnNFb20jw@mail.gmail.com>
X-Gm-Features: Ac12FXx-jmrlwg9TlknbE8GaaY_cLr21oywd4fKFTgiLomtv_j8p_oB1EUqTm4I
Message-ID: <CAGb2v67-s5kygq=4fUPKA_6csiUpkLd77Mh-4dFW4WnNFb20jw@mail.gmail.com>
Subject: Re: [PATCH 6/8] clk: sunxi-ng: add support for the A523/T527 MCU CCU
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
> On Sun, 31 Aug 2025 01:08:59 +0800
> Chen-Yu Tsai <wens@kernel.org> wrote:
>
> Hi Chen-Yu,
>
> many thanks for this patch, I feel with you when it comes to model
> Allwinner CCUs in the kernel ;-)
>
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > The A523/T527 SoCs have a new MCU PRCM, which has more clocks and reset
> > controls for the RISC-V MCU and other peripherals. There is no visible
> > bus in this part, but there is a second audio PLL. The BSP driver uses
> > the 24MHz main oscillator as the parent for all the bus clocks.
>
> So my copy of the T527 manual (v0.92) shows the system but tree of the
> MCU_PRCM in figure 2-24, and there some peripherals are on AHB_DEC0, whil=
e
> others are on APBS0. Shall we model this correctly, then?

The figure was a bit misleading as it had at its root "CPU" and "MCU_AHB"
instead of "CPUX". I guess given that we can actually access these devices,
they should be the same. It was weird because there were no bus clock
dividers in this block.

> > Add a driver to support this part. Unlike the BSP driver, the SoC's mai=
n
> > MBUS clock is chosen as the parent for the MCU MBUS clock, and the
> > latter then serves as the parent of the MCU DMA controller's MBUS clock=
.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  drivers/clk/sunxi-ng/Kconfig               |   5 +
> >  drivers/clk/sunxi-ng/Makefile              |   2 +
> >  drivers/clk/sunxi-ng/ccu-sun55i-a523-mcu.c | 447 +++++++++++++++++++++
> >  3 files changed, 454 insertions(+)
> >  create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523-mcu.c
> >
> > diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfi=
g
> > index 8896fd052ef1..6af2d020e03e 100644
> > --- a/drivers/clk/sunxi-ng/Kconfig
> > +++ b/drivers/clk/sunxi-ng/Kconfig
> > @@ -57,6 +57,11 @@ config SUN55I_A523_CCU
> >       default ARCH_SUNXI
> >       depends on ARM64 || COMPILE_TEST
> >
> > +config SUN55I_A523_MCU_CCU
> > +     tristate "Support for the Allwinner A523/T527 MCU CCU"
> > +     default ARCH_SUNXI
> > +     depends on ARM64 || COMPILE_TEST
> > +
> >  config SUN55I_A523_R_CCU
> >       tristate "Support for the Allwinner A523/T527 PRCM CCU"
> >       default ARCH_SUNXI
> > diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makef=
ile
> > index 82e471036de6..a1c4087d7241 100644
> > --- a/drivers/clk/sunxi-ng/Makefile
> > +++ b/drivers/clk/sunxi-ng/Makefile
> > @@ -34,6 +34,7 @@ obj-$(CONFIG_SUN50I_H6_CCU) +=3D sun50i-h6-ccu.o
> >  obj-$(CONFIG_SUN50I_H6_R_CCU)        +=3D sun50i-h6-r-ccu.o
> >  obj-$(CONFIG_SUN50I_H616_CCU)        +=3D sun50i-h616-ccu.o
> >  obj-$(CONFIG_SUN55I_A523_CCU)        +=3D sun55i-a523-ccu.o
> > +obj-$(CONFIG_SUN55I_A523_MCU_CCU)    +=3D sun55i-a523-mcu-ccu.o
> >  obj-$(CONFIG_SUN55I_A523_R_CCU)      +=3D sun55i-a523-r-ccu.o
> >  obj-$(CONFIG_SUN4I_A10_CCU)  +=3D sun4i-a10-ccu.o
> >  obj-$(CONFIG_SUN5I_CCU)              +=3D sun5i-ccu.o
> > @@ -61,6 +62,7 @@ sun50i-h6-ccu-y                     +=3D ccu-sun50i-h=
6.o
> >  sun50i-h6-r-ccu-y            +=3D ccu-sun50i-h6-r.o
> >  sun50i-h616-ccu-y            +=3D ccu-sun50i-h616.o
> >  sun55i-a523-ccu-y            +=3D ccu-sun55i-a523.o
> > +sun55i-a523-mcu-ccu-y                +=3D ccu-sun55i-a523-mcu.o
> >  sun55i-a523-r-ccu-y          +=3D ccu-sun55i-a523-r.o
> >  sun4i-a10-ccu-y                      +=3D ccu-sun4i-a10.o
> >  sun5i-ccu-y                  +=3D ccu-sun5i.o
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523-mcu.c b/drivers/clk/s=
unxi-ng/ccu-sun55i-a523-mcu.c
> > new file mode 100644
> > index 000000000000..6105485837c9
> > --- /dev/null
> > +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523-mcu.c
> > @@ -0,0 +1,447 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2025 Chen-Yu Tsai <wens@csie.org>
> > + *
> > + * Based on the A523 CCU driver:
> > + *   Copyright (C) 2023-2024 Arm Ltd.
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <dt-bindings/clock/sun55i-a523-mcu-ccu.h>
> > +#include <dt-bindings/reset/sun55i-a523-mcu-ccu.h>
> > +
> > +#include "ccu_common.h"
> > +#include "ccu_reset.h"
> > +
> > +#include "ccu_div.h"
> > +#include "ccu_gate.h"
> > +#include "ccu_mp.h"
> > +#include "ccu_mult.h"
> > +#include "ccu_nm.h"
> > +
> > +static const struct clk_parent_data osc24M[] =3D {
> > +     { .fw_name =3D "hosc" }
> > +};
> > +
> > +#define SUN55I_A523_PLL_AUDIO1_REG   0x00c
> > +static struct ccu_sdm_setting pll_audio1_sdm_table[] =3D {
> > +     { .rate =3D 2167603200, .pattern =3D 0xa000a234, .m =3D 1, .n =3D=
 90 }, /* div2->22.5792 */
> > +     { .rate =3D 2359296000, .pattern =3D 0xa0009ba6, .m =3D 1, .n =3D=
 98 }, /* div2->24.576 */
> > +     { .rate =3D 1806336000, .pattern =3D 0xa000872b, .m =3D 1, .n =3D=
 75 }, /* div5->22.576 */
> > +};
> > +
> > +static struct ccu_nm pll_audio1_clk =3D {
> > +     .enable         =3D BIT(27),
> > +     .lock           =3D BIT(28),
> > +     .n              =3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> > +     .m              =3D _SUNXI_CCU_DIV(1, 1),
> > +     .sdm            =3D _SUNXI_CCU_SDM(pll_audio1_sdm_table, BIT(24),
> > +                                      0x010, BIT(31)),
> > +     .min_rate       =3D 180000000U,
> > +     .max_rate       =3D 3500000000U,
> > +     .common         =3D {
> > +             .reg            =3D 0x00c,
> > +             .features       =3D CCU_FEATURE_SIGMA_DELTA_MOD,
> > +             .hw.init        =3D CLK_HW_INIT_PARENTS_DATA("pll-audio1"=
,
> > +                                                        osc24M, &ccu_n=
m_ops,
> > +                                                        CLK_SET_RATE_G=
ATE),
> > +     },
> > +};
> > +
> > +static const struct clk_hw *pll_audio1_div_parents[] =3D { &pll_audio1=
_clk.common.hw };
> > +static CLK_FIXED_FACTOR_HWS(pll_periph1_div2_clk, "pll-audio1-div2",
> > +                         pll_audio1_div_parents, 2, 1,
> > +                         CLK_SET_RATE_PARENT);
>
> I admit that those "fixed programmable" dividers are odd, but there are
> fields in the PLL control register that we should use, so it's not a
> fixed divider clock, but a programmable divider, using
> SUNXI_CCU_M_HWS().

As you found out below, this is programmed to be fixed.

> And I think you want the struct name to contain audio1, not periph1?

Correct. Copy-paste thing.

> > +static CLK_FIXED_FACTOR_HWS(pll_periph1_div5_clk, "pll-audio1-div5",
> > +                         pll_audio1_div_parents, 5, 1,
> > +                         CLK_SET_RATE_PARENT);
>
> Same here.
>
> > +
> > +static SUNXI_CCU_M_WITH_GATE(audio_out_clk, "audio-out",
> > +                          "pll-audio1-div2", 0x01c,
> > +                          0, 5, BIT(31), CLK_SET_RATE_PARENT);
>
> I wonder if CLK_SET_RATE_PARENT is a good idea here. IIUC, then the
> idea would be that the PLL is running at a fixed high rate (3072 MHz),
> and gets divided down here to something more audio-y, like 48 or 96 MHz?

No. For audio there are only two classes of clock rates that matter:

 - multiple of 24.576 MHz for 48 KHz family of sample rates
 - multiple of 22.5792 MHz for 44.1 KHz family of sample rates

The PLL has to be able to switch between these. The SDM table below
contains predefined values from the BSP.

> Do you have an idea what this clock is supposed to be used for? I
> don't see it used anywhere, neither in this series, nor in the manual's
> other clock descriptions or even pins.

I've no idea, but didn't want to leave it out and then later on someone
has to add it.

> > +
> > +static const struct clk_parent_data dsp_parents[] =3D {
> > +     { .fw_name =3D "hosc" },
> > +     { .fw_name =3D "losc" },
> > +     { .fw_name =3D "iosc" },
> > +     { .hw =3D &pll_periph1_div5_clk.hw },
> > +     { .hw =3D &pll_periph1_div2_clk.hw },
>
> The manual says that parent 0b011 is the DIV2 clock, and 0b100 is the
> DIV5 clock, so those lines should be swapped.

BSP has this order, so I'm confused as you are. I can just leave a note
here saying the order is from the BSP, which is different from the manual.

Until someone actually plays with the DSP, we won't know which one is corre=
ct.

> > +     { .fw_name =3D "dsp" },
> > +};
> > +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(dsp_clk, "mcu-dsp", dsp_parents,=
 0x0020,
> > +                                   0, 5,     /* M */
> > +                                   24, 3,    /* mux */
> > +                                   BIT(31),  /* gate */
> > +                                   0);
> > +
> > +static const struct clk_parent_data i2s_parents[] =3D {
> > +     { .fw_name =3D "pll-audio0-4x" },
> > +     { .hw =3D &pll_periph1_div2_clk.hw },
> > +     { .hw =3D &pll_periph1_div5_clk.hw },
> > +};
> > +
> > +static SUNXI_CCU_DUALDIV_MUX_GATE(i2s0_clk, "i2s0", i2s_parents, 0x02c=
,
> > +                               0, 5,         /* M */
> > +                               5, 5,         /* P */
> > +                               24, 3,        /* mux */
> > +                               BIT(31),      /* gate */
> > +                               CLK_SET_RATE_PARENT);
>
> Same question about CLK_SET_RATE_PARENT here. Does the flag mean that any
> rate request is only to be fulfilled by the parent? Couldn't find a good
> explanation for that.

AFAIK the flag is _supposed_ to mean that during a rate change, the clk
provider is free to request a different rate from the parent, one that
is suitable for its own use. This actually depends on clk drivers correctly
implementing it in their .determine_rate callbacks though.

> > +static SUNXI_CCU_DUALDIV_MUX_GATE(i2s1_clk, "i2s1", i2s_parents, 0x030=
,
> > +                               0, 5,         /* M */
> > +                               5, 5,         /* P */
> > +                               24, 3,        /* mux */
> > +                               BIT(31),      /* gate */
> > +                               CLK_SET_RATE_PARENT);
> > +static SUNXI_CCU_DUALDIV_MUX_GATE(i2s2_clk, "i2s2", i2s_parents, 0x034=
,
> > +                               0, 5,         /* M */
> > +                               5, 5,         /* P */
> > +                               24, 3,        /* mux */
> > +                               BIT(31),      /* gate */
> > +                               CLK_SET_RATE_PARENT);
> > +static SUNXI_CCU_DUALDIV_MUX_GATE(i2s3_clk, "i2s3", i2s_parents, 0x038=
,
> > +                               0, 5,         /* M */
> > +                               5, 5,         /* P */
> > +                               24, 3,        /* mux */
> > +                               BIT(31),      /* gate */
> > +                               CLK_SET_RATE_PARENT);
> > +
> > +static const struct clk_parent_data i2s3_asrc_parents[] =3D {
> > +     { .fw_name =3D "pll-periph0-300m" },
> > +     { .hw =3D &pll_periph1_div2_clk.hw },
> > +     { .hw =3D &pll_periph1_div5_clk.hw },
> > +};
> > +static SUNXI_CCU_DUALDIV_MUX_GATE(i2s3_asrc_clk, "i2s3-asrc",
> > +                               i2s3_asrc_parents, 0x038,
>
> that address should be 0x03c

It might have been a "copy-paste and then forget to update it" situation.
It was around midnight when I wrote this driver.

> > +                               0, 5,         /* M */
> > +                               5, 5,         /* P */
> > +                               24, 3,        /* mux */
> > +                               BIT(31),      /* gate */
> > +                               CLK_SET_RATE_PARENT);
> > +
> > +static SUNXI_CCU_GATE_DATA(bus_i2s0_clk, "bus-i2s0", osc24M, 0x040, BI=
T(0), 0);
>
> My manual says that APBS0 is the bus clock for the I2S peripherals. I
> guess another one for the list of "clocks" in the DT binding :-(
> This applies to the other bus clocks as well, they should be either APBS0
> or AHB(_DEC0?).

OK.

> > +static SUNXI_CCU_GATE_DATA(bus_i2s1_clk, "bus-i2s1", osc24M, 0x040, BI=
T(1), 0);
> > +static SUNXI_CCU_GATE_DATA(bus_i2s2_clk, "bus-i2s2", osc24M, 0x040, BI=
T(2), 0);
> > +static SUNXI_CCU_GATE_DATA(bus_i2s3_clk, "bus-i2s3", osc24M, 0x040, BI=
T(3), 0);
> > +
> > +static const struct clk_parent_data audio_parents[] =3D {
> > +     { .fw_name =3D "pll-audio0-4x" },
> > +     { .hw =3D &pll_periph1_div2_clk.hw },
> > +     { .hw =3D &pll_periph1_div5_clk.hw },
> > +};
> > +static SUNXI_CCU_DUALDIV_MUX_GATE(spdif_tx_clk, "spdif-tx",
> > +                               audio_parents, 0x044,
> > +                               0, 5,         /* M */
> > +                               5, 5,         /* P */
> > +                               24, 3,        /* mux */
> > +                               BIT(31),      /* gate */
> > +                               CLK_SET_RATE_PARENT);
> > +static SUNXI_CCU_DUALDIV_MUX_GATE(spdif_rx_clk, "spdif-rx",
> > +                               i2s3_asrc_parents, 0x048,
> > +                               0, 5,         /* M */
> > +                               5, 5,         /* P */
> > +                               24, 3,        /* mux */
> > +                               BIT(31),      /* gate */
> > +                               CLK_SET_RATE_PARENT);
> > +
> > +static SUNXI_CCU_GATE_DATA(bus_spdif_clk, "bus-spdif", osc24M, 0x04c, =
BIT(0), 0);
> > +
> > +static SUNXI_CCU_DUALDIV_MUX_GATE(dmic_clk, "dmic", audio_parents, 0x0=
50,
> > +                               0, 5,         /* M */
> > +                               5, 5,         /* P */
> > +                               24, 3,        /* mux */
> > +                               BIT(31),      /* gate */
> > +                               CLK_SET_RATE_PARENT);
> > +
> > +static SUNXI_CCU_GATE_DATA(bus_dmic_clk, "bus-dmic", osc24M, 0x054, BI=
T(0), 0);
> > +
> > +static SUNXI_CCU_DUALDIV_MUX_GATE(audio_dac_clk, "audio-dac",
> > +                               audio_parents, 0x058,
> > +                               0, 5,         /* M */
> > +                               5, 5,         /* P */
> > +                               24, 3,        /* mux */
> > +                               BIT(31),      /* gate */
> > +                               CLK_SET_RATE_PARENT);
> > +static SUNXI_CCU_DUALDIV_MUX_GATE(audio_adc_clk, "audio-adc",
> > +                               audio_parents, 0x05c,
> > +                               0, 5,         /* M */
> > +                               5, 5,         /* P */
> > +                               24, 3,        /* mux */
> > +                               BIT(31),      /* gate */
> > +                               CLK_SET_RATE_PARENT);
> > +
> > +static SUNXI_CCU_GATE_DATA(bus_audio_codec_clk, "bus-audio-codec",
> > +                        osc24M, 0x060, BIT(0), 0);
> > +
> > +static SUNXI_CCU_GATE_DATA(bus_dsp_msgbox_clk, "bus-dsp-msgbox",
> > +                        osc24M, 0x068, BIT(0), 0);
> > +static SUNXI_CCU_GATE_DATA(bus_dsp_cfg_clk, "bus-dsp-cfg",
> > +                        osc24M, 0x06c, BIT(0), 0);
> > +
> > +static SUNXI_CCU_GATE_DATA(bus_npu_hclk, "bus-npu-hclk", osc24M, 0x070=
, BIT(1), 0);
> > +static SUNXI_CCU_GATE_DATA(bus_npu_aclk, "bus-npu-aclk", osc24M, 0x070=
, BIT(2), 0);
> > +
> > +static const struct clk_parent_data timer_parents[] =3D {
> > +     { .fw_name =3D "hosc" },
> > +     { .fw_name =3D "losc" },
> > +     { .fw_name =3D "iosc" },
> > +     { .fw_name =3D "r-ahb" }
> > +};
> > +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(mcu_timer0_clk, "mcu-timer0", ti=
mer_parents,
> > +                                   0x074,
> > +                                   1, 3,     /* P */
> > +                                   4, 2,     /* mux */
> > +                                   BIT(0),   /* gate */
> > +                                   0);
> > +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(mcu_timer1_clk, "mcu-timer1", ti=
mer_parents,
> > +                                   0x078,
> > +                                   1, 3,     /* P */
> > +                                   4, 2,     /* mux */
> > +                                   BIT(0),   /* gate */
> > +                                   0);
> > +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(mcu_timer2_clk, "mcu-timer2", ti=
mer_parents,
> > +                                   0x07c,
> > +                                   1, 3,     /* P */
> > +                                   4, 2,     /* mux */
> > +                                   BIT(0),   /* gate */
> > +                                   0);
> > +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(mcu_timer3_clk, "mcu-timer3", ti=
mer_parents,
> > +                                   0x080,
> > +                                   1, 3,     /* P */
> > +                                   4, 2,     /* mux */
> > +                                   BIT(0),   /* gate */
> > +                                   0);
> > +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(mcu_timer4_clk, "mcu-timer4", ti=
mer_parents,
> > +                                   0x084,
> > +                                   1, 3,     /* P */
> > +                                   4, 2,     /* mux */
> > +                                   BIT(0),   /* gate */
> > +                                   0);
> > +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(mcu_timer5_clk, "mcu-timer5", ti=
mer_parents,
> > +                                   0x088,
> > +                                   1, 3,     /* P */
> > +                                   4, 2,     /* mux */
> > +                                   BIT(0),   /* gate */
> > +                                   0);
> > +static SUNXI_CCU_GATE_DATA(bus_mcu_timer_clk, "bus-mcu-timer", osc24M,=
 0x08c, BIT(0), 0);
> > +static SUNXI_CCU_GATE_DATA(bus_mcu_dma_clk, "bus-mcu-dma", osc24M, 0x1=
04, BIT(0), 0);
> > +static SUNXI_CCU_GATE_DATA(tzma0_clk, "tzma0", osc24M, 0x108, BIT(0), =
0);
> > +static SUNXI_CCU_GATE_DATA(tzma1_clk, "tzma1", osc24M, 0x10c, BIT(0), =
0);
>
> Where did you find those two? I guess in the BSP code? Can you maybe add =
a
> comment about it then?

OK.

> > +static SUNXI_CCU_GATE_DATA(bus_pubsram_clk, "bus-pubsram", osc24M, 0x1=
14, BIT(0), 0);
> > +
> > +/*
> > + * user manual has "mbus" clock as parent of both clocks below,
> > + * but this makes more sense, since BSP MCU DMA controller has
> > + * reference to both of them, likely needing both enabled.
> > + */
> > +static SUNXI_CCU_GATE_FW(mbus_mcu_clk, "mbus-mcu", "mbus", 0x11c, BIT(=
1), 0);
> > +static SUNXI_CCU_GATE_HW(mbus_mcu_dma_clk, "mbus-mcu-dma",
> > +                      &mbus_mcu_clk.common.hw, 0x11c, BIT(0), 0);
> > +
> > +static const struct clk_parent_data riscv_pwm_parents[] =3D {
>
> Where does the pwm part come from? Is the clock below actually the RISC-V
> PWM clock? Which would make more sense, since I don't see a PLL or any
> other fast clock in there.

I'm reusing the parent list here, since the list is the same for the riscv
mod clock and the pwm0 mod clock, hence the name has riscv + pwm.

> > +     { .fw_name =3D "hosc" },
> > +     { .fw_name =3D "losc" },
> > +     { .fw_name =3D "iosc" },
> > +};
> > +
> > +static SUNXI_CCU_MUX_DATA_WITH_GATE(riscv_clk, "riscv",
>
> Related to above: what RISC-V clock is this exactly? Is that some PWM
> clock source, as the parents name suggests, or the main clock, which look=
s
> rather slow then? Or is that to select the root of the RISC-V clock tree?

From https://github.com/radxa/allwinner-bsp/blob/product-t527-linux/configs=
/linux-5.15/sun55iw3p1.dtsi#L2981
it looks like it is the actual clock for the risc-v core. Given that it
is supposed to be a low power standby thing, I guess Allwinner didn't
think it was necessary to have anything faster.

> > +                                 riscv_pwm_parents, 0x120,
> > +                                 27, 3, BIT(31), 0);
> > +static SUNXI_CCU_GATE_DATA(bus_riscv_cfg_clk, "bus-riscv-cfg", osc24M,
> > +                        0x124, BIT(0), 0);
> > +static SUNXI_CCU_GATE_DATA(bus_riscv_msgbox_clk, "bus-riscv-msgbox", o=
sc24M,
> > +                        0x128, BIT(0), 0);
> > +
> > +static SUNXI_CCU_MUX_DATA_WITH_GATE(mcu_pwmmcu0_clk, "mcu-pwm0",
> > +                                 riscv_pwm_parents, 0x130,
> > +                                 27, 3, BIT(31), 0);
>
> The mux fields for this clock start at bit 24.

Oops.

> > +static SUNXI_CCU_GATE_DATA(bus_mcu_pwm0_clk, "bus-mcu-pwm0", osc24M,
> > +                        0x128, BIT(0), 0);
>
> The register offset is 0x134.

(facepalm)

> > +
> > +/*
> > + * Contains all clocks that are controlled by a hardware register. The=
y
> > + * have a (sunxi) .common member, which needs to be initialised by the=
 common
> > + * sunxi CCU code, to be filled with the MMIO base address and the sha=
red lock.
> > + */
> > +static struct ccu_common *sun55i_a523_mcu_ccu_clks[] =3D {
> > +     &pll_audio1_clk.common,
> > +     &audio_out_clk.common,
> > +     &dsp_clk.common,
> > +     &i2s0_clk.common,
> > +     &i2s1_clk.common,
> > +     &i2s2_clk.common,
> > +     &i2s3_clk.common,
> > +     &i2s3_asrc_clk.common,
> > +     &bus_i2s0_clk.common,
> > +     &bus_i2s1_clk.common,
> > +     &bus_i2s2_clk.common,
> > +     &bus_i2s3_clk.common,
> > +     &spdif_tx_clk.common,
> > +     &spdif_rx_clk.common,
> > +     &bus_spdif_clk.common,
> > +     &dmic_clk.common,
> > +     &bus_dmic_clk.common,
> > +     &audio_dac_clk.common,
> > +     &audio_adc_clk.common,
> > +     &bus_audio_codec_clk.common,
> > +     &bus_dsp_msgbox_clk.common,
> > +     &bus_dsp_cfg_clk.common,
> > +     &bus_npu_aclk.common,
> > +     &bus_npu_hclk.common,
> > +     &mcu_timer0_clk.common,
> > +     &mcu_timer1_clk.common,
> > +     &mcu_timer2_clk.common,
> > +     &mcu_timer3_clk.common,
> > +     &mcu_timer4_clk.common,
> > +     &mcu_timer5_clk.common,
> > +     &bus_mcu_timer_clk.common,
> > +     &bus_mcu_dma_clk.common,
> > +     &tzma0_clk.common,
> > +     &tzma1_clk.common,
> > +     &bus_pubsram_clk.common,
> > +     &mbus_mcu_dma_clk.common,
> > +     &mbus_mcu_clk.common,
> > +     &riscv_clk.common,
> > +     &bus_riscv_cfg_clk.common,
> > +     &bus_riscv_msgbox_clk.common,
> > +     &mcu_pwm0_clk.common,
> > +     &bus_mcu_pwm0_clk.common,
> > +};
> > +
> > +static struct clk_hw_onecell_data sun55i_a523_mcu_hw_clks =3D {
> > +     .num    =3D CLK_BUS_MCU_PWM0 + 1,
>
> like of the NPU patch, can we use ".num =3D NUM_CLOCKS," here, and
> #define NUM_CLOCKS at the beginning of the file, right after including th=
e
> binding headers?
> Or alternatively, put .num after the .hws definitions, so that last clock
> and number are closer together?

As mentioned in that patch, I prefer the latter.

> > +     .hws    =3D {
> > +             [CLK_MCU_PLL_AUDIO1]            =3D &pll_audio1_clk.commo=
n.hw,
> > +             [CLK_MCU_PLL_AUDIO1_DIV2]       =3D &pll_periph1_div2_clk=
.hw,
> > +             [CLK_MCU_PLL_AUDIO1_DIV5]       =3D &pll_periph1_div5_clk=
.hw,
> > +             [CLK_MCU_AUDIO_OUT]             =3D &audio_out_clk.common=
.hw,
> > +             [CLK_MCU_DSP]                   =3D &dsp_clk.common.hw,
> > +             [CLK_MCU_I2S0]                  =3D &i2s0_clk.common.hw,
> > +             [CLK_MCU_I2S1]                  =3D &i2s1_clk.common.hw,
> > +             [CLK_MCU_I2S2]                  =3D &i2s2_clk.common.hw,
> > +             [CLK_MCU_I2S3]                  =3D &i2s3_clk.common.hw,
> > +             [CLK_MCU_I2S3_ASRC]             =3D &i2s3_asrc_clk.common=
.hw,
> > +             [CLK_BUS_MCU_I2S0]              =3D &bus_i2s0_clk.common.=
hw,
> > +             [CLK_BUS_MCU_I2S1]              =3D &bus_i2s1_clk.common.=
hw,
> > +             [CLK_BUS_MCU_I2S2]              =3D &bus_i2s2_clk.common.=
hw,
> > +             [CLK_BUS_MCU_I2S3]              =3D &bus_i2s3_clk.common.=
hw,
> > +             [CLK_MCU_SPDIF_TX]              =3D &spdif_tx_clk.common.=
hw,
> > +             [CLK_MCU_SPDIF_RX]              =3D &spdif_rx_clk.common.=
hw,
> > +             [CLK_BUS_MCU_SPDIF]             =3D &bus_spdif_clk.common=
.hw,
> > +             [CLK_MCU_DMIC]                  =3D &dmic_clk.common.hw,
> > +             [CLK_BUS_MCU_DMIC]              =3D &bus_dmic_clk.common.=
hw,
> > +             [CLK_MCU_AUDIO_CODEC_DAC]       =3D &audio_dac_clk.common=
.hw,
> > +             [CLK_MCU_AUDIO_CODEC_ADC]       =3D &audio_adc_clk.common=
.hw,
> > +             [CLK_BUS_MCU_AUDIO_CODEC]       =3D &bus_audio_codec_clk.=
common.hw,
> > +             [CLK_BUS_MCU_DSP_MSGBOX]        =3D &bus_dsp_msgbox_clk.c=
ommon.hw,
> > +             [CLK_BUS_MCU_DSP_CFG]           =3D &bus_dsp_cfg_clk.comm=
on.hw,
> > +             [CLK_BUS_MCU_NPU_HCLK]          =3D &bus_npu_hclk.common.=
hw,
> > +             [CLK_BUS_MCU_NPU_ACLK]          =3D &bus_npu_aclk.common.=
hw,
> > +             [CLK_MCU_TIMER0]                =3D &mcu_timer0_clk.commo=
n.hw,
> > +             [CLK_MCU_TIMER1]                =3D &mcu_timer1_clk.commo=
n.hw,
> > +             [CLK_MCU_TIMER2]                =3D &mcu_timer2_clk.commo=
n.hw,
> > +             [CLK_MCU_TIMER3]                =3D &mcu_timer3_clk.commo=
n.hw,
> > +             [CLK_MCU_TIMER4]                =3D &mcu_timer4_clk.commo=
n.hw,
> > +             [CLK_MCU_TIMER5]                =3D &mcu_timer5_clk.commo=
n.hw,
> > +             [CLK_BUS_MCU_TIMER]             =3D &bus_mcu_timer_clk.co=
mmon.hw,
> > +             [CLK_BUS_MCU_DMA]               =3D &bus_mcu_dma_clk.comm=
on.hw,
> > +             [CLK_MCU_TZMA0]                 =3D &tzma0_clk.common.hw,
> > +             [CLK_MCU_TZMA1]                 =3D &tzma1_clk.common.hw,
> > +             [CLK_BUS_MCU_PUBSRAM]           =3D &bus_pubsram_clk.comm=
on.hw,
> > +             [CLK_MCU_MBUS_DMA]              =3D &mbus_mcu_dma_clk.com=
mon.hw,
> > +             [CLK_MCU_MBUS]                  =3D &mbus_mcu_clk.common.=
hw,
> > +             [CLK_MCU_RISCV]                 =3D &riscv_clk.common.hw,
> > +             [CLK_BUS_MCU_RISCV_CFG]         =3D &bus_riscv_cfg_clk.co=
mmon.hw,
> > +             [CLK_BUS_MCU_RISCV_MSGBOX]      =3D &bus_riscv_msgbox_clk=
.common.hw,
> > +             [CLK_MCU_PWM0]                  =3D &mcu_pwm0_clk.common.=
hw,
> > +             [CLK_BUS_MCU_PWM0]              =3D &bus_mcu_pwm0_clk.com=
mon.hw,
> > +     },
> > +};
> > +
> > +static struct ccu_reset_map sun55i_a523_mcu_ccu_resets[] =3D {
> > +     [RST_BUS_MCU_I2S0]              =3D { 0x0040, BIT(16) },
> > +     [RST_BUS_MCU_I2S1]              =3D { 0x0040, BIT(17) },
> > +     [RST_BUS_MCU_I2S2]              =3D { 0x0040, BIT(18) },
> > +     [RST_BUS_MCU_I2S3]              =3D { 0x0040, BIT(19) },
> > +     [RST_BUS_MCU_SPDIF]             =3D { 0x004c, BIT(16) },
> > +     [RST_BUS_MCU_DMIC]              =3D { 0x0054, BIT(16) },
> > +     [RST_BUS_MCU_AUDIO_CODEC]       =3D { 0x0060, BIT(16) },
> > +     [RST_BUS_MCU_DSP_MSGBOX]        =3D { 0x0068, BIT(16) },
> > +     [RST_BUS_MCU_DSP_CFG]           =3D { 0x006c, BIT(16) },
> > +     [RST_BUS_MCU_NPU]               =3D { 0x0070, BIT(16) },
> > +     [RST_BUS_MCU_TIMER]             =3D { 0x008c, BIT(16) },
> > +     [RST_BUS_MCU_DSP_DEBUG]         =3D { 0x0100, BIT(16) },
> > +     [RST_BUS_MCU_DSP]               =3D { 0x0100, BIT(17) },
>
> I don't see those two in the manual.
>
> > +     [RST_BUS_MCU_DMA]               =3D { 0x0104, BIT(16) },
> > +     [RST_BUS_MCU_PUBSRAM]           =3D { 0x0114, BIT(16) },
>
> The manual shows a reset bit in register 0x120, in the same register as
> this ominous riscv_clk above.

Hmm. I don't see this in the T527 manual (0.92), nor the A523 manuals
(both 1.1 and 1.4), nor the BSP code.

> > +     [RST_BUS_MCU_RISCV_CFG]         =3D { 0x0124, BIT(16) },
> > +     [RST_BUS_MCU_RISCV_DEBUG]       =3D { 0x0124, BIT(17) },
> > +     [RST_BUS_MCU_RISCV_CORE]        =3D { 0x0124, BIT(18) },
> > +     [RST_BUS_MCU_RISCV_MSGBOX]      =3D { 0x0128, BIT(16) },
>
> There is a reset bit for the PWM0 clock in the manual, register 0x130,
> same as the mcu_pwmmcu0_clk above.

I don't see this one either.

> > +     [RST_BUS_MCU_PWM0]              =3D { 0x0134, BIT(16) },
>
> Verified that all of the names defined in the binding headers appear here=
,
> and all definitions here are mentioned in the binding headers.
>
> > +};
> > +
> > +static const struct sunxi_ccu_desc sun55i_a523_mcu_ccu_desc =3D {
> > +     .ccu_clks       =3D sun55i_a523_mcu_ccu_clks,
> > +     .num_ccu_clks   =3D ARRAY_SIZE(sun55i_a523_mcu_ccu_clks),
> > +
> > +     .hw_clks        =3D &sun55i_a523_mcu_hw_clks,
> > +
> > +     .resets         =3D sun55i_a523_mcu_ccu_resets,
> > +     .num_resets     =3D ARRAY_SIZE(sun55i_a523_mcu_ccu_resets),
> > +};
> > +
> > +static int sun55i_a523_mcu_ccu_probe(struct platform_device *pdev)
> > +{
> > +     void __iomem *reg;
> > +     u32 val;
> > +     int ret;
> > +
> > +     reg =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(reg))
> > +             return PTR_ERR(reg);
> > +
> > +     val =3D readl(reg + SUN55I_A523_PLL_AUDIO1_REG);
> > +
> > +     /*
> > +      * The PLL clock code does not model all bits, for instance it do=
es
> > +      * not support a separate enable and gate bit. We present the
> > +      * gate bit(27) as the enable bit, but then have to set the
> > +      * PLL Enable, LDO Enable, and Lock Enable bits on all PLLs here.
> > +      */
> > +     val |=3D BIT(31) | BIT(30) | BIT(29);
> > +
> > +     /* Enforce p1 =3D 5, p0 =3D 2 (the default) for PLL_AUDIO1 */
> > +     val &=3D ~(GENMASK(22, 20) | GENMASK(18, 16));
> > +     val |=3D (4 << 20) | (1 << 16);
>
> Ah, I see, here you set those fixed dividers. I still think we should
> model them properly, as suggested above.

I'm not sure why it's designed this way, especially having a value that
is only close but not exactly 22.5792 MHz on the 5-divider.

Nevertheless, since the outputs are named this way, I think we should
just follow it. It causes less confusion. I can add a comment above
the PLL part.


Thanks
ChenYu

> Cheers,
> Andre
>
> > +
> > +     writel(val, reg + SUN55I_A523_PLL_AUDIO1_REG);
> > +
> > +     ret =3D devm_sunxi_ccu_probe(&pdev->dev, reg, &sun55i_a523_mcu_cc=
u_desc);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id sun55i_a523_mcu_ccu_ids[] =3D {
> > +     { .compatible =3D "allwinner,sun55i-a523-mcu-ccu" },
> > +     { }
> > +};
> > +
> > +static struct platform_driver sun55i_a523_mcu_ccu_driver =3D {
> > +     .probe  =3D sun55i_a523_mcu_ccu_probe,
> > +     .driver =3D {
> > +             .name                   =3D "sun55i-a523-mcu-ccu",
> > +             .suppress_bind_attrs    =3D true,
> > +             .of_match_table         =3D sun55i_a523_mcu_ccu_ids,
> > +     },
> > +};
> > +module_platform_driver(sun55i_a523_mcu_ccu_driver);
> > +
> > +MODULE_IMPORT_NS("SUNXI_CCU");
> > +MODULE_DESCRIPTION("Support for the Allwinner A523 MCU CCU");
> > +MODULE_LICENSE("GPL");
>

