Return-Path: <linux-kernel+bounces-724825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C6CAFF74D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98781C44388
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B7827FD68;
	Thu, 10 Jul 2025 03:06:06 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA8A2236F4
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116766; cv=none; b=Q2I2LY+O0GIWAvVfj71JmtVWL3g4yPtFHeOMoHHvJYTBZXt3Ou/hmTze8qqXgtrsd7EIas9PyFwOJVQN8CT9acHLZhatqKi4fypgZCSc0FhO/UIhli/zMqiQaUyzCQl2jnuJ5T5Y9WurGtIoM7b8yBJFf/Xz9yWKyZDsJrL8Wac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116766; c=relaxed/simple;
	bh=lo3MqqF3M7w1CyAce5AiwGGnPxEhGES/StfeFjAZlTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sDXKgYXdWCoCoCHZ9PTVqVec7Grg2HSyOmI7jBtPu6AVGH6rrWf7l/kvgePtb4NPyHuAnutRbYKkUCbhaknAC/t1on1KjQeOT1IIAzP2WI4gfaAdLg5fnf5zcQovpKVSRx7O26M62fbpiSgF3b4fKLJCVtMQuuLF5np0r2GIxBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cb34ea685d3a11f0b29709d653e92f7d-20250710
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR
	SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:69531f57-c1ce-4aaa-b9a5-ee61f1d6e198,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.1.45,REQID:69531f57-c1ce-4aaa-b9a5-ee61f1d6e198,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:6493067,CLOUDID:00147462416a962fe54cbe135c4aee57,BulkI
	D:2507101034486T1R7010,BulkQuantity:1,Recheck:0,SF:19|24|44|66|72|78|102,T
	C:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: cb34ea685d3a11f0b29709d653e92f7d-20250710
X-User: lihongtao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <lihongtao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 3746967; Thu, 10 Jul 2025 11:05:54 +0800
From: lihongtao <lihongtao@kylinos.cn>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lihongtao <lihongtao@kylinos.cn>
Subject: [PATCH] drm/panfrost: Fix leak when free gem object
Date: Thu, 10 Jul 2025 11:05:27 +0800
Message-Id: <20250710030527.167710-1-lihongtao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

obj->mappings.lock should be destroyed when free
panfrost gem object in panfrost_gem_free_object.

Signed-off-by: lihongtao <lihongtao@kylinos.cn>
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 963f04ba2de6..00549f482eec 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -49,6 +49,7 @@ static void panfrost_gem_free_object(struct drm_gem_object *obj)
 		kvfree(bo->sgts);
 	}
 
+	mutex_destroy(&bo->mappings.lock);
 	drm_gem_shmem_free(&bo->base);
 }
 
-- 
2.25.1


