Return-Path: <linux-kernel+bounces-867111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72A9C019FD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51323B6DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AC5333736;
	Thu, 23 Oct 2025 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnRGDyRL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F756334C23;
	Thu, 23 Oct 2025 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227638; cv=none; b=TjUh9YJ5e964OhSlZIfe0vNw9GNu0RH9ZbLfIi1B6P0+zEq0i/VlD20iMs7aNeMOz3W7fThioq+7mrRF+bCuTTyOyzWLghD4afh1NoncSinsCT80t9dkAGCUloLFBClri/F3A7zjtc3LTiLV28MQcWdRXEHMT2DunOYRbEiG84E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227638; c=relaxed/simple;
	bh=Q08J0lo6XGpzui6uJHwKy8ROOSmn2gg75HcBXvBcwo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIn7L0EObSO6/IHGoKtQBS55gBPKpLe3Io3VHHYP/upGgzY/iGWkhOubILNC2gWFbfgDo0+KrDBoA/IRa0dPxnIMAdINCuP0mb7PKFceASAE0dNRtytFRyJFNxQLR+OO+LBOGx15Q4fWnnSw+GPrDioSdmmFKk1IPSLWLXUsm+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnRGDyRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA8FC4CEFF;
	Thu, 23 Oct 2025 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761227637;
	bh=Q08J0lo6XGpzui6uJHwKy8ROOSmn2gg75HcBXvBcwo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZnRGDyRL9KumL5LY43iMaDRTjdGN1cvB+fCpvfZHgY3rZCtqrVTjyXD9zC47M9CI2
	 f91Xqf7Bd0Y2HmKEhMSGB8Ad/cGSPm8xz9h9ARP5hdPlJX9Dr77OqRceejVkNOpYJO
	 yAfrO2DsNKe4lKZip334rnE4CUGyH0i9AKzGMC9SejC1g41DjIg4YTEcx6+nMobwPp
	 dku1kNqxH21XiG33bU3i8UNz6u/vEIZcmRy41MA9XnEGbv8JqjEGBA0g0O+dLcGVNR
	 PBsTpN20/UImt36Iluccd0plVNpqrVzgu6I/kt+rkESTlqRk/ITPeFh0awXhjx0zsm
	 XWi2fZoOl4URA==
Date: Thu, 23 Oct 2025 14:53:52 +0100
From: Lee Jones <lee@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
	broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH v8 9/9] drivers: mfd: Add support for MediaTek SPMI PMICs
 and MT6363/73
Message-ID: <20251023135352.GO475031@google.com>
References: <20251003091158.26748-1-angelogioacchino.delregno@collabora.com>
 <20251003091158.26748-10-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251003091158.26748-10-angelogioacchino.delregno@collabora.com>

Drop "drivers: " from the subject line.

> This driver adds support for the MediaTek SPMI PMICs and their
> interrupt controller (which is present in 95% of the cases).
> 
> Other than probing all of the sub-devices of a SPMI PMIC, this
> sets up a regmap from the relevant SPMI bus and initializes an
> interrupt controller with its irq domain and irqchip to handle
> chained interrupts, with the SPMI bus itself being its parent
> irq controller, and the PMIC being the outmost device.
> 
> This driver hence holds all of the information about a specific
> PMIC's interrupts and will properly handle them, calling the
> ISR for any subdevice that requested an interrupt.
> 
> As for the interrupt spec, this driver wants 3 interrupt cells,
> but ignores the first one: this is because of how this first
> revision of the MediaTek SPMI 2.0 Controller works, which does
> not hold irq number information in its register, but delegates
> that to the SPMI device - it's possible that this will change
> in the future with a newer revision of the controller IP, and
> this is the main reason for that.
> 
> To make use of this implementation, this driver also adds the
> required bits to support MediaTek MT6363 and MT6373 SPMI PMICs.
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/mfd/Kconfig         |  17 ++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/mtk-spmi-pmic.c | 410 ++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mt6363.h  |  26 +++
>  include/linux/mfd/mt6373.h  |  21 ++
>  5 files changed, 475 insertions(+)
>  create mode 100644 drivers/mfd/mtk-spmi-pmic.c
>  create mode 100644 include/linux/mfd/mt6363.h
>  create mode 100644 include/linux/mfd/mt6373.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 13c955d31309..339fcd37eab6 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1120,6 +1120,23 @@ config MFD_MT6397
>  	  accessing the device; additional drivers must be enabled in order
>  	  to use the functionality of the device.
>  
> +config MFD_MTK_SPMI_PMIC
> +	tristate "MediaTek SPMI PMICs"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on OF
> +	depends on SPMI
> +	select REGMAP_SPMI
> +	default y if ARCH_MEDIATEK

