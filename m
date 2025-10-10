Return-Path: <linux-kernel+bounces-847895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF4DBCBF7A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D961A63A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BDE275AF5;
	Fri, 10 Oct 2025 07:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mtrBsNhF"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C6F246781;
	Fri, 10 Oct 2025 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082297; cv=none; b=Becs6q6JIV8ZylFUDRccKDEiEiWm6n+DXJI4Ez29xnpseUAsDJoct2HeQnXylaSdsr7Ma6ng1eFc3ilLES1LXLGKKOBqYj+qjeKTh8kWuP1D+wMcXM3gt5ZhqxvngeQFGPnMNrbWSFh939KhWVThVxTtIVW4dps3BrCCVLCAo+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082297; c=relaxed/simple;
	bh=dIEKw0UgtQ93sxbcV1jJBVY27LExqBd/jzcCwNehvRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8Yyslnmm683ykh9KY4oIzc67Oq8dQzXLQorFZaYy6Kg6qW691yTSzMeOideQhJvaekRMlay9O9sM0Ivhs5jWyk6EE18huM4ti/qajybAgTApqU5iPk+dHfxDqPoOiOzByPHhwQYQ2nrXfoLqysokJsvuoQKWEvG49r3PJSYYq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mtrBsNhF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gFu37tvtgN2v/29Zpl4wxrROH3QP1TBb69gJu8pDoFA=; b=mtrBsNhFP+HwwGZFXQMgSDdZHw
	Q6g8uonli6zK7gUQPEkReho2zkya4gQ7JFnzzguDMj1RV9NQEtCC5j6cD1g+EpnvpBen0ehptgImr
	3re0uNEnCpghnZhKbCVI22ayMtDhlAVZueD9SzjrolgcRQCQdQeFMLs/YCNCKYR481Cot7XZjkyKQ
	MSePUt5iEEnnlRRBzABXCx2P7j/xFIoMIPtc23jk3uSCnyT6uoz9oH+srb8oG4rHUB9fPSQB/vhav
	jnj3Zx3eNlE4uxXZbT7qQeOIGFUhsGu2WtXnHm9lg0F9jBRCZbOnvLZzXAOwD5TjQJ4jKWI2bctIx
	8GLwAWhg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v77nz-000000020BO-1fEI;
	Fri, 10 Oct 2025 07:44:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 74D9630023C; Fri, 10 Oct 2025 09:44:46 +0200 (CEST)
Date: Fri, 10 Oct 2025 09:44:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [tip:x86/core 1/1] vmlinux.o: warning: objtool:
 rcar_pcie_probe+0x13e: no-cfi indirect call!
Message-ID: <20251010074446.GE4068168@noisy.programming.kicks-ass.net>
References: <202510092124.O2IX0Jek-lkp@intel.com>
 <20251010032001.GA3741500@ax162>
 <20251010071032.GE4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010071032.GE4067720@noisy.programming.kicks-ass.net>

