Return-Path: <linux-kernel+bounces-849182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4DFBCF5E2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 15:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC91189D23F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF1027B359;
	Sat, 11 Oct 2025 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="e6N2Tr+U"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5A32773E2
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760190411; cv=none; b=DrC5wjlzB/gWNLQkcIuaAjokhGs4tpOgofy2W1Ftrf1pWDW9UzFCTmNjqslUtBGgqblqmDmrk+Di8yjdnbMiDk5bkOABmkEo3ITuzjvcsRmdbIGeENOfEwwpqYr/U32bhJTP3IYwqE6wtdAdG5ckegqJ5jqgeOIo5BaHUsfrSNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760190411; c=relaxed/simple;
	bh=N/LMxeTKVXrccVzP3tfzuFxDtYFMYGWfk9mJJCix9k0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WDp7qxno5pQZvdGJPi8fNMLXylNVdIEBRAxAI9RNa8t0u5fiB76BJ68v52AO673LG5bglfO5WxyCLBiSwjFLFPTNWbH5CLojWHlo5DKdQOuqumLlZ+vqoxtRUCYl1JP4kGuCQgIweF1HoFe3Qm+sHBpgQVVMKROjKyxTQ18EIQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=e6N2Tr+U; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4D1BA40E015F;
	Sat, 11 Oct 2025 13:46:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jZ7IN20QcOIj; Sat, 11 Oct 2025 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760190400; bh=/sVl2/GstcWbov7L9Ofhuk/HOeNcdKt3nIfEUpH+qCk=;
	h=Date:From:To:Cc:Subject:From;
	b=e6N2Tr+UAYYV3WjsmZGTBGtMsxR9wUGjUQe0r5DiJLmrM0j+xe23pAe3rpEsBMbRS
	 kxso5++ZO1SBc2MLIoded7wqWts9zR90yKpDfBNwT6iVdTOLQafOAva+BAZEIyES92
	 rqTSA+TX6fByZO19zazyzSHQkps732U57cQXU7AQvbIg41xL09uWFZLX9shfadKTXZ
	 mA3t3ildD0CsbBx5A4KKsazBJBv4MZl7JCbDsO8fWfk64N+sS3c+/jNeoXGSQrfJaZ
	 CPKLOTtBCjLF1o/4LNXLg84ZHaYcuuYHly2CeK5oVhbKNDFghRBTVcLDpZdPXq4SzU
	 IH1dOBv9czUwhQA3uv5HPRbtZHfshWTbnYTFDoB+ZKEbIqIiZX2vdfUQFl0UhyPEvl
	 5mmBcjgFt3aGt3/O3PVg7U5cRXf//vEHFylpGFOYNbCXYrBOpXp8hkm9ZeDeMKEryX
	 5z29AIKX5qqOw/0K37wB8tc+0nXSFznHe/M6gK3tp7GliMcsLFtORu8pRXs8nzFkO/
	 lvZR7uVy9EAQJ0VLEpX7ML5uUEridjmoR7EtcVq4ujvWqERN4IFa9kbCG1lr4lba09
	 FJQyCuWdclhKyK+P4OGIqUJM7smZk9Woe5uzZyk/RHkVexseOGVADMzdRV3kwdWKnb
	 6ixKWBdr1eVzYI72pW1ariAE=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7483240E00DA;
	Sat, 11 Oct 2025 13:46:37 +0000 (UTC)
Date: Sat, 11 Oct 2025 15:46:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/core for v6.18-rc1
Message-ID: <20251011134629.GAaOpftWmLdD6L7bJn@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull one more belated x86/core lineup for v6.18-rc1.

The pile conflicts with your tree but not too badly. I've added a merge
conflict resolution I've done locally, at the end of this mail to compare
notes.

Thx.

---

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_core_for_v6.18_rc1

for you to fetch changes up to 4a1e02b15ac174c3c6d5e358e67c4ba980e7b336:

  x86,retpoline: Optimize patch_retpoline() (2025-09-04 21:59:09 +0200)

----------------------------------------------------------------
- Remove a bunch of asm implementing condition flags testing in KVM's
  emulator in favor of int3_emulate_jcc() which is written in C

- Replace KVM fastops with C-based stubs which avoids problems with the
  fastop infra related to latter not adhering to the C ABI due to their
  special calling convention and, more importantly, bypassing compiler
  control-flow integrity checking because they're written in asm

- Remove wrongly used static branches and other ugliness accumulated
  over time in hyperv's hypercall implementation with a proper static
  function call to the correct hypervisor call variant

