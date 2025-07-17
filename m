Return-Path: <linux-kernel+bounces-734715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB83B0852E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA07A45E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FB1218AAB;
	Thu, 17 Jul 2025 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E74FM8yf"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E4D21765B;
	Thu, 17 Jul 2025 06:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734412; cv=none; b=uZWMMWEZ78gnZgDvxUd3So+xoIck/dJ+YlA7JNaPBtDD8yhvEb9jCJEfor/zmy3rAMbzv0E//NyS71e4N5YyYC2Df4QFm6+Y9U+ss7hgtnAxeDjrczlSRPAeIJBzG6cnbPqyM4MxH/b+3BV9FCxbraJX9Xoi3v4Ql4zJv5fo93I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734412; c=relaxed/simple;
	bh=szUa33vd/ZeNRlK8+XAGw9kUaHmYiqKdYCwv2f2LtGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxkf+ReWYLVh515gX9E2030AEsk9WY6GetP4XzSr+l5TXVWxbPXX0Zt1OYBwbZ8OQhtYy8kEmvg4Z7gmpAsmCXoJFvzEbixtIec2M/ahtN0Seqsz0WoWBcHJhmkKU1kWF/KdytSlPe0qaHNruLD/EXlk5LvzY7FFy4HwJ8wxMw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E74FM8yf; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so863145f8f.0;
        Wed, 16 Jul 2025 23:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752734408; x=1753339208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+lfzTeL1Wak4vcj0bIfTcePGEdzEu1RxZDN+yd3UWY=;
        b=E74FM8yfg6DSxSF9tPpIGA/Poh5b+kWZVs60db+ltB+MggUC52JF7zSy2UFz3je5Ke
         N8fnZRqNKt84DK1b/XstDGfKUd/1KgXuZFd9nfk1j9dW1xgz+uKqVoIBmkwPmNMCRcQu
         MMQ62CIhAv0hySq4dBkhMJYytPBPkI51oIpuAPVfV89yqCGlYKOnMw/Sc+zLqrXfsqna
         7NIcKCzueFYavg6bl3bXllXpd/2rw710KIt0qE/vYA9GJh8RWzQ1zjns/njy4g48/OeT
         t1BzsuNrH8Z3l4eI2nocT1t1UEeTV3k7ZmDY/sCDQOdw6BFyynfOwxpdGkEzh0kZImPh
         15vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752734408; x=1753339208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+lfzTeL1Wak4vcj0bIfTcePGEdzEu1RxZDN+yd3UWY=;
        b=k561s37KeyLag2JS6mH+PmEPOTa4mFETJKR+7XmXj1hOMDnXIkE937Jma5zyKEvL3T
         RpBVvEmNmX2jSFNhJn3LzwYiyZj7VwCza8X6RvjUZ0k1gNhi6EUuy1PfS58+ngWGEp7L
         5O3f4UVgiguzVB3VsgmdaN5RsOTQ4kBmUsXtQo4qNHbJIDmzeB+XvEmZF0lCpcMky1Ic
         GLm5iyYYOv1u7wLVWA36RK/4KpdT67ucEk6sEhoaaD7vML3AQV0BO/LP/DnlOPHxxQo0
         51Rfnzywy1wpgoipvG4Wruc/t97apCQsxnwn3lGJWw9K+nEidLgVAyJ1PTQxMFULezJM
         JSBw==
X-Forwarded-Encrypted: i=1; AJvYcCUPZNaBZYbwGF4qM54cLmZJMkGpvrtpNZfGrziTzF1RSqABlLt4WtCwMcFcRmUSCZ7RTumT94X13eSR@vger.kernel.org, AJvYcCUqDDkhVj6nPx4CaOTDnBsQPalE1Oy+jiednYWgKgtFSSdoga1Q4vfI83/4UxvuWbw1OtP58TMz2NC+YqJf@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4B6kduVG0st2tkru3NlM0plq12cAkAwdNBEYT0HzJ2imXpRK7
	z/CqfzuAA25rn19OzWz7gd05kqOrLNVK3QgV6eds1WpT+o9G6mwPc7bE
