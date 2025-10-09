Return-Path: <linux-kernel+bounces-847528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B605DBCB1B2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2273A8202
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD504286D63;
	Thu,  9 Oct 2025 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHXhxRKT"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C92E285061
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049322; cv=none; b=TWVy+zYnz7spZ/wBsTNpLnLdudLE7iIglGGm5dR2oRGbBgIBFdatK/A1WhIinIVf/WYNMyOElVhefF6707zcG1MdNO86JCYi91x1NLl9+N842EnpNPgXRSLroJh6gRQJHGdyP/FziBJdiLSqU7xxmYu5KeSPweS2P+OLk1y+dKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049322; c=relaxed/simple;
	bh=Ma3WiNIHzHgVWvB75ihBb7ddRrXc9o4BCeyvWzcCt/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvGE85hFIbRsfVwpSSVO5qT0JbAnEVAbxuU4+DiWDNGJ9AbxORrrUUaoZYYp9obMHs0jqq4LBr6y9o2l1SNICUkkTrYefj2W8cLTa0W1FSNMPM0BCI7hsyRDmFQFsVEZ+fubBK7vHoQ5Q6o8MluiO6I50MvAjx1Vl0HHuzAP+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHXhxRKT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so225613866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760049318; x=1760654118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAgNJ97KzVAc0b0XAVEvm+MpAppTMVkDqF2/2p9y7xI=;
        b=hHXhxRKTzUT0t1eNOg6m7VkFqqKM9KhCtziRESisvbLJHD4I1NZskZHNJ7UUYoudQT
         Y4Vs9piqylIVx+Jyv43k3iTKl9W5AmINug5yYMhf4avcYx86Vi5b0ZZtCHRfzUCmnUUa
         SZ25X/LWHp/g3sy5x2SpoMTS0rMdNSch3FH9OkpEolrdUa63EfufLnaipzXFGzWiWiI1
         2Adctqo0upEL8AvKvWQ0F07sLD8Yh8YNOWdQp3cnM1p49PxPn9nkIdAbRoZ8IZ8/NibQ
         fO1Kj7jhI5UsVIFqbUjVH6E3LlYK2LQtjSobVsqLA9WVWanuUe0vyDzz3WzZ9kG+vAFn
         zRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760049319; x=1760654119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAgNJ97KzVAc0b0XAVEvm+MpAppTMVkDqF2/2p9y7xI=;
        b=UkzUDnq/u7cCCrGYtpF0FCMOvVRekMK5J4DvGiB2TMmWbgd2k3mwfc2n6icyUAFZV5
         HUE3MN4Cnat3Ohzmoi2NjPhr6E0iBXQMzBekTUHy1tflOS+xfeSmTj58pzapZIlK/NTN
         kH0F5nPxzUuA+ua94V33+92FaeuvxjBrD/3DLa3CPtVtxmJGm8BDDn+8YPso49QRxlB/
         CxyXEPmOawrhLXE+R7UZTD2OpA/inf9U0RBTjDE6seczG+Id6jXFYUX7StPrOR9nBEkB
         spp/0UHZQhYMWPGKbrf+CufGi9KshEXSgElC17H+N5GrqJP7sBgozK4+PZo1+j5c1qJk
         lr3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSbJ3MvPTruRpXhM5l54kvi9yp5eSSaw3vzDt72RhSlJmucf9CfepvjodnxkxaShNXPBSMN7zRE+c1wkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWodBknyHXAJkSFfzI16C4qzoJcNQae0B93DyZ2RopUIMcbW6G
	OtLyGbOvuzxTQWvcyrAO0uJymPCfndbntAiYxUYHbzvCiXjs3DKrsiu/
