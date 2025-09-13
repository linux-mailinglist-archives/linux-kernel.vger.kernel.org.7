Return-Path: <linux-kernel+bounces-815111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFDFB55FE8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 11:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DE95885B7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 09:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAB02D5946;
	Sat, 13 Sep 2025 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XtZdpwQT"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400142EA736
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757755638; cv=none; b=A9UHUmxDyZ8kjxlCg+2nw2k7gcrXsTRW2OM8faYdFqJd/TU6LLrwrEpqApoMn0AwaajNsmunXVa9PPkSE88EuldeL5krI7+96T6ozk6eZ9b1kyG4/smIzb+O5Lt1wNOzWjunLHng/3t+ha4nXPeY0flGsnmDZn44DdliQf0C5Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757755638; c=relaxed/simple;
	bh=OyzbIHease9EEYAbJIr/UO0Oi4xj2IKpsRHXJ9y0e6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uN4I/db24qZG0Y4SxU9f+2v8y8982leje8lGbD55k1e0LjQE18W6CuossFt318WcdzoFlYw5fz8B8fX56wyuFDBe0AhTLNRFDt/HBjnR63CrfNCdKC6Z5FoCdHxiySXpuKSOB6/fNyd64PAZfk8vENUpeK28XAt3ssAyOEi0AfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=XtZdpwQT; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62ee43b5e5bso2498451a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 02:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757755634; x=1758360434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8sTG2aW7CCN6Ok61/8IbQqhCfdouCWd9pDONO8Yrxw=;
        b=XtZdpwQTAkwfJdWwlrHFX1K/wtkhRLNBcgiseFL7vC/F/K8B2Pvyg2IMbUyTn1RdWn
         cdcRw3sE/vH50wcNKziRFjrqG+CxXDlWBQQUxO34GV+VqQsq1rcEKV5yh5Tq3ofjzyp8
         fcVZ9S5ifZtCEggShKCz3Uegxu10j81JybGTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757755634; x=1758360434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8sTG2aW7CCN6Ok61/8IbQqhCfdouCWd9pDONO8Yrxw=;
        b=GkRy7dV8D8hVuh5hYZIRRtcGnoJ0DSKceowkEc87KamY1wjYx7ywfmyozGiMeMEVxh
         Xou/V4T3nHo1UNtcyb2UuER09JYYae1x2rAMEOZRhRgtshzsxxDRNbBCJzntO0AhqkMa
         9+P9wI4FNORi4QcgRU69B77ukWRI6xqPLjiQt+itxjG1sDQMbGpfD6as2m/dE/4qTlOv
         BmySAomYVjNxeA0iVtmkJIn60MlOB/ftMaZolnkmlbpASQQ6iY41aWCSnN5TJn88nupS
         /VrqTOeeJrftO/Yuupgb2JrOn4EWbP+2zqiFUWsHUIYB3Rg2sJzfGjmCAFEtfa0pyHEt
         KObw==
X-Gm-Message-State: AOJu0Yz1R2X29OcjYDsYM0WIccYn8Whn3uBwd9UZYz/rG6uufgxTLsWL
	VbM+ahjU3RUsyyJQMMFENNe9jjxxnOisHUe+vr7xDi8TmljuyLbg/J4ZAPTQeQBquZ51TFqo4Ju
	7S4CJ
X-Gm-Gg: ASbGncu8BrHUZqH42XoAePAXSKjYuMKockDwt2EaVjuStePDRviEGO+f0HeMggZW9AC
	Rqt2xr8OfqslSNJU1rMp/41Yu5HxrItVCxJv8djLNVZe3xSaOsc3QRDXJWsSUDs1WSQz4JQxdW+
	Jheeffls5OnHmu6pOhx2fQ7ZQhzW2tk303gtk00WKcf4p3mC+O/SKirr5CGJ2Mzg3BEg+KsDDg3
	ZHDhK5dtdeUIE+NowGfzmtxXD4KhCVOnnemRxBzFiu43soV9dkSdu1fcNUEMKUN4n2VE2b78G4C
	MgmCiA0rrCLd4ip8IdXBBe0Ey/X3lfgKXlEEMt9FtIzUV4h6tisrTKujYNajU1dbL/9E//iZ4c4
	fCm4NpFdfiLVob9W2mOXvumZLy+nY6M845NsBRr2WeSEtilTLnBmlW8Bqb28jGXfQdnSpEq+Glh
	1o9NVBFcAGPYTb1GF7oYk7bKIN9ct6OiHAi6nmH00gGZp6qFVH+NirBF0OYw3t05/SxDCtpRef7
	DD8xTtC3fCdCA==
X-Google-Smtp-Source: AGHT+IGDgtfcXCTKrkwWfNIswey6Q82jjAojqmnYLlWD9nANCJYHBa416Imm5QX70EwDR8EVn7lX/A==
X-Received: by 2002:a17:906:794d:b0:b04:8701:7304 with SMTP id a640c23a62f3a-b07c3546e64mr582834866b.10.1757755634269;
        Sat, 13 Sep 2025 02:27:14 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b33478besm551705766b.99.2025.09.13.02.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 02:27:13 -0700 (PDT)
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
Subject: [PATCH v2 4/5] dt-bindings: touchscreen: convert zet6223 bindings to json schema
Date: Sat, 13 Sep 2025 11:26:54 +0200
Message-ID: <20250913092707.1005616-4-dario.binacchi@amarulasolutions.com>
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

Convert Zeitec ZET6223 touchscreen controller device tree binding to
json-schema.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

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

base-commit: 22f20375f5b71f30c0d6896583b93b6e4bba7279
branch: drop-touchscreen.txt

