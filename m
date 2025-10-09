Return-Path: <linux-kernel+bounces-847056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F2DBC9C41
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478F519E88B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08D82EA464;
	Thu,  9 Oct 2025 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zp46Duvi"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1811E231E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023511; cv=none; b=sze1s8VBaDdytylhjYN+3+g+00fEciBajL8NpbS7B1Y1rVP0rBtOozc4uS+6eVxEJCXK/8IMeLWu5eHGCiluZWZHBLZ255zwlWH3ca1RUfxaUHGnJzDdowOJTglxa1GAKr0SGuSlkw+h1KIeR5TD71wGsFGG+vxmNfpxXa6Wfs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023511; c=relaxed/simple;
	bh=UpDpMfQpflET5V20J4n5YeVt8PTvypCmqoPo7NhX2qE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=imY81N9AY5XUhfsAp8b57U6mz0NcRJXLB1m6qhNb+J1u1jxSTqdvjPEHnpiDQazUnHNkasAQ1N8RUGxOmCyNQds/XFEL7oUzBYIZNr/gGNqwa9VdLbR5jXSVoZKAYu0bpmiGaCRoBjwnGq2myv7ZFgb5D8Us0XLN8yRABwih9iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zp46Duvi; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b48d8deaef9so193977766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760023506; x=1760628306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnyuHEM+lsiHCfL6IDRN5IyrCB7LqRf5MK311Pq4COY=;
        b=Zp46DuviIM/YmcBGz9HgNDhelYZFWxZP2FpROp7MzDWNRG46ikPmK4ve3TFD2pzs5B
         3YFpbszvBgcChBmsbPozfxF9eeysnNB8vxpp3YUIL/hqFzKdsznLeDpOvv4/YP8F6JY0
         l+WGqB/nwkStIwLYUiBHl/WzyMaf/1GuRXi/GnFPmMa7FTLZqkahIWpgSw3HoeupC5Oh
         4kq9HI3sSPMCdNp9dviGXJutBy1z8UYklzqPeO8pauSp7a6A13LxJfYtRPMXNTj6uEFf
         O6/LiQp21u1+Tr0ekycKXMyzQANtRkH50FmDHXiSZwUi65NHiZZF4c1ia11VKS084cE3
         vK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023506; x=1760628306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnyuHEM+lsiHCfL6IDRN5IyrCB7LqRf5MK311Pq4COY=;
        b=VXAz3XU2PQErTnmfqy5cVP1zjoX+GB6wKKAHcLkX9b6w7YnuN+k6JGxMItHGtcoeUs
         L8NaJ1pwlPsA8PnFUqRYbRknfpR2EmK6+0zjYI19kGWEF0oYPb0pivuLGQo/rKN33Ayq
         JsU94fvrecuPmqsCOeeBMwKm22asfmebWxuv4bffD2tlfBjB2SRS130NnZgAu3HCbbJ7
         9whtmYnt6gcOReIgyAAzTAW3T9rUu8RCcSeNBZG5zSL4zjOXHpzRbh2ZW8Wfo5xKpmWp
         WzZc0M5OTAvbAYCk2ZTqRl9IjWDPjqigcNCKpISBzViLzpcAF0oS0Wr5J8PSRQtH5d9m
         JWKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1MrdHEbyVqjJPAVuFTNofhnwnNLwUI8NuUOVVovGrY/pRGhs6hPpehMXEUl54fqF3tpsqTML8/eKhnJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq4RxBNARHYJUG4nE3RJUx2q3agWy8MqsPV/pSMa6sLvv4tNO8
	3CLfNjz1aaXdCjVWV0cvtQg44QkXYqWUivLJWWvxsiMBUtNM88nLb9CQz51URkARNAI=
X-Gm-Gg: ASbGncvPw2xDJzY4nGrXCaEBY2NY7NXmahVO7W8FzGgz85hHTOBCg6N0CgcPfONTfZC
	uOsb3pdhssC0h8hePLTs89n3IofnbWS7VeaR7XhnOO7cf/0ReWCE1iGDzQIaQqVyR3DcR727FeS
	NGu7Amdg3MuSiGD6C64bHfnL+fqtc8zubl5U4da+wO7hv1UCGgg+kzLuPvZJ1+GsSkKpMqBrHHw
	F0HYy26eyku73cVUXUbx44/W5rt1qATZqZoE/h6EzhexoQwukMqOMfwe+ztE+2Vk2NtETCHsYXX
	wc1oT1IEZtX9ub3tySKSLYrqvbKpNcu2jAiL7mzOlg+ZB1ZTfmGIXensqGEt6I56V+dy6ukNlwb
	ZpVWrfldhtiP3z8+253oNjTHsyRTtuwuO0S9mR5t8jXaCPsc+0GZdNqRUFzT8+ikx6nTLyOJEvX
	BwcU4rj/NKcALlKoCs53UWLmK97UtB6Y64Sqg9tvZn
