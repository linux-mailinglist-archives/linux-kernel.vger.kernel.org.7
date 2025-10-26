Return-Path: <linux-kernel+bounces-870484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F408C0AEA2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B833E3B47BA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FAA24E4C4;
	Sun, 26 Oct 2025 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGJk9bae"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0BC238178
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761499590; cv=none; b=sZyyFaXz5rl7t8s2+ORKI5vmKjOD3CF5/eTNdgmp2OWa2PWHknstut7Dt8TgYIrVbFjwt3ry3Ph1bgyOWfruebLlnu54haPcTfBjqPZj1muOdVvbqnCB2L+7KsHBa9CnVphj5DzneqkBnXfBbCX8V89d1tDp+BdLwLQX0B91SC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761499590; c=relaxed/simple;
	bh=PUQmCPoHMTdvsW8ctn14E6LZQyRG6SCbf1UxlHwI0Nk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=D4EkYMZ2ICJdQCJxoNub0NAF9bFuiWXW6e7nOnO+2k2DR/wr1wmXFir6tbteRNluoZV/ocR4ZBb3opsTtSjQW9QT+xfnDGwMwxWmUnx/sx13+if65RTsVfWeiUZovvHRs5qFbxt8yA57gW7Nah7D62UzkU/yqFsCkCZbbVqkev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGJk9bae; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33badfbd87aso904089a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 10:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761499588; x=1762104388; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBFcLw5BpNBFfDz3lZj9Yn2OsQ5b+bNAVNgkkfKHEVQ=;
        b=HGJk9bae6QHNJUM/R3HooKnD4t3y+U2DB4WeE7FZEvruMnn9Q9LFNQIN8XXwrpjXi8
         s7GhpWPsNc2J5fPJ/gFb5xXy9MZnUh54/YZjnodmfYZ1JfRP0VuvDP/POkag6sKn8Ck3
         L4DH+ssn5oHUSKpLYNbaRTgKpiyfmDDcop/QHgcHWGCBe+HYgskF0+BRPPW3dxreNvs1
         WhlHXV2dv9L+Cyrk9M0sPGFB97kSXauu7owgHBcs7pE7Cc9exIjvQS19qxirOL/Pcgj9
         NbwVlRdxIiZPYGfI1pxuATEtwLmoCxoGYrQNa/G2nj5IoCFVAwp/AFW+ohCSCRFU5Doi
         cpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761499588; x=1762104388;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBFcLw5BpNBFfDz3lZj9Yn2OsQ5b+bNAVNgkkfKHEVQ=;
        b=wCLFrUhYPzO/h1HlONy/C02rMFTHFTrB/ZiGfaE85jogqF5a3DhzerY7YEMn7Mmecz
         BhS7+pUrwSobSu6Ogsdotu/gSddlcZp9g/g2FVb/2sWxKWli6PMf6UxnTCaPFU7lNa5P
         uAJIG8qDRiyQEtQZivzFjX5Zi5px6L4QsmGcvepn4t7SM1yjg63N8QRVkNqgA/6jLI/P
         Wqxu9M2POpccjWAmSJJn/laHV0zlyqVGtwOQORAnZrX6s7SemkWG2jE0hg/c3JUgcNqa
         BiR1MMBSCtFjY/MVNhdBy6wLsD1sa9n2h2juCgBXOWqPvs9M0DYRK8L1+Z9s7WZEbVEw
         posg==
X-Forwarded-Encrypted: i=1; AJvYcCXHSD/qnSfwyFWPxBSncdsXH/e9OFGjTUFZ4gyKv5gyDM8eBb3yDNXwDX3EEKk1AZkzf8lT5i4KxC+zfb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT6D+rKkHHY4Uny+clxa9d9TnEvKBObF2zH02na8rbapn5/cvj
	0NrWmh8CDdFqKrdBqNC/hknt632qFsn1lWMlM2RmFM5kZgv9oBkLXb9zCAiiWRtU
X-Gm-Gg: ASbGncsN8FkW301fpW5KIojt2x2pDgIthJEYauKJT9tvQfgsMLTXl2JcpqGbW+NxvDh
	EaMRdnZphymHZ4BVib3cPs5zL8rY9Xp4koD21zxO/ByifHCjkl7t97kFbvwP3m4ivqZbH8+brvd
	ZWZwOK20V5cDipx8j8DWlv3k8hv1UNLO5o0QQz6nkLYmjxe1aqhdi1ybrrPeKbWHgiAGUA+yQI7
	hPELhHxTM0lFiEvu8YaEGK5/UEWMeTd70D4eStPo3mE+axOv8ka9tJs5oejUfg5Qt4s8SMZuRnS
	QvC8YAh81m0/JuDiX2xHk4+jyDQSGBSye/wcA+Kp7txeRE8BVDUbuYFxHyJSWtkM5WfGLVxpjQN
	engMwiybhisdF8oxn71nyRMtZ+J0S5JBeXiLQ7AgZyUZL99Jy+CBCi30CHCpiKsR65flg+OKcub
	ZwQdM6DX/Wy8cNFojvKtg4HCBegY9W4eodjhzrsFNTvAKo2rLStiWy
X-Google-Smtp-Source: AGHT+IExMSyElm0YxdAezEoVlByvabJImhmVB6WrfVipcFwJosQYBkwt4hrxz8uBWbeds5UW5QFeaA==
X-Received: by 2002:a05:6a20:258a:b0:334:8d22:f95d with SMTP id adf61e73a8af0-3392f835684mr14940008637.2.1761499587735;
        Sun, 26 Oct 2025 10:26:27 -0700 (PDT)
