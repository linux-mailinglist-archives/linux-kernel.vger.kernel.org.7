Return-Path: <linux-kernel+bounces-844158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3710EBC12C1
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2EDB34E5B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718972DF71B;
	Tue,  7 Oct 2025 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXse/G7O"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB592DC790
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835931; cv=none; b=truD9Q2OYFQjSAD+c+l58p6DKQJTAzjPVPY/86aQQG8NS3r/Zyjuo1ByU4RxV42UrID5fr6HCiAnLKmPrPAN2I0Ugjor/hGaTSn1igZjBfpv+kjNmCS0wKRUp6d1wMY+5CoP8OsLp2q4NLxqL4mBs1Hh5HxN0R7vZ8pDMZlX91Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835931; c=relaxed/simple;
	bh=d7bQy0SdounSmC8jpi+/HU+WJQIYNBZC5J2m4z/NNDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UJM/r+6axAzehv7dvZckHy9fXzB8wxOejyutJdYHSEv9/NcLGwVXiSEg4kdu5inFZqcRZVw0CykutMw7x+YfriSbPkJ0mus4SA7ipTwp3uaU+3ReOgsSoEqI8oCnQwaEcUVnK+M/AsME5w+QTSZuTrSCYpC3Ibkc3wysH4nxcaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXse/G7O; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so69932575ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759835929; x=1760440729; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCAPdNKXJAJcEkJcDhcjdf1sPz5hSUw5MgyKkZ0p1Mc=;
        b=IXse/G7OjAjjoaKZnkQvJeLMVfl7FkTN0yhp5SRUDwysOjobeeg4eDmPe6SZnpkMJL
         yrJlxpRf2QwZ4kyoUWMYxtdS2fxTejJnbkIQGvZLgWxaanSBXpNIO2RAQcPYMY0ESena
         RPp6tin8rZ6XdGxuXWM185bLicckcw/Wc5662lfTTirznz5epS6iDgIeKAcT7QsdnWb/
         +QvFkiq6xrJVGsQtlvCdFiLZXNOAsRN8w3+bmOKFbAlZScowyUArWsGB++7quwa+wvYW
         OIS3vp6YaYVRcZNzCd784LKW9hkz6YqjBSWTHZntkAcNcYhF1wygW9cj6yxR1NIlF8zT
         /nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759835929; x=1760440729;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCAPdNKXJAJcEkJcDhcjdf1sPz5hSUw5MgyKkZ0p1Mc=;
        b=CmdAGZUJjKa0yrtd0LCU2+zbUG/yrM8/0FAUk4GrCpN7MhQxxOyPzMmZRAcSQcjQ5N
         sILL6hOWp8EFIfQydfFAcDD488AGMkY4CVX6hIfLZzV5F8b/37IKxjXXahBWnPids4ft
         ey/NQP77TSUbN+A1/Ups7jKKWBR9iRsl292fbtFpEnwV9b+3TfCstu+2QDH8wZ43lXZW
         xhU0j/Rpiw39NLLlUr56bHYA7qTm2EFJyP+ma0wksWubeYPJtNJnfj9j5IlwGta+Drs+
         dXOCGrK1j0HpTM6sh0FUt6s0nPl/yLOt4czkM/kndNNr67y62gncK5AD23YvQx+Be7Bn
         3WDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1I1NMojNb6Jpdo5NfCkRT+6iBf8qJSkaXl/aPi2MBNrc/1VA9U04WUZoQjO3TdzFLxJPU7LsFOl772ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfA1OV48p5iqp/MSW5PAKCGUSWkuJDF4bxCEwym4mSORpXhBwC
	9pNjorKcukvsF2r1L6vQv2jiPhS59i0UF3dgRnFvAlfnODcUnTvfj/1x
X-Gm-Gg: ASbGncuG8U3oJalYBsIUYa2AW+HTlyFXX39WMD9vZTPXh6yjyQP/2bjhSnUqiMhLG+1
	fWE0wzFhFIfg30J87JlSZ8GLfOoE+yinfchfXWxOGVlHO76ApgbwgX8TuZuHsf9lTNcIo6h2iHR
	HOm0UqWc3pv7Gbp+vTjLgN2SYg4vqQPHUaBz3vsourfmkxA5fJ4yYs2z6XqQ90pWUsIL5miNn3r
	zrq1+W5qpNll+ztVyHiSBtS4toRDS4C7VzqpAOpbIDkzcaFPnIcTeMX/M2wgSjQ9WjGTqSUhQnG
	OP8NRfRXw3xuIqR1n57Xim8xUM5bHtYtyuPcXxzq1il3mqFpMntkErp2rYLC+c6uzkVgwlTquxF
	JAhp4YlLuxu2DRiMA/L00ISAo0C0H7m0Y/9p8dnGJWHFijV8GlaJpzL8XX9xwNTO6NIQVw5N9DG
	yqQ8xcM2uxPxMztgkDfrXzQnWkhxg3Yrv3kgUWiZWwDw==
X-Google-Smtp-Source: AGHT+IHfFdoMlBoIXqzrWMT9RmZo5vW+Dn8SIHU12lJcuw3hvHw9CkNL5y/ftl9SyGp75w6luvCUCw==
X-Received: by 2002:a17:903:38cf:b0:271:45c0:9ec8 with SMTP id d9443c01a7336-28e9a65686dmr167161655ad.37.1759835929326;
        Tue, 07 Oct 2025 04:18:49 -0700 (PDT)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d31bdsm162509045ad.94.2025.10.07.04.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:18:48 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 07 Oct 2025 21:16:53 +1000
