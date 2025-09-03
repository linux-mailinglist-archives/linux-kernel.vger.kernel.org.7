Return-Path: <linux-kernel+bounces-797891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 200D5B416D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3D2547A76
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825AE2DE710;
	Wed,  3 Sep 2025 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W9I06kB8"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856602DC330
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885020; cv=none; b=kEWRg7N0i6HWOY+TJee5DkVI4aUjoENH6G8QlV9Q3D3FIF6Lg4SjW2grN22DO+RcrWFkvgnWdBEkDMQhy29hXVig8jSJFOfr9VOMwkRT21m+EBPDi8mEFRxZKCOZOIz1OwJnd6+PDAt74syJ9QOUVElIrXrWEJoycB43srcK2zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885020; c=relaxed/simple;
	bh=g3tgyOs23YpUvObhE0YplDgm3jnpZOHrz8FpnHVIPfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Eo+zDNSDnklkMNTjx9gbBYSlTPXgzJMeupa3iIuQpkpCmv3Vzh0E+tqoxj5ev6gq9wIFoRYf3qhdUsZ04YVcXTIGij+uBa39XADORfsN7KBFZf3WHod0cPxbayqw24sl8OAhbUWYj3YRzq5AaRlnI38wFACvKzWi0UgCHFNDRmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=W9I06kB8; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250903073655epoutp021de600fb80de2c50501a1b1a9c545a89~htZ0Is5_N0711907119epoutp02c
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:36:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250903073655epoutp021de600fb80de2c50501a1b1a9c545a89~htZ0Is5_N0711907119epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756885015;
	bh=n+ccpHfpuSvqRE/S9bXMM814UA2wwwc6G81EdmNEHxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9I06kB8XMxsCyYj1hBm8af6ZUXOgiHp2aaCCIKhm+XyGHWzyj+ZrMfx3TEIL4cXy
	 AXQx7Hb3+nnN1YQWiliYT1GBpu0vROD4jBR7bWYmzwMRA2HY71gJcqjx7RdA+AiWku
	 YhnGrqg1OSKrrQx8dAZkr9jqUPPZLmK0Dpew/194=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20250903073654epcas2p2b977e318ee22d780716a3dfe2e24f978~htZzWCftL0888008880epcas2p2N;
	Wed,  3 Sep 2025 07:36:54 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.36.92]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cGvZG1v8wz3hhT9; Wed,  3 Sep
	2025 07:36:54 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250903073653epcas2p4cb25058c97aab9a30c7e68ef5f10fb91~htZyBr--N0242502425epcas2p49;
	Wed,  3 Sep 2025 07:36:53 +0000 (GMT)
Received: from asswp60 (unknown [10.229.9.60]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250903073653epsmtip2e0ddaa81875a8957ac8c69675b5cb1f3~htZx80LMz3060930609epsmtip2m;
	Wed,  3 Sep 2025 07:36:53 +0000 (GMT)
From: Shin Son <shin.son@samsung.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Shin Son <shin.son@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: thermal: samsung: Add tmu-name and
 sensor-index-ranges properties
Date: Wed,  3 Sep 2025 16:36:32 +0900
Message-ID: <20250903073634.1898865-2-shin.son@samsung.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903073634.1898865-1-shin.son@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250903073653epcas2p4cb25058c97aab9a30c7e68ef5f10fb91
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250903073653epcas2p4cb25058c97aab9a30c7e68ef5f10fb91
References: <20250903073634.1898865-1-shin.son@samsung.com>
	<CGME20250903073653epcas2p4cb25058c97aab9a30c7e68ef5f10fb91@epcas2p4.samsung.com>

The exynosautov920 TMU requires per-sensor interrupt enablement
for its critical trip points.
Add a DT property to the Samsung thermal bindings
to support this requirement:

- **samsung,hw-sensor-indices**: Defines the sensors currently
                                 mapped to the TMU hardware.
				 Indices not listed are absent or fused off

Additionally, add myself to the bindings' maintainers list, as I plan
to actively work on the exynosautov920 TMU support and handle further
updates in this area.

Signed-off-by: Shin Son <shin.son@samsung.com>
---
 .../bindings/thermal/samsung,exynos-thermal.yaml | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
index 29a08b0729ee..abd89902d33a 100644
--- a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
@@ -8,6 +8,7 @@ title: Samsung Exynos SoC Thermal Management Unit (TMU)
 
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
+  - Shin Son <shin.son@samsung.com>
 
 description: |
   For multi-instance tmu each instance should have an alias correctly numbered
@@ -27,6 +28,7 @@ properties:
       - samsung,exynos5420-tmu-ext-triminfo
       - samsung,exynos5433-tmu
       - samsung,exynos7-tmu
+      - samsung,exynosautov920-tmu
 
   clocks:
     minItems: 1
@@ -62,11 +64,22 @@ properties:
     minItems: 1
 
   '#thermal-sensor-cells':
-    const: 0
+    enum:
+      - 0
+      - 1
 
   vtmu-supply:
     description: The regulator node supplying voltage to TMU.
 
+  samsung,hw-sensor-indices:
+    description: |
+      List of hardware sensor indices that are physically present and usable
+      in this TMU instance. Indices not listed are either unmapped or unused.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 16
+    uniqueItems: true
+
 required:
   - compatible
   - clocks
@@ -131,6 +144,7 @@ allOf:
               - samsung,exynos5250-tmu
               - samsung,exynos5260-tmu
               - samsung,exynos5420-tmu
+              - samsung,exynosautov920-tmu
     then:
       properties:
         clocks:
-- 
2.50.1


