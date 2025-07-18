Return-Path: <linux-kernel+bounces-736569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C128B09E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9EB75A65E7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D922B295523;
	Fri, 18 Jul 2025 09:03:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D33295513
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829425; cv=none; b=XXX8EskXypupgTqHVvifchd3NrPrClm1OBpnXJc4hC5ULDeGivcUqNvBNWwRqjAB/QrUvHhu3xULUrlfkgCp7PmXWVyWmZKK+QDN73Gir/i31m8103gyI9T5cfWEMrxBFVgKaqIM4c9BrP3zRRyWTteR5W8DXxYh3aR5HDbdn3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829425; c=relaxed/simple;
	bh=gHqPQIAC+ljk+rkN0KeenU85DY2HdWO2rbwDr/2PHC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I2CJvrSFYESSb7MXdrmtEWnRnWIGNUIaiBYzdl4/VQJfpykIFsS3VFNPrcMYK5skUudpV3KoyM3z/7DZwoz+WcdAVX5yYIE4s9NFrYqxj5x/K3HmcKnH6hFjuUq8UC7cscfrjmW+jKBM6ndsLHWsUyF/MdxAo3b7Gr/cgtGC/Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09EBF1A32;
	Fri, 18 Jul 2025 02:03:36 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (unknown [10.164.18.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 53D8E3F66E;
	Fri, 18 Jul 2025 02:03:35 -0700 (PDT)
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
Subject: [PATCH v5 5/7] mm: Split can_change_pte_writable() into private and shared parts
Date: Fri, 18 Jul 2025 14:32:42 +0530
Message-Id: <20250718090244.21092-6-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250718090244.21092-1-dev.jain@arm.com>
References: <20250718090244.21092-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for patch 6 and modularizing the code in general, split
can_change_pte_writable() into private and shared VMA parts. No functional
change intended.

Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/mprotect.c | 50 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 4977f198168e..a1c7d8a4648d 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -40,11 +40,8 @@
 
 #include "internal.h"
 
-bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
-			     pte_t pte)
+static bool maybe_change_pte_writable(struct vm_area_struct *vma, pte_t pte)
 {
-	struct page *page;
-
 	if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
 		return false;
 
@@ -60,16 +57,32 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 	if (userfaultfd_pte_wp(vma, pte))
 		return false;
 
-	if (!(vma->vm_flags & VM_SHARED)) {
-		/*
-		 * Writable MAP_PRIVATE mapping: We can only special-case on
-		 * exclusive anonymous pages, because we know that our
-		 * write-fault handler similarly would map them writable without
-		 * any additional checks while holding the PT lock.
-		 */
-		page = vm_normal_page(vma, addr, pte);
-		return page && PageAnon(page) && PageAnonExclusive(page);
-	}
+	return true;
+}
+
+static bool can_change_private_pte_writable(struct vm_area_struct *vma,
+					    unsigned long addr, pte_t pte)
+{
+	struct page *page;
+
+	if (!maybe_change_pte_writable(vma, pte))
+		return false;
+
+	/*
+	 * Writable MAP_PRIVATE mapping: We can only special-case on
+	 * exclusive anonymous pages, because we know that our
+	 * write-fault handler similarly would map them writable without
+	 * any additional checks while holding the PT lock.
+	 */
+	page = vm_normal_page(vma, addr, pte);
+	return page && PageAnon(page) && PageAnonExclusive(page);
+}
+
+static bool can_change_shared_pte_writable(struct vm_area_struct *vma,
+					   pte_t pte)
+{
+	if (!maybe_change_pte_writable(vma, pte))
+		return false;
 
 	VM_WARN_ON_ONCE(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte));
 
@@ -83,6 +96,15 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 	return pte_dirty(pte);
 }
 
+bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
+			     pte_t pte)
+{
+	if (!(vma->vm_flags & VM_SHARED))
+		return can_change_private_pte_writable(vma, addr, pte);
+
+	return can_change_shared_pte_writable(vma, pte);
+}
+
 static int mprotect_folio_pte_batch(struct folio *folio, pte_t *ptep,
 				    pte_t pte, int max_nr_ptes)
 {
-- 
2.30.2


