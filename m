Return-Path: <linux-kernel+bounces-864068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8506BF9D59
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E2244EA848
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F080279DAF;
	Wed, 22 Oct 2025 03:30:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18478479
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761103802; cv=none; b=CrgDnD1aw0+dx4O46H+Alv36F5Tdf3502aZLjh0UB/DnB6wbv+W8/ZSFs4FnOFwJpie5QhgbW6w9HmFmx7xj9EbSXI8dAfaOzw5TQrbs5jWdpTmbFf5+382JJX5sIO/k+UazPlELBC/bN8e5XjG7/dvUaNMM92UmcGqISFV7dQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761103802; c=relaxed/simple;
	bh=5D1tfN9Y0WAx70kPYsbEMALXaXvV5OGABKZ6QHERa6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QgIN95bQZ7qCx82gTFInTc/x4dqd8uUR0NB+9gpFWyATrkNxrzXg0fXIuS9XgH7egI1eAIGVdDYcyePFtp1ItfkvPCS3dnNhUsGSGzBqoPZmeSh4VEhEPo4DMAqdHzTV6XlZDQcFO4wWD0t1HTZAD0HNl+483FRTOgXMMoX/p1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CE531063;
	Tue, 21 Oct 2025 20:29:51 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B50563F59E;
	Tue, 21 Oct 2025 20:29:57 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Huang Ying <ying.huang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH V2] mm/debug_vm_pgtable: Add [pte|pmd]_mkwrite_novma() tests
Date: Wed, 22 Oct 2025 04:29:51 +0100
Message-Id: <20251022032951.3498553-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some [pte|pmd]_mkwrite_novma() relevant tests.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Huang Ying <ying.huang@linux.alibaba.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
These tests clear on arm64 platform after the following recent patch.

https://lore.kernel.org/all/20251015023712.46598-1-ying.huang@linux.alibaba.com/

Changes in V2:

- Added a new test combination per Huang

Changes in V1:

https://lore.kernel.org/all/20251021024424.2390325-1-anshuman.khandual@arm.com/

 mm/debug_vm_pgtable.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 830107b6dd08..def344bb4a32 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -102,6 +102,12 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
 	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte, args->vma))));
 	WARN_ON(pte_dirty(pte_wrprotect(pte_mkclean(pte))));
 	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
+
+	WARN_ON(!pte_dirty(pte_mkwrite_novma(pte_mkdirty(pte))));
+	WARN_ON(pte_dirty(pte_mkwrite_novma(pte_mkclean(pte))));
+	WARN_ON(!pte_write(pte_mkdirty(pte_mkwrite_novma(pte))));
+	WARN_ON(!pte_write(pte_mkwrite_novma(pte_wrprotect(pte))));
+	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite_novma(pte))));
 }
 
 static void __init pte_advanced_tests(struct pgtable_debug_args *args)
@@ -195,6 +201,12 @@ static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
 	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite(pmd, args->vma))));
 	WARN_ON(pmd_dirty(pmd_wrprotect(pmd_mkclean(pmd))));
 	WARN_ON(!pmd_dirty(pmd_wrprotect(pmd_mkdirty(pmd))));
+
+	WARN_ON(pmd_dirty(pmd_mkwrite_novma(pmd_mkclean(pmd))));
+	WARN_ON(!pmd_write(pmd_mkdirty(pmd_mkwrite_novma(pmd))));
+	WARN_ON(!pmd_write(pmd_mkwrite_novma(pmd_wrprotect(pmd))));
+	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite_novma(pmd))));
+
 	/*
 	 * A huge page does not point to next level page table
 	 * entry. Hence this must qualify as pmd_bad().
-- 
2.30.2


