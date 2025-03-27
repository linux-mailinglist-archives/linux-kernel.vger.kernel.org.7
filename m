Return-Path: <linux-kernel+bounces-578905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC1CA73A57
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 18:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C09E3B7B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 17:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28C6218823;
	Thu, 27 Mar 2025 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rgv1ADrP"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D87B1AE01C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743096345; cv=none; b=d/QYETrsIjbmYhOp2E6MWEhhI8XBOsexwBgaaIhLl/2nhSQQ8N1kZ4MHW5F2K3+ZaEatYHZ7TD0xP9B8inik57cIxeQ8rrFBvY5Hq91jKvI3aAVBRSIUkLpa7DTGnKLekk+RSmk/kXpnNKPiu7xaJ8Ks/hrFHuzFiISlFPMIjpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743096345; c=relaxed/simple;
	bh=S2yCtPCkU3abHZGGG25cSvixrqcADDLYGhyquuUm4Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTX5n+icT0s+n8/d/rvJXaycw/VH8O5rVsJUq0TtarYQAEIVvAhXo/jFsKQ7TL7e1nJ1cNt6bvanZptSbsmkcRb0LCf2TJwNVV0XrlAips8XDIGZ8owhAts7rvp982VU4GFV60+mLIqUa1397EkTmObPKOm0m2SgeS0CJijO7Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rgv1ADrP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-226185948ffso28968885ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 10:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743096343; x=1743701143; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/d1yX1u260D2JZSyOyFpH1u4UJfKnHZNGkd7qZn4Img=;
        b=rgv1ADrPDGrHOG0MoIXKvmoIG6g+uHKXp+cr6A3WYr5sN45erlIqOUi8YNeLFVwahq
         7hq3tucCj1la/WpzJHt4FFzwnRHOxDLDLvXnCeWzJmlCkFjcIYySXaujkaShjlsS3lr2
         XWyux8x0TpVPzwTw4Y14Ji2Nb/fgJikYwVtXzTz3E7pp++/Z5MKsxjY/nELU+Nf8yyn3
         VPtqS1luCNiXYFeAM2+Kyza4K9O6MVKyIOYyPz3dhB0pOH3bdUa6jna8g26MIFhE5G4E
         OLPh1ZYXE0oQP6IKfB6pgBvrOH2pyH1WhPJrSmAek0u1vXAvSyF+cFJ/YP9cUi90ILlM
         POvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743096343; x=1743701143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/d1yX1u260D2JZSyOyFpH1u4UJfKnHZNGkd7qZn4Img=;
        b=YzqYo57Pef572N0s3/RSxmxG8OruhUZiGk/8itia/J1E+wzMqZ9zq42t5krf7Xz1QS
         PQ9FBCGa98QGH+2U4Ul/Ukl7YjF8CPVOInUZV/z8SuZDsW8fyGWzxTrFKHOBGo4BBa5G
         hPLj1vgjMoDCraxX8mrZYicosriwzAUvVEBegBtiKzVvbYeSI0xj79E2NiMUybB8bh3c
         v4JsDZzFVmfpP01y91KDo7q3paGDng2qUVePF75KEfC6YndW6fbE8WgGvxgBvu3daDyP
         wRRx6p7BosArkDN+IfuSHl+ML0odmQREftEFoVo/7T/W0UncpawkyQVdMOa1+WedEa/K
         Tspw==
X-Forwarded-Encrypted: i=1; AJvYcCXtCeWfISKQB9z49x9rT719zIqdnYz2WpYcp9ZmJ0my0vPOPv1sb2dKjAmIK0X9sP8EQs/PNWGvG53OuBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoQ8nQHFt6RUA/E7uUmaQucIDoN8YUSUYzsiecQqRaywr7AccU
	0oO/tkuu3ouvqRRpRDObhMXxiRGzBtvM48p0G7AU1oyzzbfRz1Rq4j5NGaAoIA==
X-Gm-Gg: ASbGncuSt+1R2OdfSL3Las80DuBd9BhfHN0ZSowxCDk34NPJyKsvivXfXl6ZqrL8eVk
	YbR2jdE+5JWQOqlUo1wni+mAFq9caDA+uOc9yjNa4yYZs9blgpL79vcsVNJSHYib3u/c4ZZw+Hx
	xnZ353mp7i2dO2om9oL5GJf/RnuCAiGzFkQVgabvmXZAP5j7GNCwOMxCjPUbcIJRjrj7s4BSBYp
	kXR3c7VIcjHbbobmNEtm7+f5ZY1/IhtmZVw5iSnVDVRgGCTkv4QUNZcQPHmw/amt1HIxccLOaGx
	80Ja9B+xL2Yovhl/rl9zrAhDZSPB51yxTQXO+41Llps3wjz7xuTi79c=
X-Google-Smtp-Source: AGHT+IFovdsHpxiaRgV8EpXBasRo4AVmFOVh7pghOpH7plH53tgno4Flr6BQ5eM0YxDh1//vuT0AuA==
X-Received: by 2002:a05:6a20:12d2:b0:1f0:e706:1370 with SMTP id adf61e73a8af0-1fea2f954a0mr8661259637.35.1743096342587;
        Thu, 27 Mar 2025 10:25:42 -0700 (PDT)