X-Google-Smtp-Source: AGHT+IH4Riik0fnXmeV/DELQ8JjDqdvmxMdv2ShW6jNS8r7k8K/9xDWa2qfNhUPNms6YJU3aaNnQ8w==
X-Received: by 2002:a17:906:d54e:b0:b3f:e1e9:22c1 with SMTP id a640c23a62f3a-b50ac8ebda2mr933717066b.53.1760023505945;
        Thu, 09 Oct 2025 08:25:05 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1908967566b.62.2025.10.09.08.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:25:05 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 09 Oct 2025 16:25:04 +0100
Subject: [PATCH v2 02/10] dt-bindings: soc: samsung: exynos-pmu: move
 gs101-pmu into separate binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-gs101-pd-v2-2-3f4a6db2af39@linaro.org>
References: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
In-Reply-To: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The gs101-pmu binding is going to acquire various additional (pattern)
properties that don't apply to other PMUs supported by this binding.

To enable this, move google,gs101-pmu into a separate binding.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 .../bindings/soc/google/google,gs101-pmu.yaml      | 67 ++++++++++++++++++++++
 .../bindings/soc/samsung/exynos-pmu.yaml           | 20 -------
 MAINTAINERS                                        |  1 +
 3 files changed, 68 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..209ee2f80d449c3eec568188898b3c6f7ae0ddd4
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/samsung/google,gs101-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google GS101 Power Management Unit (PMU)
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+# Custom select to avoid matching all nodes with 'syscon'
+select:
+  properties:
+    compatible:
+      contains:
+        const: google,gs101-pmu
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: google,gs101-pmu
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  reboot-mode:
+    $ref: /schemas/power/reset/syscon-reboot-mode.yaml
+    type: object
+    description:
+      Reboot mode to alter bootloader behavior for the next boot
+
+  syscon-poweroff:
+    $ref: /schemas/power/reset/syscon-poweroff.yaml#
+    type: object
+    description:
+      Node for power off method
+
+  syscon-reboot:
+    $ref: /schemas/power/reset/syscon-reboot.yaml#
+    type: object
+    description:
+      Node for reboot method
+
+  google,pmu-intr-gen-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to PMU interrupt generation interface.
+
+required:
+  - compatible
+  - reg
+  - google,pmu-intr-gen-syscon
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    system-controller@17460000 {
+        compatible = "google,gs101-pmu", "syscon";
+        reg = <0x17460000 0x10000>;
+
+        google,pmu-intr-gen-syscon = <&pmu_intr_gen>;
+    };
diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
index f0fb24156da9b8980dcfd5339ae75f12a71cf6d6..83f18a92fa1c4de75a90f00475cf17d5f0b652e4 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
@@ -15,7 +15,6 @@ select:
     compatible:
       contains:
         enum:
-          - google,gs101-pmu
           - samsung,exynos3250-pmu
           - samsung,exynos4210-pmu
           - samsung,exynos4212-pmu
@@ -36,7 +35,6 @@ properties:
     oneOf:
       - items:
           - enum:
-              - google,gs101-pmu
               - samsung,exynos3250-pmu
               - samsung,exynos4210-pmu
               - samsung,exynos4212-pmu
@@ -129,11 +127,6 @@ properties:
     description:
       Node for reboot method
 
-  google,pmu-intr-gen-syscon:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description:
-      Phandle to PMU interrupt generation interface.
-
 required:
   - compatible
   - reg
@@ -194,19 +187,6 @@ allOf:
       properties:
         dp-phy: false
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - google,gs101-pmu
-    then:
-      required:
-        - google,pmu-intr-gen-syscon
-    else:
-      properties:
-        google,pmu-intr-gen-syscon: false
-
 examples:
   - |
     #include <dt-bindings/clock/exynos5250.h>
diff --git a/MAINTAINERS b/MAINTAINERS
index 3439485437117aaffbe61b709468348231ca3cc4..9cf5b9300d4d96bfed8d1a75cc806925a884744b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10596,6 +10596,7 @@ S:	Maintained
 P:	Documentation/process/maintainer-soc-clean-dts.rst
 C:	irc://irc.oftc.net/pixel6-kernel-dev
 F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
+F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
 F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu-intr-gen.yaml
 F:	arch/arm64/boot/dts/exynos/google/
 F:	drivers/clk/samsung/clk-gs101.c

-- 
2.51.0.710.ga91ca5db03-goog


