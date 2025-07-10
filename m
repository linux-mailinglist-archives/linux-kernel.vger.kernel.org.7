Return-Path: <linux-kernel+bounces-725400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F69BAFFE8A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697213AB919
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A552D5402;
	Thu, 10 Jul 2025 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBocuiTz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538CA289361;
	Thu, 10 Jul 2025 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752141395; cv=none; b=NHiJiObo3qhEyRX97NDyklzZ4f4QlmGqCzuF/npyt1MZ3jA8cVFYl9SMi+7pYO+bQ8++hX4Z1r3tjV+Dt8ZPQjL0fV1KN1xgzNVcJw+hPIQ6JkWBpVKhssBQ3BFaDT68CGJessDlhSnoSBEsatgCzGM9gfiEcAxz8piJQEARaeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752141395; c=relaxed/simple;
	bh=sTi69w/mvnFptUvlqnK1ihadm1CzXakPo1pjhglo3Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKw1rtnv0KvMQHQSN1kGvTMymmZrHY8wdC6QBwaw7PQV6VFrZdfmwyi3OZXN0k3yugCQkBGRZq+PTBpNdtFHyuaEfefu105ez/HZHHr2I816xAx4g0Gz4QWtUSCfhhU6iLAvqSMeMiPkMMOtN/qh27ToTGEpa9J7SGTkx8++p94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBocuiTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C04C4CEE3;
	Thu, 10 Jul 2025 09:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752141394;
	bh=sTi69w/mvnFptUvlqnK1ihadm1CzXakPo1pjhglo3Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jBocuiTz5M2+7Oar6fiuzuh2L4AMf2Utd3jF80osqVjy3Km29pY8NKy+YyVC9EBi3
	 pVwljKQl3bRn/ul7HsaZrGyBtPN3ETStXaGTqd/lEW7qH8qI3u0QIdkL4oRShOEHLG
	 BJT69FlbxJfPTSW/laJvAf6dc9DEz+mzIgJ9hUFB3Pipo6hVIVv6NQsbZSosyIcGc+
	 /EbcinV1mwrR6f8yKW3PoM5/lUSLsQz1zWDbgt9x3zI3clFjtklQS+l0QJtpfOdsWy
	 abUQ+UkeJqekDuIIvm3VDZhEgToHgeVgiTHhgBh7yRHZPr24lI/r5EatP+P/TfgCEn
	 LSKbsHW2J6oNA==
Date: Thu, 10 Jul 2025 10:56:29 +0100
From: Lee Jones <lee@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Corey Minyard <minyard@acm.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net, jeffbai@aosc.io,
	kexybiscuit@aosc.io, wangyao@lemote.com,
	Chong Qiao <qiaochong@loongson.cn>,
	Corey Minyard <corey@minyard.net>
Subject: Re: [PATCH v7 1/3] mfd: ls2kbmc: Introduce Loongson-2K BMC core
 driver
Message-ID: <20250710095629.GH1431498@google.com>
References: <cover.1751617911.git.zhoubinbin@loongson.cn>
 <2252dbc3970264371278182ebaf7669fe77d33a2.1751617911.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2252dbc3970264371278182ebaf7669fe77d33a2.1751617911.git.zhoubinbin@loongson.cn>

On Fri, 04 Jul 2025, Binbin Zhou wrote:

