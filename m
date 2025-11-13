Return-Path: <linux-kernel+bounces-898321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C301BC54E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1DFF734A147
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 00:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABA98488;
	Thu, 13 Nov 2025 00:11:37 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1265317D2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762992696; cv=none; b=eoOS81uphJMsc6ePQ21zXetvsMmI2ynmvA/66WxUzWGg4quLOh8g+LWrvUe2IDqS/06CbF4hnqNj4vTDYjnkumx6N6nJHoXH4V8Yf2oWtt7e26efbXuXVCF1BZ24OPKu+dy/FnKP1vdTz8lm6YeI1swm0LNRNpuEXJCyVvAVQhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762992696; c=relaxed/simple;
	bh=Gr2YxxqKvlpCtol3yYvDxV+srWVZwDKU2Wvd/qwfouY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QNMloWgzO5VB/uC0KNA2Gyru6OSa75cnyv1+mO5F+lFk1t2C7TDvGtNXsT9T6jyrV5+DGV/GWbWzJDa4FWFy55ugVtxD40AcUxyn68X2FI9n8iUkmYl96AEbvsHtBgLUPFFd5PaYBP9Q8QEWUuOwXTP9i3wdLXuwDqb7vHqY+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.45])
	by gateway (Coremail) with SMTP id _____8Bx3tIyIhVpuqAiAA--.9383S3;
	Thu, 13 Nov 2025 08:11:30 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.45])
	by front1 (Coremail) with SMTP id qMiowJAx_8EuIhVpGQYxAQ--.60387S2;
	Thu, 13 Nov 2025 08:11:28 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.18-rc6
Date: Thu, 13 Nov 2025 08:11:16 +0800
Message-ID: <20251113001116.2758597-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx_8EuIhVpGQYxAQ--.60387S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGr1fGF4fXF4UuFWDGF47Jrc_yoW5Cw1fpr
	y3urnrGFs5GrW3Zrnrt345urn8tr1xG34aqa1jy34rCr4jvF1UXr18Xr1kXFy5J3yrJFy0
	qr1rWwnFqFyUJ3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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


