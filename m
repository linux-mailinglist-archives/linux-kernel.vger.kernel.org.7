Return-Path: <linux-kernel+bounces-867965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CDDC0405C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260E11A67E11
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA51D14F9D6;
	Fri, 24 Oct 2025 01:31:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB5F2628D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761269515; cv=none; b=rYK5MZw6rvpSnBjGP+mCvGZnHN87pYKcjogiWoOhD5U+MjljNfgcYiZNCBLBSSrew/uQKpD6BZgNvWCWaS4akkE1AXVMMomzV9v5zDL6OEQB/9BxbtKfnUnUK+hQrEuk4AylkVEsXTG+16NJozFQEmYnC1YRXL7xD/i/WWbdoRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761269515; c=relaxed/simple;
	bh=8cWdTNlFEMBW7NSAIleGZeeIAthw7xnyPkk/h/ahljo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JUvPokhw4rpSPN/ujYlTdopgBqo4LF+0/oLZ+3yYqL4HKOkcOihCjlhKzvyLyjQZBMJXlZQKEqTYgeL8YVHzygm/1uXzVYecQWRiTKqzZY3kUxFaReWbKXdKClQiu8yh6vzAdPCqAYUdcuq4B05V/Y8CK5uLxRoXuHiBB8vDK88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B20EE1CDD;
	Thu, 23 Oct 2025 18:31:37 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A7FD03F66E;
	Thu, 23 Oct 2025 18:31:43 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Huang Ying <ying.huang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH V3] mm/debug_vm_pgtable: Add [pte|pmd]_mkwrite_novma() tests
Date: Fri, 24 Oct 2025 02:31:37 +0100
Message-Id: <20251024013137.136926-1-anshuman.khandual@arm.com>
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

Changes in V3:

- Added a new test combination per Huang

Changes in V2:

https://lore.kernel.org/all/20251022032951.3498553-1-anshuman.khandual@arm.com/

- Added a new test combination per Huang

Changes in V1:

https://lore.kernel.org/all/20251021024424.2390325-1-anshuman.khandual@arm.com/

 mm/debug_vm_pgtable.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 830107b6dd08..133543ca2821 100644
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
@@ -195,6 +201,13 @@ static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
 	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite(pmd, args->vma))));
 	WARN_ON(pmd_dirty(pmd_wrprotect(pmd_mkclean(pmd))));
 	WARN_ON(!pmd_dirty(pmd_wrprotect(pmd_mkdirty(pmd))));
+
+	WARN_ON(!pmd_dirty(pmd_mkwrite_novma(pmd_mkdirty(pmd))));
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


