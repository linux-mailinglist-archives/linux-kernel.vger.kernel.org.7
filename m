Return-Path: <linux-kernel+bounces-847158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8297BCA1BA
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97B03AB829
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052632EF64D;
	Thu,  9 Oct 2025 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9TaASnO"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4148E2ED14E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026068; cv=none; b=iGHBb6ad6OR917uCngrnLyKX9+tteDW2FgiqIKf9/fAN+fLKCbTozjGpdF+aj3ggiX7BrzZnX4wwBsqNK2r4NW+r8KpdETqSA7v0MllBpOvw4wcdqfStJa8tIqd3YoWa2QFVcfhsLgAGlAhqEHh4jMeQguJWuWqHpdCaucI5U+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026068; c=relaxed/simple;
	bh=D+eyXYCRP93GiOpPf9ShDI3+JJtzfhw+VA78K4JKfqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIMq74lXNx1yMaZvkRZstaktp5nKXhURsK/hKOAv5+vuc+Bzy0dnbl6Csp09eeIbIY0EkmOCSdUDMjBDFQRXsFhZPBOXlUF7+HF/zUmuAuq3EvGlXKkIbQANuNEn15q5t/Yyq5uzDOX9qdNN+AwIiyGJzN7ujpNjqg76bBKmRMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9TaASnO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e4f2696bdso12692525e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760026064; x=1760630864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpMeQuuKWijc2mV0CsZl42OGhVfluAnUlKAKIhNO2X4=;
        b=k9TaASnOZS52Iv/iQe1qpqmwP98inWXVaSC61juV4UOa4w2l8Amkupq7OkJvhj5i9h
         4PpXqfVvKwZHIpmoNiwHA8aUT0QYGGViN34dYbh84BmdjRsu7CGCPgkJ5h0XPvKFmABP
         syJfhEcWCal+kiSK85JFc5XhYUZXysfFr+W7fxqHphS/frmCDpW4drBkSK0CijFXjL4m
         a8G5lzK3h67x+GG7jgo6WEooByAjwbgRBj9mAiPNlCRtMylu1rHBQlaPUe5D9h2bX9re
         JiLQGxm1BiYBdWRh3+aOZjDnAASnP3qC5AqSs755ezsKMWuG0bmxboAkWJjqCJNCKpFs
         /iJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760026064; x=1760630864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpMeQuuKWijc2mV0CsZl42OGhVfluAnUlKAKIhNO2X4=;
        b=gV+tLzcK9RtrrgdFvRLr1M4cWYIU2CtCON6akblts/dkL2Er2Ybiw2gPo1N7Nt1XCX
         LcicItt6ilveQbmTi/3qDglFOkTj6hx+KPgZUSKPOOGtnbO/fLnQWDMo1ATZo3iZMu0i
         n6bKo3dDzVjsZUDxHjg/j7tk9RchpPgIteun8l4x1SMbclQCVZLnMiey8/s3psk60pOi
         iJAmL01GPhktlk+ANu/Phmkf7VAvhd6PYW74o2VJcMKtANyszAsOv5epSaWibgmPIM47
         W+y01kK1eiKjRiV6kI88OK17JavCd/5DpY99p9XvWpbRUXzz0g6c5BvOmfteGk+2Lhdl
         9eJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX07IBPEAq+9DrGEDqmShq11qUazBjRHWtiNd+otbhWX+36eMr0Q03LfrC7OeG5SKtiPqiez0I4CU24fPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBP6yc+AtQxaLJdTi0sxdzupSqBpb3PBuzms1z54wE4KCsNwj3
	EKxBYtsbH9WO3J+kGbrOSqoiAx0C82RtJgU+7pRgGDqge1ZwPbmfEr61
X-Gm-Gg: ASbGnctQ01ND/VQ9bGuDCIzhWp0UuEM6U0FQqDNUJ/qr2EU4BabiFTuWzGKAyOpbcs1
	KiwELPVlDvv1cfD9rZPhA+8TMQMUyhq4/8B+FAXMwo929xbAHXBi7XmJq61R7GnJjowja8LYSJQ
	rTF8GKDD4bZNBZMt/g5UZpn9RThxmbFYXZsTLRrnfW+HBB9GHMCxk+W5z3DlbGqBi1bgIBh69g7
	vcjekdxFPjhPZF/s08CHXOuq7KvPD0ui12sVDn32l/WOJBf5WzUqaUWHKIogfKpKT6oEcqQDycp
	JxRL18SAmCj1hZZa8S5ZBhisLcl6LBq1jGTTiYd+tsIsbh7/9sdGrNCdSLbncpQe0I0xtVU9Lo9
	dpJ73H8OZWqpuW7JHk2otDMm2C7LuwAsM0q/FgQzpUtowIPCZaMNzNdtVy/Mr8MBfh0HuosEH/2
	EUyfKFWbY1VoPhhls=
X-Google-Smtp-Source: AGHT+IG0t5hujIhb89dnKBCUxpKvQGMD0O42jk7PnFi2Ci4j0hs8DGovu4xn/JLycRwB6rabDtpACw==
X-Received: by 2002:a5d:5d86:0:b0:3eb:4e88:585 with SMTP id ffacd0b85a97d-4266e8f7f58mr4909774f8f.29.1760026064046;
        Thu, 09 Oct 2025 09:07:44 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:480c:edeb:2884:a92a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426cd93e45fsm94632f8f.4.2025.10.09.09.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:07:43 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v10 4/6] dt-bindings: display: bridge: renesas,dsi: Document RZ/V2H(P) and RZ/V2N
