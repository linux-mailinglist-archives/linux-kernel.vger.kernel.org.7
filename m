Return-Path: <linux-kernel+bounces-759745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFE8B1E1DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFA2A7AFBA8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 05:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EA820F069;
	Fri,  8 Aug 2025 05:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VEwCvnzH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iCE4MQGp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3780E1361
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754632610; cv=none; b=H6eNvkJWWoQ3BRLdDKwoEldOopDPSHt755bEG0EF9k6Nzq8C3/eMIOZj/Sp9XjDafstfvoSzuAaLiNC7/l9cPMPc40oovT+C7G+eIWSRSwUFxriIkZYpupNdoxpIZ74H1tAQuAqDkiQGOZy1dOshGEW312EslNIfHYa1KmE9GTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754632610; c=relaxed/simple;
	bh=tN4ims1/l537ylNY2acrlOQfpRiG1zJIRhWn1yaCfsQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PJbSj3+PEcAyQ5n1kF36gvzU10e1nhJUcrdkB+zs6RgZqpndiJIJqKHuN9fMv1nSQC+Wcon8eCddZbfMZ3R7f+MDBKwSfp/8+Rr4hlJ0nYL9PczvNQSbjNSH/KMb7Vpe4PTjYF4SdMk01aBd2INErQtGFTT55OyXBKuXYpkOBKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VEwCvnzH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iCE4MQGp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754632607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ioePJL1VsQ/2j8sxfj1vc9birhDp1aOEmwXhjQnfcwA=;
	b=VEwCvnzH01bLZgM9WcXHIHBMVdir/4l2NEgt9JQDGoTUqaFXfF9yGB2IkzBy3xJHGn4zoY
	gRMdYZ2Xb4ZGOOrEvJeKeGzyHP6Ysu2/b9FycRv9zjnJWHb6SYiRxCSEJMyn3ZBMVVLZKo
	IeTjFjf93Avcu7dNKRon8Q+Pb+IqgIJuBiDyEpyVgFZjEwl8cyKopyLIw3vO3EX5tMCOSi
	Hys2V5MpOKYpMarSwVfedAeGsb/bd8KHvqKaOQliZMO5bJ4me9ZwTSCZsr3eAmKTBzfkXQ
	RyGmboV2c1P4q676RCorZByj4nnTN7HAluAgyCIf0vCV3GVQYn7Yr7G07CzSCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754632607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ioePJL1VsQ/2j8sxfj1vc9birhDp1aOEmwXhjQnfcwA=;
	b=iCE4MQGppabeZSxDpqUYmwhFZti0S8dr4dMXEXUg1OTpiuqGEOcpTTxLtOZfSDxAsTy4fc
	II9EDbCSMzJBydCQ==
To: Thomas Gleixner <tglx@linutronix.de>, Inochi Amaoto
 <inochiama@gmail.com>, Chen Wang <unicorn_wang@outlook.com>
Cc: Inochi Amaoto <inochiama@gmail.com>, linux-kernel@vger.kernel.org, Anup
 Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: Affinity setting problem for emulated MSI on PLIC
In-Reply-To: <87tt32r082.ffs@tglx>
References: <20250722224513.22125-1-inochiama@gmail.com> <87tt32r082.ffs@tglx>
Date: Fri, 08 Aug 2025 07:56:46 +0200
Message-ID: <87fre2pd9d.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:
> Cc'ing more people as this goes way beyond the SG204x driver

Sorry, I missed this email..

> @@ -179,12 +181,57 @@ static int plic_set_affinity(struct irq_
>  	if (cpu >= nr_cpu_ids)
>  		return -EINVAL;
>  
> -	plic_irq_disable(d);
> +	/* Invalidate the original routing entry */
> +	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
>  
>  	irq_data_update_effective_affinity(d, cpumask_of(cpu));
>  
> -	if (!irqd_irq_disabled(d))
> -		plic_irq_enable(d);
> +	/*
> +	 * Update the routing entry for the new target CPU.
> +	 *
> +	 * The below comment is not for a final patch, it's just
> +	 * documentation for this combo patch, which obviously needs to be
> +	 * split up into a gazillion of patches. So I use this as a notepad
> +	 * in order to not forget the gory details, which are changelog
> +	 * material :)
> +	 *
> +	 * This is on purpose not bug compatible with the current
> +	 * implementation, which unmasked the interrupt unconditionally due
> +	 * to:
> +	 *
> +	 *	if (!irqd_irq_disabled(d))
> +	 *		plic_irq_enable(d);
> +	 *
> +	 * which is broken as it unconditionally unmasks a masked
> +	 * interrupt. This was introduced with commit
> +	 *
> +	 * 6b1e0651e9ce ("irqchip/sifive-plic: Unmask interrupt in plic_irq_enable()")

Right, my bad.

> +	 *
> +	 * which in turn tried to fix the problem, which was introduced by
> +	 * commit
> +	 *
> +	 * a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask operations")
> +	 *
> +	 * 6b1e0651e9ce is probably harmless, but I'm too tired and can't
> +	 * be bothered to validate it. See below.
> +	 *
> +	 * This all needs real scrutiny and has to be validated against
> +	 * both specification and implementations.
> +	 *
> +	 * AFAICT, toggling unconditionally is the right thing to do, but I
> +	 * might be completely wrong as ususal.

Is it not possible that affinity is setup while the interrupt is
disabled? Because in that case, toggling unconditionally would enable a
disabled interrupt.

>                                               For me the two mentioned
> +	 * commits above seem to be contradictionary, but my tired brain
> +	 * can't decode it right now and therefore I leave that for the
> +	 * PLIC wizards as _their_ homework.

Not sure if I am included in the "PLIC wizards". But they are not contradictionary:

    a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask operations")

      Before this commit, the enable bits and the priority bits are both
      changed in irq_mask(). There was no irq_enable().

      This commit separates them, irq_mask() sets priority bits while
      irq_enable() sets the enable bits.

   6b1e0651e9ce ("irqchip/sifive-plic: Unmask interrupt in plic_irq_enable()")

      This commit changed irq_enable() to also set the priority bits.

>                                            Not that I have high
> +	 * expectations on that given the trail of Tested-by and other
> +	 * tags. "Works for me" by some definition of "works" seems to be
> +	 * the prevailing principle here. "Correctness first" is obviously
> +	 * overrated as usual up to the point where the real great hacks
> +	 * come along to "fix" the resulting sh*t. Unfortunately that costs
> +	 * the time of people, who have not been responsible for the
> +	 * problems in the first place...
> +	 */
> +	plic_irq_toggle(cpumask_of(cpu), d, 1);
>  
>  	return IRQ_SET_MASK_OK_DONE;
>  }

I could do a staring, see if there are still lurking problems

Nam

