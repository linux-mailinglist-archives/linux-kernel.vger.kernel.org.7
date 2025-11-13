Return-Path: <linux-kernel+bounces-898453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD89FC55514
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575C53B2B95
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6CB2C3278;
	Thu, 13 Nov 2025 01:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="L5i/ZM1q"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F6E29E109
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998421; cv=none; b=RJWFALkgfzozI8AqKz/PEL3WISQbTkaqHcgqj9tqboVfDhMkYKeCi1Jcr/iWxJjon9bfEquhohkUdjNwcYBIkD+ZgYSdM5akGUALVqg8LxJnYVwUwkRHXrmI1ao2FsLStMC1CAW8JUHPMrq1OwCHDnV2ex2C6LLBdDG1JWdtco0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998421; c=relaxed/simple;
	bh=00AcQO6EmVLTS35QqQGQiDwiksKUWytFr7VPjz61wJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tmQGyhJimlBLMzq99ZpY56i1zKBtNsRTIOW0z6/PI9sEnKGBMFRxqbu9RlTVvVrdCIrxvvMPh26NRkxPbIMU3DQ4ncLi+gnlPoEyW2nIKSXJqkC4iktJ/CWrU5dWirpFkFd/pU2tWj6UtwYqahclAAsfm06n4VSg5Ekg0EalOno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=L5i/ZM1q; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bc0d7255434so186142a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1762998419; x=1763603219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GSzIa/C5f6OJIgZm6PYuMbKgOcm8FD5PfqT1N2NRHyU=;
        b=L5i/ZM1qQCtt4h1VwX7zb/0QEV3cLLRG7AjIPaSCIhAqK/Emj2YEc4rudgihfTjft6
         XSlHQz5C2g+N+NsrbuqloB3KD26SWfKYDEA2BxBXtuiHdIdafuZsuzn/90DLd7AxBEKj
         IRqljdzs16bkJcE/rdOuCYVB/lH/AzD0WPrgbVRJtrXI+LKkBp3uDQlLwTuS5mLY3tU0
         TIlCLjW0kZOK37C+GTxNgD3nqZ8MF5Px6JHXu7Bi9Buopgb/X0jvFxMTMXMd0mQfkgyC
         BJWRmuspiYa066/VULD3/Z1XLrOwRbv8NDcJ+BIpklcBEs8+N8kXBZwNkKND7ZgaLTd0
         QeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762998419; x=1763603219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSzIa/C5f6OJIgZm6PYuMbKgOcm8FD5PfqT1N2NRHyU=;
        b=XF7XtGzJhoSWowT2/FLgOUuXG+6Pr0vmzIfqnXJAyqLo3K74D1KOrpZhL9qn9L3j76
         N12puA6EC7vkURDBl1sUdVMYMU1KVG04qDRVi9bmykRXRbFnlo8kme4AWmoPWSe54bEF
         xn4/f/Osz0GmV7sW+eLb0uvaX9WR0mJMBxzKRnXcNpeL7z52sssnj439+yo2Nv4hYQjC
         H57B6NRAU/TBgTPmF2xLI/3l6rrYjOdcFIZbSZ0KKnwDjAkvfcj9c7oV8QG2l+XZOxXh
         PF6PNeDrt0VWkmu8nCOxH7xRjIYM6q8L14nu5zIDvtgA5ToaOI9K2vWTwR4AujTpveOp
         WcUA==
X-Forwarded-Encrypted: i=1; AJvYcCUM9mOGUbf960jdfO+6ycR5P+GyRWbTWOMvEDog5XYmmUjYJbo9P1Jy1i6HbZ26pDCSpDLG0+97SHeJo8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjzM1HkzhF1csqBxMP0iFT80BUpmh0bgeIjEx5p/q/j8LT9Gef
	MfEsjEGT0hKrS/9D9jT4RvRunK4tgMk8WPQ4Kj0NWGa2LOzWP171jZ8PHW71QzilVBk=
