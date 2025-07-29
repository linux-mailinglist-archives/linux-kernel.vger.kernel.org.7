Return-Path: <linux-kernel+bounces-749093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C8EB149FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA132188EDB9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7308C27BF85;
	Tue, 29 Jul 2025 08:20:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AED2AF1C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777241; cv=none; b=P/M45L4FEwqAqHCFK9/7Cj2pIaj8vjtXYn4yGxrG9Wk7z6FmKFUC7ZjiGybtgMEyWuVMJTwvj+MvUJU7Ur3NCgdNwyFAsck2rHt/J1TKNz//PytnvIhnG2Fb6TSrud4GoD8y3qE8wv74b3Rv6AWJ7Z73nHEztNpg6Oug+gvJS5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777241; c=relaxed/simple;
	bh=vsVLrvuPX8YMs03wPOJthPSOWct7ZHQUgKsDcPsHr20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMd7fphT0ormIDZrQ1otxuJYXMP0EYMt0HEW5KGw93YDPjU/qtljHOnc4LxdQeC09bcOLyTUOoX9Xt9yqYQLm2+oS7nQWeVaKsPCA/tYZHqlQVgAoARTDDAKbJ6e1mwTQeKufVCWdf2FNmHp6RWH9K1gvHTa1dMJo0DBq+qvlRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1ugfZZ-0000cu-75; Tue, 29 Jul 2025 10:20:33 +0200
Message-ID: <73a4fc1d-6852-4050-85c0-8c29b4165e4d@pengutronix.de>
Date: Tue, 29 Jul 2025 10:20:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/1] genirq/devres: Add dev_err_probe() in
 devm_request_threaded_irq() and devm_request_any_context_irq()
To: Pan Chuang <panchuang@vivo.com>, tglx@linutronix.de,
 linux-kernel@vger.kernel.org
Cc: miquel.raynal@bootlin.com, Jonathan.Cameron@Huawei.com,
 angeg.delregno@collabora.com, krzk@kernel.org, frank.li@vivo.com
References: <20250729081434.497716-1-panchuang@vivo.com>
 <20250729081434.497716-2-panchuang@vivo.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20250729081434.497716-2-panchuang@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Pan,

On 29.07.25 10:14, Pan Chuang wrote:
> -int devm_request_any_context_irq(struct device *dev, unsigned int irq,
> -			      irq_handler_t handler, unsigned long irqflags,
> -			      const char *devname, void *dev_id)
> +int devm_request_threaded_irq(struct device *dev, unsigned int irq,
> +			      irq_handler_t handler, irq_handler_t thread_fn,
> +			      unsigned long irqflags, const char *devname,
> +			      void *dev_id)
> +{
> +	int rc = __devm_request_threaded_irq(dev, irq, handler, thread_fn,
> +					     irqflags, devname, dev_id);
> +	if (!rc)
> +		return 0;
> +
> +	return dev_err_probe(dev, rc, "request_irq(%u) %pS %pS %s\n",

Compared to %ps, %pS also prints offset and size relative to the symbol.
This makes sense when you have an arbitrary program counter, but for
merely printing a function symbol, I'd suggest %ps as it's less noisy.

Cheers,
Ahmad

> +			     irq, handler, thread_fn, devname ? : "");
> +}
> +EXPORT_SYMBOL(devm_request_threaded_irq);
> +
> +static int __devm_request_any_context_irq(struct device *dev, unsigned int irq,
> +					  irq_handler_t handler,
> +					  unsigned long irqflags,
> +					  const char *devname, void *dev_id)
>  {
>  	struct irq_devres *dr;
>  	int rc;
> @@ -124,6 +128,43 @@ int devm_request_any_context_irq(struct device *dev, unsigned int irq,
>  
>  	return rc;
>  }
> +
> +/**
> + * devm_request_any_context_irq - allocate an interrupt line for a managed device with error logging
> + * @dev:	Device to request interrupt for
> + * @irq:	Interrupt line to allocate
> + * @handler:	Function to be called when the IRQ occurs
> + * @irqflags:	Interrupt type flags
> + * @devname:	An ascii name for the claiming device, dev_name(dev) if NULL
> + * @dev_id:	A cookie passed back to the handler function
> + *
> + * Except for the extra @dev argument, this function takes the same arguments
> + * and performs the same function as request_any_context_irq().  IRQs requested
> + * with this function will be automatically freed on driver detach.
> + *
> + * If an IRQ allocated with this function needs to be freed separately,
> + * devm_free_irq() must be used.
> + *
> + * When the request fails, an error message is printed with contextual
> + * information (device name, interrupt number, handler functions and
> + * error code). Don't add extra error messages at the call sites.
> + *
> + * On failure, it returns a negative value. On success, it returns either
> + * IRQC_IS_HARDIRQ or IRQC_IS_NESTED.
> + */
> +int devm_request_any_context_irq(struct device *dev, unsigned int irq,
> +				 irq_handler_t handler, unsigned long irqflags,
> +				 const char *devname, void *dev_id)
> +{
> +	int rc = __devm_request_any_context_irq(dev, irq, handler, irqflags,
> +						devname, dev_id);
> +	if (rc < 0) {
> +		return dev_err_probe(dev, rc, "request_irq(%u) %pS %s\n",
> +				     irq, handler, devname ? : "");
> +	}
> +
> +	return rc;
> +}
>  EXPORT_SYMBOL(devm_request_any_context_irq);
>  
>  /**


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

