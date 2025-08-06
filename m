Return-Path: <linux-kernel+bounces-757571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCA1B1C3B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B756D186F8D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6DD25B1F4;
	Wed,  6 Aug 2025 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="2R/iuoHe"
Received: from va-1-20.ptr.blmpb.com (va-1-20.ptr.blmpb.com [209.127.230.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C55324E4D4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473705; cv=none; b=bd43kxPvh2cKg57dqii4mF5mUs1Fo1BEk3pLLg98tKS+ZuovkVAHlFiXITaiwhMzTB14thWkKJXZJpF9yzuNIY8CWrQgzzUDrurdqqZ7qbyDAI/dDOJL9u0MZnScTMckviiIHLpVzhSF4L8RtMERtYL+OfFu0QB6ima+U+iydQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473705; c=relaxed/simple;
	bh=TEsIKnBsCktk6RJ28Mqo4VSt/4/wL8gN/g8z98ikFfQ=;
	h=References:In-Reply-To:Message-Id:Subject:To:Date:Cc:Mime-Version:
	 Content-Type:From; b=cde3x3823oRcJECvGATp2Wo6THHRX8m0ddV6nPW1rQMwFrggLpmAJwRemVpNZnVMZHhkK/kU5Spw9CGejha/Pgp3sDQw0DSaJq+DrCaSc3j3UzCq0t38vYOldXCQgJ/HaZXkw0VVQGlB/tUQK35K6OBdwudTBB2NpPxH/wfrduw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=2R/iuoHe; arc=none smtp.client-ip=209.127.230.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1754473657;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=MOxyGAUvtGsG+BpRNS5MGijddPl/igFFVF2ruJUQHXg=;
 b=2R/iuoHeTBR+GXWSqwsZbQTZoTUlLX8H03/xv0o98LvdugWL/lAu/l5DYPT8W6dveQpvSS
 yBU+3XTpAySErdw2i5op51DBl+zOH1Dcfv2bj7yWVIH/B9M7OJjNEbJM/8w6ubxFdbbpP0
 3H/bvJj23vn3kmnEjj9y5kc4rzWa/4+lAczhAlTyfls3wraFl8tpFOtgiiAl/C2szjF0LK
 gBIOGhEnhRKzuLRcmVB/ooxPLWvRf6EYMPZgD98tgKmeULDMpd8oJ/iKjZ1a3lfCKS5k74
 VkGSxSBeoByJJMzTWnXHICEuLxsyH85Une01M94cwaORqES+TyObOrTALQ3o6Q==
References: <20250806082726.8835-1-nick.hu@sifive.com> <20250806082726.8835-3-nick.hu@sifive.com>
In-Reply-To: <20250806082726.8835-3-nick.hu@sifive.com>
X-Lms-Return-Path: <lba+2689324b7+33711e+vger.kernel.org+liujingqi@lanxincomputing.com>
Message-Id: <08667f67-7821-4a93-afc1-72e6575e866a@lanxincomputing.com>
Subject: Re: [PATCH v2 2/2] irqchip/riscv-aplic: Save and restore APLIC registers
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Nick Hu" <nick.hu@sifive.com>, <anup@brainfault.org>, 
	"Alexandre Ghiti" <alex@ghiti.fr>, <linux-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>
Date: Wed, 6 Aug 2025 17:47:33 +0800
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Wed, 06 Aug 2025 17:47:34 +0800
Content-Transfer-Encoding: 7bit
Cc: "Thomas Gleixner" <tglx@linutronix.de>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
From: "Nutty Liu" <liujingqi@lanxincomputing.com>

On 8/6/2025 4:27 PM, Nick Hu wrote:
> The APLIC may be powered down when the CPUs enter a deep sleep state.
> Therefore adding the APLIC save and restore functions to save and
> restore the states of APLIC.
>
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> Reviewed-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Cyan Yang <cyan.yang@sifive.com>
> ---
>   drivers/irqchip/irq-riscv-aplic-direct.c |  11 ++
>   drivers/irqchip/irq-riscv-aplic-main.c   | 158 ++++++++++++++++++++++-
>   drivers/irqchip/irq-riscv-aplic-main.h   |  11 ++
>   3 files changed, 179 insertions(+), 1 deletion(-)
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>

Thanks,
Nutty
> diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
> index 205ad61d15e4..61b9ac2e1b7b 100644
> --- a/drivers/irqchip/irq-riscv-aplic-direct.c
> +++ b/drivers/irqchip/irq-riscv-aplic-direct.c
> @@ -8,6 +8,7 @@
>   #include <linux/bitfield.h>
>   #include <linux/bitops.h>
>   #include <linux/cpu.h>
> +#include <linux/cpumask.h>
>   #include <linux/interrupt.h>
>   #include <linux/irqchip.h>
>   #include <linux/irqchip/chained_irq.h>
> @@ -171,6 +172,16 @@ static void aplic_idc_set_delivery(struct aplic_idc *idc, bool en)
>   	writel(de, idc->regs + APLIC_IDC_IDELIVERY);
>   }
>   
> +void aplic_direct_restore(struct aplic_priv *priv)
> +{
> +	struct aplic_direct *direct =
> +			container_of(priv, struct aplic_direct, priv);
> +	int cpu;
> +
> +	for_each_cpu(cpu, &direct->lmask)
> +		aplic_idc_set_delivery(per_cpu_ptr(&aplic_idcs, cpu), true);
> +}
> +
>   static int aplic_direct_dying_cpu(unsigned int cpu)
>   {
>   	if (aplic_direct_parent_irq)
> diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
> index 93e7c51f944a..91fe3305934d 100644
> --- a/drivers/irqchip/irq-riscv-aplic-main.c
> +++ b/drivers/irqchip/irq-riscv-aplic-main.c
> @@ -12,10 +12,143 @@
>   #include <linux/of.h>
>   #include <linux/of_irq.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/printk.h>
> +#include <linux/syscore_ops.h>
>   
>   #include "irq-riscv-aplic-main.h"
>   
> +static LIST_HEAD(aplics);
> +
> +static void aplic_restore(struct aplic_priv *priv)
> +{
> +	int i;
> +	u32 clrip;
> +
> +	writel(priv->saved_domaincfg, priv->regs + APLIC_DOMAINCFG);
> +#ifdef CONFIG_RISCV_M_MODE
> +	writel(priv->saved_msiaddr, priv->regs + APLIC_xMSICFGADDR);
> +	writel(priv->saved_msiaddrh, priv->regs + APLIC_xMSICFGADDRH);
> +#endif
> +	for (i = 1; i <= priv->nr_irqs; i++) {
> +		writel(priv->saved_sourcecfg[i - 1],
> +		       priv->regs + APLIC_SOURCECFG_BASE +
> +		       (i - 1) * sizeof(u32));
> +		writel(priv->saved_target[i - 1],
> +		       priv->regs + APLIC_TARGET_BASE +
> +		       (i - 1) * sizeof(u32));
> +	}
> +
> +	for (i = 0; i <= priv->nr_irqs; i += 32) {
> +		writel(-1U, priv->regs + APLIC_CLRIE_BASE +
> +			    (i / 32) * sizeof(u32));
> +		writel(priv->saved_ie[i / 32],
> +		       priv->regs + APLIC_SETIE_BASE +
> +		       (i / 32) * sizeof(u32));
> +	}
> +
> +	if (priv->nr_idcs) {
> +		aplic_direct_restore(priv);
> +	} else {
> +		/* Re-trigger the interrupts */
> +		for (i = 0; i <= priv->nr_irqs; i += 32) {
> +			clrip = readl(priv->regs + APLIC_CLRIP_BASE +
> +				      (i / 32) * sizeof(u32));
> +			writel(clrip, priv->regs + APLIC_SETIP_BASE +
> +				      (i / 32) * sizeof(u32));
> +		}
> +	}
> +}
> +
> +static void aplic_save(struct aplic_priv *priv)
> +{
> +	int i;
> +
> +	for (i = 1; i <= priv->nr_irqs; i++) {
> +		priv->saved_target[i - 1] = readl(priv->regs +
> +						  APLIC_TARGET_BASE +
> +						  (i - 1) * sizeof(u32));
> +	}
> +
> +	for (i = 0; i <= priv->nr_irqs; i += 32) {
> +		priv->saved_ie[i / 32] = readl(priv->regs +
> +					       APLIC_SETIE_BASE +
> +					       (i / 32) * sizeof(u32));
> +	}
> +}
> +
> +static int aplic_syscore_suspend(void)
> +{
> +	struct aplic_priv *priv;
> +
> +	list_for_each_entry(priv, &aplics, head) {
> +		aplic_save(priv);
> +	}
> +
> +	return 0;
> +}
> +
> +static void aplic_syscore_resume(void)
> +{
> +	struct aplic_priv *priv;
> +
> +	list_for_each_entry(priv, &aplics, head) {
> +		aplic_restore(priv);
> +	}
> +}
> +
> +static struct syscore_ops aplic_syscore_ops = {
> +	.suspend = aplic_syscore_suspend,
> +	.resume = aplic_syscore_resume,
> +};
> +
> +static int aplic_pm_notifier(struct notifier_block *nb, unsigned long action, void *data)
> +{
> +	struct aplic_priv *priv = container_of(nb, struct aplic_priv, genpd_nb);
> +
> +	switch (action) {
> +	case GENPD_NOTIFY_PRE_OFF:
> +		aplic_save(priv);
> +		break;
> +	case GENPD_NOTIFY_ON:
> +		aplic_restore(priv);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static void aplic_remove(void *data)
> +{
> +	struct aplic_priv *priv = data;
> +
> +	list_del(&priv->head);
> +	dev_pm_genpd_remove_notifier(priv->dev);
> +}
> +
> +static int aplic_add(struct device *dev, struct aplic_priv *priv)
> +{
> +	int ret;
> +
> +	list_add(&priv->head, &aplics);
> +	/* Add genpd notifier */
> +	priv->genpd_nb.notifier_call = aplic_pm_notifier;
> +	ret = dev_pm_genpd_add_notifier(dev, &priv->genpd_nb);
> +	if (ret && ret != -ENODEV && ret != -EOPNOTSUPP) {
> +		list_del(&priv->head);
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, aplic_remove, priv);
> +	if (ret)
> +		return ret;
> +
> +	return devm_pm_runtime_enable(dev);
> +}
> +
>   void aplic_irq_unmask(struct irq_data *d)
>   {
>   	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
> @@ -59,6 +192,7 @@ int aplic_irq_set_type(struct irq_data *d, unsigned int type)
>   	sourcecfg = priv->regs + APLIC_SOURCECFG_BASE;
>   	sourcecfg += (d->hwirq - 1) * sizeof(u32);
>   	writel(val, sourcecfg);
> +	priv->saved_sourcecfg[d->hwirq - 1] = val;
>   
>   	return 0;
>   }
> @@ -95,6 +229,8 @@ void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode)
>   		valh |= FIELD_PREP(APLIC_xMSICFGADDRH_HHXS, priv->msicfg.hhxs);
>   		writel(val, priv->regs + APLIC_xMSICFGADDR);
>   		writel(valh, priv->regs + APLIC_xMSICFGADDRH);
> +		priv->saved_msiaddr = val;
> +		priv->saved_msiaddrh = valh;
>   	}
>   #endif
>   
> @@ -106,6 +242,7 @@ void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode)
>   	writel(val, priv->regs + APLIC_DOMAINCFG);
>   	if (readl(priv->regs + APLIC_DOMAINCFG) != val)
>   		dev_warn(priv->dev, "unable to write 0x%x in domaincfg\n", val);
> +	priv->saved_domaincfg = val;
>   }
>   
>   static void aplic_init_hw_irqs(struct aplic_priv *priv)
> @@ -176,7 +313,24 @@ int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iomem *
>   	/* Setup initial state APLIC interrupts */
>   	aplic_init_hw_irqs(priv);
>   
> -	return 0;
> +	/* For power management */
> +	priv->saved_target = devm_kzalloc(dev, priv->nr_irqs * sizeof(u32),
> +					  GFP_KERNEL);
> +	if (!priv->saved_target)
> +		return -ENOMEM;
> +
> +	priv->saved_sourcecfg = devm_kzalloc(dev, priv->nr_irqs * sizeof(u32),
> +					     GFP_KERNEL);
> +	if (!priv->saved_sourcecfg)
> +		return -ENOMEM;
> +
> +	priv->saved_ie = devm_kzalloc(dev,
> +				      DIV_ROUND_UP(priv->nr_irqs, 32) * sizeof(u32),
> +				      GFP_KERNEL);
> +	if (!priv->saved_ie)
> +		return -ENOMEM;
> +
> +	return aplic_add(dev, priv);
>   }
>   
>   static int aplic_probe(struct platform_device *pdev)
> @@ -209,6 +363,8 @@ static int aplic_probe(struct platform_device *pdev)
>   	if (rc)
>   		dev_err_probe(dev, rc, "failed to setup APLIC in %s mode\n",
>   			      msi_mode ? "MSI" : "direct");
> +	else
> +		register_syscore_ops(&aplic_syscore_ops);
>   
>   #ifdef CONFIG_ACPI
>   	if (!acpi_disabled)
> diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/irq-riscv-aplic-main.h
> index b0ad8cde69b1..f27d5ff1c741 100644
> --- a/drivers/irqchip/irq-riscv-aplic-main.h
> +++ b/drivers/irqchip/irq-riscv-aplic-main.h
> @@ -24,6 +24,7 @@ struct aplic_msicfg {
>   };
>   
>   struct aplic_priv {
> +	struct list_head	head;
>   	struct device		*dev;
>   	u32			gsi_base;
>   	u32			nr_irqs;
> @@ -31,6 +32,15 @@ struct aplic_priv {
>   	u32			acpi_aplic_id;
>   	void __iomem		*regs;
>   	struct aplic_msicfg	msicfg;
> +	struct notifier_block	genpd_nb;
> +	u32 *saved_target;
> +	u32 *saved_sourcecfg;
> +	u32 *saved_ie;
> +	u32 saved_domaincfg;
> +#ifdef CONFIG_RISCV_M_MODE
> +	u32 saved_msiaddr;
> +	u32 saved_msiaddrh;
> +#endif
>   };
>   
>   void aplic_irq_unmask(struct irq_data *d);
> @@ -39,6 +49,7 @@ int aplic_irq_set_type(struct irq_data *d, unsigned int type);
>   int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u32 gsi_base,
>   			      unsigned long *hwirq, unsigned int *type);
>   void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode);
> +void aplic_direct_restore(struct aplic_priv *priv);
>   int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iomem *regs);
>   int aplic_direct_setup(struct device *dev, void __iomem *regs);
>   #ifdef CONFIG_RISCV_APLIC_MSI

