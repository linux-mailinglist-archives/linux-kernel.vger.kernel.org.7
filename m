Return-Path: <linux-kernel+bounces-784242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3A8B33889
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0546D4E150D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFEE1FF7C7;
	Mon, 25 Aug 2025 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="erjsbJs5"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF23222A4DB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756109531; cv=none; b=nE2KcKIJXm8pNKA3DwlEOs0NPMUAT2UZqybp3acW+prFovdaKMG2/4cX8/Un7Uq0gMo9NcS3/usyhhas3qyk+24MXdSyHZ4bLJvtfUNqPRKBWfx59xn3w+FKBiwN926oq9Pq6GynzYe+rNnuJrS0dhpSB0hiLHaYJHn5/8C63Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756109531; c=relaxed/simple;
	bh=VcDFtIzr4vI441rEW7Kp7RzmGwxaWxQUt3xEq6jBw1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BZQR+LweJuGRjKDyFH66PHVi82Djay1+ymG5q1Ha+UOsG39un0KX4cA6X5Rx2sMREPbZJkENHULdbDDQHCXc6w1ZSdsCHz4lw+r76XN/BdgLdkd4pn0Y729KsJN2vAOxiZ0f8+6SK05AmNDF0+zpzlzLjeuyMLxsYQHzfqjlRSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=erjsbJs5; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6188b5e3de6so499746a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756109527; x=1756714327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TnsZ6L300ZKgc1COVNFcUJ5H1mGue0Pdof2dEQV2XRs=;
        b=erjsbJs5OpIMRinksocW45K8M4sPTf72bTry0kCuEMA9W7dUjnE3KXhkvbCjhK+93A
         ZTdtfGeqSl5jjpYMAQaPSbCCVUFFwD2Eawj4v6x/2Ak3J9ro0JiCgjslyBsUx6mSM+sF
         C0a1xmgIuMLm5iEEK/WF8xZd8LixM8QSTPE5v9TDpdODyyuhU0bgYtgUlwHWC38ZIu+0
         gsP2vRttAsSGh74hXkJLVyh7WiD2SlNi5w3udki6NptmK7Z+tVIxoVQNsvSf6onC5rUB
         7Hr78qb84aV7F4Fu9n7FSBbq7k6WfnGBeuU14zFE7xUsj73V3rkSd5IxiKj//cPDOPL+
         sL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756109527; x=1756714327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TnsZ6L300ZKgc1COVNFcUJ5H1mGue0Pdof2dEQV2XRs=;
        b=gkWJSgauShgcGb3Mh5JV6XPU4FP63RTlDzwZZiAakE71vmcKrBCTEok5extvgQ5KgU
         9DEarzlxLDv1opv6WqTcb/LhulDBcQGQo2i3Y8jM5xKBFIHQmzg/TpqWp8XuMiv7oP3j
         iZJ9iELi354OCbfOCGb328FDXZImpmh7jx7sBT7/gZ9+DXf7pUHIVNWZYJTEisFg5ypM
         QO5fhpFH6hriMwPhxxn4K7lJEbg0qfA1h5yXjS8Vpz5qeQ+n2ZrVWFji4M0WJZr+KZsY
         cf+qSFoxx7QqK6nAgAMKwZKMeRL6fi5gG3MWxj5qWtOPwhyXl9YgsALAPqX+QAh8XvCd
         VPbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn82elQInIowvGKtNPOqh8hrwuWKC4h66LDKuOXzJrtHKEd10BJYwdARWULBozxY3IGjj6HwPm7HCraDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLr5hBsTLPiXX0L39ruXf5sOSs6Df06V9MydMyB5kprmMEefkY
	/9lqDawzm7WGACY3rreb5Ax0mK6hmEqwRQwHjJ5RoxT0f3uVPQvPIK4Y8kIoEaprIH4=
X-Gm-Gg: ASbGncuTA14xBOcE7lJ0warBowMy785O6J1vDEawE0vQHYd9/gukxeSUXusGmfARAgR
	Y+svWKuYHatokG+urJyg+NhtXLTcpHb6fbunopZdepusqNG1fxH6J2UGom2Wmgxp3TlmPdvqfe/
	AFzp1UqyMREhMYHN+68IqB1oHOJcjzWhTLtVmqzhskG0i1SLFNedsVMil6FdXDOmuXWco93V032
	j+0keykFNV6jnVQGPxlPSl04wwgmYERRLrCIk4h+I6DwCY93bu7nlWeWjxWZ72KtH/1mVfvdr3s
	Kvw3t+ediU/dOdQDx6vYpMeq6849qpvm5mgx8Pt+V9xBpWxlpezIno+2UErtnmiJUNXrQrxtlJj
	EKW0fjM1V8+/8pCN7rLliQUdHBe/RFwjO7A==
