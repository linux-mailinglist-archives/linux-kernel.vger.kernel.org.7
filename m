Return-Path: <linux-kernel+bounces-795116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2D9B3ED0C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674A73AA99D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D3B32F74A;
	Mon,  1 Sep 2025 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaJHbMZw"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D86B320A1C;
	Mon,  1 Sep 2025 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746482; cv=none; b=qmVPnzXBWkA2ah5AZu+OLAbUco4zmTmeuZdVn5UsJxsU2BRiGdlCGAS6fIGg5VA5J5DsC1p8bFKGyKpCC+zKibx+L4T9cVkIT7OM8QOix5ZduPkAIJizL6R++N+wRLyM5AYxeIGCxXchgUNMjWKTbeyzHKwOIFtcJeDGSfqnmtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746482; c=relaxed/simple;
	bh=9lBqvWgoHD1CvK52EJjFXkM4bmXfkUjDmAD5ePtG1Ww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y7XHWyWE777Ah1/oWMRumAQ04QhqNNXFdBCGY/co+6EqqF9vowEF6YPmjUU4rsIQpGiaLH1m7D1ADxJA8KPU/JKTUV0GWEc4vy6yRzv2fN00IjQr97Bkx+TBqYxAE0g0oCOThYM3nyFmOv7Fs5YOEbgcncNvGc0hfkqaGylWv/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaJHbMZw; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f98e7782bso1219007e87.0;
        Mon, 01 Sep 2025 10:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756746479; x=1757351279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hiB1x2GnfXq41ehyBCW9ZhOP3PkByTOf4Ckjc7nHIvs=;
        b=PaJHbMZwAW1j536lxgUkhc3HtzrFkXOUcYrLL0HC+mjU7Is1TUtXYzlQWQAdY2jZkg
         WbEqzGwG5gnFRK99br5HS5r0wxu2AP4e1himTetG+QiU26FLOyJ2mKcoKGDj8EnHdiNi
         RTwxHZe4H6H/LaowE9bXvxylnpY31rPcUs3h/xTX/QWCuWpg25r/TI/SkSMFFir3lPae
         mqlrC1vmqNbFJrAfz+dgBjKcyw1vO9N0xDJf5twnUCuaxX8JzeTjTU2F7KYgYAdxPgiQ
         m57fIpadFBz5XvTuTcPi1MmGwI6g1Hlvp8tEMeWKHJn+WLbQ2MMMN36/xLCVu6tJRTHS
         gr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756746479; x=1757351279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiB1x2GnfXq41ehyBCW9ZhOP3PkByTOf4Ckjc7nHIvs=;
        b=PPfZ19Kka49fe5yVznigCKbqLv+eKR5LaLcA0L+uHIxQbTXYUFDQ4DDdsYKAOVgFJI
         IZflkxaml68qLK065LTH+vB4LBk5wJwJqYSwELUYFIiCTwV6h4AhwSX62hheoAH02HpK
         EMPLI9piZYw5PpfKwevXhXRhD4hK6CH97YU7eUluWr6ONP4Mq4LH48K2MQLZnkMLVPSk
         yc1JzT8RoyX8aSWLwO1SMS6mSdS1Vv05tBoalwhkTD4bo98fceMfabC+R9m1MFzxvouP
         VR46sOfqxblyu31/joIYDC0DiaI71LjNb4Xd6gBS1iMD/OG1kfkrnn+weciOI8VUaNr8
         P+/g==
X-Forwarded-Encrypted: i=1; AJvYcCUEu7FDHgqW68NUJriyu966f3Mc4fd2Zzs5/+CKBzTn4RWuwqAjFMa5J2udEwQY69QTuw0nrxEMprz8OUyx@vger.kernel.org, AJvYcCVDZK96SIgp8oyRpSPrGz4vQvtnfui4YsZsSDl+a7Jrm0rJVJOeK9ggkW/IdbWIlCp6npCUWu2rfbZp@vger.kernel.org, AJvYcCXbMOjXM0L95g35dncd+9fN26zH+NG62MpsvUpC49F28gXkLYzQ+eNM2ttAtXc4HF7yyzboSC704jMw@vger.kernel.org
X-Gm-Message-State: AOJu0YyNqmGm8ga8P6YfNpTRdGNXLpHr5DsZgORucFYi8++yn5xDEzNe
	ayJMIj7KFtx3++hoenBF9n1tMsiupr12T6EUIrJZDbCpG7Waj2XrGnoEWRnOGw==
