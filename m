Return-Path: <linux-kernel+bounces-795115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D668B3ECFE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBDAE4E3268
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B30A2D5957;
	Mon,  1 Sep 2025 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkS8EnUV"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB6332F74A;
	Mon,  1 Sep 2025 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746478; cv=none; b=UXj/KciGCajKYX8+YOoLoLlSZ7HUyoyCzYFeKEH0kcxJH+Kihqrx/bZ0BI/RIe+1C0zvZyS3veCG/EznPT/Dz5gOcX+5pBd10sxfem2/WquMsygTsTFCL4dN4y42jQIfKpMn93RGlWIe0r4kbOjy/Ms3ciu5PWjgaMDWcJslcv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746478; c=relaxed/simple;
	bh=nBuDWNA37MXiGLfbOM2Azb046sRyvOaXBtEsYK0w/q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hMN3PnZl5MnJZa59gZOACQhx42z8Pi0AndWxsuwziWXkorFcRcd7/utKFBn6EA8f51QwBSuN4FRf0id25hl+WmljKUoN8s7mW95KplddcOOBRmHglObbPj7suy7IgQdMRGnwOu3Dwz+NY4j6spQjk5EcnE9LKfQPE0kNjo7VgNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkS8EnUV; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f69cf4b77so2874207e87.2;
        Mon, 01 Sep 2025 10:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756746474; x=1757351274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N68vtqkI2Bxq8oYBTxdNshjoedAjw9IYWQbAWFZlygU=;
        b=MkS8EnUVNkdLLwrK0kiYtK/HUQJ72m1jD4K/v4O6V1EBLY5+f2kmtLqBeFtGOVTIJk
         RUP4/ejhiI2OloV3xjsausSdiGL2FbJgbBTBtPKKM2SLF7ZHa79UvyIG5XYBaKTBBwnD
         J8vVERjC4oEnmZQi6WraL4bNMCRP+CpjJwyr/37CbRGkKhimGHfyX0x/eZXRSqsA20Mg
         hr2IyEq18kUJsBqcRHJzPcRfpC6FVZi8OyA3QRl63/Jj8uQ3Oc14p5OnwWwfqlyLA3//
         hFutLNyM7g3qNs2EDNcNeEa9NWRm5iHvJ5EZ3HRIGm5QQfwa5/tVz6YYqyGAC0t+Ms6N
         YiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756746474; x=1757351274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N68vtqkI2Bxq8oYBTxdNshjoedAjw9IYWQbAWFZlygU=;
        b=acoyr2xSQO0D3tnilb7TxvAhApAAFnxxbVONuUP2GDnslJIZG4xtSlVmg9dqL/l1xv
         b0Wtu6r6DjTloFjBqQYNMddXhOxkyU+Elj95rJd8VrelFAmKtYwdSydo697q9PtqZ+PM
         VHLR3tyVLVj8kUhn+3ukvcvYOfeOeYQze8GVCgv2eocoaflynMFAQJlU32J/s6GII80/
         guziWyBeInEnliivRlK06UU3flk74wwjSxgAsPBsUBQli6/cjOCRV7BnPFPZckk12e/i
         x2kj0ciS65HJ5NbI+gGHt4MVmfDe3Dezypv+J3UW8bV2N3GN7RnfAKHJbPP8hg5Qg8aM
         ARFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUANJrAmaAkxm8m2Wt7OCm98zxHBAtBEQg4I9CyRn+9FlNFohEBW7l1EDu2wrNEmzB9oZK5pHCQs5rt@vger.kernel.org, AJvYcCVWYEnLgIFHlZfDXvcRhO8qU3V4pq1ze7uReDYCZccVz8sosCNHdHFekFBDTCDvNTw6PYizmWrtfXBr@vger.kernel.org, AJvYcCX0M5I2kqxiUvxdo5sJgoezBgC6Te0DVeoBi9OTbieaXiQxHVUbXq90NnsNLtEfjL/x+ENG6lc+aZmv+Xtn@vger.kernel.org
