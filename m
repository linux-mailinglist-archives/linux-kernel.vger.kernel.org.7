Return-Path: <linux-kernel+bounces-780769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74184B30923
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58FE44E68A2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022C82EB5BE;
	Thu, 21 Aug 2025 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzTCqX7y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3490E2E5B3F;
	Thu, 21 Aug 2025 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814920; cv=none; b=LACnWPNNnQ/u8G8nqJC650MZ4/3Xc+DIxEysFzlCMspL8pvDPBwereJPO8jl23/3eHxNZQ5QriOl0DoHe0zGNdYnfscWd1pmuaZ6s7L8PkFvhbZzjdg9nadvRjXq6PJ43+5v5pE+XGqR5R2Y69KjnsGdCLr/ECRjmEwXT5D0SiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814920; c=relaxed/simple;
	bh=2qUFmKIc8dgW0sppRnM8ESYR2FM7rSakcDha5DKYaeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rs0nIX+QF3NjaigTXC9PyJGHbE+PIpBI+WfEk3T1+thJpOUkrLvBPn3zz4MZOG8uMZyrcba8dCQxCKTpNctHXD5lvs3oBA3Rn01ySzs2s5nIfG1u1sWxcfwSRev0LhYKWmyX+SCpdDQEDXLlsroGgVRElApW7tKItY3+EzWVS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzTCqX7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47541C4CEEB;
	Thu, 21 Aug 2025 22:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755814919;
	bh=2qUFmKIc8dgW0sppRnM8ESYR2FM7rSakcDha5DKYaeM=;
	h=From:To:Cc:Subject:Date:From;
	b=VzTCqX7yFnXdA+HluALWQoO115c536zHOAN2+1uQzZXQgd2vTCSxRknvOoTyQ5LtS
	 tAEBTFN+0uf6hNwpJlEa/wZhZT3YzAIaD0rMI9SjIixenZfMujesMzRo35v8f0bpmj
	 YXLej9NCZeVEOMXFFLxdAvCO3wwTkehyNA6Wdsp1Z18iDIOc31GWjQZ0eGajjT5OYq
	 Mf+2LU8S4zZzUkkj1grugQf42EWheBw2J59NarQ1BeAeEBCVkdsdm3EjtwwMwrKEIV
	 Rq8hFrPf/xXPUKtaYy4yPlMrVPh1bPQTiGLnlLPIi7mzrFqcP8q7J/e6zNoMWOMRR5
	 gsI7YPCIAHvhg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: vendor-prefixes: Add undocumented vendor prefixes
Date: Thu, 21 Aug 2025 17:21:33 -0500
Message-ID: <20250821222136.1027269-1-robh@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add various vendor prefixes which are in use in compatible strings
already. These were found by modifying vendor-prefixes.yaml into a
schema to check compatible strings.

The added prefixes doesn't include various duplicate prefixes in use
such as "lge".

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/vendor-prefixes.yaml  | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 77160cd47f54..0f5273123650 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -86,6 +86,8 @@ patternProperties:
     description: Allegro DVT
   "^allegromicro,.*":
     description: Allegro MicroSystems, Inc.
+  "^alliedtelesis,.*":
+    description: Allied Telesis, Inc.
   "^alliedvision,.*":
     description: Allied Vision Technologies GmbH
   "^allo,.*":
@@ -229,6 +231,8 @@ patternProperties:
     description: Bitmain Technologies
   "^blaize,.*":
     description: Blaize, Inc.
+  "^bluegiga,.*":
+    description: Bluegiga Technologies Ltd.
   "^blutek,.*":
     description: BluTek Power
   "^boe,.*":
@@ -247,6 +251,8 @@ patternProperties:
     description: Bticino International
   "^buffalo,.*":
     description: Buffalo, Inc.
+  "^buglabs,.*":
+    description: Bug Labs, Inc.
   "^bur,.*":
     description: B&R Industrial Automation GmbH
   "^bytedance,.*":
@@ -325,6 +331,8 @@ patternProperties:
     description: Conexant Systems, Inc.
   "^colorfly,.*":
     description: Colorful GRP, Shenzhen Xueyushi Technology Ltd.
+  "^compal,.*":
+    description: Compal Electronics, Inc.
   "^compulab,.*":
     description: CompuLab Ltd.
   "^comvetia,.*":
@@ -353,6 +361,8 @@ patternProperties:
     description: Guangzhou China Star Optoelectronics Technology Co., Ltd
   "^csq,.*":
     description: Shenzen Chuangsiqi Technology Co.,Ltd.
+  "^csr,.*":
+    description: Cambridge Silicon Radio
   "^ctera,.*":
     description: CTERA Networks Intl.
   "^ctu,.*":
@@ -455,6 +465,8 @@ patternProperties:
     description: Emtop Embedded Solutions
   "^eeti,.*":
     description: eGalax_eMPIA Technology Inc
+  "^egnite,.*":
+    description: egnite GmbH
   "^einfochips,.*":
     description: Einfochips
   "^eink,.*":
@@ -485,8 +497,12 @@ patternProperties:
     description: Empire Electronix
   "^emtrion,.*":
     description: emtrion GmbH
+  "^enbw,.*":
+    description: Energie Baden-Württemberg AG
   "^enclustra,.*":
     description: Enclustra GmbH
