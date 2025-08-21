Return-Path: <linux-kernel+bounces-780561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ECCB30443
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CCA1CE759F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A444F313547;
	Thu, 21 Aug 2025 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBjg2Bhf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B79312830
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806860; cv=none; b=XZoAnuKt/DcXvxtR2Y5zWMpn6bSGvYb+Mmcnzkh0xACnR/BhgPCDvBdeY92rr93aYqDQ9ABarHe9xqrdx6DhWAZkFarZskoIyyddMleCXFBJadV6XPh+j9Zs54a9U0JKww1gTmrS7/ogsbuFQdU1gLRmvfJF5oXb5CSKtWAvmkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806860; c=relaxed/simple;
	bh=I7luCT+CObepmsBOKpah/UXsbrY2375DH2pptgGLgo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unhtHRk2Fd8qK3E7OQlOzwgIOWG4bruITSf1cnMZarrzbl8yKSIUP8pFNxLdJTu2+JPHrdetF1Etb4YBRQrmLQHQGTQ7zmxLncN5dQR/css22Vcs1u/VqjiMibz5e2xV5LFJHHwCeKkIMEJ/cAJ5svvUiD8hhEAysHNJ0YmB/Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBjg2Bhf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXj+9vT03G0X8fnCGUCy6hSTWwnZnWm2sdD6cJzGZDI=;
	b=QBjg2BhftjJevnHOBEsj4+ibihsAFLdQ1U+2jHRcTvvQ7SmM9XH9b5nfVFrPD6IScCOH4m
	51K0ErMaviWRKgwZKmGr7DorYGnU8qV1rXyS1TrdAwakujJDLPA1UWv+AtH9KhQvvsPC+C
	+KocYzaHtZ1RU5eIhyIPTIPMO7njyzY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-qIs0tfOtOquMhQZXpnSh1Q-1; Thu, 21 Aug 2025 16:07:36 -0400
X-MC-Unique: qIs0tfOtOquMhQZXpnSh1Q-1
X-Mimecast-MFC-AGG-ID: qIs0tfOtOquMhQZXpnSh1Q_1755806855
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9e4146aa2so570454f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806855; x=1756411655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXj+9vT03G0X8fnCGUCy6hSTWwnZnWm2sdD6cJzGZDI=;
        b=h6EOA40J7qQEVVOpYyrQfrQ/eQOGCfZQL2Q/i5GpfWMuGnjXcEbZ+PEHB0Sdpsdqg+
         rBnxtcwy+RRYI9lq5TsROuzQQMiP4bqYOD3oJIhiKlJmcitE9HKHcZjdrurYfdFdy1/C
         11F/oTRIpv6jl8nSSxeCu9igq3yzaxEvzsn52afdFudkg8QhUTdaC6gTTeIMPoG3Txic
         EvwNnQtQIn0gaRiXrox9RtcgCULe5v2N/wED2Ot1FyhyIQLFZkkLKFESo4MZWjXQhykM
         bg7T7Q4bALNkI/Sa9Da3oN9/hhct+RSmkdmgzLu5xxNQUq61IH86hG4Nh8UA3O9kg7b8
         HNYg==
X-Gm-Message-State: AOJu0YzW/dGKRBYElwiMGgi/o6pSli3062w//E4SU4jYL5ljPKGWDbZh
	Q6W8wo0+MMjIi+8y0LBTxwR2OKeETMySO3KF/uL7ecD1p6ol/WT26Hly5v3dIm8OMVbxOJfSviQ
	IeE7JW7mrzad7hGNCpgJ31kNTFTojgfcnRrg1GrNJN+CxI4UWLHtVO4mnnRiMfa9FJl9qMmIIa5
	JjaYRLMZMEUAJjbOJezaBS3eBHet1N6KIaUN86geBltxQrE/3I
