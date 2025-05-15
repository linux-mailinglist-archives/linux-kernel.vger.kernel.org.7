Return-Path: <linux-kernel+bounces-648806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6157AAB7C14
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 05:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D6CB7A4EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 03:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04162951B7;
	Thu, 15 May 2025 03:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bV/2T1Vk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF052951DF
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 03:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747278407; cv=none; b=O94Obu/g+5B9mWFRqoMq4+2BcKlnS8zeNSAuX+a1fuzfjAwM3JCE9nkvELOGmReW0DIdZo0Z3aR32AHOsL/zfnxx15fw8f+Jmx5KCx68YnlpcKR8rhjbjLUtstgLPsIKeNv9F9w1OCobTs7P3YlXM0hK8R/SyLYlfBSJ3D5tfPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747278407; c=relaxed/simple;
	bh=Yfb09n6+Zssjnl5o7DnBveUXcGZuHtPoKbS9V7r8Sp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EV1j2vlEgKgJMP3Bt6bxpHilD+BRuwESwcMs4dpuLuyhRGkPGzOz5nmQ2jdvf+A31uxezFwn5HLxf0JyaGG5Knmx4J/65Dw/8ZF2eBQ8Sr8pd7DtbbtJlS9+ox7h7WDWvlPRF3wV2B83OFpv6Xi4Kn1rxrpfY4wjBti7dlceFdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bV/2T1Vk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747278400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8zPwPaQZipnjcHJrhPU5In/r6KTt5EaEO2/apKWg+g=;
	b=bV/2T1VkdRsA04ulE3HB/p2uC2Akll95VRi6MAM4UZ8J7UH2Nw0OIu70U9bbBagVs0A+gI
	CzmGpzDBZh6WsrM8IB85zBMGxIqjrEkBDReXV2WxjwjTgYS2VGHB+QCOqOfugryYmI8i4A
	ls20/1E2q3dqS0WT4nKvh5TcO8/i3uQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-iRMKCQQuNFqhl2IMnS-0RQ-1; Wed,
 14 May 2025 23:06:35 -0400
X-MC-Unique: iRMKCQQuNFqhl2IMnS-0RQ-1
X-Mimecast-MFC-AGG-ID: iRMKCQQuNFqhl2IMnS-0RQ_1747278391
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E54E1800360;
	Thu, 15 May 2025 03:06:31 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E33C1800359;
	Thu, 15 May 2025 03:06:15 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
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
	kirill.shutemov@linux.intel.com,
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
	rdunlap@infradead.org
Subject: [PATCH v6 11/12] khugepaged: add per-order mTHP khugepaged stats
Date: Wed, 14 May 2025 21:03:11 -0600
Message-ID: <20250515030312.125567-12-npache@redhat.com>
In-Reply-To: <20250515030312.125567-11-npache@redhat.com>
References: <20250515030312.125567-1-npache@redhat.com>
 <20250515030312.125567-2-npache@redhat.com>
 <20250515030312.125567-3-npache@redhat.com>
 <20250515030312.125567-4-npache@redhat.com>
 <20250515030312.125567-5-npache@redhat.com>
 <20250515030312.125567-6-npache@redhat.com>
 <20250515030312.125567-7-npache@redhat.com>
 <20250515030312.125567-8-npache@redhat.com>
 <20250515030312.125567-9-npache@redhat.com>
 <20250515030312.125567-10-npache@redhat.com>
 <20250515030312.125567-11-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

With mTHP support inplace, let add the per-order mTHP stats for
exceeding NONE, SWAP, and SHARED.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 include/linux/huge_mm.h |  3 +++
 mm/huge_memory.c        |  7 +++++++
 mm/khugepaged.c         | 15 ++++++++++++---
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 0bb65bd4e6dd..e3d15c737008 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -139,6 +139,9 @@ enum mthp_stat_item {
 	MTHP_STAT_SPLIT_DEFERRED,
 	MTHP_STAT_NR_ANON,
 	MTHP_STAT_NR_ANON_PARTIALLY_MAPPED,
+	MTHP_STAT_COLLAPSE_EXCEED_SWAP,
+	MTHP_STAT_COLLAPSE_EXCEED_NONE,
+	MTHP_STAT_COLLAPSE_EXCEED_SHARED,
 	__MTHP_STAT_COUNT
 };
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 177f0a78666a..700988a0d5cf 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -633,6 +633,10 @@ DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
 DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
 DEFINE_MTHP_STAT_ATTR(nr_anon, MTHP_STAT_NR_ANON);
 DEFINE_MTHP_STAT_ATTR(nr_anon_partially_mapped, MTHP_STAT_NR_ANON_PARTIALLY_MAPPED);
+DEFINE_MTHP_STAT_ATTR(collapse_exceed_swap_pte, MTHP_STAT_COLLAPSE_EXCEED_SWAP);
+DEFINE_MTHP_STAT_ATTR(collapse_exceed_none_pte, MTHP_STAT_COLLAPSE_EXCEED_NONE);
+DEFINE_MTHP_STAT_ATTR(collapse_exceed_shared_pte, MTHP_STAT_COLLAPSE_EXCEED_SHARED);
+
 
 static struct attribute *anon_stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
@@ -649,6 +653,9 @@ static struct attribute *anon_stats_attrs[] = {
 	&split_deferred_attr.attr,
 	&nr_anon_attr.attr,
 	&nr_anon_partially_mapped_attr.attr,
+	&collapse_exceed_swap_pte_attr.attr,
+	&collapse_exceed_none_pte_attr.attr,
+	&collapse_exceed_shared_pte_attr.attr,
 	NULL,
 };
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 951c44778f56..0723b184c7a4 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -604,7 +604,10 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 				continue;
 			} else {
 				result = SCAN_EXCEED_NONE_PTE;
-				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
+				if (order == HPAGE_PMD_ORDER)
+					count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
+				else
+					count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_NONE);
 				goto out;
 			}
 		}
@@ -633,8 +636,14 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		/* See khugepaged_scan_pmd(). */
 		if (folio_maybe_mapped_shared(folio)) {
 			++shared;
-			if (order != HPAGE_PMD_ORDER || (cc->is_khugepaged &&
-			    shared > khugepaged_max_ptes_shared)) {
+			if (order != HPAGE_PMD_ORDER) {
+				result = SCAN_EXCEED_SHARED_PTE;
+				count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_SHARED);
+				goto out;
+			}
+
+			if (cc->is_khugepaged &&
+				shared > khugepaged_max_ptes_shared) {
 				result = SCAN_EXCEED_SHARED_PTE;
 				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
 				goto out;
-- 
2.49.0


