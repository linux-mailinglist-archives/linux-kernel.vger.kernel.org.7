Return-Path: <linux-kernel+bounces-861926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A01A2BF4072
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5BAD4E3DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BAD2F39CC;
	Mon, 20 Oct 2025 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiT0jv2i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714C52253EB
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 23:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761003105; cv=none; b=gn+Js8+Ry0s8Q9rVEH1MUaJIkC6tRSZmQnVxGcP8hKn0fPadkV7yOw4GWoLnrF42iunfgIA2qC3JmT4irrrgbeLYP+wNRZ6RwcR8HQp53z6Vvr/sIK5aWDmoL0v3kuy4BioonCDODMXgF2WwuT3QR0yiF+DMTZ3qXbI9TRjZVR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761003105; c=relaxed/simple;
	bh=MSAK6/4fBV4LmmndaiAxLCMrrPnq6f4CzbgVcuVT6gY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Eozy2DokITzLY4MWs2N4V/UMV5kf3bjk9DPgS+EQduOisXlkZBgx5PrL6+ejF923j2NTSd7GK9mJ0HSy6knDhGZuSVxGmh2KXqXLPFnVzUGhHvrL86ZEE5afOMUdPVnR3Lg/rncN/yl65B2xsi1dERWFYGTv4/EqLovwvD1Z9wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiT0jv2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29277C4CEFB;
	Mon, 20 Oct 2025 23:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761003104;
	bh=MSAK6/4fBV4LmmndaiAxLCMrrPnq6f4CzbgVcuVT6gY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=OiT0jv2iLB3yllOHNdOExpaaufehdFK7X5eHx/RqEZynr648JdouVhGzKa+aAoitK
	 YOGtoCJY6BukhUpJ1mmZByUt43IPYxyUTFb2dNSgYWJrLx0ZJFYzLP+XGMUdgirov8
	 F9WzI3l8hMmx9gfcftH2KC7XS3Dqn5BSU1lBfPlR68A4r5YnfsxWYsDNNB++cMrcLY
	 yTgMGHmt7J1PujIKhWyVHwsMnPgLBxtO0xOWnwFSiKnc9aF/IjjnBDpnXP2X4Pzor3
	 rKIoxbCpfqVpzy61omuF/q23OZfm9fzXECQz9OJ8cmxMSGNt2cmdT1fQmciMy4iJnF
	 /+6Rtzb7Y/6Yg==
Date: Mon, 20 Oct 2025 17:31:25 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Olof Johansson <olof@lixom.net>, Ben Dooks <ben.dooks@codethink.co.uk>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc1
In-Reply-To: <alpine.DEB.2.21.2510072335250.7364@angie.orcam.me.uk>
Message-ID: <93e895ce-2b81-c111-4423-cf7181cc2b45@kernel.org>
References: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org> <066d70c7-b0a7-45e5-9337-17901bc95664@codethink.co.uk> <CAHk-=wgfpswvq0TypePyjv3dofO5YaUC_fSd_MjzY7jogCUnCg@mail.gmail.com> <3c9d9f92-aaf8-4d4d-a2d9-8d6a410edc30@codethink.co.uk>
 <aN6U8NtIfqd-fowQ@chonkvm.lixom.net> <alpine.DEB.2.21.2510072335250.7364@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1876668917-1761003104=:3822160"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1876668917-1761003104=:3822160
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 8 Oct 2025, Maciej W. Rozycki wrote:

> On Thu, 2 Oct 2025, Olof Johansson wrote:
> 
> > > Now we’re starting to see commercial cores on the horizon that will have the
> > > ability to be endian configured at run-time. For example, MIPS (the company
> > > not the ISA) has announced they will be producing cores with configurable
> > > endian (https://mips.com/products/hardware/i8500/).
> > 
> > MIPS has been doing some not so awesome things to the RISC-V architecture
> > in the last year or so. They've published patchsets that make it seem
> > like that they seem to have taken some old MIPS designs and done the
> > bare minimal conversion over to RISC-V, since they need their own weird
> > system peripherals and hooks. Again, with the burden for everybody to
> > maintain because their hardware engineers couldn't bother to develop a
> > full proper RISC-V core.
> 
>  This is obviously a false image.  The most recent MIPS ISAs, such as the 
> microMIPSr6 or the nanoMIPS architecture, and consequently implementations 
> were absolutely RISC-V-like, with branch delay slots removed, conditional 
> moves replaced with conditional selects, floating-point condition codes 
> removed in favour to setting a general register, PC-relative instructions 
> added and overall being a variable-length compressed instruction set, up 
> to the point for some company engineers to become disgruntled with the ISA 
> "losing the MIPS spirit."  So it's not that they can't be bothered to make 
> a full proper RISC-V core, surely they can.

Olof is probably referring to support for extensions like Xmipsexectl:

  https://lore.kernel.org/linux-riscv/20250724-p8700-pause-v5-0-a6cbbe1c3412@htecgroup.com/

  https://mips.com/wp-content/uploads/2025/06/P8700_Programmers_Reference_Manual_Rev1.84_5-31-2025.pdf

Xmipsexectl is annoying for at least two reasons:

1. it is a non-conforming RISC-V extension, stepping on existing 
   standardized base RISC-V ISA opcode space; and

2. it brings over new barrier operations straight from the MIPS
   instruction set, rather than just using the standard RISC-V fences

Doing things like this runs additional ecosystem fragmentation risk, which 
impacts all of us, for little apparent gain.  Nevertheless we took these 
patches because their extension includes a custom PAUSE instruction 
variant, and it's understandable that MIPS might have finalized their 
design before Zihintpause.

I hope Xmipsexectl doesn't survive past P8700, and that we never see 
kernel patches to use those leftover MIPS barrier instructions.

>  NB I doubt it's about peripherals: dropping a different CPU into an 
> existing system is nothing new and does not require the ISAs involved to 
> be remotely similar to each other; cf. VAX vs Alpha for example.

This one isn't a hypothetical example either; see:

  https://lore.kernel.org/linux-riscv/20250924-riscv-time-mmio-v6-2-9c6158a14b37@htecgroup.com/


- Paul
--8323329-1876668917-1761003104=:3822160--

