Return-Path: <linux-kernel+bounces-888226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC46C3A3B4
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C525A501F23
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8740128640B;
	Thu,  6 Nov 2025 10:20:20 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DDF2309B9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424420; cv=none; b=oi1lQpvsttwSUsp8Jf/GSK+Xo7NZ3qWd3VRepnHQ7D1DzHnnTpRS3S5u6OuOPAKYVefGYQoLlX8QS5tYLXZ04cAMqiqO/vTHPEVJbWYb6EBh6A/9zKHLNy1humgekLAlX7Cdr38CnFQjWeFalpotr8EgZyKfxR4OVA+2D93qzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424420; c=relaxed/simple;
	bh=nNL7Qvg+SuySg25YL2fUGd5cdMkLKkfIP7FBRI4krHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KnIS1V9IVkxwXinOKwvR3AD1x8pU5sRcgCZaK3+o870YokmyGzSO+xoa8sCBc08u8Hq/zW/idu3iYVkujWYvLFz/7qAlg1Ibe5sASX0ufzsWdLmXiUmMMvo+FWX8wu5HR6IHtcOzUk8tTUBpe9SIOIXXBHH1EOvRo+iQRlBfr+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2e1643c6bafa11f0a38c85956e01ac42-20251106
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:8ac0c484-78c8-42d5-a003-cdcf468be62e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:4e918cfdeedce2de0dbcf3a87f7a3545,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|15|50,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2e1643c6bafa11f0a38c85956e01ac42-20251106
X-User: yangzhao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yangzhao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1990498614; Thu, 06 Nov 2025 18:20:12 +0800
From: yangzhao <yangzhao@kylinos.cn>
To: op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	yangzhao <yangzhao@kylinos.cn>
Subject: [PATCH] tee: fix illegal pointer dereference in tee_shm_put()
Date: Thu,  6 Nov 2025 18:20:08 +0800
Message-Id: <20251106102008.1310234-1-yangzhao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tee_shm_put(), there is not only the NULL pointer dereference,
but also the illegal pointer dereference.

shutdown() --->
    __optee_disable_shm_cache -->
        shm = reg_pair_to_ptr(...);
        tee_shm_free(shm); -->
            tee_shm_put(shm); //crash: shm->ctx maybe NULL pointer or illegal pointer

Check whether the pointer is NULL and whether the pointer address is valid.

This issue occurs when rich world uses the 6.x version of the kernel and
optee secure world uses a lower version (such as version 3.2), and it is
highly likely to trigger a kernel panic when conducting hibernate tests.

Fixes: e4a718a3a47e ("tee: fix NULL pointer dereference in tee_shm_put")
Signed-off-by: yangzhao <yangzhao@kylinos.cn>
---
 drivers/tee/tee_shm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 4a47de4bb2e5..de01d16409c1 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -722,7 +722,14 @@ void tee_shm_put(struct tee_shm *shm)
 	struct tee_device *teedev;
 	bool do_release = false;
 
-	if (!shm || !shm->ctx || !shm->ctx->teedev)
+	/* checking pointer */
+	if (IS_ERR_OR_NULL(shm) || !virt_addr_valid(shm))
+		return;
+
+	if (IS_ERR_OR_NULL(shm->ctx) || !virt_addr_valid(shm->ctx))
+		return;
+
+	if (IS_ERR_OR_NULL(shm->ctx->teedev) || !virt_addr_valid(shm->ctx->teedev))
 		return;
 
 	teedev = shm->ctx->teedev;
-- 
2.25.1


