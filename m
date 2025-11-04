Return-Path: <linux-kernel+bounces-885017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B910DC31B94
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694B3188A39B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5589E33B6D2;
	Tue,  4 Nov 2025 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glzUlcxO"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91F1338594
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268318; cv=none; b=KuIV3IDthMjH7MVfPzHbfY0wX2ALYoVyopxoTA2sMevZQtmyfklwCvZYvfSTxWjrpfwAtpmZAjt8v3zHHHp3qDyYaCMd5IygnqlHjn6UEVA4slE4GTA+5BX7klww8WZZKLXUfsoFGMP3errTTXrCq3JjGhnW/NVLYetKHfvcmnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268318; c=relaxed/simple;
	bh=DSWwOgT5tbBOJuCemE10iAhhCX0NXJ6//wZV+1vI2/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N8MLR4+OOtxUMUWzmt1TLtr/KlLhhtuGhEFk3a8BdGdI6HiG3oIAK10Lqgzs36tnTFd3VNQREgOOo0no0G2blyvk/c3mEcqHeX7f/fe8vCKUXrc5aFyevRyvwwsezuTPG6XpovdH5L5z3SitMJakWDFj5HW1xwCZ7Hnvb2ol2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glzUlcxO; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso9523822a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268314; x=1762873114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvcX/auKEZgjRASVFTmjnc1+2Gff5FK7VQN+0M14FnY=;
        b=glzUlcxOqSApjfvJlm++H4Tqayxr70WlK0zJ+D6Ld2RCnKJfGlcAcxWIaU6fJHzO70
         pP7FQoqteNSFg5wvMrWeMhDNyPaFKJ+NLVY7Q08b5W6yGiOAqV50BFPVCyE6npqbMk2z
         jdmxg5kQml/aEqcoUwn+E5rA+Kyl3/8YRnZXoH+xFEDy48va0rZZtifITrWcZPqqiMVm
         NZa1KlHspKhqcqWYASSJMw8xnMeNW503UzxKmGo7HFMxhZVZOom+wu53RGjucsRsE+ac
         hgjM0hzMZKZgSsjsqpfrtX49KXr9e5IMH9GLAr57bnmFH94d4/GlYuznwC19LnoD2VOR
         A2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268314; x=1762873114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvcX/auKEZgjRASVFTmjnc1+2Gff5FK7VQN+0M14FnY=;
        b=vtd29sgKDc5OlMIpf1ghbbvdilGKiwk5vPQDFlEmKeooDpVs1XDuibNLZieIiiDMcz
         bmZrNETFk6SydYhLSvW/3kWroFDbkcLQXGv7kQSaTJpkZPp71XvlpujiDRnBJPOMho8p
         s8eOlYCli9DIcqP7NGVV7E/Id2xAWoTutk54xWhu61+UPDysnKZxM6rCqlVOk+mJLUhJ
         OO3CExj3UPcRYRIN6S8Cu/UDIGt1yFSWQnUP1UAKCuAHwME/Fl9F0GZj9bvf0i7s+lK3
         5FcG0jU7gKfxopAYeouOYidiYcyaBT62g1S+Q1U5CtkV4bDoKihjVdJL3aZbgNudDzo2
         VTFw==
X-Forwarded-Encrypted: i=1; AJvYcCXdMlrkJ+YeZdDhCQJRwhbhBiEkvBnpzPS4IJ39nV3UJztchevo9bfYINlZctJcIv+A9Wtg5nTAp/uo5Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE/62WAVfNkhNHmOWNBDQEDyN4LnZMbeAGCpvZr5/5ii4QXxBe
	gQjdaCKifHKuuc7Yq2yLnpz9sN59e2ZQU31o64avXaqhxTqQtH6a/ls1
