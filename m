Return-Path: <linux-kernel+bounces-774890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B687B2B8DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1239581C51
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425403101BD;
	Tue, 19 Aug 2025 05:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NYs762J0"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C373531076A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755582146; cv=none; b=Z7G8zkFg79KkOmcQ+9x9p8/Qe9SF2hNZ29S3L9EkWVcdxr5UOLd0oyV7MXeJA9lYsxQuvUVmb+vcBIa1pM/WykrsZQ7D4khKqdIkif0FRpj6I7Uu/BvNEMRmt1ubCBKJzOzGu28VEhEH9levHZMGF2zl1mqAw7oQoE1455KqsdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755582146; c=relaxed/simple;
	bh=07ORXzu5jE9NwCXZ2D+0evGTyTg9KEln29DvJ6sBaBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVlOxV1cDeRcJm8yTXKOnudkx55wIgyx/Tk9YY1nqHLhbZmvEakpQp71d4igVT2BrT27LEQ1i20srQkHJcbtBIL6YgSaYFWO2n7BO7ELKTbSgZ/MxzUxA8zml3bUOdMFOTqAyaJhFYoNbVAF5veIot5nGZNwGCWgPc5nnGJqR3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NYs762J0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b098f43so29690165e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755582143; x=1756186943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYSKXBGxl/0cppLApyYv7t4M3O5QkIiUowE4I+ciT30=;
        b=NYs762J0fH5Bo/Cc1/R+gdtYveCpHUUgoeCkRooGm6U2HHhsnNYWIdqTS9RtaW35GO
         RsdhRg8LHXpvwB5XPqLtt4VYSTEk1F9ld2gCwwAAyyvJMo+85aoiNjXzW0i0mpSPIDJy
         jKRJD37ODGmR7UB4e6upVSoPsBFHYkjildFCLiT5wsUZPksYODaZzOQtPud1i210oCOE
         /nV0e4MxuFVlm8ZMOOrv0RWsyV6iQkjC1V4NZd09j/FmMRUr7rLxUCF33ITqpzh+krxQ
         BNHQH7L6LTMj+NWZsR9tJUtBWDSiB2fgTfYKwlmyGh6pF3WrF3R4fU/HAKMONPf1AdgJ
         0gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755582143; x=1756186943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYSKXBGxl/0cppLApyYv7t4M3O5QkIiUowE4I+ciT30=;
        b=O2lI0hgV8dr8GdwOUA3mlhoq5iN6FS4yex9rSqg3Yfr9aOyOY46GujuIQhaJkC2k5A
         O0CtLgMkkEVFbsoaHosuNYrzIl2oDK95rRcJLMCvwyTo7E7V5NhvoRzf4SIVpGEeYOLt
         hXng1U/SvULNIOzUog7/lor3W/ssSSwUNf28W/qzD+z/R/EbMTtndfRyoBGdjaaYVzkS
         uVxMxG59qvj6SUg57Abjd7jXwO7Uzc2gtYfgqUij+2jMwPF/x82GlXDjd1E7XpEyJ5dv
         fJbLk8UNab1rZ7wiuxr4kwyZQFSVJvgEAnnKxyLM7VIP+z68SF+bBCRb7hWSW7hn/Cv/
         1dyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSMt7oSkhn85wPpnkrGYhm5sJBObcn69CItV4BGFgL869zqKieICMHThvupwHDu5cNiGC+VKmdOTS/tLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrmUv672q5J2cEgxkIDRN95cSEYIbe5x2tlTtI0AAhs2AOdtNW
	1xpOAJRBRNqxuIhr30J+jmnfE+W7cm0TtEljBm4RQeJFfSKe9P5jZ6NBtRY/WaWXOME=
X-Gm-Gg: ASbGncvlLJlE/x4Qy3GI024xquk7qxjN9+RX7pDX8PrEcvlMYeixOJsH8pJGfzWNoDP
	MUcW4AD7ntoutGCa+gH4s8WGoNRhA2qE/uY+RiUV43kE7X/C9Dvk8m+8Qv6ejrpiiwH5ktm3tpr
	j35d1ShfaXt8npw3bq9d90ZoRYmPMtq6Tggg+pyCZpiJHd0TUqTEIYHoJtLb2Wt7JEWhUJ2q18k
	bSBpk01jTUN/Jkgvzx/SAP0rPgBr7t6zBfJaKkQaUZiLYWDVzbb4+Q/z8xECHMziSXeO81MC1Ud
	D4+2305lH3QRL4Xw6oAoGGXjYeegTFE0SX/NxFY2oIQUtX64ShyEWaXpaEP39Rl7eN9Aqu/h1P6
	ZjSN4dnUHncNMm7+BXnsffauhUua4H8og/rQqXXxD1oMGYkoQgswpQJAtkJCIRyhK3J95wKEhjC
	eB4GTz9r4=
X-Google-Smtp-Source: AGHT+IEBqeNsrzMuxdDwDLYVLpHRfbSwbG09A9d+KjmEIS4kFBVPomWUHd262GBt3nx9ixhYE3ZToA==
X-Received: by 2002:a05:600c:1c1b:b0:456:1c4a:82ca with SMTP id 5b1f17b1804b1-45b43e0f3a3mr7340335e9.32.1755582142917;
        Mon, 18 Aug 2025 22:42:22 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:620a:8b00:4343:2ee6:dba1:7917])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a9847fsm25097345e9.26.2025.08.18.22.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 22:42:22 -0700 (PDT)
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
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 3/7] dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/G3S support
Date: Tue, 19 Aug 2025 08:42:08 +0300
Message-ID: <20250819054212.486426-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819054212.486426-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250819054212.486426-1-claudiu.beznea.uj@bp.renesas.com>
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


