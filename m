Return-Path: <linux-kernel+bounces-735098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF27B08AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CF117D7FD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542B829A303;
	Thu, 17 Jul 2025 10:39:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E9728B417;
	Thu, 17 Jul 2025 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748748; cv=none; b=LmxhE5vieZquZTEitOKLFxMwsieNo4o1IFbc+9e4iqaYM+3wtQWtnSBmdptwerhe/geHWCycGGAKrxXJ5bJRU0Lz23ER/DDPGHpWS16Jt8hbPoubOvpStprfnMdSMYKunG2ocJyNUmz509k0fnA6H7dGa1eTMsCGHvwRrH+S29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748748; c=relaxed/simple;
	bh=5kckD7qWJjoNwwtUMh9lLheMb6Y+w5XdwJimULnKoj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMdayJHVneybGhsV1eqHi77V1sWLJOCgN/J18p6bl4br2MRK5iqii85tKDZ1JOl4EldoMgBbfXI+U9iLFn7WDOiOPe1VvJ3InVn48hmeW93ezn4y0UU1X3VvRPDpPBgp8PYjE8Abwcz+wKrOvxBLouOVpe0jUkVep13SeKPj8Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8FEF1596;
	Thu, 17 Jul 2025 03:38:57 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A4393F6A8;
	Thu, 17 Jul 2025 03:39:03 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:38:56 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: =?utf-8?B?5YiY5rW354eVIChIYWl5YW4gTGl1KQ==?= <haiyan.liu@unisoc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	=?utf-8?B?5Luj5a2Q5Li6IChaaXdlaSBEYWkp?= <Ziwei.Dai@unisoc.com>,
	=?utf-8?B?5ZGo5bmzIChQaW5nIFpob3UvOTAzMik=?= <Ping.Zhou1@unisoc.com>,
	=?utf-8?B?5p2o5Li95aicIChMaW5hIFlhbmcp?= <lina.yang@unisoc.com>,
	=?utf-8?B?546L5Y+MIChTaHVhbmcgV2FuZyk=?= <shuang.wang@unisoc.com>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Matthew Maurer <mmaurer@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Subject: Re: Meet compiled kernel binaray abnormal issue while enabling
 generic kasan in kernel 6.12 with some default KBUILD_RUSTFLAGS on
Message-ID: <aHjSwCK98Bpgu_jb@J2N7QTR9R3>
References: <4c459085b9ae42bdbf99b6014952b965@BJMBX01.spreadtrum.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c459085b9ae42bdbf99b6014952b965@BJMBX01.spreadtrum.com>

Hi,

From a quick scan, I think this might have something to do with
UNWIND_PATCH_PAC_INTO_SCS, notes below.

On Mon, Jul 14, 2025 at 03:12:33AM +0000, 刘海燕 (Haiyan Liu) wrote:
> I am enabling generic kasan feature in kernel 6.12, and met kernel boot crash.
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> pc : do_basic_setup+0x6c/0xac
> lr : do_basic_setup+0x88/0xac
> sp : ffffffc080087e40

Can you say which hardware this is on? Given this is a NULL-dereference,
this looks ike a dodgy pointer (or memory corruption) rather than a PAC
failure.

