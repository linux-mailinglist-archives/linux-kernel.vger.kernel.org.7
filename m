Return-Path: <linux-kernel+bounces-853775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E043BDC943
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2189C4E9708
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770622FF65F;
	Wed, 15 Oct 2025 05:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTZmMDCx"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E1A2F7AB0
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760505119; cv=none; b=kC6sbHgB0frJJ3Xm46aDxedzglavu4oMFtIQNVS287TypGvquhejrRreotEOpdJL1R8WtcXb/K8skMQciWBawa4aORbEqzp4/Av67auKJMzEwqegNUVZ+lzWVmw9DDvT4wjgUrQntdkNbWVjeUC7KR0tWRcJeVFZwZX57GW5tOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760505119; c=relaxed/simple;
	bh=POYfQFwjlO43w6/RgVlcGERQCRKf5MMzMyemQwwltvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OtwtwqyZMIy0ShKaBWAYVBqSrUypmq7/NqGLYdZiXUoaTDO700IcAz61ABzaCJmFcQN9NnZjFNmQ4yTpO7orj05YNgHgQQUaO4sa866fihiKNh87ZP0l2eiLFz5LeEv7HOA7hgvk/yjQTvel/8bVKneReqb1znRfm46/XWeNAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTZmMDCx; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-78af743c232so5593237b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760505117; x=1761109917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5tve6gFk4vZUOHJ2RUvNKOE7Bm8VBN5vzcwlQzlIuE=;
        b=TTZmMDCxbHcWaMWfQswbFv7oHIJKZ04BBXheFOvRUT3eW1I3tT/HPtoai7pz8KOX87
         3nYlu/TrVoemEpIkQEdzihm5KCfUiiWdaIhuKhm3HxhcWTJNRcrPKaqrRIDYliXobMD1
         yEuNi8Zn0UWwSEG4GXZZqMyX/Ecd7nE8/8Rq63CjnkV7BAdwPavEbNmdj78/SZgDTISk
         iYVzNXAZhzzjuXeUhRUFd0AJxTEoIkPDRE1aXRuNaYezz/o7qhdNvdSTQ9IXsHqMKmwN
         9lpC1F4gPWSrUtqrmGK4QdP7uKMB9oxQ5pJR/v/9LuoC8phgM+3KFK0L8I2Mgmol7NcQ
         A8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760505117; x=1761109917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5tve6gFk4vZUOHJ2RUvNKOE7Bm8VBN5vzcwlQzlIuE=;
        b=jm2lOpXa6nbzAzZLfaBDanNRBMzUMVxsoC6XLVT/iPEh3HohnE57NEMVfpmGLRySEF
         h8hh4L7v4cWGiM0s5ZtyQCfeU2uYMKNzlRw1Ex+YdD5LJp4Cq3h8wmafeOzn33hP02q0
         0mW32doGxNWRAI/xyzardtE3K0DJN4XqJKPc7M1plyExBFYlABomaDE8Q/ClzpcHWIQ7
         gSTCZZWGmdympjXNIlY1ySca+9zyJgbpW6lJwkp/X9nr0npKxYLJPuwY5Zyh9sxXH4Rt
         UkmnT3A+oazTPbejg9y7qu8xJ/ORQAarQnx+CmvSNFNyZfN2hIZM8Fei6fvNkRVQ0tcE
         rbIw==
X-Forwarded-Encrypted: i=1; AJvYcCWtMIuewckIpWClXO9QSSq60U/RyBQGFFG9keS6BdAH8vix5QS6lBE1EP4E2+3wc7egLTCt2lWr8lw3E3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//8nMCfSI0BXr9wMe1e9DAFESYlYsQESVU0Ka4Kp2qkbMJTeh
	4o6mAIzRIP0hNXbV7y+IU+5zeuXSH1ZVoVszP49tywh/nFhh4vvPAJuu
X-Gm-Gg: ASbGncuwX1W6F2iQfVeRuT3paSNmpxX3UbWNMFxxSiy2bW0eY3Sfy2FRJCnz2khQerL
	yvGaKCM1PPhk7jm1wLCKe/Ays59aONt0BJtDif9K50QalFN0kLTc8FHq3+uYxDBUauk7Cmewb65
	4MGWENEwbL2MDAoRr/XUGxw7/3d3SdYzIStqd309TFHdgkRXmlhjj/SJTp49Z6WfyG2LmU3GJok
	LP6CHVBZdrbisOogo/yraRQ9Z9Rycb3lvPinyj6gKTh7iRrh+PVxpSk11GSo8RQkIfVZvcWeSLR
	Df8S1QNjiAooSUvfpJQ0RFn+IYqiZwol9RGsLXTe8RBHT6LJaDoI4vFHRLiP/EP0wB+gHULqH8U
	V9zWNpCrt7dO9f3aNN5vCiazRdGbTuH4H2mNSek99NEc1ofpdW+i2PzLrgBW4PfXL5nFhzEeuOk
	o=
