Return-Path: <linux-kernel+bounces-702547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C05AE83C0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 15:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F383D174407
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 13:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF17262FC1;
	Wed, 25 Jun 2025 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="f0IJlr5B"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E152E25E44D
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856891; cv=none; b=oTkfi8QXTTYCLd/vEotrStHkhST83VSiiilvMVXIaeISpQiLGSKhsJNzAzqFAbTDJzV/40TpII1qNG9U5o+2RuTUI/lHreIHZIOvIZ1M7KkS054He7FBI62y82G+Iw967NSjuMHknkTw198FQFZpkJdTuny8heiFpWurwrOM1do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856891; c=relaxed/simple;
	bh=F6DcXRoi0t6T7ZyzgYxJBAawMnwiCxokYxU36nifNqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WaivTYgTQEoNJytlDAwQtKNrHpgs9PEWoMLA6r/cmY5s5ekPE640VuAl7PjcTCSJss8Xj8y/pAToxTKxGNoHFRUMGlnZDjQGSppB4NDLtHdFg4xq23oJxJ3JxL9KrNfr07EXn1GozKSf61Z6WMnemGAN7rLHDgcgav7vyvH6Hj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=f0IJlr5B; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-555024588b1so50456e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1750856887; x=1751461687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YmZoc1HxYILMnzAwR8iICp8UEElHuji5dtRjcLwOJbk=;
        b=f0IJlr5B9qDbmyQRctCfPr+vbidEwy8QbicX6jBOSXN5sy6Nzh+CNxKbCZ9Vjx0DSd
         KfGe0tLAxjVyHMgd4bMcYv9FsTKoFjG8NsXRN91lQTTS2UZqxpNLLzh3iwpjYURQ1Y2A
         uGja+onTuNRmrrdjfzpvoj2o0PRjZmIRXQrzkHfQXOKdBokPlpYDfv5ANwVx5gmzqBH9
         L4bSl1R/Bcpm6U5NL4P6tT8j/HzvMI64eSgslVWEjKNd4yOkTrq+DLuhebOf2u0dTkJB
         pC3mP47gxUpNzrYrbT2ARzMVAL+Ttpudh+NXy7g/6j7DBZdHu8PuQv3ZjO4bVEcK3ljH
         l2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750856887; x=1751461687;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmZoc1HxYILMnzAwR8iICp8UEElHuji5dtRjcLwOJbk=;
        b=iQ/7IjosSJrQFIOPkBb7/DYinvMTZ4YD0kqRCDuKmit8Mu+1H5UNvAF1X4CPRfX0QM
         EnTIGMG5t8RPK7Qa5PXMJ8/w/SX4tYqNuWlkNek6X7v4z4HlQHasngAbce33nIS2rX6P
         R7sTib9VPotfkaqhlnCEtJq7a7YzE2psPtKMec38lZVGZJwbMTbWp2LGbo9+OtL+bZF9
         pvgPSBC0vg8XhUoudZJ3myt7bjjfV3NYbKBQThigXXjs0DP5ZrU1Uugmmsg5tLWx/Nh5
         5fWrKZyqAt4dNqYR8xcELoe9tgGLabVMVvpulKOzZc2wiIM0XI+piw5v+qh3rPM1CfFR
         x7QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa66/8oDECdtPSaps1RXUKT/y32MpRqVZ1LqW2zYvbxMVkyh4Iy5hTvik51i/shuIof4YAN4Q6BATEukc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpb0Tavi8F3eAfzshd3pM4pOeC4m92+4BiRw07GB8XJ2hoC4x2
	dt2Ji4RKbJzUAP2msv2F429baWqAySzKvBk0s3FqguZUcAJNPj8iVS9it0PX52K5EMM=
X-Gm-Gg: ASbGncv/VOjv3u7Z/RM1SpFlz5N/MkbQ2jLexstxnBeH4UlAqUG0U/ce3LnyKhUW5ub
	vTd6M3VKY1gfyGrijpvAAI1B7zCKIDVmVuq/V+FzoXR7C42Yvn5UUXi36Rid1+AMlBNu06D9/p5
	HXcPj8XGWsjsUVp7eytQ/9oGzmMwtIgmMBPtPf2LPjaXzymOqZb16XIO2hCRli30WbpAOF1lcmS
	FOxxcTl+ouMZKPC8QINKdgKgcxk+oRIx/FJ5dn7nVOV0dvsp9/Eizb7FRmnzFxmgtPP6FNb+TtH
	Oa3bqoxhjgWjCNuTOu/X65D9kzbNeM2fZPpr7AMZdFT4uTK0OhRFnwVaHGoAlrRJhE0+J5hEzTP
	ZM8P4kA==