When would this be built as a module?

> +	help
> +	  Say yes here to enable support for MediaTek's SPMI PMICs.
> +	  These PMICs made their first appearance in board designs using the
> +          MediaTek Dimensity 9400 series of SoCs.

Odd tabbing.

> +	  Note that this will only be useful paired with descriptions of the

"when paired"

> +	  independent functions as children nodes in the device tree.

"child nodes"

> +
> +	  Say M here if you want to include support for the MediaTek SPMI
> +	  PMICs as a module. The module will be called "mtk-spmi-pmic".
> +
>  config MFD_MENF21BMC
>  	tristate "MEN 14F021P00 Board Management Controller Support"
>  	depends on I2C
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index d2720d496e07..8f33fd9519ac 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -187,6 +187,7 @@ obj-$(CONFIG_MFD_MT6360)	+= mt6360-core.o
>  obj-$(CONFIG_MFD_MT6370)	+= mt6370.o
>  mt6397-objs			:= mt6397-core.o mt6397-irq.o mt6358-irq.o
>  obj-$(CONFIG_MFD_MT6397)	+= mt6397.o
> +obj-$(CONFIG_MFD_MTK_SPMI_PMIC)	+= mtk-spmi-pmic.o
>  
>  obj-$(CONFIG_RZ_MTU3)		+= rz-mtu3.o
>  obj-$(CONFIG_ABX500_CORE)	+= abx500-core.o
> diff --git a/drivers/mfd/mtk-spmi-pmic.c b/drivers/mfd/mtk-spmi-pmic.c
> new file mode 100644
> index 000000000000..512b53bdb0d1
> --- /dev/null
> +++ b/drivers/mfd/mtk-spmi-pmic.c
> @@ -0,0 +1,410 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024 MediaTek Inc.
> + * Copyright (c) 2025 Collabora Ltd
> + *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Put this in an Authors: section.

> + */
> +
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/gfp.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/spmi.h>
> +#include <linux/types.h>
> +#include <linux/regmap.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/mfd/mt6363.h>
> +#include <linux/mfd/mt6373.h>

This whole section should be ordered.

> +#define MTK_SPMI_PMIC_VAL_BITS		8
> +#define MTK_SPMI_PMIC_CHIP_ID_REG_M	0xb

What is "M"?

> +#define MTK_SPMI_PMIC_RCS_IRQ_DONE	0x41b
> +
> +/**
> + * mtk_spmi_pmic_irq_group - Group of interrupts in SPMI PMIC
> + * @num_int_regs: Number of registers for this group of interrupts
> + * @con_reg:      PMIC Interrupt Group Control 0 register
> + * @sta_reg:      PMIC Interrupt Group Status 0 register
> + * @group_num:    PMIC Interrupt Group number - also corresponds to the
> + *                status bit in the global IRQ Control register
> + */

If you _really_ want to use kerneldoc, you must run W=1.

