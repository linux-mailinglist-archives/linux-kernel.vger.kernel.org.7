Return-Path: <linux-kernel+bounces-844712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A80BC2916
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0874F19A285E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954BD23C507;
	Tue,  7 Oct 2025 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="kxrzJFK2"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEF922A7E2
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 19:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759867063; cv=none; b=tnVJsTFOzBPZZypCNU3SSV/nkyjCCLNHxiXjJed1dkEWfRRUar+vumKdkYJGXeikwSOGjs6yGSqE5j2UKBR0byT65V4gTdyfRXke4YioJPWRup1AJm9QhIlkL1+aJpnW3bcBlWXxkBBVxYVc+031b3EJgi7fGNHeWZh06GOR5qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759867063; c=relaxed/simple;
	bh=f6vqOFM1ClMIQTvzAyqnN3otmVngL9gxp0vwpvcnK+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=emmhvhsSHDLoRRbpDpm/5wZESDmD9kKYTs0BOVTlHUwFKbUsapFmKwSZnc5MA29dLiH4qXKlYoZ5ZUvpXTPnIGdIOcyQ1Srh+2G7y6u82LLgb5l64gnaQaREmz4uQB6P+HgaDMkMD3ZRCIgiRgvAvF8hFx+joXEr52NL4fANNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=kxrzJFK2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e6c8bc46eso43790235e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 12:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1759867060; x=1760471860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2j+Q9MMzpQKCegI0LqVFwaTuZf6jfnXFIw0HL+3JIHQ=;
        b=kxrzJFK2iIv5rfTU+WGNlkG4qFK4p+ksVZi1b5eNpzbMhqeGzVt0ZDBMlNbC0knqk9
         Gy4fGBW7zZLVSalrrDq6HOslEu4zFFYGs6Is8U7nLTPZz/hfdRManbfGFkBQXb3Wck7V
         +XTdIrR9XgB0NaL2xYEt5wxjfbNKpIWYbQirDYGfY0ngKebNScYDT0wtjGxBCbV/wEP2
         eyXLCKakc8ealQ70CHtP54vYOb0GTgO8AIfH337Rr4hC18MUGpnUS3HBxhvBdQNxcpmM
         vOjTvk22HXdmcq6j4tkK65hUZE5sMIlzhH7VHu0d0YM3sKw1lfUPQre2hhypOpP+JLEl
         kPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759867060; x=1760471860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2j+Q9MMzpQKCegI0LqVFwaTuZf6jfnXFIw0HL+3JIHQ=;
        b=bGhjiCkZ6dRhh+3E58Kgte9fYjqrj/wvZJEvRoPSDGuW61iJxl9X/o4QoL/tf6aPBs
         GyjWkWe73uBBM2sp+yFHzd02hbRcMPmYuGU5RSqjr4e/lzUu1mT6+oxisJsdb+2YdccE
         CxQHSVRdTAMvIT97v3aqACY3lUpAhfzBPphgizCPlu6mENbFPbOdNqxX5z9Xj/rG72W0
         CMg7OvO2TttEBkqs+U1eHMbaB+BMlaYB85EQULo1d5PLFY+ftxN2Kqo6ZhcFlqxGu+sA
         mCDdr8uM6ZzDwO0A4RQZBVO44prDN9hKZqtjMTJknRH9Q1C71m9H8uePDojfsUHIUluo
         fYqA==
X-Forwarded-Encrypted: i=1; AJvYcCXbRSfFxuMCgrEkWv8SI3arXCggYap7+aOu1a+relnrYdffXMpbMgd1UE8+neGUVPUdtnkFB2CSRqzlvO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2DQLBPSV+w5SovFIvwU7tokj2GSaX5qJ6t6xtUCRtEq12vjCR
	brZfRsyf/FlVIe4Iss/sn25QeehXLDQnPACw0B8ykk6LDMQpwDXdmfd2YuseGIhwcss=
