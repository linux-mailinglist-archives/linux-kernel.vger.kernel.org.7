Return-Path: <linux-kernel+bounces-749173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5143B14AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68287542DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D30C287244;
	Tue, 29 Jul 2025 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="16dUWIn0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fmLx/C+Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E5233158
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780498; cv=none; b=Aow6uHwDgAgwvvUs4NngwymI8/Z1bHQoSP1hNlbN5W+l7g+2Nylv0S3yCnTNQf8rEqSWuAjC5/0Nhq24QUQuKiGRelh8FyTFjFHxnCmM/Wk9l61LvHneAEFioMHbaebapPRgkZQFm6Cj0LmEJBJD9DXj8+Hd9IKuB+9qQJtobGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780498; c=relaxed/simple;
	bh=5BcNcSVV5b07LpMS5GGy2SVNJ6gHy2wvVc5fjFa18LU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=loTD7D8HvCpxeIFBs+SLwCFpZrMM00Sadro3k07hFXxmLXs1A1NZ7muCuCzho7L837Sm0VK1DatZMiCUaVJmPKNLlR13LStv+j+5HvKP5N6j8BheqNKv5bxbuWVbjEjl5k8frtyvH/ec/STOtHHIdDCCMms/n2PfTpG/Q8EXVmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=16dUWIn0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fmLx/C+Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753780494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=trM5M5tOoOKl3e5FmQaiUAiXWpFZdWg29BBzIEOGG8g=;
	b=16dUWIn0nyi7DXUU5MwGT8H41rW25+N+ktw1AjN7Zai/FXaHMPw1I4RYzS3QpSRm1PZ5Ry
	0qYJUxo6xpu7QWR1y82mY7uo1OxLBqHg0a9JurVwzZg4q4kXzDasdmxIVS8oF5zHj6YpV/
	jKVDqnM5WhIDFPjJWlmybr7uwMsmxTw2lI4v1VPQqAaN7IzDuX/HaCrrzWlQmsxBtjsvud
	5+w+Ldcvx5MTPhXIV/j6Rt5Vm6oqvHSHJgcCP0xVGa1cw0wKF+vVChOC46KVNpBavt39Q8
	g5uMwQxKXLQ71FMsGWxTPnrJSoqeUOxGbjTZ2LbLeX/haJ8dqa3p3AgYOTvZcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753780494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=trM5M5tOoOKl3e5FmQaiUAiXWpFZdWg29BBzIEOGG8g=;
	b=fmLx/C+ZDf63kiJmp8gevlwAbu1EtTzJPXVWDCili3SoTv2HHZN9tdlLZH1J4ggJGxK9us
	lLXZWkPwW51zkvBw==
To: Pan Chuang <panchuang@vivo.com>, linux-kernel@vger.kernel.org
Cc: miquel.raynal@bootlin.com, Jonathan.Cameron@Huawei.com,
 u.kleine-koenig@pengutronix.de, angeg.delregno@collabora.com,
 krzk@kernel.org, a.fatoum@pengutronix.de, frank.li@vivo.com, Pan Chuang
 <panchuang@vivo.com>
Subject: Re: [PATCH v8 1/1] genirq/devres: Add dev_err_probe() in
 devm_request_threaded_irq() and devm_request_any_context_irq()
In-Reply-To: <20250729081434.497716-2-panchuang@vivo.com>
References: <20250729081434.497716-1-panchuang@vivo.com>
 <20250729081434.497716-2-panchuang@vivo.com>
Date: Tue, 29 Jul 2025 11:14:54 +0200
Message-ID: <87qzxzjr3l.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 29 2025 at 16:14, Pan Chuang wrote:

> The devm_request_threaded_irq() and devm_request_any_context_irq() functions

devm_request_threaded_irq() and devm_request_any_context_irq() ....

The '()' notation already makes it clear that these are functions, so no
'The ... functions' is redundant.

> currently don't print any error when interrupt registration fails. This forces
> each driver to implement redundant error logging - over 2,000 lines of error
> messages exist across drivers. Additionally, when upper-layer functions
> propagate these errors without logging, critical debugging information is lost.
>
> Add automatic error logging to these functions via dev_err_probe(), printing
> device name, IRQ number, handler addresses, and error code on failure.

Again: %pS (or %ps) does NOT print the handler address. It prints the
symbol name. Feel free to ignore my review comments, but then accept
that I ignore your patches too.

> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

This SOB chain is still incorrect. Again:

 https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

If anything is unclear, then please ask.

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

As you touch this, can you please convert this to the proper

   Returns:

formatting?

Thanks,

        tglx

