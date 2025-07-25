Return-Path: <linux-kernel+bounces-745473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09712B11A76
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04561CC7778
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F420E2594BD;
	Fri, 25 Jul 2025 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYNFCMgt"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3BB257AC7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753434242; cv=none; b=l58DtQQBJ4b0iWSZoMLNkvBELxQaiUJlDzxKSqc4usBpx0cvoYBKzKX/6DilXg3rb78xNFkp0dy5uaA7QdBm6P8EmVvjDy9wFgkYOHo4SoLipzWx8Fsb30/GaGDrgGkl0L8dWWPsE0cTnClSvXYzU/c1KTfOc0qy/+2hlpG0Lqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753434242; c=relaxed/simple;
	bh=6vM1EJPOw6Q4Qtlb27Cb82oUvYEiD6W/XiM1RMs35fE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nU0uwINGGWaE0KCAazGGxzUCj0qoUC2HcwIz85V7GXB2VxDyf475KBPOX7Zewf4kq8rpvlNaiwJgKuBawx8LDH5EOzgEniASV9tqdtpSL0pCRxoeh9FRRBQbl4ZQ7xH/IdKmHC1XOUTAaePzf0rbUnrrFVmncmINLzSAASjiueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BYNFCMgt; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a52878d37aso61839f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753434238; x=1754039038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsoNTEfmfMdvFP0lv+IxaAbjZbzLYpdHn40uDlPZMSg=;
        b=BYNFCMgtMOIM+m6uEPM+IX0ZHEGlNlxguniM3q6EFZXROG7Mi+Knyb1VIYsdnC89Vw
         RlbVjVxx/35Aq6bpIr7ypjTM/ewJnO0leTn3Tr/iMHOQzOYbMvbPBit2myiOLopyjGxC
         NibSMQXFmGiLFFi1qe72wi0jtJThT64wVy5JrDcePDuF1WBjI202rw4ZATfpIeJL4KOJ
         iwFitEw1fOdU40wgbZBXJ5z7APzwKgDMsecnhyoGt22lDdFD2odE77mZL3Cue6vlWxeF
         cU4KvTHLf+Bbh8r/iNQYerDhzwXEzICZu2kntjcY31RrJi3e4cuICdaPuPB+YjvkPNkU
         rlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753434238; x=1754039038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZsoNTEfmfMdvFP0lv+IxaAbjZbzLYpdHn40uDlPZMSg=;
        b=IZ+nxB3u5LuJ5JvLkX0Hi6xd2yuqsJR10Koc0gtrvy5pEHkAwoC6dI9PaLi9Pt+ccp
         xPPidFaNc0AmtnNmSonCiVvuLQWJ73GPZGveErvkkgWghi10E+okK61YR1W+st9atzHv
         dFXi6gXkmYua8hnwv60nAMyp/b3+/JB3jJUngmcuno9HlsncJHiBa2eMw8yw5J63Lo/h
         8/O8McFN34XGPB7GSUEVLeXEHdk8lz9UBYxxaXBnmh6XtK1q1JVnh9s7BFCZlp2liJTZ
         emT7l1br9DfM7qVEDaMHA4p9pO5x2agl35bJQTqN/L+TKU8eJzYuJVADWoNcGLMXoRpO
         BA/A==
X-Forwarded-Encrypted: i=1; AJvYcCVBlDZPJMB2NwqijOyuPDITQ0jP2jkg2QN3Eub94xFcAf4l9hiAMs5DRa46gHoT/F9/1IEaCMuvG60O38g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoUHfntiuehGzNqASQYGmhGPnWX4KeQPuP1P96+DIXo7QlJ1rD
	xZ+xEpDX7OHH3lBjstdhPkFW9ypRhl6w98YVEi+XjDCKOPkwTN2RPoUwYJO8Y/8FD70=
X-Gm-Gg: ASbGncsDjlSEwumrvp7VmCXL5neB4sJ4JY/0En88QTTw1CeH8vBH6RJgVCi8d8Wum99
	lDX5pyMqlhRqoxEdHEglyJ0cP/t5hdl9MlwwhYIxlDeqlN2IrWmVxAxdyv8b4e2rnOXxlIztnO2
	vYgxh0TKlbfhO+DcUqXkF6c8hmJVHRiu2h8pT/6bxjWtwG/WGotf/4/ENErB6mTafkjOv9UGWfB
	TIyaqUcYG+gMObHltpG2Dons2Ci8L8JECps6SgGErTyWmtiy9EafM+yjNdQq2C1uI/XXaTIhCV2
	cy3pkeylgxrbxuVWMxHRKAMIeIJuIuUN1Xz0rWqgNsotcxxAb6GumVGh5MLmzzOaHV1EthaY8rL
	tcd8zp9aeYkn6kHOvz5S40t/BvN7r5TJY
