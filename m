Return-Path: <linux-kernel+bounces-869763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45871C08AEA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 06:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718343B2543
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 04:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A1E274646;
	Sat, 25 Oct 2025 04:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9Qcok5R"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44F825BEE5
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 04:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761366736; cv=none; b=Jav2YzWG+jVvmRvDeig4qQqVwrmOVPURRCpbJyTREQK2M4VED75hrclEzTbNgPUrzONKra/KoqzEXGyI747svoIfvn8zELpt5fYzfRycj0UQjWIWUuQUvifotsTNp5CF+spNLw0HfVdHrTOk8BrtdalKsw4pshyn5R1+SYLjQlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761366736; c=relaxed/simple;
	bh=LxsKOmVaDzOSy8bwwU0rWY43UlPO4MkzptnRxF9FP4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+/o34MH3V3wlOjEtHfBOfPs/5nEN+BdpgyvrznXXADGjHAQv8giiWV3y1b6fbJuj+sEADWVnx3YxpzbBFswYdJQUH0KPaS5jhNzvMktQEb7CtcGwRDVBTmHJvYAR9wZ4B9hTVG5C6mjbKnwJmyJRkjhTypeeOrxdclU9BabYOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9Qcok5R; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3737d0920e6so44916811fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761366731; x=1761971531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuZHP6YFsCwwA4TkyjhYi+XmEZKmSYURob9jZc/v+s0=;
        b=B9Qcok5RoenL6fqPlY6e10yRncd50H3kwiY26o1qE/pRn6c3Ux3k+uEO7MSFd7/CaA
         NBcnmRvhUXZxjl5UbiEiKC18ag4KrYRvH4/A1HnNIkuufh2ElkBerbg7+A5tNjSHRklG
         PDWjquaC9tXHMJmIGiZWIOIa9pgAz2ZfFXdi8wqCl+ymzUdzMtfiGOxGGWUE/ez21CNN
         QOyIyFY13Kk/ehCS2DBw6txxg3R4VuC3RKf/RbpLigqk7mn76XVnLL+kK5ExLmc6ftMH
         8aGzA3NqEUCAVaWaZnxWNRdaVi6kxo0wk2LMD1gMzc/CbQQAGBQweBzckNKNjJJ+q6ad
         Vsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761366731; x=1761971531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuZHP6YFsCwwA4TkyjhYi+XmEZKmSYURob9jZc/v+s0=;
        b=YGMPpHKeVz+OlxqOK2NmszaNhXKsxIE/Vs0lJKPxxJY46Su/7YwOcn6TSDEnJY53MF
         b/29JWIhUS31ThAkrgtp4WnSlBhC9xe12tj9VJhpBLgoJdpQAAsV43WgSkzJN/aG4gtx
         DNGrZUA0L32J2DlPANnOalmpF5pUb0j3WC/AUaIF3mkcvlvb2mRZ3XrLlbnHTASX50XH
         HjmArW44dFKiE0KMn7ndUjN7CjermRnR0FYt4g5MAgOW88r0fCO9BE6/xYy/kodDYAlp
         p/TGozan88QGezH1bPrzjRV03FCa9C467O34fiDXXc8OZ/p39zTEmoOKH9b6yrFb9/ri
         2QzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvQ4Jsgf//KKTsbD52S9z1SHzjF3yJFS/cao7hporT3H0aFDjDSY06ezVtnzPkABbwLQmD1Shv+v9PRvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ZEgBIU0VcxkBmB6XVA4mylYDNAudXU6dxY9vFAJ3LlElfLM1
	2oy1lDDrpnhFWD+SD+q10EH/qz1uQaXvSe9dKxsWsR+pifcFXy6cWtSc
X-Gm-Gg: ASbGncspN0wte8SeZliVtT9x46d5ALbRyEQ7AkpgaiaIFLf8sUE3dsAPre6BR5CRZNe
	x/4FwKouII558+3Jp8+T5zCZMcjnr2sK3/YUouc6eqty4LzofapNl6RiwcJsmUb6zPkdQQqip1l
	7gqEYkLzTi9EEweY1vqHIl8wo+zOB3Pvc/ON83x4MaI4a7bvTsTvwZooSk+IbZ7ii+hbu7AqV0+
	My8AHGSF7p/OwZXd4yVFU2ScR78OeWFzzVA4UAn9MOFn0t4vexLeDLDndavOFmiTEM33y5raxD/
	oVLL+RNazRclcJCkzzpQCx5REH2UlZceeozlFONR1jGkuFBa9EC12kWdDen8CLuRoMh5GZopeRz
	JChN4YpnXDZ8t8OpDruAR6amMsP43qYLP6u3LyawnDBoix2EnDc1BQghA3zakeW2H5u6uNqjO/E
	gH
