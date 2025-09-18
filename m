Return-Path: <linux-kernel+bounces-781483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5037CB31311
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A5B5C19DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D07C2ED17D;
	Fri, 22 Aug 2025 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I6gMCdUf"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C43A2EE5FA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854771; cv=none; b=Zebh0xJzWdzj8AsjSETe22Kiqx8/O6wuFP8Zo7o8l/fO5yHSfWaHgchZ7sRLxMflLTREN3QOgS6H+XA1ZUjCCMPvsvkvqIa8CuHYep+Aco7MRFpsyEh0eUcDj3xsnf+6WRfeFrLF7jJmbhtjwtNc51Zk/nMhFNyt+8CoGrdkTgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854771; c=relaxed/simple;
	bh=zU0G/aUo6bfSJLPq+JRQFqKaqZJgVyzOmP1MHFt8paA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYUBjDDErgzQudXU7B187yqYbq1TzT8JLy+7soP+cMnxn07Y2f7KasSxSDLXrjMTLJ4wErxgwGPB45FM1w2vxcu+qfTtTkaUQLrVU552JuTLFL6EvLfYpmz2gRpaArYUJuBnuwpCwZouISavHPEV1IYDn5LNP95a7xZ9YRS9WOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I6gMCdUf; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 22 Aug 2025 02:25:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755854757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SLjg8Y5myb/BfSTld+S05SbtufySosFInjHD1VZtzHU=;
	b=I6gMCdUf8SOoxP9R+ovqkZBQ277HOocaX8dY7qeW8bj3T7YfmvoW4cJK2LJh5qGGjKu4hp
	iTY2B2a0tfbAr84wJ5ZkiPqszexiJyLfb6wqC6+NOG9sDP5plAeS8V86HMQVRHjI0IsNpG
	Cfc4/7w+XjmPGKZ2nS3NOPz8WDjM8VA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] KVM: arm64: nv: Allow shadow stage 2 read fault
Message-ID: <aKg3l23hheuQ1dJH@linux.dev>
References: <20250822031853.2007437-1-r09922117@csie.ntu.edu.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822031853.2007437-1-r09922117@csie.ntu.edu.tw>
X-Migadu-Flow: FLOW_OUT

Hi Wei-Lin,

You've been finding some good stuff with nested, thank you :)

On Fri, Aug 22, 2025 at 11:18:53AM +0800, Wei-Lin Chang wrote:
> I am able to trigger this error with a modified L1 KVM, but I do realize
> this requires L1 to be very strange (or even just wrong) so I understand
> if we don't want to handle this kind of edge case. On the other hand,
> could there also be other ways to trigger this that I have not thought
> of?

The architecture is pretty unambiguous here that the stage-2 can
represent a translation w/o read permission.

> Another thing is that this change lets L1 get away with not flushing the
> TLB, but TLBs are ephemeral so it's fine in this aspect, however I'm not
> sure if there are other considerations.

FEAT_ETS3 is an interesting one since it provides software with ordering
expectations around MMU faults (including permission faults) and updates
to the translation tables. For KVM's shadow stage-2 to comply we need to
re-walk the guest's stage-2 before injecting the fault at L1.

> ---
>  arch/arm64/kvm/mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 1c78864767c5c..41017ca579b19 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1508,8 +1508,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	exec_fault = kvm_vcpu_trap_is_exec_fault(vcpu);
>  	VM_BUG_ON(write_fault && exec_fault);
>  
> -	if (fault_is_perm && !write_fault && !exec_fault) {
> -		kvm_err("Unexpected L2 read permission error\n");
> +	if (fault_is_perm && !write_fault && !exec_fault && !nested) {
> +		kvm_err("Unexpected S2 read permission error\n");
>  		return -EFAULT;
>  	}

Hmm... I'm also willing to just delete this check altogether. The
likelihood of KVM creating a stage-2 PTE w/o read permission is rather
low.

Thanks,
Oliver