X-Google-Smtp-Source: AGHT+IFdium0N0x3+pNtSeitx12z4cp08x0a9rOtFbjQ4k2/wcmgeo8a+KMS+HSZv8k/LAxLrq+1iw==
X-Received: by 2002:a05:6512:10c5:b0:553:543d:d996 with SMTP id 2adb3069b0e04-554fdd1d8aemr1072459e87.33.1750856884969;
        Wed, 25 Jun 2025 06:08:04 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f196f3bsm2487591a12.9.2025.06.25.06.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 06:08:04 -0700 (PDT)
Message-ID: <23153135-fc04-4c8e-88cf-639f3dd39c7a@tuxon.dev>
Date: Wed, 25 Jun 2025 16:08:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] PCI: rzg3s-host: Add Initial PCIe Host Driver for
 Renesas RZ/G3S SoC
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 john.madieu.xa@bp.renesas.com,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250530111917.1495023-1-claudiu.beznea.uj@bp.renesas.com>
 <20250530111917.1495023-5-claudiu.beznea.uj@bp.renesas.com>
 <764d3uocv4kj6mrciaumoazwnquxhtn7u33u6v3a7tjwqhiyxf@2rtfsjyzny37>
 <z7o26wizu5j3sft67yjbe2hgvqz7lqtsimgklzrvvwytahrhrd@rquvx32ctqtc>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <z7o26wizu5j3sft67yjbe2hgvqz7lqtsimgklzrvvwytahrhrd@rquvx32ctqtc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Manivannan,

