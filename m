Return-Path: <linux-kernel+bounces-766540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD6BB247E1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD136893F6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C0C2F90DF;
	Wed, 13 Aug 2025 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCMBfrrs"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3F32FABE7;
	Wed, 13 Aug 2025 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082837; cv=none; b=NeG/uWYu8jCcmY1WPLLQFZaCZeY8+BfpEi03aHKljospLWM68V9vkrIuupmLAXkIHQu3GmBoWhbzu3db2Tvpn8x3rZhuS41cDpkSFJgRRRXcB2PzaZeeuH1i8PIhDMw4Re4FoNuDUlWjJtP+vjo45ugtL0AQPkHesKWki8PWV40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082837; c=relaxed/simple;
	bh=I4wRN3KkFekGNXMWJvTYQVypbn2IQ5ZoSclWcZEKoiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AOD/UVqRefnAwElWMMDDS+OEG1kdTgtsY0PgO0WteqKvLQUXV2zsx7v1ahcXUKGPCBICR7GtYs96A/nMVA//XOgv1ZgGe5JL9/+OcMmIt/aEYfCBAddwDyrXHMFP55F2GLOHd/hptciaEUqJrNjJ+DwLJ8YJzJAwFHNIPCKDoQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCMBfrrs; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af93c3bac8fso906279766b.2;
        Wed, 13 Aug 2025 04:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755082834; x=1755687634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jPQecaBa2ZbQtikCUaWiWmxdWG34bpxT6oauUx0D2Cc=;
        b=dCMBfrrs69GTi8hnVys+bIW+RmoPiVVS2EJOXNKru4t/9vHGN4VfMWq9nvJpyeeU8w
         fV6K94bHYWUSKXxAD0dOHm0SFY5hjGNbC7lKjz8UaeCsd/E+VxV6CDDbjQIuZX8l79/a
         7EzcU0hC3KYjNNFj1i4xj+omH+5FjAr6QEruNYzg0VEOgf2+z8+ylazRGOPnCk+wVsoo
         AjSIZoA2kIHbHPTyKHO81DzJPa0vo+ougSeAaAuk1hEc556f939yBC34IxMsO2ryt/6i
         MGHXw2WvAA1zhDCZj8tWlp9wq1z1SNYZdQKSdPFFTYpiSUYKqy+zgk4bawUz9pw+LjiA
         9quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755082834; x=1755687634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPQecaBa2ZbQtikCUaWiWmxdWG34bpxT6oauUx0D2Cc=;
        b=PQeKimMhboCd2zYFJJGGg6QZHWO/g1cS95Xhk+YuYGb4Us4RRBFUfGuOphuFpOR+Qv
         ndLwVaE3Kj7DXQRqWXVnlh4R7p1jiWzJF+UAc383AzX/ZS8WPZ/ynpeepXtx2ddIGOfL
         YpTukpaYrlkJmCEqXXWIryKlv02zIRD+9cydZVTnYReH5YR6/8VUntZpUzkAx2KGNfjV
         CFHfyekml7NLzVQCHC66n6ClT8IhV+0MN97iHx2i0oUlVXfofT6pWJrTYclIDAe6r7yz
         AXzSBNWmEl9VcYgwQbgPl0kVMrjA/tFJqTrxjOKktvQ5SPMwlZbrN/g69XbfSS5UnwwO
         aC5w==
X-Forwarded-Encrypted: i=1; AJvYcCU+JhI9Vj39Uuz04bvM8snSyfsbKtDApQKD05k4p/0/Y4r+YcDe1mKNdcgBNjJS5WBQsmlRYr3vTzel@vger.kernel.org, AJvYcCWoi6I2rmfaGkgTetKbFdfyRiuELAvJoZIr2/43VWvVhMGcqKfL7PXbTGx1PSWSIoDXub3MmIOUgaSdV8xB@vger.kernel.org, AJvYcCXz/ircXzH/xsAbKw4iJI0LQxBSpo9a8sxpBnyq5Ou1ABOx6yX32nwkAmjkYqqn3sDwFOU+QdYyFffN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7HZOIDXaKZJq7O1L1AG2gjnPnGGBVVlsDCcjVIdYrQPSOxNZZ
	7T4yBrGK1W1fRcAi0zd5f+cuhcUy/Clm8//zUwC2aFKAx6VrIR6jGzKwkG/y6YAi
