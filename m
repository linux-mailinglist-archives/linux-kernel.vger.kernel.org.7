Return-Path: <linux-kernel+bounces-757541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3076B1C366
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C812E18A5BA3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6F0288519;
	Wed,  6 Aug 2025 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="nqR6yqPJ"
Received: from sg-1-19.ptr.blmpb.com (sg-1-19.ptr.blmpb.com [118.26.132.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6281FBE80
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754472666; cv=none; b=BXfXzwnMSAd1mp/ebU0nDU7hQTL+pTGrAz/+jxrkpxcBFNQ0Kgc7KzI1IWo0NK3nuOzm384YPcRfZNA2q09jmAPketsqYuh7pEnR0Sm2TGT9daZAsOMKQfLfat0Cgjt71e0tpwE3xkcpLb3N1taABpHugG9jcsX1jNR1F8co2Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754472666; c=relaxed/simple;
	bh=//+yvW26+zhbDmaZWxXy/IPR8L73jsj5oGIYBEaDI/w=;
	h=To:In-Reply-To:Subject:Message-Id:Cc:Mime-Version:From:Date:
	 References:Content-Type; b=ubHPe9IAuXX7kjwDiXarnNq8QQpuFjDWX8UOLtvaoOOG9Qkiu/OfFmCqFUPt76rn1ol7YEkwzFLMHs2PkvHnHi0eZUubW1dfIwkKLVdPvYc0INzYG/KoWs/q07Ul0nuftYX2GJTw8fHOpHMFiPfr8QokFkKjeYD2UVJbYUE3N/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=nqR6yqPJ; arc=none smtp.client-ip=118.26.132.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1754472539;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=fBUEwNprg52rGFcGYTZBrY1u6S9H9M004MLIbBJj4zA=;
 b=nqR6yqPJ9IuUJ5EGVoNsMq42MGUumel8Ig/PcFtLi2NqkgrPwrnNLVt7dIDv8uw3leUBNN
 o8kqsTHr/M5yOAMtSobqGZi4yMLANAiJe7nDlaQscVwYjWYd6ragFGQdMJ/PsquoZvRDUF
 86Q1CYAIcnvmCaqQJkiaI7qyJtswgZPjnZodFI+tJthjrXELvnvaIzrFg/+TG8wNjLXDNT
 OfyCk2RWX0l4K/TbqpDGLPn6qJmBqnRFcl0QBiNYRkjSS8/luzvxOJOJ09bf9YNDfnnpEN
 kvWzN7hbHo3XS9YFnQYjsYRB4jJnETzLlN9uer1irXOS203VRV90vwHlJuoJJw==
To: "Nick Hu" <nick.hu@sifive.com>, <anup@brainfault.org>, 
	"Alexandre Ghiti" <alex@ghiti.fr>, <linux-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26893205a+e8460c+vger.kernel.org+liujingqi@lanxincomputing.com>
In-Reply-To: <20250806082726.8835-2-nick.hu@sifive.com>
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Wed, 06 Aug 2025 17:28:57 +0800
Subject: Re: [PATCH v2 1/2] irqchip/riscv-imsic: Restore the IMSIC registers
Message-Id: <c1d4cc3e-c688-4610-8b15-488cde2836d1@lanxincomputing.com>
Content-Language: en-US
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
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
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Date: Wed, 6 Aug 2025 17:28:55 +0800
References: <20250806082726.8835-1-nick.hu@sifive.com> <20250806082726.8835-2-nick.hu@sifive.com>
Content-Type: text/plain; charset=UTF-8

On 8/6/2025 4:27 PM, Nick Hu wrote:
> When the system woken up from the low power state, the IMSIC might be in
> the reset state. Therefore adding the CPU PM callbacks to restore the
> IMSIC register when the cpu resume from the low power state.
>
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> Reviewed-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Cyan Yang <cyan.yang@sifive.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>   drivers/irqchip/irq-riscv-imsic-early.c | 40 ++++++++++++++++++++-----
>   1 file changed, 32 insertions(+), 8 deletions(-)
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>

Thanks,
Nutty
> diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
> index d9ae87808651..62bcbcae8bd4 100644
> --- a/drivers/irqchip/irq-riscv-imsic-early.c
> +++ b/drivers/irqchip/irq-riscv-imsic-early.c
> @@ -7,6 +7,7 @@
>   #define pr_fmt(fmt) "riscv-imsic: " fmt
>   #include <linux/acpi.h>
>   #include <linux/cpu.h>
> +#include <linux/cpu_pm.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
>   #include <linux/irq.h>
> @@ -109,14 +110,8 @@ static void imsic_handle_irq(struct irq_desc *desc)
>   	chained_irq_exit(chip, desc);
>   }
>   
> -static int imsic_starting_cpu(unsigned int cpu)
> +static void imsic_restore(void)
>   {
> -	/* Mark per-CPU IMSIC state as online */
> -	imsic_state_online();
> -
> -	/* Enable per-CPU parent interrupt */
> -	enable_percpu_irq(imsic_parent_irq, irq_get_trigger_type(imsic_parent_irq));
> -
>   	/* Setup IPIs */
>   	imsic_ipi_starting_cpu();
>   
> @@ -128,6 +123,19 @@ static int imsic_starting_cpu(unsigned int cpu)
>   
>   	/* Enable local interrupt delivery */
>   	imsic_local_delivery(true);
> +}
> +
> +static int imsic_starting_cpu(unsigned int cpu)
> +{
> +	/* Mark per-CPU IMSIC state as online */
> +	imsic_state_online();
> +
> +	/* Enable per-CPU parent interrupt */
> +	enable_percpu_irq(imsic_parent_irq,
> +			  irq_get_trigger_type(imsic_parent_irq));
> +
> +	/* Restore the imsic reg */
> +	imsic_restore();
>   
>   	return 0;
>   }
> @@ -143,6 +151,22 @@ static int imsic_dying_cpu(unsigned int cpu)
>   	return 0;
>   }
>   
> +static int imsic_pm_notifier(struct notifier_block *self, unsigned long cmd, void *v)
> +{
> +	switch (cmd) {
> +	case CPU_PM_EXIT:
> +		/* Restore the imsic reg */
> +		imsic_restore();
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block imsic_pm_notifier_block = {
> +	.notifier_call = imsic_pm_notifier,
> +};
> +
>   static int __init imsic_early_probe(struct fwnode_handle *fwnode)
>   {
>   	struct irq_domain *domain;
> @@ -180,7 +204,7 @@ static int __init imsic_early_probe(struct fwnode_handle *fwnode)
>   	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_IMSIC_STARTING, "irqchip/riscv/imsic:starting",
>   			  imsic_starting_cpu, imsic_dying_cpu);
>   
> -	return 0;
> +	return cpu_pm_register_notifier(&imsic_pm_notifier_block);
>   }
>   
>   static int __init imsic_early_dt_init(struct device_node *node, struct device_node *parent)

