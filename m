Return-Path: <linux-kernel+bounces-823163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9A8B85B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFD9622D09
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAAE3128B1;
	Thu, 18 Sep 2025 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Zk+grS5S"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246693128A0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209800; cv=none; b=ECd0QioXTcDc61CpyrXUiXi+ZMEpoiN7awSY8+bF4Ed1o+sg1XHjP9eb8fX7nXe+QcZYhf11mDKhaJYU1Md/P01A9KMGhor97ZOylJbL1RvJ/h0iqRjxeJ/IfKtLEqGX9Klc70pGz7EIotVDXYVp6EDxpvmV+OGPSwddTuBEHTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209800; c=relaxed/simple;
	bh=WHRaGrKLsqVg0CPq9CQiAAjtX1UXdov4WyNhS1fqM7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Di5l7Z9NydvFcNqmjdX0K3ECjq75z/Ji3TBdNcJuM6XiveBuKIH7OSUoPSnrhlfNMplO8fm15KbMwvyYH2Y5PT5okJ2WR3h03pcDTbdc9BMGy6WjiotE0H7FcE8touYtopLiHDEgZJYOv84qHy7We6w3EtBEkU0kz+g3c8RItJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Zk+grS5S; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b042eb09948so205699466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758209797; x=1758814597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEyYKH4qkqBCP6LUsqOTNG7YVoVZeon8od5MlA8LTKM=;
        b=Zk+grS5SF3U8JWeHCWcFhq2576lLX34BAZGYuKsJuaxV7pfH+c/bq0NACjTVbLA9B/
         drMR6Vt+VL1HBHWSLmJbULSinK2siWjQoZwXqAzwy/69f8gJRT/0dxfCTlYcnuaLs8sU
         z3H/zW7/wAevSYrlJSS4I6YqqF+bwUprI2vNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209797; x=1758814597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEyYKH4qkqBCP6LUsqOTNG7YVoVZeon8od5MlA8LTKM=;
        b=PfZh+C2oGeObhBnlUIUEoUFU2gE2lxlO8m6wV0ssKlN2mKKNW9QpjIDc8iZPnIGy2J
         N5NMFq6Nn6tcQn7SEb4yXgBE6ZBkzAfD8f30qwDCohBriZzTl4TDbpv48DhXCtPRtE34
         TeaHE1WEcMEJLKVUUyGynYxGln+ZeHjjMRWrksGfFmEqW9h5Kp+4sVnoFknFdAIPcd87
         e7vt++RUGjdGPRn4JMtVRabDQd8GDt3uGwIUiA91X2Pf/ZSLfEQFJ2Go5H3gOMdvx49H
         EhBVQltugKgMj0YwlQiILuo30D3iqsA1RmE1UydYp8jwAGVy/geqmvzHUFHzgh2t6tY+
         3JvA==
X-Gm-Message-State: AOJu0Yw8XU3WUAjseZIHuasTy2qPyvPrk05aSxM8GR5SDYBa5UyDUyF2
	vZ8JYoQUjpi0v8Glc0hf9Lshh0S5F1s5SyPEB5qgks/jO+c8Pj2RqoTvQWzKth+3oxsHRpOHips
	OePSi
X-Gm-Gg: ASbGncuFR+KGh/M10/Jjps9BIHJGLm1XHQEwoGTw0tP9uTrOzdrSiZQ32cc/Q/58A1i
	KiJ3UXGXGk6uytaxzNhSSvtZVgNi2U4rM7vdptjxFDkXNpctKnbMk+kW1el6tZzIJXWu7144tby
	VGP+4l2PURWcg5ZeHvN10xBuD6cXCQlMtPX6jGBy4M6fJg6waoosTDM7Vrr/pXG5M2kQk9nsGqV
	LPCKAQREx2qgyCdVE8tvTlgSJtvWTPn4U1Qe6mC6t1grbGsM7d2Z5+vUdIvAp9Qrf/Nlkz15/ue
	DHaTckK0SmpxtK0tw7G7VgtW8GZPENtH9b0mT4Hw6qpHOmtVQrV4djO2yaoCNdlqTqVHJWwuCvl
	BjyhueJiJb0YxKjlND0dn01hHkdDYzURhOGetpB1k4p1VJCXLBpCvRxoq/MDl9QPkzDmFaeZTxp
	z4L9WacXP5h7/H+6N+/Ir53pqsSZHOdgvLZOa41p+EfeoygVxtR8vpE7A55wTEGdInUXWKk/Kdd
	dy8xRxE7Xw=
X-Google-Smtp-Source: AGHT+IGYaHFbg/1QCb5L+gBEaKgygAIv/jFGntbk+uDxzoL55Zp1d+zUktfDGz/HaUwuss8VFlD8jg==
X-Received: by 2002:a17:907:2da5:b0:b0c:fdb7:4ddc with SMTP id a640c23a62f3a-b1bb0c43f6dmr683814966b.19.1758209796976;
        Thu, 18 Sep 2025 08:36:36 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd272026csm212430766b.102.2025.09.18.08.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:36:36 -0700 (PDT)
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
Subject: [PATCH v4 3/5] dt-bindings: touchscreen: convert raspberrypi,firmware-ts bindings to json schema
Date: Thu, 18 Sep 2025 17:36:08 +0200
Message-ID: <20250918153630.2535208-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918153630.2535208-1-dario.binacchi@amarulasolutions.com>
References: <20250918153630.2535208-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v3)

Changes in v3:
- Drop firmware-rpi node and use only touchscreen node to fix warnings
  you can see in
  https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250913092707.1005616-3-dario.binacchi@amarulasolutions.com/

Changes in v2:
- Added in v2

 .../touchscreen/raspberrypi,firmware-ts.txt   | 26 ------------
 .../touchscreen/raspberrypi,firmware-ts.yaml  | 40 +++++++++++++++++++
 2 files changed, 40 insertions(+), 26 deletions(-)
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
index 000000000000..697c508326b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.yaml
@@ -0,0 +1,40 @@
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
+    touchscreen {
+        compatible = "raspberrypi,firmware-ts";
+        touchscreen-size-x = <800>;
+        touchscreen-size-y = <480>;
+    };
-- 
2.43.0

base-commit: 8b789f2b7602a818e7c7488c74414fae21392b63
branch: drop-touchscreen.txt

