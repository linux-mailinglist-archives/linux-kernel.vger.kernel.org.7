Return-Path: <linux-kernel+bounces-849993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 251A7BD1919
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 441AE4EB646
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC902E1EF8;
	Mon, 13 Oct 2025 06:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaiJCpr6"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7AC2DF13D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760335249; cv=none; b=I3gl7qMLovRehoQKvGwsikLUUVc6Dj+YwzFl6mQOXqnFeABQfCL+gGZa2A5sT/3g+Xmg4jhHxdVgEz4Re52bT5F+A9CfZtxjXIxKx45ZMDbccpj5eHCDusy8PyUkAkeQZQ30h5HwaRkczKyH3BFQlOrCdZZLElbZvpXqFSWhxYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760335249; c=relaxed/simple;
	bh=H86OdhgTHF+sXtUDW7aUQJv0MWH5MWu/K9PkO+/x6d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODUJu8fEbsIPK1mUFEdXfPj1ZfDb7oszIPLzJkr4jDv7ImhtBi68Mu67dtO813DCgH6gtUWwA28j85D/HflUxnI/g/jOvrjF8qnqF6QW1ctZVIdhtAJ3ApOIxKJhJDVo4euIbNnJjvbCT3slqcQb+7+YTIPfIQc5KMakkJItCI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaiJCpr6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3e234fcd4bso636368566b.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 23:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760335245; x=1760940045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GAzaDQKIDLrSVL1wcySzyvMJnY8KNZJxvSnSoEULDg=;
        b=YaiJCpr6UwJlmrGujCOvMt3zESHCT4S8ah/8CgABe7ULtUkdw/I0KWSpnL5GeZON5A
         TS27pwaR4iBMjYrNMk57D/QHJCKHHGWkeFqZfM4VPM+plXRyBCaNsGiUq0FZA8jRNHdd
         S4+LqIlxJbVbp+gIbcq3sguw7uHVkOxOqbSgGN0oPAqVfSgTl6FuR1nMPyZ0dMR3P/du
         N9LapNCE/suxukJdfGxZu/2fVFgVHGmuQWtup8wO5tri03uYrL2bDfcxDdHbnBwi01/f
         okLa3k/y9IGCgjHr8iHnouCo2xNBLd8oFaBRVMbjgKWOeb8D7HN+GfD/VY3bCy/WLBf3
         LVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760335245; x=1760940045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GAzaDQKIDLrSVL1wcySzyvMJnY8KNZJxvSnSoEULDg=;
        b=p5ADL3CkJxUWbsvx2Bxx8KeE7R0tS7DIGO8BY5VS6LSuQzovw/J/88pfFwtLA4/jxw
         k5V1zm8O94nrD2xTR7kGdvUSHgiBHTK5VF+kPDjtZACeqfzQhB1HWDexXbnvouB9qr7c
         2+602dhhbFcrNWWH1uyvgwpGxXvr7PBoIHizx61fZ7vFFbNfSXssGB2YPUpnFKJFZMzG
         nQ8IYevxyaim7fCR5/P6PFxPIT8WonE46CHj2LbQSEXOXBGyMmRLgj0DWp4h0zAgNNyc
         pW1yUc3awZ3S90AQCVqq9dEc25JzUafsX7JRAc97Ot22GsSSTUTQBotAjAFUlMnfsZ5C
         SPLg==
X-Forwarded-Encrypted: i=1; AJvYcCUNZi2/V9dzwanvj5hz/Sk4wUbk/YmptYJ9N5RDk0tADHChFnf+wXUey/zKD++5e4mdS2i3QHtUO2v/IGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7qKxVK8/CADjOmJLAvCGDf+t4Fq/LXC5JyQMcZCScfTCL0p5N
	mElgXooeA7nEi1Jl3lMTeEqAa3X0eZZZkN4ZcHlTLYbifVEFh7IyGY3QyWBcfQ==
X-Gm-Gg: ASbGncs15NeM4xWIxobYAjsTnffux0ABUfEm7ayBXVefccn1Ln4XaPByukJAlVRfO8N
	eDTcR77+3w+/st5Pyo5PlQQEqIjgDNTQuDt8gPvIidtd6LvSdCDoSvDk8DXl19gHGrL3zwN1CJz
	V4wGB0PGa6XYq9rV3KCm0fcdwQpt4EfkwUBX+HQdj/gKeP6Dz6L94riJw6kGeOA9H2qWdUHYF7x
	reyj6h8rdA7ZmHsSBsHqzDQGr2B09JobhZpf1cruCkC65KFd0hdoMzXJyAE5Km8yeAk5RQuNVYG
	iykWr22XrCufe8pyQpVThg9xhwZUSKBjWREbCZPLn5CMcsSmpEqVHvQRpe2fL9+RsLqI/0pXFpe
	eSfSeDwaSxOZXfMMM/THwsC8lF/LKcIuNYVKgdY4atUY=
X-Google-Smtp-Source: AGHT+IGUA8rD//TeTvAJr48jm7HezjLLZ3o8NbtmUrTw8/RjBdRlUCx4yAuWNCTMiro0lpfDlE6whg==
X-Received: by 2002:a17:907:94d0:b0:b3c:e14c:e24 with SMTP id a640c23a62f3a-b50aa69e3c6mr1868584466b.13.1760335244759;
        Sun, 12 Oct 2025 23:00:44 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cacba7sm848329466b.5.2025.10.12.23.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 23:00:44 -0700 (PDT)
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
Subject: [PATCH v1 1/2 RESEND] dt-bindings: i2c: Document GPIO detected hot-plugged I2C bus
Date: Mon, 13 Oct 2025 09:00:16 +0300
Message-ID: <20251013060018.43851-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013060018.43851-1-clamor95@gmail.com>
References: <20251013060018.43851-1-clamor95@gmail.com>
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


