Return-Path: <linux-kernel+bounces-745483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C269B11A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E80561C80
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E0B272E4A;
	Fri, 25 Jul 2025 09:08:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5E11C84C6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753434513; cv=none; b=EJtPiZ8CKmL5nrEwphnr0vCCTlymjmyK5rnX0p80FOktKInj4IIQsjEHgrM6AgHbyuLAXSLuj24jPVDu6E+xED+68vEJeg8iYu/+pDWKL6qWa+YbLvyHCOYIZq2gtL2KiKmYXmqHIQzFP0s6mLzNE+npGgxqNWEYatGYl1K88NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753434513; c=relaxed/simple;
	bh=De6jJ9WFKxdiSckwlbxEIJ8N2MPXJWidcPZwaY2r0ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GX3K74Nf8nR+hfWg22UngihOb+NU9hS3HW9H+ZLuMjkrI3RHxcYvm9WVNg+8FbMb6mz8SycMOX04aSo1yK1xjHtTzBWQ7Lo2uIFgvc4RPapfMFcfO1uPdpFnIGCTMZX7J9XA+E6zq+cqka61+xJIk0SLfdWwxm6j3HCugtTXf70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D2F5176C;
	Fri, 25 Jul 2025 02:08:24 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B08203F66E;
	Fri, 25 Jul 2025 02:08:29 -0700 (PDT)
Date: Fri, 25 Jul 2025 10:08:23 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: build failure with crosstools gcc 15.1.0
Message-ID: <aINJh-WFKHhxZ3fW@J2N7QTR9R3>
References: <8362b484-ea77-4825-8ccb-d5acad660102@oss.qualcomm.com>
 <617201f8-1ad7-4403-b195-8c80d35ea30f@app.fastmail.com>
 <aIIOn-5Zndlb2tDG@J2N7QTR9R3>
 <b2feb2ec-9e69-4ab4-b75a-6c7f287c763d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2feb2ec-9e69-4ab4-b75a-6c7f287c763d@app.fastmail.com>

On Thu, Jul 24, 2025 at 05:37:11PM +0200, Arnd Bergmann wrote:
> On Thu, Jul 24, 2025, at 12:44, Mark Rutland wrote:
> > On Fri, Jul 04, 2025 at 03:25:49PM +0200, Arnd Bergmann wrote:
> >> On Mon, Jun 23, 2025, at 21:52, Jeff Johnson wrote:
> >> > vmlinux.o: warning: objtool: ncsi_process_next_channel() falls through 
> >> > to next function ncsi_channel_monitor.cold()
> >> > vmlinux.o: error: objtool [elf.c:1360]: elf_write: elf_update failed: 
> >> 
> >> Sorry for the late reply, have you figured it out in the meantime?
> >> 
> >> I couldn't immediately reproduce it, so it may already be fixed
> >> in linux-next.
> >
> > $ git clean -fdx
> > $ usekorg 15.1.0 make ARCH=x86_64 CROSS_COMPILE=x86_64-linux- defconfig
> > $ usekorg 15.1.0 make ARCH=x86_64 CROSS_COMPILE=x86_64-linux- -j56
> 
> This is very close to what I use. I assume you are also on an arm64
> host here?

Nope, this was on an x86-64 host running Debian 11.10.

I *DON'T* see this when building on an arm64 host running Debain 12.11,
using the (arm64 builds of) the GCC 15.1.0 binaries from kernel.org.

That suggests this is down to something on the build host. Given that
the failure is seen at a call to elf_update() (which is part of libelf):

	/* Write all changes to the file. */
	if (elf_update(elf->elf, ELF_C_WRITE) < 0) {
		ERROR_ELF("elf_update");
		return -1;
	}

... I suspect the version of libelf might have something to do with it.

The x86 host has libelf-dev 0.183-1 whereas the arm64 host has
libelf-dev 0.188-2.1, so maybe there's something added or fixed between
those versions.

Otherwise, looking at the resulting .config files, the only differences
are:

* The x86 host has:

  CONFIG_PAHOLE_VERSION=120
  CONFIG_CC_HAS_MARCH_NATIVE=y
  # CONFIG_X86_NATIVE_CPU is not set

* The arm64 host has:

  CONFIG_PAHOLE_VERSION=124

... and otherwise everything else is the same.

AFAICT, pahole shouldn't affect the build since none of the BTF options
are selected.

Mark.

