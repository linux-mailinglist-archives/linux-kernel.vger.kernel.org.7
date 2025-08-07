Return-Path: <linux-kernel+bounces-758976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69661B1D689
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBA9C4E2739
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3F127876E;
	Thu,  7 Aug 2025 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kobhMgmx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB78620B7EE;
	Thu,  7 Aug 2025 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565705; cv=none; b=dszuXblTc41cYEdB/kkSpz3BZW7d0/S0u3VDvFYZBblXAUsFUI7JqjpT1mjs/bCPpp+em5o3EJ2+qACjzsWIb6r3T+ToPxAKvZwflq58fAS9890hCzfwavdFJgnHhOhtuWmpq3EJKX2UUF0hFYe9LnVZTPC5nfwQN2kn1Z3BrpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565705; c=relaxed/simple;
	bh=/las3HdJgz8rwTGq/wNsnsw26iQZJlW8oUc5CdAFHfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5QIR0Q6IRaVRCfGiFJVQuQ/Z4JI8ZFvec0mGjcBi59aWCocG2BPFD6uy2tUe15Q+2DccNpaVlDYta5bpZuv+5JgxAItU9A5jjf+b4DDbMuZd/shPK2JeZSH3pdx+THGQX+6wmYQ9y3azCa4A29EVPkUubg4NpbMnyVHvHGNMZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kobhMgmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D924C4AF0B;
	Thu,  7 Aug 2025 11:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754565705;
	bh=/las3HdJgz8rwTGq/wNsnsw26iQZJlW8oUc5CdAFHfM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kobhMgmxCWKZLfpPF5/y7XQng0KRgyH6crByNET3AmHdsvppuXxtvh8H3J1YE3R77
	 K/cS4unf8WFyviLTbc+Tjshcfv4N0k0iU/kniq9t8JDS7J+R/Efz4NbmqWEu2uzJZ8
	 WSvw6m1F0tj70itsaXdIODn/WAG2onH4PrIA2D7LpXK252EUAtNF+ZouaSWFuTdZVI
	 34yqEZSIR23B+1xxFINuUIcGxipxQsUjaEerRFqp8l16KEPoMnOyDm3iZKLrwHnkcA
	 UqvoiPQ/VyFcLRAnsU78mYtnauz/xYUJOcvwbUKNqL902IXlDs7Qtk8Vs2M/7l1o7h
	 urw/l6xWyYZZw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso1502636a12.1;
        Thu, 07 Aug 2025 04:21:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzoXEghcfFXJFZpuIIR1tH3hTS8AS7R/0O4AwHlA/LlZSRCmbUG78M/tGG6+lmB5qMVtWk5i+P0PQ/@vger.kernel.org, AJvYcCVO7Dxfzd1XYm4evJ2svGB5LpGSHatUOb3qaZxzBL4SgtBQqExzDbfm6NFqDY2wl3N31ZwWeF5r4+ajKKD6@vger.kernel.org, AJvYcCXKNVcpYgiAinXr2Dfgi46ScDUtTG/bMcrZEpnvnXCZYzRy0n1G1opPgqa627cQLXJj4aO6rWtFroTn@vger.kernel.org
X-Gm-Message-State: AOJu0YwA+zHdQ0T2/sDS9T8crAFlNVj5Y0u/sSPC1BWdZE52ksxKqyjb
	IdQIJ4wCh0yf+AVzOb6AxFUpVKI/UvrDG8vHI3s+cIG87DAGJDs5D6ZybrKKfLM/XGm9NO2NzYq
	YA7hDtugARZg7RhRQED2XXSR2QQDHUI0=
X-Google-Smtp-Source: AGHT+IEfl589p0gAcsrL69GC50qs9HZoBbEWHsgSm2HvYXdNGvUj2cS1/ojsVQt++9broqx+mdKSRVRtORf9GJEvEYM=
X-Received: by 2002:a05:6402:3486:b0:617:c895:cc93 with SMTP id
 4fb4d7f45d1cf-617c895d2c3mr1022748a12.14.1754565703955; Thu, 07 Aug 2025
 04:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805150147.25909-1-ziyao@disroot.org> <20250805150147.25909-7-ziyao@disroot.org>
