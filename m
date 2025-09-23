Return-Path: <linux-kernel+bounces-827979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1062B93953
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E54019C131A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CB015A86D;
	Mon, 22 Sep 2025 23:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mMGh75xN"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9D4A32
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584022; cv=none; b=rXGJnlPlbs7ZcNXBUpAlfKKV3jGcE2oii+OTQ4Kt5XIN6zWRtn7BdtOMXIHXnrG413NDvexoSFv4yiqXpwXP/C2VG8zoPdJMvLfB5oN/PiyF0lpPfmZnOOXHfjlayBT1Z1moOTas4VRP/+DnoXTl3Lu4dGjies3Nd6pW2ML9O1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584022; c=relaxed/simple;
	bh=j6qXIZ0/y02ZO5iBRxYX2tGHPJzzFE/ioP07N0A6xL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+X44IW3+VYMm+gz3dhvsC3un0Lem2o6PCjUJ4ZEumdkopAnnqzJhf5POJNXuOZIqvVaN4jqKfFqVaRQdXKvM+q8oAiNBUosAX/fJRzjOQ+uGpdKHaJNVrytJlzZatShRzPXnTPx+Aa0pSdOY+iU3AnMtntHUS40SbJmIIpmlM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mMGh75xN; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Sep 2025 16:33:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758584017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+gGrtxGEbr8glZCCzkowKSxbC1Oe8vVU3z0oyF8KHbg=;
	b=mMGh75xNEe4RY/R53PguYpSyqXGPw0OgyU7E4WIQLZdW5fJ9APyuFCOfmsIY6mEhBJdnSz
	C2AQy8wK00Gp1wZVGnvgy4Vd2BfaCWKgX9Nzw2c4rDVJlz+NDnD2YG996EE2/YoqQBHcJg
	iphTJiLG9nbEnIXGMx7tLgcyh8AIYsM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Marc Zyngier <maz@kernel.org>, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, qperret@google.com,
	sebastianene@google.com, keirf@google.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2] KVM: arm64: Check range args for pKVM mem transitions
Message-ID: <aNHcxAJXHeS2T7TH@linux.dev>
References: <20250919155056.2648137-1-vdonnefort@google.com>
 <87plbkxcvv.wl-maz@kernel.org>
 <aNG417MneSKBxyn8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNG417MneSKBxyn8@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 22, 2025 at 10:00:07PM +0100, Vincent Donnefort wrote:
> On Sun, Sep 21, 2025 at 12:29:08PM +0100, Marc Zyngier wrote:
> > On Fri, 19 Sep 2025 16:50:56 +0100,
> > Vincent Donnefort <vdonnefort@google.com> wrote:
> > > 
> > > There's currently no verification for host issued ranges in most of the
> > > pKVM memory transitions. The subsequent end boundary might therefore be
> > > subject to overflow and could evade the later checks.
> > > 
> > > Close this loophole with an additional check_range_args() check on a per
> > > public function basis.
> > > 
> > > host_unshare_guest transition is already protected via
> > > __check_host_shared_guest(), while assert_host_shared_guest() callers
> > > are already ignoring host checks.
> > > 
> > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > > 
> > > ---
> > > 
> > >  v1 -> v2:
> > >    - Also check for (nr_pages * PAGE_SIZE) overflow. (Quentin)
> > >    - Rename to check_range_args().
> > > 
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > index 8957734d6183..65fcd2148f59 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > @@ -712,6 +712,14 @@ static int __guest_check_page_state_range(struct pkvm_hyp_vm *vm, u64 addr,
> > >  	return check_page_state_range(&vm->pgt, addr, size, &d);
> > >  }
> > >  
> > > +static bool check_range_args(u64 start, u64 nr_pages, u64 *size)
> > > +{
> > > +	if (check_mul_overflow(nr_pages, PAGE_SIZE, size))
> > > +		return false;
> > > +
> > > +	return start < (start + *size);
> > 
> > I will echo Oliver's concern on v1: you probably want to convert the
> > boundary check to be inclusive of the end of the range. Otherwise, a
> > range that ends at the top of the 64bit range will be represented as
> > 0, and fail the  check despite being perfectly valid.
> 
> Do you mean allowing something like start == 0xfffffffffffff000 and size ==
> 4096?

Yes, this is what I was alluding to on v1.

> But I guess that would still put all the following checks using "addr + size" at
> risk. Also, I believe even the code in pgtable.c wouldn't support a such range
> as it is also using a u64 end boundary.

I'm not sure I follow. Ranges are pretty commonly expressed as a range
terminated by an exclusive value. This just hasn't been an issue yet as
the page table code is only ever dealing with TTBR0 or VTTBR
translations.

Anyway, I'd rather these range checks have as few assumptions of the
applied address space as possible.

Thanks,
Oliver

