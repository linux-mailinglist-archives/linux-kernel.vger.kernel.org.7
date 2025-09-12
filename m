Return-Path: <linux-kernel+bounces-814528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0546EB5552F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3987F1D661FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA88322763;
	Fri, 12 Sep 2025 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="WXSLXHFz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B3qsl0q3"
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08543322544
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757696299; cv=none; b=uCcgkiYa/eHQcmVKeQDE3ujMFJY1VQvKdVS0z34h9IgZtgE+CaWsWRp0ozHbXtKfA62Ha8uqx6lKmnAXpnPSHUsjlwUePhcZuCi6a/zkETF42nC/KvduLWr1NFI4UJ3C46T1WjlhsotnlVGjlfmgjxIoECn2g36/KhQOUyWWS64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757696299; c=relaxed/simple;
	bh=K8hZXZUDdOVsE7IJZcctswQbxgA/STz8bHlpCW2WVhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JTmegcV068lZJ182sqsmDWupQzicTem7TiYMIIRUcZs163QA/aCz3MUCUoEi4hapmHYIpAlCAiJsB4y69/BulNfQOFqoC9MFntBxG1THz9VLq8J3iqdp/VDSGtbiAZmCpe6SSDYePU13PcinJaYglP3UoTYGQhv7iy5QpzRI0Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=WXSLXHFz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B3qsl0q3; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8144F7A0145;
	Fri, 12 Sep 2025 12:58:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 12 Sep 2025 12:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1757696295; x=1757782695; bh=upnrRYU6bn+uBt1fGKw3p
	6hAlWqFSwlxqJgEcP0xUEk=; b=WXSLXHFz4Eg996BrG1TuO+hDbfjJsr5zmoaMu
	4OG24FCJ9ws3ZSuDRzFvBHNPzBwCqmyd6fUX1rkPLyD8jw2uMAxfHqDCg9+7pYXA
	1iePl57kOXkQUWHHq/VIX92Vakl5iGOsHmuVrZ0JeVQYsPOy4aSKfTuYHZlSpwrA
	hK/UNdCWxPr3WZwaFgFwkBaCLqOZHp56L0/oHzH53LqFha/yT0IpL5r4xZJrFt2e
	YiZt3/kVWJF1srsaWHf89AA6pQ/I1Spzzju+bLTyV60SfFIHjJKxrBvIXtFNCkAH
	2by37mMKosUtefuW02l3H5ZiQdj0SOYLRMJAnMo3TyARbh7FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757696295; x=
	1757782695; bh=upnrRYU6bn+uBt1fGKw3p6hAlWqFSwlxqJgEcP0xUEk=; b=B
	3qsl0q33858qadPEzFXWKzd5k4TXP/gBqZ3s8rEIHdzjP6YegAEsgxiTNWec9RUa
	PMd85Zr7oXvzKNibN8A5jG1VlRLLagP9wbhRDxoOLjZAsHlm97Blkbj+l3BMgoNE
	VnUoZvvy0rin6xkHKLhyiZz97B7NyDjSesBWBDga8jpOn0R8h4BHYWL05GDDpORo
	jSzpDNl/Oam3+DDU9cynoUvHHs9jkC44T9cF89HeOBfRVuOhatCvmd6wJW48s8EY
	GQ2PvRryCEiMRwm/9OdhuE9cfDzLh+1NlJMEhLJNeO3Wt6wxfRh/L4Ym/PHLAfno
	m3KZeWpYHnghmOMEIKtWA==
X-ME-Sender: <xms:JlHEaNiLR-LMVhcfewzkaoYUsYkFo79QWAm1g7hsGxUzjqpfTIh-Gg>
    <xme:JlHEaN7a9yO4-00uoqEMsCOZ6VHt_0D7BNNgo71j4A1CsI9rYMVbH_mA_ZNtuFM42
    aK1EDjCvm7ryNQIWPI>
