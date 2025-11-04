Return-Path: <linux-kernel+bounces-884586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E153C30886
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C615734BDF0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDA52D3221;
	Tue,  4 Nov 2025 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAXgJBqV"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC3F2153D4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762252508; cv=none; b=lUOu9dHlrxX7YdBzjhkydeA9c7s+a/rhoRBNG6W7e3EN1S6RnAG/y+dDxkQbVCjC3+jN6PGdODxkKvtBGgp8ospaC4x0L+lWz0eiR9iVakx9HltDou6s5bbasn3dG9zp+iEwcByEZOFOdsYUVKFQU3dqxvYi5MmAnx6NCcQXhsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762252508; c=relaxed/simple;
	bh=xVTUdynUwOEfXOlM6iD7wg5Aog37SJxR0DlPuRS1e6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DzLlg+5BR0J2Sv9unYXMcppZ26S54aUf/NThvMjrBFaQpX7/cKJElQZq6QcoUUstkpJkTamJP8GxsVUAeFtZ9Wvp7ruEQvgGYudrGYKbA8lbX4+59OMWdcGV+ZZAT9MtFwMTTA9H6rqzsNAQYNlOHV109TCZIx2nMDe9jvma0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAXgJBqV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a432101883so576097b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762252505; x=1762857305; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S1ADCCgwMEU/f2OqLSByXu6fQ7rnsCgcBrI977wEgzQ=;
        b=VAXgJBqV9xcXWSjEYK1T+dxbraXkXa214NO/d5zSkgKFJagQgXmydt/MmSkDptb6GZ
         nTKVyYV8dEjp4zD3bowRr/PNTTQNHRrDO5wlbbAc3x6Pa4axj6M9/PltyG1kmAuNQfY8
         +Y5dtvV0AZgRyX+bUdk0mSlxZ9a/LbZwL7GyEq/JSYiC2r1ezlIqIN8wLHmaY2QK4Ivp
         1IJiAwo8Y96Dna5rW6cv9Dfd9hOWnE2nTuEN37vQaNzkV7dvxqO1j8CMxB7KFiH48+XO
         HV/fQLmOiDrVMK4wIlHR7/so1Vd2WI+8dPzKnr4Z4lKtsIC4YAiXhVdfhCm1CEeq2DQH
         Sqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762252505; x=1762857305;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1ADCCgwMEU/f2OqLSByXu6fQ7rnsCgcBrI977wEgzQ=;
        b=QpAt1OLWbbyBQnAddiuDq52OwL9dRfdDiLxqKLVyHRIdIn+0qvOwK5CqoEqgc1h2gi
         DTBwYtAfjklm9fkNRKMuNOcTfvTc+cOMFFYbqVDdppahVmGs/LlXeCKdK4/wHbwzs44U
         oJowfbsmUYKlSZWp5bqo9bizDiXOO2OzkAjQ3YIfH0gOrUbImL0Djw/Ers1/tmcnMz9s
         Bf1GBUL1kXnk+RpAYb0W1FDjWRAwCsTA+NWYTVlNr1UIX7q4RjK+CrfvD2TDOY+6/Bhr
         QZXSyh3MFgF36o8qNOceK5XniRxPWmV2wdNGVcuzO9n0hTBymXj2pcmPSF9IdMzwcHGR
         J4fA==
X-Forwarded-Encrypted: i=1; AJvYcCWW9i/Kss/PR4zT8zDaacOYW1HEd2dfEAzS1sRoMtQBFqTpupWuyIXprI0EFxwfl3QqV14g4S8Lx3cCmaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8qPjyFR9wWpySRaAz3JIoaiBGInZkg0Xj5LPI0CDbyFjtE5fF
	Oh/OkJ20pPptidkH2mxaWorucL8vVqkqky6xi0UdS+dGK2XMa+SFA5ERRdUvFIn6
X-Gm-Gg: ASbGncunbWYt6+LS362/ktyq4SAh9EOtdhdEIm9CBAR+IexhIh+geWJl3tJg11BMYjQ
	TfxXS59McFBfTNhjPxW5V6HgPTEiKLHrtWNHDjVUzVZllDGklj8L2aGwPHy+R0Fa9HlFxJ5pu/s
	ANnbV+882HlLDh02dsPk+DVpCBJPTgE7mXviOYFrMD6PJgVsGC9nUGXKhR+D2LEp8Bquzml7BKT
	AWNkhq4eZXz5sWRCHpmahXf/PRIC1KBmFMDIPkBS+iRW0sVZya5pUdf8etwxs0ooN3pC2/99hPd
	pO+7GJghtKF2BAbo9+RRXE76f2LjU1hBmKlnP+hNVgygMFGXHWBIEg8tNhrcv9za/YcwvWeBFP4
	7G1NYM5Emr0XVLAeHT0hbKOXCWb5tWLh6aQpMZnh/ecQ2NKVeGJ8AG8LjUjt54haQ9hU/0ltA8u
	RPBmTo0V4JzfCu8Lheh0urkb+iDC+jP1gTfZcQa8u9bw==
X-Google-Smtp-Source: AGHT+IFsh7k9STXZYBzLquZcu0MKMS+wH6vwL5dwBse+AQsFd2xiBPwyq+sQRgoRibmDakJEyHIc0Q==
X-Received: by 2002:a05:6a21:1519:b0:345:3ef1:b477 with SMTP id adf61e73a8af0-348cd4123f2mr11280556637.6.1762252505088;
        Tue, 04 Nov 2025 02:35:05 -0800 (PST)
