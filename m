Return-Path: <linux-kernel+bounces-757477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B9BB1C299
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DF43A640D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F183238C39;
	Wed,  6 Aug 2025 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nZe+vm3S"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1ED289345;
	Wed,  6 Aug 2025 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470803; cv=none; b=tat7BQCpkCrzRCJemnFBqY/9M/5GCIlFiMPbnCShdSdA1HX3FVYQzLwPcr75Y1VoGEEm0ZHHDAR44cCIGS8lJVPZHJnly0RsSEE2vqKmPIrr1L1hxnE1jp8RIDgqbeiYHLbJ8xepvmtnu6fE+dt8hTCjuuUVeZG7n6suKtaoXqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470803; c=relaxed/simple;
	bh=18XyLrx/1KQcZmKbVPtoOMcxgZ9DPylxf6vNp7synqQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BN3xCtDwTTkA3pUgRjBobiV/9k1jEVDRxd8qe0LlVeLhthVcGKv5m1RKpoRy4XsNLuWKsvbdDJeMcya+cQRatX0jfmDPT9jQVWCiy4xsD6jtnOZcDEJriwhyC/pMNR+9QJlxlFNFUNJBetni1dAFeDGFfUFr4Ojr6XMQ5LO8MDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nZe+vm3S; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b9aa1eb672a311f0b33aeb1e7f16c2b6-20250806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RzRjl0wuxO05mFaAmxgC9m8FQ896f26iiNfacinIM/I=;
	b=nZe+vm3S5NDP2GaHjwISIR6wpwup/82o6i1hvxu11KrOSX7Z4LA5Eei7XsPLTufpgyJR3r6WysKaThP0/7k9CPxsX/Mrk0bMwEPtQNuAixz/VJqVNZdqShBsjrn6YJ2ChzymGojNY8IN4cKA1IH16xOozzAr3thv8iyxH8p78vQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:a00308cc-c6d1-47c1-ad33-be37e8a9cda0,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:6a42aa9a-32fc-44a3-90ac-aa371853f23f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b9aa1eb672a311f0b33aeb1e7f16c2b6-20250806
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1083724416; Wed, 06 Aug 2025 16:59:56 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 6 Aug 2025 16:59:54 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 6 Aug 2025 16:59:54 +0800
From: Friday Yang <friday.yang@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: Friday Yang <friday.yang@mediatek.com>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v10 1/2] dt-bindings: memory: mediatek: Add SMI reset and clamp for MT8188
Date: Wed, 6 Aug 2025 16:59:35 +0800
Message-ID: <20250806085946.11383-2-friday.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250806085946.11383-1-friday.yang@mediatek.com>
References: <20250806085946.11383-1-friday.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add 'resets' and 'reset-names' properties for SMI LARBs to support
SMI reset operations.
On the MediaTek platform, some SMI LARBs are directly connected to
the SMI Common, while others are connected to the SMI Sub-Common,
which in turn is connected to the SMI Common. The hardware block
diagram can be described as follows.

             SMI-Common(Smart Multimedia Interface Common)
                 |
         +----------------+------------------+
         |                |                  |
         |                |                  |
         |                |                  |
         |                |                  |
         |                |                  |
       larb0       SMI-Sub-Common0     SMI-Sub-Common1
                   |      |     |      |             |
                  larb1  larb2 larb3  larb7       larb9

Signed-off-by: Friday Yang <friday.yang@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../mediatek,smi-common.yaml                  |  2 ++
 .../memory-controllers/mediatek,smi-larb.yaml | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
index 0762e0ff66ef..3d98c08b2149 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
@@ -40,6 +40,7 @@ properties:
           - mediatek,mt8186-smi-common
           - mediatek,mt8188-smi-common-vdo
           - mediatek,mt8188-smi-common-vpp
+          - mediatek,mt8188-smi-sub-common
           - mediatek,mt8192-smi-common
           - mediatek,mt8195-smi-common-vdo
           - mediatek,mt8195-smi-common-vpp
@@ -108,6 +109,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - mediatek,mt8188-smi-sub-common
               - mediatek,mt8195-smi-sub-common
     then:
       required:
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
index 2e7fac4b5094..fc5feb2eac1f 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
@@ -70,6 +70,12 @@ properties:
     description: the hardware id of this larb. It's only required when this
       hardware id is not consecutive from its M4U point of view.
 
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: larb
+
 required:
   - compatible
   - reg
@@ -126,6 +132,19 @@ allOf:
       required:
         - mediatek,larb-id
 
+  - if:  # only for image, camera and ipe subsys
+      properties:
+        compatible:
+          const: mediatek,mt8188-smi-larb
+        mediatek,larb-id:
+          enum:
+            [ 9, 10, 11, 12, 13, 16, 17, 18, 19, 20 ]
+
+    then:
+      required:
+        - resets
+        - reset-names
+
 additionalProperties: false
 
 examples:
-- 
2.46.0


