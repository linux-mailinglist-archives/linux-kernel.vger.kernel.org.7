Return-Path: <linux-kernel+bounces-797239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B9EB40DDA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F4F1B2828C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D783F1C68F;
	Tue,  2 Sep 2025 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r1qb2g+W"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF49350D68
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756841176; cv=none; b=XnKvL1zrxoT+Z2aNxUeAJ5KMCDgtXMLqqEEegubr3ul/p5vW8VmErq5vtCxfW5SxbtKiLiKuycgVfSWFldO6uE1YblVDYZZK0PZWWavLam4bIOfuA7t2YkED53Hp3qk0/VAU4JGlJGg1xK3F9W3enMf5yQfhIz9nZKPObo4tSs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756841176; c=relaxed/simple;
	bh=KjuJyrSCoNSSRHY9clm6zU1uQTB4k9z2+CpEzXExFIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCz8H6H+AwV3bfHYWEcf54Ujrlph0b5748OxPJJPWvY4Uzqml5FpsWdV0hCiF1m+h+nCIPV4h0xBA0QFLV8Y9t36IMa034mDJaSHmXiOTuJ6YMBkanNbS+JbU6ToR8oNckIH3gDl6tBF7xDIhcn0DrKrZHYlPPt6Dm11pABQpZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r1qb2g+W; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=jm4Az4/MaRFgMQBnu6DDk2Z9i2UG2i//oaifjDwkF1s=; b=r1qb2g+W/w0dnZozlX+gOt94C8
	Uosru8VrOA33TEbRXC462kh58jwXl6RCmnFMi2pATLc/C2zSPfgmMj3MXZsViy+SNibGDUOx/VJO2
	8a3aqO4A8G3qYuaSUiRnVTgl2L+8Z9SmZjSwh9baOk6oe33S6VFLKpQp2tRdSSBgV+cWq6c3FEc/X
	MlYDRgVXr8Fxoae9ksr0t2Mp8SHtVquPQ3PEDgfoQ5mbtHULFday3xUwj8B8fBO9+gq/YGSpSoHVa
	tH+kLAucxSxZO2q8HbUmXrdajS86DeNXUMVYKRuTwLpD6tvHDgqfUw+FFpMuKq4F5TU0K/V7XSMXI
	JDuWoruw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utWdt-0000000AZsZ-3Hm2;
	Tue, 02 Sep 2025 19:26:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3895930039F; Tue, 02 Sep 2025 21:26:09 +0200 (CEST)
Date: Tue, 2 Sep 2025 21:26:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, Joao Moreira <joao@overdrivepizza.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, ojeda@kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86,ibt: Use UDB instead of 0xEA
Message-ID: <20250902192609.GL3245006@noisy.programming.kicks-ass.net>
References: <20250901191307.GI4067720@noisy.programming.kicks-ass.net>
 <20250902081915.GK3245006@noisy.programming.kicks-ass.net>
 <CAADnVQJ2zm7BRb3SuwcmCQ5SBULznbUq777vMCHkm9UbPkaAbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ2zm7BRb3SuwcmCQ5SBULznbUq777vMCHkm9UbPkaAbQ@mail.gmail.com>

On Tue, Sep 02, 2025 at 09:04:51AM -0700, Alexei Starovoitov wrote:
> On Tue, Sep 2, 2025 at 1:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> >
> > Because this is all somewhat magical code, and this change is a little
> > on the large side, it as been suggested I 'upgrade' the Changelog some.
> >
> > On Mon, Sep 01, 2025 at 09:13:07PM +0200, Peter Zijlstra wrote:
> > >
> > > A while ago [0] FineIBT started using the 0xEA instruction to raise #UD.
> > > All existing parts will generate #UD in 64bit mode on that instruction.
> > >
> > > However; Intel/AMD have not blessed using this instruction, it is on
> > > their 'reserved' opcode list for future use.
> > >
> > > Peter Anvin worked the committees and got use of 0xD6 blessed, it
> > > shall be called UDB (per the next SDM or so), and it being a single
> > > byte instruction is easy to slip into a single byte immediate -- as
> > > is done by this very patch.
> > >
> > > Reworking the FineIBT code to use UDB wasn't entirely trivial. Notably
> > > the FineIBT-BHI1 case ran out of bytes. In order to condense the
> > > encoding some it was required to move the hash register from R10D to
> > > EAX (thanks hpa!).
> > >
> > > Per the x86_64 ABI, RAX is used to pass the number of vector registers
> > > for vararg function calls -- something that should not happen in the
> > > kernel. More so, the kernel is built with -mskip-rax-setup, which
> > > should leave RAX completely unused, allowing its re-use.
> >
> >  [ For BPF; while the bpf2bpf tail-call uses RAX in its calling
> >    convention, that does not use CFI and is unaffected. Only the
> >    'regular' C->BPF transition is covered by CFI. ]
> 
> I cannot comprehend the new scheme, but thanks for heads up.

Anywhere in particular you're getting stuck? That is, where should I
improve the comments / changelog?