X-Google-Smtp-Source: AGHT+IEWloW/wiqhZ0rSl2BD+IYWmfBOV0MOMEmhMUYgBAmFoV3loRToeklP5c4jmH9v2uWrrRGz8g==
X-Received: by 2002:a05:6a20:7d8a:b0:2fb:62bb:dec with SMTP id adf61e73a8af0-32da83db679mr34294748637.39.1760505117256;
        Tue, 14 Oct 2025 22:11:57 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f5:b08b:9826:e291:f414:9cb9:f6e4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d2d2b29sm17056790b3a.55.2025.10.14.22.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 22:11:56 -0700 (PDT)
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH v13 1/2] dt-bindings: iio: adc: add max14001
Date: Wed, 15 Oct 2025 02:11:08 -0300
Message-Id: <830368e5bc303faf04f542268acb95e99d0d1cde.1760502331.git.marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add device-tree documentation for MAX14001/MAX14002 ADCs.
The MAX14001/MAX14002 are isolated, single-channel analog-to-digital
converters with programmable voltage comparators and inrush current
control optimized for configurable binary input applications.

They share the same features, but in the MAX14001 the inrush trigger
threshold, current magnitude, and current duration are all programmable,
whereas in the MAX14002 these parameters are fixed.

Co-developed-by: Kim Seer Paller <kimseer.paller@analog.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
---

Hello maintainers,

Thank you for reviewing v12.
I believe I’ve addressed the requested code changes.

Best regards,
Marilene Andrade Garcia


 .../bindings/iio/adc/adi,max14001.yaml        | 89 +++++++++++++++++++
 MAINTAINERS                                   |  8 ++
 2 files changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
new file mode 100644
index 000000000000..a2dc59c9dcd8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023-2025 Analog Devices Inc.
+# Copyright 2023 Kim Seer Paller
+# Copyright 2025 Marilene Andrade Garcia
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,max14001.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX14001-MAX14002 ADC
+
+maintainers:
+  - Kim Seer Paller <kimseer.paller@analog.com>
+  - Marilene Andrade Garcia <marilene.agarcia@gmail.com>
+
+description: |
+    Single channel 10 bit ADC with SPI interface.
+    Datasheet can be found here
+      https://www.analog.com/media/en/technical-documentation/data-sheets/MAX14001-MAX14002.pdf
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: adi,max14002
+      - items:
+          - const: adi,max14001
+          - const: adi,max14002
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 5000000
+
+  vdd-supply:
+    description:
+      Isolated DC-DC power supply input voltage.
+
+  vddl-supply:
+    description:
+      Logic power supply.
+
+  refin-supply:
+    description:
+      ADC voltage reference supply.
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: |
+          cout: comparator output signal that asserts high on the COUT pin
+          when ADC readings exceed the upper threshold and low when readings
+          fall below the lower threshold.
+      - description: |
+          fault: when fault reporting is enabled, the FAULT pin is asserted
+          low whenever one of the monitored fault conditions occurs.
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: cout
+      - const: fault
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddl-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      adc@0 {
+        compatible = "adi,max14001", "adi,max14002";
+        reg = <0>;
+        spi-max-frequency = <5000000>;
+        spi-lsb-first;
+        vdd-supply = <&vdd>;
+        vddl-supply = <&vddl>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 8082081ea742..f584196d3260 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15174,6 +15174,14 @@ S:	Orphan
 F:	drivers/video/fbdev/matrox/matroxfb_*
 F:	include/uapi/linux/matroxfb.h
 
+MAX14001/MAX14002 IIO ADC DRIVER
+M:	Kim Seer Paller <kimseer.paller@analog.com>
+M:	Marilene Andrade Garcia <marilene.agarcia@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
+
 MAX15301 DRIVER
 M:	Daniel Nilsson <daniel.nilsson@flex.com>
 L:	linux-hwmon@vger.kernel.org

base-commit: 4b17a60d1e1c2d9d2ccbd58642f6f4ac2fa364ba
-- 
2.34.1


