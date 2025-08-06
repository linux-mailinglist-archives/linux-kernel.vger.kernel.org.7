Return-Path: <linux-kernel+bounces-757759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FEBB1C655
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7F0722A84
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AF828C5BC;
	Wed,  6 Aug 2025 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+GqTazc"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFF9221544;
	Wed,  6 Aug 2025 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484507; cv=none; b=iGCjgtONeQt2iHJn6+vLWJuv1Jjt3O8qTxfSINSRKemgicifTy1+H5qDVPMsKpmmFuCTMNUp2IQjWAqh50CLYbwYdY3KVPgBoXTiGJsGQ5BcetvroT4b/ZYhazNYgv9C1k2jE20y642VjkThoNj+kUyUUi1RROSEeZzoC0R4VPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484507; c=relaxed/simple;
	bh=+tZ7L3bTWvjxS5GRlfWgTQwrhOlSUyISF5XkXcwLHqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mVersDu4K8TA8WWN6A6TCukvE5UqyypmaNrOcI2x8YJMlJMLD8vInp2M/omJsgYBvGJh2j5b0Z3omA5TYnUJb6lMqbb9vMRjQlINlGOeEJWmRLX4KnHytCehd4JxXZXkuU1+n9Bq+HdHemNCUSAm9qRpM/lzbuHPKEeUzpNslB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+GqTazc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d3f72391so58325905e9.3;
        Wed, 06 Aug 2025 05:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754484504; x=1755089304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VNB7a4YMrb27z2qd3889RKLzuXK5LQzifxp7nYv4e34=;
        b=b+GqTazcTS3YCaPjUJ5sTnyfm52W0aWCvC2qpZPlpmRbnD8dyI3p1Xke/JWaTBqtO4
         Y3sx7Zzf6GHkWRgyqMbF1WaO9+WqjBpWRnCoPRXCcgNkUbR+mtEsCysL8TVKh6XA42NM
         LKAprjZG1zr1/Io3LcGP5+LIb83LPIu9XlcxKDyT7+B1IEDwMO5uJDbJgjk98jMf+JpJ
         wQhTN8RJ8cqQJ91S76Aqn/W3A8h11Lf+FzoQ7HmFj/iEyDUnxCuV50Zo5vLdhPSQTSnc
         s7Yh73d9Lral7I15Thvus2APAZSffgeCdcrskIaO8Jf/btuPqwGf1Moa5pf8ogOK3Nvg
         jkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754484504; x=1755089304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNB7a4YMrb27z2qd3889RKLzuXK5LQzifxp7nYv4e34=;
        b=GkQH0PMSNVS4CurrB8sWfNmfl56/4xVGVSLynfSJ4KFr+63KhJ6wrgsn0w2Pawc4cZ
         0w4/TAYpVXQOVPo5Aia6+ELkACdAbvA5zVAW0MbaCME+EJyq0eRszhOyTgXL3mvSGTlt
         +ug1/OeXfloAa+RW/EYu8JilbVbth/bT19H1pR1U1qvEbizCEHZ0zbKx1VDEx6lCEga1
         76Xj4bwOELb2hgZ1odnkLXMkHPYVpkgrNMDBIuPKtPO1HbXzWVTHO/0sM9Lcy/3pYSdf
         6QlgAYnR5vqc9A4TpMwx/ac4BxkcddmnJWfu0bKkrbVnkgUuvGaNpX2TYiCV8qe8rOmP
         IUxA==
X-Forwarded-Encrypted: i=1; AJvYcCUg+7LOnuXCjz60/SQXL9XtpmCKOItusozgvZBZLBIwEvnpBi5DRMy55EpYaTyOauF84aVW3lI/ygLZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3VmlNwrf+Nro0ZHYD+jDdNTji0eFzC+ukD0rcTVhF+dWGM+h+
	CJZf9Tz5hLG68P3ednwXHG/7xDrsbjZaOoWDHZhafJPeAobjoqC8aKh9
X-Gm-Gg: ASbGncsxojnHrb5CKbuakpnMMEPTbfoUXhiqkSKFuTkKjzBcBLuPDPamgWGxCQvFYpC
	j+mq19vh2k/AipiIfRDCi57kqU7SVrYitItrIMC+ox1JOL3CBphyY7MDLmF2cwtpQDKyvbu1/wo
	XjyLKYz5SojFBlqboTMTabF3e4C4UqOg1jMckfWdrQygCstQYXx+bHATbxOaZKSs8h+Ps8RF/BR
	RdoVSrbdFvBeHHV0KzGPLzPHZgTrQYBE6Qbwl1BdIi6SogYmCY/zjDotvknY7xCvXgJH2/3RoPK
	lOeq2z0vNq7m1FT/DK8lZ9D12wXFAJd1TdQoH+UpJ81mb5Ig9h0ZEYsfr0+PqqjOsRKRmHTeqKJ
	N1aTEq/y/GoUN0bsBnV2DwicEQNWjjKZ3QveBxVRe3CtGG5BvoNtTOhs99MdDbklY
X-Google-Smtp-Source: AGHT+IFBN2DPUlyJyt6dAn1vE27EUq0AzZJVPt+v4DrPvA6gwhn0tHlUlYyfF/G2CuE+a+IuY5Mzmw==
X-Received: by 2002:a05:600c:1c95:b0:456:1c4a:82ca with SMTP id 5b1f17b1804b1-459e70f63b8mr23496805e9.32.1754484503564;
        Wed, 06 Aug 2025 05:48:23 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([91.116.162.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458be70c5f7sm170110045e9.26.2025.08.06.05.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:48:23 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Wed, 06 Aug 2025 14:48:10 +0200
Subject: [PATCH 2/3] dt-bindings: display: sitronix,st7920: Add DT schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-st7920-v1-2-64ab5a34f9a0@gmail.com>
References: <20250806-st7920-v1-0-64ab5a34f9a0@gmail.com>
In-Reply-To: <20250806-st7920-v1-0-64ab5a34f9a0@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

Add binding for Sitronix ST7920 display.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 .../bindings/display/sitronix,st7920.yaml          | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sitronix,st7920.yaml b/Documentation/devicetree/bindings/display/sitronix,st7920.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..caee85f98c6d242dfab73729210f8c34b23a3a99
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sitronix,st7920.yaml
@@ -0,0 +1,55 @@
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
+description: |
+  The Sitronix ST7920 is a controller for monochrome dot-matrix graphical LCDs,
+  most commonly used for 128x64 pixel displays.
+  This binding supports connecting the display via a standard SPI bus.
+
+properties:
+  compatible:
+    const: sitronix,st7920
+
+  reg:
+    description: The chip-select number for the device on the SPI bus.
+    maxItems: 1
+
+  spi-max-frequency:
+    description: Maximum SPI clock frequency in Hz.
+    maximum: 600000
+
+  spi-cs-high:
+    type: boolean
+    description: Indicates the chip select is active high.
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    // Example: ST7920 connected to an SPI bus
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@0 {
+            compatible = "sitronix,st7920";
+            reg = <0>; // Chip select 0
+            spi-max-frequency = <600000>;
+            spi-cs-high;
+        };
+    };

-- 
2.50.1