Subject: [PATCH v3 12/13] arm64: dts: apple: Add common hwmon sensors and
 fans
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-macsmc-subdevs-v3-12-d7d3bfd7ae02@gmail.com>
References: <20251007-macsmc-subdevs-v3-0-d7d3bfd7ae02@gmail.com>
In-Reply-To: <20251007-macsmc-subdevs-v3-0-d7d3bfd7ae02@gmail.com>
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
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4644;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=d7bQy0SdounSmC8jpi+/HU+WJQIYNBZC5J2m4z/NNDs=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDBlPvm3LiQyNvGA56f7Tw3ofdhvf38exui6Qd2ZZ0GsJM
 cfHe4qEOkpZGMS4GGTFFFk2NAl5zDZiu9kvUrkXZg4rE8gQBi5OAZgI3zmGX0ybfr9c12HOyzdR
 lD19cV5cu0XH3u1lk2e3K6S8nfH9ejUjw9GXqVc38Hw9UmHNLjNJbnL7Qf/VE1flNosUSi5c8Pr
 5byYA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

Each Apple Silicon device exposes a unique set of sensors and fans,
however some have been found to be reliably common across devices.

Add these as .dtsi files so that they can be combined with any
device-specific sensors without excessive repetition.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 .../boot/dts/apple/hwmon-common.dtsi     | 33 +++++++++++++++++++++++++
 .../boot/dts/apple/hwmon-fan-dual.dtsi   | 22 +++++++++++++++++
 arch/arm64/boot/dts/apple/hwmon-fan.dtsi | 17 +++++++++++++
 .../boot/dts/apple/hwmon-laptop.dtsi     | 33 +++++++++++++++++++++++++
 .../boot/dts/apple/hwmon-mac-mini.dtsi   | 15 +++++++++++
 5 files changed, 120 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/hwmon-common.dtsi b/arch/arm64/boot/dts/apple/hwmon-common.dtsi
new file mode 100644
index 000000000000..b87021855fdf
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/hwmon-common.dtsi
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Hardware monitoring sensors expected to be found on all Apple Silicon devices
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+&smc_hwmon {
+	current-ID0R {
+		apple,key-id = "ID0R";
+		label = "AC Input Current";
+	};
+	power-PSTR {
+		apple,key-id = "PSTR";
+		label = "Total System Power";
+	};
+	power-PDTR {
+		apple,key-id = "PDTR";
+		label = "AC Input Power";
+	};
+	power-PMVR {
+		apple,key-id = "PMVR";
+		label = "3.8 V Rail Power";
+	};
+	temperature-TH0x {
+		apple,key-id = "TH0x";
+		label = "NAND Flash Temperature";
+	};
+	voltage-VD0R {
+		apple,key-id = "VD0R";
+		label = "AC Input Voltage";
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/hwmon-fan-dual.dtsi b/arch/arm64/boot/dts/apple/hwmon-fan-dual.dtsi
new file mode 100644
index 000000000000..3eef0721bcca
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/hwmon-fan-dual.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * SMC hwmon fan keys for Apple Silicon desktops/laptops with two fans
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include "hwmon-fan.dtsi"
+
+&smc_hwmon {
+	fan-F0Ac {
+		label = "Fan 1";
+	};
+	fan-F1Ac {
+		apple,key-id = "F1Ac";
+		label = "Fan 2";
+		apple,fan-minimum = "F1Mn";
+		apple,fan-maximum = "F1Mx";
+		apple,fan-target = "F1Tg";
+		apple,fan-mode = "F1Md";
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/hwmon-fan.dtsi b/arch/arm64/boot/dts/apple/hwmon-fan.dtsi
new file mode 100644
index 000000000000..fba9faf38f4b
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/hwmon-fan.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * hwmon fan keys for Apple Silicon desktops/laptops with a single fan.
+ *
+ *  Copyright The Asahi Linux Contributors
+ */
+
+&smc_hwmon {
+	fan-F0Ac {
+		apple,key-id = "F0Ac";
+		label = "Fan";
+		apple,fan-minimum = "F0Mn";
+		apple,fan-maximum = "F0Mx";
+		apple,fan-target = "F0Tg";
+		apple,fan-mode = "F0Md";
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/hwmon-laptop.dtsi b/arch/arm64/boot/dts/apple/hwmon-laptop.dtsi
new file mode 100644
index 000000000000..0c4666282a5c
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/hwmon-laptop.dtsi
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Hardware monitoring sensors expected on all Apple Silicon laptops
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+&smc_hwmon {
+	power-PHPC {
+		apple,key-id = "PHPC";
+		label = "Heatpipe Power";
+	};
+	temperature-TB0T {
+		apple,key-id = "TB0T";
+		label = "Battery Hotspot Temperature";
+	};
+	temperature-TCHP {
+		apple,key-id = "TCHP";
+		label = "Charge Regulator Temperature";
+	};
+	temperature-TW0P {
+		apple,key-id = "TW0P";
+		label = "WiFi/BT Module Temperature";
+	};
+	voltage-SBAV {
+		apple,key-id = "SBAV";
+		label = "Battery Voltage";
+	};
+	voltage-VD0R {
+		apple,key-id = "VD0R";
+		label = "Charger Input Voltage";
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/hwmon-mac-mini.dtsi b/arch/arm64/boot/dts/apple/hwmon-mac-mini.dtsi
new file mode 100644
index 000000000000..f32627336ae7
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/hwmon-mac-mini.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * hwmon sensors expected on all Mac mini models
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include "hwmon-fan.dtsi"
+
+&smc_hwmon {
+	temperature-TW0P {
+		apple,key-id = "TW0P";
+		label = "WiFi/BT Module Temperature";
+	};
+};

-- 
2.51.0


