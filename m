Return-Path: <linux-kernel+bounces-833924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 247B9BA357C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF26C179562
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA5B2EFD83;
	Fri, 26 Sep 2025 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NWRFyUGe"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A924672633
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882516; cv=none; b=RwmXYrftra3KutBIgFYEXAS3+kfAADKKDVnyE8+DKAdPWasshNfUukShZ8kIy9l48U7DjX9VC9W90UpCi2l8EeIjSQH5J9FJhIUALAe3FiZ9lfvp9RL+0OMAZu4T1aa4pf3oT2ufQpu90xRicf4By0NZv6OrB4Inpyo93DUCt9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882516; c=relaxed/simple;
	bh=AV2xaIoL42zj+8krdX+sW73kj32irilNXzL8oyp88Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AUR+IuU4qHj6J+0O6ws9brDpPKEuejaDMmh1DlAK1S9b7H0ocvPMse+aYDOZjpB6YAMH4FOVoSBKtPnhPNnkDxdRlzLywy5AlsemoEb2TSBO+nl3sBs4x+4wmMxo8y6x5cruwvhtNNeZu3FBGemTHn+EGT7A7j2bkaV3bq6HUTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NWRFyUGe; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CE78640E016E;
	Fri, 26 Sep 2025 10:28:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sFQjA8vez4MI; Fri, 26 Sep 2025 10:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758882507; bh=pYDGEs6A/sMCNprFkSi4bsIIJ6c19t8UtJ38s49rsts=;
	h=Date:From:To:Cc:Subject:From;
	b=NWRFyUGedwcd3xJZQ1E3nXCJSWE63PJL+fBg1ujvL2lyXjOXiw/vjej7OyKGsH6Yt
	 cE8DLvISLZOYymVv/CyNRBnG96MQCT6FTso+Gxqfmpi+jBOjUZp1E5prgQU41meFEb
	 oc3jaVOq0JFqRTFRVYoy5V/7I3RS0MG/8zQkaXTPQQXbv+bv35wjR9bupTD6PLfYPi
	 bR6wa9EmlghBo2bc+/CUr0oEtzU3pMbff+U1fCLCd2P6mT1NOpwbmARqlFQmBzSSIJ
	 /meON5lvh9LmEih9mA5Y/K3XTdm/vU/CMN2Y0g5ybhAVAaPdaGoItTojU3iaeQUk1u
	 13UvCRkJ11OWr2GSIsc0MFjkPIxjIJKJQkcc+5UeKhhW4AYi65b/4mLq5M3dBZ+kH8
	 g1EoDcx+7QQ4ZVnjwutlY2vRr+zY+6vT8zvS3dHJ0QBklYkXgZXg+8yI/FijFmUbsz
	 UuvsIZwG6awSOApNhXW/FeD2dLZ+Wg+7mlbNwcOSH9nwJdr2FhhyxwaYjVbIgRtmoV
	 Uw4VwMRR1ynZ+kdWdyyk6/o5q0vxL36esC1hguSJgsIkx9ygiS5pyLYWncPyUYqw/3
	 MUU3DHap5bqRzsX5NC5EOLhRAaQlYsYKRkOj5GOdk/iigJd7Ah6FK/laAxNd9c48sy
	 ipQsnhLPv6jUNAYE/w1AZDSU=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 0960840E016D;
	Fri, 26 Sep 2025 10:28:23 +0000 (UTC)
Date: Fri, 26 Sep 2025 12:28:23 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/apic for v6.18-rc1
Message-ID: <20250926102823.GAaNZqxzXkasrXXFjn@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/apic lineup for v6.18-rc1.

The AMD SEV (encrypted guests and hypervisor support) side of things received
a lot of development this time around and you should be getting a lot of code
from several trees.

Even this branch contains two big features because it was deemed a better idea
to merge them into one.

So there might be other merge conflicts, like with the crypto tree, for
example:

https://lore.kernel.org/r/aM1bJqhtojdLhp3c@sirena.org.uk

The resolution should be easy but lemme give you a heads-up anyway.

Thx.

---

The following changes since commit 7f830e126dc357fc086905ce9730140fd4528d66:

  x86/sev: Guard sev_evict_cache() with CONFIG_AMD_MEM_ENCRYPT (2025-09-15 18:29:43 +0200)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_apic_for_v6.18_rc1

for you to fetch changes up to 1f6113ae5ac4927fe80256154ebb0461e670fa85:

  x86/boot: Drop erroneous __init annotation from early_set_pages_state() (2025-09-24 18:08:34 +0200)

----------------------------------------------------------------
- Add functionality to provide runtime firmware updates for the non-x86 parts
  of an AMD platform like the security processor (ASP) firmware, modules
  etc, for example. The intent being that these updates are interim,
  live fixups before a proper BIOS update can be attempted

