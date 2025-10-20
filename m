Return-Path: <linux-kernel+bounces-860770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F499BF0E43
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF6218A3334
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AE930103C;
	Mon, 20 Oct 2025 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e98zoSil"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360992FF16B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960429; cv=none; b=cmNbFXzPa64EQrsAHdVcGM/aFxsHXA4myzps7imVpoGwzQzanc8tC2z8suxnFs2X0Qnmw9I9kAvjNT0a/DIOGI9HBL1vK64qvuCJp1Zr+FAtIizL5BQdc2aNgcc6VFHIB7w6tdTO1sxXC3R3vNe5shMUcBJvK65vDEqxZEH8MqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960429; c=relaxed/simple;
	bh=4qujkQr4EkckgFAhQ5XlwTIFQvfBFbXCicgVyIawCXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqqeHUetiLh4BP7OSmhb6zAA1EyQgN0WSkGFvniZHGxRxPgEStl3mr1IyUvjzNR7LvaL+sbr7+bvcb5TWvwaBLnh/7f0U2BfJw/paBLWsIB908LRw9p0SDrP5FaMia5EzkUMMeOMvY93SFyrxN/RVdoWQ+Hdq6ONHHABJer+r6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e98zoSil; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63c09ff13aeso7797682a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760960424; x=1761565224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KPl2Um7I2lBVEhg+iDB6W2BYLR9yy3oT8b4PVEgHMKA=;
        b=e98zoSilovxWLl2kMmZEK6dF+U4Ae9hpk1M9dfW+SquR1ax+sd/sNc5OxVkuK3d/2r
         Z6kuUIftzuCvGdeGkJPXSC1uiLd7K6qof1BGtq9s8VHlMF1AGC65mxJOLN2kIbARvMeV
         lUKPeKBCQtVLTrQuCfkJUp149Xt4tl0FNnbBbNLgJOwM99LRR6GR7MliqyLLHoRBC+Se
         H7d9Uueq2UAJa1R7VD7TmPkuwis4nDQdFoJ6jRI+M5TSPqse5lVghgAIytqAOOJcq+h9
         CpnUuWxfMbqnVBZWPor7Snq1PdOz0Is83OTI0R767LPgw0Ztz0S64MxdvDwUeEBIkMDu
         TJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760960424; x=1761565224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPl2Um7I2lBVEhg+iDB6W2BYLR9yy3oT8b4PVEgHMKA=;
        b=W26FfspOVTX/orxzBfiVzrvlKcFG86goNaqfXiFBFxYwUpn4MgTUreBAi9saRFE9+r
         LjS5TP4mzvcck8tCeMnQVSoi8rYuv+oPeJzJiRbpReVxNMJVnYm7MsJ5k+CdHm1sw8NU
         4Hr1/6sqdFMrfUMcVhsraUA0n3NidL/6HbcPwAS+9aELPbjRrGPw+R92nUECWaIux1pv
         2PdzQHjJE987cBgGuZYlmDJp27vCBsiM9shfyeGWWwGCLdov7JPJhSTpmix0D2HbRO3f
         WItkvqtx4qzTXtZa0yVWq4asAe8rfo856EGRwjhPycfmUeLNTA+qXazuOi82ibThujLW
         3Ngg==
X-Forwarded-Encrypted: i=1; AJvYcCUcCfW3e1NuivGZOHSrefxbd+993/6sad3w4DXSMHOky5ta1xqp+mcRwajUO2ytbenZNqk3KiwAGvzlbGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHiikxksOjh8s14lJFoluZiC6SzwBpo8Uk8wRgfrK11vr/UVsU
	QM/MffxEjwJbKHxaUVEA4zh5HWATMj4SplAHVmlPVMyOkE57jYM+6mON
X-Gm-Gg: ASbGncueTXvH5gS4Ue1zOz58Ve6Gkx6je8+nOMuMDwEvmu7mjN+6aNQNi7bw+11kX9F
	DUxWm2zG1qSggAg+Yhatg2MRn1+ruocO9sqKSRpLvnMCz4pFMXbHvcvY8OytAfmI6St+Gt3BEKB
	vZnwKyqn6b/ETFsUFq5HypVraWVANO3s56HfBSzFKwRYe840gaP0NCTmo0H16HMom3E2INO/ooc
	3tHhDiKZHcpIrWj2prt+fEkEzjWb64ZKExN81COHOR2VNBwPpXdm8dqO0I55yqodR/RcaJOogmj
	HLRTQhiTRNL3SQV6+hg7wyzovc5iMWjKMZpWaOItzsAnFC13SGR+xWKPHlBGTEnn54fLwLJ8wlE
	4xGVNias5WaJjAFV9btlrzh2xrwM77SH1DeI8GI1zGiWSY4VCwdEr7wOsSx9a0zE+kovDcc27p7
	hQ8cvet85/TxQVtQsiyTWzZ56jBrVUpHHNiZZ0+doKnkU=
X-Google-Smtp-Source: AGHT+IHv0Y0doSGXPi8HpPtRdOnJc4jNXqRl53GERgwAGtBO/cFV9LV248sfpWgTh1PM9QwVQ56tPg==
X-Received: by 2002:a05:6402:510b:b0:63b:f157:bc2d with SMTP id 4fb4d7f45d1cf-63c1f62af3emr12187142a12.1.1760960424268;
        Mon, 20 Oct 2025 04:40:24 -0700 (PDT)
Received: from [10.25.213.231] ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4949998csm6438734a12.38.2025.10.20.04.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:40:23 -0700 (PDT)
Message-ID: <07a3b881-9ddf-477d-a027-32b3f9ee3d36@gmail.com>
Date: Mon, 20 Oct 2025 04:40:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] clk: imx: add driver for imx8ulp's sim lpav
To: Frank Li <Frank.li@nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Daniel Baluta <daniel.baluta@nxp.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-4-laurentiumihalcea111@gmail.com>
 <aPJVtzVyTYAhIFGp@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <aPJVtzVyTYAhIFGp@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/17/2025 7:41 AM, Frank Li wrote:
> On Fri, Oct 17, 2025 at 04:20:20AM -0700, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> The i.MX8ULP System Integration Module (SIM) LPAV module is a block
>> control module found inside the LPAV subsystem, which offers some clock
>> gating options and reset line assertion/de-assertion capabilities.
>>
>> Therefore, the clock gate management is supported by registering the
>> module's driver as a clock provider, while the reset capabilities are
>> managed via the auxiliary device API to allow the DT node to act as a
>> reset and clock provider.
>>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> ---
>>  drivers/clk/imx/Makefile               |   1 +
>>  drivers/clk/imx/clk-imx8ulp-sim-lpav.c | 211 +++++++++++++++++++++++++
>>  2 files changed, 212 insertions(+)
>>  create mode 100644 drivers/clk/imx/clk-imx8ulp-sim-lpav.c
>>
>> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
>> index 03f2b2a1ab63..208b46873a18 100644
>> --- a/drivers/clk/imx/Makefile
>> +++ b/drivers/clk/imx/Makefile
>> @@ -41,6 +41,7 @@ clk-imx-lpcg-scu-$(CONFIG_CLK_IMX8QXP) += clk-lpcg-scu.o clk-imx8qxp-lpcg.o
>>  clk-imx-acm-$(CONFIG_CLK_IMX8QXP) = clk-imx8-acm.o
>>
>>  obj-$(CONFIG_CLK_IMX8ULP) += clk-imx8ulp.o
>> +obj-$(CONFIG_CLK_IMX8ULP) += clk-imx8ulp-sim-lpav.o
>>
>>  obj-$(CONFIG_CLK_IMX1)   += clk-imx1.o
>>  obj-$(CONFIG_CLK_IMX25)  += clk-imx25.o
>> diff --git a/drivers/clk/imx/clk-imx8ulp-sim-lpav.c b/drivers/clk/imx/clk-imx8ulp-sim-lpav.c
>> new file mode 100644
>> index 000000000000..a67a0e50e1ce
>> --- /dev/null
>> +++ b/drivers/clk/imx/clk-imx8ulp-sim-lpav.c
>> @@ -0,0 +1,211 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2025 NXP
>> + */
>> +
>> +#include <dt-bindings/clock/imx8ulp-clock.h>
>> +
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#define SYSCTRL0 0x8
>> +
>> +#define IMX8ULP_HIFI_CLK_GATE(gname, cname, pname, bidx)	\
>> +	{							\
>> +		.name = gname "_cg",				\
>> +		.id = IMX8ULP_CLK_SIM_LPAV_HIFI_##cname,	\
>> +		.parent = { .fw_name = pname, .name = pname },	\
>> +		.bit = bidx,					\
>> +	}
>> +
>> +struct clk_imx8ulp_sim_lpav_data {
>> +	void __iomem *base;
>> +	struct regmap *regmap;
>> +	spinlock_t lock; /* shared by MUX, clock gate and reset */
>> +	unsigned long flags; /* for spinlock usage */
>> +	struct clk_hw_onecell_data clk_data; /*  keep last */
>> +};
>> +
>> +struct clk_imx8ulp_sim_lpav_gate {
>> +	const char *name;
>> +	int id;
>> +	const struct clk_parent_data parent;
>> +	u8 bit;
>> +};
>> +
>> +static struct clk_imx8ulp_sim_lpav_gate gates[] = {
>> +	IMX8ULP_HIFI_CLK_GATE("hifi_core", CORE, "hifi_core", 17),
>> +	IMX8ULP_HIFI_CLK_GATE("hifi_pbclk", PBCLK, "lpav_bus", 18),
>> +	IMX8ULP_HIFI_CLK_GATE("hifi_plat", PLAT, "hifi_plat", 19)
>> +};
>> +
>> +#ifdef CONFIG_RESET_CONTROLLER
> Needn't this ifdef because if CONFIG_RESET_CONTROLLER, reset driver will
> not probe, just register aux device is not harmful.


