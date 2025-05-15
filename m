Return-Path: <linux-kernel+bounces-649307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C40AB82DC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 11:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98A2862CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 09:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC95298983;
	Thu, 15 May 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="seW5oAkm"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558272980CA;
	Thu, 15 May 2025 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301713; cv=none; b=O8tfjjb9VkfLUuGkple9zUXSgUMBAv6ti+yfOMT7QMKZD3QtYH6Z6KcQ9mdk5atlrvhpILAYPIfDD3esN/unsTPmUSh3MyLHB0C8rB5Byq3nJ1shdYc+lirxtoAPXQ5M0T7xZbgLFTRSpgpY60TT92RInPaGd+H6fULLg6nNm9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301713; c=relaxed/simple;
	bh=Aq4i5kPGAZi1+fsbO+JcKi3bA/lJlffPf5jUzqG1Q6o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMUKKXzAu8ogTV8x//3+swxeR0K/rD982k+bpKCg9WPCE8VraeMBphgwlrua6h0XeIrp9/RLW1WAwZaMy6PccGJEwRq+WOA5w3K5f00pWti7GboAdsJWoE2KQJnqKnqx7wf9a75VaC8aqWhVcUdOz+quCP2JiLa2Pu+VW3h1haA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=seW5oAkm; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e0c48a06316f11f082f7f7ac98dee637-20250515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=EhstDddaxzl5Bx8irE851VOAXZ1zEM3qne4moJza4Fc=;
	b=seW5oAkmLL7/xlbiIY0A31lHvr2vNBN9UfNuPX/uS39GX/jvCnU6uVAHn2TjMNu0BSwxGeUHR6MQRSWbr0/aHW8+6QOW9jaMUQXyFnXr8H0TpL1d1QdHfjTgrwTt8dPtI0rZNmQHtYVaQEij6a8ZAUL2jzeQAT7IJ93XnZ4gvxE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:4f5862d5-8d4a-44d4-b8b9-6ee3d78cc48d,IP:0,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:0ef645f,CLOUDID:38d6093e-da74-431d-a7be-5e6761de3b64,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:11|97|99|83|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e0c48a06316f11f082f7f7ac98dee637-20250515
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <paul-pl.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1284957745; Thu, 15 May 2025 17:35:03 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 15 May 2025 17:35:01 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 15 May 2025 17:35:01 +0800
From: paul-pl.chen <paul-pl.chen@mediatek.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<chunkuang.hu@kernel.org>, <angelogioacchino.delregno@collabora.com>
CC: <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
	<jason-jh.lin@mediatek.com>, <nancy.lin@mediatek.com>,
	<singo.chang@mediatek.com>, <xiandong.wang@mediatek.com>,
	<sirius.wang@mediatek.com>, <paul-pl.chen@mediatek.com>,
	<sunny.shen@mediatek.com>, <fshao@chromium.org>, <treapking@chromium.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 03/17] dt-bindings: display: mediatek: add BLENDER yaml for MT8196
Date: Thu, 15 May 2025 17:34:15 +0800
Message-ID: <20250515093454.1729720-4-paul-pl.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250515093454.1729720-1-paul-pl.chen@mediatek.com>
References: <20250515093454.1729720-1-paul-pl.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Paul-pl Chen <paul-pl.chen@mediatek.com>

Add mediatek,blender.yaml to support BLENDER for MT8196.
MediaTek display overlap blender, namely OVL_BLENDER or BLENDER,
executes the alpha blending function for overlapping layers
from different sources.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Signed-off-by: Nancy Lin <nancy.lin@mediatek.com>
Signed-off-by: Paul-pl Chen <paul-pl.chen@mediatek.com>
---
 .../display/mediatek/mediatek,blender.yaml    | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,blender.yaml

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,blender.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,blender.yaml
new file mode 100644
index 000000000000..4b85f6ac40a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,blender.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/mediatek/mediatek,blender.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Display Overlap Blender
+
+maintainers:
+  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
+  - Philipp Zabel <p.zabel@pengutronix.de>
+
+description:
+  MediaTek display overlap blender, namely OVL_BLENDER or BLENDER,
+  executes the alpha blending function for overlapping layers
+  from different sources. This is the primary function of the
+  overlapping system.
+
+properties:
+  compatible:
+    const: mediatek,mt8196-blender
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
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        blender0: blender@328d0000 {
+            compatible = "mediatek,mt8196-blender";
+            reg = <0 0x328d0000 0 0x1000>;
+            clocks = <&ovlsys_config_clk 29>;
+        };
+    };
-- 
2.45.2


