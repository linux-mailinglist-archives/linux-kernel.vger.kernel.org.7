Return-Path: <linux-kernel+bounces-795125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAB1B3ED19
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B19E18928E8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3555B32ED52;
	Mon,  1 Sep 2025 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEhB2dob"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4465232ED2B;
	Mon,  1 Sep 2025 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746499; cv=none; b=VbFqU2guy8YkMeqLpsEDAK+8EIImCCx3mIY1VTfowRhNnLmUHz26iuwMz11ErzDCAmlpjzOVl8ZFpHQX+fUMRGFJsWwdA0BdWHTFhFW73wxON7j59KzQKzZr+t7dWz7FEvRNARB9+JxfaaXbRNk1tARSJ5C3rMfy7kEvseDm0AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746499; c=relaxed/simple;
	bh=rAUdMtcRiLbim32aOQhQ2A3bEX5/AhJM2y49j/dPDQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ddS3yXGgQzVncsyVTHg+H2GyEkjGBv1grv8VhXwtyDR0t3BeZLxCESLV/dd7105YTiv251zZTaOV4t87rRdYIJqyDXS/TF8KjZGvAB/wkC0mlqY603Bev0xKf6vkP4EhkqaGrLy7cQEM+CxE518vRN2d8tofZoBnMxtQ51PF5O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEhB2dob; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f7ab2a84eso1292383e87.1;
        Mon, 01 Sep 2025 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756746495; x=1757351295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ez718thJEgBGVPbjA/5JBbctzFxEgtajT6pnvZZIsFM=;
        b=lEhB2dobDeLfqyzQDt0DkX8q0Ttkdh20YjybfclWnvlekOQ5fz/bMBv8j/vwf6y/Wy
         Dil2hIzpTR34Uiohn5MUW2ZdczNfCXbdtG+O4yMeZAeKRNfi1f8t5beIiFEelvIbtPxd
         lhzfqfJl4v65jSumhCuqtutgtEjVgfW+2ukPc4vC6TJdao8SO5UmxHdKH5AnoAsVTrFa
         hAA7FoyUV/zx7aoo/UsFFs6XuId6jIUvb+vwssfShHHrlXEQct6KbQgKy3K+hdE/O8H8
         NRQ1iCTAjiDQzGwNDpBHjN2rh6GRWfOc1I9aLWaOg7oSQP9FrtEgBOnES1Ny/adnHNsz
         QiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756746495; x=1757351295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ez718thJEgBGVPbjA/5JBbctzFxEgtajT6pnvZZIsFM=;
        b=OAE/BQZoBI+oaNVurf7hR9XaVNYyeR7Ekug0DBbX7p3ERrsgOZyMBDNEfo/8AAKMSM
         ioTwxhEFN4cH0/GAzBPfyBmaelhqTBoy/E7KPhy2d+HLGZCrpFVHcNLpENxi0nBlC7uC
         NzPE+whNHQVR+S47FuzWPiAxsZMO8R6iaf4uM79LfFS7PY7OMhJ9KCETR6FKHvv8kmQt
         +ZQs+eHoA1bOC8F91A/OwO1fln8qmuYofv9suTgTJVFMr+sPzk4NLkZ4hljJsbxZGc0K
         57FXu2ljek2kOb2f7WrgKVA5zDpF88uklzwWIPH97fTHAl2aWR7aStSUprt0+mGMmwT9
         oCNw==
X-Forwarded-Encrypted: i=1; AJvYcCUKvsFBhvhSm5fPNbH7kZMjmGRX3TiSI4WURqaiv+nlp4AS+LI1D5SQUxP03r3rOOZvaNYDjQryEssdvvpL@vger.kernel.org, AJvYcCUmfZ2c7Ip7BkOnBIO96iNZJB5fgQAV4pMqTrXSmLmgy533vb1H7p4ajkquELwzKSBL1q0jMP+Dm3oA@vger.kernel.org, AJvYcCXy83PFiJrr0W+yD8mzuVclWGmYK6SabFck94XKFLiPRX5CmfAV2FYepmbj3HC7WWgNyv4GyEaE07DI@vger.kernel.org
X-Gm-Message-State: AOJu0YzCNR2RRrW11lnTN1ORmEARqWHkbQerH15n+8SqHUuO2v2AaCL1
	IiSEVPNPFm7kXbQzXxTFVYU0goTT0IiGMofkjm58TV1Iv6pPl41bTrNe+JTlsQ==
