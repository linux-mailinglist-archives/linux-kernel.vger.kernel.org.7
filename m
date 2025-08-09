Return-Path: <linux-kernel+bounces-761017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2A5B1F30B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 10:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24AC172558A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 08:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D5A22156D;
	Sat,  9 Aug 2025 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lttuJLFW"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BD1225A32;
	Sat,  9 Aug 2025 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754726914; cv=none; b=lmMUoGakbuKrkHjmb+w2kVfw44yVEPDomiG5Gm8ZO/sDekRUkbc9GPS5Bib0cBK3BWfEIgqOS+O2LRvDFbIR4xEJONkTLcueCylYmP9lDrKz/qBw4dnC58uyZjWKw9ckjfygD+R/qahd0wl1hUsTojqQ7TUnPSeUSffLpp9cVMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754726914; c=relaxed/simple;
	bh=zxqVNvlmFBueyIpfaw0chLiheUGrJ1bn4hX2Kep9wY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/gFaFFGN0VO9aLN/ygp1W8v6TQcpsbc+UssHw49fPhHN7mQlkog0kOBx3pCBsrZ8rvFfLlBVJYSRSiextE8oVmd6TZ+t8nJqYTmDrNzwYXf8FOqboOENzqx5dL3GSwM7u/+rCTY7c/OaBdfOQQbqzYFbkhg7DpOUkcwm/1qjOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lttuJLFW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b8de193b60so1673242f8f.0;
        Sat, 09 Aug 2025 01:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754726910; x=1755331710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bO63kbpz8+8BzniFjwRj6G4Qq7weRB5CNspOoOAO+Xo=;
        b=lttuJLFWutHCpTmF9EYsLu0zcE3II9PhnC9GWb+kIQA7Xwq6CQ7Hv0oyyb0d5ZRKtT
         nRmbXMRYiXwnnDfbcWb0CKtGBqgRnJHi5QNWOu1LDSbRk1iRj9JWH6FYHNYL27twszxZ
         MyJ7du/f/+hjocHJdFm2vcogy65/I1jdoss+CCfPA+V7Ihh36cFLwxfJYC2uinqtrtcI
         yPwTkDR45k9ZbkanieZIbkD5zJYq10FImYAipLClyXcWzaBkbBglg/VOzEGjUoswIO+D
         CpECHmF4aKrY6Kyd6y5o/9X7GsbacR33r0P3qsA7vTsV+bbamVL3s3rRhJZuXPGLNRF7
         MvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754726910; x=1755331710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bO63kbpz8+8BzniFjwRj6G4Qq7weRB5CNspOoOAO+Xo=;
        b=Co0O+GT6WMgqpApCwH1QMu6SA6p2KiCAw1jVcbTkfO9jBtJiLz5/ZSnyyGPTBM14zN
         RJ+PT1nOJk50rQp4IYdZo+fWTmqkTi6ADGqeAJIP3XVoB6gCD30ALSfhKzrGihvIsiRG
         ClQa18hm61Uh3VJGST8W19360Febc7brAuFUDwBt8ODvGComxHmHQitOKuvjKZF1go1z
         uIX/r1jZ21NrOB71yBMxXHl+tzFYMq817IQkvmZ6p05pSF1qcCVbzqwb4e1FHIyz+5o+
         Uo15P/5f5VwIyt/oS2Y0Qr/BUB3Gje421UFBS7Nvs3JXv80zqEHU4vmCMao3oklGFC5c
         TpZg==
X-Forwarded-Encrypted: i=1; AJvYcCUSHFY4wb4wyw0FMG1Be224j1ldH/z9tVuRF2baNUnOP/uxLZXvpcx7RRfNw751M2FvZQYzfu7sK9tmtRQ=@vger.kernel.org, AJvYcCXfwuK6D2IRbrHns3ifkoM4oYZYA2i1MhlJwDuJXDAx1x7lZETGpO/hov3LHU9ZrlctPoKmNWfzG+HZNFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4rdjpCRTzbdJeSzIzbT5v+wC1CwqOax6jCCE9mQ66xSSalIRL
	La3OwlFjvKvtV+iiLhr1utklEz+wCPRqTfhANoqNvHvOn3IB5vfMdkV0KuW7pecV3V2h2Q==
