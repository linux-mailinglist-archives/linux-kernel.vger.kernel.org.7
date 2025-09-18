Return-Path: <linux-kernel+bounces-821955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E37B82B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0E31C07975
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDA81F4C8C;
	Thu, 18 Sep 2025 02:54:17 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712461FC8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758164056; cv=none; b=ddIRzxbWA2FJIc5r4+z9O688TdFDTqNA/29Tk6J/AqyXLn5A9wLZhJgojjFcg1ONk9LV8oKucTDD6gsYHTy5bsMOJ2wp7WwSmNPJU9K9kODU+8j3rA736lZBJDuheKQPipk+537PEcIcdRzsMg9Iu9hpH12YVvXH3rklh/VngfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758164056; c=relaxed/simple;
	bh=QkOL4suBpq4PAJSYK9VM9hPUZZxATsvcDrJ34c66IZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pH4VSjgJWzV/N0dYkM7tgqcaLO3sP8eKcaIiqKT5rqPOP3bRt3L9gji8/42HytWrT34rnWVAjtFvKGTvJ6wShvdBLMyJztBiBZzqa5tpBVAy9R0YHS0kC1j2Q0BzRt7hG89UYZ9VZxkRE1dtpbbLSh7dYw6q+WoHtB2j0CcWNkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: becf2b94943a11f0b29709d653e92f7d-20250918
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:bde16297-68d7-40b3-aa49-15e12cfd95e3,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:54eb46c3ea35f8edffaa8d20cd76c0ca,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:5,IP:nil
	,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: becf2b94943a11f0b29709d653e92f7d-20250918
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1594707725; Thu, 18 Sep 2025 10:54:07 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] platform: Use IOMEM_ERR_PTR for ioremap error returns
Date: Thu, 18 Sep 2025 10:54:02 +0800
Message-Id: <320f2cc9ada5cb66845daa6bf259000b4cffd8b3.1758163939.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace ERR_PTR() with IOMEM_ERR_PTR() in stubbed ioremap functions to
maintain type consistency. The functions return void __iomem * pointers
and IOMEM_ERR_PTR() provides proper type casting to avoid sparse warnings.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509060307.JubgnLhc-lkp@intel.com/
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 include/linux/platform_device.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 074754c23d33..1d424fed1435 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -80,7 +80,7 @@ static inline void __iomem *
 devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
 				unsigned int index, struct resource **res)
 {
-	return ERR_PTR(-EINVAL);
+	return IOMEM_ERR_PTR(-EINVAL);
 }
 
 
@@ -88,14 +88,14 @@ static inline void __iomem *
 devm_platform_ioremap_resource(struct platform_device *pdev,
 			       unsigned int index)
 {
-	return ERR_PTR(-EINVAL);
+	return IOMEM_ERR_PTR(-EINVAL);
 }
 
 static inline void __iomem *
 devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 				      const char *name)
 {
-	return ERR_PTR(-EINVAL);
+	return IOMEM_ERR_PTR(-EINVAL);
 }
 
 #endif
-- 
2.25.1


