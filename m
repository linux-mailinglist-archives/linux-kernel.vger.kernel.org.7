Return-Path: <linux-kernel+bounces-803455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FE7B45FF7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F67A44FAA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9761E3191D8;
	Fri,  5 Sep 2025 17:21:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650103191CB;
	Fri,  5 Sep 2025 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092888; cv=none; b=HIm43goUBucBGuApCWuymUucTyYNZJhS6bPYzy4pKT5CPruMIL1U37BY1qDrNZ9GY9taOHGUhCdzazUabjzd56NxvSRCmOY9Ww+z2nFUmd1SBI7zCdt7aFCHeOkLF/r5gJJrHxuNzNJ25QHGZYBTzutzk8RH7s805m7eb7WIoJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092888; c=relaxed/simple;
	bh=94R74LeSlJdeVeO9GJpEGa1CSoF4CvxVgVeM6hgQ5GI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxVg1eouRysmkhh4PpvesiyY8R3MXFpJQRKQA90lQMaSH2o7JCTH48HLvpjs4hfikvPPPOlNceFpHYVTNNs6O3z8/hxQXHwhdEgEy7KLrTSKqPlgPZK6/j+cx5q65taQB/8fGCVHwq9qz3XSq2goXx5mIa3wUW1vBwpi9C7IHcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 355B4152B;
	Fri,  5 Sep 2025 10:21:16 -0700 (PDT)
Received: from donnerap (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E41A83F6A8;
	Fri,  5 Sep 2025 10:21:22 -0700 (PDT)
Date: Fri, 5 Sep 2025 18:21:19 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Jernej
 Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] clk: sunxi-ng: add support for the A523/T527 MCU
 CCU
Message-ID: <20250905182119.113a61e6@donnerap>
In-Reply-To: <CAGb2v67-s5kygq=4fUPKA_6csiUpkLd77Mh-4dFW4WnNFb20jw@mail.gmail.com>
References: <20250830170901.1996227-1-wens@kernel.org>
	<20250830170901.1996227-7-wens@kernel.org>
	<20250905161428.7747729e@donnerap>
	<CAGb2v67-s5kygq=4fUPKA_6csiUpkLd77Mh-4dFW4WnNFb20jw@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 6 Sep 2025 00:13:33 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

Hi,

> On Fri, Sep 5, 2025 at 11:14=E2=80=AFPM Andre Przywara <andre.przywara@ar=
m.com> wrote:
> >
> > On Sun, 31 Aug 2025 01:08:59 +0800
> > Chen-Yu Tsai <wens@kernel.org> wrote:
> >
> > Hi Chen-Yu,
> >
> > many thanks for this patch, I feel with you when it comes to model
> > Allwinner CCUs in the kernel ;-)
> > =20
> > > From: Chen-Yu Tsai <wens@csie.org>
> > >
> > > The A523/T527 SoCs have a new MCU PRCM, which has more clocks and res=
et
> > > controls for the RISC-V MCU and other peripherals. There is no visible
> > > bus in this part, but there is a second audio PLL. The BSP driver uses
> > > the 24MHz main oscillator as the parent for all the bus clocks. =20
> >
> > So my copy of the T527 manual (v0.92) shows the system but tree of the
> > MCU_PRCM in figure 2-24, and there some peripherals are on AHB_DEC0, wh=
ile
> > others are on APBS0. Shall we model this correctly, then? =20
>=20
> The figure was a bit misleading as it had at its root "CPU" and "MCU_AHB"
> instead of "CPUX". I guess given that we can actually access these device=
s,
> they should be the same. It was weird because there were no bus clock
> dividers in this block.

Yeah, I agree that this figure is as misleading as it's useful. For
instance what is AHB_DEC0? Is that the same as AHB or AHB_DEC? And
indeed does CPU refer to the Arm cores or the RISC-V core? And is that
APBS0 the same as the APBS0 from the PRCM CCU? Though they seem to have
different parents ...

>=20
> > > Add a driver to support this part. Unlike the BSP driver, the SoC's m=
ain
> > > MBUS clock is chosen as the parent for the MCU MBUS clock, and the
> > > latter then serves as the parent of the MCU DMA controller's MBUS clo=
ck.
> > >
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > ---
> > >  drivers/clk/sunxi-ng/Kconfig               |   5 +
> > >  drivers/clk/sunxi-ng/Makefile              |   2 +
> > >  drivers/clk/sunxi-ng/ccu-sun55i-a523-mcu.c | 447 +++++++++++++++++++=
++
> > >  3 files changed, 454 insertions(+)
> > >  create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523-mcu.c
> > >
> > > diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kcon=
fig
> > > index 8896fd052ef1..6af2d020e03e 100644
> > > --- a/drivers/clk/sunxi-ng/Kconfig
> > > +++ b/drivers/clk/sunxi-ng/Kconfig
> > > @@ -57,6 +57,11 @@ config SUN55I_A523_CCU
> > >       default ARCH_SUNXI
> > >       depends on ARM64 || COMPILE_TEST
> > >
> > > +config SUN55I_A523_MCU_CCU
> > > +     tristate "Support for the Allwinner A523/T527 MCU CCU"
> > > +     default ARCH_SUNXI
> > > +     depends on ARM64 || COMPILE_TEST
> > > +
> > >  config SUN55I_A523_R_CCU
> > >       tristate "Support for the Allwinner A523/T527 PRCM CCU"
> > >       default ARCH_SUNXI
> > > diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Mak=
efile
> > > index 82e471036de6..a1c4087d7241 100644
> > > --- a/drivers/clk/sunxi-ng/Makefile
> > > +++ b/drivers/clk/sunxi-ng/Makefile
> > > @@ -34,6 +34,7 @@ obj-$(CONFIG_SUN50I_H6_CCU) +=3D sun50i-h6-ccu.o
> > >  obj-$(CONFIG_SUN50I_H6_R_CCU)        +=3D sun50i-h6-r-ccu.o
> > >  obj-$(CONFIG_SUN50I_H616_CCU)        +=3D sun50i-h616-ccu.o
> > >  obj-$(CONFIG_SUN55I_A523_CCU)        +=3D sun55i-a523-ccu.o
> > > +obj-$(CONFIG_SUN55I_A523_MCU_CCU)    +=3D sun55i-a523-mcu-ccu.o
> > >  obj-$(CONFIG_SUN55I_A523_R_CCU)      +=3D sun55i-a523-r-ccu.o
> > >  obj-$(CONFIG_SUN4I_A10_CCU)  +=3D sun4i-a10-ccu.o
> > >  obj-$(CONFIG_SUN5I_CCU)              +=3D sun5i-ccu.o
> > > @@ -61,6 +62,7 @@ sun50i-h6-ccu-y                     +=3D ccu-sun50i=
-h6.o
> > >  sun50i-h6-r-ccu-y            +=3D ccu-sun50i-h6-r.o
> > >  sun50i-h616-ccu-y            +=3D ccu-sun50i-h616.o
> > >  sun55i-a523-ccu-y            +=3D ccu-sun55i-a523.o
> > > +sun55i-a523-mcu-ccu-y                +=3D ccu-sun55i-a523-mcu.o
> > >  sun55i-a523-r-ccu-y          +=3D ccu-sun55i-a523-r.o
> > >  sun4i-a10-ccu-y                      +=3D ccu-sun4i-a10.o
> > >  sun5i-ccu-y                  +=3D ccu-sun5i.o
> > > diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523-mcu.c b/drivers/clk=
/sunxi-ng/ccu-sun55i-a523-mcu.c
> > > new file mode 100644
> > > index 000000000000..6105485837c9
> > > --- /dev/null
> > > +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523-mcu.c
> > > @@ -0,0 +1,447 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2025 Chen-Yu Tsai <wens@csie.org>
> > > + *
> > > + * Based on the A523 CCU driver:
> > > + *   Copyright (C) 2023-2024 Arm Ltd.
> > > + */
> > > +
> > > +#include <linux/clk-provider.h>
> > > +#include <linux/io.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +#include <dt-bindings/clock/sun55i-a523-mcu-ccu.h>
> > > +#include <dt-bindings/reset/sun55i-a523-mcu-ccu.h>
> > > +
> > > +#include "ccu_common.h"
> > > +#include "ccu_reset.h"
> > > +
> > > +#include "ccu_div.h"
> > > +#include "ccu_gate.h"
> > > +#include "ccu_mp.h"
> > > +#include "ccu_mult.h"
> > > +#include "ccu_nm.h"
> > > +
> > > +static const struct clk_parent_data osc24M[] =3D {
> > > +     { .fw_name =3D "hosc" }
> > > +};
> > > +
> > > +#define SUN55I_A523_PLL_AUDIO1_REG   0x00c
> > > +static struct ccu_sdm_setting pll_audio1_sdm_table[] =3D {
> > > +     { .rate =3D 2167603200, .pattern =3D 0xa000a234, .m =3D 1, .n =
=3D 90 }, /* div2->22.5792 */
> > > +     { .rate =3D 2359296000, .pattern =3D 0xa0009ba6, .m =3D 1, .n =
=3D 98 }, /* div2->24.576 */
> > > +     { .rate =3D 1806336000, .pattern =3D 0xa000872b, .m =3D 1, .n =
=3D 75 }, /* div5->22.576 */
> > > +};
> > > +
> > > +static struct ccu_nm pll_audio1_clk =3D {
> > > +     .enable         =3D BIT(27),
> > > +     .lock           =3D BIT(28),
> > > +     .n              =3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> > > +     .m              =3D _SUNXI_CCU_DIV(1, 1),
> > > +     .sdm            =3D _SUNXI_CCU_SDM(pll_audio1_sdm_table, BIT(24=
),
> > > +                                      0x010, BIT(31)),
> > > +     .min_rate       =3D 180000000U,
> > > +     .max_rate       =3D 3500000000U,
> > > +     .common         =3D {
> > > +             .reg            =3D 0x00c,
> > > +             .features       =3D CCU_FEATURE_SIGMA_DELTA_MOD,
> > > +             .hw.init        =3D CLK_HW_INIT_PARENTS_DATA("pll-audio=
1",
> > > +                                                        osc24M, &ccu=
_nm_ops,
> > > +                                                        CLK_SET_RATE=
_GATE),
> > > +     },
> > > +};
> > > +
> > > +static const struct clk_hw *pll_audio1_div_parents[] =3D { &pll_audi=
o1_clk.common.hw };
> > > +static CLK_FIXED_FACTOR_HWS(pll_periph1_div2_clk, "pll-audio1-div2",
> > > +                         pll_audio1_div_parents, 2, 1,
> > > +                         CLK_SET_RATE_PARENT); =20
> >
> > I admit that those "fixed programmable" dividers are odd, but there are
> > fields in the PLL control register that we should use, so it's not a
> > fixed divider clock, but a programmable divider, using
> > SUNXI_CCU_M_HWS(). =20
>=20
> As you found out below, this is programmed to be fixed.
>=20
> > And I think you want the struct name to contain audio1, not periph1? =20
>=20
> Correct. Copy-paste thing.
>=20
> > > +static CLK_FIXED_FACTOR_HWS(pll_periph1_div5_clk, "pll-audio1-div5",
> > > +                         pll_audio1_div_parents, 5, 1,
> > > +                         CLK_SET_RATE_PARENT); =20
> >
> > Same here.
> > =20
> > > +
> > > +static SUNXI_CCU_M_WITH_GATE(audio_out_clk, "audio-out",
> > > +                          "pll-audio1-div2", 0x01c,
> > > +                          0, 5, BIT(31), CLK_SET_RATE_PARENT); =20
> >
> > I wonder if CLK_SET_RATE_PARENT is a good idea here. IIUC, then the
> > idea would be that the PLL is running at a fixed high rate (3072 MHz),
> > and gets divided down here to something more audio-y, like 48 or 96 MHz=
? =20
>=20
> No. For audio there are only two classes of clock rates that matter:
>=20
>  - multiple of 24.576 MHz for 48 KHz family of sample rates
>  - multiple of 22.5792 MHz for 44.1 KHz family of sample rates
>=20
> The PLL has to be able to switch between these. The SDM table below
> contains predefined values from the BSP.
>=20
> > Do you have an idea what this clock is supposed to be used for? I
> > don't see it used anywhere, neither in this series, nor in the manual's
> > other clock descriptions or even pins. =20
>=20
> I've no idea, but didn't want to leave it out and then later on someone
> has to add it.

