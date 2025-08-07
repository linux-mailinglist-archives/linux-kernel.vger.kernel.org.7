Return-Path: <linux-kernel+bounces-759093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB41B1D853
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9581AA3138
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76DB2550DD;
	Thu,  7 Aug 2025 12:55:25 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971C32561AE;
	Thu,  7 Aug 2025 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754571325; cv=none; b=gqKdK7a6uB7G4WK7JsGGF+/JppfXNOBFfEw5CSu/OVPxnxB9m0ehwddCeH//Y6P7NZwuP9kpshxxHIaxPax60a5JhICBt7a04vs6cukDAkqtoHPSwMAYz8Zfa21oXPFrYFJWnFhJwcHeQTPvq/jQPnyEgIdCSUlIMCYDTEsE/u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754571325; c=relaxed/simple;
	bh=tEOw5Zi+9INvNCevJdYGwLRHGO0A2GgFwCMszJ2V1Yo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h+tiZpow35FkVxhk5uqsNvKWrg3SUyt2RXXHe7zIY8d/8HFmZl5KKL2wbOEyiBwJHruMg/iT0CwvHgeY6RIkLLt6evjgDk2AHd/CPEcRexvQFn1OzZa8t7rlFMGqjaP/ctArlRWdAp/4dRsnE3GsFdgcbmESkHa4GUkda9/LQTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c1426ea4738d11f0b29709d653e92f7d-20250807
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
X-CID-O-INFO: VERSION:1.1.45,REQID:082bdb2d-9253-41c3-b790-d86eec6e4e4b,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:082bdb2d-9253-41c3-b790-d86eec6e4e4b,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:209cab4319257c0126b15a31a766151b,BulkI
	D:2508072055154RQQU8EA,BulkQuantity:0,Recheck:0,SF:19|24|44|66|72|78|81|82
	|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: c1426ea4738d11f0b29709d653e92f7d-20250807
X-User: liuqiqi@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <liuqiqi@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1771552369; Thu, 07 Aug 2025 20:55:11 +0800
From: liuqiqi@kylinos.cn
To: gregkh@linuxfoundation.org
Cc: cve@kernel.org,
	linux-cve-announce@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuqiqi <liuqiqi@kylinos.cn>
Subject: CVE-2024-57884  patch review feedback (https://lore.kernel.org/linux-cve-announce/2025011510-CVE-2024-57884-4cf8@gregkh/#R)
Date: Thu,  7 Aug 2025 20:54:13 +0800
Message-Id: <20250807125413.1443050-1-liuqiqi@kylinos.cn>
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

		if (cpusets_enabled() &&=0D
			(alloc_flags & ALLOC_CPUSET) &&=0D
			!__cpuset_zone_allowed(zone, gfp_mask))=0D
				continue;=0D
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
	struct zone *zone;=0D
	struct zoneref *z;=0D
=0D
	/*=0D
	 * Make sure at least one zone would pass __compaction_suitable if we cont=
inue=0D
	 * retrying the reclaim.=0D
	 */=0D
	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,=0D
				ac->highest_zoneidx, ac->nodemask) {=0D
		unsigned long available;=0D
=0D
		/*=0D
		 * Do not consider all the reclaimable memory because we do not=0D
		 * want to trash just for a single high order allocation which=0D
		 * is even not guaranteed to appear even if __compaction_suitable=0D
		 * is happy about the watermark check.=0D
		 */=0D
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

