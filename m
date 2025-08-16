Return-Path: <linux-kernel+bounces-771876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B81B28C74
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25B71C818C2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8FA24BD04;
	Sat, 16 Aug 2025 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWylBKzm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110AD24A043;
	Sat, 16 Aug 2025 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755336794; cv=none; b=brdMc4mGbKdRzTK3no4xmFklOs9LAypu2i6o1suPs36qLz+npPJJnKuc+nLLUYYq8Q39FslL/9ENkc2j4KSIrRXxQfxLt0AMnUJVawQdxYbPj7yEcej5nrrybpqLwj6J0UOHVyvA0bNoYODAQKidYbqYgveKBXcZSUoxhCQiIqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755336794; c=relaxed/simple;
	bh=CGm9yLJptkx/owDsJQBhgom8+2ST8ifFCJpbZhGlWus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OumtKLtWjVgad+DeCbLrNK3+woiPX63Qb1MLfq/YL2HXHoK/MFz+OaPdBWksUhQjt1/bPYMCj/Q5c4K2L6cDO6KxQhKlBH2YSwAkD2DZRw9/taTBkNUx5/vJBtgOmaY+FX2Im2SFl9ufC8BhLFrVYDgHLKZq7UVoY7MGILg7nW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWylBKzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AFAC4CEEF;
	Sat, 16 Aug 2025 09:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755336793;
	bh=CGm9yLJptkx/owDsJQBhgom8+2ST8ifFCJpbZhGlWus=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LWylBKzmboh6g8QmqLgQs7AM6K5L8Ww3TEfU0JKccbD8j58oEDnl4gEKayAhdfpZX
	 r6zVnfVUCKMPN8BuOTY8mnF4r5G2Tzu21HFIQeU0kJ+0QX+v4PH/7CuRpUAPNWskel
	 fb1pLoAWdJAqchrxf38Z6rnzaWcq99jMrqZiXG+Nrcm38nek4IZ9+3o1x4aBT5e9pK
	 i4wA4r1F+z6jvEASMqrWEv0IjaHPQtYDi9tHRRnYQcF8enh9sqptmILGMUg9rP7pbH
	 iHMKhNcmlNzE9cJFcB8cWSA42xM8L8p0G+DwEwYFDaSC+wD2aD05H/GdbYcKeKa78g
	 ofyMhmRA4sUNg==
Message-ID: <484e4ff2-c7b2-4087-8850-5a972e7c82b4@kernel.org>
Date: Sat, 16 Aug 2025 11:33:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] phy: allwinner: a523: add USB3/PCIe PHY driver
To: iuncuim <iuncuim@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Andre Przywara
 <andre.przywara@arm.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20250816084700.569524-1-iuncuim@gmail.com>
 <20250816084700.569524-5-iuncuim@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250816084700.569524-5-iuncuim@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/08/2025 10:46, iuncuim wrote:
> +
> +	phy->reset = devm_reset_control_get(dev, NULL);
> +	if (IS_ERR(phy->reset)) {
> +		dev_err(dev, "failed to get reset control\n");
> +		return PTR_ERR(phy->reset);

Syntax is return dev_err_probe.

> +	}
> +
> +	phy->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(phy->regs))
> +		return PTR_ERR(phy->regs);
> +
> +	phy->regs_clk = phy->regs + PHY_CLK_OFFSET;
> +	if (IS_ERR(phy->regs_clk))
> +		return PTR_ERR(phy->regs_clk);
> +
> +	phy->phy = devm_phy_create(dev, NULL, &sun55i_usb3_pcie_phy_ops);
> +	if (IS_ERR(phy->phy)) {
> +		dev_err(dev, "failed to create PHY\n");
> +		return PTR_ERR(phy->phy);
> +	}
> +
> +	phy_set_drvdata(phy->phy, phy);
> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +
> +	ret = sun55i_usb3_pcie_clk_init(phy);
> +	if (ret)
> +		return ret;
> +	dev_info(phy->dev, "phy version is: 0x%x\n", readl(phy->regs));


This should be rather dev_dbg. See coding style.

> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static const struct of_device_id sun55i_usb3_pcie_phy_of_match[] = {
> +	{ .compatible = "allwinner,sun55i-a523-usb3-pcie-phy" },

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, sun55i_usb3_pcie_phy_of_match);
> +
> +static struct platform_driver sun55i_usb3_pcie_phy_driver = {
> +	.probe	= sun55i_usb3_pcie_phy_probe,
> +	.driver = {
> +		.of_match_table	= sun55i_usb3_pcie_phy_of_match,
> +		.name  = "sun55i-usb3-pcie-phy",
> +	}
> +};
> +module_platform_driver(sun55i_usb3_pcie_phy_driver);
> +
> +MODULE_DESCRIPTION("Allwinner A523 USB3/PCIe phy driver");
> +MODULE_AUTHOR("Mikhail Kalashnikov <iuncuim@gmail.com>");
> +MODULE_LICENSE("GPL");


Best regards,
Krzysztof

