Return-Path: <linux-kernel+bounces-855679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D86BE1F54
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D0574E8213
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F5D2FCC16;
	Thu, 16 Oct 2025 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k637RR6X"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDD227E076
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600545; cv=none; b=YPEI6SZ6ous2oJidF2jxhcl200JtZHXb0S2G1o/fWDvdGy4uQ5p/jwjffhcAg9yfeuKOgVcVoA+7RKnD1BA2gFwRHNbG6Kx8+cPwcWDZCbRu3Nrxs6c6ZAllIK0mZhjiOtQCysW8wQuy4kyOhxCw/nyuzgx6q1W657Ots1PAb18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600545; c=relaxed/simple;
	bh=FkGRInyokXG5KJ+kNbqMo2+fNDp7XD2fsmE5VLy0RFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+pnmJRL5UJ/phPRYNQmkFw5GTJKeVAO01CtwA5EFVWcrLJqOPeLljWjXbQIB+EucFEMbPHypjRaXp5n9cg0igqjSQk4ZJSiTgtkljoya+2LYp94iJsMx+ESXMEGvK43j3D4eCRHL8jDIV0tN/jZJWMOTb9neSoxJeO4HLweEWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k637RR6X; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-591c9934e0cso485906e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760600542; x=1761205342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OFHVsoqdL4FPop43Q5nsyfcnf+4nWBxo0n9KE3mG1k=;
        b=k637RR6XHedi8yaJRkiZptXdraa3lA2GP7TsT49K7SQj80XRPDayVmTqb/x2yKZiOk
         libL9sQQL1Vik3M0loZJeyy6IhTh5z5kNIdzVaDMdkYRErTik3V1Y9DHoGD/du7u82DB
         hwqYK5Tvj3fw+encIewM2bMnBFQx3hgpzfKMoxzxGFOgMiRZrUjysyIf/HGZucDPmZRR
         n3KRZtUlPppan7+Po6FgNNjJ6RsZ4qlTYUmZ+Ttq1zUgNe34D2O/OgLDe49WsDU8ivBr
         Q3M8x1YhtHz3uEaENx01tiOyuNrqA3g4vNkZok7qYJ9yr0jWZ4fnXti70/xNE7LMRH0i
         66fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760600542; x=1761205342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OFHVsoqdL4FPop43Q5nsyfcnf+4nWBxo0n9KE3mG1k=;
        b=b2zd9s8p0tcFtCaNMm6GU7pIT7T9p7T2TmvxoInLjcS87jRKv6ZOVfO5OpQDsnJKXw
         uVUQ15LsFiL3mq41eu6A8EO/Zk+azBn/ek0LInBQU7QlaKptT/ZKeZ2I5+LLgOpfqwdd
         80Kn2AFfqE7WuHBw4omUED9mamBov6p02H1zEr1evfkcUuYhb0CERc35u2lw3auxaQDV
         DoHmR86cY7J9VbbzyNJa+aMWHSFmjRu1j53xafSRPNpKpKCtXS0wxshM1/FqJ2NsBSs2
         prEf9NPFJo7LjezH/tcUpj9uVO/p0q5zVS3yq8pkvyKfAMWKYe7DbMRXoeApbjZuSbhh
         fCYA==
X-Forwarded-Encrypted: i=1; AJvYcCUZyV2U+KgfrL9/Gtr+shBGmoVGrgZJ86OaIZZjlitFG4S5PJ6P/gsfOiwVtdQOKU0Kcweki+LK2LXMHtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywcJht2YQyYw2Ox+YMtn1iNgOJF142Fm/OlfEiQcv5BlvHCXBg
	H1r+3znmn9Uev57fkbE62vpKCLSYFNMy/zEBMcYfh5iTOMngq2PaE8HrtmSJig==
X-Gm-Gg: ASbGncsF1NgDBjXVppCk4JY8JHWwTAuHXoE4eacYZbGT+dSUizIIjIlOWfulnchYhAZ
	eshZaYYhMPHGuJjljnsD2d2dvuTphdt9DGUnVBcv41q6/yRAo1FMRoELavpRIh65m73RovOLNDh
	aTT9VXMws6GpLwB7v3sVo0BNaJyas70Loeln/2Z9efA7OolJr96i0ahq1G4ueNpz1cY838tjVe5
	ZxNNLl4rkwVIvk+il25dpRld7QNoo+K+6e53ImHoKmw4AtHqDGZSpkbYnd5o8+qs93XtdG/WsQi
	U8dd/XwRIaCzG1FvDdtJOSZSjBiyJJrWyQIL3wPCqJmL9CNn0AdosKNbNQmiFj6pj5Tva49g8/w
	wKh+fjRv3v1sYUTvRk8Vz/7aNDzCf5NPv7+Jpp0zgZ3IyJa/jY3IcLbz7VKgYPPavcLGdoOuNAA
	tqPyyRg7yXWT5q