On 20.06.2025 22:35, Manivannan Sadhasivam wrote:
> On Wed, Jun 18, 2025 at 11:12:28PM +0530, Manivannan Sadhasivam wrote:
>> On Fri, May 30, 2025 at 02:19:13PM +0300, Claudiu wrote:
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
>>> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
>>> only as a root complex, with a single-lane (x1) configuration. The
>>> controller includes Type 1 configuration registers, as well as IP
>>> specific registers (called AXI registers) required for various adjustments.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>> ---
> 
> [...]
> 
>>> +static int rzg3s_pcie_msi_setup(struct rzg3s_pcie_host *host)
>>> +{
>>> +	size_t size = RZG3S_PCI_MSI_INT_NR * sizeof(u32);
>>> +	struct rzg3s_pcie_msi *msi = &host->msi;
>>> +	struct device *dev = host->dev;
>>> +	int id, ret;
>>> +
>>> +	msi->pages = __get_free_pages(GFP_KERNEL | GFP_DMA, 0);
>>> +	if (!msi->pages)
>>> +		return -ENOMEM;
>>> +
>>> +	msi->dma_addr = dma_map_single(dev, (void *)msi->pages, size * 2,
>>> +				       DMA_BIDIRECTIONAL);
>>> +	if (dma_mapping_error(dev, msi->dma_addr)) {
>>> +		ret = -ENOMEM;
>>> +		goto free_pages;
>>> +	}
> 
> Why can't you use dma_alloc_coherent()?

I just wanted to be mapped.

Controller needs the address returned here to fit into one of the AXI
windows. This address is just configured into the controller registers and
not used anywhere else in the current code.

> 
>>> +
>>> +	/*
>>> +	 * According to the RZ/G3S HW manual (Rev.1.10, section 34.4.5.2 Setting
>>> +	 * the MSI Window) the MSI window need to be within any AXI window. Find
>>> +	 * an AXI window to setup the MSI window.
>>> +	 */
>>> +	for (id = 0; id < RZG3S_MAX_WINDOWS; id++) {
>>> +		u64 base, basel, baseu;
>>> +		u64 mask, maskl, masku;
>>> +
>>> +		basel = readl(host->axi + RZG3S_PCI_AWBASEL(id));
>>> +		/* Skip checking this AXI window if it's not enabled */
>>> +		if (!(basel & RZG3S_PCI_AWBASEL_WIN_ENA))
>>> +			continue;
>>> +
>>> +		baseu = readl(host->axi + RZG3S_PCI_AWBASEU(id));
>>> +		base = baseu << 32 | basel;
>>> +
>>> +		maskl = readl(host->axi + RZG3S_PCI_AWMASKL(id));
>>> +		masku = readl(host->axi + RZG3S_PCI_AWMASKU(id));
>>> +		mask = masku << 32 | maskl;
>>> +
>>> +		if (msi->dma_addr < base || msi->dma_addr > base + mask)
>>> +			continue;
>>> +
>>> +		break;
>>> +	}
>>> +
>>> +	if (id == RZG3S_MAX_WINDOWS) {
>>> +		ret = -EINVAL;
>>> +		goto dma_unmap;
>>> +	}
>>> +
>>> +	/* The MSI base address need to be aligned to the MSI size */
>>> +	msi->window_base = ALIGN(msi->dma_addr, size);
>>> +	if (msi->window_base < msi->dma_addr) {
>>> +		ret = -EINVAL;
>>> +		goto dma_unmap;
>>> +	}
>>> +
>>> +	rzg3s_pcie_msi_hw_setup(host);
>>> +
>>> +	return 0;
>>> +
>>> +dma_unmap:
>>> +	dma_unmap_single(dev, msi->dma_addr, size * 2, DMA_BIDIRECTIONAL);
>>> +free_pages:
>>> +	free_pages(msi->pages, 0);
>>> +	return ret;
>>> +}
>>> +
>>> +static int rzg3s_pcie_msi_enable(struct rzg3s_pcie_host *host)
>>> +{
>>> +	struct platform_device *pdev = to_platform_device(host->dev);
>>> +	struct rzg3s_pcie_msi *msi = &host->msi;
>>> +	struct device *dev = host->dev;
>>> +	const char *devname;
>>> +	int irq, ret;
>>> +
>>> +	mutex_init(&msi->map_lock);
>>> +
>>> +	irq = platform_get_irq_byname(pdev, "msi");
>>> +	if (irq < 0)
>>> +		return dev_err_probe(dev, irq ? irq : -EINVAL,
>>> +				     "Failed to get MSI IRQ!\n");
>>> +
>>> +	devname = devm_kasprintf(dev, GFP_KERNEL, "%s-msi", dev_name(dev));
>>> +	if (!devname)
>>> +		return -ENOMEM;
>>> +
>>> +	ret = rzg3s_pcie_msi_allocate_domains(msi);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = devm_request_irq(dev, irq, rzg3s_pcie_msi_irq, 0, devname, host);
>>> +	if (ret) {
>>> +		dev_err_probe(dev, ret, "Failed to request IRQ: %d\n", ret);
>>> +		goto free_domains;
>>> +	}
>>> +
> 
> So you've modelled INTx as hierarchial IRQ domain, but not MSI. May I know why?

MSI domain created in rzg3s_pcie_msi_allocate_domains() is created with
pci_msi_create_irq_domain() that calls msi_create_irq_domain() ->
__msi_create_irq_domain() -> irq_domain_create_hierarchy()

I noticed other drivers are doing it similarly (e.g.
drivers/pci/controller/mobiveil/pcie-mobiveil-host.c).

Am I missing something?

> Both are chained to GIC, isn't it?

Yes, both are chained to GIC.

> 
>>> +	ret = rzg3s_pcie_msi_setup(host);
>>> +	if (ret) {
>>> +		dev_err_probe(dev, ret, "Failed to setup MSI!\n");
>>> +		goto free_domains;
>>> +	}
>>> +
>>> +	return 0;
>>> +
>>> +free_domains:
>>> +	rzg3s_pcie_msi_free_domains(msi);
>>> +	return ret;
>>> +}
>>> +
> 
> [...]
> 
>>> +static int rzg3s_soc_pcie_init_phy(struct rzg3s_pcie_host *host)
>>> +{
>>> +	static const u32 xcfgd_settings[RZG3S_PCI_PHY_XCFGD_NUM] = {
>>> +		[8]  = 0xe0006801, 0x007f7e30, 0x183e0000, 0x978ff500,
>>> +		       0xec000000, 0x009f1400, 0x0000d009,
>>> +		[17] = 0x78000000,
>>> +		[19] = 0x00880000, 0x000005c0, 0x07000000, 0x00780920,
>>> +		       0xc9400ce2, 0x90000c0c, 0x000c1414, 0x00005034,
>>> +		       0x00006000, 0x00000001,
>>> +	};
>>> +	static const u32 xcfga_cmn_settings[RZG3S_PCI_PHY_XCFGA_CMN_NUM] = {
>>> +		0x00000d10, 0x08310100, 0x00c21404, 0x013c0010, 0x01874440,
>>> +		0x1a216082, 0x00103440, 0x00000080, 0x00000010, 0x0c1000c1,
>>> +		0x1000c100, 0x0222000c, 0x00640019, 0x00a00028, 0x01d11228,
>>> +		0x0201001d,
>>> +	};
>>> +	static const u32 xcfga_rx_settings[RZG3S_PCI_PHY_XCFGA_RX_NUM] = {
>>> +		0x07d55000, 0x030e3f00, 0x00000288, 0x102c5880, 0x0000000b,
>>> +		0x04141441, 0x00641641, 0x00d63d63, 0x00641641, 0x01970377,
>>> +		0x00190287, 0x00190028, 0x00000028,
>>> +	};
>>> +
>>> +	writel(RZG3S_PCI_PERM_PIPE_PHY_REG_EN, host->axi + RZG3S_PCI_PERM);
>>> +
>>> +	for (u8 i = 0; i < RZG3S_PCI_PHY_XCFGD_NUM; i++)
>>> +		writel(xcfgd_settings[i], host->axi + RZG3S_PCI_PHY_XCFGD(i));
>>> +
>>> +	for (u8 i = 0; i < RZG3S_PCI_PHY_XCFGA_CMN_NUM; i++) {
>>> +		writel(xcfga_cmn_settings[i],
>>> +		       host->axi + RZG3S_PCI_PHY_XCFGA_CMN(i));
>>> +	}
>>> +
>>> +	for (u8 i = 0; i < RZG3S_PCI_PHY_XCFGA_RX_NUM; i++) {
>>> +		writel(xcfga_rx_settings[i],
>>> +		       host->axi + RZG3S_PCI_PHY_XCFGA_RX(i));
>>> +	}
>>> +
>>> +	writel(0x107, host->axi + RZG3S_PCI_PHY_XCFGA_TX);
>>> +
>>> +	/* Select PHY settings values */
>>> +	writel(RZG3S_PCI_PHY_XCFG_CTRL_PHYREG_SEL,
>>> +	       host->axi + RZG3S_PCI_PHY_XCFG_CTRL);
>>> +
>>> +	writel(0, host->axi + RZG3S_PCI_PERM);
>>> +
>>> +	return 0;
>>> +}
> 
> Why didn't these go into a PHY driver? Please provide justification.