X-Gm-Gg: ASbGncusssghI8WLiTgTUNdHWeKHsvcgENue+LFE347znB9mKpMNTznqW6CF4PS7kty
	ze+KnFdacgc2RV7AnNkYLXePsjpYXmGIfTJFxK1SxfXshaYsKFwmzU770fw4PLwYrFKm3QzuT+X
	v1h9BlYH09Gpk8nLgxCMBhcimeC7KErXOTc4yoMMocIEaqGpHUyNbDFsn7t9HHJOGEKHJh08KqU
	WlmDv/kHEHqnnOCF679NEd1z+KZ+19RZBoT7wC1UqVLfK3KW4Gg0OhnxWeRJaxgiHr+y5fUD6dH
	PFxkS2KLcEgZaHEwVbkX3Iic8bw8OpZyPRNtSaQXwGanlvn4oKMqPrD75VevsUoENmAL5mOgt00
	L6jOu4hAl6ctY9vbTtD15o48+CZo+uee2QJShhnONHxGgKirM559Roze/Zv/LseCVY4FNy+w3++
	tdN4P97l8Gzrd58VCG2ILs2044FuqMefmPCvsW0DcpeBYWptg=
X-Google-Smtp-Source: AGHT+IHZUUsGZGBtlaJoXWS1ySzHKciLjAZo/SuEhSLnYmO1pEob8UZ17/Np7x/XSHyNvnKfD+0P5A==
X-Received: by 2002:a05:6402:35ce:b0:640:a9fb:3464 with SMTP id 4fb4d7f45d1cf-640a9fb36ffmr9455039a12.7.1762268313877;
        Tue, 04 Nov 2025 06:58:33 -0800 (PST)
Received: from tablet.my.domain (83.21.17.47.ipv4.supernova.orange.pl. [83.21.17.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a7fcd7sm2288874a12.37.2025.11.04.06.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:58:33 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Tue, 04 Nov 2025 15:58:24 +0100
Subject: [PATCH RESEND v7 6/7] clk: bcm21664: Add corresponding bus clocks
 for peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-kona-bus-clock-v7-6-071002062659@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5074;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=DSWwOgT5tbBOJuCemE10iAhhCX0NXJ6//wZV+1vI2/8=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBpChSO58K/GaAyCzMSSY6ye7b4jny16XKR0l4zJ
 o79TmPUjR2JAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaQoUjgAKCRCzu/ihE6BR
 aHHWD/4v2Qw9VrLNQZSN7Q30cKwEsR+zIfo+zZKngZivHpxP+mnxJ+ZERE2Kb6ZVbiM0RKRHZqL
 irpncIkpgvOctJQJJobF1UyWg8IYBjAVWiLh5YOYOwLqOGKnNIAesJU/VrNEKJlgRTPwDMXhxYN
 Rdn+Ldgmlcd/gHzrBXJvxrx09gUKf29bu/NQBFyTbTmn9WGAFjwT+SCfhegtROGg/OLZe7wUB5x
 qVXne26FI04QT8rh5N/McogfQGyjUebaMZ6wgGI9yCBS2alCsd7IcNVVYUMB0OzZEJV6Anx1gxZ
 3d2hj8qT7ViH2V47LnXvGQ0EnX2DNVqgVnIkh2dMBjlqWFEcEUTI/9PchHkkrJyqe3sfV0B8bv0
 nA7Ti3muhkf4irAvWbAhLncBY7GdumksSwMX0pBRQEauNa8NB7QjRzgWW3oR5TWNlN0Y8XlPGCH
 7a/ykBIBNYMVaFnCvXCb1YIbTBiCauE8/OsGjFYtm1+mIG1615SJaY6yrzrDGGc2NIZfmJlCmO2
 JKekrls9PRkoOIyVA8BJRxz99814xAi+iyTx77LZ3aEB0693iFekVB4G0d+wlfweOSpYUzikaIa
 5iw4Dps9sSt1uuiV1SrqftCrpvvvzqEfYINTLCrdT72sM+EolBKY02e3zIZ7HvDylICEl5PTwht
 CgHk1kiLT4YXYiw==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Now that bus clock support has been implemented into the Broadcom Kona
clock driver, add bus clocks corresponding to HUB_TIMER, SDIO, UART and
BSC, as well as the USB OTG bus clock.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
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
index 14b7db824704..4223ac1c35a2 100644
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
2.51.1