X-Google-Smtp-Source: AGHT+IGMFHVCfgzqOUh+pGDLejurh3U7hp17R5KFUc6Wa/vTUBiH/N42R6EI9BDD6UgsghTGJU7GvA==
X-Received: by 2002:a05:6402:2748:b0:61c:6855:d917 with SMTP id 4fb4d7f45d1cf-61c6855df51mr1226404a12.6.1756109526816;
        Mon, 25 Aug 2025 01:12:06 -0700 (PDT)
Received: from kuoka.. ([213.244.170.152])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c312a57e6sm4553003a12.14.2025.08.25.01.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 01:12:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Pengyu Luo <mitltlatltl@gmail.com>,
	Michael Walle <mwalle@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jean Delvare <jdelvare@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lee Jones <lee@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Cheng-Yi Chiang <cychiang@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Nikita Travkin <nikita@trvn.ru>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tinghan Shen <tinghan.shen@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-sound@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mathew McBride <matt@traverse.com.au>
Subject: [PATCH v3] dt-bindings: mfd: Move embedded controllers to own directory
Date: Mon, 25 Aug 2025 10:12:02 +0200
Message-ID: <20250825081201.9775-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move several embedded controller bindings (like ChromeOS EC, Gateworks
System Controller and Kontron sl28cpld Board Management) to new
subdirectory "embedded-controller" matching their purpose.

An embedded controller (EC) is a discrete component that contains a
microcontroller (i.e. a small CPU running a small firmware without
operating system) mounted into a larger computer system running
a fully fledged operating system that needs to utilize the embedded
controller as part of its operation.

So far the EC bindings were split between "mfd" and "platform"
directory.  MFD name comes from Linux, not hardware, and "platform" is a
bit too generic.

Rename Gateworks GSC and Huawei Gaokun filenames to match compatible, as
preferred for bindings.

Acked-by: Michael Walle <mwalle@kernel.org> # for sl28cpld
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Lee,
Can you take it via MFD?
There is a patch on the lists touching kontron,sl28cpld.

Changes in v3:
1. Move more files from "platform" directory.
2. Grow commit msg, based on feedback from Linus.
3. Add Rb (patch changed, though).

Changes in v2:
1. Correct remaining paths in other schemas ($ref and descriptions).
2. Add Ack.

Cc: Mathew McBride <matt@traverse.com.au>
---
 .../{platform => embedded-controller}/acer,aspire1-ec.yaml  | 2 +-
 .../{mfd => embedded-controller}/google,cros-ec.yaml        | 2 +-
 .../gateworks-gsc.yaml => embedded-controller/gw,gsc.yaml}  | 2 +-
 .../huawei,gaokun3-ec.yaml}                                 | 2 +-
 .../{mfd => embedded-controller}/kontron,sl28cpld.yaml      | 2 +-
 .../lenovo,yoga-c630-ec.yaml                                | 2 +-
 .../microsoft,surface-sam.yaml                              | 2 +-
 .../devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml     | 2 +-
 .../devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml   | 2 +-
 .../interrupt-controller/kontron,sl28cpld-intc.yaml         | 2 +-
 .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml         | 2 +-
 .../devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml       | 2 +-
 Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml   | 4 ++--
 .../devicetree/bindings/sound/google,cros-ec-codec.yaml     | 2 +-
 .../devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml  | 2 +-
 MAINTAINERS                                                 | 6 +++---
 16 files changed, 19 insertions(+), 19 deletions(-)
 rename Documentation/devicetree/bindings/{platform => embedded-controller}/acer,aspire1-ec.yaml (94%)
 rename Documentation/devicetree/bindings/{mfd => embedded-controller}/google,cros-ec.yaml (99%)
 rename Documentation/devicetree/bindings/{mfd/gateworks-gsc.yaml => embedded-controller/gw,gsc.yaml} (98%)
 rename Documentation/devicetree/bindings/{platform/huawei,gaokun-ec.yaml => embedded-controller/huawei,gaokun3-ec.yaml} (97%)
 rename Documentation/devicetree/bindings/{mfd => embedded-controller}/kontron,sl28cpld.yaml (97%)
 rename Documentation/devicetree/bindings/{platform => embedded-controller}/lenovo,yoga-c630-ec.yaml (95%)
 rename Documentation/devicetree/bindings/{platform => embedded-controller}/microsoft,surface-sam.yaml (92%)

