Return-Path: <linux-kernel+bounces-885011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C51C31B2B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A597F18C0792
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31F8334691;
	Tue,  4 Nov 2025 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3a30MOR"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFA0334C23
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268311; cv=none; b=dBFQeldYYMXNjOXUdEzJsK3qwSfDAe4FTIZUQ5QqLASMzGgks+RuyLL6h7nd4u9KSQDcVaFTklDhd++ONzUaorp5lBEOyiPvhH2cWcBuXbHWKjyn52kcS/iQfxkjnD7cN3i07P0Yr8ZaJ6M6UO+NVPfiHIWPZRfMlkAF3CIpFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268311; c=relaxed/simple;
	bh=Pth2Uzo1gzhh5BgeItKlIlc+tS4ImCHocJjvX3QMVOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kq3/FF2EPTs7UNZkhOto/mLNWawW6pRK2R0kI5/Od+MdnMLdbIUctwUp5Eh0rsfloxIRS7RNRF4YbOcRf/NQJMAuiiy34UGzC9hnS5r/B3CXsUnWsNJAuVmFU7insfJGoTTRAFng2sFBFRVkx6Ji27SROURBrTxc5ajk2XIirAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3a30MOR; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640f8a7aba2so522497a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268306; x=1762873106; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49FY2zVqI9ZeKrIZlBhUVkh4m9OzOZyEeEGZ8bRpxBs=;
        b=O3a30MORdFb8yRQFfk6YXJ97BSS5hT9Ed9nAfvgRRvD7x5pvQpAhTqu1GUeWQhAz5B
         KVdRNNeiZBqrr6vD7rhF7QfbYH1lWTiz3p6H8DClncw72Ivu3iPw4Lyn/yIvRy2I7z0T
         /+pmXKjNAOGX98vTlGmc1BFAD7q+FHTN0afWZmfTReqxAY8tov5aaZpMRx1D0RMxQY/J
         qpkCh6ddxVUHgUg42S1Y3OawOqK00NoEmQnpjmiGqe6A7M+Y20WMBzHZJKjEg7Ew4vEJ
         vpL/4nB8wZmqiCcK8bawwy49OLH0AyqTPTCHjuY3CD2477VdJ8LBXP27L8B90KlWaQJh
         LPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268306; x=1762873106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49FY2zVqI9ZeKrIZlBhUVkh4m9OzOZyEeEGZ8bRpxBs=;
        b=MIFEGv/T213NiQWE+rvh1X++P1so8L+yZ7wofEK2w9rZ7VNtv2DUTWYSReHUrrHyv9
         YX9wYCvRAO8C/IUGSEqSeyRMLpqZZzOEHSFs2MzX4NQX+XiAf4T7MYnqkqrWsI/J45Iv
         MnVlMEj7Z/XqUgxQtlWz8GDEJE5tFX3cTuOr8y+TpzznZgrzmSwylCsT4DexVNQYuTAZ
         18j484lki9sVPZpRCZEFUb4Pif6w4ipQbDs57Qlvhj+ZgiT4zl80xxgmu/FwWNOeEX+F
         xHNJD1x2EOMX3xQoABpD5ZyUgVTzIN3VxVQQSQCiBi27ioU/5Gt91V3RWBr46g2y5YhU
         LwHA==
X-Forwarded-Encrypted: i=1; AJvYcCVL+vuSsONoPLlAS5ZTFhHQb3+RdGkwdMemNf3i/TSVoywBdzligBq/+0HyrsWHsyHoP4LJ2cx/flSln20=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfB/N5gNTrQt+9kEZRY7RH6vctm0rwtEdPb7XYkaVWKWjML62w
	ecvcqWesv9q1B0aZGs9U6qgJ5qDMCVCPng6TtQCqRPXgZkhFNR7MiSY+
X-Gm-Gg: ASbGncvbt1xSLt0AKoBMqZUbkedMlZo2NQwKyiPID1VhNs4QxRo4aSgD2ShgZX4BI6D
	sj/k5PQPfDTJaWnQvEMrs3aSKYv+rP70CXytSzHSEJ1Xis0jTGKmaToS8g0X1GC6OJN4BAe2mtV
	gdDffb5G3wtFadPWZDQj4BSeKyrfQJ0gCdImpi5qxwCA6nrKovMwwJ83TcMPIha2wV553t0baOW
	xNGEsZK0l5Ww7tJCqaWhSg4DJheNc1K+GUxq/8G79HMpPxMehgOGPagKU3jAtjYkybpQVs17Me8
	m0KUpXYb3KV2SFn2+I34sXU5l5wEVg9Ov8kbfAJ8wiQxK0w3d6OjTlnJDc9jOqaprBpEogG6FK/
	89LPWvrC2iQdppr0ElciJRBswPDtMZa45oeyfk+dKzEQvV7FfITneq1UcRVDuAbdstBucgQdz4K
	IdSF8VSoUgctjYyUzcUGjsq8Z+wAJxS9/v04eIaeQRxMz8V1E=
