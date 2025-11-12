Return-Path: <linux-kernel+bounces-896635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4929C50DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2483B87B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D43727B50F;
	Wed, 12 Nov 2025 07:00:52 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0556123D7D7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930851; cv=none; b=uENr9cNnaTLdELWbTAG5G6zYgAi4QfONMGd9taeIyJadiG9tur3fC5drd6pngNDtHd4EL1cdvE1AY4bqd7zCOPtUC2NaYw8hSpZbC+EsCR06AOdY8H2teIu0vDyvQLrqO8HbUCY8z6uQyUivNNh/34HjOVTgUXh8AEdIRaUIY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930851; c=relaxed/simple;
	bh=Gr2YxxqKvlpCtol3yYvDxV+srWVZwDKU2Wvd/qwfouY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdsFcvPtIDqASDVL17cDRiNFEP1R9TM4anq1ZczZ4rCvDEUk7X+WWTGTcCJOkRuHOvBzkA4394LYISCXk0lbG3W2l3+MoURTO0A4ojp7M4W+xNSgFYoUYj8Neuc4D5QXUh4+GJtuRtmTQwh/t90VMAbFql6GsSIH7J+JH5sCQeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.45])
	by gateway (Coremail) with SMTP id _____8Bx1tCWMBRpylUiAA--.8701S3;
	Wed, 12 Nov 2025 15:00:38 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.45])
	by front1 (Coremail) with SMTP id qMiowJDxcMKRMBRpxUEwAQ--.3804S2;
	Wed, 12 Nov 2025 15:00:37 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.18-rc6
Date: Wed, 12 Nov 2025 15:00:19 +0800
Message-ID: <20251112070019.2182638-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxcMKRMBRpxUEwAQ--.3804S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGr1fGF4fXF4UuFWDGF47Jrc_yoW5Cw1fpr
	y3urnrGFs5GrW3Zrnrt345urn8tr1xG34aqa1jy34rCr4jvF1UXr18Xr1kXFy5J3yrJFy0
	qr1rWwnFqFyUJ3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==

The following changes since commit e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c:

  Linux 6.18-rc5 (2025-11-09 15:10:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.18-1

for you to fetch changes up to 237e74bfa261fb0cf75bd08c9be0c5094018ee20:

  LoongArch: KVM: Fix max supported vCPUs set with EIOINTC (2025-11-10 08:37:07 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.18-rc6

Fix a build error about Rust; fix some bugs about exception/interrupt,
memory management, perf event, hardware breakpoint, kexec and KVM.
----------------------------------------------------------------
Bibo Mao (5):
      LoongArch: KVM: Set page with write attribute if dirty track disabled
      LoongArch: KVM: Add delay until timer interrupt injected
      LoongArch: KVM: Restore guest PMU if it is enabled
      LoongArch: KVM: Skip PMU checking on vCPU context switch
      LoongArch: KVM: Fix max supported vCPUs set with EIOINTC

Huacai Chen (5):
      LoongArch: Clarify 3 MSG interrupt features
      LoongArch: Use physical addresses for CSR_MERRENTRY/CSR_TLBRENTRY
      LoongArch: Consolidate early_ioremap()/ioremap_prot()
      LoongArch: Consolidate max_pfn & max_low_pfn calculation
      LoongArch: Use correct accessor to read FWPC/MWPC

Qiang Ma (1):
      LoongArch: kexec: Print out debugging message if required

Tianyang Zhang (1):
      LoongArch: Let {pte,pmd}_modify() record the status of _PAGE_DIRTY

Tiezhu Yang (1):
      LoongArch: Refine the init_hw_perf_events() function

Vishal Moola (Oracle) (1):
      LoongArch: Remove __GFP_HIGHMEM masking in pud_alloc_one()

Xi Ruoyao (1):
      rust: Add -fno-isolate-erroneous-paths-dereference to bindgen_skip_c_flags

Youling Tang (1):
      LoongArch: kexec: Initialize the kexec_buf structure

 arch/loongarch/include/asm/cpu-features.h  |  2 ++
 arch/loongarch/include/asm/cpu.h           |  6 +++++-
 arch/loongarch/include/asm/hw_breakpoint.h |  4 ++--
 arch/loongarch/include/asm/io.h            |  5 ++++-
 arch/loongarch/include/asm/loongarch.h     |  2 ++
 arch/loongarch/include/asm/pgalloc.h       |  2 +-
 arch/loongarch/include/asm/pgtable.h       | 11 ++++++++---
 arch/loongarch/kernel/cpu-probe.c          |  4 ++++
 arch/loongarch/kernel/kexec_efi.c          |  2 +-
 arch/loongarch/kernel/kexec_elf.c          |  2 +-
 arch/loongarch/kernel/machine_kexec.c      | 22 ----------------------
 arch/loongarch/kernel/machine_kexec_file.c |  2 +-
 arch/loongarch/kernel/mem.c                |  7 +++----
 arch/loongarch/kernel/numa.c               | 23 ++---------------------
 arch/loongarch/kernel/perf_event.c         |  7 ++++---
 arch/loongarch/kernel/setup.c              |  5 ++---
 arch/loongarch/kernel/traps.c              |  4 ++--
 arch/loongarch/kvm/intc/eiointc.c          |  2 +-
 arch/loongarch/kvm/mmu.c                   |  2 +-
 arch/loongarch/kvm/timer.c                 |  2 ++
 arch/loongarch/kvm/vcpu.c                  | 19 +++++++++----------
 arch/loongarch/mm/init.c                   |  2 --
 arch/loongarch/mm/ioremap.c                |  2 +-
 rust/Makefile                              |  2 +-
 24 files changed, 59 insertions(+), 82 deletions(-)


