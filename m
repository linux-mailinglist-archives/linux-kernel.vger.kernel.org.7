Return-Path: <linux-kernel+bounces-847844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 688FEBCBDFC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3212E4E4F20
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A093E257431;
	Fri, 10 Oct 2025 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QApQzuwM"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9061624466D;
	Fri, 10 Oct 2025 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760080238; cv=none; b=hBRbwgoE7HWZjHAnF3obRtbQixDMe00HOicJ9KvOgNdrf60F2DC2E//fP5wnPpcWB25vcHAViimqjbpb9broHDlGOACWLY43I53HfOdVPF8lkBu4jL+DSQ/b4fEMdDCXVjKsAv7RJZTiW7ATfOlfkjhf/XdtXdW3huzXruQPm+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760080238; c=relaxed/simple;
	bh=zF+0z316RJQl9MIvnx3TLWdplqoKjE8A6iD22i2AB14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVGJ2yO/4TbQUmkrqA5/rCgM/0JrQdhNTK04iSJD7oqAiElSSmedMMKp4oHwRbWe93tECKQLkB2qgM17jMX8fFM86COPds85xdpneZhCN/QxYmHmCsCs0Bai/H8XFbgmajDfdqgNT2GonHpBV8dcoxynQ3CKDaKPC8FPFHvzGEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QApQzuwM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=50y4dNqj3cTwICK+6pWktLMc2B7J6SPVStSqB8mkboA=; b=QApQzuwMjpDeLWln5BMhThjrrd
	Seb/MnniOXasfRoosZ8SLuy/6gZ0KLOb0kozIwOLFoZ7VI9BH9OIj7Qf/yEWRAeRjmCMxTFzeTRmQ
	HXAmk7Amb6EiklIJR/i5hbjTWnQXSO6wCoHmHPLISc13Zi6jnyJ2HuaUiGahTiyNvcpeNzQjBLHbN
	0aZreBgS2ODsabnvENo6tJvXOdFmhy/iWbhhJPAX+ix32QkKgPeqTx/TunwL3O41pvy/z+M4h3Owm
	cAsSSb+y3vosWs0lskrezIeKPRQDmTS+V3HDd5zc7RqJI7CN1twkP9DhzljIqrVWv71ocl0x+ijox
	J7PM9ClA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v77Gq-00000006PCr-1KbF;
	Fri, 10 Oct 2025 07:10:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8352A300325; Fri, 10 Oct 2025 09:10:32 +0200 (CEST)
Date: Fri, 10 Oct 2025 09:10:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [tip:x86/core 1/1] vmlinux.o: warning: objtool:
 rcar_pcie_probe+0x13e: no-cfi indirect call!
Message-ID: <20251010071032.GE4067720@noisy.programming.kicks-ass.net>
References: <202510092124.O2IX0Jek-lkp@intel.com>
 <20251010032001.GA3741500@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010032001.GA3741500@ax162>

On Thu, Oct 09, 2025 at 08:20:01PM -0700, Nathan Chancellor wrote:
> Hi Peter,
> 
> On Thu, Oct 09, 2025 at 09:07:02PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
> > head:   6c6e6a5416471498d8aafc050110bec9467e4da7
> > commit: 6c6e6a5416471498d8aafc050110bec9467e4da7 [1/1] Merge branch 'linus' into x86/core, to resolve conflicts
> 
> It appears that this got bisected to the merge because the configuration
> has CONFIG_CFI=y, which needs the rename that is in Linus's tree. This
> is reproducible with just commit 894af4a1cde6 ("objtool: Validate kCFI
> calls") cherry-picked onto 6.17 and CONFIG_CFI_CLANG=y in the config
> provided at the link below.
> 
> > config: x86_64-buildonly-randconfig-001-20251009 (https://download.01.org/0day-ci/archive/20251009/202510092124.O2IX0Jek-lkp@intel.com/config)
> > compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251009/202510092124.O2IX0Jek-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202510092124.O2IX0Jek-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> vmlinux.o: warning: objtool: rcar_pcie_probe+0x13e: no-cfi indirect call!
> 
> I do see an indirect call in rcar_pcie_probe() with ->host_init_fn() but
> rcar_pcie_probe() is not __nocfi... +0x13e is 0x8d9d7e in this build.
> 
>     8d9d6f: 31 c0                         xorl    %eax, %eax
>     8d9d71: 49 89 86 58 06 00 00          movq    %rax, 0x658(%r14)
>     8d9d78: 4c 89 ff                      movq    %r15, %rdi
>     8d9d7b: 45 31 db                      xorl    %r11d, %r11d
>     8d9d7e: 2e e8 00 00 00 00             callq   0x8d9d84 <rcar_pcie_probe+0x144>
>                   00000000008d9d80:  R_X86_64_PLT32       __x86_indirect_thunk_r11-0x4
> 
> Is this an issue with the objtool check or is clang not generating the
> right code?

So going by the asm above, objtool is right, this is not a CFI adorned
indirect call.

Let me go build this thing.

