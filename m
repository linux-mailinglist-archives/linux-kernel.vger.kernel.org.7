Return-Path: <linux-kernel+bounces-763610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555FAB21771
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0803B17C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B08A2E3B14;
	Mon, 11 Aug 2025 21:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="fHPznUfg"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388252E0B5A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 21:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947902; cv=none; b=RKLTuvrZ67MjHL3RnEAxFxnadcvifmo9R9J3/M9kBcvSzs+t6kbBATBDvuOTnBboEOepa51wZnkvwnriRf7+tEilwnU0GFUfC2tG7SzYaYoS/jhF3K0iF5gT6n1m0qRoVcw8cS6sHrQO0WalMVsGo2Rvph8WwY4WAeG9lzKw6Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947902; c=relaxed/simple;
	bh=mH1KMnGR+XUrI8L0FCKy07QnW+kkqMzlPl8BlW5s7Xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rh5ew/EN/Lb68+qPQrwpsU5B0nl18zZyzploeMoSGYsd2QDl3h5ZZ0VlZP6r2eZcO4UnoXtGzF98+luLnzEyK4vuRDdVCkpkse3C56i1SH4OUPrM0K/RdW311cE81UD7+0hUZIiiSPajTgY+vo0+A/ci4pSfA76uzheYrxHhFfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=fHPznUfg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45994a72356so38466445e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1754947899; x=1755552699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhHE/8QAww8bZTkCasgOGL4wfh1aWV6rClxlRHnPYl4=;
        b=fHPznUfg087tFX79GvSm5ACDcYxGtLVV7priFLc6SLndYaww0u8EyApYltyac7/RZK
         Spi1aawtayyELb+pgt1DLm8QVpXS4KbFZPujmXQhCm9IZSClCkAjImQ/QBS6j98AMthk
         H+lqmSi8V7BzUlVTbKZjbawKaK9CGKlOP3Gdlm3ui0IokAUiiPR03PG6EnnV3MhOWZd/
         PpO8yDnF2+/Woz0Go3WHOpd0CIO7cru2CL0sAoqB7Sjo7TRkMfCCVst37NDqpzuLR7Ry
         hMwHmX7J8zP3mkYdSvLlmBF2Ypgww9p8N8EiffZe1ApfTZeKnKtnveWI1QDLhxpwcKYd
         fJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754947899; x=1755552699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhHE/8QAww8bZTkCasgOGL4wfh1aWV6rClxlRHnPYl4=;
        b=vv1Xwpk6FANKqo6o3pslHEkuTmdNko0BF4XruD2XqJJUb6Ojrl0lOZ2h47iQhbbm0f
         48sQ1RhEy/Fciku3dVUF2qrQ3T72QYPuVbrEl4oLtOeU+mPQ+1Aaj4kWhvc/AxzYc/nL
         p6guaiIbM03YOBkR4xE2eQ6Zejn87zWmVwKozVM4MmyGd9c7x1HW4P7sF1qki9HcZUiF
         SU7RNds8wqPzwX7PUv5B3sSE2o9itww5PIupwb+n2IUo7DhG7GdcJyLwS3238nCcpM5D
         ro0U2oR0fKkueXWL0Vqs+buG+ZW4b/XYPN9wkuHUuqTBkcZ8fObqsIoCh+4g3bt7XpGl
         i22Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuFAhi1MMeHVFNGwAUl4kmeiO6C+gAAT6i6Q7uF2FLFw8hT0pFwb4nefPQYQFPytf03DtuLtdIgPQi/Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YycRi9NpHYfy5LScsW6MR4q3PlcmgPS23zuChsizbv2y1s5UBK6
	3N4OKA0eYPd8SFIQ1IuaKiArZbIYdLAj34zUqMwNqPhyNhkb3eNkrQJXphACtAKlwbc=
X-Gm-Gg: ASbGncswwD8yhaIwPggAR2FqOE+YHaMSwH6qXzy7vYMjZVFHe+DCXV+eEuiVgHAjODh
	biG2klG3ZVeozvoKhzm1Sz5kCyp3JFzFTq7pOMcMF7ySH7NrADwWPEU8e6nLV1gqJqrjNO9bA1l
	L5/UkadDOTf2FNXqPPqhDjM/uWxksMGqzyMRaIGkwgH1pbPb1E1ZI90yEiPgCUtX6PcRy0xC/w5
	oP6hEHVWoB418p6c4otoB/eKDR1Hx8PmGeS7yPzlP2RdKePi9yiDD6XObY840bytroJ8EpclnD6
	J2LcXlPRrh1uzWIILuV/ndt/gkov8cry0nXPj/LWLTpODEKDV3VDy4myexFOOZOUujV8sTl67DT
	cqqG1ktUi26v+vC/kQc4AzN+jsK1ISUytCA0Bizdh7DGzGVyd/hNbGBBy+Rc=
X-Google-Smtp-Source: AGHT+IF3sgOQh/DoU/bwRIxmb6kfg2ojWEPdxg5wHP7MJpFbD2YwAp8jeRfHrHkI1kRvJtz4JYjjSQ==
X-Received: by 2002:a05:600c:47d4:b0:459:e002:8b1e with SMTP id 5b1f17b1804b1-45a10dd53ebmr5752515e9.13.1754947898989;
        Mon, 11 Aug 2025 14:31:38 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:f8cb:3493:2eed:8d11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c485444sm42397387f8f.66.2025.08.11.14.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:31:38 -0700 (PDT)
From: Alexander Smirnov <asmirnou@pinefeat.co.uk>
X-Google-Original-From: Alexander Smirnov <aliaksandr.smirnou@gmail.com>
To: mchehab@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aliaksandr Smirnou <support@pinefeat.co.uk>
Subject: [PATCH v2 1/2] dt-bindings: Pinefeat cef168 lens control board
Date: Mon, 11 Aug 2025 22:31:01 +0100
Message-Id: <20250811213102.15703-2-aliaksandr.smirnou@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811213102.15703-1-aliaksandr.smirnou@gmail.com>
References: <20250811213102.15703-1-aliaksandr.smirnou@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aliaksandr Smirnou <support@pinefeat.co.uk>

Add the Device Tree schema and examples for the Pinefeat cef168 lens
 control board. This board interfaces Canon EF & EF-S lenses with
 non-Canon camera bodies, enabling electronic control of focus and
 aperture via V4L2.

Signed-off-by: Aliaksandr Smirnou <support@pinefeat.co.uk>
---
 .../bindings/media/i2c/pinefeat,cef168.yaml   | 52 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 MAINTAINERS                                   |  6 +++
 3 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml b/Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml
new file mode 100644
index 000000000000..3563fb1d46db
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml
@@ -0,0 +1,52 @@
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
+  vcc-supply:
+    description: VDD 3v3 power supply
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
+            vcc-supply = <&vdd_3v3_reg>;
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


