Return-Path: <linux-kernel+bounces-760274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EE4B1E8C7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460B8A02B28
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AF227D77D;
	Fri,  8 Aug 2025 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aLqWIi5B"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C54A27B4F7;
	Fri,  8 Aug 2025 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754657850; cv=none; b=oU0WsosaOr22pPtDnJXFvCDdGhMz91C4SdvPVRUclpJHipmkNvJNL5Z6/kcvTMRTwB0fsWLC6o/nZYAoV+Eh2TbMSJbNs3JkyYB2j9gPDNVv5aJBJfkE2QyGTj7XNQUMIwlsI/TanhIAH+Q0wDb9Lkdm2w+b9pvcj+7e7SCYZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754657850; c=relaxed/simple;
	bh=ft3SCcMSL8QrXyekEdbOrpJrwABHf3qeat8lYv85Wfc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqsZACx6GEa+pzMcgq7RNuy1/G2tnjmLYzOS7DVNII8vCljlgIhY9+1LAEaw45dtu2+Rn+5xpnnRyaMsJxnJIkpWUzICnoko8YWKlbOorvV4pGNW74IeKIqoeBCqMVv7V2Q842cv29KPYl06VPUZbv3LYTMN9qGh7kVZGTzgsFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aLqWIi5B; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 32c0b2ba745711f0b33aeb1e7f16c2b6-20250808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Moru1e+eo1W2qBlDQbPKQ/q9t+du5PgIZxCnNE2k8w0=;
	b=aLqWIi5BJetZMhOUZQN55u4VvgtZ4TgjlDB7OsG2OMhaJAXmxJQJvOrFse1cDCQQfrtt2HIlM5hF+yvuxbgHA1HD9wbrRDnoEMnwIhVRaffU4z+7O4ltvgA2/hjTr0ALBJllU8NscaNk42/b/szZRrkm7vfcnOTmsf+3LRiJMYM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:da7606b3-176f-4abf-957c-95203c3533a8,IP:0,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:f1326cf,CLOUDID:06e935ce-1ac4-40cd-97d9-e8f32bab97d5,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:11|97|99|83|106|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 32c0b2ba745711f0b33aeb1e7f16c2b6-20250808
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <jay.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 162280590; Fri, 08 Aug 2025 20:57:11 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 8 Aug 2025 20:57:07 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 8 Aug 2025 20:57:07 +0800
From: Jay Liu <jay.liu@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Jay Liu <jay.liu@mediatek.com>
Subject: [PATCH v3 4/6] dt-bindings: display: mediatek: disp-tdshp: Add support for MT8196
Date: Fri, 8 Aug 2025 20:53:59 +0800
Message-ID: <20250808125512.9788-5-jay.liu@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250808125512.9788-1-jay.liu@mediatek.com>
References: <20250808125512.9788-1-jay.liu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Add disp-tdshp hardware description for MediaTek MT8196 SoC

Signed-off-by: Jay Liu <jay.liu@mediatek.com>
---
 .../display/mediatek/mediatek,disp-tdshp.yaml | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml
new file mode 100644
index 000000000000..94aa33a2a5ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/mediatek/mediatek,disp-tdshp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek display 2D sharpness processor
+
+maintainers:
+  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
+  - Philipp Zabel <p.zabel@pengutronix.de>
+
+description: |
+  MediaTek display 2D sharpness processor, namely TDSHP, provides a
+  operation used to adjust sharpness in display system.
+  TDSHP device node must be siblings to the central MMSYS_CONFIG node.
+  For a description of the MMSYS_CONFIG binding, see
+  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
+  for details.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8196-disp-tdshp
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      disp-tdshp@321e0000 {
+          compatible = "mediatek,mt8196-disp-tdshp";
+          reg = <0 0x321e0000 0 0x1000>;
+          clocks = <&dispsys_config_clk 107>;
+      };
+    };
-- 
2.46.0


