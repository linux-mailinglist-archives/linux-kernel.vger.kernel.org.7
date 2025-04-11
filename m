Return-Path: <linux-kernel+bounces-599772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA05A857C7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 11:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDB2D7A79F9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 09:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65264293B4C;
	Fri, 11 Apr 2025 09:17:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0A21E5B99
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363023; cv=none; b=FstoXcm9fqka0WVVar9DTEdoUxuHEa4u4oPWpnbDFb9w/jPy+A3/bO+leViAFkaWQeAK4Mhobi/pIU6JIf1XTYS/og0wotLXnOkfCaq0uXG1BqcU4Cmw6+yyVU+1wfjimh1TbRoqsN9D/8CrsmRcuDKtZb1C5c6bObrmfp7abuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363023; c=relaxed/simple;
	bh=0PL2NvJJ9bMt8cEkUrXaJZ5rbCF5zqK2HLSK0rZvHBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c0OYVc8Mk3fKGkwA7OWkBMdf4+IHn8blrEWsfkBJqHkK2FHk4MdK3sqn9AuSadXeOR6qJG5QMRL7rjujkfRqceBpErJ193PBJyDgpjJj6FMQJuARMtwrKg3MWaYg/G0yjPWQ2SNlzJDnehBi/AqMEikAsbIB2jWPQH5VCAeB5Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB764106F;
	Fri, 11 Apr 2025 02:16:56 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 428403F6A8;
	Fri, 11 Apr 2025 02:16:53 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Subject: [RFC PATCH v4 00/18] pkeys-based page table hardening
Date: Fri, 11 Apr 2025 10:16:13 +0100
Message-ID: <20250411091631.954228-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NEW in v4: performance estimation (section "Performance")

This is a proposal to leverage protection keys (pkeys) to harden
critical kernel data, by making it mostly read-only. The series includes
a simple framework called "kpkeys" to manipulate pkeys for in-kernel use,
as well as a page table hardening feature based on that framework,
"kpkeys_hardened_pgtables". Both are implemented on arm64 as a proof of
concept, but they are designed to be compatible with any architecture
that supports pkeys.

The proposed approach is a typical use of pkeys: the data to protect is
mapped with a given pkey P, and the pkey register is initially configured
to grant read-only access to P. Where the protected data needs to be
written to, the pkey register is temporarily switched to grant write
access to P on the current CPU.

The key fact this approach relies on is that the target data is
only written to via a limited and well-defined API. This makes it
possible to explicitly switch the pkey register where needed, without
introducing excessively invasive changes, and only for a small amount of
trusted code.

Page tables were chosen as they are a popular (and critical) target for
attacks, but there are of course many others - this is only a starting
point (see section "Further use-cases"). It has become more and more
common for accesses to such target data to be mediated by a hypervisor
in vendor kernels; the hope is that kpkeys can provide much of that
protection in a simpler and cheaper manner. A rough performance
estimation has been performed on a modern arm64 system, see section
"Performance".

This series has similarities with the "PKS write protected page tables"
series posted by Rick Edgecombe a few years ago [1], but it is not
specific to x86/PKS - the approach is meant to be generic.

kpkeys
======

The use of pkeys involves two separate mechanisms: assigning a pkey to
pages, and defining the pkeys -> permissions mapping via the pkey
register. This is implemented through the following interface:

- Pages in the linear mapping are assigned a pkey using set_memory_pkey().
  This is sufficient for this series, but of course higher-level
  interfaces can be introduced later to ask allocators to return pages
  marked with a given pkey. It should also be possible to extend this to
  vmalloc() if needed.

- The pkey register is configured based on a *kpkeys level*. kpkeys
  levels are simple integers that correspond to a given configuration,
  for instance:

  KPKEYS_LVL_DEFAULT:
        RW access to KPKEYS_PKEY_DEFAULT
        RO access to any other KPKEYS_PKEY_*

  KPKEYS_LVL_<FEAT>:
        RW access to KPKEYS_PKEY_DEFAULT
        RW access to KPKEYS_PKEY_<FEAT>
        RO access to any other KPKEYS_PKEY_*

  Only pkeys that are managed by the kpkeys framework are impacted;
  permissions for other pkeys are left unchanged (this allows for other
  schemes using pkeys to be used in parallel, and arch-specific use of
  certain pkeys).

  The kpkeys level is changed by calling kpkeys_set_level(), setting the
  pkey register accordingly and returning the original value. A
  subsequent call to kpkeys_restore_pkey_reg() restores the kpkeys
  level. The numeric value of KPKEYS_LVL_* (kpkeys level) is purely
  symbolic and thus generic, however each architecture is free to define
  KPKEYS_PKEY_* (pkey value).