+  "^endian,.*":
+    description: Endian SRL
   "^endless,.*":
     description: Endless Mobile, Inc.
   "^ene,.*":
@@ -552,6 +568,8 @@ patternProperties:
     description: FocalTech Systems Co.,Ltd
   "^forlinx,.*":
     description: Baoding Forlinx Embedded Technology Co., Ltd.
+  "^foxlink,.*":
+    description: Foxlink Group
   "^freebox,.*":
     description: Freebox SAS
   "^freecom,.*":
@@ -640,6 +658,10 @@ patternProperties:
     description: Haoyu Microelectronic Co. Ltd.
   "^hardkernel,.*":
     description: Hardkernel Co., Ltd
+  "^hce,.*":
+    description: HCE Engineering SRL
+  "^headacoustics,.*":
+    description: HEAD acoustics
   "^hechuang,.*":
     description: Shenzhen Hechuang Intelligent Co.
   "^hideep,.*":
@@ -723,6 +745,8 @@ patternProperties:
     description: Shenzhen INANBO Electronic Technology Co., Ltd.
   "^incircuit,.*":
     description: In-Circuit GmbH
+  "^incostartec,.*":
+    description: INCOstartec GmbH
   "^indiedroid,.*":
     description: Indiedroid
   "^inet-tek,.*":
@@ -931,6 +955,8 @@ patternProperties:
     description: Maxim Integrated Products
   "^maxlinear,.*":
     description: MaxLinear Inc.
+  "^maxtor,.*":
+    description: Maxtor Corporation
   "^mbvl,.*":
     description: Mobiveil Inc.
   "^mcube,.*":
@@ -1094,6 +1120,8 @@ patternProperties:
     description: Nordic Semiconductor
   "^nothing,.*":
     description: Nothing Technology Limited
+  "^novatech,.*":
+    description: NovaTech Automation
   "^novatek,.*":
     description: Novatek
   "^novtech,.*":
@@ -1189,6 +1217,8 @@ patternProperties:
     description: Pervasive Displays, Inc.
   "^phicomm,.*":
     description: PHICOMM Co., Ltd.
+  "^phontech,.*":
+    description: Phontech
   "^phytec,.*":
     description: PHYTEC Messtechnik GmbH
   "^picochip,.*":
@@ -1273,6 +1303,8 @@ patternProperties:
     description: Ramtron International
   "^raspberrypi,.*":
     description: Raspberry Pi Foundation
+  "^raumfeld,.*":
+    description: Raumfeld GmbH
   "^raydium,.*":
     description: Raydium Semiconductor Corp.
   "^rda,.*":
@@ -1311,6 +1343,8 @@ patternProperties:
     description: ROHM Semiconductor Co., Ltd
   "^ronbo,.*":
     description: Ronbo Electronics
+  "^ronetix,.*":
+    description: Ronetix GmbH
   "^roofull,.*":
     description: Shenzhen Roofull Technology Co, Ltd
   "^roseapplepi,.*":
@@ -1337,8 +1371,12 @@ patternProperties:
     description: Schindler
   "^schneider,.*":
     description: Schneider Electric
+  "^schulercontrol,.*":
+    description: Schuler Group
   "^sciosense,.*":
     description: ScioSense B.V.
+  "^sdmc,.*":
+    description: SDMC Technology Co., Ltd
   "^seagate,.*":
     description: Seagate Technology PLC
   "^seeed,.*":
@@ -1377,6 +1415,8 @@ patternProperties:
     description: Si-En Technology Ltd.
   "^si-linux,.*":
     description: Silicon Linux Corporation
+  "^sielaff,.*":
+    description: Sielaff GmbH & Co.
   "^siemens,.*":
     description: Siemens AG
   "^sifive,.*":
@@ -1445,6 +1485,8 @@ patternProperties:
     description: SolidRun
   "^solomon,.*":
     description: Solomon Systech Limited
+  "^somfy,.*":
+    description: Somfy Systems Inc.
   "^sony,.*":
     description: Sony Corporation
   "^sophgo,.*":
@@ -1515,6 +1557,8 @@ patternProperties:
   "^synopsys,.*":
     description: Synopsys, Inc. (deprecated, use snps)
     deprecated: true
+  "^taos,.*":
+    description: Texas Advanced Optoelectronic Solutions Inc.
   "^tbs,.*":
     description: TBS Technologies
   "^tbs-biometrics,.*":
@@ -1545,6 +1589,8 @@ patternProperties:
     description: Teltonika Networks
   "^tempo,.*":
     description: Tempo Semiconductor
+  "^tenda,.*":
+    description: Shenzhen Tenda Technology Co., Ltd.
   "^terasic,.*":
     description: Terasic Inc.
   "^tesla,.*":
@@ -1648,6 +1694,8 @@ patternProperties:
     description: V3 Semiconductor
   "^vaisala,.*":
     description: Vaisala
+  "^valve,.*":
+    description: Valve Corporation
   "^vamrs,.*":
     description: Vamrs Ltd.
   "^variscite,.*":
@@ -1748,6 +1796,8 @@ patternProperties:
     description: Extreme Engineering Solutions (X-ES)
   "^xiaomi,.*":
     description: Xiaomi Technology Co., Ltd.
+  "^xicor,.*":
+    description: Xicor Inc.
   "^xillybus,.*":
     description: Xillybus Ltd.
   "^xingbangda,.*":
-- 
2.50.1