X-Gm-Gg: ASbGncsKRFaMOcIQRNhRAkhyMyVJDfst1wgRzcVENxFZLB1omtsqP+uhqo5VZ9bSOPh
	Uy/g2Sl/G7DkcW4yDxlrAyhj+hkvRs3JLpt45iz6vypkPZ+Ep5Rhgqd51u/VJJIGozxTmiJ77bn
	JKs50GiRi4ry4BTPp8FJ9Azd97fkEsqo3pmkGPrhx5KfplohYrTE0oKNy3+7Y0L4bEYJ6LOz62o
	fum6Why1rAwTiKXg7CKqG9rvcTOZftZhORXXxVYgpxEVYwGFXL0OOvzLAdjtEduS5uSAtTKPEL3
	jCL3eAkixCMi44ZSKqg+QEa4pKjEaI4HMSttv7ApbmOwCMHIthjvlmvlugAUK7wal10H7A/n/wc
	UufmUfsvgD7herWMWa8O/ux18+UaTYdx7Fb4=
X-Google-Smtp-Source: AGHT+IGkpS32lklXD/lmEr28JmUgh5DF7U83AUzY0TCMmOlDGuNFhdtJfvo18Z6/V6X6CkVguIgn+Q==
X-Received: by 2002:a05:6512:258c:b0:55f:43ba:9410 with SMTP id 2adb3069b0e04-55f708b4592mr2402339e87.15.1756746495041;
        Mon, 01 Sep 2025 10:08:15 -0700 (PDT)
