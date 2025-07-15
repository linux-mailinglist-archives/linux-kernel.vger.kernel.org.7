Return-Path: <linux-kernel+bounces-731493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C21CB05526
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A364A6CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2577B275118;
	Tue, 15 Jul 2025 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P80H432C"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9D6157493
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568852; cv=none; b=HD7ARVNyySnVRiV08yjBbAuGJL+XRvsJeq+fJN/QCHuqi+q3OvXEz87jm697Wol0+6yH54FG/6/zIHBmU3iSr81mqKKlv1cNSGm+IYuCbzCeSqj2fjifTF65yzskydLVPP/anqX3XSUIlhv4io1dwRHvHqFKrYVl2+WCXVu5W4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568852; c=relaxed/simple;
	bh=IbM+eUjzHCYDt0mwG9cAosSZhoRTho08UIqSvtUjti0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzNJ5hRMipaKUS6hqsnDFCCtdMY5/N49I5lZK+im+G1IOaW1eWL9R6l/TViFoU+nBOF4lzkdM4P97o62oxeaNfVIQLD/khypOGKP6UEI8erlJKW+8YY/2OAv95rhClVrWeZplCKMM6AoCXJGnlTn+GAGiOSy06507Hv8jZQDUO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P80H432C; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=28ph/RzSy25ewBI0wqF/jCQTm9yjZs8CnD+4nyCq5TA=; b=P80H432CdGRjzFxiqKPZYRSj+r
	OFDnjlZezbom+fNf5FBgF6ztat+/p6acfDUXJ3bHBNDFvUUGwrXemJvq/aWxIeW77aBhnAgxkZ1sE
	51kFINAxfLcRVodoBx44YJxdUu4iliTJ1dtWiMh08R+DoG0AlWTaxLZ7EKtpjl6PspOl2KuXdoIQ2
	pqCcXYQVer7nPkX+t3tnma32FMOhW8ceWxXXMAbATNDXuXwR2ARsBsnv4Oyf6SB31WefGkuP2I4Db
	3f1aKr/mz78psn5GeLvhL27+5R3y1qSpYzjbYs7keLG/0nFTZQ7Qbzra0kZ6H4AmBzFjFMfgse90l
	SSlljuKg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubbDH-0000000Bb0Y-1gmW;
	Tue, 15 Jul 2025 08:40:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 306553001AA; Tue, 15 Jul 2025 10:40:34 +0200 (CEST)
Date: Tue, 15 Jul 2025 10:40:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Xin Li <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, jmill@asu.edu,
	andrew.cooper3@citrix.com
Subject: Re: [PATCH v1 1/1] x86/fred: Remove ENDBR64 from FRED entry points
Message-ID: <20250715084034.GO1613200@noisy.programming.kicks-ass.net>
References: <20250715064437.807569-1-xin@zytor.com>
 <bb77f5f9-231a-4640-91b7-bca42e9654f3@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb77f5f9-231a-4640-91b7-bca42e9654f3@zytor.com>

On Mon, Jul 14, 2025 at 11:50:57PM -0700, Xin Li wrote:
> On 7/14/2025 11:44 PM, Xin Li (Intel) wrote:
> > The FRED specification v9.0 states that there is no need for FRED
> > event handlers to begin with ENDBR64, because in the presence of
> > supervisor indirect branch tracking, FRED event delivery does not
> > enter the WAIT_FOR_ENDBRANCH state.
> > 
> > As a result, remove ENDBR64 from FRED entry points.
> > 
> > Then add ANNOTATE_NOENDBR to indicate that FRED entry points will
> > never be used for indirect calls to suppress an objtool warning.
> > 
> > This change implies that any indirect CALL/JMP to FRED entry points
> > causes #CP in the presence of supervisor indirect branch tracking.
> > 
> > Credit goes to Jennifer Miller <jmill@asu.edu> and other contributors
> > from Arizona State University whose work led to this change.
> > 
> > Link: https://lore.kernel.org/linux-hardening/Z60NwR4w%2F28Z7XUa@ubun/
> > Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> > Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> > Cc: Jennifer Miller <jmill@asu.edu>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> 
> Sorry, forgot to put CC stable.

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")

Right?

> 
> > ---
> >   arch/x86/entry/entry_64_fred.S | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
> > index 29c5c32c16c3..907bd233c6c1 100644
> > --- a/arch/x86/entry/entry_64_fred.S
> > +++ b/arch/x86/entry/entry_64_fred.S
> > @@ -16,7 +16,7 @@
> >   .macro FRED_ENTER
> >   	UNWIND_HINT_END_OF_STACK
> > -	ENDBR
> > +	ANNOTATE_NOENDBR
> >   	PUSH_AND_CLEAR_REGS
> >   	movq	%rsp, %rdi	/* %rdi -> pt_regs */
> >   .endm
> 

