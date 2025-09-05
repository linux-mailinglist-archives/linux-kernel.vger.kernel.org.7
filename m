Return-Path: <linux-kernel+bounces-803355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B329FB45E07
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA17D5C6DCF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A11130216F;
	Fri,  5 Sep 2025 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QadUpJ58"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CF12F7ABF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089384; cv=none; b=SYnW4EFE1NM4S7FhOQN95wRrpHszRsYAKZUgFE6YV0gkJCjIV/DAqQMXrOuppPT3J2UuUD8yixJ6wrbcwQWlWloI6yIQRcbpNyh0pxoJteYpVnGdjGapAPOObb8iJ1nBEU2OGkML4TCvGuOKnoUGB2WFfMXfIW28R2AomxAnVG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089384; c=relaxed/simple;
	bh=FQ7VSQDMZ26MKHHuRF6ZOu5yejO3Qto6Ugr32kBm5c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PB2eCn42uFbdP1BlWujL1OwwyJ7sDm6w/PONNbcJK5bTajQDaFij8Ga9UaSnXvd1Ab89DzzkO99/x50SeoclaDD78FPLXMM1OWDmiMxnnZMtRBf3kshCcFmWFSG82kmC85f+C8Ae5DHfCOlmNGVS7jYENHQHMCKR9kTw3Zn2ThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QadUpJ58; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-80a59f06a4fso318023385a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757089380; x=1757694180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ad13/2gQOL6Gr085zJwP5rL6z3rEqez1d11xvvV7kSE=;
        b=QadUpJ58diaJa0Nm2ps0xqqmIoJ5FGk/6m9EcUZ6nhf5vHj5XgWgGkMuDC606utL9N
         cHXMBR0EWe7d43iPoyRD+aUfNq/K4nt1IRemjJZeMATBDW5FFkNJfWhvDLpTBOqwyFTa
         hxUvH7yM2slPtxYAwEFdG4DN+sbWYLk43gnlZ0jD02rcmBOmX1NBC1CM/AmKGVou2op4
         3o20PGyHv9SSDnmt1J7K4wF/IEv2Ha9prUzjvBfhO9n2bcRQ8Pzzez+xRTUwJJPJwhav
         GZQiHbDYQTXo78CFfjriLkKlfCaLPeBptoBrlIJf0GkTbcVkEVrLBsqXc5IOWzD29bPH
         3HzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757089380; x=1757694180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ad13/2gQOL6Gr085zJwP5rL6z3rEqez1d11xvvV7kSE=;
        b=ge12s/dPI3/bH5A0p41b/Hcat5d9e8FXANBFpyK1ZPscd9Cqty5VKRoXrBEbo9hUo3
         TGokegXcV+6cp3xMr6jxDJ7rrYn6FXfOfar00ZcSVPjf4av89tw5ciQd6OtRraBxPoC2
         DOU3IlxQ+OWLq/isbJXaB4CfdwziC6FPj5jHtQKcxmIzz/gjSjhDSlZXTEjMnBitQhF2
         beA8eOhGYEOd+HuXa01u6fYCRMDKgCI9xRnBOpI4AIMAM9Rep+4tG0JseZ8CbpFXKbGe
         KZL7gGXhNbV8NBd8dr+ul8yUI82g+YmOmI/TtSC+n4iijde6hpslC2tejrzxvuzmkQRg
         s9DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxQny1VJb013XT6HzuRmg3TNMmYp5YYViBHOsg7039QtuxkrOAtJ6VVa4mjIbRC8Y+IOytoC5AiT/1aHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKi80YcsjU5UjzEfKw0M2rcDY1CilPuuXue1dUDhf4SDsE+BcH
	X43I4QciW6YZRhAsORL1pgaWDML7A9HxeKOPZsA8P3fzDucUkozHyLvwWc82xk/C2rg=
X-Gm-Gg: ASbGncs7hr2eSm/SV0RIWnL+9FTLGBBvE3KgyObc0GD24GLTT0Lc0fh7TTqyIZDEfus
	wX2/snFQtWTXFb5Fx6slhM+3sDzpZ4DZCKERvC46BjMMxhcNVaAN1LYNLPJcFIoc1LOgbmH869E
	ZszjCWYQYIF0hsAfwRsBKQ+Y/sIGSbfCjeBiDQZ2FbQYV51gxFoZCuVb8DHtvAUh1KmUEuJptWG
	uIQwm2HR9VDbc21SNDDCX+zxbIQmytSUZy0EcdF8Ys8kVGGeMnkN+2GaWQh0AXzfSy5DBeY3AEX
	xtP8+G6QTjdJiRI6NwjuYqpllhweM9lcU9zTZvw2sYwzjB6PHBoS2gs5/VzdlF5Z35qIA9PS3jS
	0UErfpXTwKgr74/tcn+uJqoF8g2jl3wSynuYECXm6EUQEOZWOfoiUOwWq+Da02VaYOEls
