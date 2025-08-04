Return-Path: <linux-kernel+bounces-755385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A982B1A5C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F913B5695
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE712165F3;
	Mon,  4 Aug 2025 15:22:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2864F19F11E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320933; cv=none; b=IWVfpyK2/cuWw3MCkQAI4+xBq8LoAJLpKf8Rdlgj10eCefNguvbtOFWvhZhzTF6Xk5Cht5YogxB5beXRBdXWq/SROhc7lsiE65U4JvFLIy9ESNZAW4zGVA+imOhUj87+i27O1Si+jSByZp/x43hnK3VRPVUwSfsMSW34wLiFZX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320933; c=relaxed/simple;
	bh=TD83Fz3P8u//V8Y1cX6pFywl3ILTbs7KXqK7IVCw6Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSDGM9SH+YFJdAfRHKeEV58IqfLLejbfFuNluinihMLIqeU1kUtQA/VSF5rjanOUiuXunwx/X9O2LW3QUECZwU6/sp22WscbsTW+eCRAMRq73DxcbrsCLj6uvzsehicWIDfnYJINIwCYObQG8t263aJeBb3Nm0LrOZRfpBHSZe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3034D1E4D;
	Mon,  4 Aug 2025 08:22:01 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F071F3F673;
	Mon,  4 Aug 2025 08:22:06 -0700 (PDT)
Date: Mon, 4 Aug 2025 16:22:04 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Sebastian Ene <sebastianene@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] KVM: arm64: ptdump: Fix exec attribute printing
Message-ID: <aJDQHMbiNVToTbum@J2N7QTR9R3>
References: <20250802104021.3076621-1-r09922117@csie.ntu.edu.tw>
 <d72b7928-8646-4616-a8f0-96b9d9bbaf09@arm.com>
 <z2hmwwmtgbrio2wv3sj2pc4zhxdjioorlhnm45o2arcsjahjni@xod435q26jqq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z2hmwwmtgbrio2wv3sj2pc4zhxdjioorlhnm45o2arcsjahjni@xod435q26jqq>

On Mon, Aug 04, 2025 at 08:41:35PM +0800, Wei-Lin Chang wrote:
> Hi Anshuman,
> 
> On Sun, Aug 03, 2025 at 07:33:04PM +0530, Anshuman Khandual wrote:
> > 
> > 
> > On 02/08/25 4:10 PM, Wei-Lin Chang wrote:
> > > Currently the guest stage-2 page table dump has the executable attribute
> > > printed in reverse, showing "X" for a non-executable region and showing
> > > " " for an executable one. This is caused by misjudgement of which
> > > string gets printed for the executable and non-executable case. Fix it
> > > by swapping the two strings.
> > > 
> > > Signed-off-by: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
> > > ---
> > >  arch/arm64/kvm/ptdump.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> > > index 098416d7e5c25..99fc13f1c11fb 100644
> > > --- a/arch/arm64/kvm/ptdump.c
> > > +++ b/arch/arm64/kvm/ptdump.c
> > > @@ -44,8 +44,8 @@ static const struct ptdump_prot_bits stage2_pte_bits[] = {
> > >  	}, {
> > >  		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
> > >  		.val	= PTE_VALID,
> > > -		.set	= " ",
> > > -		.clear	= "X",
> > > +		.set	= "X",
> > > +		.clear	= " ",
> > >  	}, {

I think the big problem here is that we've included the 'PTE_VALID' bit
in the mask. We don't bother with that for the Stage-1 ptdump code, e.g.

        {
                .mask   = PTE_PXN,
                .val    = PTE_PXN,
                .set    = "NX",
                .clear  = "x ",
        },

.... so do we actually need to take the PTE_VALID bit into account here? Do
invalid Stage-2 entries have anything we don't want to report?

... or can we change the Stage-2 ptdump code to have:

	{
		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN,
		.val	= KVM_PTE_LEAF_ATTR_HI_S2_XN,
		.set	= "NX",
		.clear	= "x ",
	},

... and match the Stage-1 code?

Otherwise, maybe we can add a separate valid-only filter.

> > >  		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
> > >  		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
> > 
> > Is not KVM_PTE_LEAF_ATTR_HI_S2_XN already in the reverse semantics aka
> > XN (Execute Never). Hence when KVM_PTE_LEAF_ATTR_HI_S2_XN macro is set
> > that means the entry is not executable and vice versa.
> 
> Yes you are correct. However in dump_prot() we have:
> 
> if ((st->current_prot & bits->mask) == bits->val)
> 	s = bits->set;
> else
> 	s = bits->clear;
> 
> Analysis:
> 
> 1. region is executable:
>     - st->current_prot == PTE_VALID (ignore other bits)
>     - st->current_prot & bits->mask gets PTE_VALID
>     - if condition is true (.val is PTE_VALID)
>     - prints bits->set
> 
> 2. region is not executable:
>     - st->current_prot == KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID
>     - st->current_prot & bits->mask gets (KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID)
>     - if condition is false
>     - prints bits->clear

As above, this is because the PTE_VALID bit has been placed into the
mask, and that's not how the ptdump code was intended to be used.

> Therefore we want .set = "X", and .clear = " ".

That'll work around the problem, but I'm not sure that's the right fix.
If nothing else, it's *very* confusing.

Mark.

