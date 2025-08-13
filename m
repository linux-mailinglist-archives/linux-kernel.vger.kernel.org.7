Return-Path: <linux-kernel+bounces-766533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45059B247CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52B7D7AA70B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CB72F659E;
	Wed, 13 Aug 2025 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emQb+Aat"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68652F6571;
	Wed, 13 Aug 2025 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082822; cv=none; b=cYEsR68cLaDvw7FTpdFVPWZUpedqGS+1iPL20NSaYxoYHsdAlhGMjmv1nsmZB5AH65+1E8QvNJz7xpaAy1O6G6TcsrATNeR792jgo8OYDYucPyQNSR1KQp+6xhE+N2f3QK4cIUe6Dvfl7IErLX4+C5p7VKPSmC6iNDYUFvnn/QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082822; c=relaxed/simple;
	bh=OyUyiVNH1nNJRzK5OA+EFXhH7ke4k69wyUohAzjN7Qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ETAmvrYfusVjqEbojnG6Y1clgAast5yV05QTJ/AVBi3ZS8rnbq9Ci+ptiU1teFhrit6FLvc6+Wjy4Xgx/53TRAx65xPM8Vyo/Gv2mC4P9iT1rPAGvGtiI8FajAgYUei8Yu+pVYeYZOS+njT57Top5hGpsqptwDNaGkxd4gTJBUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emQb+Aat; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6180ce2197cso8235312a12.2;
        Wed, 13 Aug 2025 04:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755082819; x=1755687619; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMxZP0Gqr+LI7kYspfoImpeTf4WZO3hif0vxeFkbU8Q=;
        b=emQb+AatyoXqBaJ2y1wxC4mPM7fnJ30Xjdl6p+hyiErjYiGlm6Rfa4KKU1Fk4MQbsP
         asHTAAEf5tTUjRh9sQkph1fZG4T2QpHBbARUFEuixJ6Ux5fJw87g5vHYXTrhmy7OZGXW
         8Kbm3e5+/6p99kUKWYFK60SF0MEmu/rAxs+J8cR8rSDOJzPd631hB8aLmSnTDaOjtmAV
         fPGB8XTldweToGVNsB18arhwlGDgIC8v5eTnpkopefZir4VAg78Be8G5Zwdk4Cft0jly
         ThoMdBNr7v18/AKrRGnmzPGcrI62jfG7VoP/RFInA+7FRTGXtsM2B5Dh/fkbHzo8FDHe
         sf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755082819; x=1755687619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMxZP0Gqr+LI7kYspfoImpeTf4WZO3hif0vxeFkbU8Q=;
        b=RwWVtx9LR+gJfoVSmxMEbvrYBc/dR3AQiySYPbOmADORMd8dqbxu4H6iRHiRXBL/rl
         9/TkymMF/dyktHmfFQUQZ/ATMkOgKUHUKgeplKTLtXfaBOQLn0UW450wh8hkBLqT9ztP
         Wk1hBz+1bBObtSYqBybkM4Rl4WdxPknlt5llto7nNyAK0Wp56SGGtXlKz9+Ai6+MLW7u
         1dgCrXRF+py/ElDp9h7t/Q2TlZGdRNS9ctlWFAy7uWVVobqw5yCs23FbYJa+w68Nsjmq
         ObFnk/GrPSs3fhZQt5YnP2Z3Gc03Bkgd4cLSIQ4P8S0xE3V9uFSfXIdzYdhW2lQVmqIE
         sSSg==
X-Forwarded-Encrypted: i=1; AJvYcCWopVaybD0xjodT6yO/9JpV8ydsdp7082Nx8+wVbvM3sCUNbE5sorWkLaKsUTB/8Fng+H3WLlbM+jFF@vger.kernel.org, AJvYcCWs2E5almBDDGYzW84sG7zNcrd7JK2BCkH+FgV48y3kjOmt3SJQAbxTPEsaNT6aJ/FWVcHd/wqIUHAIidrj@vger.kernel.org, AJvYcCWwH/VquQcxjBbbnDnUcFc54BM0Q4nTbZw+aHPOLIRlVyvb3XIQ+o3NOnOoPRhI/G+H3jMn4VcXXrhl@vger.kernel.org
X-Gm-Message-State: AOJu0YwVY5EkvYGemlLQwTNLzzhHcwWTsaT6YeZ+gyTLI2MV4trW1nEI
	eC6v4NnLZplzPQG68M43iVxENXm94MdHSDO4+/L2IqfKTG6gc37VKl2q
