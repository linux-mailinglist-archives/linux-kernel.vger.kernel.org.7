Return-Path: <linux-kernel+bounces-850901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D017BD4964
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0039543222
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39622272805;
	Mon, 13 Oct 2025 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jzq0aJ7Y"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DC13191A3
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369286; cv=none; b=nbzeB9RNIDegoq+GHKFRMmFW8LsaJ9pyXDAIBqqXgG6HIvaqIRXQ76TeIU+UVLEqXV0WbXyDAW0F4DkbPcbYxZUFkFjtYBugtedGylmpQq7bKMRtheEUDqIQXH1EJxjmRXimMTLQP4JBILzFKCcL+zHabSnnTzfvALmf0OOf7X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369286; c=relaxed/simple;
	bh=LPpFGckQlGu41PWKhM1jFADnk8iS1JnOVJ7LQRpoM1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOrIwhpuZp/1M8VAdCaKZUkSOx/EWyh4R2r4azdypcoKQJ854kg4CdBAbE8dcnLDgyGTCBOHV06ZtmTON7z5M/i64bUEca6WRoPf8Ln3luVnAecCDTk+x5Z80zi9VSyF0ekOHey6A2c3b442kGW8ChpQ+TgY1mReoV0PkPBt33U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jzq0aJ7Y; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8B9204E41071;
	Mon, 13 Oct 2025 15:28:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 61D4C6067B;
	Mon, 13 Oct 2025 15:28:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7AAB7102F2272;
	Mon, 13 Oct 2025 17:27:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760369282; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=4Yv2LZrhSOd4vz0gQ7eWw6e3151d7qoUhYTKCe+tu2E=;
	b=Jzq0aJ7YVOV0T7gPWEGHQR0fG3brxvbm4L4mbuRxWs89F0KraZg/NoyQM5VhfPvN70PrLe
	NS/Q+5D1YIETc/xpwfclqv0boO379ZPq62kbeKL6BT57GRpQ0ojWaeiQoLI30CI3rsixc0
	U99Ot2ZKQcc1UI7V7i86UhcdSxPHUn9ny5sCWh9Eu9WbMYKkoOzPQ/2xGvsaJoC6QWHZW2
	XZ06I+inc5R9XUoIY0WdakuTeNlJwyVXBVEF3eKySBd0sjCy1xIPAlp+b3TvrmwLNofthI
	IG0GNG2LN6ff9jbHHlTxUJAPcVObnQlUxJQqIDMZP/cTi6CgPuK/B5R08sv60w==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Johan Hovold <johan@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v2 14/15] dt-bindings: mtd: sunxi: Add H616 compatible
Date: Mon, 13 Oct 2025 17:26:44 +0200
Message-ID: <20251013152645.1119308-15-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251013152645.1119308-1-richard.genoud@bootlin.com>
References: <20251013152645.1119308-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The H616 NAND controller is quite different from the A10 and A23 ones,
some registers offset changed, and some new one are introduced.
Also, the DMA handling is different (it uses chained descriptors)

So, introduce a new compatible to represent this version of the IP.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 .../mtd/allwinner,sun4i-a10-nand.yaml         | 57 ++++++++++++++++---
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
index 054b6b8bf9b9..4b82de9fae17 100644
--- a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
@@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Allwinner A10 NAND Controller
 
-allOf:
-  - $ref: nand-controller.yaml
-
 maintainers:
   - Chen-Yu Tsai <wens@csie.org>
   - Maxime Ripard <mripard@kernel.org>
@@ -18,6 +15,8 @@ properties:
     enum:
       - allwinner,sun4i-a10-nand
       - allwinner,sun8i-a23-nand-controller
+      - allwinner,sun50i-h616-nand-controller
+
   reg:
     maxItems: 1
 
@@ -25,14 +24,12 @@ properties:
     maxItems: 1
 
   clocks:
-    items:
-      - description: Bus Clock
-      - description: Module Clock
+    minItems: 2
+    maxItems: 4
 
   clock-names:
-    items:
-      - const: ahb
-      - const: mod
+    minItems: 2
+    maxItems: 4
 
   resets:
     maxItems: 1
@@ -85,6 +82,48 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: nand-controller.yaml
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - allwinner,sun4i-a10-nand
+              - allwinner,sun8i-a23-nand-controller
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Bus Clock
+            - description: Module Clock
+        clock-names:
+          items:
+            - const: ahb
+            - const: mod
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - allwinner,sun50i-h616-nand-controller
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Bus Clock
+            - description: Module Clock
+            - description: ECC Clock
+            - description: MBus Clock
+        clock-names:
+          items:
+            - const: ahb
+            - const: mod
+            - const: ecc
+            - const: mbus
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>

