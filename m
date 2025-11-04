Return-Path: <linux-kernel+bounces-885018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A9AC31C24
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98B8D5000E4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AEF33BBB0;
	Tue,  4 Nov 2025 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKwD66NS"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AC0338F45
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268320; cv=none; b=vGhK7d+O8Iyso9kqwZ4URjLmBDZndexwYLn5d5ZYtja9JBqjLHaokSNzV01PwGXg71OsWtotbLg9gtvxKO3jxzNfjEXSQlEI6N85KpXcHDKi0bkiGM0u72ypN3UAWX4YBRJufn9013fh8HJ3YNgFKY9IZA1HOJrJQFb0QCZ06OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268320; c=relaxed/simple;
	bh=oaleqb9XqZrB+5VSSVHMl0U9JzcMe7IFlSred6/4jZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=razJ2d/rFhVbd3+0OTHH1dJp+lxWTYTvuvxBG+ZIJSNgwzVkjv6OGGx8Pw4MrgJ+fbVwuCHgc9t2o7OrdLeq+mtqKJOsqnSRWRmo7eUkxhXYpjmq10JovW7zhUgxBteDe804r2VuaYxhaoq1daACB55Um5i+/b/pcPlH//A1OwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKwD66NS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-641018845beso100058a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268316; x=1762873116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YiETutXUQi91zPM9wQrjIsBcMeBokATJ9Dk+OnsfOPY=;
        b=IKwD66NSZQxcY2O0VwmX+GxMiyYD58CyexTGxan7ZtBiXrjO7PI26Y/Nu7aTxUsVsP
         8MkJHtVPZQxwAPDYUbQBNmpAPeJ+yL2ffSTDP8PTX1h87MuVhf5lh/9nwdWe+yiwS0aO
         eufYTujEm+bW0lgynGanwWlj+o+NMuT9vciV8H8WcDkPNwyk6TxIyrdUr+KpAePRx74C
         V/X6t5e6QBUGY1eH0VBHXAQTKDQ+0BY+nhhaFOyMUXAWzmuZi8TadjZOIGcWepYU8gZG
         3k21Yd2/mXbFPbuDxpoFq/UBb52L1gzP9f9WgbbfkchaLX7HuEe8pQlgGnT1eoHHnXQ4
         gz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268316; x=1762873116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiETutXUQi91zPM9wQrjIsBcMeBokATJ9Dk+OnsfOPY=;
        b=UIUjZXbSI97bYeMtN6jWKXDIU2RWH1j1oHHHv56ngeum6FCFGqazsV+uCaZo411RKU
         mSz4k9HB4n0YOel1XoY7u0vJYHvZiiRMl7QCr2/MK1YZFoXIdkQSzEQQfdtYpid5bEZw
         csTfM3GIX/2kneebDAZUPdWigh4l1dpMFZwSkZ0TKLlvYF+/5LaAjcVnZcLF1QwvCsWY
         ys4mR/8zqm3v556BMFA3dXgTgCXtowIsUMHJs84PrMsdidEbfXt7ja1iiR4/9vGdqrjV
         Es38qZfbsna+5S3mq8iVEM7ar2OOXDOqOPTSUZSNQT/sWsTInvWuxHJpSk0iZjHyn3VF
         BwWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwlEF9ijh8lNwA/gEk0+pdUT3CoTJbe8BdUp0aV/YGA6GxoMhINnuVaD+AC+4pur7susjpn6vBW65t000=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQcrziQcj1iLfS0fRoXv/iW4UcMGlr3JWiwSo/HvL+AxuzcMSc
	h7RdRQi7lyE39+1IeL572eGr1KIoLDEXWV4Jcpv7U0dZW3t1JPTKPlHk
