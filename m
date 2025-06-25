Return-Path: <linux-kernel+bounces-701633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837A0AE7748
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 08:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF53A17B39A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 06:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5871F463C;
	Wed, 25 Jun 2025 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZVTsY4iu"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390EC1F417B
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750833604; cv=none; b=BCYvcCe2d2QXXitkJOsuSoqaHbcmiIHFaur6/qYz6ZtdB5a2xaHA2jJaopUMa9IFIBaRNU3xVcjc+NkXV7c5AMlyvC32vbbMTOEHV7DhqHF/K29aS0//jCjCC1PuznSByT91Bs8m6NEE/Q/0RT/kxY87moOI/OFtUJT1ON+2MrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750833604; c=relaxed/simple;
	bh=AlFRqGPfVPlsS/JrN+TTx7xmwCM5gQLROXynUoae7+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjdTyIk+RsjNuKwCIo+EoZrXM3F/u0j1m8xspkAXrd0glnX8Glx1bP4lQ0pRF+MA2n58iLQWxMXeZLG6Dk9NOnqu+YGnU8y+MmaiHo3pBWd9pEULyqq3nB8yDVS8p4t5Hc43dwL8m07vF6PvE0OhOt5CRqgSDuxbH3kp6whX8lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZVTsY4iu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P6KIFC027197;
	Wed, 25 Jun 2025 06:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=y0uGGjTwvQMXqwA8b
	HmeHWGWvFDAhSVWPCqT+UWRp/M=; b=ZVTsY4iuseNAEkMz5aUAtf20YjK87OvHJ
	pgiY16o8tHB6B3VQm34YNet81excWdAZN0ARDY9xDvouCYKksesrqL995PempcPG
	vMZCS2AFNTNt26GaHOxjsWsd4Jfu0bsZftDu5NR4FsuDeTareXKit3lSU7Hl9QsL
	eiRZEjHwBn8IvJXAPOxGiUYg6DYAPeW3YMnpwTJLx0213bzh44e53EpHrdLz0X5J
	zZq5oGQQ3nr4VO6znGbhwWYqOWM9dPaB62lEsSGkKH/M6hfJ+f9mhunL3YTDD0aB
	L7xO0S71Cq91L++yG2hhM2Ko7Z2Pp2ZMtwBD7B0qSoZPZID7d5VWw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5twg89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 06:39:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55P65rBf006329;
	Wed, 25 Jun 2025 06:39:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82p8012-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 06:39:48 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55P6dlxV47251908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 06:39:47 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A9A058932;
	Wed, 25 Jun 2025 06:39:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F152558913;
	Wed, 25 Jun 2025 06:39:24 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com.com (unknown [9.36.18.35])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Jun 2025 06:39:24 +0000 (GMT)
From: Andrew Donnellan <ajd@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, pasha.tatashin@soleen.com,
        akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, sweettea-kernel@dorminy.me,
        christophe.leroy@csgroup.eu, mingo@kernel.org
Subject: [PATCH v15 11/13] powerpc: mm: Implement *_user_accessible_page() for ptes
Date: Wed, 25 Jun 2025 16:37:51 +1000
Message-ID: <20250625063753.77511-12-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625063753.77511-1-ajd@linux.ibm.com>
References: <20250625063753.77511-1-ajd@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o8pwN8EwYal227quZlaJ3Sf4w3pndpWK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA0NSBTYWx0ZWRfX/r2U2Vc/ajCp bxsk6+xpiyEKaboTL+EmY/t/cFJaZuaZichgUtjlkdAvasA29qP2hCPbFcI1lbO577y3aQem6KE 71z4G3FuhONrOr5KROK5VkunB2NBAYb5WBzFTfnTbJ2uUcwNpgAsFWz++yrgbPc4eSfantOty6e
 hTXJcsG2W4MBNRzZuGXgYWgiLit9rIPiuPccmbSQ/7Ppwb/7bPqvj9gXNyit86BC7NZLK/39yGW y1YO2Hky4EwTzlhpnMeMj6eISDXZdZZu1z+l3jKiMbu/cr0m8UrOQ2vQ8+I/+C2bev6ppY6EILf HlJ8LYFyUh0nkS3mXBAecPKECm3FPacnmng+Q/j52GBoYS3AK8DdkMMevf/0TKjw1D0TLNf0WA3
 JFp/KHCimzIj1NX/oSzyY9gfxMfUUJAU5wbgcEBFp84EeJbtrhGdEaC25cegM3OTd5Mutnpl
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=685b99b5 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=7ipKWUHlAAAA:8 a=a65a1E2n8xkc5m_RgcEA:9 a=gpc5p9EgBqZVLdJeV_V1:22
X-Proofpoint-GUID: o8pwN8EwYal227quZlaJ3Sf4w3pndpWK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=673 impostorscore=0
 clxscore=1011 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250045

