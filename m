Return-Path: <linux-kernel+bounces-879783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6E3C2408E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09A1581AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF3A32E136;
	Fri, 31 Oct 2025 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="In7LF65w"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5D232E133
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901541; cv=none; b=U8/QQtTFjLDywnxWL2TdUkBFWnns/Rs3wU4IZ6TxYUyy+s1eX3fpubXMXDvoLnB3/cOBi8VbRPhTQoc/zp5jkZrf5adM64xtTF18Qz6tflAL+qR37Eq0cB+gEYa7OtYtr3LgFXxEVlsBuoynCSYwba6ll2jK0CxJT6B3h40BYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901541; c=relaxed/simple;
	bh=nro5ffECISZBxP47ojXf217UYA8LT/9kG6EOdNqFQ4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZCWr4A8RqdOUHj0RUn2WiUK1OXkZEL4ZcB8FxDzd1VJPH1wWi2ZHls7GuN6DDx3tPElyLHKMbNNMzmfaNM5ivGHq6ZBpje3G5LrV9Rdf+/mIZoampZimQDZyUxDcvt21DYLLltvunpnoMBCvFo0XSBYLeCpfbDY9wuE7iw1c5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=In7LF65w; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so1980614f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761901538; x=1762506338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18hreP4xxLaFHfo0ItO/fnmo3JBInKcj9IQEHPw+gD0=;
        b=In7LF65wL29ARj9kwVZq1dwimDbZTe1jFDIk700bkD1BDSt4bt+xcHvN5SHblmXPjJ
         TOuixSk9tVuEDHIAqzafoR2IrtPsfZEDAu3pGqVTkZ3vG1Xh5tdMdv1cbDQAFlZ2Lsfm
         Ig+7Ytp3dAb0LEWCcikK2A4i7UoILT6via6Gs2O8H4ubAOObtNRl1qfkpYNP72+G33f1
         xtYUphof77p//bFPy/49B13JhnCxkIeRzGJw/RQuywYR7ZKgwSiIZTfBfBLkA/xXkAbi
         Rb+EWlikXpkhV+FIO6eLJ2lfnycWkKd2R3EDchQ700BsoRoi08s+2JDJcjbBRBVmSgtw
         3YzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901538; x=1762506338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18hreP4xxLaFHfo0ItO/fnmo3JBInKcj9IQEHPw+gD0=;
        b=T9AUNtNRP5jjhyvag0pODocDwDe93gR016tnYCkgUFK3aL2SpHGFCrUQcrHdhPEbwQ
         qTBrWHq5mc9rUG0SY4YPNIRXjPnPALf0eb1fQYVjyBp51DDw4jviSXecXevSCssz76by
         yZOMsEnWhddkJcSYl9u9coJeugR+Uo2qBhUrDBLFxrmRDEKtRnaBB/U61hYeMyU/lffr
         x7FdqMxA0tIznlGfz08UsK4PfpXPmj15f7xxWaOA2onk5Kss/TezCCce4SGsfeY8xcLl
         sseZbQ7ywd5XD5XAk8FlrCAfvuKAZd3Qt+8vlHl6u1WmrG2jgCaOsFw8VPBIP/JjgtMM
         ynVw==
X-Gm-Message-State: AOJu0Yz/o+IzOnoAQaberiRcpYrtyP0b49hyUs7o7+qeJLverokSa5/R
	qG+c9z1vq0Gn99+JYxcnYOR5z4PU+5nhHiEMtXEvZTGUTdKbVHu/3Xft
X-Gm-Gg: ASbGncsiro5iDi32xaRfHVeh9ffMBeq+pQLIBmNvqoPTX5izYyy0p6Y1hnMRaKLiJ9B
	Ko4ot7q0jeyROvvVu6QGXXX4Arc08BkBuQOae89b9I0414LXcoLKnqrimAqo5EUhUkQwsLNeLl7
	s+krMasublVO2ITJXzgW4WL+Qzf7b+3GAxwCmHqbJWdiEiZPdlA7U4ab5jdE6Pl7fjMU49Vy/DT
	XppXyJjNDuFlWnkbxNtryPwzt2w70Yf026gZLknUZiveIXmX46WhWhInGbzodZiWQYqyjMIkWSd
	+PsfNK/5x66NStzfk/PXnNWS5myR8kgeZqkdgS62NCyQa85PkcbHVxQxCuhedFt9KvaYT/6DwJt
	u+P+4L5E9esVt3VJ63fC1zHFdF/58tMzT5/TmAAGf7mWO4wYANhDMpm6GwNtn/Zu9HEjvyts+Mk
	gRgG2HJDFziFTvaEdQ18Qoo+6v+LBfVYorPl+5eNUq+g==
X-Google-Smtp-Source: AGHT+IHNoK3cnUIF6KdTyd7IGy8y4YEq1qFpnGQ1VkRb4cjN2zo87WIQY2U8y6o5zmD6jrgtQ6cpUg==
X-Received: by 2002:a5d:64e9:0:b0:426:ff7c:86e4 with SMTP id ffacd0b85a97d-429bd683568mr2152208f8f.19.1761901537817;
        Fri, 31 Oct 2025 02:05:37 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.139.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289adaf8sm93454475e9.7.2025.10.31.02.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:05:37 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Fri, 31 Oct 2025 10:05:17 +0100
Subject: [PATCH v4 1/3] dt-bindings: display: sitronix,st7920: Add DT
 schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-st7920-v4-1-35291f8076b2@gmail.com>
References: <20251031-st7920-v4-0-35291f8076b2@gmail.com>
In-Reply-To: <20251031-st7920-v4-0-35291f8076b2@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Add binding for Sitronix ST7920 display.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 .../bindings/display/sitronix,st7920.yaml          | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sitronix,st7920.yaml b/Documentation/devicetree/bindings/display/sitronix,st7920.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..c4f006fc41e1f472939725bd82b86a649f9b3f56
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sitronix,st7920.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sitronix,st7920.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sitronix ST7920 LCD Display Controllers
+
+maintainers:
+  - Iker Pedrosa <ikerpedrosam@gmail.com>
+
+description:
+  The Sitronix ST7920 is a controller for monochrome dot-matrix graphical LCDs,
+  most commonly used for 128x64 pixel displays.
+
+properties:
+  compatible:
+    const: sitronix,st7920
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides 5V Vdd power supply
+
+  reset-gpios:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 600000
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@0 {
+            compatible = "sitronix,st7920";
+            reg = <0>;
+            vdd-supply = <&reg_5v>;
+            reset-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
+            spi-max-frequency = <600000>;
+            spi-cs-high;
+        };
+    };

-- 
2.51.0


