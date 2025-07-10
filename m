Return-Path: <linux-kernel+bounces-725100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E065AFFACC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C15641D02
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E831289340;
	Thu, 10 Jul 2025 07:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rB+FnS+N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A3921B195;
	Thu, 10 Jul 2025 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132366; cv=none; b=LDvm0oN8RaaSZYUnsq0mXavsZvxi2VFuX1WyTKchU8PPwIGclv7TyXifrDRD6tWI6k4J7r86aMQe23h0s33gtuOP4Fy+oL9QZ6RRVLMTqoJgsk6uEcA7C/jU8fKgGLw+VOptQoPyd96xTHSSNiSmrHl0oRW6ZNRfKB6Trrl471w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132366; c=relaxed/simple;
	bh=S8zzqP7m8nDKjbkX5GeKEnyhQD//kGc7olrVD3SohzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRgC7QWCaedy4j2Z51l4GaYbUigdvJ6+mHY5UTd7q5zWpIiLr62Kxo0JaWZJxwrWw3xwmOii4D0+2mA2UCR6vxz4/p4voB9h5HRTBouzV/oK0Y5r3KzUIW3PI0XL8r3xxPcjaetGrz7QaVvbOVLrcUgBUGy/04urqoq9ca6uZqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rB+FnS+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D63C4CEE3;
	Thu, 10 Jul 2025 07:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752132365;
	bh=S8zzqP7m8nDKjbkX5GeKEnyhQD//kGc7olrVD3SohzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rB+FnS+NgGqBg7cfEhioIsVnv9NflbSh5+zGFkD7Q5AgHl9IJEWfX3+5wZQxvziiw
	 wNxrOF5iE7oWRaZgbznYwWp7XMTAF6kH5htQsgEaN07x4jmt6PVhn6/duqO7Z2VDgq
	 zMSKeMEWs7ZaumQHdsoDFlSFUuUcm7UCrI35ch8VQud98CT1DE7r1ecTnh5NPO+EgE
	 6hyLP4kEPWPb51HRxlZtEZQgFce2WzGPYVar3OHUfA0gwQm/FJGrW0aubh2SwJ0H1O
	 zy8tYOCpQNxpA4blXYUjXYxPc7lavF507PopQIhvqN+AGW3ofXYmSAbW5aV+rUgan0
	 gfV8l3glDHnaA==
Date: Thu, 10 Jul 2025 09:26:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Karthik Poduval <kpoduval@lab126.com>
Cc: jyxiong@amazon.com, miguel.lopes@synopsys.com, anishkmr@amazon.com, 
	vkoul@kernel.org, kishon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] phy: dw-dphy-rx: Add Synopsys DesignWare D-PHY RX
Message-ID: <20250710-sly-rigorous-silkworm-6d67ea@krzk-bin>
References: <cover.1752106239.git.kpoduval@lab126.com>
 <2383f8cf2a8f5e1b914d4cf9bd11674ed55876d2.1752106239.git.kpoduval@lab126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2383f8cf2a8f5e1b914d4cf9bd11674ed55876d2.1752106239.git.kpoduval@lab126.com>

On Wed, Jul 09, 2025 at 07:42:20PM -0700, Karthik Poduval wrote:
> +static const struct regmap_config dw_dphy_regmap_cfg1 = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.name = "dw-dhpy-cfg1",
> +	.fast_io = true,
> +};
> +
> +/**
> + * dw_dphy_regmap_cfg2 - Register map configuration for DW DPHY
> + * @reg_bits: Width of register address in bits (32)
> + * @val_bits: Width of register value in bits (32)
> + * @reg_stride: Number of bytes between registers (4)
> + * @name: Name identifier for this register map
> + * @fast_io: Flag to indicate fast I/O operations are supported
> + *
> + **/

Drop

> +static const struct regmap_config dw_dphy_regmap_cfg2 = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.name = "dw-dhpy-cfg2",
> +	.fast_io = true,
> +};
> +
> +/**
> + * dw_dphy_probe - Probe and initialize DW DPHY device
> + * @pdev: Platform device pointer
> + * Return: 0 on success, negative error code on failure
> + *
> + **/

