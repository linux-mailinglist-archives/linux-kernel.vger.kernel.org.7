Return-Path: <linux-kernel+bounces-863422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F2EBF7D80
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B9F08354B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38567345749;
	Tue, 21 Oct 2025 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sl9mtHQh"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9754238C03
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067136; cv=none; b=uccH+7X1vUcEOy0QCRAHbUXyycbCZdzBB5VOwrVxSKm9YijZ/WwaKcPcLxyJC8RxKUY+p03bYdAL/e1FkZmiqqpFHplKcHjCRGO0Loe2e9UeOMMV6qC1M6v3dLmfpUlNSTPIKHYrWZwK0IsZjt76RRQUiWsEmXicDAFGDFHg7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067136; c=relaxed/simple;
	bh=eL7TuZ4q41LX6EtwEGRgSAoGxjZUyPAyEG1F+Tq/uxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCoCsTXXzdWUcDaRNweV6IHa6D+LrjW25wt/FjHL/VC+gOXgMinBLB3b89DkJUvLm0oDBX5SzsbYGNo9Kr1sZ49I9pddRllNNcT/RNMqihLeLd807+uIngWwLcpVvDjMdVhupjxKN/VUKxm6ePzinG6KDnfLG+t12ZqeBxWY0uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sl9mtHQh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ro3QuI5vKGv9I7xOexxSK9c5TqlJdJviaSMrsULWAPU=; b=sl9mtHQhY7syEElMnGszPO9CCq
	aTTj1zqK9XfGzkXCcNFkg9E14c3/96JemOXkPGr5Kpx8Rkts8pRrbkz2wNsUv2vkWXEvf5Is6G8FO
	+3hZtJ72oa6SAJPcx10aC5LkedLEV/9lEblfPDKIH3zhDs6Q/alXv9s3m/XRDa0+79PkBLgLWE6BK
	bg6j6/TnMH6WcWMD3qjpniJ6ELSfW76n61j8+tXzl9WgFVTJl7crywamTYN9Soj4nO9kbyOqh8KR6
	ad0xYryoy5xHw03eqtmA2NgFLNHuzzznqig/odBzxe1RYnpOo3RqaTcuv/BRGkNpt+u5twoj1bKCE
	bMwriS8w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0X-0000000DsJr-0Meb;
	Tue, 21 Oct 2025 17:18:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9F49E302D3E; Mon, 20 Oct 2025 12:39:40 +0200 (CEST)
Date: Mon, 20 Oct 2025 12:39:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: jpoimboe@kernel.org, rostedt@kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>, linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 11/12] unwind: Implement compat fp unwind
Message-ID: <20251020103940.GP3419281@noisy.programming.kicks-ass.net>
References: <20250924075948.579302904@infradead.org>
 <20250924080119.613695709@infradead.org>
 <bd9bac99-208c-426d-b828-e23188d93226@linux.ibm.com>
 <cc6f34bb-7d05-4260-bc02-299fef2bcb01@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc6f34bb-7d05-4260-bc02-299fef2bcb01@linux.ibm.com>

On Mon, Oct 20, 2025 at 11:16:45AM +0200, Jens Remus wrote:
> Hello Peter!
> 
> On 10/17/2025 5:47 PM, Jens Remus wrote:
> > while rebasing the unwind user sframe series on top of this series and
> > https://lore.kernel.org/linux-trace-kernel/20251007214008.080852573@kernel.org/
> > I ran into the following issue:
> > 
> > On 9/24/2025 9:59 AM, Peter Zijlstra wrote:
> > 
> >> --- a/include/linux/unwind_user_types.h
> >> +++ b/include/linux/unwind_user_types.h
> >> @@ -36,6 +36,7 @@ struct unwind_user_state {
> >>  	unsigned long				ip;
> >>  	unsigned long				sp;
> >>  	unsigned long				fp;
> >> +	unsigned int				ws;
> > 
> > Factoring out the word size (ws) from the CFA, FP, and RA offsets is
> > clever.  Wondering though whether that would be an issue for unwind user
> > sframe.  Do all architectures guarantee that those offsets are aligned
> > to the native word size?
> > 
> >>  	enum unwind_user_type			current_type;
> >>  	unsigned int				available_types;
> >>  	bool					done;
> > 
> >> --- a/kernel/unwind/user.c
> >> +++ b/kernel/unwind/user.c
> > 
> >> @@ -29,21 +44,21 @@ static int unwind_user_next_fp(struct un
> >>  	}
> >>  
> >>  	/* Get the Canonical Frame Address (CFA) */
> >> -	cfa += frame->cfa_off;
> >> +	cfa += state->ws * frame->cfa_off;
> > 
> > In SFrame the CFA, FP, and RA offsets are unscaled.  Would it be ok, if
> > unwind user sframe would factor state->ws from those offset values?  What
> > if they were not aligned?  unwind user sframe would then have to fail.
> 
> Sorry that I did not immediately think about the most obvious solution
> tho above issues:  to not factor out the word size from the frame CFA,
> FP, and RA offsets.  What do you think about making the following
> changes to this and giyour subsequent patch?  That would work nicely
> with unwind user sframe.


Yes, this should do nicely. I've made the changes, I'll do a test build
and then push out to the robots.

Thanks!

