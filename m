Return-Path: <linux-kernel+bounces-894725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A62C4BB12
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03E604E79DE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D143C2DAFB9;
	Tue, 11 Nov 2025 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pegatron-corp-partner-google-com.20230601.gappssmtp.com header.i=@pegatron-corp-partner-google-com.20230601.gappssmtp.com header.b="KUE6pxN/"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512062DAFB0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843151; cv=none; b=N6A2kN0d9eNfsU1ZxSGNnFGCW/1Qr3AqN+bN+Xk1I3DrFqwpMcn/plcvtZEhLaozDDey6myP2S2R4KeUigwvefBsQmyjslhcF0xMNCJ8Cz0gO4uOru18MhxefypubXrg0WcLgydRjr0nJ0a2VlbMKGdImJYir0Tzyj9IrEXHdgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843151; c=relaxed/simple;
	bh=76ABllftNutziPZMfTsAUOfZ4NSqPsrwSGo7hCu81bQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W4R+nE1WLMw4WjFXsJGaPVzdgxD1logEeHix6tT62YCFyhYiVo77I4Qgtlqh/N3O0strusHINaShGe3umdtifzfMsT/Vhy/YnKZyiyzI2EYT5LTJrM6I0Mu+kfnnNeJ8CXVZGge/J39GwGRZsCL27rDlGXwe1YxUVj5TuvKrLhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pegatron.corp-partner.google.com; spf=pass smtp.mailfrom=pegatron.corp-partner.google.com; dkim=pass (2048-bit key) header.d=pegatron-corp-partner-google-com.20230601.gappssmtp.com header.i=@pegatron-corp-partner-google-com.20230601.gappssmtp.com header.b=KUE6pxN/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pegatron.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pegatron.corp-partner.google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34372216275so3140077a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pegatron-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1762843148; x=1763447948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0TxzvcO8Ijul3ALJ59ZtrQlKnZ0E0zof1tiecvpAdh0=;
        b=KUE6pxN/2usja5SEEKiQl6lYp4Fpb96ubwL9vmzDOsrK+mMCLhpvEdaB4q4NLcYIVn
         lPZ+2K56pZ5uF/Djrg2BNaeolH4g9ZIjUZHJN2/SGoAv35yt8hnaVjMkCIR+zWk2mqtx
         ZATxB/jeijnrQtCimMBkqPKhi5AFad6Q7kSdl+54BgmI/QtOAe/1d0TcL18bE2W96bRv
         gm4wDUdmHLNiDYXKNkyUJBHUwder/JQuwQMq15FKi0UZDHfS8IjUFHTBgs7daEV6j/wM
         X1WLjgIOKpt5qYnZjJ4GIVFxBBKbXPGayz0HYfV9N/php1w0YB47lkhhsnkJjFv2veSM
         lTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762843148; x=1763447948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TxzvcO8Ijul3ALJ59ZtrQlKnZ0E0zof1tiecvpAdh0=;
        b=T8StYLunJbQGv/1FLHzV/MUzn87ICSOReLqIsNbq85D/O8xwoMV3oSkOCa0zO2kn8K
         OQPXXIiADrwJbSkcMH8ZsDPzdhsHSdcuiahbgydrUhfuTA+UgAN19bGDa3axdFfZo+2o
         E0JWhhL1dMvFms6U6bi8WpR63613KfMFRrPvy503NQlSL4Op4PKecZcym4eiKSgwDjG5
         QLJ1hBgAYgPw11XtmaYciokEbKru9TJqGvB+8CB+MTISw+MahrFxAJquej5vPGLfOWe2
         Ac18kTUfjBbpm8LV9K6QKqjJqasCCDXxoQuXGExUtZoZGmC0kVX+s8O9Pegk1u6SmIfN
         FmkQ==
X-Gm-Message-State: AOJu0YyubcygrNEJVt+YLT6evCOPWL+cJ1CnLXgjnIijUOqcuXLxz5ys
	fh3MivAoRVJf+JCqICkslwjaE9kBlHjLwMZpYK4oMMwp/Sv8si86XNGk4Jmz8uXI2Q==
