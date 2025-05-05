Return-Path: <linux-kernel+bounces-631871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1DFAA8E95
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 10:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF893B7D30
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 08:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686B71F418F;
	Mon,  5 May 2025 08:53:15 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6698718C008
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435195; cv=none; b=r+rg8+MYjmAbWPnIj5JpcqlhfoXZzUzVDzqnBovIqt0vG6Mr3QmCt0iSJTdNUqxMKg6OQ0UEYAFEm5sIYUziXxtsgXmmYDViY91CMnS/l1N4YCJtiboH7QME/77s2IalW1CF1b0ya42u1aAy/78i7e2usltW9tXYCwGKAct1JYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435195; c=relaxed/simple;
	bh=HNA0hsv82UWMWwlcVYIRa+W7ego3ZLOxskQF3FLO/tc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MvI/MfPC6IMzpmYaSwaP3DIbVMou6xN9G4UwqxrJ+3RySIO6emkdYQPClFRtMHwW9zySNbyA2Ced79s5ukvm3STA2bt0ij3OIBGM3aKHyJssuupGcFQDaQ48QNJ2vFhLz7HDRSEBan7Us74/5evmkKZ2chIylUbWVdQ0DL+AJOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id E1A1C92009C; Mon,  5 May 2025 10:53:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id DE01092009B;
	Mon,  5 May 2025 09:53:04 +0100 (BST)
Date: Mon, 5 May 2025 09:53:04 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Ingo Molnar <mingo@kernel.org>
cc: linux-kernel@vger.kernel.org, "Ahmed S . Darwish" <darwi@linutronix.de>, 
    Andrew Cooper <andrew.cooper3@citrix.com>, 
    Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    "H . Peter Anvin" <hpa@zytor.com>, John Ogness <john.ogness@linutronix.de>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Peter Zijlstra <peterz@infradead.org>, 
    Thomas Gleixner <tglx@linutronix.de>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [RFC PATCH 0/15] x86: Remove support for TSC-less and CX8-less
 CPUs
In-Reply-To: <20250425084216.3913608-1-mingo@kernel.org>
Message-ID: <alpine.DEB.2.21.2505050944230.31828@angie.orcam.me.uk>
References: <20250425084216.3913608-1-mingo@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 25 Apr 2025, Ingo Molnar wrote:

>  > I really get the feeling that it's time to leave i486 support behind.
>  > There's zero real reason for anybody to waste one second of
>  > development effort on this kind of issue.
> 
> This series increases minimum kernel support features to include TSC and
> CX8 (CMPXCHG8B) hardware support, which removes 486 (and derivatives) support
> and early-586 (and derivatives) support.

 FWIW I'm not happy about that at the very least because this will prevent 
me from using my 486 box for EISA defxx driver maintenance.  What exactly 
is the problem with 486?

 I know the lack of TSC has security implications, but don't use the 
machine in a way for which it would be an issue and I don't expect anyone 
doing otherwise.  We have non-x86 platforms that lack a high-resolution 
timer and nobody's going to drop them.

 We also have platforms that lack atomics, let alone double-precision ones 
and they're fine too, so why is x86 different?

  Maciej