> The Loongson-2K Board Management Controller provides an PCIe interface
> to the host to access the feature implemented in the BMC.
> 
> The BMC is assembled on a server similar to the server machine with
> Loongson-3 CPU. It supports multiple sub-devices like DRM and IPMI.
> 
> Co-developed-by: Chong Qiao <qiaochong@loongson.cn>
> Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Acked-by: Corey Minyard <corey@minyard.net>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  MAINTAINERS                 |   6 ++
>  drivers/mfd/Kconfig         |  13 +++
>  drivers/mfd/Makefile        |   2 +
>  drivers/mfd/ls2k-bmc-core.c | 156 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 177 insertions(+)
>  create mode 100644 drivers/mfd/ls2k-bmc-core.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0d053c45f7f9..4eb0f7b69d35 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14199,6 +14199,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
>  F:	drivers/thermal/loongson2_thermal.c
>  
> +LOONGSON-2K Board Management Controller (BMC) DRIVER
> +M:	Binbin Zhou <zhoubinbin@loongson.cn>
> +M:	Chong Qiao <qiaochong@loongson.cn>
> +S:	Maintained
> +F:	drivers/mfd/ls2k-bmc-core.c
> +
>  LOONGSON EDAC DRIVER
>  M:	Zhao Qunqin <zhaoqunqin@loongson.cn>
>  L:	linux-edac@vger.kernel.org
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index c635790afa75..47cc8ea9d2ef 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2400,6 +2400,19 @@ config MFD_INTEL_M10_BMC_PMCI
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  
> +config MFD_LS2K_BMC_CORE
> +	bool "Loongson-2K Board Management Controller Support"
> +	depends on PCI && ACPI_GENERIC_GSI
> +	select MFD_CORE
> +	help
> +	  Say yes here to add support for the Loongson-2K BMC which is a Board
> +	  Management Controller connected to the PCIe bus. The device supports
> +	  multiple sub-devices like display and IPMI. This driver provides common
> +	  support for accessing the devices.
> +
> +	  The display is enabled by default in the driver, while the IPMI interface
> +	  is enabled independently through the IPMI_LS2K option in the IPMI section.
> +
>  config MFD_QNAP_MCU
>  	tristate "QNAP microcontroller unit core driver"
>  	depends on SERIAL_DEV_BUS
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index ca351cb0ddcc..675b4ec6ef4c 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -284,6 +284,8 @@ obj-$(CONFIG_MFD_INTEL_M10_BMC_CORE)   += intel-m10-bmc-core.o
>  obj-$(CONFIG_MFD_INTEL_M10_BMC_SPI)    += intel-m10-bmc-spi.o
>  obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)   += intel-m10-bmc-pmci.o
>  
> +obj-$(CONFIG_MFD_LS2K_BMC_CORE)		+= ls2k-bmc-core.o
> +
>  obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
>  obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
>  
> diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
> new file mode 100644
> index 000000000000..50d560a4611c
> --- /dev/null
> +++ b/drivers/mfd/ls2k-bmc-core.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Loongson-2K Board Management Controller (BMC) Core Driver.
> + *
> + * Copyright (C) 2024-2025 Loongson Technology Corporation Limited.
> + *
> + * Authors:
> + *	Chong Qiao <qiaochong@loongson.cn>
> + *	Binbin Zhou <zhoubinbin@loongson.cn>
> + */
> +
> +#include <linux/aperture.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/pci_ids.h>
> +#include <linux/platform_data/simplefb.h>
> +#include <linux/platform_device.h>
> +
> +/* LS2K BMC resources */
> +#define LS2K_DISPLAY_RES_START		(SZ_16M + SZ_2M)
> +#define LS2K_IPMI_RES_SIZE		0x1C
> +#define LS2K_IPMI0_RES_START		(SZ_16M + 0xF00000)
> +#define LS2K_IPMI1_RES_START		(LS2K_IPMI0_RES_START + LS2K_IPMI_RES_SIZE)
> +#define LS2K_IPMI2_RES_START		(LS2K_IPMI1_RES_START + LS2K_IPMI_RES_SIZE)
> +#define LS2K_IPMI3_RES_START		(LS2K_IPMI2_RES_START + LS2K_IPMI_RES_SIZE)
> +#define LS2K_IPMI4_RES_START		(LS2K_IPMI3_RES_START + LS2K_IPMI_RES_SIZE)
> +
> +static struct resource ls2k_display_resources[] = {
> +	DEFINE_RES_MEM_NAMED(LS2K_DISPLAY_RES_START, SZ_4M, "simpledrm-res"),
> +};
> +
> +static struct resource ls2k_ipmi0_resources[] = {
> +	DEFINE_RES_MEM_NAMED(LS2K_IPMI0_RES_START, LS2K_IPMI_RES_SIZE, "ipmi0-res"),
> +};
> +
> +static struct resource ls2k_ipmi1_resources[] = {
> +	DEFINE_RES_MEM_NAMED(LS2K_IPMI1_RES_START, LS2K_IPMI_RES_SIZE, "ipmi1-res"),
> +};
> +
> +static struct resource ls2k_ipmi2_resources[] = {
> +	DEFINE_RES_MEM_NAMED(LS2K_IPMI2_RES_START, LS2K_IPMI_RES_SIZE, "ipmi2-res"),
> +};
> +
> +static struct resource ls2k_ipmi3_resources[] = {
> +	DEFINE_RES_MEM_NAMED(LS2K_IPMI3_RES_START, LS2K_IPMI_RES_SIZE, "ipmi3-res"),
> +};
> +
> +static struct resource ls2k_ipmi4_resources[] = {
> +	DEFINE_RES_MEM_NAMED(LS2K_IPMI4_RES_START, LS2K_IPMI_RES_SIZE, "ipmi4-res"),
> +};
> +
> +static struct mfd_cell ls2k_bmc_cells[] = {
> +	MFD_CELL_RES("simple-framebuffer", ls2k_display_resources),
> +	MFD_CELL_RES("ls2k-ipmi-si", ls2k_ipmi0_resources),
> +	MFD_CELL_RES("ls2k-ipmi-si", ls2k_ipmi1_resources),
> +	MFD_CELL_RES("ls2k-ipmi-si", ls2k_ipmi2_resources),
> +	MFD_CELL_RES("ls2k-ipmi-si", ls2k_ipmi3_resources),
> +	MFD_CELL_RES("ls2k-ipmi-si", ls2k_ipmi4_resources),
> +};
> +
> +/*
> + * Currently the Loongson-2K BMC hardware does not have an I2C interface to adapt to the
> + * resolution. We set the resolution by presetting "video=1280x1024-16@2M" to the BMC memory.
> + */
> +static int ls2k_bmc_parse_mode(struct pci_dev *pdev, struct simplefb_platform_data *pd)
> +{
> +	char *mode;
> +	int depth, ret;
> +
> +	/* The last 16M of PCI BAR0 is used to store the resolution string. */
> +	mode = devm_ioremap(&pdev->dev, pci_resource_start(pdev, 0) + SZ_16M, SZ_16M);
> +	if (!mode)
> +		return -ENOMEM;
> +
> +	/* The resolution field starts with the flag "video=". */
> +	if (!strncmp(mode, "video=", 6))
> +		mode = mode + 6;
> +
> +	ret = kstrtoint(strsep(&mode, "x"), 10, &pd->width);
> +	if (ret)
> +		return ret;
> +
> +	ret = kstrtoint(strsep(&mode, "-"), 10, &pd->height);
> +	if (ret)
> +		return ret;
> +
> +	ret = kstrtoint(strsep(&mode, "@"), 10, &depth);
> +	if (ret)
> +		return ret;
> +
> +	pd->stride = pd->width * depth / 8;
> +	pd->format = depth == 32 ? "a8r8g8b8" : "r5g6b5";
> +
> +	return 0;
> +}
> +
> +static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
> +{
> +	struct simplefb_platform_data pd;
> +	resource_size_t base;
> +	int ret;
> +
> +	ret = pci_enable_device(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ls2k_bmc_parse_mode(dev, &pd);
> +	if (ret)
> +		goto disable_pci;
> +
> +	ls2k_bmc_cells[0].platform_data = &pd;
> +	ls2k_bmc_cells[0].pdata_size = sizeof(pd);

This is fragile.

Please identify the elements in ls2k_bmc_cells and use it to index here.

See: `static struct mfd_cell as3711_subdevs`

> +	base = dev->resource[0].start + LS2K_DISPLAY_RES_START;
> +
> +	/* Remove conflicting efifb device */
> +	ret = aperture_remove_conflicting_devices(base, SZ_4M, "simple-framebuffer");
> +	if (ret) {
> +		dev_err(&dev->dev, "Failed to removed firmware framebuffers: %d\n", ret);
> +		goto disable_pci;
> +	}
> +
> +	return devm_mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
> +				    ls2k_bmc_cells, ARRAY_SIZE(ls2k_bmc_cells),
> +				    &dev->resource[0], 0, NULL);
> +
> +disable_pci:
> +	pci_disable_device(dev);
> +	return ret;
> +}
> +
> +static void ls2k_bmc_remove(struct pci_dev *dev)
> +{
> +	pci_disable_device(dev);
> +}
> +
> +static struct pci_device_id ls2k_bmc_devices[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x1a05) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, ls2k_bmc_devices);
> +
> +static struct pci_driver ls2k_bmc_driver = {
> +	.name = "ls2k-bmc",
> +	.id_table = ls2k_bmc_devices,
> +	.probe = ls2k_bmc_probe,
> +	.remove = ls2k_bmc_remove,
> +};
> +module_pci_driver(ls2k_bmc_driver);
> +
> +MODULE_DESCRIPTION("Loongson-2K Board Management Controller (BMC) Core driver");
> +MODULE_AUTHOR("Loongson Technology Corporation Limited");
> +MODULE_LICENSE("GPL");
> -- 
> 2.47.1
> 

-- 
Lee Jones [李琼斯]