kpkeys_hardened_pgtables
========================

The kpkeys_hardened_pgtables feature uses the interface above to make
the (kernel and user) page tables read-only by default, enabling write
access only in helpers such as set_pte(). One complication is that those
helpers as well as page table allocators are used very early, before
kpkeys become available. Enabling kpkeys_hardened_pgtables, if and when
kpkeys become available, is therefore done as follows:

1. A static key is turned on. This enables a transition to
   KPKEYS_LVL_PGTABLES in all helpers writing to page tables, and also
   impacts page table allocators (step 3).

2. swapper_pg_dir is walked to set all early page table pages to
   KPKEYS_PKEY_PGTABLES.

3. Page table allocators set the returned pages to KPKEYS_PKEY_PGTABLES
   (and the pkey is reset upon freeing). This ensures that all page
   tables are mapped with that privileged pkey.

This series
===========

The series is composed of two parts:

- The kpkeys framework (patch 1-9). The main API is introduced in
  <linux/kpkeys.h>, and it is implemented on arm64 using the POE
  (Permission Overlay Extension) feature.

- The kpkeys_hardened_pgtables feature (patch 10-18). <linux/kpkeys.h>
  is extended with an API to set page table pages to a given pkey and a
  guard object to switch kpkeys level accordingly, both gated on a
  static key. This is then used in generic and arm64 pgtable handling
  code as needed. Finally a simple KUnit-based test suite is added to
  demonstrate the page table protection.

pkey register management
========================

The kpkeys model relies on the kernel pkey register being set to a
specific value for the duration of a relatively small section of code,
and otherwise to the default value. Accordingly, the arm64
implementation based on POE handles its pkey register (POR_EL1) as
follows:

- POR_EL1 is saved and reset to its default value on exception entry,
  and restored on exception return. This ensures that exception handling
  code runs in a fixed kpkeys state.

- POR_EL1 is context-switched per-thread. This allows sections of code
  that run at a non-default kpkeys level to sleep (e.g. when locking a
  mutex). For kpkeys_hardened_pgtables, only involuntary preemption is
  relevant and the previous point already handles that; however sleeping
  is likely to occur in more advanced uses of kpkeys.

An important assumption is that all kpkeys levels allow RW access to the
default pkey (0). Otherwise, saving POR_EL1 before resetting it on
exception entry would be a best difficult, and context-switching it too.

Performance
===========

No arm64 hardware currently implements POE. To estimate the performance
impact of kpkeys_hardened_pgtables, a mock implementation of kpkeys has
been used, replacing accesses to the POR_EL1 register with accesses to
another system register that is otherwise unused (CONTEXTIDR_EL1), and
leaving everything else unchanged. Most of the kpkeys overhead is
expected to originate from the barrier (ISB) that is required after
writing to POR_EL1, and from setting the POIndex (pkey) in page tables;
both of these are done exactly in the same way in the mock
implementation.

The original implementation of kpkeys_hardened_pgtables is very
inefficient when many PTEs are changed at once, as the kpkeys level is
switched twice for every PTE (two ISBs per PTE). Patch 18 introduces
an optimisation that makes use of the lazy_mmu mode to batch those
switches: 1. switch to KPKEYS_LVL_PGTABLES on arch_enter_lazy_mmu_mode(),
2. skip any kpkeys switch while in that section, and 3. restore the
kpkeys level on arch_leave_lazy_mmu_mode(). When that last function
already issues an ISB (when updating kernel page tables), we get a
further optimisation as we can skip the ISB when restoring the kpkeys
level.