Received: from thinkpad ([120.60.71.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e51a4asm73523b3a.81.2025.03.27.10.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 10:25:42 -0700 (PDT)
Date: Thu, 27 Mar 2025 22:55:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, cassel@kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michal.simek@amd.com, bharat.kumar.gogada@amd.com, thippeswamy.havalige@amd.com
Subject: Re: [PATCH v6 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
 signal
Message-ID: <cjrb3idrj3x7vo4fujl6nakj3foyu64gtxwovmxd4qvovvhwqq@26bpt5b4zjao>
References: <20250326022811.3090688-1-sai.krishna.musham@amd.com>
 <20250326022811.3090688-3-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326022811.3090688-3-sai.krishna.musham@amd.com>

On Wed, Mar 26, 2025 at 07:58:11AM +0530, Sai Krishna Musham wrote:
> Add PCIe IP reset along with GPIO-based control for the PCIe Root
> Port PERST# signal. Synchronizing the PCIe IP reset with the PERST#
> signal's assertion and deassertion avoids Link Training failures.
> 
> Adapt to use GPIO framework and make reset optional to maintain
> backward compatibility with existing DTBs.
> 
> Add clear firewall after Link reset for CPM5NC.
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> Changes for v6:
> - Correct version check condition of CPM5NC_HOST.
> 
> Changes for v5:
> - Handle probe defer for reset_gpio.
> - Resolve ABI break.
> 
> Changes for v4:
> - Add PCIe PERST# support for CPM5NC.
> - Add PCIe IP reset along with PERST# to avoid Link Training Errors.
> - Remove PCIE_T_PVPERL_MS define and PCIE_T_RRS_READY_MS after
>   PERST# deassert.
> - Move PCIe PERST# assert and deassert logic to
>   xilinx_cpm_pcie_init_port() before cpm_pcie_link_up(), since
>   Interrupts enable and PCIe RP bridge enable should be done after
>   Link up.
> - Update commit message.
> 
> Changes for v3:
> - Use PCIE_T_PVPERL_MS define.
> 
> Changes for v2:
> - Make the request GPIO optional.
> - Correct the reset sequence as per PERST#
> - Update commit message
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 86 ++++++++++++++++++++++--
>  1 file changed, 82 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index d0ab187d917f..b10c0752a94f 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -6,6 +6,8 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/irqchip.h>
> @@ -21,6 +23,13 @@
>  #include "pcie-xilinx-common.h"
>  
>  /* Register definitions */
> +#define XILINX_CPM_PCIE0_RST		0x00000308
> +#define XILINX_CPM5_PCIE0_RST		0x00000318
> +#define XILINX_CPM5_PCIE1_RST		0x0000031C
> +#define XILINX_CPM5NC_PCIE0_RST		0x00000324
> +
> +#define XILINX_CPM5NC_PCIE0_FRWALL	0x00001140
> +
>  #define XILINX_CPM_PCIE_REG_IDR		0x00000E10
>  #define XILINX_CPM_PCIE_REG_IMR		0x00000E14
>  #define XILINX_CPM_PCIE_REG_PSCR	0x00000E1C
> @@ -99,6 +108,7 @@ struct xilinx_cpm_variant {
>  	u32 ir_status;
>  	u32 ir_enable;
>  	u32 ir_misc_value;
> +	u32 cpm_pcie_rst;
>  };
>  
>  /**
> @@ -106,6 +116,8 @@ struct xilinx_cpm_variant {
>   * @dev: Device pointer
>   * @reg_base: Bridge Register Base
>   * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
> + * @crx_base: CPM Clock and Reset Control Registers Base
> + * @cpm5nc_attr_base: CPM5NC Control and Status Registers Base
>   * @intx_domain: Legacy IRQ domain pointer
>   * @cpm_domain: CPM IRQ domain pointer
>   * @cfg: Holds mappings of config space window
> @@ -118,6 +130,8 @@ struct xilinx_cpm_pcie {
>  	struct device			*dev;
>  	void __iomem			*reg_base;
>  	void __iomem			*cpm_base;
> +	void __iomem			*crx_base;
> +	void __iomem			*cpm5nc_attr_base;
>  	struct irq_domain		*intx_domain;
>  	struct irq_domain		*cpm_domain;
>  	struct pci_config_window	*cfg;
> @@ -475,12 +489,45 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie *port)
>   * xilinx_cpm_pcie_init_port - Initialize hardware
>   * @port: PCIe port information
>   */
> -static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
> +static int xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>  {
>  	const struct xilinx_cpm_variant *variant = port->variant;
> +	struct device *dev = port->dev;
> +	struct gpio_desc *reset_gpio;
> +
> +	/* Request the GPIO for PCIe reset signal */
> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio)) {
> +		if (PTR_ERR(reset_gpio) != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to request reset GPIO\n");
> +		return PTR_ERR(reset_gpio);
> +	}
>  
> -	if (variant->version == CPM5NC_HOST)
> -		return;
> +	if (reset_gpio && port->crx_base) {
> +		/* Assert the PCIe IP reset */
> +		writel_relaxed(0x1, port->crx_base + variant->cpm_pcie_rst);
> +
> +		/* Controller specific delay */
> +		udelay(50);
> +

There should be atleast 100ms delay before PERST# deassert as per the spec. So
use PCIE_T_PVPERL_MS. I know that you had it before, but removed in v4. I don't
see a valid reason for that.

> +		/* Deassert the PCIe IP reset */
> +		writel_relaxed(0x0, port->crx_base + variant->cpm_pcie_rst);
> +
> +		/* Deassert the reset signal */
> +		gpiod_set_value(reset_gpio, 0);
> +		mdelay(PCIE_T_RRS_READY_MS);
> +
> +		if (variant->version == CPM5NC_HOST && port->cpm5nc_attr_base) {
> +			/* Clear Firewall */
> +			writel_relaxed(0x00, port->cpm5nc_attr_base +
> +					XILINX_CPM5NC_PCIE0_FRWALL);
> +			writel_relaxed(0x01, port->cpm5nc_attr_base +
> +					XILINX_CPM5NC_PCIE0_FRWALL);
> +			writel_relaxed(0x00, port->cpm5nc_attr_base +
> +					XILINX_CPM5NC_PCIE0_FRWALL);
> +			return 0;
> +		}
> +	}
>  
>  	if (cpm_pcie_link_up(port))
>  		dev_info(port->dev, "PCIe Link is UP\n");
> @@ -512,6 +559,8 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>  	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
>  		   XILINX_CPM_PCIE_REG_RPSC_BEN,
>  		   XILINX_CPM_PCIE_REG_RPSC);
> +
> +	return 0;
>  }
>  
>  /**
> @@ -551,6 +600,27 @@ static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
>  		port->reg_base = port->cfg->win;
>  	}
>  
> +	port->crx_base = devm_platform_ioremap_resource_byname(pdev,
> +							       "cpm_crx");
> +	if (IS_ERR(port->crx_base)) {
> +		if (PTR_ERR(port->crx_base) == -EINVAL)
> +			port->crx_base = NULL;
> +		else
> +			return PTR_ERR(port->crx_base);
> +	}
> +
> +	if (port->variant->version == CPM5NC_HOST) {
> +		port->cpm5nc_attr_base =
> +			devm_platform_ioremap_resource_byname(pdev,
> +							      "cpm5nc_attr");

Where is this resource defined in the binding?

> +		if (IS_ERR(port->cpm5nc_attr_base)) {
> +			if (PTR_ERR(port->cpm5nc_attr_base) == -EINVAL)

Why?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

