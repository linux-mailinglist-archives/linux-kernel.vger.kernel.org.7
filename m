Return-Path: <linux-kernel+bounces-759105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DFDB1D887
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB9B189C4BF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AD8257AC6;
	Thu,  7 Aug 2025 13:05:33 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28FB23816E;
	Thu,  7 Aug 2025 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754571933; cv=none; b=Mqm1VaNzbiyapxi44iH1m8ncdUFbKSJCeK/WFpmq5+vGrjYB25Kn27sK1muHOf1iYi87NtrTZ0YNfqidi5k+Y2JLzn/FUueyAR9qyyIaJIB4uQqdNfcJ0G/+CeaT/LJkg6DBgGKiYI06dnSjs4MkzZHtBErTqGWwxR86tRiAybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754571933; c=relaxed/simple;
	bh=wFXb5lAQXTDrmzUC6XfMd0dRpKtnEjFNW4RV0ePxg8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fP2UcuDW4KREU5Ey/PI4oWTn1J/FC09MPNVGsfB+TTMj74pex9+IvDID9IzNdG5pxTR44JjcCJftQHlfCESbL61lfknSfHIejA8vWTLERY5pUMVuiVH5zH6uGyXOlejSbveDmY7ewN81suPfZOjiLvO0lOXCgD9Guj80As//Xr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2d8da2ee738f11f0b29709d653e92f7d-20250807
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_QP
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:7e20fc9a-254b-4258-9f29-81d1d9c5fa59,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:7e20fc9a-254b-4258-9f29-81d1d9c5fa59,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:c2842ccf03033012f8abbe80433b3499,BulkI
	D:2508072055154RQQU8EA,BulkQuantity:1,Recheck:0,SF:19|24|44|66|72|78|81|82
	|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 2d8da2ee738f11f0b29709d653e92f7d-20250807
X-User: liuqiqi@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <liuqiqi@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1725618865; Thu, 07 Aug 2025 21:05:23 +0800
From: liuqiqi@kylinos.cn
To: gregkh@linuxfoundation.org
Cc: cve@kernel.org,
	linux-cve-announce@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuqiqi <liuqiqi@kylinos.cn>
Subject: CVE-2024-57884  patch review feedback (https://lore.kernel.org/linux-cve-announce/2025011510-CVE-2024-57884-4cf8@gregkh/#R)
Date: Thu,  7 Aug 2025 21:05:15 +0800
Message-Id: <20250807130515.1445117-1-liuqiqi@kylinos.cn>
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

CVE-2024-57884  patch fixes  mm: vmscan: account for free pages to prevent =
infinite Loop in throttle_direct_reclaim() modify as follows=0D
@@ -342,7 +342,14 @@ unsigned long zone_reclaimable_pages(struct zone *zone=
)=0D
 	if (get_nr_swap_pages() > 0)=0D
 		nr +=3D zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +=0D
 			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);=0D
-=0D
+	/*=0D
+	 * If there are no reclaimable file-backed or anonymous pages,=0D
+	 * ensure zones with sufficient free pages are not skipped.=0D
+	 * This prevents zones like DMA32 from being ignored in reclaim=0D
+	 * scenarios where they can still help alleviate memory pressure.=0D
+	 */=0D
+	if (nr =3D=3D 0)=0D
+		nr =3D zone_page_state_snapshot(zone, NR_FREE_PAGES);=0D
 	return nr;=0D
 }=0D
However, should_reclaim_retry() function calls zone_reclaimable_pages to co=
unt free pages. When nr is 0, it double-counts NR_FREE_PAGES. This seems to=
 cause inaccurate page statistics, right?=0D
static inline bool=0D
should_reclaim_retry(gfp_t gfp_mask, unsigned order,=0D
		     struct alloc_context *ac, int alloc_flags,=0D
		     bool did_some_progress, int *no_progress_loops)=0D
{=0D
......=0D
=0D
		available =3D reclaimable =3D zone_reclaimable_pages(zone);=0D
		available +=3D zone_page_state_snapshot(zone, NR_FREE_PAGES);=0D
=0D
		/*=0D
		 * Would the allocation succeed if we reclaimed all=0D
		 * reclaimable pages?=0D
		 */=0D
		wmark =3D __zone_watermark_ok(zone, order, min_wmark,=0D
				ac->highest_zoneidx, alloc_flags, available);=0D
=0D
compaction_zonelist_suitable() function has the same problem.=0D
bool compaction_zonelist_suitable(struct alloc_context *ac, int order,=0D
		int alloc_flags)=0D
{=0D
......=0D
		available =3D zone_reclaimable_pages(zone) / order;=0D
		available +=3D zone_page_state_snapshot(zone, NR_FREE_PAGES);=0D
		if (__compaction_suitable(zone, order, min_wmark_pages(zone),=0D
					  ac->highest_zoneidx, available))=0D
=0D
If this is problematic, can it be modified as follows:=0D
diff --git a/mm/vmscan.c b/mm/vmscan.c=0D
--- a/mm/vmscan.c=0D
+++ b/mm/vmscan.c=0D
@@ -6417,7 +6417,7 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)=0D
                return true;=0D
 =0D
        for_each_managed_zone_pgdat(zone, pgdat, i, ZONE_NORMAL) {=0D
-               if (!zone_reclaimable_pages(zone))=0D
+               if (!zone_reclaimable_pages(zone) || !(zone_page_state_snap=
shot(zone, NR_FREE_PAGES)))=0D
                        continue;=0D
=0D
Signed-off-by: liuqiqi <liuqiqi@kylinos.cn>=0D

