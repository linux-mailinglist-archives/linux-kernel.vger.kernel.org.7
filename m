Return-Path: <linux-kernel+bounces-849984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3367ABD189D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 926B94EAC77
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FF62DFF12;
	Mon, 13 Oct 2025 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgPzDZ3H"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EAA2DEA7B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334977; cv=none; b=T4B/QoXHs3oOL0fbc6zhTBzK0aVam6XHJildck7+jaAGv9iXZEfeOT2EHQ6iY4I+kt1eK70apMbB9sUeK+82ZCt25wGCgXpWEbFYoq6j5fRDfgCgbxLD/A/ZkYzMU1ZAgAm4GuD6FfiOoZ4hgwnqlFOYShUFWh/vR4DPBXtRO/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334977; c=relaxed/simple;
	bh=M+TtnNRlKxmwNkWjOrflCvsVUhdbfnUnfwwEyraGfY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHCuCi5Cu2u2LgC9TMFGZAxpIv1v3dVRLnS7wjAeGAoir4nLJdPk7IK3OdQ7/ysDqnG4XbjxqGnAngBz/pPdby/5h3vOeDJRL40i/OM5DyTY5QhVqOJfgsJXQPUfCSkAsTFqpg3uuTZslOdf7+e2FAa/xo5U3w/+kShEMAAEOJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgPzDZ3H; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-639102bba31so7903863a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760334974; x=1760939774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmVeYmdQG39CjbFRBoggArBt69tBLOMtXANeqHPySaA=;
        b=mgPzDZ3HAHGC3lbyh6ymSMn5R0mryNTIn4t1Qy6W2C5mxbuZrnX0vhriVhGhknCDW5
         J9d8mehe4BLjWtry5jX+U3GVX4uNn6K4Uo2VO9NvXphqOAsdZgF90nhIYsJCjgtkwECF
         U+v9S7YDKfixfh2zPttXx+rLyzChxLMWM227TCFqj+b+y+knkDbGH2Hfe+j+jZguBzfC
         W7XbEB7UBBJBg8sRqwHagWQked6xqld7RdK+e1X6mSU9cT7JRF1oeaUu1ZG9N6qPAxDH
         9EBrPAwcOYwYc6OC3NOu5IqAlnb7JKoIXfYPu+9kJHSZmfblpmXJQaswP4amq1wwD1do
         LuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334974; x=1760939774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmVeYmdQG39CjbFRBoggArBt69tBLOMtXANeqHPySaA=;
        b=SoDckPJGgDturxh1P5mtQrjPa5iVltsQQ651Ib75nltbx/eb5WGB3OSlxsc54R5lp9
         LVvUAtbpmj3SeQShfHaLOK5tQDd4pSzyOBHUKIa1GrDUXTW9Urq5T0d1E15BF9N78gs9
         5WR8UA9+b3nngHEMHEs3QSWtZxNSIlVjWPjfyk9YJoPidg+aif8SxQSBWdayUtNwaV7z
         +tvKmFH1XWuTqowN0r7+kZMtaJ7p+rt2Q85V84Xiz7RZx+7cSUWvf8DXE6PVJh/wtVEZ
         byG7gGCiYShQegvJMzj9MrZwv7J5hR2mXTe3UytUreMTYggpzf7ZuafmnK0DsNdwBH2N
         H25g==
X-Forwarded-Encrypted: i=1; AJvYcCWluT64GOSORyEy5+Q7zdzQqmjD6mhOAFcvfp2bYAE9KfL+N373prCYUzn5Dp+Ssip2S58FtKGg8e3l7dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyObLnj5fOOZM+BiRxH1hVYLtiUyjMJwdEtaRrl2AH1rwa0Dwg2
	DAgr8Kj8gO/qC4aGHc7bbIdAeOCxdIU8imub4iczedc+n0jdGoVSgh4p
X-Gm-Gg: ASbGnctTzqwBBPCZcvqS4q3stxPYpb+qXWpqXSLkfOU50q79847bKKW6j+BPY6uh4bI
	Cj8lKuSgUJnSN5hA7O1V+HIL9002XNn8gKx7cLSpdybDWJilz9lxI5vFmnvMNZC87fO5wxJWx+m
	/oqx+JS2xZcAG9yKatYo2dts3d0F7/f9AmWV0wnTJvEkfijiTMTuWHKZYNE089EDowWnij8rPVX
	x5FT7g+JUtW0uoUFHvZEWIz+Xh4VJi6SN5dha8ad4+Bp6U7gndynVxjA/8s1gZTf7Y++d8WzWV2
	iq8o6svEMbRVgNWoCrUhFLznFPqaRBOgSl/EMShY6OsWguLUpJ8utcawTd7kUB3RcpUcD66cOvv
	lny4xs1FvCwbtG2iAJbZAUPlAjIRahEkISUHcNpu7Htk=
X-Google-Smtp-Source: AGHT+IH2c+24CivWPPJ/ldu3md2RU+buuXCl55Yc9ObghGW9GfGlOejHYQ5h1JhatOPelTBivJjgCA==
X-Received: by 2002:a17:907:5c8:b0:b40:b6a9:f70f with SMTP id a640c23a62f3a-b50a9c5b352mr2011241866b.4.1760334973858;
        Sun, 12 Oct 2025 22:56:13 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d63c9a3csm860912566b.23.2025.10.12.22.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:56:13 -0700 (PDT)
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
Subject: [PATCH v3 1/7] dt-bindings: display: panel: properly document LG LD070WX3 panel
Date: Mon, 13 Oct 2025 08:55:36 +0300
Message-ID: <20251013055543.43185-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013055543.43185-1-clamor95@gmail.com>
References: <20251013055543.43185-1-clamor95@gmail.com>
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


