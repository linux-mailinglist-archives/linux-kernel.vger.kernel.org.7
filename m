Return-Path: <linux-kernel+bounces-889466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98266C3DB13
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 23:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F1E74E6A2B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 22:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CFD33CEAE;
	Thu,  6 Nov 2025 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EunqhHxg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BED1EB9FA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469544; cv=none; b=irE82qBWEUt3x0o/xQDQSCShNXDWEncL7DbWIj4mB9+pSeBbiDMhSsy9U8pn8feV6LxMHVwhNBTvSLMaSoLmePHT4+kIoUHNw/CrrM2AWiXNPUYSw5J5316KL/4Wgr+kCoc3ggcnRhBM+/u/d3a3cwUOXUG73leN7rNLlngDBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469544; c=relaxed/simple;
	bh=IRSfT8Qcf/blTDsXUTYbvaNw0dJP4wdg2wtqcoH4yR4=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=beV20By7iOJ1Hb9tQ7orbejTdOhRU4sF5JLJRsNgOZqolIZg9dQWVUtKLR5XTlrlb05dVn5TrhGq6wnxSdvYeZ3f7knVNdzMv847r1MPBcr2x8MSwHEDLUaXJ+AChc9MBJZV5I6ol0fEPvRpkNyFeH9vx/XEaipfstqosk713ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EunqhHxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB47C4CEFB;
	Thu,  6 Nov 2025 22:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469543;
	bh=IRSfT8Qcf/blTDsXUTYbvaNw0dJP4wdg2wtqcoH4yR4=;
	h=Date:From:To:cc:Subject:From;
	b=EunqhHxgmUSdhXFTenfnXxc0Emrh3LEc4uoA6tGgiY5NJC02JnZpkeK4rQkDOuv0y
	 ROjoeFLWeEXSTiUKLWZct/fsWRfl1VtXEMTdj/YTZSPPns0S3/I3/qQTc5P2/qTtFs
	 +tg9PxCiZWGUDhAH7Idie5DNQ50oEHyrlwYHzW9xMoPGBDxqSIxQWUzRoBzmNcM3/5
	 RTqzEifevewgnrVcz3iCpFrg18tRK2ZA+deESaPngDpDVgaOrZUr5jM7GKpyLi7vyW
	 nM/s6ilnEaO+CjG3VCVSlF4vV/X82aR8HitsdrqI3i2/Quf5k11Cd1DAszSajDDzSO
	 QlbCDysn0YH8Q==
Date: Thu, 6 Nov 2025 15:52:22 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: torvalds@linux-foundation.org
cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V updates for v6.18-rc5
Message-ID: <50a5b4a5-18ae-6dda-bdbd-db67e112bc1b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


Linus,

The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

  Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-6.18-rc5

for you to fetch changes up to 2e448567839c65768486d56612c88cb327d26050:

  cpuidle: riscv-sbi: Replace deprecated strcpy in sbi_cpuidle_init_cpu (2025-10-27 23:38:13 -0600)


- Paul
----------------------------------------------------------------
RISC-V updates for v6.18-rc5

Some RISC-V updates for v6.18-rc5, including:

- A fix to disable KASAN checks while walking a non-current task's
  stackframe (following x86)

- A fix for a kvrealloc()-related memory leak in
  module_frob_arch_sections()

- Two replacements of strcpy() with strscpy()

- A change to use the RISC-V .insn assembler directive when possible
  to assemble instructions from hex opcodes

- Some low-impact fixes in the ptdump code and kprobes test code

----------------------------------------------------------------
Ben Dooks (1):
      riscv: asm: use .insn for making custom instructions

Chunyan Zhang (1):
      riscv: stacktrace: Disable KASAN checks for non-current tasks

Josephine Pfeiffer (1):
      riscv: ptdump: use seq_puts() in pt_dump_seq_puts() macro

Miaoqian Lin (1):
      riscv: Fix memory leak in module_frob_arch_sections()

Thorsten Blum (2):
      riscv: KGDB: Replace deprecated strcpy in kgdb_arch_handle_qxfer_pkt
      cpuidle: riscv-sbi: Replace deprecated strcpy in sbi_cpuidle_init_cpu

Vivian Wang (2):
      riscv: tests: Rename kprobes_test_riscv to kprobes_riscv
      riscv: tests: Make RISCV_KPROBES_KUNIT tristate

 arch/riscv/include/asm/asm.h                    |  6 ++++++
 arch/riscv/include/asm/insn-def.h               |  8 ++++----
 arch/riscv/include/asm/vendor_extensions/mips.h |  6 +++---
 arch/riscv/kernel/kgdb.c                        |  4 ++--
 arch/riscv/kernel/module-sections.c             |  8 ++++++--
 arch/riscv/kernel/stacktrace.c                  | 21 +++++++++++++++++++--
 arch/riscv/kernel/tests/Kconfig.debug           |  2 +-
 arch/riscv/kernel/tests/kprobes/Makefile        |  4 +++-
 arch/riscv/kernel/tests/kprobes/test-kprobes.c  |  5 ++++-
 arch/riscv/mm/ptdump.c                          |  2 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c             |  5 +++--
 11 files changed, 52 insertions(+), 19 deletions(-)

vmlinux size differences in bytes (from v6.18-rc3):
 text  data bss    dec   hex filename                             
 -112   +64   .    -48   -30 vmlinux.defconfig.gcc-15             
 -104   +64   .    -40   -28 vmlinux.nosmp_defconfig.gcc-15       
 -112  +160   .    +48   +30 vmlinux.rv32_defconfig.gcc-15        
  +32   +96   .   +128   +80 vmlinux.rv32_nosmp_defconfig.gcc-15  
  +24   +64   .    +88   +58 vmlinux.nommu_virt_defconfig.gcc-15  
  +32   +96   .   +128   +80 vmlinux.defconfig.clang-20           
  +24   +96   .   +120   +78 vmlinux.nosmp_defconfig.clang-20     
  +40   +96   .   +136   +88 vmlinux.rv32_defconfig.clang-20      
  +32  +160   .   +192   +c0 vmlinux.rv32_nosmp_defconfig.clang-20
   +8   +64   .    +72   +48 vmlinux.nommu_virt_defconfig.clang-20
 -112  +128   .    +16   +10 vmlinux.defconfig.gcc-14             
 -104   +64   .    -40   -28 vmlinux.nosmp_defconfig.gcc-14       
 -104   +96   .     -8    -8 vmlinux.rv32_defconfig.gcc-14        
  +24  +160   .   +184   +b8 vmlinux.rv32_nosmp_defconfig.gcc-14  
  +24   +64   .    +88   +58 vmlinux.nommu_virt_defconfig.gcc-14  
  +36  +128   .   +164   +a4 vmlinux.defconfig.clang-19           
  +40   +96   .   +136   +88 vmlinux.nosmp_defconfig.clang-19     
  +40   +96   .   +136   +88 vmlinux.rv32_defconfig.clang-19      
  +48  +128   .   +176   +b0 vmlinux.rv32_nosmp_defconfig.clang-19
  +16     .   .    +16   +10 vmlinux.nommu_virt_defconfig.clang-19
    .     .   .      .     . vmlinux.allnoconfig.gcc-14           
-5937 -4656   . -10593 -2961 vmlinux.allmodconfig.gcc-14          

