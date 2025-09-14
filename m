Return-Path: <linux-kernel+bounces-815878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51467B56C38
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 22:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D167617AE10
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB3A2E8889;
	Sun, 14 Sep 2025 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qxkFo656"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39532E7657
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757882313; cv=none; b=NtNUUv4F/kKItPFUiGrsOKPOs2sMIlGfoBtK0x6sD0Gy5A/+Isl2Q4rnWaNod7aAGgQdgLIUlzHwBgF5OSN7uG+hgZ4r3weZ55pC5rV8n8efP4dW1LJ4Y1Dnkk1rru0gBw2DLnOyISuZqTsMG47+GXtOMlTcwp2OKchcABfAGxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757882313; c=relaxed/simple;
	bh=2aP7ZNnKsj64rUeEHduOQ/Z8EfbTpQ+D4oav9/vzXhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scyt5aP6sp7mz5ZeNo0r0f864kW2A0m4rO0iNTZ2HGAXgJBZ96Q1EQJpvIoiCDABxFaw5tpxFOQV4IHJzqo9+g7SSiwAEwA32Ja5e2qod9k9sMV9EOV2PTyEDCMg+rkGzeD4xOhy58ufIxgO5uolkcyoLCn0B8pu9aZmMmRRVQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=qxkFo656; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62ef469bb2cso3601527a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757882310; x=1758487110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zogDSCC9sjp5/MJLHL2D4fuF8U7ldK3mZBr4RRBDP2s=;
        b=qxkFo656nmoip8tRKVEIFQRUCXack2OlPywg6uQEelgG7F78ePL52trzdQF7tPGzp7
         EK9extH3ah0kqndU10nvm7m9CNVc2qz6W8CiZh1znSnmONJBdBBZRieAj6Jm94qQ0pAe
         EfytXOsRClrfY7Oo7j8vNx/QLxy4qdguufcN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757882310; x=1758487110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zogDSCC9sjp5/MJLHL2D4fuF8U7ldK3mZBr4RRBDP2s=;
        b=qcT4+7RbVfVRnl660uZvEE8WW7N748PQU+Ji3OauJ47qjJt8uQuE+F4LEukZnRRTxU
         KASGoB39tyyD3r0poZeVt9WBoPf1UGRPlEvRvLsyRVUOZzrVQt8NLu4o2obvg3jZvK/y
         frVYNmtOJN+QpY+fbBfS50qTI7/MVbC9LMSvcu9FEHLS+mmYoFoiwGYTvuiHoOFdlV21
         LcCvzldmMKUV0UQh5geDMgp0iYNvzcBfHLRNByYrZyWonvGChd7O7OTZ/hcTpXItku20
         Tldpt2Ejh18B4ovIxaRn700Yctr4DRikcapCfc6dRpnjDzzg553uyJA2gd/tvqBZ7T44
         kqAg==
X-Gm-Message-State: AOJu0YwJbSETjdm5cYTURiJoxdymGLismvThWYrbFtX29QV8PUs9r0i6
	uWFtmGQaoEbY9aaz0rJcyt1fKbTpyOkgS3YzsS4DL3+fV5FB5OVN6tMnUMwdqjSf6+OoTimDL7i
	EV7X7
X-Gm-Gg: ASbGnct/V4Z0IznnpXpBb+FcxdViul82TDHbdiv4AdhS6qbjFNtKP+VX3FMFdEjW3L+
	L8wBiM4CeYTjl9rVrSbgXYDCvhnwnxweidEwZ2xoqWWrq+HgGDKxyNYlwDzLqbIvzg4LG9BQQVO
	uSNric2TQ9BRd8HTGrKvGvRRb0lB8B//B0d/DpDmaEpAYesB3pD5RPogtzWyZKc8CJX/0Ls+pBr
	QwzU+44wWujswOpV2cyPj52DOm+VTa5dxdwGZ8GS2R2PtL3tSll65C4TAYzSZlvOMXpRJwSPX8h
	PPRJZTba1l4IpIOy1D0Pj5az9eLrxw4uSzNF/C3MGSKL7FF9E0c7jAVLkjDEZuJBW+n95lWAkiK
	sK1MB+R2zrgt1U0rt8ljf3Rq44yGzqlgh8DElyqvxO5HOlMqgGTHx+A7JCHSVx2JqL7zQmM7Gl1
	dS8bgS82dl1xfotu5KYdCJHAF6Sukh2tiEgtscvaDH1SBJar1sLeBTdlCKklxtP2G3HN7XPxNdY
	M0=
