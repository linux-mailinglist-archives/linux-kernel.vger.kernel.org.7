Return-Path: <linux-kernel+bounces-832166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C765B9E890
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA484A4227
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAFB2877C5;
	Thu, 25 Sep 2025 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q4SO6594"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC2502BE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794611; cv=none; b=Tii+1SydR/X4gLLO/q5Okwy+fmHYHVbnvOR5fmIyAs31VWCJOGMuWDCs+oEOP+5ylRjRV6nehHRA/76r3mBRTzum+awoZ/MKsHZDR7ZQaPguJD55MsB16MD9MAV3+lsaBSATuR8I8uanGEu0oB2PJxRFrHo+H6dpVEIH98EhVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794611; c=relaxed/simple;
	bh=qXBHDSAjV+tln5KtEYGzzsvI1nzgEdoaP4mfzWJd+GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5HNmAsfBZmKx54k6M9w7NxXdDAsl7CLkUZ94Jsr/EpqOj7oek4ywA0gPe3wAUQuv4IM7uY6ujlMUpkUCMHpEbN9/SJNLVNArzP2deZCR7Cglj2NacxDV1hUkrP93nD8LZ3N5gQp8E5bw39CYkAJlEF8fzJIc0aEoYeAK56SEF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q4SO6594; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SUb9FI4q+NT5ocTcPergGuwEC4PTY7k/Skc4CI1VRTs=; b=q4SO6594rCO5a9mOpVt5rM+ByA
	1NSfaVLOfC6hzBgijP9x3daLJIGwygC2Hf3gdBoSIRIRFDN2YPUMCq+lSjfWtsrxv5Fi785k+3VJK
	LgylPjIc/ISbDWDZacFgYuCPL3LJrur/U7I9+fr26Wt6W+bRyeUCfa4L4UXaHblU2eVpqN+DZXDcp
	2QTY0OcMLS1AOyCbi19krOnPYprRGC6nsXAtOAgde0Wgqfe69tP/lzbbk++4y1IXu0Hp4ROttGU4T
	1g+h6KvIWcL6HzalSbLGQOX5I2DlO8jl/7AgSQOu9jYcTNtVjQ8ObzQ5Q9L5k6VLnWHoSeTY9UxLo
	7wvDy48Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1iou-00000001Q05-0BDc;
	Thu, 25 Sep 2025 10:03:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 732663002BF; Thu, 25 Sep 2025 12:03:23 +0200 (CEST)
Date: Thu, 25 Sep 2025 12:03:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: jpoimboe@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] objtool/x86: Fix NOP decode
Message-ID: <20250925100323.GY4067720@noisy.programming.kicks-ass.net>
References: <20250924134507.288529132@infradead.org>
 <20250924134644.154610650@infradead.org>
 <b6aaa53d-2658-491a-9308-32ae2b5aefb1@oracle.com>
 <20250924184158.GZ3245006@noisy.programming.kicks-ass.net>
 <f17d5e92-2aaa-43e7-ba67-ea5e7d07601a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f17d5e92-2aaa-43e7-ba67-ea5e7d07601a@oracle.com>

On Thu, Sep 25, 2025 at 11:55:23AM +0200, Alexandre Chartre wrote:
> 
> On 9/24/25 20:41, Peter Zijlstra wrote:
> > On Wed, Sep 24, 2025 at 07:34:00PM +0200, Alexandre Chartre wrote:
> > > 
> > > On 9/24/25 15:45, Peter Zijlstra wrote:
> > > > For x86_64 the kernel consistently uses 2 instructions for all NOPs:
> > > > 
> > > >     90       - NOP
> > > >     0f 1f /0 - NOPL
> > > > 
> > > > 
> > > > Notably:
> > > > 
> > > >    - REP NOP is PAUSE, not a NOP instruction.
> > > > 
> > > >    - 0f {0c...0f} is reserved space,
> > > >      except for 0f 0d /1, which is PREFETCHW, not a NOP.
> > > > 
> > > >    - 0f {19,1c...1f} is reserved space,
> > > >      except for 0f 1f /0, which is NOPL.
> > > > 
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > ---
> > > >    tools/objtool/arch/x86/decode.c |   12 +++++++-----
> > > >    1 file changed, 7 insertions(+), 5 deletions(-)
> > > > 
> > > > --- a/tools/objtool/arch/x86/decode.c
> > > > +++ b/tools/objtool/arch/x86/decode.c
> > > > @@ -494,7 +494,8 @@ int arch_decode_instruction(struct objto
> > > >    		break;
> > > >    	case 0x90:
> > > > +		if (prefix != 0xf3) /* REP NOP := PAUSE */
> > > > +			insn->type = INSN_NOP;
> > > >    		break;
> > > 
> > > So this covers NOP1 (0x90) and NOP2 (0x66 0x90), right?
> > 
> > Yes. Everything with opcode 0x90, except 0xf3 0x90, which as stated is
> > PAUSE.
> > 
> 
> What about 0x49 0x90, which is xchg (XCHG r8,rAX) ?

Ooh, that is a nice one. Yes, that needs fixing. Thanks!

