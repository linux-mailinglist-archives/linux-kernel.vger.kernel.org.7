Return-Path: <linux-kernel+bounces-832789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57804BA05F8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A17189887F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2048B2FC86F;
	Thu, 25 Sep 2025 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TQZhRP5E"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640EF2E6112
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814314; cv=none; b=pbnx88kXdp7sSH/AKnjcc1QuqYAAOczbWc2jSCW1o5meiuAD3ciZjpOdupZqA2N705/jxOXvtjyPvhaanEjqEDaY4Xe0Gqivs0DQ2PDGfy3qPXqWQvFG3KCN/ITtr7Wdwc3H3BJP4+2/UjSHo1yq4gSeXKCyjla6u+X9M0MWs0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814314; c=relaxed/simple;
	bh=644PMervGuZhLRtTxo42BpqSF+8nWdIjBlmVIsZS8Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gh2kSnjxTahC4M9dce6Rk14tFhcrhcpzL2DmaPfEcuKMyCR9CQPSGFfBI/LjSKcRhI+d0krzc4NAZP2NvqjzlGUphu35WFjJAH7o9+eFWd5TKszAhsrXGyWsiY9PR7YuGXtLwh3T7T60u8eUPG73+VrBEGGjfUmGHMWEWibvheg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=TQZhRP5E; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b33d785de7cso181456866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758814310; x=1759419110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5s1NkUGStweVlYWGlUVqWZR3tOWBeOpZjnhIgCBEaNw=;
        b=TQZhRP5EAAP5ZRKR32Y9MrAcdhDcN9e4bD5GROQnZ9vVs6W8Wrz34ZjHNDcqnMrLJB
         GKoiDxHp/VVWKoqeoYMsBJl8e5k3JJudZlsD/nYVeYGrCtl1gi1DE1BWb4CdNErzHpdJ
         pJiM2yATNA7A87AntD101W05bhWzfPOpjQpHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758814310; x=1759419110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5s1NkUGStweVlYWGlUVqWZR3tOWBeOpZjnhIgCBEaNw=;
        b=SkHhFIyisCsT9yi2dj5yHQL5+6wCeuTO/aB3aL40yDLSZLWUAIMu/sOjMOZFKFEptd
         2FySPBvQEW1VIODT/0p93JXUM5QNwz18Ef5EbpIkq0AOAQJ12L/M+k/2kD/mXc4E4lIr
         19s2atjbzzf2yutJr9YwU1RT2iJi1C863iYekxkO/MkpWxJxqy7XutiJ65cRNZUJH76B
         WHtSscXFmB0y3tNRBo/FCxXZZo0JCgZ4WNFWtnD/LCoEsG52dBSb87Ys1L7KMCRZnH9K
         QTyBwi52AUiL7vWbuE30hp5WRxjQJLJNh1CFdA8wkgKGKiKELHGbikQI6qV+yciuZb62
         PbkA==
X-Gm-Message-State: AOJu0YwqXr0kkYgzmG+ifW7UksNm5XWwJPW4zBZ7CJUnbv+09nNiG2G2
	dzDdAP/ipTNyNwGbwawFppr/AZ8MBb5xRCwz/jjCoq/1fbU5JOz2Kg51Xei+WtEO1wN8HDcVTSN
	XAycr0lI=
X-Gm-Gg: ASbGnct4JUowatswromAZW/SWat/wWEKKIFLmiMy2ZUwrF8DAzTWQBnuWmJ5IVcMymm
	OeHoL5gBf8djoF5erQHloJCRvkPaWrk0PovsvRL29YImcTMc7izZGKY2hutJ8FrEDEi1/GAyndi
	hBo1VkdnpnsPQJYO0dozsV7hyslICKiPUu5S7FvwVh1TpcP6t21W8cgBtRfXu7cNAegxJVvRl81
	2r9oOWmOoUCtzG6VoZyG2GYPc5yYapBj5KptrQ+XNeb3XyeQEezySZ7Q7DTQVRjY7fFYsEKdreS
	cOy0qvKmj4qNaPKwrjzOQhHej1If0nIt7YXnGKp1Y1YEUxMViICLJr37jrTZgQeOP+HfI8LjeXO
	jRNo9xd2o+q3rjnsYCsJdIP9J6LvPSL8muZs6NWwxGx9TJ9+xr4THflqRCRsfrTvIYivfaFHT8B
	8PTOvJIIZtW2/YPowUiuPa/h8SK8iBPEEQkzbPg+9PtXL9AUBEDYJXk8mhvjmRJsrONvTX1ZSiR
	FCfw1NAPtM=
