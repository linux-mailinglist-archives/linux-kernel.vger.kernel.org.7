Return-Path: <linux-kernel+bounces-785011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83996B344B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FFF1890137
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209C52F3627;
	Mon, 25 Aug 2025 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f6ycLc+c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4zN5pQ6+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB235965
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133773; cv=none; b=luvw0ma2XegcBTOttxl3Na11lDmsnZ8CDmgtO6JkxXKzwIlgujKqv7jHi3unCN2O1glZTyZUm/lM0KzrLkJ/43vzIrpSangh6KSm+MR7cPZJEMWkgY90iE8b2riXR1g2WSpzGwRe0GUDCmC9eGFC9iLxqW4MCWSU/GmbGsVrmyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133773; c=relaxed/simple;
	bh=lzG5ztffWAmxTgcoF6EAknDcfDopOHWkXJTGfrHmOPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVEDI6JYs2FDq8V0J2djjP1Jw91zeb+DcOzVR9CzRtVlQNlUWj48TcEGASPoYpqck2x61+u0GvHUfatZO68Pt4hdE2C7+i8ZEIEdVwAo7p5PvycWpQigETTPTxEvwct3fwPJQhZ/O495wavcG5hFgW6zd1Mx3BlTC0i34N4meFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f6ycLc+c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4zN5pQ6+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 16:56:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756133770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwgA88EWTFhd52yR0KS4Tya5c3yeMbixjFO2en//4I0=;
	b=f6ycLc+ccZewfUYXs381T6wG69W1URTNV0n0okdxE9eYaaN9LXhRT3oH1Q1P5DVBYlCgn2
	ZdZneVP5/orfnlkIVwmHFCKTL9s750J3y9mNhAwXZTQr6ReGYWxdApTEQf+ZLIhgUK0V4k
	VaEYup6V0CK4ThO8yaJVAJRm5f69CurSWsv2ZAcC+BGlS1GxVPYMDehyNehFYProCz6PbG
	BsJ2ueHvI5jMqz0b0TZ6Czt7/G3bjryzqEN6ioi9QdoGgZZtlSjS9fhtOgMtvivXsajFnG
	JkCpdfeCYOf4Cct5Atq9bumMP3Ejl+hturHOPcqBZL+MCv52R6CtuGprAgl5vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756133770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwgA88EWTFhd52yR0KS4Tya5c3yeMbixjFO2en//4I0=;
	b=4zN5pQ6+SCMy9m9z4yvmOJSd2mEtuAX5oxD9YrgIK3giIj4HdyNAUdKExvqNeowsq818zB
	MUBkImWWu3z3WkDw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 06/34] x86/cpuid: Introduce <asm/cpuid/leaf_types.h>
Message-ID: <aKx5iFEXVGlzWETl@lx-t490>
References: <20250815070227.19981-1-darwi@linutronix.de>
 <20250815070227.19981-7-darwi@linutronix.de>
 <20250825141803.GUaKxwm1lAAugFJHVQ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250825141803.GUaKxwm1lAAugFJHVQ@fat_crate.local>

Hi Boris,

On Mon, 25 Aug 2025, Borislav Petkov wrote:
>
> On Fri, Aug 15, 2025 at 09:01:59AM +0200, Ahmed S. Darwish wrote:
> > +struct leaf_0x1_0 {
> > +	// eax
> > +	u32	stepping			:  4, // Stepping ID
>
> All those bit names in all those leafs: are they taken from the official
> documentation?
>

Yes, I've built the 86-cpuid-db XML database from the official sources.

Intel:

    Intel® 64 and IA-32 Architectures Software Developer's Manual
    Intel® Architecture Instruction Set Extensions and Future Features
    Intel® CPUID Enumeration and Architectural MSRs
    Intel® X86-S External Architectural Specification
    Intel® Key Locker Specification
    Intel® Architecture Memory Encryption Technologies Specification
    Intel® Trust Domain CPU Architectural Extensions
    Intel® Architecture Specification: Intel® Trust Domain Extensions (TDX)
    Intel® Flexible Return and Event Delivery (FRED) Specification

AMD:

    AMD64 Architecture Programmer’s Manual, Volumes 1–5
    Preliminary Processor Programming Reference (PPR) for AMD Family 19h
    Model 11h, Revision B1 Processors
    Open-Source Register Reference For AMD Family 17h Processors Models 00h-2Fh

Transmeta:

    Processor Recognition, Transmeta Corporation (2002/05/07)

This is also listed under the 'References' section of the project:

    https://gitlab.com/x86-cpuid.org/x86-cpuid-db

There are some bitfields contributed by Intel and AMD developers that are
not yet in the official documentation.  In such cases, I trusted that
such info is posted from developers within Intel and/or AMD.

>
> > +/*
> > + * Leaf 0x5
> > + * MONITOR/MWAIT instructions enumeration
> 				 ^^^^^^^^^^^
> Let's drop all those tautologies - it is absolutely clear that it is an
> enumeration so no need for it. Just keep the minimum text that is needed to
> describe the bit. People can always use that to find the official
> documentation of they need more info.
>

will do.

>
> > +/*
> > + * Leaf 0x18
> > + * Intel determenestic address translation (TLB) parameters
>
> + * Intel determenestic address translation (TLB) parameters
> Unknown word [determenestic] in comment.
> Suggestions: ['deterministic',...
>
> spellchecker please.
>

will do.

[ I have a spellcheck CI pipeline for the XML database, but somehow I
  missed checking the leaf description field :( ]

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH

