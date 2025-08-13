Return-Path: <linux-kernel+bounces-766030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B348DB24179
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EA41B6521D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BE72D3209;
	Wed, 13 Aug 2025 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EHCPAT1f"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0002D23B5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066450; cv=none; b=eB9Q1uCHTRbSRY60VPt0GQwFaf2CpHCp7MVOjv5tVdefhzUSZo+25+DWimJ5XIKZSD+Roq8oBy2gk0vd5/KB18Nn6VgkTu6i99oVQo75KBNWhGU03hEn7dETk726LQKQmB48rPRBqLAm0rdqnhMXlpXV2O7qlzJnUpYAggt5NPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066450; c=relaxed/simple;
	bh=7HGjWLD91WnSt5t0+nGdoKepZ+o/oIeRRUCVD9sAeLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSc6R4PiEp50KOxqiKthSyBkaKhZ8joc3dp8rolMnODYPUdASOKlwdX4bkA0AeB4E+5VPQtwO4jmy8BcMqh7mE84o2klBzIxTd+IFAStMJ4LonwUdRrvlEOYjo+ftL5A2aVBJer2gvrVwIwz72sTD0b+yL7EkTiiC0VsDFZfgIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EHCPAT1f; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CNQEdw029457;
	Wed, 13 Aug 2025 06:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4/Ctvw1o/hFQJBWWT
	XNgAbNPCkcs2kP/YXaYRhFGjCA=; b=EHCPAT1f2fauwPtx/6zrJJMyUp0eIk2Y7
	hDQfBazzR0GwVvKBWmScRNueXvD9ynudxoLhPhCsWYaviLXRR4BmAXWwtWCQya4j
	7GUqQEVZ9NuWoKU7KZ2tvaVOuhAUWcO8p6eqn+B5E4fn5tufgQWPULlMsI6rQZAg
	y0nou+fOvRmjzpR4Ox+EZA4L4ptsYPdwFWv8kz9c0CaN3q63Cz3x5+PbbRz2MX/z
	ku/7CRXwcex6OlmIxkzs9h/OShkYCujhuTgidYprSEBMupUaHj8dX+SG30FhUn6/
	4SBx9+tp0s/ucZ/DjuLGEm46PIf0hCQCHxp2hONdWEOmG0cnm+eAA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwudax2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 06:27:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57D2Cmmm026282;
	Wed, 13 Aug 2025 06:27:14 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh21655h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 06:27:13 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57D6RCjh60490068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 06:27:12 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A4475805C;
	Wed, 13 Aug 2025 06:27:12 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AA4558059;
	Wed, 13 Aug 2025 06:27:06 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com.com (unknown [9.36.10.70])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Aug 2025 06:27:06 +0000 (GMT)
From: Andrew Donnellan <ajd@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, x86@kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pasha.tatashin@soleen.com, sweettea-kernel@dorminy.me,
        nicholas@linux.ibm.com, christophe.leroy@csgroup.eu,
        Rohan McLure <rmclure@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v16 04/13] mm/page_table_check: Reinstate address parameter in [__]page_table_check_pmd[s]_set()
Date: Wed, 13 Aug 2025 16:26:05 +1000
Message-ID: <20250813062614.51759-5-ajd@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX33uH2V/03q65
 WN1QqKQKPu+t/sNLO9adq6bh7J0+vOcFEjkPlxjNF7M7tg+moTlBMpS/c6j9AgpvgXUZ2MYtBIa
 GtFekt00DU+cohrUnti/7P5wmWPKnf75PmWN6ycJXo11JjLgJfvyvuKs/F0K+PXMgzFcTjebPdA
 5OqZpbwdlm8QhqyfRUahZcLCR7p4v6EmHoa3xnCixBaMM+Ji/JPDY34KQoxO1S6gNftzLTXfStr
 intARyZ3giZtscaglPA26hARl0XSFBdjwhiBZfXaF32KPpXgJLy7fBvhsJxHWdQN+Pqb/gSSAB4
 HYrf7sYrN8xaITkfpUvuz51i2leyAGqJnNpkyxwMHzhP4HHMaOjAN13K+mI0n5lZ3gDzwZIFD92
 QHXPggVK
