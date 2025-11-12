Return-Path: <linux-kernel+bounces-897077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7884DC51F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFA2421846
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C73C30C608;
	Wed, 12 Nov 2025 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUSRk/W/"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315D130BB98
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946264; cv=none; b=n5AX5gLaT2B+h7PC5Dj70vyU6gMPFk5AL+fntsPyg++6HhihtTMwhrNEHtRSCg/lMfC4qmfgJvTXVuVCAIUCfRxm7HYDdryRZk7eXQA51hOXnpYAzWV1vlCZD+cFNWQyKXljyM/W6qe3vmtClhptBSN0/0EGC+gbRib9Y15WmdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946264; c=relaxed/simple;
	bh=Ys2W7bVXS/rMb7lzjzuNB+sgh7O/1vg8ds/1vxXK880=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sSF0qBiYn6UWlLEPEjjYhSj0NgZmAoOOKReWKbV4Of7ph9oKoR3+qT+T4982IXLkxtPvWp6fMrwfBs73614pHkVLuzdFH7gf9O9WE/ztdnZO/LQN+I12tBrivH0tDrcBbe47E6vtwVFDnPU3kN0J7PnS40LTkVY8ruaZpXxAqow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUSRk/W/; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b55517e74e3so668053a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762946262; x=1763551062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgbjWrvK8elb98wH0NVYO1wkwh6HfRo9teorVSr5yAE=;
        b=DUSRk/W/7kxoQPlXuFGKfdyz1kBDZleJTZrsizgg8H1XB7tceYe+rzWa2DmcsbPAkS
         DNmbKhhOzX5NTnLiwqo5gM6b4LU6WiiFS3LOT0bCcYuNaYWYI+Xe/YR2pmGDIw7cd+y6
         dr8JOSJh7DVcyCVZDvILlysESzw5ck9D6tD1jCTMcX+IKe8OykwZ5nWKFp6wDOet2aKN
         euTXx96qkemvzmHu0YkrAigsxDCP2Ar3dxEtuyOORyhXsNtkFDlmvZvVUTelwQPLjeDa
         M+YPtUQFJU7TiO9FvKpdobOXHXEs7xjK7RMDtLyJ72ra11hDgM3xr5s7zrTzKSu4+VLB
         fvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946262; x=1763551062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LgbjWrvK8elb98wH0NVYO1wkwh6HfRo9teorVSr5yAE=;
        b=v+/iNerEDtvB8hGc1wgjAXGNGYQjjQT9yNgLKGubydE/CGOCDLvs6jJh8xiEs72YTR
         CdQY+7Mvhw/NzvgPCj3N/SGP8qMU3jWHrjASmOhyWV2JPuUvq6BEhlBck3LM6U0PmaPG
         w/WOgLm5Y8UjUnrU/ogrzI/YzsULZpawISaPVhvVUoJnO1SmkKL+Vt5JyTzhhFNCNfXe
         TKgkWNpAF6gAlQ1tewrwNnGIRAwH4yA9Au1UWKlYCJjr9sQKjrXqTKLIu4CPc2WeVAlr
         fnSd9wD2ETEKmP/0qWCHyXOmvENa+jfJc593LmjJajiP1BWcnLeUYtj6W9p3cl0EWzXE
         bwyA==
X-Forwarded-Encrypted: i=1; AJvYcCVI6G1Ryyu6OEtWKNefU0N4QySS7cI+9xNZvYEHEO1ufaolWzh2UGye/aNflmhMyivDka/IUPHZ8YSgMPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5C477xYr1BJP5Dh6Jg7l3oUsc1SuzqVaKya/80ISChh6W6NfJ
	X3kPPaNcgOELc7DbLcf5CIKOH0Wrs51vByztN+CbFkgpBF8oSNGZITkZ
X-Gm-Gg: ASbGncvhAtHuVFAtFenNDILfMDonXUBsdZFENj6QxDP/enn8q3++rrKZtjkH+MKb2C6
	BRsorykHAASWS4frfIYqLp2t7lsD7irU6FuJN1auOUvqsC7p3xomZN/5qpctUwACGF3NvKXhzFP
	Y/aM6z/8Fim1H9HEAeRT5pF+Ir0UAw0cF2Q+Alu6jfYz3TfrzTArRr8mVSDfVV6uxLZ3Fj0byKr
	LigQA0RxjT3nr+AU9Snri5XCiCpNHFM0cl4fUEMvlMQtxrxtaHahsMyni9HGfXG0i0q6ftCLYmV
	p7GNCEXhx32OZO+FN+Ickf7lMbtZr/41YtOyBq17UYh2kALD6DOcfYtToJ98ylmB5c6qjTNoZaV
	sJOEccuzdfbEcjZ6SuTKFL3fD1h0YWcuIoo+il+RzFx8II907LA7Zcdvz9rGlHRUxhEjrVQJHdx
	buLgN4cazLw1EBVrEI2gDiaTwex5AAlAV1wSUVJbSeJPzQc++KiKLBlUxae9r0OJyn7cx+5re9R
	Gx3pyJrk8qsMqXgInDG1Oa7z9pGya5nfaThFuFiKd+LE6vace3kgJA=
X-Google-Smtp-Source: AGHT+IHzzKGS6ukPiu3qZhs2xy9KjVsM2L0MFpMuDNYIYeYdSYNgHuNotiH+CMNMtQb/4PcLQUYTDA==
X-Received: by 2002:a17:902:dac3:b0:262:9c4:5470 with SMTP id d9443c01a7336-2984edc800amr35769115ad.28.1762946262292;
        Wed, 12 Nov 2025 03:17:42 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dca0f28sm27386695ad.60.2025.11.12.03.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:17:42 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Wed, 12 Nov 2025 21:16:47 +1000
Subject: [PATCH v5 01/11] dt-bindings: rtc: Add Apple SMC RTC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-macsmc-subdevs-v5-1-728e4b91fe81@gmail.com>
References: <20251112-macsmc-subdevs-v5-0-728e4b91fe81@gmail.com>
In-Reply-To: <20251112-macsmc-subdevs-v5-0-728e4b91fe81@gmail.com>
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
 bh=5rnjjuFINxFZvoBYoUd9LjmfgXR+dmJkDEVsibGRKy8=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDJkiOUce1qazTeLmfLnTij+44+21Ts/axefvRd7jOmBRU
 6pv9ja2YyILgxgXg6WYIsuGJiGP2UZsN/tFKvfCzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 hjrGOkYMXJwCMNUs3IwMU197tywX5rA+6qDHltJfezFg8be1XbntnS9kApWe7Ds4keF/nM3UDPv
 tslv37N+8xk+vWWvFol0ZHk2ZujrVi9y4D0xiBgA=
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
index f0c8b85baa6b..51942a9a9b43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2439,6 +2439,7 @@ F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
 F:	Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
 F:	Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
+F:	Documentation/devicetree/bindings/rtc/apple,smc-rtc.yaml
 F:	Documentation/devicetree/bindings/spi/apple,spi.yaml
 F:	Documentation/devicetree/bindings/spmi/apple,spmi.yaml
 F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml

-- 
2.51.2


