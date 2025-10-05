Return-Path: <linux-kernel+bounces-842479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F083EBBCCBE
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 23:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D2ED3484E1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 21:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9DB1E376C;
	Sun,  5 Oct 2025 21:56:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0162A1CF;
	Sun,  5 Oct 2025 21:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759701418; cv=none; b=CJuD1oRKmp5maRE+eUkxsPV+lC3RW4YzFWMjYRJkWdyN++fkpwW9Ge9vq7kUbyVDEVzW/flZ4EuL0fZ9aFOL3x+GInmV/QuRcQm+DzRZt0gbm5m7J9rou5/8a+EgMMBkTKttbz9qs/lPQM9lxuNCOEKfCqZ1NFdCaE0HpR/6K20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759701418; c=relaxed/simple;
	bh=ZPuLZMTDLLctIl395YutGFv90SdSy3FAHvE1GyuzzKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dbhxqmjutxc0KUMDFEtOOJs19xzXIv6NXlbzPxJYhZLNRuRd+CndVZijRTcInlvU96xkhj/nqpptpi9QoFBCiLGyUgotzKEvOwikdylJbV5TKsoa3OxCHLtRQfhGUwGtTxqi5ZJpR6KkfJcCPs1ZZWuFJbs8/WupXERJqnB8oRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDC7C4CEF4;
	Sun,  5 Oct 2025 21:56:57 +0000 (UTC)
Message-ID: <cd8e3d8c-314a-4a77-a3c1-665957f4ea9a@kernel.og>
Date: Sun, 5 Oct 2025 16:56:56 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] clk: socfpga: agilex5: add clock driver for Agilex5
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
 Dinh Nguyen <dinguyen@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>,
 "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Ang Tien Sung <tiensung.ang@altera.com>
References: <cover.1759482803.git.khairul.anuar.romli@altera.com>
 <e7e7e105327aafd54e58d1786a7a55ff0ea4aa9b.1759482803.git.khairul.anuar.romli@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.og>
In-Reply-To: <e7e7e105327aafd54e58d1786a7a55ff0ea4aa9b.1759482803.git.khairul.anuar.romli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/3/25 04:19, Khairul Anuar Romli wrote:
> Add the new Clock manager driver to support new Agilex5 platform. The new
> driver got rid of the clk_parent_data structures as there are no 'clock-names'
> property in the DT bindings and use parent_names internally. This is based on
> the previous feedback from the maintainer.
> 
> Signed-off-by: Ang Tien Sung <tiensung.ang@altera.com>
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
>   drivers/clk/socfpga/clk-agilex5.c    | 563 +++++++++++++++++++++++++++
>   drivers/clk/socfpga/clk-gate-s10.c   |  53 +++
>   drivers/clk/socfpga/clk-periph-s10.c |  41 ++
>   drivers/clk/socfpga/clk-pll-s10.c    |  38 +-
>   drivers/clk/socfpga/stratix10-clk.h  |  43 ++
>   5 files changed, 737 insertions(+), 1 deletion(-)

Do you want to add it a Makefile to build it?

>   create mode 100644 drivers/clk/socfpga/clk-agilex5.c
> 
> diff --git a/drivers/clk/socfpga/clk-agilex5.c b/drivers/clk/socfpga/clk-agilex5.c
> new file mode 100644
> index 000000000000..0013fab81357
> --- /dev/null
> +++ b/drivers/clk/socfpga/clk-agilex5.c
> @@ -0,0 +1,563 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022-2024, Intel Corporation
> + * Copyright (C) 2025, Altera Corporation
> + */
> +#include <linux/slab.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>

Remove of_device.h and of_address and just use of.h.

> +#include <linux/platform_device.h>
> +#include  <dt-bindings/clock/intel,agilex5-clkmgr.h>
> +#include "stratix10-clk.h"
> +#include "clk.h"
> +

<snip>


