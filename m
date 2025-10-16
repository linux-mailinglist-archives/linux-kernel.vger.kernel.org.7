Return-Path: <linux-kernel+bounces-856256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EBBBE3A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F6E587184
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE38C1B21BD;
	Thu, 16 Oct 2025 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3/uLnaLm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gn/NlTqn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD916182B4;
	Thu, 16 Oct 2025 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620667; cv=none; b=syh7tgaAul/l+uC7r8S+LP7DsIvalwSAVVL52/2lpLnm+IirNTMcWT2QnSxn/htRsq6B6Qa0YqN/P1hmxPBkWEa966HvHfiKpndQAwO3FxeazhnFC6banJkAqpMAz//mFp+oW9C+NQi3yHn1jj5S05TmcWwnJqUF4Bfi3RuppgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620667; c=relaxed/simple;
	bh=yrKfrV0nbOKXtObxq3UyJPSp80wbu5z0EU242OuV6G0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=biXFahYIxghDqk7mqspo6zmAeL6It+e5+A0AuOzYR2t5hivKnhGP0ul1+S3wwWPgAEIjwdx/5Uvz2t0yO/9LXkgmW3PACDDskni0D5EZy/iuBQbvQCoV0OkvKFdKOqi6Sncp+2XoSBuM5ovD6MCeCrlY7Ol2WBfa8hI88jp6xIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3/uLnaLm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gn/NlTqn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760620664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+oUsWchRMdAE4l+vEN2fWlus0VY/n34ExO8gyOqnMgA=;
	b=3/uLnaLmN//dFyOSyDF7z93ieUKiwrTSGweVvS0Zt+mj1ZlLJM6EvuYJq7lQYwf6A8sNZJ
	qmL0ZsFD5ylLS62sUlAziXGrq1mxaWSoXhfL30MRWnX5IoYG/dPaeNAICX9As8IpFHAFQ0
	oezi9KI8sVw6tkcDDtRR1S1DiX6zqKcIeCRQukpnSWi2cLxN9ztpnUybJS/sHDlMokwupJ
	cmYsGFiH6O8yhzqgsilzDLCIJarNni9F8ncD+nyOxV+EI9X3Lu8jGojxw/kxynWLmbrZcH
	Ih7XhBYmh7hTJfUE26CiZ3VuiB1dFaGsNSf9jbJuk2lk3q8ZAHVLw0xEVd8zUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760620664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+oUsWchRMdAE4l+vEN2fWlus0VY/n34ExO8gyOqnMgA=;
	b=gn/NlTqnvRPSe8AeSdxph3cIKZLyJJlA5SOlj8PMN2CG1GBeIbsmhusHcfKwYcc3GKYCNk
	km8SkqAp3iDfvmCw==
To: Lucas Zampieri <lzampier@redhat.com>, linux-kernel@vger.kernel.org
Cc: Charles Mirabile <cmirabil@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Samuel
 Holland <samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Vivian
 Wang <dramforever@live.com>, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, Zhang Xincheng
 <zhangxincheng@ultrarisc.com>, Lucas Zampieri <lzampier@redhat.com>
Subject: Re: [PATCH v5 3/3] irqchip/plic: add support for UltraRISC DP1000 PLIC
In-Reply-To: <20251016084301.27670-4-lzampier@redhat.com>
References: <20251016084301.27670-1-lzampier@redhat.com>
 <20251016084301.27670-4-lzampier@redhat.com>
Date: Thu, 16 Oct 2025 15:17:42 +0200
Message-ID: <87plan0yvd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 16 2025 at 09:42, Lucas Zampieri wrote:

After fixing the corrupted patch up I had a closer look and decided not
to merge it. See comments below.
  
> +static bool cp100_isolate_pending_irq(int nr_irq_groups, u32 ie[],
> +				       void __iomem *pending,
> +				       void __iomem *enable)
> +{
> +	u32 pending_irqs = 0;
> +	int i, j;
> +
> +	/* Look for first pending interrupt */
> +	for (i = 0; i < nr_irq_groups; i++) {
> +		pending_irqs = ie[i] & readl_relaxed(pending + i * sizeof(u32));
> +		if (pending_irqs)
> +			break;
> +	}
> +
> +	if (!pending_irqs)
> +		return false;
> +
> +	/* Disable all interrupts but the first pending one */
> +	for (j = 0; j < nr_irq_groups; j++) {
> +		u32 new_mask = 0;
> +
> +		if (j == i) {
> +			/* Extract mask with lowest set bit */
> +			new_mask = (pending_irqs & -pending_irqs);
> +		}
> +
> +		writel_relaxed(new_mask, enable + j * sizeof(u32));
> +	}
> +
> +	return true;
> +}
> +
> +static irq_hw_number_t cp100_get_hwirq(struct plic_handler *handler,
> +					void __iomem *claim)
> +{
> +	int nr_irq_groups = DIV_ROUND_UP(handler->priv->nr_irqs, 32);
> +	void __iomem *pending = handler->priv->regs + PENDING_BASE;
> +	void __iomem *enable = handler->enable_base;
> +	irq_hw_number_t hwirq = 0;
> +	int i;
> +
> +	guard(raw_spinlock)(&handler->enable_lock);
> +
> +	/* Save current interrupt enable state */
> +	for (i = 0; i < nr_irq_groups; i++)
> +		handler->enable_save[i] = readl_relaxed(enable + i * sizeof(u32));

This is truly the most inefficient way to solve that problem. The enable
registers are modified with enabled_lock held, so you can just cache the
value in plic_handler::enabled_save and avoid this read loop completely.
After claiming the interrupt you restore from that cache, no?

Now for the search and disable mechanism. Of course you need to search
for th pending interrupt first, but then you can make that masking loop
very simple by having a plic_handler::enabled_clear[] array which is
zeroed on initialization:

        unsigned long pending = 0;
        
	for (group = 0; !pending && group < nr_irq_groups; group++) {
		pending = handler->enabled_save[i];
                pending =& readl_relaxed(pending + group * sizeof(u32));
	}
        if (!pending)
        	return false;

        bit = ffs(pending) - 1;
        handler->enabled_clear[group] |= BIT(bit);
        for (int i = 0; i < nr_irq_groups; i++)
		writel_relaxed(handler->enabled_clear[i], enable + i * sizeof(u32));
        handler->enabled_clear[group] = 0;

No?

But looking at this makes me wonder about the functional correctness of all
this. What happens in this case:

Device A raises an interrupt

    handler()
        ....
        disable_groups();

Device B raises a now disabled interrupt

        restore_groups();

Is the device B interrupt preserved in the interrupt chip and actually
raised when the interrupt enable bit is restored or is it lost?

Thanks,

        tglx