X-Gm-Gg: ASbGncvi0GzCcVWOvpjpJ+78bCXZhi9H81Bp2Do0T2xOYRckQdmUWHdN0sWzvoS4aKr
	2Mdd7S8aQNb8yUqYewhSBQb0htvMPhwivtWt30WvYpF0Qyj5gT9JaG6qY7oOeaSuK9hqyW2mbO+
	vlcuZ3xLNwBf3iXU701XTzk7NVitlfUDQL4ea2sOqAPgJVXV2GiZ2y367wpV194Kdg6WQ3BhGTx
	EyX5R44WVPzx7T++q5ntnm7tc02euFMghQzMJsXSSB4PKoX7ywvdz/QLSmag72ur7klE3UnQ4Go
	AMljzNqMVPAhcW1u96a4mf5ortFV87mtSI5k2x2bcEKOUi+cvs/huH/5RvlZBAiWrl6PKDrJvxJ
	sVr0VJoe7Rq5nlmW6/2Pt
X-Google-Smtp-Source: AGHT+IEC6CNyV5e2Dr4iiRPg921i9+KVkISq7COE0Ff62GiHFSzacCVW4wEUSqGnqWpAHgMFiGdvtg==
X-Received: by 2002:a05:6000:4183:b0:3a4:d9d3:b7cc with SMTP id ffacd0b85a97d-3b613a3ffbdmr1127459f8f.28.1752734407755;
        Wed, 16 Jul 2025 23:40:07 -0700 (PDT)
Received: from masalkhi.. ([61.8.129.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e135sm20039788f8f.72.2025.07.16.23.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 23:40:07 -0700 (PDT)
From: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: conor+dt@kernel.org,
	luoyifan@cmss.chinamobile.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	christophe.jaillet@wanadoo.fr,
	abd.masalkhi@gmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/3] dt-bindings: eeprom: Add ST M24LR support
Date: Thu, 17 Jul 2025 06:39:32 +0000
Message-ID: <20250717063934.5083-2-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717063934.5083-1-abd.masalkhi@gmail.com>
References: <20250717063934.5083-1-abd.masalkhi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for STMicroelectronics M24LR RFID/NFC EEPROM chips.
These devices use two I2C addresses: the primary address provides
access to control and system parameter registers, while the
secondary address is used for EEPROM access.

Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/eeprom/st,m24lr.yaml  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/eeprom/st,m24lr.yaml

diff --git a/Documentation/devicetree/bindings/eeprom/st,m24lr.yaml b/Documentation/devicetree/bindings/eeprom/st,m24lr.yaml
new file mode 100644
index 000000000000..0a0820e9d11f
--- /dev/null
+++ b/Documentation/devicetree/bindings/eeprom/st,m24lr.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/eeprom/st,m24lr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics M24LR NFC/RFID EEPROM
+
+maintainers:
+  - Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
+
+description:
+  STMicroelectronics M24LR series are dual-interface (RF + I2C)
+  EEPROM chips. These devices support I2C-based access to both
+  memory and a system area that controls authentication and configuration.
+  They expose two I2C addresses, one for the system parameter sector and
+  one for the EEPROM.
+
+allOf:
+  - $ref: /schemas/nvmem/nvmem.yaml#
+
+properties:
+  compatible:
+    enum:
+      - st,m24lr04e-r
+      - st,m24lr16e-r
+      - st,m24lr64e-r
+
+  reg:
+    items:
+      - description: I2C address used for control/system registers
+      - description: I2C address used for EEPROM memory access
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      eeprom@57 {
+        compatible = "st,m24lr04e-r";
+        reg = <0x57>, /* primary-device */
+              <0x53>; /* secondary-device */
+      };
+    };
+...
-- 
2.43.0


