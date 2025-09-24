Return-Path: <linux-kernel+bounces-830293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5AAB99547
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6304C5D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9882DC77C;
	Wed, 24 Sep 2025 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Do/9BbTA"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5402DCBE2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708213; cv=none; b=I6WC4ATMnZmZMq0U/NaiVlfAYrFteghnggFYb2yIEXmKspN5gPBtvFKAIN2VhroJcAu2V+WdzBCtonkGg93wV9DEsKe0Jrh1vAeCtQE1CYNTgHYRhuQXVZpifs1vAjfxHNnhGo20Z8lBizWgbjksq6Dgz0eujuEHKkAsjEtRgRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708213; c=relaxed/simple;
	bh=HYUoI22bV7rg9Ve/hq+9pc8VZtuwx3rsi1QoADu72Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rb5gr4X4NHo2dcJk2fEP+Md1mlXhuhX9Vk88PsGn0WRIUrOGifxsOcctCB7SAZC3EW8ZykEYTInqu9pdFJPTNQJO+OAIOkqhmzjm9Y2FBNF702ijtr9961Znfe7pASOioGPodZYSHm0kzE3HOlbQafV5t6hVREHNsAoAvJJYl0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Do/9BbTA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gSzKkn95aJhKUUtAxX8yFbdOTN479L21009/xPVDxFo=; b=Do/9BbTAem0kA+Q3UuG6+kUz/j
	vh3DfOVHftIdYUrDPfNtCoaHmbWkdEFIDpbf34DwCvE+BUJzEonIEQBtYixRmpBpoXGWXhE1BXB6A
	s5k14jg2enZHfSlTEISDmr1IPs6CirYtrJGtyOjByHVcuCzGniPjCxQmEI/XYBB+fO+0ftoOd52r6
	kITJfqsfSdGSyAmenmeqF+Am1eGxHjg6nh7CUNlFKyb7dfs9w8RKBmlZ+x3Ph/wyeGRqyu5STYM9H
	0OFO+y/flDB9Np3xa+jIseXnBZ01CILGL98LPeU1cgiJyjFaqCMsCB7uK/RNiAONNsyJt1Uw47AFW
	TyDwtTrw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1MG4-0000000DB3g-1DwZ;
	Wed, 24 Sep 2025 09:57:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 23F8130043D; Wed, 24 Sep 2025 11:57:55 +0200 (CEST)
Date: Wed, 24 Sep 2025 11:57:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC PATCH v2 00/17] objtool: Function validation tracing
Message-ID: <20250924095755.GY3245006@noisy.programming.kicks-ass.net>
References: <20250619145659.1377970-1-alexandre.chartre@oracle.com>
 <20250924073649.GT4067720@noisy.programming.kicks-ass.net>
 <20250924091751.GX4068168@noisy.programming.kicks-ass.net>
 <4c4afe3e-ac24-4891-9acd-1d493ea88eca@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c4afe3e-ac24-4891-9acd-1d493ea88eca@oracle.com>

On Wed, Sep 24, 2025 at 11:50:25AM +0200, Alexandre Chartre wrote:
> 
> On 9/24/25 11:17, Peter Zijlstra wrote:
> > On Wed, Sep 24, 2025 at 09:36:49AM +0200, Peter Zijlstra wrote:
> > 
> > > >                        | <alternative.65c4e> alt 1/4 end
> > > >   65c4e: os_xsave+0x2e | <alternative.65c4e> alt 2/4 begin
> > > >   1c3d: .altinstr_replacement+0x1c3d | | xsaves64 0x40(%rbp)
> > > >   65c53: os_xsave+0x33 | | xor %ebx,%ebx
> > > >   65c55: os_xsave+0x35 | | test %ebx,%ebx - already visited
> > > >                        | <alternative.65c4e> alt 2/4 end
> > > >   65c4e: os_xsave+0x2e | <alternative.65c4e> alt 3/4 begin
> > > >   1c38: .altinstr_replacement+0x1c38 | | xsavec64 0x40(%rbp)
> > > >   65c53: os_xsave+0x33 | | xor %ebx,%ebx - already visited
> > > >                        | <alternative.65c4e> alt 3/4 end
> > > >   65c4e: os_xsave+0x2e | <alternative.65c4e> alt 4/4 begin
> > > >   1c33: .altinstr_replacement+0x1c33 | | xsaveopt64 0x40(%rbp)
> > > >   65c53: os_xsave+0x33 | | xor %ebx,%ebx - already visited
> > > >                        | <alternative.65c4e> alt 4/4 end
> > > >   65c4e: os_xsave+0x2e | <alternative.65c4e> alt default
> > > >   65c4e: os_xsave+0x2e | xsave64 0x40(%rbp)
> > > >   65c53: os_xsave+0x33 | xor %ebx,%ebx - already visited
> > > 
> > > I find it *very* hard to read these alternatives. If at all possible, I
> > > think something like:
> > > 
> > >     65c4e: os_xsave+0x2e | xsave64	| xsaveopt64	| xsavec64	| xsaves64
> > >     65c53: os_xsave+0x33 | xor %ebx,%ebx
> > > 
> > > Would be *much* easier to follow
> > 
> > Another option is to write it source-like:
> > 
> >    65c4e: os_xsave+0x2e | ALTERNATIVE("xsave64",
> >                                       "xsaveopt64", X86_FEATURE_XSAVEOPT,
> > 				     "xsavec64", X86_FEATURE_XSAVEC,
> > 				     "xsaves64", X86_FEATURE_XSAVES);
> >    65c53: os_xsave+0x33 | xor %ebx,%ebx
> > 
> > 
> > We have the 'feature' bit, we'd just have to 'borrow' the feature
> > strings from the kernel I suppose.
> 
> Yes, that would be very useful. But I will probably look at it for a next
> set of patches.

Yes, like I said, I don't think we need to hold up the current set for
this. But given how I struggle to read that alternative stuff, I figured
we should explore alternatives :-)

