Return-Path: <linux-kernel+bounces-784955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A72B34413
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4712A601B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E722302CDB;
	Mon, 25 Aug 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kCvU29sP"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82EE2FB98F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132033; cv=none; b=aLWdXQf8tGuYwV2x7/sejhHqF5ZPgqgSxid5ETrKUCiw7If7w46Overve85mqvKLKubQSarlfXljYmbypZ2ymZMo6+YPxpcwm2PVVyRzDarai+KRo6oMmNUGc8rkRExDBf+aSEehy9qRN9POl+Md/E/KWZvGD75PmSAjQ3RooQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132033; c=relaxed/simple;
	bh=wIEIXo0GxVU4ywzJB/g6XZYic4UF9s5rP6rG75651IM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I5zRotc+AlMh9xVRZUifVr2mrNl3yU4c9cgxuN4UhH6XsI4KW1OQMbDaT++/AozlqshRJu32T1i4PVlSMJ/BAGdv8/epdIME/26EtUCoe224RWXlHNTCJiiyoazrvcwDNsfFGiZW+IcJ8Ym324ugAnnpZyVz4OOvINJbuwmMdaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kCvU29sP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3c380aa1ad0so2194249f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756132027; x=1756736827; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzzrp9eAHi9yGAEdwpG/XTAQ7mJqh8kLZKSZyAhHltg=;
        b=kCvU29sPAN5TDjJMN1Hu4LwPJrwRLcEKYkNVH9z5h1sscfdyU2Qxpts7lFkk4xU+zl
         l+HG8oyZvrZfsidGHUJBeZIywbEid7e2soNJL12CAky3KHlm6sn4kja9xpDwDKm3ejBS
         jGi7t3MlsaOdelshsNuRk+FeJzCPIJPXAcGslIK1GbjLUi8yg7UqZ06X87xsaIRg1YfL
         ZrhUokDP1nbj6zCxS1B4wy2PChqw6IQKC5ObWUsQfmSI4HjwGo8Cr34cb3v530T/L6no
         aIeGcQT2gFVTnv1pejslACOwl/jw3EC/psA5qN0ybN0f6GpZYxeBUxezYwHQkTEP3vmQ
         OT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756132027; x=1756736827;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzzrp9eAHi9yGAEdwpG/XTAQ7mJqh8kLZKSZyAhHltg=;
        b=KCPKRVJl0vkA4gto/Ym5CwLHOPuXQI/jpJskn/E4HxbQNUaMl7+Zo5mau8yeurzGmq
         Yowiv/a4/AW33d+7B4678YOo10cRU/bgQk6Bnx5YuZO5V+Beq8U2A96a10hvKL+tyk5z
         P/sF+W9BrPcE8wQ7Pj6RQDm8B2GUiQGxcWr04Gfs9p5Uj+O3jo9prtEcJis208fo0tkZ
         gkudWS12+8yrnGekFCm0Q5fEodllFdkf47LR8fjJdl5jdfHFdwQUmvrVaeDwAHdLG0kZ
         O3hkDDgclWWhxIPTnP2Wu/MrO28hWwqR143McgmxhOYDPbDmrZI2YYuK/NExLZYG3bnU
         GtZw==
X-Forwarded-Encrypted: i=1; AJvYcCVnS4G2assZEFBWUp0s2VEt8+CUQlgdvjps3zwTtTrjl591TB/+BadWhfJwWZ0HKga8+KXEGQzjlQ+XogE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpaMpqK81WHni0bbCly9FQ74dLTDbl3xnNY30Cmp/bRPc//rD5
	FdqGYG5vMKWWhoysisHQDf56NKSIOrYnG6TE1J6ZFeTWhuSdO+xrUpu0W5ysmpyMfEQ3SzwjWoB
	+o5SV
X-Gm-Gg: ASbGncuWXJCPKNsmvhBwSojZ+nfUFDMmJYm+J2C62MHtAbSJm2aGZEBDNPb0RY8mj2C
	oVtWt1HgtJckdH9hL1fRg2PX3M3wHj08Mjx0bq5qfLBQK6opJyBGp6nn1T3akPY/uHAyBHPD8TJ
	EEnimn0n6R7/nuQxYys9fdpGoYXo40jcG3TNhBsHxU+QhRj4ttT37C0QbyNKP75/w1dRIwm32o6
	IYirZ7X2i7qveGrZfjVy7fkiuTHGf/3TYesyhv/XLlb9JD6gcxzYI9LuOo9tFt6QFm9CNm3FEeM
	SzO+Bct1tS8uyuW5CiWZmjQrVin9Qy+C/kBttXmjEOmJ+NMESnJzaCTNMS5UhDSZ6b0Rpb2/Z+7
	KZloBwSUTh4pCbr1FoIFE2yCiwNNw3H5i8WWJ
