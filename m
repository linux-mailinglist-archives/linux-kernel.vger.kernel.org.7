Return-Path: <linux-kernel+bounces-774823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BD8B2B7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181B2525420
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F4F28399;
	Tue, 19 Aug 2025 03:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="2QMhgPc+"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4E6244679
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755575346; cv=none; b=YceTgqB0f87TA6xS8LDDZDenJtbe/DLZuNUYZwVFkAZ51UNS/emBWFPNW3rMw+4RSQTyaR//WoFbLVwe2uCLH4T5fXL5kQLWJBPawBgd24sUDS2CsaMU6ECurWeCc6jXImlVhzlpVSD+cSPzS9ATPBjrK3363HLTH5OF8LfMtyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755575346; c=relaxed/simple;
	bh=oUU4w3N/b3eU5F8XoiwyNGw0ZTdvLyGDFBe3ntBtKIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TYmwruwnuKFi32VHOzef1ldzUFn7+4pA6fgru9N0clqlTIhJ3SGLfsZep/rclLRb527l74CaYfhTVDv2Td+XqtnWo3XfBQzK9V3/O77uCXFUXYy7LKUS6cGk2sZXeMaLaDqUVP62FVgvqkoGkhpAFQ1AeYxUnPq+r7gzRN55FDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=2QMhgPc+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4018882b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1755575344; x=1756180144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UD/t2s//ukt2draDKRuWX0oXSSFuAR39g30E2DEs+Ko=;
        b=2QMhgPc+zuauRSb/Lv651NpPlDTYMmZyvxU0OSQtbegJRD3mQmGxbHekgNy3+ntPJi
         cPR2upgO4UtXwgLpPft3ZR3FipXjD8El8Nf5OeenyF9h1SqqPf3SYHTWysOyLOSkbOhc
         lDV2AyYc7qb4Ha0WSk4DtF9ERi499zMFlp6L9hPNE9SdrQNx+u0Z7En37+2VcZXsTjzA
         T2Vl1rtXZsXxem8+2dA4mIF8CSIlOHJ3KplgRRqyS3199JU2A4ecDcfHY01BREgEGlJI
         ZCxCGDX0LaUXcGTdpQQeu6YnfVzZ+mMuBseA1Jtn/xpVGvqaf2RyA3NIViUaxJ/YjxoH
         oySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755575344; x=1756180144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UD/t2s//ukt2draDKRuWX0oXSSFuAR39g30E2DEs+Ko=;
        b=DrQwcr6+wDv0X0AvLZIBqx7H/B05DLDLc16ql5DL6wh8O8C+OiRYveFngLlk91hAUr
         0Sm0mrC1tfdrPElH/Th5xlPp6olyqwV9W+bB9FnPByRPbg3YZRBSZzLMsx4qCx1jgjcH
         zqhygTvxe8lEj4rK0um+S+NYwmcz8QFhM3F4Dq2Mp0GUrgDNomPU4MzGe+Zz66Fi77Ga
         CLGC6m9u0mDI0FPd/gqS4D+iRRrSJoE+AXd3Sv/UHMXwWPQql7tbR3k2DQN3czg14kb5
         NH9Hll4p1DPv72m9ZGJQKDjnFdN6CtOnc7acchqfST0i9CfZrxQnMVSZ/9E+uGeJkSrO
         PWcg==
X-Forwarded-Encrypted: i=1; AJvYcCXQHqd48Vm1M8t/5F3yaDx32vrBjmNY5FDNoZXfiJlikBSQIQ+fHNnUrDncFfiqJRbiYimYbiYTB2RPDeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2gnjJVgKO1tOTI3bxzK1y+smizGGLIHCkFg7XsYSLw072aIva
	l4+YSr8pGV2Pj92ivCJbJhDmNM9YKnFm+4tBvUsuDWrBZKq0CYBaw9xiFHx5zvyr/GU=
X-Gm-Gg: ASbGncv0gmoWSEAnMQ7cmXIiE9RkwK+xhIAlV8SWvk0CF/AqFUlz9zMsDfOBml1yv+h
	dd3DDrpk2Olw56nPWz3rnjMANmOMcCs8hfbV+kUOnvP0+5FagA/2QFcylhyLspEiHvgcv3vgN4C
	YIX9S+jfsHNDBKFsQgMAZgVYKZ3ZH9epnlOpP+jlQ7DytjVzeux+tCW6Y7ein+B8mIZwhc3qY73
	KvhqtDDZrzh60SdCem2uUHcym3KZ/thIXCWWKSvYdYoMEnRiQx5uN1VFA0ouxYHvugRgrNm//5U
	DKVROCnl+F2XyA2npery0YLWwTAqBI/sjolLxrZUVDabSPxUqJUoZUWRM15eZZpErc6TDsh51b+
	meit9hA8bJXguM6+fOPiWCCk4aNWwxdB2V7odOHq12HOjWk12h4QfK7HNyCh43O0lo92C2Q==
X-Google-Smtp-Source: AGHT+IEhmZ4SllY3Wag/Jp8a1Uo3rRiFgjISpJsWH6Z2XbRIMRHfSJamZAM9PfGwGGrCH+ivpoZ8HA==
X-Received: by 2002:a05:6a00:174b:b0:755:93be:40fd with SMTP id d2e1a72fcca58-76e81927792mr1055932b3a.2.1755575343861;
        Mon, 18 Aug 2025 20:49:03 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e8538edb8sm28953b3a.67.2025.08.18.20.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 20:49:03 -0700 (PDT)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	dianders@chromium.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Subject: [PATCH v1 1/2] dt-bindings: HID: i2c-hid: parade: Introduce bindings for Parade tc3408
Date: Tue, 19 Aug 2025 11:48:51 +0800
Message-Id: <20250819034852.1230264-2-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819034852.1230264-1-yelangyan@huaqin.corp-partner.google.com>
References: <20250819034852.1230264-1-yelangyan@huaqin.corp-partner.google.com>
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
 .../bindings/input/parade,tc3408.yaml         | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/parade,tc3408.yaml

diff --git a/Documentation/devicetree/bindings/input/parade,tc3408.yaml b/Documentation/devicetree/bindings/input/parade,tc3408.yaml
new file mode 100644
index 000000000000..25db85e90b18
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/parade,tc3408.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/parade,tc3408.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Parade tc3408 touchscreen controller
+
+maintainers:
+  - Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
+
+description:
+  Supports the Parade tc3408 touchscreen controller.
+  This touchscreen controller uses the i2c-hid protocol with a reset GPIO.
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+
+properties:
+  compatible:
+    const: parade,tc3408
+
+  reg:
+    const: 0x24
+
+  interrupts:
+    maxItems: 1
+
+  panel: true
+
+  reset-gpios:
+    maxItems: 1
+    description: Reset GPIO.
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
+  - panel
+  - vcc33-supply
+  - vccio-supply
+
+additionalProperties: false
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
+        panel = <&panel>;
+        reset-gpios = <&pio 126 GPIO_ACTIVE_LOW>;
+        vcc33-supply = <&pp3300_tchscr_x>;
+        vccio-supply = <&pp1800_tchscr_report_disable>;
+      };
+    };
-- 
2.34.1