X-Gm-Gg: ASbGncuFVpuFOD353CJzccquIQvbEI2mgIMEFvi9GdYRkzI/bG2PHcXFEi9uGn2YkQq
	cxo6qwDHraJljLeXn/pD7iF0cqX2lbNBxowDinmPXgCtA6baAXBQbfDkqslwEfROE57+u+l96mr
	H3ba5Ctey0stc0lj4gy1jqGSR6t2mfn+lnwXhzN+V8AjTMHprRiN6URF7faomySPlqTs0cep6tp
	h7Jh16isTHNr1PHsjuIRhr3H6blwoFFihM8fDTpJ9d52y+uUlF6PKejnTpOdl+MNWEETno31GtE
	yvrmV90YH9GzRiitm2BwJCIbL/rU/F6yZD1YxxnNq+NjVHnAQA63obeQyGjp98uHXYJuDstn56+
	qe1kEle93KKU6Iu+jweVydWLN40u/yBhpnmZ3W65vAx4TIwq9GRfCiiE1xzsXNxmv9TbFFrxAb6
	c9H3DTJK9GIdEdQdzA5yObXfuWgc/4WI4G
X-Google-Smtp-Source: AGHT+IGQ1oJIJsgSbTE25rUPYQbOXvZA9fZDeWGgVb5ZU8Gh8y0+bI+696VC2IPvCWeUs/WTbPO2dg==
X-Received: by 2002:a17:903:8cb:b0:295:6427:87d4 with SMTP id d9443c01a7336-2984ee18d1cmr62642185ad.50.1762998418704;
        Wed, 12 Nov 2025 17:46:58 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccae8sm4986485ad.98.2025.11.12.17.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:46:58 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: devicetree@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Conor Dooley <conor@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Joe Perches <joe@perches.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Nicolas Palix <nicolas.palix@imag.fr>
Subject: [PATCH v3 00/22] riscv: Memory type control for platforms with physical memory aliases
Date: Wed, 12 Nov 2025 17:45:13 -0800
Message-ID: <20251113014656.2605447-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


On some RISC-V platforms, including StarFive JH7100 and ESWIN EIC7700,
DRAM is mapped to multiple physical address ranges, with each alias
having a different set of statically-determined Physical Memory
Attributes (PMAs), such as cacheability. Software can alter the PMAs for
a page by selecting a PFN from the corresponding physical address range.
On these platforms, this is the only way to allocate noncached memory
for use with noncoherent DMA.

These physical memory aliases are only visible to architecture code.
Generic MM code only ever sees the primary (cacheable) alias. The major
change from v1 of this series is that I was asked to move the hooks from
pfn_pXX()/pXX_pfn() to set_pXX()/pXXp_get().

 - Patches 1-10 ensure that architecture-specific code that hooks page
   table reads and writes is always called, and the calls are balanced.
 - Patches 11-14 refactor existing platform-specific memory type support
   to be modeled as variants on top of the standard Svpbmt extension,
   and apply the memory type transformation during PTE reads/writes.
 - Patches 15-20 add a new DT binding to describe physical memory
   regions, and implement a new memory type variant that transforms the
   PFN to use the desired alias when reading/writing page tables.
 - Patches 21-22 enable this new memory type variant on StarFive JH7100
   and ESWIN EIC7700.

I have boot-tested this series and tested DMA on SoCs with each of the
four ways to select a memory type: SiFive FU740 (none), SiFive
P470-based SoC (Svpbmt), Allwinner D1 (XTheadMae), StarFive JH7100
(aliases), and ESWIN EIC7700 (aliases).

Here is some basic `perf benchmark` data comparing relative performance
between v6.17 and either the generic MM changes or the whole series:

 Test        | Scenario   |  FU740 |   P470 |    D1  | EIC7700
 =============================================================
 syscall     | patch 1-10 | +3.17% | +0.89% | +2.60% |  +0.68%
   basic     |     series | -2.52% | -1.41% | +1.37% |  -0.64%
 -------------------------------------------------------------
 syscall     | patch 1-10 | +0.17% | -0.57% | +2.79% |  -1.12%
   fork      |     series | -1.31% | -5.91% | -1.50% |  -2.73%
 -------------------------------------------------------------
 syscall     | patch 1-10 | -0.24% | -0.30% | +2.76% |  +1.32%
   execve    |     series | -1.65% | -4.82% | -1.38% |  -0.66%
 -------------------------------------------------------------
 sched       | patch 1-10 | +1.54% | -5.76% | -5.09% |  -1.04%
   messaging |     series | +0.66% | +2.00% | +1.40% |  +1.97%
 -------------------------------------------------------------

