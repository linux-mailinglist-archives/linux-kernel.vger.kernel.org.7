Return-Path: <linux-kernel+bounces-850593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7477BBD33FF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A27F4F2205
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FEB3081D7;
	Mon, 13 Oct 2025 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpUec/18"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08053081B1
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362922; cv=none; b=Hww4pZfRWv/6RyzF5NOax3qD54+RLFBl+E2ExzNCPQ/N7oCqcoDGHpbPIbVOwe6Y6jDfqu2uSwdPkLgmDdi6yFcH/L42lLHtZsjk3tt0hH6TbZGQflM5RLbsmzGhw0mP0a9ebQXebEcMhdqGRZqdn8TuFEXmjxc5MjhCMwL9Jxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362922; c=relaxed/simple;
	bh=E+oiUZgen68cnjAENtdOLkMPulLFXMt4mXOQGkGDE6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xnisly31/JjUKITZjq0QUo5etT/nDJTJG15kGXFIU4hp2l6s8k4GbfRHnvZmmoQKJSq2Q7DUahsvB618CGeeN1hOC0XXT32icC83S+znoGpVvTt7rgTfP6nwVpLUj9elIlepul+d1fBMrgEsqki+0R/H1/8E5I1G2ZxWLrPJsog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpUec/18; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63babfdb52cso1527163a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760362919; x=1760967719; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bdqoW+LR5yZxLdoidUpEK8sPbCwQ5DxDfyq2+aB58A=;
        b=WpUec/18UuhKo2VRFbCUDr4lDzIFwAArkbjvUOa3ONab+Snb0GigVByjpYkFtpZheX
         ML7CUKAlJvp8ri4RRzOMDK1jQEUHAsBIAl6KjqJb6pXa8JvP12796sbfPZPMNOa7Gx+N
         58ckgJ7cAIYtzDIardYx71pAQ1tXfykIqmFy/jbcMhw1gC69D6AJFwMr92N8kYUGhZxM
         wf7+q6VuYu5Uv3djKjQRoLnzXQ9Zu8uHrRir2n2JqY+mY71L+3FfH434Kz4c9X9CYMdl
         vw6l8sSAPFRfuj9p0KIeiI4DdPCuPCJiUKr5j0O9QEvI3JwLsPpMxlUprz+2/tn0FzKU
         wu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760362919; x=1760967719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bdqoW+LR5yZxLdoidUpEK8sPbCwQ5DxDfyq2+aB58A=;
        b=mHt15VFh4DUVOfD6LeZUu+3+GiddTJ8PaB8Tc2iJSU1D3nRqqYxJ4WjESIxWbFJWNe
         HApLiqfnnedQbFTfIRmjnSfriijs5Slo36sdhSvhtyH5R/DWyf4sXGdxDT5V6gl4SV2U
         WQGwrWj7Vh0j8NPZSsduGj1YRNZc2+pZrkkmNrC5PN/z9nJpqb6FZwYrv/ezybUevlit
         gYjV5+bnUHUmwEr4xQdh7e1x6s/gzyUIkjtXaZeWlPEyxN6ZTtCVBPxl4I8yPEuxjXt/
         X2oTHKG56QwuK28FiUQm8jGNrlQa1MGoCE6ySov6O+GYndbJZ6GxivCR59aAOr+INbda
         6jnw==
X-Forwarded-Encrypted: i=1; AJvYcCUyUQL64tXY+0BoV+TXHcBobELlM29ed+HlN5rQ3D2rkjEb9+/XvEVP7DrIiCy08EvHiR1t4CWcsYpu9xI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM2F/ge9vec9vv9Mi4c9oqHPBRq/0Mwslp6T5zZwfZvKQgidwe
	vJOtYcaLiU6HdJF9kwjLLS+AV2WpxV81Y/pccbFV+Kr/h3NPwa1vGvGd
X-Gm-Gg: ASbGncvcngvag0H3ulJIxdNjAnbNopMHvQzyj7XETGqrt/hEKSwOiNmoyeiHrh6ebHN
	OhJaS42E23LS1ugVc7Vw/SWqC/znpkphX61YBwK0FvBnF3iQHQpOjVc0uDyDmli3XqSUW5ROEw0
	Zj81X/9yyBIbGtuDeNatCQixz1jrx3g9JiGCN8ZRoiPREpSOrWXxh+7aHQbD9MtCMQ/Z/9DFUAb
	dENqVP4JY27YJa5mte3a6LHpsAyWhglgdzIROr4Stz/+BG04cGbuU5cP8G05wXEtlkpGrdRqDO7
	OikJhtYw0gxcleSTZOKL8Rp0alA8qhHp6Ty143P0Oayw4tIhukS5qZkIpaQDUC5B9GhUjucq1rR
	VSib5i07h1bNsu11fLDIEOJ+qR9q8gANxvct/tzBq/M76GS5oXzZpPKf/PvrxZvbeXfSjavl+Ya
	AhOE9+IuJ14+mt
