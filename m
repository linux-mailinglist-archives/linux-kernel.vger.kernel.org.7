Return-Path: <linux-kernel+bounces-741094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B709B0E011
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1A9188B9FA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B9A239E9E;
	Tue, 22 Jul 2025 15:06:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4797C1E8320
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196778; cv=none; b=ohJbN1bYKyE9rvbNVDglFvNP7YQBw7o0A3KXhlO8IIE1eMgk9G0lYrjECljuvsH4e/WWVRqGpKrZ2nybDyyyOrLUk23TOW1O9zFYBv8i3qFwXyAID4jpQbOIbvI8tZYPPE5z7qbEXQi6ZpwY+2dQgDFb+M4WV3tsr2MbHcjzFd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196778; c=relaxed/simple;
	bh=cqlHcVFAxbAEO9cUZx72h42oaaYNi0LObMO0TkR7APA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CTuIQNo/Qn3y+VRvcfBjXkR8j1gwNiCQHbNkQ6yTtetYSQniSoAvX7IIP4c/Btdwf7ct2isntf3CHDdOqyM5ghP51MM3p43A9hIg9FuR9t2y+XF2auxQ0Oyw9hg3AvjhXeBxe1uYr/sLr0P4Gx6bVmGzOYw7bB72lWP6z18/6to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1046E152B;
	Tue, 22 Jul 2025 08:06:10 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.163.92.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7B79E3F6A8;
	Tue, 22 Jul 2025 08:06:11 -0700 (PDT)
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
Subject: [PATCH v3 0/3] Optimizations for khugepaged
Date: Tue, 22 Jul 2025 20:35:56 +0530
Message-Id: <20250722150559.96465-1-dev.jain@arm.com>
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
Rebased on today's mm-new.

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
 include/linux/pgtable.h |  6 +++++
 mm/khugepaged.c         | 57 +++++++++++++++++++++++++++--------------
 mm/mremap.c             |  2 +-
 mm/rmap.c               |  2 +-
 5 files changed, 47 insertions(+), 22 deletions(-)

-- 
2.30.2


