Return-Path: <linux-kernel+bounces-832170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46697B9E8B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635FA1BC1F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DE42EB5B2;
	Thu, 25 Sep 2025 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="OYdNO92J"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A9A2EA720
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794647; cv=none; b=OS/2M1aPWee0zEuP/sFg80RX6/512IZT43e0MM6SfAK5Q41DwXM7TcTXHRfZkVE2X9vw9LkakD77BssogyT5kpz9f4ck+tfVF/X0r9rkV5ehRkLzBYV8g1aukvw2wsNrIEWoUIwJ7c20gn1UEwosv6kBKd4o3VmnRSvyWmbOg4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794647; c=relaxed/simple;
	bh=fPHE+4SS6NADEeNKpXr5L2VRjNuZneALXLZC1DzOqF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZkDXP3B2KYGd6FELPdBT2Deoc4Ze+pgZXG434kx/2z4Wem9ynOsWZNgahYLEHPMsBGwaP1XckbtBYFo2dWjb502cTHoZNvnvN8DSV1b16tPGvZH08wbp4dpX9yotpQtj3+8ePxNyXHwg56KeWmwsqBsXKHxbmcAyY+P0LgFIho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=OYdNO92J; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46b7580f09eso4801655e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1758794644; x=1759399444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ev+V/JW5+QM+PIWIe4k3CE87ZcIEVc5Xt1x3/zgMw44=;
        b=OYdNO92JRVwJC5r+jv5N1iTcM5WDHjbfVTDMzo9IPjwrUs/r9NPRmmnGauFuWY6T3H
         Ebx78cisArMU1e0eu3TNk/baYdNrHa5RYde5Ce87bqK1t216M9Qkt325FRQaMWPG6Nsb
         BwvPwH9ckKyWgG5mkEjstrZakj9nEIxZLyTLsUQMENTVfW4gjcXi/uO2a23I6ty9vd9Z
         TMiTTyZomlIzaVX7+QlGO9f9YQlknsOpik7DECyJoI91YuZ5N9wNjdR8MXv2+e8Llm22
         jYhVwrAYbTYqCzJy7ElFnoyGP7pPQMEYcwSknKzyScMi3eBWaU/1w3cBjLafzQ7KC7nn
         kQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758794644; x=1759399444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ev+V/JW5+QM+PIWIe4k3CE87ZcIEVc5Xt1x3/zgMw44=;
        b=lEA6QbdxcH89z2DAvq2UUsGxT5SOHSknc/3igv9o8A9H1hehq2+AjDJJ29yLQE1Z1F
         oR/Pv+z9LvZn9fI8aK+wpeCAYfwqAuR08mRkYSF5NCHvuoxIC5me6d/xm3/xok2TsHBQ
         LMtmKolOxt7ff2inOQF2ryk8fB9BfP1/mHaaP5/VSAW4fniVPjIi5fUUuAJKXDdGW/+p
         /HPAj5b3CzdgaqJSq+1SxMFdWqllkDLIM7neW0XCqL2VAtt75WQApiD70bQi4P8PUjnr
         FsyHWyGtIhCGhVVNp2p/X+8OvveMKAb9pQHGEhpGey/mzd0WX0HKpnIo+hMwmwYU9cTB
         btDA==
X-Forwarded-Encrypted: i=1; AJvYcCURv+qvh1qatwiDXJXZ8mFioNjfuHTqkgmMVmJZKYc7U78tRD2pD+J9PPBjUs3OQFLMEaoQVvuMDAwAOd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwddmANJIgzHaoMl+puwXx7bwLYefv2W2+IRVqHnLbLNufAN2Oq
	FKAUkFTc3Ed8pQoY2mz+cdyjJfEcXasjoyrWUEquoRSANhVf+Q5INCwzXQ5py/M54/c=
