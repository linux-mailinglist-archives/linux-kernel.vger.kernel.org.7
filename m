Return-Path: <linux-kernel+bounces-860604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DA6BF07FD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FBE188AC60
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A9D2FF16E;
	Mon, 20 Oct 2025 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c4Ta6UE/"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8042FC899;
	Mon, 20 Oct 2025 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955256; cv=none; b=iJjGh6PHHnnvNHlUswFmvMoN2fFd1xvUsVotBtyD9+Yz34eXsRbvaAyxBkXnUrG+upOVvMn3ZfEJy9Ea1ljUFPD3tnQkQvXr1WP1vJt0IMOiIkFkIqvmQv55r6mKRT5gQ/Et90nrbfhGtvNgfmt00YF4Hka9x9C5tGxw4169a1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955256; c=relaxed/simple;
	bh=ptMw9CSf8NeiaK7jBVCUOBFfd2vSRsLgkF/FG3xtYrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPQ23M1SGKBGjB39d4G+4Ms0TukOVdVeHcoeyROzkBxntcGEGrOW6Duuk1bN/HkHtVmlaBEbjiPgZpah6jpk6rCOuo1YtkwQiR1SZpHFZ63mhNCTLX5/G/3BmOMwGzwZEWFF6SE3KoVJs86icTFVRUcq1V/3TCXDWn0Zbmv6uj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c4Ta6UE/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 876D21A1537;
	Mon, 20 Oct 2025 10:14:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5BFFC606D5;
	Mon, 20 Oct 2025 10:14:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C2AA102F23AF;
	Mon, 20 Oct 2025 12:14:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760955252; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=EJZx7MjvWZvR+9dhB8zsNC40vJfrlNPlQ8ARjxiScT8=;
	b=c4Ta6UE/C0O36OnJN8Hs08sr6wpMsXXN+k9RfK9GLKLFJsXb/adbzcS0eAQR3SftGlEnNB
	gaNdULvdIQgZlNBEINquexRJnCHrIrnMCDx5jezUeHU+IeozY70Fd3ZummPIUEqEm7ROCY
	AVi5kk9xjAg/HHWOe9ljSuAXqG9Vy2HWFyLYjGsSu5IVmowQMW57/cHJNGpnceLvMQqlKR
	05pBIEbomAo1ziXcqb3OJ+Tq68SGsWUZg4vqKm1TawT0dmC3i/E9mijvncOt8aVGVVeAMj
	weg3XzP3ZN6RTs3M+9zSW6PZVZm4gaxB6pKIUt/8nuVZvf6mk03/6fURDVzpJQ==
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
Subject: [PATCH v3 14/15] dt-bindings: mtd: sunxi: Add H616 compatible
Date: Mon, 20 Oct 2025 12:13:10 +0200
Message-ID: <20251020101311.256819-15-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020101311.256819-1-richard.genoud@bootlin.com>
References: <20251020101311.256819-1-richard.genoud@bootlin.com>
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
 .../mtd/allwinner,sun4i-a10-nand.yaml         | 41 +++++++++++++++++--
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
index 054b6b8bf9b9..9d061e2216cb 100644
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
 
@@ -25,14 +24,20 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 2
     items:
       - description: Bus Clock
       - description: Module Clock
+      - description: ECC Clock
+      - description: MBus Clock
 
   clock-names:
+    minItems: 2
     items:
       - const: ahb
       - const: mod
+      - const: ecc
+      - const: mbus
 
   resets:
     maxItems: 1
@@ -85,6 +90,36 @@ required:
 
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
+          maxItems: 2
+        clock-names:
+          maxItems: 2
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
+          minItems: 4
+        clock-names:
+          minItems: 4
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>

