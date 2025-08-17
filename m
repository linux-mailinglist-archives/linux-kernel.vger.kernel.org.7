Return-Path: <linux-kernel+bounces-772418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5A2B29258
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 10:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B4DB7A559F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 08:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8BD2185B8;
	Sun, 17 Aug 2025 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxmOTR2h"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA25221FC4;
	Sun, 17 Aug 2025 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755420730; cv=none; b=I6nUlq/guluxy+s5fQdp94bgF3eML3axoSI/SBICnCLWkKgVKyDg/GG+RiZv/yoMMIfF5FuYtrlSRz5yLbe1yUdKCpMBCyqzw5+daTstjKuLr39xaYN75SJBHm48AQcYSKopDynALwmLlru4dxck6ZuGrei/CmYyNAT7GPeR0cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755420730; c=relaxed/simple;
	bh=mOZmGCDS+ifmqcLYmfbp8BPcpAmCwzlvZIOuiRx0LQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pPkpYD3OEBHEZTKsv0o1TaJ3gXpcuQhqFYGrZFazvTSG9jjoNPEAyuwFz8106cax9K+UyA8WHeE3HZtpSORvWLNx/bIAi9MUunoNrpEQ9cSaNYEEyuQQIS0trgwkwspM4E8y9MAXXSvHN6p+YP/ESrszG1vU5Udyw969c0Y5bI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxmOTR2h; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b00e4a1so20299175e9.0;
        Sun, 17 Aug 2025 01:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755420727; x=1756025527; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nczVdXOwZnKrAnrfSpvljupjNcdPfY9nuejpS2UQfbs=;
        b=LxmOTR2hxxQ15wfbcEa28kXUuPJSve8hTXq6W1yzoW1FWaMkm4B4T1ZH4nl3ynQ1Yt
         RQwFIG4PvZBU6ITq0QIiDCpAg1l8NYGrXLlWyLd8O43qa40AjzhmtnZ1HOWuOllj7cps
         MRAK8bz7cYb8tMKGeO/ZTgb4DFeWZLR/nA2FedFBxuQhtE+2wBSEu1OE7lyCzJ0bUHEt
         vpLAD/oDeJ/QbdOzRiF0zdtbccDYq1tTzki6ZNGRxmWfv6SFOhFjT5cb+BSbNL45SifM
         9NFlYvE3hJghnPBK8F5a/H2LMn73crpB410rxEeS3cuLXULEocod1CB9SGUuEcjwW5p+
         pnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755420727; x=1756025527;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nczVdXOwZnKrAnrfSpvljupjNcdPfY9nuejpS2UQfbs=;
        b=lh5JtqeIL29TYSsr17ymifQTFUxtwU+fyysp/x5lNxXf/b4V10HAOW7xkI8Zusr68M
         ijGocMETYBvRewSqj6XG1t2bt6MsQZhpxiqa31P5Ci9mmVK74ruXGprg/TWcVJtjAN59
         CerSimD+PshC5iBaDTwemHhSo4NFp7rNBLdtCO/wJlsCorjIQpkq5fLF0nIXL9ZsIwpk
         WQGN3qc9zE7QuhXD0+WGyFyOYnZ19DW+b55Yk27zH5W8t6JGoqyr/cSMkqXTiz8LjgTG
         UXu/9lqj7f6yNila/kjwxRhsmkgfUTK1mnuBlCUFntB0la5B/UHI7B/QYfgdT9Q0R58R
         TH/g==
X-Forwarded-Encrypted: i=1; AJvYcCWo0rJOTsifpXA4orVM0r2JxmHfoui5mFtOohGt//fVpndSBkvOketciHnQCdYSZy5jPWZZea5ra1Av@vger.kernel.org
X-Gm-Message-State: AOJu0Yx76So4f2BCHdKy66MKZdbk32p18kQctuZxGtWkY4rqme4Mf6YR
	4zQytDW7tGZgsj8WsAejf5dslkSmLGQVo0tVubGyA+KzQJzaKgVmVDag
X-Gm-Gg: ASbGncu3f9vYmcD2Wd0pfyZEPtIJRW60QLEA1WkCuuZZ8Ii7o5/++500M93J1adIrfx
	L4cb1Z1pfXz5MywFNxFeI9QNEwpQNmQyyDQvMPF8MQtrDGwS87+3enPFtEpxrx2MgLUKVQLFba5
	1cUyAZxhII0x4rXXzkEI3HgUQTgcWkgETezJ9YsndWeowjbkMz4O4waWZ+A+9CRcrehWM+BFNmr
	W0JDFIcS8jLvVEawl8cmIOyt0HBq4E0dv7zAyKcjatdUmZnJd5/U14qkiPtDxWgt9Y44bjRcTiQ
	P5AsTrFqIJ3ZnyyS5AcMrfjJGZrXKIBGxprGugGPNvzHNd25MVzI52jc2J2YniWenaB/KEpcEu4
	uDrApRiFwwjQO/Sdf952p8uVn5WI2R+VkaZ10XQ==
X-Google-Smtp-Source: AGHT+IHpkqsbnW5dI7T7TVGSboSIG78i5UQ9PGrjFIX6sk/xbZSOWeEOND1ulVndvLOVG5mNNs3k7g==
X-Received: by 2002:a05:600c:b8d:b0:459:dfde:3324 with SMTP id 5b1f17b1804b1-45a21857f09mr61790745e9.29.1755420726498;
        Sun, 17 Aug 2025 01:52:06 -0700 (PDT)