X-Gm-Gg: ASbGncuTqiIZRE/TsHwneG3AcWYg/jF3ko83W3QOwx2qH0jDScd9rm57WYZWH+afZss
	3234d14j3cUn+KZB8bOoW7whEx498c7SimcfG/5QjcBn9/LpN5Tjj/8+UIJaoYiL/H9twkGx4UT
	kGgaaT5inGLzlkdqMcnal0WBUkY8/mYmrSZOQm3ybBRZflTK8ArzjOKcHzBuqMMCgGpVifvct2v
	7tWx55+IaZTM7iVzs4SPJqFwOvpUJydw3cJm9Nf73gRcq5JEAPmjRrjXMVpPy7+EclZ/uaamQMw
	tbyDvYPgKK8r/SKRkG9aG96GbaNGuWMUFhOpysE/ebg8X3jQS6Ec8j2LKx0CrVJP6VssdRxlXez
	x4X1RacHpXs9I9DcI2GOKhC2uyFX+HgKJGubb+/5l5orGRRj04HxgF0kF5XA547VQ
X-Google-Smtp-Source: AGHT+IG9cbogcwOF6WmVSeyEhHXG7ZHMIzZWC4Mn8mt/VZI5xaGBB2qXeSTvBwUq847PUK7YWE1qgQ==
X-Received: by 2002:a05:6000:26c2:b0:3ce:bf23:3c32 with SMTP id ffacd0b85a97d-4266e7beb06mr328269f8f.22.1759867059593;
        Tue, 07 Oct 2025 12:57:39 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:bdb:8f55:60a1:c8ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8b0068sm26830896f8f.26.2025.10.07.12.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 12:57:39 -0700 (PDT)
From: Aliaksandr Smirnou <asmirnou@pinefeat.co.uk>
To: jacopo.mondi@ideasonboard.com,
	hverkuil@xs4all.nl,
	mchehab@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aliaksandr Smirnou <asmirnou@pinefeat.co.uk>
Subject: [PATCH v6 1/2] dt-bindings: Pinefeat cef168 lens control board
Date: Tue,  7 Oct 2025 20:57:31 +0100
Message-Id: <20251007195732.16436-2-asmirnou@pinefeat.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251007195732.16436-1-asmirnou@pinefeat.co.uk>
References: <20251007195732.16436-1-asmirnou@pinefeat.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Device Tree schema and examples for the Pinefeat cef168 lens
control board. This board interfaces Canon EF & EF-S lenses with
non-Canon camera bodies, enabling electronic control of focus and
aperture via V4L2.

Power supply is derived from fixed supplies via connector or GPIO
header. Therefore, the driver does not manage any regulator, so
representing any supply in the binding is redundant.

Signed-off-by: Aliaksandr Smirnou <asmirnou@pinefeat.co.uk>
---
 .../bindings/media/i2c/pinefeat,cef168.yaml   | 47 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 MAINTAINERS                                   |  6 +++
 3 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml b/Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml
new file mode 100644
index 000000000000..1295b1f4edeb
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2025 Pinefeat LLP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/pinefeat,cef168.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Pinefeat cef168 lens driver
+
+maintainers:
+  - Aliaksandr Smirnou <support@pinefeat.co.uk>
+
+description: |
+  Pinefeat produces an adapter designed to interface between
+  Canon EF & EF-S lenses and non-Canon camera bodies, incorporating
+  features for electronic focus and aperture adjustment. The cef168
+  circuit board, included with the adapter, provides a software
+  programming interface that allows control of lens focus and
+  aperture positions.
+
+properties:
+  compatible:
+    enum:
+      - pinefeat,cef168
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        camera-lens@d {
+            compatible = "pinefeat,cef168";
+            reg = <0x0d>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f1d1882009ba..4f50c35ed670 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1241,6 +1241,8 @@ patternProperties:
     description: Picochip Ltd
   "^pine64,.*":
     description: Pine64
+  "^pinefeat,.*":
+    description: Pinefeat LLP
   "^pineriver,.*":
     description: Shenzhen PineRiver Designs Co., Ltd.
   "^pixcir,.*":
diff --git a/MAINTAINERS b/MAINTAINERS
index 5a2cde903910..a59cd27caf11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20332,6 +20332,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/input/pine64,pinephone-keyboard.yaml
 F:	drivers/input/keyboard/pinephone-keyboard.c
 
+PINEFEAT CEF168 LENS DRIVER
+M:	Aliaksandr Smirnou <support@pinefeat.co.uk>
+L:	linux-media@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml
+
 PLANTOWER PMS7003 AIR POLLUTION SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
 S:	Maintained
-- 
2.34.1