X-Google-Smtp-Source: AGHT+IF7BuPuSGwyBCz2UCqO+HRTTylRFxaIlwU3C5Efe36PDl6FBJSX2Hnycv4Zf1+SFTY6NIs+yw==
X-Received: by 2002:a17:907:d94:b0:b04:2d6c:551 with SMTP id a640c23a62f3a-b34bb9e9ffemr417345866b.42.1758814310288;
        Thu, 25 Sep 2025 08:31:50 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b36f410e129sm43924766b.89.2025.09.25.08.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:31:49 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: sebastian.reichel@collabora.com,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Rob Herring <robh@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eric Anholt <eric@anholt.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org
Subject: [linux-next PATCH v8 2/3] dt-bindings: arm: bcm: raspberrypi,bcm2835-firmware: Add touchscreen child node
Date: Thu, 25 Sep 2025 17:31:34 +0200
Message-ID: <20250925153144.4082786-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925153144.4082786-1-dario.binacchi@amarulasolutions.com>
References: <20250925153144.4082786-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Raspberry Pi firmware 7" touchscreen controller device tree
binding to json-schema.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

---

Changes in v8:
- Add Reviewed-by tag of Rob Herring

Changes in v7:
- Add $ref: /schemas/input/touchscreen/touchscreen.yaml#

Changes in v5:
- Move bindings into raspberrypi,bcm2835-firmware.yaml
- Remove raspberrypi,firmware-ts.yaml
- Update the commit message

Changes in v3:
- Drop firmware-rpi node and use only touchscreen node to fix warnings
  you can see in
  https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250913092707.1005616-3-dario.binacchi@amarulasolutions.com/

Changes in v2:
- Added in v2

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 28 +++++++++++++++++++
 .../touchscreen/raspberrypi,firmware-ts.txt   | 26 -----------------
 2 files changed, 28 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
index 1f84407a73e4..8349c0a854d9 100644
--- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
@@ -103,6 +103,28 @@ properties:
       - compatible
       - "#pwm-cells"
 
+  touchscreen:
+    type: object
+    $ref: /schemas/input/touchscreen/touchscreen.yaml#
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: raspberrypi,firmware-ts
+
+      firmware:
+        deprecated: true
+        description: Phandle to RPi's firmware device node.
+
+      touchscreen-size-x: true
+      touchscreen-size-y: true
+      touchscreen-inverted-x: true
+      touchscreen-inverted-y: true
+      touchscreen-swapped-x-y: true
+
+    required:
+      - compatible
+
 required:
   - compatible
   - mboxes
@@ -135,5 +157,11 @@ examples:
             compatible = "raspberrypi,firmware-poe-pwm";
             #pwm-cells = <2>;
         };
+
+        ts: touchscreen {
+            compatible = "raspberrypi,firmware-ts";
+            touchscreen-size-x = <800>;
+            touchscreen-size-y = <480>;
+        };
     };
 ...
diff --git a/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
deleted file mode 100644
index 2a1af240ccc3..000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Raspberry Pi firmware based 7" touchscreen
-=====================================
-
-Required properties:
- - compatible: "raspberrypi,firmware-ts"
-
-Optional properties:
- - firmware: Reference to RPi's firmware device node
- - touchscreen-size-x: See touchscreen.txt
- - touchscreen-size-y: See touchscreen.txt
- - touchscreen-inverted-x: See touchscreen.txt
- - touchscreen-inverted-y: See touchscreen.txt
- - touchscreen-swapped-x-y: See touchscreen.txt
-
-Example:
-
-firmware: firmware-rpi {
-	compatible = "raspberrypi,bcm2835-firmware";
-	mboxes = <&mailbox>;
-
-	ts: touchscreen {
-		compatible = "raspberrypi,firmware-ts";
-		touchscreen-size-x = <800>;
-		touchscreen-size-y = <480>;
-	};
-};
-- 
2.43.0

base-commit: b5a4da2c459f79a2c87c867398f1c0c315779781
branch: drop-touchscreen