X-Authority-Analysis: v=2.4 cv=d/31yQjE c=1 sm=1 tr=0 ts=689c3043 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=7ipKWUHlAAAA:8 a=VwQbUJbxAAAA:8
 a=-IAaNFHw-wEKn7DCNmAA:9 a=gpc5p9EgBqZVLdJeV_V1:22
X-Proofpoint-GUID: ArK2hxIBNAN1bo7D-2Vwi9D3z4rGNP9E
X-Proofpoint-ORIG-GUID: ArK2hxIBNAN1bo7D-2Vwi9D3z4rGNP9E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224

From: Rohan McLure <rmclure@linux.ibm.com>

This reverts commit a3b837130b58 ("mm/page_table_check: remove unused
parameter in [__]page_table_check_pmd_set").

Reinstate previously unused parameters for the purpose of supporting
powerpc platforms, as many do not encode user/kernel ownership of the
page in the pte, but instead in the address of the access.

Apply this to __page_table_check_pmds_set(), page_table_check_pmd_set(), and
the page_table_check_pmd_set() wrapper macro.

[ajd@linux.ibm.com: rebase on arm64 + riscv changes, update commit message]
Signed-off-by: Rohan McLure <rmclure@linux.ibm.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Ingo Molnar <mingo@kernel.org>  # x86
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
---
v13: remove inaccurate comment on riscv in the commit message
v14: rebase
v15: rebase, amend commit message
---
 arch/arm64/include/asm/pgtable.h |  5 +++--
 arch/riscv/include/asm/pgtable.h |  4 ++--
 arch/x86/include/asm/pgtable.h   |  4 ++--
 include/linux/page_table_check.h | 12 ++++++------
 mm/page_table_check.c            |  4 ++--
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 8070b653c409..9fe3af8b4cad 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -709,7 +709,8 @@ static inline void __set_ptes_anysz(struct mm_struct *mm, unsigned long addr,
 		page_table_check_ptes_set(mm, ptep, pte, nr);
 		break;
 	case PMD_SIZE:
-		page_table_check_pmds_set(mm, (pmd_t *)ptep, pte_pmd(pte), nr);
+		page_table_check_pmds_set(mm, addr, (pmd_t *)ptep,
+					  pte_pmd(pte), nr);
 		break;
 #ifndef __PAGETABLE_PMD_FOLDED
 	case PUD_SIZE:
@@ -1514,7 +1515,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp, pmd_t pmd)
 {
-	page_table_check_pmd_set(vma->vm_mm, pmdp, pmd);
+	page_table_check_pmd_set(vma->vm_mm, address, pmdp, pmd);
 	return __pmd(xchg_relaxed(&pmd_val(*pmdp), pmd_val(pmd)));
 }
 #endif
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 3ed0f5e4879d..6e8c3d19f96a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -805,7 +805,7 @@ static inline pud_t pud_mkspecial(pud_t pud)
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 				pmd_t *pmdp, pmd_t pmd)
 {
-	page_table_check_pmd_set(mm, pmdp, pmd);
+	page_table_check_pmd_set(mm, addr, pmdp, pmd);
 	return __set_pte_at(mm, (pte_t *)pmdp, pmd_pte(pmd));
 }
 
@@ -876,7 +876,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 				unsigned long address, pmd_t *pmdp, pmd_t pmd)
 {
-	page_table_check_pmd_set(vma->vm_mm, pmdp, pmd);
+	page_table_check_pmd_set(vma->vm_mm, address, pmdp, pmd);
 	return __pmd(atomic_long_xchg((atomic_long_t *)pmdp, pmd_val(pmd)));
 }
 
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 0603793acb3a..8ee301b16b50 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1213,7 +1213,7 @@ static inline pud_t native_local_pudp_get_and_clear(pud_t *pudp)
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 			      pmd_t *pmdp, pmd_t pmd)
 {
-	page_table_check_pmd_set(mm, pmdp, pmd);
+	page_table_check_pmd_set(mm, addr, pmdp, pmd);
 	set_pmd(pmdp, pmd);
 }
 