X-Gm-Gg: ASbGncvD8rlpKUoZ7ZjZnh3COwOOLFza2/0NpV5QJLrTlwU2xKPPc31wYvPR8EAqXev
	xSNDk6koXh9zioCY4y6rWU5GBhACDzxIfmbA+3JRkZd6yyIOF4RShJXKyTdhrL596RkfOhAQys3
	SdWylpdaCHK3lXlIjvafq3RHLpqcKEpKmVHXMjaS7goBrYFHAZjrR0lKjOFv9MCFVJ5enSD3MZL
	PqKowjXH5TXK0fZKQCniVyBpz4kmOw78P+SGWoqvx5Ex0CuEbF1lVTFWp0Q3tVqCUm+B90YOQrN
	UhWtA9WEwJA2j7t+lI62ulWuq56iUy2bNN3YROC655R9sht6/U9MslUfSJ+jPtSJSlvOEMoBIIu
	V5nxcclyO6zB8PlJT7PGzalbtMY6vCEJCbtgtx5CsMDIHkZSyy3Y6
X-Google-Smtp-Source: AGHT+IHF5IlDl81hhWyikMX5E0qyEzULKekaiiDeU818Ht7Ddn8on2/kQQ7mJhhr2YOOLfwqnUuxuw==
X-Received: by 2002:a05:600c:630f:b0:46e:1c16:7f42 with SMTP id 5b1f17b1804b1-46e329aec2dmr28177585e9.11.1758794643994;
        Thu, 25 Sep 2025 03:04:03 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb6b7sm2501122f8f.2.2025.09.25.03.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:04:03 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v7 3/7] dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/G3S support
Date: Thu, 25 Sep 2025 13:02:58 +0300
Message-ID: <20250925100302.3508038-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925100302.3508038-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250925100302.3508038-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas USB PHY hardware block needs to have the PWRRDY bit in the
system controller set before applying any other settings. The PWRRDY bit
must be controlled during power-on, power-off, and system suspend/resume
sequences as follows:
- during power-on/resume, it must be set to zero before enabling clocks and
  modules
- during power-off/suspend, it must be set to one after disabling clocks
  and modules

Add the renesas,sysc-pwrrdy device tree property, which allows the
reset-rzg2l-usbphy-ctrl driver to parse, map, and control the system
controller PWRRDY bit at the appropriate time. Along with it add a new
compatible for the RZ/G3S SoC.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- dropped Tb tag as it was reported that it is not valid on bindings

Changes in v6:
- collected tags

Changes in v5:
- fixed description formatting
- collected tags

Changes in v4:
- dropped blank line from compatible section
- s/renesas,sysc-signals/renesas,sysc-pwrrdy/g
- dropped description from renesas,sysc-pwrrdy
- updated description of renesas,sysc-pwrrdy items
- updated patch description

Changes in v3:
- none; this patch is new

 .../reset/renesas,rzg2l-usbphy-ctrl.yaml      | 41 ++++++++++++++++---
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
index b0b20af15313..c83469a1b379 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
+++ b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
@@ -15,12 +15,14 @@ description:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a07g043-usbphy-ctrl # RZ/G2UL and RZ/Five
-          - renesas,r9a07g044-usbphy-ctrl # RZ/G2{L,LC}
-          - renesas,r9a07g054-usbphy-ctrl # RZ/V2L
-      - const: renesas,rzg2l-usbphy-ctrl
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g043-usbphy-ctrl # RZ/G2UL and RZ/Five
+              - renesas,r9a07g044-usbphy-ctrl # RZ/G2{L,LC}
+              - renesas,r9a07g054-usbphy-ctrl # RZ/V2L
+          - const: renesas,rzg2l-usbphy-ctrl
+      - const: renesas,r9a08g045-usbphy-ctrl # RZ/G3S
 
   reg:
     maxItems: 1
@@ -48,6 +50,20 @@ properties:
     $ref: /schemas/regulator/regulator.yaml#
     unevaluatedProperties: false
 
+  renesas,sysc-pwrrdy:
+    description:
+      The system controller PWRRDY indicates to the USB PHY if the power supply
+      is ready. PWRRDY needs to be set during power-on before applying any
+      other settings. It also needs to be set before powering off the USB.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description:
+              System controller phandle required by USB PHY CTRL driver to set
+              PWRRDY
+          - description: Register offset associated with PWRRDY
+          - description: Register bitmask associated with PWRRDY
+
 required:
   - compatible
   - reg
@@ -57,6 +73,19 @@ required:
   - '#reset-cells'
   - regulator-vbus
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g045-usbphy-ctrl
+    then:
+      required:
+        - renesas,sysc-pwrrdy
+    else:
+      properties:
+        renesas,sysc-pwrrdy: false
+
 additionalProperties: false
 
 examples:
-- 
2.43.0


