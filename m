Return-Path: <linux-kernel+bounces-896378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD33C5039E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9089D4E5A07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F55A27C84E;
	Wed, 12 Nov 2025 01:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gzqVHa77"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5921914B96E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762911850; cv=none; b=STgZnxIFc7hnS1PIJuY7vBk5JZn7ZGNGuHC68ym892YZhXNLrcjlotbBRiymeno3loyMIs/ypoeCCt0X1cFIGDJBGNCwfalNT9W5+8Pd9Je03LgKwqi5G9I0ahIEKAvI8e3Iu6yGX5Z0BhAnGuVucVCS3VpDC9ogsC2hDFeN3ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762911850; c=relaxed/simple;
	bh=QUVkNhiW2laIBaQ7VGe6VuJFbj4tK229DSIHbpz1Fp8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I8e98PGE2BDrGhIrz/jq11VGVPG9R3agtdBH4omh7FjVB7r6Bz0mi3yjJb7vley1AFlL3cPR7c0l/hpZlx2uaX62UCvybI+jbHrbvN6SPwxsVvzbQaQXGmLmUOJFzDiflu0F7WCqaeSHes39dtD9eE3s+/FQNbBwKVnmAkTrY/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gzqVHa77; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762911843; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=F2jNYeDr5F6pCBPM7sUJqzwBw4ZiFroYQTaihiWqMoM=;
	b=gzqVHa77aiZX6c/NKvfV5rVFKsJWGS1sRiYxSqbpYgLfKAH1SHcY9zmBx/8MA+Ck6MVqtmLaojBWXnC5Afa7XYGWHbTdyM7jsu2lC6t/ZGEYzrP9W/hs8eppXQ2Cm970FnV8nlRbu530H+DA7FySfp83CjEUOnC5iN1Y8GaVgJQ=
Received: from localhost.localdomain(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WsEIP-m_1762911513 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Nov 2025 09:38:45 +0800
From: Huang Ying <ying.huang@linux.alibaba.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: Huang Ying <ying.huang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Yin Fengwei <fengwei_yin@linux.alibaba.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH -v5 0/2] arm, tlbflush: avoid TLBI broadcast if page reused in write fault
Date: Wed, 12 Nov 2025 09:38:20 +0800
Message-Id: <20251112013822.54334-1-ying.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is to optimize the system performance via avoiding TLBI
broadcast if page is reused in the write protect fault handler.  More
details of the background and the test results can be found in [2/2].

Changelog:

v5:

- Code cleanup for [2/2], Thanks David's comments.

- Rebased on v6.18-rc5.

v4:

- Collected Reviewed-by and Acked-by, Thanks Lorenzo, David, Ryan, and
  Barry.

v3:

- Various code cleanup and improved design and document in [1/2],
  Thanks Lorenzo and David's comments!
- Fixed a typo and improved function interface in [2/2], Thanks Ryan's
  comments!

v2:

- Various code cleanup in [1/2], Thanks David's comments!
- Remove unnecessary __local_flush_tlb_page_nosync() in [2/2], Thanks Ryan's comments!
- Add missing contpte processing, Thanks Rayn and Catalin's comments!

Huang Ying (2):
  mm: add spurious fault fixing support for huge pmd
  arm64, tlbflush: don't TLBI broadcast if page reused in write fault

 arch/arm64/include/asm/pgtable.h  | 14 ++++---
 arch/arm64/include/asm/tlbflush.h | 56 ++++++++++++++++++++++++++++
 arch/arm64/mm/contpte.c           |  3 +-
 arch/arm64/mm/fault.c             |  8 +++-
 include/linux/huge_mm.h           |  2 +-
 include/linux/pgtable.h           |  4 ++
 mm/huge_memory.c                  | 33 ++++++++++------
 mm/internal.h                     |  2 +-
 mm/memory.c                       | 62 +++++++++++++++++++++++--------
 9 files changed, 145 insertions(+), 39 deletions(-)

Best Regards,
Huang, Ying

