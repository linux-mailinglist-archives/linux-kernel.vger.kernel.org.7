Return-Path: <linux-kernel+bounces-887250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD962C37A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C9174EBD04
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA195346771;
	Wed,  5 Nov 2025 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b="anF113TB"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091B342CBD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373657; cv=none; b=CUoeA8D/ZNhdNpl2h0s9bI8lBYNpSVcs23Li7IfP7wuXs+tzRaN1R5x8A0qDh2ABbNxpAnWrWU71xzMafdpGPdZuWMZU8c0HNJnhgvTAVUt+QmEQ0HpaY1KKrBWJSOUH8CBIrIwRCctZnI2PW7URPQtYjDCp4QY2W8tRRnEl8aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373657; c=relaxed/simple;
	bh=Ykvay+KbmIz4mfBpsW6reUfGaWR/oBY1ov+y0XO0Gi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jszrb2doopBr2oRykdVCOG138SNVUXiRscsyGCMZR6No/Bf1nbxEJZENshf2nuktxAlJCS3Ia2dewJNsV/qbT/NDYveCqLzgCjCC+WQSz5tc2HhpcZjh1UYT/gQ8tQpZlGco/2Dap8TEX5wBOd2cmjIXuSbbix77If/I/08cWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net; spf=none smtp.mailfrom=dpplabs.com; dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b=anF113TB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dpplabs.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29558061c68so3014385ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reznichenko.net; s=google; t=1762373655; x=1762978455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5UUjWOJCMb12I/BWzOWhp+eaG/l4rBJ5tx7KBsTma4=;
        b=anF113TBFdGCwBVy4exG+TjYZ8rzr6yppxd3TG4JUruavX8aRpZ5242FhEBoqvf9eQ
         iGRYFsr2GH9kpaZ1sCVXbQ1tZ/J8PBcpnjqN288VE7MxZY9J+ObQRdbBEjyj0E5rlZjx
         +YUtHGeTfnBNifJ3br6/rTX4suogwBQwF9YCMwRJc05La/D0un4fR42+XlbejBslkXm0
         CDxch6lWoPqKR7rpS5HyZmtwAOVAhGoBIvy66bJYdIGCW6gz3YUvIcpCCTPyvfNPh0ZC
         Hyg5Ge6AYsgTL9UWDwBvhkt0DDuXi1Aee+dqlfXqh1bPOsGjvo6eanPsCYc+F1q0i48o
         QOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373655; x=1762978455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5UUjWOJCMb12I/BWzOWhp+eaG/l4rBJ5tx7KBsTma4=;
        b=ZxHx5Nl1Vt5I+3+b29NZk63kX8/9lP03urp2pOKelWtEmW1r49HIaLDTlqOKnGMQMU
         Y4lJuF4uSFK7zF5sipjlHD9sUZI4A3qzbr4XpsSITCZUmYan7BG8rZG2G0YPWwnQlp2s
         Bnvjx5Ryvj6DPlELaVO+1uAT/6gT4Nyt+AkmKCTgSLdr1tgyAxTMvMmz79NA5bX00Ur3
         I4Qyo1uEoK1xFvGX4Wzsnuzabpf1M/N6UqXpBfQy4FwCJYhQaq7m1LQLKLZNIane/0vz
         cQojw7aIFt7QzPwHGn2RKkDmV/UWsZ6DB4U/B4WaBLk/+/4XAwIT1/+llpvOO0U1Q9BW
         Ia0w==
X-Forwarded-Encrypted: i=1; AJvYcCWWEsIhRXhvdCy2qBsDV1U3rNrWcdznnxUofiSis66UvJNGIuwO0j8N6S9ezlc/TqjVN+0Y0KKtqpQDVkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXhQUW62bgQvRbdpdEgkkeh7X+3vw/WWErxh8aEegsasc6ll8n
	BbWQP/HdgmPFZWodeqtVn5E07MzofXiSmKjXAb6vRRAcwGlJcl1ZD8hZ2PWRZ40QGyM=