X-Google-Smtp-Source: AGHT+IGNh7egRS4Kex6r927tL9H0Aj3/PBwDBRA+aKAvEzjTyuXGGLNytvVXgOYRLookHqQtsKhc7Q==
X-Received: by 2002:a5d:5d84:0:b0:3a4:e0ad:9aa5 with SMTP id ffacd0b85a97d-3b77675b226mr421712f8f.11.1753434238420;
        Fri, 25 Jul 2025 02:03:58 -0700 (PDT)
Received: from kuoka.. ([178.197.203.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc6d1b0sm4457094f8f.18.2025.07.25.02.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 02:03:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Will McVicker <willmcvicker@google.com>,
	Youngmin Nam <youngmin.nam@samsung.com>,
	Donghoon Yu <hoony.yu@samsung.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] clocksource/drivers/exynos_mct: Revert commits causing section mismatches
Date: Fri, 25 Jul 2025 11:03:50 +0200
Message-ID: <20250725090349.87730-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6066; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=6vM1EJPOw6Q4Qtlb27Cb82oUvYEiD6W/XiM1RMs35fE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBog0h1G5Uk9Pte6K2erF5TqunuTTBgTDpGsrvV8
 TEOHz0s63OJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaINIdQAKCRDBN2bmhouD
 1wWRD/98MncWXJ487P4kJKVuFRECgj7W6JrPbTWD1EFBGsiBhmOGCRM2RSyKQZXGViRmQsThRHa
 g+al4JPMNu8ZgRgoH3scYChiRxjmHMa6WjuNpLtX5V2RoH3KwZciSSpvxXJgeakJ77f5NpzwsVx
 rzQwovhhoLN4sbRTX5R4a+Qc7aO/U0ClyYZjPFFPc44D6XBocWK/4q3Y21WGmSXSOGbIWCwNc5/
 EBZ1xXzPPQ2PyEkLQiLgkWpkoHCe+09gm0M/ACxlRm4mdiX9uNJ+4qTjSeIl04LnNX3qNQ+Lriv
 DLeJuuFv1Nqm7zo96pkaLRwt5itojLI/iMHiHwBjERAXVn3atyB7tsj/DZOp1hB9LXtzruJ5Kup
 3/Hk+iDz2QXx8qjyvdK1r75tEg3nBBCCjLmEGbcGHHaSeU26N4auuX1FQTCqJXvV+hoTDNNhAtH
 ufJdEUHbyKyWQr6RyiJM3qRDjne0af36YX5iQcRJL+SAuw55jf6ITi3yIRqI/ygPC4uHNUOVOVw
 aU+/QY00QV0d0rrJvObAsiuj4pgMjRUgVGHLcq+J2WzDCnnr0mtqNVRGw2gmlLAN/0ZvsC7Z1PG
 Km9rBuMIgYmOBCqKlj/X7w5dfahbhLGiavdVXuI03ZtzHJeS5OLteenkWBtg5k3EgDcwSnrx92w Lji1FxNr7fmWU5w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Commit 5d86e479193b ("clocksource/drivers/exynos_mct: Add module
support") introduced section mismatch failures.
Commit 7e477e9c4eb4 ("clocksource/drivers/exynos_mct: Fix section
mismatch from the module conversion") replaced these to other section
mismatch failures:

  WARNING: modpost: vmlinux: section mismatch in reference: mct_init_dt+0x164 (section: .text) -> register_current_timer_delay (section: .init.text)
  WARNING: modpost: vmlinux: section mismatch in reference: mct_init_dt+0x20c (section: .text) -> register_current_timer_delay (section: .init.text)
  ERROR: modpost: Section mismatches detected.

No progress on real fixing of these happened (intermediary fix was still
not tested), so revert both commits till the work is prepared correctly.

Fixes: 7e477e9c4eb4 ("clocksource/drivers/exynos_mct: Fix section mismatch from the module conversion")
Fixes: 5d86e479193b ("clocksource/drivers/exynos_mct: Add module support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

First build failure:
https://krzk.eu/#/builders/12/builds/3350
---
 drivers/clocksource/Kconfig      |  3 +-
 drivers/clocksource/exynos_mct.c | 51 ++++++--------------------------
 2 files changed, 10 insertions(+), 44 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index d657c8ddc96b..645f517a1ac2 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -451,8 +451,7 @@ config ATMEL_TCB_CLKSRC
 	  Support for Timer Counter Blocks on Atmel SoCs.
 
 config CLKSRC_EXYNOS_MCT
-	tristate "Exynos multi core timer driver" if ARM64
-	default y if ARCH_EXYNOS || COMPILE_TEST
+	bool "Exynos multi core timer driver" if COMPILE_TEST
 	depends on ARM || ARM64
 	depends on ARCH_ARTPEC || ARCH_EXYNOS || COMPILE_TEST
 	help
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 80d263ee046d..62febeb4e1de 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -15,11 +15,9 @@
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/percpu.h>
-#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
-#include <linux/platform_device.h>
 #include <linux/clocksource.h>
 #include <linux/sched_clock.h>
 
@@ -219,7 +217,6 @@ static struct clocksource mct_frc = {
 	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	.resume		= exynos4_frc_resume,
-	.owner		= THIS_MODULE,
 };
 
 /*
@@ -244,7 +241,7 @@ static cycles_t exynos4_read_current_timer(void)
 }
 #endif
 
-static int exynos4_clocksource_init(bool frc_shared)
+static int __init exynos4_clocksource_init(bool frc_shared)
 {
 	/*
 	 * When the frc is shared, the main processor should have already
@@ -339,7 +336,6 @@ static struct clock_event_device mct_comp_device = {
 	.set_state_oneshot	= mct_set_state_shutdown,
 	.set_state_oneshot_stopped = mct_set_state_shutdown,
 	.tick_resume		= mct_set_state_shutdown,
-	.owner			= THIS_MODULE,
 };
 
 static irqreturn_t exynos4_mct_comp_isr(int irq, void *dev_id)
@@ -480,7 +476,6 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
 			CLOCK_EVT_FEAT_PERCPU;
 	evt->rating = MCT_CLKEVENTS_RATING;
-	evt->owner = THIS_MODULE;
 
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
 
@@ -516,7 +511,7 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
 	return 0;
 }
 
-static int exynos4_timer_resources(struct device_node *np)
+static int __init exynos4_timer_resources(struct device_node *np)
 {
 	struct clk *mct_clk, *tick_clk;
 
@@ -544,7 +539,7 @@ static int exynos4_timer_resources(struct device_node *np)
  * @local_idx: array mapping CPU numbers to local timer indices
  * @nr_local: size of @local_idx array
  */
-static int exynos4_timer_interrupts(struct device_node *np,
+static int __init exynos4_timer_interrupts(struct device_node *np,
 					   unsigned int int_type,
 					   const u32 *local_idx,
 					   size_t nr_local)
@@ -657,7 +652,7 @@ static int exynos4_timer_interrupts(struct device_node *np,
 	return err;
 }
 
-static __init_or_module int mct_init_dt(struct device_node *np, unsigned int int_type)
+static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 {
 	bool frc_shared = of_property_read_bool(np, "samsung,frc-shared");
 	u32 local_idx[MCT_NR_LOCAL] = {0};
@@ -705,43 +700,15 @@ static __init_or_module int mct_init_dt(struct device_node *np, unsigned int int
 	return exynos4_clockevent_init();
 }
 
-static __init_or_module int mct_init_spi(struct device_node *np)
+
+static int __init mct_init_spi(struct device_node *np)
 {
 	return mct_init_dt(np, MCT_INT_SPI);
 }
 
-static __init_or_module int mct_init_ppi(struct device_node *np)
+static int __init mct_init_ppi(struct device_node *np)
 {
 	return mct_init_dt(np, MCT_INT_PPI);
 }
-
-static int exynos4_mct_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	int (*mct_init)(struct device_node *np);
-
-	mct_init = of_device_get_match_data(dev);
-	if (!mct_init)
-		return -EINVAL;
-
-	return mct_init(dev->of_node);
-}
-
-static const struct of_device_id exynos4_mct_match_table[] = {
-	{ .compatible = "samsung,exynos4210-mct", .data = &mct_init_spi, },
-	{ .compatible = "samsung,exynos4412-mct", .data = &mct_init_ppi, },
-	{}
-};
-MODULE_DEVICE_TABLE(of, exynos4_mct_match_table);
-
-static struct platform_driver exynos4_mct_driver = {
-	.probe		= exynos4_mct_probe,
-	.driver		= {
-		.name	= "exynos-mct",
-		.of_match_table = exynos4_mct_match_table,
-	},
-};
-module_platform_driver(exynos4_mct_driver);
-
-MODULE_DESCRIPTION("Exynos Multi Core Timer Driver");
-MODULE_LICENSE("GPL");
+TIMER_OF_DECLARE(exynos4210, "samsung,exynos4210-mct", mct_init_spi);
+TIMER_OF_DECLARE(exynos4412, "samsung,exynos4412-mct", mct_init_ppi);
-- 
2.48.1