X-Gm-Gg: ASbGnctMs9SsrYZ0CCeLV0OAp4PWXtfoqgXNERszLi8dl8/lRiMrhxTd67uHKyMHXmb
	ElLmomq1vlIrNKAECvUcW3Zc80XUcbLpPDXy52pymuoH44yUQehaYD12w+czW/zntuf7PVq3Rtv
	aeGp/Ej89TeELk00EP613u6lmwQ4BS8xPNeoqzKHYwrLZkym2DPlDPDZ9oVxXPTaJgOKzJgs+z4
	nD5LY1nw7z63kqJyWPrjGMPrwHHm5o6zdxzW4l1SOkmtRrRzsFqdoXCOdXKSqsF0c4cCwqn6in9
	/dGl9S2vzEJkMy+CLI6Of4pf+d5LpiVm1o5SlgdO4fZtg2s5ktYIklqdmsgXAwuclnSObsffdLR
	Jf82hKPCUc3dFILAVvaM0ecH/Rb0cSg1Nnj5unvwfqaFUbx8tBrPj9PDEgGfdKkSlOw6Bt9AgEX
	qe3Bm+QbIdzOU+7qP5ww2RzyaOdMeaEDrgeCRhxR3ehBS6CXlQkH9w997GE52zDYa9AS42xZeLi
	uD90eBpIrkWlokU9TDOb9H3GUKIHbcjZUbtfM7nHaJNHa+qOnDc283w4DmIQna4K5lbGBg=
X-Google-Smtp-Source: AGHT+IG5KqPahXbbmibL5vikOZZx0fOqdq9+WZQW+1be30DeSfCc7ofE7W/ExoFor7vmsaV/es1lpA==
X-Received: by 2002:a17:90b:4a4d:b0:340:dd2c:a3d9 with SMTP id 98e67ed59e1d1-3436cb29cafmr17037940a91.12.1762843148630;
        Mon, 10 Nov 2025 22:39:08 -0800 (PST)
Received: from sw-TUF-Gaming-FX505GU-FX505GU.. (2001-b400-e2ac-65d6-f177-1588-49fc-6b55.emome-ip6.hinet.net. [2001:b400:e2ac:65d6:f177:1588:49fc:6b55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f9ed1e73sm15237243a12.12.2025.11.10.22.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 22:39:08 -0800 (PST)
From: daniel_peng@pegatron.corp-partner.google.com
X-Google-Original-From: Daniel_Peng@pegatron.corp-partner.google.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: input: i2c-hid: Introduce FocalTech FT8112
Date: Tue, 11 Nov 2025 14:38:59 +0800
Message-Id: <20251111143853.1.I76ee34ac45e1469dbeb11de0d1e47d794af7dc88@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>

The FocalTech FT8112 touch screen chip same as Ilitek ili2901 controller
has a reset gpio. The difference is that they have different
post_gpio_reset_on_delay_ms.
FocalTech FT8112 also uses 3.3V power supply.

Signed-off-by: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>
---

 .../bindings/input/focaltech,ft8112.yaml      | 66 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/focaltech,ft8112.yaml

diff --git a/Documentation/devicetree/bindings/input/focaltech,ft8112.yaml b/Documentation/devicetree/bindings/input/focaltech,ft8112.yaml
new file mode 100644
index 000000000000..114288787c98
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/focaltech,ft8112.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/focaltech,ft8112.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: FocalTech FT8112 touchscreen controller
+
+maintainers:
+  - Dmitry Torokhov <dmitry.torokhov@gmail.com>
+
+description:
+  Supports the FocalTech FT8112 touchscreen controller.
+  This touchscreen controller uses the i2c-hid protocol with a reset GPIO.
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+
+properties:
+  compatible:
+    enum:
+      - focaltech,ft8112
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  panel: true
+
+  reset-gpios:
+    maxItems: 1
+
+  vcc33-supply: true
+
+  vccio-supply: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vcc33-supply
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
+      touchscreen@38 {
+        compatible = "focaltech,ft8112";
+        reg = <0x38>;
+
+        interrupt-parent = <&pio>;
+        interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
+
+        reset-gpios = <&pio 126 GPIO_ACTIVE_LOW>;
+        vcc33-supply = <&pp3300_tchscr_x>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ddecf1ef3bed..69f54515fe98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12326,6 +12326,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
 F:	Documentation/devicetree/bindings/input/
 F:	Documentation/devicetree/bindings/serio/
 F:	Documentation/input/
+F:	drivers/hid/
 F:	drivers/input/
 F:	include/dt-bindings/input/
 F:	include/linux/gameport.h
-- 
2.34.1


