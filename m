Return-Path: <linux-kernel+bounces-748213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3256FB13DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7628F17E4CC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB0E26D4E9;
	Mon, 28 Jul 2025 15:10:59 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E48D22B8C2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715458; cv=none; b=YczSunCFKo1wYHNExze5/v6u7UzBTgZ/kUdbpFthwPNve25++b0LYq4smJRDtJ29F3mdJItG0RZvMEChmHSKUVK+Egy6KA3MZYEkbpU/oZqakA4SNYz2HMqhYmI2uU1pDGBywUUPcZglk1IO9Y1RGVrPKDXuPKch5kSJvBO5CLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715458; c=relaxed/simple;
	bh=Urnls7LTsgyCqhDUiCZtRYKkQj1nlVu3vG4zU+q9BNE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRzvMLavz9kW8TT1Nq2npgW014pUvC/wgZYA/h0fARL7TCXuX5/HRrSi0ccAuukqF9jM6f5eWvw4H4YLjsWCV7MJZVLtO7+gG76H/ZgKfS8kteD0L17NUOfdNPFCFGYUtiFXlbB9ZlyQYdR7u8y0Im2n1ILh4y1AVu5EN3f4j7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4brMMM1GGDz6H7NX;
	Mon, 28 Jul 2025 23:09:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5517B140446;
	Mon, 28 Jul 2025 23:10:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 28 Jul
 2025 17:10:51 +0200
Date: Mon, 28 Jul 2025 16:10:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Pan Chuang <panchuang@vivo.com>
CC: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<miquel.raynal@bootlin.com>, <u.kleine-koenig@pengutronix.de>,
	<angeg.delregno@collabora.com>, <krzk@kernel.org>, <a.fatoum@pengutronix.de>,
	<frank.li@vivo.com>
Subject: Re: [PATCH v7 1/1] genirq/devres: Add dev_err_probe() in
 devm_request_threaded_irq() and devm_request_any_context_irq()
Message-ID: <20250728161050.000018f2@huawei.com>
In-Reply-To: <20250728123251.384375-2-panchuang@vivo.com>
References: <20250728123251.384375-1-panchuang@vivo.com>
	<20250728123251.384375-2-panchuang@vivo.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Jul 2025 20:32:51 +0800
Pan Chuang <panchuang@vivo.com> wrote:

> Modify devm_request_thread_irq() and devm_request_any_context_irq(), in
> order to print an error message by default when the request fails.
> 
> Converting drivers to use this API has the following benefits:
> 
>   1.More than 2,000 lines of code can be saved by removing redundant error
>   messages in drivers.
> 
>   2.Upper-layer functions can directly return error codes without missing
>   debugging information.
> 
>   3.Having proper and consistent information about why the device cannot
>   be used is useful.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  kernel/irq/devres.c | 78 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 74 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
> index eb16a58e0322..a1b934c1ecc8 100644
> --- a/kernel/irq/devres.c
> +++ b/kernel/irq/devres.c
> @@ -31,7 +31,7 @@ static int devm_irq_match(struct device *dev, void *res, void *data)
>  }
>  
>  /**
> - *	devm_request_threaded_irq - allocate an interrupt line for a managed device
> + *	__devm_request_threaded_irq - allocate an interrupt line for a managed device
>   *	@dev: device to request interrupt for
>   *	@irq: Interrupt line to allocate
>   *	@handler: Function to be called when the IRQ occurs
> @@ -49,7 +49,7 @@ static int devm_irq_match(struct device *dev, void *res, void *data)
>   *	If an IRQ allocated with this function needs to be freed
>   *	separately, devm_free_irq() must be used.
>   */
> -int devm_request_threaded_irq(struct device *dev, unsigned int irq,
> +static int __devm_request_threaded_irq(struct device *dev, unsigned int irq,
>  			      irq_handler_t handler, irq_handler_t thread_fn,

Parameters were previously aligned after (
Probably best to realign them to keep that style.

>  			      unsigned long irqflags, const char *devname,
>  			      void *dev_id)
> @@ -78,10 +78,46 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
>  
>  	return 0;
>  }
> +
> +/**
> + * devm_request_threaded_irq - allocate an interrupt line for a managed device with error logging
> + * @dev:	Device to request interrupt for
> + * @irq:	Interrupt line to allocate
> + * @handler:	Function to be called when the IRQ occurs
> + * @thread_fn:	Function to be called in a threaded interrupt context. NULL
> + *		for devices which handle everything in @handler
> + * @irqflags:	Interrupt type flags
> + * @devname:	An ascii name for the claiming device, dev_name(dev) if NULL
> + * @dev_id:	A cookie passed back to the handler function
> + *
> + * This function extends __devm_request_threaded_irq by adding detailed error
> + * logging via dev_err_probe() when the underlying request fails. It ensures the
> + * interrupt is automatically freed on driver detach and provides contextual
> + * information (e.g., IRQ number, handler address, device name) in error messages.
> + *
> + * Return: 0 on success or a negative error number.
> + */
> +int devm_request_threaded_irq(struct device *dev, unsigned int irq,
> +			      irq_handler_t handler, irq_handler_t thread_fn,
> +			      unsigned long irqflags, const char *devname,
> +			      void *dev_id)
> +{
> +	int rc;
> +
> +	rc = __devm_request_threaded_irq(dev, irq, handler, thread_fn, irqflags,
> +					 devname, dev_id);
> +	if (rc < 0) {

I'm in two minds about this.
The internals of __devm_request_threaded_irq() use if (rc)
so we know that will be fine here.

However, given you are passing it to dev_err_probe() locally being sure
that we don't have a value > 0 perhaps makes sense.

> +		return dev_err_probe(dev, rc, "request_irq(%u) %pS %pS %s\n",
> +				     irq, handler, thread_fn,
> +				     devname ? : dev_name(dev));
> +	}
> +
> +	return 0;
> +}
>  EXPORT_SYMBOL(devm_request_threaded_irq);

Same comments apply to remaining code.

Jonathan