X-Google-Smtp-Source: AGHT+IEXVdyh48H8oH0/xUTvKXSChcH9i9wf/zeGtDmNyTYV1hOK38cVudoH4thFOwcevE2sV19FMA==
X-Received: by 2002:a5d:5f81:0:b0:3b8:f2f2:e417 with SMTP id ffacd0b85a97d-3c5dcdfc643mr9512373f8f.51.1756132026883;
        Mon, 25 Aug 2025 07:27:06 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:b261:baab:ed3d:3cb6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm12634462f8f.14.2025.08.25.07.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:27:06 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 25 Aug 2025 16:26:26 +0200
Subject: [PATCH v2 01/12] clk: amlogic: drop meson-clkcee
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-meson-clk-cleanup-24-v2-1-0f402f01e117@baylibre.com>
References: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
In-Reply-To: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14449; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=wIEIXo0GxVU4ywzJB/g6XZYic4UF9s5rP6rG75651IM=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBorHKuPU1yavCa12WCaKa7rXOwVuzm2LqDkuG9T
 AdoZYbNdvSJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaKxyrgAKCRDm/A8cN/La
 hQFfD/4/X5co3XCJrSHU/q3oQiOYDRDcRyCDwxFGgtqBezb/7/8BhAqnkJgpuu4F+d9buKMdOA2
 7ZQQ4rMMp12y8/zchEsdh+ZKFUVD5DGEU3aRgsmaob45eeqGoZwqlBBu+2UmIAzujMuaTp/dHOZ
 mdLyjClhSeCly6hLlzh8jWcFMB3aP2QaEOsPHKjBMb+/6e7NDjjZ6453Mi87Qh9Ei0xmq8w9YM9
 qy3Tk+H8FcnLLvjy9feu4D3E/Z7/Un4Kzx3I0hBrgIyReyVqCRZnJHShVVTDRavT/O1l6Tbk9CR
 0mpYBAR+wyMW9v3kUplPkl0ZX8CX2cYOZCWLN7O4/TQ179fAXT9T9GxbFXlvy3jv1yC3QET+xkx
 bl5iv2cX4nNQDc4jF4S0pHW1j37Ssf5sua7ItVKDbzT01C7AxolCQzqDXHI5Pr6x6WEyguMOBXZ
 YTw7SZRD6ruLY6K8/sA5pUT98HhA5U2KolM9AMKzwaf4nRHu4keIGmkjkL0HzaaPxvBPbrK9fIs
 Gl7/TX8mqg8W9+60V/N+F9uP3uS4wbMzmTfBF/sE9ZZkEv9PkRzZK0QAcSbEeJgWbwpBpaaMrJ1
 w1EwsgkznSEhQZ8uQvjNCldY/QBcfXHhJ11qAa2N2OQDjYP9wKcdaDfzinBMRkDyrKFylNw2Hmn
 HervvwEJ8PMD/Rg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

What is being done by the Amlogic clock controller registration helper for
EE controllers could benefit other controllers. As such, having a specific
module for this makes little sense.

