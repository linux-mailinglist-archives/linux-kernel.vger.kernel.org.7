Return-Path: <linux-kernel+bounces-817107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 726AEB57E0A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC0716BDD5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A031F7910;
	Mon, 15 Sep 2025 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="TRQovllc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V7XtVNNB"
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25A01FAC37
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944381; cv=none; b=dtyxY/roR1/YGNoKHa+lKDZI/LhN/VmA674yKAjAVQ2GaHtNOrtUdheM3KVmPIcfluHQrgyS7klf1VAYI/7Ce9/kYZYXklNqI1g370DavVKhPdoKW8RnlR45tOoVytbwYrpUjqTI+u/oM3DIwcoFRMb+az0Ko1ZVwHFwRzkLNaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944381; c=relaxed/simple;
	bh=oz4Z++cVpI//VG0Y/Mye5EjLE4DB+uouT/0KXkuxarc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YJ6eiLxn2X6/lB3MXG29K1nEcEMi2AaCZj26lwRjipvfPA8sw5PPqN42pZcvGvQc2XISq5i4VD9W/8h/+eGzvR1gmYh8VJxHbKP/lbrY1cqVMRluynyM9rQSXy9WXbXWbFL6oWs+Unl41sdAi+RNSZ2zQCQakntsM1wzmDkw/KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=TRQovllc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V7XtVNNB; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 40F3B1D00071;
	Mon, 15 Sep 2025 09:52:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 15 Sep 2025 09:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1757944377; x=1758030777; bh=gj2hpwBYG8Xyktyq6qkf/
	/++RSuokJq1T7PZ0K0vVVc=; b=TRQovllcP3cGfwvSIC32Fk7ufYxzgqSANa0Ww
	KVoU/WB3mM9Mws7u/QXn41isoeVvTe3tfWJ2xdaY0OpgznS6Z4mk7Pauo4qVtsWV
	sAr79oFJdyIPAKjM+Q/Se7odJmCNsAcAKKCK9Z2pJzxry1arQtUSXIi2nf5Lm6WU
	stPwHr/KxOzBiOVkah8EEOyzEWvLjx0ASIGEvaAExWQPVSi3B+zogBNBkzjMu04P
	mqFGQTrUinDu+5HsgunMNh4ufLnBXRrSpS8mQGZC6mZBAK7dcurRxGwPUWTPzpD7
	ReHUK+mQ3glKe29Ek8CJ9+b36XgfBQyV1SfrdVhtcqNbby8Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757944377; x=
	1758030777; bh=gj2hpwBYG8Xyktyq6qkf//++RSuokJq1T7PZ0K0vVVc=; b=V
	7XtVNNB2sTrMAJSaLx1ztdTaeabBuKRJwu2GKIvCAK9MdCU5w269OEfccx0RSier
	WAqkO+vPUtzunWYS42ieJSggYSECVCxgr+8mJDTePPnl4sm8+YxBeVDx7QHz0PQ4
	yhxppVL4Ogf/hm2qASWhuJlOnYS+M6CgM/LHBJluW7O10y3jTgebwbIOCOdipYsY
	bu4STeLlfIhcNREp12KWOuij7osEd4jE3vRJ/IcV52wLMNYGrasfjB4dlURAX7Sg
	UrZnhQ6U6VCnwJTsrh/Rt+6Oug8r+iuwAWDwc2Z48gmt7/7Ff+23zpT1mFvkgmQu
	dLFWIH04S95nY3pGGYaMA==
X-ME-Sender: <xms:OBrIaOXsPtx3oB2Q05aLiiP-CaURc1DLi7iX15vnfzWmOCWe_31rBw>
    <xme:OBrIaGfbeZHh7P3e7vJjtc_F88iTfucYKBIxRO-F5WXTKQ8ll8KqBeQln8AVbGYz5
    I1wBDRjbAwwRdcfPWo>
X-ME-Received: <xmr:OBrIaLMF0XJxw7PrE4aRI3i1GzlnlnzOR1jkK450bFXEZGo1R7AJOH-GM0htvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeekhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:OBrIaOKR6veAbfhMTlXmK1rgBhnEJYsMEi5sGtMUTYhBzyt4Fs9iXg>
    <xmx:OBrIaBk7ksXO1fhgy2TyV9qwb9sjhUhBIim5B5iMjQ1yeJFxe-KqRA>
    <xmx:OBrIaNbFWPk34Px1VpvGRXYpq4YX-tIvlS1Qz52wKRg_HDZjiDOM4g>
    <xmx:OBrIaAivdDqldIpGlPoxonEfWth0BoAR8I_6dfN_9PNVNM119svYTQ>
    <xmx:ORrIaMo056VAA1hEZjRraCtU6B9R7QkHEtAd4TUVqwmcZN5DDQGlaAKr>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 09:52:55 -0400 (EDT)
Date: Mon, 15 Sep 2025 14:52:53 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2] mm/khugepaged: Do not fail collapse_pte_mapped_thp() on
 SCAN_PMD_NULL
Message-ID: <v5ivpub6z2n2uyemlnxgbilzs52ep4lrary7lm7o6axxoneb75@yfacfl5rkzeh>
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

v2:
 - Modify set_huge_pmd() instead of introducing install_huge_pmd();

---
 mm/khugepaged.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b486c1d19b2d..986718599355 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1472,15 +1472,32 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
 static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
 			pmd_t *pmdp, struct folio *folio, struct page *page)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	struct vm_fault vmf = {
 		.vma = vma,
 		.address = addr,
 		.flags = 0,
-		.pmd = pmdp,
 	};
+	pgd_t *pgdp;
+	p4d_t *p4dp;
+	pud_t *pudp;
 
 	mmap_assert_locked(vma->vm_mm);
 
+	if (!pmdp) {
+		pgdp = pgd_offset(mm, addr);
+		p4dp = p4d_alloc(mm, pgdp, addr);
+		if (!p4dp)
+			return SCAN_FAIL;
+		pudp = pud_alloc(mm, p4dp, addr);
+		if (!pudp)
+			return SCAN_FAIL;
+		pmdp = pmd_alloc(mm, pudp, addr);
+		if (!pmdp)
+			return SCAN_FAIL;
+	}
+
+	vmf.pmd = pmdp;
 	if (do_set_pmd(&vmf, folio, page))
 		return SCAN_FAIL;
 
@@ -1556,6 +1573,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	switch (result) {
 	case SCAN_SUCCEED:
 		break;
+	case SCAN_PMD_NULL:
 	case SCAN_PMD_NONE:
 		/*
 		 * All pte entries have been removed and pmd cleared.
-- 
2.50.1


