Return-Path: <linux-kernel+bounces-869834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F12BAC08D38
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 09:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4FC1C627BE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 07:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A571C22CBD7;
	Sat, 25 Oct 2025 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dtqs4k+Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE8A2629C
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761376517; cv=none; b=Z8Iscv2jS3pxg4/43WyE51I4ehG/ZAHhn9eG3nC65bflVjy76XUCx8P6PKaamHDhKCZxzRaojBuDHYgSAHbLIcEaX9iFDEPWM25yMJDpijBUKhUgXqQ0NspzpRg8DDQNONcrocLo8M8OmXpi7QzLAFigbVtVlxSeY1oqh6sEGF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761376517; c=relaxed/simple;
	bh=xk5wGA7YzQyhSJOIloUEEN8B+/4+jX+OfkebTt5KUMc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OpoYuMxN5bhn6KwUVbI4EF+EDRzzOhkJSPgziaBbzoTHV16F74uOHZp2pKIMz8QUUfm+uuyuNlCHyV0Voa3ndM33tpxW1EUQAYW8fFiiqhOI10XaOGjI1Zn3hY1TWH9tHRRUFBnfwysUo6hUS75j8AIXMfZBuXZbfD+aMmf56fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dtqs4k+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AD2C4CEF5;
	Sat, 25 Oct 2025 07:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761376516;
	bh=xk5wGA7YzQyhSJOIloUEEN8B+/4+jX+OfkebTt5KUMc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Dtqs4k+YJTg9+aS8n9Jcy4T8TIFIOS/BNLwX7RDyLLVGGN3o2Fwr2wC8fFu06Tqdv
	 0UDFWO+wkzdNoWt4yTE1fecwekaZCO8cauqXIvH3AtKtprRqOA50XSeO0vwVHNyWHi
	 2bU8ra7Za+A7xDuWNgIsPgGish/PiydgCr4Muqy5hO0sMlV7gA0iyWq80AiLB60PND
	 wkNmWqjiTBnCsj/U0O22jiXIMpDpN047NAxdigGmt+mY4A91/4gqnsVvCX32s9+wgk
	 UHtPf60PecjW6KemZqOT+0fiw3Mb+hRO4dQs+tHEjAiaUDPrXTDif6dGb89NHOTSkZ
	 H1hqh1/yoLguA==
Date: Sat, 25 Oct 2025 01:15:12 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Josephine Pfeiffer <hi@josie.lol>
cc: pjw@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
    aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] riscv: ptdump: use seq_puts() in pt_dump_seq_puts()
 macro
In-Reply-To: <20251019140711.63664-1-hi@josie.lol>
Message-ID: <ab17be2e-202e-e34e-21f8-c865aff4024f@kernel.org>
References: <2eaeaa69-b2cf-3a3a-0239-2aefcaa836aa@kernel.org> <20251019140711.63664-1-hi@josie.lol>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 19 Oct 2025, Josephine Pfeiffer wrote:

> On Sat, 18 Oct 2025, Paul Walmsley wrote:
> 
> > Hard to accept that it's a performance issue.  But I think you're right
> > that generating a newline should be done with seq_puts().
> 
> Fair point. I'll drop that from the commit message.
> 
> > A better fix would seem to be to just get rid of pt_dump_seq_puts().  It's
> > only used once in arch/riscv.
> >
> > Taking a broader view, both pt_dump_seq_puts() and pt_dump_seq_printf()
> > look completely pointless.  Is there any argument for keeping them?
> 
> Good question. I investigated the git history and current usage:
> 
> The macros were introduced in commit ae5d1cf358a5 ("arm64: dump: Make the
> page table dumping seq_file optional") to support passing NULL for the
> seq_file parameter. This is used by ptdump_check_wx() for CONFIG_DEBUG_WX,
> where the kernel walks page tables to check for writable+executable pages
> without outputting anything to userspace.
> 
> All four architectures use this pattern in ptdump_check_wx():
> 
>   arch/arm64/mm/ptdump.c:341:         .seq = NULL,
>   arch/arm/mm/dump.c:456:             .seq = NULL,
>   arch/riscv/mm/ptdump.c:378:         .seq = NULL,
>   arch/s390/mm/dump_pagetables.c:197: .seq = NULL,
> 
> However, you're right that the utility of these macros varies:
> 
> Usage of pt_dump_seq_puts():
> - arm64: 1 use
> - ARM: 0 uses
> - riscv: 1 use
> - s390: 3 uses
> 
> Note: ARM defines pt_dump_seq_puts() but never uses it - that macro
> could be removed entirely.
> 
> Usage of pt_dump_seq_printf():
> - arm64: 6 uses
> - ARM: 7 uses
> - riscv: 6 uses
> - s390: 5 uses
> 
> For RISC-V specifically, I agree the single use of pt_dump_seq_puts()
> could be replaced with an inline conditional. For pt_dump_seq_printf(),
> the macro does save some repetition (6 uses vs 1 macro definition).
> 
> pt_dump_seq_printf() could also be questioned - removing it means 20+
> inline conditionals across all architectures. I focused on the minimal
> fix, but happy to tackle the larger refactor if preferred.
> 
> Would you prefer:
> 
> Option A) Remove pt_dump_seq_puts() entirely from riscv and replace the
> single use with:
>   if (st->seq)
>     seq_puts(st->seq, "\n");
> 
> Option B) Keep the macro for consistency with other architectures, but
> fix the bug
> 
> I'm happy to send a v2 with either approach. If Option A, I could also
> propose similar cleanups for arm64 (1 use) as a follow-up.

Thanks for investigating further.  I just queued your original patch; I 
think that's the simplest way forward.


- Paul

