Return-Path: <linux-kernel+bounces-807418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0AEB4A427
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD59167C62
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7903E239E80;
	Tue,  9 Sep 2025 07:48:42 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EBB1D5CE8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404122; cv=none; b=tES3tECGOTXnz+IEZVg6oVH1MTH79NH7NcU/8fMNfuc8NtxAaoPIKGaLZeoSg3iAQBWQagAsZE6jPRMY6kJiz/5WIrpO3AumCbsYOkyAglwNqUNdy+CMPs1xvX+a0V0j54BShK7cWL/VbfcFdkfC2aQTn1avmU1ZNwx/09IUIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404122; c=relaxed/simple;
	bh=0TvMik+92sFdyhvEcEaf+VARkKvs2ijz/U0CNzz/MDg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KBVAoIQTZZHgY3Ugnx9k+K1t4hOD2BEinw+w42qFAwFu6gaeFwfaH4zo8+0/uWtBXLwIwvhJzYcYLdRzJ1qeVF0jo3eBWdDcdhhuqvkh204q5WoXunm3geJQalJjmRc0ba8R2HXLoIZ7ufCbS+qCcRkF989ZKAT6gUp8fvVCyC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 603b27588d5111f0b29709d653e92f7d-20250909
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c9d64b59-8547-4850-8971-4da55c312d9f,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.1.45,REQID:c9d64b59-8547-4850-8971-4da55c312d9f,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:6493067,CLOUDID:de6a38db08b61df599d118a345fe75fa,BulkI
	D:250909154831ZXY1HHMU,BulkQuantity:0,Recheck:0,SF:19|24|38|44|66|72|78|10
	2|850,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 603b27588d5111f0b29709d653e92f7d-20250909
X-User: husong@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <husong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1128407; Tue, 09 Sep 2025 15:48:29 +0800
From: Hu Song <husong@kylinos.cn>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Hu Song <husong@kylinos.cn>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slub: Use folio_nr_pages() in __free_slab()
Date: Tue,  9 Sep 2025 15:48:11 +0800
Message-Id: <20250909074812.599030-1-husong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use folio_nr_pages() helper instead of manual calculation (1 << order)
for better code readability and maintainability.

Signed-off-by: Hu Song <husong@kylinos.cn>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index d257141896c9..eba25461641a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2719,7 +2719,7 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
 {
 	struct folio *folio = slab_folio(slab);
 	int order = folio_order(folio);
-	int pages = 1 << order;
+	int pages = folio_nr_pages(folio);
 
 	__slab_clear_pfmemalloc(slab);
 	folio->mapping = NULL;
-- 
2.25.1