X-Gm-Gg: ASbGncsGqEqAYcfr8X2CaQbO1KwG/CabGlzyknPAqYsEV553VzzXf15Vd8aFOzrnDiH
	tL6Vwok0EeW/Qh2GKpPRzAiGx1LZWnvNVQXvv/LoqfLrPLUdbZdrGLgkjY103NCkSQOXLWrsyJO
	BUqt+P65T6pRHFfk5lhCuAPtIrqR3bA83l0SQd9hQQEJ35B7UxmyjNji5JC2j4gLrTNjCiLM0PV
	mIIp5CBc9dxGD8h61LH5kCObw2AB+BoZCRJpKPLjyhLITcudRLgf/1vm778SQifqiGbo5uEFyxG
	t68lavfUlOCDA4+NhZOp6rEg2zy0hgQkH6K5ewiNTsLeLiIMBwPBHVZonSI38LJoZp/KCCDH3s1
	I5e/hgRgosPdKBV2/bZ+ElpPiUi5Egy74+OXMK69hKZmKyVIrO9DbMK1MVMTa32+BqYLUJo8Z6J
	L0JZSb
X-Google-Smtp-Source: AGHT+IFygjdX4zks77zDv5lXPN6A8NVx7lOIanCSu8uh0ZExHtyqNilgf2QwtI9ylVeq3rYeVw0p4A==
X-Received: by 2002:a17:907:2d2c:b0:af9:8d62:b1ab with SMTP id a640c23a62f3a-afca4ccded9mr301187966b.10.1755082833843;
        Wed, 13 Aug 2025 04:00:33 -0700 (PDT)
Received: from tablet.my.domain (ip-31-0-121-4.multi.internet.cyfrowypolsat.pl. [31.0.121.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0df10asm2377046966b.59.2025.08.13.04.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 04:00:33 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Wed, 13 Aug 2025 13:00:13 +0200
Subject: [PATCH v6 7/9] clk: bcm281xx: Add corresponding bus clocks for
 peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-kona-bus-clock-v6-7-f5a63d4920a4@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5998;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=I4wRN3KkFekGNXMWJvTYQVypbn2IQ5ZoSclWcZEKoiY=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBonHA+8AUsepJbdIVrRZk3+xeY2c74BI9jKew0E
 ivHMgKs1LGJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaJxwPgAKCRCzu/ihE6BR
 aD3pD/93RapZiPZaEaoSCv/y7TXThVF1EnX+u9QI1P8FFlzMgPLVAPDVZyBAfv6cBHGl3CHbBZG
 sKqmdLzOH7fR4HNfnUevaBN9WOiyCyds/zt5BmGm2d03g4ePHuPyAZcm66gCRSCY17laQISc2yv
 K0wQ4GKlDYkHp5zfpaQMIJsV3t7oKMwVxV4l5c6iDeHecoEjZncgD2KGK8mpvughUaoVJ3RNIzx
 mCUh7VjaXRp5AmxQE9VmRrXZE5I18n1EEqxfFZ3fBTZIMv40AqtBd81aCfPTKN3bcMaXewMtEgk
 tF4WnOS/tkE6fJFUa/KDjT8b+1onYDEqGA2cFNT7+6P+PrWyuMhVikAPvcgyHJZwrG5C86q3F7I
 vA6ExpJj/t0AUkFt4qgxqJrumGWrzOZOY5DGXolzVRUtx58iLxFUsbUB/e2XLGtABDhEs2tYOAp
 P0snT/iMC4cf6Y4sPnGz/sv7Cs17Y1XXNqnutNDq96MGl5S3aCR2UuTdz6ItBLBVFEU2PiwsSev
 W/WUpvVgj9EbPctOjX1a0I1yFLWBN5Th3J4R+97LF6jY5s624r2IFx6C1XxfoeFYTRXtuyv/YXS
 gaNPpza0XfmKe4xYxVEeHhX17W5NCcEVu17l2Lpqg6xsWke+TNcjERbWHYHUVqpJv4Ukq+Xe6rH
 UwLJBrY75KDLSzw==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Add bus clocks corresponding to peripheral clocks currently supported
by the BCM281xx clock driver.

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
index 62c3bf4656259261ae4f7d81dae48c90ab26c04e..13fd8a5ea8fa07bf6f3cca83b6b18e59a8de63df 100644
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
2.50.1


