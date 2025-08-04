Return-Path: <linux-kernel+bounces-755124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB31CB1A18E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EA03A75F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6C525B1C4;
	Mon,  4 Aug 2025 12:39:46 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2D825A354
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311185; cv=none; b=F4Iqo/QMPA8Y11EIgMRGI5BVOsR3eQucv24k5aIH8wAvakbCVRcq2/kxzXUT6hcLquyLjyGeDb5isa+hGedx7TncLkDhZs6GEOnXqACgfrzUah7B6b+bB4yF6EFIqruxc51wXz8bjP5QSY0RIQ2ZuOJjccO+6KWM++08HfsFa7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311185; c=relaxed/simple;
	bh=diHt/HwJkW+Tolx+PfVqw2Psml19FkN0p9a97jtCMxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pM3EDWgpjIuOYR8ES/5r1KZ5u5BC6gu1cn4RF91WiRNFHWg4xAwSzg2X7YkmXxDaazjOpDEgmXOWoOho+eYglg8Ydq8LOSYOeh+Q1trnLtzWvYc/WKE1W4alUZ1eHdwYW/fB+3amC8LhUvhMFoGNt2dpm7xYj/5IF7ToCeY1Fj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1313378c713011f0b29709d653e92f7d-20250804
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:cde1d874-73fe-4e09-b3f8-ce7c60d1ae2a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:cde1d874-73fe-4e09-b3f8-ce7c60d1ae2a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:468911c6df3b77ec9f02fa5e36d336c3,BulkI
	D:250804194720VBS1UNX1,BulkQuantity:1,Recheck:0,SF:19|24|38|44|66|72|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 1313378c713011f0b29709d653e92f7d-20250804
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1288974341; Mon, 04 Aug 2025 20:39:34 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id A82B5E008FB3;
	Mon,  4 Aug 2025 20:39:28 +0800 (CST)
X-ns-mid: postfix-6890AA00-5248871
Received: from localhost.localdomain (unknown [10.42.12.14])
	by mail.kylinos.cn (NSMail) with ESMTPA id A6631E008FAC;
	Mon,  4 Aug 2025 20:39:26 +0800 (CST)
From: Li Qiang <liqiang01@kylinos.cn>
To: akpm@linux-foundation.org,
	david@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	Li Qiang <liqiang01@kylinos.cn>
Subject: [PATCH] mm: memory: Force-inline PTE/PMD zapping functions for performance
Date: Mon,  4 Aug 2025 20:39:23 +0800
Message-Id: <20250804123923.296230-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This change converts several critical page table zapping functions from
`inline` to `__always_inline`, resulting in measurable performance
improvements in process spawning workloads.

Performance Impact (Intel Xeon Gold 6430 2.1GHz):
- UnixBench 'context1' test shows ~6% improvement (single-core)
- UnixBench  shows ~0.6% improvement (single-core)
- mm/memory.o size reduced by 2.49% (70190 -> 68445 bytes)
- Net code reduction of 1745 bytes (add/remove: 211/166)

The modified functions form a hot path during process teardown:
1. zap_present_ptes()
2. do_zap_pte_range()
3. zap_pte_range()
4. zap_pmd_range()

Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 mm/memory.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b0cda5aab398..281a353fae7b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1543,7 +1543,7 @@ static __always_inline void zap_present_folio_ptes(=
struct mmu_gather *tlb,
  *
  * Returns the number of processed (skipped or zapped) PTEs (at least 1)=
.
  */
-static inline int zap_present_ptes(struct mmu_gather *tlb,
+static __always_inline int zap_present_ptes(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, pte_t *pte, pte_t ptent,
 		unsigned int max_nr, unsigned long addr,
 		struct zap_details *details, int *rss, bool *force_flush,
@@ -1662,7 +1662,7 @@ static inline int zap_nonpresent_ptes(struct mmu_ga=
ther *tlb,
 	return nr;
 }
=20
-static inline int do_zap_pte_range(struct mmu_gather *tlb,
+static __always_inline int do_zap_pte_range(struct mmu_gather *tlb,
 				   struct vm_area_struct *vma, pte_t *pte,
 				   unsigned long addr, unsigned long end,
 				   struct zap_details *details, int *rss,
@@ -1698,7 +1698,7 @@ static inline int do_zap_pte_range(struct mmu_gathe=
r *tlb,
 	return nr;
 }
=20
-static unsigned long zap_pte_range(struct mmu_gather *tlb,
+static __always_inline unsigned long zap_pte_range(struct mmu_gather *tl=
b,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				struct zap_details *details)
@@ -1790,7 +1790,7 @@ static unsigned long zap_pte_range(struct mmu_gathe=
r *tlb,
 	return addr;
 }
=20
-static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
+static __always_inline unsigned long zap_pmd_range(struct mmu_gather *tl=
b,
 				struct vm_area_struct *vma, pud_t *pud,
 				unsigned long addr, unsigned long end,
 				struct zap_details *details)
@@ -1832,7 +1832,7 @@ static inline unsigned long zap_pmd_range(struct mm=
u_gather *tlb,
 	return addr;
 }
=20
-static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
+static __always_inline unsigned long zap_pud_range(struct mmu_gather *tl=
b,
 				struct vm_area_struct *vma, p4d_t *p4d,
 				unsigned long addr, unsigned long end,
 				struct zap_details *details)
@@ -1861,7 +1861,7 @@ static inline unsigned long zap_pud_range(struct mm=
u_gather *tlb,
 	return addr;
 }
=20
-static inline unsigned long zap_p4d_range(struct mmu_gather *tlb,
+static __always_inline unsigned long zap_p4d_range(struct mmu_gather *tl=
b,
 				struct vm_area_struct *vma, pgd_t *pgd,
 				unsigned long addr, unsigned long end,
 				struct zap_details *details)
--=20
2.25.1


