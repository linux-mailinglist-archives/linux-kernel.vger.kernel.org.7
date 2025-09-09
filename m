Return-Path: <linux-kernel+bounces-807658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 373E8B4A7B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DFAB4E8112
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC312D7381;
	Tue,  9 Sep 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ocmyOY+8"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074922D6621
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409346; cv=none; b=Y+ci3t1BLzoop0H6C0rlL+dwd7Bvi0kJ/WfjykpSG44X9c58lrO+++iVdLCVWiihPhAhw641x0schk1cWGMKeIEvR4eOQO6KF6aOkqCIF+8RY5tUer+bsrkb2chM7sAd0h9DN6zQmPluhyfbItqnJqP0AE3kXU1kdl/k6V8QHmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409346; c=relaxed/simple;
	bh=N6LIupMDk0S5FOA1e3upWYxspCO7R38q+uiTL7MRhLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KH4PgGUDbx8+GiLyR8H076jJLwIP0kwAjw/SMixh97VyaxPLa//FdrMntWBkh3D2dKOPIIZk3UTyvlw3wHz0e+Yjn+k/W5BU6yDhb0XOPEQOaC43IQhM0M1pWHFHzvtMPd+8eTQizZ+0e1kPyIDgyCiHRDMjWA834LcllWPwZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ocmyOY+8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58990div031661;
	Tue, 9 Sep 2025 09:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8lpZ7Kcjm736hRttC
	DDPd8Oh+DFxjiym2RbVj81INmM=; b=ocmyOY+81FEpgusNJXMxmGzziiAMZU2w8
	JSX1isTopHv9NlD59UxHu/ctRCubyO2slf6T345AZI8ofUGk7NZepHEOfjS4X4bG
	SIQeD+FCUaSW/+EWOO4gWR+M3tEsnoysTxlxYo9+0o7g/6/dMkds73O6ZTaLERBL
	4IUNFDC0uFjdgfsLoJDfpdOyYJXQ9zKB9YH70IuMI+6cV7sNDcL24z6W47r3QJkV
	Y2IVnR6DAGbp2uLUwfTT9LXBTK+T4CQAgb80RQG5bTw8XCS/SxFvJzDaUF+FZ2ZW
	vNZPj8td04UZtGyBECIXZsJTmnDy7UN9QlPsZyFLQJbHv3nbm/cIw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acqxn9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 09:15:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5897G6Bj017219;
	Tue, 9 Sep 2025 09:15:28 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gma5ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 09:15:28 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5899FSfl29950484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 09:15:28 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E41E158043;
	Tue,  9 Sep 2025 09:15:27 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDA8858060;
	Tue,  9 Sep 2025 09:15:22 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com.com (unknown [9.36.2.198])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 09:15:22 +0000 (GMT)
From: Andrew Donnellan <ajd@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, x86@kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pasha.tatashin@soleen.com, sweettea-kernel@dorminy.me,
        nicholas@linux.ibm.com, christophe.leroy@csgroup.eu,
        alexghiti@rivosinc.com, Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH v17 11/12] powerpc: mm: Use set_pte_at_unchecked() for internal usages
Date: Tue,  9 Sep 2025 19:13:34 +1000
Message-ID: <20250909091335.183439-12-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909091335.183439-1-ajd@linux.ibm.com>
References: <20250909091335.183439-1-ajd@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 63LcHXFzzkovazD-aRXH5GGwkMQxYNTi
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68bff031 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=aG8EAFyCJnWj3sFUJ80A:9
X-Proofpoint-ORIG-GUID: 63LcHXFzzkovazD-aRXH5GGwkMQxYNTi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfXx1Yd4G+KdQRj
 o6pEaUCIlr5tzQVwA/upa5zjgdcR62dV5MKecMSPwt6wdSHHMJ6TlCyZp9Qp9rTmvX3PuIvVUnN
 Ut60YYspVxOcHFsvQ+5gpDG6P/rUg8a2d0jFB0oUtvxEKbhH184fsxqaAGF4Y0qG+Y5LZzn9D0D
 kDyyQ661GmDBN4Ot3Hb0V5OAd7iYh1oJA2uK7w/+BeXTq7ZgKIZ3tI/eArVWoS9sFR9SHJgPZAe
 AYaPYh3pD0uTOBBCyNJfXTo75FFVDFhirFFMm20IqEPVf1W2MfEKBbPapX62BQ8XiD0E6fy2uaq
 zbUHupzDOfL3VHXfBqfm0k1yDBG28ei44lWzOdkG58B2WAnjLgo0pljlyf8hbN/UrA8gv83Fhsm
 8pdUzHZX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000

From: Rohan McLure <rmclure@linux.ibm.com>

