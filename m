Return-Path: <linux-kernel+bounces-883599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6072C2DDE8
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 349724EF58F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FD732861C;
	Mon,  3 Nov 2025 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMq5PpOZ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE20B320387
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197293; cv=none; b=HChoAZSk9u/YhGCaset+kSaKdBOpPcMAnduQpkuJxUhQIjJMbu66NUHPQ2TZmyBTlY6RsFSuRMAzfRUPvK4osQWVthy+KSfHgQ9HISz+9WDrTm16qd+mCCY/ufyBBC4Ke1v6APrGk3QSR4ZVgd1xVsQWCcwpEkbr1seO67M6V0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197293; c=relaxed/simple;
	bh=c/xrRD600w1Dsyuw4U+hAJBnYZyF9dXpxSSF3rQ6G0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dysGHWVx2VmrowuHeUMnGqPNOr3sXH0z/RRbX4jI9L2iJCjwQgnQ/jEosaj8MoW/uc6PLQNiSvHwCaWhWejEs8FeSCy2hWtobWV9BmTFlpznoZp6jRDS6ur7msvFtjfWYEYAu5cctdjwvxdNVP0Tz/hVXayhqHmlw93v55VgB+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iMq5PpOZ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so2558141a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762197287; x=1762802087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpU3+dPMBGal6bIAhOfb10JFhOSohjDVXIH9FUT9R/s=;
        b=iMq5PpOZ5+33YJBuGg/lCjGFjd2KBqHC8X8O30/DXTnVzOQAH8gMpqY3Y+/1SKqZ1c
         lgKvQlb1/vG8k0CCTEYe4yKpIqqi5AFcbJJJE+NT3qKzThrL13/AEbRo0lsn68FfAviI
         JqrIbfe7ui8P0DJskMBnz5BSgpQKq2SihqDx35Gn0g3FDFPTgVEwOm1ud8N4Csl7WSG/
         5ILFp+wiZab9JaR0Q3hS9j62em3eAzXELHHkdS9HLWeRSfRHb1yt8mh9tI4Rb3Y7Dxv6
         KPsxFvLe6TOiVwfNh576nr4+8T+1REQqETVNLiRxiIdkKoUFJ2D7vdwRN5jPxUnCAFU+
         vDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762197287; x=1762802087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpU3+dPMBGal6bIAhOfb10JFhOSohjDVXIH9FUT9R/s=;
        b=tzkVbn1XRQ0eqQG46jT22uzl/dr9YGW/aJzIkJkOcQhpf1aez0RMRhWFEzxgNikUTx
         Bcs1GHJz4FrZuSaEHw0/xoCTSluWOfHViEcG3luPDcLZugW7GOhfyYAkXDpQGoZxP9gu
         Lcmeb15zJGk00VDabsTL3t45MsKdj/rk9udv4535NCvRmk1pIH/2+OcR/QSrBU0WTcvX
         ZKbQ4oPAarwKNV5IVbronKGASRGaL5wSwJE3zHvoiLgthyMycpTMsn1dvKUe/DiF/rTZ
         CZLRjUt7DMzGNqpZs8Mzz5+cnwYUSYJdO7KZi5+TVt6xvBnZr10yQFYMfU12XBkKZF44
         MvdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzt3uYoe77EQ+dibP2j7PoJ9x7ZHlXOGhtwhSEM+HQoyjwLpuyJrvi4U3uVTHxXHP90hbQw+8VSQbimP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKOQz3eP9YlZmmSOIWE5/VMbgFBkMTpo2n/f+xHS5Cb1d1+9Me
	/38JaRreFg8ntHzVcqVghreKwuQEMlr4OKS9Ql3LRmmRoY3OZwKKb38VCxDigZX8sv6t2uIyRWW
	pUjyljnBiaw==
X-Gm-Gg: ASbGncvKoK90e5FuDxRnGFGTiKPmVMcKyGXEUvt09E3B1h9KtJBB9YW8uyWm5OA8bu6
	ervr8yqgAdZmgXcR9Igjd0hEeL5BJffkKhtZ/Yxa38oMBnduY3jIWI9RuFz8MD7oIbLlEr6ndLx
	uVRTKppqVMXm/snnfCzh8IUr+GvoFa6FxWaD022rnh8JthmMakfUVfW50CakuCbfBZfnfrmgJSk
	2dQ9nIFGsDZDoJbfGRst4fl5gliHQsPLVJOxHBtwdjpS6qZpq9d94+zifD6L9g0JBa6JiZ1cll2
	sn/9d3i9mz+RzDZQc2dd6k63yZvVNmJ3j9omkpq1zzg5NKVr07P6YOe0KFlwDAtO2XFqC3LLfBz
	s/dBASVAH1ItAzUbHJc8hwhXs4VOX6rfyqjuxZ49PTrj5mhOCk2KNTDvVZjnxgxYwrQN1CHbYdq
	qPf+OG5R6gVXn4FELIHt0CGxWZUfpkMACzIycOqSYQueZZIlHzSTuswUaAxJYirD6G+3W0IKwCj
	a8xVs7Dpw==
