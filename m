Return-Path: <linux-kernel+bounces-882725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D62C2B40A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3719E3A550D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2A230103F;
	Mon,  3 Nov 2025 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSaL5qiU"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D2E301700
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168025; cv=none; b=pHpj+qP1zETIgOAtmKlnLnsbGhEpx9kv8MICZppFV3Wwnhc5aMeFEJsdVcWB/sFnqYbFE8ys+uPGKu5MR3mU/xWw7HIfuIyWc5ALpDP4PLWw9aatJmRSbxzXY9sUP4OIv8rsoOLWFnXhbNTQVWIKDEH62BAvJPcWXmJGZeN4JUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168025; c=relaxed/simple;
	bh=U2S1xSihT43zwJfSjpJYIZmqbEiWaSbNbBj+0gTTbSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfDcCW2s+fslUh8plcRVzbuW3uwDzaRP6kctTOYy21nowRyo+0PBWa0iuD3w0yzCM6hB6rZ7tXXvUxpMQDKZB39BEVN6i1GLLnX9ZpvknbWRtBOQ1lp8ECRu3BctoNlip8aayMKEMelO0fpw9l/cdczTF7Rg5VHoiPfnBtdz558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSaL5qiU; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-294df925292so37397625ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 03:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762168022; x=1762772822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vwqxs3pFPgUNdzREwICsv/UCTbRI0baMAHgNVcVWKho=;
        b=PSaL5qiUcpMiwwN6Z+iZaZe5A3Ze+E9ajOL6GFzvw1com9pJfxR6HTTLSftCHpFMY4
         hlf12EjNXCbBxGYGEYRy1I/qImxGXYIF6tSqYais1oO5gBcSPth9o0ej8utTHGWk6Kco
         jk+V6cg5GBOAAfHWdARx+iiJOB+bFrqmNUEA1qiE0LTGN3NWOO60BMTwsmTK4LBulSdP
         DTPtLh4pmBkx+Emd3TaMw7QjNY0WMepAJwDhyoT4N+HGb7cXVKfdesYsQ1JuO1Ac5+hj
         uCLvX3wOdB/7dMEN1yyA+yS4G9Lx/CVSDJWMETEGSLw3/PSZI7WekJyJuZ1bOU/fOjjW
         E2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762168022; x=1762772822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vwqxs3pFPgUNdzREwICsv/UCTbRI0baMAHgNVcVWKho=;
        b=dyHgjF2mAyLP44szVmdDfxeYOdyva8pd1Sthg5sv903KIKMzDnLLCjPEtpKO/4abW0
         bhpVmia66Y6t0ttjUz9dpx3atpvmcph95o44cWdaYrfkYt8ojgha0jFbjJp5yQWllRhp
         C5QoVyMjw3SNO5B4e5jmHj3Jm1F9tAlMHhbH5yazExCWK/fMhnxXOX8lrI8V2Ds/suFj
         OXQ59QEqst4VdxJ/rVkOf9ay66vBy/0PnmKR7z6reApOXBZNp+4B8Ub4WqoC74XnFxg4
         ogEz4OdGH1IeiXB5ZB9TgcdC4QSvr6kQaYd/8/zivdp3608l79lG0rrCp+R0o+epdFWz
         4p3w==
X-Forwarded-Encrypted: i=1; AJvYcCVU11iX0LZ8N8K1T93mUL6rd+Sb5xK86hwl58Tsx5YXpXvqHlUZCjSLubcLpZDi6ADceofLHmW4yZUhT4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK/n7cHHOooomH3eC4ki7xrbNdzZwyKEtia9x+3VrrvlNKRDSE
	VqsCTV6+hXpiETsT9w/fb4s2eM722m71wv2B1jp0PFmtakoyhhoGj+kJ
X-Gm-Gg: ASbGncvcR+Swl08boVlEC1EoKfshYxmBbplf5AiV+RD9lKDfX122Owqp4sGwVr4mOe7
	IZObwCbjEt9M5j/lWZ0PRrVM7BHi3Zwvf0F9MJXChQk1N9gUJG/Xjxeb0pCplGFU7pLYGRLXym9
	VQaGSBh6C8kEdXD9AHhpN98yRrblZInYpTRpcFjjgz+yVevK/YXMaGBuqSJLzPshWSIEFwSUb70
	UPSsEPcPbHLsg4Wq7jzlsnsbGvLA24GFIT4RFFohkj3zLrNbw+0ySTHb+/wH3J0yqBDytrwHVbj
	KfIKGnORhosN7MRMVtnLa36+5lgpc3nWI5vqtTK845Ujoh/DcejAd7sFT9h+C4SNOONMOpduUlK
	fxWf33m9l4LAYrnouI2QsOW90nSHOtjhDbIpByPVQD9kZM4djc4ZEWXrMbX2W+KHBVuI4UaudUl
	6EDfKKkS5TXgUk8OOUgQ==
