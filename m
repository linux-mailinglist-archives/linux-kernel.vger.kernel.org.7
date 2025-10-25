Return-Path: <linux-kernel+bounces-869829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0CBC08D0E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 09:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51DC24F81DA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 07:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEC62DC78D;
	Sat, 25 Oct 2025 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="demwg70V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DEF2DC78B
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375867; cv=none; b=llZOv8AjsExvSIeAfc5ZPIZhsARYSBRKCATrNoBFd6lR+JRkxZo1gOwYLaVYK92v/L2srA5xw4obZNVO+M7weuMt+uhxjHgCiHa90stvSwr8ZFOn9SEHeRu2Q7Fb59IAZEn8TkvkkOAqqKjcr1t3/RQzpc/kWziMg5fgW1BZi0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375867; c=relaxed/simple;
	bh=xXZGzgAFhPqm4rFWZKlguHzsT8Q2QsAf9zp9FqHsRdM=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=jYlZxcbXv0x1y0S7821aK2iARPJvmkuxgHi9wIsgGu/0LELiRnnQ12cH+Kzl1FskWnYnp/QLdBz5GYymYMxvVUlkA5J4KEEv5gPZUw6wH8l9oGQKEP7pmavL6t+Z3riODIrZVU8cPcTrMhTloNG1afF3A2l7/IJdoIvyJfB9xmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=demwg70V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328A2C4CEF5;
	Sat, 25 Oct 2025 07:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761375866;
	bh=xXZGzgAFhPqm4rFWZKlguHzsT8Q2QsAf9zp9FqHsRdM=;
	h=Date:From:To:cc:Subject:From;
	b=demwg70VrcRhtgYzj5IQuvqEn79ZY+bb14OkpTv4N8M0U0JlbD+SGbzlRx1XgE+Je
	 DrbJOVo3zIosbYSF+IXqOb9/LXoCvN/zlYZYaACBtHkML8ULgds9d2L3K6SVfZakBg
	 6wavHzCZAs3Irva2Oy/bZ0b7ZD5NDdQHfPRfiESwnNNLKCh0KpPD2HPMhV6E46p/DQ
	 zOlUUuwjfYR4ZZ8GRSYuAA6AtxDUsDIP590D/Mju8EY8vcxTLyaWs6HkuH85RDNBwJ
	 v+B2127zi4JRSRkmF/uD6TfrQiCwb9LaOGRTe3L8MnFHBQF/qMlqngOffHW/MRXZL9
	 C9b+haSyEr1vQ==
Date: Sat, 25 Oct 2025 01:04:21 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: torvalds@linux-foundation.org
cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V updates for v6.18-rc3
Message-ID: <27fed8ce-11d7-cd8c-b0e2-b89b11fa3c5a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Linus,

The following changes since commit fe69107ec7d8b946ab413cfe118984dac8f1a0d8:

  Merge tag 'riscv-for-linux-6.18-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2025-10-17 12:59:31 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-6.18-rc3

for you to fetch changes up to b7776a802f2f80139f96530a489dd00fd7089eda:

  riscv: hwprobe: avoid uninitialized variable use in hwprobe_arch_id() (2025-10-18 09:36:36 -0600)


- Paul

----------------------------------------------------------------
RISC-V updates for v6.18-rc3

Several RISC-V fixes for v6.18-rc3:

- Close a race during boot between userspace vDSO usage and some
  late-initialized vDSO data

- Improve performance on systems with non-CPU-cache-coherent
  DMA-capable peripherals by enabling write combining on
  pgprot_dmacoherent() allocations

- Add human-readable detail for RISC-V IPI tracing

- Provide more information to zsmalloc on 64-bit RISC-V to improve
  allocation

- Silence useless boot messages about CPUs that have been disabled in
  DT

- Resolve some compiler and smatch warnings and remove a redundant macro

----------------------------------------------------------------
Anup Patel (2):
      RISC-V: Define pgprot_dmacoherent() for non-coherent devices
      RISC-V: Don't print details of CPUs disabled in DT