- Add guest support for AMD's Secure AVIC feature which gives encrypted
  guests the needed protection against a malicious hypervisor generating
  unexpected interrupts and injecting them into such guest, thus
  interfering with its operation in an unexpected and negative manner.
  The advantage of this scheme is that the guest determines which
  interrupts and when to accept them vs leaving that to the benevolence
  (or not) of the hypervisor

- Strictly separate the startup code from the rest of the kernel where
  former is executed from the initial 1:1 mapping of memory. The problem
  was that the toolchain-generated version of the code was being
  executed from a different mapping of memory than what was "assumed"
  during code generation, needing an ever-growing pile of fixups for
  absolute memory references which are invalid in the early, 1:1 memory
  mapping during boot.

  The major advantage of this is that there's no need to check the 1:1
  mapping portion of the code for absolute relocations anymore and get
  rid of the RIP_REL_REF() macro sprinkling all over the place.

  For more info, see Ard's very detailed writeup on this:
  https://lore.kernel.org/r/CAMj1kXEzKEuePEiHB%2BHxvfQbFz0sTiHdn4B%2B%2BzVBJ2mhkPkQ4Q@mail.gmail.com

- The usual cleanups and fixes

----------------------------------------------------------------
Ard Biesheuvel (23):
      x86/sev: Separate MSR and GHCB based snp_cpuid() via a callback
      x86/sev: Use MSR protocol for remapping SVSM calling area
      x86/sev: Use MSR protocol only for early SVSM PVALIDATE call
      x86/sev: Run RMPADJUST on SVSM calling area page to test VMPL
      x86/sev: Move GHCB page based HV communication out of startup code
      x86/sev: Avoid global variable to store virtual address of SVSM area
      x86/sev: Share implementation of MSR-based page state change
      x86/sev: Pass SVSM calling area down to early page state change API
      x86/sev: Use boot SVSM CA for all startup and init code
      x86/boot: Drop redundant RMPADJUST in SEV SVSM presence check
      x86/boot: Provide PIC aliases for 5-level paging related constants
      x86/sev: Provide PIC aliases for SEV related data objects
      x86/sev: Move __sev_[get|put]_ghcb() into separate noinstr object
      x86/sev: Export startup routines for later use
      objtool: Add action to check for absence of absolute relocations
      x86/boot: Check startup code for absence of absolute relocations
      x86/boot: Revert "Reject absolute references in .head.text"
      x86/kbuild: Incorporate boot/startup/ via Kbuild makefile
      x86/boot: Create a confined code area for startup code
      efistub/x86: Remap inittext read-execute when needed
      x86/boot: Move startup code out of __head section
      x86/boot: Get rid of the .head.text section
      x86/boot: Drop erroneous __init annotation from early_set_pages_state()

Ashish Kalra (3):
      x86/sev: Add new dump_rmp parameter to snp_leak_pages() API
      crypto: ccp - Add new HV-Fixed page allocation/free API
      crypto: ccp - Add AMD Seamless Firmware Servicing (SFS) driver

Borislav Petkov (AMD) (2):
      x86/apic/savic: Do not use snp_abort()
      x86/sev: Zap snp_abort()

Ingo Molnar (2):
      Merge branch 'x86/apic' into x86/sev, to resolve conflict
      Merge branch 'x86/urgent' into x86/apic, to resolve conflict

Kishon Vijay Abraham I (2):
      x86/sev: Initialize VGIF for secondary vCPUs for Secure AVIC
      x86/sev: Enable NMI support for Secure AVIC

Nathan Chancellor (1):
      objtool: Ignore __pi___cfi_ prefixed symbols

Neeraj Upadhyay (16):
      x86/apic: Add new driver for Secure AVIC
      x86/apic: Initialize Secure AVIC APIC backing page
      x86/apic: Populate .read()/.write() callbacks of Secure AVIC driver
      x86/apic: Initialize APIC ID for Secure AVIC
      x86/apic: Add update_vector() callback for APIC drivers
      x86/apic: Add an update_vector() callback for Secure AVIC
      x86/apic: Add support to send IPI for Secure AVIC
      x86/apic: Support LAPIC timer for Secure AVIC
      x86/apic: Add support to send NMI IPI for Secure AVIC
      x86/apic: Allow NMI to be injected from hypervisor for Secure AVIC
      x86/apic: Read and write LVT* APIC registers from HV for SAVIC guests
      x86/apic: Handle EOI writes for Secure AVIC guests
      x86/apic: Add kexec support for Secure AVIC
      x86/apic: Enable Secure AVIC in the control MSR
      x86/sev: Prevent SECURE_AVIC_CONTROL MSR interception for Secure AVIC guests
      x86/sev: Indicate the SEV-SNP guest supports Secure AVIC

