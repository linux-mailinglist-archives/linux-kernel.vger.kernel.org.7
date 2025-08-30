Return-Path: <linux-kernel+bounces-792920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF69B3CA73
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2392B1BA5DDA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C279F274FF9;
	Sat, 30 Aug 2025 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="nwg+mt9E"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A971DEFF5
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756552525; cv=none; b=iKJl2AEIdABwG9OGykkVgujC6H4xliOAS5GOBYwF+akNo9Ty0TuMtBFYi5MctdhPhWgwe38aQE8GG8n8jiegRYFJWT9LFQ9gcx4cUWGFMUrcoAjehBHWFNAMeVhZzOAaVN6ts1Uj3wQIgNlVXKw8TGQ2UukqRLxUQ3v4MbVnqow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756552525; c=relaxed/simple;
	bh=GC6F3/Jn5vtalbPADycR9a2Ilql3ZeepeVFqnze4ARw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HNyVYrbJOPFeaSbdOP3SJzKlH3Oq8hGbzBOlSHos9B5jJjUBli+bqivsMpT5WINoAVqFoAUR2ixtcsllx8YGlKORRhtEtMRnQ8v8vcURNxHS+LX29KuyTtreA1JHfkFToMxr9ua5FHolI5rs/sJQGDNpGIwYgIrkYDeUmT+2IbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=nwg+mt9E; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b77f59bd8so14995135e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 04:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1756552521; x=1757157321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8c7uejE+UWAVBp++A3P0eUre76yYfUCzitGMEvBnArM=;
        b=nwg+mt9EBBzyefaQJTZbTysBpHPovF4DxRILlLo9lwUH9/i66NxO0jbFkn5XS40tKZ
         ZKvmwVgvN5bEQI4vgcQIGEGdOteovDmLBrOwg54hio1QeQlrz1d4fbH5Cv1cP5awpekU
         mFtzoYxkYOXVeWAURvdOmKGz07gv9YItBNO9Lg94uCkavmy1Xnu/eZ8KxLkudRPi3G86
         D6VH1d6zqf/tF7gFbBKaeDKaPOLWR9y6QmrHpCZFDSNPTVgNEVFvTSq12N+2qZqodkuR
         U2jWeyVmBTo6tgyaqcsFhBg51o49rYF96uPNu2KNBeZSECMKUbgyHbLfBOx6CqHAQ3X1
         SKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756552521; x=1757157321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8c7uejE+UWAVBp++A3P0eUre76yYfUCzitGMEvBnArM=;
        b=cvj2TCShuWgeNahoCC5FPESEaPpjnmw151UhHMUC7qrd1Rwo5yMS4iDDLqDnZzjn4E
         ksssNGeEztqD8EmMI+lyMJyFS/WiTzNw1Aug/3sPqYPmwQ9dwdg004NHIf84ZwMNJLKi
         kYcR+lbV/XptJDutPhMZnSlEfHANAyBLNDyyqJtAqvzBqjtlPoKD6Ub66+e241JT7URn
         qcXgp5vhg9FW1g621f1lY6syvUV1A6dj+CEFuH1gwLTfQCOv1mBPmpY32xTAJqfniKUZ
         zFGufdJMtlOgTuiCPs3u5lMWCv2zKthay4Wy1BlohsykdANtrVTkGLaj1AYFGhJGf/oI
         p5Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWBXDWLaEHQGwcEKfTrSa1Oas3K0NdTBwSS7vAjtpzxIgkr9QrATEapu4641obvw97DYawcWdcTzsUmh6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNoZDPuI2ADZLxV1Um2AWcqRbWiJZB3p+aw/qmli/+qVae032D
	uN6Ly+sOISB92Ur+Tp1pZHY2RR0VNGq8OhoaiI4TxGYOJYWhiJDTBfNzwU+4nhJSb6g=
X-Gm-Gg: ASbGncuPQN+Dw5QWian3EBUr5gJJlmYBcSB/uUZP7fdHfcXq95moagsXidtVE9toWsP
	GtQoQrxZ5+1u8L+CHAYJPlC3VJ3zxnY2hqzT2xJSdSkMMZ6HyuAbXVrhLlwf2xicCi/yTC57kRT
	EzEYIj33Pynb4SYX/w/+UdtKMUUG+STFeEEbNvorF1dmktyJE248uq2N7bcBd+sZwvUdGFUm9ln
	SDgAsUm/B1VxgHTKaHHH90wJk5OxY4uD7/DHRsKOSLajvi6ec41Bc9BBaf2tUHyfw8x2znfTca0
	BrumZyWz5WfMsAUQWHumZGdlfB9F2igAnWiOYW2KZVZUMZOX6itX1bXFdGASAVafdLlc3kI7HeO
	9sZ1SOzBd1yWdIgJV3AmqRjM0q/c79f5RL0WA+QhuQyEB24NwkDBP
X-Google-Smtp-Source: AGHT+IFWihlt2sUVQsqxUumHh9j3uk8AiDiA4vx2FytN10+wzJr9StvuHVKTd3ZZOsWAK2Bfrpl/4g==
X-Received: by 2002:a05:6000:1786:b0:3d0:e221:892e with SMTP id ffacd0b85a97d-3d1df633bedmr1336652f8f.27.1756552520486;
        Sat, 30 Aug 2025 04:15:20 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:8714:ec04:28d3:3897])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fba9c4sm6713630f8f.48.2025.08.30.04.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:15:20 -0700 (PDT)
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
Subject: [PATCH v4 1/2] dt-bindings: Pinefeat cef168 lens control board
Date: Sat, 30 Aug 2025 12:14:59 +0100
Message-Id: <20250830111500.53169-2-asmirnou@pinefeat.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250830111500.53169-1-asmirnou@pinefeat.co.uk>
References: <20250830111500.53169-1-asmirnou@pinefeat.co.uk>
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
index 77160cd47f54..dab27f769b0a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1195,6 +1195,8 @@ patternProperties:
     description: Picochip Ltd
   "^pine64,.*":
     description: Pine64
+  "^pinefeat,.*":
+    description: Pinefeat LLP
   "^pineriver,.*":
     description: Shenzhen PineRiver Designs Co., Ltd.
   "^pixcir,.*":
diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..811c6a150029 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19985,6 +19985,12 @@ S:	Supported
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