Received: from [127.0.1.1] ([2406:7400:10c:a59a:f324:3a40:f5b9:3811])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414015724sm5433692b3a.14.2025.10.26.10.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 10:26:27 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Sun, 26 Oct 2025 22:56:16 +0530
Subject: [PATCH v2] dt_bindings: sound: ti,pcm186x: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251026-dtbs-v2-1-cd3b713a288e@gmail.com>
X-B4-Tracking: v=1; b=H4sIALdZ/mgC/13MQQqDMBCF4avIrJviJCqkq96juIhj1IFqSkZCi
 +TuTV12+T8e3wHiI3uBW3VA9ImFw1ZCXyqgxW2zVzyWBl3rFmuNatwHUcYZnDprqekQyvUV/cT
 vk3n0pReWPcTPqSb8rX9AQoWqsYbQOd2age7z6vh5pbBCn3P+AvDPeSaYAAAA
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
 david.hunter.linux@gmail.com, khalid@kernel.org, 
 linux-kernel-mentees@lists.linuxfoundation.org, 
 Ranganath V N <vnranganath.20@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761499583; l=3652;
 i=vnranganath.20@gmail.com; s=20250816; h=from:subject:message-id;
 bh=PUQmCPoHMTdvsW8ctn14E6LZQyRG6SCbf1UxlHwI0Nk=;
 b=kjNKEEdaT5Oxrzi0nbqHtUt2Gaytpog/0p+HvEumeOqM+G4795JeBDHfr1TnC1bRxuwtHWRRd
 GE0gKtCdUjDD18/H2P3fSzgT5unbP7owrLdnTh3nazo3O3fS1FLhm4K
X-Developer-Key: i=vnranganath.20@gmail.com; a=ed25519;
 pk=7mxHFYWOcIJ5Ls8etzgLkcB0M8/hxmOh8pH6Mce5Z1A=

convert the Texas Instruments PCM186x Universal audio ADC bindings to DT schema.

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
Convert the Texas Instruments PCM186x audio ADC bindings to DT schema.
---
Changes in v2:
- Fixes as per the reviews suggested for the v1.
- Link to v1: https://lore.kernel.org/r/20251021-dtbs-v1-1-493c1aa253bc@gmail.com
---
 .../devicetree/bindings/sound/pcm186x.txt          | 42 ---------------
 .../devicetree/bindings/sound/ti,pcm186x.yaml      | 61 ++++++++++++++++++++++
 2 files changed, 61 insertions(+), 42 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/pcm186x.txt b/Documentation/devicetree/bindings/sound/pcm186x.txt
deleted file mode 100644
index 1087f4855980..000000000000
--- a/Documentation/devicetree/bindings/sound/pcm186x.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-Texas Instruments PCM186x Universal Audio ADC
-
-These devices support both I2C and SPI (configured with pin strapping
-on the board).
-
-Required properties:
-
- - compatible : "ti,pcm1862",
-                "ti,pcm1863",
-                "ti,pcm1864",
-                "ti,pcm1865"
-
- - reg : The I2C address of the device for I2C, the chip select
-         number for SPI.
-
- - avdd-supply: Analog core power supply (3.3v)
- - dvdd-supply: Digital core power supply
- - iovdd-supply: Digital IO power supply
-        See regulator/regulator.txt for more information
-
-CODEC input pins:
- * VINL1
- * VINR1
- * VINL2
- * VINR2
- * VINL3
- * VINR3
- * VINL4
- * VINR4
-
-The pins can be used in referring sound node's audio-routing property.
-
-Example:
-
-	pcm186x: audio-codec@4a {
-		compatible = "ti,pcm1865";
-		reg = <0x4a>;
-
-		avdd-supply = <&reg_3v3_analog>;
-		dvdd-supply = <&reg_3v3>;
-		iovdd-supply = <&reg_1v8>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/ti,pcm186x.yaml b/Documentation/devicetree/bindings/sound/ti,pcm186x.yaml
new file mode 100644
index 000000000000..306905eebd68
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,pcm186x.yaml
@@ -0,0 +1,61 @@
+﻿# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,pcm186x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments PCM186x Universal Audio ADC
+
+maintainers:
+  - Ranganath V N <vnranganath.20@gmail.com>
+
+description:
+  The Texas Instruments PCM186x family are multi-channel audio ADCs
+  that support both I2C and SPI control interfaces, selected by
+  pin strapping. These devices include on-chip programmable gain
+  amplifiers and support differential or single-ended analog inputs.
+
+properties:
+  compatible:
+    enum:
+      - ti,pcm1862
+      - ti,pcm1863
+      - ti,pcm1864
+      - ti,pcm1865
+
+  reg:
+    maxItems: 1
+
+  avdd-supply: true
+
+  dvdd-supply: true
+
+  iovdd-supply: true
+
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - dvdd-supply
+  - iovdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        audio-codec@4a {
+            compatible = "ti,pcm1865";
+            reg = <0x4a>;
+
+            avdd-supply = <&reg_3v3_analog>;
+            dvdd-supply = <&reg_3v3>;
+            iovdd-supply = <&reg_1v8>;
+        };
+    };

---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251021-dtbs-3a31f699c461

Best regards,
-- 
Ranganath V N <vnranganath.20@gmail.com>