X-Gm-Gg: ASbGncvzux+9pNh7/0Nko7OPM8okJXOAdjTE8+rB8tg5wVkx791QttjEsZzVW8k+vVc
	X++ePrNAWu4y1C4QmVK1eDscRIDirr7mRMxuoHFqITbgomf/OAU2X0748FAFNS+ruQGyIJ8hX+D
	xNIlmY7uQFhFQ70SqSaH2UumgPe0jVEwCojZGxFfN73S/rOG8COhjS/OYzIPWnStqJB0LaUfzSm
	6kw1TLwbRQzkJ27nCGbt1kURL3Wp9aJjv0FEbb6ooPrND4EhLH0q9O1OoJ7qOLBoyZVWIqcDfcx
	RnynJT4G9S9qJOtJSziRKa+pt7PYBWpE0x5OvVSLRH1LBQFuXF/03hW17yRAE2dbAbFs18VopQO
	O8BlVjZxK7LqRc2zW+h8jIPTvHTqR6BSvhfm8vupRJ2jabS/8VIzsg9QtpZ/7bSaZUehlliAuep
	ppzh6X9tXn1TR/iBz6H1V06yBe3OtLbZGkY6Oy8XXestX7PTM=
X-Google-Smtp-Source: AGHT+IEm9m/w9mr1Ah54jXoKE1xbMScwRImAvwjuiTBh4hTI8OJ22nQbryQ4R/71ZzmoPFNV84Nqyg==
X-Received: by 2002:a05:6402:90e:b0:640:cc76:ae35 with SMTP id 4fb4d7f45d1cf-640cc76b080mr5264788a12.21.1762268315761;
        Tue, 04 Nov 2025 06:58:35 -0800 (PST)
