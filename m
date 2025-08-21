Return-Path: <linux-kernel+bounces-779036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF911B2EE35
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BE31C80914
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2823C54764;
	Thu, 21 Aug 2025 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZyhWTWUR"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D863718FC97
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757731; cv=none; b=H+DeV1UFt8tUZd+bN4Kgffi/t2MgNfaLO5Jib3OtWLdZMDaTu7e/seh6gBiUksYFq9G9VBdXFFBeelX4VsZLdAK5klyKH0frvFMlP9kQdKWQU+RDrISsCy/G8k3NP4K62ASZ3gvJIDiV9axtDQiEUULcsEBB6/9kj76T0Ic77Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757731; c=relaxed/simple;
	bh=BuRfAnFnaOP1D4CJsQUvuku8RSgN8ChGH2kSyQKMXpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uSK0dnGL0QFHAfP5rOiLInGCcrYpQKdbBwXT1jp7Z6rs0R6j5GY4lKv4feJ95U0SmomsOtP4jdStQ6qqFVDpXv5Qm6tEfqPKo2Y1yNV3qHo7RCBQs8r6Rl34fDpf46joJtX+s9CAUuHehbdfKW0yR2B1Xx9j7y2VgZIh/xgeV5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZyhWTWUR; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afdf4bb0e5cso10846666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755757727; x=1756362527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RdUVASp7YNyKaUR2qHcgjrjThqHqtigmKhoUTntMczo=;
        b=ZyhWTWURZskJ9e0jDD3ml+L7FXv7Nzub13qamMxRzoXwFRMHZ6J+Hbgn16DjAVlLhB
         WV2R+0+rSjmElhQaF50fWu0ZDYGBhQVrLHCTWbsjwBsJW9jA1Q1A8Rl16acQvBeLEFx0
         y7mA/+JM4imyQaAY8uH7sJovQ8Y8BYkqzGb3QaMGqByIoUgwIKjJtON2RTl/+/NsRfWj
         rEn6XddwmSADV2Ym8VhUr5OIfaVBzX01ab4BLyTTuV1m+MG1lia8jSzAtcjsGLa0w41a
         JjfPvDp3yida6kp1d4LPNMdIfaj0yTw2SGp/9sc3CCMZo/s4lAD5p2hrso1GRDZk02w2
         vHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755757727; x=1756362527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdUVASp7YNyKaUR2qHcgjrjThqHqtigmKhoUTntMczo=;
        b=Wgt7NAJ5Sws9ucvR+5oO+G/XBWyGAVmwsrmtHxfS1HhrpBdWu38gMTqQWGvfnJw5W6
         Q3CGyXGOT0WA4lySLhAbslGj/e9RZoI1ImLp3Y328vg/pP9r8R1h+D7YGHLmPYUuJ302
         ADodW2ntHaJnX2Up8TKwbC0PZGu4mxk5q+2s8STDSaZ0Op0T2ZoWlC63Q2hA6p91hA+f
         cxtB1f4BsP87TuiEcY5hMB2rIkT43Bmi8IzYVwKMgFr5HHPqevUr868rHX4pVKN0mWtQ
         hX9CKhEiCEpG9U9ZOp68Aztn0NroqgP+KUxAyMp50otrt/u21p3bBxHMpl8EEl6RcbrG
         R/yw==
X-Forwarded-Encrypted: i=1; AJvYcCXKoTtZ2dCzrt6oXK2sU3Cp24q9lvQrmmp6WEj/ie57St6A2C8i1GQZO4gbPLsoQ4zwKodKTzzIus3uC4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJcPR8Shra2TnQLzCXCWOd/NK/OzkWlt5nSvcUGq/4YZDtnll0
	UqJJoOsqSXQ+1yGAwaSy0zRrdiJG6UUKsL/v0tYe8PrDwRFXB6sxBjpG4yWUnwSkgZQ=
X-Gm-Gg: ASbGncv3dF0A3mWvKKPMFsmr8UwdMaRwV/w0v2yItDX8cxf0XqXsj1VgGptYkMTBpGt
	33rZr7aD3ATK66loVIA8d7LL9CiqYNf89UKFbYZSpdBicrpAa79ZTnczK/9KZYgQJfaxqMbIZZT
	KBcrkfG/8ZZwc2Bcjb69CFga+nAqX3P984mxXhWo0GOkiPkgITY+ilD0hDFJeVIeeshx6nELWb8
	2S7U9pN2qZIgF4uO5W+ljt6NcAyzCiW1Tn5Fyv3GYMVGQOywbivWZpkCQ1euuQcM6NY15yykhcv
	fLquvKeXTeuqU3hkGBsNn1qWgqZ4nm6ELjnD/RJt8c/h46kQoF9xQXLbEaBVd9CyOls7WnqjwSI
	hvWdYd9ngD4RtyU4DcFD2eVkkTEIz+lTcUw==
