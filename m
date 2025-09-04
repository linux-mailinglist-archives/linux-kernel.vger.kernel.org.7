Return-Path: <linux-kernel+bounces-800015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7474B4326E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9409B7C5F05
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D6B27604E;
	Thu,  4 Sep 2025 06:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GOSZfhB1"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1911A274FE3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967589; cv=none; b=tIrQdiGBim/Zvwpk/Bsq4oHNYERqBrKhIDSpNPdH0mLkObEcf+wCgAAmkAqor3N7SiZ81ljbI5gpFu7xa7DJ193SvtBsUQLIgf4wjI+jBQE4sDXFk5Ekm58GDlQ1GWcpjX5G7sN8SnJrW/qnEPw/izmcdXcX4Kqbv4mF3oqL24g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967589; c=relaxed/simple;
	bh=EcYEj43mL8nM4gr/Yfa810G91+KSmFFHYILwTZHNnHM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CafGzmBHb6knuisRuFbqjYAxjXKpyk8yen2nYKUuZRA2+kXPvq42FACPh8i2/vXfPK/kEabJ0fiDij8LNZwJAtIfhk+1vON4piCqIrI5LM4bQNs676BXw9Xx3e0gqAprDK41RXBzKcNH+5tOveduiGPI6iV4nXBBsoKFXcPFBZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GOSZfhB1; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 010f9abc895911f0bd5779446731db89-20250904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YpGOZ6R4tA8s0gpQCC9ncHlNVuO9zib3S9+/vzed/sQ=;
	b=GOSZfhB1S2vrhO3TVkB5u8O6D6D0wbzm+W0DiDCmZ5/gLQkd5+Bigkoi8ii2Z/WaaT3G/LW1eOw3BCIc2/R24leLa6AIvdmiGnno2XnQKW7sQfOFM7Pmk4ElFWOqGE70gh+uoBy7lLcp2W9nlXrOyX6y4pkTmNKgHdjqkNSy4c4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:e94d8672-95ee-48db-8b1b-0970ae6764c6,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:e3eeeef7-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 3,DMD|SSN|SDN
X-CID-BAS: 3,DMD|SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 010f9abc895911f0bd5779446731db89-20250904
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <xion.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 256494133; Thu, 04 Sep 2025 14:33:01 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 4 Sep 2025 14:32:58 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 4 Sep 2025 14:32:52 +0800
From: <xion.wang@mediatek.com>
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Akinobu
 Mita <akinobu.mita@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <wsd_upstream@mediatek.com>, <huadian.liu@mediatek.com>, Xion Wang
	<xion.wang@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] char: Use list_del_init() in misc_deregister() to reinitialize list pointer
Date: Thu, 4 Sep 2025 14:37:04 +0800
Message-ID: <20250904063714.28925-2-xion.wang@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250904063714.28925-1-xion.wang@mediatek.com>
References: <20250904063714.28925-1-xion.wang@mediatek.com>
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

Currently, misc_deregister() uses list_del() to remove the device
from the list. After list_del(), the list pointers are set to 
LIST_POISON1 and LIST_POISON2, which may help catch use-after-free bugs,
but does not reset the list head.
If misc_deregister() is called more than once on the same device,
list_empty() will not return true, and list_del() may be called again,
leading to undefined behavior.

Replace list_del() with list_del_init() to reinitialize the list head
after deletion. This makes the code more robust against double
deregistration and allows safe usage of list_empty() on the miscdevice
after deregistration.

Fixes: b329becfc78b1 ("char: add WARN_ON() in misc_deregister()")

Signed-off-by: Xion Wang <xion.wang@mediatek.com>
---
 drivers/char/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 558302a64dd9..b5d44b08ad7b 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -279,7 +279,7 @@ void misc_deregister(struct miscdevice *misc)
 		return;
 
 	mutex_lock(&misc_mtx);
-	list_del(&misc->list);
+	list_del_init(&misc->list);
 	device_destroy(&misc_class, MKDEV(MISC_MAJOR, misc->minor));
 	misc_minor_free(misc->minor);
 	mutex_unlock(&misc_mtx);
-- 
2.45.2


