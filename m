Return-Path: <linux-kernel+bounces-843047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C23FBBE4B9
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AEFF1898BE8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9AF2D4806;
	Mon,  6 Oct 2025 14:13:11 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4159B7081C
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759759991; cv=none; b=jG5H/TvdBkZmxNn8dVEqQ46Bq/Xs6/qIJSfJjV6ugFd44lxh6kZ4vUIUSrUqJEijAATG6Nn2mxgUjtYCHIVn6oigPiOkxeyfToiU8dq101pMKZltPwPzRLNnyhD/GZHvDZ+X8oUt6zFPqmS4MioNyfyM0YyVjGtHT+GxyPcwAEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759759991; c=relaxed/simple;
	bh=uP6CerlMC0Y3nc50t2A1HH3D4P1/cf2ULQQcMRhQSOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qBO2Q1gzdkaTvO971ZvRFSs8+H4CSPC7yAvXPtiVwDAtF1cOEEOhaMRVegh2e0mbsB6555+uzDFnFLrzLVHEeYzVY41fJQ1d/Gwldu7wovoBfTjmcztizddLXoVWzK/q/lAEgkQYJ023Wg0iFjpT20VxWt70NVpvV2jqbIrdkDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8DxO9JrzuNoPfsSAA--.40287S3;
	Mon, 06 Oct 2025 22:12:59 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowJCxrsNhzuNosArSAA--.62698S2;
	Mon, 06 Oct 2025 22:12:57 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch changes for v6.18
Date: Mon,  6 Oct 2025 22:12:28 +0800
Message-ID: <20251006141228.3534607-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxrsNhzuNosArSAA--.62698S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr1rZFWDWrW5KF4kKw4DAwc_yoWrJrW8pr
	43urnxJF4UGrsxJr9xt345uF15twn7Gry7Xa1akry8Cr1UZr1UGw1xXF97Xa4Ut3yrJr1I
	qr1rG34jg3WUJagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOiSdUUUUU=

The following changes since commit e5f0a698b34ed76002dc5cff3804a61c80233a7a:

  Linux 6.17 (2025-09-28 14:39:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.18

for you to fetch changes up to 032676ff8217cab3273da56ee774b64c46b56b5e:

  LoongArch: Update Loongson-3 default config file (2025-10-05 11:52:43 +0800)

----------------------------------------------------------------
LoongArch changes for v6.18

1, Init acpi_gbl_use_global_lock to false;
2, Allow specify SIMD width via kernel parameters;
3, Add kexec_file (both EFI & ELF format) support;
4, Add PER_VMA_LOCK for page fault handling support;
5, Improve BPF trampoline support;
6, Update the default config file;
7, Some bug fixes and other small changes.

Note: There is a conflict in arch/loongarch/Kconfig but can be simply
fixed by adjusting context.

----------------------------------------------------------------
Hengqi Chen (8):
      LoongArch: BPF: Remove duplicated flags check
      LoongArch: BPF: Remove duplicated bpf_flush_icache()
      LoongArch: BPF: No text_poke() for kernel text
      LoongArch: BPF: No support of struct argument in trampoline programs
      LoongArch: BPF: Don't align trampoline size
      LoongArch: BPF: Make trampoline size stable
      LoongArch: BPF: Make error handling robust in arch_prepare_bpf_trampoline()
      LoongArch: BPF: Sign-extend struct ops return values properly

Huacai Chen (6):
      Merge tag 'acpi-6.18-rc1' into loongarch-next
      LoongArch: Fix build error for LTO with LLVM-18
      LoongArch: Init acpi_gbl_use_global_lock to false
      LoongArch: Allow specify SIMD width via kernel parameters
      LoongArch: BPF: Fix uninitialized symbol 'retval_off'
      LoongArch: Update Loongson-3 default config file

Tiezhu Yang (3):
      LoongArch: Add cflag -fno-isolate-erroneous-paths-dereference
      LoongArch: Handle new atomic instructions for probes
      LoongArch: BPF: Optimize sign-extention mov instructions

Wentao Guan (1):
      LoongArch: Try VMA lock-based page fault handling first

Youling Tang (6):
      LoongArch: Add struct loongarch_image_header for kernel
      LoongArch: Add preparatory infrastructure for kexec_file
      LoongArch: Add EFI binary support for kexec_file
      LoongArch: Add ELF binary support for kexec_file
      LoongArch: Add crash dump support for kexec_file
      LoongArch: Automatically disable kaslr if boot from kexec_file

 arch/loongarch/Kconfig                     |  11 ++
 arch/loongarch/Makefile                    |   4 +-
 arch/loongarch/configs/loongson3_defconfig |  73 ++++++++-
 arch/loongarch/include/asm/image.h         |  52 +++++++
 arch/loongarch/include/asm/inst.h          |   5 +
 arch/loongarch/include/asm/kexec.h         |  12 ++
 arch/loongarch/kernel/Makefile             |   1 +
 arch/loongarch/kernel/cpu-probe.c          |  46 +++++-
 arch/loongarch/kernel/inst.c               |  12 ++
 arch/loongarch/kernel/kexec_efi.c          | 113 ++++++++++++++
 arch/loongarch/kernel/kexec_elf.c          | 105 +++++++++++++
 arch/loongarch/kernel/machine_kexec.c      |  37 +++--
 arch/loongarch/kernel/machine_kexec_file.c | 239 +++++++++++++++++++++++++++++
 arch/loongarch/kernel/relocate.c           |   4 +
 arch/loongarch/kernel/setup.c              |   1 +
 arch/loongarch/mm/fault.c                  |  58 ++++++-
 arch/loongarch/net/bpf_jit.c               |  86 ++++++++---
 17 files changed, 809 insertions(+), 50 deletions(-)
 create mode 100644 arch/loongarch/include/asm/image.h
 create mode 100644 arch/loongarch/kernel/kexec_efi.c
 create mode 100644 arch/loongarch/kernel/kexec_elf.c
 create mode 100644 arch/loongarch/kernel/machine_kexec_file.c


