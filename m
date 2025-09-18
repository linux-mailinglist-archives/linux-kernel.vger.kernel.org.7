Return-Path: <linux-kernel+bounces-822730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6B3B848AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D764B5420F0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B668256C9F;
	Thu, 18 Sep 2025 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dtHP/ZEK"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD891C5486;
	Thu, 18 Sep 2025 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197885; cv=none; b=npnfsyg2OWqHUxvg+uBAooXsStBMxpy6vm1NbkeDU3oYAUtlP7cPJgle6ttHEVxkfny/zeVgvNoDCzCseXpj6KN5qMO1EFIAt5h4PEosgqBnjs8VqdsBJkUqSLHberYXYoO4aopQ5STVGL9RtTIHemuvdBvnWwE28pnNG0l7Ohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197885; c=relaxed/simple;
	bh=i+yDfi/479YybxR30hsg1UF5H6lWRNpq+qhbiEjwXNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G7NdpZPRcbdGY9CNAUM1HCQbrD+iVC3TqNWVwF/B+W1rfwgf+JZFNKun3inImE0+5X0BhY3KmupFrLEcbnI0ThLEu7Ud6iRoyGkrN8sAs9iVCxPbRqg870hYFJsm8wqG+qvvuLV8dS8ZpK8Gea6oNH8Ywt6WJKXn8ZzMn+keCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dtHP/ZEK; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 81fc9270948911f08d9e1119e76e3a28-20250918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KYI0VLNGPFF+BPC8SpD1zlWgSvD0SEyXsY08IItMsME=;
	b=dtHP/ZEKU7fjC9FaGLAWuol/WpeOteHi8F+zGdYEbSskpkwb7zw/HZaDWnz/jficU2XaKkRSPOeCBwF9Gm5++JhbrobrF2Ch5nBFrpkrm4PbbMkXDaOESq4egP9Px5k6bkivNk+KXla7AMUtxEwp/miv/XoMTL++ieu/fY0qz2k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:42f50449-b9b2-40b4-be83-a2ed395d2802,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:1ca6b93,CLOUDID:7e5d71f8-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 81fc9270948911f08d9e1119e76e3a28-20250918
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1928731714; Thu, 18 Sep 2025 20:17:56 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 18 Sep 2025 20:17:54 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 18 Sep 2025 20:17:54 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Sean Wang
	<sean.wang@mediatek.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Ramax Lo <ramax.lo@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4 4/4] arm64: defconfig: Enable UFS support for MediaTek Genio 1200 EVK UFS board
Date: Thu, 18 Sep 2025 20:17:50 +0800
Message-ID: <20250918121751.229554-4-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918121751.229554-1-macpaul.lin@mediatek.com>
References: <20250918121751.229554-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK: N

Enable the UFS related settings to support Genio 1200 EVK UFS board.
This board uses UFS as the boot device and also the main storage.
This includes support for:
 - CONFIG_SCSI_UFS_MEDIATEK

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

Changes for v2:
 - No changes.

Changes for v3:
 - Enable CONFIG_SCSI_UFS_MEDIATEK as a built-in option, since it’s
   required to mount the root filesystem during boot.
 - Use 'make savedefconfig' to generate patch. Thanks for reminding.

Changes for v4:
 - No change. Add Reviewed-by tag. Thanks!

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 58f87d09366c..c4601925221c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1218,6 +1218,7 @@ CONFIG_SCSI_UFS_BSG=y
 CONFIG_SCSI_UFSHCD_PLATFORM=y
 CONFIG_SCSI_UFS_CDNS_PLATFORM=m
 CONFIG_SCSI_UFS_QCOM=m
+CONFIG_SCSI_UFS_MEDIATEK=y
 CONFIG_SCSI_UFS_HISI=y
 CONFIG_SCSI_UFS_RENESAS=m
 CONFIG_SCSI_UFS_TI_J721E=m
-- 
2.45.2


