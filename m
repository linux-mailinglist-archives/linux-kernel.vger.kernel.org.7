Return-Path: <linux-kernel+bounces-818329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FC3B58FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B447AACC5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C90A28642E;
	Tue, 16 Sep 2025 08:06:33 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5522D286433
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009993; cv=none; b=PiYv74bLxM/1AzlH2d+tVx0ylZgm2jgZqOwggsPE7afN6HkTFeIEx92pjMHMpOcOXidGv+7FdRNua9F9/fqrgFtVsYolg856kVkShtYevVyVQ21FNgno1adlpQciE4XuIjZQP5h/DyE+gdLmUUKKgqqTVPLkgBHwi1lZwCYMj7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009993; c=relaxed/simple;
	bh=aSLg8XH1Qp0MXlYuL6nIZUfWNWCsHbeN6xlzXnZf3h8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RF7ykWetwiW4XZrxTmNny4zsxTnAFy8+aV3ibh0WEo9Kn4XHnZXF+T1t+dwLhUiipAEEcU1w8M4yl7z2OM/JZ5nybnHXjMiYDQuhums5y+RdZwWyV0kB1orYtyx5GIhmr2eMj2vE4je821jDJ+9QGxM8XPajmHVuMtRP8Ag+PuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 04c7b0de92d411f0b29709d653e92f7d-20250916
X-CID-CACHE: Type:Local,Time:202509161557+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:525affbb-c15c-42ed-a3bb-ed388d6ce25d,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:dd8cac28ab574c40f89e524f978907ea,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 04c7b0de92d411f0b29709d653e92f7d-20250916
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xialonglong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1339358385; Tue, 16 Sep 2025 16:06:15 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id A5CBF160042A0;
	Tue, 16 Sep 2025 16:06:15 +0800 (CST)
X-ns-mid: postfix-68C91A77-166109859
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node4.com.cn (NSMail) with ESMTPA id 3C10C1600429F;
	Tue, 16 Sep 2025 08:06:13 +0000 (UTC)
From: Longlong Xia <xialonglong@kylinos.cn>
To: akpm@linux-foundation.org,
	david@redhat.com
Cc: xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Longlong Xia <xialonglong@kylinos.cn>
Subject: [PATCH 1/1] mm/ksm: remove page_stable_node() and use folio_stable_node() directly
Date: Tue, 16 Sep 2025 16:05:33 +0800
Message-ID: <20250916080533.2385624-1-xialonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The page_stable_node() function was a trivial wrapper around
folio_stable_node() that had only one call site. Remove this
unnecessary helper and call folio_stable_node(page_folio(page))
directly at that site.There is no functional change.

Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
 mm/ksm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 160787bb121c..eab5348d19a7 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1061,11 +1061,6 @@ struct ksm_stable_node *folio_stable_node(const st=
ruct folio *folio)
 	return folio_test_ksm(folio) ? folio_raw_mapping(folio) : NULL;
 }
=20
-static inline struct ksm_stable_node *page_stable_node(struct page *page=
)
-{
-	return folio_stable_node(page_folio(page));
-}
-
 static inline void folio_set_stable_node(struct folio *folio,
 					 struct ksm_stable_node *stable_node)
 {
@@ -2233,7 +2228,7 @@ static void cmp_and_merge_page(struct page *page, s=
truct ksm_rmap_item *rmap_ite
 	int err;
 	bool max_page_sharing_bypass =3D false;
=20
-	stable_node =3D page_stable_node(page);
+	stable_node =3D folio_stable_node(page_folio(page));
 	if (stable_node) {
 		if (stable_node->head !=3D &migrate_nodes &&
 		    get_kpfn_nid(READ_ONCE(stable_node->kpfn)) !=3D
--=20
2.43.0


