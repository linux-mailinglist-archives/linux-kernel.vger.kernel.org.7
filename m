Return-Path: <linux-kernel+bounces-744102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF1CB107FF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D6F5A3086
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9FE267F4C;
	Thu, 24 Jul 2025 10:44:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34017267B9B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353898; cv=none; b=bDGHRaTEqRqm6GsmLTUXGdJnqaGVfjH54g4KfwgDOZ69r9THejo3EaWhF+xON8SupSRX/uV5cGjmX4SWliN47NOaH89pfL3uLYhEbssmPG4S261uRyuoOY2oRS4mNsUEzBYpDynWRYhU4SDVSQsyXrEzXufyTDZ3Uei7DngE+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353898; c=relaxed/simple;
	bh=RgHZddi0ynsrr+kGHbof42zzgia/mOAOnkJdUPLnkIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6/jHVmkmYFscgP+3HS5e2Y+ErcuAddfp/mQUI6uulK+OvbvbxWdIKgPdypO7SPjljjJJWJRVL7XchS18IXHnPkoJ/B9q4XcA1Y+QVLHzmCp40i2JX2+KzSUzOwSTV86156BnDSPnDrdh85ubX8NSQXx6Kxrk6t4AcyzsHjM6ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E29BE1A00;
	Thu, 24 Jul 2025 03:44:48 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3ECE3F5A1;
	Thu, 24 Jul 2025 03:44:53 -0700 (PDT)
Date: Thu, 24 Jul 2025 11:44:47 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: build failure with crosstools gcc 15.1.0
Message-ID: <aIIOn-5Zndlb2tDG@J2N7QTR9R3>
References: <8362b484-ea77-4825-8ccb-d5acad660102@oss.qualcomm.com>
 <617201f8-1ad7-4403-b195-8c80d35ea30f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <617201f8-1ad7-4403-b195-8c80d35ea30f@app.fastmail.com>

On Fri, Jul 04, 2025 at 03:25:49PM +0200, Arnd Bergmann wrote:
> On Mon, Jun 23, 2025, at 21:52, Jeff Johnson wrote:
> > I've been using crosstools gcc 14.2.0.
> >
> > Today I saw that gcc 15.1.0 has been added to crosstools:
> > https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/15.1.0/
> >
> > But when I try it I'm getting an error:
> >   LD      vmlinux.o
> > vmlinux.o: warning: objtool: ncsi_process_next_channel() falls through 
> > to next function ncsi_channel_monitor.cold()
> > vmlinux.o: error: objtool [elf.c:1360]: elf_write: elf_update failed: 
> > invalid section alignment
> > make[5]: *** [scripts/Makefile.vmlinux_o:72: vmlinux.o] Error 1
> > make[5]: *** Deleting file 'vmlinux.o'
> > make[5]: Target '__default' not remade because of errors.
> > make[4]: *** [Makefile:1217: vmlinux_o] Error 2
> > make[4]: Target 'all' not remade because of errors.
> > make[3]: *** [debian/rules:80: build-arch] Error 2
> > make[3]: Target 'binary' not remade because of errors.
> > dpkg-buildpackage: error: make -f debian/rules binary subprocess 
> > returned exit status 2
> > make[2]: *** [scripts/Makefile.package:126: bindeb-pkg] Error 2
> > make[1]: *** 
> > [/local/mnt/workspace/jjohnson/kernel/laptop-debug/Makefile:1635: 
> > bindeb-pkg] Error 2
> > make: *** [Makefile:248: __sub-make] Error 2
> > make: Target 'bindeb-pkg' not remade because of errors.
> >
> > This is with a simple x86 make C=1 W=1 -j8 bindeb-pkg
> >
> > Any thoughts?
> 
> Hi Jeff,
> 
> Sorry for the late reply, have you figured it out in the meantime?
> 
> I couldn't immediately reproduce it, so it may already be fixed
> in linux-next.

FWIW, I consistently see the same objtool splat for v6.16-rc7 and
next-20250724, built with GCC 15.1.0 from the kernel.org cross
toolchains page, e.g.

$ git clean -fdx
$ usekorg 15.1.0 make ARCH=x86_64 CROSS_COMPILE=x86_64-linux- defconfig
$ usekorg 15.1.0 make ARCH=x86_64 CROSS_COMPILE=x86_64-linux- -j56

The build machine is Debian 11.10 on x86-64., and 'usekorg ${VERSION}'
is my script to put the relevant kernel.org cross toolchain binaries
into my $PATH.

Doing the same with the 14.2.0 binaries, e.g.

$ git clean -fdx
$ usekorg 14.2.0 make ARCH=x86_64 CROSS_COMPILE=x86_64-linux- defconfig
$ usekorg 14.2.0 make ARCH=x86_64 CROSS_COMPILE=x86_64-linux- -j56

... builds successfully, but there are some objtool warnings:

|   LD      vmlinux.o
| vmlinux.o: warning: objtool: x86_init_dev_msi_info+0x58: relocation to !ENDBR: irq_chip_retrigger_hierarchy+0x0
| vmlinux.o: warning: objtool: .export_symbol+0x3e78: data relocation to !ENDBR: irq_chip_retrigger_hierarchy+0x0
| vmlinux.o: warning: objtool: .export_symbol+0x31140: data relocation to !ENDBR: stpcpy+0x0
| vmlinux.o: warning: objtool: dmar_msi_controller+0x58: data relocation to !ENDBR: irq_chip_retrigger_hierarchy+0x0
| vmlinux.o: warning: objtool: intcapxt_controller+0x58: data relocation to !ENDBR: irq_chip_retrigger_hierarchy+0x0
| vmlinux.o: warning: objtool: hpet_msi_controller+0x58: data relocation to !ENDBR: irq_chip_retrigger_hierarchy+0x0
| vmlinux.o: warning: objtool: ioapic_ir_chip+0x58: data relocation to !ENDBR: irq_chip_retrigger_hierarchy+0x0
| vmlinux.o: warning: objtool: ioapic_chip+0x58: data relocation to !ENDBR: irq_chip_retrigger_hierarchy+0x0

Mark.