Move the helper function to clkc-utils and rename it to describe what it
does, registering syscon based controller, instead of what it serves.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Kconfig            | 13 +++-----
 drivers/clk/meson/Makefile           |  1 -
 drivers/clk/meson/axg.c              |  6 ++--
 drivers/clk/meson/g12a.c             | 28 ++++++++---------
 drivers/clk/meson/gxbb.c             |  8 ++---
 drivers/clk/meson/meson-clkc-utils.c | 50 +++++++++++++++++++++++++++++-
 drivers/clk/meson/meson-clkc-utils.h | 10 ++++++
 drivers/clk/meson/meson-eeclk.c      | 60 ------------------------------------
 drivers/clk/meson/meson-eeclk.h      | 24 ---------------
 9 files changed, 85 insertions(+), 115 deletions(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 7197d23543b8bb8a9020cde316170b50bc359a6c..71481607a6d55d14898f9ecca68f004ccc6f6231 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -36,6 +36,8 @@ config COMMON_CLK_MESON_VCLK
 	select COMMON_CLK_MESON_REGMAP
 
 config COMMON_CLK_MESON_CLKC_UTILS
+	select REGMAP
+	select MFD_SYSCON
 	tristate
 
 config COMMON_CLK_MESON_AO_CLKC
@@ -44,11 +46,6 @@ config COMMON_CLK_MESON_AO_CLKC
 	select COMMON_CLK_MESON_CLKC_UTILS
 	select RESET_CONTROLLER
 
-config COMMON_CLK_MESON_EE_CLKC
-	tristate
-	select COMMON_CLK_MESON_REGMAP
-	select COMMON_CLK_MESON_CLKC_UTILS
-
 config COMMON_CLK_MESON_CPU_DYNDIV
 	tristate
 	select COMMON_CLK_MESON_REGMAP
@@ -73,12 +70,12 @@ config COMMON_CLK_GXBB
 	depends on ARM64
 	default ARCH_MESON
 	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_CLKC_UTILS
 	select COMMON_CLK_MESON_DUALDIV
 	select COMMON_CLK_MESON_VID_PLL_DIV
 	select COMMON_CLK_MESON_MPLL
 	select COMMON_CLK_MESON_PLL
 	select COMMON_CLK_MESON_AO_CLKC
-	select COMMON_CLK_MESON_EE_CLKC
 	select MFD_SYSCON
 	help
 	  Support for the clock controller on AmLogic S905 devices, aka gxbb.
@@ -89,11 +86,11 @@ config COMMON_CLK_AXG
 	depends on ARM64
 	default ARCH_MESON
 	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_CLKC_UTILS
 	select COMMON_CLK_MESON_DUALDIV
 	select COMMON_CLK_MESON_MPLL
 	select COMMON_CLK_MESON_PLL
 	select COMMON_CLK_MESON_AO_CLKC
-	select COMMON_CLK_MESON_EE_CLKC
 	select MFD_SYSCON
 	help
 	  Support for the clock controller on AmLogic A113D devices, aka axg.
@@ -167,11 +164,11 @@ config COMMON_CLK_G12A
 	depends on ARM64
 	default ARCH_MESON
 	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_CLKC_UTILS
 	select COMMON_CLK_MESON_DUALDIV
 	select COMMON_CLK_MESON_MPLL
 	select COMMON_CLK_MESON_PLL
 	select COMMON_CLK_MESON_AO_CLKC
-	select COMMON_CLK_MESON_EE_CLKC
 	select COMMON_CLK_MESON_CPU_DYNDIV
 	select COMMON_CLK_MESON_VID_PLL_DIV
 	select COMMON_CLK_MESON_VCLK
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index bc56a47931c1d27db7dde72b73d9842c93e74f62..c6998e752c683ec9d1736a6811b1cfd71559b289 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -5,7 +5,6 @@ obj-$(CONFIG_COMMON_CLK_MESON_CLKC_UTILS) += meson-clkc-utils.o
 obj-$(CONFIG_COMMON_CLK_MESON_AO_CLKC) += meson-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON_CPU_DYNDIV) += clk-cpu-dyndiv.o
 obj-$(CONFIG_COMMON_CLK_MESON_DUALDIV) += clk-dualdiv.o
-obj-$(CONFIG_COMMON_CLK_MESON_EE_CLKC) += meson-eeclk.o
 obj-$(CONFIG_COMMON_CLK_MESON_MPLL) += clk-mpll.o
 obj-$(CONFIG_COMMON_CLK_MESON_PHASE) += clk-phase.o
 obj-$(CONFIG_COMMON_CLK_MESON_PLL) += clk-pll.o
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 7273178d33f788a989297d7c6fdb5b033630887c..021bc7658f7f49911835abd22badac3eba64a10c 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -18,7 +18,7 @@
 #include "clk-regmap.h"
 #include "clk-pll.h"
 #include "clk-mpll.h"
-#include "meson-eeclk.h"
+#include "meson-clkc-utils.h"
 
 #include <dt-bindings/clock/axg-clkc.h>
 