Received: from tablet.my.domain (83.21.17.47.ipv4.supernova.orange.pl. [83.21.17.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a7fcd7sm2288874a12.37.2025.11.04.06.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:58:35 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Tue, 04 Nov 2025 15:58:25 +0100
Subject: [PATCH RESEND v7 7/7] clk: bcm281xx: Add corresponding bus clocks
 for peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-kona-bus-clock-v7-7-071002062659@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6005;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=oaleqb9XqZrB+5VSSVHMl0U9JzcMe7IFlSred6/4jZc=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBpChSPDzc0qX79x6O83xMuL+h1vrRyYab9QcJKX
 vTAZcWQZS6JAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaQoUjwAKCRCzu/ihE6BR
 aGUwD/9rHsz4h33pXwGXH/5ZmWcK9bAgXdjLQJzEJXA2ZvaTR0eYh1aY8S4QyX8yuWSPnsyfzNI
 26sg4lwqP3R/ikGpjup+Thz1EzWvOiapUWActOQisJfzz5E/bY2D9IDkMYb9c9qyspwt2hMRqOS
 dtgPzncqkKCzbn2q+Jx0I634cK9BOMWJwEWBS+B6OcxZYx49scZxMgs3VzCfpkLf9hXxVZGFg19
 33+SbwFvoQaN+wuYxUl1njAieZpbX9Q4cYDRGnQgdAerYKlFQfG8PkFwqLy1PFb/1zEuElNX4Ko
 +cfyw1J7jQxg12P/Itbq9oE3iPpkjsBnFfb7fNcYiSgzFb6IiRqtoDKBPZxI2Ox9J3cRK7ANY+M
 +pNk9YNnMUtOC5qV9bP49m7R4JOQ6aXnMMvtKH0ycKwTa/wY5/3eUDDyGCcnLyAjrEcnfazod6t
 1ZwNq5yLhoOvd5kaJqKCMzW81mogJ7xIrp12Y0GGLaCtNk3NsGbctBd7ARkRbTfCJ5MXJqi4Wj2
 WXySVxv0kIbwnamow75nF2WbWIy9bO/eMRW9G0RHYeZlgPpnOo/j1jGNClDArrqV1XpbERK1k5j
 FRv4w8NT1hXdLrK+vWNagTW8g70u72nAsLdcJLdY/eZ0t0Q5W5XmYRtqkYpCgIgNFrQcivvnRBU
 JidqQz4b+FUw7UQ==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Add bus clocks corresponding to peripheral clocks currently supported
by the BCM281xx clock driver.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v4:
- Adapt to CLOCK_COUNT -> CLK_COUNT rename

Changes in v3:
- Adapt to CLOCK_COUNT defines being moved

Changes in v2:
- Add this patch (BCM281xx bus clocks)
---
 drivers/clk/bcm/clk-bcm281xx.c | 127 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm281xx.c b/drivers/clk/bcm/clk-bcm281xx.c
index 62c3bf465625..13fd8a5ea8fa 100644
--- a/drivers/clk/bcm/clk-bcm281xx.c
+++ b/drivers/clk/bcm/clk-bcm281xx.c
@@ -59,7 +59,17 @@ static struct peri_clk_data pmu_bsc_var_data = {
 	.trig		= TRIGGER(0x0a40, 2),
 };
 
-#define BCM281XX_AON_CCU_CLK_COUNT	(BCM281XX_AON_CCU_PMU_BSC_VAR + 1)
+static struct bus_clk_data hub_timer_apb_data = {
+	.gate		= HW_SW_GATE(0x0414, 18, 3, 2),
+	.hyst		= HYST(0x0414, 10, 11),
+};
+
+static struct bus_clk_data pmu_bsc_apb_data = {
+	.gate		= HW_SW_GATE(0x0418, 18, 3, 2),
+	.hyst		= HYST(0x0418, 10, 11),
+};
+
+#define BCM281XX_AON_CCU_CLK_COUNT	(BCM281XX_AON_CCU_PMU_BSC_APB + 1)
 
 static struct ccu_data aon_ccu_data = {
 	BCM281XX_CCU_COMMON(aon, AON),
@@ -70,6 +80,10 @@ static struct ccu_data aon_ccu_data = {
 			KONA_CLK(aon, pmu_bsc, peri),
 		[BCM281XX_AON_CCU_PMU_BSC_VAR] =
 			KONA_CLK(aon, pmu_bsc_var, peri),
+		[BCM281XX_AON_CCU_HUB_TIMER_APB] =
+			KONA_CLK(aon, hub_timer_apb, bus),
+		[BCM281XX_AON_CCU_PMU_BSC_APB] =
+			KONA_CLK(aon, pmu_bsc_apb, bus),
 		[BCM281XX_AON_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };
@@ -178,7 +192,36 @@ static struct peri_clk_data hsic2_12m_data = {
 	.trig		= TRIGGER(0x0afc, 5),
 };
 
-#define BCM281XX_MASTER_CCU_CLK_COUNT	(BCM281XX_MASTER_CCU_HSIC2_12M + 1)
+static struct bus_clk_data sdio1_ahb_data = {
+	.gate		= HW_SW_GATE(0x0358, 16, 1, 0),
+};
+
+static struct bus_clk_data sdio2_ahb_data = {
+	.gate		= HW_SW_GATE(0x035c, 16, 1, 0),
+};
+
+static struct bus_clk_data sdio3_ahb_data = {
+	.gate		= HW_SW_GATE(0x0364, 16, 1, 0),
+};
+
+static struct bus_clk_data sdio4_ahb_data = {
+	.gate		= HW_SW_GATE(0x0360, 16, 1, 0),
+};
+
+static struct bus_clk_data usb_ic_ahb_data = {
+	.gate		= HW_SW_GATE(0x0354, 16, 1, 0),
+};
+
+/* also called usbh_ahb */
+static struct bus_clk_data hsic2_ahb_data = {
+	.gate		= HW_SW_GATE(0x0370, 16, 1, 0),
+};
+
+static struct bus_clk_data usb_otg_ahb_data = {
+	.gate		= HW_SW_GATE(0x0348, 16, 1, 0),
+};
+
+#define BCM281XX_MASTER_CCU_CLK_COUNT	(BCM281XX_MASTER_CCU_USB_OTG_AHB + 1)
 
 static struct ccu_data master_ccu_data = {
 	BCM281XX_CCU_COMMON(master, MASTER),
@@ -197,6 +240,20 @@ static struct ccu_data master_ccu_data = {
 			KONA_CLK(master, hsic2_48m, peri),
 		[BCM281XX_MASTER_CCU_HSIC2_12M] =
 			KONA_CLK(master, hsic2_12m, peri),
+		[BCM281XX_MASTER_CCU_SDIO1_AHB] =
+			KONA_CLK(master, sdio1_ahb, bus),
+		[BCM281XX_MASTER_CCU_SDIO2_AHB] =
+			KONA_CLK(master, sdio2_ahb, bus),
+		[BCM281XX_MASTER_CCU_SDIO3_AHB] =
+			KONA_CLK(master, sdio3_ahb, bus),
+		[BCM281XX_MASTER_CCU_SDIO4_AHB] =
+			KONA_CLK(master, sdio4_ahb, bus),
+		[BCM281XX_MASTER_CCU_USB_IC_AHB] =
+			KONA_CLK(master, usb_ic_ahb, bus),
+		[BCM281XX_MASTER_CCU_HSIC2_AHB] =
+			KONA_CLK(master, hsic2_ahb, bus),
+		[BCM281XX_MASTER_CCU_USB_OTG_AHB] =
+			KONA_CLK(master, usb_otg_ahb, bus),
 		[BCM281XX_MASTER_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };
@@ -309,7 +366,51 @@ static struct peri_clk_data pwm_data = {
 	.trig		= TRIGGER(0x0afc, 15),
 };
 
-#define BCM281XX_SLAVE_CCU_CLK_COUNT	(BCM281XX_SLAVE_CCU_PWM + 1)
+static struct bus_clk_data uartb_apb_data = {
+	.gate		= HW_SW_GATE(0x0400, 16, 1, 0),
+};
+
+static struct bus_clk_data uartb2_apb_data = {
+	.gate		= HW_SW_GATE(0x0404, 16, 1, 0),
+};
+
+static struct bus_clk_data uartb3_apb_data = {
+	.gate		= HW_SW_GATE(0x0408, 16, 1, 0),
+};
+
+static struct bus_clk_data uartb4_apb_data = {
+	.gate		= HW_SW_GATE(0x040c, 16, 1, 0),
+};
+
+static struct bus_clk_data ssp0_apb_data = {
+	.gate		= HW_SW_GATE(0x0410, 16, 1, 0),
+};
+
+static struct bus_clk_data ssp2_apb_data = {
+	.gate		= HW_SW_GATE(0x0418, 16, 1, 0),
+};
+
+static struct bus_clk_data bsc1_apb_data = {
+	.gate		= HW_SW_GATE(0x0458, 16, 1, 0),
+	.hyst		= HYST(0x0458, 8, 9),
+};
+
+static struct bus_clk_data bsc2_apb_data = {
+	.gate		= HW_SW_GATE(0x045c, 16, 1, 0),
+	.hyst		= HYST(0x045c, 8, 9),
+};
+
+static struct bus_clk_data bsc3_apb_data = {
+	.gate		= HW_SW_GATE(0x0484, 16, 1, 0),
+	.hyst		= HYST(0x0484, 8, 9),
+};
+
+static struct bus_clk_data pwm_apb_data = {
+	.gate		= HW_SW_GATE(0x0468, 16, 1, 0),
+	.hyst		= HYST(0x0468, 8, 9),
+};
+
+#define BCM281XX_SLAVE_CCU_CLK_COUNT	(BCM281XX_SLAVE_CCU_PWM_APB + 1)
 
 static struct ccu_data slave_ccu_data = {
 	BCM281XX_CCU_COMMON(slave, SLAVE),
@@ -334,6 +435,26 @@ static struct ccu_data slave_ccu_data = {
 			KONA_CLK(slave, bsc3, peri),
 		[BCM281XX_SLAVE_CCU_PWM] =
 			KONA_CLK(slave, pwm, peri),
+		[BCM281XX_SLAVE_CCU_UARTB_APB] =
+			KONA_CLK(slave, uartb_apb, bus),
+		[BCM281XX_SLAVE_CCU_UARTB2_APB] =
+			KONA_CLK(slave, uartb2_apb, bus),
+		[BCM281XX_SLAVE_CCU_UARTB3_APB] =
+			KONA_CLK(slave, uartb3_apb, bus),
+		[BCM281XX_SLAVE_CCU_UARTB4_APB] =
+			KONA_CLK(slave, uartb4_apb, bus),
+		[BCM281XX_SLAVE_CCU_SSP0_APB] =
+			KONA_CLK(slave, ssp0_apb, bus),
+		[BCM281XX_SLAVE_CCU_SSP2_APB] =
+			KONA_CLK(slave, ssp2_apb, bus),
+		[BCM281XX_SLAVE_CCU_BSC1_APB] =
+			KONA_CLK(slave, bsc1_apb, bus),
+		[BCM281XX_SLAVE_CCU_BSC2_APB] =
+			KONA_CLK(slave, bsc2_apb, bus),
+		[BCM281XX_SLAVE_CCU_BSC3_APB] =
+			KONA_CLK(slave, bsc3_apb, bus),
+		[BCM281XX_SLAVE_CCU_PWM_APB] =
+			KONA_CLK(slave, pwm_apb, bus),
 		[BCM281XX_SLAVE_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };

-- 
2.51.1


