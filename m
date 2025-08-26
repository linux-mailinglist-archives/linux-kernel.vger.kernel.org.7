Return-Path: <linux-kernel+bounces-787212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8FAB3730D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5E8E7A6849
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289B6374279;
	Tue, 26 Aug 2025 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aDqDpINy"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2853728AB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236604; cv=none; b=ny/F8GKzXHRmS6gTcixbv1dV0qR1w5SEFH38vaJ7CJAWeL4ghyjDVNQ9PACmREM0ww5swniYWWYhIkDuAyAZ6GgTiuPbHyMDTavTmOhSOM0zmnt/6RX8b8QF5ALcG2LP4fy1kyFozS3YAth0CQNR1ScDBbPEcwDHkB3PWwKQaJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236604; c=relaxed/simple;
	bh=rEKbhoNka+rtltPfgB057P3vkV2ooVBisYd42WcxP/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBmsNTtFaJudwht+uxvVv8kkb4wAaglxTbYAg4r8OMiu4HPCe3RBqMoWNQBhFJor61HUexk9WdVegbNWR6YQCcJ0Fwik0y6+GTuT9SMKO1aLdKuvh/kiNwxF3zUYqCbDjVgUIpcTBdeULJw+tPKeDCQGDjquCxopmZozJfcb3jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aDqDpINy; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 26 Aug 2025 12:29:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756236591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A3TH3r3Rwj1NIsB8dPGas/6OVkWEe0yZPECgLM5Cpvg=;
	b=aDqDpINynr6ybo6xMCGuGg/Zm3t4jpzlChTdjV1hAwFyilOB/hSW8hHvUKENj0Q9zZh6rs
	zkPcG5uk/BTm7PXnIPzAupTb3u1putzTorFk6ye4so4VTdKUMGqM01ra6qxVE+HZnhWg02
	3MRonxtLj+pvtIRm0QYoetQYBwm/mMA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	James Houghton <jthoughton@google.com>
Subject: Re: [RFC PATCH 05/16] KVM: arm64: Introduce "struct kvm_page_fault"
 for tracking abort state
Message-ID: <aK4LIj-OZsP_35wc@linux.dev>
References: <20250821210042.3451147-1-seanjc@google.com>
 <20250821210042.3451147-6-seanjc@google.com>
 <aKeeRynpwFTSONfm@linux.dev>
 <aK4DwtuQtzYvRei-@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK4DwtuQtzYvRei-@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 26, 2025 at 11:58:10AM -0700, Sean Christopherson wrote:
> On Thu, Aug 21, 2025, Oliver Upton wrote:
> > Hey Sean,
> > 
> > On Thu, Aug 21, 2025 at 02:00:31PM -0700, Sean Christopherson wrote:
> > > Add and use a kvm_page_fault structure to track state when handling a
> > > guest abort.  Collecting everything in a single structure will enable a
> > > variety of cleanups (reduce the number of params passed to helpers), and
> > > will pave the way toward using "struct kvm_page_fault" in arch-neutral KVM
> > > code, e.g. to consolidate logic for KVM_EXIT_MEMORY_FAULT.
> > > 
> > > No functional change intended.
> > > 
> > > Cc: James Houghton <jthoughton@google.com>
> > > Link: https://lore.kernel.org/all/20250618042424.330664-1-jthoughton@google.com
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/arm64/include/asm/kvm_host.h |  18 ++++
> > >  arch/arm64/kvm/mmu.c              | 143 ++++++++++++++----------------
> > >  2 files changed, 87 insertions(+), 74 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > > index 2f2394cce24e..4623cbc1edf4 100644
> > > --- a/arch/arm64/include/asm/kvm_host.h
> > > +++ b/arch/arm64/include/asm/kvm_host.h
> > > @@ -413,6 +413,24 @@ struct kvm_vcpu_fault_info {
> > >  	u64 disr_el1;		/* Deferred [SError] Status Register */
> > >  };
> > >  
> > > +struct kvm_page_fault {
> > > +	const u64 esr;
> > > +	const bool exec;
> > > +	const bool write;
> > > +	const bool is_perm;
> > 
> > Hmm... these might be better represented as predicates that take a
> > pointer to this struct and we just compute it based on ESR. That'd have
> > the benefit in the arch-neutral code where 'struct kvm_page_fault' is an
> > opaque type and we don't need to align field names/types.
> 
> We'd need to align function names/types though, so to some extent it's six of one,
> half dozen of the other.  My slight preference would be to require kvm_page_fault
> to have certain fields, but I'm ok with making kvm_page_fault opaque to generic
> code and instead adding arch APIs.  Having a handful of wrappers in x86 isn't the
> end of the world, and it would be more familiar for pretty much everyone.

To clarify my earlier point, my actual interest is in using ESR as the
source of truth from the arch POV, interface to the arch-neutral code
isn't that big of a deal either way.

Thanks,
Oliver