On Fri, Oct 10, 2025 at 09:10:32AM +0200, Peter Zijlstra wrote:
> On Thu, Oct 09, 2025 at 08:20:01PM -0700, Nathan Chancellor wrote:
> > Hi Peter,
> > 
> > On Thu, Oct 09, 2025 at 09:07:02PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
> > > head:   6c6e6a5416471498d8aafc050110bec9467e4da7
> > > commit: 6c6e6a5416471498d8aafc050110bec9467e4da7 [1/1] Merge branch 'linus' into x86/core, to resolve conflicts
> > 
> > It appears that this got bisected to the merge because the configuration
> > has CONFIG_CFI=y, which needs the rename that is in Linus's tree. This
> > is reproducible with just commit 894af4a1cde6 ("objtool: Validate kCFI
> > calls") cherry-picked onto 6.17 and CONFIG_CFI_CLANG=y in the config
> > provided at the link below.
> > 
> > > config: x86_64-buildonly-randconfig-001-20251009 (https://download.01.org/0day-ci/archive/20251009/202510092124.O2IX0Jek-lkp@intel.com/config)
> > > compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251009/202510092124.O2IX0Jek-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202510092124.O2IX0Jek-lkp@intel.com/
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > > >> vmlinux.o: warning: objtool: rcar_pcie_probe+0x13e: no-cfi indirect call!
> > 
> > I do see an indirect call in rcar_pcie_probe() with ->host_init_fn() but
> > rcar_pcie_probe() is not __nocfi... +0x13e is 0x8d9d7e in this build.
> > 
> >     8d9d6f: 31 c0                         xorl    %eax, %eax
> >     8d9d71: 49 89 86 58 06 00 00          movq    %rax, 0x658(%r14)
> >     8d9d78: 4c 89 ff                      movq    %r15, %rdi
> >     8d9d7b: 45 31 db                      xorl    %r11d, %r11d
> >     8d9d7e: 2e e8 00 00 00 00             callq   0x8d9d84 <rcar_pcie_probe+0x144>
> >                   00000000008d9d80:  R_X86_64_PLT32       __x86_indirect_thunk_r11-0x4
> > 
> > Is this an issue with the objtool check or is clang not generating the
> > right code?
> 
> So going by the asm above, objtool is right, this is not a CFI adorned
> indirect call.
> 
> Let me go build this thing.

vmlinux.o: warning: objtool: rcar_pcie_probe+0x13e: no-cfi indirect call!

$ ./scripts/objdump-func tmp-build/vmlinux.o rcar_pcie_probe
0000 00000000008c7a20 <rcar_pcie_probe>:
0000   8c7a20:  f3 0f 1e fa             endbr64
0004   8c7a24:  0f 1f 44 00 00          nopl   0x0(%rax,%rax,1) 8c7a25: R_X86_64_NONE   __fentry__-0x4
0009   8c7a29:  55                      push   %rbp
000a   8c7a2a:  41 57                   push   %r15
000c   8c7a2c:  41 56                   push   %r14
000e   8c7a2e:  41 55                   push   %r13
0010   8c7a30:  41 54                   push   %r12
0012   8c7a32:  53                      push   %rbx
0013   8c7a33:  49 89 fc                mov    %rdi,%r12
0016   8c7a36:  48 8d 5f 10             lea    0x10(%rdi),%rbx
001a   8c7a3a:  be 20 01 00 00          mov    $0x120,%esi
001f   8c7a3f:  48 89 df                mov    %rbx,%rdi
0022   8c7a42:  e8 00 00 00 00          call   8c7a47 <rcar_pcie_probe+0x27>    8c7a43: R_X86_64_PLT32  devm_pci_alloc_host_bridge-0x4
0027   8c7a47:  48 85 c0                test   %rax,%rax
002a   8c7a4a:  0f 84 74 01 00 00       je     8c7bc4 <rcar_pcie_probe+0x1a4>
0030   8c7a50:  49 89 c6                mov    %rax,%r14
0033   8c7a53:  4c 8d b8 40 05 00 00    lea    0x540(%rax),%r15
003a   8c7a5a:  4c 89 ff                mov    %r15,%rdi
003d   8c7a5d:  e8 00 00 00 00          call   8c7a62 <rcar_pcie_probe+0x42>    8c7a5e: R_X86_64_PLT32  __tsan_write8-0x4
0042   8c7a62:  49 89 9e 40 05 00 00    mov    %rbx,0x540(%r14)
0049   8c7a69:  49 8d bc 24 88 00 00 00         lea    0x88(%r12),%rdi
0051   8c7a71:  e8 00 00 00 00          call   8c7a76 <rcar_pcie_probe+0x56>    8c7a72: R_X86_64_PLT32  __tsan_write8-0x4
0056   8c7a76:  4d 89 bc 24 88 00 00 00         mov    %r15,0x88(%r12)
005e   8c7a7e:  45 31 ed                xor    %r13d,%r13d
0061   8c7a81:  4d 8b a5 00 00 00 00    mov    0x0(%r13),%r12   8c7a84: R_X86_64_32S    .rodata+0x587390
0068   8c7a88:  48 89 df                mov    %rbx,%rdi
006b   8c7a8b:  4c 89 e6                mov    %r12,%rsi
006e   8c7a8e:  e8 00 00 00 00          call   8c7a93 <rcar_pcie_probe+0x73>    8c7a8f: R_X86_64_PLT32  devm_regulator_get_enable_optional-0x4
0073   8c7a93:  85 c0                   test   %eax,%eax
0075   8c7a95:  0f 99 c1                setns  %cl
0078   8c7a98:  83 f8 ed                cmp    $0xffffffed,%eax
007b   8c7a9b:  0f 94 c2                sete   %dl
007e   8c7a9e:  08 ca                   or     %cl,%dl
0080   8c7aa0:  0f 84 25 01 00 00       je     8c7bcb <rcar_pcie_probe+0x1ab>
0086   8c7aa6:  49 83 c5 08             add    $0x8,%r13
008a   8c7aaa:  49 83 fd 18             cmp    $0x18,%r13
008e   8c7aae:  75 d1                   jne    8c7a81 <rcar_pcie_probe+0x61>
0090   8c7ab0:  4c 89 ff                mov    %r15,%rdi
0093   8c7ab3:  e8 00 00 00 00          call   8c7ab8 <rcar_pcie_probe+0x98>    8c7ab4: R_X86_64_PLT32  __tsan_read8-0x4
0098   8c7ab8:  49 8b 3f                mov    (%r15),%rdi
009b   8c7abb:  e8 00 00 00 00          call   8c7ac0 <rcar_pcie_probe+0xa0>    8c7abc: R_X86_64_PLT32  pm_runtime_enable-0x4
00a0   8c7ac0:  4c 89 ff                mov    %r15,%rdi
00a3   8c7ac3:  e8 00 00 00 00          call   8c7ac8 <rcar_pcie_probe+0xa8>    8c7ac4: R_X86_64_PLT32  __tsan_read8-0x4
00a8   8c7ac8:  49 8b 3f                mov    (%r15),%rdi
00ab   8c7acb:  be 04 00 00 00          mov    $0x4,%esi
00b0   8c7ad0:  e8 00 00 00 00          call   8c7ad5 <rcar_pcie_probe+0xb5>    8c7ad1: R_X86_64_PLT32  __pm_runtime_resume-0x4
00b5   8c7ad5:  89 c5                   mov    %eax,%ebp
00b7   8c7ad7:  4c 89 ff                mov    %r15,%rdi
00ba   8c7ada:  e8 00 00 00 00          call   8c7adf <rcar_pcie_probe+0xbf>    8c7adb: R_X86_64_PLT32  __tsan_read8-0x4
00bf   8c7adf:  49 8b 3f                mov    (%r15),%rdi
00c2   8c7ae2:  85 ed                   test   %ebp,%ebp
00c4   8c7ae4:  0f 88 09 01 00 00       js     8c7bf3 <rcar_pcie_probe+0x1d3>
00ca   8c7aea:  48 c7 c6 00 00 00 00    mov    $0x0,%rsi        8c7aed: R_X86_64_32S    .rodata.str1.1+0x101fe2
00d1   8c7af1:  e8 00 00 00 00          call   8c7af6 <rcar_pcie_probe+0xd6>    8c7af2: R_X86_64_PLT32  devm_phy_optional_get-0x4
00d6   8c7af6:  49 89 c4                mov    %rax,%r12
00d9   8c7af9:  49 8d be 50 05 00 00    lea    0x550(%r14),%rdi
00e0   8c7b00:  e8 00 00 00 00          call   8c7b05 <rcar_pcie_probe+0xe5>    8c7b01: R_X86_64_PLT32  __tsan_write8-0x4
00e5   8c7b05:  4d 89 a6 50 05 00 00    mov    %r12,0x550(%r14)
00ec   8c7b0c:  49 81 fc 01 f0 ff ff    cmp    $0xfffffffffffff001,%r12
00f3   8c7b13:  bd ea ff ff ff          mov    $0xffffffea,%ebp
00f8   8c7b18:  41 0f 43 ec             cmovae %r12d,%ebp
00fc   8c7b1c:  85 ed                   test   %ebp,%ebp
00fe   8c7b1e:  0f 88 dd 00 00 00       js     8c7c01 <rcar_pcie_probe+0x1e1>
0104   8c7b24:  48 c7 c7 00 00 00 00    mov    $0x0,%rdi        8c7b27: R_X86_64_32S    .rodata.str1.1+0x132d1d
010b   8c7b2b:  be 4a 01 00 00          mov    $0x14a,%esi
0110   8c7b30:  e8 00 00 00 00          call   8c7b35 <rcar_pcie_probe+0x115>   8c7b31: R_X86_64_PLT32  __might_sleep-0x4
0115   8c7b35:  4c 89 ff                mov    %r15,%rdi
0118   8c7b38:  e8 ee 00 00 00          call   8c7c2b <rcar_pcie_parse_map_dma_ranges>
011d   8c7b3d:  89 c5                   mov    %eax,%ebp
011f   8c7b3f:  85 c0                   test   %eax,%eax
0121   8c7b41:  75 21                   jne    8c7b64 <rcar_pcie_probe+0x144>
0123   8c7b43:  49 8d be 58 06 00 00    lea    0x658(%r14),%rdi
012a   8c7b4a:  e8 00 00 00 00          call   8c7b4f <rcar_pcie_probe+0x12f>   8c7b4b: R_X86_64_PLT32  __tsan_write8-0x4
012f   8c7b4f:  31 c0                   xor    %eax,%eax
0131   8c7b51:  49 89 86 58 06 00 00    mov    %rax,0x658(%r14)
0138   8c7b58:  4c 89 ff                mov    %r15,%rdi
013b   8c7b5b:  45 31 db                xor    %r11d,%r11d
013e   8c7b5e:  2e e8 00 00 00 00       cs call 8c7b64 <rcar_pcie_probe+0x144>  8c7b60: R_X86_64_PLT32  __x86_indirect_thunk_r11-0x4

That's here... and that is indeed broken. Also note how it zeros r11
right before calling it.

AFAICT this is:

        host->phy_init_fn = of_device_get_match_data(dev);
        err = host->phy_init_fn(host);

Where it has decided that of_device_get_match_data() *will* return NULL
and then helpfully emits (*NULL)(); or something like that. And then
forgets to add CFI bits on for extra fun and games.



Anyway, look at the output of:

$ objdump -wdr defconfig-build/vmlinux.o | grep -C 10 __x86_indirect_thunk_r11

      57:       41 ba 40 2f 74 0e       mov    $0xe742f40,%r10d
      5d:       45 03 53 f1             add    -0xf(%r11),%r10d
      61:       74 02                   je     65 <__traceiter_initcall_level+0x55>
      63:       0f 0b                   ud2
      65:       2e e8 00 00 00 00       cs call 6b <__traceiter_initcall_level+0x5b>    67: R_X86_64_PLT32      __x86_indirect_thunk_r11-0x4

     107:       41 ba f6 c0 b9 f6       mov    $0xf6b9c0f6,%r10d
     10d:       45 03 53 f1             add    -0xf(%r11),%r10d
     111:       74 02                   je     115 <__traceiter_initcall_start+0x55>
     113:       0f 0b                   ud2
     115:       2e e8 00 00 00 00       cs call 11b <__traceiter_initcall_start+0x5b>   117: R_X86_64_PLT32     __x86_indirect_thunk_r11-0x4

     1bd:       41 ba cc ca 37 0d       mov    $0xd37cacc,%r10d
     1c3:       45 03 53 f1             add    -0xf(%r11),%r10d
     1c7:       74 02                   je     1cb <__traceiter_initcall_finish+0x5b>
     1c9:       0f 0b                   ud2
     1cb:       2e e8 00 00 00 00       cs call 1d1 <__traceiter_initcall_finish+0x61>  1cd: R_X86_64_PLT32     __x86_indirect_thunk_r11-0x4

etc..

That is the expected pattern for a CFI adorned indirect call. In
particular objtool checks for that 'ud2' being there. 