Received: from tablet.my.domain ([2a00:f44:892:8a37:6b0:21e7:549b:225b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f7abf7abesm1137666e87.55.2025.09.01.10.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 10:08:14 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 01 Sep 2025 19:07:12 +0200
Subject: [PATCH RESEND v6 6/9] clk: bcm21664: Add corresponding bus clocks
 for peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-kona-bus-clock-v6-6-c3ac8215bd4d@gmail.com>
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
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5067;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=rAUdMtcRiLbim32aOQhQ2A3bEX5/AhJM2y49j/dPDQ4=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBotdLKISn5Xn+v2JhuoOBbaD2kE8qnEpb7s8ddI
 ulN3Ym9gViJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaLXSygAKCRCzu/ihE6BR
 aNF3D/4mL3It9Oiv4ExStahRWgDaCl5Rkukq9zokxYOELYbmitZd9wiYGeWEHg+4ZLVdoDS5byG
 mATA2VK0BCLHHv4zUwinu0cail6+6yMlP003bJcnBqY6Z9iP3nWMagxWcLZD54UlzsEFq/L9w0R
 FjlZ+DSSV+zV+qFTRNlNOx5fGTP5eNTALXis0OkdD0tJhTJl/a7GzpoQzjnpV181ytxrVp4ni2+
 kyBFbunn2ghHSiLyb/I8LLCpWAMkL3kTIUyXo/4fJKMUM131ED0Y0pH7FSmB/Ek4kG+Z63x1vpe
 6+sA4POM5qCvP1k8dFyrK6kJdeN4Ia8+7mLMs8zkjV7Gxd1DDIc32FMZ0zqwL5dI1CPkl4Hq7EJ
 eTrrZXxrcIN5yBk2q8DdXmHcmJjdpNdDKAwtPQ14G3zWwJVTB0JiWeak0oSxljX+rOW7C9mVmvn
 URuRkxHkV+U5BwNBMoNIzBMmuRKN9JzuMSwX3HeTM8ftFnuleHalVAqdKyoKCdQOaLXsTq1v+CR
 wlPTPQq7qkHDast99zBQkrUaj5V1zvHDeXUlE3RAjpVjxalDCyr9pBmW7KLkM7E1kSXw5oCHASd
 ithBgEqGIE1/oEICodpdhLmGiT/GZfNcPQiiU2RR+Z9RZYVKIsHb99XItxMaTGIm7e+21B8gyMh
 Z7wh9f9x6jC9qfQ==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Now that bus clock support has been implemented into the Broadcom Kona
clock driver, add bus clocks corresponding to HUB_TIMER, SDIO, UART and
BSC, as well as the USB OTG bus clock.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v4:
- Adapt to CLOCK_COUNT -> CLK_COUNT rename
- Change commit summary to match equivalent BCM281xx commit

Changes in v3:
- Adapt to CLOCK_COUNT defines being moved

Changes in v2:
- Adapt to dropped prereq clocks
---
 drivers/clk/bcm/clk-bcm21664.c | 89 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm21664.c b/drivers/clk/bcm/clk-bcm21664.c
index 14b7db824704824b4a6bfcce79308afa44e092c6..4223ac1c35a258bd30ba2bd4b240da6b1e88fa06 100644
--- a/drivers/clk/bcm/clk-bcm21664.c
+++ b/drivers/clk/bcm/clk-bcm21664.c
@@ -41,7 +41,12 @@ static struct peri_clk_data hub_timer_data = {
 	.trig		= TRIGGER(0x0a40, 4),
 };
 
-#define BCM21664_AON_CCU_CLK_COUNT	(BCM21664_AON_CCU_HUB_TIMER + 1)
+static struct bus_clk_data hub_timer_apb_data = {
+	.gate		= HW_SW_GATE(0x0414, 18, 3, 2),
+	.hyst		= HYST(0x0414, 10, 11),
+};
+
+#define BCM21664_AON_CCU_CLK_COUNT	(BCM21664_AON_CCU_HUB_TIMER_APB + 1)
 
 static struct ccu_data aon_ccu_data = {
 	BCM21664_CCU_COMMON(aon, AON),
@@ -52,6 +57,8 @@ static struct ccu_data aon_ccu_data = {
 	.kona_clks	= {
 		[BCM21664_AON_CCU_HUB_TIMER] =
 			KONA_CLK(aon, hub_timer, peri),
+		[BCM21664_AON_CCU_HUB_TIMER_APB] =
+			KONA_CLK(aon, hub_timer_apb, bus),
 		[BCM21664_AON_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };
@@ -126,7 +133,27 @@ static struct peri_clk_data sdio4_sleep_data = {
 	.gate		= HW_SW_GATE(0x0360, 18, 2, 3),
 };
 
-#define BCM21664_MASTER_CCU_CLK_COUNT	(BCM21664_MASTER_CCU_SDIO4_SLEEP + 1)
+static struct bus_clk_data sdio1_ahb_data = {
+	.gate		= HW_SW_GATE(0x0358, 16, 0, 1),
+};
+
+static struct bus_clk_data sdio2_ahb_data = {
+	.gate		= HW_SW_GATE(0x035c, 16, 0, 1),
+};
+
+static struct bus_clk_data sdio3_ahb_data = {
+	.gate		= HW_SW_GATE(0x0364, 16, 0, 1),
+};
+
+static struct bus_clk_data sdio4_ahb_data = {
+	.gate		= HW_SW_GATE(0x0360, 16, 0, 1),
+};
+
+static struct bus_clk_data usb_otg_ahb_data = {
+	.gate		= HW_SW_GATE(0x0348, 16, 0, 1),
+};
+
+#define BCM21664_MASTER_CCU_CLK_COUNT	(BCM21664_MASTER_CCU_USB_OTG_AHB + 1)
 
 static struct ccu_data master_ccu_data = {
 	BCM21664_CCU_COMMON(master, MASTER),
@@ -151,6 +178,16 @@ static struct ccu_data master_ccu_data = {
 			KONA_CLK(master, sdio3_sleep, peri),
 		[BCM21664_MASTER_CCU_SDIO4_SLEEP] =
 			KONA_CLK(master, sdio4_sleep, peri),
+		[BCM21664_MASTER_CCU_SDIO1_AHB] =
+			KONA_CLK(master, sdio1_ahb, bus),
+		[BCM21664_MASTER_CCU_SDIO2_AHB] =
+			KONA_CLK(master, sdio2_ahb, bus),
+		[BCM21664_MASTER_CCU_SDIO3_AHB] =
+			KONA_CLK(master, sdio3_ahb, bus),
+		[BCM21664_MASTER_CCU_SDIO4_AHB] =
+			KONA_CLK(master, sdio4_ahb, bus),
+		[BCM21664_MASTER_CCU_USB_OTG_AHB] =
+			KONA_CLK(master, usb_otg_ahb, bus),
 		[BCM21664_MASTER_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };
@@ -231,7 +268,39 @@ static struct peri_clk_data bsc4_data = {
 	.trig		= TRIGGER(0x0afc, 19),
 };
 
-#define BCM21664_SLAVE_CCU_CLK_COUNT	(BCM21664_SLAVE_CCU_BSC4 + 1)
+static struct bus_clk_data uartb_apb_data = {
+	.gate		= HW_SW_GATE_AUTO(0x0400, 16, 0, 1),
+};
+
+static struct bus_clk_data uartb2_apb_data = {
+	.gate		= HW_SW_GATE_AUTO(0x0404, 16, 0, 1),
+};
+
+static struct bus_clk_data uartb3_apb_data = {
+	.gate		= HW_SW_GATE_AUTO(0x0408, 16, 0, 1),
+};
+
+static struct bus_clk_data bsc1_apb_data = {
+	.gate		= HW_SW_GATE_AUTO(0x0458, 16, 0, 1),
+	.hyst		= HYST(0x0458, 8, 9),
+};
+
+static struct bus_clk_data bsc2_apb_data = {
+	.gate		= HW_SW_GATE_AUTO(0x045c, 16, 0, 1),
+	.hyst		= HYST(0x045c, 8, 9),
+};
+
+static struct bus_clk_data bsc3_apb_data = {
+	.gate		= HW_SW_GATE_AUTO(0x0470, 16, 0, 1),
+	.hyst		= HYST(0x0470, 8, 9),
+};
+
+static struct bus_clk_data bsc4_apb_data = {
+	.gate		= HW_SW_GATE_AUTO(0x0474, 16, 0, 1),
+	.hyst		= HYST(0x0474, 8, 9),
+};
+
+#define BCM21664_SLAVE_CCU_CLK_COUNT	(BCM21664_SLAVE_CCU_BSC4_APB + 1)
 
 static struct ccu_data slave_ccu_data = {
 	BCM21664_CCU_COMMON(slave, SLAVE),
@@ -254,6 +323,20 @@ static struct ccu_data slave_ccu_data = {
 			KONA_CLK(slave, bsc3, peri),
 		[BCM21664_SLAVE_CCU_BSC4] =
 			KONA_CLK(slave, bsc4, peri),
+		[BCM21664_SLAVE_CCU_UARTB_APB] =
+			KONA_CLK(slave, uartb_apb, bus),
+		[BCM21664_SLAVE_CCU_UARTB2_APB] =
+			KONA_CLK(slave, uartb2_apb, bus),
+		[BCM21664_SLAVE_CCU_UARTB3_APB] =
+			KONA_CLK(slave, uartb3_apb, bus),
+		[BCM21664_SLAVE_CCU_BSC1_APB] =
+			KONA_CLK(slave, bsc1_apb, bus),
+		[BCM21664_SLAVE_CCU_BSC2_APB] =
+			KONA_CLK(slave, bsc2_apb, bus),
+		[BCM21664_SLAVE_CCU_BSC3_APB] =
+			KONA_CLK(slave, bsc3_apb, bus),
+		[BCM21664_SLAVE_CCU_BSC4_APB] =
+			KONA_CLK(slave, bsc4_apb, bus),
 		[BCM21664_SLAVE_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };

-- 
2.51.0