X-Google-Smtp-Source: AGHT+IHidqK20asSnkSoaYA0Ua+IEXaUMgtNo1d+OXf+4JbTCbl0aR8F8Cd5djjk9glXI6+3c84fFA==
X-Received: by 2002:a2e:a916:0:b0:376:4430:b545 with SMTP id 38308e7fff4ca-378e4648542mr13761041fa.49.1761366730866;
        Fri, 24 Oct 2025 21:32:10 -0700 (PDT)
Received: from junAIR ([176.106.241.81])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0ca7a0sm3409241fa.33.2025.10.24.21.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 21:32:10 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
Date: Sat, 25 Oct 2025 12:31:24 +0800
Message-ID: <20251025043129.160454-2-iuncuim@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025043129.160454-1-iuncuim@gmail.com>
References: <20251025043129.160454-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

Add a binding for D1/T113s thermal sensor controller. Add dt-bindings
description of the thermal sensors in the A523 processor.
The controllers require activation of the additional frequency of the
associated gpadc controller, so a new clock property has been added.

The calibration data is split into two cells that are in different areas
of nvmem. Both controllers require access to both memory cell, so a new
property nvmem-cells has been added. To maintain backward compatibility,
the name of the old cell remains the same and the new nvmem-cell-names is
called calibration-second-part

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 .../thermal/allwinner,sun8i-a83t-ths.yaml     | 56 ++++++++++++++++++-
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
index 3e61689f6..b2f750ef2 100644
--- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
+++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
@@ -24,18 +24,23 @@ properties:
       - allwinner,sun50i-h5-ths
       - allwinner,sun50i-h6-ths
       - allwinner,sun50i-h616-ths
+      - allwinner,sun55i-a523-ths0
+      - allwinner,sun55i-a523-ths1
 
   clocks:
     minItems: 1
     items:
       - description: Bus Clock
       - description: Module Clock
+      - description: GPADC Clock
 
   clock-names:
     minItems: 1
+    maxItems: 2
     items:
       - const: bus
       - const: mod
+      - const: gpadc
 
   reg:
     maxItems: 1
@@ -47,11 +52,16 @@ properties:
     maxItems: 1
 
   nvmem-cells:
-    maxItems: 1
-    description: Calibration data for thermal sensors
+    minItems: 1
+    items:
+      - description: Calibration data for thermal sensors
+      - description: Additional cell in case of separate calibration data
 
   nvmem-cell-names:
-    const: calibration
+    minItems: 1
+    items:
+      - const: calibration
+      - const: calibration-second-part
 
   allwinner,sram:
     maxItems: 1
@@ -107,6 +117,7 @@ allOf:
             enum:
               - allwinner,sun8i-h3-ths
               - allwinner,sun20i-d1-ths
+              - allwinner,sun55i-a523-ths0
 
     then:
       properties:
@@ -132,6 +143,32 @@ allOf:
         - clock-names
         - resets
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - allwinner,sun55i-a523-ths0
+              - allwinner,sun55i-a523-ths1
+    then:
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          enum: [ bus, gpadc ]
+        nvmem-cells:
+          minItems: 2
+        nvmem-cell-names:
+          minItems: 2
+    else:
+      properties:
+        nvmem-cells:
+          maxItems: 1
+        nvmem-cell-names:
+          maxItems: 1
+          items:
+            - const: calibration
+
 required:
   - compatible
   - reg
@@ -176,4 +213,17 @@ examples:
         #thermal-sensor-cells = <1>;
     };
 
+  - |
+    thermal-sensor@2009400 {
+      compatible = "allwinner,sun55i-a523-ths1";
+      reg = <0x02009400 0x400>;
+      interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_GPADC1>;
+      clock-names = "bus", "gpadc";
+      resets = <&ccu RST_BUS_THS>;
+      nvmem-cells = <&ths_calibration0>, <&ths_calibration1>;
+      nvmem-cell-names = "calibration",
+             "calibration-second-part";
+      #thermal-sensor-cells = <1>;
+    };
 ...
-- 
2.51.0


