Return-Path: <linux-kernel+bounces-752966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD2BB17D20
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585015478DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F064620B81D;
	Fri,  1 Aug 2025 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aSmF8fQi"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3F201017;
	Fri,  1 Aug 2025 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754032169; cv=none; b=WIjVFVM4doib+i8HQFWUx9oNBJB+uw5/ZK1TxweeoxdFC0/DRL2VSTu6a6ZFqAw0NvEpxueOHNruHTnTrEo7YqYTBoURN9UzTPNzRF/VlNl8EU6aX9MwVZe1bBKtxERSe+iDSi8RnGEExurBQv6zQpkq9oqHTec6teeCVae6qcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754032169; c=relaxed/simple;
	bh=dWoWYp80Yn/oHw5MwEHA9PrApj2bREuTYX3PhhXQVJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7bTA5ufMPjNxato7WrQOy5SF50KElJ2kR2ITmaTThGCpy3CwCMdoQXx8LgCYgrHHecHg5e/FgtpZk+bRwQbnFLLaYTll3Oowk+2hCEWkyYr9Pm3TW73HdudkxgzFpVR9TwS+jphykda2k5KIewzu1gYIksWnZgIhvZl/tb3Qx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aSmF8fQi; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 71c5e2c06ea611f08871991801538c65-20250801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=44JZwaJOph6x4ufXe4ONSuwp85LLDJHU1ELMAqXU37Y=;
	b=aSmF8fQiIX53cDzz/8bUTPcllVIGkS5L5Jk+jTaiPsUE9X7vZDiLQJHu+NYWQ9STbbbipr+tj5r8sOJDyREV9FEC6RFaB5rfdOgv89uj2OeNb6e1JZLfQj8imRk3kkf3L6JRxW/UNttwyJURsT8dHveELKeGLicb1ry0GEBXcDU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:22afb216-49e0-499b-a35b-e17254cf17b9,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:cfaf660f-6968-429c-a74d-a1cce2b698bd,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 71c5e2c06ea611f08871991801538c65-20250801
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <niklaus.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1470666232; Fri, 01 Aug 2025 15:09:20 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 1 Aug 2025 15:09:18 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 1 Aug 2025 15:09:16 +0800
From: niklaus.liu <niklaus.liu@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	"Matthias Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Flora Fu
	<flora.fu@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, niklaus.liu
	<niklaus.liu@mediatek.com>
Subject: [PATCH 1/3] dt-bindings: mediatek : add binding for pwrap,spmi
Date: Fri, 1 Aug 2025 14:39:35 +0800
Message-ID: <20250801070913.3109-2-niklaus.liu@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250801070913.3109-1-niklaus.liu@mediatek.com>
References: <20250801070913.3109-1-niklaus.liu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add pwrap,spmi compatible for mt8189  to the binding.

Signed-off-by: niklaus.liu <niklaus.liu@mediatek.com>
---
 .../devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml         | 1 +
 Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
index 4737e5f45d54..c93cea9f203c 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
@@ -52,6 +52,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt8188-pwrap
+              - mediatek,mt8189-pwrap
           - const: mediatek,mt8195-pwrap
           - const: syscon
 
diff --git a/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
index 7f0be0ac644a..dc61d88008a9 100644
--- a/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
+++ b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
@@ -26,6 +26,7 @@ properties:
           - enum:
               - mediatek,mt8186-spmi
               - mediatek,mt8188-spmi
+              - mediatek,mt8189-spmi
           - const: mediatek,mt8195-spmi
 
   reg:
-- 
2.46.0