X-Gm-Gg: ASbGncuQ+0lPeAW2P94lWHvC1B5jUhjGUHynLfEvJ/m7BMfXWwBdkelolUb+cDVlcgl
	aec4bq499xyj+8lWPaliH5FBIz1zNefo6zFPuvRMAOmk29PyZoDAQ5UTEsfCGeHn/N+4batG2Pc
	a/g9zmc9oHAI1v9ptbKKrugUaZF0PNBpcn2L0naOzb3jfm8E9gOguAtLEy0Gs3oLBUcB1n6Sg8P
	VGKXh2cp2Ef/Syhk47mFFLIybwNNrEOHdHPtT6Sqt7VcZ7rnPu3HkaL+FrEGClPcy5mUCXB7MOl
	KpXchdss5ox9lsw2EHTPLAeSF9zjl/UK1V9aSKWs4ZJrMdNnjJKkAVOVb8MAr2vToMrHEh7tN/T
	KuQ+MYtJV98YDkww1h1yq44ilajpSf4Rqg3qbgS63lR0lEQ==
X-Google-Smtp-Source: AGHT+IEMPwVvz3dT+Wa5T1jv6PwP0GwVTvVM4L0/EXefUHmXiO71AbRQUD+lo1xy2csQBhZ56UYSGA==
X-Received: by 2002:a05:6512:2349:b0:55f:400b:1144 with SMTP id 2adb3069b0e04-55f709dc934mr2840126e87.27.1756746479006;
        Mon, 01 Sep 2025 10:07:59 -0700 (PDT)
