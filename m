Return-Path: <linux-kernel+bounces-757693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 868E0B1C594
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2037F3AEB38
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F5B26E146;
	Wed,  6 Aug 2025 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="afPxRGHA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MXTLAyPL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5112D241686
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754482100; cv=none; b=u48uC33VZr+xOiq4mU4CA0ERdV3hghR/JyYLkDPwk+Qyk+l8lhHjwVzEsF+d6MTm511FN329OAe0Cdf4oWyBFw8CpPB4lhQ5OZqMYZeIh0nSA4s7rQW7EdMrep9IxDz2U7hR8y79aDakzkAN5QrQqvNKY8iCktzt42I8MkoXKuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754482100; c=relaxed/simple;
	bh=nX8cnF21cavGmAToVevK6ofOqz6ek6ad1pzX6iYRwBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wl78ko6pGcxvMxPf3CQEE4E17tjFU4l5je2+zn3nYtVfZDqq3BcZ4WbQvQwb2h55EtiszBGWFa+brfpKqWcWn57q5aJkhPClL7W+r1F/tmOgR+Qa3k9EonruSLsDFkzBAzHOnN2P7ZuQYSabaMYB18u12QJnVF8birsxDUiUywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=afPxRGHA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MXTLAyPL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754482097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nARV5rtz8CjMLkrWEZibNlw4GiyGVYsSYfJk4mKkeI8=;
	b=afPxRGHAR7qQFcaHkIbzx1MAXuMdkQukeMam8nN/tgcCJfM1mDDNt/e5gyKHFQwwIdDrJa
	HswZxyURvZrnZgEEpI7/9KNOJdlHv3lQgFQyQw1nw3xXJAtiFOeX9EVkrz5bP5r0jC/AJc
	I4xvbvEyaAiCM2wUi22l9y1ou+7/l58VUNHKs43tdqs+qUm2ukSSNAEQGrRDQaBTi+TaHd
	ddjFTIyRNCN80i3EBHZhqrzB6AYaGosC/MQlva6zvJg4XO0vR9CQUdPmO+U2Suvy6VrjM5
	fFXD7kWGCei9PWbYH86P0NIPxSARF3ihJPD89caJ0LfHG+ZbTukQxz8C9EdfIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754482097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nARV5rtz8CjMLkrWEZibNlw4GiyGVYsSYfJk4mKkeI8=;
	b=MXTLAyPLMxFpIK1fMcBTqx5v0+pFNi/6wNxA/li4uyxT6du576vBcfv56gP27D0OZnj3MT
	/2XUulBgrE97IlCQ==
To: Nick Hu <nick.hu@sifive.com>, anup@brainfault.org, Alexandre Ghiti
 <alex@ghiti.fr>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Nick Hu <nick.hu@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 1/2] irqchip/riscv-imsic: Restore the IMSIC registers
In-Reply-To: <20250806082726.8835-2-nick.hu@sifive.com>
References: <20250806082726.8835-1-nick.hu@sifive.com>
 <20250806082726.8835-2-nick.hu@sifive.com>
Date: Wed, 06 Aug 2025 14:08:16 +0200
Message-ID: <878qjwejpr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 06 2025 at 16:27, Nick Hu wrote:

"Restore the IMSIC registers" does not tell me anything useful. When are
they restored?

> When the system woken up from the low power state, the IMSIC might be in

is woken up from a low power state

> the reset state.

The real important information is:

   When the system enters a low power state the IMSIC might be reset,
   but on exit nothing restores the registers, which prevents interrupt
   delivery.

Or something like that.

> Therefore adding the CPU PM callbacks to restore the IMSIC register
> when the cpu resume from the low power state.

This is not a valid sentence.

  Solve this by registering a CPU power management notifier, which
  restores the IMSIC on exit.

Or such.

See

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

for further explanation.

> diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
> index d9ae87808651..62bcbcae8bd4 100644
> --- a/drivers/irqchip/irq-riscv-imsic-early.c
> +++ b/drivers/irqchip/irq-riscv-imsic-early.c
> @@ -7,6 +7,7 @@
>  #define pr_fmt(fmt) "riscv-imsic: " fmt
>  #include <linux/acpi.h>
>  #include <linux/cpu.h>
> +#include <linux/cpu_pm.h>
>  #include <linux/interrupt.h>

This does neither apply against Linus tree nor against tip 

> -static int imsic_starting_cpu(unsigned int cpu)
> +static void imsic_restore(void)

This function is used for both setup _and_ restore, so naming it
restore() is misleading at best.

>  {
> -	/* Mark per-CPU IMSIC state as online */
> -	imsic_state_online();
> -
> -	/* Enable per-CPU parent interrupt */
> -	enable_percpu_irq(imsic_parent_irq, irq_get_trigger_type(imsic_parent_irq));
> -
>  	/* Setup IPIs */
>  	imsic_ipi_starting_cpu();
>  
> @@ -128,6 +123,19 @@ static int imsic_starting_cpu(unsigned int cpu)
>  
>  	/* Enable local interrupt delivery */
>  	imsic_local_delivery(true);
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

No line break required. You have 100 characters.

> +
> +	/* Restore the imsic reg */

One IMSIC register? Can you please write proper sentences and write
words out? This is not twitter. Also use IMSIC uppercase as the rest of
the code does in the comments.

Thanks,

        tglx

