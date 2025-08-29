Return-Path: <linux-kernel+bounces-791699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DD0B3BA46
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492C41C8720A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3008F31578E;
	Fri, 29 Aug 2025 11:53:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60859314A96
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468387; cv=none; b=BGcXk1a+PVloJi5lBeRtBM6xbFXn/TZpscGkssTvhKV7BcVsqulaLpLHuv2cz+TQZ9llvi6RPKaX/9A1esG/Z/b0IW4b+mhzd0ecSaLX6AIuT+4YuK1MMUe1NQ7G/gOftkuJ/+26gMbcGqkhhWoOyylCcMRBN/zGNC8qfk9Nut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468387; c=relaxed/simple;
	bh=NFNthLyAq9eCER4Vcg9USH/AoVBxFsXMR9h6jeIl2U0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YAt8BzmyBQ7IcPBvYZVO6KmHosSaXUqPjQCwlEijK3bj3ofSbo2Y2BSCtxgzY9dAMip2j2A/NK/heISj9R8pS5oSb62go720Wub8aHyalZEixlWt7FI5hSaFzy5BFHcJB1a2gFRfEdn+frYby1vm/xsPTPuCyg++U13p7z14C/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A99A19F0;
	Fri, 29 Aug 2025 04:52:56 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 951F53F694;
	Fri, 29 Aug 2025 04:53:02 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v7 0/6] arm64: support FEAT_BBM level 2 and large block mapping when rodata=full
Date: Fri, 29 Aug 2025 12:52:41 +0100
Message-ID: <20250829115250.2395585-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This is a new version following on from the v6 RFC at [1] which itself is based
on Yang Shi's work. On systems with BBML2_NOABORT support, it causes the linear
map to be mapped with large blocks, even when rodata=full, and leads to some
nice performance improvements.

I've tested this on an AmpereOne system (a VM with 12G RAM) in all 3 possible
modes by hacking the BBML2 feature detection code:

  - mode 1: All CPUs support BBML2 so the linear map uses large mappings
  - mode 2: Boot CPU does not support BBML2 so linear map uses pte mappings
  - mode 3: Boot CPU supports BBML2 but secondaries do not so linear map
    initially uses large mappings but is then repainted to use pte mappings

In all cases, mm selftests run and no regressions are observed. In all cases,
ptdump of linear map is as expected:

