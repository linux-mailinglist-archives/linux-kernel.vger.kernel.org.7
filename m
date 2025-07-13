Return-Path: <linux-kernel+bounces-729060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B16F9B03134
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 15:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F89189B8CD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E15B278157;
	Sun, 13 Jul 2025 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCPum5uy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1FB7464
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752413745; cv=none; b=nyDRqwNomPt+abnZJ9wSH8k7cPwQAhILzzutPt6RKnWhSLChPMZIC49Uvgf3MnhzQPX8oc1RsCua8/gFYFEQPR2Hbl7dgmABg+iDZB1nhPaMgtPCGcpMUYGc3gAvSwX2/nLNPnTb8XbVOxFt0NqERoHYEXNZBJ7HRQYAIcw3684=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752413745; c=relaxed/simple;
	bh=mBU5USz8BZIF/JIkJTQAznKlxvdAyXWf9AuUzuPluIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6B5zTSEx/V2T13LVRbh6Pl+PszMXTTXFxMSY2ThIMcTfBkUI/1mydjH+IwiWfIEPp5MOEEkWodLCdHQCPotUrcJcnuwTuBZZbI+UcJXU8hBLudcSjzciiQQZaLCotpf+78Lagb1qG2M7kkbP9TCgxlUrasFKxdhTD4U1oOnYsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCPum5uy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795A2C4CEE3;
	Sun, 13 Jul 2025 13:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752413745;
	bh=mBU5USz8BZIF/JIkJTQAznKlxvdAyXWf9AuUzuPluIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bCPum5uyXpu9VX4xtKlkj7VMlS30iuqvm8kOOJCpTGCIIS2/1UebZV3FLZ4fYqNV+
	 xNhUyt2aU9Sysf9o0Uo8y07It0xxyKRkjA3gyBgSu3eqAyH83IZRITgN0zhBOv5Jzg
	 ugXcqhUKjtiRtHlVoPWgu8iAAuSHcrIUpzFCIDu/7yQSOOQYY3MBjBvOvfMJLDaw6D
	 GNu8J5nMkhP6ez0cRdr8JLKJORImC8zWN602KGTUvNrTD/CSrRv1xFj3JiNn2aLYv7
	 maqJVW3wLnInXlVXHezdE9nxN9cLsCspGynML3YIQ1KoVvCFiVHqD7Qm5Ehm2WWWsR
	 4dp0RLgGeuzCQ==
Date: Sun, 13 Jul 2025 14:35:40 +0100
From: Will Deacon <will@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 10/10] arm64: mm: Re-implement the __flush_tlb_range_op
 macro in C
Message-ID: <aHO2LAoDpciZftP_@willie-the-truck>
References: <20250711161732.384-1-will@kernel.org>
 <20250711161732.384-11-will@kernel.org>
 <CAHk-=wijmAO=-dWc8HUMdUbkdGqgNtiO6mntAcTekWc5qN3YjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wijmAO=-dWc8HUMdUbkdGqgNtiO6mntAcTekWc5qN3YjQ@mail.gmail.com>

On Fri, Jul 11, 2025 at 11:16:32AM -0700, Linus Torvalds wrote:
> On Fri, 11 Jul 2025 at 09:18, Will Deacon <will@kernel.org> wrote:
> >
> > The __flush_tlb_range_op() macro is horrible and has been a previous
> > source of bugs thanks to multiple expansions of its arguments (see
> > commit f7edb07ad7c6 ("Fix mmu notifiers for range-based invalidates")).
> >
> > Rewrite the thing in C.
> 
> So I do think this is better than the old case, but I think you could
> go one step further...
> 
> > +static __always_inline void __flush_tlb_range_op(const enum tlbi_op op,
> > +                                                u64 start, size_t pages,
> > +                                                u64 stride, u16 asid,
> > +                                                u32 level, bool lpa2)
> 
> If you replaced that "enum tlbi_op op" with two function pointers
> instead (for "the invalidate range" and "invalidate one" cases
> respectively), I think you could make this code much more obvious.
> 
> And exactly like how you depend on that 'op' value being
> constant-folded because all the different levels are inline functions,
> the same thing ends up happening with function pointers where inlining
> will result in a constant function pointer becoming just a static call
> (and in turn inlined as well).

So I don't _strictly_ rely on the constant-folding and replacing that
BUILD_BUG_ON() with a BUG_ON() would still give functionally correct
code if inlining didn't occur. I just much preferred catching a wonky
TLBI op at compile-time, which is why I ended up with this but I hadn't
considered that this would allow us to inline indirect function calls.

> And then the actual *callers* would use the "look up op" thing, but I
> suspect that in many cases those could then be in turn also simplified
> to not use that op-number at all, but just end up using the op-name.

Right, I think we'd drop the enum entirely if we went down this route.

> I didn't try to actually create that series - and I think you'd want
> to do it in multiple steps just to make each individual step small and
> obvious - but I think it would end up looking nicer.

I'll have a play...

Will

