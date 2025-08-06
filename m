Return-Path: <linux-kernel+bounces-757793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DABB1C6B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9531785D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D03328BAA9;
	Wed,  6 Aug 2025 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9wf9jvQ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520763398B;
	Wed,  6 Aug 2025 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754486311; cv=none; b=c2FyRIxwwcD0mY9K8mx2MZCoTahNyfQpIFP22NCmPUd74dQkF8iNK8hxPvPE2dX+HaOm9AOtq8QNzJgxe1SWT6bu6s4ro5AvedZtwFonTpNBQsp35E5SsHDG8FRZYICdyQ76feNauXbMsCMSrtWzzFvmWB9BbuAmGmyBGzNQaWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754486311; c=relaxed/simple;
	bh=rfgaiLWxVI97cRVXmy6XfavdY84+4UY8Gyiw4Qz4hwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rSG+C0kQZO5MjqM6E3kNuDvN0rdk2+sxLaxDiGf85wtpBDPtmf7IH7SoEeosGPafK2UhlqUdMHf+BJQ3ep9vLUHe4APCDJL0yXgV8MM56eYIPGDLkxUIz5nzPYB/T0OrIl4dLuzgm/oCWRGRn+q8U2mb8oe6faLGV5wDJq6hlfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9wf9jvQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-458bc3ce3beso27461045e9.1;
        Wed, 06 Aug 2025 06:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754486307; x=1755091107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xPGiRTcpm1yV3vPw5mjGOqDhanwq+tGNym74Y47LA5I=;
        b=N9wf9jvQ98uFdssBcti+huf++FeH1T26i0bMk07MwvcTCRnipkkz/Hpff/He7gOkZY
         GUV73VkToiyz0G+yyKfOQ/rVeo/fXwryAFb+eYN2TVLaWMwER+AeIqduRVTajYnUcGRR
         m/uaBooBoL3YrQXj+uTUTGCK7nTwNsAvHqWWOSIQPHLXgTpFBy9Sr9jzdT5Kh6vSYyt7
         R2hwUitM1KNvypEOD4DqcqaN5YVPsQ2JJ9/vaCM2/8BmwRcu1siTb9P/EEYuHL2cx7N4
         TVqpEEY6j+PNNRyhuu6tTuRRQe66XHjQEjt9048DJ2SUke5H9Lj9LgFEMRjeBbFIAz7H
         uN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754486307; x=1755091107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPGiRTcpm1yV3vPw5mjGOqDhanwq+tGNym74Y47LA5I=;
        b=Obl/nWRl7hEE/tVwy0jrRJ98ByOnY2Kx+ZLS5PrISeV3bTb54Dz02pV85HZu8RIypw
         FTD0MLrs78+KmdV3GKXGk5WhSnmbDenLSd+siLD6mESTgjKVXNcKkxpPTYzJU2AYt/Sd
         azKiaW0bf+z2vXR4y2DZ38E4hv+GLIRZUQia9ge3YjfktIkRZ0hjuQpS2ya+jdrkaE9T
         DHuq2O5VwWx34Du+meoKWAPriz6PH4lH1nPttanEp7RQ80p27saYwAbtlgwq+H7bSasF
         eiLsBx0nc46f9vfzLXXl3DV70hcCaxdeiru7YQKfz64GQjgR6uNsRM+76RvQqk7rNg75
         oxZw==
X-Forwarded-Encrypted: i=1; AJvYcCUOsiR9xikAw8NAyKUwpnSKdfml4FhAug2rd9/1zS9nD0J1Ibb8rKAVdlTjTnwgndzubbSh1fkZKAJR9zk=@vger.kernel.org, AJvYcCV9Jb0Idq/M4zViG40lEoUHoy6B0FGII2ZzNb3amxPN1LmYnioeqW02yJr8jEvDjxw9G4SS60G0XICswc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylxtq54azZv9JWlH7BIG8IWGeZ80jEZXbS2Z45a7WmEJYZtz0U
	0FJUlBjAuCQJzGacytEvEOeGLGOIDbZYCKHNJ39wKoFnN7b+7GhDCYjjWHUanFbreaJoEg==
X-Gm-Gg: ASbGncuDBNbeBd9lHgfA1DFEPBX+yO31JdQQJpvyzVNCqPkaVjBfpccRYD4WZXKyuj1
	258vap3Fq4Dn/2lQAUA1ctsfDAgXgnENB0gdIKP3mtJ9s1BqseiN+V58UuKjqlhfdkUGVF+FY3o
	aMnzZuwqLW9vSUJL92++7cm5U8qwG4V77ZUDFsns24m5HXpKL0tsIfbPnFjA6rU+JNujPkQhbD8
	qUj83KZqTkurp46QFi/EbaF2Pg129kXdzbeY+xrXmjregkTQorFa8IwWHnQMkbMf6jRDvD4nFPV
	jGnmz6D1uiOx6Cq7PTmZWDRlmb5+gwczSKmPiicMY0dlOZCTPp+FwAjVmPFpI6JdeZJeH049Q0+
	2i6aKiTyb6pfA
X-Google-Smtp-Source: AGHT+IG5eSmjKB0oUsyK5jzp73+3ckIw7mQ2dBrq516QfGUOitH4EY69ekvQ8//92ihFcZCNmeZoiA==
X-Received: by 2002:a05:600c:19d1:b0:456:19eb:2e09 with SMTP id 5b1f17b1804b1-459e744f690mr23561195e9.8.1754486306829;
        Wed, 06 Aug 2025 06:18:26 -0700 (PDT)
Received: from mmk-tp ([139.179.138.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5862be7sm53219795e9.15.2025.08.06.06.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 06:18:26 -0700 (PDT)
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
Subject: [PATCH v3] ASoC: dt-bindings: realtek,alc5623: convert to DT schema
Date: Wed,  6 Aug 2025 16:18:18 +0300
Message-ID: <20250806131818.38278-1-mmk1776@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I converted the alc5623 audio codec binding from text to DT schema.
This is my first try and I used make dt_binding_check & make dtbs_check to verify
without getting any errors.

Signed-off-by: Mahdi Khosravi <mmk1776@gmail.com>
---
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
 .../bindings/sound/realtek,alc5623.yaml       | 52 +++++++++++++++++++
 2 files changed, 52 insertions(+), 25 deletions(-)
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
index 000000000000..2a389ca95b0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,alc5623.yaml
@@ -0,0 +1,52 @@
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
+    const: realtek,alc5623
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


