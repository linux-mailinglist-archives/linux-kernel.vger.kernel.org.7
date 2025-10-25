Return-Path: <linux-kernel+bounces-869648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA0BC08660
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23981C821DD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB4A1547EE;
	Sat, 25 Oct 2025 00:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpGam7Tx"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398A2151991
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761351905; cv=none; b=KmZ330iaqoePwSORV8f+4PPhgj+beyeNJdg4JFtYzSPXeVVDsDwDpPK11MXryB+vYV8aicc5z+xFkGABswMeoQw2e1cvAXB7hpsxVXwq7GSaY5CT7Y6f8UjUtukrSqka3XnrRIJjG3FlZfPzrjC+6mrYgnvBJHuM92CmxTK9neU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761351905; c=relaxed/simple;
	bh=doc6D/qsvutmJbzXvdZDYSYz0ZxXLQM+iyKROYiaouk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KLqMyB18Ay9W1yxX9OScc5PkKwmiAFkxX5XNdeCA4XnMTWIddCbjy+2p3kn/QEO68Xfj3+u4oiF0ELUdYGh0Xb5O4IqTDArMTK1nnIUh5+3zNBwfyWfrodVVU4aJtUrtPsuBHb+19LZXG+hrXbQx4FfjyhqcGghp7d9/qaSBXZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpGam7Tx; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6cea3f34ebso1909251a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761351902; x=1761956702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wae5anKN9hvFHOBxJWNDxfF+UZ1MN51bIQyhwDOYr8M=;
        b=DpGam7Tx91C3uwnzdqHANFynSeEaPGgVqstnUk4slv0fq87EaP6eGvTyPSaZSKpwoU
         8lty4dwHo8cAtxbVwYDzNIZwXOwTmKoPMvabSn0/whEWCTT9Fl2eBb3Q6QQEtdTSfH5+
         vpyasGtXqN8U+3XEiQGzE6nXAEg9xfJAdLvoOTY/tjlwe4InBVi02H+f7QLp/gGc3H6R
         lJAlaued35/Yyl++Hr66tacDWlZG2KomI8MXxYAtVCstUwIb7G6dOAf3zTln3BgI6gaS
         i1QOTrgZ8Zwdc+ZEiw75xo96Klo/CM3C4/RPJ9BJzeqIYP+DlJxFo09c5vBAYx+fpvNQ
         KIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761351902; x=1761956702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wae5anKN9hvFHOBxJWNDxfF+UZ1MN51bIQyhwDOYr8M=;
        b=ZY5A2wMDT05lmRHLcjLXd8GSOyqNUFSWIOmSNXhWtKK3y6YlgPPjr3N4pmHqjVpTRp
         Ksr5WQF24gpHvgUuaNo82A7tS2JXYS70lRrBKiorT8pk0df99jhI8TYb7tnG2gQUp5SM
         eoweSZF932CksBVXqoZ1hehxxfk+6ePOW064xaWilO8MFo6lgUn78tnXCEq4PjgPbqNG
         sY6icGFU7S0de/+o4foCIhYLC1c8jsHmlLjGCZbMoo7cyolAYxmSko+6K62YoNUg93Ev
         GDp6GrhVl3GDzu+TBM5YEBkpGBhuE3IlYWI+Yzpzh1uXu5QQh/IO/IwYmhplFeVWVU56
         cayg==
X-Forwarded-Encrypted: i=1; AJvYcCU4Pq3AqG0tTVQgOBETey3D2Pwd+1x6Ilg+iIcrWvmiZHbL1vMDSmusANwLQltzHX7Iwy7SpKGUaPFpUEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPc60eanG0EJdcm76wFOTpxB83/6cJ/0SL8ABH1YFIP8DlvjeZ
	pkSkp1pWtDaLzsQEPLTYU4SiYRIAyT/gotjrQx7Jn3nn2/iuImNB1q6a
X-Gm-Gg: ASbGncu/umBSDY/J1Rpvx6FVaIUDzf6v0Bd38Qh5WGMnciAotIAm73zU2Q4Z+Jfd5qs
	QxLbAMjlyL1zng5lmIXcTwZymKISonuU2myqG9ZlOf1x/49wTbqLqpeBoKjjV9TaHZfV7BWBqWY
	ayjFkBfHx4zxcLocZL9Dc+EC20FTlGLx0j/EOK1NOt2oKRfDrcBKXH+DeDy22yv2LpVVpLu0vyB
	rcitC6Iyo5v/RThsiYIXaOGKKGEv3uCutZlJQ2x2pSgeTBS8u4dVzBhM6ymF475M4Yg9a9usaKC
	JpGJ8s94Ls3dtF8WYho/5or6CTUj7tPxYeeTHsic8Ofc7j0fuXByc2v2LaNBW98fJ8LlaBidCJt
	EjrX/2fELtprSCSpyfL1XqThP0ozVwWhNzWG23AqVVQoYd8VxQKCNyOjKqG03L2563KMO0f+7ex
	V4M84hGvN52r/YTzA8592vepfGZt7Yp4bzWT8DoCoaazQo9ha8+6dZ/3mDdQYoyRMBS3gqOfWz8
	gK0LUMK/s+P+694iNOR/C0rw8M6UbL+Ja1a17sY386azvsG6evKTg==
