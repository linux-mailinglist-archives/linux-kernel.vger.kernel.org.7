Return-Path: <linux-kernel+bounces-892660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D30C45912
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6ECE3B5B03
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184E82FF66A;
	Mon, 10 Nov 2025 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKGaGDD3"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846E2155389
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766129; cv=none; b=lgghCD87Jy/I+VLtvqpOYH3dFqxuxlXf6MG587YvY75izrZLf33UWLdKdc0S73K3VCdI/d9e0VcrjLesWFi75ydBRf8nGMLc0/zNlUD7cs5weM9Q99JcKfbVxgqSezWf/tZt5hwn+p5oJmZU92aarhAsXRUTNCT50N/lYfY4d1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766129; c=relaxed/simple;
	bh=M+TtnNRlKxmwNkWjOrflCvsVUhdbfnUnfwwEyraGfY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GT351/P/4R2rfRhMwhKpBX8jzc4gpRLH1E7XghLruorVgX2jOrZLpodKyJpoikwuGApOV1LEqtSz2KW4VCYG8FIr1sL/JrfLDTqEAXXG7AWtID4INn1yiInbzEjgYAX0HHafLCJBDNhB2qeNlGzX06Ku5bsv1I8yxcH3VueSa40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKGaGDD3; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37a33b06028so23494551fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762766125; x=1763370925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmVeYmdQG39CjbFRBoggArBt69tBLOMtXANeqHPySaA=;
        b=RKGaGDD3VtE/GLQK8rJR3NTOP7wu5Y1cYeHUHmeCbhsmnholaP0ZM39sTS3v8Hcfdn
         Y/w9cvPC8DKVfUpa1SW5Q+OpyVk9ruGzomVQeEKzdRDx8MkvB8xXui4ud3pWJVdFLza5
         5uJQUU32wKOqXDbrwGQBPOQ/j692mKssv49GBksKMTUnumucLE5bOIXocTixN39DUtFb
         Xr4Ionav27nXv6ih5iaAqXXOY9Jp3f2yryWH3FXWKVIlrCbVfMpGWgYHE757UYBVImc3
         WOEunKBJcC0YiUFFuBkDEt6d4PDlVQxlQwQPapJFRdZM5b4SG23CN0ZbMIJbsifMlq/b
         sUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762766125; x=1763370925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MmVeYmdQG39CjbFRBoggArBt69tBLOMtXANeqHPySaA=;
        b=e7PL9Rt3QrSFbG6nJ6L65OcM7iXLOZoXii2Qpt3nYdS4p9eFBIL+Jj+8Ra8ZyxLlC3
         2ylUjW3/Fl+r4M+jjbBYCwCF/zZpMm8Pz57MV/JSkdtOGT1LMUTYKgPaouj6moVXxHYl
         hY91oIT1uuzHZPW87XSqNr+wXUPu/+gsljwaud5Jn+d2SqoU25Td+tCqstTA4OYMCu2J
         Kd27f7tNz/EAKMEALn+pSZHB1MDDUlJEviY3hO8diI/EVCo1pDQ+KJWrYWIA3DMwXV4O
         29S/KNkNmOldhCTHhBujlZncZM9OR3ZowbFV78fMcvSHP42fcn6LGNc/4BCi4bGejhVH
         jddw==
X-Forwarded-Encrypted: i=1; AJvYcCXl/TrYTivFpv47xFqucjoAsvHLbTuzL1E4uah1CdYdqmzrZObijQ17avlpdwlMZg5CKgcSZqb5LEXdFYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNRqEFEMFQQcgng7BkwbcxBiKeTJpYi+vGqXnBPQL6pbd4eB1D
	GPI1sRefATS4e2QLR3qnoUwpRAOBJq3YXD1YH64Xp4wpDFozVQTkhUky
