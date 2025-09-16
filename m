Return-Path: <linux-kernel+bounces-819163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D821FB59C58
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C9F7A78C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9271635CEAD;
	Tue, 16 Sep 2025 15:42:27 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD11345722
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037347; cv=none; b=SZ+JZ8ymDnbVQzt54tvx7/D+MiWxbOGWGZDHMdg4VPmEBm0xayqiUw/Fq+bvZCJ5yqrns/uehmGHmaK0IfjFUBZi74rbpXaBP0C2+cT7gNYKjhT1sSZ2+0ibjrZIDq2w1Hyl+WU9B1MzpimcHYynlGMSjWtmKijBfVg0MzTYH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037347; c=relaxed/simple;
	bh=D8sjOdiT4z2oYG1XEIbAWxGYXzY3r8Vt0ZCJzv0C9M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMjb9f8Y9R3vzvRBEbm4JuAVe3bOfz/sS5utTzURKSVZlECH3sZ3vEnE1pScXdJnn5J6PPqfukB4cT8NaPP8usZ5jK+AdLa1LOPKc7SavmEgAMvrBLvS4nfhQatBNOohBC79V01HCT0RCZ3+eHLYKNtoBTq3mImTDDJVLFQ7Wyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 58GFfn80294667;
	Tue, 16 Sep 2025 10:41:49 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 58GFfmi4294661;
	Tue, 16 Sep 2025 10:41:48 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 16 Sep 2025 10:41:48 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Ash Logan <ash@heyquark.com>
Cc: arnd@arndb.de, christophe.leroy@csgroup.eu,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        officialTechflashYT@gmail.com, AWilcox@wilcox-tech.com,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: 32-bit HIGHMEM and game console downstreams
Message-ID: <aMmFPCwU-mVxBbsv@gate>
References: <3e8cb683-a084-4847-8f69-e1f4d9125c45@heyquark.com>
 <aMbNwBrxtBSPl8NQ@gate>
 <95d176d1-e1be-4594-91bd-caf0d68fd532@heyquark.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95d176d1-e1be-4594-91bd-caf0d68fd532@heyquark.com>

On Tue, Sep 16, 2025 at 12:10:14PM +1000, Ash Logan wrote:
> On 15/9/25 00:14, Segher Boessenkool wrote:
> > On Sat, Sep 13, 2025 at 08:53:08PM +1000, Ash Logan wrote:
> > > Wii (2006)
> > > - 1x PowerPC 750CL "Broadway" @ 729MHz
> > > - 24MB "MEM1" + 64MB "MEM2" (non-contiguous - MEM2 starts 256MiB in)
> > > - Kernel 4.19 (+ CIP patchset), dev has been working on forward-porting all
> > > the drivers one major version at a time (he's currently up to 5.15 last I
> > > checked) + limited upstream support (hardware bringup, UART, not many
> > > peripherals)
> > 
> > There *aren't* many peripherals, so that is quite okay :-)
> 
> That's true. The lack of a UART or similar does make USB kinda essential for
> an input device in my opinion, though getting it working is Complicated for
> DMA reasons. (I think this is the main thing holding the downstream back in
> their rebasing efforts)

We often threw something on the EXI bus, either something that directly
converts to USB (like the EXIUSB board we did), or anything goes really,
it is a really simple bus so an FPGA or a CPLD or XS1 or even pure
software works.

> > > Wii U (2012)
> > > - 3x PowerPC 750CL "Espresso" @ 1.2GHz
> > 
> > It is not a 750CL.  We never found out what the model # is, if indeed it
> > has one!  But the CPU cores are compatible to the Broadway, sure, there
> > even are configuration bits to make it do the bugs that were fixed in
> > Espresso!  (Just like Broadway can emulate a Gekko, 750CXe, the GCN
> > thing).
> > 
> > It does have its own PVR value of course, that is something at least :-)
> > 
> > (Espresso is one chip btw, with three mostly symmetrical cores).
> 
> Yeah, I was just going for the closest "public" chip :) I think the PVR is
> closer to the CXe too, but all the HIDs, missing THRM, missing frequency
> scaling - it's very CL-y...

The 750CX and 750CXe (and so, Gekko as well) have a PVN of 8, it is
just a 750 after all.  750FX has 0x7000 though, and 750GX has 0x7002.
Espresso is 0x7001, maybe it is somwhat inbetween FX and GX wrt
implementation process or the like.

The numbering is a bit of a mess, yeah :-)

> > > - 32MB "MEM1" + 2GB "MEM2" (also starts 256MiB in) + various small SRAMs
> > 
> > It has 32MB MEM1?  Huh.  Why?
> 
> New generation upgrade? MEM1 does get used for Wii U software too, usually
> to keep framebuffers and other 3D things, so I guess they wanted just a
> little more for all the 1080p buffers the new console juggles.

Ah, it appears the MEM1 is not implemented as 1T-SRAM anymore, but just
is a hunk of off-the-shelf DDR2 (or GDDR3, or DDR3, or whatever they
used; it doesn't matter so much).  Those come in power-of-two sizes
mostly :-)

There only is 3MB of 1T on WiiU, for the graphics memory.

> > > Distribution-wise, we're supported by ArchPOWER [5], Adélie Linux [6], and
> > > other distros. The Wii U's Espresso has CPU errata requiring a patched
> > > compiler,
> > 
> > Can you remind me what that is about?  It shouldn't be too hard to
> > include it in mainline GCC.
> 
> The short version is "every stwcx. should be prefaced with a dcbst" -
> something to do with bus snooping (store-with-flush, store-with-kill) I'd
> guess. I have some GCC patches drafted (activated by -mcpu=espresso) here:
> https://gitlab.com/linux-wiiu/smp-patches

Ah cool.  I'm maintainer for PowerPC GCC these days, I'll be happy to
work with whoever wants to do a good patch (not this one, it is not a
different CPU type, we shouldn't pretend it is, the actual patch can be
just a handful of lines).

> I'm impressed by how often IBM stuffed up atomics during this generation.
> The Xbox 360 has an extremely similar issue despite being an entirely
> different lineage of chip.

It is not very similar at all.  Both have some issues related to
(off-core) coherency stuff, something for which there were no good
testing frameworks in that era.  And that is where the similarity ends.

This needs full-system emulation to test well, probably interpreting
the whole VHDL, for all cores and the caches and the fabric.  Or special
ASICs to implement the whole thing at a hundred of a percent of real
speed.

> No surprise the console vendors all went to x86
> and ARM right after, I suppose.

Both of which had similar (but even worse) bugs, yeah :-)


Segher

