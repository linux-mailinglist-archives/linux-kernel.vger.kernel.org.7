Return-Path: <linux-kernel+bounces-779102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FBEB2EF1D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038C63AB190
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EA027B352;
	Thu, 21 Aug 2025 07:11:47 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48F71EA7D2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760306; cv=none; b=FRk0FVyOILlALhPAuOUDGTm4rmXAL2mvMBwkLrGcE/G2D83mr56SioOWotbCwKHeGiikqDIipAJcowzpNVeVnKz7NRlcGL2a584qaqXCKNMEJrEd+BtDq37TegvzG4UNXRVWK4wDeA4TdAlr6E6BgIWgZhaQu9PFF1t13XxWBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760306; c=relaxed/simple;
	bh=58RBQM6omo2HhKg7GdZdZPgexggqYZ+7Ei3/6hWVjfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NyZAH8/VJ+8+2AuFKGoeurjC+96bBV73AxM4XRGIa7ZBeJMZFSi3RGDH+PwIjifHb0lezsBKG2TO4/wbgYw2+xPXttTRRSskJQ/Jm+pBP+pdlM25MDc1f9ptuFQholrFane0Ps9xnrL1zb7qGaFxokOZzS47I5SJ1NBd8jTmOh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c6vX559whz2Cg8n;
	Thu, 21 Aug 2025 15:07:17 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id DE6A41401F2;
	Thu, 21 Aug 2025 15:11:40 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 15:11:40 +0800
Message-ID: <aaf975a9-db4a-5b61-4e07-5d667db47172@huawei.com>
Date: Thu, 21 Aug 2025 15:11:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] irqchip/gic-v5: Fix kmemleak L2 IST table entries false
 positives
Content-Language: en-US
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
References: <20250811135001.1333684-1-lpieralisi@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20250811135001.1333684-1-lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/8/11 21:50, Lorenzo Pieralisi wrote:
> L2 IST table entries are allocated with the kmalloc interface
> and their physical addresses are programmed in the GIC (either
> IST base address register or L1 IST table entries) but their
> virtual addresses are not stored in any kernel data structure
> because they are not needed at runtime - the L2 IST table entries
> are managed through system instructions but never dereferenced
> directly by the driver.
> 

[...]

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

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

>  
>  	/*
>  	 * Make sure we invalidate the cache line pulled before the IRS