@@ -1356,7 +1356,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp, pmd_t pmd)
 {
-	page_table_check_pmd_set(vma->vm_mm, pmdp, pmd);
+	page_table_check_pmd_set(vma->vm_mm, address, pmdp, pmd);
 	if (IS_ENABLED(CONFIG_SMP)) {
 		return xchg(pmdp, pmd);
 	} else {
diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
index 0bf18b884a12..cf7c28d8d468 100644
--- a/include/linux/page_table_check.h
+++ b/include/linux/page_table_check.h
@@ -19,8 +19,8 @@ void __page_table_check_pmd_clear(struct mm_struct *mm, pmd_t pmd);
 void __page_table_check_pud_clear(struct mm_struct *mm, pud_t pud);
 void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
 		unsigned int nr);
-void __page_table_check_pmds_set(struct mm_struct *mm, pmd_t *pmdp, pmd_t pmd,
-		unsigned int nr);
+void __page_table_check_pmds_set(struct mm_struct *mm, unsigned long addr,
+		pmd_t *pmdp, pmd_t pmd, unsigned int nr);
 void __page_table_check_puds_set(struct mm_struct *mm, unsigned long addr,
 		pud_t *pudp, pud_t pud, unsigned int nr);
 void __page_table_check_pte_clear_range(struct mm_struct *mm,
@@ -77,12 +77,12 @@ static inline void page_table_check_ptes_set(struct mm_struct *mm,
 }
 
 static inline void page_table_check_pmds_set(struct mm_struct *mm,
-		pmd_t *pmdp, pmd_t pmd, unsigned int nr)
+		unsigned long addr, pmd_t *pmdp, pmd_t pmd, unsigned int nr)
 {
 	if (static_branch_likely(&page_table_check_disabled))
 		return;
 
-	__page_table_check_pmds_set(mm, pmdp, pmd, nr);
+	__page_table_check_pmds_set(mm, addr, pmdp, pmd, nr);
 }
 
 static inline void page_table_check_puds_set(struct mm_struct *mm,
@@ -132,7 +132,7 @@ static inline void page_table_check_ptes_set(struct mm_struct *mm,
 }
 
 static inline void page_table_check_pmds_set(struct mm_struct *mm,
-		pmd_t *pmdp, pmd_t pmd, unsigned int nr)
+		unsigned long addr, pmd_t *pmdp, pmd_t pmd, unsigned int nr)
 {
 }
 
@@ -149,7 +149,7 @@ static inline void page_table_check_pte_clear_range(struct mm_struct *mm,
 
 #endif /* CONFIG_PAGE_TABLE_CHECK */
 
-#define page_table_check_pmd_set(mm, pmdp, pmd)	page_table_check_pmds_set(mm, pmdp, pmd, 1)
+#define page_table_check_pmd_set(mm, addr, pmdp, pmd)	page_table_check_pmds_set(mm, addr, pmdp, pmd, 1)
 #define page_table_check_pud_set(mm, addr, pudp, pud)	page_table_check_puds_set(mm, addr, pudp, pud, 1)
 
 #endif /* __LINUX_PAGE_TABLE_CHECK_H */
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 3c39e4375886..09258f2ad93f 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -218,8 +218,8 @@ static inline void page_table_check_pmd_flags(pmd_t pmd)
 		WARN_ON_ONCE(swap_cached_writable(pmd_to_swp_entry(pmd)));
 }
 
-void __page_table_check_pmds_set(struct mm_struct *mm, pmd_t *pmdp, pmd_t pmd,
-		unsigned int nr)
+void __page_table_check_pmds_set(struct mm_struct *mm, unsigned long addr,
+		pmd_t *pmdp, pmd_t pmd, unsigned int nr)
 {
 	unsigned long stride = PMD_SIZE >> PAGE_SHIFT;
 	unsigned int i;
-- 
2.50.1


