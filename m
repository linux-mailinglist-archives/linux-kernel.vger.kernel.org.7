Return-Path: <linux-kernel+bounces-774073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B181B2AE52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B361BA1147
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00047342C8C;
	Mon, 18 Aug 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n5+vEN12";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="97vdCJ19"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7650341ADE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535039; cv=none; b=AAO/K6xLh4ZFu+tosFmjtJV8IYVsrQ7DKQ/O31HMpxzQO04MYGnNsR4F31TPosaVapfQ7pI7LzppLnIcbsT0CBaLRuUF6w4dlmkoXuEnUxJEkCCvaVPRFREA5Li3AXG3vaejYBsoNOo2T3CBIeW7QT1w3pVvW8PbLaFeXusNvlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535039; c=relaxed/simple;
	bh=8eNf0iKa0ig3TuxwumQ2/QRd1bTDl/mqIxw/LuoIvZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CshQo75AmopyIEbIP1nXDSe5DuBTkit4O2h/pL3Ywrnhp70LpWlkSu0/ZA0hLGJvHlpy9A8rQavIkDPSieYkemH4Ry9NeJwm7DZLYfCXt0fZKUdJmxI7jU7pbEnqURAaq1JTg0WRgFty0EExkGc3lJxa0D7v/+loT9M5SuIWGPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n5+vEN12; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=97vdCJ19; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 18:37:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755535035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcfYUOp3ONarOFQ9ApEyTry+lTvGB64KU4u/3784Bfk=;
	b=n5+vEN12rbGP5L/u4vO3Huz1gPEaGj+as65fKG1SvibuAo/vXWI2wwzBQXFAhP/Pa/cktX
	nyjx1oXzEQJ+Q51q7NF7BqKRnBpDgfu18gCY0gZLcXDQYsIWruKwZzty76+RYkaZyMftNf
	Jlio166ozQucntttojCT6hIqFiAM6gci3EUnHZxpy/D1xV+TqF76cPmFCil8M7ZX+jY9tI
	RMxYfjg04/GPT4JLLTATmjNMFcOUk2d/wmz1DneNXPd0FNCQsx30y3nzSzIdrltPgelrtH
	/oUgtNIyZXV6FV+HwlCK/c+PaQwke3UD347CJbNUupSFpYxekfU/NZf+REzycg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755535035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcfYUOp3ONarOFQ9ApEyTry+lTvGB64KU4u/3784Bfk=;
	b=97vdCJ19J7JIIyOfNtDVegOcd1/0peo0SN0PASMkFjO4mt5vKasg/bors4uEpchDX8AZSL
	OPrLUsJQd0kp+VCQ==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/34] x86: Introduce a centralized CPUID data model
Message-ID: <aKNWuX6UHd_6wJoR@lx-t490>
References: <20250815070227.19981-1-darwi@linutronix.de>
 <ebab779b93b8be44bd5089ae6ecc9746b1517a68.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebab779b93b8be44bd5089ae6ecc9746b1517a68.camel@infradead.org>

Hi!

On Sat, 16 Aug 2025, David Woodhouse wrote:
>
> Nice work.
>

Thanks a lot.

>
> Looks like you haven't attempted to address hypervisor CPUID yet.
>

Yeah, I plan to tackle the hypervisor stuff after the X86_FEATURE(s)
dependency graph mentioned in the Bhyve thread:

    https://lore.kernel.org/lkml/aKL0WlA4wIU8l9RT@lx-t490

> I've attempted to document that in a section at the end of
> http://david.woodhou.se/ExtDestId.pdf — I wonder if we should find
> somewhere to publish it as canonical?

That PDF, and the text file it links to, is some of the best
documentation I ever saw in kernel land...

I would be more than happy to cover the last section of that PDF
('Hhypervisor Detection via CPUID') under the x86-cpuid-db umbrella.

There's some very basic hypervisor-related things:

    https://gitlab.com/x86-cpuid.org/x86-cpuid-db/-/blob/tip/db/xml/hypervisors.xml
    https://gitlab.com/x86-cpuid.org/x86-cpuid-db/-/blob/tip/db/xml/leaf_40000000.xml

But the idea of CPUID block "ranges", as in cpuid_base_hypervisor(), is
not yet covered.  Also, the only thing these XMLs above actually do is
generating the 'struct leaf_0x40000000_0' data type:

    Subject: [PATCH v4 06/34] x86/cpuid: Introduce <asm/cpuid/leaf_types.h>
    https://lore.kernel.org/lkml/20250815070227.19981-7-darwi@linutronix.de

>
> I suspect our loop in cpuid_base_hypervisor() should be 'fixed' to
> comply with the new rule I just made up, that it should only scan each
> block at 0x4000_0.00 until it finds an empty block, rather than going
> all the way up to 0x4001_0000?
>
> Are there any hypervisors which provide more than one block, that
> *aren't* just putting the Hyper-V leaves at 0x4000_0000 and their own
> native leaves at 0x4000_0100 ?
>

I think, no, but you and others at Cc are definitely the more experienced
folks regarding this :)

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH

