Return-Path: <linux-kernel+bounces-802275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4041AB45032
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1FA1C239FB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1188C26B951;
	Fri,  5 Sep 2025 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gxj5SjIz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C77514E2F2;
	Fri,  5 Sep 2025 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058424; cv=none; b=kMXKbaMJ+2zu8gcZtreNBuDncemtTzY6VW2vmyykJk8gna3DHcUFMsRdehgjtx+ZFd57n0m4OEwGpeUEZovymIEYTAhIPa5d8XoU/cqlqb2c2ZqIGWZ0eBreJydsChi8x0hAGFDb0rA7o9iUAdjKpIrYoJtOOHiuB82prmewqzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058424; c=relaxed/simple;
	bh=X9O/FE8yapu+Tkiylk8h8PPSZSi+4NrKdxIeBU484kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTKhTeb+Tt9yzUnIjzboQDOGjzOQxvUptyu3Ra8B9AY4aIjUdcG9Z4visN592TCC6AuzZWbXmZFFkv7JSZHyxcAvQ2n5BkVQSjCzdP4wZp74RtkFRG7+sDtmNvdstw7YI3jB6VUKZDLk8R/p8h9XJ+2Prb6KY/NVb8JFPG6fXnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gxj5SjIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EE9C4CEF1;
	Fri,  5 Sep 2025 07:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757058424;
	bh=X9O/FE8yapu+Tkiylk8h8PPSZSi+4NrKdxIeBU484kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gxj5SjIz8HB3amYF0S1DCJ+jzsknGXqtqizW8Ic844n58B0W/1NwOufsacin/xUOX
	 YzyBqXTRzstrJ8c8/a9xgCM+YVx8DnJGoMI3xY7HPoMD5oQBwUtdIxwAp7yLEEW8bV
	 CjueosZpoZFkTc/lRe+X6okqFErtp9eXDUocp9OoRTGJKWYYf0VISpKusxM/X+mFw4
	 Rt7lVsu3J8D++lKtMuLQaCsirDs1vJ6tjg0grnOIa63yBkRIv/NatX4Za1hvGMuBAq
	 q3Q3oXEvtBoDraxVrjORcIwytJ2Z0dbEW53ZmeRs2x8SPfhnUlO+7wIgUYnt/hlqMA
	 T0SdFDh79HDTg==
Date: Fri, 5 Sep 2025 09:47:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Woodrow Douglass <wdouglass@carnegierobotics.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] regulator: pf530x: Add a driver for the NXP
 PF5300 Regulator
Message-ID: <20250905-chirpy-utopian-platypus-bea05f@kuoka>
References: <20250902-pf530x-v6-0-ae5efea2198d@carnegierobotics.com>
 <20250902-pf530x-v6-2-ae5efea2198d@carnegierobotics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902-pf530x-v6-2-ae5efea2198d@carnegierobotics.com>

On Thu, Sep 04, 2025 at 04:44:36PM -0400, Woodrow Douglass wrote:
> +
> +static const struct regulator_ops pf530x_regulator_ops = {
> +	.enable = regulator_enable_regmap,
> +	.disable = regulator_disable_regmap,
> +	.is_enabled = regulator_is_enabled_regmap,
> +	.map_voltage = regulator_map_voltage_linear_range,
> +	.list_voltage = regulator_list_voltage_linear_range,
> +	.set_voltage_sel = regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel = regulator_get_voltage_sel_regmap,
> +	.get_status = pf530x_get_status,
> +	.get_error_flags = pf530x_get_error_flags,
> +	.set_bypass = regulator_set_bypass_regmap,
> +	.get_bypass = regulator_get_bypass_regmap,
> +};
> +
> +static struct linear_range vrange = REGULATOR_LINEAR_RANGE(500000, 0, 140, 5000);

This looks like could be const

> +
> +static struct regulator_desc pf530x_reg_desc = {

This as well (unless I missed something)

> +	.name = "SW1",
> +	.ops = &pf530x_regulator_ops,
> +	.linear_ranges = &vrange,
> +	.n_linear_ranges = 1,
> +	.type = REGULATOR_VOLTAGE,
> +	.id = 0,
> +	.owner = THIS_MODULE,
> +	.vsel_reg = PF530X_SW1_VOLT,
> +	.vsel_mask = 0xFF,
> +	.bypass_reg = PF530X_SW1_CTRL2,
> +	.bypass_mask = 0x07,
> +	.bypass_val_on = 0x07,
> +	.bypass_val_off = 0x00,
> +	.enable_reg = PF530X_SW1_CTRL1,
> +	.enable_mask = GENMASK(5, 2),
> +	.enable_val = GENMASK(5, 2),
> +	.disable_val = 0,
> +};
> +

...

> +	config.dev = chip->dev;
> +	config.driver_data = &pf530x_reg_desc;
> +	config.of_node = chip->dev->of_node;
> +	config.regmap = chip->regmap;
> +	config.init_data = init_data;
> +
> +	// the config parameter gets copied, it's ok to pass a pointer on the stack here
> +	rdev = devm_regulator_register(&client->dev, &pf530x_reg_desc, &config);
> +	if (IS_ERR(rdev)) {
> +		dev_err(&client->dev, "failed to register %s regulator\n", pf530x_reg_desc.name);
> +		return PTR_ERR(rdev);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id pf530x_dt_ids[] = {
> +	{ .compatible = "nxp,pf5300",},
> +	{ .compatible = "nxp,pf5301",},

Drop

> +	{ .compatible = "nxp,pf5302",},

Drop, that's the point of compatibility - less clutter in the drivers.

Best regards,
Krzysztof


