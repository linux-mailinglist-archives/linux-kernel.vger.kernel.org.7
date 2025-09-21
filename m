Return-Path: <linux-kernel+bounces-826367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4232B8E558
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8165B189A876
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95D928D8E8;
	Sun, 21 Sep 2025 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kszijCFj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0276469D;
	Sun, 21 Sep 2025 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758486657; cv=none; b=BJP5nZo/DuugCmPOMqmfgil2HhCFI1ae/s/H8qswILbglci2vRSDqslLBatHXF1UiNEiwhKyv8Z738dFSayJgjBrGSJ7pCNacznoZRCbnCxGemxMxt1f9oIpDYcb1vRv5anfciJ67Bf5uRZ1G4f2J1KvEXp2yIpgm/Ogz0DXdhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758486657; c=relaxed/simple;
	bh=tUS6aLo3JFjUSfeZ3yczY2XUmq5jWkWh48tqLXUN0Co=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=s4M+eEPoASIaBJG+G39uAJOnyzYZTbV3edjFuQS1m2c21egdMpRYdDKhpMpg2g6Ep34Gfr9KkN7qkiE7x/oLXsogURlj+QEQqLzjpIaVudHkdibv9466STT5Exau8jHErbNI+mLkY3XB7nAr9YPds2ev3q6NvMKY+x/8w5ohTGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kszijCFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355EBC4CEE7;
	Sun, 21 Sep 2025 20:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758486657;
	bh=tUS6aLo3JFjUSfeZ3yczY2XUmq5jWkWh48tqLXUN0Co=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=kszijCFj2nT8L+yY1Al/CKfdBLdyDsARLfAhHi+A0xL+QYkknKDHpY0Dv2+Nhk6b9
	 RDrPhZ1WE54ygk4tm8SPkJr0gno2Sg1JQOEf31P26ksowu+NCeZFfR71b3eepty2Ub
	 2oihm3GQOeg0N4jkjyLiw7mFIbU1bCLAl/KPa9fI38KRZ68ySpFHEl4Kc5WJHm6A4k
	 L11q4N3LB2XjZR4mGZfUDYC63bWPTw+44PDLyxhKYLggDsDwjrb4vJ6Wm619DRfHwa
	 MVtlEBmdio5G2eSxYINAOSq7lJoG81GtmqTBLeJ3p8orB11uh34hCEL8+xGNmJ9vW5
	 3rZDchW5YDGTg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250917020539.3690324-4-ryan_chen@aspeedtech.com>
References: <20250917020539.3690324-1-ryan_chen@aspeedtech.com> <20250917020539.3690324-4-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v14 3/3] clk: aspeed: add AST2700 clock driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: Brian Masney <bmasney@redhat.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Mo Elbadry <elbadrym@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, William Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>, devicetree@vger.kernel.org, dkodihalli@nvidia.com, leohu@nvidia.com, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, ryan_chen <ryan_chen@aspeedtech.com>, spuranik@nvidia.com, wthai@nvidia.com
Date: Sun, 21 Sep 2025 13:30:55 -0700
Message-ID: <175848665572.4354.4488545150485789314@lazor>
User-Agent: alot/0.11

Quoting Ryan Chen (2025-09-16 19:05:39)
> diff --git a/drivers/clk/clk-ast2700.c b/drivers/clk/clk-ast2700.c
> new file mode 100644
> index 000000000000..7766bc17876f
> --- /dev/null
> +++ b/drivers/clk/clk-ast2700.c
> @@ -0,0 +1,1139 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 ASPEED Technology Inc.
> + * Author: Ryan Chen <ryan_chen@aspeedtech.com>
> + */
> +#include <linux/auxiliary_bus.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/of_platform.h>

Is this include used?

> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/units.h>
> +
> +#include <dt-bindings/clock/aspeed,ast2700-scu.h>
> +
> +#define SCU_CLK_12MHZ  (12 * HZ_PER_MHZ)
> +#define SCU_CLK_24MHZ  (24 * HZ_PER_MHZ)
> +#define SCU_CLK_25MHZ  (25 * HZ_PER_MHZ)
> +#define SCU_CLK_192MHZ (192 * HZ_PER_MHZ)

Please inline these where they're used to make it more readable and
shorter. We don't have to look at the definition of 192MHZ to know that
it is 192 MHz

