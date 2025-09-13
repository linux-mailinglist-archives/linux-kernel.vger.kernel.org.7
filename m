Return-Path: <linux-kernel+bounces-815110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BEAB55FE3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 11:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5C75800AE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 09:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D212EAB83;
	Sat, 13 Sep 2025 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="h+E2Y/D3"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8662E9721
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757755636; cv=none; b=AmJ7fb52uCmquPsgdK/oYUAsmbp/aT7GYFzjrd8NwDdLYgcAtV4YUgnKsH0SyrAJxWbkQPx25al/mEs1ycqlFgLn2+Iyh2KmIqI+Mmajj7tQ759ic9rAl91iIIby1luR5P2VC+BJENKaVgeK0AfpdefQQuKaGgA4K7q1hQjv4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757755636; c=relaxed/simple;
	bh=SI3lDQsYd8CRACImpGfulLofBUBh/AVtpawU6yv+3+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvbQUNmDha/doZliNP5yH2zT8/JASk5h0ILAzuG1WWQvJkVz9eDuc1/Tw5MDRRFkIQa0s20lXyMKkD6zFOt99888t5Tgbw8w3ptF7DEc/+8KJnVZFnksz6z9kBv1Dr5nSLLKLNd0KqAbD+DLeTbZha1OCgoDdHt36nw7i6p9oxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=h+E2Y/D3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b07dac96d1eso131453466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 02:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757755633; x=1758360433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llSqr6SrvAH3wy9n6q0vaWwWuQff59HrQWE9Ffc1WMQ=;
        b=h+E2Y/D3jUv7HP1IEMN3DagljMvpNyd9MvYGaqnH7O6iVbTjUoQ5P8V44niaOP7/Mg
         uSg3X9zI9+vdMxsJ32ooHvZqm3dX4f6DKz9rtxjsoatCDdOccdsWfA0tX2TxxpvlBNk4
         qPF+q0jVJmg9w9uP6pFOirHKIl5W6C4fXkpj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757755633; x=1758360433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llSqr6SrvAH3wy9n6q0vaWwWuQff59HrQWE9Ffc1WMQ=;
        b=csAW6osUxWbCbk7uWwiVjY0fdaI80Wq74hv9eZ2qixKA39IBIlp8HGplpfAsNgQvOz
         5toN6d/N2iHthKnRxkAG2jXe6kSbArfuneCAx7izgtMBEBSxQLIv3kymV2y/cT7Izrt0
         BuTbjWKSryvaCSBqGALWDahMigkhR0uybrJyP2yunWi4s7SW3RYCHMMqZ1lPzmSfg7O3
         L/CaaqQ2w+3W3K9Ujv5OK880sEk5WRZMWOJPw/DpREsi6cmns/AT/naoi46Hm6A3+tRk
         6vKFGML5rmnOzqAyHmFPuZC8j1cSsoc4vsLVVLAMnNmCwzrCu3qWiv1RhGSMz1dE3LCr
         WsRg==
X-Gm-Message-State: AOJu0Yy6nvNmmE/U3S78lRfyhY+P4yvy6KRGv31YiGfatF5zRbxSd4Tj
	zT0EZZEGt4FjVhPh14DYA/GH73SI2787wBgJPQ+KrniP8g+gUMuDXS/ICuA+qRdY8R4AzJZxEYa
	V+ExB
X-Gm-Gg: ASbGnctTbd6FJfATdSImPH5LmSEJNysftcm6qezo2qgB8McxBTp11taNYQRhLVYRDua
	I0B0Tn4uPSPp1TJihuEJ3rQJ6RC1vD6yUu+wRYab1b0Xl1UHpu1cCcsG6uP4KgTqngDGliGJeVC
	KydQ/F5VR2Yd0yHeIBnVOFbPK+zU+NHXFp+zu8tJS+EGiQ3RU8+sn+gUyAV1j+GLFA7mfPJqycA
	DCZMhmU30tMmSPYkp56gvbS+G/4Sw3Bo2UJYN+ndI32CqSv0iJ3OloB+Lgt2ArjmF+AMRPRi0Yc
	hP61R8DRM3sgfVZ8a1pco0KVs/mQeVm39DA73YZA8BBLPd7iwElZazkeJkENvR7YOnIQofZyQoy
	W1lfT0XAVdhdbB2G5JIE3veCo3osC6CeC/gtibPQPC2IDcbFS3nhskCOp3EHwegNQUPNuzh95q2
	N1r5si7StgWfPdKvQB2nriEpk6E4mSe4al6KhfLnX4LE96g7d3GxM9l9OiJ+Pd5qOU
X-Google-Smtp-Source: AGHT+IHcZdrPl3YiT8w37AtF2eLwy3H1lf7B4vokF4mlZ6H6fOjpLCxDlkfMTGZH+eFNfBTCbsCKyw==
X-Received: by 2002:a17:907:74e:b0:b04:6546:3475 with SMTP id a640c23a62f3a-b07c22b2136mr684830166b.6.1757755633084;
        Sat, 13 Sep 2025 02:27:13 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b33478besm551705766b.99.2025.09.13.02.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 02:27:12 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org
Subject: [PATCH v2 3/5] dt-bindings: touchscreen: convert raspberrypi,firmware-ts bindings to json schema
Date: Sat, 13 Sep 2025 11:26:53 +0200
Message-ID: <20250913092707.1005616-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250913092707.1005616-1-dario.binacchi@amarulasolutions.com>
References: <20250913092707.1005616-1-dario.binacchi@amarulasolutions.com>
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

Changes in v2:
- Added in v2

 .../touchscreen/raspberrypi,firmware-ts.txt   | 26 -----------
 .../touchscreen/raspberrypi,firmware-ts.yaml  | 45 +++++++++++++++++++
 2 files changed, 45 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.yaml

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
diff --git a/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.yaml b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.yaml
new file mode 100644
index 000000000000..8faa796fb7dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/raspberrypi,firmware-ts.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raspberry Pi firmware based 7" touchscreen
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
+      - raspberrypi,firmware-ts
+
+  firmware:
+    description: Phandle to RPi's firmware device node.
+
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-swapped-x-y: true
+
+additionalProperties: false
+
+required:
+  - compatible
+
+examples:
+  - |
+    firmware: firmware-rpi {
+        compatible = "raspberrypi,bcm2835-firmware";
+        mboxes = <&mailbox>;
+
+        ts: touchscreen {
+            compatible = "raspberrypi,firmware-ts";
+            touchscreen-size-x = <800>;
+            touchscreen-size-y = <480>;
+        };
+    };
-- 
2.43.0

base-commit: 22f20375f5b71f30c0d6896583b93b6e4bba7279
branch: drop-touchscreen.txt

