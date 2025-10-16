Return-Path: <linux-kernel+bounces-856320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C41EDBE3DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2EE19C5287
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F355B339B31;
	Thu, 16 Oct 2025 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M20aTFkN"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41131D5CE8
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760623668; cv=none; b=e3/pJxlJCnRjXFPQAovN8E/wfmiSYZGHB5xuSBIxPkxqQnqGdLtoeYOq/I3E8END/Xyjwv7mqc+OotE1htqSTpGcaiFutsO8EysFNzYBsDYx55bLz1VJM18IP5eB1cUkMCgZ03HwYuS95Lr9Ks15IRCiLuUG2ZxzQRuB5Ne/q88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760623668; c=relaxed/simple;
	bh=Jz1p2BQoc3FFImSrVshIrOAxntuYO0BxgmhqUh2NGaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evsnRwAJDhPsc/GmT2+nawB7Ka/8jtNQ5rlfU0AknOiJlmdLil2nVXBoCzmjNErN5IgIW7Qf77ctu8qkFyJwW2do90RKC5CvmceJU5c/LXGzIdg8h9KUvs2cWVjsZ5dIIhS+dBeQSOjgwXMBufLCEflgHRcj2pNLrQ1F0app/gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M20aTFkN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ihjj8HRliWmSUM97YqVHVQpdMKtmLySBdNzRQ6Z4gC4=; b=M20aTFkNeKCqDIarC3eTHxqmXM
	ryG1BVW+5r7A+ksczyxlDWV4xgl+4k491eFOxovtbfCOKd9jZSPCHErd4SXn/rQBMnqcLNwMQCiNF
	bTxceNr0Wk0DjKiE11hyxd8kHSAo3yw2nzfViw0KawbF6AVMUGmDq8qVSQUZKs/Gn+jvc0aTFXMfZ
	let2A+UCMJ1dsx9tL52xqQoMuDGxfNcU4UmEieO+v4BsbCaOKZuOi4fY5eWViZDeLS0HEfvG+A6D2
	kbd4bFBJ6LYfvROQovNF8XUTj5hTRLU2c6WL87LfBEmTEbV0OIJoY3k+BK3vOELbkw1Fgm1MbZerA
	hTIHqB+w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9Odf-00000005NaI-17sE;
	Thu, 16 Oct 2025 14:07:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 757DD30023C; Thu, 16 Oct 2025 16:07:31 +0200 (CEST)
Date: Thu, 16 Oct 2025 16:07:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 31/56] x86/alternative: Prepend nops with retpolines
Message-ID: <20251016140731.GS4067720@noisy.programming.kicks-ass.net>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-32-david.kaplan@amd.com>
 <20251016110717.GE3289052@noisy.programming.kicks-ass.net>
 <20251016112327.GQ1386988@noisy.programming.kicks-ass.net>
 <DS0PR12MB92738D3C38021EE0B693326994E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR12MB92738D3C38021EE0B693326994E9A@DS0PR12MB9273.namprd12.prod.outlook.com>

On Thu, Oct 16, 2025 at 01:27:53PM +0000, Kaplan, David wrote:

> > Ah, I found it, you freeze everything, which puts it at safe points.
> 
> Yes.  In fact, I think you were the one who pointed me in that direction :)

Heh, yeah, I remembered talking to you about this, but had forgotten all
details. I quickly checked the cover letter, but found insufficient
detail there, so I went and asked. Then later memory started coming back
and I went looking for it in later patches.

> Despite the freezer though, this patch is necessary in particular
> because stop_machine_nmi() uses an indirect branch to run the handler.
> Which means that while patching is going on, all cores are inside a
> function which is going to return to after the indirect call site.
> And so that needs to be the end of the 5 (or 6) byte sequence.

Yeah, makes sense. But I like I wrote, I think prefix stuffing might be
a better option.

