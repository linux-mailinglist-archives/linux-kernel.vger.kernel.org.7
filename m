Return-Path: <linux-kernel+bounces-766535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9BDB247D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F83F5A1FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF9D2F747A;
	Wed, 13 Aug 2025 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5p8nnF5"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC5F2F7442;
	Wed, 13 Aug 2025 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082826; cv=none; b=XABFZmZI4/q6rYAeKEMrzUwSlNIvfS4+HqtVtAcNazVukxJEAdPydTuYXQM9NOuV9wT2M1MlggrP/y0OGwwZiYj2HPKk+L0z8hywv+GBVQ8bUdM18FflTDeYVbEfqtMDTdK9P/GOE+z9fwdetRQ+x52eFH2YeR2M4H9RbIWQDhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082826; c=relaxed/simple;
	bh=+3gXC+OUGrttxQjNxnrmV+KRMD9spkRxLvYcC7eZAwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qizDgZuM0UArNul9369371+T4LCqlU6iJA9pbIV6rTgzrIJ2USk1oMrU4bfZk6Ylu4aa5fEdTGLO6Kbz4LeB0L1irWWd7NLCw6IHBn483vaFVaa5yRZXidO1VoAgl2cLonOJTAzOPsHAqp/IlpV+URcPIE3WM4sHMGH+SyLvBPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5p8nnF5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af949891d3aso840681166b.1;
        Wed, 13 Aug 2025 04:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755082822; x=1755687622; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+2MgRxKtKDHXWfk6f/P6hEAfTTptZtl+AlJvXaWoE8=;
        b=d5p8nnF5D0UEAAA5V4Gu7wSygTHIl7ZMEMf1UrjMSqdjYte6NLck3W3AYUKYBaUVLm
         ltzB8oGsmZXlLxQbBoT4iRz7EYJvZDUQSlubXURhe96EAJWEGoF03vPTXwwBU7keYVZZ
         vbF9JkbuxU1UKJsuNiRbIBa1jb6TqCsrkTgqSz8sdrqyHCm8hEK6ijU60uQHFXHN0abN
         wkRO1e6fd3YmCOh57cPnRhx07ZxrcvnFSTMLJ+AJ/3aPpRdCM+ud3vD66aHAOHV7+1qh
         uWLarNlfpfNd8JsJtASvsHwhJcSVpdAnUFQ92tC34s3aDEv/OuowCty+xhrQvP+gquVV
         OB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755082822; x=1755687622;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+2MgRxKtKDHXWfk6f/P6hEAfTTptZtl+AlJvXaWoE8=;
        b=eNUKRqjTREwA6S+T51qdPrnaZDdxdhEJ/9ebWrqzqS6fJFFNeTBSRrxuob5cIO7w0h
         iTzaIqovPgrH2m62eQc50lPqt29Bzd2zawtAcjxo1OBYIg5aatVI50LCj2Xo1+pEGvN7
         mU4qCSOoJ3tnrkjjyyb1dMJDY2AkaV2Moq3620XOMG/xHPx+Xzmg7WCCTC5biZdQITAa
         5GTPG69Zm2sQUkMsWksExmKfVOkiJCj4MJTX2Orxgg2ryZK34zJilzGtykXqqWJ/wpZ2
         +2UKZdVcMoibmK0HKtByKDz1HssFNrjtdpJr07o2bxJj3WHoP9LZnTJCaC0avog5Gvb6
         zCIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+nFolZ3pnW99HeLVo1lFqXVtaClLgo+tlxI+DojxZfpb3RAjKz56fOvPj6wDpBkmlQlonP52HnVE4@vger.kernel.org, AJvYcCU6+bSagLaF6GqCd8wnibzMwk/SJBU83u9HACdoggt+mT/pkeVmAWNorcQj0kkHY37HdYZHhgtROro5@vger.kernel.org, AJvYcCUDClK9uWwcOu0QWBiMu+zVrXvqv39PxzJBwfrdlreWnucPEh0n6hjRWENB8awVWN/QZWoIbITY+1NCHVyd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6L+ZwqamSFFSRLcHqpSuB2uewOba3pdPGH9kz5hVp7spKaYtS
	qoulT1fMiHHZ4ArpL3Kdnw0d6uHkZfpdo+geCRcyAnvYDNBqNverlf/u
