Return-Path: <linux-kernel+bounces-777662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B2DB2DC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3997265AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02745303CB0;
	Wed, 20 Aug 2025 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="cNekxlfo"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FD22F49F9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755692734; cv=none; b=UtPWkikqOPqAD33JZhxWdZ+48u+I5mqr7MW7bq44Ias4uHbQiHTNPHF9Ql40/v2OLDsTVHlM3r2nky74pOX7tVIw0nFSSLXPkMTYpWfgKz247+cpm/JS2hk0ugzhj0waK4WTgHEG0CwxsPZ6bXN+jbfWzjkKOlrJA0XLq++hcek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755692734; c=relaxed/simple;
	bh=5y5lyKH1/hkTYyDy0RGC/8IY1XSLp6p75tDi/3+y9J4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qt5vmGB/gGW8S0afbFep9DG3XlA6AuutGJi+YMaLKz6hPLCwRW6OZvcJ0JJfW/kt31yn7zv4UJ+MLel0Mvpyb6vrK7qK9D2dvkGUa3wcNT9qK9PcRWbFbA3y9VJLIQ/k7SZGDYgK7BXI6+u6eRZ8me2IKclNb+oiBpfeShNU4lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=cNekxlfo; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b47173749dbso4385611a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1755692732; x=1756297532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDVo17AEiZBayUfTjsimRdU07RT7bA4wzSPxYn34tGU=;
        b=cNekxlfoGjQnRlP8zrqf36EWkHzcnuKcFs+ekel+UwC+E+zjuwcz8CmFDY+mNLwUKu
         EvvHx690ASh7x+j6STSJR/6wuUvLafIAxt+ANSpRNFJGDc2/zDcI6zgFodDs/hqKQfue
         SJC9pzyZ09rtZ567BJxuGyOQGlwW2uPuqTKZcju2EuPLlqzJt6T/ToxSUhsSigTJA/u1
         wiSKF5RWOR0F40s6LptD7WKbhm61qjOMbtPXnpgIfuMatJshV2kWlMMCktngTKeLKVk7
         AQYEXspP4okU5fkHDRo4LO0fz8TBUp8ndwJCKu12XL3UXmnLJTRW9UCvlnSj31xavztR
         RO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755692732; x=1756297532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDVo17AEiZBayUfTjsimRdU07RT7bA4wzSPxYn34tGU=;
        b=jWp4S8zLNAlpuW9lDDQtRKDw0rVChJojRtgb9Ghm55SWMEKL0ygoMAz4Fusp0TCBQq
         Hn5zxzq4ftlN0ynUh6nwjZR1KgNFYHXFRJtxwbAQJqHgfvnxdGqrnI7diomsWOvRxc2T
         32VvoqixQhtWNz46+d1h1wQ6a2g++FlYB0Gj8BGD/IiOtqx4gls5fGzoDXc5p5TH8Qya
         Zjad3mzRqEtUNJLFC37JiRzuL2qssa0TEmFa/B145a9Os4jHOGWIdwx05iDJrniAfcyY
         IGTztQo5RdW7pgggu6tsDqTIHvvDPSuXTAaD8ji8f8i5L1oBcgDXe3BFX1E4/U01cc7R
         EOiA==
X-Forwarded-Encrypted: i=1; AJvYcCXsnb4CUIqHooWwOTzOTg58g8u1uwR73FvO33flb1N68C82oOXzGSIzdD2vI8M+l1TBAP/wnO/VTogcdao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUa3/Fl5pT//BjtPfyiEzUo83VB7AYwt3jFuHVg6Aj6InaPZuE
	r1pn3e+KZMyk+jzbQJVLd8Zuqy+mGbVlGEIkYerETCzHZjpTKXOEHRzuA9ZSPTBZZ20=
X-Gm-Gg: ASbGncsfxgX6a3k0XRDlucoNn2H4YcRMT1aSP4elatbANgylUirRilp2mmkbGh96c9K
	wbYnBnAadfjIH1KEdHfEgYmnyx/XecmHJQhjSwD0M0OiEu/2LwDsPFyXQPsOgmKl3BCoqbJiEcz
	WledBuNWBsFrhPpfodeY2TSCnyTAFMtFqY+4ILW9XX1IZCA3sFTHUnHCOdjbg323ALPC28kRh5m
	YlUprl8fYMtgQMT+4kP8p9WUs4rgBW5R4+9D6fU6f5Ze4AnpuGLa56iQoc0Slz7cKRfRYC3N/eX
	qodBptWZooBLuubl2q2Qb6L19o3QrDnN88Hq4GVsf6bY7SMQvFpuRPoKm7S8+Fovl/8MgSQ3QaS
	UHNox3AYhvkUfxjoPjHxBdACY8UTuC3vvaGCJO7aQY7YOHlgQJCPG7dWh1roJMEpkjRVHjA==
X-Google-Smtp-Source: AGHT+IEx9O55cYKi9Uh808obEjpVhsZk0ACrWNpbOz63pRgF26JlfxtJTcbiypz4Elqho4hRYYczIw==
X-Received: by 2002:a17:903:1a2f:b0:240:3ef:e17d with SMTP id d9443c01a7336-245ef23b5f4mr32288545ad.40.1755692732392;
        Wed, 20 Aug 2025 05:25:32 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c745dsm25450135ad.73.2025.08.20.05.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 05:25:32 -0700 (PDT)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dianders@chromium.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Subject: [PATCH v2 1/2] dt-bindings: input: Add Parade TC3408 touchscreen controller
Date: Wed, 20 Aug 2025 20:25:19 +0800
Message-Id: <20250820122520.3356738-2-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820122520.3356738-1-yelangyan@huaqin.corp-partner.google.com>
References: <20250820122520.3356738-1-yelangyan@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tc3408 touch screen chip same as Elan eKTH6915 controller
has a reset gpio. The difference is that they have different
post_power_delay_ms.

Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
---
 .../bindings/input/parade,tc3408.yaml         | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/parade,tc3408.yaml

diff --git a/Documentation/devicetree/bindings/input/parade,tc3408.yaml b/Documentation/devicetree/bindings/input/parade,tc3408.yaml
new file mode 100644
index 000000000000..30ffefb96c68
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/parade,tc3408.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/parade,tc3408.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Parade TC3408 touchscreen controller
+
+maintainers:
+  - Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
+
+description: |
+  Parade TC3408 is a touchscreen controller supporting the I2C-HID protocol.
+  It requires a reset GPIO and two power supplies (3.3V and 1.8V).
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+
+properties:
+  compatible:
+    const: parade,tc3408
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  vcc33-supply:
+    description: The 3.3V supply to the touchscreen.
+
+  vccio-supply:
+    description: The 1.8V supply to the touchscreen.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vcc33-supply
+  - vccio-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      touchscreen: touchscreen@24 {
+        compatible = "parade,tc3408";
+        reg = <0x24>;
+
+        interrupt-parent = <&pio>;
+        interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
+
+        reset-gpios = <&pio 126 GPIO_ACTIVE_LOW>;
+        vcc33-supply = <&pp3300_tchscr_x>;
+        vccio-supply = <&pp1800_tchscr_report_disable>;
+      };
+    };
-- 
2.34.1


