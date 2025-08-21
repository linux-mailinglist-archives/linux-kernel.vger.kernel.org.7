Return-Path: <linux-kernel+bounces-779786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0488CB2F8DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C77607A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F07F31B112;
	Thu, 21 Aug 2025 12:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e1UB2SAB"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC4431A049
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780431; cv=none; b=CFjN60RknUOtt4JddLknTRAp0LX9IJB8N99blL2giXvwtqI2Nm5ea1xs0X720SO4ZivIqrUMmmnaMYsZBHU4UPmkJkOtgyWjfuCK5b+bstlnXZRJTXKe+5ALrVVjjlnhTSUjPv5pAoSTBZtZezz7kgGzo6t+zMSF512P52oZXdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780431; c=relaxed/simple;
	bh=kOg13v+onhuGuxW4803UZ6u3K33G+5yvxevRUzFVDpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PA11SK24X9okNmeqZRMAkMM/RdlhQrOsJHdSedap1gII+D3SyMnhlMcGDbzeUeKaZ6c+VPG2DmLd8uBUPkdMgpq+st91S/soZCOksyFRdkEBnhm7RbxP5kflZruCsXittIsD8SK1BTuFnVUZ6F4aayt7AHCOLEfdEqsa6e7Xj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e1UB2SAB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m2HSFc8Nh7kp8IpGRpCETSqySyj+cxKt6+J+l+bvbEM=; b=e1UB2SABn+kbINgZd7o1CPs/HZ
	RzgtHNWwfjE5KM7fieXBrDZCYp2o2pq19JBVB1CvlU4ZAmXHUaGQLGtka41ob07fBI/60nIwNfYU2
	XAeXNokzo6LMzpK6CFGAtTbSjHM+aueQq8Larm7dgT/xpDzsFcarkNNJJ7/hivCX42NhNWmwgTxGU
	S//JbWKdjTxNALlbAQU/5pb6qiRD+3AHqNAhWcBKxz9YXQER0XoimEQJFy9DbqNM0IKtdy2Yq6skz
	zRHu5BcqUDy2OcXVSLrPv1wldSTE6UIMD9aH87LiMY/85IgAZNI6MnwTZyvyCavLqaYt2DSLd0WUI
	jZQbtJVQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up4h0-00000007BD8-3iRD;
	Thu, 21 Aug 2025 12:46:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0B3413002ED; Thu, 21 Aug 2025 14:46:59 +0200 (CEST)
Date: Thu, 21 Aug 2025 14:46:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Marcos Del Sol Vives <marcos@orca.pet>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
	Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Kees Cook <kees@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Oleg Nesterov <oleg@redhat.com>, "Xin Li (Intel)" <xin@zytor.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Subject: Re: [PATCH] x86: add hintable NOPs emulation
Message-ID: <20250821124659.GO3289052@noisy.programming.kicks-ass.net>
References: <20250820013452.495481-1-marcos@orca.pet>
 <20250820090733.GJ3245006@noisy.programming.kicks-ass.net>
 <20250821132807.0a898dfa@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821132807.0a898dfa@pumpkin>

On Thu, Aug 21, 2025 at 01:28:07PM +0100, David Laight wrote:
> On Wed, 20 Aug 2025 11:07:33 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Aug 20, 2025 at 03:34:46AM +0200, Marcos Del Sol Vives wrote:
> > > Hintable NOPs are a series of instructions introduced by Intel with the
> > > Pentium Pro (i686), and described in US patent US5701442A.
> > > 
> > > These instructions were reserved to allow backwards-compatible changes
> > > in the instruction set possible, by having old processors treat them as
> > > variable-length NOPs, while having other semantics in modern processors.
> > > 
> > > Some modern uses are:
> > >  - Multi-byte/long NOPs
> > >  - Indirect Branch Tracking (ENDBR32)
> > >  - Shadow Stack (part of CET)
> > > 
> > > Some processors advertising i686 compatibility lack full support for
> > > them, which may cause #UD to be incorrectly triggered, crashing software
> > > that uses then with an unexpected SIGILL.
> > > 
> > > One such software is sudo in Debian bookworm, which is compiled with
> > > GCC -fcf-protection=branch and contains ENDBR32 instructions. It crashes
> > > on my Vortex86DX3 processor and VIA C3 Nehalem processors [1].
> > > 
> > > This patch is a much simplified version of my previous patch for x86
> > > instruction emulation [2], that only emulates hintable NOPs.
> > > 
> > > When #UD is raised, it checks if the opcode corresponds to a hintable NOP
> > > in user space. If true, it warns the user via the dmesg and advances the
> > > instruction pointer, thus emulating its expected NOP behaviour.
> > > 
> > > [1]: https://lists.debian.org/debian-devel/2023/10/msg00118.html
> > > [2]: https://lore.kernel.org/all/20210626130313.1283485-1-marcos@orca.pet/
> > > 
> > > Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>  
> > 
> > This is going to be terribly slow if there's a significant number of
> > traps (like with endbr32), but yeah, this ought to work.
> 
> Could you patch the memory resident page to contain a supported nop?
> (without marking it 'dirty')
> Then the same function wouldn't trap until the code page was reloaded
> from the source file.

It would mean cloning the page as private. Yes you can do it, uprobes
has all the code for this. But it has non-trivial memory overhead.

