Return-Path: <linux-kernel+bounces-816134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C149CB56FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92173B9382
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 06:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C47278E5D;
	Mon, 15 Sep 2025 06:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4Ieyqrl"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE74207A38
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757916124; cv=none; b=PB+G/c+fJ3jRe5fnBj3yfWJ0tGZ88OoSn5io0idj1kE0eHt7WWYxr0XjmlWm0Fd0xn7bi1FzWRfy5FZDrFcC7YJRZuWMIT1nFCicDe4eplYZgzAQ8yR55lSjIPgi2yDzP3WO5rnITObVCbdddRRm9E3WQRnZhX20Un6zr+6NaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757916124; c=relaxed/simple;
	bh=H86OdhgTHF+sXtUDW7aUQJv0MWH5MWu/K9PkO+/x6d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2RTrEThwrSD0OFT5MtIcaO6rdKCYp/Cv1DlNCmUHiSPS/MHZdgOcFxH38KwQzh00qRB83Gv2KcLgmn1F7iWOEWlyCltqb0wSYRTQozGYeq/ZraDWpK+x5zi4/XPLfGKcuBQFb+nWMJAK/6eXPqUtiJ4yjXEiGllsHmxjEvgsAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4Ieyqrl; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f72452a8eso4402512e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 23:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757916121; x=1758520921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GAzaDQKIDLrSVL1wcySzyvMJnY8KNZJxvSnSoEULDg=;
        b=H4IeyqrlEP1w9hYzZpidqEX0G58A4F45FJWvMaaKXeTHIoAurn6qEprL0dh4Qh1wb3
         Tdco/8EvWBKMJfPGm+b09OCeSyN+D7sDvLlB7bU38XqkkWATlM5rRCM3xHKPc5ClBa5E
         SXiavKNbHMAXcScYqhJdpdLZMztSnttor9ut+8VFUJxOVDYx+8BFE1crZsJ0lxG00CEm
         zJ7oZfYwiCHLg6EvZIV4WOjFGm3TFrB6jTlfAFOgwkc8mGa8vhO4rsp8+SAve7BC2bbE
         K3oHQy0QLMrD6tN/q6rpzqHyIBclI6sq50VX4orayK3Nvli9clMI1SMV5fRhUsvubVfd
         2LkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757916121; x=1758520921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GAzaDQKIDLrSVL1wcySzyvMJnY8KNZJxvSnSoEULDg=;
        b=VM+SYkkdnMqJQAOgOoNAEDNHV+C3pLR0CCUWE8JB+1h46itEUWmJJpoy8sIKZmcM/r
         FqMyPqWxcheFWVzVUskuwlxK8ND7BvZ0zeDDmoiK2aNaqD0iaWxsP9f/bBewpaEFyp/T
         CsO8w69R+HxXXkA23bMj13K1RXMwgFYH6AlACBItrtCt2IcZgM9kxj+jm+WzX0g07Y4R
         QnlYXtw94wy09wxH63r9C3+CnrORIrL4qytM9UTsCAROyJ8n+tu8YiDU5VKMTjl7V8AM
         9f9CJDax4FWApCzD/Ws3E5Hmvgcp8qDdylFnHOK+zkqJqGVPP0LasrskvtqPlEhfx2yt
         OjNw==
X-Forwarded-Encrypted: i=1; AJvYcCVwFOmKmtMeoVFy+pihstR4sXBucAaryTsTJ5I2Jxs7R0rApGRUYhEy6zKHAuXqoqybVsFnMHxJwjtvGgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznp62anz05GpRAkCCiuVRpSvahx1KTV6hb9LKSEihCpnS2g2b1
	n+VfO/ue1IVg19mfYoVpAriTD5i5Nf4bPLNlRR+8rlD0wut0dM2j8QCT
X-Gm-Gg: ASbGncspash8CCB5iqkwjXlfq3RC/C4e7KQqNlIBZdO9+gz6hP4jB9ysPQydyzsX/bK
	hchgmnRHqa5WftJBGPXCirUeJooDMs2ixiW8qlOBOFC/YA9FuW9NkkudUTQlqqlL840YpcQxs/o
	fUg7pPIADko381vpTWe2maOnBNQ2SUskJufz5jBRy2dKWJVEaedWf3NP4SoABRE0e3I2ONI8S06
	WOkwQiyy4Xc/F0wDuaJb+3FND+FuxlNbS2OEPEm7TRaDT1XbO3es/AQEZt5nwtTmU2Dx0s4EuHi
	yAjXV1taVdhfVSeQicS5M/TBIxyeYCMP4MkiI/Fgj4Koovp3PmhC5dJ42cmWuRjajUYe+KfSHR0
	4xsAAg0k2b08XXQ==
X-Google-Smtp-Source: AGHT+IH/1syhnxH2MgON3fBQYZRWQzr7rl4FW7/6FJ9ZvlyxiPfGztFWjjW5t/Xc1eUHZDZ7Yq0H2Q==
X-Received: by 2002:a05:6512:32c6:b0:55f:5245:d695 with SMTP id 2adb3069b0e04-57048bea410mr3293682e87.10.1757916120363;
        Sun, 14 Sep 2025 23:02:00 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571d16e79d0sm2062214e87.86.2025.09.14.23.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 23:02:00 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Rosin <peda@axentia.se>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: i2c: Document GPIO detected hot-plugged I2C bus
Date: Mon, 15 Sep 2025 09:01:37 +0300
Message-ID: <20250915060141.12540-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915060141.12540-1-clamor95@gmail.com>
References: <20250915060141.12540-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Schema describes hardware configuration that uses a GPIO signal to
determine the bus's presence and state, allowing the system to dynamically
configure I2C devices as they are plugged in or removed.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/i2c/i2c-hotplug-gpio.yaml        | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hotplug-gpio.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-hotplug-gpio.yaml b/Documentation/devicetree/bindings/i2c/i2c-hotplug-gpio.yaml
new file mode 100644
index 000000000000..d1d5d830c91b
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-hotplug-gpio.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/i2c-hotplug-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO detected hot-plugged I2C bus
+
+maintainers:
+  - Michał Mirosław <mirq-linux@rere.qmqm.pl>
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description: An I2C bus, where some devices on the bus are hot-pluggable
+  and their presence is indicated by GPIO line.
+
+properties:
+  compatible:
+    const: i2c-hotplug-gpio
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  interrupts:
+    maxItems: 1
+
+  detect-gpios:
+    description: usually the same GPIO used as an interrupt. In the active
+      state should indicate that detachable devices are plugged in.
+    maxItems: 1
+
+  i2c-parent:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#size-cells'
+  - interrupts
+  - detect-gpios
+  - i2c-parent
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c-dock {
+        compatible = "i2c-hotplug-gpio";
+
+        interrupt-parent = <&gpio>;
+        interrupts = <164 IRQ_TYPE_EDGE_BOTH>;
+
+        detect-gpios = <&gpio 164 GPIO_ACTIVE_LOW>;
+
+        i2c-parent = <&gen2_i2c>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
+...
-- 
2.48.1


