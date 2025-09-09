Return-Path: <linux-kernel+bounces-808669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C61B5033E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E04517AF9F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCE735AAA8;
	Tue,  9 Sep 2025 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLPxo9J7"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D341135336F;
	Tue,  9 Sep 2025 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436799; cv=none; b=A3Qf4FEPfUFZLW4NdVCWUx3jgUJE8d5BNQVr/BE5axrMhGDqPnllVJcTPH7ao1tYCDR8T4NAVKYJcoicnT4zFlOcghxD0juodnMRIPCHJFLQj4CsSLrFiHZlVdExPyKQPbPk6eAlZfNtCIKOTqjTBvN2g0u+Bm4bNoVKIG39mwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436799; c=relaxed/simple;
	bh=HCCjD6YjsAHEKZx/rtQO9mzRxNlQd1YVX0+oejbMm+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TGDS/ayaY4VV0WN4Tj/7mDCVHQRX046Z+AmheOX47bfQdaD3ajemNTC+TyMWV5OWgLtN2mi1EW8sgE81HM861FkjmsEDt5XxWIDvbpbHVesCnjo0vMndHjTZGUuGaI81ydvvsu+fnE1dvM/8lqB5escBBrE4s2xihyPvdFy3Nvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLPxo9J7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b9853e630so54142855e9.0;
        Tue, 09 Sep 2025 09:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757436796; x=1758041596; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p94vhBpn6I1H1gadXz17+U2dyfmeO5CYxkWEWa6pquY=;
        b=lLPxo9J7027/FZfBQU0h6ksGDlFu36NucEoFrrICxot3ZiJ6ZuujMH1cQaoGcepeJN
         rk06z/see/MbGiImMqXRTjtR/4U1GCNJ/u4ifcUi9Vc7Ze9VgIdSdAuzFbD3W0Qutudp
         RWMs+yNt3XX9mBR0hPStxgVmhGrlfVCqRKFl6JT//Zyxtb1M8kRmXO5jZc3z09pjLRzc
         fTy2eSG57aKvXcah8DDtBb/PdosDp/ndC+HsYoXx2T+P+ObkA36kFtusAc2p+mW44+D6
         qJM0gGpbzYMFz7tWKSIh3+oJj0z/ADFoTDQbdatPpEvwUlJAcMC2ZSwE6HPvRJ5kN2yh
         K2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436796; x=1758041596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p94vhBpn6I1H1gadXz17+U2dyfmeO5CYxkWEWa6pquY=;
        b=RWwU1UULrUfvz5g/20xIfT39yjcDEM2GDayYDLAnc6AGW6hU334a0XPHgCtdk7/eGz
         QX5VhlXF7dJlqKBnm4ij5IsVvctg9cbNgWgty02jwrC0FhthsGFD/518bQyS1110hK7D
         0xkxVpoKLyk1KqyzmS64Q64b4i+M3wlmJpEbSfdfn1nJ+ORiM3ikFwlsl++4jkC0Lkf9
         1uFhs4+xWs/DtVIYYNF1koDVG/PnuFq9kY4fPmbsBCfjq8su+GUTLEX3hDW78SFgC9/B
         UtvTCRZah7o3TV4Gmvd7e0jT7FJ4Z+tpOOaarQm9bZ54WShbj6/2TrECuS+8BwceIr2W
         Si0w==
X-Forwarded-Encrypted: i=1; AJvYcCVp4nIw0qFlMyNcXE7QLzKwaYQOms/K8IhzwQcYMpGcQF1fLEatQCU2jMZVSs3ho8lDzHlsfzJR1dSa@vger.kernel.org
X-Gm-Message-State: AOJu0YzYLdEaaLDGBPA8sGvufwqubqkiPVVX+xSlslp2QkTNUeEs8C7f
	ZQCPC0Aqc7ZW2nTMPB61k979Ng03FMXgmYaekAphI3JHy67/+ZSTxLZO
X-Gm-Gg: ASbGncvPPWEvCE3JV2TR9hcMmkF6HZCQqt9EeDfPzV0nEZ7PJnO0EhowWK5hmDkqzFM
	G1o25SKgOSMMifvlgk7poa6LZqS00Hn6Q9fX8RHG6vIX67cwUP+hr11Cq7hxoZS7BEWNiBSv6Ye
	HrvTRZ2EeJ9+Rcj6N2qdpv4IczNccECpzMDkAa/33kwDUy3WCqbP/98lOINHfWe0Ozh1m1dk93+
	bxqCHl55SkkyovG6dPXu+PvwhFLhbLiI2mqkOjzHWPsi3dtBfS5V1ZWfFIhfGvXEtr3LgjkVUPC
	C6PLe2wIYNVRbwD9Oe/J+5oFHgu7RNP+xufzs4JuMZwjBt9yUUsyhnk7mnf8+98c7LwuvOeOoyQ
	GhgK70doeoPVkYROFtCSV64ilWCDSXT8YlHugF1VooUATfRXfPZKhTpYH5kySBf5TdCbuvGIik6
	s=
X-Google-Smtp-Source: AGHT+IEF+jsF9Ep1sxBSIPUi8j40DLrBGK1qvHYFTtZX1Y9LF80IpzZJEcXp+w18dvnss1B8AiANuw==
X-Received: by 2002:a05:600c:4fcd:b0:45b:8822:d6c4 with SMTP id 5b1f17b1804b1-45dddee600dmr125529755e9.33.1757436795745;
        Tue, 09 Sep 2025 09:53:15 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.138.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9ab7c7dbsm314379085e9.11.2025.09.09.09.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:53:15 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Tue, 09 Sep 2025 18:52:44 +0200
Subject: [PATCH v2 2/3] dt-bindings: display: sitronix,st7920: Add DT
 schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-st7920-v2-2-409f4890fb5f@gmail.com>
References: <20250909-st7920-v2-0-409f4890fb5f@gmail.com>
In-Reply-To: <20250909-st7920-v2-0-409f4890fb5f@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Add binding for Sitronix ST7920 display.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 .../bindings/display/sitronix,st7920.yaml          | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sitronix,st7920.yaml b/Documentation/devicetree/bindings/display/sitronix,st7920.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f08869c48a634cdb2a9e6fb33a0510cd1a407970
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sitronix,st7920.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sitronix,st7920.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sitronix ST7920 LCD Display Controllers
+
+maintainers:
+  - Iker Pedrosa <ikerpedrosam@gmail.com>
+
+description:
+  The Sitronix ST7920 is a controller for monochrome dot-matrix graphical LCDs,
+  most commonly used for 128x64 pixel displays.
+
+properties:
+  compatible:
+    const: sitronix,st7920
+
+  reg:
+    description: The chip-select number for the device on the SPI bus.
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 600000
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    // Example: ST7920 connected to an SPI bus
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@0 {
+            compatible = "sitronix,st7920";
+            reg = <0>;
+            spi-max-frequency = <600000>;
+            spi-cs-high;
+        };
+    };

-- 
2.51.0