> +struct mtk_spmi_pmic_irq_grp {
> +	u8 hwirq_base;
> +	u8 num_int_regs;
> +	u16 con_reg;
> +	u16 sta_reg;
> +	u8 group_num;
> +};
> +
> +/**
> + * mtk_spmi_pmic_pdata - SPMI PMIC Platform Data
> + * @pmic_irq:    Group of interrupts in SPMI PMIC
> + * @num_groups:  Number of groups of interrupts
> + * @con_reg_sz:  Size of Control registers, depends on existence

"size" or "len" is nicer.

> + *               of SET and CLR registers in the layout
> + * @top_irq_reg: Global interrupt status register, explains which
> + *               group needs attention because of a group irq
> + * @chip_id_reg: Chip ID Register
> + */
> +struct mtk_spmi_pmic_pdata {
> +	const struct mtk_spmi_pmic_irq_grp *pmic_irq;
> +	u8 num_groups;
> +	u8 con_reg_sz;
> +	u8 top_irq_reg;
> +	u8 chip_id_reg;
> +};
> +
> +/**
> + * mtk_spmi_pmic - Main driver structure
> + * @pdata:    SPMI PMIC Platform data

This already exists in 'dev'.

In fact, I'm not sure this is platform data, per say.

In the device driver model, platform data usually gets passed to a child
device for consumption.  However, here the driver is feeding from it,
which is not correct.

I think just a rename is in order.  What does this actually describe?

> + * @dev:      Handle to SPMI Device
> + * @dom:      IRQ Domain of the PMIC's interrupt controller
> + * @regmap:   Handle to PMIC regmap
> + * @irq_lock: Lock for the PMIC's irqchip
> + * @irq:      PMIC chained interrupt
> + */
> +struct mtk_spmi_pmic {
> +	const struct mtk_spmi_pmic_pdata *pdata;
> +	struct device *dev;
> +	struct irq_domain *dom;
> +	struct regmap *regmap;
> +	struct mutex irq_lock;
> +	int irq;
> +};
> +
> +static void mtk_spmi_pmic_irq_set_unmasking(struct irq_data *d, bool unmask)
> +{
> +	struct mtk_spmi_pmic *pmic = irq_data_get_irq_chip_data(d);
> +	const struct mtk_spmi_pmic_pdata *pdata = pmic->pdata;
> +	struct regmap *regmap = pmic->regmap;
> +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +	unsigned short i;
> +
> +	for (i = 0; i < pdata->num_groups; i++) {
> +		const struct mtk_spmi_pmic_irq_grp *irq_grp = &pdata->pmic_irq[i];
> +		u32 con_reg;
> +		u8 irq_en_bit;
> +
> +		if (hwirq < irq_grp->hwirq_base)
> +			continue;
> +
> +		con_reg = irq_grp->con_reg + (pdata->con_reg_sz * i);
> +		irq_en_bit = hwirq - irq_grp->hwirq_base;
> +
> +		regmap_assign_bits(regmap, con_reg, BIT(irq_en_bit), unmask);
> +
> +		break;
> +	}
> +}
> +
> +static void mtk_spmi_pmic_irq_mask(struct irq_data *d)
> +{
> +	mtk_spmi_pmic_irq_set_unmasking(d, false);
> +}
> +
> +static void mtk_spmi_pmic_irq_unmask(struct irq_data *d)
> +{
> +	mtk_spmi_pmic_irq_set_unmasking(d, true);
> +}
> +
> +static void mtk_spmi_pmic_irq_lock(struct irq_data *d)
> +{
> +	struct mtk_spmi_pmic *pmic = irq_data_get_irq_chip_data(d);
> +
> +	mutex_lock(&pmic->irq_lock);
> +}
h> +
> +static void mtk_spmi_pmic_irq_sync_unlock(struct irq_data *d)
> +{
> +	struct mtk_spmi_pmic *pmic = irq_data_get_irq_chip_data(d);
> +
> +	mutex_unlock(&pmic->irq_lock);
> +}
> +
> +static struct irq_chip mtk_spmi_pmic_irq_chip = {
> +	.name = "mtk-spmi-pmic",
> +	.irq_mask = mtk_spmi_pmic_irq_mask,
> +	.irq_unmask = mtk_spmi_pmic_irq_unmask,
> +	.irq_bus_lock = mtk_spmi_pmic_irq_lock,
> +	.irq_bus_sync_unlock = mtk_spmi_pmic_irq_sync_unlock,
> +	.flags = IRQCHIP_SKIP_SET_WAKE,
> +};
> +
> +static int mtk_spmi_pmic_irq_domain_map(struct irq_domain *d, unsigned int virq,
> +					irq_hw_number_t hwirq)
> +{
> +	struct mtk_spmi_pmic *pmic = d->host_data;
> +
> +	irq_set_chip_data(virq, pmic);
> +	irq_set_chip_and_handler(virq, &mtk_spmi_pmic_irq_chip, handle_level_irq);
> +
> +	return 0;
> +}
> +
> +static int mtk_spmi_pmic_irq_xlate(struct irq_domain *d, struct device_node *ctrlr,
> +				  const u32 *intspec, unsigned int intsize,
> +				  unsigned long *out_hwirq, unsigned int *out_type)
> +{
> +	struct mtk_spmi_pmic *pmic = d->host_data;
> +	struct device *dev = pmic->dev;
> +	struct irq_fwspec fwspec;
> +
> +	of_phandle_args_to_fwspec(ctrlr, intspec, intsize, &fwspec);
> +	if (WARN_ON(fwspec.param_count < 3))

Let's not WARN if we don't have to.  This can crash the kernel.

Simply print a dev_err() and return the error value.

> +		return -EINVAL;
> +
> +	/*
> +	 * The IRQ number in intspec[0] is ignored on purpose here!
> +	 *
> +	 * This is because of how at least the first revision of the SPMI 2.0
> +	 * controller works in MediaTek SoCs: the controller will raise an
> +	 * interrupt for each SID (but doesn't know the details!), and the

Does the exclamation mark add anything here?

> +	 * specific IRQ number that got raised must be read from the PMIC or
> +	 * its sub-device driver.
> +	 * It's possible that this will change in the future with a newer
> +	 * revision of the SPMI controller, and this is why the devicetree

"device tree".

> +	 * holds the full intspec.

In full please.  Some people might not know the abbreviations.

> +	 */
> +	*out_hwirq = intspec[1];

Please #define what will be held in elements 0, 1 and 2.

> +	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
> +
> +	dev_dbg(dev, "Found device IRQ %u chained from SPMI IRQ %x (map: 0x%lx)\n",
> +		intspec[1], intspec[0], *out_hwirq);

Who is going to find this useful now development is complete?

Suggest removing this and subsequent debug prints.

> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops mtk_spmi_pmic_irq_domain_ops = {
> +	.map = mtk_spmi_pmic_irq_domain_map,
> +	.xlate = mtk_spmi_pmic_irq_xlate,
> +};
> +
> +static int mtk_spmi_pmic_handle_group_irq(struct mtk_spmi_pmic *pmic, int group)
> +{
> +	const struct mtk_spmi_pmic_irq_grp *irq_grp = &pmic->pdata->pmic_irq[group];
> +	struct regmap *regmap = pmic->regmap;
> +	struct device *dev = pmic->dev;
> +	int i, ret;
> +
> +	for (i = 0; i < irq_grp->num_int_regs; i++) {

You can use:

  for (int i = 0; ...

... if you want.

> +		u32 status, saved_status;
> +
> +		ret = regmap_read(regmap, irq_grp->sta_reg + i, &status);
> +		if (ret) {
> +			dev_err(dev, "Could not read IRQ status register: %d", ret);
> +			return ret;
> +		}
> +
> +		if (status == 0)
> +			continue;
> +
> +		saved_status = status;
> +		do {
> +			irq_hw_number_t hwirq;
> +			u8 bit = __ffs(status);
> +
> +			/* Each reg has 8 bits: this is the first irq of this group */

"register"
"IRQ"

> +			hwirq = MTK_SPMI_PMIC_VAL_BITS * i;
> +
> +			/* Offset by this group's start interrupt */
> +			hwirq += irq_grp->hwirq_base;
> +
> +			/* Finally, offset by the fired irq's bit number */

As above and throughout.

> +			hwirq += bit;
> +
> +			status &= ~BIT(bit);
> +
> +			generic_handle_domain_irq(pmic->dom, hwirq);
> +		} while (status);
> +
> +		/* Clear the interrupts by writing the previous status */
> +		regmap_write(regmap, irq_grp->sta_reg + i, saved_status);
> +	}
> +
> +	return 0;
> +}
> +
> +static void mtk_spmi_pmic_handle_chained_irq(struct irq_desc *desc)
> +{
> +	struct mtk_spmi_pmic *pmic = irq_desc_get_handler_data(desc);
> +	const struct mtk_spmi_pmic_pdata *pdata = pmic->pdata;
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct regmap *regmap = pmic->regmap;
> +	bool irq_handled = false;
> +	int i, ret;
> +	u32 val;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	ret = regmap_read(regmap, pdata->top_irq_reg, &val);
> +	if (ret)
> +		handle_bad_irq(desc);
> +
> +	dev_dbg(pmic->dev, "PMIC IRQ Status: %x\n", val);
> +
> +	/* This is very unlikely to happen */
> +	if (val == 0) {
> +		chained_irq_exit(chip, desc);
> +		return;
> +	}
> +
> +	for (i = 0; i < pdata->num_groups; i++) {
> +		const struct mtk_spmi_pmic_irq_grp *irq_grp = &pdata->pmic_irq[i];
> +		u8 group_bit = BIT(irq_grp[i].group_num);
> +
> +		if (val & group_bit) {
> +			ret = mtk_spmi_pmic_handle_group_irq(pmic, i);
> +			if (ret == 0)
> +				irq_handled = true;
> +		}
> +	}
> +
> +	/* The RCS flag has to be cleared even if the IRQ was not handled. */
> +	ret = regmap_write(regmap, MTK_SPMI_PMIC_RCS_IRQ_DONE, 1);
> +	if (ret)
> +		dev_warn(pmic->dev, "Could not clear RCS flag!\n");
> +
> +	if (!irq_handled)
> +		handle_bad_irq(desc);
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void mtk_spmi_pmic_irq_remove(void *data)
> +{
> +	struct mtk_spmi_pmic *pmic = (struct mtk_spmi_pmic *)data;
> +
> +	irq_set_chained_handler_and_data(pmic->irq, NULL, NULL);
> +	irq_domain_remove(pmic->dom);
> +}
> +
> +static int mtk_spmi_pmic_irq_init(struct spmi_device *sdev, struct regmap *regmap,
> +				  const struct mtk_spmi_pmic_pdata *pdata)
> +{
> +	struct mtk_spmi_pmic *pmic;
> +	int ret;
> +
> +	pmic = devm_kzalloc(&sdev->dev, sizeof(*pmic), GFP_KERNEL);
> +	if (!pmic)
> +		return -ENOMEM;
> +
> +	pmic->irq = of_irq_get(sdev->dev.of_node, 0);
> +	if (pmic->irq < 0)
> +		return dev_err_probe(&sdev->dev, pmic->irq, "Cannot get IRQ\n");
> +
> +	pmic->dev = &sdev->dev;
> +	pmic->regmap = regmap;
> +	pmic->pdata = pdata;

Where is this consumed?

> +	mutex_init(&pmic->irq_lock);
> +
> +	pmic->dom = irq_domain_add_tree(sdev->dev.of_node,
> +					&mtk_spmi_pmic_irq_domain_ops, pmic);

Feel free to use 100-chars to prevent ugly line-breaks.

> +	if (!pmic->dom)
> +		return dev_err_probe(&sdev->dev, -ENOMEM, "Cannot create IRQ domain\n");
> +
> +	ret = devm_add_action_or_reset(&sdev->dev, mtk_spmi_pmic_irq_remove, pmic);
> +	if (ret) {
> +		irq_domain_remove(pmic->dom);
> +		return ret;
> +	}
> +
> +	irq_set_chained_handler_and_data(pmic->irq, mtk_spmi_pmic_handle_chained_irq, pmic);
> +
> +	return 0;
> +}
> +
> +#define MTK_SPMI_PMIC_IRQ_GROUP(pmic, grp, gnum, first_irq, last_irq)	\

grp = group_name
gnum = group_index

... or similar.

> +{									\
> +	.hwirq_base = first_irq,					\
> +	.num_int_regs = ((last_irq - first_irq) /			\
> +			 MTK_SPMI_PMIC_VAL_BITS) + 1,			\

100-chars.

> +	.con_reg = pmic##_##grp##_TOP_INT_CON0,				\
> +	.sta_reg = pmic##_##grp##_TOP_INT_STATUS0,			\
> +	.group_num = gnum,						\
> +}
> +
> +static const struct mtk_spmi_pmic_irq_grp mt6363_irq_groups[] = {
> +	MTK_SPMI_PMIC_IRQ_GROUP(MT6363, BUCK, 0, 0, 9),
> +	MTK_SPMI_PMIC_IRQ_GROUP(MT6363, LDO, 1, 16, 40),
> +	MTK_SPMI_PMIC_IRQ_GROUP(MT6363, PSC, 2, 48, 57),
> +	MTK_SPMI_PMIC_IRQ_GROUP(MT6363, MISC, 3, 64, 79),
> +	MTK_SPMI_PMIC_IRQ_GROUP(MT6363, HK, 4, 80, 87),
> +	MTK_SPMI_PMIC_IRQ_GROUP(MT6363, BM, 6, 88, 107)

Please tab out the numbers - straight lines make my OCD happy!

> +};
> +
> +static const struct mtk_spmi_pmic_irq_grp mt6373_irq_groups[] = {
> +	MTK_SPMI_PMIC_IRQ_GROUP(MT6373, BUCK, 0, 0, 9),
> +	MTK_SPMI_PMIC_IRQ_GROUP(MT6373, LDO, 1, 16, 39),
> +	MTK_SPMI_PMIC_IRQ_GROUP(MT6373, MISC, 3, 56, 71),
> +};
> +
> +static const struct mtk_spmi_pmic_pdata mt6363_pdata = {
> +	.pmic_irq = mt6363_irq_groups,
> +	.num_groups = ARRAY_SIZE(mt6363_irq_groups),
> +	.con_reg_sz = 3,
> +	.top_irq_reg = MT6363_TOP_INT_STATUS1,
> +	.chip_id_reg = MTK_SPMI_PMIC_CHIP_ID_REG_M,
> +};
> +
> +static const struct mtk_spmi_pmic_pdata mt6373_pdata = {
> +	.pmic_irq = mt6373_irq_groups,
> +	.num_groups = ARRAY_SIZE(mt6373_irq_groups),
> +	.con_reg_sz = 3,
> +	.top_irq_reg = MT6373_TOP_INT_STATUS1,
> +	.chip_id_reg = MTK_SPMI_PMIC_CHIP_ID_REG_M,
> +};
> +
> +static const struct regmap_config mtk_spmi_regmap_config = {
> +	.reg_bits	= 16,
> +	.val_bits	= MTK_SPMI_PMIC_VAL_BITS,
> +	.max_register	= 0xffff,
> +	.fast_io	= true,
> +};
> +
> +static int mtk_spmi_pmic_probe(struct spmi_device *sdev)
> +{
> +	const struct mtk_spmi_pmic_pdata *pdata;
> +	struct device *dev = &sdev->dev;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = devm_regmap_init_spmi_ext(sdev, &mtk_spmi_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	pdata = (const struct mtk_spmi_pmic_pdata *)device_get_match_data(&sdev->dev);

"dev" here or remove the variable and use "sdev->dev" everywhere.

> +	if (pdata && pdata->num_groups) {
> +		ret = mtk_spmi_pmic_irq_init(sdev, regmap, pdata);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_of_platform_populate(dev);
> +}
> +
> +static const struct of_device_id mtk_pmic_spmi_id_table[] = {
> +	{ .compatible = "mediatek,mt6363", .data = &mt6363_pdata },
> +	{ .compatible = "mediatek,mt6373", .data = &mt6373_pdata },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mtk_pmic_spmi_id_table);
> +
> +static struct spmi_driver mtk_spmi_pmic_driver = {
> +	.probe = mtk_spmi_pmic_probe,
> +	.driver = {
> +		.name = "mtk-spmi-pmic",
> +		.of_match_table = mtk_pmic_spmi_id_table,
> +	},
> +};
> +module_spmi_driver(mtk_spmi_pmic_driver);
> +
> +MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
> +MODULE_DESCRIPTION("MediaTek SPMI PMIC driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/mt6363.h b/include/linux/mfd/mt6363.h
> new file mode 100644
> index 000000000000..2e13398f5af5
> --- /dev/null
> +++ b/include/linux/mfd/mt6363.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2021 MediaTek Inc.
> + * Copyright (c) 2025 Collabora Ltd
> + *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#ifndef __MFD_MT6363_H__
> +#define __MFD_MT6363_H__
> +
> +/* PMIC Registers */
> +#define MT6363_MISC_TOP_INT_CON0	0x37
> +#define MT6363_MISC_TOP_INT_STATUS0	0x43
> +#define MT6363_TOP_INT_STATUS1		0x4e
> +#define MT6363_PSC_TOP_INT_CON0		0x90f
> +#define MT6363_PSC_TOP_INT_STATUS0	0x91b
> +#define MT6363_BM_TOP_INT_CON0		0xc24
> +#define MT6363_BM_TOP_INT_STATUS0	0xc36
> +#define MT6363_HK_TOP_INT_CON0		0xf92
> +#define MT6363_HK_TOP_INT_STATUS0	0xf9e
> +#define MT6363_BUCK_TOP_INT_CON0	0x1411
> +#define MT6363_BUCK_TOP_INT_STATUS0	0x141d
> +#define MT6363_LDO_TOP_INT_CON0		0x1b11
> +#define MT6363_LDO_TOP_INT_STATUS0	0x1b29

 MT6363_REG_ to disambiguate.

> +#endif /* __MFD_MT6363_H__ */
> diff --git a/include/linux/mfd/mt6373.h b/include/linux/mfd/mt6373.h

You don't need a whole new file for this.

Just create include/linux/mfd/mt63x3.h and roll with it.

Ah wait!  The convention seems to have already been set:

include/linux/mfd/mt63??/{core,registers}.h

Please follow convention, but also be sensible - do we really need all
of these tiny files?

> new file mode 100644
> index 000000000000..3509e46447bd
> --- /dev/null
> +++ b/include/linux/mfd/mt6373.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2021 MediaTek Inc.
> + * Copyright (c) 2025 Collabora Ltd
> + *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#ifndef __MFD_MT6373_H__
> +#define __MFD_MT6373_H__
> +
> +/* PMIC Registers */
> +#define MT6373_MISC_TOP_INT_CON0	0x3c
> +#define MT6373_MISC_TOP_INT_STATUS0	0x48
> +#define MT6373_TOP_INT_MASK_CON0	0x4c
> +#define MT6373_TOP_INT_STATUS1		0x53
> +#define MT6373_BUCK_TOP_INT_CON0	0x1411
> +#define MT6373_BUCK_TOP_INT_STATUS0	0x141d
> +#define MT6373_LDO_TOP_INT_CON0		0x1b10
> +#define MT6373_LDO_TOP_INT_STATUS0	0x1b22
> +
> +#endif /* __MFD_MT6373_H__ */
> -- 
> 2.51.0
> 

-- 
Lee Jones [李琼斯]