X-Gm-Gg: ASbGncuSfeEyVYUakm4PqFNZORQq+LYgL3wVpDmmGcdiUuI4kS4COVpj/tuEn+h9wTs
	NWjCdFdIpi94nNmUQRcwUjFiYG5RLFO1FU62shZDazalIPtKdog7rukMZAPU4LtdXfeTC/2oTFu
	XMo1ZpB03qzzDsbN9rxVKBYqRST1fNQgnMMAST0Ffc0oPsYNcBuj2vJdT3UzZ5qH6Bgy89gm0eR
	XKKfoLOwVyhCQIOtcGuyJjKHSXsDOqjbLhm01seKXb/xincSNfxkuTU/FjppCvhgzv3qgfdQl6Q
	WXbcJC1s26F9HSgrqLiG15CfcZHstDytowx0NvH0LC3GDWmIqoN5vGjHb56/eCqbAym9PqSHI15
	y/BQVCNMzm7MnxgA=
X-Google-Smtp-Source: AGHT+IHDWCw/q0WaB4EMZMox+xYQMzAajDWTVvScx+MoxUHFCsr91rFaz5iWccvYQPwh/Fr4EUAwyg==
X-Received: by 2002:a05:6000:18a6:b0:3b5:dafc:1525 with SMTP id ffacd0b85a97d-3b900b4b727mr4817748f8f.33.1754726910280;
        Sat, 09 Aug 2025 01:08:30 -0700 (PDT)
Received: from mmk-tp ([2a00:1d36:1034:ab00:136:d194:45b4:3fb9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459fb43b491sm31291005e9.3.2025.08.09.01.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 01:08:29 -0700 (PDT)
From: Mahdi Khosravi <mmk1776@gmail.com>
To: devicetree@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahdi Khosravi <mmk1776@gmail.com>
Subject: [PATCH v4] ASoC: dt-bindings: realtek,alc5623: convert to DT schema
Date: Sat,  9 Aug 2025 11:08:24 +0300
Message-ID: <20250809080824.68845-1-mmk1776@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert alc5623 audio codec binding to DT schema.

Signed-off-by: Mahdi Khosravi <mmk1776@gmail.com>
---
Changes in v4:
- Add "realtek,alc5621" and "realtek,alc5622" to compatible list

Changes in v3:
- Drop allOf, just use $ref for uint32
- Remove stray '>' in descriptions
- Fix subject to "to DT schema"

Changes in v2:
- Add dai-common ref
- Switch add-ctrl/jack-det-ctrl to allOf uint32
- Use unevaluatedProperties
- Fix example compatible
---
 .../devicetree/bindings/sound/alc5623.txt     | 25 ---------
 .../bindings/sound/realtek,alc5623.yaml       | 55 +++++++++++++++++++
 2 files changed, 55 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/alc5623.txt
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,alc5623.yaml

diff --git a/Documentation/devicetree/bindings/sound/alc5623.txt b/Documentation/devicetree/bindings/sound/alc5623.txt
deleted file mode 100644
index 26c86c98d671..000000000000
--- a/Documentation/devicetree/bindings/sound/alc5623.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-ALC5621/ALC5622/ALC5623 audio Codec
-
-Required properties:
-
- - compatible:	"realtek,alc5623"
- - reg:		the I2C address of the device.
-
-Optional properties:
-
- - add-ctrl:	  Default register value for Reg-40h, Additional Control
-		  Register. If absent or has the value of 0, the
-		  register is untouched.
-
- - jack-det-ctrl: Default register value for Reg-5Ah, Jack Detect
-		  Control Register. If absent or has value 0, the
-		  register is untouched.
-
-Example:
-
-	alc5621: alc5621@1a {
-		compatible = "alc5621";
-		reg = <0x1a>;
-		add-ctrl = <0x3700>;
-		jack-det-ctrl = <0x4810>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/realtek,alc5623.yaml b/Documentation/devicetree/bindings/sound/realtek,alc5623.yaml
new file mode 100644
index 000000000000..f9c9518cd084
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,alc5623.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,alc5623.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ALC5621/ALC5622/ALC5623 Audio Codec
+
+maintainers:
+  - Mahdi Khosravi <mmk1776@gmail.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - realtek,alc5621
+      - realtek,alc5622
+      - realtek,alc5623
+
+  reg:
+    maxItems: 1
+
+  add-ctrl:
+    description:
+      Default register value for Reg-40h, Additional Control Register.
+      If absent or zero, the register is left untouched.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  jack-det-ctrl:
+    description:
+      Default register value for Reg-5Ah, Jack Detect Control Register.
+      If absent or zero, the register is left untouched.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@1a {
+            compatible = "realtek,alc5623";
+            reg = <0x1a>;
+            add-ctrl = <0x3700>;
+            jack-det-ctrl = <0x4810>;
+        };
+    };
-- 
2.50.1


