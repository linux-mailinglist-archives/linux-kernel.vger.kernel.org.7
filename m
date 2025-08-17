Return-Path: <linux-kernel+bounces-772473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330B6B29320
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 15:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5E1485929
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 13:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527C32528F3;
	Sun, 17 Aug 2025 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="PdWoNvLi"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC063FE5
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755435966; cv=none; b=bVGf9qM4oMvZAoISertlXVh21pbqy8oiqt5q8AwUO61vubdHSTCV4yExRDSH+7vIoup2wEtNnMe6OYi3MLWyiRCmu1HZ3gAKVovT7MFEXgutRUzb4qxmW0ZkCgxbHRTGCyUxbcyKmL7RV2QmVcX2iokzTCo6qDj3d+I3ZDxpsA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755435966; c=relaxed/simple;
	bh=n+LG32lrqhbZEHPnRm0DKpY9KEFe6UgElqttoMw0ofY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DT6fbZm1OKYxKTJdt7dwMfAFJXHcxw8bgix/lOosP9S81ByzGFUNRmD9bfv2YDQ0sMsjTnTK6k1Bhi3jj96GEGjPjZqpV1DIJ8j3KZAt6+Idk18fEzomeWW1rY4QplZg2+Am5jRBt2Wh4lLgzwylVQLqHMbC5gp2ekUmTHnlX08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=PdWoNvLi; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9edf0e4efso2383576f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 06:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1755435962; x=1756040762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOX3OLtfh155JLaNOfAZcUOGkcxsk7cjeCdGL/xz2xU=;
        b=PdWoNvLiDRcQrC2KKfY2Nzo/sGCY+RB4H7pvODl9azqe8nmX2sTNrgXZpH5lG0dWr0
         A2IGkE1GJTHD1PqGqZ886JMSL5hX2zQWSWrcjRbUY6bx/5rBYBex8HtUC7tu2roojD7M
         hJNm0yRwi0NLavhRtINAMiftcJnt9BXB8XqEcA4tN33WSujNcU5NhzN8jncRH5PKdHJi
         NFM7ZVYhwfQuMTdLuqirhiVvh9aPbZZRuZKN+YfGvKYPvMhgM+6U/kGyYUqYUSE/xfiJ
         fcW2Sb6tEVvOuMSbPDt2QbVL8mGaQcD4ShP/J9r0c960hbLHjK886EtVmsi128WhZl0w
         1adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755435962; x=1756040762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOX3OLtfh155JLaNOfAZcUOGkcxsk7cjeCdGL/xz2xU=;
        b=Cmq1jqwIuZ1vfQG0jjkNjDutSR6zdVR63wPct8LQ+qMGxX1gL274LctBX9Gljlih8l
         nF9pg1tsPqVk+jp5Qbvb5UIgIWScafHr+ZBAL7cvLttvpNDvOqjAyv2OiO1pJ6NFl9Yx
         7OyCC7+stwstKRVZfZHpA3NcD2H3YESotUrU2sQqgnvkPoQ1LZnt2EWZnAYZXnKq10lm
         ZyvTxAa+8OccD0L//tSLjBMDZetVjyrt8hCc5SOs0auuMmZQzbdrv6j98I4y0rM0RbY/
         oJ/lFEF5PK1adQ8vbQq4afkAc6URWFAwYJnPOlr7/gLjPK64+FVOEL5e2jf1OkG/XQLM
         0zTg==
X-Forwarded-Encrypted: i=1; AJvYcCUCSJWihzHNFdVRzFI5F4UFDK8mmOvfbWXOlw1KjWcZDb+ypDhf6h+nh5U9H7J2E+5EMYP97k6LdV7ky6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHCGTv7Lbo2dcLgcwFUYuvwy1/csNOYfBpRV420LCaSdc1jYE6
	cFkOLbeE1uEWbrjQrj/tqk4OveIvr78Ja5ruW8Mk8/wGnDhCqYGRbtBari9kiiRLgfU=
X-Gm-Gg: ASbGncuc5BaHVi4TFTldU/1kju9lT2MGaUkhqB6rcqLIMIMJ1fv/ab+VTV6PWKUIvLZ
	EnorAaZHZIDNjaTGZ6+3gaXt6E96d62g9VdqQ7Nm1Gzy2x3znO0WxZlhEOZrqc0ch0h7WRRQfLb
	giggwbw4BlyC4M2KQhzbdmozZ3AhloRH6ZRsqASkC9Mi7wH1jgltf88CsCvzwPqE/5RoqQS2jxV
	r6E8ZwFXG8jSJkI1YLxOchpRDoG0x8GA0IoaH3wv7UA1EyzTChVN1Cp+NKbjA0lj32FC5my8Zmq
	5mNiYfs/VPrYK+64qI3TBIfhpQfpM7oCFYNFQlBNIvLnOjPcSfvZw9BmWoSfGJ7Ux1pE3Olm/Z7
	m/+bi35v1wOAiyU/+TuzhGCjQHjnctCFMOZ+PRUrm
X-Google-Smtp-Source: AGHT+IH4t+K+wdyKKjtu7C3WDETSgqotuEysxOHVXeMjX8vcWBncV2wJkzVWE9RHgsvRzMXRTAtVLA==
X-Received: by 2002:a05:6000:400a:b0:3a6:d95e:f38c with SMTP id ffacd0b85a97d-3bb68a17232mr5769729f8f.33.1755435962122;
        Sun, 17 Aug 2025 06:06:02 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:b4c0:f0fd:db4c:31dd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb93862fe7sm9235729f8f.64.2025.08.17.06.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 06:06:01 -0700 (PDT)
From: Aliaksandr Smirnou <support@pinefeat.co.uk>
To: mchehab@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aliaksandr Smirnou <support@pinefeat.co.uk>
Subject: [PATCH v3 1/2] dt-bindings: Pinefeat cef168 lens control board
Date: Sun, 17 Aug 2025 14:05:48 +0100
Message-Id: <20250817130549.7766-2-support@pinefeat.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250817130549.7766-1-support@pinefeat.co.uk>
References: <20250817130549.7766-1-support@pinefeat.co.uk>
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

Signed-off-by: Aliaksandr Smirnou <support@pinefeat.co.uk>
---
 .../bindings/media/i2c/pinefeat,cef168.yaml   | 48 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 MAINTAINERS                                   |  6 +++
 3 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml b/Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml
new file mode 100644
index 000000000000..80cdff40d175
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml
@@ -0,0 +1,48 @@
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
+  aperture positions. This driver enables controlling the lens
+  focus and aperture via the V4L2 (Video4Linux2) API.
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


