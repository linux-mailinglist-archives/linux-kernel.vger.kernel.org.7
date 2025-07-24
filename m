Return-Path: <linux-kernel+bounces-743536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DCBB0FFE5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238EE963678
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F68C1F8937;
	Thu, 24 Jul 2025 05:23:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9719F2A1BB
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753334593; cv=none; b=GlnKKHrAGKuQXfGpoKa7jfIOajMCW8sL6kNoLMR2gFAalpYyTIrPAcblNTqrDGA7BL16QJER7c8MGWJVpFWSoYZi06D9edGdTKjSp8KM3gEzz/kHi4wplYUPMUFbLX9HkdsatPMgpd0DupAQ7GqAzmQ4Z96AMHjWDVHyZS/tpEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753334593; c=relaxed/simple;
	bh=nglIYqF6R1QWThpX4Bob/1F2SFnZc1JPKN0hBKrpf8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SREvE6Eu2XS/4rarIgrCz5/frqLlrnkU/msywphjlndMM+PL4D3UboZDsdMV+Ns8b2h7N9E3xhNu4FfHiJAtWu68hTIwCZyTPO6rSw8oyYu5Qu5lCs2Nh9pYEvN5vd2gPNWvYozSsFyFouM1lZkqz0fBs8yqTL0LnoFqAuZZxYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E63C1A32;
	Wed, 23 Jul 2025 22:23:04 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (unknown [10.164.18.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E72D33F66E;
	Wed, 23 Jul 2025 22:23:06 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com
Cc: ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	baohua@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v4 0/3] Optimizations for khugepaged
Date: Thu, 24 Jul 2025 10:52:58 +0530
Message-Id: <20250724052301.23844-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the underlying folio mapped by the ptes is large, we can process those
ptes in a batch using folio_pte_batch().

For arm64 specifically, this results in a 16x reduction in the number of
ptep_get() calls, since on a contig block, ptep_get() on arm64 will iterate
through all 16 entries to collect a/d bits. Next, ptep_clear() will cause
a TLBI for every contig block in the range via contpte_try_unfold().
Instead, use clear_ptes() to only do the TLBI at the first and last
contig block of the range.

For split folios, there will be no pte batching; the batch size returned
by folio_pte_batch() will be 1. For pagetable split folios, the ptes will
still point to the same large folio; for arm64, this results in the
optimization described above, and for other arches, a minor improvement
is expected due to a reduction in the number of function calls and
batching atomic operations.

---
Rebased on today's mm-new - the v3 of this patchset was already in, so
I reverted those commits and then rebased on top of that.
mm-selftests pass.

v3->v4:
 - Use unsigned int for nr_ptes and max_nr_ptes (David)
 - Define the functions in patch 1 as inline functions with kernel docs
   instead of macros (akpm)


v2->v3:
 - Drop patch 3 (was merged separately)
 - Add patch 1 (David)
 - Coding style change, drop mapped_folio (Lorenzo)

v1->v2:
 - Use for loop instead of do-while loop (Lorenzo)
 - Remove folio_test_large check since the subpage-check condition
   will imply that (Baolin)
 - Combine patch 1 and 2 into this series, add new patch 3

David Hildenbrand (1):
  mm: add get_and_clear_ptes() and clear_ptes()

Dev Jain (2):
  khugepaged: Optimize __collapse_huge_page_copy_succeeded() by PTE
    batching
  khugepaged: Optimize collapse_pte_mapped_thp() by PTE batching

 arch/arm64/mm/mmu.c     |  2 +-
 include/linux/pgtable.h | 45 ++++++++++++++++++++++++++++++++
 mm/khugepaged.c         | 58 +++++++++++++++++++++++++++--------------
 mm/mremap.c             |  2 +-
 mm/rmap.c               |  2 +-
 5 files changed, 87 insertions(+), 22 deletions(-)

-- 
2.30.2