X-Gm-Gg: ASbGncsF+YwewB12xJeYCX5/hYFJdru4NGed72LcMc/lkXRJSX2rljkXcCBOHcd4d9k
	4VSe8asKUCwVLk/Bp4G1CcJ2lMFNmL1F5234h5gh8w9BISqqmEtUULknTRKy97WByoAQC7BPbW5
	kynjPMP2/xmyu/wGb3FfflmVRftKlkMAjkNrrOD+mjy8+jrVx72NldAKD3SB2R6JV5NbGVS00mH
	roAr8HqtBku7JrAXGIauN3ZAjgWd7P2I3QRl4937CAHJGeo6fywUqXU8Ncp/2Fl2cscOxoCzTng
	0CqlISTiVvCmFYp776Qy2qxcxRRZW4tu3ilWQT37mzqlKKk8Lh6LvISJz7h+WWHnTkkA2goEDng
	qisKPgY/AU+q5Gq31LmZ1L16dsr8diBTibou2LhC2653ZWFz0qg==
X-Google-Smtp-Source: AGHT+IHoJj/Q+zlkewAtr1USEimUUg4SieqlDfunBq89n6GPaMjS3S5NJYnL6Jp2xNHUqKpGw2WnLQ==
X-Received: by 2002:a17:907:d1c:b0:b2d:d7ba:8e7b with SMTP id a640c23a62f3a-b50aaa9ea3dmr976779366b.23.1760049318401;
        Thu, 09 Oct 2025 15:35:18 -0700 (PDT)
Received: from builder.. ([2001:9e8:f121:c116:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cad80bsm74383766b.16.2025.10.09.15.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 15:35:18 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [RFC PATCH v1 1/2] dt-bindings: gpio: add gpio-split controller
Date: Thu,  9 Oct 2025 22:35:00 +0000
Message-ID: <20251009223501.570949-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251009223501.570949-1-jelonek.jonas@gmail.com>
References: <20251009223501.570949-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dt-schema for a virtual gpio-split controller which exposes virtual
GPIOs for a shared GPIO controlled by a multiplexer, e.g. a gpio-mux.

The gpio-split controller is a gpio-controller, thus has mostly the same
semantics. However, it requires a mux-control to be specified upon which
it will operate.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 .../devicetree/bindings/gpio/gpio-split.yaml  | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-split.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-split.yaml b/Documentation/devicetree/bindings/gpio/gpio-split.yaml
new file mode 100644
index 000000000000..9a58c81da4fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-split.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/gpio-split.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO split
+
+maintainers:
+  - Jonas Jelonek <jelonek.jonas@gmail.com>
+
+description:
+  A virtual GPIO controller to provide virtual GPIOs backed by a single real
+  GPIO and a multiplexer. This controller may be used in case a real GPIO is
+  connected to multiple inputs/outputs and controlled by a multiplexer, and
+  another subsystem/driver is not able to work with multiplexer subsystem.
+
+properties:
+  compatible:
+    const: gpio-split
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-line-names: true
+
+  mux-controls:
+    maxItems: 1
+
+  ngpios: false
+
+  shared-gpio:
+    description:
+      GPIO that is shared by the virtual GPIOs and controlled via the mux.
+
+required:
+  - compatible
+  - gpio-controller
+  - mux-controls
+  - shared-gpio
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/mux/mux.h>
+
+    sfp_gpio_mux: gpio-mux {
+        compatible = "gpio-mux";
+        mux-gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>,
+                    <&gpio0 14 GPIO_ACTIVE_HIGH>;
+        #mux-control-cells = <0>;
+        idle-state = <MUX_IDLE_AS_IS>;
+    };
+
+    sfp1_gpio: sfp-gpio-1 {
+        compatible = "gpio-split";
+        gpio-controller;
+        #gpio-cells = <2>;
+
+        mux-controls = <&sfp_gpio_mux>;
+        shared-gpio = <&gpio0 19 GPIO_ACTIVE_HIGH>;
+
+        gpio-line-names = "SFP1_LOS", "SFP1_MOD_ABS", "SFP1_TX_FAULT";
+        gpio-0 {
+            mux-state = <0>;
+        };
+        gpio-1 {
+            mux-state = <1>;
+        };
+        gpio-2 {
+            mux-state = <3>;
+        };
+    };
-- 
2.48.1


