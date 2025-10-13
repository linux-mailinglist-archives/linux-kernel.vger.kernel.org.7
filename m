Return-Path: <linux-kernel+bounces-850592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4C7BD33F3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8844E4EE1D1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10D33081AE;
	Mon, 13 Oct 2025 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pr6SCHuL"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C575E3064A2
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362920; cv=none; b=fVxXHBX1z57Vam0ZiPjdLZkCMqJxHUZL5Raj061bzIJpungg8WkezXIvZq2m1v29lVqpVVRWpJxZ0KVN8EYjkpVPkmkByn7imUZ+IBZ05xF5Y06EvBTpJ6jnDN318QQV8lc69NizOF0IxehCXHaNZtd0gPb2AbMK0SW3W1VPOWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362920; c=relaxed/simple;
	bh=z75QJxLEV0SbWN5Xpt8GE0TnWBRNEzskqUz8wVKyHMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ssFI0ju/mr3p9t7vmFRMPOYW/Zd6rUeyZD5bUIJ7EtpTOPo0ZCe4ANKw06iZ6FsC2g20qns4fiKBHbZaROLbGvcxkB+kIIv8e+aTvTZnpw6E+pSGDK0fRmnXLIm2awU2a1NiIwB8flhKr50aVv2/SoaCjcVk6LCIoRdCPG5u0Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pr6SCHuL; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63bc12a5608so730465a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760362917; x=1760967717; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xl6F1iZ+nTtDNeb7FVvoataOw45pSnmlttNDisOfUsQ=;
        b=Pr6SCHuLk+lCKTRuwPVQdoJSy6LdF2Z+ppn6hJCjMG/RSyILUcJ6N9aLxaFjaNCPSN
         a+vb0fzZdRsFYjVShL7qldZJSuhrhhbWGnZOiU6kj0+C/iypv9cn7giYGB6y2JqCDIcg
         Kf6Rl+yk7YMWmJOvOv3wRE7CoyBjaGdk7BwvKls8fd49Zf8oNwS14uR7xAEzeQeCHKeD
         2dHI/CC8lrrNE4prWmM3miGMp3ZmC/bS9mg3H7hQWqHqB/RY1bExagFX5M0qAAwfHd0T
         6CbcTe6whgaFX4aJxzHkPCD0Rcne+Rze/4pcBx9nU9Qtpk8eEJwEt0c2PPaEW73A9w/A
         UO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760362917; x=1760967717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xl6F1iZ+nTtDNeb7FVvoataOw45pSnmlttNDisOfUsQ=;
        b=hD9eOZf0EoA+lHT7jIvmvsSqJf2bW3DZn9OLe9jIfyJlvpiSbK6veHB6KnO3CBU94e
         gX6n8Vw2YUML+7VOC/jWmjjDnT2FUrt04ZUVD3hYVrSzPWlNPrDKcdwlQT7+DYEOvjab
         YkAvhd4dO/AZ+E3yJtd7ipDNvJ+Ls/kierAdl91dzSZWkiegNJuVy+NJC5PF4EH2DGte
         DgdvkzkYBpUSkJBGyYGQ1Ewnfm5zExCMkrgY27F6Q053uVDQ3XqWcka7pPGgoETdWC2W
         IlBrErzsnAUVTVpph1mrhZhISWqkXjNP+Y3sb01+4NUjnCLRs08EnOMUTGXse4DsvtYV
         MssQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWELWMOiqoSlkviHBWY8BmYrSR4pvI7vcVzn8TCPvMEtQz+mVNVpUX/jLaPYgJopKtshPOnnHAdsi+PCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy84g+UybSwjRPDYJTasMu2xPs3ePxU8Kn81MuyBJfc6KDOFw4V
	6eovYUhGEkV29n4+H0hxBQAw1F1xjp7gLwRnT7J43k6gQxyEoeqFs+I/3A/EV1Nj
