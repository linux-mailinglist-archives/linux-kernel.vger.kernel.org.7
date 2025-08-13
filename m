Return-Path: <linux-kernel+bounces-766539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B21B247E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998541BC2B49
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA0F2FAC05;
	Wed, 13 Aug 2025 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+SC7aQD"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E942FA0F2;
	Wed, 13 Aug 2025 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082835; cv=none; b=TTVGwVfQ2oQ5AVo8+89/Jb2EoBc8/sDCeO5WCXBE4gusAt99ztBVjGMlLdpKf+v6X4TWxQ0NJtEoOHY8O0ZdSkTnPAVLFsTWmMyp6lzbbba2/HZGg62P5e3qTNHoY2vyYsiq8xYF05fuDsLn492psKJ1EnPlulqpV9zT7EWVCdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082835; c=relaxed/simple;
	bh=Gq7lvAxtLYAke9zvYzvJyfhtBiZKv6UgZ6bOPFeWiL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tqp1UjACaD+vBoZJEI/Pviz3xe4a300z88bPWBrNM0ZK0AzmusBoHi5VZP1CStF3B1uB9bL/1pAmXjgiHI5CDfWTP/8Iccjn1D9jVecD8oLnheU4m/KE++TaF8lq4DghzDzRnWDUJbLErZDWeZ7kCCm4ji+XRFLrfNUF9/ED8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+SC7aQD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af98b77d2f0so1198220366b.3;
        Wed, 13 Aug 2025 04:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755082832; x=1755687632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6v9b5bSF0XUxHDNFzPCHx7YgPRQ9cjjoZsAismkQ8s=;
        b=h+SC7aQD3r0JqN/ESCo8IN5N7n4cQBCUHAJRVBKfVyWr7LSf3oT6ZI5Cv1h2Cu/M7K
         p5aTQyQrNI7kZ3+3Hzlyko+dtRDjUPlCSOdT5j5YkQIPZnGM1Ee8i0x/9VX2IDF6I8Rm
         mf93LH5MZVB4HMne8hrsgFTxzDNlAdvwyYziHuCV0jn0IAshWx3IL106Tv39y6zTq2l9
         //DYY3UNhsmSMDUY5pJs68xx4tHaNHNsCGeEd62VFG0+FdSbEIiuaAOWGEYkvr8sqVKg
         qa7jZUdtfOHxr9GRUyZ7Y5mqAknAVi0Xfo1fHdiFENHA6RTxLGjx6HstvuT4uUM+oDYs
         y19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755082832; x=1755687632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6v9b5bSF0XUxHDNFzPCHx7YgPRQ9cjjoZsAismkQ8s=;
        b=qKHTjncONIDYna8FRm3mtyzJ55v8wJYReQrDjC7rafy1eME+C11qsYXth48ompBVp+
         2c388J23n6zYKOpfDY40JsRSV1Z4qzT3zG+zRNBH5sItxOznSBZhsgKLkTlajSPA9pst
         DRqKousUM6hry3TrRBhemHzO68xqQdISASdNoLex/1iTQnbIQ4qMkjb5Ucz/YNsW02Lo
         bAEmqHEs3ImpvOrYrxbcgz+plvpxxNC+L3q8ER4gaXOKdkTp94BoEpVPSnQWI2Up1Zyf
         uuirGr7wQttjPr23KP30B3nF0kyR9dEgrL9IWQ7aD6BErgpf9Qt3181IBMpLxj+AFIVG
         AT/w==
X-Forwarded-Encrypted: i=1; AJvYcCVRwu2lK1inqvl9vMxygiaq84oFN7e9T8FiR0OBEwdiqp5tPChE213S2lB4R/Pbr02SrfQS4mLlUeyN@vger.kernel.org, AJvYcCW7MQjFO78ii2qXV0kaMqlkBxGqBfutJqpfJoCEnOBO5SshjD9MfXT5JXtKMrWNpqGGzMcEUb2YIqVDf5+q@vger.kernel.org, AJvYcCWIYORlc7ZzAOn4biVjj9FEw3QQWlKypoGO/piB1Jv5nC0CtGlfeH5fQk2c1Yk4AccY8TVnQ98aWt3O@vger.kernel.org
X-Gm-Message-State: AOJu0Yw81RATnaYvgBvG/ZPyzeux2TY43AlF+paVSBNcjrd+dj3y8cZt
	w16B0gp566UlJ+pe/E8V4VUYEVt3CKqjf72GaYKoq9lwddYUIvb1hpOz
