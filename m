Return-Path: <linux-kernel+bounces-789542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ADBB39710
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860B93B0225
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971052DEA7B;
	Thu, 28 Aug 2025 08:33:44 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9812D7801
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370024; cv=none; b=grvuRSkH62PDpmYcI4v3Wo2n/zWzRpe//D67V62R6tXVK4XeB1mPZn24vfqZIh5fED12wo8b6PPX+FGNHE4MkBzt2A/xdIltmab6nvyj6wx+nKRJs3LDOzvH29fMGFRyFjtVrJAD0lkWjTyaXSexth2X8BVeRure7CGg+8LylJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370024; c=relaxed/simple;
	bh=TnIt2UUbf6chkHr/n4NxkJT+mOsIrHHSY0GyJLIdbk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hZmDsOnxgxR63R+gGksPEqiaJID+oF8k0uViTSDQ6sx1cMDRzyRjvRZcdyZbBadRfAcSuWPAxljBMO8HSSyljzT+7yMZDk6i8bfZB2r94SHyTjOkf0ccih3g/dObRwWyyPqyYiRanuADISbgKH9WmY0aqwxXNsFW2qm/cjFGnrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a7e4876e83e911f0b29709d653e92f7d-20250828
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR
	SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:37059b13-93ad-469e-b21a-39ca1299dcbe,IP:10,
	URL:0,TC:0,Content:0,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-20
X-CID-INFO: VERSION:1.1.45,REQID:37059b13-93ad-469e-b21a-39ca1299dcbe,IP:10,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-20
X-CID-META: VersionHash:6493067,CLOUDID:7982bef487c24e9de1a0c001ba5c3d46,BulkI
	D:250828163333U604VCAT,BulkQuantity:0,Recheck:0,SF:19|24|44|66|72|78|102|8
	50,TC:nil,Content:0|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: a7e4876e83e911f0b29709d653e92f7d-20250828
X-User: lihongfu@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lihongfu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1765091486; Thu, 28 Aug 2025 16:33:21 +0800
From: Hongfu Li <lihongfu@kylinos.cn>
To: aahringo@redhat.com,
	teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hongfu Li <lihongfu@kylinos.cn>
Subject: [PATCH] dlm: use KMEM_CACHE in dlm_memory_init
Date: Thu, 28 Aug 2025 16:32:35 +0800
Message-Id: <20250828083235.46347-1-lihongfu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using KMEM_CACHE() macro makes the code more concise and easy to read.

Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
 fs/dlm/memory.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/memory.c b/fs/dlm/memory.c
index 5c35cc67aca4..124b370d1571 100644
--- a/fs/dlm/memory.c
+++ b/fs/dlm/memory.c
@@ -34,8 +34,7 @@ int __init dlm_memory_init(void)
 	if (!mhandle_cache)
 		goto mhandle;
 
-	lkb_cache = kmem_cache_create("dlm_lkb", sizeof(struct dlm_lkb),
-				__alignof__(struct dlm_lkb), 0, NULL);
+	lkb_cache = KMEM_CACHE(dlm_lkb, 0);
 	if (!lkb_cache)
 		goto lkb;
 
@@ -43,8 +42,7 @@ int __init dlm_memory_init(void)
 	if (!msg_cache)
 		goto msg;
 
-	rsb_cache = kmem_cache_create("dlm_rsb", sizeof(struct dlm_rsb),
-				__alignof__(struct dlm_rsb), 0, NULL);
+	rsb_cache = KMEM_CACHE(dlm_rsb, 0);
 	if (!rsb_cache)
 		goto rsb;
 
-- 
2.25.1


