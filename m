Return-Path: <linux-kernel+bounces-832788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E82BA05A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A551178C39
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1CF2E54BD;
	Thu, 25 Sep 2025 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aws2QwIz"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728D82DEA95
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814312; cv=none; b=SeYI6UO4unLuvVOenpGAwBrwU202mpM66TY1ptaK0TUJlKfcy9Fcu2BSVhZ9Cd5iiQkjgIx40W3mcN1l7xG7ixgelc+dhBqcUSwiXXnlEwthu499IDSl44MgBqT9w357q3qDNLQBwUPwD7MuYg62ZhfJHgIj/RyIwEivW2UskSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814312; c=relaxed/simple;
	bh=ZgX4ZPQJsepw4/oMrvoAOpLc8zKM+owbJQqU9DnA/q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T8bUOwRhgI2xop8eIMRootUvLrxHFCeV27x8Elvf+U1iFkS3Mhk5WJGOUCwgu/K9SHGx9VkZ62X9lptjmWzy4KnicIAu1DdnMSm43ASKB9PjQF+iBD9KP3GYYmSOICO9J2DqIWub5zqs23QGpKZsP8t85Ew9U0SSLXmxnJFdHcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=aws2QwIz; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso2116469a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758814308; x=1759419108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6M+kRPZnfzew0Cma8s8KKEI2zbCAKgyLYpFhhR2kq4=;
        b=aws2QwIzFM1yCKxP7y9/9Pz3i4H/aIbS1js3NV8YLMGJ77FPKZMRVfaKxMq4aQJizr
         o9Ipb36RRgBw2m+scwbgmRUY9I9/nLw9dUjBS9cKh9BJvHWHm1Pf36m7/6DFj/9R96RB
         YBeCBkElDhe31HCVU4mzMIADDdKrQ21kdbPsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758814308; x=1759419108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6M+kRPZnfzew0Cma8s8KKEI2zbCAKgyLYpFhhR2kq4=;
        b=FKIbbca0tqPc++PsNf2R3MwAAJ5ehJtD2laid+CFVkwV9Y0VBiKodnbrFt2wky7n0a
         qzCiZrlUvn1DoqeZmxjtvaOXIPGQJY8bU+E7sFdbcmSqk7klAXfBIEFuxdxmcUhtkujy
         MnxeCNQwGgY7nTpDvgXL7NkEAHsYUSpcPzacUKo/bOLUrBcK4MiMTCUpmkj2RG4Mj7b+
         isloxFqDW+2o07tU10Rx5mv/GJ30fQqiISUWOZzc4xZTxdIeK/DjPVZEzNMZ4XUjM57H
         9RRcaP5y5E5O5aKUuaUi839h9+vtiq7i2j+42R7gYkdWXCxDFu+8KPT8frdOXuNfpyvZ
         8iww==
X-Gm-Message-State: AOJu0YwA8OP5qeYErIpX3p3HZ1FksTcoFt/5Icf+Gdbj6Or8vWX04q+z
	51UUdNtvg0XFE8UKL7rbNPq0gaSA4oyay7OhSD11gxdKq5DX+zlLNZtkgXBnjSaZASILfLdBc5K
	MmhY1jpw=
X-Gm-Gg: ASbGnctRspbsFexp4D8UOe4O+dv1KcOkW7iTAXc9m84ewCDB79qrbeThyO6EBGMGwO8
	rno8Zs5iLqgXjO5MYNUVKzZBpm/RgVS4Vb8mLh7FiI+/EOi+TNheizW1mI56ZR1XdhzFZKNW/gQ
	oFTgL1/LWtc2osvwiYbo10+p5IySVLXHkV1exyoqtKWL4xo1+2smyFrtK4Qw2OyRovpjG4iqkoY
	auqG5VDywyPDa0rC/7nhEF8jl53KFKSJh//OtHbJ84+T9nAMrnWVKO6Jp9zUWTdg63gqZpuUTVP
	UNaXB+az3p54A8WItjrMJIuj9L/eUAOTJceu8znP1FaQ1sZzcAxACzM55TRTj/P1c4uTMljRZPM
	epovkiwaOHy0Ns7XVFvr4fAhV/ngLad+tEHpa938MaH0m9TnPnJQUXgqdip8npmieMLTZpILwhS
	jfpBpmjbQQyJC7DkulHK4nIdaM9GDIXP9fNje9rV1xOHtMvR4eQ9cXCbh9k4bQszYI
