Return-Path: <linux-kernel+bounces-604457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2661DA894BD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 09:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E951894379
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 07:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B541921171C;
	Tue, 15 Apr 2025 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDScuucj"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A4110F2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 07:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701525; cv=none; b=fa1dCZ+aukWhJnkq0Ydsz7tZTcxZ/j4KjP0DaJcTOtLTjwxvpWllZRKzwGiR3FVYNikO6OK8+jTwRTZ0Mx0EtTtw4N9ZOJucmLXojmv95hu97i1MBTqfyrfRU9Mm7EUOMc7rgsDXhH+9eX6WS8mTAmVmyzsfoOmw1p/0mXIfRJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701525; c=relaxed/simple;
	bh=jjxXLOtaUU5zGI7uHmJIeqVNnv25Zreg+4XVdIUySb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1LMukMIqFMPlMXnVbc12mD1cQP2Fgsttw8frxiKfJQ+Ut0yrwnzY/jSp7fOynB+S81yiYwAGXFFiVdjwD1bDqmIN5PfKTw77gZXnZ+vmcOm9vS/DIa6Kux3skuA7+VZHJ/uhQXDd+WE2psaiOLa7zbPzGXGRWPFrgpdQ39867o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nDScuucj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227b650504fso49963545ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 00:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744701521; x=1745306321; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MjVkJWHmX8v3mt1102Wpc+/VjkT959RAvTZUx+eidcw=;
        b=nDScuucj0e9im4kMj2cY5iKH9UbjaKlKhm+gghi1Yo3+rmKcBwKWb4IGhbrrNsFSRE
         NsTLXD+OmDEE0IQpcv54wONsNYjkjHNf3FIub1xXxIZllISjH77c3rYYNzjhoKqfQZXj
         7N3LU7Mg8LrL6PWFASklw9KOrgBGK6StL4GH/Zcu1AU8CenC/jVGk8BZ2AGOv2nJZkfT
         B1FU/npNbvFCvm+QT04pQpZ91Y3deWeU29Y8D0Q+vuw2yt92jnp7B78plm//YvrGqHnj
         YrPPQ3joKdZiR49IS2hrM3aLDE+4jvrUAcfL7QtCoZinhOsLciVqHs1V+HlvkByoqcGG
         ijhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744701521; x=1745306321;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MjVkJWHmX8v3mt1102Wpc+/VjkT959RAvTZUx+eidcw=;
        b=XXmisKmSGbiHm0aY8VDfKMWr3K60P6yfo/gH+pMasrK7nsX1pFdORh88jilHOgWo9w
         xmTX3FAHa/bKI5INXxykZkGwiiNngBn+fvHlmV/9VIEbamaEWCiwTHrAHA/kkQAWFNJU
         XqmU94oDR0d7CB0bxXw3GhUe6FGRcWfITB/c5IUzw9pGiOiQmiYoNe/ZLQc/EF8SGS+M
         f9xpOOl/+1bpqDSJmYrNYVqf55dgwVMXc/eufydWU6tmi+dlncYK0YvbToyakBTBa/aA
         q5ehbOx41PWXLu3DRlSjqNthX49U1tjqgvPkujDt1nZ7m/XXuBvF32LVwVRhPuWHOi49
         5cAA==
X-Forwarded-Encrypted: i=1; AJvYcCXMhD2/AFxmo3p7QGxyGQGT0uVugW19/0N8dxf+SyNnEAR9spGZ9cqQjKr8lBn3rjwd25lOkSKUJI04M5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxidA7rC94iVapjRu5+EKPrmzZ+ISuCOPJo/UfsYTGsVDi2otsh
	qLuNHJvbiqTuctc5+K0r9ITHXBPT5eTfPVix6LMZsPC0DpXdmQdfFFQp2h7rYQ==
X-Gm-Gg: ASbGncs6OveCNteLuRWz2Xd7X/80DUpqgOdJNS4Th8HX1ccOXU2s9/2vfie/VqOxAMw
	GqyLJhtoH4v5A6IdndDzUW7eO3pPiCB+B1PXiiajeLTBvfUdsfb8Zk5zpP4LMCNabQcfc5oybTn
	n+f4bLFBEdPJwbhp6qjPQbW3Z4dalh0Gifpy3z0T/0r3y3ovo2E2+Gb3A+ReJ4e1gFtr+RQtakq
	WKRVuFDrpKPViLuZY4EnFZ1nK7JsOpR6rhnvfkRL7nQUcDfMsaTRzs59K6QZYzqg8CNWpWEKpVZ
	d/QorkrQORYB4jOE32uNM8H1TzyRpBeVAqdKZi8JVlRH25Hlou3CplNneFV/
X-Google-Smtp-Source: AGHT+IElyXCOb4OPYmCjdN/6HrTiolToBMZfQbUehYU59w0I4aTlufDp7vFNPzJ0Nd7+qwAQOi33Xw==
X-Received: by 2002:a17:902:d4c8:b0:223:6657:5008 with SMTP id d9443c01a7336-22bea4bd865mr185866395ad.24.1744701521616;
        Tue, 15 Apr 2025 00:18:41 -0700 (PDT)
Received: from thinkpad ([120.60.71.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8b18esm110805445ad.82.2025.04.15.00.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:18:41 -0700 (PDT)
Date: Tue, 15 Apr 2025 12:48:34 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, cassel@kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michal.simek@amd.com, bharat.kumar.gogada@amd.com, thippeswamy.havalige@amd.com
Subject: Re: [LINUX PATCH v7 2/2] PCI: xilinx-cpm: Add support for PCIe RP
 PERST# signal
Message-ID: <lopqatqgd4ql5qdtlph2irw2b4ed6dbnjsgncd7idlsz2tjlhn@rdvfj2ma2wx5>
References: <20250414030842.857176-1-sai.krishna.musham@amd.com>
 <20250414030842.857176-3-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250414030842.857176-3-sai.krishna.musham@amd.com>

On Mon, Apr 14, 2025 at 08:38:42AM +0530, Sai Krishna Musham wrote:
> Add support for handling the PCIe Root Port (RP) PERST# signal using
> the GPIO framework, along with the PCIe IP reset. This reset is
> managed by the driver and occurs after the Initial Power Up sequence
> (PCIe CEM r6.0, 2.2.1) is handled in hardware before the driver's probe
> function is called.
> 
> This reset mechanism is particularly useful in warm reset scenarios,
> where the power rails remain stable and only PERST# signal is toggled
> through the driver. Applying both the PCIe IP reset and the PERST#
> improves the reliability of the reset process by ensuring that both
> the Root Port controller and the Endpoint are reset synchronously
> and avoid lane errors.
> 
> Adapt the implementation to use the GPIO framework for reset signal
> handling and make this reset handling optional, along with the
> `cpm_crx` property, to maintain backward compatibility with existing
> device tree binaries (DTBs).
> 
> Additionally, clear Firewall after the link reset for CPM5NC to allow
> further PCIe transactions.
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> Changes for v7:
> - Use platform_get_resource_byname() to make cpm_crx and cpm5nc_fw_attr
>   optional
> - Use 100us delay T_PERST as per PCIe spec before PERST# deassert.
> 
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
>  drivers/pci/controller/pcie-xilinx-cpm.c | 97 +++++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index 13ca493d22bd..c46642417d52 100644
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
> +#define XILINX_CPM5NC_PCIE0_FRWALL	0x00000140
> +
>  #define XILINX_CPM_PCIE_REG_IDR		0x00000E10
>  #define XILINX_CPM_PCIE_REG_IMR		0x00000E14
>  #define XILINX_CPM_PCIE_REG_PSCR	0x00000E1C
> @@ -93,12 +102,16 @@ enum xilinx_cpm_version {
>   * @ir_status: Offset for the error interrupt status register
>   * @ir_enable: Offset for the CPM5 local error interrupt enable register
>   * @ir_misc_value: A bitmask for the miscellaneous interrupt status
> + * @cpm_pcie_rst: Offset for the PCIe IP reset
> + * @cpm5nc_fw_rst: Offset for the CPM5NC Firewall
>   */
>  struct xilinx_cpm_variant {
>  	enum xilinx_cpm_version version;
>  	u32 ir_status;
>  	u32 ir_enable;
>  	u32 ir_misc_value;
> +	u32 cpm_pcie_rst;
> +	u32 cpm5nc_fw_rst;
>  };
>  
>  /**
> @@ -106,6 +119,8 @@ struct xilinx_cpm_variant {
>   * @dev: Device pointer
>   * @reg_base: Bridge Register Base
>   * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
> + * @crx_base: CPM Clock and Reset Control Registers Base
> + * @cpm5nc_fw_base: CPM5NC Firewall Attribute Base
>   * @intx_domain: Legacy IRQ domain pointer
>   * @cpm_domain: CPM IRQ domain pointer
>   * @cfg: Holds mappings of config space window
> @@ -118,6 +133,8 @@ struct xilinx_cpm_pcie {
>  	struct device			*dev;
>  	void __iomem			*reg_base;
>  	void __iomem			*cpm_base;
> +	void __iomem			*crx_base;
> +	void __iomem			*cpm5nc_fw_base;
>  	struct irq_domain		*intx_domain;
>  	struct irq_domain		*cpm_domain;
>  	struct pci_config_window	*cfg;
> @@ -475,12 +492,57 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie *port)
>   * xilinx_cpm_pcie_init_port - Initialize hardware
>   * @port: PCIe port information
>   */
> -static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
> +static int xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>  {
>  	const struct xilinx_cpm_variant *variant = port->variant;
> +	struct device *dev = port->dev;
> +	struct gpio_desc *reset_gpio;
> +	bool do_reset = false;
> +
> +	if (port->crx_base && (variant->version < CPM5NC_HOST ||
> +			       (variant->version == CPM5NC_HOST &&
> +				port->cpm5nc_fw_base))) {
> +		/* Request the GPIO for PCIe reset signal and assert */
> +		reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +		if (IS_ERR(reset_gpio))
> +			return dev_err_probe(dev, PTR_ERR(reset_gpio),
> +					     "Failed to request reset GPIO\n");
> +		if (reset_gpio)
> +			do_reset = true;
> +	}
> +
> +	if (do_reset) {
> +		/* Assert the PCIe IP reset */
> +		writel_relaxed(0x1, port->crx_base + variant->cpm_pcie_rst);
> +
> +		/*
> +		 * "PERST# active time", as per Table 2-10: Power Sequencing
> +		 * and Reset Signal Timings of the PCIe Electromechanical
> +		 * Specification, Revision 6.0, symbol "T_PERST".
> +		 */
> +		udelay(100);

You don't need this delay unless the above 'cpm_pcie_rst' controls refclk.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

