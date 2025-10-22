Return-Path: <linux-kernel+bounces-865735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 311F2BFDE39
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD6B3A6AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E1734C811;
	Wed, 22 Oct 2025 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwFEqHo6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3947034D4E1
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158352; cv=none; b=BGfX/IXv0kbXyQPoP2XHXXrjr1lL4bV/reZR771JC+eUcSqW2w+GRomgsiTCaW36kXpY47aEoN8gDhCWbMTJrd6oeuu+VnwBu/pvDf8ALFItKEp+BkAibQVZjgd5gRAEIXQ1YW7HHSZKLDix6rU0lwLv6LvL+LR5ghqzKYpTcxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158352; c=relaxed/simple;
	bh=ovMLDkSWm8fENHDxtXv3t9t98oSc8eU1evUa7cRE7NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlnYhlCQXOzLet2K6FboZQ4EbhG1w77uyvvrGwk+1byCSNjPCMeN+IvKURTlo/LuVDo4rOrJrmipXEY1b8CDQOgccN8tNsOC+1ikkXcNfDu206y65udRGMTH0JRWvSQ4FN2T2sd3nsGOA9KCl742PFumrebxnUsXK938cRTi8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwFEqHo6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761158349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2REGf03JWcvDSZSsPzScdNEpBV9wevechnucut1WH7k=;
	b=fwFEqHo6fwNsvtuFpzgwslXBnlTcbOhI7LaJq7ExU8V24RhOiMDaAQCw2jnBjnqi3nyIyf
	Sn0hsBi4ZWYFi2e3ovWzVrjVaCypW58QE3LxTI8XaZcTMLzAj2Ybjl0xh4Qw0cbU98KwW7
	czhd+r3WhR/sakPpj0W73lIqTYhEePM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-vEmx2dYTPn2aYKj8HQdtdw-1; Wed,
 22 Oct 2025 14:39:04 -0400
X-MC-Unique: vEmx2dYTPn2aYKj8HQdtdw-1
X-Mimecast-MFC-AGG-ID: vEmx2dYTPn2aYKj8HQdtdw_1761158339
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BB851956086;
	Wed, 22 Oct 2025 18:38:59 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7CC5419560B5;
	Wed, 22 Oct 2025 18:38:49 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org
Cc: david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	corbet@lwn.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org,
	baohua@kernel.org,
	willy@infradead.org,
	peterx@redhat.com,
	wangkefeng.wang@huawei.com,
	usamaarif642@gmail.com,
	sunnanyong@huawei.com,
	vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com,
	yang@os.amperecomputing.com,
	kas@kernel.org,
	aarcange@redhat.com,
	raquini@redhat.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	tiwai@suse.de,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	jack@suse.cz,
	cl@gentwo.org,
	jglisse@google.com,
	surenb@google.com,
	zokeefe@google.com,
	hannes@cmpxchg.org,
	rientjes@google.com,
	mhocko@suse.com,
	rdunlap@infradead.org,
	hughd@google.com,
	richard.weiyang@gmail.com,
	lance.yang@linux.dev,
	vbabka@suse.cz,
	rppt@kernel.org,
	jannh@google.com,
	pfalcato@suse.de
Subject: [PATCH v12 mm-new 04/15] khugepaged: generalize alloc_charge_folio()
Date: Wed, 22 Oct 2025 12:37:06 -0600
Message-ID: <20251022183717.70829-5-npache@redhat.com>
In-Reply-To: <20251022183717.70829-1-npache@redhat.com>
References: <20251022183717.70829-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Dev Jain <dev.jain@arm.com>

Pass order to alloc_charge_folio() and update mTHP statistics.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Co-developed-by: Nico Pache <npache@redhat.com>
Signed-off-by: Nico Pache <npache@redhat.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 Documentation/admin-guide/mm/transhuge.rst |  8 ++++++++
 include/linux/huge_mm.h                    |  2 ++
 mm/huge_memory.c                           |  4 ++++
 mm/khugepaged.c                            | 17 +++++++++++------
 4 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 1654211cc6cf..13269a0074d4 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -634,6 +634,14 @@ anon_fault_fallback_charge
 	instead falls back to using huge pages with lower orders or
 	small pages even though the allocation was successful.
 
+collapse_alloc
+	is incremented every time a huge page is successfully allocated for a
+	khugepaged collapse.
+
+collapse_alloc_failed
+	is incremented every time a huge page allocation fails during a
+	khugepaged collapse.
+
 zswpout
 	is incremented every time a huge page is swapped out to zswap in one
 	piece without splitting.
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7698b3542c4f..3d29624c4f3f 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -128,6 +128,8 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_ALLOC,
 	MTHP_STAT_ANON_FAULT_FALLBACK,
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
+	MTHP_STAT_COLLAPSE_ALLOC,
+	MTHP_STAT_COLLAPSE_ALLOC_FAILED,
 	MTHP_STAT_ZSWPOUT,
 	MTHP_STAT_SWPIN,
 	MTHP_STAT_SWPIN_FALLBACK,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 370ecfd6a182..0063d1ba926e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -620,6 +620,8 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
+DEFINE_MTHP_STAT_ATTR(collapse_alloc, MTHP_STAT_COLLAPSE_ALLOC);
+DEFINE_MTHP_STAT_ATTR(collapse_alloc_failed, MTHP_STAT_COLLAPSE_ALLOC_FAILED);
 DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
 DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
@@ -685,6 +687,8 @@ static struct attribute *any_stats_attrs[] = {
 #endif
 	&split_attr.attr,
 	&split_failed_attr.attr,
+	&collapse_alloc_attr.attr,
+	&collapse_alloc_failed_attr.attr,
 	NULL,
 };
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6cf8700823f9..36ee659acfbb 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1061,21 +1061,26 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 }
 
 static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
-			      struct collapse_control *cc)
+		struct collapse_control *cc, unsigned int order)
 {
 	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
 		     GFP_TRANSHUGE);
 	int node = collapse_find_target_node(cc);
 	struct folio *folio;
 
-	folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nmask);
+	folio = __folio_alloc(gfp, order, node, &cc->alloc_nmask);
 	if (!folio) {
 		*foliop = NULL;
-		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
+		if (order == HPAGE_PMD_ORDER)
+			count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
+		count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC_FAILED);
 		return SCAN_ALLOC_HUGE_PAGE_FAIL;
 	}
 
-	count_vm_event(THP_COLLAPSE_ALLOC);
+	if (order == HPAGE_PMD_ORDER)
+		count_vm_event(THP_COLLAPSE_ALLOC);
+	count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC);
+
 	if (unlikely(mem_cgroup_charge(folio, mm, gfp))) {
 		folio_put(folio);
 		*foliop = NULL;
@@ -1112,7 +1117,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	 */
 	mmap_read_unlock(mm);
 
-	result = alloc_charge_folio(&folio, mm, cc);
+	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
 	if (result != SCAN_SUCCEED)
 		goto out_nolock;
 
@@ -1850,7 +1855,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
 	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
 
-	result = alloc_charge_folio(&new_folio, mm, cc);
+	result = alloc_charge_folio(&new_folio, mm, cc, HPAGE_PMD_ORDER);
 	if (result != SCAN_SUCCEED)
 		goto out;
 
-- 
2.51.0