X-Google-Smtp-Source: AGHT+IED1NK8Nun74yVDxcwX2L2vPElvPQSyImAaJGU2myF3ZiOioVg5mqtofEuE0gFzFHfeDCXjwQ==
X-Received: by 2002:a17:902:f682:b0:295:8db9:305f with SMTP id d9443c01a7336-2958db93392mr64853685ad.34.1762168021882;
        Mon, 03 Nov 2025 03:07:01 -0800 (PST)
Received: from VM-0-14-ubuntu.. ([43.134.26.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2955615d720sm84025575ad.65.2025.11.03.03.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 03:07:01 -0800 (PST)
From: Junjie Cao <caojunjie650@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>,
	Junjie Cao <caojunjie650@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: leds: backlight: Add Awinic AW99706 backlight
Date: Mon,  3 Nov 2025 19:06:47 +0800
Message-ID: <20251103110648.878325-2-caojunjie650@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103110648.878325-1-caojunjie650@gmail.com>
References: <20251103110648.878325-1-caojunjie650@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengyu Luo <mitltlatltl@gmail.com>

Add Awinic AW99706 backlight binding documentation.

Signed-off-by: Junjie Cao <caojunjie650@gmail.com>
---
Changes in v2:
- use proper units for properties (Krzysztof)
- drop non-fixed properties (Krzysztof)
- add properties(max-brightness, default-brightness) (Krzysztof)
- Link to v1: https://lore.kernel.org/linux-leds/20251026123923.1531727-2-caojunjie650@gmail.com

 .../leds/backlight/awinic,aw99706.yaml        | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/awinic,aw99706.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/awinic,aw99706.yaml b/Documentation/devicetree/bindings/leds/backlight/awinic,aw99706.yaml
new file mode 100644
index 000000000..9b7266e61
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/awinic,aw99706.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/awinic,aw99706.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Awinic AW99706 6-channel WLED Backlight Driver
+
+maintainers:
+  - Junjie Cao <caojunjie650@gmail.com>
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: awinic,aw99706
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIO to use to enable/disable the backlight (HWEN pin).
+    maxItems: 1
+
+  awinic,dim-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: >
+      Select dimming mode of the device.
+        0 = Bypass mode.
+        1 = DC mode.
+        2 = MIX mode(PWM at low brightness and DC at high brightness).
+        3 = MIX-26k mode(MIX mode with different PWM frequency).
+    enum: [ 0, 1, 2, 3 ]
+    default: 1
+
+  awinic,sw-freq-hz:
+    description: Boost switching frequency in Hz.
+    enum: [ 300000, 400000, 500000, 600000, 660000, 750000, 850000, 1000000, 1200000, 1330000, 1500000, 1700000 ]
+    default: 750000
+
+  awinic,sw-ilmt-microamp:
+    description: Switching current limitation in uA.
+    enum: [ 1500000, 2000000, 2500000, 3000000 ]
+    default: 3000000
+
+  awinic,iled-max-microamp:
+    description: Maximum LED current setting in uA.
+    minimum: 5000
+    maximum: 50000
+    multipleOf: 500
+    default: 20000
+
+  awinic,uvlo-thres-microvolt:
+    description: UVLO(Under Voltage Lock Out) in uV.
+    enum: [ 2200000, 5000000 ]
+    default: 2200000
+
+  awinic,ramp-ctl:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: >
+      Select ramp control and filter of the device.
+        0 = Fade in/fade out.
+        1 = Light filter.
+        2 = Medium filter.
+        3 = Heavy filter.
+    enum: [ 0, 1, 2, 3 ]
+    default: 2
+
+required:
+  - compatible
+  - reg
+  - enable-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        aw99706@76 {
+            compatible = "awinic,aw99706";
+            reg = <0x76>;
+            enable-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+            default-brightness = <2047>;
+            max-brightness = <4095>;
+            awinic,dim-mode = <1>;
+            awinic,sw-freq-hz = <750000>;
+            awinic,sw-ilmt-microamp = <3000000>;
+            awinic,uvlo-thres-microvolt = <2200000>;
+            awinic,iled-max-microamp = <20000>;
+            awinic,ramp-ctl = <2>;
+        };
+    };
+
+...
-- 
2.51.1.dirty