X-Google-Smtp-Source: AGHT+IFEqmXz9bRiukdYngtpXwv8pFo+7VapY1AMW8bk3PUTqtg9ECS2KTxI+6Fj45sxyikhlb2EeQ==
X-Received: by 2002:a17:902:cec7:b0:269:8edf:67f8 with SMTP id d9443c01a7336-290cb27f40emr370038515ad.52.1761351902363;
        Fri, 24 Oct 2025 17:25:02 -0700 (PDT)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3f4asm4728885ad.11.2025.10.24.17.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 17:25:02 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 25 Oct 2025 10:24:32 +1000
Subject: [PATCH v4 01/11] dt-bindings: rtc: Add Apple SMC RTC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251025-macsmc-subdevs-v4-1-374d5c9eba0e@gmail.com>
References: <20251025-macsmc-subdevs-v4-0-374d5c9eba0e@gmail.com>
In-Reply-To: <20251025-macsmc-subdevs-v4-0-374d5c9eba0e@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 James Calligeros <jcalligeros99@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Mark Kettenis <kettenis@openbsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3352;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=mFOSrinm6mR52T1DXQZDpIdEAeTd/TshZKSbr4XqCgw=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDBl/JM5KOUU19IWnm920k5nipVbb7c99zz1Ye9FD1RWXL
 bg5V1p2TGRhEONisBRTZNnQJOQx24jtZr9I5V6YOaxMIEOkRRoYgICFgS83Ma/USMdIz1TbUM/Q
 UMdYx4iBi1MApnpmICPD/JeKQcuVJpTJ5a0VO/JY8PkWXavfna5xi4x7tfR/GthfZmQ4vNRKL0n
 +VX/I1WCGLzziV2SPLPpV/aN1bcasfeJRCZ94AQ==
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Sven Peter <sven@kernel.org>

Apple Silicon Macs (M1, etc.) have an RTC that is part of the PMU IC,
but most of the PMU functionality is abstracted out by the SMC.
An additional RTC offset stored inside NVMEM is required to compute
the current date/time.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sven Peter <sven@kernel.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 .../bindings/mfd/apple,smc.yaml          |  9 +++++++
 .../bindings/rtc/apple,smc-rtc.yaml      | 35 +++++++++++++++++++++++++
 MAINTAINERS                              |  1 +
 3 files changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/apple,smc.yaml b/Documentation/devicetree/bindings/mfd/apple,smc.yaml
index 5429538f7e2e..0410e712c900 100644
--- a/Documentation/devicetree/bindings/mfd/apple,smc.yaml
+++ b/Documentation/devicetree/bindings/mfd/apple,smc.yaml
@@ -46,6 +46,9 @@ properties:
   reboot:
     $ref: /schemas/power/reset/apple,smc-reboot.yaml
 
+  rtc:
+    $ref: /schemas/rtc/apple,smc-rtc.yaml
+
 additionalProperties: false
 
 required:
@@ -80,5 +83,11 @@ examples:
           nvmem-cell-names = "shutdown_flag", "boot_stage",
                              "boot_error_count", "panic_count";
         };
+
+        rtc {
+          compatible = "apple,smc-rtc";
+          nvmem-cells = <&rtc_offset>;
+          nvmem-cell-names = "rtc_offset";
+       };
       };
     };
diff --git a/Documentation/devicetree/bindings/rtc/apple,smc-rtc.yaml b/Documentation/devicetree/bindings/rtc/apple,smc-rtc.yaml
new file mode 100644
index 000000000000..607b610665a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/apple,smc-rtc.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/apple,smc-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SMC RTC
+
+description:
+  Apple Silicon Macs (M1, etc.) have an RTC that is part of the PMU IC,
+  but most of the PMU functionality is abstracted out by the SMC.
+  An additional RTC offset stored inside NVMEM is required to compute
+  the current date/time.
+
+maintainers:
+  - Sven Peter <sven@kernel.org>
+
+properties:
+  compatible:
+    const: apple,smc-rtc
+
+  nvmem-cells:
+    items:
+      - description: 48bit RTC offset, specified in 32768 (2^15) Hz clock ticks
+
+  nvmem-cell-names:
+    items:
+      - const: rtc_offset
+
+required:
+  - compatible
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index b45db73e55df..745d85b66365 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2435,6 +2435,7 @@ F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
 F:	Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
 F:	Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
+F:	Documentation/devicetree/bindings/rtc/apple,smc-rtc.yaml
 F:	Documentation/devicetree/bindings/spi/apple,spi.yaml
 F:	Documentation/devicetree/bindings/spmi/apple,spmi.yaml
 F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml

-- 
2.51.0