X-Gm-Gg: ASbGncsE3yWVMiKSDBAYHjLt/j1G/7pH6CEIGJ7sPL0PgbRzhoxUaDTXCI3CpCD7SK6
	eRB1CfRRYB6LTz73F67ckbyDkcX+J+QzFLLHFx7eIoECIqtPO4oiirwrXv4KFnytY4xztlwWRKu
	HePUmV3d10WD/wAAaBVBUL3FRXKQZHjcqPZrvOf1lwjKleDpG/uoYNoeCouiK5rLJyITg+CZfV9
	345n+gwIdM07LrvcARdakstEA2Hw7HHhZkdaa1W3+HX63TSWJoLbC75QnbEN8DMjU51S9ZztuBb
	zxSyrNarhrmFscy7PxxflMTlhkoEzF157NyKsKWJCBQeZWdJtAWX4xgiTi2oE9NP9IQnHiVKcga
	HWU2jfXO0R15c5U+uuVF2v812vBWpq4vMGb0cou6nKnpZyzjPcyBdKfsOVyoUb2+7qwox63oF06
	oEyiBswG8oFsL3sOyPLTQPhZw=
X-Google-Smtp-Source: AGHT+IH1R3LHTRzGleUVMZwJjjGd2hp2PO32KdCWlPdImEsFvM0BjsAVI0pE+77toFSrcdThRY8QDA==
X-Received: by 2002:a05:6402:42c6:b0:639:ef26:a015 with SMTP id 4fb4d7f45d1cf-639ef26a351mr17316622a12.23.1760362916889;
        Mon, 13 Oct 2025 06:41:56 -0700 (PDT)
Received: from tablet.my.domain (83.21.75.22.ipv4.supernova.orange.pl. [83.21.75.22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c32249esm8729019a12.41.2025.10.13.06.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 06:41:56 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 13 Oct 2025 15:41:48 +0200
Subject: [PATCH v7 1/7] clk: bcm: kona: Move CLOCK_COUNT defines into the
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-kona-bus-clock-v7-1-8f473d99ae19@gmail.com>
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
 phone-devel@vger.kernel.org, Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6586;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=z75QJxLEV0SbWN5Xpt8GE0TnWBRNEzskqUz8wVKyHMg=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBo7QGf4hJ3fgjKwFX/7o3hjktxSVfcV/Q/jo8cg
 kC+BEfCDCyJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaO0BnwAKCRCzu/ihE6BR
 aKlpD/99hhENXLLXpBuK9pb9P6somzlg12+rIt6+FnH2MKHK7i6y+s31wZLRzguP4L1FXnYSzJh
 BgL/9LR8LFlcaTbOVIX/s7NCiXRIHFEPfceMhScRj4q9PtmVeFl1oU35PGMHBkLe7fIH0pJbSC+
 j4/Ibl1a43ushnOGAAcgxWvcehQcUQSiXqTJCSkoHK/15AcLO0ADeAXrW48K365a5cgpOC1A8pi
 p/f4osfU/TEVvQsOXg0/VJ+rgOR71Al2PaW/Ky2zLlYT5bEQ6PnLHwt5gVu5w4k3kbjEhfFleiF
 R/fHmpWt8f9rXx2NPIq5kWQagpnqN7Fuz2Ga3HrgWcVM1GE8uARBqaNxWLSMuhC58JLYa4tnwm/
 zU9NxuMKqJCyP+TAbrkW6neNA/pTZygKtHQbT+DFF1w0siUhMGuE1T/TUb1B+2oDCznUxlGFDIG
 bqgt3c9JRj5E5Tt/jcr6XTDgkTvgj65zpSu0yeaHqqJo62pauXUxo42EP1haKalH1DNJr7HXvxE
 Q1VAIb+7084ZwVgATJJX3Soe84QxP3csNL+yyQ6GInj5inDrwcu9kF2NDkJoqNSGiZnbzqKWK8Q
 gBm6MIgifl4oeLe4mZ5gcy6hWPhnXZS2tF3/9rf4MvMaKo0ot6+ar3IRNOtP3QhQ9ss99+JbC/9
 kGsTfsTj/zECO7g==
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
2.51.0


