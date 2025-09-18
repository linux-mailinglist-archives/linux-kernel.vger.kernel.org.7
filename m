Return-Path: <linux-kernel+bounces-822321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8003B83881
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE751BC5CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE02C2F83B6;
	Thu, 18 Sep 2025 08:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SojZz9q4"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2431D2EE5F0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184448; cv=none; b=iKu9xb3tu7ZxgfP6GzmMMtUHm1TLLjwv/DejCfGrBxcUmaAAIXq2y7mbKYijl1FHRLupqKnKdSrwLOZJoxF9I9O1G6pvi6H99iTGRvtg29ZZo5ykG1IUxcUd35Du5reRqB04fgPbujpscGhHBD4w+gqay29HxeGYts7+05NrIBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184448; c=relaxed/simple;
	bh=z8zyOghTq87xeDNWe0HqJD0JZ/az2SAEfK9ACdH8vHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fErpDx/sTgK/POWd7S8e+iHg6WLy9C8WHKTN9hZHOvGpMIYiaTnBoFlGvOTWit00q3kbcMSvddYO4Po9IIq4LU7WOb5tzRZz/36xqV6tYUEnZlMfxGbd78HkGO5KxcZoFIi09mt7wkvLf7iqdflB+zpyR9lipo/58VElrcdvC+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SojZz9q4; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8BA664E40D0C;
	Thu, 18 Sep 2025 08:34:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 610006062C;
	Thu, 18 Sep 2025 08:34:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 033F1102F1CA3;
	Thu, 18 Sep 2025 10:34:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758184443; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tU2EkQI+mFY7LHIakOZurCgSDiSSuoFWyy5L0zuDbaU=;
	b=SojZz9q4446Z+mbslL+S2mRwCCW3NN0Un89Z3cQ0So5EX505VMbKfSvaoIOKVhF+rXu4OE
	HUXsfSpjo4R0v83sviAOPkO7Q08mCgPE6RflIpKJNC1L6cKboKhayl/snpuBFjSnkzRtEC
	6kxCJm70X2CGIOszhgA6g0oZvWYPSPk+4By3Gul0hw1WvaCPCevnX21Sv5JtZGKmSOfyMC
	Y1Flhunq+0M9deyETjOgiNo4YlfIFx2+T5tHKmrB4Ut6ZjvimCj+n2qBoHkdTARDxLhquR
	v5OLwOKzBShbbjKIFcHCLzMlhknAbxYnkPQMxYuaG1KyKZDNewdqBWdqUlAl3Q==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 18 Sep 2025 10:33:50 +0200
Subject: [PATCH net-next v3 1/3] dt-bindings: net: dsa: microchip: Group if
 clause under allOf tag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-ksz-strap-pins-v3-1-16662e881728@bootlin.com>
References: <20250918-ksz-strap-pins-v3-0-16662e881728@bootlin.com>
In-Reply-To: <20250918-ksz-strap-pins-v3-0-16662e881728@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Pascal Eberhard <pascal.eberhard@se.com>, 
 Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Upcoming patch adds a new if/then clause. It requires to be grouped with
the already existing if/then clause under an 'allOf:' tag.

Move the if/then clause under the already existing 'allOf:' tag to
prepare next patch.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 68 +++++++++++-----------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index eb4607460db7f32a4dffd416e44b61c2674f731e..db8175b4ced6d136ba97c371b68ba993637e444a 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -10,9 +10,6 @@ maintainers:
   - Marek Vasut <marex@denx.de>
   - Woojung Huh <Woojung.Huh@microchip.com>
 
-allOf:
-  - $ref: /schemas/spi/spi-peripheral-props.yaml#
-
 properties:
   # See Documentation/devicetree/bindings/net/dsa/dsa.yaml for a list of additional
   # required and optional properties.
@@ -107,38 +104,41 @@ required:
   - compatible
   - reg
 
-if:
-  not:
-    properties:
-      compatible:
-        enum:
-          - microchip,ksz8863
-          - microchip,ksz8873
-then:
-  $ref: dsa.yaml#/$defs/ethernet-ports
-else:
-  patternProperties:
-    "^(ethernet-)?ports$":
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+      not:
+        properties:
+          compatible:
+            enum:
+              - microchip,ksz8863
+              - microchip,ksz8873
+    then:
+      $ref: dsa.yaml#/$defs/ethernet-ports
+    else:
       patternProperties:
-        "^(ethernet-)?port@[0-2]$":
-          $ref: dsa-port.yaml#
-          unevaluatedProperties: false
-          properties:
-            microchip,rmii-clk-internal:
-              $ref: /schemas/types.yaml#/definitions/flag
-              description:
-                When ksz88x3 is acting as clock provier (via REFCLKO) it
-                can select between internal and external RMII reference
-                clock. Internal reference clock means that the clock for
-                the RMII of ksz88x3 is provided by the ksz88x3 internally
-                and the REFCLKI pin is unconnected. For the external
-                reference clock, the clock needs to be fed back to ksz88x3
-                via REFCLKI.
-                If microchip,rmii-clk-internal is set, ksz88x3 will provide
-                rmii reference clock internally, otherwise reference clock
-                should be provided externally.
-          dependencies:
-            microchip,rmii-clk-internal: [ethernet]
+        "^(ethernet-)?ports$":
+          patternProperties:
+            "^(ethernet-)?port@[0-2]$":
+              $ref: dsa-port.yaml#
+              unevaluatedProperties: false
+              properties:
+                microchip,rmii-clk-internal:
+                  $ref: /schemas/types.yaml#/definitions/flag
+                  description:
+                    When ksz88x3 is acting as clock provier (via REFCLKO) it
+                    can select between internal and external RMII reference
+                    clock. Internal reference clock means that the clock for
+                    the RMII of ksz88x3 is provided by the ksz88x3 internally
+                    and the REFCLKI pin is unconnected. For the external
+                    reference clock, the clock needs to be fed back to ksz88x3
+                    via REFCLKI.
+                    If microchip,rmii-clk-internal is set, ksz88x3 will provide
+                    rmii reference clock internally, otherwise reference clock
+                    should be provided externally.
+              dependencies:
+                microchip,rmii-clk-internal: [ethernet]
 
 unevaluatedProperties: false
 

-- 
2.51.0