> +
> +static int
> +agilex5_clk_register_c_perip(const struct stratix10_perip_c_clock *clks,
> +			     int nums, struct stratix10_clock_data *data)
> +{
> +	struct clk_hw *hw_clk;
> +	void __iomem *base = data->base;
> +	int i;
> +
> +	for (i = 0; i < nums; i++) {
> +		hw_clk = s10_register_periph(&clks[i], base);
> +		if (IS_ERR(hw_clk)) {
> +			pr_err("%s: failed to register clock %s\n", __func__,
> +			       clks[i].name);
> +			continue;
> +		}
> +		data->clk_data.hws[clks[i].id] = hw_clk;
> +	}
> +	return 0;
> +}
> +
> +static int
> +agilex5_clk_register_cnt_perip(const struct agilex5_perip_cnt_clock *clks,
> +			       int nums, struct stratix10_clock_data *data)
> +{
> +	struct clk_hw *hw_clk;
> +	void __iomem *base = data->base;
> +	int i;
> +
> +	for (i = 0; i < nums; i++) {
> +		hw_clk = agilex5_register_cnt_periph(&clks[i], base);
> +		if (IS_ERR(hw_clk)) {
> +			pr_err("%s: failed to register clock %s\n", __func__,
> +			       clks[i].name);
> +			continue;
> +		}
> +		data->clk_data.hws[clks[i].id] = hw_clk;
> +	}
> +
> +	return 0;
> +}
> +
> +static int agilex5_clk_register_gate(const struct agilex5_gate_clock *clks,
> +				     int nums,
> +				     struct stratix10_clock_data *data)
> +{
> +	struct clk_hw *hw_clk;
> +	void __iomem *base = data->base;
> +	int i;
> +
> +	for (i = 0; i < nums; i++) {
> +		hw_clk = agilex5_register_gate(&clks[i], base);
> +		if (IS_ERR(hw_clk)) {
> +			pr_err("%s: failed to register clock %s\n", __func__,
> +			       clks[i].name);
> +			continue;
> +		}
> +		data->clk_data.hws[clks[i].id] = hw_clk;
> +	}
> +
> +	return 0;
> +}
> +
> +static int agilex5_clk_register_pll(const struct agilex5_pll_clock *clks,
> +				    int nums, struct stratix10_clock_data *data)
> +{
> +	struct clk_hw *hw_clk;
> +	void __iomem *base = data->base;
> +	int i;
> +
> +	for (i = 0; i < nums; i++) {
> +		hw_clk = agilex5_register_pll(&clks[i], base);
> +		if (IS_ERR(hw_clk)) {
> +			pr_err("%s: failed to register clock %s\n", __func__,
> +			       clks[i].name);
> +			continue;
> +		}
> +		data->clk_data.hws[clks[i].id] = hw_clk;
> +	}
> +
> +	return 0;
> +}
> +
> +static int agilex5_clkmgr_init(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct stratix10_clock_data *clk_data;
> +	struct resource *res;
> +	void __iomem *base;
> +	int i, num_clks;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(dev, res);

Use devm_platform_ioremap_resource() for simpler code.

> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	num_clks = AGILEX5_NUM_CLKS;
> +
> +	clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws, num_clks), GFP_KERNEL);
> +	if (!clk_data)
> +		return -ENOMEM;

Please take a look at commit "65f9e1becb55 clk: socfpga: agilex: Add 
bounds-checking coverage for struct stratix10_clock_data"


