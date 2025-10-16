Return-Path: <linux-kernel+bounces-856527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E6ABE4648
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39AE9359E59
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6FC34DCD2;
	Thu, 16 Oct 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMABDZn1"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC5B34F484
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630328; cv=none; b=QSrayz053SwOmw1/C53wHxiqkFzKDT3qAKHTJlqXQE8B4XqVG4bb6YaJPtTvOEk0zvhaSpwyeFUSIlL0G80/JQlbnYZun2eOe0AbEXv68WiE09wPlVZfj5XkdP8fAVmcJ/fo6FiX2+nP6Y4MeyoDN3upLaPESDkUvvRgIFFEwhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630328; c=relaxed/simple;
	bh=wjOKCcfNVyYH/LNtGu2O1tFUuSoILDand+0vO7/BXUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XQjBg+f95CNaUzu0KZRU4q20OxFmkvcwp1R6lIX1Qw38hzAxQXoAfpTxwx0x+Qh6R7PuMuSIBUB0ataGB3v5lsYdGtLsFdMUJdy/9GjudQ7MMq+qixeFa2PTumQ/Q9qBRs3drnoFA40+bwAISZwBLfwp5f7DOgIWaqcG7rcS+4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MMABDZn1; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso152562066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630324; x=1761235124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFbyyNjgnPle57Vb/hgplgnkdL2H4IawW/m15NrLQlQ=;
        b=MMABDZn1D17yQ3YN45OCisXM3y7dxRyN+DbnYmBsla3UnZLJUuflkpmaipAUv5FtTh
         GO7vDZx5feK8py+as+8hyqF0a2dgPYmHnEK4R//16m3DhgIm10KBtiLafBKRw7LWpFbh
         hsdLeCHw63qcaPIqB+aMzec9zgqfAj3U2mq3xlc7TxiABOnS/oF7J4TI/TPwE1grPkNc
         z12dXzuzqIxgR7JXwcgxAWEJkLd0hRByGew1xJDoN4lishDBuCAab7ssl6cRIBcnSAri
         G1U74f96O8tm3snNtJUKnTKkUiOrFevu9KkW/V1nC/tuTAEJitQS1B+slFMjvXOlchkl
         8EVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630324; x=1761235124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFbyyNjgnPle57Vb/hgplgnkdL2H4IawW/m15NrLQlQ=;
        b=Ard0lLa0CLesjn8qb9up9+ufH7cSqlZ7yDei1Z6r5aApss2Nl3YlnDdyh5Fpyt1D+u
         QNqW9+4rM15SPI07AxBTntYPOSGXvjB45/fYz+NnHIjcdM0FFKPiVBvBUIiPmrxQRKMI
         Q92HgYni2jpK2/zTLvC9MxoCTq14qXiXCOw41rEYSpdt+YtJdGSfjq8F6dHXEc/Qhd0H
         zEDiGXCPIyTQ4bNv/NC88JknLo2jK9QmJ+Vg/QzLgSP7E3aImvc3PRVF4dAq1rfiyjxI
         AeuutvppzBDRhZQg8lCwkbN2NrCDbolLcm1C5kG33DeWR4+a5oiv3uyxtiXq4WOxFNh6
         JezQ==
X-Forwarded-Encrypted: i=1; AJvYcCUStWNgKDVc5jMhIR2XnF1+lYfQB5YNmgMFtpNcp5pIPMcdX2FULNzqxu9W4UG2BaQduDR8bJGOsAS50W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzN7xnfF+jDPxUz7pfDQjtSv3sQhGlgVEgBNeoRI0i2HXm3s+u
	gdwRTJ0nQWbLjsL7pfmu7TwO1eOU82Iqj5c9n9ESLPA2GvemTTuL0H7PsQHN0tmprYo=
X-Gm-Gg: ASbGncvjd0LSdJnzyJS9WF8eBkyVdJfCv4a8PhHIHnfTAgvxdVKlin5hftlEv2NXq90
	IUWiYTVnTwvm8d7HeMtEJZFcj5jwJubjEJfcOWNx5+AFhVhQYwlyiaNY2+8T9dx3uBgCb7lfSK+
	cBEfqhpp8E3avtYetyXBRTcnJp16FzHBU206/ipNcPvx+gENr9+MM5bP9aokkb5sSCt5sMNTVzS
	iy0CNIy00sXhp2YNi2wMtCAOqeVNBI+Ox87YD0Py0Xef04kRWhXTJYqMZWZJGMAwawxbJWJxoZ1
	BJJRTuK09w7Ou8ydy/K+SKcXuBBeCwhSFzOm9iS5T6YTBkEBf/MvvbLLCW1ebiFSzSmXHvkSJht
	vxehc2dQwf4LZ+CU2rDeXs9xo0Umi3tSgVvBzt6Ko4L0TUfGMAVsPHJsIvpc+Ie0e+ybtvy/HNH
	sd84QC5wWK5aOgWe1iwAIcYL6Q+21g6/Pbxqr0dhp/egNTZamOb28voSotP2ZQuncdaTpr5Us=
X-Google-Smtp-Source: AGHT+IED/FvFffti0T0jCYr1x6YRSUGnajOXW2cxPyV/0xQA94FV6cSMBe/igTzVHYhYkjAYJA2B3w==
X-Received: by 2002:a17:906:ef05:b0:b41:e675:95cd with SMTP id a640c23a62f3a-b6472d5bb90mr52421266b.13.1760630324239;
        Thu, 16 Oct 2025 08:58:44 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:43 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:35 +0100
Subject: [PATCH v3 02/10] dt-bindings: soc: samsung: exynos-pmu: move
 gs101-pmu into separate binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-gs101-pd-v3-2-7b30797396e7@linaro.org>
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
In-Reply-To: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
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
v3:
- use additionalProperties, not unevaluatedProperties
- fix path in $id (Rob)
- drop comment around 'select' (Rob)
---
 .../bindings/soc/google/google,gs101-pmu.yaml      | 66 ++++++++++++++++++++++
 .../bindings/soc/samsung/exynos-pmu.yaml           | 20 -------
 MAINTAINERS                                        |  1 +
 3 files changed, 67 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f7119e7a39a3fe0a0a23d1faa251d356f83ba501
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/google/google,gs101-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google GS101 Power Management Unit (PMU)
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
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
+additionalProperties: false
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
index 8cb7a124f6e81372060c38ac2b3c9a11505ae004..22573869586eacdac0d0a075d4a691849272442e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10597,6 +10597,7 @@ S:	Maintained
 P:	Documentation/process/maintainer-soc-clean-dts.rst
 C:	irc://irc.oftc.net/pixel6-kernel-dev
 F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
+F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
 F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu-intr-gen.yaml
 F:	arch/arm64/boot/dts/exynos/google/
 F:	drivers/clk/samsung/clk-gs101.c

-- 
2.51.0.788.g6d19910ace-goog