- Add some fixes and modifications to allow running FRED-enabled kernels
  in KVM even on non-FRED hardware

- Add kCFI improvements like validating indirect calls and prepare for
  enabling kCFI with GCC. Add cmdline params documentation and other
  code cleanups

- Use the single-byte 0xd6 insn as the official #UD single-byte
  undefined opcode instruction as agreed upon by both x86 vendors

- Other smaller cleanups and touchups all over the place

----------------------------------------------------------------
Josh Poimboeuf (1):
      x86/fred: Play nice with invoking asm_fred_entry_from_kvm() on non-FRED hardware

Kees Cook (6):
      compiler_types.h: Move __nocfi out of compiler-specific header
      x86/traps: Clarify KCFI instruction layout
      x86/cfi: Document the "cfi=" bootparam options
      x86/cfi: Standardize on common "CFI:" prefix for CFI reports
      x86/cfi: Add "debug" option to "cfi=" bootparam
      x86/cfi: Remove __noinitretpoline and __noretpoline

Peter Zijlstra (15):
      KVM: x86: Implement test_cc() in C
      KVM: x86: Introduce EM_ASM_1
      KVM: x86: Introduce EM_ASM_2
      KVM: x86: Introduce EM_ASM_2R
      KVM: x86: Introduce EM_ASM_2W
      KVM: x86: Introduce EM_ASM_2CL
      KVM: x86: Introduce EM_ASM_1SRC2
      KVM: x86: Introduce EM_ASM_3WCL
      KVM: x86: Convert em_salc() to C
      KVM: x86: Remove fastops
      x86/hyperv: Clean up hv_do_hypercall()
      x86/hyperv: Use direct call to hypercall-page
      objtool: Validate kCFI calls
      x86,ibt: Use UDB instead of 0xEA
      x86,retpoline: Optimize patch_retpoline()

Sean Christopherson (2):
      x86/fred: Install system vector handlers even if FRED isn't fully enabled
      x86/fred: KVM: VMX: Always use FRED for IRQs when CONFIG_X86_FRED=y

 Documentation/admin-guide/kernel-parameters.txt |  18 +
 arch/x86/entry/calling.h                        |  11 +-
 arch/x86/entry/entry_64_fred.S                  |  33 +-
 arch/x86/hyperv/hv_init.c                       |  69 +--
 arch/x86/hyperv/ivm.c                           |  15 +
 arch/x86/include/asm/bug.h                      |   9 +-
 arch/x86/include/asm/cfi.h                      |  14 +-
 arch/x86/include/asm/ibt.h                      |  10 +-
 arch/x86/include/asm/idtentry.h                 |   9 +-
 arch/x86/include/asm/mshyperv.h                 | 137 ++----
 arch/x86/include/asm/text-patching.h            |  20 +-
 arch/x86/kernel/alternative.c                   | 292 ++++++++-----
 arch/x86/kernel/asm-offsets.c                   |   1 +
 arch/x86/kernel/cfi.c                           |   2 +-
 arch/x86/kernel/cpu/mshyperv.c                  |  19 +-
 arch/x86/kernel/irqinit.c                       |   6 +-
 arch/x86/kernel/machine_kexec_64.c              |   4 +
 arch/x86/kernel/traps.c                         |   8 +-
 arch/x86/kvm/Kconfig                            |   1 +
 arch/x86/kvm/emulate.c                          | 550 ++++++++++--------------
 arch/x86/kvm/vmx/vmenter.S                      |   4 +
 arch/x86/kvm/vmx/vmx.c                          |   8 +-
 arch/x86/lib/bhi.S                              |  58 +--
 arch/x86/lib/retpoline.S                        |   4 +-
 arch/x86/net/bpf_jit_comp.c                     |   6 +-
 arch/x86/platform/efi/efi_stub_64.S             |   4 +
 drivers/misc/lkdtm/perms.c                      |   5 +
 include/linux/compiler-clang.h                  |   5 -
 include/linux/compiler-gcc.h                    |   4 -
 include/linux/compiler_types.h                  |   4 +-
 include/linux/init.h                            |   8 -
 include/linux/objtool.h                         |  10 +
 include/linux/objtool_types.h                   |   1 +
 tools/include/linux/objtool_types.h             |   1 +
 tools/objtool/check.c                           |  42 ++
 tools/objtool/include/objtool/elf.h             |   1 +
 36 files changed, 728 insertions(+), 665 deletions(-)

---

merge conflict resolution:
---
     Conflicts:
            arch/x86/kvm/Kconfig
            arch/x86/kvm/emulate.c
            arch/x86/lib/retpoline.S