The benchmark results are stable within each machine, and the same
binary was used on all machines. I would have expected the preparatory
changes (patch 1-10) to hurt performance somewhat, due to READ_ONCE/
WRITE_ONCE generating additional loads/stores, but surprisingly
performance was improved in some cases. The variation across machines
in response to the entire series is expected, as each of these machines
gets a different version of the alternative block.

Changes in v3:
 - Use upstream commit/patch for Anshuman Khandual's changes
 - Rebased on top of torvalds/master (v6.18-rc5+)
 - Add a checkpatch rule to warn on page table pointer dereference
 - Select DMA_DIRECT_REMAP when any memory type extension is enabled
 - Split PMR_IS_ALIAS flag from PMR_ALIAS_MASK number
 - Add "model" property to DT binding example to fix validation
 - Fix the logic to allow an alias to be paired with region entry 0
 - Fix the entry number of the paired region in the DT
 - Keep the ERRATA_STARFIVE_JH7100 option but update its description
 - CC all core MM reviewers

Changes in v2:
 - Keep Kconfig options for each PBMT variant separate/non-overlapping
 - Move fixup code sequences to set_pXX() and pXXp_get()
 - Only define ALT_UNFIX_MT in configurations that need it
 - Improve inline documentation of ALT_FIXUP_MT/ALT_UNFIX_MT
 - Fix erroneously-escaped newline in assembly ALTERNATIVE_CFG_3 macro
 - Remove references to Physical Address Width (no longer part of Smmpt)
 - Remove special first entry from the list of physical memory regions
 - Fix compatible string in DT binding example
 - Put new code behind a new Kconfig option RISCV_ISA_XLINUXMEMALIAS
 - Document the calling convention of riscv_fixup/unfix_memory_alias()
 - Do not transform !pte_present() (e.g. swap) PTEs
 - Export riscv_fixup/unfix_memory_alias() to fix module compilation
 - Move the JH7100 DT changes from jh7100-common.dtsi to jh7100.dtsi
 - Keep RISCV_DMA_NONCOHERENT and RISCV_NONSTANDARD_CACHE_OPS selected

Anshuman Khandual (4):
  mm/ptdump: replace READ_ONCE() with standard page table accessors
  mm: replace READ_ONCE() with standard page table accessors
  mm/dirty: replace READ_ONCE() with pudp_get()
  perf/events: replace READ_ONCE() with standard page table accessors