> +
> +static const struct clk_div_table ast2700_clk_uart_div_table[] =3D {
> +       { 0x0, 1 },
> +       { 0x1, 13 },
> +       { 0 }
> +};
> +
> +static const struct clk_parent_data soc0_clkin[] =3D {
> +       { .fw_name =3D "soc0-clkin", .name =3D "soc0-clkin" },

This is wrong. Please use clk_hw pointers, or the .index member of
'struct clk_parent_data' instead of having both the .fw_name and .name
members set in the parent data. The .fw_name should match some string in
the DT binding for this device. The .name shouldn't be used unless we're
migrating existing code from string based parent descriptions to clk_hw
or clk_parent_data structures.

> +
> +static const struct clk_parent_data uart13clk[] =3D {

This isn't used.

> +       { .fw_name =3D "uart13clk", .name =3D "uart13clk" },
> +};
> +
> +static const struct clk_parent_data uart14clk[] =3D {

This isn't used.

> +       { .fw_name =3D "uart14clk", .name =3D "uart14clk" },
> +};
> +
> +static const struct clk_parent_data soc1_i3c[] =3D {
> +       { .fw_name =3D "soc1-i3c", .name =3D "soc1-i3c" },
> +};
> +
> +
> +static struct clk_hw *ast2700_clk_hw_register_hpll(void __iomem *reg,
> +                                                  const char *name, cons=
t char *parent_name,
> +                                                  struct ast2700_clk_ctr=
l *clk_ctrl)
> +{
> +       unsigned int mult, div;
> +       u32 val;
> +
> +       val =3D readl(clk_ctrl->base + SCU0_HWSTRAP1);
> +       if ((readl(clk_ctrl->base) & REVISION_ID) && (val & BIT(3))) {

This can be read once during probe and then passed as an argument?

> +               switch ((val & GENMASK(4, 2)) >> 2) {
> +               case 2:
> +                       return devm_clk_hw_register_fixed_rate(clk_ctrl->=
dev, name, NULL,
> +                                                              0, 1800 * =
HZ_PER_MHZ);
> +               case 3:
> +                       return devm_clk_hw_register_fixed_rate(clk_ctrl->=
dev, name, NULL,
> +                                                              0, 1700 * =
HZ_PER_MHZ);
> +               case 6:
> +                       return devm_clk_hw_register_fixed_rate(clk_ctrl->=
dev, name, NULL,
> +                                                              0, 1200 * =
HZ_PER_MHZ);
> +               case 7:
> +                       return devm_clk_hw_register_fixed_rate(clk_ctrl->=
dev, name, NULL,
> +                                                              0, 800 * H=
Z_PER_MHZ);
> +               default:
> +                       return ERR_PTR(-EINVAL);
> +               }
> +       } else if ((val & GENMASK(3, 2)) !=3D 0) {
> +               switch ((val & GENMASK(3, 2)) >> 2) {
> +               case 1:
> +                       return devm_clk_hw_register_fixed_rate(clk_ctrl->=
dev, name, NULL,
> +                                                              0, 1900 * =
HZ_PER_MHZ);
> +               case 2:
[...]
> +static int ast2700_clk_enable(struct clk_hw *hw)
> +{
> +       struct clk_gate *gate =3D to_clk_gate(hw);
> +       u32 clk =3D BIT(gate->bit_idx);
> +
> +       if (readl(gate->reg) & clk)
> +               writel(clk, gate->reg + 0x04);
> +
> +       return 0;
> +}
> +
> +static void ast2700_clk_disable(struct clk_hw *hw)
> +{
> +       struct clk_gate *gate =3D to_clk_gate(hw);
> +       u32 clk =3D BIT(gate->bit_idx);
> +
> +       /* Clock is set to enable, so use write to set register */
> +       writel(clk, gate->reg);
> +}
> +
> +static const struct clk_ops ast2700_clk_gate_ops =3D {
> +       .enable =3D ast2700_clk_enable,
> +       .disable =3D ast2700_clk_disable,
> +       .is_enabled =3D ast2700_clk_is_enabled,
> +};
> +
> +static struct clk_hw *ast2700_clk_hw_register_gate(struct device *dev, c=
onst char *name,
> +                                                  const struct clk_paren=
t_data *parent,
> +                                                  void __iomem *reg, u8 =
clock_idx,
> +                                                  unsigned long clk_gate=
_flags, spinlock_t *lock)
> +{
> +       struct clk_gate *gate;
> +       struct clk_hw *hw;
> +       struct clk_init_data init;
> +       int ret =3D -EINVAL;
> +
> +       gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
> +       if (!gate)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name =3D name;
> +       init.ops =3D &ast2700_clk_gate_ops;
> +       init.flags =3D clk_gate_flags;
> +       init.parent_names =3D parent ? &parent->name : NULL;

Don't use string names to describe parent child relationships.

> +       init.num_parents =3D parent ? 1 : 0;
> +
> +       gate->reg =3D reg;
> +       gate->bit_idx =3D clock_idx;
> +       gate->flags =3D 0;
> +       gate->lock =3D lock;
> +       gate->hw.init =3D &init;
> +
> +       hw =3D &gate->hw;
> +       ret =3D clk_hw_register(dev, hw);
> +       if (ret) {
> +               kfree(gate);
> +               hw =3D ERR_PTR(ret);
> +       }
> +
> +       return hw;
> +}
> +
> +static void ast2700_soc1_configure_i3c_clk(struct ast2700_clk_ctrl *clk_=
ctrl)
> +{
> +       if (readl(clk_ctrl->base + SCU1_REVISION_ID) & REVISION_ID) {
> +               u32 val;
> +
> +               /* I3C 250MHz =3D HPLL/4 */
> +               val =3D readl(clk_ctrl->base + SCU1_CLK_SEL2) & ~SCU1_CLK=
_I3C_DIV_MASK;
> +               val |=3D FIELD_PREP(SCU1_CLK_I3C_DIV_MASK, SCU1_CLK_I3C_D=
IV(4));
> +               writel(val, clk_ctrl->base + SCU1_CLK_SEL2);
> +       }
> +}
> +
> +static int ast2700_soc_clk_probe(struct platform_device *pdev)
> +{
> +       const struct ast2700_clk_data *clk_data;
> +       struct clk_hw_onecell_data *clk_hw_data;
> +       struct ast2700_clk_ctrl *clk_ctrl;
> +       struct device *dev =3D &pdev->dev;
> +       struct auxiliary_device *adev;
> +       void __iomem *clk_base;
> +       struct clk_hw **hws;
> +       char *reset_name;
> +       int ret;
> +       int i;
> +
> +       clk_ctrl =3D devm_kzalloc(dev, sizeof(*clk_ctrl), GFP_KERNEL);
> +       if (!clk_ctrl)
> +               return -ENOMEM;
> +       clk_ctrl->dev =3D dev;
> +       dev_set_drvdata(&pdev->dev, clk_ctrl);
> +
> +       spin_lock_init(&clk_ctrl->lock);
> +
> +       clk_base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(clk_base))
> +               return PTR_ERR(clk_base);
> +
> +       clk_ctrl->base =3D clk_base;
> +
> +       clk_data =3D device_get_match_data(dev);
> +       if (!clk_data)
> +               return -ENODEV;
> +
> +       clk_ctrl->clk_data =3D clk_data;
> +       reset_name =3D devm_kasprintf(dev, GFP_KERNEL, "reset%d", clk_dat=
a->scu);
> +
> +       clk_hw_data =3D devm_kzalloc(dev, struct_size(clk_hw_data, hws, c=
lk_data->nr_clks),
> +                                  GFP_KERNEL);
> +       if (!clk_hw_data)
> +               return -ENOMEM;
> +
> +       clk_hw_data->num =3D clk_data->nr_clks;
> +       hws =3D clk_hw_data->hws;
> +
> +       if (clk_data->scu)
> +               ast2700_soc1_configure_i3c_clk(clk_ctrl);
> +
> +       for (i =3D 0; i < clk_data->nr_clks; i++) {
> +               const struct ast2700_clk_info *clk =3D &clk_data->clk_inf=
o[i];
> +               void __iomem *reg;
> +
> +               if (clk->type =3D=3D CLK_FIXED) {
> +                       const struct ast2700_clk_fixed_rate_data *fixed_r=
ate =3D &clk->data.rate;
> +
> +                       hws[i] =3D devm_clk_hw_register_fixed_rate(dev, c=
lk->name, NULL, 0,
> +                                                                fixed_ra=
te->fixed_rate);
> +               } else if (clk->type =3D=3D CLK_FIXED_FACTOR) {
> +                       const struct ast2700_clk_fixed_factor_data *facto=
r =3D &clk->data.factor;
> +
> +                       hws[i] =3D devm_clk_hw_register_fixed_factor(dev,=
 clk->name,
> +                                                                  factor=
->parent->name,
> +                                                                  0, fac=
tor->mult, factor->div);
> +               } else if (clk->type =3D=3D DCLK_FIXED) {
> +                       const struct ast2700_clk_pll_data *pll =3D &clk->=
data.pll;
> +
> +                       reg =3D clk_ctrl->base + pll->reg;
> +                       hws[i] =3D ast2700_clk_hw_register_dclk(reg, clk-=
>name, clk_ctrl);
> +               } else if (clk->type =3D=3D CLK_HPLL) {
> +                       const struct ast2700_clk_pll_data *pll =3D &clk->=
data.pll;
> +
> +                       reg =3D clk_ctrl->base + pll->reg;
> +                       hws[i] =3D ast2700_clk_hw_register_hpll(reg, clk-=
>name,
> +                                                             pll->parent=
->name, clk_ctrl);
> +               } else if (clk->type =3D=3D CLK_PLL) {
> +                       const struct ast2700_clk_pll_data *pll =3D &clk->=
data.pll;
> +
> +                       reg =3D clk_ctrl->base + pll->reg;
> +                       hws[i] =3D ast2700_clk_hw_register_pll(i, reg, cl=
k->name,
> +                                                            pll->parent-=
>name, clk_ctrl);
> +               } else if (clk->type =3D=3D CLK_UART_PLL) {
> +                       const struct ast2700_clk_pll_data *pll =3D &clk->=
data.pll;
> +
> +                       reg =3D clk_ctrl->base + pll->reg;
> +                       hws[i] =3D ast2700_clk_hw_register_uartpll(reg, c=
lk->name,
> +                                                                pll->par=
ent->name, clk_ctrl);
> +               } else if (clk->type =3D=3D CLK_MUX) {
> +                       const struct ast2700_clk_mux_data *mux =3D &clk->=
data.mux;
> +
> +                       reg =3D clk_ctrl->base + mux->reg;
> +                       hws[i] =3D devm_clk_hw_register_mux_parent_data_t=
able(dev, clk->name,
> +                                                                        =
   mux->parents,
> +                                                                        =
   mux->num_parents, 0,
> +                                                                        =
   reg, mux->bit_shift,
> +                                                                        =
   mux->bit_width, 0,
> +                                                                        =
   NULL, &clk_ctrl->lock);
> +               } else if (clk->type =3D=3D CLK_MISC) {
> +                       const struct ast2700_clk_pll_data *misc =3D &clk-=
>data.pll;
> +
> +                       reg =3D clk_ctrl->base + misc->reg;
> +                       hws[i] =3D ast2700_clk_hw_register_misc(i, reg, c=
lk->name,
> +                                                             misc->paren=
t->name, clk_ctrl);
> +               } else if (clk->type =3D=3D CLK_DIVIDER) {
> +                       const struct ast2700_clk_div_data *div =3D &clk->=
data.div;
> +
> +                       reg =3D clk_ctrl->base + div->reg;
> +                       hws[i] =3D devm_clk_hw_register_divider_table(dev=
, clk->name,
> +                                                                   div->=
parent->name, 0,
> +                                                                   reg, =
div->bit_shift,
> +                                                                   div->=
bit_width, 0,
> +                                                                   div->=
div_table,
> +                                                                   &clk_=
ctrl->lock);
> +               } else if (clk->type =3D=3D CLK_GATE_ASPEED) {
> +                       const struct ast2700_clk_gate_data *gate =3D &clk=
->data.gate;
> +
> +                       reg =3D clk_ctrl->base + gate->reg;
> +                       hws[i] =3D ast2700_clk_hw_register_gate(dev, clk-=
>name, gate->parent,
> +                                                             reg, gate->=
bit, gate->flags,
> +                                                             &clk_ctrl->=
lock);
> +
> +               } else {
> +                       const struct ast2700_clk_gate_data *gate =3D &clk=
->data.gate;
> +
> +                       reg =3D clk_ctrl->base + gate->reg;
> +                       hws[i] =3D devm_clk_hw_register_gate_parent_data(=
dev, clk->name, gate->parent,
> +                                                                      0,=
 reg, clk->clk_idx, 0,
> +                                                                      &c=
lk_ctrl->lock);
> +               }
> +
> +               if (IS_ERR(hws[i]))
> +                       return PTR_ERR(hws[i]);
> +       }
> +
> +       ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, c=
lk_hw_data);
> +       if (ret)
> +               return ret;
> +
> +       adev =3D devm_auxiliary_device_create(dev, reset_name, (__force v=
oid *)clk_base);
> +       if (!adev)
> +               return -ENODEV;
> +
> +       return 0;
> +}
> +
[...]
> +static int __init clk_ast2700_init(void)
> +{
> +       return platform_driver_register(&ast2700_scu_driver);
> +}
> +arch_initcall(clk_ast2700_init);

Just use module_platform_driver()?