Both implementations (without and with batching) were evaluated on an
Amazon EC2 M7g instance (Graviton3), using a variety of benchmarks that
involve heavy page table manipulations. The results shown below are
relative to the baseline for this series, which is 6.15-rc1 + [2] + [3].
The branches used for all three sets of results (baseline, with/without
batching) are available in a repository, see next section. Positive
numbers indicate a regression; regressions that are considered
statistically significant (95% confidence interval) are annotated with
"(R)".

Caveat: these numbers should be seen as a lower bound for the overhead
of a real POE-based protection. The hardware checks added by POE are
however not expected to incur significant extra overhead.

+-------------------+----------------------------------+------------------+---------------+
| Benchmark         | Result Class                     | Without batching | With batching |
+===================+==================================+==================+===============+
| mmtests/kernbench | elsp-64                          |            0.20% |         0.20% |
|                   | syst-64                          |            1.62% |         0.63% |
|                   | user-64                          |           -0.04% |         0.05% |
+-------------------+----------------------------------+------------------+---------------+
| micromm/fork      | fork: p:1                        |      (R) 225.56% |        -0.07% |
|                   | fork: p:512                      |      (R) 254.32% |         0.73% |
+-------------------+----------------------------------+------------------+---------------+
| micromm/munmap    | munmap: p:1                      |       (R) 24.49% |         4.29% |
|                   | munmap: p:512                    |      (R) 161.47% |     (R) 6.06% |
+-------------------+----------------------------------+------------------+---------------+
| micromm/vmalloc   | fix_size_alloc_test: p:1, h:0    |       (R) 14.80% |    (R) 11.85% |
|                   | fix_size_alloc_test: p:4, h:0    |       (R) 38.42% |    (R) 10.47% |
|                   | fix_size_alloc_test: p:16, h:0   |       (R) 64.74% |     (R) 6.41% |
|                   | fix_size_alloc_test: p:64, h:0   |       (R) 79.98% |     (R) 3.24% |
|                   | fix_size_alloc_test: p:256, h:0  |       (R) 85.46% |     (R) 2.77% |
|                   | fix_size_alloc_test: p:16, h:1   |       (R) 47.89% |         3.10% |
|                   | fix_size_alloc_test: p:64, h:1   |       (R) 62.43% |         3.36% |
|                   | fix_size_alloc_test: p:256, h:1  |       (R) 64.30% |     (R) 2.68% |
|                   | random_size_alloc_test: p:1, h:0 |       (R) 74.94% |     (R) 3.13% |
|                   | vm_map_ram_test: p:1, h:0        |       (R) 30.53% |    (R) 26.20% |
+-------------------+----------------------------------+------------------+---------------+

Benchmarks:
- mmtests/kernbench: running kernbench (kernel build) [4].
- micromm/{fork,munmap}: from David Hildenbrand's benchmark suite. A
  mapping of a given number of pages (p:) is created and then fork/unmap
  is called.
- micromm/vmalloc: from test_vmalloc.ko, varying the number of pages
  (p:) and whether huge pages are used (h:).

On a "real-world" and fork-heavy workload like kernbench, the estimated
overhead of kpkeys_hardened_pgtables turns out to be rather modest: 1.6%
system time overhead without batching, and less than half that figure
(0.6%) with batching.