Received: from [127.0.1.1] ([2406:7400:10c:9fcf:2909:749f:36f6:6b85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2a80459sm1952010a12.15.2025.11.04.02.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:35:04 -0800 (PST)
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Tue, 04 Nov 2025 16:04:58 +0530
Subject: [PATCH v7] ASoC: dt-bindings: ti,pcm1862: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-dtbs-v7-1-224aacb09671@gmail.com>
X-B4-Tracking: v=1; b=H4sIANHWCWkC/13QwW7DIAwG4FepOI8J20DLTnuPaQdioEVamylUU
 asq7z6oMi3j+Fv+fsl+iBKnHIt42z3EFOdc8nipYf+yE3zyl2OUOdQsUKEBhSDDdSiSPEGyzrG
 2IOrq9xRTvj1rPj5rPuVyHaf7s3WGNu0KZpAgtSMG79HQwO/Hs89frzyeRSuYcYvsirAiDjTsg
 TweDrFHtEVuRVQRMYNFRGDEHukNIrUi3VBKiRoCcD0yW/R7k6koRgisBkxeqx7ZPwRKr8hWZCE
 Yn9pPw7+blmX5AfBnhLuhAQAA
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
 david.hunter.linux@gmail.com, khalid@kernel.org, 
 linux-kernel-mentees@lists.linuxfoundation.org, 
 Ranganath V N <vnranganath.20@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762252501; l=5567;
 i=vnranganath.20@gmail.com; s=20250816; h=from:subject:message-id;
 bh=xVTUdynUwOEfXOlM6iD7wg5Aog37SJxR0DlPuRS1e6E=;
 b=geYToZPDBy5tyXIRvlqHX9s3GXu8IEe6Ozo1EFpJWtgfnErpCnfgBIcsITPv7ZI6sTwYACG7s
 Hwp/JaY/W4cA6BMHrhALuvo3E+m04WWneC7t62yWM6Ur2v9LU9ApuwA
X-Developer-Key: i=vnranganath.20@gmail.com; a=ed25519;
 pk=7mxHFYWOcIJ5Ls8etzgLkcB0M8/hxmOh8pH6Mce5Z1A=

convert the Texas Instruments PCM186x Universal audio ADC bindings
to DT schema.

The PCM186x codec provides a single digital audio interface. Therefore
this binding adds a reference to dai-common.yaml and defines
'#sound-dai-cells = 0".

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
Convert the Texas Instruments PCM186x audio ADC bindings to DT schema.
---
Changes in v7:
- Commit message as a junstification to add the '#sound-dai-cells' 
  to the new binding.(Krzysztof)
- Link to v6: https://lore.kernel.org/r/20251104-dtbs-v6-1-61d5afa31fde@gmail.com

Changes in v6:
- Corrected the Subject Asoc->ASoC, dt_bindings -> dt-bindings and ti,pcm186x -> ti,pcm1862
- Updated the commit message.
- added the missed Description from the old binding.
- Link to v5: https://lore.kernel.org/r/20251031-dtbs-v5-1-ee1dc0b2fa40@gmail.com

Changes in v5:
- Resolved previous patch warnings/errors
- dtschema/dtc warnings/errors:
- /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,pcm1862.yaml: 
- $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
- 	 $id: http://devicetree.org/schemas/sound/ti,pcm186x.yaml
- 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,pcm1862.yaml
- Link to v4: https://lore.kernel.org/r/20251030-dtbs-v4-1-3fff32221119@gmail.com

Changes in v4:
- Corrected subject dt_bindings:sound to Asoc: dt_bindings:
- Corrected the filename to match one of the compitables in the file 
- ti,pcm186x.yaml to ti,pcm1862.yaml
- Link to v3: https://lore.kernel.org/r/20251029-dtbs-v3-1-3cc162221c22@gmail.com

Changes in v3:
- Unicode FEFF character was present in the begining of the file,
- Removed unicode character.
- Link to v2: https://lore.kernel.org/r/20251026-dtbs-v2-1-cd3b713a288e@gmail.com

Changes in v2:
- Fixes as per the reviews suggested for the v1.
- Link to v1: https://lore.kernel.org/r/20251021-dtbs-v1-1-493c1aa253bc@gmail.com
---
 .../devicetree/bindings/sound/pcm186x.txt          | 42 ------------
 .../devicetree/bindings/sound/ti,pcm1862.yaml      | 76 ++++++++++++++++++++++
 2 files changed, 76 insertions(+), 42 deletions(-)

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
diff --git a/Documentation/devicetree/bindings/sound/ti,pcm1862.yaml b/Documentation/devicetree/bindings/sound/ti,pcm1862.yaml
new file mode 100644
index 000000000000..0f0e254a2420
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,pcm1862.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,pcm1862.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments PCM186x Universal Audio ADC
+
+maintainers:
+  - Ranganath V N <vnranganath.20@gmail.com>
+
+description: |
+  The Texas Instruments PCM186x family are multi-channel audio ADCs
+  that support both I2C and SPI control interfaces, selected by
+  pin strapping. These devices include on-chip programmable gain
+  amplifiers and support differential or single-ended analog inputs.
+
+  CODEC input pins:
+    * VINL1
+    * VINR1
+    * VINL2
+    * VINR2
+    * VINL3
+    * VINR3
+    * VINL4
+    * VINR4
+
+  The pins can be used in referring sound node's audio-routing property.
+
+allOf:
+  - $ref: dai-common.yaml#
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
+unevaluatedProperties: false
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


