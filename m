Return-Path: <linux-kernel+bounces-777428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68C4B2D92A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD837BBFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F122EE272;
	Wed, 20 Aug 2025 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TgcqEcVz"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9EB2DE711;
	Wed, 20 Aug 2025 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755683161; cv=none; b=I3HZCU6JWRFc/0Hfr/tmUMpx2sCV6IEPY8Q/Oulb1e2RDtFdkQQoxiU+UAGB6LPTIjI4J00elIe3hB8bBGTG1J2I3IscsedTxy2G+4OJS9ceEBPg8hNPTfe3DjrLs4l76TnYYP4uYPIVEfPxrRRyPOqmsXKMGEd/zNb+4+338Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755683161; c=relaxed/simple;
	bh=AXAko9vaxnm4ExGe1sc0sBe32VhH6MBje5rezV3nZVI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/BMdbHncKhB0d0dgNl/ZFVCE62WnvGvuHcqNMTl9Wf3g79GWtc0jyLJeL5yLs6JQh7BdxNI5D45XD8ayxLWfQwIHLN8Cs4W+a2k9bqe/7gxQIVUQC1zwoTbzD3e3uelWUHzAcsrLzgDYsyEbYla6s8WLxIDmlsHaKCsjNXvY2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TgcqEcVz; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7530424e7daa11f0b33aeb1e7f16c2b6-20250820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=w78QeFyGreVf7tMSy4TKKfr5c2/3G42Hlc0lLvKZiDE=;
	b=TgcqEcVzrWWfmsTGCPSnNwsiMIvc3AVPnTyVgiRhmbri2bSXHjg50SEyh+S3kYCY/2jf28HZoSze3iALF3pniKpRoDNn9fqqF8UjMHMZwMf6vDcS1HcJLmFT4qC13VDBArnQmy08YmF34gL8CjSOLne/D6hNh61IW0iN5Oe48fA=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.3.3,REQID:b2f03362-1daf-4712-a1fa-47baa45fae1f,IP:0,UR
	L:25,TC:0,Content:100,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Spam_GS6885AD,ACT
	ION:quarantine,TS:125
X-CID-META: VersionHash:f1326cf,CLOUDID:3fb6547a-966c-41bd-96b5-7d0b3c22e782,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|801,TC:-5,Content:3|15|50,EDM:
	-3,IP:nil,URL:11|97|99|83|106|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7530424e7daa11f0b33aeb1e7f16c2b6-20250820
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1310600732; Wed, 20 Aug 2025 17:45:51 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 20 Aug 2025 17:45:48 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 20 Aug 2025 17:45:47 +0800
From: Jjian Zhou <jjian.zhou@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Jjian Zhou
	<Jjian.Zhou@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jjian Zhou
	<jjian.zhou@mediatek.com>
Subject: [PATCH v4 1/2] dt-bindings: mailbox: mediatek,mt8196-vcp-mbox: add mtk vcp-mbox document
Date: Wed, 20 Aug 2025 17:45:37 +0800
Message-ID: <20250820094545.23821-2-jjian.zhou@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250820094545.23821-1-jjian.zhou@mediatek.com>
References: <20250820094545.23821-1-jjian.zhou@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

The MTK VCP mailbox enables the SoC to communicate with the VCP by passing
messages through 64 32-bit wide registers. It has 32 interrupt vectors in
either direction for signalling purposes.

This adds a binding for Mediatek VCP mailbox.

Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
---
 .../mailbox/mediatek,mt8196-vcp-mbox.yaml     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,mt8196-vcp-mbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,mt8196-vcp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,mt8196-vcp-mbox.yaml
new file mode 100644
index 000000000000..bd1b024e22f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/mediatek,mt8196-vcp-mbox.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/mtk,mt8196-vcp-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Video Companion Processor (VCP) mailbox
+
+maintainers:
+  - Jjian Zhou <Jjian.Zhou@mediatek.com>
+
+description:
+  The MTK VCP mailbox enables the SoC to communicate with the VCP by passing
+  messages through 64 32-bit wide registers. It has 32 interrupt vectors in
+  either direction for signalling purposes.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8196-vcp-mbox
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#mbox-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#mbox-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mailbox@31b80000 {
+        compatible = "mediatek,mt8196-vcp-mbox";
+        reg = <0x31b80000 0x1000>;
+        interrupts = <GIC_SPI 789 IRQ_TYPE_LEVEL_HIGH 0>;
+        #mbox-cells = <0>;
+    };
--
2.45.2