X-Gm-Gg: ASbGnct889N+JYg0PfdkTIux2M+axwSlQW/ICKUn0IzvpRzofxxrNlNp32vP0zcDLa7
	6AFzVHJ6YR340JYzHmp+qdskuEHYaM/Boa2SJUIdH2Nk5jm2CTsqYbT4HySKD7pros6RCIHy6KS
	X0jZp9q80Bwhu4tc4x/CXEWXp/wtZMrTpBQdFzhryjm2dD2zfIVPMHCiHd2zXMRMsnpaOMnEmAt
	r7CBkeFQUpx/G+VA6dCY0cYCiRkLw5lJ0babjktco9V6z0hN6zsd8wXdTrasDkJrHKH6kJmvqRY
	3REwVFFogM1vhXlpGbCZ46E+4jYB/e2t0dyZIq99XqtVxjNhOQL0qqwGcywhZAmXwSriVQDMHrL
	76/wnY4zyqOgObJNk7kJVAim+/Ogc8nuulYGJThdleQXyymodK2Q3V4DGyC7Y7Evb
X-Google-Smtp-Source: AGHT+IEnre8euOUlJN4NOBJZ2nC+Kyrobg6JzCsMbW0vlCirl1sVxwVHvO40Hh8x69PfhvhcPyI0sQ==
X-Received: by 2002:a05:6512:a8e:b0:594:5236:2842 with SMTP id 2adb3069b0e04-5945f146023mr1871274e87.10.1762766124504;
        Mon, 10 Nov 2025 01:15:24 -0800 (PST)
Received: from xeon ([188.163.112.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a0b76f4sm3852006e87.73.2025.11.10.01.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:15:24 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Douglas Anderson <dianders@chromium.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 1/7 RESEND] dt-bindings: display: panel: properly document LG LD070WX3 panel
Date: Mon, 10 Nov 2025 11:14:31 +0200
Message-ID: <20251110091440.5251-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110091440.5251-1-clamor95@gmail.com>
References: <20251110091440.5251-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

LG LD070WX3-SL01 was mistakenly documented as a simple DSI panel, which it
clearly is not. Address this by adding the proper schema for this panel.

There is only one user of this panel binding in the mainline Linux kernel,
which is the Nvidia tablet Tegra Note 7. Its panel is broken anyway since
it cannot initialize properly if the bootloader does not leave a
pre-initialized panel. It also cannot suspend or re-initialize properly,
since no DSI configuration is set and it has a loose regulator which
relies on an always-on property rather than being hooked to the panel
where it belongs.

Tegra Note 7 device tree is adjusted as a part of this series.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../display/panel/lg,ld070wx3-sl01.yaml       | 60 +++++++++++++++++++
 .../display/panel/panel-simple-dsi.yaml       |  2 -
 2 files changed, 60 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,ld070wx3-sl01.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/lg,ld070wx3-sl01.yaml b/Documentation/devicetree/bindings/display/panel/lg,ld070wx3-sl01.yaml
new file mode 100644
index 000000000000..0f0b9079f199
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lg,ld070wx3-sl01.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/lg,ld070wx3-sl01.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LG Corporation 7" WXGA TFT LCD panel
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: lg,ld070wx3-sl01
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  vcc-supply: true
+
+  backlight: true
+  port: true
+
+required:
+  - compatible
+  - vdd-supply
+  - vcc-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "lg,ld070wx3-sl01";
+            reg = <0>;
+
+            vdd-supply = <&vdd_3v3_lcd>;
+            vcc-supply = <&vcc_1v8_lcd>;
+
+            backlight = <&backlight>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index 9b92a05791cc..f9f1e76a810c 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -42,8 +42,6 @@ properties:
       - kingdisplay,kd097d04
         # LG ACX467AKM-7 4.95" 1080×1920 LCD Panel
       - lg,acx467akm-7
-        # LG Corporation 7" WXGA TFT LCD panel
-      - lg,ld070wx3-sl01
         # LG Corporation 5" HD TFT LCD panel
       - lg,lh500wx1-sd03
         # Lincoln LCD197 5" 1080x1920 LCD panel
-- 
2.48.1


