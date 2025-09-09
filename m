Return-Path: <linux-kernel+bounces-807647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A62B4A799
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE88D5E2C42
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B2F275AF6;
	Tue,  9 Sep 2025 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IjUMIvmi"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D612D2398
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409294; cv=none; b=dKKw5dHWKKS24JSY9uwZjvSOJF0t9Yfour+P60Oo86S2BfqNPF0r2MaGEGQ+XgboVqjXm0ODTcG/At2LjGo1k8Gq7MzUegIXlefF17/1BLwodIBCNtihJ2zLrZMYCL7io0PcvfizIZyn/LiUtkMBGqhTqaES77KW1bU9cwW1qV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409294; c=relaxed/simple;
	bh=8UINRWJ9fkKVOiXAWwZ6CFu504K6JpLNZMwJMyT6b1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSw0wrnnO4Ru3SMcwFA4hEdSk3we6mN4umF1g0rVnyPbygv2UKHLByGAVQfc6WEshPh2a2HcHZntTJXEp3etIaUjdURndp8yNckgp++Wb5/fYMo5HlXIqs2cKdII9I/UEKV6xISrmNCQWvFcZi1BtIF44lVqs474bqjLngxC58U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IjUMIvmi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588JqsJ3027668;
	Tue, 9 Sep 2025 09:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=c0HW+blhE7M3nTPyF
	A27l5i/iEflduWAFHPGBKiI5lE=; b=IjUMIvmi0L8BRu7otvJmyUfaAOG1ADq20
	7i1e5kbZNv1UarwszA0kPJ8nqONwLuxygYrRYWDS5u1426Lh/dGnPEj5LMufW/78
	p8dXRqGGLDl8wmJwEfplSm8VUufMhZnuDwtGbJM9OMEILDJ/5XYMlYh5GZ5+1Ps+
	M0/aMk7XLBZ0gEqaWZabHJMZUtjWsTw7Z0iTDWCfXXyQkEzutVRwBDTJ7jjlISC2
	UiQkQRFUSXFRiG4CvqpmSwL3X2odqlqlKj9QnfpPxkVhd25alo16lqNk/q9PDKSY
	Ra2OK8TCN7Yy1wtLh307ot2saiWQ/O1umlBjsPFlt2jc4bN7zXUvQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acqxn5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 09:14:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5897Dfcg017163;
	Tue, 9 Sep 2025 09:14:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gma577-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 09:14:35 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5899EY5X30868222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 09:14:34 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6144D58061;
	Tue,  9 Sep 2025 09:14:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6617758043;
	Tue,  9 Sep 2025 09:14:29 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com.com (unknown [9.36.2.198])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 09:14:28 +0000 (GMT)
From: Andrew Donnellan <ajd@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, x86@kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pasha.tatashin@soleen.com, sweettea-kernel@dorminy.me,
        nicholas@linux.ibm.com, christophe.leroy@csgroup.eu,
        alexghiti@rivosinc.com
Subject: [PATCH v17 02/12] arm64/mm: Add addr parameter to __ptep_get_and_clear_anysz()
Date: Tue,  9 Sep 2025 19:13:25 +1000
Message-ID: <20250909091335.183439-3-ajd@linux.ibm.com>
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
X-Proofpoint-GUID: zma7-2BIGce-GjmjSuDkB0mTsFn9uVMG
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68bfeffc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=_22z2SZoHydJqXFBeZgA:9
X-Proofpoint-ORIG-GUID: zma7-2BIGce-GjmjSuDkB0mTsFn9uVMG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX1ZST0tGidk09
 0tYS4d3b9I50Xe9Xj9L0RFbb//nVHmcrY8Kmmi0KcbGjvSYhAJnleq/oaC9/hiqsN42X8f7wI3z
 NbPTNnaRmzQcq+jUWyL5N5delqzVe6pmQP7pMEH2r9GHThMmXfnGONPytsC0UIbAAjb8+hBqRve
 aNnvPhGBgOKjU962DWfo6101QuylYVAuKBPcQi7jOi9N/PsUme2uFMHalr7FrJTaQGhbAEnV5lj
 y0CZaENOf0CkOi/7y2Va75gIixlFoFqMPH6XkB6x7G9UX13q51yxh7e2RVCTvO/3r7/qo8VJliQ
 oyo4C01nk8inYVWpCpnzb3yphiqfMhuWgkuSgxBYgHXz7eTo3cYMf6cjk884K3kcopbupsItyOL
 woutaxKE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1011 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000

To provide support for page table check on powerpc, we need to reinstate the
address parameter in several functions, including
page_table_check_{pte,pmd,pud}_clear().

In preparation for this, add the addr parameter to arm64's
__ptep_get_and_clear_anysz() and change its callsites accordingly.

Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
---
v15: new patch
---
 arch/arm64/include/asm/pgtable.h | 5 +++--
 arch/arm64/mm/hugetlbpage.c      | 7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index ed644be48d87..66b5309fcad8 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1357,6 +1357,7 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG */
 
 static inline pte_t __ptep_get_and_clear_anysz(struct mm_struct *mm,
+					       unsigned long address,
 					       pte_t *ptep,
 					       unsigned long pgsize)
 {
@@ -1384,7 +1385,7 @@ static inline pte_t __ptep_get_and_clear_anysz(struct mm_struct *mm,
 static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address, pte_t *ptep)
 {
-	return __ptep_get_and_clear_anysz(mm, ptep, PAGE_SIZE);
+	return __ptep_get_and_clear_anysz(mm, address, ptep, PAGE_SIZE);
 }
 
 static inline void __clear_full_ptes(struct mm_struct *mm, unsigned long addr,
@@ -1423,7 +1424,7 @@ static inline pte_t __get_and_clear_full_ptes(struct mm_struct *mm,
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 					    unsigned long address, pmd_t *pmdp)
 {
-	return pte_pmd(__ptep_get_and_clear_anysz(mm, (pte_t *)pmdp, PMD_SIZE));
+	return pte_pmd(__ptep_get_and_clear_anysz(mm, address, (pte_t *)pmdp, PMD_SIZE));
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 1003b5020752..bcc28031eb7a 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -159,11 +159,12 @@ static pte_t get_clear_contig(struct mm_struct *mm,
 	pte_t pte, tmp_pte;
 	bool present;
 
-	pte = __ptep_get_and_clear_anysz(mm, ptep, pgsize);
+	pte = __ptep_get_and_clear_anysz(mm, addr, ptep, pgsize);
 	present = pte_present(pte);
 	while (--ncontig) {
 		ptep++;
-		tmp_pte = __ptep_get_and_clear_anysz(mm, ptep, pgsize);
+		addr += pgsize;
+		tmp_pte = __ptep_get_and_clear_anysz(mm, addr, ptep, pgsize);
 		if (present) {
 			if (pte_dirty(tmp_pte))
 				pte = pte_mkdirty(pte);
@@ -207,7 +208,7 @@ static void clear_flush(struct mm_struct *mm,
 	unsigned long i, saddr = addr;
 
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
-		__ptep_get_and_clear_anysz(mm, ptep, pgsize);
+		__ptep_get_and_clear_anysz(mm, addr, ptep, pgsize);
 
 	if (mm == &init_mm)
 		flush_tlb_kernel_range(saddr, addr);
-- 
2.51.0


