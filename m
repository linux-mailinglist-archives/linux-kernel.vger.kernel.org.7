Return-Path: <linux-kernel+bounces-815669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD47B569A1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388FA164F83
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1100420A5EB;
	Sun, 14 Sep 2025 14:15:04 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101D32566
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757859303; cv=none; b=a9JahY3tRjY2Mw4LIYbv/acI6e69UYEwj1eGDGTaW+QiYPvDorbMkoQlA62nFv7HcagUm7zi4SWaVudNsoHRkV/S0e3boMXPXSn+J8Oh2fSZUZ4YTm2CqEfOje8cMcie50qBBRHO1wDM3/gZjv2BA6kQ/WsQLhslvT1+h3bO1go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757859303; c=relaxed/simple;
	bh=8OWzVDOeqjw5yvefV0UbCW1zk+30jAKzYbBKLL82ytA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1KLjMXFGPMiWpVHd0bQ4DbDgArvqPrl+EbOgnkodaLTAZDBxhltK/tw168iTtknxDN+Wz0yls3Kw2uZdlZ6CrHif3zvryfhdoLv2cRIETLSevQ2juPVl1hWqSPDQ/6sPEXkHHBPFewMzMU980/j2pkvGHk3MTSVS3JuKQwkrvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 58EEEPWI157725;
	Sun, 14 Sep 2025 09:14:25 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 58EEEOtL157724;
	Sun, 14 Sep 2025 09:14:24 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Sun, 14 Sep 2025 09:14:24 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Ash Logan <ash@heyquark.com>
Cc: arnd@arndb.de, christophe.leroy@csgroup.eu,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        officialTechflashYT@gmail.com, AWilcox@wilcox-tech.com,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: 32-bit HIGHMEM and game console downstreams
Message-ID: <aMbNwBrxtBSPl8NQ@gate>
References: <3e8cb683-a084-4847-8f69-e1f4d9125c45@heyquark.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e8cb683-a084-4847-8f69-e1f4d9125c45@heyquark.com>

Hi!

On Sat, Sep 13, 2025 at 08:53:08PM +1000, Ash Logan wrote:
> Wii (2006)
> - 1x PowerPC 750CL "Broadway" @ 729MHz
> - 24MB "MEM1" + 64MB "MEM2" (non-contiguous - MEM2 starts 256MiB in)
> - Kernel 4.19 (+ CIP patchset), dev has been working on forward-porting all
> the drivers one major version at a time (he's currently up to 5.15 last I
> checked) + limited upstream support (hardware bringup, UART, not many
> peripherals)

There *aren't* many peripherals, so that is quite okay :-)

> Wii U (2012)
> - 3x PowerPC 750CL "Espresso" @ 1.2GHz

It is not a 750CL.  We never found out what the model # is, if indeed it
has one!  But the CPU cores are compatible to the Broadway, sure, there
even are configuration bits to make it do the bugs that were fixed in
Espresso!  (Just like Broadway can emulate a Gekko, 750CXe, the GCN
thing).

It does have its own PVR value of course, that is something at least :-)

(Espresso is one chip btw, with three mostly symmetrical cores).

> - 32MB "MEM1" + 2GB "MEM2" (also starts 256MiB in) + various small SRAMs

It has 32MB MEM1?  Huh.  Why?

> Special mention to the GameCube, basically a slower Wii with only 24MB
> direct RAM and 16MB of non-mapped "ARAM". Wii Linux has experimental support
> for this where they use the ARAM as swap.

The main memory on the GCN was very fast, low-latency, ram.  "1T-SRAM",
named so because it isn't SRAM, and not really single cycle access
either :-)

There is a block of it for graphics, too.  No idea where that is direct-
mapped, if at all.

> There is a somewhat active userbase for both devices.

Still?  Nice to hear!

> I only have stats for
> the Wii U side, but some rough nginx grepping for the last few days - Sep
> 7th-Sep 12th - shows 39 downloads of distribution tarballs and bootloader
> binaries in that period, not including torrents. In the past 2 weeks - Aug
> 29th-Sep 12th - 9 people joined the community Discord, 442 total.
> Anecdotally, the Wii Linux userbase appears at least twice as big (based on
> their Discord activity).

That makes sense, there are way more Wii devices than WiiU devices, but
the latter is newer and somewhat nicer (bigger) to run Linux on.

> Distribution-wise, we're supported by ArchPOWER [5], Adélie Linux [6], and
> other distros. The Wii U's Espresso has CPU errata requiring a patched
> compiler,

Can you remind me what that is about?  It shouldn't be too hard to
include it in mainline GCC.

> and both distributions ship separate package repos for this CPU.
> ArchPOWER requested I rebase onto 6.6 so they could have firmware
> compression - previously the Wii U was on 4.19 - so there is some demand for
> newer kernel features as well.
> 
> I know I'm talking about hobbyist use - and mostly downstream use at that -
> and I do suspect that in the event of a wider 32-bit deprecation we'd be
> fine on the final LTS, whatever that ends up being. Still, I think the Wii
> and Wii U represent a decent number of 32-bit users, so I wanted to add to
> the conversation here.

Hey, at least you hobbyists are responsive!

I don't see any real reason to no longer support 32-bit systems in
Linux -- all of the ways where that needs different treatment have been
figured out decades ago already, and perhaps not too many people still
use it, but for some architectures it is the only option and that will
never change.  Not all of the world is x86.  Even with Arm there are
many 32-bit only systems in the wild, some pretty new even!


Segher