Received: from tablet.my.domain ([2a00:f41:b0c2:8202:4205:bdef:2b7a:307d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c61a66esm122908205e9.0.2025.08.17.01.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 01:52:06 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sun, 17 Aug 2025 10:52:04 +0200
Subject: [PATCH] dt-bindings: extcon: rt8973a: Convert DT bindings to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250817-rt8973a-dt-bindings-yaml-v1-1-150eb4599dc9@gmail.com>
X-B4-Tracking: v=1; b=H4sIADOYoWgC/x3MTQqAIBBA4avErBtQ++8q0cJ0qoGy0IgiunvS8
 lu890AgzxSgTR7wdHLgzUXINAEzazcRso0GJVQhalmhP+qmyjTaAwd2lt0U8NbrgnlpVDkamWs
 jIOa7p5Gvf9317/sBFCRutGoAAAA=
X-Change-ID: 20250817-rt8973a-dt-bindings-yaml-46c26fc14ac0
To: MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3614;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=mOZmGCDS+ifmqcLYmfbp8BPcpAmCwzlvZIOuiRx0LQc=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBooZg09NEWXrXJwt4SiDAZDQjE9ZS2KCbbMIEey
 5KvZAGVD+OJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaKGYNAAKCRCzu/ihE6BR
 aPx8D/9RwWq/MUMbV2XLphySJXfdeMUzrpjAjItYc+UdsQ2HbpLfdzFn1aw3kAHiEGgY2jYJA1y
 pt0gPAaDPxp7hy/LH6ILKc3Y6tM0LNVUHO0UrCq0VKQUxJvdkf6WlnLlhdoDoeJn7gVavqgVkGw
 vQH32aTAT0t+Zrw+w2ZBhuhUhMiRfQa57b6GpujAbmGrUaGsIqpQEvaPUi+c5xYLpAF1Vt0tdjm
 AX8TmYWcsnHUgUnwLArxK4XTQJKrAl/AgS5eFEQtlrHVedEMBYDtHNcVoP5QnkHv8YppaubNQdn
 XLwlkPQj+wRFApuREojmvBqjuX01dMjjWcKsFcCVSAWuqPtuy21nR9ELqHOG3nIXkIQ6b4NACoT
 yTPEIKm7bqJMhmwE0WvjSGE0eaeFz/sdg38CDJV0b1CJTgoO+5JWxUJDoQW9egfYTDEMKA9uSZE
 sFFbnQYi3SUw/OHJ1DKLn7mnb9Al5E+UD1DBhgbu8O42oU6Hq+7OYTLHTpM826R47Zfb4ih9eFH
 q3/2APguRQpmX9+Sc83aPYWUif0+2apl2ao6KE/4yeHmO9flBxvjcncc+5hMmjmlW3h1q4plOtb
 su/GrPr47uZePmN+sYOJ9Zf/E/u8r5cnPbQfzEbLUrXOcnmZPKGDUe4Ljnbn+QVoyVyIPDC4CW2
 7kRbZz74pWdUZnw==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Convert the device tree bindings for Richtek RT8973A MUIC to the YAML
format. No functional changes.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
I've added Chanwoo Choi as the binding maintainer as he is listed
as the author of the driver for this device; I can change this if
needed.
---
 .../devicetree/bindings/extcon/extcon-rt8973a.txt  | 23 ----------
 .../bindings/extcon/richtek,rt8973a-muic.yaml      | 49 ++++++++++++++++++++++
 2 files changed, 49 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/extcon/extcon-rt8973a.txt b/Documentation/devicetree/bindings/extcon/extcon-rt8973a.txt
deleted file mode 100644
index cfcf455ad4deffc1e4819934e6dc6fb3f95a54a5..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/extcon/extcon-rt8973a.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-
-* Richtek RT8973A - Micro USB Switch device
-
-The Richtek RT8973A is Micro USB Switch with OVP and I2C interface. The RT8973A
-is a USB port accessory detector and switch that is optimized to protect low
-voltage system from abnormal high input voltage (up to 28V) and supports high
-speed USB operation. Also, RT8973A support 'auto-configuration' mode.
-If auto-configuration mode is enabled, RT8973A would control internal h/w patch
-for USB D-/D+ switching.
-
-Required properties:
-- compatible: Should be "richtek,rt8973a-muic"
-- reg: Specifies the I2C slave address of the MUIC block. It should be 0x14
-- interrupts: Interrupt specifiers for detection interrupt sources.
-
-Example:
-
-	rt8973a@14 {
-		compatible = "richtek,rt8973a-muic";
-		interrupt-parent = <&gpx1>;
-		interrupts = <5 0>;
-		reg = <0x14>;
-	};
diff --git a/Documentation/devicetree/bindings/extcon/richtek,rt8973a-muic.yaml b/Documentation/devicetree/bindings/extcon/richtek,rt8973a-muic.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f9e0d816c025957e8b96b15bdf478e589e653e90
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/richtek,rt8973a-muic.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/extcon/richtek,rt8973a-muic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT8973A MUIC
+
+maintainers:
+  - Chanwoo Choi <cw00.choi@samsung.com>
+
+description:
+  The Richtek RT8973A is Micro USB Switch with OVP and I2C interface. The RT8973A
+  is a USB port accessory detector and switch that is optimized to protect low
+  voltage system from abnormal high input voltage (up to 28V) and supports high
+  speed USB operation. Also, RT8973A support 'auto-configuration' mode.
+  If auto-configuration mode is enabled, RT8973A would control internal h/w patch
+  for USB D-/D+ switching.
+
+properties:
+  compatible:
+    const: richtek,rt8973a-muic
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        usb-switch@14 {
+          compatible = "richtek,rt8973a-muic";
+          reg = <0x14>;
+          interrupt-parent = <&gpio>;
+          interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };

---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250817-rt8973a-dt-bindings-yaml-46c26fc14ac0

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