X-Gm-Gg: ASbGncsI9W8+bEMtmQHyJZYcogi1HXocMfXjDbYsbijChfQe8fl8msejxATv7Vc226Q
	CMC8isaq+z8iIRnn8Mq/IhlaiBVYZR80pyjVb/N0Zqtp3SqiYR5Qz/ckIkezpAMT/v1fLsJwX55
	FeN3ndV34S8w0i3Ifshqm8TrIRw2u677EI0pbYiTrFbW5eQrabcS+Q0fPsubU69NjKyxyFyQC3w
	GtdPW+CXJ4/vgbYlwy++mfNIJOjSdeQMVCUkJgUtpMcO2UXWT01ex4AdHzcj+Y9IA1iFEekDEpy
	/znqOwjtFTWJmC2T3NhDmRCVA14h689tCa35GQ0ataLVYPCZTtlRKHG8wbVpBUjC1eApaBgDS1d
	DVTIsFppmrOrWwFPP+c4PzmoPcUkK8l0s0exLukYKM44pkZywL3LbqQSkXYVbeq78RRPnLUdLvR
	yyG3q5
X-Google-Smtp-Source: AGHT+IFjOro9467OEyMI/W2I01Woz2Ux1Tf4CSfsmNe+ZdoGRW1ROPjzS9YFPh/RmIJFSZt2ySWbzQ==
X-Received: by 2002:a17:907:9801:b0:ae3:6f35:36fe with SMTP id a640c23a62f3a-afca4e43bcamr236802866b.47.1755082821601;
        Wed, 13 Aug 2025 04:00:21 -0700 (PDT)
Received: from tablet.my.domain (ip-31-0-121-4.multi.internet.cyfrowypolsat.pl. [31.0.121.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0df10asm2377046966b.59.2025.08.13.04.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 04:00:21 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Wed, 13 Aug 2025 13:00:08 +0200
Subject: [PATCH v6 2/9] dt-bindings: clock: brcm,kona-ccu: Drop CLOCK_COUNT
 defines from DT headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-kona-bus-clock-v6-2-f5a63d4920a4@gmail.com>
References: <20250813-kona-bus-clock-v6-0-f5a63d4920a4@gmail.com>
In-Reply-To: <20250813-kona-bus-clock-v6-0-f5a63d4920a4@gmail.com>
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
 bh=+3gXC+OUGrttxQjNxnrmV+KRMD9spkRxLvYcC7eZAwI=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBonHA92e49EbzEuG/Cda57B6VEac13NXUUJTprP
 JPFrm6TMFmJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaJxwPQAKCRCzu/ihE6BR
 aP9cD/48iYmKyR6SYUNzEVA9jbZ2O9h12s1C5tuGN83N4mmi3FLN1bo/o4FdlOFAsPxHw2MN5Xy
 4ypgY/swakHPpo83zBjyRa8TpO8kK7QiR+9RPbl1uZ5V8Dj8MGnvCrDdcFSM5CfecPovUgE8Tet
 ZCF3thdVuk5gGG9UsvNQEo2OU0TsYgqNGWasiJBeKfznrPqSehsMGh9ChbxGICd+kYKd6FjucAL
 z/fJ6QXhzfVTa2iMc3X8DfAiLWeE4dWT6ad0PY51vtJP2XBdw2HW08ZB+lecG9dEpKxuVjxo+8k
 E2PLLpEHOkaLItQrwBg6Phdbdx+VrPw5G0m7JbHAfPQDNoCe4cRdIK5u4SpfPTwWMe3F11n/6T5
 cWxsqpaljKd4U7krEEtoX+oTvx+s6oMCa/xLutUhyVN5mzyJfRCZV32k4eaXWmbpvRssMxloOcu
 WQ5eqmdjv7rOZteaZhLhJ7EZKKWwaFv93Udl/ivAG3wxqB+sObuWmlz0EfrvsJ05yhdymj1YRxg
 sHm9yNocBGFrrl9Lhh1nazcnIG003HZe7/OtIfm6qtvcj5ahIVjH8zQSMMjAxrzJTvHaNxaCs2e
 TBv8RApc2WodRfS0tdcOYm8D00l2gm7ATL2xnMKcz8DDSKqoa3M5Atenz96Rjt9Kxt6Ne/vJ4tG
 zF0jJtX31KY4Y8Q==
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
2.50.1