X-Google-Smtp-Source: AGHT+IGboT0zZyC1O+5BE8fpnBfnc957GqC4iwpI3neSB8Xxwq58FC9qag7/uLD5PdUhRv7MO8IczQ==
X-Received: by 2002:a17:907:3f9e:b0:ae0:c276:d90e with SMTP id a640c23a62f3a-afe07a0e6a4mr67859966b.4.1755757727090;
        Wed, 20 Aug 2025 23:28:47 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded479868sm327334966b.58.2025.08.20.23.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 23:28:46 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Michael Walle <mwalle@kernel.org>,
	Lee Jones <lee@kernel.org>,
	devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mathew McBride <matt@traverse.com.au>
Subject: [PATCH] dt-bindings: mfd: Move embedded controllers to own directory
Date: Thu, 21 Aug 2025 08:28:41 +0200
Message-ID: <20250821062840.9383-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4904; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=BuRfAnFnaOP1D4CJsQUvuku8RSgN8ChGH2kSyQKMXpM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopryYe55RPyEPBDxuIysytsjwZXrGU13RiseVq
 9CsfRiTjXWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKa8mAAKCRDBN2bmhouD
 15kmD/9Q7Zpp5+h7XrEAaw2XkPWouR762eRSFXtOsWf0fAEy0/nEkVTJM3X2bgoCA+kzBspaOkd
 dDx+wDCAPeTEeUJhdTrlcEI9SvNrSomyNURwQr0/vbp/w4LdM9HvnYnFpZw3tFsL2/L1q8h0jsn
 l6W+JjPxHg+NyNnHfkeUQz6HgoJODDhqP5tLws5Juk8mI/nD0fJlBQQxDyAKJqBo0T+easLhKB2
 7JiwCewCrMd6u0+KkV/kghHGYsJBmR2ybifDuaxKVxHVhj6L2s+rkyqsQnxjYQZLvoWINzuuAJD
 XxB8ezzBjQqg/2IdHSRcgOHXO93e9i2dKAv/u/fw8jCX7xAj4NQG5033XopBVMNcKXTx3fn/FAC
 zjWrqCfJzmzumt22xdo2a/UmCVBpt4o6uQJF9HTn7Hjr7v8BFVanWBOooPXfYRCWYpG2duzsmqK
 X3AHv9mSmAk6EmkrtKlzTWJ4yVOXRLKDD3+l0sceBPMUnt8VgqpiYR1gcIIeURyhosfRqDfiOfz
 OdpQVZj0D9NccW7xfL+2MML2AcHZURXtiZXPQcjIHCSN0tRQL1o1Lm6689Y4j9G86VpQyWxG2oG
 etWm76IKRB20J3rj6NISaC/Nwu0etBNyVK5TYVSKoDDN+jR2oj4pqPV9fsPYdQ+gsRAsE1Cmj2H F0m0JXCBqrSIryA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Move ChromeOS Embedded Controller, Gateworks System Controller and
Kontron sl28cpld Board Management Controller to new subdirectory
"embedded-controller" matching their purpose.  MFD is coming from Linux
and does not really fit the actual purpose of this hardware.

Rename Gateworks GSC filename to match compatible, as preferred for
bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Mathew McBride <matt@traverse.com.au>

Lee,
Can you take it via MFD?
---
 .../bindings/{mfd => embedded-controller}/google,cros-ec.yaml | 2 +-
 .../gateworks-gsc.yaml => embedded-controller/gw,gsc.yaml}    | 2 +-
 .../{mfd => embedded-controller}/kontron,sl28cpld.yaml        | 2 +-
 MAINTAINERS                                                   | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)
 rename Documentation/devicetree/bindings/{mfd => embedded-controller}/google,cros-ec.yaml (99%)
 rename Documentation/devicetree/bindings/{mfd/gateworks-gsc.yaml => embedded-controller/gw,gsc.yaml} (98%)
 rename Documentation/devicetree/bindings/{mfd => embedded-controller}/kontron,sl28cpld.yaml (97%)

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
diff --git a/MAINTAINERS b/MAINTAINERS
index 7969d09dff17..f3e4c1aa656e 100644
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