X-Google-Smtp-Source: AGHT+IGKx04tsYPLBvcqXY7Ecx3PC4XIi2xWV2nuoXlJTghX703VWRsq3RlhzHc4VON/CJmYFIqs2A==
X-Received: by 2002:a17:906:c10b:b0:b6d:8e29:8f67 with SMTP id a640c23a62f3a-b70701ae016mr1456556066b.26.1762197286776;
        Mon, 03 Nov 2025 11:14:46 -0800 (PST)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70b9f29c8asm466765066b.8.2025.11.03.11.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:14:46 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 03 Nov 2025 19:14:46 +0000
Subject: [PATCH v3 07/20] dt-bindings: firmware: google,gs101-acpm-ipc:
 update PMIC examples
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251103-s2mpg1x-regulators-v3-7-b8b96b79e058@linaro.org>
References: <20251103-s2mpg1x-regulators-v3-0-b8b96b79e058@linaro.org>
In-Reply-To: <20251103-s2mpg1x-regulators-v3-0-b8b96b79e058@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

In a typical system using the Samsung S2MPG10 PMIC, an S2MPG11 is used
as a sub-PMIC.

The interface for both is the ACPM firmware protocol, so update the
example here to describe the connection for both.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 .../bindings/firmware/google,gs101-acpm-ipc.yaml   | 40 ++++++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml b/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml
index 4a1e3e3c0505aad6669cadf9b7b58aa4c7f284cb..c25e155926e5f44bd74f195cdbff3672c7499f8e 100644
--- a/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml
+++ b/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml
@@ -45,6 +45,15 @@ properties:
       compatible:
         const: samsung,s2mpg10-pmic
 
+  pmic2:
+    description: Child node describing the sub PMIC.
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: samsung,s2mpg11-pmic
+
   shmem:
     description:
       List of phandle pointing to the shared memory (SHM) area. The memory
@@ -62,7 +71,9 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/regulator/samsung,s2mpg10-regulator.h>
 
     power-management {
         compatible = "google,gs101-acpm-ipc";
@@ -74,12 +85,20 @@ examples:
             compatible = "samsung,s2mpg10-pmic";
             interrupts-extended = <&gpa0 6 IRQ_TYPE_LEVEL_LOW>;
 
+            vinl3m-supply = <&buck8m>;
+
             regulators {
                 ldo1m {
                     regulator-name = "vdd_ldo1";
                     regulator-min-microvolt = <700000>;
                     regulator-max-microvolt = <1300000>;
-                    regulator-always-on;
+                };
+
+                ldo20m {
+                    regulator-name = "vdd_dmic";
+                    regulator-min-microvolt = <700000>;
+                    regulator-max-microvolt = <1300000>;
+                    samsung,ext-control = <S2MPG10_EXTCTRL_LDO20M_EN>;
                 };
 
                 // ...
@@ -88,8 +107,23 @@ examples:
                     regulator-name = "vdd_mif";
                     regulator-min-microvolt = <450000>;
                     regulator-max-microvolt = <1300000>;
-                    regulator-always-on;
-                    regulator-boot-on;
+                    regulator-ramp-delay = <6250>;
+                };
+            };
+        };
+
+        pmic2 {
+            compatible = "samsung,s2mpg11-pmic";
+            interrupts-extended = <&gpa0 7 IRQ_TYPE_LEVEL_LOW>;
+
+            vinl1s-supply = <&buck8m>;
+            vinl2s-supply = <&buck6s>;
+
+            regulators {
+                buckd {
+                    regulator-ramp-delay = <6250>;
+                    enable-gpios = <&gpp0 1 GPIO_ACTIVE_HIGH>;
+                    samsung,ext-control = <S2MPG11_EXTCTRL_UFS_EN>;
                 };
             };
         };

-- 
2.51.2.997.g839fc31de9-goog


