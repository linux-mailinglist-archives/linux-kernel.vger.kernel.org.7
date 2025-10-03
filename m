Return-Path: <linux-kernel+bounces-840884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E0CBB5A70
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 02:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9E81AE477B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 00:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACD023CE;
	Fri,  3 Oct 2025 00:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qg4zTlvU"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B42A48
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 00:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759449866; cv=none; b=qCEXwzQCcIJ4hYW/j9ruh/dAr0nLNtqsuNgmq0y33k+tXN6c2fJ3jCKQecDweq0CzQ+byX/9eTK7kxDXonLcAMSpYCffkbjPfP3NT69AP3ptPbWRV0BmU5yg8R1fkakIiBlPoMlT1vJ3RStAg+xLg11duA3clNKgUem5PWphm6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759449866; c=relaxed/simple;
	bh=j2aNLIyCaCGd69AdirvOB2Gaoi0yVQ5cqrWrzaky7lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRm94trrolzjX74Ci0VhjW7ZNAr15IoNlRLgzOt93Pe08lFkcNicSpzVI6tJ+ntk1tCVsHoGZ9+2qW5zIRiS35jPzC/EATbf9thwkiaKWyzxQNakuymCpn/GyY3B32djbTKkrkDG85RAdYte4wOC1r0ZKOpu3vPwGSvy4odNhkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qg4zTlvU; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 2 Oct 2025 17:04:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759449861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kkFgpezMQKS/gQLXn3AyZkGxBPfCkQ1RwNxBP22utPM=;
	b=qg4zTlvUUnUwY8urfG2Q95TBycGvvpK1Cdx3XhQ7mPJesKFOtu62Az3Ad8+VzmqKFyYLNB
	XSmjjuDXsUQAkoO6YZuHaXhLtGg23SF78swtq3aPOQv0uEqIAWFSLfGnucRINVvtS5aE6R
	fGBZW4/o9mH5RNv2EUQSLOGGkSzefJg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Wei-Lin Chang <r09922117@csie.ntu.edu.tw>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH] KVM: arm64: nv: do not inject L2-bound IRQs to L1
 hypervisor
Message-ID: <aN8S-8HJFLjq6i2M@linux.dev>
References: <20251002205939.1219901-1-volodymyr_babchuk@epam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002205939.1219901-1-volodymyr_babchuk@epam.com>
X-Migadu-Flow: FLOW_OUT

Hi Volodymyr,

On Thu, Oct 02, 2025 at 09:00:11PM +0000, Volodymyr Babchuk wrote:
> Difference between nested virtualization and "baremetal" case is that
> real GIC can track lots of active interrupts simultaneously, but vGIC
> is limited only to 4..16 LRs.

There isn't an architectural limitation here. Nothing prevents a
virtualized GIC from representing more active IRQs than there are LRs in
hardware.

ICH_HCR_EL2.LRENPIE allows you to take a trap when an EOI is received
for an IRQ that exists outside of teh list registers which would allow
the deactivation of the SW view of that IRQ.

As Marc suggested, the correct thing to do is adjust the sorting of IRQs
such that pending IRQs fill LRs before those in an active state.

> diff --git a/arch/arm64/kvm/vgic/vgic-v3-nested.c b/arch/arm64/kvm/vgic/vgic-v3-nested.c
> index 7f1259b49c505..bdd1fb78e3682 100644
> --- a/arch/arm64/kvm/vgic/vgic-v3-nested.c
> +++ b/arch/arm64/kvm/vgic/vgic-v3-nested.c
> @@ -286,9 +286,13 @@ void vgic_v3_sync_nested(struct kvm_vcpu *vcpu)
>  		if (WARN_ON(!irq)) /* Shouldn't happen as we check on load */
>  			continue;
>  
> +		irq->targets_l2 = true;
> +
>  		lr = __gic_v3_get_lr(lr_map_idx_to_shadow_idx(shadow_if, i));
> -		if (!(lr & ICH_LR_STATE))
> +		if (!(lr & ICH_LR_STATE)) {
>  			irq->active = false;
> +			irq->targets_l2 = false;
> +		}
>  
>  		vgic_put_irq(vcpu->kvm, irq);
>  	}
> diff --git a/arch/arm64/kvm/vgic/vgic.c b/arch/arm64/kvm/vgic/vgic.c
> index 6dd5a10081e27..6f6759a74569a 100644
> --- a/arch/arm64/kvm/vgic/vgic.c
> +++ b/arch/arm64/kvm/vgic/vgic.c
> @@ -858,6 +858,17 @@ static void vgic_flush_lr_state(struct kvm_vcpu *vcpu)
>  			break;
>  		}
>  
> +		/*
> +		 * If we are switching to L1 Hypervisor - populate LR with
> +		 * IRQs that targeting it especially and are not targeting
> +		 * its L2 guest
> +		 */
> +		if (vcpu_has_nv(vcpu) && !vgic_state_is_nested(vcpu) &&
> +		    irq->targets_l2) {
> +			raw_spin_unlock(&irq->irq_lock);
> +			continue;
> +		}
> +
>  		if (likely(vgic_target_oracle(irq) == vcpu)) {
>  			vgic_populate_lr(vcpu, irq, count++);

This has some serious issues as it violates our architectural model of
the GIC.

The existence of an LR associating a vIRQ to a pIRQ only has relevance
when in a nested state, specifically when handling vIRQ deactivation.
Besides that it is just a number...

For example, imagine the guest hypervisor associated an EL1 timer IRQ
with an LR and later tried to clear the active state and re-arm the
timer. Seems like we would miss the IRQ entirely.

I'd really like to see a solution similar to Marc's proposal which
addresses the fundamental problem of active IRQs overflowing the list
registers. 

Thanks,
Oliver

