Return-Path: <linux-kernel+bounces-846555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B678BC8561
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 230434EACF1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2F52D5A07;
	Thu,  9 Oct 2025 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HepAyTOc"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7C01862A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760002650; cv=none; b=kcWO7KB8Ey4++WjqyfDetwzzOdAROFRpQG58LbazIMGaVc80tpX9RPipsvtBFdS7LINq/G/BvJ/KIcbSEU0PCEkGSb3g3Mlju9V8yX2Bi0YT5GQVDpiV/YdyPQT23lgA98F355IKG2UdfOEpdHF9y6kkBFQY2ObNnKucv09LmwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760002650; c=relaxed/simple;
	bh=CRwaB/Rj3/NJ++9ici1EaZR/vj92uUtAvUWYLh3o+wE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qh3BLGAnZkvvHS8NB3uIkoJOxlUXrChcbXm4U8KcCc8Yr/drgvkVRHrg8JTJOjU3fi82t8YOK78l/GTr1i01MIXOPj1s1q/cKips/KFmRSrPPbngFOaCmcVvusknqZxnMM2i5x9siAzcVRpsM3Y1XpBygWfA/sX6CZ+T2PfgL+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HepAyTOc; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760002643; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=h1VdD661PFCksQ/jZehnN/o3cope4Mou/GGCneQlrGM=;
	b=HepAyTOcmmTLP5WlSpbHE5IuLUeiciSTWbn4jgNOptmVcPh0Fi+zqFvWnwCV8Phs84JejVC8UXkd7hvBo7Pmnkyp0u37di5UO3+nIbD/k0RX9mUG0K+e6yyLp5slP2tasyqwtZjf52TOyoiv9daSbWVA3HBgV6mx9I3bPy9fjBo=
Received: from L-G4162440-1116.localdomain(mailfrom:yadong.qi@linux.alibaba.com fp:SMTPD_---0WplFjgI_1760002641 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Oct 2025 17:37:23 +0800
From: Yadong Qi <yadong.qi@linux.alibaba.com>
To: akpm@linux-foundation.org,
	urezki@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ying.huang@linux.alibaba.com
Cc: Yadong Qi <yadong.qi@linux.alibaba.com>
Subject: [PATCH v3] mm: vmalloc: WARN_ON if mapping size is not PAGE_SIZE aligned
Date: Thu,  9 Oct 2025 17:37:06 +0800
Message-Id: <20251009093707.868-1-yadong.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mm/vmalloc.c, the function vmap_pte_range() assumes that the
mapping size is aligned to PAGE_SIZE. If this assumption is
violated, the loop will become infinite because the termination
condition (`addr != end`) will never be met. This can lead to
overwriting other VA ranges and/or random pages physically follow
the page table.

It's the caller's responsibility to ensure that the mapping size
is aligned to PAGE_SIZE. However, the memory corruption is hard
to root cause. To identify the programming error in the caller
easier, check whether the mapping size is PAGE_SIZE aligned with
WARN_ON().

Signed-off-by: Yadong Qi <yadong.qi@linux.alibaba.com>
Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
---
v2 -> v3:
  * change error code from ENOMEM to EINVAL
  * modify callers of vmap_pte_range to handle return code
v1 -> v2:
  * Use WARN_ON instead of BUG_ON
---
 mm/vmalloc.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5edd536ba9d2..1fa52f203795 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -100,6 +100,9 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	struct page *page;
 	unsigned long size = PAGE_SIZE;
 
+	if (WARN_ON(!PAGE_ALIGNED(end - addr)))
+		return -EINVAL;
+
 	pfn = phys_addr >> PAGE_SHIFT;
 	pte = pte_alloc_kernel_track(pmd, addr, mask);
 	if (!pte)
@@ -167,6 +170,7 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 {
 	pmd_t *pmd;
 	unsigned long next;
+	int err;
 
 	pmd = pmd_alloc_track(&init_mm, pud, addr, mask);
 	if (!pmd)
@@ -180,10 +184,11 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 			continue;
 		}
 
-		if (vmap_pte_range(pmd, addr, next, phys_addr, prot, max_page_shift, mask))
-			return -ENOMEM;
+		err = vmap_pte_range(pmd, addr, next, phys_addr, prot, max_page_shift, mask);
+		if (err)
+			break;
 	} while (pmd++, phys_addr += (next - addr), addr = next, addr != end);
-	return 0;
+	return err;
 }
 
 static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned long end,
@@ -217,6 +222,7 @@ static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 {
 	pud_t *pud;
 	unsigned long next;
+	int err;
 
 	pud = pud_alloc_track(&init_mm, p4d, addr, mask);
 	if (!pud)
@@ -230,11 +236,11 @@ static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 			continue;
 		}
 
-		if (vmap_pmd_range(pud, addr, next, phys_addr, prot,
-					max_page_shift, mask))
-			return -ENOMEM;
+		err = vmap_pmd_range(pud, addr, next, phys_addr, prot, max_page_shift, mask);
+		if (err)
+			break;
 	} while (pud++, phys_addr += (next - addr), addr = next, addr != end);
-	return 0;
+	return err;
 }
 
 static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned long end,
@@ -268,6 +274,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 {
 	p4d_t *p4d;
 	unsigned long next;
+	int err;
 
 	p4d = p4d_alloc_track(&init_mm, pgd, addr, mask);
 	if (!p4d)
@@ -281,11 +288,11 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 			continue;
 		}
 
-		if (vmap_pud_range(p4d, addr, next, phys_addr, prot,
-					max_page_shift, mask))
-			return -ENOMEM;
+		err = vmap_pud_range(p4d, addr, next, phys_addr, prot, max_page_shift, mask);
+		if (err)
+			break;
 	} while (p4d++, phys_addr += (next - addr), addr = next, addr != end);
-	return 0;
+	return err;
 }
 
 static int vmap_range_noflush(unsigned long addr, unsigned long end,
-- 
2.43.5