Received: from tablet.my.domain ([2a00:f44:892:8a37:6b0:21e7:549b:225b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f7abf7abesm1137666e87.55.2025.09.01.10.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 10:07:58 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 01 Sep 2025 19:07:08 +0200
Subject: [PATCH RESEND v6 2/9] dt-bindings: clock: brcm,kona-ccu: Drop
 CLOCK_COUNT defines from DT headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-kona-bus-clock-v6-2-c3ac8215bd4d@gmail.com>
References: <20250901-kona-bus-clock-v6-0-c3ac8215bd4d@gmail.com>
In-Reply-To: <20250901-kona-bus-clock-v6-0-c3ac8215bd4d@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, 
 Artur Weber <aweber.kernel@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2774;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=9lBqvWgoHD1CvK52EJjFXkM4bmXfkUjDmAD5ePtG1Ww=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBotdLJtJnA13rPAwrEmbCtVga/hPA3it6+0GH37
 HKIZtR2OT+JAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaLXSyQAKCRCzu/ihE6BR
 aF1jEACKEG0rMtSl7xca6+LF6eZGKGO80JmTNV8doBqGFebvOwlJ1YQ7vn6x75zxx5fFIPnH9fh
 kKzxqzesdhDdKooL7PaKAjoIDkNVrJHqU/dpT+Fs2eIgZDZvqIkCIsuxgHjbX3Cp3NhiXTRaSJa
 r67ePQ1CBgj9G3aL169r5Yo+xUCHOSrgi/RzEEwlkm2oA+kHnOGH/Xwe+YTVZqv0N3GYOuFwDNx
 xnZ01HhfS2qs24G4w6rVAPIskxIfVf+QGo1oJBqwzu+J5boWzQIsvrghmZZbEpCiHlOw+9GbGCr
 b1PeSPPuCM4kSGL8cc2PiBjq94MbFJqjtDRbz5IL1rG9E0AKpHg6Ftz3xwm0EZBT3Na/T3SBEBb
 EmP6w245RIomYH61vVkfVOVG2ZTgSKGweKjj1G9DntDJHUocj+qFj+8gh2S6Qk4kUeZcSa/DPMH
 XUllABhED7wpl7Plv+tqJNiyeiAs2CuNR+ZlmysmakDEVnx2G1esLBDJcf/1UFt2qrN17sTXiEj
 JilnoSiJ3BTgnfj3oVrXi3606m7QYxqZxJX15RSP/QAGrZUYwZIA3DQHYLXtu++n0XZOyIcbhw7
 k4Os66fYYNEq7hVu90zC76yg2wQ3AqsqBqsDmr9dEgqbOta3HPl109cIJBvDBV+bZjx3c2HMsvV
 kmOQQ1keVxWqBSQ==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

The CLOCK_COUNT defines are not used by device trees, only by the clock
driver. Keeping them in the DT binding header is frowned upon.

Since they're being moved to the clock driver directly, drop these defines
from the dt-bindings header and only keep clock IDs.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v3:
- Add this commit
---
 include/dt-bindings/clock/bcm21664.h | 4 ----
 include/dt-bindings/clock/bcm281xx.h | 5 -----
 2 files changed, 9 deletions(-)

diff --git a/include/dt-bindings/clock/bcm21664.h b/include/dt-bindings/clock/bcm21664.h
index 7c7492742f3d4ca439236f2f352e432989409570..7a380a51848ce100cbf94f9da2b997dbe3a65230 100644
--- a/include/dt-bindings/clock/bcm21664.h
+++ b/include/dt-bindings/clock/bcm21664.h
@@ -21,12 +21,10 @@
 /* root CCU clock ids */
 
 #define BCM21664_ROOT_CCU_FRAC_1M		0
-#define BCM21664_ROOT_CCU_CLOCK_COUNT		1
 
 /* aon CCU clock ids */
 
 #define BCM21664_AON_CCU_HUB_TIMER		0
-#define BCM21664_AON_CCU_CLOCK_COUNT		1
 
 /* master CCU clock ids */
 
@@ -38,7 +36,6 @@
 #define BCM21664_MASTER_CCU_SDIO2_SLEEP		5
 #define BCM21664_MASTER_CCU_SDIO3_SLEEP		6
 #define BCM21664_MASTER_CCU_SDIO4_SLEEP		7
-#define BCM21664_MASTER_CCU_CLOCK_COUNT		8
 
 /* slave CCU clock ids */
 
@@ -49,6 +46,5 @@
 #define BCM21664_SLAVE_CCU_BSC2			4
 #define BCM21664_SLAVE_CCU_BSC3			5
 #define BCM21664_SLAVE_CCU_BSC4			6
-#define BCM21664_SLAVE_CCU_CLOCK_COUNT		7
 
 #endif /* _CLOCK_BCM21664_H */
diff --git a/include/dt-bindings/clock/bcm281xx.h b/include/dt-bindings/clock/bcm281xx.h
index d74ca42112e79746c513f6861a89628ee03f0f79..0c7a7e10cb425ddb597392939cb218545a48bf22 100644
--- a/include/dt-bindings/clock/bcm281xx.h
+++ b/include/dt-bindings/clock/bcm281xx.h
@@ -27,19 +27,16 @@
 /* root CCU clock ids */
 
 #define BCM281XX_ROOT_CCU_FRAC_1M		0
-#define BCM281XX_ROOT_CCU_CLOCK_COUNT		1
 
 /* aon CCU clock ids */
 
 #define BCM281XX_AON_CCU_HUB_TIMER		0
 #define BCM281XX_AON_CCU_PMU_BSC		1
 #define BCM281XX_AON_CCU_PMU_BSC_VAR		2
-#define BCM281XX_AON_CCU_CLOCK_COUNT		3
 
 /* hub CCU clock ids */
 
 #define BCM281XX_HUB_CCU_TMON_1M		0
-#define BCM281XX_HUB_CCU_CLOCK_COUNT		1
 
 /* master CCU clock ids */
 
@@ -50,7 +47,6 @@
 #define BCM281XX_MASTER_CCU_USB_IC		4
 #define BCM281XX_MASTER_CCU_HSIC2_48M		5
 #define BCM281XX_MASTER_CCU_HSIC2_12M		6
-#define BCM281XX_MASTER_CCU_CLOCK_COUNT		7
 
 /* slave CCU clock ids */
 
@@ -64,6 +60,5 @@
 #define BCM281XX_SLAVE_CCU_BSC2			7
 #define BCM281XX_SLAVE_CCU_BSC3			8
 #define BCM281XX_SLAVE_CCU_PWM			9
-#define BCM281XX_SLAVE_CCU_CLOCK_COUNT		10
 
 #endif /* _CLOCK_BCM281XX_H */

-- 
2.51.0


