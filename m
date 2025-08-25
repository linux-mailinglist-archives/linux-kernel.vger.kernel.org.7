Return-Path: <linux-kernel+bounces-784305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4E7B339C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53E93B95D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054D12C0F96;
	Mon, 25 Aug 2025 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aZ3knCbI"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E542C0F7B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111296; cv=none; b=c4LbDps2qDVxnZE4VVbNp4VXvZbRebUieJ0d8fc1cVsGGblgCHzLGSnKn4BB8nqlAzSs1fOvD85Boq3LkqfReYzjCjXbTzYJeynG7yQckeKbYWUdsyyWKGeJLzQBlubbGpD+zwDP3t+BJ7VbuFop65F7pMo11SJ+C/f+FgVhiM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111296; c=relaxed/simple;
	bh=Jfa1THEcp2NSGVGu9eZpmlzsfemWMV56Bx1xwURGSvc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0jruYUNMkDBbH/Mv+ZbDYoE3px/KX7cuYph/6glshRLuUu94DQUP7El01ZlD1C1yHKe/a4Az+29WJrukIV+OZp9jFoJF2Q7avNeCtantTRmyuc5LU+S+61Omt3CZLG99w/KI/lQ1ix3FMEG43W70C7GnTXwPz+ZZi6nkpqL1oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aZ3knCbI; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4b54a67a818f11f0b33aeb1e7f16c2b6-20250825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Tj8a6GPuOmdWC97QKAJpys6LnXM9wpEnatX8NPRY2Qw=;
	b=aZ3knCbI68NQGGZOMKsi5/62yK9Gogkbn9hXqdtYGeWKSuFDuv0J/ULiNlbWlUjy+svS3umeQz5FrTB2BZlGIj1T+Y0khjouZJw7d6AGX9HdZQXuyYXtyVmEx+ijF5nuNDhCMDdpAMcgGtBUzYHNa+eRwmjywXoUkaRQVsL7MOM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:dafbeef3-e35e-4499-b7cb-05f520da4fa7,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:f4e87e7a-966c-41bd-96b5-7d0b3c22e782,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 3,DMD|SSN|SDN
X-CID-BAS: 3,DMD|SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4b54a67a818f11f0b33aeb1e7f16c2b6-20250825
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <xion.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 263565723; Mon, 25 Aug 2025 16:41:29 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 25 Aug 2025 16:41:28 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 25 Aug 2025 16:41:27 +0800
From: <xion.wang@mediatek.com>
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <wsd_upstream@mediatek.com>, <huadian.liu@mediatek.com>, Xion Wang
	<xion.wang@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] misc: Prevent double registration and deregistration of miscdevice
Date: Mon, 25 Aug 2025 16:45:47 +0800
Message-ID: <20250825084556.10358-2-xion.wang@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250825084556.10358-1-xion.wang@mediatek.com>
References: <20250825084556.10358-1-xion.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Xion Wang <xion.wang@mediatek.com>

When repeated calls to misc_register() or misc_deregister() on the
same miscdevice could lead to kernel crashes or misc_list corruption due to
multiple INIT_LIST_HEAD or list_del operations on the same list node.

This patch improves the robustness of the misc device driver by preventing
both double registration and double deregistration of miscdevice instances.

Signed-off-by: Xion Wang <xion.wang@mediatek.com>
---
 drivers/char/misc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 558302a64dd9..2f8666312966 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -210,6 +210,9 @@ int misc_register(struct miscdevice *misc)
 	int err = 0;
 	bool is_dynamic = (misc->minor == MISC_DYNAMIC_MINOR);
 
+	if (WARN_ON(misc->this_device))
+		return -EEXIST;
+
 	INIT_LIST_HEAD(&misc->list);
 
 	mutex_lock(&misc_mtx);
@@ -251,6 +254,7 @@ int misc_register(struct miscdevice *misc)
 			misc->minor = MISC_DYNAMIC_MINOR;
 		}
 		err = PTR_ERR(misc->this_device);
+		misc->this_device = NULL;
 		goto out;
 	}
 
@@ -275,12 +279,13 @@ EXPORT_SYMBOL(misc_register);
 
 void misc_deregister(struct miscdevice *misc)
 {
-	if (WARN_ON(list_empty(&misc->list)))
+	if (WARN_ON(!misc->this_device))
 		return;
 
 	mutex_lock(&misc_mtx);
 	list_del(&misc->list);
 	device_destroy(&misc_class, MKDEV(MISC_MAJOR, misc->minor));
+	misc->this_device = NULL;
 	misc_minor_free(misc->minor);
 	mutex_unlock(&misc_mtx);
 }
-- 
2.45.2