In-Reply-To: <20250805150147.25909-7-ziyao@disroot.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 7 Aug 2025 19:21:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4=A=BaHsAKmTiS62gE6XQLD4rnYmU6snDFt1S0uMHr6A@mail.gmail.com>
X-Gm-Features: Ac12FXxtKvbs-PZAXQ75JhId8jhPeM716oPQ_ai_smjUQTo4Hj6YHjdaaiHGjNI
Message-ID: <CAAhV-H4=A=BaHsAKmTiS62gE6XQLD4rnYmU6snDFt1S0uMHr6A@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] clk: loongson2: Add clock definitions for Loongson
 2K0300 SoC
To: Yao Zi <ziyao@disroot.org>
Cc: Yinbo Zhu <zhuyinbo@loongson.cn>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Yao,

On Tue, Aug 5, 2025 at 11:05=E2=80=AFPM Yao Zi <ziyao@disroot.org> wrote:
>
> The clock controller of Loongson 2K0300 consists of three PLLs, requires
> an 120MHz external reference clock to function, and generates clocks in
> various frequencies for SoC peripherals.
>
> Clock definitions for previous SoC generations could be reused for most
> clock hardwares. There're two gates marked as critical, clk_node_gate
> and clk_boot_gate, which supply the CPU cores and the system
> configuration bus. Disabling them leads to a SoC hang.
>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  drivers/clk/clk-loongson2.c | 48 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
> index 52a9f1c2794a..1d210a7683ea 100644
> --- a/drivers/clk/clk-loongson2.c
> +++ b/drivers/clk/clk-loongson2.c
> @@ -12,6 +12,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <dt-bindings/clock/loongson,ls2k-clk.h>
> +#include <dt-bindings/clock/loongson,ls2k0300-clk.h>
>
>  enum loongson2_clk_type {
>         CLK_TYPE_PLL,
> @@ -137,6 +138,52 @@ struct loongson2_clk_board_info {
>                 .fixed_rate     =3D _rate,                        \
>         }
>
> +static const struct loongson2_clk_board_info ls2k0300_clks[] =3D {
> +       /* Reference Clock */
> +       CLK_PLL(LS2K0300_PLL_NODE, "pll_node",   0x00, 15, 9, 8, 7),
> +       CLK_PLL(LS2K0300_PLL_DDR,  "pll_ddr",    0x08, 15, 9, 8, 7),
> +       CLK_PLL(LS2K0300_PLL_PIX,  "pll_pix",    0x10, 15, 9, 8, 7),
> +       CLK_FIXED(LS2K0300_CLK_STABLE, "clk_stable", NULL, 100000000),
> +       CLK_FIXED(LS2K0300_CLK_THSENS, "clk_thsens", NULL, 10000000),
> +       /* Node PLL */
> +       CLK_DIV(LS2K0300_CLK_NODE_DIV, "clk_node_div", "pll_node", 0x00, =
24, 7),
> +       CLK_DIV(LS2K0300_CLK_GMAC_DIV, "clk_gmac_div", "pll_node", 0x04, =
0, 7),
> +       CLK_DIV(LS2K0300_CLK_I2S_DIV,  "clk_i2s_div",  "pll_node", 0x04, =
8, 7),
> +       CLK_GATE(LS2K0300_CLK_NODE_PLL_GATE,   "clk_node_pll_gate", "clk_=
node_div", 0x00, 0),
> +       CLK_GATE(LS2K0300_CLK_GMAC_GATE,       "clk_gmac_gate",     "clk_=
gmac_div", 0x00, 1),
> +       CLK_GATE(LS2K0300_CLK_I2S_GATE,        "clk_i2s_gate",      "clk_=
i2s_div", 0x00, 2),
> +       CLK_GATE_FLAGS(LS2K0300_CLK_NODE_GATE, "clk_node_gate",     "clk_=
node_scale",
> +                      0x24, 0, CLK_IS_CRITICAL),
There is no 80 chars limit now, so feel free to define a clock in one line.

> +       CLK_SCALE_MODE(LS2K0300_CLK_NODE_SCALE,    "clk_node_scale",    "=
clk_node_pll_gate",
> +                      0x20, 0, 3, 3),
The same.

> +       /* DDR PLL */
> +       CLK_DIV(LS2K0300_CLK_DDR_DIV, "clk_ddr_div", "pll_ddr", 0x08, 24,=
 7),
> +       CLK_DIV(LS2K0300_CLK_NET_DIV, "clk_net_div", "pll_ddr", 0x0c, 0, =
7),
> +       CLK_DIV(LS2K0300_CLK_DEV_DIV, "clk_dev_div", "pll_ddr", 0x0c, 8, =
7),
> +       CLK_GATE(LS2K0300_CLK_NET_GATE,         "clk_net_gate", "clk_net_=
div", 0x08, 1),
> +       CLK_GATE(LS2K0300_CLK_DEV_GATE,         "clk_dev_gate", "clk_dev_=
div", 0x08, 2),
> +       CLK_GATE_FLAGS(LS2K0300_CLK_DDR_GATE,   "clk_ddr_gate", "clk_ddr_=
div",
> +                      0x08, 0, CLK_IS_CRITICAL),
The same.

> +       /* PIX PLL */
> +       CLK_DIV(LS2K0300_CLK_PIX_DIV,    "clk_pix_div",    "pll_pix", 0x1=
0, 24, 7),
> +       CLK_DIV(LS2K0300_CLK_GMACBP_DIV, "clk_gmacbp_div", "pll_pix", 0x1=
4, 0, 7),
> +       CLK_GATE(LS2K0300_CLK_PIX_PLL_GATE, "clk_pix_pll_gate", "clk_pix_=
div", 0x10, 0),
> +       CLK_GATE(LS2K0300_CLK_PIX_GATE,     "clk_pix_gate",     "clk_pix_=
scale", 0x24, 6),
> +       CLK_GATE(LS2K0300_CLK_GMACBP_GATE,  "clk_gmacbp_gate",  "clk_gmac=
bp_div", 0x10, 1),
> +       CLK_SCALE_MODE(LS2K0300_CLK_PIX_SCALE,  "clk_pix_scale",        "=
clk_pix_pll_gate",
> +                      0x20, 4, 3, 7),
The same.

> +       /* clk_dev_gate */
> +       CLK_DIV(LS2K0300_CLK_SDIO_SCALE, "clk_sdio_scale", "clk_dev_gate"=
, 0x20, 24, 4),
> +       CLK_GATE(LS2K0300_CLK_USB_GATE,  "clk_usb_gate",        "clk_usb_=
scale", 0x24, 2),
> +       CLK_GATE(LS2K0300_CLK_SDIO_GATE, "clk_sdio_gate",       "clk_sdio=
_scale", 0x24, 4),
> +       CLK_GATE(LS2K0300_CLK_APB_GATE,  "clk_apb_gate",        "clk_apb_=
scale", 0x24, 3),
> +       CLK_GATE_FLAGS(LS2K0300_CLK_BOOT_GATE, "clk_boot_gate", "clk_boot=
_scale",
> +                      0x24, 1, CLK_IS_CRITICAL),
The same.

Huacai

> +       CLK_SCALE_MODE(LS2K0300_CLK_USB_SCALE,  "clk_usb_scale",  "clk_de=
v_gate", 0x20, 12, 3, 15),
> +       CLK_SCALE_MODE(LS2K0300_CLK_APB_SCALE,  "clk_apb_scale",  "clk_de=
v_gate", 0x20, 16, 3, 19),
> +       CLK_SCALE_MODE(LS2K0300_CLK_BOOT_SCALE, "clk_boot_scale", "clk_de=
v_gate", 0x20, 8, 3, 11),
> +};
> +
>  static const struct loongson2_clk_board_info ls2k0500_clks[] =3D {
>         CLK_PLL(LOONGSON2_NODE_PLL,   "pll_node", 0,    16, 8, 8, 6),
>         CLK_PLL(LOONGSON2_DDR_PLL,    "pll_ddr",  0x8,  16, 8, 8, 6),
> @@ -393,6 +440,7 @@ static int loongson2_clk_probe(struct platform_device=
 *pdev)
>  }
>
>  static const struct of_device_id loongson2_clk_match_table[] =3D {
> +       { .compatible =3D "loongson,ls2k0300-clk", .data =3D &ls2k0300_cl=
ks },
>         { .compatible =3D "loongson,ls2k0500-clk", .data =3D &ls2k0500_cl=
ks },
>         { .compatible =3D "loongson,ls2k-clk", .data =3D &ls2k1000_clks }=
,
>         { .compatible =3D "loongson,ls2k2000-clk", .data =3D &ls2k2000_cl=
ks },
> --
> 2.50.1
>