Samuel Holland (18):
  mm: Move the fallback definitions of pXXp_get()
  mm: Always use page table accessor functions
  checkpatch: Warn on page table access without accessors
  mm: Allow page table accessors to be non-idempotent
  riscv: hibernate: Replace open-coded pXXp_get()
  riscv: mm: Always use page table accessor functions
  riscv: mm: Simplify set_p4d() and set_pgd()
  riscv: mm: Deduplicate _PAGE_CHG_MASK definition
  riscv: ptdump: Only show N and MT bits when enabled in the kernel
  riscv: mm: Fix up memory types when writing page tables
  riscv: mm: Expose all page table bits to assembly code
  riscv: alternative: Add an ALTERNATIVE_3 macro
  riscv: alternative: Allow calls with alternate link registers
  riscv: Fix logic for selecting DMA_DIRECT_REMAP
  dt-bindings: riscv: Describe physical memory regions
  riscv: mm: Use physical memory aliases to apply PMAs
  riscv: dts: starfive: jh7100: Use physical memory ranges for DMA
  riscv: dts: eswin: eic7700: Use physical memory ranges for DMA

 .../bindings/riscv/physical-memory.yaml       |  92 +++++++
 arch/riscv/Kconfig                            |  19 +-
 arch/riscv/Kconfig.errata                     |  11 +-
 arch/riscv/Kconfig.socs                       |   4 +
 arch/riscv/boot/dts/eswin/eic7700.dtsi        |   5 +
 .../boot/dts/starfive/jh7100-common.dtsi      |  24 --
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |   4 +
 arch/riscv/include/asm/alternative-macros.h   |  45 +++-
 arch/riscv/include/asm/errata_list.h          |  45 ----
 arch/riscv/include/asm/hwcap.h                |   1 +
 arch/riscv/include/asm/pgtable-32.h           |  17 +-
 arch/riscv/include/asm/pgtable-64.h           | 228 +++++++++++++-----
 arch/riscv/include/asm/pgtable-bits.h         |  43 +++-
 arch/riscv/include/asm/pgtable.h              |  67 ++---
 arch/riscv/kernel/alternative.c               |   4 +-
 arch/riscv/kernel/cpufeature.c                |   6 +
 arch/riscv/kernel/hibernate.c                 |  18 +-
 arch/riscv/kernel/setup.c                     |   1 +
 arch/riscv/kvm/gstage.c                       |   6 +-
 arch/riscv/mm/Makefile                        |   1 +
 arch/riscv/mm/init.c                          |  68 +++---
 arch/riscv/mm/memory-alias.S                  | 123 ++++++++++
 arch/riscv/mm/pgtable.c                       | 114 +++++++--
 arch/riscv/mm/ptdump.c                        |  16 +-
 fs/dax.c                                      |   4 +-
 fs/proc/task_mmu.c                            |  27 ++-
 fs/userfaultfd.c                              |   6 +-
 include/dt-bindings/riscv/physical-memory.h   |  45 ++++
 include/linux/huge_mm.h                       |   8 +-
 include/linux/mm.h                            |  14 +-
 include/linux/pgtable.h                       | 112 ++++-----
 kernel/events/core.c                          |   8 +-
 mm/damon/vaddr.c                              |   2 +-
 mm/debug_vm_pgtable.c                         |   4 +-
 mm/filemap.c                                  |   6 +-
 mm/gup.c                                      |  37 +--
 mm/hmm.c                                      |   2 +-
 mm/huge_memory.c                              |  90 +++----
 mm/hugetlb.c                                  |  10 +-
 mm/hugetlb_vmemmap.c                          |   4 +-
 mm/kasan/init.c                               |  39 +--
 mm/kasan/shadow.c                             |  12 +-
 mm/khugepaged.c                               |  10 +-
 mm/ksm.c                                      |   2 +-
 mm/madvise.c                                  |   8 +-
 mm/mapping_dirty_helpers.c                    |   2 +-
 mm/memory-failure.c                           |  14 +-
 mm/memory.c                                   |  80 +++---
 mm/mempolicy.c                                |   4 +-
 mm/migrate.c                                  |   4 +-
 mm/migrate_device.c                           |  10 +-
 mm/mlock.c                                    |   6 +-
 mm/mprotect.c                                 |   4 +-
 mm/mremap.c                                   |  30 +--
 mm/page_table_check.c                         |   7 +-
 mm/page_vma_mapped.c                          |   6 +-
 mm/pagewalk.c                                 |  14 +-
 mm/percpu.c                                   |   8 +-
 mm/pgalloc-track.h                            |   8 +-
 mm/pgtable-generic.c                          |  25 +-
 mm/ptdump.c                                   |  10 +-
 mm/rmap.c                                     |   8 +-
 mm/sparse-vmemmap.c                           |  10 +-
 mm/userfaultfd.c                              |  10 +-
 mm/vmalloc.c                                  |  49 ++--
 mm/vmscan.c                                   |  16 +-
 scripts/checkpatch.pl                         |   7 +
 67 files changed, 1129 insertions(+), 615 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/physical-memory.yaml
 create mode 100644 arch/riscv/mm/memory-alias.S
 create mode 100644 include/dt-bindings/riscv/physical-memory.h

-- 
2.47.2

base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
branch: up/dma-alias

