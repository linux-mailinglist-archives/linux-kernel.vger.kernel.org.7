Return-Path: <linux-kernel+bounces-860260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02170BEFB3F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0E014E945C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F46A2DF133;
	Mon, 20 Oct 2025 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="obIh9uKR"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39320153BD9;
	Mon, 20 Oct 2025 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946145; cv=none; b=rYuRZwci9XkF8em9cvQoJnGtMIuZnf6F8CXwxzh8wS2tlNH0MP8Y8v20jMlNdTG66cEA924IwzEB8dSUMj/34mopowmC9wrPiyoWXVnxylaCtpcb1Au+Wchjm7nKD8U/NtbDQt4fUDSViTuCDvQtcjxr1HGysSIn7PXQcCB/f8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946145; c=relaxed/simple;
	bh=cPeFCRjh1FIjtbO/klRnnF52hABm0LgfGS/wEIKTVJ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=arxLNIrmYKZbQca/DC7q8t/cYjBF/1xyVMxI2wz3UJ+W/J/RYdHKLYQOQXGDZ+cKc4OR8WEj1xOZOBCu5Q/ZZa49IBoUmg8TRSoQGq0Ak7qmfZnzBYXM1oF7o9C+cyyGspqO8bD83EGGyU1uTJdcU8FS4NtVo4osiSx345KJnWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=obIh9uKR; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4d232ee8ad8811f0ae1e63ff8927bad3-20251020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=OFMWr2Qbe+Xb/UIm3owsP/tjkP9llxwZ0iyfLuKotAo=;
	b=obIh9uKRVGZ+CF6N+qPmD3hjIsMvsR2C9rU0EgE1XgrOU9W7ug4042bRGXff8Mg2zDF5fkKfNoEDsc4e9sDJPzNbA2HZi3ygt1pRQVafoxRmy3CCwVJCvEDStepu54aoK7FGPLv+nIUjf363PLc629SHRRHp+hetHlJ5dvH4orU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:24b6767c-b044-4c60-8b6e-bedc64a1a528,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:e79b3e51-c509-4cf3-8dc0-fcdaad49a6d3,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:1,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4d232ee8ad8811f0ae1e63ff8927bad3-20251020
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <xiandong.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1342833036; Mon, 20 Oct 2025 15:42:16 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 20 Oct 2025 15:42:11 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 20 Oct 2025 15:42:10 +0800
From: Xiandong Wang <xiandong.wang@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Yongqiang Niu
	<yongqiang.niu@mediatek.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Xiandong Wang <xiandong.wang@mediatek.com>
Subject: [PATCH v1 00/13] Add MediaTek SoC DRM support for MT8189
Date: Mon, 20 Oct 2025 15:40:13 +0800
Message-ID: <20251020074211.8942-1-xiandong.wang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

base on mt8196 disp driver V4 https://patchwork.kernel.org/project/linux-mediatek/list/?series=996375

Xiandong Wang (13):
  dt-bindings: soc: mediatek: add aal yaml for MT8189
  dt-bindings: soc: mediatek: add ccorr yaml for MT8189
  dt-bindings: soc: mediatek: add color yaml for MT8189
  dt-bindings: soc: mediatek: add dither yaml for MT8189
  dt-bindings: soc: mediatek: add gamma yaml for MT8189
  dt-bindings: arm: mediatek: mmsys: add compatible for MT8189
  dt-bindings: soc: mediatek: add ovl yaml for MT8189
  dt-bindings: soc: mediatek: add rdma yaml for MT8189
  dt-bindings: soc: mediatek: add mutex yaml for MT8189
  dt-bindings: soc: mediatek: add dsi yaml for MT8189
  soc: mediatek: add mmsys support for MT8189
  drm/mediatek: Add support for mt8189 mmsys driver probe
  soc: mediatek: mutex: add mutex support for MT8189

 .../bindings/arm/mediatek/mediatek,mmsys.yaml |   1 +
 .../display/mediatek/mediatek,aal.yaml        |   1 +
 .../display/mediatek/mediatek,ccorr.yaml      |   1 +
 .../display/mediatek/mediatek,color.yaml      |   1 +
 .../display/mediatek/mediatek,dither.yaml     |   1 +
 .../display/mediatek/mediatek,dsi.yaml        |   1 +
 .../display/mediatek/mediatek,gamma.yaml      |   1 +
 .../display/mediatek/mediatek,ovl.yaml        |   2 +
 .../display/mediatek/mediatek,rdma.yaml       |   1 +
 .../bindings/soc/mediatek/mediatek,mutex.yaml |   1 +
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c       |   2 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c       |  40 +++
 drivers/gpu/drm/mediatek/mtk_disp_ovl.h       |   2 +
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c      |   8 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  39 +++
 drivers/soc/mediatek/mt8189-mmsys.h           | 300 ++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c              |  12 +
 drivers/soc/mediatek/mtk-mutex.c              |  88 +++++
 include/linux/soc/mediatek/mtk-mmsys.h        |   5 +
 19 files changed, 507 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt8189-mmsys.h

-- 
2.46.0