Date: Thu,  9 Oct 2025 17:07:30 +0100
Message-ID: <20251009160732.1623262-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009160732.1623262-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251009160732.1623262-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add the compatible string "renesas,r9a09g057-mipi-dsi" for the Renesas
RZ/V2H(P) (R9A09G057) SoC. While the MIPI DSI LINK registers are shared
with the RZ/G2L SoC, the D-PHY register layout differs. Additionally, the
RZ/V2H(P) uses only two resets compared to three on RZ/G2L, and requires
five clocks instead of six.

To reflect these hardware differences, update the binding schema to
support the reduced clock and reset requirements for RZ/V2H(P).

Since the RZ/V2N (R9A09G056) SoC integrates an identical DSI IP to
RZ/V2H(P), the same "renesas,r9a09g057-mipi-dsi" compatible string is
reused for RZ/V2N.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
---
v9->v10:
- No changes.

v8->v9:
- No changes

v7->v8:
- Added reviewed-by tags from Geert and Tomi

v6->v7:
- Renamed pllclk to pllrefclk
- Preserved the reviewed by tag from Geert and Krzysztof

v5->v6:
- Preserved the sort order (by part number).
- Added reviewed tag from Geert.

v4->v5:
- No changes

v3->v4:
- No changes

v2->v3:
- Collected reviewed tag from Krzysztof

v1->v2:
- Kept the sort order for schema validation
- Added  `port@1: false` for RZ/V2H(P) SoC
---
 .../bindings/display/bridge/renesas,dsi.yaml  | 120 +++++++++++++-----
 1 file changed, 91 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
index 5a99d9b9635e..c20625b8425e 100644
--- a/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
@@ -14,16 +14,21 @@ description: |
   RZ/G2L alike family of SoC's. The encoder can operate in DSI mode, with
   up to four data lanes.
 
-allOf:
-  - $ref: /schemas/display/dsi-controller.yaml#
-
 properties:
   compatible:
-    items:
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g044-mipi-dsi # RZ/G2{L,LC}
+              - renesas,r9a07g054-mipi-dsi # RZ/V2L
+          - const: renesas,rzg2l-mipi-dsi
+
+      - items:
+          - const: renesas,r9a09g056-mipi-dsi # RZ/V2N
+          - const: renesas,r9a09g057-mipi-dsi
+
       - enum:
-          - renesas,r9a07g044-mipi-dsi # RZ/G2{L,LC}
-          - renesas,r9a07g054-mipi-dsi # RZ/V2L
-      - const: renesas,rzg2l-mipi-dsi
+          - renesas,r9a09g057-mipi-dsi # RZ/V2H(P)
 
   reg:
     maxItems: 1
@@ -49,34 +54,56 @@ properties:
       - const: debug
 
   clocks:
-    items:
-      - description: DSI D-PHY PLL multiplied clock
-      - description: DSI D-PHY system clock
-      - description: DSI AXI bus clock
-      - description: DSI Register access clock
-      - description: DSI Video clock
-      - description: DSI D-PHY Escape mode transmit clock
+    oneOf:
+      - items:
+          - description: DSI D-PHY PLL multiplied clock
+          - description: DSI D-PHY system clock
+          - description: DSI AXI bus clock
+          - description: DSI Register access clock
+          - description: DSI Video clock
+          - description: DSI D-PHY Escape mode transmit clock
+      - items:
+          - description: DSI D-PHY PLL reference clock
+          - description: DSI AXI bus clock
+          - description: DSI Register access clock
+          - description: DSI Video clock
+          - description: DSI D-PHY Escape mode transmit clock
 
   clock-names:
-    items:
-      - const: pllclk
-      - const: sysclk
-      - const: aclk
-      - const: pclk
-      - const: vclk
-      - const: lpclk
+    oneOf:
+      - items:
+          - const: pllclk
+          - const: sysclk
+          - const: aclk
+          - const: pclk
+          - const: vclk
+          - const: lpclk
+      - items:
+          - const: pllrefclk
+          - const: aclk
+          - const: pclk
+          - const: vclk
+          - const: lpclk
 
   resets:
-    items:
-      - description: MIPI_DSI_CMN_RSTB
-      - description: MIPI_DSI_ARESET_N
-      - description: MIPI_DSI_PRESET_N
+    oneOf:
+      - items:
+          - description: MIPI_DSI_CMN_RSTB
+          - description: MIPI_DSI_ARESET_N
+          - description: MIPI_DSI_PRESET_N
+      - items:
+          - description: MIPI_DSI_ARESET_N
+          - description: MIPI_DSI_PRESET_N
 
   reset-names:
-    items:
-      - const: rst
-      - const: arst
-      - const: prst
+    oneOf:
+      - items:
+          - const: rst
+          - const: arst
+          - const: prst
+      - items:
+          - const: arst
+          - const: prst
 
   power-domains:
     maxItems: 1
@@ -130,6 +157,41 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: ../dsi-controller.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g057-mipi-dsi
+    then:
+      properties:
+        clocks:
+          maxItems: 5
+
+        clock-names:
+          maxItems: 5
+
+        resets:
+          maxItems: 2
+
+        reset-names:
+          maxItems: 2
+    else:
+      properties:
+        clocks:
+          minItems: 6
+
+        clock-names:
+          minItems: 6
+
+        resets:
+          minItems: 3
+
+        reset-names:
+          minItems: 3
+
 examples:
   - |
     #include <dt-bindings/clock/r9a07g044-cpg.h>
-- 
2.51.0


