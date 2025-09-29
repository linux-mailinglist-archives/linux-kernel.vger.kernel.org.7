Return-Path: <linux-kernel+bounces-836388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 677BFBA98D5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC46189C25A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFF030B516;
	Mon, 29 Sep 2025 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJnclQXG"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68BD309DCF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155923; cv=none; b=Bt3XMf8xfRzTLRoCpXtqE/e5WcMf7t1RSBn0aS3E2Cshtbrduw1ZvWTHZLgMm8G6LA+0/GnBW9ntkfkkc6AfVDLp0fSjRUXbGU+1A2gXfCnO16+PINHk2hb2oWmKo8P7YKUTE3WGBZ80gPwxCpLa1Wwml8b/89T6QIB+Sw9H12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155923; c=relaxed/simple;
	bh=DvadToblCQTcVIF5apzEvP8l/eXojW3y4KnHvhcpa58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqBjwMiqedhSxOYG0EGSanVdRTDgrRJPXkGnVhhBDwAYC8b2hN3T3xOp7+zdp7AWxTZm11s03fvX0hJTy4aYVVNbhDtMyYu2zaWhqNUg1q8Enos4rqrYj7q9y+hBt75VGSEX937AeRyrvj10Dn6ukG12bjdBaTPgbamuWQw3lhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJnclQXG; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3635bd94dadso42121441fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759155920; x=1759760720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSQFvg/0Op4ijZhmcHNRkV3VuLRSkHnJiSZzYGsOKnU=;
        b=OJnclQXGYJKJOy4CUU1BZfCMIDJavOaNWwqUn3zRvvGWqpm5VNwuWfvn6z6RMi8cVQ
         RDt6DM7rOloEXH1RkteIqinwWHlIYw44yWm/TJ79tr5CNd5bnUtU2VCR5We7s73QrkCK
         3GaCoUqKG4Thw0M951QeAs+kY9HMphisyjeG3b0oZHl1d/ALqy6O8AUPOKYQfnQqj6/D
         FR804bdUwYCpifu59PjEkv+ke9e6bU2hhT915A9ofPM/XPJolAFJ0UEdCedjHx3tgflZ
         DIDHqP4c7CDL4gC9AixLXl8Ze58fvgZkkDFtVtjsm5mkBefwx+G1sFUgrWcJKzRE2HE7
         s7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759155920; x=1759760720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSQFvg/0Op4ijZhmcHNRkV3VuLRSkHnJiSZzYGsOKnU=;
        b=pOm03toFxl8OgFKOObUO5cWmwd1wyxC2rdS1FL3HZ6FaPXf6CETYS5ZTbs6plyg9MA
         b4ffGGb7Y8HKsh2WSvPqrtawb5ChWCx+Wf30i+2ST8CckzkdGy1AlHf+SNFmpdCCJJIj
         0+U2Vvy3YzrTVKauRf26xIP/LkCZ1cUcgukDy0PsXWUVNL7mCwzVCYVpFxu+WtPjGPnB
         ahNiWv+2Fs21D/JUloLzD5yE8To0Lgcb0L1oCI2KDPbEO/7Pb9Xpy/3Mj1p4dG+Te2o0
         XyTF7RW2C2lKb4kAJIURGDPz+8x02p4L87Ne1bxRgoJtYJLUiLl014Wtf7VoxfY98jVH
         1Nbg==
X-Forwarded-Encrypted: i=1; AJvYcCWKfwsFZegNpW8CZFQ9n5N+Mmtvm0piS41EP4dVsk4nr/mGg+hj5cyIk6PjQbYRrsXVHEwe/LfRcJrF5XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHKQfFt8CLL/6nCXD+qhJw5EVFZOVhOSnd96FoIF01RUIXpLhj
	O0giDQQWfT3REsOKHNb11VeSykA8NDPprOvp8T2Zz0RguTUVxJH6Tz2Mwpv3Mg==
X-Gm-Gg: ASbGncsD9E5GeegRfoIhViX2Gpu9XuqtvWymLiDtkVsp1taPkrWTReGaprwdwHBpt1u
	8P6bSHd6IDFamygAlh1NrzCIEvoKrZ6AWL0ij2hhSI8naQ+tRlwa/PfFy/LRp2b9ja/ajZmoVC1
	po8c24NShfRMUKq3IsDDaeb/eJx7ehgyP0IqIvbzEkfpGnb+1VDQqeiAzKlD38hzBA3KEs3g6UJ
	8f4uJsBBXpBI6Xrp3Dt1/w8UV+5Pie8HSGD3+cGP0XItxANYEJQ/qqIJWB2lz381WA84IBJ2FUv
	u6QIB8JV3Rqnn+WJmI/jrXUp5pYpRgde6rRdTZHJbIDLYLRnzaJw44ocaA+l1R4DXr1RMWmxdGS
	UElvVwvGSTGQHeg==
X-Google-Smtp-Source: AGHT+IEibrCwJezr+A8wOo2gVwCb6lK72bDzFcB4eV9MZWICPRGwz5lX+FlGpBMGd5346Nlox3jBSw==
X-Received: by 2002:a2e:a10b:0:b0:372:8ca0:15af with SMTP id 38308e7fff4ca-3728ca01b01mr21960021fa.35.1759155919667;
        Mon, 29 Sep 2025 07:25:19 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3728c23e6c1sm13201001fa.52.2025.09.29.07.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:25:19 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
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
Subject: [PATCH v1 1/8] dt-bindings: display: panel: properly document LG LD070WX3 panel
Date: Mon, 29 Sep 2025 17:24:47 +0300
Message-ID: <20250929142455.24883-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250929142455.24883-1-clamor95@gmail.com>
References: <20250929142455.24883-1-clamor95@gmail.com>
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

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/display/panel/lg,ld070wx3.yaml   | 60 +++++++++++++++++++
 .../display/panel/panel-simple-dsi.yaml       |  2 -
 2 files changed, 60 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,ld070wx3.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/lg,ld070wx3.yaml b/Documentation/devicetree/bindings/display/panel/lg,ld070wx3.yaml
new file mode 100644
index 000000000000..0a82cf311452
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lg,ld070wx3.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/lg,ld070wx3.yaml#
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