Jingwei Wang (1):
      riscv: hwprobe: Fix stale vDSO data for late-initialized keys at boot

Paul Walmsley (3):
      riscv: add a forward declaration for cpuinfo_op
      riscv: cpufeature: avoid uninitialized variable in has_thead_homogeneous_vlenb()
      riscv: hwprobe: avoid uninitialized variable use in hwprobe_arch_id()

Samuel Holland (3):
      riscv: Register IPI IRQs with unique names
      riscv: mm: Define MAX_POSSIBLE_PHYSMEM_BITS for zsmalloc
      riscv: Remove the PER_CPU_OFFSET_SHIFT macro

Sunil V L (1):
      ACPI: RIMT: Fix unused function warnings when CONFIG_IOMMU_API is disabled

 arch/riscv/include/asm/asm.h               |   8 +-
 arch/riscv/include/asm/cpufeature.h        |   2 +
 arch/riscv/include/asm/hwprobe.h           |   7 ++
 arch/riscv/include/asm/pgtable-64.h        |   2 +
 arch/riscv/include/asm/pgtable.h           |   2 +
 arch/riscv/include/asm/vdso/arch_data.h    |   6 ++
 arch/riscv/kernel/cpu.c                    |   4 +-
 arch/riscv/kernel/cpufeature.c             |   4 +-
 arch/riscv/kernel/smp.c                    |  24 +++---
 arch/riscv/kernel/sys_hwprobe.c            |  76 +++++++++++++++---
 arch/riscv/kernel/unaligned_access_speed.c |   9 ++-
 arch/riscv/kernel/vdso/hwprobe.c           |   2 +-
 drivers/acpi/riscv/rimt.c                  | 122 ++++++++++++++---------------
 13 files changed, 168 insertions(+), 100 deletions(-)


vmlinux size differences (from 6f3b6e91f720):

text  data  bss   dec   hex  filename                             
+140  +152    .  +292  +124  vmlinux.defconfig.gcc-15             
+144  +120    .  +264  +108  vmlinux.nosmp_defconfig.gcc-15       
 +76  +160    .  +236   +ec  vmlinux.rv32_defconfig.gcc-15        
+168   +88    .  +256  +100  vmlinux.rv32_nosmp_defconfig.gcc-15  
 +76   +16    .   +92   +5c  vmlinux.nommu_virt_defconfig.gcc-15  
+140  +152    .  +292  +124  vmlinux.defconfig.gcc-14             
+144  +120    .  +264  +108  vmlinux.nosmp_defconfig.gcc-14       
 +76  +160    .  +236   +ec  vmlinux.rv32_defconfig.gcc-14        
+168   +88    .  +256  +100  vmlinux.rv32_nosmp_defconfig.gcc-14  
 +76   +16    .   +92   +5c  vmlinux.nommu_virt_defconfig.gcc-14  
+356   +84    .  +440  +1b8  vmlinux.defconfig.clang-20           
+340  +116    .  +456  +1c8  vmlinux.nosmp_defconfig.clang-20     
+400   +80    .  +480  +1e0  vmlinux.rv32_defconfig.clang-20      
+376  +112    .  +488  +1e8  vmlinux.rv32_nosmp_defconfig.clang-20
 +48   +80    .  +128   +80  vmlinux.nommu_virt_defconfig.clang-20
+328  +116    .  +444  +1bc  vmlinux.defconfig.clang-19           
+344   +76    .  +420  +1a4  vmlinux.nosmp_defconfig.clang-19     
+424   +84    .  +508  +1fc  vmlinux.rv32_defconfig.clang-19      
+396   +76    .  +472  +1d8  vmlinux.rv32_nosmp_defconfig.clang-19
 +60   +16    .   +76   +4c  vmlinux.nommu_virt_defconfig.clang-19
-100   +80    .   -20   -14  vmlinux.allnoconfig.gcc-14           
   x     x    x     x     x  vmlinux.allmodconfig.gcc-14

