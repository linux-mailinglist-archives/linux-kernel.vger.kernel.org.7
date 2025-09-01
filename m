Return-Path: <linux-kernel+bounces-795126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4D9B3ED1B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE6C17EF0B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BA5320A37;
	Mon,  1 Sep 2025 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJzCLZmE"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27443340D85;
	Mon,  1 Sep 2025 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746504; cv=none; b=g85EMF6uTiZHIXPThju5vFKyNNMASGOMxhMoozKMYCHiED4OlS7E+ugMBA51G/PddlcujUJYsv4bTaBoPArR96ZGjE3dCGhlpaZ05YDCOXHv4yHgJjWtM+bnn2zwi9R9c+2vlws7bNL6S4AGnqVelJvLdrr6QBf3BQ36YsI7WRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746504; c=relaxed/simple;
	bh=7aeNymfQ+oRiq3siHu3iF22xsu+e9eWllZLSuixd8zA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BIDR4vB3Myqu5bFBqGFC3OaYNBon2TJubUawzHZCsOM5Z63chkz0nFknbhIvpnOVzPoyLTyq/c0UkEnTVobB5vefMdFAHGi1oFJYCvdLE9/hAbgYFC+YJ3FYaatOD5ggte4lRze/6mTdaK33V9brbUJN9z+iVEOJkZglnUY+DnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJzCLZmE; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f72452a8eso2255968e87.3;
        Mon, 01 Sep 2025 10:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756746500; x=1757351300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nU+2OvKdO52NBr1XCLEoYT1CqEnpX6+PT81g/aWGPRI=;
        b=mJzCLZmE8GpjrfC/1R5wg7+lkxSDtbLmVHIXfgw4AwTYDJbY24O64K+YiIpwbMs5XI
         r1jLmTL8Dl341Lgn3Zktvi4H9YrmlBvQ4A3PY4zcNPaZkua+r792z0aHbxyARaUpOsFP
         IjYBSvmP4e1tebwCAB555PA7ae9hoOHOyDgyK3YS4Ii3osrt9v/WItz5C9PqLfACFvtX
         NU75dhlOlhp4mZaUsPEMzZzqIzMuEk1Vv84PdvQwLdpQR92oXPayC09Og6WsFPnGm656
         X0giQNdT7lyvTLaGTLzXVHt9PbFDXWkNn+rEffLa7oWm9WJA4he7fmTkbYGzKbt9Mqtf
         0oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756746500; x=1757351300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU+2OvKdO52NBr1XCLEoYT1CqEnpX6+PT81g/aWGPRI=;
        b=j+iJyrq3VFLOnYIW1WTOC2YuozS2wKo7aNMsxvOX+XxMxcduZ1txPqH9rwD7V6TLE6
         kBZYYKdJIAGctPVyedvlwEoQ/35WpAVUEBpfixCfIB6/2uPdiqvafzQQ4WQaeTIQFoJr
         69rTGSjLjs+ibLSTiYpjJ5IV5wxO59S6PO12eSBmWzd3AMmBOylM5PnaY+e7BJW8gGlp
         xrgQRIol+U6cCCc3u5xoPHELBJe0zD6bUfhFNu0zPQ/88dhm1mDfaT3ghIhKusZ+4m2E
         fbyPP+5ZLgcBVDpM9yy318ssrIeDxFMNvL+6troti+2Aiw4ktqLRC4GdpHGMf5/sicAw
         CFjw==
X-Forwarded-Encrypted: i=1; AJvYcCUlOaq0opNTWYxjjwi/7wsRBtNTveziBU6cn5duMseMlvGKp13rVRSSzFwA30FwW7E6TE7/HuHCZYWrOxOV@vger.kernel.org, AJvYcCXVv7FpUu45w0uFCAbxURwsQ64yXW0gWqvFu+7eJl3FvPR/6lRxPA+9HCEmRdjwQDSLJ20lIXp1Se6P@vger.kernel.org, AJvYcCXdYT/ViK/GzfMP5sqEqbl33EKY79AdZbOsF42h67KB3Sim4JIRLYr5+Rrus+nFZQMsv3p/48zzRGW4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5TN3tphuJlbkEdlXp6lwW0zEsC6PvkbXdHlhaBJOiNYyUklDS
	GmD9uoBK+LvWTq35d0FxH5JUYAwA04BXLcc5Gyw21PAYr6/J/H51kaIlvVVm+Q==
