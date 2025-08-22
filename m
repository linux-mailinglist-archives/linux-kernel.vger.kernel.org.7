Return-Path: <linux-kernel+bounces-781522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E57B3137B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563B91D03468
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2733C2EBDD7;
	Fri, 22 Aug 2025 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KspxgxsT"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC37421D5B3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855014; cv=none; b=iAX6MJm+DBLbIgAYQ5lemyca12HgHbr4Pgr4xBwTJXSUdvmaV1h/MRqkunPggbfHpNPNb7wx4UasLjv6bOuwsZqsaooFXDta8+NFOgG2gmqGPRIYPTpAjagSyafxo0xNAttkwMC4SQE6pgH0th0GvitWd1cpzgSCPG5X1HleLJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855014; c=relaxed/simple;
	bh=88Lt4aP+ewswjg17OSpE6y4lwdUPoRldgDkV/MhYvKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=noG2SXV9JqmzY73y3JGZeyUhqNqWTI3kZWqZSnMg20wTObElhpPE/oj5VeuERmA/S+L3q4+54UF3TkH4ca0X5MtUgXiQyx6awWgufVsrLnZcVaC4K7YezsH9zzId1isZoekoDo+FHA88f68nUxUx/u43XglBAPnBkZ/i7lwbYwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KspxgxsT; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250822093010epoutp01c1bcab774e59deead995456f227fd170~eDNROMV1c2094620946epoutp01b
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:30:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250822093010epoutp01c1bcab774e59deead995456f227fd170~eDNROMV1c2094620946epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755855010;
	bh=/UZny0nmt2vMBkU2e/gpL3R9Mx0QIOy020xV8xd0zVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KspxgxsTX4TCaH/kI7B3FiCoebY2C/QwexF5hEphgpwJmwcyX9DPoqUn9Tq3s9Zdu
	 KUExtZAB6quu0rbvSdjeqNvL5SZsb0gC55m5cxAd52rbRVJGCnozN7D7e9otWCZ3AW
	 BomZXP6DtHsU7154fqGM6m1yBF2mGwq7RqJN1YR4=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250822093010epcas5p4db619c0e6cb35c784f0f67dcec6f63ea~eDNQq1pdH1315013150epcas5p4M;
	Fri, 22 Aug 2025 09:30:10 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.92]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4c7ZfT13Pqz6B9m6; Fri, 22 Aug
	2025 09:30:09 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250822093008epcas5p218f9f9a5381a716b5b8e0c4b23e4b3bf~eDNPSC-fN1655716557epcas5p2D;
	Fri, 22 Aug 2025 09:30:08 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250822093005epsmtip229ae5445f3c8672966c8d22df05031b4~eDNMTiRZd0037000370epsmtip2R;
	Fri, 22 Aug 2025 09:30:05 +0000 (GMT)
From: Pritam Manohar Sutar <pritam.sutar@samsung.com>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	andre.draszik@linaro.org, peter.griffin@linaro.org, kauschluss@disroot.org,
	ivo.ivanov.ivanov1@gmail.com, igor.belwon@mentallysanemainliners.org,
	johan@kernel.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
	pritam.sutar@samsung.com
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rosa.pila@samsung.com,
	dev.tailor@samsung.com, faraz.ata@samsung.com, muhammed.ali@samsung.com,
	selvarasu.g@samsung.com
Subject: [PATCH v7 1/6] dt-bindings: phy: samsung,usb3-drd-phy: add
 ExynosAutov920 HS phy compatible
Date: Fri, 22 Aug 2025 15:08:40 +0530
Message-Id: <20250822093845.1179395-2-pritam.sutar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822093845.1179395-1-pritam.sutar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250822093008epcas5p218f9f9a5381a716b5b8e0c4b23e4b3bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250822093008epcas5p218f9f9a5381a716b5b8e0c4b23e4b3bf
References: <20250822093845.1179395-1-pritam.sutar@samsung.com>
	<CGME20250822093008epcas5p218f9f9a5381a716b5b8e0c4b23e4b3bf@epcas5p2.samsung.com>

This SoC has USB2.0 phy and supports only UTMI+ interface. This phy
requires two clocks, named as "phy" and "ref". The required supplies for
this phy are vdd075_usb20(0.75v), vdd18_usb20(1.8v), vdd33_usb20(3.3v).

Add a dedicated compatible string for USB HS phy found in this SoC.

Signed-off-by: Pritam Manohar Sutar <pritam.sutar@samsung.com>
---
 .../bindings/phy/samsung,usb3-drd-phy.yaml    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
index e906403208c0..e238fd0c9f6c 100644
--- a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
@@ -34,6 +34,7 @@ properties:
       - samsung,exynos7870-usbdrd-phy
       - samsung,exynos850-usbdrd-phy
       - samsung,exynos990-usbdrd-phy
+      - samsung,exynosautov920-usbdrd-phy
 
   clocks:
     minItems: 1
@@ -110,6 +111,12 @@ properties:
   vddh-usbdp-supply:
     description: VDDh power supply for the USB DP phy.
 
+  dvdd075-usb20-supply:
+    description: 0.75V power supply for the USB 2.0 phy.
+
+  vdd18-usb20-supply:
+    description: 1.8V power supply for the USB 2.0 phy.
+
 required:
   - compatible
   - clocks
@@ -219,6 +226,7 @@ allOf:
               - samsung,exynos7870-usbdrd-phy
               - samsung,exynos850-usbdrd-phy
               - samsung,exynos990-usbdrd-phy
+              - samsung,exynosautov920-usbdrd-phy
     then:
       properties:
         clocks:
@@ -235,6 +243,22 @@ allOf:
 
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
+        - dvdd075-usb20-supply
+        - vdd18-usb20-supply
+        - vdd33-usb20-supply
+
+    else:
+      properties:
+        dvdd075-usb20-supply: false
+        vdd18-usb20-supply: false
 
 unevaluatedProperties: false
 
-- 
2.34.1