diff --git a/Documentation/devicetree/bindings/platform/acer,aspire1-ec.yaml b/Documentation/devicetree/bindings/embedded-controller/acer,aspire1-ec.yaml
similarity index 94%
rename from Documentation/devicetree/bindings/platform/acer,aspire1-ec.yaml
rename to Documentation/devicetree/bindings/embedded-controller/acer,aspire1-ec.yaml
index 7cb0134134ff..01ee61768527 100644
--- a/Documentation/devicetree/bindings/platform/acer,aspire1-ec.yaml
+++ b/Documentation/devicetree/bindings/embedded-controller/acer,aspire1-ec.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/platform/acer,aspire1-ec.yaml#
+$id: http://devicetree.org/schemas/embedded-controller/acer,aspire1-ec.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Acer Aspire 1 Embedded Controller
diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/embedded-controller/google,cros-ec.yaml
similarity index 99%
rename from Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
rename to Documentation/devicetree/bindings/embedded-controller/google,cros-ec.yaml
index 50f457090066..3ab5737c9a8f 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/embedded-controller/google,cros-ec.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/mfd/google,cros-ec.yaml#
+$id: http://devicetree.org/schemas/embedded-controller/google,cros-ec.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: ChromeOS Embedded Controller
diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
rename to Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml
index dc379f3ebf24..82d4b2dadbae 100644
--- a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
+++ b/Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/mfd/gateworks-gsc.yaml#
+$id: http://devicetree.org/schemas/embedded-controller/gw,gsc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Gateworks System Controller
diff --git a/Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml b/Documentation/devicetree/bindings/embedded-controller/huawei,gaokun3-ec.yaml
similarity index 97%
rename from Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml
rename to Documentation/devicetree/bindings/embedded-controller/huawei,gaokun3-ec.yaml
index 4a03b0ee3149..cd9e65b6c2ea 100644
--- a/Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml
+++ b/Documentation/devicetree/bindings/embedded-controller/huawei,gaokun3-ec.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/platform/huawei,gaokun-ec.yaml#
+$id: http://devicetree.org/schemas/embedded-controller/huawei,gaokun3-ec.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Huawei Matebook E Go Embedded Controller
diff --git a/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml b/Documentation/devicetree/bindings/embedded-controller/kontron,sl28cpld.yaml
similarity index 97%
rename from Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
rename to Documentation/devicetree/bindings/embedded-controller/kontron,sl28cpld.yaml
index 37207a97e06c..0b752f3baaa9 100644
--- a/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
+++ b/Documentation/devicetree/bindings/embedded-controller/kontron,sl28cpld.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/mfd/kontron,sl28cpld.yaml#
+$id: http://devicetree.org/schemas/embedded-controller/kontron,sl28cpld.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Kontron's sl28cpld board management controller
diff --git a/Documentation/devicetree/bindings/platform/lenovo,yoga-c630-ec.yaml b/Documentation/devicetree/bindings/embedded-controller/lenovo,yoga-c630-ec.yaml
similarity index 95%
rename from Documentation/devicetree/bindings/platform/lenovo,yoga-c630-ec.yaml
rename to Documentation/devicetree/bindings/embedded-controller/lenovo,yoga-c630-ec.yaml
index 3180ce1a22d4..a029b38e8dc0 100644
--- a/Documentation/devicetree/bindings/platform/lenovo,yoga-c630-ec.yaml
+++ b/Documentation/devicetree/bindings/embedded-controller/lenovo,yoga-c630-ec.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/platform/lenovo,yoga-c630-ec.yaml#
+$id: http://devicetree.org/schemas/embedded-controller/lenovo,yoga-c630-ec.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Lenovo Yoga C630 Embedded Controller.
diff --git a/Documentation/devicetree/bindings/platform/microsoft,surface-sam.yaml b/Documentation/devicetree/bindings/embedded-controller/microsoft,surface-sam.yaml
similarity index 92%
rename from Documentation/devicetree/bindings/platform/microsoft,surface-sam.yaml
rename to Documentation/devicetree/bindings/embedded-controller/microsoft,surface-sam.yaml
index b33d26f15b2a..9202cfca0b35 100644
--- a/Documentation/devicetree/bindings/platform/microsoft,surface-sam.yaml
+++ b/Documentation/devicetree/bindings/embedded-controller/microsoft,surface-sam.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/platform/microsoft,surface-sam.yaml#
+$id: http://devicetree.org/schemas/embedded-controller/microsoft,surface-sam.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Surface System Aggregator Module (SAM, SSAM)
diff --git a/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml b/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
index b032471831e7..02663d67eac7 100644
--- a/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 description: |
   This module is part of the sl28cpld multi-function device. For more
-  details see ../mfd/kontron,sl28cpld.yaml.
+  details see ../embedded-controller/kontron,sl28cpld.yaml.
 
   There are three flavors of the GPIO controller, one full featured
   input/output with interrupt support (kontron,sl28cpld-gpio), one
diff --git a/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
index 010333cb25c0..5803a1770cad 100644
--- a/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
+++ b/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 description: |
   This module is part of the sl28cpld multi-function device. For more
