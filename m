Return-Path: <linux-kernel+bounces-810325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77163B518CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412525E69A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80BC324B39;
	Wed, 10 Sep 2025 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="c430aQio"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C56322A13
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513011; cv=none; b=J39TQ+zT+LBsTsHF4Tqudk35kSw8HsQ+1e4eBvesV6/pLQOILMWDCNfgvxM3ZT9YVb4J55YiU1YGS3BHedEXZb1REW97XeGSI5RvsUx4DhMFsqKHLKFsgWrYFplnAnI5F9bJBsXcuOwLJ2h8tBAkuMh6SZc256K5qVZ5TZ9ANCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513011; c=relaxed/simple;
	bh=wQK73c6sveRXcpQRikwfdxno7S+vuxPzSo++euQO9OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZpPezS7vRj/6rVS7J1FG5uXQNT7JwKiw0rLGNhe+nAO37irmCRpCiVVIk3YlgkLZTikMsZ3pxBE4+jZQceWV54rgQrfpBT8JLjBOLRdT2klSCVKSlhA2sIPtQp/43BAft+ht+QswweQKGG+s7K+fwPx+w0GxpK4QHLsL8nYtkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=c430aQio; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45de1084868so21068375e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757513007; x=1758117807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2v/qfrJwcDhrBtg7MhE4eAOkQayuMMHztt7+WMK54yY=;
        b=c430aQioNO3/4hCcqa1xteIWtp9OGPTVdgL/lZD+RdDelnF674+ZHEQme1byqe6gaa
         xy90KX6hByGUZdzv9rEkDwb9hVVt3pyWLZDz/5br44dlRGq1D4nmgIv3ewCngAoltyZX
         fAWzYrIjv2BSPUNw43nQuIpFx4ZN5ddVA9f1iBV8S1rrNcQI/7tER6YSEqlhA6JA6c9o
         hRf5/XUfMIxbwar/yhL7g176SIpRrS9Ak5HHxsdoEzLZ9WhJZ/7zezeZeU68RBPY29vx
         lXM2yNx/rPlPNuOmxGp5CHp3Sj1M64q5Ofr4aKuHqkaQbHpdFgU1VFrVeJyk2RkGFnTR
         MsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513007; x=1758117807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2v/qfrJwcDhrBtg7MhE4eAOkQayuMMHztt7+WMK54yY=;
        b=oO5scTYji+FMLQiPrLM5BupbMgzsIwk6YmXh7OpqigAtMAD6tBunDE90R1yvQgizop
         qZ1HTp/ByoJDliawpU6dIgQyBGVoWUx+z1B/yPqlCjsbIuPt5ozAwlHihhgEzexrGgiK
         ZfJUz93rZoFpc9AHfGzri5CP87LfWC3KLWbEjorD7/0+/xcMu1LDdhuoHukceTTf+Mb6
         6y9NMJWGFDVQRnU5eRe8Gh820/KS6lMX2U0VeaZFxOmkCtPY+ymGUoekfIucqR+QZlOy
         xVwS/RqB9J+dc9IaWYwndcHLERpYhJN4kwi5EVxn2xIRdYS6R7mQJmUCZLv2rbIBbyco
         035w==
X-Forwarded-Encrypted: i=1; AJvYcCXykPKzCajYKzOQVKLRvbbpcgerS+Wxw1UmEFecyzlKTzyfJwO+xASpGLTtH5EI3njsI6nnRxr+Jkz0FIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4x33tKajhfcpEEGHqWQHA5B3HgcAV8utfbCmnj4hRZYvG7fG0
	RacQ0uNxcbn1NSrh7dKU1k/9yfM0xlKdkIs/qTWylWyJwCUIxwSB//y2uirZQUNKiG4=
X-Gm-Gg: ASbGncsUgb0/Z5aGiit7u9mTQ3ezvkeCAh8sjSX92lJy2aVqq4irO1NCj3A6egD/e4T
	vLmjxWN0gMAde04NGCnT3vu+PH0REO2oY/ytaLb8E1/oJhSr8azp1/2DeWf0S99Wjt2rcXLY+0B
	YDskyVXDmG4FATQXq8qy69uu6nuPlpjebO9K3BMSlMddQ3+i7L+BoA/1RMoAEEIBrrlIfSIq1H5
	4VQjpWI5aUiuS+4q3BgMhoV9vuNG9piQ4fxTOdbLxXxMx+Qpycw3rzFqO2D7MuAmWSRpemIpbcp
	O+3HJ93759eOSPYEPhhRoN3+4cGWeEmS2hBmVC8OaJLJbAFUY3GMzKFCb43wGPgFnofSXH7O/dC
	llOk1gAAiyUyFnfnNeMqpTnxYLHMyWp4lSV8l4cSfD9D5sxhMYa+1kro4WlSco6o=
X-Google-Smtp-Source: AGHT+IER2la6Lcfz8bP/iHB1RQ8PkQa4R+3KjeerQ7zRfv0QQDireuWsIfKEUQrrW3yVDeUhRWK7Sw==
X-Received: by 2002:a05:600c:4587:b0:45d:d94b:a8fc with SMTP id 5b1f17b1804b1-45ddde8c757mr179992855e9.16.1757513007223;
        Wed, 10 Sep 2025 07:03:27 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df804bce3sm29523875e9.0.2025.09.10.07.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:03:26 -0700 (PDT)
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v6 3/7] dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/G3S support
Date: Wed, 10 Sep 2025 17:03:01 +0300
Message-ID: <20250910140305.541961-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910140305.541961-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250910140305.541961-1-claudiu.beznea.uj@bp.renesas.com>
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
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

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


