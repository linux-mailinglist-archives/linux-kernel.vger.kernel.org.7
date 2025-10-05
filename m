Return-Path: <linux-kernel+bounces-842309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1882BB979A
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 15:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DA624E4A9E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 13:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2045288C96;
	Sun,  5 Oct 2025 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="CQUBJilP"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B422882A9
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759671186; cv=none; b=HNlO0c9yPl6CYIYOMsOq+OswjydEcZIflczTEp4Yb1Iu6dk0CspiQTE4sUaiwrFwKUoii53X/3/vpgLG33wW7A1DMsIpRHBEQxjyHDbcvVkCtOgLBXcKu+ffigAE7VWgdWf63gL7sdQl/dI3KMDmgMiD9e00lFQdNvutF5ZHlmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759671186; c=relaxed/simple;
	bh=f6vqOFM1ClMIQTvzAyqnN3otmVngL9gxp0vwpvcnK+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jOxfEQ77OoU26NlGgmetXl63UqRTia4PMGwT//bRmlQKpCqzEuxclY0ZdSJJTt1bypEqAoPirnl3dcJ8xSGv9inFZUjVztg/CtPZupIKH8e5ubma9NjR2ZEkmZKR74x0S52QFCah8C40yPUCndpk4Is8C2U2snzuKs4+UMz2yXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=CQUBJilP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-421851bcb25so2126348f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 06:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1759671183; x=1760275983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2j+Q9MMzpQKCegI0LqVFwaTuZf6jfnXFIw0HL+3JIHQ=;
        b=CQUBJilPLqZRpUN7azm7hbXs+iU4AbuhZOanCBG13Pa+gxRdu3bQdlpSSrdb6B97cE
         o4Q3IAXVQt3DonrHwNjkqEwwlrKIW5IEv9uuINERJupV44A0H51Q5ZIXPQgkAGiARW19
         9o4G4/Qjh+XcplxeFQ/zD2Ah5FxkW/CSva0JmJSLbYiWN45HsTWaV0YbIbJ6F3k0hsYB
         lKqdBUu9sZNnUyNUrLZRNsg4+rxsl/GqXcSUc3aMlqCmIoJL9gIMgwI8qookyKZoFKgN
         FberwDQqfu/kQDzo8S3R338MMVjsulFC7lhdeXEm/PcmebkaRq9BAwyWNRBCgL+nwJl6
         eV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759671183; x=1760275983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2j+Q9MMzpQKCegI0LqVFwaTuZf6jfnXFIw0HL+3JIHQ=;
        b=wUUTX3qlW2C/m9slWRyao9ok0mtNA40STfRXiZYwuVGqawcPhh+CW/I4TfLqDperdk
         JhqfU491KT4uTuV0o3r2tJYxNcDME6ovxdsxmg/KJt7EkL43+Q+M8p1HQxdwI6OeyKmW
         gu8HNsrfseiCLoeaB3xPryd4SGe2Ro+rGd9j0SzD89wduO0Lu3nV7r99XC0t2rUbFv6O
         hEsLg+UZt1jKV/I5XmrrAUlo1w670fu/Wz5krlHypIPRX3OBpOfLzc3zrXm0gXVjwo4z
         b+RbqicO45URMjA9G72ZvpuSww/A+3MigA2j69kTQsu+rRUb2ZaM8gT1CY/QHaUJnqH0
         YERA==
X-Forwarded-Encrypted: i=1; AJvYcCVDVlDCAH/ZOiLI9QgCiZV+dum9zgTpFTG2A8zD+4aI403V/6ijAMMHhI2jaBBWGZKtmWa4gugxxMlPp2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc7gb2OcNFAXPWV3d18/Ydb3NTcRd0Cey/7WDR+eklGsylQ6aS
	84sTp+C+9Sxs20CVnSGLKnZXFpueG66EVmmvLnJtDjRuzZ+v9JX2k/RRhA05g/ZHdps=
X-Gm-Gg: ASbGncvLsZoduPD3DEXn8s1sghc2hitX9qQHEwhryddpqXhzCQ/0bEbYchEH3xIfg+G
	qbMQCYng6aLZof3Bn1WRajn31XPwr1MHUC3LKfLa+HmwqGPHQz5c125446bHpd13iSe4VXMkcYt
	MqdQQTLjxr9cDCKxGFKMxgRtJJeUhSFRZcC+pGHlVCJM3aiTejyK61k3vuZSghupqX/NnKuENa2
	dvUHADE7j1YJkUrBKP0ZvjFJ4IOziXE2KOSiVyVP4+omxfbybgooxfES38hTGjfexFG+IaQWnZn
	P5obQUWnuKZPEYKGY/Xa8FWC1F9a7fO7exy0usboehW4ZGZ5dM7u/dZP8Ku0lfqNA1+RBdY5KVV
	w/FT4W/jbFfbS11EDMEFzMWY9Zro5buDFSdgCUqDDpaoa2EbPKmM71GNq2O+pkws+sq8e1ftY6u
	k=
X-Google-Smtp-Source: AGHT+IE4EINjbOD0Nv4TfZcchd929tbPxzPg0iqO1k5gau9eTOYrCdwVAmX2EdM3NGwqRr9r0K6bNA==
X-Received: by 2002:a05:6000:402b:b0:3ea:6680:8fce with SMTP id ffacd0b85a97d-4256719383emr6163478f8f.48.1759671182253;
        Sun, 05 Oct 2025 06:33:02 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:33bb:4d0:68e8:89b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4cc3sm16459730f8f.55.2025.10.05.06.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 06:33:02 -0700 (PDT)
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
Subject: [PATCH v5 1/2] dt-bindings: Pinefeat cef168 lens control board
Date: Sun,  5 Oct 2025 14:32:27 +0100
Message-Id: <20251005133228.62704-2-asmirnou@pinefeat.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251005133228.62704-1-asmirnou@pinefeat.co.uk>
References: <20251005133228.62704-1-asmirnou@pinefeat.co.uk>
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