From: Rohan McLure <rmclure@linux.ibm.com>

Page table checking depends on architectures providing an
implementation of p{te,md,ud}_user_accessible_page. With
refactorisations made on powerpc/mm, the pte_access_permitted() and
similar methods verify whether a userland page is accessible with the
required permissions.

Since page table checking is the only user of
p{te,md,ud}_user_accessible_page(), implement these for all platforms,
using some of the same preliminary checks taken by pte_access_permitted()
on that platform.

Since commit 8e9bd41e4ce1 ("powerpc/nohash: Replace pte_user() by pte_read()")
pte_user() is no longer required to be present on all platforms as it
may be equivalent to or implied by pte_read(). Hence implementations of
pte_user_accessible_page() are specialised.

[ajd@linux.ibm.com: rebase and fix commit message]
Signed-off-by: Rohan McLure <rmclure@linux.ibm.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h |  5 +++++
 arch/powerpc/include/asm/book3s/64/pgtable.h | 17 +++++++++++++++++
 arch/powerpc/include/asm/nohash/pgtable.h    |  5 +++++
 arch/powerpc/include/asm/pgtable.h           |  8 ++++++++
 4 files changed, 35 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 92d21c6faf1e..b225967f85ea 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -437,6 +437,11 @@ static inline bool pte_access_permitted(pte_t pte, bool write)
 	return true;
 }
 
+static inline bool pte_user_accessible_page(pte_t pte, unsigned long addr)
+{
+	return pte_present(pte) && !is_kernel_addr(addr);
+}
+
 /* Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
  *
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index a2ddcbb3fcb9..5de04302c6f4 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -540,6 +540,11 @@ static inline bool pte_access_permitted(pte_t pte, bool write)
 	return arch_pte_access_permitted(pte_val(pte), write, 0);
 }
 
+static inline bool pte_user_accessible_page(pte_t pte, unsigned long addr)
+{
+	return pte_present(pte) && pte_user(pte);
+}
+
 /*
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
@@ -1430,5 +1435,17 @@ static inline bool is_pte_rw_upgrade(unsigned long old_val, unsigned long new_va
 	return false;
 }
 
+#define pmd_user_accessible_page pmd_user_accessible_page
+static inline bool pmd_user_accessible_page(pmd_t pmd, unsigned long addr)
+{
+	return pmd_leaf(pmd) && pte_user_accessible_page(pmd_pte(pmd), addr);
+}
+
+#define pud_user_accessible_page pud_user_accessible_page
+static inline bool pud_user_accessible_page(pud_t pud, unsigned long addr)
+{
+	return pud_leaf(pud) && pte_user_accessible_page(pud_pte(pud), addr);
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 7d6b9e5b286e..a8bc4f24beb1 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -243,6 +243,11 @@ static inline bool pte_access_permitted(pte_t pte, bool write)
 	return true;
 }
 
+static inline bool pte_user_accessible_page(pte_t pte, unsigned long addr)
+{
+	return pte_present(pte) && !is_kernel_addr(addr);
+}
+
 /* Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
  *
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 0f73a9ade0ed..d0938e9c33fb 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -223,6 +223,14 @@ static inline int pud_pfn(pud_t pud)
 }
 #endif
 
+#ifndef pmd_user_accessible_page
+#define pmd_user_accessible_page(pmd, addr)	false
+#endif
+
+#ifndef pud_user_accessible_page
+#define pud_user_accessible_page(pud, addr)	false
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_PGTABLE_H */
-- 
2.49.0


