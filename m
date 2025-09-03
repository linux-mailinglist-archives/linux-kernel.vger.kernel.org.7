Return-Path: <linux-kernel+bounces-797868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AAFB4167D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468311887724
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470032DCF55;
	Wed,  3 Sep 2025 07:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Efuz+Vbw"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B81E2DA74D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884582; cv=none; b=Zlh82YUtD0Fgg5WXy6qxWUhiL5uXnJlB1w1A1164m/GpgCmE/iYLwVfkfCXvDixXhFiCevomKMB5L0fAS/IVBmdneQewPQE45CRGktB9nGoZuXqlHF4tSu6PKXTUV/Cn6RxOv05/npoEIc6RHnRMcsv20BtlOwjCb4VZv93wuRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884582; c=relaxed/simple;
	bh=d+P1sCzPwT6rsH5h10bLtBk+dAxWn3P60LDgemHQfwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=LDuUSDhJZ6inTqL4IDdBk7U+uB18IkeEg0kbDhyEGJ1dr8qXHqetZLtrQKgmseUV1g0vwSahGZWsiLkD3QwJOvl4cHYcZkQj3Up349Fq0CK5e5ZAVSaVT7Q4Ws5xInpDyzDDrO9LgXzN3GVxViy1P/OWkMgbsg9B8sHFNstJ5W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Efuz+Vbw; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250903072938epoutp01c6348dc397bfe14cc35a2380cce0209a~htTdRdfsl1339713397epoutp01y
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:29:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250903072938epoutp01c6348dc397bfe14cc35a2380cce0209a~htTdRdfsl1339713397epoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756884578;
	bh=1cHHzvpcToVfUQ+s6oKU0F9PCcevPZTTm727qZ7syWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Efuz+Vbwwk8pbAgOELhnkw7hJu1m8keUdVoSODbouG7xhGThr6vyO1uULlJFKmh1c
	 hvBNyY2zj/iznMaBT9BphmP2w9KrirP60YU5uGZxITVaJBRzi/FZGZPHyT2vIVvyTF
	 5lz4f9Ighpe8Nx5gOE7c/kjDSjESnnZlsT4bUlNY=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250903072937epcas5p363acb7df02fcdd202b8299e1b35f697e~htTccMDIK2807428074epcas5p3D;
	Wed,  3 Sep 2025 07:29:37 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.92]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cGvPr5vCcz6B9m5; Wed,  3 Sep
	2025 07:29:36 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250903072936epcas5p4a28d0e63c7f0792b516b0cbc68bf3a8e~htTa3DKDo2045620456epcas5p4v;
	Wed,  3 Sep 2025 07:29:36 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250903072932epsmtip20e01ed3ee241f03e3553f0744bf70758~htTXz-USp2480024800epsmtip2N;
	Wed,  3 Sep 2025 07:29:32 +0000 (GMT)
From: Pritam Manohar Sutar <pritam.sutar@samsung.com>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	andre.draszik@linaro.org, peter.griffin@linaro.org, kauschluss@disroot.org,
	ivo.ivanov.ivanov1@gmail.com, igor.belwon@mentallysanemainliners.org,
	m.szyprowski@samsung.com, s.nawrocki@samsung.com, pritam.sutar@samsung.com
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rosa.pila@samsung.com,
	dev.tailor@samsung.com, faraz.ata@samsung.com, muhammed.ali@samsung.com,
	selvarasu.g@samsung.com
Subject: [PATCH v8 1/6] dt-bindings: phy: samsung,usb3-drd-phy: add
 ExynosAutov920 HS phy compatible
Date: Wed,  3 Sep 2025 13:08:22 +0530
Message-Id: <20250903073827.3015662-2-pritam.sutar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903073827.3015662-1-pritam.sutar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250903072936epcas5p4a28d0e63c7f0792b516b0cbc68bf3a8e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250903072936epcas5p4a28d0e63c7f0792b516b0cbc68bf3a8e
References: <20250903073827.3015662-1-pritam.sutar@samsung.com>
	<CGME20250903072936epcas5p4a28d0e63c7f0792b516b0cbc68bf3a8e@epcas5p4.samsung.com>

Document support for the USB20 phy found on the ExynosAutov920 SoC. The
USB20 phy is functionally identical to that on the Exynos850 SoC, so no
driver changes are needed to support this phy. However, add a dedicated
compatible string for USB20 phy found in this SoC.

Signed-off-by: Pritam Manohar Sutar <pritam.sutar@samsung.com>
---
 .../bindings/phy/samsung,usb3-drd-phy.yaml    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
index e906403208c0..8d8114eb5660 100644
--- a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
@@ -34,6 +34,7 @@ properties:
       - samsung,exynos7870-usbdrd-phy
       - samsung,exynos850-usbdrd-phy
       - samsung,exynos990-usbdrd-phy
+      - samsung,exynosautov920-usbdrd-phy
 
   clocks:
     minItems: 1
@@ -110,6 +111,15 @@ properties:
   vddh-usbdp-supply:
     description: VDDh power supply for the USB DP phy.
 
+  dvdd-supply:
+    description: 0.75V power supply for the USB phy.
+
+  vdd18-supply:
+    description: 1.8V power supply for the USB phy.
+
+  vdd33-supply:
+    description: 3.3V power supply for the USB phy.
+
 required:
   - compatible
   - clocks
@@ -219,6 +229,7 @@ allOf:
               - samsung,exynos7870-usbdrd-phy
               - samsung,exynos850-usbdrd-phy
               - samsung,exynos990-usbdrd-phy
+              - samsung,exynosautov920-usbdrd-phy
     then:
       properties:
         clocks:
@@ -236,6 +247,24 @@ allOf:
         reg-names:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynosautov920-usbdrd-phy
+    then:
+      required:
+        - dvdd-supply
+        - vdd18-supply
+        - vdd33-supply
+
+    else:
+      properties:
+        dvdd-supply: false
+        vdd18-supply: false
+        vdd33-supply: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


