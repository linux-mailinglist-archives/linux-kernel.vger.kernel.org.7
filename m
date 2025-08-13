Return-Path: <linux-kernel+bounces-766026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E352AB2416E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E721B63D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6162D238E;
	Wed, 13 Aug 2025 06:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qwQS/bPG"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8C1DE2D7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066434; cv=none; b=eU6HjuvISXcA2/CjePpJ+/09/t/avwi3d4iQMbQeHogdONJCm70z3xWHW0D0aB9ztFdyOi7knsewTPppoPwRJdc8NXDqLkZ7Qku4aFPIB0fxIAUIC+R/HwGnDaq/mpQuWAQHAj9ZwNWjNvmqTpqc4MpQp5U3T4YgsLxYo/CRP6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066434; c=relaxed/simple;
	bh=P+RQUqbGQu8U9l6CAJt0Xq4Y9S/V5PlfhQXmOLXAw3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+sDsoTRsf1cMqdUWjBq++7GRcot8WpFaUFs8ZCaUxzlQHNgPiToumSyJJtg7MgGD8L7wYQDX5jpkNBK+v3+T4SEjh9CP+bDiIuRQ13xT0IoTwLww8cb8xA+Fljk3pvmIfP8igjYJRB3f2Dm38PUKdDpaAap2I0SH1dkWLrLcMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qwQS/bPG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CNQT4C009277;
	Wed, 13 Aug 2025 06:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nrJVwyChoAP1347E6
	ULfn6WFMFSfSytfpEMcX/qwjy4=; b=qwQS/bPGxt7TGG39EWVe6T3aCIPfJ5VeI
	FPy2KDnNEUsJ41iLxhD0CIZRTGqrb3dDwvTBRZZnYxyA2PmENa1wS4mrdQd03c11
	5dzGqZ40DDpV2vDV5Q4DVjpPC3agYU8yF8ZS/I2Oso+iP/puU0h5lm7I9rtCI4aL
	L8NrQ5HbTkQGFgGspW14V6ehaF/N/fZSw5oG1Etj5tQqUYboaUNBwf6Wftt1VH49
	5BY/Q1KSeXS6HTuTanX/UWGJEHQbU3a5W2iYjWVsUIp6Mw1Is5XI6cmuDhPQPRln
	lrMomYXGN83Y/fimPM+oMGqGix+f82Ft3+9NbfNUWa/oLxDGTK3jQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48duruav9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 06:26:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57D1c7UT026279;
	Wed, 13 Aug 2025 06:26:54 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh21653b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 06:26:54 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57D6QrkO9962414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 06:26:53 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AE5D5805E;
	Wed, 13 Aug 2025 06:26:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66CB958059;
	Wed, 13 Aug 2025 06:26:48 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com.com (unknown [9.36.10.70])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Aug 2025 06:26:48 +0000 (GMT)
From: Andrew Donnellan <ajd@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, x86@kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pasha.tatashin@soleen.com, sweettea-kernel@dorminy.me,
        nicholas@linux.ibm.com, christophe.leroy@csgroup.eu
Subject: [PATCH v16 01/13] arm64/mm: Add addr parameter to __set_ptes_anysz()
Date: Wed, 13 Aug 2025 16:26:02 +1000
Message-ID: <20250813062614.51759-2-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813062614.51759-1-ajd@linux.ibm.com>
References: <20250813062614.51759-1-ajd@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1DmuEpzOEC91AhJGOz3CZKD6ylyDxymq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX9mkUL6x9zxY2
 6Gh1cmtLtFG1OFrKTykCTN9l5yXY9y7nJIXtYKb7NVExjYcnhpFmoZGsazt/l5Qt/uBGDhkFhk+
 yYO6Sihmqw4ta5TLtzOLE7kI8qK2nf+M6hZtDXHBTIcObTV00jRqz2KWwXLynRjhgGoKUE5OZaX
 xQUX2Vt6+l85ynB36Tw59m2P/MMuXBITyhbsAl/T7mEY4YfR8vOAqLlVBQOFzOKM9c/sC8zbHzs
 1Ljcba4ASMebldPjFhu+IffpCtJMv1qW80BOoYC2H6VT3wg954WvoAArFf4rn+uyQB1bmNW+ZxX
 Qo/l/sVagrf+MLN3EXBWYV9JCvkoP9V2iNk+OsdaQwPABsgOuvRFGR6i5lPuMCx2fqEBG4WkGmB
 kIYiud5O
X-Authority-Analysis: v=2.4 cv=QtNe3Uyd c=1 sm=1 tr=0 ts=689c302f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=iO9NmEFvf90wNdx_zysA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
X-Proofpoint-ORIG-GUID: 1DmuEpzOEC91AhJGOz3CZKD6ylyDxymq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224

