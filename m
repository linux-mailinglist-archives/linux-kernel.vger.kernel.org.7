Return-Path: <linux-kernel+bounces-770729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D183B27E47
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0011416F06B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8BB23956A;
	Fri, 15 Aug 2025 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b9ueQWk/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A582279788
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253861; cv=none; b=SRTGTHRjr4wgkjsz3cU2T8QfajFNloANVXpTNeX3KZoH7xqK1m4Pw8k47NbVk1lBp/+bHGKyxmaghVvu+fwgzHLqFYXCR2xpFEiBtuJ7q75ndVXJbeRHHsNsok7L7lupdnj2LoQYpjnU7cSaM48N9XhvxDMZbc/xDPKCIolsm+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253861; c=relaxed/simple;
	bh=8Zho9W9mjH3VRv/uqFPx0jWzohoX0UEZCoz8IDn7o/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEnUVml5JzwHxbn0WvqbPvi/sVVCPbFP6SS7URUlQ/SdQvvX4hrpZSbBYJgU6B7GA3cMN+XekvtAUt9xP1Kt9c67J1Xn+KAai3E6uixZ/BH+pPmGILYNoDZk1xF8FhRTkEbHtpPNrKA4bBKAtasFGZQEh04C2Y+jOtvr8mV2WZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b9ueQWk/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YST5mFlMzRQ1Dyw5VZzGJhlspjKG9SDS5kg8mQIxDK8=; b=b9ueQWk/HrCcXzas5+/EejGzev
	RG2PM1On1jvN8lOrh9U7/n4HuyAqDdY1kFFImWsCf+c+u0KEJfQdobnFVrCQSDOI6pZP1acp8XvHO
	QKfGZUe8oov+yzhrleJYa/TKgNH3ZY6K2xEtjBT7iNvjutZYCN3mvkcCJv76vh01g0H687KFViY16
	wsUzAS3LgJV8VKqf3nFQxeGhCLA06Aem4UP9T7G11Q+vmuWgl3LMnGLzln3zysVAAVx6S1xEcPrgD
	/HqMs+CtshMNOdxFB+jTWeLLGdTaJ4Sw1tT7jVPTKKPA7pwnO+ELSyxw2oZ8uG3hPfIfxDFLG5igv
	lXZOKa+A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umri2-0000000BV79-3jWK;
	Fri, 15 Aug 2025 10:30:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1C72D3002ED; Fri, 15 Aug 2025 12:30:55 +0200 (CEST)
Date: Fri, 15 Aug 2025 12:30:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, kees@kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, samitolvanen@google.com,
	nathan@kernel.org, alexei.starovoitov@gmail.com,
	mhiramat@kernel.org, ojeda@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] x86,ibt: Use UDB instead of 0xEA
Message-ID: <20250815103055.GE4068168@noisy.programming.kicks-ass.net>
References: <20250814111732.GW4067720@noisy.programming.kicks-ass.net>
 <2c121572-8fde-4288-80ca-ab79f2b22cce@zytor.com>
 <20250815074939.GA3419281@noisy.programming.kicks-ass.net>
 <20250815102839.GD4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815102839.GD4068168@noisy.programming.kicks-ass.net>

On Fri, Aug 15, 2025 at 12:28:39PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 15, 2025 at 09:49:39AM +0200, Peter Zijlstra wrote:
> > On Thu, Aug 14, 2025 at 06:27:44PM -0700, H. Peter Anvin wrote:
> > > On 2025-08-14 04:17, Peter Zijlstra wrote:
> > > > Hi!
> > > > 
> > > > A while ago FineIBT started using the instruction 0xEA to generate #UD.
> > > > All existing parts will generate #UD in 64bit mode on that instruction.
> > > > 
> > > > However; Intel/AMD have not blessed using this instruction, it is on
> > > > their 'reserved' list for future use.
> > > > 
> > > > Peter Anvin worked the committees and got use of 0xD6 blessed, and it
> > > > will be called UDB (per the next SDM or so).
> > > > 
> > > > Reworking the FineIBT code to use UDB wasn't entirely trivial, and I've
> > > > had to switch the hash register to EAX in order to free up some bytes.
> > > > 
> > > > Per the x86_64 ABI, EAX is used to pass the number of vector registers
> > > > for varargs -- something that should not happen in the kernel. More so,
> > > > we build with -mskip-rax-setup, which should leave EAX completely unused
> > > > in the calling convention.
> > > > 
> > > > The code boots and passes the LKDTM CFI_FORWARD_PROTO test for various
> > > > combinations (non exhaustive so far).
> > > > 
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > 
> > > Looks good to me (and using %eax will save one byte per call site as
> > > well), but as per our IRC discussion, *my understanding* is that the
> > > best possible performance (least branch predictor impact across
> > > implementations) is to use a forward branch with a 2E prefix (jcc,pn in
> > > GAS syntax) rather than a reverse branch, if space allows.
> > 
> > Oh right. I did see that comment on IRC and them promptly forgot about
> > it again :/ I'll have a poke. Scott, do you agree? You being responsible
> > for the backward jump and such.
> 
> On top of the other, to show the delta.
> 
> If we want a fwd branch, we can stick the D6 in the endbr poison nop.
> That frees up more bytes again, but also that matches what I already did
> for the bhi1 case, so less special cases is more better.
> 
> I've had to use cs prefixed jcc.d32, because our older toolchains don't
> like the ,pn notation.

And then I forgot to move that cs prefix around in the bhi1 case...
fixed that.

