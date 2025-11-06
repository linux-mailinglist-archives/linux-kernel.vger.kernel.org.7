Return-Path: <linux-kernel+bounces-889417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2549CC3D811
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E35188BA81
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89FC329370;
	Thu,  6 Nov 2025 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhlpPpYa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591F308F14
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464570; cv=none; b=cgb0SxKKSwzvkJa4Ue1fqKGUhX0uLdrQlwtQgu73ZJIoE3J8n6pmQiIKO8nVhJ45Iy73BknMg8cdZfk4b/F4p2SB1Nv7LnVSW3KFQtVVRt9eA8dj9kCbh0XdBPEwtwXJpn91ysZmRm856mkAwBi8E+Ea1E8hCKwUfPeertPfBEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464570; c=relaxed/simple;
	bh=mZUwhrSjct79OADXPPXT1Fv3AVXEy295G5720Wv1cGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWCGTz/BQbp+DDRJ1PlUFG1fDZNyAxLgW3TZ6BErgV5rPpESKppy+vbTDCvCs544oEjXXtcmAFdC1W0/s6zFLgmQd86Uhj/dk+b7jJnSfd5AjUzo7k46/b9kK22BB5VTrCgMS+CtOV+hVzZq7boYc2L0DsMOLtzJQKYfRCOzwJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhlpPpYa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762464567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Q/SGZoDMzCFiE+HfvZvclHk/fNK+yt1scbMDujY49o=;
	b=KhlpPpYaeQvE91jwHABnQklOz25O6Bo0J/jM6Pom3kgvNcSzEkzN00Lmo31nURUmrWf0VQ
	oW9qjhulx7xSWx7n6UvxatijFsuPlw9hSe8Q4Q9aZBaet6qJr7zv2zSk4NfYijD+xL7V8h
	7D7evLwP223apBGhA4nF/jeiDJO1byU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-nUk9SCG5NVKVdyycDf4y2Q-1; Thu,
 06 Nov 2025 16:29:24 -0500
X-MC-Unique: nUk9SCG5NVKVdyycDf4y2Q-1
X-Mimecast-MFC-AGG-ID: nUk9SCG5NVKVdyycDf4y2Q_1762464563
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 501C81800357;
	Thu,  6 Nov 2025 21:29:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.101])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 29FAE19560B2;
	Thu,  6 Nov 2025 21:29:22 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: david@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com
Subject: [RFC 06/10] mm: debug_vm_pgtable: use pgtable_has_pmd_leaves()
Date: Thu,  6 Nov 2025 16:28:53 -0500
Message-ID: <237bcb7f3d832457322210cc7f8d1272c4ac88ef.1762464515.git.luizcap@redhat.com>
In-Reply-To: <cover.1762464515.git.luizcap@redhat.com>
References: <cover.1762464515.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

debug_vm_pgtable calls has_transparent_hugepage() in multiple places to
check if PMD-sized pages are supported, use pgtable_has_pmd_leaves()
instead.

Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 mm/debug_vm_pgtable.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 830107b6dd08..241b36c78ac9 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -170,7 +170,7 @@ static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
 	unsigned long val = idx, *ptr = &val;
 	pmd_t pmd;
 
-	if (!has_transparent_hugepage())
+	if (!pgtable_has_pmd_leaves())
 		return;
 
 	pr_debug("Validating PMD basic (%pGv)\n", ptr);
@@ -208,7 +208,7 @@ static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
 	pmd_t pmd;
 	unsigned long vaddr = args->vaddr;
 
-	if (!has_transparent_hugepage())
+	if (!pgtable_has_pmd_leaves())
 		return;
 
 	page = (args->pmd_pfn != ULONG_MAX) ? pfn_to_page(args->pmd_pfn) : NULL;
@@ -269,7 +269,7 @@ static void __init pmd_leaf_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
 
-	if (!has_transparent_hugepage())
+	if (!pgtable_has_pmd_leaves())
 		return;
 
 	pr_debug("Validating PMD leaf\n");
@@ -674,7 +674,7 @@ static void __init pmd_protnone_tests(struct pgtable_debug_args *args)
 	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
 		return;
 
-	if (!has_transparent_hugepage())
+	if (!pgtable_has_pmd_leaves())
 		return;
 
 	pr_debug("Validating PMD protnone\n");
@@ -721,7 +721,7 @@ static void __init pmd_soft_dirty_tests(struct pgtable_debug_args *args)
 	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
 		return;
 
-	if (!has_transparent_hugepage())
+	if (!pgtable_has_pmd_leaves())
 		return;
 
 	pr_debug("Validating PMD soft dirty\n");
@@ -738,7 +738,7 @@ static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args)
 		!IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION))
 		return;
 
-	if (!has_transparent_hugepage())
+	if (!pgtable_has_pmd_leaves())
 		return;
 
 	pr_debug("Validating PMD swap soft dirty\n");
@@ -801,7 +801,7 @@ static void __init pmd_swap_tests(struct pgtable_debug_args *args)
 	swp_entry_t arch_entry;
 	pmd_t pmd1, pmd2;
 
-	if (!has_transparent_hugepage())
+	if (!pgtable_has_pmd_leaves())
 		return;
 
 	pr_debug("Validating PMD swap\n");
@@ -881,7 +881,7 @@ static void __init pmd_thp_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
 
-	if (!has_transparent_hugepage())
+	if (!pgtable_has_pmd_leaves())
 		return;
 
 	pr_debug("Validating PMD based THP\n");
@@ -968,7 +968,7 @@ static void __init destroy_args(struct pgtable_debug_args *args)
 	}
 
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-	    has_transparent_hugepage() &&
+	    pgtable_has_pmd_leaves() &&
 	    args->pmd_pfn != ULONG_MAX) {
 		if (args->is_contiguous_page) {
 			free_contig_range(args->pmd_pfn, (1 << HPAGE_PMD_ORDER));
@@ -1226,7 +1226,7 @@ static int __init init_args(struct pgtable_debug_args *args)
 	}
 
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-	    has_transparent_hugepage()) {
+	    pgtable_has_pmd_leaves()) {
 		page = debug_vm_pgtable_alloc_huge_page(args, HPAGE_PMD_ORDER);
 		if (page) {
 			args->pmd_pfn = page_to_pfn(page);
-- 
2.51.1