> +
> +	for (i = 0; i < num_clks; i++)
> +		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
> +
> +	clk_data->base = base;
> +	clk_data->clk_data.num = num_clks;
> +
> +	agilex5_clk_register_pll(agilex5_pll_clks, ARRAY_SIZE(agilex5_pll_clks),
> +				 clk_data);
> +
> +	/* mainPLL C0, C1, C2, C3 and periph PLL C0, C1, C2, C3*/
> +	agilex5_clk_register_c_perip(agilex5_main_perip_c_clks,
> +				     ARRAY_SIZE(agilex5_main_perip_c_clks),
> +				     clk_data);
> +
> +	agilex5_clk_register_cnt_perip(agilex5_main_perip_cnt_clks,
> +				       ARRAY_SIZE(agilex5_main_perip_cnt_clks),
> +				       clk_data);
> +
> +	agilex5_clk_register_gate(agilex5_gate_clks,
> +				  ARRAY_SIZE(agilex5_gate_clks), clk_data);
> +
> +	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &clk_data->clk_data);
> +	return 0;
> +}
> +
> +static int agilex5_clkmgr_probe(struct platform_device *pdev)
> +{
> +	int (*probe_func)(struct platform_device *init_func);
> +
> +	probe_func = of_device_get_match_data(&pdev->dev);
> +	if (!probe_func)
> +		return -ENODEV;
> +	return probe_func(pdev);
> +}
> +
> +static const struct of_device_id agilex5_clkmgr_match_table[] = {
> +	{ .compatible = "intel,agilex5-clkmgr", .data = agilex5_clkmgr_init },
> +	{}
> +};
> +
> +static struct platform_driver agilex5_clkmgr_driver = {
> +	.probe		= agilex5_clkmgr_probe,
> +	.driver		= {
> +		.name	= "agilex5-clkmgr",
> +		.suppress_bind_attrs = true,
> +		.of_match_table = agilex5_clkmgr_match_table,
> +	},
> +};
> +
> +static int __init agilex5_clk_init(void)
> +{
> +	return platform_driver_register(&agilex5_clkmgr_driver);
> +}
> +core_initcall(agilex5_clk_init);
> diff --git a/drivers/clk/socfpga/clk-gate-s10.c b/drivers/clk/socfpga/clk-gate-s10.c
> index 3930d922efb4..dce3ef137bf3 100644
> --- a/drivers/clk/socfpga/clk-gate-s10.c
> +++ b/drivers/clk/socfpga/clk-gate-s10.c
> @@ -239,3 +239,56 @@ struct clk_hw *agilex_register_gate(const struct stratix10_gate_clock *clks, voi
>   	}
>   	return hw_clk;
>   }
> +
> +struct clk_hw *agilex5_register_gate(const struct agilex5_gate_clock *clks, void __iomem *regbase)
> +{
> +	struct clk_hw *hw_clk;
> +	struct socfpga_gate_clk *socfpga_clk;
> +	struct clk_init_data init;
> +	int ret;
> +
> +	socfpga_clk = kzalloc(sizeof(*socfpga_clk), GFP_KERNEL);
> +	if (!socfpga_clk)
> +		return NULL;
> +
> +	socfpga_clk->hw.reg = regbase + clks->gate_reg;
> +	socfpga_clk->hw.bit_idx = clks->gate_idx;
> +
> +	gateclk_ops.enable = clk_gate_ops.enable;
> +	gateclk_ops.disable = clk_gate_ops.disable;
> +
> +	socfpga_clk->fixed_div = clks->fixed_div;
> +
> +	if (clks->div_reg)
> +		socfpga_clk->div_reg = regbase + clks->div_reg;
> +	else
> +		socfpga_clk->div_reg = NULL;
> +
> +	socfpga_clk->width = clks->div_width;
> +	socfpga_clk->shift = clks->div_offset;
> +
> +	if (clks->bypass_reg)
> +		socfpga_clk->bypass_reg = regbase + clks->bypass_reg;
> +	else
> +		socfpga_clk->bypass_reg = NULL;
> +	socfpga_clk->bypass_shift = clks->bypass_shift;
> +
> +	if (streq(clks->name, "cs_pdbg_clk"))
> +		init.ops = &dbgclk_ops;
> +	else
> +		init.ops = &agilex_gateclk_ops;
> +
> +	init.name = clks->name;
> +	init.flags = clks->flags;
> +	init.num_parents = clks->num_parents;
> +	init.parent_names = clks->parent_names;
> +	socfpga_clk->hw.hw.init = &init;
> +	hw_clk = &socfpga_clk->hw.hw;
> +
> +	ret = clk_hw_register(NULL, &socfpga_clk->hw.hw);
> +	if (ret) {
> +		kfree(socfpga_clk);
> +		return ERR_PTR(ret);
> +	}
> +	return hw_clk;
> +}
> diff --git a/drivers/clk/socfpga/clk-periph-s10.c b/drivers/clk/socfpga/clk-periph-s10.c
> index f5c1ca42b668..f12ca43ffe7c 100644
> --- a/drivers/clk/socfpga/clk-periph-s10.c
> +++ b/drivers/clk/socfpga/clk-periph-s10.c
> @@ -214,3 +214,44 @@ struct clk_hw *s10_register_cnt_periph(const struct stratix10_perip_cnt_clock *c
>   	}
>   	return hw_clk;
>   }
> +
> +struct clk_hw *agilex5_register_cnt_periph(const struct agilex5_perip_cnt_clock *clks,
> +					   void __iomem *regbase)
> +{
> +	struct clk_hw *hw_clk;
> +	struct socfpga_periph_clk *periph_clk;
> +	struct clk_init_data init;
> +	const char *name = clks->name;
> +	int ret;
> +
> +	periph_clk = kzalloc(sizeof(*periph_clk), GFP_KERNEL);
> +	if (WARN_ON(!periph_clk))
> +		return NULL;
> +
> +	if (clks->offset)
> +		periph_clk->hw.reg = regbase + clks->offset;
> +	else
> +		periph_clk->hw.reg = NULL;
> +
> +	if (clks->bypass_reg)
> +		periph_clk->bypass_reg = regbase + clks->bypass_reg;
> +	else
> +		periph_clk->bypass_reg = NULL;
> +	periph_clk->bypass_shift = clks->bypass_shift;
> +	periph_clk->fixed_div = clks->fixed_divider;
> +
> +	init.name = name;
> +	init.ops = &peri_cnt_clk_ops;
> +	init.flags = clks->flags;
> +	init.num_parents = clks->num_parents;
> +	init.parent_names = clks->parent_names;
> +	periph_clk->hw.hw.init = &init;
> +	hw_clk = &periph_clk->hw.hw;
> +
> +	ret = clk_hw_register(NULL, hw_clk);
> +	if (ret) {
> +		kfree(periph_clk);
> +		return ERR_PTR(ret);
> +	}
> +	return hw_clk;
> +}
> diff --git a/drivers/clk/socfpga/clk-pll-s10.c b/drivers/clk/socfpga/clk-pll-s10.c
> index a88c212bda12..ae80814cfa92 100644
> --- a/drivers/clk/socfpga/clk-pll-s10.c
> +++ b/drivers/clk/socfpga/clk-pll-s10.c
> @@ -182,7 +182,7 @@ static const struct clk_ops clk_pll_ops = {
>   };
>   
>   static const struct clk_ops clk_boot_ops = {
> -	.recalc_rate = clk_boot_clk_recalc_rate,
> +	.recalc_rate = clk_boot_clk_recalc_rate, /* TODO this is wrong*/

Do you know what's wrong with it? Maybe fix it first?


Dinh

