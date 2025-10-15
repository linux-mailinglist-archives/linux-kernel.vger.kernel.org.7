Return-Path: <linux-kernel+bounces-853634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 487D9BDC2A3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D19314E2915
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D8727E056;
	Wed, 15 Oct 2025 02:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xeEinGP3"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DE615A8
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760495915; cv=none; b=O25WHhrTM4hrmBwKKLUule9mNhwBl6nuuyauaHUVve6TxPNO44ppD6bQ40sX9ON/7IAzsMlrjKUwGlN4QzGAJkEp6r+DgBAXEYftAkBxZh81HFsdt0c8RO2QUqAsQUSQeAN0IytdrTlO2NdMQY4ylU/7TbEjH+PLEFYTxKprpkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760495915; c=relaxed/simple;
	bh=mp8l5fm+Ox07WGYEuzH2kZeumJ6EmYeGA4lSRQvYREI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u4KIoBZ0TxaGwmgYLlj1J63/RrcQq2ZGqmSHUzrK/ph6nAs2ixMOiBw/KxP8RAOzZuROldtVl65+hFjzIIK5tg1vdxbfOY231iIXUXzly6yb+R0yDo4Ohqgbf5YKH4n/UuyrjsVAuc54873xss64p2T7Z/M7iIaYuPVQQgTnG0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xeEinGP3; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760495910; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=awK8T53rvm3JtUI0otLj6zux7hpJFSpVbJLW34F+bWs=;
	b=xeEinGP3R9r73JC97QkaxIl4YG3RqRZdGrBCXphKHbmoKk3gaczmFDmuh/E0BGWYOIKX7vxAIuZwuciwUj3+IzpoeDmnBjOfVLHAvvg813JM6XIG0rx+n6iHE8n3u6DnKpI1PjIIvZVAti7rbjz3oRKNxFKuKjMXPoXoFM+pwQg=
Received: from localhost.localdomain(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WqEOUxe_1760495898 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Oct 2025 10:38:29 +0800
From: Huang Ying <ying.huang@linux.alibaba.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Huang Ying <ying.huang@linux.alibaba.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Gavin Shan <gshan@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64, mm: avoid always making PTE dirty in pte_mkwrite()
Date: Wed, 15 Oct 2025 10:37:12 +0800
Message-Id: <20251015023712.46598-1-ying.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current pte_mkwrite_novma() makes PTE dirty unconditionally.  This may
mark some pages that are never written dirty wrongly.  For example,
do_swap_page() may map the exclusive pages with writable and clean PTEs
if the VMA is writable and the page fault is for read access.
However, current pte_mkwrite_novma() implementation always dirties the
PTE.  This may cause unnecessary disk writing if the pages are
never written before being reclaimed.

So, change pte_mkwrite_novma() to clear the PTE_RDONLY bit only if the
PTE_DIRTY bit is set to make it possible to make the PTE writable and
clean.

The current behavior was introduced in commit 73e86cb03cf2 ("arm64:
Move PTE_RDONLY bit handling out of set_pte_at()").  Before that,
pte_mkwrite() only sets the PTE_WRITE bit, while set_pte_at() only
clears the PTE_RDONLY bit if both the PTE_WRITE and the PTE_DIRTY bits
are set.

To test the performance impact of the patch, on an arm64 server
machine, run 16 redis-server processes on socket 1 and 16
memtier_benchmark processes on socket 0 with mostly get
transactions (that is, redis-server will mostly read memory only).
The memory footprint of redis-server is larger than the available
memory, so swap out/in will be triggered.  Test results show that the
patch can avoid most swapping out because the pages are mostly clean.
And the benchmark throughput improves ~23.9% in the test.

Fixes: 73e86cb03cf2 ("arm64: Move PTE_RDONLY bit handling out of set_pte_at()")
Signed-off-by: Huang Ying <ying.huang@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Gavin Shan <gshan@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Yicong Yang <yangyicong@hisilicon.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/include/asm/pgtable.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index aa89c2e67ebc..0944e296dd4a 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -293,7 +293,8 @@ static inline pmd_t set_pmd_bit(pmd_t pmd, pgprot_t prot)
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte = set_pte_bit(pte, __pgprot(PTE_WRITE));
-	pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
+	if (pte_sw_dirty(pte))
+		pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
 	return pte;
 }
 
-- 
2.39.5