It has been explained in the review of v1:

Registers are at separate offset compared to AXI and PCIe registers. But
they are all part of the PCIe controller address space, same
clocks are used to access them, same resets.

I thought implemeting it as a separate driver considering that I will
attach it to the auxiliary bus. For that, if I'm not wrong, I would have
been registering that PHY driver from this PCIe driver probe function and
later on, in the PCIe driver probe, I would have been requesting the same
previously registered PHY. For this, I consider to be overcomplicated thus
I ended up having it as proposed here.

Please let me know if you prefer to have the reasoning of this as a comment
in this driver or if you see it otherwise implemented.

> 
>>> +
>>> +static void rzg3s_pcie_pm_runtime_put(void *data)
>>> +{
>>> +	pm_runtime_put_sync(data);
>>> +}
>>> +
> 
> [...]
> 
>>> +static int rzg3s_pcie_probe(struct platform_device *pdev)
>>> +{
>>> +	struct pci_host_bridge *bridge;
>>> +	struct device *dev = &pdev->dev;
>>> +	struct device_node *np = dev->of_node;
>>> +	struct device_node *sysc_np __free(device_node) =
>>> +		of_parse_phandle(np, "renesas,sysc", 0);
>>> +	struct rzg3s_pcie_host *host;
>>> +	int ret;
>>> +
>>> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*host));
>>> +	if (!bridge)
>>> +		return -ENOMEM;
>>> +
>>> +	host = pci_host_bridge_priv(bridge);
>>> +	host->dev = dev;
>>> +	host->data = device_get_match_data(dev);
>>> +	platform_set_drvdata(pdev, host);
>>> +
>>> +	host->axi = devm_platform_ioremap_resource(pdev, 0);
>>> +	if (IS_ERR(host->axi))
>>> +		return PTR_ERR(host->axi);
>>> +	host->pcie = host->axi + RZG3S_PCI_CFG_BASE;
>>> +
>>> +	ret = of_property_read_u32(np, "vendor-id", &host->vendor_id);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = of_property_read_u32(np, "device-id", &host->device_id);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	host->sysc = syscon_node_to_regmap(sysc_np);
>>> +	if (IS_ERR(host->sysc))
>>> +		return PTR_ERR(host->sysc);
>>> +
>>> +	ret = regmap_update_bits(host->sysc, RZG3S_SYS_PCIE_RST_RSM_B,
>>> +				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
>>> +				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 1));
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = devm_add_action_or_reset(dev, rzg3s_pcie_sysc_signal_action,
>>> +				       host->sysc);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = rzg3s_pcie_resets_prepare(host);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = devm_pm_runtime_enable(dev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = pm_runtime_resume_and_get(dev);
>>> +	if (ret)
>>> +		return ret;
> 
> Why do you need runtime PM?

The clocks of this controller are managed though a clock power domain.


> Do you need to enable any parent domain before
> intializing the controller?

No, the power domain controls the IP clocks only.

> 
>>> +
>>> +	ret = devm_add_action_or_reset(dev, rzg3s_pcie_pm_runtime_put, dev);
>>> +	if (ret)
>>> +		return ret;
>>> +
> 
> Why is this needed?

To keep the failure path simpler. It reverts the
pm_runtime_resume_and_get() call above.

> 
>>> +	raw_spin_lock_init(&host->hw_lock);
>>> +
>>> +	ret = rzg3s_pcie_host_setup(host, rzg3s_pcie_intx_setup,
>>> +				    rzg3s_pcie_msi_enable, true);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	bridge->sysdata = host;
>>> +	bridge->ops = &rzg3s_pcie_root_ops;
>>> +	bridge->child_ops = &rzg3s_pcie_child_ops;
>>> +	ret = pci_host_probe(bridge);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return devm_add_action_or_reset(dev, rzg3s_pcie_host_remove_action,
>>> +					host);
> 
> Is this a workaround for not having a .remove() callback?

I used devm actions or resets to keep the failure path simpler. Having this
one was explictly proposed in the review process of v1:
https://lore.kernel.org/all/28195126-8dd4-4a61-91b9-fb65aea6d420@tuxon.dev/

> 
>>> +}
>>> +
>>> +static int rzg3s_pcie_suspend_noirq(struct device *dev)
>>> +{
>>> +	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
>>> +	const struct rzg3s_pcie_soc_data *data = host->data;
>>> +	struct regmap *sysc = host->sysc;
>>> +	int ret;
>>> +
>>> +	ret = pm_runtime_put_sync(dev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = reset_control_bulk_assert(data->num_power_resets,
>>> +					host->power_resets);
>>> +	if (ret)
>>> +		goto rpm_restore;
>>> +
>>> +	ret = reset_control_bulk_assert(data->num_cfg_resets,
>>> +					host->cfg_resets);
>>> +	if (ret)
>>> +		goto power_resets_restore;
>>> +
>>> +	ret = regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
>>> +				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
>>> +				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 0));
>>> +	if (ret)
>>> +		goto cfg_resets_restore;
> 
> Don't you need to control the endpoint state here? Like putting it into D3Cold,
> toggling PERST#, enabling wakeup etc...?

