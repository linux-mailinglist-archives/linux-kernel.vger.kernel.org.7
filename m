Return-Path: <linux-kernel+bounces-780774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA65CB30938
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D9D1D03DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16022283C9E;
	Thu, 21 Aug 2025 22:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hjrNecBB"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B537925C6EC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755815524; cv=none; b=gX4Kk8k8suW+XkqbjItT0UrZdeEodFokjA0VQP/gwfpEEDUQ55O7LNamhFGFx648sXxR6ywSEbrxCpMDttPr0vgrOe5PrjOyx+J/PuNo5vGGc7qluwn2kTMl23/4bE7+WZ/KHzJrB8gowJHd/BMkjhQoY1f/zFoS1g4DOGB+cfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755815524; c=relaxed/simple;
	bh=FZXiEO9ymqRTyNyhHt9aCurnaIp5/0aDjY/zutzCCDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2i+E4Kz7ECj0ykwdgYpU76mfrIS0q+Z5LPuI1usvuePDtCTb9Bys8NK1fwsoI/ZI9O9M/ye4MxP0JtV8IECByv2p7bBMyjEACa9wOKUhzSsh8tWxquOYZxHjst9Nl6BLnA8W9O29wBjqIif2vIa4mbvU97vWoBJa1rVqecIykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hjrNecBB; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Aug 2025 15:31:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755815520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oFEGbbG9vuv1+XubWypEttTMi6N6Jq7oeRJFb4KHVfY=;
	b=hjrNecBBoBWsKWTqEpFNnL+iVXrbWpNYn9MFE86Hjj9HjdbamZiTL06lrzvtFamG9v4Wv4
	rrSvmoyOB+TWNaAkyALNXOJrbgAhJE2dmzauDVGvPIYJRfdYheZw6vDXdaaOZycSw47tIB
	7Yv9fNk7SuYSS+W/V0ht2XEqKPoiXHA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	James Houghton <jthoughton@google.com>
Subject: Re: [RFC PATCH 05/16] KVM: arm64: Introduce "struct kvm_page_fault"
 for tracking abort state
Message-ID: <aKeeRynpwFTSONfm@linux.dev>
References: <20250821210042.3451147-1-seanjc@google.com>
 <20250821210042.3451147-6-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821210042.3451147-6-seanjc@google.com>
X-Migadu-Flow: FLOW_OUT

Hey Sean,

On Thu, Aug 21, 2025 at 02:00:31PM -0700, Sean Christopherson wrote:
> Add and use a kvm_page_fault structure to track state when handling a
> guest abort.  Collecting everything in a single structure will enable a
> variety of cleanups (reduce the number of params passed to helpers), and
> will pave the way toward using "struct kvm_page_fault" in arch-neutral KVM
> code, e.g. to consolidate logic for KVM_EXIT_MEMORY_FAULT.
> 
> No functional change intended.
> 
> Cc: James Houghton <jthoughton@google.com>
> Link: https://lore.kernel.org/all/20250618042424.330664-1-jthoughton@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/arm64/include/asm/kvm_host.h |  18 ++++
>  arch/arm64/kvm/mmu.c              | 143 ++++++++++++++----------------
>  2 files changed, 87 insertions(+), 74 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 2f2394cce24e..4623cbc1edf4 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -413,6 +413,24 @@ struct kvm_vcpu_fault_info {
>  	u64 disr_el1;		/* Deferred [SError] Status Register */
>  };
>  
> +struct kvm_page_fault {
> +	const u64 esr;
> +	const bool exec;
> +	const bool write;
> +	const bool is_perm;

Hmm... these might be better represented as predicates that take a
pointer to this struct and we just compute it based on ESR. That'd have
the benefit in the arch-neutral code where 'struct kvm_page_fault' is an
opaque type and we don't need to align field names/types.

> +	phys_addr_t fault_ipa; /* The address we faulted on */
> +	phys_addr_t ipa; /* Always the IPA in the L1 guest phys space */

NYC, but this also seems like a good opportunity to rename + retype
these guys. Specifically:

	fault_ipa => ipa
	ipa => canonical_ipa

would clarify these and align with the verbiage we currently use to talk
about nested.

Thanks,
Oliver

