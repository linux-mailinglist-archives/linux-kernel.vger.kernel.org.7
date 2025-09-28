Return-Path: <linux-kernel+bounces-835326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E09BA6C1A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42F13A7F80
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D986C2BEC5E;
	Sun, 28 Sep 2025 08:53:48 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9D2220F29
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759049628; cv=none; b=Kew3lTql+lWXPvnZ90C9y0Nc9cOxr9K1Zi64mWc8434h92rS8DrQXXSIzEH7QTGVc67EuqKbr9Svq/U2UBNonJ3OjzgU41aaivYUJSRK/4fRgw7l9B7cJ59KLZjwFRE4szrba4EN8I+zW5xGAsS3JIvvbXRj1Wz7il8fRZbxsbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759049628; c=relaxed/simple;
	bh=xb+mAdqrzTEBOxRcy7+i28GEw89xwI56laFTVevQVw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WLacthiNRZxZwefYlGXZOLRtgKfgTGq5+SWWo38oAU8AQnSbaUFAegcCu2HuYQh+NiM/6uW3OEMQ6Hq8DmEYz0b+FV2A1KjSatFizToFGlfMxIoJJompZNH4FwZAXdfiglghMNBmgFBnObNd09v1hB4F2h5gFAiFzA/ARHG6K2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9d262d109c4811f08b9f7d2eb6caa7cf-20250928
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:18390acd-ce92-4649-a3f0-60665cc67b87,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:18390acd-ce92-4649-a3f0-60665cc67b87,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:dff9953f3593f4e90ce0ead82a59cc3b,BulkI
	D:250928165133IMOM59E2,BulkQuantity:1,Recheck:0,SF:17|19|24|38|44|66|78|10
	2|850,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 9d262d109c4811f08b9f7d2eb6caa7cf-20250928
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1075139267; Sun, 28 Sep 2025 16:53:33 +0800
From: Enze Li <lienze@kylinos.cn>
To: broonie@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: linux-kernel@vger.kernel.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH] regmap: mmio: Add module description
Date: Sun, 28 Sep 2025 16:53:17 +0800
Message-ID: <20250928085317.284326-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MODULE_DESCRIPTION() for the regmap-mmio module to eliminate the
following warning:

  WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-mmio.o

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 drivers/base/regmap/regmap-mmio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 99d7fd85ca7d..6183dff62928 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -609,4 +609,5 @@ void regmap_mmio_detach_clk(struct regmap *map)
 }
 EXPORT_SYMBOL_GPL(regmap_mmio_detach_clk);
 
+MODULE_DESCRIPTION("Register map access for memory-mapped I/O");
 MODULE_LICENSE("GPL v2");

base-commit: 51a24b7deaae5c3561965f5b4b27bb9d686add1c
-- 
2.51.0


