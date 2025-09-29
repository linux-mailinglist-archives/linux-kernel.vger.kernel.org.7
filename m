Return-Path: <linux-kernel+bounces-836164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A02B6BA8E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606E0164811
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFE12FBDFF;
	Mon, 29 Sep 2025 10:46:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F7F2ECE8F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759142812; cv=none; b=jOEOTgUA5Wwz9BGWeVV5bo/rY3RwRvxnAaZF0mnKDXZ4/1SwsB19e7SmP9ofV6ROsD8p6ObrkVkbTttVlzuFgLBxtCARTWDi25RVlcBADpwPZ0VVZGTtMczWezvtP6l0yETdvnZ+ZM2MjHs61m6iPRqhYzmWcdelKdxmE9BC4Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759142812; c=relaxed/simple;
	bh=iwkp/9r0Oc7tHr8WdiP/Kk8lUeotqucyHxLb18YxiPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iAaaK2EVMCw0xOIhf41WrU2tAaiDwYqeUDznNx9bM+AeCJtozfDqr465vCKe9xKNlAu/ViXrqUZ6o+Xfyz9kEdViIviwFBx82ihSAuB9a8Y27arX5S3rlAf5YpNNRQAOkfNVH4gSzxKwD5L+iw6EMO6Ez+9cfsKQwv+gCppYDeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB93B150C;
	Mon, 29 Sep 2025 03:46:41 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A37F93F66E;
	Mon, 29 Sep 2025 03:46:48 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/thp: Drop follow_devmap_pmd() default stub
Date: Mon, 29 Sep 2025 11:46:43 +0100
Message-Id: <20250929104643.1100421-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

follow_devmap_pmd() has already been dropped by the commit fd2825b0760a
("mm/gup: remove pXX_devmap usage from get_user_pages()"). The fallback
stub in the header which is now redundant, can be dropped off as well.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/huge_mm.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7748489fde1b..96ce0ca54e49 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -652,12 +652,6 @@ static inline void mm_put_huge_zero_folio(struct mm_struct *mm)
 	return;
 }
 
-static inline struct page *follow_devmap_pmd(struct vm_area_struct *vma,
-	unsigned long addr, pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
-{
-	return NULL;
-}
-
 static inline bool thp_migration_supported(void)
 {
 	return false;
-- 
2.30.2


