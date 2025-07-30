Return-Path: <linux-kernel+bounces-751080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7766B16510
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B75E1612D6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA012DEA94;
	Wed, 30 Jul 2025 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tfdqIV2m"
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C4A24B26;
	Wed, 30 Jul 2025 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894694; cv=none; b=lafOvJmyxGWt2eZtYjTn9lkWUQk6xdRTO7vHA6W2V5tYdL03l2Y+pPcAAAbFmp/UbHZp7uZg1oFh1EidFaYBI7+xe5zY5mmIK+lbAxyMy45ZTIDMeJkrMXxhQCYXsC+IfOlUnjq51F83vJ+bUWt0SaOrBK4LJsv9+o2Gxs9N2T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894694; c=relaxed/simple;
	bh=fHy9OEIth1PK5cjk9/LOwBDtsV+T1Zc9NOQ/tUqxioE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjzC8bHTkhsF85/jsGmxP1Y1MZeao5dRp1dtxjHVvu+5/MzJXWLYVaiw++tDQ+FhP8qHds1v7L4uE8ymhnEUGB4CSV+KnmkKy1IsLmS6klw0cxWD6l2gW+HTbcOxQcaDhXUzWDMW5LBqB5P0diS6f/g8eS6lefGnv7WBmOebySY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=tfdqIV2m; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id h9yqu8H9OsqJSh9yruJXg8; Wed, 30 Jul 2025 18:48:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753894127;
	bh=C/d6klvErSL9N0UVrQJpgwYug7KZBqrLEBQ59UmO/zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=tfdqIV2m0/ONTSA5x8mdAmKVIAG0UdS2fknUBtcvsWH453Rx3Gru9R2JdxwchOXRY
	 x2x9tZFFwKM1gAmzHo4Kv8zVADo87BKx2xHPV2aD0nCb1CXjov6HdDrcBULHHgJJqQ
	 mn4ZK5dvmxSrv6r5Iy/ILha/ngVgNXZ8HKxAT6d/ECaCktsfrqVtUU90I4/1a2QsaB
	 0hIFlzIMQJNevI6oREiRB430Hpe8z+XD8xtC1IFw9yeMjnK+KB8bDXjMn94Wm2AtzG
	 eT/U6TBdUCF3CGWI2gI0FQsJXRYLhcU3Ebf6ebGZCae9hZcrmDcT31OAL2neMTuVfu
	 tz+kehFtnQ7vQ==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 30 Jul 2025 18:48:47 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <2afd89be-713e-4075-b91b-36ec7fb6072d@wanadoo.fr>
Date: Wed, 30 Jul 2025 18:48:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/1] genirq/devres: Add dev_err_probe() in
 devm_request_threaded_irq() and devm_request_any_context_irq()
To: Pan Chuang <panchuang@vivo.com>, tglx@linutronix.de
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 miquel.raynal@bootlin.com, Jonathan.Cameron@Huawei.com,
 u.kleine-koenig@pengutronix.de, angeg.delregno@collabora.com,
 krzk@kernel.org, a.fatoum@pengutronix.de, frank.li@vivo.com
References: <20250730062554.269151-1-panchuang@vivo.com>
 <20250730062554.269151-2-panchuang@vivo.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20250730062554.269151-2-panchuang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 30/07/2025 à 08:25, Pan Chuang a écrit :
