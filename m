Return-Path: <linux-kernel+bounces-855954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF00BE2AAB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4144E4FBC80
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC4731A56C;
	Thu, 16 Oct 2025 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C9hzE/Cn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Te3nuhzP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205932D12F5
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608918; cv=none; b=DjB+FWaNt3khVgK24iLx+ciQkiN7CcPV+TlaYnpZM5/Gv3+aQ5mJflAWy4W5b2l9ZgdgtfoqmhQAnzcqf3ZmQ8LyKVNyX1E9bi7R/SXQeXeHYx1EsbMnxFgRQ94e/v3QjWAKPZVdzhYTlkSCg7kk7rAG3MZa8jm5RfXWdKsN66U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608918; c=relaxed/simple;
	bh=zyfNOLyeJGLAkaDkAXsRIAVlmYtWlRS9MOxeMvBdFpE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AwcoUh5NdacuN9KXbMTJ8uLiOVQgOeq/bwPC0vPx044g9OPDvEThy0Qy9CDseC7/iruGSe2bdVyBOpb2SHKw2hpR5X/FwseGW+ExVpyfqzKWaPVPHJ8h7IDCvdsZXJlkVVjOvn+naAKXEui35L1n6o4QWZQB7bUiqGT1QRZvAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C9hzE/Cn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Te3nuhzP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PDeWvfL0Yyl8v4f6ecg6l9WJt9/NhYirIKkwErXjMzM=;
	b=C9hzE/CnqBaasqAFCYuDPVH3pbX8GmLjumEf+rwtEW10/GGgJcGb64IDCdnSXahjzJ1Bcv
	Ldzyqc1RtjWrd6TXX+7K6nlfIePUOB2W7YHIvWRWh6uBYrg+XtnOr6pqI364XFRBq9MHAi
	2sTCsZg1ryKXqQSUbLFycP/dR6ceMSMZSpcT8sgnIVfnIwwf+EPj7uqwwTdmrUGYK8Nazl
	S2SXCRUJqq4mefTGqUedWBLDdYeSQ5WCAp16z1dDsr9xdzCVCKQnuPpb3a1HywV6A2Pmzn
	CR5Wa8eLp241JNeW+jd+dUYrOfRlGHjpMJFGWQsvHZbypBFw5R8Xar60G77EaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PDeWvfL0Yyl8v4f6ecg6l9WJt9/NhYirIKkwErXjMzM=;
	b=Te3nuhzPs7a2+HiG1/4JZ8YshOJPg+QJXZMmqkNWfOIRteiGE88LShyNMdHuM9ZfOtgrE7
	9rSduVKyiixm0qDg==
To: Samuel Holland <samuel.holland@sifive.com>, Anup Patel
 <anup@brainfault.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
 Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, Paul
 Walmsley <pjw@kernel.org>, Samuel Holland <samuel.holland@sifive.com>,
 Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 4/4] irqchip/riscv-imsic: Remove irq_desc lookup from
 hot path
In-Reply-To: <20251015195712.3813004-5-samuel.holland@sifive.com>
References: <20251015195712.3813004-1-samuel.holland@sifive.com>
 <20251015195712.3813004-5-samuel.holland@sifive.com>
Date: Thu, 16 Oct 2025 12:01:53 +0200
Message-ID: <87v7kf17xq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 15 2025 at 12:55, Samuel Holland wrote:
> The IMSIC driver uses the IRQ matrix allocator, so there is an arbitrary
> mapping from the per-CPU interrupt identity to the global irq number. As
> a result, the driver maintains a table of vectors so it can look up the
> virq number during interrupt handling. The driver uses the virq for one
> main purpose: it gets passed to generic_handle_irq(), which then uses it
> to look up the irq_desc in the sparse_irqs tree.
>
> Taking inspiration from the loongarch AVEC irqchip driver, skip the tree

which got the idea from x86 :)

> -struct imsic_vector *imsic_vector_alloc(unsigned int irq, const struct cpumask *mask)
> +struct imsic_vector *imsic_vector_alloc(struct irq_desc *desc, const struct cpumask *mask)
>  {
>  	struct imsic_vector *vec = NULL;
>  	struct imsic_local_priv *lpriv;
> @@ -450,7 +451,7 @@ struct imsic_vector *imsic_vector_alloc(unsigned int irq, const struct cpumask *
>  
>  	lpriv = per_cpu_ptr(imsic->lpriv, cpu);
>  	vec = &lpriv->vectors[local_id];
> -	vec->irq = irq;
> +	vec->desc = desc;
>  	vec->enable = false;
>  	vec->move_next = NULL;
>  	vec->move_prev = NULL;
> @@ -463,7 +464,7 @@ void imsic_vector_free(struct imsic_vector *vec)
>  	unsigned long flags;
>  
>  	raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
> -	vec->irq = 0;
> +	vec->desc = NULL;
>  	irq_matrix_free(imsic->matrix, vec->cpu, vec->local_id, false);
>  	raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);

This is only correct when it is guaranteed that the interrupt can't be
raised in the CPU _before_ a interrupt allocation completed throughout
the hierarchy and _after_ the freeing hierarchy walk started. Otherwise
this might end up accessing a half initialized or half torn down
descriptor.

If it is, then please add a comment describing it. If not then you need
to implement the activate/deactivate callbacks for your interrupt domain
and do the store/clear of vec->desc there.

Thanks,

        tglx