In the new set_ptes() API, set_pte_at() (a special case of set_ptes())
is intended to be instrumented by the page table check facility. There
are however several other routines that constitute the API for setting
page table entries, including set_pmd_at() among others. Such routines
are themselves implemented in terms of set_ptes_at().

A future patch providing support for page table checking on powerpc
must take care to avoid duplicate calls to
page_table_check_p{te,md,ud}_set(). Allow for assignment of pte entries
without instrumentation through the set_pte_at_unchecked() routine
introduced in this patch.

Cause API-facing routines that call set_pte_at() to instead call
set_pte_at_unchecked(), which will remain uninstrumented by page
table check. set_ptes() is itself implemented by calls to
__set_pte_at(), so this eliminates redundant code.

[ajd@linux.ibm.com: don't change to unchecked for early boot/kernel mappings]
Signed-off-by: Rohan McLure <rmclure@linux.ibm.com>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
v13: don't use the unchecked version for early-boot kernel mappings (Pasha)
---
 arch/powerpc/include/asm/pgtable.h       | 2 ++
 arch/powerpc/mm/book3s64/pgtable.c       | 6 +++---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 6 +++---
 arch/powerpc/mm/pgtable.c                | 8 ++++++++
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index fa43f663e615..3983efb365cc 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -34,6 +34,8 @@ struct mm_struct;
 void set_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 		pte_t pte, unsigned int nr);
 #define set_ptes set_ptes
+void set_pte_at_unchecked(struct mm_struct *mm, unsigned long addr,
+			  pte_t *ptep, pte_t pte);
 #define update_mmu_cache(vma, addr, ptep) \
 	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
 
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index c9431ae7f78a..ff0c5a1988f8 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -127,7 +127,7 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	WARN_ON(!(pmd_leaf(pmd)));
 #endif
 	trace_hugepage_set_pmd(addr, pmd_val(pmd));
-	return set_pte_at(mm, addr, pmdp_ptep(pmdp), pmd_pte(pmd));
+	return set_pte_at_unchecked(mm, addr, pmdp_ptep(pmdp), pmd_pte(pmd));
 }
 
 void set_pud_at(struct mm_struct *mm, unsigned long addr,
@@ -144,7 +144,7 @@ void set_pud_at(struct mm_struct *mm, unsigned long addr,
 	WARN_ON(!(pud_leaf(pud)));
 #endif
 	trace_hugepage_set_pud(addr, pud_val(pud));
-	return set_pte_at(mm, addr, pudp_ptep(pudp), pud_pte(pud));
+	return set_pte_at_unchecked(mm, addr, pudp_ptep(pudp), pud_pte(pud));
 }
 
 static void do_serialize(void *arg)
@@ -549,7 +549,7 @@ void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
 	if (radix_enabled())
 		return radix__ptep_modify_prot_commit(vma, addr,
 						      ptep, old_pte, pte);
-	set_pte_at(vma->vm_mm, addr, ptep, pte);
+	set_pte_at_unchecked(vma->vm_mm, addr, ptep, pte);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 73977dbabcf2..b2541bf33d01 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1606,7 +1606,7 @@ void radix__ptep_modify_prot_commit(struct vm_area_struct *vma,
 	    (atomic_read(&mm->context.copros) > 0))
 		radix__flush_tlb_page(vma, addr);
 
-	set_pte_at(mm, addr, ptep, pte);
+	set_pte_at_unchecked(mm, addr, ptep, pte);
 }
 
 int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
@@ -1617,7 +1617,7 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 	if (!radix_enabled())
 		return 0;
 
-	set_pte_at(&init_mm, 0 /* radix unused */, ptep, new_pud);
+	set_pte_at_unchecked(&init_mm, 0 /* radix unused */, ptep, new_pud);
 
 	return 1;
 }
@@ -1664,7 +1664,7 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 	if (!radix_enabled())
 		return 0;
 
-	set_pte_at(&init_mm, 0 /* radix unused */, ptep, new_pmd);
+	set_pte_at_unchecked(&init_mm, 0 /* radix unused */, ptep, new_pmd);
 
 	return 1;
 }
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 56d7e8960e77..7b69cd16e011 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -224,6 +224,14 @@ void set_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 	}
 }
 
+void set_pte_at_unchecked(struct mm_struct *mm, unsigned long addr,
+			  pte_t *ptep, pte_t pte)
+{
+	VM_WARN_ON(pte_hw_valid(*ptep) && !pte_protnone(*ptep));
+	pte = set_pte_filter(pte, addr);
+	__set_pte_at(mm, addr, ptep, pte, 0);
+}
+
 void unmap_kernel_page(unsigned long va)
 {
 	pmd_t *pmdp = pmd_off_k(va);
-- 
2.51.0


