Return-Path: <linux-kernel+bounces-779078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3A2B2EEBE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA8BD4E3476
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F06A2E8B70;
	Thu, 21 Aug 2025 06:53:10 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0588A2E093A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759190; cv=none; b=QVXOSpvv9Z6iWisasINpjXHt1HOEahQFanOnH6iCyutS4EqR1CCyR5q7tkKRJ5ruieTI5qo+uXFSrJqeLBOMVo7My1Yize0PDRaBdQ6aHimNhTSi9N4twym1FNCIziw0OnSTv9RMU1+4kueiG+hINNd/8tdhCx4L4cAx09xKceU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759190; c=relaxed/simple;
	bh=RmmERoEA013CqYqHZ/gUF7ZZnNFcE/eoBYkAwXxdRCo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tZtbXhwbON0wkrf0d34FpBjt2maTGsiTxdhm6NWlHs7bN1gCt2WWOj4cIzm7/ehRk27THmQFEWM2EdQasWjVku1M4KJOocutwObq5azJxe7ua9pZWx3+L9WaA1qafC2BamIFLE18ZAtV/UX0LNr53dTZwPXrF6U+IvTkn112LAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c6v8K6Wbdz2gLPM;
	Thu, 21 Aug 2025 14:50:09 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id 6859A1400DA;
	Thu, 21 Aug 2025 14:53:03 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 14:53:02 +0800
Subject: Re: [PATCH] irqchip/gic-v5: Fix kmemleak L2 IST table entries false
 positives
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>
References: <20250811135001.1333684-1-lpieralisi@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <82bac373-21d6-7aab-0b3d-509b5bce25db@huawei.com>
Date: Thu, 21 Aug 2025 14:53:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250811135001.1333684-1-lpieralisi@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk200017.china.huawei.com (7.202.194.83)

On 2025/8/11 21:50, Lorenzo Pieralisi wrote:
> L2 IST table entries are allocated with the kmalloc interface
> and their physical addresses are programmed in the GIC (either
> IST base address register or L1 IST table entries) but their
> virtual addresses are not stored in any kernel data structure
> because they are not needed at runtime - the L2 IST table entries
> are managed through system instructions but never dereferenced
> directly by the driver.
> 
> This triggers kmemleak false positive reports:
> 
> unreferenced object 0xffff00080039a000 (size 4096):
>   comm "swapper/0", pid 0, jiffies 4294892296
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 0):
>     kmemleak_alloc+0x34/0x40
>     __kmalloc_noprof+0x320/0x464
>     gicv5_irs_iste_alloc+0x1a4/0x484
>     gicv5_irq_lpi_domain_alloc+0xe4/0x194
>     irq_domain_alloc_irqs_parent+0x78/0xd8
>     gicv5_irq_ipi_domain_alloc+0x180/0x238
>     irq_domain_alloc_irqs_locked+0x238/0x7d4
>     __irq_domain_alloc_irqs+0x88/0x114
>     gicv5_of_init+0x284/0x37c
>     of_irq_init+0x3b8/0xb18
>     irqchip_init+0x18/0x40
>     init_IRQ+0x104/0x164
>     start_kernel+0x1a4/0x3d4
>     __primary_switched+0x8c/0x94
> 
> Instruct kmemleak to ignore L2 IST table memory allocation
> virtual addresses to prevent these false positive reports.
> 
> Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Closes: https://lore.kernel.org/lkml/cc611dda-d1e4-4793-9bb2-0eaa47277584@huawei.com/
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v5-irs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
> index ad1435a858a4..e8a576f66366 100644
> --- a/drivers/irqchip/irq-gic-v5-irs.c
> +++ b/drivers/irqchip/irq-gic-v5-irs.c
> @@ -5,6 +5,7 @@
>  
>  #define pr_fmt(fmt)	"GICv5 IRS: " fmt
>  
> +#include <linux/kmemleak.h>
>  #include <linux/log2.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> @@ -117,6 +118,7 @@ static int __init gicv5_irs_init_ist_linear(struct gicv5_irs_chip_data *irs_data
>  		kfree(ist);
>  		return ret;
>  	}
> +	kmemleak_ignore(ist);
>  
>  	return 0;
>  }
> @@ -232,6 +234,7 @@ int gicv5_irs_iste_alloc(const u32 lpi)
>  		kfree(l2ist);
>  		return ret;
>  	}
> +	kmemleak_ignore(l2ist);

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

Thanks,
Zenghui