X-Google-Smtp-Source: AGHT+IGahpiUClMcLLVXgS5mwb3H7pF6RD7KDX0AnnNYHP758kBLVwSbh/Pr8Ncjrvt8ub1MMqdwLg==
X-Received: by 2002:a05:6214:b03:b0:727:e45a:562c with SMTP id 6a1803df08f44-727e45a5b36mr82427466d6.45.1757089379823;
        Fri, 05 Sep 2025 09:22:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b5b9ceb1sm67962746d6.57.2025.09.05.09.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:22:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uuZDG-00000002sWI-1ORv;
	Fri, 05 Sep 2025 13:22:58 -0300
Date: Fri, 5 Sep 2025 13:22:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, will@kernel.org, maz@kernel.org,
	tglx@linutronix.de, robin.murphy@arm.com, suzuki.poulose@arm.com,
	akpm@linux-foundation.org, steven.price@arm.com
Subject: Re: [RFC PATCH] arm64: swiotlb: dma: its: Ensure shared buffers are
 properly aligned
Message-ID: <20250905162258.GA483339@ziepe.ca>
References: <20250905055441.950943-1-aneesh.kumar@kernel.org>
 <aLrh_rbzWLPw9LnH@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLrh_rbzWLPw9LnH@arm.com>

On Fri, Sep 05, 2025 at 02:13:34PM +0100, Catalin Marinas wrote:
> Hi Aneesh,
> 
> On Fri, Sep 05, 2025 at 11:24:41AM +0530, Aneesh Kumar K.V (Arm) wrote:
> > When running with private memory guests, the guest kernel must allocate
> > memory with specific constraints when sharing it with the hypervisor.
> > 
> > These shared memory buffers are also accessed by the host kernel, which
> > means they must be aligned to the host kernel's page size.
> 
> So this is the case where the guest page size is smaller than the host
> one. Just trying to understand what would go wrong if we don't do
> anything here. Let's say the guest uses 4K pages and the host a 64K
> pages. Within a 64K range, only a 4K is shared/decrypted. If the host
> does not explicitly access the other 60K around the shared 4K, can
> anything still go wrong? Is the hardware ok with speculative loads from
> non-shared ranges?

+1 I'm also confused by this description.

I thought the issue here was in the RMM. The GPT or S2 min granule
could be > 4k and in this case an unaligned set_memory_decrypted()
from the guest would have to fail inside the RMM as impossible to
execute?

Though I'm a little unclear on when and why the S2 needs to be
manipulated. Can't the S2 fully map both the protected and unprotected
IPA space and rely on the GPT for protection?

I do remember having a discussion that set_memory_decrypted() has
nothing to do with the VM's S1 granule size, and it is a mistake to
have linked these together. The VM needs to understand what
granularity the RMM will support set_memory_decrypted() for and follow
that.

I don't recall there is also an issue on the hypervisor? I thought GPT
faults on ARM were going to work well, ie we could cleanly segfault
the VMM process if it touches any protected memory that may have been
mapped into it, and speculation was safe?

> > @@ -213,16 +213,20 @@ static gfp_t gfp_flags_quirk;
> >  static struct page *its_alloc_pages_node(int node, gfp_t gfp,
> >  					 unsigned int order)
> >  {
> > +	long new_order;
> >  	struct page *page;
> >  	int ret = 0;
> >  
> > -	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
> > +	/* align things to hypervisor page size */
> > +	new_order = get_order(ALIGN((PAGE_SIZE << order), arch_shared_mem_alignment()));
> > +
> > +	page = alloc_pages_node(node, gfp | gfp_flags_quirk, new_order);
> >  
> >  	if (!page)
> >  		return NULL;
> >  
> >  	ret = set_memory_decrypted((unsigned long)page_address(page),
> > -				   1 << order);
> > +				   1 << new_order);
> 
> At some point this could move to the DMA API.

I don't think we should be open coding these patterns.

Esepcially given the above, it makes no sense to 'alloc page' and then
'decrypt page' on ARM CCA. decryption is not really a OS page level
operation. I suggest coming with some series to clean these up into a
more sensible API.

Everything wanting decrypted memory should be going through some more
general API that has some opportunity to use pools.

DMA API may be one choice, but I know we will need more options in
RDMA land :|

Jason

