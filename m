Return-Path: <linux-kernel+bounces-844886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7209CBC2FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918683AC682
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651BC248176;
	Tue,  7 Oct 2025 23:50:22 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3007182B4
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881022; cv=none; b=tl5UFqjUyg2BlcXZfKOFlIf969i5STzCWP0p2575bkPz2X1bbEluMRNBVdDcTDGKfGC/8HMnxOBu7N0KHoOioF9Nut/OlOQhNDMrxzR8rc5w/fK4/OrWxPYbOTWcU40Fsxu3C6kgRoKOwxwh227KXiAjVLDC+K7EbZSqBwZchAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881022; c=relaxed/simple;
	bh=U9/ZAW3gr6vN83901FwrfGq8YHfs0RM9QJB1yg+D/7M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=L8wWzT2sU7GDLC9AtqogYvMnEv/RebktfSfUgEpaqZXvWuFvB93NbcW+xf+HIWZB4iyGtFV3+GuNokzyk3v2BvdJZnLxsBl8VnmXAGSI/iSQeXWzaP29qT1Ady58q9RFEgOx8Tg1nRn9ySKJd9qolH644nSjQWSmuaq/uYVjh/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id DF3C892009C; Wed,  8 Oct 2025 01:43:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id D935092009B;
	Wed,  8 Oct 2025 00:43:46 +0100 (BST)
Date: Wed, 8 Oct 2025 00:43:46 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Olof Johansson <olof@lixom.net>
cc: Ben Dooks <ben.dooks@codethink.co.uk>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc1
In-Reply-To: <aN6U8NtIfqd-fowQ@chonkvm.lixom.net>
Message-ID: <alpine.DEB.2.21.2510072335250.7364@angie.orcam.me.uk>
References: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org> <066d70c7-b0a7-45e5-9337-17901bc95664@codethink.co.uk> <CAHk-=wgfpswvq0TypePyjv3dofO5YaUC_fSd_MjzY7jogCUnCg@mail.gmail.com> <3c9d9f92-aaf8-4d4d-a2d9-8d6a410edc30@codethink.co.uk>
 <aN6U8NtIfqd-fowQ@chonkvm.lixom.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 2 Oct 2025, Olof Johansson wrote:

> > Now we’re starting to see commercial cores on the horizon that will have the
> > ability to be endian configured at run-time. For example, MIPS (the company
> > not the ISA) has announced they will be producing cores with configurable
> > endian (https://mips.com/products/hardware/i8500/).
> 
> MIPS has been doing some not so awesome things to the RISC-V architecture
> in the last year or so. They've published patchsets that make it seem
> like that they seem to have taken some old MIPS designs and done the
> bare minimal conversion over to RISC-V, since they need their own weird
> system peripherals and hooks. Again, with the burden for everybody to
> maintain because their hardware engineers couldn't bother to develop a
> full proper RISC-V core.

 This is obviously a false image.  The most recent MIPS ISAs, such as the 
microMIPSr6 or the nanoMIPS architecture, and consequently implementations 
were absolutely RISC-V-like, with branch delay slots removed, conditional 
moves replaced with conditional selects, floating-point condition codes 
removed in favour to setting a general register, PC-relative instructions 
added and overall being a variable-length compressed instruction set, up 
to the point for some company engineers to become disgruntled with the ISA 
"losing the MIPS spirit."  So it's not that they can't be bothered to make 
a full proper RISC-V core, surely they can.

 The thing is based on my experience I'm fairly sure it's all just driven 
by company customers, which have their legacy MIPS code base or whatever 
and want to switch with minimum effort.  And for a hardware company to 
support a customer it's obviously easier to tweak hardware rather than 
software.

 NB I doubt it's about peripherals: dropping a different CPU into an 
existing system is nothing new and does not require the ISAs involved to 
be remotely similar to each other; cf. VAX vs Alpha for example.

> While I'm not happy with the lack of upstreaming from the (mostly
> Chinese) SoC vendors, and we should be encouraging more of them to
> contribute directly, MIPS seems to be making choices that might have
> long term burden for all of us. So far the slope is slippery on the
> system side, but needing to worry about BE support seems to be stepping
> over the line for me without some obvious clear use cases that make sense.

 Whether we're going to accept things dumped onto us is another matter.  
There's plenty of code downstream that hasn't made it here, and going back 
to my examples, we've never got microMIPSr6 support in Linux even though 
it used to live downstream, and attempts continue being made to get this 
stuff upstreamed across the board.  We may or may not choose to accept 
bits that make our life tougher, and there have been precedents across 
free software, such as the RS6000/PowerPC GCC backend maintainer refusing 
to take changes adding support for the VLE instruction set.

 FYI and FWIW,

  Maciej

