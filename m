Return-Path: <linux-kernel+bounces-876106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0FDC1A9BC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B43750837D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42383358D2;
	Wed, 29 Oct 2025 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pk9g9oaS"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651D9329397
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743337; cv=none; b=GhRA2nxRDKL4861ebcz/DfDwyVLmvNzJ9CIyPzLLtXLeX9o/2mHeM9OUa9QVeiiVt/RVRs0/fwWdXxe+VOuOctNn8KuCzAdpzGzteVG1EQxP+qP2qP5sskupq1neAiRVo+NawcUTF52XGt1FHFMdYDNIOwJurbSAJsLUUBhbx/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743337; c=relaxed/simple;
	bh=Z55s3i9xSKU27fw2ODBvX6XiH5+LNXp+zms/8kq1IqE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BZbktU84JTWC3KjJJ79zUtytQJOFHCzcmcJorZhaONdCrRN1FjyV3IxOQjN7y+P2FgeHrfmA1NqSl6QQzf2RR5yTG9wqBQFO4UXLoqdRQkNnoBRr46hEDmfeaxI4PYTQ6gEh+kEt9jsCtUiaGkhAMyzjv25QA8WnrfYLG54uV68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pk9g9oaS; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 683688aab4c811f0ae1e63ff8927bad3-20251029
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5rqruaBGbdBage9RelMNC/uGmvBCpu4gWGsl5QOYqT0=;
	b=pk9g9oaSYj3I+TOZUiQQGGHiCWJRB61dGuuMc0yCvDer0LubkfUzbbDEGLelDX7P58QHftHW/ISbCMet9wVF4uL8mNn0DAoGqPcmwh5mMoelcPNs6BkTL3I/uPZOsrmwO0xlGKvbOsCS0kKK100+Er44P9SZROenVmEp3q8hsfE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:752901ef-bde3-4493-a0e1-379b11936704,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:70fcb118-3399-4579-97ab-008f994989ea,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 683688aab4c811f0ae1e63ff8927bad3-20251029
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <sirius.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 274325936; Wed, 29 Oct 2025 21:08:48 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 29 Oct 2025 21:08:45 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Wed, 29 Oct 2025 21:08:45 +0800
From: Sirius Wang <sirius.wang@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>
CC: <wenst@chromium.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, <jh.hsu@mediatek.com>,
	Sirius Wang <sirius.wang@mediatek.com>
Subject: [PATCH] soc: mediatek: mtk-socinfo: Add extra entry for MT8189
Date: Wed, 29 Oct 2025 21:08:34 +0800
Message-ID: <20251029130842.32633-1-sirius.wang@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The MT8189 has a different socinfo match for MT8189 SoC
(commercial name Kompanio 540), so add it the driver.

Signed-off-by: Sirius Wang <sirius.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-socinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-socinfo.c b/drivers/soc/mediatek/mtk-socinfo.c
index c697a0398d91..32153c122416 100644
--- a/drivers/soc/mediatek/mtk-socinfo.c
+++ b/drivers/soc/mediatek/mtk-socinfo.c
@@ -50,6 +50,8 @@ static struct socinfo_data socinfo_data_table[] = {
 	MTK_SOCINFO_ENTRY("MT8186T", "MT8186TV/AZA", "Kompanio 528", 0x81862001, CELL_NOT_USED),
 	MTK_SOCINFO_ENTRY("MT8188", "MT8188GV/AZA", "Kompanio 838", 0x81880000, 0x00000010),
 	MTK_SOCINFO_ENTRY("MT8188", "MT8188GV/HZA", "Kompanio 838", 0x81880000, 0x00000011),
+	MTK_SOCINFO_ENTRY("MT8189", "MT8189GV/AZA", "Kompanio 540", 0x81890000, 0x00000020),
+	MTK_SOCINFO_ENTRY("MT8189", "MT8189HV/AZA", "Kompanio 540", 0x81890000, 0x00000021),
 	MTK_SOCINFO_ENTRY("MT8192", "MT8192V/AZA", "Kompanio 820", 0x00001100, 0x00040080),
 	MTK_SOCINFO_ENTRY("MT8192T", "MT8192V/ATZA", "Kompanio 828", 0x00000100, 0x000400C0),
 	MTK_SOCINFO_ENTRY("MT8195", "MT8195GV/EZA", "Kompanio 1200", 0x81950300, CELL_NOT_USED),
-- 
2.45.2