> The devm_request_threaded_irq() and devm_request_any_context_irq() currently
> don't print any error when interrupt registration fails. This forces each
> driver to implement redundant error logging - over 2,000 lines of error
> messages exist across drivers. Additionally, when upper-layer functions
> propagate these errors without logging, critical debugging information is lost.
> 
> Add automatic error logging to these functions via dev_err_probe(), printing
> device name, IRQ number, handler functions, and error code on failure.
> 
> Co-developed-by: Yangtao Li <frank.li@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>   kernel/irq/devres.c | 121 +++++++++++++++++++++++++++++---------------
>   1 file changed, 81 insertions(+), 40 deletions(-)
> 
> diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
> index eb16a58e0322..dcbb9d0cd736 100644
> --- a/kernel/irq/devres.c
> +++ b/kernel/irq/devres.c
> @@ -30,29 +30,11 @@ static int devm_irq_match(struct device *dev, void *res, void *data)
>   	return this->irq == match->irq && this->dev_id == match->dev_id;
>   }
>   
> -/**
> - *	devm_request_threaded_irq - allocate an interrupt line for a managed device
> - *	@dev: device to request interrupt for
> - *	@irq: Interrupt line to allocate
> - *	@handler: Function to be called when the IRQ occurs
> - *	@thread_fn: function to be called in a threaded interrupt context. NULL
> - *		    for devices which handle everything in @handler
> - *	@irqflags: Interrupt type flags
> - *	@devname: An ascii name for the claiming device, dev_name(dev) if NULL
> - *	@dev_id: A cookie passed back to the handler function
> - *
> - *	Except for the extra @dev argument, this function takes the
> - *	same arguments and performs the same function as
> - *	request_threaded_irq().  IRQs requested with this function will be
> - *	automatically freed on driver detach.
> - *
> - *	If an IRQ allocated with this function needs to be freed
> - *	separately, devm_free_irq() must be used.
> - */
> -int devm_request_threaded_irq(struct device *dev, unsigned int irq,
> -			      irq_handler_t handler, irq_handler_t thread_fn,
> -			      unsigned long irqflags, const char *devname,
> -			      void *dev_id)
> +static int __devm_request_threaded_irq(struct device *dev, unsigned int irq,
> +				       irq_handler_t handler,
> +				       irq_handler_t thread_fn,
> +				       unsigned long irqflags,
> +				       const char *devname, void *dev_id)
>   {
>   	struct irq_devres *dr;
>   	int rc;
> @@ -78,28 +60,50 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL(devm_request_threaded_irq);
>   
>   /**
> - *	devm_request_any_context_irq - allocate an interrupt line for a managed device
> - *	@dev: device to request interrupt for
> - *	@irq: Interrupt line to allocate
> - *	@handler: Function to be called when the IRQ occurs
> - *	@irqflags: Interrupt type flags
> - *	@devname: An ascii name for the claiming device, dev_name(dev) if NULL
> - *	@dev_id: A cookie passed back to the handler function
> + * devm_request_threaded_irq - allocate an interrupt line for a managed device with error logging
> + * @dev:	Device to request interrupt for
> + * @irq:	Interrupt line to allocate
> + * @handler:	Function to be called when the IRQ occurs
> + * @thread_fn:	Function to be called in a threaded interrupt context. NULL
> + *		for devices which handle everything in @handler
> + * @irqflags:	Interrupt type flags
> + * @devname:	An ascii name for the claiming device, dev_name(dev) if NULL
> + * @dev_id:	A cookie passed back to the handler function
>    *
> - *	Except for the extra @dev argument, this function takes the
> - *	same arguments and performs the same function as
> - *	request_any_context_irq().  IRQs requested with this function will be
> - *	automatically freed on driver detach.
> + * Except for the extra @dev argument, this function takes the same arguments
> + * and performs the same function as request_threaded_irq().  IRQs requested
> + * with this function will be automatically freed on driver detach.
> + *
> + * If an IRQ allocated with this function needs to be freed separately,
> + * devm_free_irq() must be used.
> + *
> + * When the request fails, an error message is printed with contextual
> + * information (device name, interrupt number, handler functions and
> + * error code). Don't add extra error messages at the call sites.
>    *
> - *	If an IRQ allocated with this function needs to be freed
> - *	separately, devm_free_irq() must be used.
> + * Return: 0 on success or a negative error number.
>    */
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
> +	return dev_err_probe(dev, rc, "request_irq(%u) %ps %ps %s\n",
> +			     irq, handler, thread_fn, devname ? : "");
> +}
> +EXPORT_SYMBOL(devm_request_threaded_irq);
> +
> +static int __devm_request_any_context_irq(struct device *dev, unsigned int irq,
> +					  irq_handler_t handler,
> +					  unsigned long irqflags,
> +					  const char *devname, void *dev_id)
>   {
>   	struct irq_devres *dr;
>   	int rc;
> @@ -124,6 +128,43 @@ int devm_request_any_context_irq(struct device *dev, unsigned int irq,
>   
>   	return rc;
>   }
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
> + * Return: IRQC_IS_HARDIRQ or IRQC_IS_NESTED on success, or a negative error
> + * number.
> + */
> +int devm_request_any_context_irq(struct device *dev, unsigned int irq,
> +				 irq_handler_t handler, unsigned long irqflags,
> +				 const char *devname, void *dev_id)
> +{
> +	int rc = __devm_request_any_context_irq(dev, irq, handler, irqflags,
> +						devname, dev_id);
> +	if (rc < 0) {
> +		return dev_err_probe(dev, rc, "request_irq(%u) %ps %s\n",
> +				     irq, handler, devname ? : "");
> +	}

Extra { } should be removed.

 From my PoV, it would look more logical to have the same logic in 
devm_request_threaded_irq() and in devm_request_any_context_irq().

Why "if (!rc) SUCCESS" in one case, and "if (rc < 0) FAILURE" in the 
other case?

Personally, I would change in devm_request_threaded_irq() above to have
	if (rc)
		return dev_err_probe();
	return 0;

> +
> +	return rc;
> +}
>   EXPORT_SYMBOL(devm_request_any_context_irq);

On version 5 of the patch, there was a comment related to using 
EXPORT_SYMBOL_GPL(), does it still make sense?
(no strong opinion from me, just noted that and wondered if done on purpose)

CJ

>   
>   /**


