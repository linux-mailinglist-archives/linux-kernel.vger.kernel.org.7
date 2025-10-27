Return-Path: <linux-kernel+bounces-871496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F8BC0D75C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0409D189E615
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD612E1EE5;
	Mon, 27 Oct 2025 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f+9E024D"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D26185C4A;
	Mon, 27 Oct 2025 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567325; cv=none; b=l7QEw926RoE6+fjJ/W47dRpNGARQJqzOpzJtxPf0oPDv9UCCkFWREtX2EKlM1EKTstGiXrH2r1qmPy3umyFG7Pt6mcFQN9pAy1IjsM1PaJyURgG1RmDcIu/ByAuM1sazyo18s+VP8EPeeTN9cQJxOigadOYOfk7PEWhx2otsqkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567325; c=relaxed/simple;
	bh=3EHYcbLigckh/AP73NSWrYbGOjavUhSiB84ltb7Beew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+odygJuWk07BBqL758tB3NhFf8ot03VTTg8YcywGaiR8uotjiippOsXSLpqB4i8r/emggS0e/OymK4De1c+mruNehTxBoUtoq8IQ4j1Qw9/041kc7Gn8GzxnK4voBZ3MtozRlHASiQHrvepvzzjip8Ei9v+4Mtk7lNsxYADQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=f+9E024D; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 95dd12d8b32e11f0ae1e63ff8927bad3-20251027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KkuEErUrXfFzsQkjQsraDkINjJMAVu/dSi9jyJ2QsjM=;
	b=f+9E024DKSvLrFKefChyN1DBGZzq1gYRhAcGd3d6KiO6i9waFszWwUBTpG3gYYsC7pEB3+i8W8+FQ3IUtg1U0KXF8q3Uq4IhtUPuNdIKrDM7uKeV/5bLELqM3f1A67knpMdXPQEpnneHUZNiM76FU+X2a0mvOChXgb7fsdwX8GU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:eab64542-bbae-49f3-b9ad-7b4addc66683,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:dfb8de3a-b16f-49fc-bb37-560773c432f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 95dd12d8b32e11f0ae1e63ff8927bad3-20251027
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <zhengnan.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 615450332; Mon, 27 Oct 2025 20:15:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 27 Oct 2025 20:15:07 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 27 Oct 2025 20:15:06 +0800
From: Zhengnan Chen <zhengnan.chen@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Zhengnan Chen
	<zhengnan.chen@mediatek.com>
Subject: [PATCH v2 1/2] dt-bindings: memory-controllers: mtk-smi: Add support for mt8189
Date: Mon, 27 Oct 2025 20:14:27 +0800
Message-ID: <20251027121443.16783-2-zhengnan.chen@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251027121443.16783-1-zhengnan.chen@mediatek.com>
References: <20251027121443.16783-1-zhengnan.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add binding description for mt8189.

The clocks number of mt8189 smi-sub common has a bit difference.
Its clock count is 2, while mt8195 has 3. Therefore, the minimum
number of clocks is changed to 2, with the third one being optional.

About what smi-sub-common is, please check the below diagram,
we add it in mediatek,smi-common.yaml file.

Signed-off-by: Zhengnan Chen <zhengnan.chen@mediatek.com>
---
Hi Angelo,
We add a diagram in the smi-common yaml, We are not sure if you agree
with this. thus I remove your R-b.

Thanks.
---
---
 .../mediatek,smi-common.yaml                  | 25 +++++++++++++++++--
 .../memory-controllers/mediatek,smi-larb.yaml |  3 +++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
index 0762e0ff66ef..454d11a83973 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
@@ -25,6 +25,21 @@ description: |
   SMI generation 1 to transform the smi clock into emi clock domain, but that is
   not needed for SMI generation 2.
 
+  The smi-common connects with smi-larb and IOMMU. The maximum inputs number of
+  a smi-common is 8. In SMI generation 2, the engines number may be over 8.
+  In this case, we use a smi-sub-common to merge some larbs.
+  The block diagram something is like:
+
+                          IOMMU
+                           | |
+                       smi-common
+              ---------------------------
+               |          |           ...
+              larb0   sub-common      ...  <-max number is 8
+                   ----------------
+                    |     |    ...
+                  larb1 larbX  ...  <-max number is 8
+
 properties:
   compatible:
     oneOf:
@@ -40,6 +55,8 @@ properties:
           - mediatek,mt8186-smi-common
           - mediatek,mt8188-smi-common-vdo
           - mediatek,mt8188-smi-common-vpp
+          - mediatek,mt8189-smi-common
+          - mediatek,mt8189-smi-sub-common
           - mediatek,mt8192-smi-common
           - mediatek,mt8195-smi-common-vdo
           - mediatek,mt8195-smi-common-vpp
@@ -108,19 +125,23 @@ allOf:
         compatible:
           contains:
             enum:
+              - mediatek,mt8189-smi-sub-common
               - mediatek,mt8195-smi-sub-common
     then:
       required:
         - mediatek,smi
       properties:
         clocks:
-          minItems: 3
+          minItems: 2
           maxItems: 3
         clock-names:
+          minItems: 2
+          maxItems: 3
           items:
             - const: apb
             - const: smi
-            - const: gals0
+          additionalItems:
+            const: gals0
     else:
       properties:
         mediatek,smi: false
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
index 2e7fac4b5094..9a5dafd7c07e 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
@@ -27,6 +27,7 @@ properties:
           - mediatek,mt8183-smi-larb
           - mediatek,mt8186-smi-larb
           - mediatek,mt8188-smi-larb
+          - mediatek,mt8189-smi-larb
           - mediatek,mt8192-smi-larb
           - mediatek,mt8195-smi-larb
 
@@ -85,6 +86,7 @@ allOf:
             - mediatek,mt8183-smi-larb
             - mediatek,mt8186-smi-larb
             - mediatek,mt8188-smi-larb
+            - mediatek,mt8189-smi-larb
             - mediatek,mt8195-smi-larb
 
     then:
@@ -119,6 +121,7 @@ allOf:
               - mediatek,mt6779-smi-larb
               - mediatek,mt8186-smi-larb
               - mediatek,mt8188-smi-larb
+              - mediatek,mt8189-smi-larb
               - mediatek,mt8192-smi-larb
               - mediatek,mt8195-smi-larb
 
-- 
2.46.0


