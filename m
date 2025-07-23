Return-Path: <linux-kernel+bounces-741908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE08B0EA88
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889AD1C278F3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182626B741;
	Wed, 23 Jul 2025 06:23:04 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CA318DB1C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251784; cv=none; b=HzfX7j7po8TDIXtlchcy5B9Tx1tw/O1aUwYYttQRqILpa0J7Qfle9gdGXdO23nAzI226JBUeI9loOYMaTDMbwggq+MBJRq8mcN8OVgNPjG/5Vwlg+lRm9+IQOiN8iLEIdafvl8rPfmO4Eq1JsQTvJbHoikFPcL3fseHMgEYhBvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251784; c=relaxed/simple;
	bh=IxMMDxf2uWSsOCzUgIh/WIzI3PvZ8pEJlMW/uMWbZsw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ICB6v8DOp3y9fdazfRONbFiPbD1uWKC29eVReFXyN3QToUwR+iDtZ0InVHqq86Vy3uyjI/EOj5moMVLjcW1e/vG8zF+hgcGiuFKWeudmZw6wHdHEH4ngkFInIk+CaxK0F8VXUuhsX4eozfloUvkBhBX1Dfc2gEIPsjWc/vDiTas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 729723b4678d11f0b29709d653e92f7d-20250723
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:31b4b0c0-d74b-46a4-b042-dfa836bce806,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:3ea1ebc595a8a98a68fe82727fa18d46,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 729723b4678d11f0b29709d653e92f7d-20250723
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1884763640; Wed, 23 Jul 2025 14:22:45 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: jens.wiklander@linaro.org,
	sumit.garg@kernel.org,
	balint.dobszay@arm.com,
	op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] tee: fix memory leak in tee_dyn_shm_alloc_helper
Date: Wed, 23 Jul 2025 14:22:41 +0800
Message-Id: <ae66122a86295f0ca5f2ff385ac2850360a805c1.1753251689.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When shm_register() fails in tee_dyn_shm_alloc_helper(), the pre-allocated
pages array is not freed, resulting in a memory leak.

Fixes: cf4441503e20 ("tee: optee: Move pool_op helper functions")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/tee/tee_shm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 915239b033f5..2a7d253d9c55 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -230,7 +230,7 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
 	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
 	if (!pages) {
 		rc = -ENOMEM;
-		goto err;
+		goto err_pages;
 	}
 
 	for (i = 0; i < nr_pages; i++)
@@ -243,11 +243,13 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
 		rc = shm_register(shm->ctx, shm, pages, nr_pages,
 				  (unsigned long)shm->kaddr);
 		if (rc)
-			goto err;
+			goto err_kfree;
 	}
 
 	return 0;
-err:
+err_kfree:
+	kfree(pages);
+err_pages:
 	free_pages_exact(shm->kaddr, shm->size);
 	shm->kaddr = NULL;
 	return rc;
-- 
2.25.1