Fair enough, I guess we can fix that if needed, when we get actual users.

> > > +
> > > +static const struct clk_parent_data dsp_parents[] =3D {
> > > +     { .fw_name =3D "hosc" },
> > > +     { .fw_name =3D "losc" },
> > > +     { .fw_name =3D "iosc" },
> > > +     { .hw =3D &pll_periph1_div5_clk.hw },
> > > +     { .hw =3D &pll_periph1_div2_clk.hw }, =20
> >
> > The manual says that parent 0b011 is the DIV2 clock, and 0b100 is the
> > DIV5 clock, so those lines should be swapped. =20
>=20
> BSP has this order, so I'm confused as you are. I can just leave a note
> here saying the order is from the BSP, which is different from the manual.
>=20
> Until someone actually plays with the DSP, we won't know which one is cor=
rect.

The rest of the parent lists always use DIV2 first, than DIV5. So I am
really inclined to believe in a BSP bug. I guess in real life people will
use the "dsp" clock anyway, so nobody noticed.

>=20
> > > +     { .fw_name =3D "dsp" },
> > > +};
> > > +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(dsp_clk, "mcu-dsp", dsp_parent=
s, 0x0020,
> > > +                                   0, 5,     /* M */
> > > +                                   24, 3,    /* mux */
> > > +                                   BIT(31),  /* gate */
> > > +                                   0);
> > > +
> > > +static const struct clk_parent_data i2s_parents[] =3D {
> > > +     { .fw_name =3D "pll-audio0-4x" },
> > > +     { .hw =3D &pll_periph1_div2_clk.hw },
> > > +     { .hw =3D &pll_periph1_div5_clk.hw },
> > > +};
> > > +
> > > +static SUNXI_CCU_DUALDIV_MUX_GATE(i2s0_clk, "i2s0", i2s_parents, 0x0=
2c,
> > > +                               0, 5,         /* M */
> > > +                               5, 5,         /* P */
> > > +                               24, 3,        /* mux */
> > > +                               BIT(31),      /* gate */
> > > +                               CLK_SET_RATE_PARENT); =20
> >
> > Same question about CLK_SET_RATE_PARENT here. Does the flag mean that a=
ny
> > rate request is only to be fulfilled by the parent? Couldn't find a good
> > explanation for that. =20
>=20
> AFAIK the flag is _supposed_ to mean that during a rate change, the clk
> provider is free to request a different rate from the parent, one that
> is suitable for its own use. This actually depends on clk drivers correct=
ly
> implementing it in their .determine_rate callbacks though.

Ah, thanks, that's a good point: it's somewhat IMPDEF.