X-Google-Smtp-Source: AGHT+IHZRqeG8YCJqWhmCcxUblf7Z56+CmrQsZREuQzXIH47fTIg3gZSrOqr8GCfaea14PdW5W858A==
X-Received: by 2002:a05:6402:46d9:b0:628:f072:2f18 with SMTP id 4fb4d7f45d1cf-62ed81ff6fdmr10494542a12.3.1757882309960;
        Sun, 14 Sep 2025 13:38:29 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33ad242sm7803739a12.17.2025.09.14.13.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 13:38:29 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v3 4/5] dt-bindings: touchscreen: convert zet6223 bindings to json schema
Date: Sun, 14 Sep 2025 22:37:55 +0200
Message-ID: <20250914203812.1055696-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914203812.1055696-1-dario.binacchi@amarulasolutions.com>
References: <20250914203812.1055696-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Zeitec ZET6223 touchscreen controller device tree binding to
json-schema.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v2)

Changes in v2:
- Added in v2

 .../bindings/input/touchscreen/zet6223.txt    | 30 ---------
 .../bindings/input/touchscreen/zet6223.yaml   | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/zet6223.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/zet6223.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/zet6223.txt b/Documentation/devicetree/bindings/input/touchscreen/zet6223.txt
deleted file mode 100644
index 27d55a506f18..000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/zet6223.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Zeitec ZET6223 I2C touchscreen controller
-
-Required properties:
-- compatible		  : "zeitec,zet6223"
-- reg			  : I2C slave address of the chip (0x76)
-- interrupts		  : interrupt specification for the zet6223 interrupt
-
-Optional properties:
-
-- vio-supply		  : Specification for VIO supply (1.8V or 3.3V,
-			    depending on system interface needs).
-- vcc-supply		  : Specification for 3.3V VCC supply.
-- touchscreen-size-x	  : See touchscreen.txt
-- touchscreen-size-y	  : See touchscreen.txt
-- touchscreen-inverted-x  : See touchscreen.txt
-- touchscreen-inverted-y  : See touchscreen.txt
-- touchscreen-swapped-x-y : See touchscreen.txt
-
-Example:
-
-i2c@00000000 {
-
-	zet6223: touchscreen@76 {
-		compatible = "zeitec,zet6223";
-		reg = <0x76>;
-		interrupt-parent = <&pio>;
-		interrupts = <6 11 IRQ_TYPE_EDGE_FALLING>
-	};
-
-};
diff --git a/Documentation/devicetree/bindings/input/touchscreen/zet6223.yaml b/Documentation/devicetree/bindings/input/touchscreen/zet6223.yaml
new file mode 100644
index 000000000000..a126f3f369ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/zet6223.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/zet6223.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Zeitec ZET6223 touchscreen controller
+
+description:
+  Zeitec ZET6223 I2C driven touchscreen controller.
+
+maintainers:
+  - Dario Binacchi <dario.binacchi@amarulasolutions.com>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    enum:
+      - zeitec,zet6223
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vio-supply:
+    description: Phandle to the 1.8V or 3.3V VIO supply.
+
+  vcc-supply:
+    description: Phandle to the 3.3V VCC supply.
+
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-swapped-x-y: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@76 {
+            compatible = "zeitec,zet6223";
+            reg = <0x76>;
+            interrupt-parent = <&pio>;
+            interrupts = <6 11 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
-- 
2.43.0

base-commit: df86f912b45c20e236060321c85fe35437e9325d
branch: drop-touchscreen.txt