X-Google-Smtp-Source: AGHT+IFJ5RjszPrVn/momTP/VgXs6PvdsosumGKSnAuVSbcsK7vDz96xQNlT+VW8DiVuWKFGQ1fHPw==
X-Received: by 2002:a17:907:2d8c:b0:b24:6396:c643 with SMTP id a640c23a62f3a-b34ba450628mr410897166b.23.1758814308519;
        Thu, 25 Sep 2025 08:31:48 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b36f410e129sm43924766b.89.2025.09.25.08.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:31:47 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: sebastian.reichel@collabora.com,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [linux-next PATCH v8 1/3] dt-bindings: touchscreen: convert eeti bindings to json schema
Date: Thu, 25 Sep 2025 17:31:33 +0200
Message-ID: <20250925153144.4082786-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert EETI touchscreen controller device tree binding to json-schema.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

---

Changes in v8:
- fix conflicts after rebasing on linux-next where the patch
  dt-bindings: input: exc3000: move eeti,egalax_ts from egalax-ts.txt to eeti,exc3000.yaml
  has been merged.

Changes in v7:
- Add Reviewed-by tag of Rob Herring

Changes in v6:
- Add deprected to the compatible string and attn-gpios
  property
- Put const 0x2a i2c address for reg property only in case
  of not eeti,exc3000-i2c.
- Put false the attn-gpios property in case of not
  eeti,exc3000-i2c..
- Drop example for eeti,exc3000-i2c.

Changes in v5:
- Move bindings into eeti,exc3000.yaml
- Remove eeti.yaml

Changes in v2:
- Added in v2

 .../input/touchscreen/eeti,exc3000.yaml       | 16 ++++++++--
 .../bindings/input/touchscreen/eeti.txt       | 30 -------------------
 2 files changed, 14 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/eeti.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
index d19b07d4cfd4..930c70104b3f 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
@@ -16,12 +16,14 @@ properties:
       - const: eeti,exc80h60
       - const: eeti,exc80h84
       - const: eeti,egalax_ts # Do NOT use for new binding
+      - const: eeti,exc3000-i2c
+        deprecated: true
       - items:
           - enum:
               - eeti,exc81w32
           - const: eeti,exc80h84
   reg:
-    enum: [0x4, 0x2a]
+    enum: [0x4, 0xa, 0x2a]
   interrupts:
     maxItems: 1
   reset-gpios:
@@ -30,6 +32,12 @@ properties:
     maxItems: 1
   vdd-supply:
     description: Power supply regulator for the chip
+  attn-gpios:
+    deprecated: true
+    maxItems: 1
+    description: Phandle to a GPIO to check whether interrupt is still
+                 latched. This is necessary for platforms that lack
+                 support for level-triggered IRQs.
   touchscreen-size-x: true
   touchscreen-size-y: true
   touchscreen-inverted-x: true
@@ -51,7 +59,9 @@ allOf:
         compatible:
           not:
             contains:
-              const: eeti,egalax_ts
+              enum:
+                - eeti,egalax_ts
+                - eeti,exc3000-i2c
     then:
       properties:
         reg:
@@ -59,6 +69,8 @@ allOf:
 
         wakeup-gpios: false
 
+        attn-gpios: false
+
       required:
         - touchscreen-size-x
         - touchscreen-size-y
diff --git a/Documentation/devicetree/bindings/input/touchscreen/eeti.txt b/Documentation/devicetree/bindings/input/touchscreen/eeti.txt
deleted file mode 100644
index 32b3712c916e..000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/eeti.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Bindings for EETI touchscreen controller
-
-Required properties:
-- compatible:	should be "eeti,exc3000-i2c"
-- reg:		I2C address of the chip. Should be set to <0xa>
-- interrupts:	interrupt to which the chip is connected
-
-Optional properties:
-- attn-gpios:	A handle to a GPIO to check whether interrupt is still
-		latched. This is necessary for platforms that lack
-		support for level-triggered IRQs.
-
-The following optional properties described in touchscreen.txt are
-also supported:
-
-- touchscreen-inverted-x
-- touchscreen-inverted-y
-- touchscreen-swapped-x-y
-
-Example:
-
-i2c-master {
-	touchscreen@a {
-		compatible = "eeti,exc3000-i2c";
-		reg = <0xa>;
-		interrupt-parent = <&gpio>;
-		interrupts = <123 IRQ_TYPE_EDGE_RISING>;
-		attn-gpios = <&gpio 123 GPIO_ACTIVE_HIGH>;
-	};
-};
-- 
2.43.0

base-commit: b5a4da2c459f79a2c87c867398f1c0c315779781
branch: drop-touchscreen