> > > +static SUNXI_CCU_DUALDIV_MUX_GATE(i2s1_clk, "i2s1", i2s_parents, 0x0=
30,
> > > +                               0, 5,         /* M */
> > > +                               5, 5,         /* P */
> > > +                               24, 3,        /* mux */
> > > +                               BIT(31),      /* gate */
> > > +                               CLK_SET_RATE_PARENT);
> > > +static SUNXI_CCU_DUALDIV_MUX_GATE(i2s2_clk, "i2s2", i2s_parents, 0x0=
34,
> > > +                               0, 5,         /* M */
> > > +                               5, 5,         /* P */
> > > +                               24, 3,        /* mux */
> > > +                               BIT(31),      /* gate */
> > > +                               CLK_SET_RATE_PARENT);
> > > +static SUNXI_CCU_DUALDIV_MUX_GATE(i2s3_clk, "i2s3", i2s_parents, 0x0=
38,
> > > +                               0, 5,         /* M */
> > > +                               5, 5,         /* P */
> > > +                               24, 3,        /* mux */
> > > +                               BIT(31),      /* gate */
> > > +                               CLK_SET_RATE_PARENT);
> > > +
> > > +static const struct clk_parent_data i2s3_asrc_parents[] =3D {
> > > +     { .fw_name =3D "pll-periph0-300m" },
> > > +     { .hw =3D &pll_periph1_div2_clk.hw },
> > > +     { .hw =3D &pll_periph1_div5_clk.hw },
> > > +};
> > > +static SUNXI_CCU_DUALDIV_MUX_GATE(i2s3_asrc_clk, "i2s3-asrc",
> > > +                               i2s3_asrc_parents, 0x038, =20
> >
> > that address should be 0x03c =20
>=20
> It might have been a "copy-paste and then forget to update it" situation.
> It was around midnight when I wrote this driver.

Don't worry, I know the drill. Especially those large clock drivers are a
nightmare in this respect, and missing some update after copy&paste
happened to me so many times before.

>=20
> > > +                               0, 5,         /* M */
> > > +                               5, 5,         /* P */
> > > +                               24, 3,        /* mux */
> > > +                               BIT(31),      /* gate */
> > > +                               CLK_SET_RATE_PARENT);
> > > +
> > > +static SUNXI_CCU_GATE_DATA(bus_i2s0_clk, "bus-i2s0", osc24M, 0x040, =
BIT(0), 0); =20
> >
> > My manual says that APBS0 is the bus clock for the I2S peripherals. I
> > guess another one for the list of "clocks" in the DT binding :-(
> > This applies to the other bus clocks as well, they should be either APB=
S0
> > or AHB(_DEC0?). =20
>=20
> OK.

I am wondering what the consequences are in terms of compatibility?
Maybe we should at least make those clocks part of the DT clocks property,
so that old DTs have them, should we need them in the future?

> > > +static SUNXI_CCU_GATE_DATA(bus_i2s1_clk, "bus-i2s1", osc24M, 0x040, =
BIT(1), 0);
> > > +static SUNXI_CCU_GATE_DATA(bus_i2s2_clk, "bus-i2s2", osc24M, 0x040, =
BIT(2), 0);
> > > +static SUNXI_CCU_GATE_DATA(bus_i2s3_clk, "bus-i2s3", osc24M, 0x040, =
BIT(3), 0);
> > > +
> > > +static const struct clk_parent_data audio_parents[] =3D {
> > > +     { .fw_name =3D "pll-audio0-4x" },
> > > +     { .hw =3D &pll_periph1_div2_clk.hw },
> > > +     { .hw =3D &pll_periph1_div5_clk.hw },
> > > +};
> > > +static SUNXI_CCU_DUALDIV_MUX_GATE(spdif_tx_clk, "spdif-tx",
> > > +                               audio_parents, 0x044,
> > > +                               0, 5,         /* M */
> > > +                               5, 5,         /* P */
> > > +                               24, 3,        /* mux */
> > > +                               BIT(31),      /* gate */
> > > +                               CLK_SET_RATE_PARENT);
> > > +static SUNXI_CCU_DUALDIV_MUX_GATE(spdif_rx_clk, "spdif-rx",
> > > +                               i2s3_asrc_parents, 0x048,
> > > +                               0, 5,         /* M */
> > > +                               5, 5,         /* P */
> > > +                               24, 3,        /* mux */
> > > +                               BIT(31),      /* gate */
> > > +                               CLK_SET_RATE_PARENT);
> > > +
> > > +static SUNXI_CCU_GATE_DATA(bus_spdif_clk, "bus-spdif", osc24M, 0x04c=
, BIT(0), 0);
> > > +
> > > +static SUNXI_CCU_DUALDIV_MUX_GATE(dmic_clk, "dmic", audio_parents, 0=
x050,
> > > +                               0, 5,         /* M */
> > > +                               5, 5,         /* P */
> > > +                               24, 3,        /* mux */
> > > +                               BIT(31),      /* gate */
> > > +                               CLK_SET_RATE_PARENT);
> > > +
> > > +static SUNXI_CCU_GATE_DATA(bus_dmic_clk, "bus-dmic", osc24M, 0x054, =
BIT(0), 0);
> > > +
> > > +static SUNXI_CCU_DUALDIV_MUX_GATE(audio_dac_clk, "audio-dac",
> > > +                               audio_parents, 0x058,
> > > +                               0, 5,         /* M */
> > > +                               5, 5,         /* P */
> > > +                               24, 3,        /* mux */
> > > +                               BIT(31),      /* gate */
> > > +                               CLK_SET_RATE_PARENT);
> > > +static SUNXI_CCU_DUALDIV_MUX_GATE(audio_adc_clk, "audio-adc",
> > > +                               audio_parents, 0x05c,
> > > +                               0, 5,         /* M */
> > > +                               5, 5,         /* P */
> > > +                               24, 3,        /* mux */
> > > +                               BIT(31),      /* gate */
> > > +                               CLK_SET_RATE_PARENT);
> > > +
> > > +static SUNXI_CCU_GATE_DATA(bus_audio_codec_clk, "bus-audio-codec",
> > > +                        osc24M, 0x060, BIT(0), 0);
> > > +
> > > +static SUNXI_CCU_GATE_DATA(bus_dsp_msgbox_clk, "bus-dsp-msgbox",
> > > +                        osc24M, 0x068, BIT(0), 0);
> > > +static SUNXI_CCU_GATE_DATA(bus_dsp_cfg_clk, "bus-dsp-cfg",
> > > +                        osc24M, 0x06c, BIT(0), 0);
> > > +
> > > +static SUNXI_CCU_GATE_DATA(bus_npu_hclk, "bus-npu-hclk", osc24M, 0x0=
70, BIT(1), 0);
> > > +static SUNXI_CCU_GATE_DATA(bus_npu_aclk, "bus-npu-aclk", osc24M, 0x0=
70, BIT(2), 0);
> > > +
> > > +static const struct clk_parent_data timer_parents[] =3D {
> > > +     { .fw_name =3D "hosc" },
> > > +     { .fw_name =3D "losc" },
> > > +     { .fw_name =3D "iosc" },
> > > +     { .fw_name =3D "r-ahb" }
> > > +};
> > > +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(mcu_timer0_clk, "mcu-timer0", =
timer_parents,
> > > +                                   0x074,
> > > +                                   1, 3,     /* P */
> > > +                                   4, 2,     /* mux */
> > > +                                   BIT(0),   /* gate */
> > > +                                   0);
> > > +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(mcu_timer1_clk, "mcu-timer1", =
timer_parents,
> > > +                                   0x078,
> > > +                                   1, 3,     /* P */
> > > +                                   4, 2,     /* mux */
> > > +                                   BIT(0),   /* gate */
> > > +                                   0);
> > > +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(mcu_timer2_clk, "mcu-timer2", =
timer_parents,
> > > +                                   0x07c,
> > > +                                   1, 3,     /* P */
> > > +                                   4, 2,     /* mux */
> > > +                                   BIT(0),   /* gate */
> > > +                                   0);
> > > +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(mcu_timer3_clk, "mcu-timer3", =
timer_parents,
> > > +                                   0x080,
> > > +                                   1, 3,     /* P */
> > > +                                   4, 2,     /* mux */
> > > +                                   BIT(0),   /* gate */
> > > +                                   0);
> > > +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(mcu_timer4_clk, "mcu-timer4", =
timer_parents,
> > > +                                   0x084,
> > > +                                   1, 3,     /* P */
> > > +                                   4, 2,     /* mux */
> > > +                                   BIT(0),   /* gate */
> > > +                                   0);
> > > +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(mcu_timer5_clk, "mcu-timer5", =
timer_parents,
> > > +                                   0x088,
> > > +                                   1, 3,     /* P */
> > > +                                   4, 2,     /* mux */
> > > +                                   BIT(0),   /* gate */
> > > +                                   0);
> > > +static SUNXI_CCU_GATE_DATA(bus_mcu_timer_clk, "bus-mcu-timer", osc24=
M, 0x08c, BIT(0), 0);
> > > +static SUNXI_CCU_GATE_DATA(bus_mcu_dma_clk, "bus-mcu-dma", osc24M, 0=
x104, BIT(0), 0);
> > > +static SUNXI_CCU_GATE_DATA(tzma0_clk, "tzma0", osc24M, 0x108, BIT(0)=
, 0);
> > > +static SUNXI_CCU_GATE_DATA(tzma1_clk, "tzma1", osc24M, 0x10c, BIT(0)=
, 0); =20
> >
> > Where did you find those two? I guess in the BSP code? Can you maybe ad=
d a
> > comment about it then? =20
>=20
> OK.
>=20
> > > +static SUNXI_CCU_GATE_DATA(bus_pubsram_clk, "bus-pubsram", osc24M, 0=
x114, BIT(0), 0);
> > > +
> > > +/*
> > > + * user manual has "mbus" clock as parent of both clocks below,
> > > + * but this makes more sense, since BSP MCU DMA controller has
> > > + * reference to both of them, likely needing both enabled.
> > > + */
> > > +static SUNXI_CCU_GATE_FW(mbus_mcu_clk, "mbus-mcu", "mbus", 0x11c, BI=
T(1), 0);
> > > +static SUNXI_CCU_GATE_HW(mbus_mcu_dma_clk, "mbus-mcu-dma",
> > > +                      &mbus_mcu_clk.common.hw, 0x11c, BIT(0), 0);
> > > +
> > > +static const struct clk_parent_data riscv_pwm_parents[] =3D { =20
> >
> > Where does the pwm part come from? Is the clock below actually the RISC=
-V
> > PWM clock? Which would make more sense, since I don't see a PLL or any
> > other fast clock in there. =20
>=20
> I'm reusing the parent list here, since the list is the same for the riscv
> mod clock and the pwm0 mod clock, hence the name has riscv + pwm.

Ah, I see, makes sense, and indeed we used that naming pattern before.

>=20
> > > +     { .fw_name =3D "hosc" },
> > > +     { .fw_name =3D "losc" },
> > > +     { .fw_name =3D "iosc" },
> > > +};
> > > +
> > > +static SUNXI_CCU_MUX_DATA_WITH_GATE(riscv_clk, "riscv", =20
> >
> > Related to above: what RISC-V clock is this exactly? Is that some PWM
> > clock source, as the parents name suggests, or the main clock, which lo=
oks
> > rather slow then? Or is that to select the root of the RISC-V clock tre=
e? =20
>=20
> From https://github.com/radxa/allwinner-bsp/blob/product-t527-linux/confi=
gs/linux-5.15/sun55iw3p1.dtsi#L2981
> it looks like it is the actual clock for the risc-v core. Given that it
> is supposed to be a low power standby thing, I guess Allwinner didn't
> think it was necessary to have anything faster.

But is it meant to be the SCP? Since we found the ARISC still being in the
SoC, plus ARISC code in the BSP, and I think Jernej mentioned that a E906
is quite some overkill for just power management. The manual mentions 200
MHz for the RISC-V core, so I wonder if there is something missing.
Also since they call it MCU, I wonder if that's designed as some kind of
realtime core? Running some RTOS, for instance?

> > > +                                 riscv_pwm_parents, 0x120,
> > > +                                 27, 3, BIT(31), 0);
> > > +static SUNXI_CCU_GATE_DATA(bus_riscv_cfg_clk, "bus-riscv-cfg", osc24=
M,
> > > +                        0x124, BIT(0), 0);
> > > +static SUNXI_CCU_GATE_DATA(bus_riscv_msgbox_clk, "bus-riscv-msgbox",=
 osc24M,
> > > +                        0x128, BIT(0), 0);
> > > +
> > > +static SUNXI_CCU_MUX_DATA_WITH_GATE(mcu_pwmmcu0_clk, "mcu-pwm0",
> > > +                                 riscv_pwm_parents, 0x130,
> > > +                                 27, 3, BIT(31), 0); =20
> >
> > The mux fields for this clock start at bit 24. =20
>=20
> Oops.
>=20
> > > +static SUNXI_CCU_GATE_DATA(bus_mcu_pwm0_clk, "bus-mcu-pwm0", osc24M,
> > > +                        0x128, BIT(0), 0); =20
> >
> > The register offset is 0x134. =20
>=20
> (facepalm)

Hey, don't worry, I prefer finding those bugs over not finding anything!

>=20
> > > +
> > > +/*
> > > + * Contains all clocks that are controlled by a hardware register. T=
hey
> > > + * have a (sunxi) .common member, which needs to be initialised by t=
he common
> > > + * sunxi CCU code, to be filled with the MMIO base address and the s=
hared lock.
> > > + */
> > > +static struct ccu_common *sun55i_a523_mcu_ccu_clks[] =3D {
> > > +     &pll_audio1_clk.common,
> > > +     &audio_out_clk.common,
> > > +     &dsp_clk.common,
> > > +     &i2s0_clk.common,
> > > +     &i2s1_clk.common,
> > > +     &i2s2_clk.common,
> > > +     &i2s3_clk.common,
> > > +     &i2s3_asrc_clk.common,
> > > +     &bus_i2s0_clk.common,
> > > +     &bus_i2s1_clk.common,
> > > +     &bus_i2s2_clk.common,
> > > +     &bus_i2s3_clk.common,
> > > +     &spdif_tx_clk.common,
> > > +     &spdif_rx_clk.common,
> > > +     &bus_spdif_clk.common,
> > > +     &dmic_clk.common,
> > > +     &bus_dmic_clk.common,
> > > +     &audio_dac_clk.common,
> > > +     &audio_adc_clk.common,
> > > +     &bus_audio_codec_clk.common,
> > > +     &bus_dsp_msgbox_clk.common,
> > > +     &bus_dsp_cfg_clk.common,
> > > +     &bus_npu_aclk.common,
> > > +     &bus_npu_hclk.common,
> > > +     &mcu_timer0_clk.common,
> > > +     &mcu_timer1_clk.common,
> > > +     &mcu_timer2_clk.common,
> > > +     &mcu_timer3_clk.common,
> > > +     &mcu_timer4_clk.common,
> > > +     &mcu_timer5_clk.common,
> > > +     &bus_mcu_timer_clk.common,
> > > +     &bus_mcu_dma_clk.common,
> > > +     &tzma0_clk.common,
> > > +     &tzma1_clk.common,
> > > +     &bus_pubsram_clk.common,
> > > +     &mbus_mcu_dma_clk.common,
> > > +     &mbus_mcu_clk.common,
> > > +     &riscv_clk.common,
> > > +     &bus_riscv_cfg_clk.common,
> > > +     &bus_riscv_msgbox_clk.common,
> > > +     &mcu_pwm0_clk.common,
> > > +     &bus_mcu_pwm0_clk.common,
> > > +};
> > > +
> > > +static struct clk_hw_onecell_data sun55i_a523_mcu_hw_clks =3D {
> > > +     .num    =3D CLK_BUS_MCU_PWM0 + 1, =20
> >
> > like of the NPU patch, can we use ".num =3D NUM_CLOCKS," here, and
> > #define NUM_CLOCKS at the beginning of the file, right after including =
the
> > binding headers?
> > Or alternatively, put .num after the .hws definitions, so that last clo=
ck
> > and number are closer together? =20
>=20
> As mentioned in that patch, I prefer the latter.

Thanks, works for me!

>=20
> > > +     .hws    =3D {
> > > +             [CLK_MCU_PLL_AUDIO1]            =3D &pll_audio1_clk.com=
mon.hw,
> > > +             [CLK_MCU_PLL_AUDIO1_DIV2]       =3D &pll_periph1_div2_c=
lk.hw,
> > > +             [CLK_MCU_PLL_AUDIO1_DIV5]       =3D &pll_periph1_div5_c=
lk.hw,
> > > +             [CLK_MCU_AUDIO_OUT]             =3D &audio_out_clk.comm=
on.hw,
> > > +             [CLK_MCU_DSP]                   =3D &dsp_clk.common.hw,
> > > +             [CLK_MCU_I2S0]                  =3D &i2s0_clk.common.hw,
> > > +             [CLK_MCU_I2S1]                  =3D &i2s1_clk.common.hw,
> > > +             [CLK_MCU_I2S2]                  =3D &i2s2_clk.common.hw,
> > > +             [CLK_MCU_I2S3]                  =3D &i2s3_clk.common.hw,
> > > +             [CLK_MCU_I2S3_ASRC]             =3D &i2s3_asrc_clk.comm=
on.hw,
> > > +             [CLK_BUS_MCU_I2S0]              =3D &bus_i2s0_clk.commo=
n.hw,
> > > +             [CLK_BUS_MCU_I2S1]              =3D &bus_i2s1_clk.commo=
n.hw,
> > > +             [CLK_BUS_MCU_I2S2]              =3D &bus_i2s2_clk.commo=
n.hw,
> > > +             [CLK_BUS_MCU_I2S3]              =3D &bus_i2s3_clk.commo=
n.hw,
> > > +             [CLK_MCU_SPDIF_TX]              =3D &spdif_tx_clk.commo=
n.hw,
> > > +             [CLK_MCU_SPDIF_RX]              =3D &spdif_rx_clk.commo=
n.hw,
> > > +             [CLK_BUS_MCU_SPDIF]             =3D &bus_spdif_clk.comm=
on.hw,
> > > +             [CLK_MCU_DMIC]                  =3D &dmic_clk.common.hw,
> > > +             [CLK_BUS_MCU_DMIC]              =3D &bus_dmic_clk.commo=
n.hw,
> > > +             [CLK_MCU_AUDIO_CODEC_DAC]       =3D &audio_dac_clk.comm=
on.hw,
> > > +             [CLK_MCU_AUDIO_CODEC_ADC]       =3D &audio_adc_clk.comm=
on.hw,
> > > +             [CLK_BUS_MCU_AUDIO_CODEC]       =3D &bus_audio_codec_cl=
k.common.hw,
> > > +             [CLK_BUS_MCU_DSP_MSGBOX]        =3D &bus_dsp_msgbox_clk=
.common.hw,
> > > +             [CLK_BUS_MCU_DSP_CFG]           =3D &bus_dsp_cfg_clk.co=
mmon.hw,
> > > +             [CLK_BUS_MCU_NPU_HCLK]          =3D &bus_npu_hclk.commo=
n.hw,
> > > +             [CLK_BUS_MCU_NPU_ACLK]          =3D &bus_npu_aclk.commo=
n.hw,
> > > +             [CLK_MCU_TIMER0]                =3D &mcu_timer0_clk.com=
mon.hw,
> > > +             [CLK_MCU_TIMER1]                =3D &mcu_timer1_clk.com=
mon.hw,
> > > +             [CLK_MCU_TIMER2]                =3D &mcu_timer2_clk.com=
mon.hw,
> > > +             [CLK_MCU_TIMER3]                =3D &mcu_timer3_clk.com=
mon.hw,
> > > +             [CLK_MCU_TIMER4]                =3D &mcu_timer4_clk.com=
mon.hw,
> > > +             [CLK_MCU_TIMER5]                =3D &mcu_timer5_clk.com=
mon.hw,
> > > +             [CLK_BUS_MCU_TIMER]             =3D &bus_mcu_timer_clk.=
common.hw,
> > > +             [CLK_BUS_MCU_DMA]               =3D &bus_mcu_dma_clk.co=
mmon.hw,
> > > +             [CLK_MCU_TZMA0]                 =3D &tzma0_clk.common.h=
w,
> > > +             [CLK_MCU_TZMA1]                 =3D &tzma1_clk.common.h=
w,
> > > +             [CLK_BUS_MCU_PUBSRAM]           =3D &bus_pubsram_clk.co=
mmon.hw,
> > > +             [CLK_MCU_MBUS_DMA]              =3D &mbus_mcu_dma_clk.c=
ommon.hw,
> > > +             [CLK_MCU_MBUS]                  =3D &mbus_mcu_clk.commo=
n.hw,
> > > +             [CLK_MCU_RISCV]                 =3D &riscv_clk.common.h=
w,
> > > +             [CLK_BUS_MCU_RISCV_CFG]         =3D &bus_riscv_cfg_clk.=
common.hw,
> > > +             [CLK_BUS_MCU_RISCV_MSGBOX]      =3D &bus_riscv_msgbox_c=
lk.common.hw,
> > > +             [CLK_MCU_PWM0]                  =3D &mcu_pwm0_clk.commo=
n.hw,
> > > +             [CLK_BUS_MCU_PWM0]              =3D &bus_mcu_pwm0_clk.c=
ommon.hw,
> > > +     },
> > > +};
> > > +
> > > +static struct ccu_reset_map sun55i_a523_mcu_ccu_resets[] =3D {
> > > +     [RST_BUS_MCU_I2S0]              =3D { 0x0040, BIT(16) },
> > > +     [RST_BUS_MCU_I2S1]              =3D { 0x0040, BIT(17) },
> > > +     [RST_BUS_MCU_I2S2]              =3D { 0x0040, BIT(18) },
> > > +     [RST_BUS_MCU_I2S3]              =3D { 0x0040, BIT(19) },
> > > +     [RST_BUS_MCU_SPDIF]             =3D { 0x004c, BIT(16) },
> > > +     [RST_BUS_MCU_DMIC]              =3D { 0x0054, BIT(16) },
> > > +     [RST_BUS_MCU_AUDIO_CODEC]       =3D { 0x0060, BIT(16) },
> > > +     [RST_BUS_MCU_DSP_MSGBOX]        =3D { 0x0068, BIT(16) },
> > > +     [RST_BUS_MCU_DSP_CFG]           =3D { 0x006c, BIT(16) },
> > > +     [RST_BUS_MCU_NPU]               =3D { 0x0070, BIT(16) },
> > > +     [RST_BUS_MCU_TIMER]             =3D { 0x008c, BIT(16) },
> > > +     [RST_BUS_MCU_DSP_DEBUG]         =3D { 0x0100, BIT(16) },
> > > +     [RST_BUS_MCU_DSP]               =3D { 0x0100, BIT(17) }, =20
> >
> > I don't see those two in the manual.
> > =20
> > > +     [RST_BUS_MCU_DMA]               =3D { 0x0104, BIT(16) },
> > > +     [RST_BUS_MCU_PUBSRAM]           =3D { 0x0114, BIT(16) }, =20
> >
> > The manual shows a reset bit in register 0x120, in the same register as
> > this ominous riscv_clk above. =20
>=20
> Hmm. I don't see this in the T527 manual (0.92), nor the A523 manuals
> (both 1.1 and 1.4), nor the BSP code.

Scratch that, starring at code and manual for too long. Indeed there is no
reset bit, just a clock enable at bit 31.

> > > +     [RST_BUS_MCU_RISCV_CFG]         =3D { 0x0124, BIT(16) },
> > > +     [RST_BUS_MCU_RISCV_DEBUG]       =3D { 0x0124, BIT(17) },
> > > +     [RST_BUS_MCU_RISCV_CORE]        =3D { 0x0124, BIT(18) },
> > > +     [RST_BUS_MCU_RISCV_MSGBOX]      =3D { 0x0128, BIT(16) }, =20
> >
> > There is a reset bit for the PWM0 clock in the manual, register 0x130,
> > same as the mcu_pwmmcu0_clk above. =20
>=20
> I don't see this one either.

And now it's gone for me as well! Must have been pre-lunch starvation,
dulling my senses ;-) Sorry for that!

Cheers,
Andre

> > > +     [RST_BUS_MCU_PWM0]              =3D { 0x0134, BIT(16) }, =20
> >
> > Verified that all of the names defined in the binding headers appear he=
re,
> > and all definitions here are mentioned in the binding headers.
> > =20
> > > +};
> > > +
> > > +static const struct sunxi_ccu_desc sun55i_a523_mcu_ccu_desc =3D {
> > > +     .ccu_clks       =3D sun55i_a523_mcu_ccu_clks,
> > > +     .num_ccu_clks   =3D ARRAY_SIZE(sun55i_a523_mcu_ccu_clks),
> > > +
> > > +     .hw_clks        =3D &sun55i_a523_mcu_hw_clks,
> > > +
> > > +     .resets         =3D sun55i_a523_mcu_ccu_resets,
> > > +     .num_resets     =3D ARRAY_SIZE(sun55i_a523_mcu_ccu_resets),
> > > +};
> > > +
> > > +static int sun55i_a523_mcu_ccu_probe(struct platform_device *pdev)
> > > +{
> > > +     void __iomem *reg;
> > > +     u32 val;
> > > +     int ret;
> > > +
> > > +     reg =3D devm_platform_ioremap_resource(pdev, 0);
> > > +     if (IS_ERR(reg))
> > > +             return PTR_ERR(reg);
> > > +
> > > +     val =3D readl(reg + SUN55I_A523_PLL_AUDIO1_REG);
> > > +
> > > +     /*
> > > +      * The PLL clock code does not model all bits, for instance it =
does
> > > +      * not support a separate enable and gate bit. We present the
> > > +      * gate bit(27) as the enable bit, but then have to set the
> > > +      * PLL Enable, LDO Enable, and Lock Enable bits on all PLLs her=
e.
> > > +      */
> > > +     val |=3D BIT(31) | BIT(30) | BIT(29);
> > > +
> > > +     /* Enforce p1 =3D 5, p0 =3D 2 (the default) for PLL_AUDIO1 */
> > > +     val &=3D ~(GENMASK(22, 20) | GENMASK(18, 16));
> > > +     val |=3D (4 << 20) | (1 << 16); =20
> >
> > Ah, I see, here you set those fixed dividers. I still think we should
> > model them properly, as suggested above. =20
>=20
> I'm not sure why it's designed this way, especially having a value that
> is only close but not exactly 22.5792 MHz on the 5-divider.
>=20
> Nevertheless, since the outputs are named this way, I think we should
> just follow it. It causes less confusion. I can add a comment above
> the PLL part.
>=20
>=20
> Thanks
> ChenYu
>=20
> > Cheers,
> > Andre
> > =20
> > > +
> > > +     writel(val, reg + SUN55I_A523_PLL_AUDIO1_REG);
> > > +
> > > +     ret =3D devm_sunxi_ccu_probe(&pdev->dev, reg, &sun55i_a523_mcu_=
ccu_desc);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct of_device_id sun55i_a523_mcu_ccu_ids[] =3D {
> > > +     { .compatible =3D "allwinner,sun55i-a523-mcu-ccu" },
> > > +     { }
> > > +};
> > > +
> > > +static struct platform_driver sun55i_a523_mcu_ccu_driver =3D {
> > > +     .probe  =3D sun55i_a523_mcu_ccu_probe,
> > > +     .driver =3D {
> > > +             .name                   =3D "sun55i-a523-mcu-ccu",
> > > +             .suppress_bind_attrs    =3D true,
> > > +             .of_match_table         =3D sun55i_a523_mcu_ccu_ids,
> > > +     },
> > > +};
> > > +module_platform_driver(sun55i_a523_mcu_ccu_driver);
> > > +
> > > +MODULE_IMPORT_NS("SUNXI_CCU");
> > > +MODULE_DESCRIPTION("Support for the Allwinner A523 MCU CCU");
> > > +MODULE_LICENSE("GPL"); =20
> > =20


