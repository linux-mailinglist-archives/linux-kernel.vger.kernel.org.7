Return-Path: <linux-kernel+bounces-826013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D125B8D559
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DF53AD800
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 05:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE3D2737E5;
	Sun, 21 Sep 2025 05:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cP7+OzSC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3852737F6
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 05:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758433513; cv=none; b=tD5vyx0iqwX+mymdZWGOTXMQaIgTOWVOY5ILwB5uAGPWCfakma1OyCE8hkyV6Q1GUH1ofx12jEZnpZo4uC6owzDN/xI1v//2osJzSd62XXJ1BdBWfcKaODdhhIm2a7Iwsu3CmpLKYudt+uy2km6HQI/YTk9hKde8mSMUQMzckQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758433513; c=relaxed/simple;
	bh=CO7FNMIzfL/eCqrPH8bakqiqnseo/pXbiUH3kfW/r1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGIPb00ETWB1vKFrJUoOyBSiaZ3r5seg9K8u5Z5DbRWxF+VSqA6lkOk9LiUA7Fo7FtHCM+NGlAg47lMikRqgqK/NLd3nQKjPLi/B3qE1w9ycFRIg3PqAwct8EjHM+6xt51snj53YmE46SFA+JflO3Rl6gzGTGZdQ9KKyKiDfHhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cP7+OzSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36412C4CEE7;
	Sun, 21 Sep 2025 05:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758433513;
	bh=CO7FNMIzfL/eCqrPH8bakqiqnseo/pXbiUH3kfW/r1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cP7+OzSCDmtZoUwnaIa9QgC/3G3YIMlw+CgaaUfOdyEyR5wXl6Jo0yazZNiYfy86u
	 20FRGejyMcuuTEyFGRFvmN1FUaBbXLRDVr8gvoH8Bc2E+IA6P9A0TCNL+0TP/7inTR
	 uZwsne8BGIG3lPC0pJlYo6aJpgzcz7jcsmXk8P943xdBtbMhMuUL2nwmqCx3MGRpid
	 b020Orae28Q+ldT4mxsyvC9St9IESBAOUr95lEYNmFOlj9bssmjbtbjX69dMbREZKk
	 uV7mlUxjLhb48KL77rWLAtqjBAeTcfWrtPTtUr2ghzZ11puNG2GzqJqc8S6RxjdnA1
	 61O2BHRIUQ+WQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] kho: replace kho_preserve_phys() with kho_preserve_pages()
Date: Sun, 21 Sep 2025 08:44:56 +0300
Message-ID: <20250921054458.4043761-3-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250921054458.4043761-1-rppt@kernel.org>
References: <20250921054458.4043761-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

to make it clear that KHO operates on pages rather than on a random
physical address.

The kho_preserve_pages() will be also used in upcoming support for
vmalloc preservation.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/kexec_handover.h |  5 +++--
 kernel/kexec_handover.c        | 25 +++++++++++--------------
 mm/memblock.c                  |  4 +++-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 348844cffb13..cc5c49b0612b 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -18,6 +18,7 @@ enum kho_event {
 
 struct folio;
 struct notifier_block;
+struct page;
 
 #define DECLARE_KHOSER_PTR(name, type) \
 	union {                        \
@@ -42,7 +43,7 @@ struct kho_serialization;
 bool kho_is_enabled(void);
 
 int kho_preserve_folio(struct folio *folio);
-int kho_preserve_phys(phys_addr_t phys, size_t size);
+int kho_preserve_pages(struct page *page, unsigned int nr_pages);
 struct folio *kho_restore_folio(phys_addr_t phys);
 int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
@@ -65,7 +66,7 @@ static inline int kho_preserve_folio(struct folio *folio)
 	return -EOPNOTSUPP;
 }
 
-static inline int kho_preserve_phys(phys_addr_t phys, size_t size)
+static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 85f1bf38b123..fd80be3b12fd 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -725,26 +725,23 @@ int kho_preserve_folio(struct folio *folio)
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
 
 /**
- * kho_preserve_phys - preserve a physically contiguous range across kexec.
- * @phys: physical address of the range.
- * @size: size of the range.
+ * kho_preserve_pages - preserve contiguous pages across kexec
+ * @page: first page in the list.
+ * @nr_pages: number of pages.
  *
- * Instructs KHO to preserve the memory range from @phys to @phys + @size
- * across kexec.
+ * Preserve a contiguous list of order 0 pages. Must be restored using
+ * kho_restore_pages() to ensure the pages are restored properly as order 0.
  *
  * Return: 0 on success, error code on failure
  */
-int kho_preserve_phys(phys_addr_t phys, size_t size)
+int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 {
-	unsigned long pfn = PHYS_PFN(phys);
+	struct kho_mem_track *track = &kho_out.ser.track;
+	const unsigned long start_pfn = page_to_pfn(page);
+	const unsigned long end_pfn = start_pfn + nr_pages;
+	unsigned long pfn = start_pfn;
 	unsigned long failed_pfn = 0;
-	const unsigned long start_pfn = pfn;
-	const unsigned long end_pfn = PHYS_PFN(phys + size);
 	int err = 0;
-	struct kho_mem_track *track = &kho_out.ser.track;
-
-	if (!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size))
-		return -EINVAL;
 
 	while (pfn < end_pfn) {
 		const unsigned int order =
@@ -764,7 +761,7 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(kho_preserve_phys);
+EXPORT_SYMBOL_GPL(kho_preserve_pages);
 
 /* Handling for debug/kho/out */
 
diff --git a/mm/memblock.c b/mm/memblock.c
index 117d963e677c..6ec3eaa4e8d1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2516,8 +2516,10 @@ static int reserve_mem_kho_finalize(struct kho_serialization *ser)
 
 	for (i = 0; i < reserved_mem_count; i++) {
 		struct reserve_mem_table *map = &reserved_mem_table[i];
+		struct page *page = phys_to_page(map->start);
+		unsigned int nr_pages = map->size >> PAGE_SHIFT;
 
-		err |= kho_preserve_phys(map->start, map->size);
+		err |= kho_preserve_pages(page, nr_pages);
 	}
 
 	err |= kho_preserve_folio(page_folio(kho_fdt));
-- 
2.50.1


