Return-Path: <linux-kernel+bounces-736563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6070B09E94
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A72057B674D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4ED2949E5;
	Fri, 18 Jul 2025 09:03:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBE615278E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829383; cv=none; b=tmyXgciv3R61caK9tJ/3c1o6SaxNsVLOo48UUUjklfnpYHtB1K6QQINJ9B0UdWrkEkiTmghi/E9Dx6ylAyayRPjRY10sL8f8SyJJETna/hzvuGdcUbu2tz8I3stzcwUZgtlN+tbGAtrcQzhvS3lLGGfUx27XWGJMYKwXZYYRpsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829383; c=relaxed/simple;
	bh=VjJtF6nhJ6Vi0Jq28a+KMKCE4IqUKBN0eN7p35y6Brk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FaJScR7lLTBeW0F2bBNwjpNfOn8RRmEcHaQIwQko/Ii0QkkCdHCF2qIGVpThF7zvr4T6yGU9yhf0H8ohO7Hve+QQLP/XYWwKvlvj3ipw2XLupzsplf5j5v+jRSVC3mA6mbkoEBQlioG3+4/PyAbhkSxqopxCt/d6tUc3p91pxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE013176C;
	Fri, 18 Jul 2025 02:02:52 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (unknown [10.164.18.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F3E923F66E;
	Fri, 18 Jul 2025 02:02:51 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org
Cc: ryan.roberts@arm.com,
	david@redhat.com,
	willy@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com,
	anshuman.khandual@arm.com,
	peterx@redhat.com,
	joey.gouly@arm.com,
	ioworker0@gmail.com,
	baohua@kernel.org,
	kevin.brodsky@arm.com,
	quic_zhenhuah@quicinc.com,
	christophe.leroy@csgroup.eu,
	yangyicong@hisilicon.com,
	linux-arm-kernel@lists.infradead.org,
	hughd@google.com,
	yang@os.amperecomputing.com,
	ziy@nvidia.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v5 0/7] Optimize mprotect() for large folios
Date: Fri, 18 Jul 2025 14:32:37 +0530
Message-Id: <20250718090244.21092-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use folio_pte_batch() to optimize change_pte_range(). On arm64, if the ptes
are painted with the contig bit, then ptep_get() will iterate through all
16 entries to collect a/d bits. Hence this optimization will result in
a 16x reduction in the number of ptep_get() calls. Next,
ptep_modify_prot_start() will eventually call contpte_try_unfold() on
every contig block, thus flushing the TLB for the complete large folio
range. Instead, use get_and_clear_full_ptes() so as to elide TLBIs on
each contig block, and only do them on the starting and ending
contig block.

For split folios, there will be no pte batching; the batch size returned
by folio_pte_batch() will be 1. For pagetable split folios, the ptes will
still point to the same large folio; for arm64, this results in the
optimization described above, and for other arches, a minor improvement
is expected due to a reduction in the number of function calls.

mm-selftests pass on arm64. I have some failing tests on my x86 VM already;
no new tests fail as a result of this patchset.

We use the following test cases to measure performance, mprotect()'ing
the mapped memory to read-only then read-write 40 times:

Test case 1: Mapping 1G of memory, touching it to get PMD-THPs, then
pte-mapping those THPs
Test case 2: Mapping 1G of memory with 64K mTHPs
Test case 3: Mapping 1G of memory with 4K pages

Average execution time on arm64, Apple M3:
Before the patchset:
T1: 2.1 seconds   T2: 2 seconds   T3: 1 second

After the patchset:
T1: 0.65 seconds   T2: 0.7 seconds   T3: 1.1 seconds

Observing T1/T2 and T3 before the patchset, we also remove the regression
introduced by ptep_get() on a contpte block. And, for large folios we get
an almost 74% performance improvement, albeit the trade-off being a slight
degradation in the small folio case.

For x86:
Before the patchset:
T1: 3.75 seconds  T2: 3.7 seconds  T3: 3.85 seconds

After the patchset:
T1: 3.7 seconds  T2: 3.7 seconds  T3: 3.9 seconds

So there is a minor improvement due to reduction in number of function
calls, and a slight degradation in the small folio case due to the
overhead of vm_normal_folio() + folio_test_large().

Here is the test program:

 #define _GNU_SOURCE
 #include <sys/mman.h>
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
 #include <unistd.h>

 #define SIZE (1024*1024*1024)

unsigned long pmdsize = (1UL << 21);
unsigned long pagesize = (1UL << 12);

static void pte_map_thps(char *mem, size_t size)
{
	size_t offs;
	int ret = 0;


	/* PTE-map each THP by temporarily splitting the VMAs. */
	for (offs = 0; offs < size; offs += pmdsize) {
		ret |= madvise(mem + offs, pagesize, MADV_DONTFORK);
		ret |= madvise(mem + offs, pagesize, MADV_DOFORK);
	}

	if (ret) {
		fprintf(stderr, "ERROR: mprotect() failed\n");
		exit(1);
	}
}

int main(int argc, char *argv[])
{
	char *p;
        int ret = 0;
	p = mmap((1UL << 30), SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	if (p != (1UL << 30)) {
		perror("mmap");
		return 1;
	}



	memset(p, 0, SIZE);
	if (madvise(p, SIZE, MADV_NOHUGEPAGE))
		perror("madvise");
	explicit_bzero(p, SIZE);
	pte_map_thps(p, SIZE);

	for (int loops = 0; loops < 40; loops++) {
		if (mprotect(p, SIZE, PROT_READ))
			perror("mprotect"), exit(1);
		if (mprotect(p, SIZE, PROT_READ|PROT_WRITE))
			perror("mprotect"), exit(1);
		explicit_bzero(p, SIZE);
	}
}

---
v4->v5:
 - Add patch 4
 - Add patch 1 (Lorenzo)
 - For patch 2, instead of using nr_ptes returned from prot_numa_skip()
   as a dummy for whether to skip or not, make that function return
   boolean, and then use folio_pte_batch() to determine how much to
   skip
 - Split can_change_pte_writable() (Lorenzo)
 - Implement patch 6 in a better way

v3->v4:
 - Refactor skipping logic into a new function, edit patch 1 subject
   to highlight it is only for MM_CP_PROT_NUMA case (David H)
 - Refactor the optimization logic, add more documentation to the generic
   batched functions, do not add clear_flush_ptes, squash patch 4
   and 5 (Ryan)

v2->v3:
 - Add comments for the new APIs (Ryan, Lorenzo)
 - Instead of refactoring, use a "skip_batch" label
 - Move arm64 patches at the end (Ryan)
 - In can_change_pte_writable(), check AnonExclusive page-by-page (David H)
 - Resolve implicit declaration; tested build on x86 (Lance Yang)

v1->v2:
 - Rebase onto mm-unstable (6ebffe676fcf: util_macros.h: make the header more resilient)
 - Abridge the anon-exclusive condition (Lance Yang)


Dev Jain (7):
  mm: Refactor MM_CP_PROT_NUMA skipping case into new function
  mm: Optimize mprotect() for MM_CP_PROT_NUMA by batch-skipping PTEs
  mm: Add batched versions of ptep_modify_prot_start/commit
  mm: Introduce FPB_RESPECT_WRITE for PTE batching infrastructure
  mm: Split can_change_pte_writable() into private and shared parts
  mm: Optimize mprotect() by PTE batching
  arm64: Add batched versions of ptep_modify_prot_start/commit

 arch/arm64/include/asm/pgtable.h |  10 ++
 arch/arm64/mm/mmu.c              |  28 ++-
 include/linux/pgtable.h          |  84 ++++++++-
 mm/internal.h                    |  11 +-
 mm/mprotect.c                    | 295 ++++++++++++++++++++++++-------
 5 files changed, 352 insertions(+), 76 deletions(-)

-- 
2.30.2