X-Gm-Gg: ASbGncu+poL44KYUL/OThIHklB3N9e8FfK2YUasHEIcoVw3cMuwXCXDRedpgY/Fp47a
	8v3ZSxF9r+405s1NYvr0uZ4ylOJpEFEFNpZFUrkHeICIDvOLwcJrX3fbW4rBiGz8pVUhZVR89Sz
	NC/1OD83S9WkZ/IWr/kZFGMtDkg588HiAXvyGSmc6ef+vte0d4evI5jQYezPDDeff2JgZiarQXh
	YFq9BzcH8SgRP2jqUrB6188dXPyzoT6m4Rz9O3YXcEux7lUKzp5GIC5b5O/AAioDL4G7iDSfZ1y
	WXXlZPIq3VNnCYzchxSLwnoSASVFtuewOLYlpAMPYZ80o17553BX39xbeaPEI8k2z/MsZUvI2ll
	a+ckJD4ZiplgSDd3JIUUiPqkjf/g0Amk5LeJLUKisF/E7VidfGUsyYjKBGc5kwknvM6DOT9Dd1A
	Rep4t/
X-Google-Smtp-Source: AGHT+IEjpV8uKzDh0mqjSYJdMkdpDUvzmzgtcM5DbbXrgqYqpERe5r1rLRQ+ntgzzLdXaURecIaxJQ==
X-Received: by 2002:a17:907:724b:b0:ade:4339:9367 with SMTP id a640c23a62f3a-afca4db9115mr274442466b.26.1755082831981;
        Wed, 13 Aug 2025 04:00:31 -0700 (PDT)
Received: from tablet.my.domain (ip-31-0-121-4.multi.internet.cyfrowypolsat.pl. [31.0.121.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0df10asm2377046966b.59.2025.08.13.04.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 04:00:31 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Wed, 13 Aug 2025 13:00:12 +0200
Subject: [PATCH v6 6/9] clk: bcm21664: Add corresponding bus clocks for
 peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-kona-bus-clock-v6-6-f5a63d4920a4@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5067;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=Gq7lvAxtLYAke9zvYzvJyfhtBiZKv6UgZ6bOPFeWiL4=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBonHA9PFfpIcmbnxav3qONDESI4hRMmnXIkt+GR
 N0gQvH/nEKJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaJxwPQAKCRCzu/ihE6BR
 aN5nD/4x15LNvhxIRyWToXPUg5x8ovQAr/3oEsuKMjO+H+yEzhxAtk0nVLKjl4QPP/LN+PkgKrg
 p0qvxUEvHgKscr+clMxQRyFv0AChlKLCDGO3BbBfAjBf2yEKESCCT628sSpghPoycTPtJ/b9244
 OM87WmVNzipTNEg7LAHeEd2CC66qhjfa/szv0vO6Z8QHlqWHH+NO0BF/RknMSRRE0RyaTSoEzFv
 pAaUFgQnBZh8s4ANQAjVBsTJlKzrMswuDPuqat0si/xyjD9ZT8dGgEMqHjZbKlHqNuIsAGmuKI6
 O/E7yY3TbwfVzDTUMzWRWgYfgjDPG4fAbz5lSZb3ND1jC5jVaOEeSDEUBfXnvwZmBIT5ajRRfqn
 6KmbbleqP+oALn3u7GVuhdoda0B557FyX8qJ2eGV0xcNd62UBcueOhtKhWnATxtnOfGzU8IEaLd
 f0Tr5Qwrp8TIUf32AYuRvi5Ap0uwaPJrtrZ6IcOvTzclF3Pr64koIO5CzR0oC6EHrLULJzJT1qX
 zZEJ78rvrvt1yAMLjWKMPtcIRAi3t7kdEVcVkGpjV4kwbwzUH8jbEIC5MCZjzBmoK4q9osUmu/I
 NDIDAgBZSIrubP9kVykSEAk9IcSAIPMqtWInNWtWLsdrjDwHlW0YgqOywrJXNwPA47AGnPMRzGi
 aeLulAuP48rOgHQ==
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
2.50.1