The role of the RZG3S_SYS_PCIE_RST_RSM_B signal is to signal to the PCIe
PHY that the power to the PHY was applied. Software need to set this
before/after power to the PHY is turned off/on.

The rzg3s_pcie_set_max_link_speed() don't progress further if the link is
not L0. AFAIK, this corresponds to D0 on the endpoint side. Please correct
me if I'm wrong.

The controller don't have specific registers to set the PERST#. I think
this may be controlled though the IP resets. I need to check. Should I add
a PCI_PM_D3COLD_WAIT delay after all resets are de-asserted?

In the next version I am going to add a delay msleep(PCIE_T_RRS_READY_MS)
before enumerating devices as suggested by Bjorn.

> 
>>> +
>>> +	return 0;
>>> +
>>> +	/* Restore the previous state if any error happens */
>>> +cfg_resets_restore:
>>> +	reset_control_bulk_deassert(data->num_cfg_resets,
>>> +				    host->cfg_resets);
>>> +power_resets_restore:
>>> +	reset_control_bulk_deassert(data->num_power_resets,
>>> +				    host->power_resets);
>>> +rpm_restore:
>>> +	pm_runtime_resume_and_get(dev);
>>> +	return ret;
>>> +}
>>> +
>>> +static int rzg3s_pcie_resume_noirq(struct device *dev)
>>> +{
>>> +	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
>>> +	const struct rzg3s_pcie_soc_data *data = host->data;
>>> +	struct regmap *sysc = host->sysc;
>>> +	int ret;
>>> +
>>> +	ret = regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
>>> +				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
>>> +				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 1));
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/*
>>> +	 * According to the RZ/G3S HW manual (Rev.1.10, section
>>> +	 * 34.5.1.2 De-asserting the Reset) the PCIe IP needs to wait 5ms from
>>> +	 * power on to the de-assertion of reset.
>>> +	 */
>>> +	usleep_range(5000, 5100);
>>> +	ret = reset_control_bulk_deassert(data->num_power_resets,
>>> +					  host->power_resets);
>>> +	if (ret)
>>> +		goto assert_rst_rsm_b;
>>> +
>>> +	ret = pm_runtime_resume_and_get(dev);
>>> +	if (ret)
>>> +		goto assert_power_resets;
>>> +
>>> +	ret = rzg3s_pcie_host_setup(host, NULL, rzg3s_pcie_msi_hw_setup, false);
>>> +	if (ret)
>>> +		goto rpm_put;
>>> +
>>> +	return 0;
>>> +
>>> +	/*
>>> +	 * If any error happens there is no way to recover the IP. Put it in the
>>> +	 * lowest possible power state.
>>> +	 */
>>> +rpm_put:
>>> +	pm_runtime_put_sync(dev);
>>> +assert_power_resets:
>>> +	reset_control_bulk_assert(data->num_power_resets,
>>> +				  host->power_resets);
>>> +assert_rst_rsm_b:
>>> +	regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
>>> +			   RZG3S_SYS_PCIE_RST_RSM_B_MASK,
>>> +			   FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 0));
>>> +	return ret;
>>> +}
>>> +
>>> +static const struct dev_pm_ops rzg3s_pcie_pm_ops = {
>>> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(rzg3s_pcie_suspend_noirq,
>>> +				  rzg3s_pcie_resume_noirq)
>>> +};
>>> +
>>> +const char * const rzg3s_soc_power_resets[] = {
>>> +	"aresetn", "rst_cfg_b", "rst_load_b",
>>> +};
>>> +
>>> +const char * const rzg3s_soc_cfg_resets[] = {
>>> +	"rst_b", "rst_ps_b", "rst_gp_b", "rst_rsm_b",
>>> +};
>>> +
>>> +static const struct rzg3s_pcie_soc_data rzg3s_soc_data = {
>>> +	.power_resets = rzg3s_soc_power_resets,
>>> +	.num_power_resets = ARRAY_SIZE(rzg3s_soc_power_resets),
>>> +	.cfg_resets = rzg3s_soc_cfg_resets,
>>> +	.num_cfg_resets = ARRAY_SIZE(rzg3s_soc_cfg_resets),
>>> +	.init_phy = rzg3s_soc_pcie_init_phy,
>>> +};
> 
> Are you expecting these callbacks to be different in next gen SoCs?