> After debug, I find some error in do_ctors().
> Normally, the complier should insert the paciasp instruction at the function entry so that its corresponding autiasp instruction is used to validate the return address when the function returns.
> NSX:FFFFFFC0800A840C|F800865E     asan.module_ctor:   str  x30,[x18],#0x8；x30,[x18],#8
> NSX:FFFFFFC0800A8410|A9BF7BFD                       stp     x29,x30,[sp,#-0x10]!   ; x29,x30,[sp,#-16]!
> NSX:FFFFFFC0800A8414|910003FD                       mov     x29,sp
> NSX:FFFFFFC0800A8418|B0023420                       adrp    x0,0xFFFFFFC08472D000
> NSX:FFFFFFC0800A841C|91390000                       add     x0,x0,#0xE40     ; x0,x0,#3648
> NSX:FFFFFFC0800A8420|528000A1                       mov     w1,#0x5          ; w1,#5
> NSX:FFFFFFC0800A8424|9422AF50                       bl      0xFFFFFFC080954164   ; __asan_register_globals
> NSX:FFFFFFC0800A8428|A8C17BFD                       ldp     x29,x30,[sp],#0x10   ; x29,x30,[sp],#16
> NSX:FFFFFFC0800A842C|F85F8E5E                       ldr     x30,[x18,#-0x8]!   ; x30,[x18,#-8]!    
> NSX:FFFFFFC0800A8430|D65F03C0                       ret

Here you evidently have shadow call stack enabled...

> NSX:FFFFFFC0800A8478|D503233F  asan.module_ctor:    paciasp                                         
> NSX:FFFFFFC0800A847C|A9BF7BFD                       stp     x29,x30,[sp,#-0x10]!   ; x29,x30,[sp,#-16]!
> NSX:FFFFFFC0800A8480|910003FD                       mov     x29,sp
> NSX:FFFFFFC0800A8484|B0023420                       adrp    x0,0xFFFFFFC08472D000
> NSX:FFFFFFC0800A8488|913E0000                       add     x0,x0,#0xF80     ; x0,x0,#3968
> NSX:FFFFFFC0800A848C|52800021                       mov     w1,#0x1          ; w1,#1
> NSX:FFFFFFC0800A8490|9422AF35                       bl      0xFFFFFFC080954164   ; __asan_register_globals
> NSX:FFFFFFC0800A8494|A8C17BFD                       ldp     x29,x30,[sp],#0x10   ; x29,x30,[sp],#16
> NSX:FFFFFFC0800A8498|D50323BF                       autiasp                                         
> NSX:FFFFFFC0800A849C|D65F03C0                       ret

... but here you evidently don't, and have PAC instead.

Are these from the same kernel Image?

Are these decoded from the static kernel binary, or are these dumps from
memory once a kernel has booted (or is in the process of booting)?

> But actually, in two asan.module_ctor functions, there is only autiasp  instruction inserted before return, for validation of return address, while paciasp instruction is missing before.
> NSX:FFFFFFC0800A72D8|F800865E  asan.module_ctor:    str     x30,[x18],#0x8   ; x30,[x18],#8          
> NSX:FFFFFFC0800A72DC|F81F0FFE                       str     x30,[sp,#-0x10]!   ; x30,[sp,#-16]!
> NSX:FFFFFFC0800A72E0|B00233C0                       adrp    x0,0xFFFFFFC084720000
> NSX:FFFFFFC0800A72E4|91350000                       add     x0,x0,#0xD40     ; x0,x0,#3392
> NSX:FFFFFFC0800A72E8|52803D61                       mov     w1,#0x1EB        ; w1,#491
> NSX:FFFFFFC0800A72EC|9422B39E                       bl      0xFFFFFFC080954164   ; __asan_register_globals
> NSX:FFFFFFC0800A72F0|F84107FE                       ldr     x30,[sp],#0x10   ; x30,[sp],#16
> NSX:FFFFFFC0800A72F4|D50323BF                       autiasp                                         
> NSX:FFFFFFC0800A72F8|D65F03C0                       ret

Thas has a mixture of SCS and PAC; there's a shadow call stack prologue
but a PAC epilogue:

	str     x30, [x18], #8	// SCS
	...
	autiasp                 // PAC

... so I'll hazard a guess that these are dumps from memory, and you
have UNWIND_PATCH_PAC_INTO_SCS selected. Assuming that is the case,
either this dump has been made mid-patching, or the patching has gone
wrong somehow and left the prologues/epilogues in an inconsistent state
(and the NULL dereference could be a secondary effect of that).

Ard, does that sound plausible to you?

I can't see why that would depend on KBUILD_RUSTFLAGS, but maybe the
DWARF generated by rustc has confused the patching code somehow, or the
linker has aggregated that in a suprising way.

Mark.

> NSX:FFFFFFC0800A7390|F800865E  asan.module_ctor:    str     x30,[x18],#0x8   ; x30,[x18],#8          
> NSX:FFFFFFC0800A7394|F81F0FFE                       str     x30,[sp,#-0x10]!   ; x30,[sp,#-16]!
> NSX:FFFFFFC0800A7398|B0023400                       adrp    x0,0xFFFFFFC084728000
> NSX:FFFFFFC0800A739C|91210000                       add     x0,x0,#0x840     ; x0,x0,#2112
> NSX:FFFFFFC0800A73A0|528006E1                       mov     w1,#0x37         ; w1,#55
> NSX:FFFFFFC0800A73A4|9422B370                       bl      0xFFFFFFC080954164   ; __asan_register_globals
> NSX:FFFFFFC0800A73A8|F84107FE                       ldr     x30,[sp],#0x10   ; x30,[sp],#16
> NSX:FFFFFFC0800A73AC|D50323BF                       autiasp                                          
> NSX:FFFFFFC0800A73B0|D65F03C0                       ret
> 
> I compare kernel 6.6 and kernel 6.12 ARM Makefile, and find the difference.
> Kernel6.6 Makefile
> 66 ifeq ($(CONFIG_ARM64_BTI_KERNEL),y)
> 67   KBUILD_CFLAGS += -mbranch-protection=pac-ret+bti
> 68 else ifeq ($(CONFIG_ARM64_PTR_AUTH_KERNEL),y)
> 69   ifeq ($(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET),y)
> 70     KBUILD_CFLAGS += -mbranch-protection=pac-ret
> 71   else
> 72     KBUILD_CFLAGS += -msign-return-address=non-leaf
> 73   endif
> 74 else
> 75   KBUILD_CFLAGS += $(call cc-option,-mbranch-protection=none)
> 76 endif
> 
> Kernel6.12  Makefile
> 81 ifeq ($(CONFIG_ARM64_BTI_KERNEL),y)
> 82   KBUILD_CFLAGS += -mbranch-protection=pac-ret+bti
> 83   KBUILD_RUSTFLAGS += -Zbranch-protection=bti,pac-ret                                 
> 84 else ifeq ($(CONFIG_ARM64_PTR_AUTH_KERNEL),y)
> 85   KBUILD_RUSTFLAGS += -Zbranch-protection=pac-ret                                   
> 86   ifeq ($(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET),y)
> 87     KBUILD_CFLAGS += -mbranch-protection=pac-ret
> 88   else
> 89     KBUILD_CFLAGS += -msign-return-address=non-leaf
> 90   endif
> 91 else
> 92   KBUILD_CFLAGS += $(call cc-option,-mbranch-protection=none)
> 93 endif
> 
> After I delete the rust build flags, the asan.module_ctor binary is right and kasan feature works fine.Could you help check why KBUILD_RUSTFLAGS impacts kernel complication with kasan feature enabled and how can this issue fixed?
> 
> I use the build.config.constants:
> BRANCH=android16-6.12
> KMI_GENERATION=4
> CLANG_VERSION=r536225
> RUSTC_VERSION=1.82.0
> AARCH64_NDK_TRIPLE=aarch64-linux-android31
> X86_64_NDK_TRIPLE=x86_64-linux-android31
> ARM_NDK_TRIPLE=arm-linux-androideabi31
> 
> compile configuration is :
> CONFIG_GCC_VERSION=0
> CONFIG_CC_IS_CLANG=y
> CONFIG_CLANG_VERSION=190001
> CONFIG_AS_IS_LLVM=y
> CONFIG_AS_VERSION=190001
> CONFIG_LD_VERSION=0
> CONFIG_LD_IS_LLD=y
> CONFIG_LLD_VERSION=190001
> CONFIG_RUSTC_VERSION=108200
> CONFIG_RUST_IS_AVAILABLE=y
> CONFIG_RUSTC_LLVM_VERSION=190001
> CONFIG_CC_CAN_LINK=y
> CONFIG_CC_CAN_LINK_STATIC=y
> CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
> CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
> CONFIG_TOOLS_SUPPORT_RELR=y
> CONFIG_CC_HAS_ASM_INLINE=y
> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
> CONFIG_PAHOLE_VERSION=125
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_TABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> Thank you