@@ -2110,7 +2110,7 @@ static struct clk_hw *axg_hw_clks[] = {
 	[CLKID_VDIN_MEAS]		= &axg_vdin_meas.hw,
 };
 
-static const struct meson_eeclkc_data axg_clkc_data = {
+static const struct meson_clkc_data axg_clkc_data = {
 	.hw_clks = {
 		.hws = axg_hw_clks,
 		.num = ARRAY_SIZE(axg_hw_clks),
@@ -2124,7 +2124,7 @@ static const struct of_device_id axg_clkc_match_table[] = {
 MODULE_DEVICE_TABLE(of, axg_clkc_match_table);
 
 static struct platform_driver axg_clkc_driver = {
-	.probe		= meson_eeclkc_probe,
+	.probe		= meson_clkc_syscon_probe,
 	.driver		= {
 		.name	= "axg-clkc",
 		.of_match_table = axg_clkc_match_table,
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 7e2c0ce91964963ae5eb90a5125e5f04e40bc11f..c06a4b678b277e8789a33328e25f0c615b3f1b9d 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -23,7 +23,7 @@
 #include "clk-cpu-dyndiv.h"
 #include "vid-pll-div.h"
 #include "vclk.h"
-#include "meson-eeclk.h"
+#include "meson-clkc-utils.h"
 
 #include <dt-bindings/clock/g12a-clkc.h>
 
@@ -5360,26 +5360,26 @@ static int g12a_dvfs_setup(struct platform_device *pdev)
 }
 
 struct g12a_clkc_data {
-	const struct meson_eeclkc_data eeclkc_data;
+	const struct meson_clkc_data clkc_data;
 	int (*dvfs_setup)(struct platform_device *pdev);
 };
 
 static int g12a_clkc_probe(struct platform_device *pdev)
 {
-	const struct meson_eeclkc_data *eeclkc_data;
+	const struct meson_clkc_data *clkc_data;
 	const struct g12a_clkc_data *g12a_data;
 	int ret;
 
-	eeclkc_data = of_device_get_match_data(&pdev->dev);
-	if (!eeclkc_data)
+	clkc_data = of_device_get_match_data(&pdev->dev);
+	if (!clkc_data)
 		return -EINVAL;
 
-	ret = meson_eeclkc_probe(pdev);
+	ret = meson_clkc_syscon_probe(pdev);
 	if (ret)
 		return ret;
 
-	g12a_data = container_of(eeclkc_data, struct g12a_clkc_data,
-				 eeclkc_data);
+	g12a_data = container_of(clkc_data, struct g12a_clkc_data,
+				 clkc_data);
 
 	if (g12a_data->dvfs_setup)
 		return g12a_data->dvfs_setup(pdev);
@@ -5388,7 +5388,7 @@ static int g12a_clkc_probe(struct platform_device *pdev)
 }
 
 static const struct g12a_clkc_data g12a_clkc_data = {
-	.eeclkc_data = {
+	.clkc_data = {
 		.hw_clks = {
 			.hws = g12a_hw_clks,
 			.num = ARRAY_SIZE(g12a_hw_clks),
@@ -5400,7 +5400,7 @@ static const struct g12a_clkc_data g12a_clkc_data = {
 };
 
 static const struct g12a_clkc_data g12b_clkc_data = {
-	.eeclkc_data = {
+	.clkc_data = {
 		.hw_clks = {
 			.hws = g12b_hw_clks,
 			.num = ARRAY_SIZE(g12b_hw_clks),
@@ -5410,7 +5410,7 @@ static const struct g12a_clkc_data g12b_clkc_data = {
 };
 
 static const struct g12a_clkc_data sm1_clkc_data = {
-	.eeclkc_data = {
+	.clkc_data = {
 		.hw_clks = {
 			.hws = sm1_hw_clks,
 			.num = ARRAY_SIZE(sm1_hw_clks),
@@ -5422,15 +5422,15 @@ static const struct g12a_clkc_data sm1_clkc_data = {
 static const struct of_device_id g12a_clkc_match_table[] = {
 	{
 		.compatible = "amlogic,g12a-clkc",
-		.data = &g12a_clkc_data.eeclkc_data
+		.data = &g12a_clkc_data.clkc_data
 	},
 	{
 		.compatible = "amlogic,g12b-clkc",
-		.data = &g12b_clkc_data.eeclkc_data
+		.data = &g12b_clkc_data.clkc_data
 	},
 	{
 		.compatible = "amlogic,sm1-clkc",
-		.data = &sm1_clkc_data.eeclkc_data
+		.data = &sm1_clkc_data.clkc_data
 	},
 	{}
 };
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 2ad29c7cd6cf04d3e65b25cd96f587d5156759e8..608c2cd34a455f48087dd65809dbcda54f153a71 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -13,7 +13,7 @@
 #include "clk-regmap.h"
 #include "clk-pll.h"
 #include "clk-mpll.h"
-#include "meson-eeclk.h"
+#include "meson-clkc-utils.h"
 #include "vid-pll-div.h"
 
 #include <dt-bindings/clock/gxbb-clkc.h>
@@ -3234,14 +3234,14 @@ static struct clk_hw *gxl_hw_clks[] = {
 	[CLKID_ACODEC]		    = &gxl_acodec.hw,
 };
 
-static const struct meson_eeclkc_data gxbb_clkc_data = {
+static const struct meson_clkc_data gxbb_clkc_data = {
 	.hw_clks = {
 		.hws = gxbb_hw_clks,
 		.num = ARRAY_SIZE(gxbb_hw_clks),
 	},
 };
 
-static const struct meson_eeclkc_data gxl_clkc_data = {
+static const struct meson_clkc_data gxl_clkc_data = {
 	.hw_clks = {
 		.hws = gxl_hw_clks,
 		.num = ARRAY_SIZE(gxl_hw_clks),
@@ -3256,7 +3256,7 @@ static const struct of_device_id gxbb_clkc_match_table[] = {
 MODULE_DEVICE_TABLE(of, gxbb_clkc_match_table);
 
 static struct platform_driver gxbb_clkc_driver = {
-	.probe		= meson_eeclkc_probe,
+	.probe		= meson_clkc_syscon_probe,
 	.driver		= {
 		.name	= "gxbb-clkc",
 		.of_match_table = gxbb_clkc_match_table,
diff --git a/drivers/clk/meson/meson-clkc-utils.c b/drivers/clk/meson/meson-clkc-utils.c
index 6937d1482719bda00da127381025a165907e5db6..49f562d0f203b9a7d15b5119100216564c10cb21 100644
--- a/drivers/clk/meson/meson-clkc-utils.c
+++ b/drivers/clk/meson/meson-clkc-utils.c
@@ -3,9 +3,13 @@
  * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
  */
 
-#include <linux/of_device.h>
 #include <linux/clk-provider.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
 #include "meson-clkc-utils.h"
 
 struct clk_hw *meson_clk_hw_get(struct of_phandle_args *clkspec, void *clk_hw_data)
@@ -22,6 +26,50 @@ struct clk_hw *meson_clk_hw_get(struct of_phandle_args *clkspec, void *clk_hw_da
 }
 EXPORT_SYMBOL_NS_GPL(meson_clk_hw_get, "CLK_MESON");
 
+int meson_clkc_syscon_probe(struct platform_device *pdev)
+{
+	const struct meson_clkc_data *data;
+	struct device *dev = &pdev->dev;
+	struct device_node *np;
+	struct regmap *map;
+	struct clk_hw *hw;
+	int ret, i;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	np = of_get_parent(dev->of_node);
+	map = syscon_node_to_regmap(np);
+	of_node_put(np);
+	if (IS_ERR(map)) {
+		dev_err(dev,
+			"failed to get parent syscon regmap\n");
+		return PTR_ERR(map);
+	}
+
+	if (data->init_count)
+		regmap_multi_reg_write(map, data->init_regs, data->init_count);
+
+	for (i = 0; i < data->hw_clks.num; i++) {
+		hw = data->hw_clks.hws[i];
+
+		/* array might be sparse */
+		if (!hw)
+			continue;
+
+		ret = devm_clk_hw_register(dev, hw);
+		if (ret) {
+			dev_err(dev, "registering %s clock failed\n",
+				hw->init->name);
+			return ret;
+		}
+	}
+
+	return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get, (void *)&data->hw_clks);
+}
+EXPORT_SYMBOL_NS_GPL(meson_clkc_syscon_probe, "CLK_MESON");
+
 MODULE_DESCRIPTION("Amlogic Clock Controller Utilities");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("CLK_MESON");
diff --git a/drivers/clk/meson/meson-clkc-utils.h b/drivers/clk/meson/meson-clkc-utils.h
index fe6f407289496c5c4821b7c9e5a6b6e8a45068b2..26cd47544302b28ca1a342e178956559a84b152a 100644
--- a/drivers/clk/meson/meson-clkc-utils.h
+++ b/drivers/clk/meson/meson-clkc-utils.h
@@ -9,6 +9,8 @@
 #include <linux/of_device.h>
 #include <linux/clk-provider.h>
 
+struct platform_device;
+
 struct meson_clk_hw_data {
 	struct clk_hw	**hws;
 	unsigned int	num;
@@ -16,4 +18,12 @@ struct meson_clk_hw_data {
 
 struct clk_hw *meson_clk_hw_get(struct of_phandle_args *clkspec, void *clk_hw_data);
 
+struct meson_clkc_data {
+	const struct reg_sequence	*init_regs;
+	unsigned int			init_count;
+	struct meson_clk_hw_data	hw_clks;
+};
+
+int meson_clkc_syscon_probe(struct platform_device *pdev);
+
 #endif
diff --git a/drivers/clk/meson/meson-eeclk.c b/drivers/clk/meson/meson-eeclk.c
deleted file mode 100644
index 6236bf970d79e85b1e739c713c03f35a00c291b9..0000000000000000000000000000000000000000
--- a/drivers/clk/meson/meson-eeclk.c
+++ /dev/null
@@ -1,60 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2019 BayLibre, SAS.
- * Author: Jerome Brunet <jbrunet@baylibre.com>
- */
-
-#include <linux/clk-provider.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/mfd/syscon.h>
-#include <linux/regmap.h>
-#include <linux/module.h>
-
-#include "clk-regmap.h"
-#include "meson-eeclk.h"
-
-int meson_eeclkc_probe(struct platform_device *pdev)
-{
-	const struct meson_eeclkc_data *data;
-	struct device *dev = &pdev->dev;
-	struct device_node *np;
-	struct regmap *map;
-	int ret, i;
-
-	data = of_device_get_match_data(dev);
-	if (!data)
-		return -EINVAL;
-
-	/* Get the hhi system controller node */
-	np = of_get_parent(dev->of_node);
-	map = syscon_node_to_regmap(np);
-	of_node_put(np);
-	if (IS_ERR(map)) {
-		dev_err(dev,
-			"failed to get HHI regmap\n");
-		return PTR_ERR(map);
-	}
-
-	if (data->init_count)
-		regmap_multi_reg_write(map, data->init_regs, data->init_count);
-
-	for (i = 0; i < data->hw_clks.num; i++) {
-		/* array might be sparse */
-		if (!data->hw_clks.hws[i])
-			continue;
-
-		ret = devm_clk_hw_register(dev, data->hw_clks.hws[i]);
-		if (ret) {
-			dev_err(dev, "Clock registration failed\n");
-			return ret;
-		}
-	}
-
-	return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get, (void *)&data->hw_clks);
-}
-EXPORT_SYMBOL_NS_GPL(meson_eeclkc_probe, "CLK_MESON");
-
-MODULE_DESCRIPTION("Amlogic Main Clock Controller Helpers");
-MODULE_LICENSE("GPL");
-MODULE_IMPORT_NS("CLK_MESON");
diff --git a/drivers/clk/meson/meson-eeclk.h b/drivers/clk/meson/meson-eeclk.h
deleted file mode 100644
index 6a81d67b46b2270315e24eb58042de8c09b37763..0000000000000000000000000000000000000000
--- a/drivers/clk/meson/meson-eeclk.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2019 BayLibre, SAS.
- * Author: Jerome Brunet <jbrunet@baylibre.com>
- */
-
-#ifndef __MESON_CLKC_H
-#define __MESON_CLKC_H
-
-#include <linux/clk-provider.h>
-#include "clk-regmap.h"
-#include "meson-clkc-utils.h"
-
-struct platform_device;
-
-struct meson_eeclkc_data {
-	const struct reg_sequence	*init_regs;
-	unsigned int			init_count;
-	struct meson_clk_hw_data	hw_clks;
-};
-
-int meson_eeclkc_probe(struct platform_device *pdev);
-
-#endif /* __MESON_CLKC_H */

-- 
2.47.2