X-Gm-Message-State: AOJu0YwqLGtzVHb1MtaJ4DaPlaZeaH17yhJzjF1c+NXu0MoztTjdu47X
	Vj3xco4wWErcJ7smJ5+8l1BkMmQYWlz9Vk/j+uwqDyNb3rA6sG2vTP30IbKMyg==
X-Gm-Gg: ASbGncuUqCT8ToUwpP8FhMrIO6pkLJQ/c9QYDxE+KIIB07ZGI/qBLXHEIMPQydyOTn+
	JNnTjonT1FI1QzdN9L05r3v0ZV8ZZGmw5qj8yifXaD4/7gf2bQDPJOQ4OqgjMPJicUDZnRtLWU4
	Juow5a/6gJA1mRlBuPrPU0ME3mKijY5UpTouU5c5UYmPP6ueNVhv1B8CT03m08lH1PGZk0Spis9
	x6BxsggEbAvJAogUPMO4AUJejWDEOrZ3xwSAq1piRWtzhBvj439SRA5UuSffQ9HFqH7PWpoNNHX
	X2VMF7qsHRdfJ1NJwU5PDU2flZCReho9rPcqDXwiNLnSJ14CDHb9e/OmnvDrvDGAIXwUbR4L/IN
	RlzQcaNd60kHDHpaHx59ZTrF2vi/hCkRHTkU93weGpoitiw==
X-Google-Smtp-Source: AGHT+IEBI3/9tvuQ3BUVi5V7SGZm4I3o01z5HwuLEeNOENmeRPKn3SDZwrWeSvaP0ado3JN65LNk/g==
X-Received: by 2002:a05:6512:1393:b0:55f:4506:a638 with SMTP id 2adb3069b0e04-55f7093e990mr2307618e87.41.1756746474162;
        Mon, 01 Sep 2025 10:07:54 -0700 (PDT)
Received: from tablet.my.domain ([2a00:f44:892:8a37:6b0:21e7:549b:225b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f7abf7abesm1137666e87.55.2025.09.01.10.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 10:07:53 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 01 Sep 2025 19:07:07 +0200
Subject: [PATCH RESEND v6 1/9] clk: bcm: kona: Move CLOCK_COUNT defines
 into the driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-kona-bus-clock-v6-1-c3ac8215bd4d@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6691;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=nBuDWNA37MXiGLfbOM2Azb046sRyvOaXBtEsYK0w/q0=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBotdLJgoVdyN2WpTmcp17uhOxOMloaZOyaJVDKu
 J+MM2eqA+aJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaLXSyQAKCRCzu/ihE6BR
 aAcDD/9KS21Jls0D4Tl13jDcnM61FzSYr6XH8eZ0cL7KO8zLdBStCLqvhw3vUe48BhwWBpjj7T+
 bsVSlOJyolR8vuLXHYwlg4HZwpOWvYQ/slK67nEPQ3bCvgdQLm3dWCkzlT93VKLR3eXXONyITRn
 BAUkRoA2EavTzSSlXXSzJUOyYS2oi/qblQffCy8uKiXBBwvrYytNJBlJQtYMg0nLDZpqXHu8cWG
 Uy/VE22kaObJy6CIscTcy/vHcgYqQpIqJBk7rUqKKAzWQWYuFMuJgAsLNHqI3Srr8nslxH/2a4M
 xq+C1ZPuQnE9sVpsRRLl3yYFSZxHCD779HPCPT/iLh+XOs9QRX9eHTjQfiY0PPph8hdL1BDYSL9
 VTGXr5u4lxCl4qoY2UKAFC+dLE8WTVB3MDFiHWqhylKWnHSna2btA67ZQ9g1vtuFuzGgErXMX5t
 AyuSzhnjV8+3s13a0eTjKg4FW04yRcbmVuNh6cL+6og6VN4thWKGOALoNbr9hz5MB0nH0sSGd+j
 XqxJgCnCyQKRC1+LdAnFnyDC96+bo1zgVvYzxzPpq2B/1o05j/OXun05VU7g0JodUM8OXrsEd09
 KCB1qM50Se5Ac7L6E0litirzZVHnmKZzOab/LISG6fijRJWLNF/trA9+SnJGVnEcHvLwfMKXZUv
 HxoaIjaZ4Epwu5w==
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
2.51.0