-  details see ../mfd/kontron,sl28cpld.yaml.
+  details see ../embedded-controller/kontron,sl28cpld.yaml.
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
index e8dfa6507f64..87df07beda59 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 description: |
   This module is part of the sl28cpld multi-function device. For more
-  details see ../mfd/kontron,sl28cpld.yaml.
+  details see ../embedded-controller/kontron,sl28cpld.yaml.
 
   The following interrupts are available. All types and levels are fixed
   and handled by the board management controller.
diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
index f7bc84b05a87..8f5a468cfb91 100644
--- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
@@ -14,7 +14,7 @@ description: |
   Google's ChromeOS EC PWM is a simple PWM attached to the Embedded Controller
   (EC) and controlled via a host-command interface.
   An EC PWM node should be only found as a sub-node of the EC node (see
-  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml).
+  Documentation/devicetree/bindings/embedded-controller/google,cros-ec.yaml).
 
 allOf:
   - $ref: pwm.yaml#
diff --git a/Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml b/Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
index 981cfec53f37..19a9d2e15a96 100644
--- a/Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 description: |
   This module is part of the sl28cpld multi-function device. For more
-  details see ../mfd/kontron,sl28cpld.yaml.
+  details see ../embedded-controller/kontron,sl28cpld.yaml.
 
   The controller supports one PWM channel and supports only four distinct
   frequencies (250Hz, 500Hz, 1kHz, 2kHz).
diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
index adc6b3f36fde..179c98b33b4d 100644
--- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
@@ -58,7 +58,7 @@ properties:
     maxItems: 1
 
   cros-ec-rpmsg:
-    $ref: /schemas/mfd/google,cros-ec.yaml
+    $ref: /schemas/embedded-controller/google,cros-ec.yaml
     description:
       This subnode represents the rpmsg device. The properties
       of this node are defined by the individual bindings for
@@ -126,7 +126,7 @@ patternProperties:
         maxItems: 1
 
       cros-ec-rpmsg:
-        $ref: /schemas/mfd/google,cros-ec.yaml
+        $ref: /schemas/embedded-controller/google,cros-ec.yaml
         description:
           This subnode represents the rpmsg device. The properties
           of this node are defined by the individual bindings for
diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
index 1434f4433738..dd51e8c5b8c2 100644
--- a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
@@ -15,7 +15,7 @@ description: |
   Embedded Controller (EC) and is controlled via a host-command
   interface.  An EC codec node should only be found inside the "codecs"
   subnode of a cros-ec node.
-  (see Documentation/devicetree/bindings/mfd/google,cros-ec.yaml).
+  (see Documentation/devicetree/bindings/embedded-controller/google,cros-ec.yaml).
 
 allOf:
   - $ref: dai-common.yaml#
diff --git a/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml b/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
index 179272f74de5..872a8471ef65 100644
--- a/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 description: |
   This module is part of the sl28cpld multi-function device. For more
-  details see ../mfd/kontron,sl28cpld.yaml.
+  details see ../embedded-controller/kontron,sl28cpld.yaml.
 
 allOf:
   - $ref: watchdog.yaml#
diff --git a/MAINTAINERS b/MAINTAINERS
index 7969d09dff17..ef41ae022a36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10129,7 +10129,7 @@ F:	drivers/media/i2c/gc2145.c
 GATEWORKS SYSTEM CONTROLLER (GSC) DRIVER
 M:	Tim Harvey <tharvey@gateworks.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
+F:	Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml
 F:	Documentation/hwmon/gsc-hwmon.rst
 F:	drivers/hwmon/gsc-hwmon.c
 F:	drivers/mfd/gateworks-gsc.c
@@ -11300,7 +11300,7 @@ F:	drivers/net/ethernet/huawei/hinic3/
 HUAWEI MATEBOOK E GO EMBEDDED CONTROLLER DRIVER
 M:	Pengyu Luo <mitltlatltl@gmail.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml
+F:	Documentation/devicetree/bindings/embedded-controller/huawei,gaokun3-ec.yaml
 F:	drivers/platform/arm64/huawei-gaokun-ec.c
 F:	drivers/power/supply/huawei-gaokun-battery.c
 F:	drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
@@ -23177,10 +23177,10 @@ F:	drivers/usb/misc/sisusbvga/
 SL28 CPLD MFD DRIVER
 M:	Michael Walle <mwalle@kernel.org>
 S:	Maintained
+F:	Documentation/devicetree/bindings/embedded-controller/kontron,sl28cpld.yaml
 F:	Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
 F:	Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
-F:	Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
 F:	Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
 F:	Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
 F:	drivers/gpio/gpio-sl28cpld.c
-- 
2.48.1


