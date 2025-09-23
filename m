Return-Path: <linux-kernel+bounces-828943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BEEB95E80
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39EB2E6A65
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4773324B16;
	Tue, 23 Sep 2025 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Lthjn3bL"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBB0323F46
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632271; cv=none; b=ppZtuYpjR1GDrC4lboDXhgy2HM+8Hr+I7lQqkTqU2Q6m6o2Ot0irC2RbKfB15HK1FsDRbuBdN/o2fCHJopQVMlEMKCpvNbBMpFnWib3/ikM4K7IvOcLhpsOROHNdTC/QrQeJCVPI3mrPkLCnbqdj7HCRXOaFjVm/tqi80OjfeUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632271; c=relaxed/simple;
	bh=bnh8GbGCyR8IvnNWt9bRFqHNgzI3hQZhpUpv3weFsXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqPwtfIqbK9jPvGG3AplwGeCmYhZIiIrBJf17QCSD6pbOcA8i08rdZmy27yNTzJcMdUA/aJNZjLQLSW8RTBEW9rIdYjVdeMukhRsVv+RudggorFOJ4y60t78rc8HOz4fHZqPSNlccCksUbkq0PhrKEfk2eB9HTLIaWD24pisemk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Lthjn3bL; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62fbd0a9031so6285540a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758632267; x=1759237067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eq3dfyrFYclljj1qT31cA5X22L5O+KUSooUYqpQO2X0=;
        b=Lthjn3bLUELh6JPqeZwD1fMV0AH8WmEs+hij2lZpj5sjo3uZmjwOJgmWi35nO307nL
         k5RGJpVOj8B1E9jevIwWTIf1Y9nmVQdCUTH8vONRUTYEYh+YhrNn1YfRtgTFM/MVSp93
         apr7wmwgCIFGZJa83Tyza+ycIHo71Jp9W+ulo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758632267; x=1759237067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eq3dfyrFYclljj1qT31cA5X22L5O+KUSooUYqpQO2X0=;
        b=HZLgVUiEKmm+b9G7P0sZzGsuQif8oPfQ9FLNz8qQjkSBifQPtclRS5JqQOddhwyeTN
         QemAfojv7OlYnYiDR+bogva3wciKHnCpECKRqJbEnZf9QsuTi9h6BgfUGuLI2RL86NWX
         ekiQIfK3jh7yPtQWcp+N60jTnQ90u8DFfS1ceox3W0LtDbJwZ3ihGLSx6RH+F/voMdqt
         7M7rmESdkehBf+4ejF7fvzKNDEmNcrlGF5mu+K+oHUElIEhmByRoss2QGosg41Vn9Qyj
         BDR4a2t6n6a4xpgF0qDw5T3tHd+vRxt8pia9VnDBXYJyhH3IefnuhxeXLIzQeY1i2qU2
         st2A==
X-Gm-Message-State: AOJu0Yw3E+eSaQ4xU5pFJctWmk4mh9slyby8Zg7wGb8FInWDJElYo3V0
	tYiTsuU7mL4dFwqK2tStTb4ipFww95gyhkvbjf4Y6CROFzKQoPd+Nkt3YP7uCrdbj6HX8Q0Scz0
	OvS1p
X-Gm-Gg: ASbGncsKH5r//LntUrQjp6XX8JXMlg3kFsMk2MZPqrBC/7G5tWYnJQOoYQtku6hqUD+
	2krVmvrvN9cw0WkvuPUGmpS7SqhApcyUDawAewgarEfy1LChX9oBl/Dd53j5pin1Z7Vx8+MMUIe
	8+ypBhaEWyPERzjOQeYOpGr5Ut2lsnuyNolvzwdny9ABbOPj3dTsLEGQqLOo5vP/oc/1IVaoRqU
	TRSFkDvexshy/In8WAlcqu7NLO+fRFOgxhTALBsWsA0Ech7OHJs90m1HN3RWPy43UhT+9CtV1sF
	IUNRSvAtXJvSWrF09VRsWxFd4ZEtCBTilxd9OJRMDyHcvUhMPexjQyXa2MIMBmpC2BEidx4Jahk
	wKoW2Qz6yF+mHaZP5tFLdd+Zpvw+2fzs8INRNLGdeK43vqj13ZVxAfvjlNedv1pcirlSAKcNsjH
	heO9Dzn2i0RbKVlL4WwsOV1W6jh7vF2KROU8X/kLm/G/9Am4HC5qIvGRBuMoiE7lcb
X-Google-Smtp-Source: AGHT+IFGakYPF5iPMB1/+894VRlbLwCXmeQPzZ6Q8KuBpQCg4xITr20xSCf3DfifCufaTwJ53CPxGg==
X-Received: by 2002:a17:906:f58a:b0:b2a:dc08:5914 with SMTP id a640c23a62f3a-b302ad3922bmr241240166b.45.1758632267240;
        Tue, 23 Sep 2025 05:57:47 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2761cb532esm872331166b.67.2025.09.23.05.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 05:57:46 -0700 (PDT)
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
Subject: [PATCH v7 2/3] dt-bindings: arm: bcm: raspberrypi,bcm2835-firmware: Add touchscreen child node
Date: Tue, 23 Sep 2025 14:57:11 +0200
Message-ID: <20250923125741.2705551-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923125741.2705551-1-dario.binacchi@amarulasolutions.com>
References: <20250923125741.2705551-1-dario.binacchi@amarulasolutions.com>
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

base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
branch: drop-touchscreen.txt

