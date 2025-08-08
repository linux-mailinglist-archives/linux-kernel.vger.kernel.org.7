Return-Path: <linux-kernel+bounces-760814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4DBB1F075
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 23:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2FB05A42A6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 21:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD29126CE3D;
	Fri,  8 Aug 2025 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYbLg4Gi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB0528A714;
	Fri,  8 Aug 2025 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754690000; cv=none; b=rEvvXjPuL41rOx2Ry6p/MuS6H+9WPNIuanfS39UWbSE2L5aB7PLNtG3oHyk8QSXo/ScQ1sKy2nYRfvR4tsrnKprTzBRYNDmExZeEb11qt+BqCH0lSEKi5KEghUlNVWa0CEkhwe3dudmDFRKF0MpGNTnSIo9FhIjYHDqaEqJA0i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754690000; c=relaxed/simple;
	bh=Zod0TsMHtgwPaKwYE+/U4AqQ+FNkV4HBXTB6f91BvZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCjMVGk+qP3DYCQHuBkJhiYSjDOIxqEhTLmys4l9gdI0FLruNgGRiHcdIY4Q/LYcBM9yRUDWdjFUW1UT4Zdn2O42N1QxuPRZr6Cvjmo6YIL2e8zpFDAbiReNRIAp+QE8rA4NHHz70RkiRjXvIvGkk3Oo1GiNJt0MOLZhS4wc1n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYbLg4Gi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1511FC4CEED;
	Fri,  8 Aug 2025 21:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754689997;
	bh=Zod0TsMHtgwPaKwYE+/U4AqQ+FNkV4HBXTB6f91BvZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lYbLg4GiGw07oF2xFiGEtFahtPNaTguxQZTnzCPsaP33Ps1Sd5dpiW8Hyd5/tH5fz
	 mNwQTkVnoHd8KUZjNIK+Yrud4qzng0tU9T6Z2/wF6XCUipfQzAz+oqGlla7oRVuQKu
	 4DMlU/Mjyav39rR+6LZEtDFHTv8GCIC7FRQ6VPqWN1Y0lk9mV3Uyn4N+758nnMgSQq
	 TAfj/Ivzh7mUG6hOvUxB117SjPt3roQe5TQM7xa2+gU+P+ltdgxpem4MCU77zInFJB
	 2lVBwI+71nkOi9dtIpA/QEJjRO6cgrmZsSBJjEKfTzXiSiEzoAH4NgpaVDxE9rMWGf
	 ctO+yy1/jYC6g==
Date: Fri, 8 Aug 2025 14:53:12 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: kernel test robot <lkp@intel.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	linux-riscv@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: ld.lld: error: Function Import: link error: linking module flags
 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at
 1229286), and 'i32 1' from vmlinux.a(vma_exec.o at 1246866)
Message-ID: <20250808215312.GA3625764@ax162>
References: <202508082339.sjRnzZrX-lkp@intel.com>
 <j6pxm4n2n3tnan22x73ff3ku6dwr6e65mi4tafjmlyoicbpygi@vbjbioh7p5fx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j6pxm4n2n3tnan22x73ff3ku6dwr6e65mi4tafjmlyoicbpygi@vbjbioh7p5fx>

On Fri, Aug 08, 2025 at 10:32:01PM +0100, Pedro Falcato wrote:
> This doesn't look particularly mm related, CC'd riscv and kernel llvm lists.

Indeed, this should be avoided with [1], I just need someone in the
RISC-V space to pick it up.

https://lore.kernel.org/20250710-riscv-restrict-lto-to-medany-v1-1-b1dac9871ecf@kernel.org/

> On Sat, Aug 09, 2025 at 12:09:05AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   37816488247ddddbc3de113c78c83572274b1e2e
> > commit: dd7a6246f4fd6e8a6dcb08f1f51c899f3e0d3b83 mm: abstract initial stack setup to mm subsystem
> > date:   3 months ago
> > config: riscv-randconfig-r071-20250729 (https://download.01.org/0day-ci/archive/20250808/202508082339.sjRnzZrX-lkp@intel.com/config)
> > compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 1b4db78d2eaa070b3f364a2d2b2b826a5439b892)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250808/202508082339.sjRnzZrX-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202508082339.sjRnzZrX-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(core.o at 1243626)
> >    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(ring_buffer.o at 1239546)
> >    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(vmalloc.o at 1246746)
> >    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(memory.o at 1246026)
> >    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(main.o at 1225686)
> >    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(output.o at 1404306)
> >    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(mmap.o at 1246206)
> >    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(vma.o at 1246806)
> >    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(drm_gem.o at 1315866)
> >    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(drm_gem_shmem_helper.o at 1317846)
> >    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(virtgpu_vram.o at 1327806)
> >    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 1' from vmlinux.a(alternative.o at 1226286), and 'i32 3' from vmlinux.a(init.o at 1229286)
> >    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(direct-io.o at 1251666)
> >    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(debug_vm_pgtable.o at 1247886)
> >    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(drm_gem_dma_helper.o at 1317726)
> >    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(blk-lib.o at 1282566)
> > >> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(vma_exec.o at 1246866)
> >    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(context.o at 1229706)
> >    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(setup.o at 1226826)
> >    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(physaddr.o at 1229886)
> >    ld.lld: error: too many errors emitted, stopping now (use --error-limit=0 to see all errors)
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> -- 
> Pedro
> 

