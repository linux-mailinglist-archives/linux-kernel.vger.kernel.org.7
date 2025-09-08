Return-Path: <linux-kernel+bounces-805076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B464AB483BF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D3917512E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8B821FF35;
	Mon,  8 Sep 2025 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HZIZUfgx"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A3E36B;
	Mon,  8 Sep 2025 05:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757310402; cv=none; b=TRk5zcAEpXZ4VEJY4H/RJRMxlb0edeGUGli/S4AJYayIIis4RUu6uvAsVaMLEPiH1aSyN9bCWee3xItcnZbHcLDGZJ6dAQ7XioFTSBP+Qmqukf7mDKihaBeJEc9Od0tIpNFFPj1/8ulDILzEeRSrQo66H8gnBpokkSZYn8QDKs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757310402; c=relaxed/simple;
	bh=IhlDzU8v4sxj9kgiVqNqdxcAcjHWZWp+A0k2p7rweT4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hJVvI0u2Hqp3bknc2fpkguBRnWt/pNf3e6DtQf85nh4ZKNgbm5mJ13lbyn09SX17Ms8X1Wtfd+xCaw8TbjoZ6dcDnxWvUUOAhMO8dCEp9FuQ+DKgeoZpVJ8gM9TuXAJEggMnwQZFHMlStc3gS5TLOgy5NkJfBGYwrmN08YLQZ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HZIZUfgx; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5885kIoT4177018;
	Mon, 8 Sep 2025 00:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757310378;
	bh=6JUrHOaCwdFcfKI+71eVuDBjCs4fIIRwLXH05PdzWro=;
	h=From:To:CC:Subject:Date;
	b=HZIZUfgx9/+2hXStkyI1e5YjwCa3Gs5R5Uyn2z5QugAWvNVK76VxdUpFjA12cA9Cn
	 wUI326LFYvARVpLuJ185dmmI8GXWZWoHwCs98vqx3AjmJmrx7IQ6/PAO//kCtSd+cX
	 AiQCOqBGt83MauU2GQ8PoowVNtDS1Gfwe756ZnkY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5885kHCb2775068
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 00:46:17 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 00:46:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 00:46:16 -0500
Received: from hkshenoy.dhcp.ti.com (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5885k960075469;
	Mon, 8 Sep 2025 00:46:10 -0500
From: Harikrishna Shenoy <h-shenoy@ti.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <sjakhade@cadence.com>, <yamonkar@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devarsht@ti.com>, <u-kumar1@ti.com>,
        <s-jain1@ti.com>
CC: <h-shenoy@ti.com>
Subject: [PATCH v3] dt-bindings: drm/bridge: MHDP8546 bridge binding changes for DSC
Date: Mon, 8 Sep 2025 11:16:09 +0530
Message-ID: <20250908054609.1113360-1-h-shenoy@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Swapnil Jakhade <sjakhade@cadence.com>

Add binding changes for DSC(Display Stream Compression) in the MHDP8546
DPI/DP bridge.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
---
Changelog v2 --> v3:
-Update the name of dsc register block.
-Add the reg-name list in conditional based on compatible.
Link to v2- https://lore.kernel.org/all/20250903111357.2605199-1-h-shenoy@ti.com/

 .../display/bridge/cdns,mhdp8546.yaml         | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
index c2b369456e4e..eb51f9595da8 100644
--- a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
@@ -27,6 +27,8 @@ properties:
           Register block for DSS_EDP0_INTG_CFG_VP registers in case of TI J7 SoCs.
       - description:
           Register block of mhdptx sapb registers.
+      - description:
+          Register block for mhdptx DSC encoder registers.
 
   reg-names:
     minItems: 1
@@ -34,6 +36,7 @@ properties:
       - const: mhdptx
       - const: j721e-intg
       - const: mhdptx-sapb
+      - const: dsc
 
   clocks:
     maxItems: 1
@@ -100,18 +103,27 @@ allOf:
       properties:
         reg:
           minItems: 2
-          maxItems: 3
+          maxItems: 4
         reg-names:
           minItems: 2
-          maxItems: 3
+          maxItems: 4
+          items:
+            - const: mhdptx
+            - const: j721e-intg
+            - const: mhdptx-sapb
+            - const: dsc
     else:
       properties:
         reg:
           minItems: 1
-          maxItems: 2
+          maxItems: 3
         reg-names:
           minItems: 1
-          maxItems: 2
+          maxItems: 3
+          items:
+            - const: mhdptx
+            - const: mhdptx-sapb
+            - const: dsc
 
 required:
   - compatible
-- 
2.34.1


