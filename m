Return-Path: <linux-kernel+bounces-855858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8652ABE281C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 981CA4FC15A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF362D9EE0;
	Thu, 16 Oct 2025 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="tY2hlJ90"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3B12DEA6B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608258; cv=none; b=b3eOaVNx8C3PzMaISPsICcNEEzDVPOEkJHlzVZssLzWuEfCApYcLO1HYJXYSbPVXtNN+E1pZQIVrSEJ23Bbq6SYN+/pgON2bHnJxwZNWbcItu8x7SsEmFzeH67K/F1VS69C4RqncNp1AxY0fIah5GcfLX55S7mL5qMG/hoLxZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608258; c=relaxed/simple;
	bh=nPPQHX8eYq9TT6Af1AxBiBYIobQJgeM4uW8BQ25eQ+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iy0zI291pJ9gaYQzJBv30CRBiwsFIVJ4M5zUYTbyDpI0UzAUfLkHjneZp9jLtz7ooymsOQzfnGWMEbzaJdKzNd2LYQnvMCrrxvzcXQMyRWiV/1/SzcF0yoq4+Zurz2TpBTRM/HXYrLE44HQO3A8mM/sdZbTrHymd8MF/3gel4NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=tY2hlJ90; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2698d47e776so4005715ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1760608255; x=1761213055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8lwo5+QtTg4leMDK6YabJ0+AataBKUrh7WnXyXZEVc=;
        b=tY2hlJ90mU1pJsp+Pchl06gnenyCPHf9fS/0mWU2iMqgvmz/Zx8pKMT2kirYAOthHT
         SqeTnub7eAb9DZVbu2NFwBxhmXESYK/KwnFxQZT47IG/dOEVu7h3MKrR9QthcQqYdDdo
         zgQjo8ZhgSEYmZKEQ92MR7mARaiCDx9qYMhjxeYhP5d30iCt+7Mi8GwcRpw3s3DCSiNa
         0CTR3Sux0KWKcrYsp9XcVWGuBeZJFJ/MEJ7yws5aHkmveQ3NXdh3fMbtrXC4b/mvDr/s
         tDfWGqfkX3ACPOXQrAyoNSmyA0i7gewTNt8u+ABGHEkb0/QwbAYf4PIkGOqV1YcuahAk
         8seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760608255; x=1761213055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8lwo5+QtTg4leMDK6YabJ0+AataBKUrh7WnXyXZEVc=;
        b=MuUQlc/PiAOwtyAfKC2Araz94lhApXd6E6ppw39axnJoyg7Z1VPqkU454j6+KLjmPj
         0ALT2UUOZvJem2+ZiepCGj8NUnYUFPfVh40bZ05voQiXqbA94bpwh72N4l7gglyoov9A
         Dk3hsPt/YpicdHxpkbDqxfh7LTXw8R0qZUIIlZz2amPapljmM8O+NE7LlA8ovSf8aqy2
         udzAp3wG4MuXA7wxcVYGs+jVi6QXxIWYVFWQFuoEv3UQ/SwVm+Y7DdUOlrEoy+qNVfIf
         0Gw7tTan0MKkPhaYJ5IElMzkhJDzRzz7gqYrqwbsyLQEP4prTQU0JyzzNwZWaHc1RaaF
         2CIw==
X-Forwarded-Encrypted: i=1; AJvYcCWPDCDrNsM3RtiPVHJS96/y9+/TaLevbBE97PegF9013/36hyZiMSK3qlCZZNLUTxoCUy1sstDHjSghc4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM56EwMYVkVJJfYhlp9tHtXP0zDvYQCa9cJ4o6BCQ2EeCM8yC9
	QN1QKHmzVtLfkLxJk29oeHMta3N1MXvkHpVDZPtjsmMnNJoTnxx4eD4twmRyDlh8bxg=
X-Gm-Gg: ASbGnct+Enjei3LOlUcoWqNLhYXHHBwNgwr4tbFOLJzPsd0W0DzdULta+QyKQo2c3af
	m4uRi1t/Ihr1kkChHl7Y01c9LjLrduuJH/gr4vj2B5o9BwGfpjk9LMwNcEecmeUS6198iTH15XR
	8QDCVqFgYLmz3wmPysoiZ8p6Ktq1AJfAsU9guUNEsTQNuYoG6Ez/h0lqQxfDDM2zEy7Hw22kp8O
	UsESYUVKyA3eGKo8GM9g4ZVJNiwbhqAN+1w+tI1OrwenPSNnz/M3y9BSuj/8/xLOPVQjrnC+HME
	RzrShiomC3WBDOWyI4yZUtgl5uWkczzoL9qcI+JHjPu2Q1dVJAI3nZBB0rE/EbtetMC2QJGLDIz
	3lorpAf4NgatAkagx5i9v7CqNhMVWzGGydPo1l/Ec5zGiF3Ak3DO/uzg6ahX5AiIHHcraNhX9hM
	vf8uqSYE5zMVTUpqbiuEegsIde17Kdx1iQkTEo51yTrtMFxVU=
X-Google-Smtp-Source: AGHT+IE9vLrAwDLQcz+0U3II8DUCaJP2gPK7bJaQpcbKO5SQlykPmukNz62SIYwsb4GaeEmergo5nA==
X-Received: by 2002:a17:903:120c:b0:26c:4085:e3f5 with SMTP id d9443c01a7336-29027391377mr374826855ad.50.1760608255266;
        Thu, 16 Oct 2025 02:50:55 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([103.117.77.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb6519421sm1272402a91.1.2025.10.16.02.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:50:54 -0700 (PDT)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Subject: [PATCH v3 1/2] dt-bindings: display: panel: Add Tianma TL121BVMS07-00 panel
Date: Thu, 16 Oct 2025 17:50:42 +0800
Message-Id: <20251016095043.1694736-2-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251016095043.1694736-1-yelangyan@huaqin.corp-partner.google.com>
References: <20251016095043.1694736-1-yelangyan@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the Tianma TL121BVMS07-00 12.1-inch
MIPI-DSI TFT LCD panel. The panel is based on the Ilitek IL79900A
controller.

Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
---
 .../display/panel/ilitek,il79900a.yaml        | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml
new file mode 100644
index 000000000000..4e3c5afd4584
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,il79900a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek IL79900a based MIPI-DSI panels
+
+maintainers:
+  - Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - tianma,il79900a
+      - const: ilitek,il79900a
+
+  reg: true
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO specifier for the enable pin
+
+  avdd-supply:
+    description: Positive analog voltage supply (AVDD)
+
+  avee-supply:
+    description: Negative analog voltage supply (AVEE)
+
+  pp1800-supply:
+    description: 1.8V logic voltage supply
+
+  backlight: true
+
+required:
+  - compatible
+  - reg
+  - enable-gpios
+  - avdd-supply
+  - avee-supply
+  - pp1800-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "tianma,il79900a", "ilitek,il79900a";
+            reg = <0>;
+            enable-gpios = <&pio 25 0>;
+            avdd-supply = <&reg_avdd>;
+            avee-supply = <&reg_avee>;
+            pp1800-supply = <&reg_pp1800>;
+            backlight = <&backlight>;
+        };
+    };
+
+...
-- 
2.34.1