X-Google-Smtp-Source: AGHT+IHJtzeYQurhnlAW9tml/nOCL3ntwqVOYGzJy1iG+4nFDJLqIFVys/FUilJjcxgefmjojh9Slg==
X-Received: by 2002:a05:6402:50c8:b0:61c:cf8d:e51d with SMTP id 4fb4d7f45d1cf-639d5c2f5a8mr20630779a12.22.1760362919103;
        Mon, 13 Oct 2025 06:41:59 -0700 (PDT)
Received: from tablet.my.domain (83.21.75.22.ipv4.supernova.orange.pl. [83.21.75.22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c32249esm8729019a12.41.2025.10.13.06.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 06:41:58 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 13 Oct 2025 15:41:49 +0200
Subject: [PATCH v7 2/7] dt-bindings: clock: brcm,kona-ccu: Drop CLOCK_COUNT
 defines from DT headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-kona-bus-clock-v7-2-8f473d99ae19@gmail.com>
References: <20251013-kona-bus-clock-v7-0-8f473d99ae19@gmail.com>
In-Reply-To: <20251013-kona-bus-clock-v7-0-8f473d99ae19@gmail.com>
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
 phone-devel@vger.kernel.org, Artur Weber <aweber.kernel@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2725;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=E+oiUZgen68cnjAENtdOLkMPulLFXMt4mXOQGkGDE6I=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBo7QGf+ItKfJtMmRNf1EyGe+DAhXxvE0FB8Xc6T
 83+l6P8PoOJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaO0BnwAKCRCzu/ihE6BR
 aPJED/99jvVa+gYxsmfku8hqbnFcbTpy+1rL64+7ChnpDDOCPdBm9QZy3EIrI8kdBmDM/Mvnkos
 6Ch9+AXNcxcMJFWRvFLHQ4dBKCPBVdAwwm8qLE8KzrbOs3Cxt7CxnxlkRgQAYkzXr/va10iBxm3
 g4EbK9bjqwsioUSLpTofaQEMW/Q6kwO+tLtEHaDGy05NE3lZyW1eCD7Nk8wW5dky/oRoTHtSENu
 WV3gbXwPCUxqJXfqaGwhdkboXDbiQM9f3vCSaf4qMVzRPjvflptITwBBtJ/8hWAZKHvpe/HJ9Rt
 ACGdZVSxYSs8MZHavFpOET3Kma70j+FpO+BV9QYEcVKRj5JzKPxEQf6VMRIAh4tHHGVa3ie6YOe
 fjWqQbkCFYYuVepxgU4ErDN8USVu+i1lcnp7b8yNyrwgMX8jEK3Qh057xtnXt5amoGl1CC48vi+
 hzb5jpuXFEMLsoI7++jWQoMdbv2N2oRNZXJ0dzKLv7Kvp6Sy8ziP/wZIf181ElGMVweMg1LGljI
 +FIqPhVmTgKwXYsCuyV8/cnGif3jwdkiO0gzgatXLEzOUw4FPPiTij4gVzT6Do1YA6XT5m6YRAo
 bJSuMIOK8C2ooGlD2BrMHGHOoSuIFc1coN3h+k3Skc4FlubsZjCY5PeFAvDKRjpa7j+H5WXqobe
 uf9fYV4PlZKuuFA==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

The CLOCK_COUNT defines are not used by device trees, only by the clock
driver. Keeping them in the DT binding header is frowned upon.

Since they're being moved to the clock driver directly, drop these defines
from the dt-bindings header and only keep clock IDs.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v3:
- Add this commit
---
 include/dt-bindings/clock/bcm21664.h | 4 ----
 include/dt-bindings/clock/bcm281xx.h | 5 -----
 2 files changed, 9 deletions(-)

diff --git a/include/dt-bindings/clock/bcm21664.h b/include/dt-bindings/clock/bcm21664.h
index 7c7492742f3d..7a380a51848c 100644
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
index d74ca42112e7..0c7a7e10cb42 100644
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


