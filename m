Return-Path: <linux-kernel+bounces-876311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A40C1B4BD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64E514FAAA1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D83221ADCB;
	Wed, 29 Oct 2025 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QUFdntHA"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604D4548EE
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746759; cv=none; b=iaNaHE2mbkzqLw+BcGiNjDnCypBL2q6oIzLPmIesfxYhB+GRArwt92+gNCMSvu7xi2KBd+VStlO+u2V5+QYPCoLZNeYx2idATl+lHbHjydER1W9DLoBPEClUykRfEjGjI3+Rr0hyLlHLdzRTWEU2Z04G0L1an/3v5tnwEpmLLTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746759; c=relaxed/simple;
	bh=DWCrM1Ytk1tC3uuBqVJX9sbTQMqpdl1IvPI6L250DRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJ1ZLLYXdUUIN8yXMsTjbGIbooDGrMXItj7hxMcMwV5K2MwdCE2CwJFsH1pnykG6BG2JbqqFn2+tpsXknIOLiI6kebH5urRh8szVvDLN4f8D+l6csar1AqTSH18bFcZYiwvNgOplk99c7e6X6pHZw2uiH01j1DVKY5terP8Bvzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QUFdntHA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uelsE65wcEyLfySQ2NZ8ihLF6jYLevz72XHXI9bbYVw=; b=QUFdntHAhiCBPW99UUTHkIdKwd
	Z7a26uFmQcVO0Q9omqyeCyRAY55Izt2rs71bUhEO7w/ZChVWlR+7Qa8tXIFvMhGHAFe0qkSLmAgpI
	VeX42hZxRS2ryv+NK+a6Kk6DSiFtTeXVHQzIxd5eGskf6301cNDiiCpjr0jAvn/T6v3zmrE2oKcX3
	rPsHhptd0Kfk0YDo2rHFTFsdUx16uqgCtkUPFY67KKaz90l/rEP20Z80TB5Qgll608DVJyGZt6Sqv
	1SVRmTji1hSLzYiCIJh+2b022iuaoGn7ZjEQlCJzJv6cQd0Yba58ZJJvyoAIUkA8KglN1ypasvmua
	jsCxNbNw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE6oB-0000000CM9w-0xBK;
	Wed, 29 Oct 2025 14:05:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5B8E7300289; Wed, 29 Oct 2025 15:05:51 +0100 (CET)
Date: Wed, 29 Oct 2025 15:05:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: odd objtool 'unreachable instruction' warning
Message-ID: <20251029140551.GE4067720@noisy.programming.kicks-ass.net>
References: <CAHk-=wi6goUT36sR8GE47_P-aVrd5g38=VTRHpktWARbyE-0ow@mail.gmail.com>
 <20251029095638.06cce7c7@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029095638.06cce7c7@pumpkin>

On Wed, Oct 29, 2025 at 09:56:38AM +0000, David Laight wrote:
> On Tue, 28 Oct 2025 12:29:11 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > Josh, Peter,
> >  due to another entirely unrelated discussion, I ended up resurrecting
> > my "make asm readable" patch that I have had in my local tree when I
> > want to look at the actual generated code for user accesses.
> > 
> > That is a local hack that just removes the alternative noise for the
> > common ops, so that I actually see the fences and clac/stac
> > instructions as such, instead of seeing them as nops in the object
> > file or as horrible noise in the assembler output.
> 
> I've toyed with using explicit nop sequences that would be identifiable
> as stac, clac and lfence.
> 
> At least that would tell you which is which.
> 
> Since the flags can be trashed there are plenty to choose from.
> (eg all the cmpb $n,%reg if you don't mind a false dependency.)

things like:

	mov %reg, %reg

are 3 bytes on x86_64 and otherwise unused, since the canonical NOP for
>=3 bytes is NOPL.

So if you do something like:

	mov %rax, %rax -- stac
	mov %rcx, %rcx -- clac

that should be readily recognisable. Trouble is, this doesn't readily
work for 32bit, so you'll need to complicate the code to pick different
NOPs there. I suppose you can CS-prefix stuff the same MOVs, like:

	cs mov %eax, %eax
	cs mov %ecx, %ecx