Yes, we have prepared the support for another SoC (RZ/G3E). That one have
different resets (only "aresetn"), cfg_resets are handled though PCIe
specific registers, and there is no need for phy init.

> I'd
> recommend to get rid of callbacks until the support for newer SoCs get added.

I agree with this. I did it like this as the driver got cleaner this way,
to me. I can revert it, if any. Please let me know.

> 
>>> +
>>> +static const struct of_device_id rzg3s_pcie_of_match[] = {
>>> +	{
>>> +		.compatible = "renesas,r9a08g045s33-pcie",
>>> +		.data = &rzg3s_soc_data,
>>> +	},
>>> +	{},
>>> +};
>>> +
>>> +static struct platform_driver rzg3s_pcie_driver = {
>>> +	.driver = {
>>> +		.name = "rzg3s-pcie-host",
>>> +		.of_match_table = rzg3s_pcie_of_match,
>>> +		.pm = pm_ptr(&rzg3s_pcie_pm_ops),
>>> +	},
>>> +	.probe = rzg3s_pcie_probe,
> 
> You haven't implemented .remove(), but didn't set '.suppress_bind_attrs = true'.

The driver can still be removed w/o remove being here. devm takes care of
proper configuration. I wasn't sure about suppress_binding_attrs, I noticed
there are controllers using it but didn't knew the rationale behind it.

> PCI controller drivers acting as an IRQCHIP are not safe to be removed.

OK, I will add suppress_bind_attrs = true.

Thank you for your review,
Claudiu