X-ME-Received: <xmr:JlHEaF61r7mHUYPFQXYPtDUEx0azbEjJLgVQRZQZ2oTcZ22DGkLvCoyLHryLuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvleehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfggtggusehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfuhhhu
    thhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrg
    htthgvrhhnpeefhfdugfeghfdvfeefvddujeeuueefvdefuddvfeejheevveeigfejteet
    teeiudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepvdegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnug
    grthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhr
    tghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtg
    hpthhtohepiihihiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsggrohhlihhnrdif
    rghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehlihgrmhdrhh
    hofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepnhhprggthhgvsehrvggu
    hhgrthdrtghomhdprhgtphhtthhopehrhigrnhdrrhhosggvrhhtshesrghrmhdrtghomh
    dprhgtphhtthhopeguvghvrdhjrghinhesrghrmhdrtghomh
X-ME-Proxy: <xmx:JlHEaLH_MnLrv7K_tzBlUdSsVroMe6YE7s7287G-Zcfpv6MlO0nmuA>
    <xmx:JlHEaDz25KXMEbRbN-HWsHgrLN68RP6YZhKZj7nG0ufAmcuNxfJsIg>
    <xmx:JlHEaL3l966TxlLzY-b_JuezyIin1hBw8MX8fl054bTs7xw56rhJ0Q>
    <xmx:JlHEaGPO0kAiiQsM5xbntXTe-uBltdCOx8_lNhFeL86bhh9lNbEebA>
    <xmx:J1HEaP0hCnFIs3xOnKUjvL3hHeaPCEad_K-hwv5brwN7MqostgwHUt6A>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 12:58:13 -0400 (EDT)
Date: Fri, 12 Sep 2025 17:58:11 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/khugepaged: Do not fail collapse_pte_mapped_thp() on
 SCAN_PMD_NULL
Message-ID: <xhan2av3fyl7qpsl4bhjtds2zeegrl57ehtc5grtkua3c3v3nz@vain5s6gpycl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Kiryl Shutsemau <kas@kernel.org>

MADV_COLLAPSE on a file mapping behaves inconsistently depending on if
PMD page table is installed or not.

Consider following example:

	p = mmap(NULL, 2UL << 20, PROT_READ | PROT_WRITE,
		 MAP_SHARED, fd, 0);
	err = madvise(p, 2UL << 20, MADV_COLLAPSE);

fd is a populated tmpfs file.

The result depends on the address that the kernel returns on mmap().
If it is located in an existing PMD table, the madvise() will succeed.
However, if the table does not exist, it will fail with -EINVAL.

This occurs because find_pmd_or_thp_or_none() returns SCAN_PMD_NULL when
a page table is missing, which causes collapse_pte_mapped_thp() to fail.

SCAN_PMD_NULL and SCAN_PMD_NONE should be treated the same in
collapse_pte_mapped_thp(): install the PMD leaf entry and allocate page
tables as needed.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 mm/khugepaged.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b486c1d19b2d..9e76a4f46df9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1488,6 +1488,28 @@ static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
 	return SCAN_SUCCEED;
 }
 
+static int install_huge_pmd(struct vm_area_struct *vma, unsigned long haddr,
+			    pmd_t *pmd, struct folio *folio)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+
+	pgd = pgd_offset(mm, haddr);
+	p4d = p4d_alloc(mm, pgd, haddr);
+	if (!p4d)
+		return SCAN_FAIL;
+	pud = pud_alloc(mm, p4d, haddr);
+	if (!pud)
+		return SCAN_FAIL;
+	pmd = pmd_alloc(mm, pud, haddr);
+	if (!pmd)
+		return SCAN_FAIL;
+
+	return set_huge_pmd(vma, haddr, pmd, folio, &folio->page);
+}
+
 /**
  * collapse_pte_mapped_thp - Try to collapse a pte-mapped THP for mm at
  * address haddr.
@@ -1556,6 +1578,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	switch (result) {
 	case SCAN_SUCCEED:
 		break;
+	case SCAN_PMD_NULL:
 	case SCAN_PMD_NONE:
 		/*
 		 * All pte entries have been removed and pmd cleared.
@@ -1700,7 +1723,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 maybe_install_pmd:
 	/* step 5: install pmd entry */
 	result = install_pmd
-			? set_huge_pmd(vma, haddr, pmd, folio, &folio->page)
+			? install_huge_pmd(vma, haddr, pmd, folio)
 			: SCAN_SUCCEED;
 	goto drop_folio;
 abort:
-- 
2.50.1

