Return-Path: <linux-kernel+bounces-860266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A0EBEFB63
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8673BF4CF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5682E6114;
	Mon, 20 Oct 2025 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Y2BKApf4"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422C2E265A;
	Mon, 20 Oct 2025 07:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946155; cv=none; b=QfITYCCIPjsmaOf/1OCbw0oXAeSReKZGZsDn7L2Ga6vieCMBJZqX0FmpqqxlPEpy4fBzzapjvXI/wdzhDXWLsd/BXR66r9L78W3SepLmfJ1cpwTZ/1FvyUEXdHRrGmSmt76CkrbA3IvOUKNDEDDsA7djxnzn++IAPCEQTND+BSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946155; c=relaxed/simple;
	bh=TpEr2BLTJy6/LjciTPm0yxvSsfAqUKJSvB9Ur+CPzg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYb8u6w1vv+752aQDNayEGB4MgDi29iB/EB7G1b5vaeyfp4W0PiHo/wcuosoYYuZTPwRGT7+9+czcupBacKbyCZIPxBTboG/h3sIkYey3jD+kJxqCTw/zmYEB2WmhBbMSXWnlDjAN2UK3pY8r8xiOOVwhOfowpDSKArCQql0a2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Y2BKApf4; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 52ee9d4ead8811f0ae1e63ff8927bad3-20251020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GGOie3gK1Zacx2nTpTrunE4NF4/ZRFH0AqCuFcHfdFw=;
	b=Y2BKApf4Jf1WjOQqFRMdgpytc6QL3AbEZkLkAD4MdToEQR3HLwCLapewL4EqUqyHecd3Qm5ndCwqoTTDcoOVlXmYDPKWZxUuwsFb9DEiXcvro1ryIB5beJoowzvkP3nxIHyaTYmw7hvqjUCPlBZZA2iQMavPNm1gHmlwiyrGQxM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:2b354916-35d3-4c7d-810f-6e0d072a31b7,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:21d15ab9-795c-4f99-91f3-c115e0d49051,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 52ee9d4ead8811f0ae1e63ff8927bad3-20251020
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <xiandong.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 920648876; Mon, 20 Oct 2025 15:42:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 20 Oct 2025 15:42:21 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 20 Oct 2025 15:42:20 +0800
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
Subject: [PATCH v1 06/13] dt-bindings: arm: mediatek: mmsys: add compatible for MT8189
Date: Mon, 20 Oct 2025 15:40:19 +0800
Message-ID: <20251020074211.8942-7-xiandong.wang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251020074211.8942-1-xiandong.wang@mediatek.com>
References: <20251020074211.8942-1-xiandong.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In MT8189, a single HW pipeline was an independent mmsys,
which included the OVL module, PQ module, and display interface
module.

Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>
---
 .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
index 3f4262e93c78..f1889b9788ab 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
@@ -35,6 +35,7 @@ properties:
               - mediatek,mt8188-vdosys1
               - mediatek,mt8188-vppsys0
               - mediatek,mt8188-vppsys1
+              - mediatek,mt8189-mmsys
               - mediatek,mt8192-mmsys
               - mediatek,mt8195-vdosys1
               - mediatek,mt8195-vppsys0
-- 
2.46.0