X-Google-Smtp-Source: AGHT+IEQ7WcXMMwyK2nxJArLctfo4cva0enT8AjYXTH9/BOo6BovSeeUah3crI2yt6sggvpHayBv2g==
X-Received: by 2002:a05:6512:308d:b0:579:ec3a:ada2 with SMTP id 2adb3069b0e04-5906d7738b2mr10869982e87.4.1760600541764;
        Thu, 16 Oct 2025 00:42:21 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762ea14d46sm53226121fa.34.2025.10.16.00.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 00:42:21 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4 RESEND] dt-bindings: display: tegra: document EPP, ISP, MPE and TSEC for Tegra114+
Date: Thu, 16 Oct 2025 10:41:49 +0300
Message-ID: <20251016074152.8759-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016074152.8759-1-clamor95@gmail.com>
References: <20251016074152.8759-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current EPP, ISP and MPE schemas are largely compatible with Tegra114+,
requiring only minor adjustments. Additionally, the TSEC schema for the
Security engine, which is available from Tegra114 onwards, is included.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 .../display/tegra/nvidia,tegra114-tsec.yaml   | 68 +++++++++++++++++++
 .../display/tegra/nvidia,tegra20-epp.yaml     | 14 ++--
 .../display/tegra/nvidia,tegra20-isp.yaml     | 15 ++--
 .../display/tegra/nvidia,tegra20-mpe.yaml     | 18 +++--
 4 files changed, 102 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-tsec.yaml

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-tsec.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-tsec.yaml
new file mode 100644
index 000000000000..2c4d519a1bb7
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-tsec.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra114-tsec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra Security co-processor
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: Tegra Security co-processor, an embedded security processor used
+  mainly to manage the HDCP encryption and keys on the HDMI link.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - nvidia,tegra114-tsec
+          - nvidia,tegra124-tsec
+          - nvidia,tegra210-tsec
+
+      - items:
+          - const: nvidia,tegra132-tsec
+          - const: nvidia,tegra124-tsec
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+  operating-points-v2: true
+
+  power-domains:
+    maxItems: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra114-car.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    tsec@54500000 {
+        compatible = "nvidia,tegra114-tsec";
+        reg = <0x54500000 0x00040000>;
+        interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&tegra_car TEGRA114_CLK_TSEC>;
+        resets = <&tegra_car TEGRA114_CLK_TSEC>;
+    };
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-epp.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-epp.yaml
index 3c095a5491fe..334f5531b243 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-epp.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-epp.yaml
@@ -15,10 +15,16 @@ properties:
     pattern: "^epp@[0-9a-f]+$"
 
   compatible:
-    enum:
-      - nvidia,tegra20-epp
-      - nvidia,tegra30-epp
-      - nvidia,tegra114-epp
+    oneOf:
+      - enum:
+          - nvidia,tegra20-epp
+          - nvidia,tegra30-epp
+          - nvidia,tegra114-epp
+          - nvidia,tegra124-epp
+
+      - items:
+          - const: nvidia,tegra132-epp
+          - const: nvidia,tegra124-epp
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-isp.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-isp.yaml
index 3bc3b22e98e1..ee25b5e6f1a2 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-isp.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-isp.yaml
@@ -12,10 +12,17 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - nvidia,tegra20-isp
-      - nvidia,tegra30-isp
-      - nvidia,tegra210-isp
+    oneOf:
+      - enum:
+          - nvidia,tegra20-isp
+          - nvidia,tegra30-isp
+          - nvidia,tegra114-isp
+          - nvidia,tegra124-isp
+          - nvidia,tegra210-isp
+
+      - items:
+          - const: nvidia,tegra132-isp
+          - const: nvidia,tegra124-isp
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml
index 2cd3e60cd0a8..36b76fa8f525 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml
@@ -12,13 +12,21 @@ maintainers:
 
 properties:
   $nodename:
-    pattern: "^mpe@[0-9a-f]+$"
+    oneOf:
+      - pattern: "^mpe@[0-9a-f]+$"
+      - pattern: "^msenc@[0-9a-f]+$"
 
   compatible:
-    enum:
-      - nvidia,tegra20-mpe
-      - nvidia,tegra30-mpe
-      - nvidia,tegra114-mpe
+    oneOf:
+      - enum:
+          - nvidia,tegra20-mpe
+          - nvidia,tegra30-mpe
+          - nvidia,tegra114-msenc
+          - nvidia,tegra124-msenc
+
+      - items:
+          - const: nvidia,tegra132-msenc
+          - const: nvidia,tegra124-msenc
 
   reg:
     maxItems: 1
-- 
2.48.1


