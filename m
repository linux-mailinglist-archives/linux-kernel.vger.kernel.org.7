Return-Path: <linux-kernel+bounces-726266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF71B00AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56DA27613A7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7972F0E3B;
	Thu, 10 Jul 2025 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="KTkNK7B5"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23792F1FD3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169875; cv=none; b=i/FEV25CbIMTNvmwmzNnb22URG7vJ/zBGfUPwg3+iGSLIBP5qiYm9yMjKO+kdk7tZhWG61JSHF+6mX8oOLti/0CMQKeXHywIWevFl30ea73zHEMGYYiCDeHQzPayI3hH85h/l33oN2nZyKkowhYw2Dm45Nn06YHnKb7OfQFZeTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169875; c=relaxed/simple;
	bh=TcSAvv80iECU+EemBY/QAFaaDjBspFOa95X1JROvb5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5GSkDK0agRqTQf8kEtFDR25864Io/nYyrHuYcSKfqEKXFcSmyBsl16GDpYRJVBgAUOPGauPdPU3TiFGjw2FxXR5hDElN8FbLwMAMqvZ1zE4R0eo0L6kLOvlQsGCkTNpnlLSSmSmuOLYbYEdUMNKSDCSd5rmwM1IhmGTP8WHwXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=KTkNK7B5; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a43d2d5569so15516431cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1752169873; x=1752774673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNF7PY8BTTw3n4PxFimy6RpSwNTBoHWIsy6At478d2Q=;
        b=KTkNK7B50nK8RX8G78Qe9kAqdorqnBfyqXYmHNE0lQ9BXLXvzdHqvcgd5Ceq1zO6cu
         EFf4IVq2mhnZLU4l8d56Y5C44OKpxWwyZs9Z6Ozwa51KMR/iHKHFgkDz7GwMDdm/MF+e
         VaS2kUAdmPxSE3oVQlmUhblUmSQ5iUhDciquu0KiLSdqLlP0b340XVqBw9bHBuCmedYV
         8QlJoI7DjczQbMi5PSSrOmPjtDT0OVaPnPLGuduSlLZ5aXIqNTeI0xV/uJviDr80lWCj
         GtceVmwVTInrUUZCOaqQh8Un1wi/EwBlXh5WMXhW+hO+jglr7GgbScv4CNV8e28FeQLp
         yYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752169873; x=1752774673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNF7PY8BTTw3n4PxFimy6RpSwNTBoHWIsy6At478d2Q=;
        b=eREVXEHkarEwRIPa53GM2kzShcmcefuljrqlqYDEe3la8SrPvPPy0s0jVNtNEZ3L7F
         VDdBjsYKPqWyKLGCw8oM6JFEdcV6+wlYi8DNRAg5h99ZnNsmq0nxEErLuq7QwhWSVenx
         An5t+JaqzXtszjtYT80l/bqd4wyN6uSV6Lp178XTDTWnEyBl/xhgCqRp0JgHwBk7b+ZP
         z8kNyeNTSDPajp7Ahk/s9AhLcYj8csIxGL1qwyQ4yV3NCJ2Jyn+FsGyRn4Vrt7qIlOWo
         JWxaxq1cNSthrH8chIcHcnJlKC2aJPtQV8zBEywAhiKXyi72x9lOnfQsnLoVZPQVb8G/
         8lAg==
X-Forwarded-Encrypted: i=1; AJvYcCXUdfmFXxsBOsOftMf5A8rlml2DAE0hKWIldnZCgFNalDOorxl6qQubvvBkTvGEv0qaY8uFUAI7v36RkgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGsaXZ1iDhlQ8xkVpK8/IlTm3c7Pq9IvxAgzTnGQrffqyBZ77m
	OO6FqX/rhjlYOogly4qKko/aV8NIOYQa4r577DzvWSk7zThwo2RG/fdbQNd1/AqKAK4=
X-Gm-Gg: ASbGncvybmRGXVkohBkOvFWqzuHMnxby2U82ai+wjzE8OKvZ48+I2unLhUGUqniLcVp
	k0TRHeaazrl4EOXYfftjKI5U9O27Jc6IHLcrkYH3S9dPfKikyNh40V/DmxBxC6yj/WVsVLtv2w2
	6s3UcWHXczPhePxSP+Z5jxA07Q3ovY+9s0O3bo371+bsAgTYJLSiISZ/xpU9cyXC6AReD3pqKEO
	zfiwLMZtYZFyVfa/XIra8AYR844fg1MStZ/YipvJPYQCfwcwIQO4jOkbXieyVyBl6Z996k8xD2Q
	9RgPZG5Lfk1VEuU6zj9Nej8aKFtpyLJHAf7jXsnfx6mmdDakiNF+rM6RPYLt0Ic9BzP2FCrTsM1
	WtOj6+Ijts+4yiO8GV6jflvHPgOyv4ba7ng0=
X-Google-Smtp-Source: AGHT+IE0cJRHVoq9k9LOPhhDX5Qx0jjf0lgcMuAEVcjuN5h/JF5bteKTincAlkOQmKWP6gWojXJAQw==
X-Received: by 2002:a05:622a:4acb:b0:4a8:1a88:7208 with SMTP id d75a77b69052e-4a9fb9a670amr4227831cf.48.1752169872379;
        Thu, 10 Jul 2025 10:51:12 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee300sm11165941cf.73.2025.07.10.10.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:51:12 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: lee@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mat.jonczyk@o2.pl,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	troymitchell988@gmail.com,
	guodong@riscstar.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/8] dt-bindings: mfd: add support the SpacemiT P1 PMIC
Date: Thu, 10 Jul 2025 12:50:59 -0500
Message-ID: <20250710175107.1280221-2-elder@riscstar.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250710175107.1280221-1-elder@riscstar.com>
References: <20250710175107.1280221-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the SpacemiT P1, which is an I2C-controlled PMIC.  Initially
only the RTC and regulators will be supported.

Signed-off-by: Alex Elder <elder@riscstar.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/mfd/spacemit,p1.yaml  | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/spacemit,p1.yaml

diff --git a/Documentation/devicetree/bindings/mfd/spacemit,p1.yaml b/Documentation/devicetree/bindings/mfd/spacemit,p1.yaml
new file mode 100644
index 0000000000000..5cc34d4934b54
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/spacemit,p1.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/spacemit,p1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT P1 Power Management Integrated Circuit
+
+maintainers:
+  - Troy Mitchell <troymitchell988@gmail.com>
+
+description:
+  P1 is an I2C-controlled PMIC produced by SpacemiT.  It implements six
+  constant-on-time buck converters and twelve low-dropout regulators.
+  It also contains a load switch, watchdog timer, real-time clock, eight
+  12-bit ADC channels, and six GPIOs.  Additional details are available
+  in the "Power Stone/P1" section at the following link.
+    https://developer.spacemit.com/documentation
+
+properties:
+  compatible:
+    const: spacemit,p1
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vin-supply:
+    description: Input supply phandle.
+
+  regulators:
+    type: object
+
+    patternProperties:
+      "^(buck[1-6]|aldo[1-4]|dldo[1-7])$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@41 {
+            compatible = "spacemit,p1";
+            reg = <0x41>;
+            interrupts = <64>;
+
+            regulators {
+                buck1 {
+                    regulator-name = "buck1";
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <3450000>;
+                    regulator-ramp-delay = <5000>;
+                    regulator-always-on;
+                };
+
+                aldo1 {
+                    regulator-name = "aldo1";
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <3400000>;
+                    regulator-boot-on;
+                };
+
+                dldo1 {
+                    regulator-name = "dldo1";
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <3400000>;
+                    regulator-boot-on;
+                };
+            };
+        };
+    };
-- 
2.45.2