diff --cc arch/x86/kvm/Kconfig
index 67d4f23bab66,b92ef117f355..278f08194ec8
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@@ -96,6 -95,9 +96,7 @@@ config KVM_SW_PROTECTED_V
  config KVM_INTEL
  	tristate "KVM for Intel (and compatible) processors support"
  	depends on KVM && IA32_FEAT_CTL
 -	select KVM_GENERIC_PRIVATE_MEM if INTEL_TDX_HOST
 -	select KVM_GENERIC_MEMORY_ATTRIBUTES if INTEL_TDX_HOST
+ 	select X86_FRED if X86_64
  	help
  	  Provides support for KVM on processors equipped with Intel's VT
  	  extensions, a.k.a. Virtual Machine Extensions (VMX).
diff --cc arch/x86/kvm/emulate.c
index 59f93f68718a,796d0c64f9ba..4e3da5b497b8
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@@ -4102,10 -4001,10 +4037,10 @@@ static const struct opcode group4[] = 
  };
  
  static const struct opcode group5[] = {
- 	F(DstMem | SrcNone | Lock,		em_inc),
- 	F(DstMem | SrcNone | Lock,		em_dec),
+ 	I(DstMem | SrcNone | Lock,		em_inc),
+ 	I(DstMem | SrcNone | Lock,		em_dec),
 -	I(SrcMem | NearBranch | IsBranch,       em_call_near_abs),
 -	I(SrcMemFAddr | ImplicitOps | IsBranch, em_call_far),
 +	I(SrcMem | NearBranch | IsBranch | ShadowStack, em_call_near_abs),
 +	I(SrcMemFAddr | ImplicitOps | IsBranch | ShadowStack, em_call_far),
  	I(SrcMem | NearBranch | IsBranch,       em_jmp_abs),
  	I(SrcMemFAddr | ImplicitOps | IsBranch, em_jmp_far),
  	I(SrcMem | Stack | TwoMemOp,		em_push), D(Undefined),
diff --cc arch/x86/lib/retpoline.S
index f513d33b6d37,24b7aca454ec..8f1fed0c3b83
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@@ -126,45 -126,7 +126,45 @@@ SYM_CODE_END(__x86_indirect_jump_thunk_
  #define GEN(reg) __EXPORT_THUNK(__x86_indirect_jump_thunk_ ## reg)
  #include <asm/GEN-for-each-reg.h>
  #undef GEN
 -#endif
 +
 +#endif /* CONFIG_MITIGATION_CALL_DEPTH_TRACKING */
 +
 +#ifdef CONFIG_MITIGATION_ITS
 +
 +.macro ITS_THUNK reg
 +
 +/*
-  * If CFI paranoid is used then the ITS thunk starts with opcodes (0xea; jne 1b)
++ * If CFI paranoid is used then the ITS thunk starts with opcodes (1: udb; jne 1b)
 + * that complete the fineibt_paranoid caller sequence.
 + */
- 1:	.byte 0xea
++1:	ASM_UDB
 +SYM_INNER_LABEL(__x86_indirect_paranoid_thunk_\reg, SYM_L_GLOBAL)
 +	UNWIND_HINT_UNDEFINED
 +	ANNOTATE_NOENDBR
 +	jne 1b
 +SYM_INNER_LABEL(__x86_indirect_its_thunk_\reg, SYM_L_GLOBAL)
 +	UNWIND_HINT_UNDEFINED
 +	ANNOTATE_NOENDBR
 +	ANNOTATE_RETPOLINE_SAFE
 +	jmp *%\reg
 +	int3
 +	.align 32, 0xcc		/* fill to the end of the line */
 +	.skip  32 - (__x86_indirect_its_thunk_\reg - 1b), 0xcc /* skip to the next upper half */
 +.endm
 +
 +/* ITS mitigation requires thunks be aligned to upper half of cacheline */
 +.align 64, 0xcc
 +.skip 29, 0xcc
 +
 +#define GEN(reg) ITS_THUNK reg
 +#include <asm/GEN-for-each-reg.h>
 +#undef GEN
 +
 +	.align 64, 0xcc
 +SYM_FUNC_ALIAS(__x86_indirect_its_thunk_array, __x86_indirect_its_thunk_rax)
 +SYM_CODE_END(__x86_indirect_its_thunk_array)
 +
 +#endif /* CONFIG_MITIGATION_ITS */
  
  #ifdef CONFIG_MITIGATION_RETHUNK
  


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