ah, yes, was meant to drop this. Will give it a try and do the change for V3 if everything

works well.


>
>> +static void clk_imx8ulp_sim_lpav_aux_reset_release(struct device *dev)
>> +{
>> +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
>> +
>> +	kfree(adev);
>> +}
>> +
>> +static void clk_imx8ulp_sim_lpav_unregister_aux_reset(void *data)
>> +{
>> +	struct auxiliary_device *adev = data;
>> +
>> +	auxiliary_device_delete(adev);
>> +	auxiliary_device_uninit(adev);
>> +}
>> +
>> +static int clk_imx8ulp_sim_lpav_register_aux_reset(struct platform_device *pdev)
>> +{
>> +	struct auxiliary_device *adev __free(kfree) = NULL;
>> +	int ret;
>> +
>> +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
>> +	if (!adev)
>> +		return -ENOMEM;
>> +
>> +	adev->name = "reset";
>> +	adev->dev.parent = &pdev->dev;
>> +	adev->dev.release = clk_imx8ulp_sim_lpav_aux_reset_release;
>> +
>> +	ret = auxiliary_device_init(adev);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to initialize aux dev\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = auxiliary_device_add(adev);
>> +	if (ret) {
>> +		auxiliary_device_uninit(adev);
>> +		dev_err(&pdev->dev, "failed to add aux dev\n");
>> +		return ret;
>> +	}
>> +
>> +	return devm_add_action_or_reset(&pdev->dev,
>> +					clk_imx8ulp_sim_lpav_unregister_aux_reset,
>> +					no_free_ptr(adev));
> use devm_auxiliary_device_create() to simple whole code.


good catch. Will give this a try and switch to it in next version if there's no issues.


>
>> +}
>> +#else
>> +static int clk_imx8ulp_sim_lpav_register_aux_reset(struct platform_device *pdev)
>> +{
>> +	return 0;
>> +}
>> +#endif /* CONFIG_RESET_CONTROLLER */
>> +
>> +static void clk_imx8ulp_sim_lpav_lock(void *arg) __acquires(&data->lock)
>> +{
>> +	struct clk_imx8ulp_sim_lpav_data *data = dev_get_drvdata(arg);
>> +
>> +	spin_lock_irqsave(&data->lock, data->flags);
>> +}
>> +
>> +static void clk_imx8ulp_sim_lpav_unlock(void *arg) __releases(&data->lock)
>> +{
>> +	struct clk_imx8ulp_sim_lpav_data *data = dev_get_drvdata(arg);
>> +
>> +	spin_unlock_irqrestore(&data->lock, data->flags);
>> +}
>> +
>> +static const struct regmap_config clk_imx8ulp_sim_lpav_regmap_cfg = {
>> +	.reg_bits = 32,
>> +	.val_bits = 32,
>> +	.reg_stride = 4,
>> +	.lock = clk_imx8ulp_sim_lpav_lock,
>> +	.unlock = clk_imx8ulp_sim_lpav_unlock,
> why need lock/unlock here, regmap already have lock to access one register.


yeah but we want to share the lock with the clock gate. I know we can theoretically do

something like "&regmap->spinlock" but the lock initialization (i.e. which lock we initialize)

depends on how we configure "struct regmap_config", which is why I think my proposal is

more robust since we don't depend on how we fill in the fields of "struct regmap_config"

(other than lock/unlock/lock_arg).


But then again I'm not fixated on current approach so if more people think it would

be better to just use "&regmap->spinlock" then I'll give that a try.


>
> Frank
>> +};
>> +
>> +static int clk_imx8ulp_sim_lpav_probe(struct platform_device *pdev)
>> +{
>> +	struct clk_imx8ulp_sim_lpav_data *data;
>> +	struct regmap_config regmap_config;
>> +	struct clk_hw *hw;
>> +	int i, ret;
>> +
>> +	data = devm_kzalloc(&pdev->dev,
>> +			    struct_size(data, clk_data.hws, ARRAY_SIZE(gates)),
>> +			    GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	dev_set_drvdata(&pdev->dev, data);
>> +
>> +	memcpy(&regmap_config, &clk_imx8ulp_sim_lpav_regmap_cfg, sizeof(regmap_config));
>> +	regmap_config.lock_arg = &pdev->dev;
>> +
>> +	/*
>> +	 * this lock is used directly by the clock gate and indirectly
>> +	 * by the reset and mux controller via the regmap API
>> +	 */
>> +	spin_lock_init(&data->lock);
>> +
>> +	data->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(data->base))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(data->base),
>> +				     "failed to ioremap base\n");
>> +	/*
>> +	 * although the clock gate doesn't use the regmap API to modify the
>> +	 * registers, we still need the regmap because of the reset auxiliary
>> +	 * driver and the MUX drivers, which use the parent device's regmap
>> +	 */
>> +	data->regmap = devm_regmap_init_mmio(&pdev->dev, data->base, &regmap_config);
>> +	if (IS_ERR(data->regmap))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(data->regmap),
>> +				     "failed to initialize regmap\n");
>> +
>> +	data->clk_data.num = ARRAY_SIZE(gates);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(gates); i++) {
>> +		hw = devm_clk_hw_register_gate_parent_data(&pdev->dev,
>> +							   gates[i].name,
>> +							   &gates[i].parent,
>> +							   CLK_SET_RATE_PARENT,
>> +							   data->base + SYSCTRL0,
>> +							   gates[i].bit,
>> +							   0x0, &data->lock);
>> +		if (IS_ERR(hw))
>> +			return dev_err_probe(&pdev->dev, PTR_ERR(hw),
>> +					     "failed to register %s gate\n",
>> +					     gates[i].name);
>> +
>> +		data->clk_data.hws[i] = hw;
>> +	}
>> +
>> +	ret = clk_imx8ulp_sim_lpav_register_aux_reset(pdev);
>> +	if (ret)
>> +		return dev_err_probe(&pdev->dev, ret,
>> +				     "failed to register aux reset\n");
>> +
>> +	ret = devm_of_clk_add_hw_provider(&pdev->dev,
>> +					  of_clk_hw_onecell_get,
>> +					  &data->clk_data);
>> +	if (ret)
>> +		return dev_err_probe(&pdev->dev, ret,
>> +				     "failed to register clk hw provider\n");
>> +
>> +	/* used to probe MUX child device */
>> +	return devm_of_platform_populate(&pdev->dev);
>> +}
>> +
>> +static const struct of_device_id clk_imx8ulp_sim_lpav_of_match[] = {
>> +	{ .compatible = "fsl,imx8ulp-sim-lpav" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, clk_imx8ulp_sim_lpav_of_match);
>> +
>> +static struct platform_driver clk_imx8ulp_sim_lpav_driver = {
>> +	.probe = clk_imx8ulp_sim_lpav_probe,
>> +	.driver = {
>> +		.name = "clk-imx8ulp-sim-lpav",
>> +		.of_match_table = clk_imx8ulp_sim_lpav_of_match,
>> +	},
>> +};
>> +module_platform_driver(clk_imx8ulp_sim_lpav_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("i.MX8ULP LPAV System Integration Module (SIM) clock driver");
>> +MODULE_AUTHOR("Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>");
>> --
>> 2.43.0
>>

