Return-Path: <linux-kernel+bounces-687573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B08BADA6B2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 05:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B31B188C702
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 03:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDEA295520;
	Mon, 16 Jun 2025 03:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lF+ViI/Q"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CBD28E594;
	Mon, 16 Jun 2025 03:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750043510; cv=none; b=lf0O30RFxqsRqyZXp/V3kJx+LuP2G+1FzHgMMQeO7MOxfMCgcyc838UT9W0KANI/9Y4ZPv9z8hFuoXHnBjDAkG5UEagPBSYkFhHV+mkFEKt9JeU1zcHivwkjukAJURTlVExf3EhwnjlXrzVHeTNU+P+VNIopw+rX4HMzGSbvB5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750043510; c=relaxed/simple;
	bh=qf1MbNteaNFmIuHCeFXwy4QvVoxmZC5pLPaW/3wYq1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OsZpZF9pRCdQxh99tFqLQapebRB2j7opNKpK3N/uPdL0ZrbumDfoD4Rcc3Xep2iOKgVbO2Jn2IG9sc1+0LZBfWFk0vfkfIPdUzqwjd1iURgxA8ZXy47KiapIm5k4ULmNPPy4auQllH6D27CjnZ3XztRqmBKoi/fLS9rXj4h6Sjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lF+ViI/Q; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 848c90924a5d11f0b33aeb1e7f16c2b6-20250616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VBckLV6jNByzkSdMQw8AHIGDrw+A/A7qK4UW3zfX+Kk=;
	b=lF+ViI/Q55Q68ANrrcMRpas9q+fzGc4+qK7bItFPOojM6rJTXxnLHkMgLRojTMmCUrhN9mpNykZ8z+GmelHdJ1p7tpkqAkNL2ahA5yeFeGVQyx574RJp0xgRVPt+e0ZCSP28KeG30ZdK3mjmzv1fVo0jA7ZBzmgRkgwbs8w189I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.3,REQID:b1412469-3fad-484e-aacd-083c9afda5d9,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:09905cf,CLOUDID:ce810277-7521-4364-b0ef-cd7d9c0ecbde,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 848c90924a5d11f0b33aeb1e7f16c2b6-20250616
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <xueqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 985199707; Mon, 16 Jun 2025 10:56:36 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 16 Jun 2025 10:56:34 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 16 Jun 2025 10:56:33 +0800
From: Xueqi Zhang <xueqi.zhang@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <Project_Global_Chrome_Upstream_Group@mediatek.com>, Ning li
	<ning.li@mediatek.com>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <iommu@lists.linux.dev>, Xueqi Zhang
	<xueqi.zhang@mediatek.com>
Subject: [RFC PATCH 1/8] dt-bindings: iommu: mediatek: Add mt8196 support
Date: Mon, 16 Jun 2025 10:56:07 +0800
Message-ID: <20250616025628.25454-2-xueqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250616025628.25454-1-xueqi.zhang@mediatek.com>
References: <20250616025628.25454-1-xueqi.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

1. Mediatek has its own implementation for wrapper interrupts and
power management. Add the SoC specific compatible for MT8196
implementing arm,smmu-v3.
2. APU SMMU need wait until its power is ready, thus add a phandle
smmu-mediatek-parents to its power node.

Signed-off-by: Xueqi Zhang <xueqi.zhang@mediatek.com>
---
 .../bindings/iommu/arm,smmu-v3.yaml           | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
index 75fcf4cb52d9..c9a99e54de69 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
@@ -20,7 +20,12 @@ properties:
   $nodename:
     pattern: "^iommu@[0-9a-f]*"
   compatible:
-    const: arm,smmu-v3
+    - description: MediaTek SoCs implementing "arm,smmu-v3"
+      items:
+        - enum:
+            - mediatek,mt8196-apu-smmu
+            - mediatek,mt8196-mm-smmu
+        - const: arm,smmu-v3
 
   reg:
     maxItems: 1
@@ -69,11 +74,28 @@ properties:
       register access with page 0 offsets. Set for Cavium ThunderX2 silicon that
       doesn't support SMMU page1 register space.
 
+  mediatek,smmu-parents:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      A phandle to the SMMU's power node. The SMMU should wait until its power
+      is ready
+
 required:
   - compatible
   - reg
   - '#iommu-cells'
 
+allOf:
+  - if:  # for SMMU need to wait its power node
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8196-apu-smmu
+    then:
+      required:
+        - mediatek,smmu-parents
+
 additionalProperties: false
 
 examples:
-- 
2.46.0