Drop

> +static int dw_dphy_probe(struct platform_device *pdev)
> +{
> +	struct dw_dphy *dphy;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	struct phy_provider *phy_provider;
> +	int ret;
> +
> +	dphy = devm_kzalloc(&pdev->dev, sizeof(*dphy), GFP_KERNEL);
> +	if (!dphy)
> +		return -ENOMEM;
> +
> +	dphy->dt_data =
> +		(struct dt_data_dw_dphy *)of_device_get_match_data(&pdev->dev);
> +	dev_set_drvdata(&pdev->dev, dphy);
> +	dphy->dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	dphy->iomem_cfg1 = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(dphy->iomem_cfg1))
> +		return PTR_ERR(dphy->iomem_cfg1);
> +
> +	dphy->regmap_cfg1 =
> +		devm_regmap_init_mmio(dev, dphy->iomem_cfg1, &dw_dphy_regmap_cfg1);
> +	if (IS_ERR(dphy->regmap_cfg1))
> +		return PTR_ERR(dphy->regmap_cfg1);
> +
> +	ret = devm_regmap_field_bulk_alloc(dev, dphy->regmap_cfg1, dphy->rf_cfg1,
> +					   dw_dphy_v1_2_cfg1, DW_DPHY_RF_CFG1_MAX);
> +	if (ret < 0) {
> +		dev_err(dev, "Could not alloc RF\n");
> +		return ret;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	dphy->iomem_cfg2 = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(dphy->iomem_cfg2))
> +		return PTR_ERR(dphy->iomem_cfg2);
> +
> +	dphy->regmap_cfg2 = devm_regmap_init_mmio(dev, dphy->iomem_cfg2,
> +						 &dw_dphy_regmap_cfg2);
> +	if (IS_ERR(dphy->regmap_cfg2))
> +		return PTR_ERR(dphy->regmap_cfg2);
> +
> +	ret = devm_regmap_field_bulk_alloc(dev, dphy->regmap_cfg2, dphy->rf_cfg2,
> +					   dw_dphy_v1_2_cfg2, DW_DPHY_RF_CFG2_MAX);
> +	if (ret < 0) {
> +		dev_err(dev, "Could not alloc RF\n");
> +		return ret;
> +	}
> +
> +	dphy->phy = devm_phy_create(&pdev->dev, NULL, dphy->dt_data->phy_ops);
> +	if (IS_ERR(dphy->phy)) {
> +		dev_err(dev, "failed to create PHY\n");
> +		return PTR_ERR(dphy->phy);
> +	}
> +
> +	phy_set_drvdata(dphy->phy, dphy);
> +	phy_provider =
> +		devm_of_phy_provider_register(&pdev->dev, of_phy_simple_xlate);
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +/**
> + * dw_dphy_of_match - Device tree match table for DW DPHY
> + * @compatible: Compatible string to match device tree node
> + * @data: Pointer to configuration data for matched device
> + *
> + * Table of compatible strings and associated configuration data
> + * for supported DW DPHY variants.
> + * Currently supports:
> + * - DW DPHY v1.2 ("snps,dw-dphy-1p2")
> + *
> + **/

Drop

> +static const struct of_device_id dw_dphy_of_match[] = {
> +	{ .compatible = "snps,dw-dphy-1p2", .data = &dw_dphy_1p2 },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, dw_dphy_of_match);
> +
> +/**
> + * dw_dphy_platform_driver - Platform driver structure for DW DPHY
> + * @probe: Pointer to probe function called on device discovery
> + * @driver: Core driver structure containing:
> + *         - name: Driver name used for matching and debugging
> + *         - of_match_table: Table of compatible device tree matches
> + *
> + **/

Drop all such useless generic kerneldocs. Not helpful. Keep useful ones,
so ones not saying obvious parts of core


> +static struct platform_driver dw_dphy_platform_driver = {
> +	.probe		= dw_dphy_probe,

Best regards,
Krzysztof