Thomas Gleixner (1):
      x86/apic: Make the ISR clearing sane

Tom Lendacky (1):
      x86/startup/sev: Document the CPUID flow in the boot #VC handler

 arch/x86/Kbuild                            |   2 +
 arch/x86/Kconfig                           |  13 +
 arch/x86/Makefile                          |   1 -
 arch/x86/boot/compressed/Makefile          |   2 +-
 arch/x86/boot/compressed/misc.c            |   2 +
 arch/x86/boot/compressed/sev-handle-vc.c   |   3 +
 arch/x86/boot/compressed/sev.c             | 132 +++------
 arch/x86/boot/cpuflags.c                   |  13 -
 arch/x86/boot/startup/Makefile             |  22 ++
 arch/x86/boot/startup/exports.h            |  14 +
 arch/x86/boot/startup/gdt_idt.c            |   4 +-
 arch/x86/boot/startup/map_kernel.c         |   4 +-
 arch/x86/boot/startup/sev-shared.c         | 327 +++++++---------------
 arch/x86/boot/startup/sev-startup.c        | 210 +++-----------
 arch/x86/boot/startup/sme.c                |  30 +-
 arch/x86/coco/core.c                       |   3 +
 arch/x86/coco/sev/Makefile                 |   8 +-
 arch/x86/coco/sev/core.c                   | 276 ++++++++++++++++---
 arch/x86/coco/sev/{sev-nmi.c => noinstr.c} |  74 +++++
 arch/x86/coco/sev/vc-handle.c              |  22 +-
 arch/x86/coco/sev/vc-shared.c              | 143 +++++++++-
 arch/x86/include/asm/apic.h                |  11 +
 arch/x86/include/asm/apicdef.h             |   2 +
 arch/x86/include/asm/boot.h                |   2 +
 arch/x86/include/asm/init.h                |   6 -
 arch/x86/include/asm/msr-index.h           |   9 +-
 arch/x86/include/asm/setup.h               |   1 +
 arch/x86/include/asm/sev-common.h          |   1 +
 arch/x86/include/asm/sev-internal.h        |  28 +-
 arch/x86/include/asm/sev.h                 |  41 ++-
 arch/x86/include/uapi/asm/svm.h            |   4 +
 arch/x86/kernel/apic/Makefile              |   1 +
 arch/x86/kernel/apic/apic.c                |  85 +++---
 arch/x86/kernel/apic/vector.c              |  28 +-
 arch/x86/kernel/apic/x2apic_savic.c        | 428 +++++++++++++++++++++++++++++
 arch/x86/kernel/head64.c                   |   5 +-
 arch/x86/kernel/head_32.S                  |   5 +-
 arch/x86/kernel/head_64.S                  |  10 +-
 arch/x86/kernel/vmlinux.lds.S              |   9 +-
 arch/x86/mm/mem_encrypt_amd.c              |   6 -
 arch/x86/mm/mem_encrypt_boot.S             |   6 +-
 arch/x86/platform/pvh/head.S               |   2 +-
 arch/x86/tools/relocs.c                    |   8 +-
 arch/x86/virt/svm/sev.c                    |   7 +-
 drivers/crypto/ccp/Makefile                |   3 +-
 drivers/crypto/ccp/psp-dev.c               |  20 ++
 drivers/crypto/ccp/psp-dev.h               |   8 +-
 drivers/crypto/ccp/sev-dev.c               | 182 ++++++++++++
 drivers/crypto/ccp/sev-dev.h               |   3 +
 drivers/crypto/ccp/sfs.c                   | 311 +++++++++++++++++++++
 drivers/crypto/ccp/sfs.h                   |  47 ++++
 drivers/firmware/efi/libstub/x86-stub.c    |   4 +-
 include/linux/cc_platform.h                |   8 +
 include/linux/psp-platform-access.h        |   2 +
 include/uapi/linux/psp-sfs.h               |  87 ++++++
 tools/objtool/arch/x86/decode.c            |  12 +
 tools/objtool/builtin-check.c              |   2 +
 tools/objtool/check.c                      |  48 +++-
 tools/objtool/include/objtool/arch.h       |   1 +
 tools/objtool/include/objtool/builtin.h    |   1 +
 tools/objtool/noreturns.h                  |   1 -
 61 files changed, 2042 insertions(+), 708 deletions(-)
 create mode 100644 arch/x86/boot/startup/exports.h
 rename arch/x86/coco/sev/{sev-nmi.c => noinstr.c} (61%)
 create mode 100644 arch/x86/kernel/apic/x2apic_savic.c
 create mode 100644 drivers/crypto/ccp/sfs.c
 create mode 100644 drivers/crypto/ccp/sfs.h
 create mode 100644 include/uapi/linux/psp-sfs.h


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