Mode 1:
=======
---[ Linear Mapping start ]---
0xffff000000000000-0xffff000000200000           2M PMD       RW NX SHD AF        BLK UXN    MEM/NORMAL-TAGGED
0xffff000000200000-0xffff000000210000          64K PTE       RW NX SHD AF    CON     UXN    MEM/NORMAL-TAGGED
0xffff000000210000-0xffff000000400000        1984K PTE       ro NX SHD AF            UXN    MEM/NORMAL
0xffff000000400000-0xffff000002400000          32M PMD       ro NX SHD AF        BLK UXN    MEM/NORMAL
0xffff000002400000-0xffff000002550000        1344K PTE       ro NX SHD AF            UXN    MEM/NORMAL
0xffff000002550000-0xffff000002600000         704K PTE       RW NX SHD AF    CON     UXN    MEM/NORMAL-TAGGED
0xffff000002600000-0xffff000004000000          26M PMD       RW NX SHD AF        BLK UXN    MEM/NORMAL-TAGGED
0xffff000004000000-0xffff000040000000         960M PMD       RW NX SHD AF    CON BLK UXN    MEM/NORMAL-TAGGED
0xffff000040000000-0xffff000140000000           4G PUD       RW NX SHD AF        BLK UXN    MEM/NORMAL-TAGGED
0xffff000140000000-0xffff000142000000          32M PMD       RW NX SHD AF    CON BLK UXN    MEM/NORMAL-TAGGED
0xffff000142000000-0xffff000142120000        1152K PTE       RW NX SHD AF    CON     UXN    MEM/NORMAL-TAGGED
0xffff000142120000-0xffff000142128000          32K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000142128000-0xffff000142159000         196K PTE       ro NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000142159000-0xffff000142160000          28K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000142160000-0xffff000142240000         896K PTE       RW NX SHD AF    CON     UXN    MEM/NORMAL-TAGGED
0xffff000142240000-0xffff00014224e000          56K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff00014224e000-0xffff000142250000           8K PTE       ro NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000142250000-0xffff000142260000          64K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000142260000-0xffff000142280000         128K PTE       RW NX SHD AF    CON     UXN    MEM/NORMAL-TAGGED
0xffff000142280000-0xffff000142288000          32K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000142288000-0xffff000142290000          32K PTE       ro NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000142290000-0xffff0001422a0000          64K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff0001422a0000-0xffff000142465000        1812K PTE       ro NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000142465000-0xffff000142470000          44K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000142470000-0xffff000142600000        1600K PTE       RW NX SHD AF    CON     UXN    MEM/NORMAL-TAGGED
0xffff000142600000-0xffff000144000000          26M PMD       RW NX SHD AF        BLK UXN    MEM/NORMAL-TAGGED
0xffff000144000000-0xffff000180000000         960M PMD       RW NX SHD AF    CON BLK UXN    MEM/NORMAL-TAGGED
0xffff000180000000-0xffff000181a00000          26M PMD       RW NX SHD AF        BLK UXN    MEM/NORMAL-TAGGED
0xffff000181a00000-0xffff000181b90000        1600K PTE       RW NX SHD AF    CON     UXN    MEM/NORMAL-TAGGED
0xffff000181b90000-0xffff000181b9d000          52K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000181b9d000-0xffff000181c80000         908K PTE       ro NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000181c80000-0xffff000181c90000          64K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000181c90000-0xffff000181ca0000          64K PTE       RW NX SHD AF    CON     UXN    MEM/NORMAL-TAGGED
0xffff000181ca0000-0xffff000181dbd000        1140K PTE       ro NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000181dbd000-0xffff000181dc0000          12K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000181dc0000-0xffff000181e00000         256K PTE       RW NX SHD AF    CON     UXN    MEM/NORMAL-TAGGED
0xffff000181e00000-0xffff000182000000           2M PMD       RW NX SHD AF        BLK UXN    MEM/NORMAL-TAGGED
0xffff000182000000-0xffff0001c0000000         992M PMD       RW NX SHD AF    CON BLK UXN    MEM/NORMAL-TAGGED
0xffff0001c0000000-0xffff000300000000           5G PUD       RW NX SHD AF        BLK UXN    MEM/NORMAL-TAGGED
0xffff000300000000-0xffff008000000000         500G PUD
0xffff008000000000-0xffff800000000000      130560G PGD
---[ Linear Mapping end ]---

Mode 3:
=======
---[ Linear Mapping start ]---
0xffff000000000000-0xffff000000210000        2112K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000000210000-0xffff000000400000        1984K PTE       ro NX SHD AF            UXN    MEM/NORMAL
0xffff000000400000-0xffff000002400000          32M PMD       ro NX SHD AF        BLK UXN    MEM/NORMAL
0xffff000002400000-0xffff000002550000        1344K PTE       ro NX SHD AF            UXN    MEM/NORMAL
0xffff000002550000-0xffff000143a61000     5264452K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000143a61000-0xffff000143c61000           2M PTE       ro NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000143c61000-0xffff000181b9a000     1015012K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000181b9a000-0xffff000181d9a000           2M PTE       ro NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000181d9a000-0xffff000300000000     6261144K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
0xffff000300000000-0xffff008000000000         500G PUD
0xffff008000000000-0xffff800000000000      130560G PGD
---[ Linear Mapping end ]---


Performance Testing
===================

Yang Shi has gathered some compelling results which are detailed in the commit
log for patch #3. Additionally I have run this through a random selection of
benchmarks on AmpereOne. None show any regressions, and various benchmarks show
statistically significant improvement. I'm just showing those improvements here:

+----------------------+----------------------------------------------------------+-------------------------+
| Benchmark            | Result Class                                             | Improvement vs 6.17-rc1 |
+======================+==========================================================+=========================+
| micromm/vmalloc      | full_fit_alloc_test: p:1, h:0, l:500000 (usec)           |              (I) -9.00% |
|                      | kvfree_rcu_1_arg_vmalloc_test: p:1, h:0, l:500000 (usec) |              (I) -6.93% |
|                      | kvfree_rcu_2_arg_vmalloc_test: p:1, h:0, l:500000 (usec) |              (I) -6.77% |
|                      | pcpu_alloc_test: p:1, h:0, l:500000 (usec)               |              (I) -4.63% |
+----------------------+----------------------------------------------------------+-------------------------+
| mmtests/hackbench    | process-sockets-30 (seconds)                             |              (I) -2.96% |
+----------------------+----------------------------------------------------------+-------------------------+
| mmtests/kernbench    | syst-192 (seconds)                                       |             (I) -12.77% |
+----------------------+----------------------------------------------------------+-------------------------+
| pts/perl-benchmark   | Test: Interpreter (Seconds)                              |              (I) -4.86% |
+----------------------+----------------------------------------------------------+-------------------------+
| pts/pgbench          | Scale: 1 Clients: 1 Read Write (TPS)                     |               (I) 5.07% |
|                      | Scale: 1 Clients: 1 Read Write - Latency (ms)            |              (I) -4.72% |
|                      | Scale: 100 Clients: 1000 Read Write (TPS)                |               (I) 2.58% |
|                      | Scale: 100 Clients: 1000 Read Write - Latency (ms)       |              (I) -2.52% |
+----------------------+----------------------------------------------------------+-------------------------+
| pts/sqlite-speedtest | Timed Time - Size 1,000 (Seconds)                        |              (I) -2.68% |
+----------------------+----------------------------------------------------------+-------------------------+


Changes since v6 [1]
====================

- Patch 1: Minor refactor to implement walk_kernel_page_table_range() in terms
  of walk_kernel_page_table_range_lockless(). Also lead to adding *pmd argument
  to the lockless variant for consistency (per Catalin).
- Misc function/variable renames to improve clarity and consistency.
- Share same syncrhonization flag between idmap_kpti_install_ng_mappings and
  wait_linear_map_split_to_ptes, which allows removal of bbml2_ptes[] to save
  ~20K from kernel image.
- Only take pgtable_split_lock and enter lazy mmu mode once for both splits.
- Only walk the pgtable once for the common "split single page" case.
- Bypass split to contpmd and contpte when spllitting linear map to ptes.


Applies on v6.17-rc3.


[1] https://lore.kernel.org/linux-arm-kernel/20250805081350.3854670-1-ryan.roberts@arm.com/

Thanks,
Ryan

Dev Jain (1):
  arm64: Enable permission change on arm64 kernel block mappings

Ryan Roberts (3):
  arm64: mm: Optimize split_kernel_leaf_mapping()
  arm64: mm: split linear mapping if BBML2 unsupported on secondary CPUs
  arm64: mm: Optimize linear_map_split_to_ptes()

Yang Shi (2):
  arm64: cpufeature: add AmpereOne to BBML2 allow list
  arm64: mm: support large block mapping when rodata=full

 arch/arm64/include/asm/cpufeature.h |   2 +
 arch/arm64/include/asm/mmu.h        |   3 +
 arch/arm64/include/asm/pgtable.h    |   5 +
 arch/arm64/kernel/cpufeature.c      |  12 +-
 arch/arm64/mm/mmu.c                 | 418 +++++++++++++++++++++++++++-
 arch/arm64/mm/pageattr.c            | 157 ++++++++---
 arch/arm64/mm/proc.S                |  27 +-
 include/linux/pagewalk.h            |   3 +
 mm/pagewalk.c                       |  36 ++-
 9 files changed, 599 insertions(+), 64 deletions(-)

--
2.43.0