X-Google-Smtp-Source: AGHT+IGhPjYnI2dd4Y8tgVpYrusguuiQEaOFUSTzgRXBxGOGzflATdcavzKwVGBwCMd5j0FypdvmLA==
X-Received: by 2002:a05:6402:2350:b0:640:7529:b8c7 with SMTP id 4fb4d7f45d1cf-64076f710cbmr15166855a12.1.1762268306022;
        Tue, 04 Nov 2025 06:58:26 -0800 (PST)
Received: from tablet.my.domain (83.21.17.47.ipv4.supernova.orange.pl. [83.21.17.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a7fcd7sm2288874a12.37.2025.11.04.06.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:58:25 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Tue, 04 Nov 2025 15:58:19 +0100
Subject: [PATCH RESEND v7 1/7] clk: bcm: kona: Move CLOCK_COUNT defines
 into the driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-kona-bus-clock-v7-1-071002062659@gmail.com>
References: <20251104-kona-bus-clock-v7-0-071002062659@gmail.com>
In-Reply-To: <20251104-kona-bus-clock-v7-0-071002062659@gmail.com>
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
 phone-devel@vger.kernel.org, Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6586;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=Pth2Uzo1gzhh5BgeItKlIlc+tS4ImCHocJjvX3QMVOU=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBpChSNOEyLcilSEETBIZirAou5qm09aAf8xYkar
 yv9ZYNtvReJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaQoUjQAKCRCzu/ihE6BR
 aFV0D/98icD+0WcR/TEYPPGeJeKVzdMZjA2VaWFmw1wWQ9j2KtZcV+tMbX0OCSG0csSD+cpaQ7Z
 claxEfFqoKEEJkrOI8Ow/7j0vE/BiaFyLolZlCAvSgh3xhGqgIRG8y+q9586Kd3FJuQ8bt0dLPY
 Mr3zed8MJCa+hdMbkuUTI9xnpmrOHPqfFMDdRQtiK1D+y041Xx4/HutrjxlfTUVdbkEwSLIkb7L
 QLGa6JTn8mXhvqwycR3pxJZLPeR7f0GJfYWCvE7Vf1FD894uNRGYd1SUUaRVtZACXGe9dZqiBxu
 lp3pQyjqQbFbAyKmVs/OGfeGd/o2DofTz/oUPNFG9ebY/dhsPrhIaGrLITzp0AUVPLkw5ty/7Sl
 QEb5Vfn4B5cHuzBWWUHnmkaUVuKxdrrtmD8sMLoF8pVdTEJeUkGAAA5o1b2+GVM5bNOaLcFWRS6
 xVud/NkFx0xipNSDaXAiFL02F+gbRpNRKrm1x/j0+wh0hB1nriNYLYisPlfWNsX4i5zbObtx5SQ
 pidWARuqG6wOGl7Ww7NT8Y8vCKHmA0hr88sxBHv+uq9ThcmYoTy5jOG8oYBAV/Wm6SGqsJQ5VIv
 cuUHdnrY7eRHApxK2i8G2zl8DDEXdTi9yi3Qml2mQdFLxXZssd3d/CWNIdQ7yo49hJSLlApA/K1
 kzCeh7K6tnDf0lA==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

CLOCK_COUNT defines for each CCU are stored in the DT binding header.
This is not correct - they are not used by device trees, only internally
by the driver.

Move the CLOCK_COUNT defines directly into the driver in preparation
for dropping them from the DT binding include. To avoid conflicts with
the old defines, rename them to use the CLK_COUNT suffix.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v4:
- Rename CLOCK_COUNT to CLK_COUNT to avoid redefinition

Changes in v3:
- Add this commit
---
 drivers/clk/bcm/clk-bcm21664.c | 16 ++++++++++++----
 drivers/clk/bcm/clk-bcm281xx.c | 20 +++++++++++++++-----
 drivers/clk/bcm/clk-kona.h     |  2 +-
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm21664.c b/drivers/clk/bcm/clk-bcm21664.c
index 520c3aeb4ea9..14b7db824704 100644
--- a/drivers/clk/bcm/clk-bcm21664.c
+++ b/drivers/clk/bcm/clk-bcm21664.c
@@ -17,13 +17,15 @@ static struct peri_clk_data frac_1m_data = {
 	.clocks		= CLOCKS("ref_crystal"),
 };
 
+#define BCM21664_ROOT_CCU_CLK_COUNT	(BCM21664_ROOT_CCU_FRAC_1M + 1)
+
 static struct ccu_data root_ccu_data = {
 	BCM21664_CCU_COMMON(root, ROOT),
 	/* no policy control */
 	.kona_clks	= {
 		[BCM21664_ROOT_CCU_FRAC_1M] =
 			KONA_CLK(root, frac_1m, peri),
-		[BCM21664_ROOT_CCU_CLOCK_COUNT] = LAST_KONA_CLK,
+		[BCM21664_ROOT_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };
 
@@ -39,6 +41,8 @@ static struct peri_clk_data hub_timer_data = {
 	.trig		= TRIGGER(0x0a40, 4),
 };
 
+#define BCM21664_AON_CCU_CLK_COUNT	(BCM21664_AON_CCU_HUB_TIMER + 1)
+
 static struct ccu_data aon_ccu_data = {
 	BCM21664_CCU_COMMON(aon, AON),
 	.policy		= {
@@ -48,7 +52,7 @@ static struct ccu_data aon_ccu_data = {
 	.kona_clks	= {
 		[BCM21664_AON_CCU_HUB_TIMER] =
 			KONA_CLK(aon, hub_timer, peri),
-		[BCM21664_AON_CCU_CLOCK_COUNT] = LAST_KONA_CLK,
+		[BCM21664_AON_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };
 
@@ -122,6 +126,8 @@ static struct peri_clk_data sdio4_sleep_data = {
 	.gate		= HW_SW_GATE(0x0360, 18, 2, 3),
 };
 
+#define BCM21664_MASTER_CCU_CLK_COUNT	(BCM21664_MASTER_CCU_SDIO4_SLEEP + 1)
+
 static struct ccu_data master_ccu_data = {
 	BCM21664_CCU_COMMON(master, MASTER),
 	.policy		= {
@@ -145,7 +151,7 @@ static struct ccu_data master_ccu_data = {
 			KONA_CLK(master, sdio3_sleep, peri),
 		[BCM21664_MASTER_CCU_SDIO4_SLEEP] =
 			KONA_CLK(master, sdio4_sleep, peri),
-		[BCM21664_MASTER_CCU_CLOCK_COUNT] = LAST_KONA_CLK,
+		[BCM21664_MASTER_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };
 
@@ -225,6 +231,8 @@ static struct peri_clk_data bsc4_data = {
 	.trig		= TRIGGER(0x0afc, 19),
 };
 
+#define BCM21664_SLAVE_CCU_CLK_COUNT	(BCM21664_SLAVE_CCU_BSC4 + 1)
+
 static struct ccu_data slave_ccu_data = {
 	BCM21664_CCU_COMMON(slave, SLAVE),
        .policy		= {
@@ -246,7 +254,7 @@ static struct ccu_data slave_ccu_data = {
 			KONA_CLK(slave, bsc3, peri),
 		[BCM21664_SLAVE_CCU_BSC4] =
 			KONA_CLK(slave, bsc4, peri),
-		[BCM21664_SLAVE_CCU_CLOCK_COUNT] = LAST_KONA_CLK,
+		[BCM21664_SLAVE_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };
 
diff --git a/drivers/clk/bcm/clk-bcm281xx.c b/drivers/clk/bcm/clk-bcm281xx.c
index 823d5dfa31b8..62c3bf465625 100644
--- a/drivers/clk/bcm/clk-bcm281xx.c
+++ b/drivers/clk/bcm/clk-bcm281xx.c
@@ -19,12 +19,14 @@ static struct peri_clk_data frac_1m_data = {
 	.clocks		= CLOCKS("ref_crystal"),
 };
 
+#define BCM281XX_ROOT_CCU_CLK_COUNT	(BCM281XX_ROOT_CCU_FRAC_1M + 1)
+
 static struct ccu_data root_ccu_data = {
 	BCM281XX_CCU_COMMON(root, ROOT),
 	.kona_clks	= {
 		[BCM281XX_ROOT_CCU_FRAC_1M] =
 			KONA_CLK(root, frac_1m, peri),
-		[BCM281XX_ROOT_CCU_CLOCK_COUNT] = LAST_KONA_CLK,
+		[BCM281XX_ROOT_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };
 
@@ -57,6 +59,8 @@ static struct peri_clk_data pmu_bsc_var_data = {
 	.trig		= TRIGGER(0x0a40, 2),
 };
 
+#define BCM281XX_AON_CCU_CLK_COUNT	(BCM281XX_AON_CCU_PMU_BSC_VAR + 1)
+
 static struct ccu_data aon_ccu_data = {
 	BCM281XX_CCU_COMMON(aon, AON),
 	.kona_clks	= {
@@ -66,7 +70,7 @@ static struct ccu_data aon_ccu_data = {
 			KONA_CLK(aon, pmu_bsc, peri),
 		[BCM281XX_AON_CCU_PMU_BSC_VAR] =
 			KONA_CLK(aon, pmu_bsc_var, peri),
-		[BCM281XX_AON_CCU_CLOCK_COUNT] = LAST_KONA_CLK,
+		[BCM281XX_AON_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };
 
@@ -80,12 +84,14 @@ static struct peri_clk_data tmon_1m_data = {
 	.trig		= TRIGGER(0x0e84, 1),
 };
 
+#define BCM281XX_HUB_CCU_CLK_COUNT	(BCM281XX_HUB_CCU_TMON_1M + 1)
+
 static struct ccu_data hub_ccu_data = {
 	BCM281XX_CCU_COMMON(hub, HUB),
 	.kona_clks	= {
 		[BCM281XX_HUB_CCU_TMON_1M] =
 			KONA_CLK(hub, tmon_1m, peri),
-		[BCM281XX_HUB_CCU_CLOCK_COUNT] = LAST_KONA_CLK,
+		[BCM281XX_HUB_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };
 
@@ -172,6 +178,8 @@ static struct peri_clk_data hsic2_12m_data = {
 	.trig		= TRIGGER(0x0afc, 5),
 };
 
+#define BCM281XX_MASTER_CCU_CLK_COUNT	(BCM281XX_MASTER_CCU_HSIC2_12M + 1)
+
 static struct ccu_data master_ccu_data = {
 	BCM281XX_CCU_COMMON(master, MASTER),
 	.kona_clks	= {
@@ -189,7 +197,7 @@ static struct ccu_data master_ccu_data = {
 			KONA_CLK(master, hsic2_48m, peri),
 		[BCM281XX_MASTER_CCU_HSIC2_12M] =
 			KONA_CLK(master, hsic2_12m, peri),
-		[BCM281XX_MASTER_CCU_CLOCK_COUNT] = LAST_KONA_CLK,
+		[BCM281XX_MASTER_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };
 
@@ -301,6 +309,8 @@ static struct peri_clk_data pwm_data = {
 	.trig		= TRIGGER(0x0afc, 15),
 };
 
+#define BCM281XX_SLAVE_CCU_CLK_COUNT	(BCM281XX_SLAVE_CCU_PWM + 1)
+
 static struct ccu_data slave_ccu_data = {
 	BCM281XX_CCU_COMMON(slave, SLAVE),
 	.kona_clks	= {
@@ -324,7 +334,7 @@ static struct ccu_data slave_ccu_data = {
 			KONA_CLK(slave, bsc3, peri),
 		[BCM281XX_SLAVE_CCU_PWM] =
 			KONA_CLK(slave, pwm, peri),
-		[BCM281XX_SLAVE_CCU_CLOCK_COUNT] = LAST_KONA_CLK,
+		[BCM281XX_SLAVE_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };
 
diff --git a/drivers/clk/bcm/clk-kona.h b/drivers/clk/bcm/clk-kona.h
index 348a3454ce40..d7cae437333c 100644
--- a/drivers/clk/bcm/clk-kona.h
+++ b/drivers/clk/bcm/clk-kona.h
@@ -483,7 +483,7 @@ struct ccu_data {
 #define KONA_CCU_COMMON(_prefix, _name, _ccuname)			    \
 	.name		= #_name "_ccu",				    \
 	.lock		= __SPIN_LOCK_UNLOCKED(_name ## _ccu_data.lock),    \
-	.clk_num	= _prefix ## _ ## _ccuname ## _CCU_CLOCK_COUNT
+	.clk_num	= _prefix ## _ ## _ccuname ## _CCU_CLK_COUNT
 
 /* Exported globals */
 

-- 
2.51.1


