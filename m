Return-Path: <linux-kernel+bounces-750489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31C7B15C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378FB5A3309
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A782A29552B;
	Wed, 30 Jul 2025 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFkkwXjf"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADE3273D95;
	Wed, 30 Jul 2025 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868243; cv=none; b=rGNvbXugYgdTVyALkBYGEFIy5aV5uVeb7aD0foK3YY6hnuKDxUyTpu0mh3hMeXJ7Pfp5vSe60ivGV82qYHuSPCO/M8Ls2MOwaS/X8YqJkFQYB44XfdsdKh4W8cbC37ra4p8INgUOKby07eDZgbhAzp/2qQK07p306QPa4vVDP0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868243; c=relaxed/simple;
	bh=6QTZt0b1cPPLNSSULV2L1y0naUCZF/1EHqcd3FtSxbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eO2y9HEFB9mTT2HONLIlqmq7aVex5IAL7zF89xB7D5VfIPXAnOhuv+Lcv14JuzA5WKs/gAgE4ELIixXy5uqYTE4ny0VsCDDol5M08eZjMcCyne8Ifl5JaLwKA9OLhVe3fjZb9QeyX6B+peRMCF+pJz2ZCgSDv7zgBdQ/mvE9UBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFkkwXjf; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so1365413566b.1;
        Wed, 30 Jul 2025 02:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753868239; x=1754473039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i6YOO0TzbEQfaaf8W4aY2z1q9/mDeUmckMbIor0Gmtc=;
        b=KFkkwXjf24bockVc6E0cJdfZHvY6yA4dYmspGNKa/1iZDaI8J5hJk8DSQPGoSa3VxO
         m7AjfmUUFSq+qzObMrNYVMANY333HGnAFLdOYwGL0SQqhxoIFReAnFVSmfFlrLapy3vA
         itmIi00qBqWjYwADiT4hFCL3ovtJTXdd+1s1+q8K+WN7KJyj3udsQ7SZer/jkYB5f5St
         xDwjfq7L5i6n/Iyi9lPiz8Jct7DdmwEt7JRWXOwD9VUOzjRm9sikP+6nAIVXrXSFNp0L
         0/unk6Pa+FfOg9VmEDs2+iyxLrOKFvD2gw5rwuvE3luRdF3ZaUouXY6du7uwpM879Blk
         5v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753868239; x=1754473039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6YOO0TzbEQfaaf8W4aY2z1q9/mDeUmckMbIor0Gmtc=;
        b=plNP3K98qUvF8oNKoKujtcaYkAhF00Yr2aMCbRAJujG71GwF/iqReqpmVT1FeMqA0G
         uMq+LsrNyn6CRViRbiyzkPHDX2bmgZw+B/AD4NxkNYZ9OnhEDZzP3ZeZRZ0FNNrc6h17
         S/nPOp4ovUbOK4LDgewONFdybcrL33qwzPYppENZoZawPRGNExOJGtZyslrZqRsE277G
         NL5IrvSotCHa1MBKTEqi01BcmEAgIOu9CPNdIP5Uvz+qsgo8GSKrk2J2JaRnvLyFFzkD
         lg4qt1lnEfeQmJZwDu13Ce8g7UauSDtfW5kywM+eEFxw+vXTXZM1wNikD6UFk/W+OU08
         rQzw==
X-Forwarded-Encrypted: i=1; AJvYcCW3hzqLiw6JSqi61U8Xoy5/Yukghv0S11cA/hLa3586I/wjUip79Ai4IXijaAngpKgDpXRDUwksWmml62Q=@vger.kernel.org, AJvYcCX5MgEPwrMWdCuNpe65j6XDh/6GL5+EgvwXipXPgaxPg0Iw4nJWzh+9M6s+N66ZtiSEvwNI3g9iBgQBa70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKS0z5CY7e4NB+RC5dPTTwaGLNGTAPsj4G24tVZrlpRKume8Jr
	Rsk9bgR0w9tUwa+5ncyJMvDo9zT+jnYHQL6ZBFcBoXUOVASJsBN+K3jCOOJvmlyqyRQTHg==
X-Gm-Gg: ASbGncvgQ0g4xE1AXVGWo5xrFiLuWvSz0esyu+k5z7gb2IMfqqlOjrOg/QfJe5VxmM4
	ePYZF2+unzwX88uPV03w81GADBs2j2GrO/hbCjF8t5SwKbt5qld1Tw54u6qALXCnfI9BEG+874V
	PDQCmZpfZgC4fmuNJv0Q3pGIFodwowjxD5rtzH0NQR8mClWYj5w4Uiw17o4vc7+fpNLRFRalvda
	SCf7KIWksuc5KjBGv9CQ9hBcj3Iys0F0I5IpfngULLi6T0+1xHhhL0G4U5dGDHXhRFUCn5E6UNX
	+7VXZPS5xMqVrnhNuBMeX8gJUrbU1FXKcJIogI3dUngjLSwPsnD9JOwa3WagjKc4ZPl8LYv149I
	CstCYvNir34G8
X-Google-Smtp-Source: AGHT+IFVrjm/Gel7dBd1tQUVbUu9FUqdxDRDLKGo/ZG7N4mrpESqaZbBEBDPGVM6BhDW1FhkEaYKVw==
X-Received: by 2002:a17:907:3d16:b0:ae8:e6f9:7cf with SMTP id a640c23a62f3a-af8fd73d200mr302379666b.23.1753868238850;
        Wed, 30 Jul 2025 02:37:18 -0700 (PDT)
Received: from mmk-tp ([139.179.215.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358d1abasm729312766b.63.2025.07.30.02.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 02:37:18 -0700 (PDT)
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
Subject: [PATCH] convert sound: realtek: alc5623 from txt to yaml
Date: Wed, 30 Jul 2025 12:37:13 +0300
Message-ID: <20250730093713.104003-1-mmk1776@gmail.com>
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
 .../devicetree/bindings/sound/alc5623.txt     | 25 ----------
 .../bindings/sound/realtek,alc5623.yaml       | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 25 deletions(-)
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
index 000000000000..98524d06458c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,alc5623.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,alc5623.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ALC5621/ALC5622/ALC5623 audio Codec
+
+maintainers:
+  - Mahdi Khosravi <mmk1776@gmail.com>
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
+      Default register value for Reg-40h, Additional Control Register. If absent
+      or has the value of 0, the register is untouched.
+    type: object
+
+  jack-det-ctrl:
+    description:
+      Default register value for Reg-5Ah, Jack Detect Control Register. If absent
+      or has value 0, the register is untouched.
+    type: object
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@1a {
+            compatible = "realtek,alc5632";
+            reg = <0x1a>;
+            add-ctrl = <0x3700>;
+            jack-det-ctrl = <0x4810>;
+        };
+    };
-- 
2.50.1


