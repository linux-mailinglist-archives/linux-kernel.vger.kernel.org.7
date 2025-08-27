Return-Path: <linux-kernel+bounces-787576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56709B37834
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7879363F43
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A022C1596;
	Wed, 27 Aug 2025 02:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OwreRfaH"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4A62BF01E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756262261; cv=none; b=s+w/FSbd+zXHEwHBhbM4Dnma5r3ELuBMmrJSWlaLPTbYEqMNPECn33K8uzZK6YR9I8dl1dG3E3OMGDisa3+OetxkAjHjCW1ikSnEAsq/HNFLrttGm52jLf7ddw1xC5f8BxGdLKza0+btMgvs0VigkjemP68BErSh87C/TSjysus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756262261; c=relaxed/simple;
	bh=IcfFXBC6vip/hTsmuCwRJQWKX01evLHIMzIfElDodN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0QDoflWUa9dZk7ZSUUWmST5y44fukf6LCozKJORfaEzwmD+AlN+6lmEpILjm71tfsD0E9XhfRjotXvZ2ooqvR8bcz79QYntNA9HexCMRqkBCTjkrPtIUB1Yf3yk5hhJ51+WCXoFHsSgmW4XWHmfJzggRu81+YiPpdyRVQYzbqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OwreRfaH; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c8f9ae2682ee11f0b33aeb1e7f16c2b6-20250827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qqQOUmPhPDF+wRFVuZ8A8xxyMc7EM27KRGaAeuZra8I=;
	b=OwreRfaHxOeaRe24eDR6vrOwfwf21WwEEbIo4DQ12Otso1UubuYSuclmj95kqM5AGOAtkBZZdLWjm9U6V4UnoHfWxXmKV2FQTBXnAO+GB8HcMCnjSLO1jqnPRDIuRdZKvSaQIhbjJ+APVvRXuPFfPmKoDmBSuqMuRvartDXX/0I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:2be08581-750d-4665-ac3f-2fd9cb8d849b,IP:0,UR
	L:0,TC:0,Content:22,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:22
X-CID-META: VersionHash:f1326cf,CLOUDID:aae78f7a-966c-41bd-96b5-7d0b3c22e782,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:4|15|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 3,DMD|SSN|SDN
X-CID-BAS: 3,DMD|SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c8f9ae2682ee11f0b33aeb1e7f16c2b6-20250827
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <xion.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1636638563; Wed, 27 Aug 2025 10:37:33 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 27 Aug 2025 10:37:32 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 27 Aug 2025 10:37:31 +0800
From: <xion.wang@mediatek.com>
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <wsd_upstream@mediatek.com>, <huadian.liu@mediatek.com>, Xion Wang
	<xion.wang@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] misc: remove ineffective WARN_ON() check from misc_deregister()
Date: Wed, 27 Aug 2025 10:41:00 +0800
Message-ID: <20250827024201.21407-2-xion.wang@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250827024201.21407-1-xion.wang@mediatek.com>
References: <20250827024201.21407-1-xion.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Xion Wang <xion.wang@mediatek.com>

The WARN_ON(list_empty(&misc->list)) in misc_deregister() does
not catch any practical error conditions:
- For statically allocated miscdevice structures, the list pointers
 are zero-initialized, so list_empty() returns false, not true.
- After list_del(), the pointers are set to LIST_POISON1 and LIST_POISON2,
 so repeated deregistration also fails to trigger the check.

Signed-off-by: Xion Wang <xion.wang@mediatek.com>
---
 drivers/char/misc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 558302a64dd9..f46b00a76a59 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -275,9 +275,6 @@ EXPORT_SYMBOL(misc_register);
 
 void misc_deregister(struct miscdevice *misc)
 {
-	if (WARN_ON(list_empty(&misc->list)))
-		return;
-
 	mutex_lock(&misc_mtx);
 	list_del(&misc->list);
 	device_destroy(&misc_class, MKDEV(MISC_MAJOR, misc->minor));
-- 
2.45.2