Microbenchmarks show large overheads without batching, which increase
with the number of pages being manipulated. Batching drastically reduces
that overhead, almost negating it for micromm/fork. Because all PTEs in
the mapping are modified in the same lazy_mmu section, the kpkeys level
is changed just twice regardless of the mapping size; as a result the
relative overhead actually decreases as the size increases for
fix_size_alloc_test. (It isn't immediately clear why this does not apply
to micromm/munmap; maybe the mapping isn't fully PTE-mapped?)

Note: the performance impact of set_memory_pkey() is likely to be
relatively low on arm64 because the linear mapping uses PTE-level
descriptors only. This means that set_memory_pkey() simply changes the
attributes of some PTE descriptors. However, some systems may be able to
use higher-level descriptors in the future [5], meaning that
set_memory_pkey() may have to split mappings. Allocating page tables
from a contiguous cache of pages could help minimise the overhead, as
proposed for x86 in [1].

Branches
========

To make reviewing and testing easier, this series is available here:

  https://gitlab.arm.com/linux-arm/linux-kb

The following branches are available:

- kpkeys/rfc-v4 - this series, as posted

- kpkeys/rfc-v4-base - the baseline for this series, that is:
  6.15-rc1 + [2] + [3]

- kpkeys/rfc-v4-bench-batching - this series + patch for benchmarking on
  a regular arm64 system (see section above)

- kpkeys/rfc-v4-bench-no-batching - this series without patch 18
  (batching) + benchmarking patch

Threat model
============

The proposed scheme aims at mitigating data-only attacks (e.g.
use-after-free/cross-cache attacks). In other words, it is assumed that
control flow is not corrupted, and that the attacker does not achieve
arbitrary code execution. Nothing prevents the pkey register from being
set to its most permissive state - the assumption is that the register
is only modified on legitimate code paths.

A few related notes:

- Functions that set the pkey register are all implemented inline.
  Besides performance considerations, this is meant to avoid creating
  a function that can be used as a straightforward gadget to set the
  pkey register to an arbitrary value.

- kpkeys_set_level() only accepts a compile-time constant as argument,
  as a variable could be manipulated by an attacker. This could be
  relaxed but it seems unlikely that a variable kpkeys level would be
  needed in practice.

Further use-cases
=================

It should be possible to harden various targets using kpkeys, including:

- struct cred - kpkeys-based cred hardening is now available in a
  separate series [6]

- fixmap (occasionally used even after early boot, e.g.
  set_swapper_pgd() in arch/arm64/mm/mmu.c)

- SELinux state (e.g. struct selinux_state::initialized)

... and many others.

kpkeys could also be used to strengthen the confidentiality of secret
data by making it completely inaccessible by default, and granting
read-only or read-write access as needed. This requires such data to be
rarely accessed (or via a limited interface only). One example on arm64
is the pointer authentication keys in thread_struct, whose leakage to
userspace would lead to pointer authentication being easily defeated.

Open questions
==============

A few aspects in this RFC that are debatable and/or worth discussing:

- There is currently no restriction on how kpkeys levels map to pkeys
  permissions. A typical approach is to allocate one pkey per level and
  make it writable at that level only. As the number of levels
  increases, we may however run out of pkeys, especially on arm64 (just
  8 pkeys with POE). Depending on the use-cases, it may be acceptable to
  use the same pkey for the data associated to multiple levels.

  Another potential concern is that a given piece of code may require
  write access to multiple privileged pkeys. This could be addressed by
  introducing a notion of hierarchy in trust levels, where Tn is able to
  write to memory owned by Tm if n >= m, for instance.

- kpkeys_set_level() and kpkeys_restore_pkey_reg() are not symmetric:
  the former takes a kpkeys level and returns a pkey register value, to
  be consumed by the latter. It would be more intuitive to manipulate
  kpkeys levels only. However this assumes that there is a 1:1 mapping
  between kpkeys levels and pkey register values, while in principle
  the mapping is 1:n (certain pkeys may be used outside the kpkeys
  framework).

- An architecture that supports kpkeys is expected to select
  CONFIG_ARCH_HAS_KPKEYS and always enable them if available - there is
  no CONFIG_KPKEYS to control this behaviour. Since this creates no
  significant overhead (at least on arm64), it seemed better to keep it
  simple. Each hardening feature does have its own option and arch
  opt-in if needed (CONFIG_KPKEYS_HARDENED_PGTABLES,
  CONFIG_ARCH_HAS_KPKEYS_HARDENED_PGTABLES).


Any comment or feedback will be highly appreciated, be it on the
high-level approach or implementation choices!

- Kevin

---
Changelog

RFC v3..v4:

- Added appropriate handling of the arm64 pkey register (POR_EL1):
  context-switching between threads and resetting on exception entry
  (patch 7 and 8). See section "pkey register management" above for more
  details. A new POR_EL1_INIT macro is introduced to make the default
  value available to assembly (where POR_EL1 is reset on exception
  entry); it is updated in each patch allocating new keys.

- Added patch 18 making use of the lazy_mmu mode to batch switches to
  KPKEYS_LVL_PGTABLES - just once per lazy_mmu section rather than on
  every pgtable write. See section "Performance" for details.

- Rebased on top of [2]. No direct impact on the patches, but it ensures that
  the ctor/dtor is always called for kernel pgtables. This is an
  important fix as kernel PTEs allocated after boot were not protected
  by kpkeys_hardened_pgtables in v3 - a new test was added to patch 17
  to ensure that pgtables created by vmalloc are protected too.

- Rebased on top of [3]. The batching of kpkeys level switches in patch
  18 relies on the last patch in [3].

- Moved kpkeys guard definitions out of <linux/kpkeys.h> and to a relevant
  header for each subsystem (e.g. <asm/pgtable.h> for the
  kpkeys_hardened_pgtables guard).

- Patch 1,5: marked kpkeys_{set_level,restore_pkey_reg} as
  __always_inline to ensure that no callable gadget is created.
  [Maxwell Bland's suggestion]

- Patch 5: added helper __kpkeys_set_pkey_reg_nosync().

- Patch 10: marked kernel_pgtables_set_pkey() and related helpers as
  __init. [Linus Walleij's suggestion]

- Patch 11: added helper kpkeys_hardened_pgtables_enabled(), renamed the
  static key to kpkeys_hardened_pgtables_key.

- Patch 17: followed the KUnit conventions more closely. [Kees Cook's
  suggestion]

- Patch 17: changed the address used in the write_linear_map_pte()
  test. It seems that the PTEs that map some functions are allocated in
  ZONE_DMA and read-only (unclear why exactly). This doesn't seem to
  occur for global variables.

- Various minor fixes/improvements.

- Rebased on v6.15-rc1. This includes [7], which renames a few POE
  symbols: s/POE_RXW/POE_RWX/ and
  s/por_set_pkey_perms/por_elx_set_pkey_perms/


RFC v3: https://lore.kernel.org/linux-hardening/20250203101839.1223008-1-kevin.brodsky@arm.com/

RFC v2..v3:

- Patch 1: kpkeys_set_level() may now return KPKEYS_PKEY_REG_INVAL to indicate
  that the pkey register wasn't written to, and as a result that
  kpkeys_restore_pkey_reg() should do nothing. This simplifies the conditional
  guard macro and also allows architectures to skip writes to the pkey
  register if the target value is the same as the current one.

- Patch 1: introduced additional KPKEYS_GUARD* macros to cover more use-cases
  and reduce duplication.

- Patch 6: reject pkey value above arch_max_pkey().

- Patch 13: added missing guard(kpkeys_hardened_pgtables) in
  __clear_young_dirty_pte().

- Rebased on v6.14-rc1.

RFC v2: https://lore.kernel.org/linux-hardening/20250108103250.3188419-1-kevin.brodsky@arm.com/

RFC v1..v2:

- A new approach is used to set the pkey of page table pages. Thanks to
  Qi Zheng's and my own series [8][9], pagetable_*_ctor is
  systematically called when a PTP is allocated at any level (PTE to
  PGD), and pagetable_*_dtor when it is freed, on all architectures.
  Patch 11 makes use of this to call kpkeys_{,un}protect_pgtable_memory
  from the common ctor/dtor helper. The arm64 patches from v1 (patch 12
  and 13) are dropped as they are no longer needed. Patch 10 is
  introduced to allow pagetable_*_ctor to fail at all levels, since
  kpkeys_protect_pgtable_memory may itself fail.
  [Original suggestion by Peter Zijlstra]

- Changed the prototype of kpkeys_{,un}protect_pgtable_memory in patch 9
  to take a struct folio * for more convenience, and implemented them
  out-of-line to avoid a circular dependency with <linux/mm.h>.

- Rebased on next-20250107, which includes [8] and [9].

- Added locking in patch 8. [Peter Zijlstra's suggestion]

RFC v1: https://lore.kernel.org/linux-hardening/20241206101110.1646108-1-kevin.brodsky@arm.com/
---
References

[1] https://lore.kernel.org/all/20210830235927.6443-1-rick.p.edgecombe@intel.com/
[2] https://lore.kernel.org/linux-mm/20250408095222.860601-1-kevin.brodsky@arm.com/
[3] https://lore.kernel.org/linux-mm/20250304150444.3788920-1-ryan.roberts@arm.com/
[4] https://github.com/gormanm/mmtests/blob/master/shellpack_src/src/kernbench/kernbench-bench
[5] https://lore.kernel.org/all/20250304222018.615808-1-yang@os.amperecomputing.com/
[6] https://lore.kernel.org/linux-hardening/20250203102809.1223255-1-kevin.brodsky@arm.com/
[7] https://lore.kernel.org/linux-arm-kernel/20250219164029.2309119-1-kevin.brodsky@arm.com/
[8] https://lore.kernel.org/linux-mm/cover.1736317725.git.zhengqi.arch@bytedance.com/
[9] https://lore.kernel.org/linux-mm/20250103184415.2744423-1-kevin.brodsky@arm.com/
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jann Horn <jannh@google.com>
Cc: Jeff Xu <jeffxu@chromium.org>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Pierre Langlois <pierre.langlois@arm.com>
Cc: Quentin Perret <qperret@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org
Cc: x86@kernel.org
---
Kevin Brodsky (18):
  mm: Introduce kpkeys
  set_memory: Introduce set_memory_pkey() stub
  arm64: mm: Enable overlays for all EL1 indirect permissions
  arm64: Introduce por_elx_set_pkey_perms() helper
  arm64: Implement asm/kpkeys.h using POE
  arm64: set_memory: Implement set_memory_pkey()
  arm64: Reset POR_EL1 on exception entry
  arm64: Context-switch POR_EL1
  arm64: Enable kpkeys
  mm: Introduce kernel_pgtables_set_pkey()
  mm: Introduce kpkeys_hardened_pgtables
  mm: Allow __pagetable_ctor() to fail
  mm: Map page tables with privileged pkey
  arm64: kpkeys: Support KPKEYS_LVL_PGTABLES
  arm64: mm: Guard page table writes with kpkeys
  arm64: Enable kpkeys_hardened_pgtables support
  mm: Add basic tests for kpkeys_hardened_pgtables
  arm64: mm: Batch kpkeys level switches

 arch/arm64/Kconfig                        |   2 +
 arch/arm64/include/asm/kpkeys.h           |  62 +++++++++
 arch/arm64/include/asm/pgtable-prot.h     |  16 +--
 arch/arm64/include/asm/pgtable.h          |  57 +++++++-
 arch/arm64/include/asm/por.h              |  11 ++
 arch/arm64/include/asm/processor.h        |   2 +
 arch/arm64/include/asm/ptrace.h           |   4 +
 arch/arm64/include/asm/set_memory.h       |   4 +
 arch/arm64/kernel/asm-offsets.c           |   3 +
 arch/arm64/kernel/cpufeature.c            |   5 +-
 arch/arm64/kernel/entry.S                 |  24 +++-
 arch/arm64/kernel/process.c               |   9 ++
 arch/arm64/kernel/smp.c                   |   2 +
 arch/arm64/mm/fault.c                     |   2 +
 arch/arm64/mm/mmu.c                       |  26 ++--
 arch/arm64/mm/pageattr.c                  |  25 ++++
 include/asm-generic/kpkeys.h              |  21 +++
 include/asm-generic/pgalloc.h             |  15 ++-
 include/linux/kpkeys.h                    | 157 ++++++++++++++++++++++
 include/linux/mm.h                        |  27 ++--
 include/linux/set_memory.h                |   7 +
 mm/Kconfig                                |   5 +
 mm/Makefile                               |   2 +
 mm/kpkeys_hardened_pgtables.c             |  44 ++++++
 mm/memory.c                               | 137 +++++++++++++++++++
 mm/tests/kpkeys_hardened_pgtables_kunit.c |  97 +++++++++++++
 security/Kconfig.hardening                |  24 ++++
 27 files changed, 749 insertions(+), 41 deletions(-)
 create mode 100644 arch/arm64/include/asm/kpkeys.h
 create mode 100644 include/asm-generic/kpkeys.h
 create mode 100644 include/linux/kpkeys.h
 create mode 100644 mm/kpkeys_hardened_pgtables.c
 create mode 100644 mm/tests/kpkeys_hardened_pgtables_kunit.c

-- 
2.47.0