X-Gm-Gg: ASbGncvFwmCgYzvUXLF3vcR330YflQZlY+ThilxnvYWgnCqN44uVzZ5LxMV31G31kbg
	V3ORi//kD8fBuVGlrmZ46Gt9EYhZSrP13XyRgsR2QOWN2SPy7GfJfvQz73+/wT99xW4jwAPd6AC
	MS5BeXpEYBgBHBJfyhgSbHCUr8qDPzj8xaDrgtxTC9nPM3lUGAVjCcutIgK7BLdgGeU6OeCcLY5
	et2osGqMPmJVwjLuDIkXQm3I8A+3tLXOB8UhEEsY/erJ6rbwhCP2oQ/pk+woF89voFgUsSkG1FQ
	ZhPLG5TwpxGuK8fis4FX/hK3nYnXXa8MoN5RW28ag+Dg595UoyGqhYL/1xOnIwEesHTRtHnGi3g
	n/aUkdABramweIgINTDSZ9cY+mC9VyHEkdSrTXEnIT/GX12wtbUPb6by/kl3W7spF2YLqjOBOV4
	ktajQd
X-Google-Smtp-Source: AGHT+IGvq7p7zrwMDXk6ZX7lO2oP01JqYVpmGN3l1U91UMYaxQy9DeOubajdOB6pcLNRW2pBrhv2eA==
X-Received: by 2002:a17:907:7e93:b0:ae3:6651:58ba with SMTP id a640c23a62f3a-afca4e0afd0mr229812766b.35.1755082818984;
        Wed, 13 Aug 2025 04:00:18 -0700 (PDT)
Received: from tablet.my.domain (ip-31-0-121-4.multi.internet.cyfrowypolsat.pl. [31.0.121.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0df10asm2377046966b.59.2025.08.13.04.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 04:00:18 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Wed, 13 Aug 2025 13:00:07 +0200
Subject: [PATCH v6 1/9] clk: bcm: kona: Move CLOCK_COUNT defines into the
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-kona-bus-clock-v6-1-f5a63d4920a4@gmail.com>
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
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6691;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=OyUyiVNH1nNJRzK5OA+EFXhH7ke4k69wyUohAzjN7Qo=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBonHA9xM6Wt6D9eU6TsSE9GmrueMWf4cY84bCUO
 Cdx5DUVo7WJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaJxwPQAKCRCzu/ihE6BR
 aPQvD/9b+THxS2sbk81gNzVeVawjioZ6+EZxprycSfblHpC8h80Ofy7OFDpOgS4HITERjGYopwv
 XlWFg5KFcrgudwIo9ggTITeOpkoqLw4IflgUZA8im7DokVZuUssBY3hNltBfLnp06VoCwjt7YfU
 DJKvLI65b0wMhimm4dmSyKOQ2CcfArRethxpvtPAtETgo3L8z7naL+XyKPe+Kimxaj+SSJOkQ/R
 T4C/pIBPBQJ7WYmO4Fck2U+Ms78Lbb7d2RTrXeRTgC62RBFwpp2RCjgujOhk6OTdfPmFUqqy4i6
 uQsIf0kF+m9N95cUMQyWLGXGHeLi7MxVqV62211rW8tNjasB5rHrqXJIb6xAd8zUdTU33WLSjoP
 nq1QmR6tQhm3VH1czz8EJ/ZTV1J/T2uW2IZi9n3Y5copaxnM7AYw9K81A6ZGHCMDghZSuktdEiU
 khzw7seNCBUXQ0O7hzsF9l0nZT+A9rTIdIXD9cW4NH1eYfgeY8E/6uX6s0yGLjpGH2WDq+aOnn+
 mN4+lXC86CUkm4k5G70XgVu/ETuSDrBbJP16ekN1iXtMWZl7cdZBoJCo+M7GSjKVVBU+UkJrPr8
 5GwBELBEz16IPITbEueH0g06wrB4fPUvGXJu5vsjxgQ4f3C2jCYbb3sx7OltOXTaIEKWszM1fo5
 hImyyTOn6Hy47Yg==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

CLOCK_COUNT defines for each CCU are stored in the DT binding header.
This is not correct - they are not used by device trees, only internally
by the driver.

Move the CLOCK_COUNT defines directly into the driver in preparation
for dropping them from the DT binding include. To avoid conflicts with
the old defines, rename them to use the CLK_COUNT suffix.

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
index 520c3aeb4ea9c4a431512c0909f9545c1761d17a..14b7db824704824b4a6bfcce79308afa44e092c6 100644
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
index 823d5dfa31b84f502fcd6ada1eff6d8f4673b3dd..62c3bf4656259261ae4f7d81dae48c90ab26c04e 100644
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
index 348a3454ce4013e4e2b06b9542f5895a8397dd8e..d7cae437333c83e05b2960ba8d51e718480e6155 100644
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
2.50.1