To provide support for page table check on powerpc, we need to reinstate the
address parameter in several functions, including
page_table_check_{ptes,pmds,puds}_set().

In preparation for this, add the addr parameter to arm64's __set_ptes_anysz()
and change its callsites accordingly.

Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
---
v15: new patch
v16: rebase
---
 arch/arm64/include/asm/pgtable.h | 19 ++++++++-----------
 arch/arm64/mm/hugetlbpage.c      | 10 +++++-----
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index abd2dee416b3..ed644be48d87 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -698,8 +698,8 @@ static inline pgprot_t pud_pgprot(pud_t pud)
 	return __pgprot(pud_val(pfn_pud(pfn, __pgprot(0))) ^ pud_val(pud));
 }
 
-static inline void __set_ptes_anysz(struct mm_struct *mm, pte_t *ptep,
-				    pte_t pte, unsigned int nr,
+static inline void __set_ptes_anysz(struct mm_struct *mm, unsigned long addr,
+				    pte_t *ptep, pte_t pte, unsigned int nr,
 				    unsigned long pgsize)
 {
 	unsigned long stride = pgsize >> PAGE_SHIFT;
@@ -734,26 +734,23 @@ static inline void __set_ptes_anysz(struct mm_struct *mm, pte_t *ptep,
 	__set_pte_complete(pte);
 }
 
-static inline void __set_ptes(struct mm_struct *mm,
-			      unsigned long __always_unused addr,
+static inline void __set_ptes(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte, unsigned int nr)
 {
-	__set_ptes_anysz(mm, ptep, pte, nr, PAGE_SIZE);
+	__set_ptes_anysz(mm, addr, ptep, pte, nr, PAGE_SIZE);
 }
 
-static inline void __set_pmds(struct mm_struct *mm,
-			      unsigned long __always_unused addr,
+static inline void __set_pmds(struct mm_struct *mm, unsigned long addr,
 			      pmd_t *pmdp, pmd_t pmd, unsigned int nr)
 {
-	__set_ptes_anysz(mm, (pte_t *)pmdp, pmd_pte(pmd), nr, PMD_SIZE);
+	__set_ptes_anysz(mm, addr, (pte_t *)pmdp, pmd_pte(pmd), nr, PMD_SIZE);
 }
 #define set_pmd_at(mm, addr, pmdp, pmd) __set_pmds(mm, addr, pmdp, pmd, 1)
 
-static inline void __set_puds(struct mm_struct *mm,
-			      unsigned long __always_unused addr,
+static inline void __set_puds(struct mm_struct *mm, unsigned long addr,
 			      pud_t *pudp, pud_t pud, unsigned int nr)
 {
-	__set_ptes_anysz(mm, (pte_t *)pudp, pud_pte(pud), nr, PUD_SIZE);
+	__set_ptes_anysz(mm, addr, (pte_t *)pudp, pud_pte(pud), nr, PUD_SIZE);
 }
 #define set_pud_at(mm, addr, pudp, pud) __set_puds(mm, addr, pudp, pud, 1)
 
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 1d90a7e75333..1003b5020752 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -225,8 +225,8 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	ncontig = num_contig_ptes(sz, &pgsize);
 
 	if (!pte_present(pte)) {
-		for (i = 0; i < ncontig; i++, ptep++)
-			__set_ptes_anysz(mm, ptep, pte, 1, pgsize);
+		for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
+			__set_ptes_anysz(mm, addr, ptep, pte, 1, pgsize);
 		return;
 	}
 
@@ -234,7 +234,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	if (pte_cont(pte) && pte_valid(__ptep_get(ptep)))
 		clear_flush(mm, addr, ptep, pgsize, ncontig);
 
-	__set_ptes_anysz(mm, ptep, pte, ncontig, pgsize);
+	__set_ptes_anysz(mm, addr, ptep, pte, ncontig, pgsize);
 }
 
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
@@ -449,7 +449,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	if (pte_young(orig_pte))
 		pte = pte_mkyoung(pte);
 
-	__set_ptes_anysz(mm, ptep, pte, ncontig, pgsize);
+	__set_ptes_anysz(mm, addr, ptep, pte, ncontig, pgsize);
 	return 1;
 }
 
@@ -473,7 +473,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	pte = get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
 	pte = pte_wrprotect(pte);
 
-	__set_ptes_anysz(mm, ptep, pte, ncontig, pgsize);
+	__set_ptes_anysz(mm, addr, ptep, pte, ncontig, pgsize);
 }
 
 pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
-- 
2.50.1