X-Gm-Gg: ASbGncuz/M87S3/fOVp+ZyCA5WcNSdl2WtL1tBlAGeEMO78EtE8I7i7w8aSccuVHSMx
	HUdjX2py1azhvQ9U+GVW0vCq+62P7s36uedbXH4waLR+s7aO1on2v/WbcyMvqKcTbBxaFXVUzPY
	DXAv47MjC2oV1N8GQYnL4CSaXTBI24UgDTwvVyBKg8eb333Stu+EDZ3NB9o2VPK98VE9Ne1qX8W
	i8+1vmg4CVzcobWj2rAA77i8tlK7mNpsHOO5a5BbhjgrR0bzZ+BmyQTyiZBoPe11TrPqdPdF+Y9
	56W57HQ4zXMIDrOel+XWDEhKqKz4glPy+Tk0dljKP0vBYLesxUVC/5ZiR4IYfPM8eSn8MdyCsDj
	h1lQG2fwa+rb4qRghSWXcY7Q/Er8LmlXAr1qW7ys+Hv34p4Fp+wSd2D/8Ta+mXJxAu4Qz+o3Aml
	b4VadyS2U=
X-Google-Smtp-Source: AGHT+IFsZQ3ivEoCdxUegpplY25ctIsfGAFJ5rAU93tEd/MzTCmdN2ztCF+pwuYG4rHstc9J65so6Q==
X-Received: by 2002:a17:902:d2c6:b0:295:1e92:6b6d with SMTP id d9443c01a7336-2962adb2866mr67889775ad.46.1762373655002;
        Wed, 05 Nov 2025 12:14:15 -0800 (PST)
Received: from z440.. ([2601:1c0:4502:2d00:3099:85d6:dec7:dbe0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b8ddsm4039435ad.5.2025.11.05.12.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:14:14 -0800 (PST)
From: Igor Reznichenko <igor@reznichenko.net>
To: linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net
Cc: david.hunter.linux@gmail.com,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v4 1/2] dt-bindings: hwmon: ST TSC1641 power monitor
Date: Wed,  5 Nov 2025 12:14:05 -0800
Message-ID: <20251105201406.1210856-2-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105201406.1210856-1-igor@reznichenko.net>
References: <20251105201406.1210856-1-igor@reznichenko.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for the TSC1641 I2C power monitor.

Signed-off-by: Igor Reznichenko <igor@reznichenko.net>
---
 .../devicetree/bindings/hwmon/st,tsc1641.yaml | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml b/Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml
new file mode 100644
index 000000000000..aaf244790663
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/st,tsc1641.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST Microelectronics TSC1641 I2C power monitor
+
+maintainers:
+  - Igor Reznichenko <igor@reznichenko.net>
+
+description: |
+  TSC1641 is a 60 V, 16-bit high-precision power monitor with I2C and
+  MIPI I3C interface
+
+  Datasheets:
+    https://www.st.com/resource/en/datasheet/tsc1641.pdf
+
+properties:
+  compatible:
+    const: st,tsc1641
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Optional alert interrupt.
+    maxItems: 1
+
+  shunt-resistor-micro-ohms:
+    description: Shunt resistor value in micro-ohms. Since device has internal
+      16-bit RSHUNT register with 10 uOhm LSB, the maximum value is capped at
+      655.35 mOhm.
+    minimum: 100
+    default: 1000
+    maximum: 655350
+
+  st,alert-polarity-active-high:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Default value is 0 which configures the normal polarity of the
+      ALERT pin, being active low open-drain. Setting this to 1 configures the
+      polarity of the ALERT pin to be inverted and active high open-drain.
+      Specify this property to set the alert polarity to active-high.
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
+        power-sensor@40 {
+            compatible = "st,tsc1641";
+            reg = <0x40>;
+            shunt-resistor-micro-ohms = <1000>;
+            st,alert-polarity-active-high;
+        };
+    };
-- 
2.43.0


