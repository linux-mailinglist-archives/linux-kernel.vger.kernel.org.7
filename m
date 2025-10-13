Return-Path: <linux-kernel+bounces-850598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E72BD342C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FB2189DA9A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241663081B7;
	Mon, 13 Oct 2025 13:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFHvPTOF"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79903090C4
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362931; cv=none; b=jyuQ5aAeqVC2tl/6YtNuvoOL5E3Xf4RqzAAO7bAlJKevvMTxnKQgqDzXtsEv7VOmfIx1mUwQnsEQFtMSITRad8ums3LOjfQ+MvQLY3Iqi/ybIIdH08TDJpBf93z/W8TGlDgO3jfLlF/P3NLZWOcrHxWc+G67SCM8RMiftGwQL0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362931; c=relaxed/simple;
	bh=BKr8nVscrBQotunl8u3eUCru7U4bR7e46blB/UH7zYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sji+Rrj387YMFO7N/uuGb771dCuzVLnNLYGCACvye0e8ZiXC/416nAE0KdJrlG4eAQtVKGdBea25Ej3W24Ew+cXdbt3/aKrbogguMRQT9zMUDyptygXHZVMi4tx428GDeNd5JRkY13Y6HM1SxPfsBG/gqDMpKO9qKZfHcACRuro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFHvPTOF; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6399706fd3cso6225830a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760362927; x=1760967727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rrxn5V2ZLraaXqN1UhOIzjX1yimKmGYY2iP8b/c23xI=;
        b=RFHvPTOFEazrnVZ+d+wAmKPdyUftHbrsiQOggoftM7nAcEICLrkkcMd4yxSQ5Fcy+K
         ZxNIr5QtYgr7Ve9mNYaEVqKqGuOFm2KSJmdUzrekrU6Tb4sLBSzMClH1mIhey3/3cgWR
         DKDrAzhb4qziZXj5XeokfIpxrwiIau/B4etYK321aFyPC0gUef2yh/zfxEh9X0UlNmhH
         woGDOa39vTUACPGFDyLFosYEM/pRnukFYWaTlisr3AdVGrDkgT8VlzRypgEJw8ru41a+
         LhzWXt+QPWG9lMgtXfNorqWlTbXF9GjkP/ZvgzM2UO7JPffi+6/4KkMDQp5pqzteOzg+
         zkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760362927; x=1760967727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrxn5V2ZLraaXqN1UhOIzjX1yimKmGYY2iP8b/c23xI=;
        b=gnzh2fMzhxb6qyhs8lh5qA2ajU+MVt5XQKG40qBHN7FteYSzt99P8VoZ2sPg4pgm29
         78TJHVNSa9HCIl5jM7Neqfg2wi7UqWsSNA8Di4SviSOPuHs3wamSe1MqNikBu7hX0YHt
         +3qm3CkbSCXg5gzipaOVxIfiNaoJvHR95GB57oCCM/pCrtlRCPIRbGFRt1MY3huQZpx1
         VLAlbIs2GlIX0l93w0rS4lKX8TpUJ4M41AnWarJmNsf6uiasHMonhCMlE/ggLLxw+LHg
         8vbh7Qc7HK/rapLAx/E7ncOxOiAjy/n9Wbjtk18nsV6Vcci9YN9IqQtMiizVgum4rVfs
         JBZg==
X-Forwarded-Encrypted: i=1; AJvYcCWUD/fWWshg6mP0uNrubOvevdxZl3ImpzYjq+6Xh+wZzEkmExLrB2ui0q7KlQLcvejJwCuoXtpfgdPIj+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTzHRYlXIRCn3bp2uxoEHeDbnXJX81PaV4q0IsYczCg3wYQCk8
	Y3flV2/2P95viuc5zYOwXcC7wVUrontGEaDxkkM5cdErksgxpn/BAT50/FljTr/X
X-Gm-Gg: ASbGncvC1OhzEUmPuhQ8LoQY0FiLpjzrkx2VVsNBTLVfUfnkR5pttorj+Wf4Q6Eo01A
	k6cb8CuwwDvmV1Dltjtm/tomSQ1wtTwVyrVs8znuODyF2ZY4qFM8VbIwFq2bWH6sxV+faRKv4A2
	PZKw11FQgyMDlqTzjiNkODy4nY0z4autpwJTYKNFEtxT044k9TJJaAhxigbnNmRMCTXU2lDWE7f
	x+N1q9jXaK462LoNQc5iW1EMMG/fEJawb9ddVLOk+aVHvBR9aQLgZg+6Eo2/Ri/ImRFlrVotbBn
	/kkrDwIzSwS5ls7GYvvXLQbouuVXvl/l/UOXi6lLFbWB1q/9aIhPd0bPoQeym0XmVMUX0Xx5EQK
	PFWdoi+Lg/H85QW3qm4NdxsBc4QAwUFUfJ1i1RGpTO8x7fbvMMpbaCNAqMMVdBSozbbVjkz2z5w
	DwVziQC7q0LhvU
X-Google-Smtp-Source: AGHT+IHW8B7vpbCVSo6VA1fn0F5FpN2EF++GQ7/3RSyeUuDyDe6Te8GkuSpOBf62mr76lPkgAINLng==
X-Received: by 2002:a05:6402:40d1:b0:639:ef26:a01d with SMTP id 4fb4d7f45d1cf-639ef26a47emr15112262a12.11.1760362927050;
        Mon, 13 Oct 2025 06:42:07 -0700 (PDT)
Received: from tablet.my.domain (83.21.75.22.ipv4.supernova.orange.pl. [83.21.75.22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c32249esm8729019a12.41.2025.10.13.06.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 06:42:06 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 13 Oct 2025 15:41:54 +0200
Subject: [PATCH v7 7/7] clk: bcm281xx: Add corresponding bus clocks for
 peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-kona-bus-clock-v7-7-8f473d99ae19@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6005;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=BKr8nVscrBQotunl8u3eUCru7U4bR7e46blB/UH7zYk=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBo7QGg6q+Yc21Ig+afa32iNWFNzvHv7ZkWVlH2N
 0Em92Ym7byJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaO0BoAAKCRCzu/ihE6BR
 aMTLEACdZNtR5aTmug+rai2D1xBgUuBhee96uc7gCs6JjvgMPMffeAChVUIytsllR71lj74m9mf
 g5X6AS9hbUWdkzNGZl8jslulemey9NH8A9W19Ld9XejQDTWGQtv9RTZ4mAHagi0m/pCoBf8b9H4
 vfM+34HRFfV05296MrCfT1kFibzDvgCKHZzEgvvM/B0J+X6hDtwezVfRi9tlarMvORZEUhaY9xu
 dM+WKd1ZUpvyc+oaFMSpxtEfkmhCR3fk8P7EANYZ/D/HOf17SiSA3Cw386UdyFoiESu43w35qlo
 zGFooOq+OowrQDWkutSUHsQrMGes5RP5twZL+9EpOIBcsesKO7mtOMxwAcbE9f35Ey91Q/kwL2R
 WzwoecopMZZB2Hcim6Qw6zZNFUyB1Z+5likC1QeAON1Gd2uGbKo+n31B9sXk0Af3vuYErD6ZqZj
 fxUBic+06J2pgC4tWVDQ+hp9H/dOeGxAUnD/G6DlFiYHJjrCIKbynMWNsecBhKPg0oA5+XUh+aZ
 yY66HmUc7Tcma0giwX2YK6SpQ/sDjOaAZWjkTiVJqr2nChHDthpLFt9/b1FvoDVgCJ6LWOCzlCp
 pFrMW7Q6KqHQUq4M/QLCWwICtIy+qvpOE2q7WDv4NRyMsdQtt6ClLslQy7E1MLymsEztaHR3oNH
 Ks8sp5Chwqk+k3Q==
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
2.51.0