X-Gm-Gg: ASbGncsTCimekNUsirPBSO+VdzJL1H4XLybpFFRKuF6EFo4Y5alHbeJkKUor9upY3Lz
	73SlaPxe2t80owN5oE6V9nBDOpiU6L5WqLeRDxBk3dER1WuQbLPf6B8NZw0wQFsJl/XBpBimlhG
	lnJxPXujit13wr5KtNSCqmAtknsu8Ws96Db0j+90q/fszw9Ye0bVjxeGmAJPlrgsnukRUHwxZad
	QpO3dkJfG7O/+ZqvR9AnEVCnINrGMHicLD14693ZOX5kV/jW9J/y4BIwOFl8YqAptYYJKNFT5PK
	jM4DeHgEKkJJ2wQuLoQee6MbPlc/lmmmt5mNH3zuPoNuBl2FhcliZkZbprrw+LDGtfnYU6Vtic7
	oP4Grk7hErCqjhoWm+WiFNQ==
X-Received: by 2002:a05:6000:2303:b0:3b8:d893:5230 with SMTP id ffacd0b85a97d-3c5ddd7f36emr169101f8f.47.1755806855393;
        Thu, 21 Aug 2025 13:07:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbzCbSL6MUAhNqtGz96KSex+k6XoYEx77XRmSFhqyAAErvnD4a434thNrJcfmyX2YJjFDsxQ==
X-Received: by 2002:a05:6000:2303:b0:3b8:d893:5230 with SMTP id ffacd0b85a97d-3c5ddd7f36emr169035f8f.47.1755806854709;
        Thu, 21 Aug 2025 13:07:34 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c077788b39sm12802789f8f.47.2025.08.21.13.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:34 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 10/35] mm/hugetlb: cleanup hugetlb_folio_init_tail_vmemmap()
Date: Thu, 21 Aug 2025 22:06:36 +0200
Message-ID: <20250821200701.1329277-11-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All pages were already initialized and set to PageReserved() with a
refcount of 1 by MM init code.

In fact, by using __init_single_page(), we will be setting the refcount to
1 just to freeze it again immediately afterwards.

So drop the __init_single_page() and use __ClearPageReserved() instead.
Adjust the comments to highlight that we are dealing with an open-coded
prep_compound_page() variant.

Further, as we can now safely iterate over all pages in a folio, let's
avoid the page-pfn dance and just iterate the pages directly.

Note that the current code was likely problematic, but we never ran into
it: prep_compound_tail() would have been called with an offset that might
exceed a memory section, and prep_compound_tail() would have simply
added that offset to the page pointer -- which would not have done the
right thing on sparsemem without vmemmap.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d12a9d5146af4..ae82a845b14ad 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3235,17 +3235,14 @@ static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
 					unsigned long start_page_number,
 					unsigned long end_page_number)
 {
-	enum zone_type zone = zone_idx(folio_zone(folio));
-	int nid = folio_nid(folio);
-	unsigned long head_pfn = folio_pfn(folio);
-	unsigned long pfn, end_pfn = head_pfn + end_page_number;
+	struct page *head_page = folio_page(folio, 0);
+	struct page *page = folio_page(folio, start_page_number);
+	unsigned long i;
 	int ret;
 
-	for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
-		struct page *page = pfn_to_page(pfn);
-
-		__init_single_page(page, pfn, zone, nid);
-		prep_compound_tail((struct page *)folio, pfn - head_pfn);
+	for (i = start_page_number; i < end_page_number; i++, page++) {
+		__ClearPageReserved(page);
+		prep_compound_tail(head_page, i);
 		ret = page_ref_freeze(page, 1);
 		VM_BUG_ON(!ret);
 	}
@@ -3257,12 +3254,14 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
 {
 	int ret;
 
-	/* Prepare folio head */
+	/*
+	 * This is an open-coded prep_compound_page() whereby we avoid
+	 * walking pages twice by preparing+freezing them in the same go.
+	 */
 	__folio_clear_reserved(folio);
 	__folio_set_head(folio);
 	ret = folio_ref_freeze(folio, 1);
 	VM_BUG_ON(!ret);
-	/* Initialize the necessary tail struct pages */
 	hugetlb_folio_init_tail_vmemmap(folio, 1, nr_pages);
 	prep_compound_head((struct page *)folio, huge_page_order(h));
 }
-- 
2.50.1