X-Gm-Gg: ASbGncsUJyMhq3V6pEQuw04ENBbrqugeo3Pt8+cQZh7vfOcn5JfFdPaTQ6SEnXzv+7c
	COtGzH2RSvoM5amXgi+flwTQOm8gRtUy8/io158fmd/ZDv/E3eQS/7hAr3ZWF475Izzt6xXLloU
	PsbQ+/lEDFFQVihAyLU5rOIPv+naSUJPd7A2KEvjKLkpfGuLw3Pc938Id/wkifEUqm9yX2mqmxM
	WbtBZDHJrWrbjiSE/i+Dqj9MdSAG10ilTr+jqNdpvqHTTdaTuf09WqCveUlTWvGdlplrlhY+2qs
	Ol3LK1SayVmftMSAT2S+xJ6+tawTyYtpf1B/U3LeEwU86atMAJG3njdY9MKMOvPShoutucR501o
	JJkGxEHnkVPt5SPBm+jqd+B9D8DV9W+PzW2eoRxubjerfNg==
X-Google-Smtp-Source: AGHT+IH8FkGM2/AOW9Jyvo+dZ1Rwp0qYwwake7W3rzM+jTNQMzLvFjB/GSVAEwJgE3ubbrkKFePhkQ==
X-Received: by 2002:a05:6512:2347:b0:55f:42b8:b00 with SMTP id 2adb3069b0e04-55f708a2b65mr2558015e87.12.1756746500047;
        Mon, 01 Sep 2025 10:08:20 -0700 (PDT)
Received: from tablet.my.domain ([2a00:f44:892:8a37:6b0:21e7:549b:225b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f7abf7abesm1137666e87.55.2025.09.01.10.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 10:08:19 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 01 Sep 2025 19:07:13 +0200
Subject: [PATCH RESEND v6 7/9] clk: bcm281xx: Add corresponding bus clocks
 for peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-kona-bus-clock-v6-7-c3ac8215bd4d@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5998;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=7aeNymfQ+oRiq3siHu3iF22xsu+e9eWllZLSuixd8zA=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBotdLKJe64Q0Dpem6NWmOii8RTKDbMRRGPVcAO2
 NK2vhJvtT6JAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaLXSygAKCRCzu/ihE6BR
 aJe5D/4rWpg6khHN4pnPPYZho9CeKKqUTVz5BCX0VMGkvFg32yUMFNexaa5XXtO6aP+vzQJ6V4E
 fn3v82yhXYQfiQY4B7TWS75haC77DgeUNswBP+86x6nUtXv8M2JM6BnObNw/TV45dMMSztnZl1y
 UV8c97Lzby0cIMqoP97X7ZfKSOR4v/B/4Aa5ir+wP96734Zqw33SGQ0ICwvrA6ATQPAiTjnyNvY
 UJvnh48XPHVipHnkyBBZh6D6AgBnU2+OhkIiI6o2QzxKlQez+4io80ldu0ErHiO+zrkiyhgXZHt
 GOBkNE0/mpQ60Iqhs30yTnFOTn/uKoF7WkjnW7+EBMl44g7WCOoukgKNLHO1W/9cyNho4KWQa80
 +w0fvmYL6TNY0ZLHuuswtog7LMjK1OkEgCU9IetLAGom/+suzCBeFjytEC+rFSTJAM22o1HbI6p
 fmy6nHd0REKjtMljLpjvT5Vovkj9jtulICu/NJB7PTDScwXlTaqNqxpVC0krTzEc4Vtum0JxVF8
 YCLY8eOapB+Q2gC4d6ombjce1RUDuUYoNad1xHzBTRt5ZeJ/yOYybMuofPoAiSpiG+59hkg7VTo
 FgVKCUAvfAdsaliEm6azcdvqd0/Ix7IgWcaqit9szQs7yGp7mIuJYdkvsDCRQd0ATYlLfyF8N5a
 SZsd5iYaryQj5YQ==
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
2.51.0


