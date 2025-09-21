Return-Path: <linux-kernel+bounces-826303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535EBB8E24E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E96C1897B6F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB801258CE5;
	Sun, 21 Sep 2025 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Q6pLnAGK"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E621A2387
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758476547; cv=none; b=mkaHBE4oggvAv94gK7irahCOjfPmp8ITkRN+jQgajHi7Tan1Qg1YESZkf/Tl5k9BB41idR9+6BCOGzGldPCHtU5PJUWWcrlup3UlY6dBx9mI/zAgYYLw6WoTHU75u73JGnYVD4HtBulhLjjNnGx81goBo+eprT6+kgWq9lNriI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758476547; c=relaxed/simple;
	bh=oOjZOItw2FyDSVtCNH8Oh9Mq0hYT66Z9X5gdpRuEPYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAkYEoDZsmWrhJPhXnYRPx/kgikbSFLNFnB+B8QMu7/OMGFRux6ZPIvdeiwxZZnNBL8gwF4Pr8yq7JUDbCHtp1kEbr/9GdkC86jLM3nEzzqjJxjelZ3HJWs/UHueqXoFc5O+dCmdPQjKSsC+SZkUNOl0GoZikdCyc2tjtTBv52Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Q6pLnAGK; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-367ce660b61so7471451fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 10:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758476543; x=1759081343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zj9dH/IE/77bdbBlwkTPAdjFGDmZXl6gQJLki2rgrNA=;
        b=Q6pLnAGKTcGPtxAvzmRENzjIGGsUg5DoUA0AIn+F+7BBoGpTqMrfHFy0pFcavkYlSG
         RmYgeC4bwmya2D0yNLWYdNqei9TuspsR2+HmjY4lkonRdDR02Xlx+a8CKd4rFYEFQBbW
         W2WqS8Fku2gouC51gbBrjyNv/EyqTYERVI8wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758476543; x=1759081343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj9dH/IE/77bdbBlwkTPAdjFGDmZXl6gQJLki2rgrNA=;
        b=uEIN495GD9uo6bH7GciUWvaKtaIY3UUIVeBSllzYESURG5FNCjkEfewkt8DXHp/O4C
         YRD2yGIYRyO9j9NR0pjXqDWhuPGxpF3s9t0PEDaPunJhq2cej6PkwHS1A+X406lGy4qS
         4B+ov7bxVHoMaQMSTXzydsLVeQkWO2vVTv4tGrdd/amWNAYFQouU5A+iRdFC4YArFHg4
         30GUP+etreO4p8elU2/Mv7xymmJCaNmL4j84mQGoHot+ebZY1uJbMBGyG74idG4gVf1G
         xmNkbmuszu89lRYZqZ5bAsYrUpBkWdVqZSAOWcR5JhjHoFy+VGq5dhCgxXj7RDvGogwY
         h6vg==
X-Gm-Message-State: AOJu0YzQNehFYXaQbjTppV7G2JAF2BvczfQVLKowg5TM5fQBsGKnq6zo
	+JNmHy6PWpf+aP35cgnPcwm+NY0KkNpVHXNrOKN6XHhNsc3gH9R7OYMVXB1P4atzL0oRtTdvJy9
	unKNy
X-Gm-Gg: ASbGnctNX1dr8vkEqCtuifxTB5pek+5hPapSYp+QX6fBSJeQVZ8oCyb7uqwtjMMEJyz
	D2/DoFcB6utw6Lp/uhtG4ke3pDLteRbtraAoBu2J5hOHOj8Ep8A+afQsNtL1ZqJpFVj81jteDDs
	pZNA5tQO95JUJcvngaxJg2Ww9FwW1J4j2pKSPjxx+W2Eva2L11y7tIIvB7F8ExWGZeU/nqGcaKa
	ZNLOGEJun2YfXMs9s1lIqqZAokC+zXVjv3toBBuFgDpL5xYvBr9qrDjPqzmAFVZYlNIon04VSpV
	XzRI1plYt0I77G1X/8UGhLtui5QVwwfS18VSpnxUq9M0zAm1LYEXJtyKKG+57JEyUSgqnd9TAGO
	Pd0OEs7aiUglwq21gk09sjpKRnVr6Av1S+ksJPCHwxP2nm5xK/rVcXHNRIxh63nNYbtHpHHFYH6
	KRIPlYtvr89IsvMPy9U7cfGIqh/t3PpBv99cLoSpLkx4eHdwcoz6XEkq+2BrynkPdo
X-Google-Smtp-Source: AGHT+IELR3aAJwhh1aLPtkTHY1OkF1rr/ic7Ckv+/xLZy9AvN4maY3EHd3KWHVVOccM88c8SJc/H9g==
X-Received: by 2002:a17:907:1c1a:b0:b07:c290:6ce7 with SMTP id a640c23a62f3a-b24edd549f9mr962373366b.7.1758476037865;
        Sun, 21 Sep 2025 10:33:57 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2928cd31a6sm324347266b.102.2025.09.21.10.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 10:33:57 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	sebastian.reichel@collabora.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eric Anholt <eric@anholt.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Rob Herring <robh@kernel.org>,
	Scott Branden <sbranden@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org
Subject: [PATCH v6 2/3] dt-bindings: arm: bcm: raspberrypi,bcm2835-firmware: Add touchscreen child node
Date: Sun, 21 Sep 2025 19:33:43 +0200
Message-ID: <20250921173353.2641438-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250921173353.2641438-1-dario.binacchi@amarulasolutions.com>
References: <20250921173353.2641438-1-dario.binacchi@amarulasolutions.com>
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

---

(no changes since v5)

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

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 27 +++++++++++++++++++
 .../touchscreen/raspberrypi,firmware-ts.txt   | 26 ------------------
 2 files changed, 27 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
index 1f84407a73e4..044544c17e8e 100644
--- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
@@ -103,6 +103,27 @@ properties:
       - compatible
       - "#pwm-cells"
 
+  touchscreen:
+    type: object
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
@@ -135,5 +156,11 @@ examples:
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

base-commit: f975f08c2e899ae2484407d7bba6bb7f8b6d9d40
branch: drop-touchscreen.txt

