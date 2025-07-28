Return-Path: <linux-kernel+bounces-748243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAEDB13E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37DC4E1364
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D984273D6A;
	Mon, 28 Jul 2025 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rFUL1cy/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rtxhh/t3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2D4273D65
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716394; cv=none; b=ncK2XxGiTR+Z8OEcHgE4k/E/gbxcTcUNePpjmC573mpGenldrt0BrxdwoHewIZ8mF6K/N/cslrEcmQmgY4jJ+4kyFrbgoVP1Yf4h8onbESpelcv9U8Pnzh+fp5V5oa9j/NvkCBM7JaNW+tXDBHgt6sIrLaSyvIn3dhyTFZl+YFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716394; c=relaxed/simple;
	bh=54azFvqPpuZrk/n8tj9escUe2C8QrEDT51LPlv/Vbys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f606a7aQcPDFCwa+9bJrF7GDXpKcYgUxPT6JnOMNfyl8X8h7VWPu4wqGG2ohyiiMMoB40h50m1TtxFDcvSd2bOF5hQr860YVGQ5hLXlJci2U6coTiTK/bteumU/mXd4MH5e1hoWGH8HH6UdbSRpK5SN0cK1UuaD6vGGIOu/6e7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rFUL1cy/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rtxhh/t3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753716390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9+iLgcw/8wMuaoLNc0I5+UMEMvRQq/M+sDDCWRbJXZU=;
	b=rFUL1cy/Z+MLjS/1+uxbUUy5O5kzih6M3dmeg5/490KdRRGqVEcazhkAqOmoe3CGw61wZM
	y6DihvqFX11+Nsh4fwlXWAin1Bu1l5nAbcCQzD3CLAvfW0/GC9QtSY8mgWzwsJFeCyoz/S
	Usi4MRrRGWbJpSbmO+GE6Of2e/DlM56oEBfN8SU47BhS6pbMw2KL6X0W47E0vUvngLs4mz
	eJQZRccaWLrhxjfJrVBFUgMNu+4piZiovknmaIO9+B52aHBTuoEaMoHg5BC+P7S16V7rsE
	nbsPnt8jtJs0/S2TWjLWQ2wqvz55EuiJk6HGKktNi+H65RyRWGS2iAxQklqoxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753716390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9+iLgcw/8wMuaoLNc0I5+UMEMvRQq/M+sDDCWRbJXZU=;
	b=rtxhh/t3noNDvOVCZlAtUAA0XIBP3lZ9IQHVE38xapUu5qxeD3Xl3vdMdKG1LGWXcdhqac
	3ecmFz7O0eF8E6BQ==
To: Pan Chuang <panchuang@vivo.com>, linux-kernel@vger.kernel.org
Cc: miquel.raynal@bootlin.com, Jonathan.Cameron@Huawei.com,
 u.kleine-koenig@pengutronix.de, angeg.delregno@collabora.com,
 krzk@kernel.org, a.fatoum@pengutronix.de, frank.li@vivo.com, Pan Chuang
 <panchuang@vivo.com>
Subject: Re: [PATCH v7 1/1] genirq/devres: Add dev_err_probe() in
 devm_request_threaded_irq() and devm_request_any_context_irq()
In-Reply-To: <20250728123251.384375-2-panchuang@vivo.com>
References: <20250728123251.384375-1-panchuang@vivo.com>
 <20250728123251.384375-2-panchuang@vivo.com>
Date: Mon, 28 Jul 2025 17:26:30 +0200
Message-ID: <875xfcpc9l.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 28 2025 at 20:32, Pan Chuang wrote:
> Modify devm_request_thread_irq() and devm_request_any_context_irq(), in
> order to print an error message by default when the request fails.

> Converting drivers to use this API has the following benefits:

No driver is converted. They all use the API already, no?

>   1.More than 2,000 lines of code can be saved by removing redundant error
>   messages in drivers.
>
>   2.Upper-layer functions can directly return error codes without missing
>   debugging information.
>
>   3.Having proper and consistent information about why the device cannot
>   be used is useful.

Please read

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

and do not start with _WHAT_ the patch does. Decribe the context and the
problem you are trying to solve and then briefly the solution.

> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

This Signed-off-by chain is broken.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

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

This kernel doc is a pointless duplicate. Just leave it above the API
function. This is an internal function, which is split out to make the
error path simpler.

> -int devm_request_threaded_irq(struct device *dev, unsigned int irq,
> +static int __devm_request_threaded_irq(struct device *dev, unsigned int irq,
>  			      irq_handler_t handler, irq_handler_t thread_fn,
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

Nice reformatting!

> + *
> + * This function extends __devm_request_threaded_irq by adding detailed error

This is irrelevant for the user and you take the real important
information away from the user and hide it in the pointless documenation
of the internal function.

> + * logging via dev_err_probe() when the underlying request fails. It ensures the
> + * interrupt is automatically freed on driver detach and provides contextual
> + * information (e.g., IRQ number, handler address, device name) in error messages.

Just add something like this to the original documentation:

 * When the request fails, an error message is printed with contextual
 * information (device name, interrupt number, handler functions and
 * error code). Don't add extra error messages at the call sites.

I used 'handler functions' because 'handler address' is not what %pS
prints.

> + * Return: 0 on success or a negative error number.

Nice addition!

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

Just move this up to the declaration

	int rc = __devm_request_threaded_irq(dev, irq, handler, thread_fn,
					     irqflags, devname, dev_id);

> +	if (rc < 0) {
> +		return dev_err_probe(dev, rc, "request_irq(%u) %pS %pS %s\n",
> +				     irq, handler, thread_fn,
> +				     devname ? : dev_name(dev));
> +	}
> +
> +	return 0;

If you reverse the check, then you can spare an indentation level and
brackets.

        if (!rc)
        	return 0;

	return dev_err_probe(dev, rc, "request_irq(%u) %pS %pS %s\n",
			     irq, handler, thread_fn, devname ? : "");
                
There is no point to print dev_name(dev) again in case devname is NULL
as it is already printed by dev_err_probe() at the beginning, no?

Thanks,

        tglx

