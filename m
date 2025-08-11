Return-Path: <linux-kernel+bounces-762296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71081B20493
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A053A2047
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496851FF1B2;
	Mon, 11 Aug 2025 09:53:48 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33002191493;
	Mon, 11 Aug 2025 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906027; cv=none; b=ZA7Hr5S7ISVWUlbRplfKqluYr4w8tMBjjtcYOi+k3pRpYJnza5vajZgdvLrsPB/GSUgYV7YgJ98BqG3j9mBRcIMPsmFjBHwfX+mNmGK3NReq36VOyihu7h79+OXDytYWYYCY4qgSYhzelmBTc+WDTirN8iSmNia6cHSL8bALZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906027; c=relaxed/simple;
	bh=iFrdu35/R/MaVSfCUzqjyElDZoQza0RbyOa+1qTuIXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k6kEGv7YVTGI5xYtcPj3SUCBCFrVzQ4V1SHwEHmnByD/P9I1p6K2AQSp+KwUdHGhNjnyuD7hSV6SpwtjXmMC/HQqQqL9IeZ/l17G8HlvN0k9ECTpHiuj+2lIoLAuuiI1ZqrrDQzVa9vJznvpcH5HLncIARq24xnbxQZwzTabbEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0e1a4a9a769911f0b29709d653e92f7d-20250811
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_QP
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_LOWREP, SA_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:f97a9600-d617-4534-bcce-cbfa62f139da,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:f97a9600-d617-4534-bcce-cbfa62f139da,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:30ab249d94d8a4dff4a8db77771f4b17,BulkI
	D:250811175340AC2T3V49,BulkQuantity:0,Recheck:0,SF:19|24|44|66|72|78|81|82
	|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 0e1a4a9a769911f0b29709d653e92f7d-20250811
X-User: liuqiqi@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <liuqiqi@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1987749795; Mon, 11 Aug 2025 17:53:38 +0800
From: liuqiqi@kylinos.cn
To: gregkh@linuxfoundation.org
Cc: cve@kernel.org,
	linux-cve-announce@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuqiqi <liuqiqi@kylinos.cn>
Subject: mm:fix duplicate accounting of free pages in should_reclaim_retry()
Date: Mon, 11 Aug 2025 17:53:30 +0800
Message-Id: <20250811095330.1573939-1-liuqiqi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025011510-CVE-2024-57884-4cf8@gregkh>
References: <2025011510-CVE-2024-57884-4cf8@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the zone_reclaimable_pages() function, if the page counts for NR_ZONE_IN=
ACTIVE_FILE, =0D
NR_ZONE_ACTIVE_FILE, NR_ZONE_INACTIVE_ANON, and NR_ZONE_ACTIVE_ANON are all=
 zero, =0D
the function returns the number of free pages as the result.=0D
=0D
In this case, when should_reclaim_retry() calculates reclaimable pages, =0D
it will inadvertently double-count the free pages in its accounting.=0D
=0D
diff --git a/mm/vmscan.c b/mm/vmscan.c=0D
index 34410d24dc15..a9aaefdba7a2 100644=0D
--- a/mm/vmscan.c=0D
+++ b/mm/vmscan.c=0D
@@ -393,14 +393,7 @@ unsigned long zone_reclaimable_pages(struct zone *zone=
)=0D
        if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))=0D
                nr +=3D zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANO=
N) +=0D
                        zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON)=
;=0D
-       /*=0D
-        * If there are no reclaimable file-backed or anonymous pages,=0D
-        * ensure zones with sufficient free pages are not skipped.=0D
-        * This prevents zones like DMA32 from being ignored in reclaim=0D
-        * scenarios where they can still help alleviate memory pressure.=0D
-        */=0D
-       if (nr =3D=3D 0)=0D
-               nr =3D zone_page_state_snapshot(zone, NR_FREE_PAGES);=0D
+=0D
        return nr;=0D
 }=0D
 =0D
@@ -6417,7 +6410,7 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)=0D
                return true;=0D
 =0D
        for_each_managed_zone_pgdat(zone, pgdat, i, ZONE_NORMAL) {=0D
-               if (!zone_reclaimable_pages(zone))=0D
+               if (!zone_reclaimable_pages(zone) && zone_page_state_snapsh=
ot(zone, NR_FREE_PAGES))=0D
                        continue;=0D
 =0D
signed-off-by: liuqiqi <liuqiqi@kylinos.cn>=0D

