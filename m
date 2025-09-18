Return-Path: <linux-kernel+bounces-784966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C473B343FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CEB31A86132
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2CE3090EE;
	Mon, 25 Aug 2025 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QZR18ve4"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E33302749
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132041; cv=none; b=IdcnEfrNkCsmFe3QOQqr6mQJWeiRgQQRA6YFOJ+NkgwNtxVhQA3I0a1aL7AQMENcKY0rTVdg+oxyPJbSFs7tbD+onTwAZ2SjGqoo4hnUX+55wTIawhCpj7GP+K7idxis07AOs62Ey3Ahy2mNR0PQrvun5GbqKsq9CBja7YSeEm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132041; c=relaxed/simple;
	bh=X5//jNi74IpHsHYBbOdRVuP6Q8Mvlr1eAL2dNlSaP1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lD+CWyrikbXxB/rYAkNHw1x1KVTSJIEBcniialDa4DNhvtoMk1h0unDh5YOcQnbCM+fBqV8zaT75erhX7x1GT/LuiKM7v6emfskTBu2L4RulwjwztNKu8h8vfQX0tenqQEDhMjJuPOYDXplUJu/0KwrjaMjtM6VZFY4CqZ9GGPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QZR18ve4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a286135c8so27676445e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756132032; x=1756736832; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=obtHB0H0zF8/AUNa0Qw+GTMgbmBek7VKVmSq18IqlTc=;
        b=QZR18ve4RKYv0uifKtrh22Z8eozwOTM7q+8KFGrKXlc1FYjimdETd4/MMBUEYxefjv
         rEVKt/ZaVToIqpjl67Fckl/HT84N+4tEu5fJMndhdErV5CqYYqVqSGUnNpxVENmmm2sf
         pafTnsV8W5P5A/Xx0XE1IZ/Xr7pcRdu/WvGjAeqUi6Nao+UfSXciqSToPv2RtTGtY8ss
         c1RDauiG0/J2g+CLh+rCQE4jmNCGbfY6ZpYmu27hJVxhVcOQCvnaFwzvO1uCO1UjTX5e
         rR/qai0S2p7S0cauxDmFTapRrwgSs2XpdXyoVTmMIKOsulXou+y0+skVJLjW6BHkQ6GQ
         eHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756132032; x=1756736832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obtHB0H0zF8/AUNa0Qw+GTMgbmBek7VKVmSq18IqlTc=;
        b=t1s9bz/OKFafVaQR3S0bT01Vu0ey0+lZBhvxj7fcyWaj7a8A1e4mlmuM6hFLSR2AtO
         bUd56N1ZK5GoPHuWAqDcDoqE0wVRljIytkwQDlUzCgv5D7xgQhSf+EVHmyDtQZiLye8s
         f9C/YXp42fZaLyAynOrHWliGkZNExGmNbnqtH+l6V+FiQRqJuFnNqDRACNq5EPkyyUIj
         kK5/xnYyyxXMZPKZOmUa+ghATPX+//3pSI1VoMT/1048B49OUL8YAWZgcc378z8nIRCz
         3JvSEF6xazxVMwW6PLiX+zhbSMHCmK8IOjQ7yXXVXqVVKP3aDQNMs2Cc5Ln9NP+DbHtS
         3Mdg==
X-Forwarded-Encrypted: i=1; AJvYcCVqgyMNOTMptUTAirpjVGo2svbq5ljZt2RmgvG+LVQggoLt2zRxfaEbMuXKB4UpO58jPJvr+u1ZeEsCM/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpPZfIw71QeE7c0xcfnIpuuRUdVdHXDR4kSDsGKzDm+BULINbP
	efhtUIKKDr7q4fyFIo8Az+6rp1UPJ6oNfw9XOCkxCZ/YuW+Hew0J4D7btaNnUvG9hE4=
X-Gm-Gg: ASbGncsB35r0rD2QJAJTR4Ms2NDw1hZjxbmXZjEd3XRTYSJ4MGi7N/oR0Z7GmgvIh2V
	ntpAwDYhD2k8X+sHLz/1FBnVWCL7bAsAEwcMwLKMZ799KGw8RQw4wnKKT8CWYnxVDNFg0zzFu6P
	oTxsoNrgGz1wr0op2aVGbICgf9j0BwKYmwOM2MDp2Mxpd6HJPntWiRD4JMhO0tCh+2UvImFiTMN
	LC2iA8U/rHJxT0njc2Nq1oWP6qinSN+kF96a5ZYR3m/+iQxCB+iFro5gkKwTKfq5aV9jBV5u/kG
	PpQsjLMa7ghRO6yWdOqUfEK1eRpXITC9rwyLlyqqsb9BEANe/mDRLOun1DHz57p5rOLSnAY4ulL
	3FQo6ReEkscDlto4KoVGKmsMzKpqTMWQDUMii
X-Google-Smtp-Source: AGHT+IFcq3ZXI3i0LHZWpsp/q+i24wDf6XY6QuEKult4QnrTYt+AlspnV3rhphQd1qYlTs82qh5j+Q==
X-Received: by 2002:adf:f7d2:0:b0:3c5:921a:f440 with SMTP id ffacd0b85a97d-3c5922a3763mr9495467f8f.12.1756132031283;
        Mon, 25 Aug 2025 07:27:11 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:b261:baab:ed3d:3cb6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm12634462f8f.14.2025.08.25.07.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:27:10 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 25 Aug 2025 16:26:32 +0200
Subject: [PATCH v2 07/12] clk: amlogic: pclk explicitly use
 CLK_IGNORE_UNUSED
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-meson-clk-cleanup-24-v2-7-0f402f01e117@baylibre.com>
References: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
In-Reply-To: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=65122; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=X5//jNi74IpHsHYBbOdRVuP6Q8Mvlr1eAL2dNlSaP1Y=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBorHK0qxQE/1xHz8WUZ7io62TpsxvDFsBuEMZju
 mPz1+/hAh2JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaKxytAAKCRDm/A8cN/La
 hcaSEACQNlTYtAvySYcw/eLaxmExXPR4vf97oYZwdL38KdU0P2oaV/NbrdLb3AGSClt3g6dwf/X
 jCqe9PmpPf+GsF7ifMO7RanyJ/0bwTKkJu8rphg1Jtb3KbGXcovm+x0U0jstR7NXN3Xyv6gMxu4
 +RbfftkoP1LxQ3/XbRjX2Q40o15kHpqUdAy5R1kHWWDpW9W0tc/ofGGLEGEkf+kMtMY7JuaQX2i
 sywHhFG81fmWEyRTURdiI71Z8Y/OiACqDBCNdEXezNgnYQH/RNcc9VppbsMvYOx4x4y8m9m89VZ
 UvCnHvRGy1dWU8/MSFnDJ8s/mA01qBpgW4xV/nRzVVuARbZ2NlR1GaPx7YycgdmEb8Pr3w1FbFR
 3cnh5CkUqWYb9fOZ6GuiEITTXdauXDakV3kA28pkHRhB5XUQDm0441psbJY7FnHat19unZ+Gr0z
 LRVj4e5x7ra74ObTpyLC3qzaVgNZOyTls7La6W7Fj5nt8v07WAFTaqeuClffCDtSdSB4ipMXnmZ
 qoUKTOxKSlisWJqev2kn+PI3dyQTsLnXqTh5/vOesA88Pfw/xB3a4lkXeA8ZcSV18gf49IRRwY7
 C37EHrXxSPc2gBQilqCobeSFVapd3R9fgai3QCRCX86ACdlw4+E205rH9pOP8/hA0wkMjtRO4Xg
 Y1BfULMe9SFFOuw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Every usage of CLK_IGNORE_UNUSED should be explicitly motivated and
documented. However, the PCLK macros used by most Amlogic platforms are
adding that flag systematically. Because of this, all pclks are marked with
CLK_IGNORE_UNUSED, without any form of distinction or motivation.

This may have been fine in the early days of CCF but it is not anymore.

Just removing the flag is not an option at this stage since it could cause
regression on existing platforms.

Instead, drop the flag from the macro definition and add it to the each
clock definition, for the existing clocks. This makes quite a nasty change
but it will make it a lot easier for people to contribute to fixing the
problem, clock by clock. It will also prevent new platform from being added
with a silent use of the flag.

Reviewed-by: Chuan Liu <chuan.liu@amlogic.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/a1-peripherals.c   | 125 ++++++++++++-----------
 drivers/clk/meson/axg-aoclk.c        |  18 ++--
 drivers/clk/meson/axg.c              | 110 ++++++++++----------
 drivers/clk/meson/g12a-aoclk.c       |  49 ++++-----
 drivers/clk/meson/g12a.c             | 176 ++++++++++++++++----------------
 drivers/clk/meson/gxbb-aoclk.c       |  16 +--
 drivers/clk/meson/gxbb.c             | 188 ++++++++++++++++++-----------------
 drivers/clk/meson/meson-clkc-utils.h |  12 +--
 drivers/clk/meson/meson8b.c          | 183 ++++++++++++++++++----------------
 drivers/clk/meson/s4-peripherals.c   | 119 ++++++++++++----------
 10 files changed, 528 insertions(+), 468 deletions(-)

diff --git a/drivers/clk/meson/a1-peripherals.c b/drivers/clk/meson/a1-peripherals.c
index b2feb8fe4775e38a17d8aa9ce9b992b3e1fb2bb8..a7bd3822df18f5e043e58e2d7bbcaa24345ea404 100644
--- a/drivers/clk/meson/a1-peripherals.c
+++ b/drivers/clk/meson/a1-peripherals.c
@@ -1840,64 +1840,73 @@ static struct clk_regmap a1_cecb_32k_out = {
 	},
 };
 
-#define A1_PCLK(_name, _reg, _bit) \
-	MESON_PCLK(a1_##_name, _reg, _bit, &a1_sys.hw)
-
-static A1_PCLK(clktree,		SYS_CLK_EN0,	0);
-static A1_PCLK(reset_ctrl,	SYS_CLK_EN0,	1);
-static A1_PCLK(analog_ctrl,	SYS_CLK_EN0,	2);
-static A1_PCLK(pwr_ctrl,	SYS_CLK_EN0,	3);
-static A1_PCLK(pad_ctrl,	SYS_CLK_EN0,	4);
-static A1_PCLK(sys_ctrl,	SYS_CLK_EN0,	5);
-static A1_PCLK(temp_sensor,	SYS_CLK_EN0,	6);
-static A1_PCLK(am2axi_dev,	SYS_CLK_EN0,	7);
-static A1_PCLK(spicc_b,		SYS_CLK_EN0,	8);
-static A1_PCLK(spicc_a,		SYS_CLK_EN0,	9);
-static A1_PCLK(msr,		SYS_CLK_EN0,	10);
-static A1_PCLK(audio,		SYS_CLK_EN0,	11);
-static A1_PCLK(jtag_ctrl,	SYS_CLK_EN0,	12);
-static A1_PCLK(saradc_en,	SYS_CLK_EN0,	13);
-static A1_PCLK(pwm_ef,		SYS_CLK_EN0,	14);
-static A1_PCLK(pwm_cd,		SYS_CLK_EN0,	15);
-static A1_PCLK(pwm_ab,		SYS_CLK_EN0,	16);
-static A1_PCLK(cec,		SYS_CLK_EN0,	17);
-static A1_PCLK(i2c_s,		SYS_CLK_EN0,	18);
-static A1_PCLK(ir_ctrl,		SYS_CLK_EN0,	19);
-static A1_PCLK(i2c_m_d,		SYS_CLK_EN0,	20);
-static A1_PCLK(i2c_m_c,		SYS_CLK_EN0,	21);
-static A1_PCLK(i2c_m_b,		SYS_CLK_EN0,	22);
-static A1_PCLK(i2c_m_a,		SYS_CLK_EN0,	23);
-static A1_PCLK(acodec,		SYS_CLK_EN0,	24);
-static A1_PCLK(otp,		SYS_CLK_EN0,	25);
-static A1_PCLK(sd_emmc_a,	SYS_CLK_EN0,	26);
-static A1_PCLK(usb_phy,		SYS_CLK_EN0,	27);
-static A1_PCLK(usb_ctrl,	SYS_CLK_EN0,	28);
-static A1_PCLK(sys_dspb,	SYS_CLK_EN0,	29);
-static A1_PCLK(sys_dspa,	SYS_CLK_EN0,	30);
-static A1_PCLK(dma,		SYS_CLK_EN0,	31);
-
-static A1_PCLK(irq_ctrl,	SYS_CLK_EN1,	0);
-static A1_PCLK(nic,		SYS_CLK_EN1,	1);
-static A1_PCLK(gic,		SYS_CLK_EN1,	2);
-static A1_PCLK(uart_c,		SYS_CLK_EN1,	3);
-static A1_PCLK(uart_b,		SYS_CLK_EN1,	4);
-static A1_PCLK(uart_a,		SYS_CLK_EN1,	5);
-static A1_PCLK(sys_psram,	SYS_CLK_EN1,	6);
-static A1_PCLK(rsa,		SYS_CLK_EN1,	8);
-static A1_PCLK(coresight,	SYS_CLK_EN1,	9);
-
-static A1_PCLK(am2axi_vad,	AXI_CLK_EN,	0);
-static A1_PCLK(audio_vad,	AXI_CLK_EN,	1);
-static A1_PCLK(axi_dmc,		AXI_CLK_EN,	3);
-static A1_PCLK(axi_psram,	AXI_CLK_EN,	4);
-static A1_PCLK(ramb,		AXI_CLK_EN,	5);
-static A1_PCLK(rama,		AXI_CLK_EN,	6);
-static A1_PCLK(axi_spifc,	AXI_CLK_EN,	7);
-static A1_PCLK(axi_nic,		AXI_CLK_EN,	8);
-static A1_PCLK(axi_dma,		AXI_CLK_EN,	9);
-static A1_PCLK(cpu_ctrl,	AXI_CLK_EN,	10);
-static A1_PCLK(rom,		AXI_CLK_EN,	11);
-static A1_PCLK(prod_i2c,	AXI_CLK_EN,	12);
+#define A1_PCLK(_name, _reg, _bit, _flags) \
+	MESON_PCLK(a1_##_name, _reg, _bit, &a1_sys.hw, _flags)
+
+/*
+ * NOTE: The gates below are marked with CLK_IGNORE_UNUSED for historic reasons
+ * Users are encouraged to test without it and submit changes to:
+ *  - remove the flag if not necessary
+ *  - replace the flag with something more adequate, such as CLK_IS_CRITICAL,
+ *    if appropriate.
+ *  - add a comment explaining why the use of CLK_IGNORE_UNUSED is desirable
+ *    for a particular clock.
+ */
+static A1_PCLK(clktree,		SYS_CLK_EN0,	 0, CLK_IGNORE_UNUSED);
+static A1_PCLK(reset_ctrl,	SYS_CLK_EN0,	 1, CLK_IGNORE_UNUSED);
+static A1_PCLK(analog_ctrl,	SYS_CLK_EN0,	 2, CLK_IGNORE_UNUSED);
+static A1_PCLK(pwr_ctrl,	SYS_CLK_EN0,	 3, CLK_IGNORE_UNUSED);
+static A1_PCLK(pad_ctrl,	SYS_CLK_EN0,	 4, CLK_IGNORE_UNUSED);
+static A1_PCLK(sys_ctrl,	SYS_CLK_EN0,	 5, CLK_IGNORE_UNUSED);
+static A1_PCLK(temp_sensor,	SYS_CLK_EN0,	 6, CLK_IGNORE_UNUSED);
+static A1_PCLK(am2axi_dev,	SYS_CLK_EN0,	 7, CLK_IGNORE_UNUSED);
+static A1_PCLK(spicc_b,		SYS_CLK_EN0,	 8, CLK_IGNORE_UNUSED);
+static A1_PCLK(spicc_a,		SYS_CLK_EN0,	 9, CLK_IGNORE_UNUSED);
+static A1_PCLK(msr,		SYS_CLK_EN0,	10, CLK_IGNORE_UNUSED);
+static A1_PCLK(audio,		SYS_CLK_EN0,	11, CLK_IGNORE_UNUSED);
+static A1_PCLK(jtag_ctrl,	SYS_CLK_EN0,	12, CLK_IGNORE_UNUSED);
+static A1_PCLK(saradc_en,	SYS_CLK_EN0,	13, CLK_IGNORE_UNUSED);
+static A1_PCLK(pwm_ef,		SYS_CLK_EN0,	14, CLK_IGNORE_UNUSED);
+static A1_PCLK(pwm_cd,		SYS_CLK_EN0,	15, CLK_IGNORE_UNUSED);
+static A1_PCLK(pwm_ab,		SYS_CLK_EN0,	16, CLK_IGNORE_UNUSED);
+static A1_PCLK(cec,		SYS_CLK_EN0,	17, CLK_IGNORE_UNUSED);
+static A1_PCLK(i2c_s,		SYS_CLK_EN0,	18, CLK_IGNORE_UNUSED);
+static A1_PCLK(ir_ctrl,		SYS_CLK_EN0,	19, CLK_IGNORE_UNUSED);
+static A1_PCLK(i2c_m_d,		SYS_CLK_EN0,	20, CLK_IGNORE_UNUSED);
+static A1_PCLK(i2c_m_c,		SYS_CLK_EN0,	21, CLK_IGNORE_UNUSED);
+static A1_PCLK(i2c_m_b,		SYS_CLK_EN0,	22, CLK_IGNORE_UNUSED);
+static A1_PCLK(i2c_m_a,		SYS_CLK_EN0,	23, CLK_IGNORE_UNUSED);
+static A1_PCLK(acodec,		SYS_CLK_EN0,	24, CLK_IGNORE_UNUSED);
+static A1_PCLK(otp,		SYS_CLK_EN0,	25, CLK_IGNORE_UNUSED);
+static A1_PCLK(sd_emmc_a,	SYS_CLK_EN0,	26, CLK_IGNORE_UNUSED);
+static A1_PCLK(usb_phy,		SYS_CLK_EN0,	27, CLK_IGNORE_UNUSED);
+static A1_PCLK(usb_ctrl,	SYS_CLK_EN0,	28, CLK_IGNORE_UNUSED);
+static A1_PCLK(sys_dspb,	SYS_CLK_EN0,	29, CLK_IGNORE_UNUSED);
+static A1_PCLK(sys_dspa,	SYS_CLK_EN0,	30, CLK_IGNORE_UNUSED);
+static A1_PCLK(dma,		SYS_CLK_EN0,	31, CLK_IGNORE_UNUSED);
+
+static A1_PCLK(irq_ctrl,	SYS_CLK_EN1,	 0, CLK_IGNORE_UNUSED);
+static A1_PCLK(nic,		SYS_CLK_EN1,	 1, CLK_IGNORE_UNUSED);
+static A1_PCLK(gic,		SYS_CLK_EN1,	 2, CLK_IGNORE_UNUSED);
+static A1_PCLK(uart_c,		SYS_CLK_EN1,	 3, CLK_IGNORE_UNUSED);
+static A1_PCLK(uart_b,		SYS_CLK_EN1,	 4, CLK_IGNORE_UNUSED);
+static A1_PCLK(uart_a,		SYS_CLK_EN1,	 5, CLK_IGNORE_UNUSED);
+static A1_PCLK(sys_psram,	SYS_CLK_EN1,	 6, CLK_IGNORE_UNUSED);
+static A1_PCLK(rsa,		SYS_CLK_EN1,	 8, CLK_IGNORE_UNUSED);
+static A1_PCLK(coresight,	SYS_CLK_EN1,	 9, CLK_IGNORE_UNUSED);
+
+static A1_PCLK(am2axi_vad,	AXI_CLK_EN,	 0, CLK_IGNORE_UNUSED);
+static A1_PCLK(audio_vad,	AXI_CLK_EN,	 1, CLK_IGNORE_UNUSED);
+static A1_PCLK(axi_dmc,		AXI_CLK_EN,	 3, CLK_IGNORE_UNUSED);
+static A1_PCLK(axi_psram,	AXI_CLK_EN,	 4, CLK_IGNORE_UNUSED);
+static A1_PCLK(ramb,		AXI_CLK_EN,	 5, CLK_IGNORE_UNUSED);
+static A1_PCLK(rama,		AXI_CLK_EN,	 6, CLK_IGNORE_UNUSED);
+static A1_PCLK(axi_spifc,	AXI_CLK_EN,	 7, CLK_IGNORE_UNUSED);
+static A1_PCLK(axi_nic,		AXI_CLK_EN,	 8, CLK_IGNORE_UNUSED);
+static A1_PCLK(axi_dma,		AXI_CLK_EN,	 9, CLK_IGNORE_UNUSED);
+static A1_PCLK(cpu_ctrl,	AXI_CLK_EN,	10, CLK_IGNORE_UNUSED);
+static A1_PCLK(rom,		AXI_CLK_EN,	11, CLK_IGNORE_UNUSED);
+static A1_PCLK(prod_i2c,	AXI_CLK_EN,	12, CLK_IGNORE_UNUSED);
 
 /* Array of all clocks registered by this provider */
 static struct clk_hw *a1_peripherals_hw_clks[] = {
diff --git a/drivers/clk/meson/axg-aoclk.c b/drivers/clk/meson/axg-aoclk.c
index efc33fd18c197df233d537e5f8244a376d4d0924..74c2f51424f11cc04a80a3a4918e4de0a5d11d08 100644
--- a/drivers/clk/meson/axg-aoclk.c
+++ b/drivers/clk/meson/axg-aoclk.c
@@ -34,7 +34,7 @@
 #define AO_RTC_ALT_CLK_CNTL0	0x94
 #define AO_RTC_ALT_CLK_CNTL1	0x98
 
-#define AXG_AO_GATE(_name, _bit)					\
+#define AXG_AO_GATE(_name, _bit, _flags)				\
 static struct clk_regmap axg_ao_##_name = {				\
 	.data = &(struct clk_regmap_gate_data) {			\
 		.offset = (AO_RTI_GEN_CNTL_REG0),			\
@@ -47,17 +47,17 @@ static struct clk_regmap axg_ao_##_name = {				\
 			.fw_name = "mpeg-clk",				\
 		},							\
 		.num_parents = 1,					\
-		.flags = CLK_IGNORE_UNUSED,				\
+		.flags = (_flags),					\
 	},								\
 }
 
-AXG_AO_GATE(remote, 0);
-AXG_AO_GATE(i2c_master, 1);
-AXG_AO_GATE(i2c_slave, 2);
-AXG_AO_GATE(uart1, 3);
-AXG_AO_GATE(uart2, 5);
-AXG_AO_GATE(ir_blaster, 6);
-AXG_AO_GATE(saradc, 7);
+AXG_AO_GATE(remote,	0, CLK_IGNORE_UNUSED);
+AXG_AO_GATE(i2c_master,	1, CLK_IGNORE_UNUSED);
+AXG_AO_GATE(i2c_slave,	2, CLK_IGNORE_UNUSED);
+AXG_AO_GATE(uart1,	3, CLK_IGNORE_UNUSED);
+AXG_AO_GATE(uart2,	5, CLK_IGNORE_UNUSED);
+AXG_AO_GATE(ir_blaster,	6, CLK_IGNORE_UNUSED);
+AXG_AO_GATE(saradc,	7, CLK_IGNORE_UNUSED);
 
 static struct clk_regmap axg_ao_cts_oscin = {
 	.data = &(struct clk_regmap_gate_data){
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 021bc7658f7f49911835abd22badac3eba64a10c..fd9a7a362a1be1d8a584f855f454daa354ae2ade 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -1915,59 +1915,69 @@ static struct clk_regmap axg_gen_clk = {
 	},
 };
 
-#define AXG_PCLK(_name, _reg, _bit) \
-	MESON_PCLK(axg_##_name, _reg, _bit, &axg_clk81.hw)
-
-/* Everything Else (EE) domain gates */
-static AXG_PCLK(ddr,			HHI_GCLK_MPEG0,  0);
-static AXG_PCLK(audio_locker,		HHI_GCLK_MPEG0,  2);
-static AXG_PCLK(mipi_dsi_host,		HHI_GCLK_MPEG0,  3);
-static AXG_PCLK(isa,			HHI_GCLK_MPEG0,  5);
-static AXG_PCLK(pl301,			HHI_GCLK_MPEG0,  6);
-static AXG_PCLK(periphs,		HHI_GCLK_MPEG0,  7);
-static AXG_PCLK(spicc_0,		HHI_GCLK_MPEG0,  8);
-static AXG_PCLK(i2c,			HHI_GCLK_MPEG0,  9);
-static AXG_PCLK(rng0,			HHI_GCLK_MPEG0, 12);
-static AXG_PCLK(uart0,			HHI_GCLK_MPEG0, 13);
-static AXG_PCLK(mipi_dsi_phy,		HHI_GCLK_MPEG0, 14);
-static AXG_PCLK(spicc_1,		HHI_GCLK_MPEG0, 15);
-static AXG_PCLK(pcie_a,			HHI_GCLK_MPEG0, 16);
-static AXG_PCLK(pcie_b,			HHI_GCLK_MPEG0, 17);
-static AXG_PCLK(hiu_reg,		HHI_GCLK_MPEG0, 19);
-static AXG_PCLK(assist_misc,		HHI_GCLK_MPEG0, 23);
-static AXG_PCLK(emmc_b,			HHI_GCLK_MPEG0, 25);
-static AXG_PCLK(emmc_c,			HHI_GCLK_MPEG0, 26);
-static AXG_PCLK(dma,			HHI_GCLK_MPEG0, 27);
-static AXG_PCLK(spi,			HHI_GCLK_MPEG0, 30);
-
-static AXG_PCLK(audio,			HHI_GCLK_MPEG1,  0);
-static AXG_PCLK(eth_core,		HHI_GCLK_MPEG1,  3);
-static AXG_PCLK(uart1,			HHI_GCLK_MPEG1, 16);
-static AXG_PCLK(g2d,			HHI_GCLK_MPEG1, 20);
-static AXG_PCLK(usb0,			HHI_GCLK_MPEG1, 21);
-static AXG_PCLK(usb1,			HHI_GCLK_MPEG1, 22);
-static AXG_PCLK(reset,			HHI_GCLK_MPEG1, 23);
-static AXG_PCLK(usb_general,		HHI_GCLK_MPEG1, 26);
-static AXG_PCLK(ahb_arb0,		HHI_GCLK_MPEG1, 29);
-static AXG_PCLK(efuse,			HHI_GCLK_MPEG1, 30);
-static AXG_PCLK(boot_rom,		HHI_GCLK_MPEG1, 31);
-
-static AXG_PCLK(ahb_data_bus,		HHI_GCLK_MPEG2,  1);
-static AXG_PCLK(ahb_ctrl_bus,		HHI_GCLK_MPEG2,  2);
-static AXG_PCLK(usb1_to_ddr,		HHI_GCLK_MPEG2,  8);
-static AXG_PCLK(usb0_to_ddr,		HHI_GCLK_MPEG2,  9);
-static AXG_PCLK(mmc_pclk,		HHI_GCLK_MPEG2, 11);
-static AXG_PCLK(vpu_intr,		HHI_GCLK_MPEG2, 25);
-static AXG_PCLK(sec_ahb_ahb3_bridge,	HHI_GCLK_MPEG2, 26);
-static AXG_PCLK(gic,			HHI_GCLK_MPEG2, 30);
+#define AXG_PCLK(_name, _reg, _bit, _flags) \
+	MESON_PCLK(axg_##_name, _reg, _bit, &axg_clk81.hw, _flags)
+
+/*
+ * Everything Else (EE) domain gates
+ *
+ * NOTE: The gates below are marked with CLK_IGNORE_UNUSED for historic reasons
+ * Users are encouraged to test without it and submit changes to:
+ *  - remove the flag if not necessary
+ *  - replace the flag with something more adequate, such as CLK_IS_CRITICAL,
+ *    if appropriate.
+ *  - add a comment explaining why the use of CLK_IGNORE_UNUSED is desirable
+ *    for a particular clock.
+ */
+static AXG_PCLK(ddr,			HHI_GCLK_MPEG0,  0, CLK_IGNORE_UNUSED);
+static AXG_PCLK(audio_locker,		HHI_GCLK_MPEG0,  2, CLK_IGNORE_UNUSED);
+static AXG_PCLK(mipi_dsi_host,		HHI_GCLK_MPEG0,  3, CLK_IGNORE_UNUSED);
+static AXG_PCLK(isa,			HHI_GCLK_MPEG0,  5, CLK_IGNORE_UNUSED);
+static AXG_PCLK(pl301,			HHI_GCLK_MPEG0,  6, CLK_IGNORE_UNUSED);
+static AXG_PCLK(periphs,		HHI_GCLK_MPEG0,  7, CLK_IGNORE_UNUSED);
+static AXG_PCLK(spicc_0,		HHI_GCLK_MPEG0,  8, CLK_IGNORE_UNUSED);
+static AXG_PCLK(i2c,			HHI_GCLK_MPEG0,  9, CLK_IGNORE_UNUSED);
+static AXG_PCLK(rng0,			HHI_GCLK_MPEG0, 12, CLK_IGNORE_UNUSED);
+static AXG_PCLK(uart0,			HHI_GCLK_MPEG0, 13, CLK_IGNORE_UNUSED);
+static AXG_PCLK(mipi_dsi_phy,		HHI_GCLK_MPEG0, 14, CLK_IGNORE_UNUSED);
+static AXG_PCLK(spicc_1,		HHI_GCLK_MPEG0, 15, CLK_IGNORE_UNUSED);
+static AXG_PCLK(pcie_a,			HHI_GCLK_MPEG0, 16, CLK_IGNORE_UNUSED);
+static AXG_PCLK(pcie_b,			HHI_GCLK_MPEG0, 17, CLK_IGNORE_UNUSED);
+static AXG_PCLK(hiu_reg,		HHI_GCLK_MPEG0, 19, CLK_IGNORE_UNUSED);
+static AXG_PCLK(assist_misc,		HHI_GCLK_MPEG0, 23, CLK_IGNORE_UNUSED);
+static AXG_PCLK(emmc_b,			HHI_GCLK_MPEG0, 25, CLK_IGNORE_UNUSED);
+static AXG_PCLK(emmc_c,			HHI_GCLK_MPEG0, 26, CLK_IGNORE_UNUSED);
+static AXG_PCLK(dma,			HHI_GCLK_MPEG0, 27, CLK_IGNORE_UNUSED);
+static AXG_PCLK(spi,			HHI_GCLK_MPEG0, 30, CLK_IGNORE_UNUSED);
+
+static AXG_PCLK(audio,			HHI_GCLK_MPEG1,  0, CLK_IGNORE_UNUSED);
+static AXG_PCLK(eth_core,		HHI_GCLK_MPEG1,  3, CLK_IGNORE_UNUSED);
+static AXG_PCLK(uart1,			HHI_GCLK_MPEG1, 16, CLK_IGNORE_UNUSED);
+static AXG_PCLK(g2d,			HHI_GCLK_MPEG1, 20, CLK_IGNORE_UNUSED);
+static AXG_PCLK(usb0,			HHI_GCLK_MPEG1, 21, CLK_IGNORE_UNUSED);
+static AXG_PCLK(usb1,			HHI_GCLK_MPEG1, 22, CLK_IGNORE_UNUSED);
+static AXG_PCLK(reset,			HHI_GCLK_MPEG1, 23, CLK_IGNORE_UNUSED);
+static AXG_PCLK(usb_general,		HHI_GCLK_MPEG1, 26, CLK_IGNORE_UNUSED);
+static AXG_PCLK(ahb_arb0,		HHI_GCLK_MPEG1, 29, CLK_IGNORE_UNUSED);
+static AXG_PCLK(efuse,			HHI_GCLK_MPEG1, 30, CLK_IGNORE_UNUSED);
+static AXG_PCLK(boot_rom,		HHI_GCLK_MPEG1, 31, CLK_IGNORE_UNUSED);
+
+static AXG_PCLK(ahb_data_bus,		HHI_GCLK_MPEG2,  1, CLK_IGNORE_UNUSED);
+static AXG_PCLK(ahb_ctrl_bus,		HHI_GCLK_MPEG2,  2, CLK_IGNORE_UNUSED);
+static AXG_PCLK(usb1_to_ddr,		HHI_GCLK_MPEG2,  8, CLK_IGNORE_UNUSED);
+static AXG_PCLK(usb0_to_ddr,		HHI_GCLK_MPEG2,  9, CLK_IGNORE_UNUSED);
+static AXG_PCLK(mmc_pclk,		HHI_GCLK_MPEG2, 11, CLK_IGNORE_UNUSED);
+static AXG_PCLK(vpu_intr,		HHI_GCLK_MPEG2, 25, CLK_IGNORE_UNUSED);
+static AXG_PCLK(sec_ahb_ahb3_bridge,	HHI_GCLK_MPEG2, 26, CLK_IGNORE_UNUSED);
+static AXG_PCLK(gic,			HHI_GCLK_MPEG2, 30, CLK_IGNORE_UNUSED);
 
 /* Always On (AO) domain gates */
 
-static AXG_PCLK(ao_media_cpu,		HHI_GCLK_AO, 0);
-static AXG_PCLK(ao_ahb_sram,		HHI_GCLK_AO, 1);
-static AXG_PCLK(ao_ahb_bus,		HHI_GCLK_AO, 2);
-static AXG_PCLK(ao_iface,		HHI_GCLK_AO, 3);
-static AXG_PCLK(ao_i2c,			HHI_GCLK_AO, 4);
+static AXG_PCLK(ao_media_cpu,		HHI_GCLK_AO, 0, CLK_IGNORE_UNUSED);
+static AXG_PCLK(ao_ahb_sram,		HHI_GCLK_AO, 1, CLK_IGNORE_UNUSED);
+static AXG_PCLK(ao_ahb_bus,		HHI_GCLK_AO, 2, CLK_IGNORE_UNUSED);
+static AXG_PCLK(ao_iface,		HHI_GCLK_AO, 3, CLK_IGNORE_UNUSED);
+static AXG_PCLK(ao_i2c,			HHI_GCLK_AO, 4, CLK_IGNORE_UNUSED);
 
 /* Array of all clocks provided by this provider */
 
diff --git a/drivers/clk/meson/g12a-aoclk.c b/drivers/clk/meson/g12a-aoclk.c
index 872a7b800bb86bdf1ead56c3eec7e47f30637dbd..45e4df393feb6f916b6e035ad71e379e6e30ee99 100644
--- a/drivers/clk/meson/g12a-aoclk.c
+++ b/drivers/clk/meson/g12a-aoclk.c
@@ -37,13 +37,7 @@
 #define AO_RTC_ALT_CLK_CNTL0	0x94
 #define AO_RTC_ALT_CLK_CNTL1	0x98
 
-/*
- * Like every other peripheral clock gate in Amlogic Clock drivers,
- * we are using CLK_IGNORE_UNUSED here, so we keep the state of the
- * bootloader. The goal is to remove this flag at some point.
- * Actually removing it will require some extensive test to be done safely.
- */
-#define G12A_AO_PCLK(_name, _reg, _bit)					\
+#define G12A_AO_PCLK(_name, _reg, _bit, _flags)				\
 static struct clk_regmap g12a_ao_##_name = {				\
 	.data = &(struct clk_regmap_gate_data) {			\
 		.offset = (_reg),					\
@@ -56,26 +50,35 @@ static struct clk_regmap g12a_ao_##_name = {				\
 			.fw_name = "mpeg-clk",				\
 		},							\
 		.num_parents = 1,					\
-		.flags = CLK_IGNORE_UNUSED,				\
+		.flags = (_flags),					\
 	},								\
 }
 
-G12A_AO_PCLK(ahb,	AO_CLK_GATE0,    0);
-G12A_AO_PCLK(ir_in,	AO_CLK_GATE0,    1);
-G12A_AO_PCLK(i2c_m0,	AO_CLK_GATE0,    2);
-G12A_AO_PCLK(i2c_s0,	AO_CLK_GATE0,    3);
-G12A_AO_PCLK(uart,	AO_CLK_GATE0,    4);
-G12A_AO_PCLK(prod_i2c,	AO_CLK_GATE0,    5);
-G12A_AO_PCLK(uart2,	AO_CLK_GATE0,    6);
-G12A_AO_PCLK(ir_out,	AO_CLK_GATE0,    7);
-G12A_AO_PCLK(saradc,	AO_CLK_GATE0,    8);
+/*
+ * NOTE: The gates below are marked with CLK_IGNORE_UNUSED for historic reasons
+ * Users are encouraged to test without it and submit changes to:
+ *  - remove the flag if not necessary
+ *  - replace the flag with something more adequate, such as CLK_IS_CRITICAL,
+ *    if appropriate.
+ *  - add a comment explaining why the use of CLK_IGNORE_UNUSED is desirable
+ *    for a particular clock.
+ */
+G12A_AO_PCLK(ahb,	AO_CLK_GATE0,    0, CLK_IGNORE_UNUSED);
+G12A_AO_PCLK(ir_in,	AO_CLK_GATE0,    1, CLK_IGNORE_UNUSED);
+G12A_AO_PCLK(i2c_m0,	AO_CLK_GATE0,    2, CLK_IGNORE_UNUSED);
+G12A_AO_PCLK(i2c_s0,	AO_CLK_GATE0,    3, CLK_IGNORE_UNUSED);
+G12A_AO_PCLK(uart,	AO_CLK_GATE0,    4, CLK_IGNORE_UNUSED);
+G12A_AO_PCLK(prod_i2c,	AO_CLK_GATE0,    5, CLK_IGNORE_UNUSED);
+G12A_AO_PCLK(uart2,	AO_CLK_GATE0,    6, CLK_IGNORE_UNUSED);
+G12A_AO_PCLK(ir_out,	AO_CLK_GATE0,    7, CLK_IGNORE_UNUSED);
+G12A_AO_PCLK(saradc,	AO_CLK_GATE0,    8, CLK_IGNORE_UNUSED);
 
-G12A_AO_PCLK(mailbox,	AO_CLK_GATE0_SP, 0);
-G12A_AO_PCLK(m3,	AO_CLK_GATE0_SP, 1);
-G12A_AO_PCLK(ahb_sram,	AO_CLK_GATE0_SP, 2);
-G12A_AO_PCLK(rti,	AO_CLK_GATE0_SP, 3);
-G12A_AO_PCLK(m4_fclk,	AO_CLK_GATE0_SP, 4);
-G12A_AO_PCLK(m4_hclk,	AO_CLK_GATE0_SP, 5);
+G12A_AO_PCLK(mailbox,	AO_CLK_GATE0_SP, 0, CLK_IGNORE_UNUSED);
+G12A_AO_PCLK(m3,	AO_CLK_GATE0_SP, 1, CLK_IGNORE_UNUSED);
+G12A_AO_PCLK(ahb_sram,	AO_CLK_GATE0_SP, 2, CLK_IGNORE_UNUSED);
+G12A_AO_PCLK(rti,	AO_CLK_GATE0_SP, 3, CLK_IGNORE_UNUSED);
+G12A_AO_PCLK(m4_fclk,	AO_CLK_GATE0_SP, 4, CLK_IGNORE_UNUSED);
+G12A_AO_PCLK(m4_hclk,	AO_CLK_GATE0_SP, 5, CLK_IGNORE_UNUSED);
 
 static struct clk_regmap g12a_ao_cts_oscin = {
 	.data = &(struct clk_regmap_gate_data){
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index c06a4b678b277e8789a33328e25f0c615b3f1b9d..bfa8815647aee9f8c0b373a36b8b9ae5380c759e 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -4384,89 +4384,99 @@ static struct clk_regmap sm1_nna_core_clk = {
 	},
 };
 
-#define G12A_PCLK(_name, _reg, _bit) \
-	MESON_PCLK(_name, _reg, _bit, &g12a_clk81.hw)
-
-#define G12A_PCLK_RO(_name, _reg, _bit) \
-	MESON_PCLK_RO(_name, _reg, _bit, &g12a_clk81.hw)
-
-/* Everything Else (EE) domain gates */
-static G12A_PCLK(g12a_ddr,			HHI_GCLK_MPEG0,	0);
-static G12A_PCLK(g12a_dos,			HHI_GCLK_MPEG0,	1);
-static G12A_PCLK(g12a_audio_locker,		HHI_GCLK_MPEG0,	2);
-static G12A_PCLK(g12a_mipi_dsi_host,		HHI_GCLK_MPEG0,	3);
-static G12A_PCLK(g12a_eth_phy,			HHI_GCLK_MPEG0,	4);
-static G12A_PCLK(g12a_isa,			HHI_GCLK_MPEG0,	5);
-static G12A_PCLK(g12a_pl301,			HHI_GCLK_MPEG0,	6);
-static G12A_PCLK(g12a_periphs,			HHI_GCLK_MPEG0,	7);
-static G12A_PCLK(g12a_spicc_0,			HHI_GCLK_MPEG0,	8);
-static G12A_PCLK(g12a_i2c,			HHI_GCLK_MPEG0,	9);
-static G12A_PCLK(g12a_sana,			HHI_GCLK_MPEG0,	10);
-static G12A_PCLK(g12a_sd,			HHI_GCLK_MPEG0,	11);
-static G12A_PCLK(g12a_rng0,			HHI_GCLK_MPEG0,	12);
-static G12A_PCLK(g12a_uart0,			HHI_GCLK_MPEG0,	13);
-static G12A_PCLK(g12a_spicc_1,			HHI_GCLK_MPEG0,	14);
-static G12A_PCLK(g12a_hiu_reg,			HHI_GCLK_MPEG0,	19);
-static G12A_PCLK(g12a_mipi_dsi_phy,		HHI_GCLK_MPEG0,	20);
-static G12A_PCLK(g12a_assist_misc,		HHI_GCLK_MPEG0,	23);
-static G12A_PCLK(g12a_emmc_a,			HHI_GCLK_MPEG0,	24);
-static G12A_PCLK(g12a_emmc_b,			HHI_GCLK_MPEG0,	25);
-static G12A_PCLK(g12a_emmc_c,			HHI_GCLK_MPEG0,	26);
-static G12A_PCLK(g12a_audio_codec,		HHI_GCLK_MPEG0,	28);
-
-static G12A_PCLK(g12a_audio,			HHI_GCLK_MPEG1,	0);
-static G12A_PCLK(g12a_eth_core,			HHI_GCLK_MPEG1,	3);
-static G12A_PCLK(g12a_demux,			HHI_GCLK_MPEG1,	4);
-static G12A_PCLK(g12a_audio_ififo,		HHI_GCLK_MPEG1,	11);
-static G12A_PCLK(g12a_adc,			HHI_GCLK_MPEG1,	13);
-static G12A_PCLK(g12a_uart1,			HHI_GCLK_MPEG1,	16);
-static G12A_PCLK(g12a_g2d,			HHI_GCLK_MPEG1,	20);
-static G12A_PCLK(g12a_reset,			HHI_GCLK_MPEG1,	23);
-static G12A_PCLK(g12a_pcie_comb,		HHI_GCLK_MPEG1,	24);
-static G12A_PCLK(g12a_parser,			HHI_GCLK_MPEG1,	25);
-static G12A_PCLK(g12a_usb_general,		HHI_GCLK_MPEG1,	26);
-static G12A_PCLK(g12a_pcie_phy,			HHI_GCLK_MPEG1,	27);
-static G12A_PCLK(g12a_ahb_arb0,			HHI_GCLK_MPEG1,	29);
-
-static G12A_PCLK(g12a_ahb_data_bus,		HHI_GCLK_MPEG2,	1);
-static G12A_PCLK(g12a_ahb_ctrl_bus,		HHI_GCLK_MPEG2,	2);
-static G12A_PCLK(g12a_htx_hdcp22,		HHI_GCLK_MPEG2,	3);
-static G12A_PCLK(g12a_htx_pclk,			HHI_GCLK_MPEG2,	4);
-static G12A_PCLK(g12a_bt656,			HHI_GCLK_MPEG2,	6);
-static G12A_PCLK(g12a_usb1_to_ddr,		HHI_GCLK_MPEG2,	8);
-static G12A_PCLK(g12b_mipi_isp_gate,		HHI_GCLK_MPEG2,	17);
-static G12A_PCLK(g12a_mmc_pclk,			HHI_GCLK_MPEG2,	11);
-static G12A_PCLK(g12a_uart2,			HHI_GCLK_MPEG2,	15);
-static G12A_PCLK(g12a_vpu_intr,			HHI_GCLK_MPEG2,	25);
-static G12A_PCLK(g12b_csi_phy1,			HHI_GCLK_MPEG2,	28);
-static G12A_PCLK(g12b_csi_phy0,			HHI_GCLK_MPEG2,	29);
-static G12A_PCLK(g12a_gic,			HHI_GCLK_MPEG2,	30);
-
-static G12A_PCLK(g12a_vclk2_venci0,		HHI_GCLK_OTHER,	1);
-static G12A_PCLK(g12a_vclk2_venci1,		HHI_GCLK_OTHER,	2);
-static G12A_PCLK(g12a_vclk2_vencp0,		HHI_GCLK_OTHER,	3);
-static G12A_PCLK(g12a_vclk2_vencp1,		HHI_GCLK_OTHER,	4);
-static G12A_PCLK(g12a_vclk2_venct0,		HHI_GCLK_OTHER,	5);
-static G12A_PCLK(g12a_vclk2_venct1,		HHI_GCLK_OTHER,	6);
-static G12A_PCLK(g12a_vclk2_other,		HHI_GCLK_OTHER,	7);
-static G12A_PCLK(g12a_vclk2_enci,		HHI_GCLK_OTHER,	8);
-static G12A_PCLK(g12a_vclk2_encp,		HHI_GCLK_OTHER,	9);
-static G12A_PCLK(g12a_dac_clk,			HHI_GCLK_OTHER,	10);
-static G12A_PCLK(g12a_aoclk_gate,		HHI_GCLK_OTHER,	14);
-static G12A_PCLK(g12a_iec958_gate,		HHI_GCLK_OTHER,	16);
-static G12A_PCLK(g12a_enc480p,			HHI_GCLK_OTHER,	20);
-static G12A_PCLK(g12a_rng1,			HHI_GCLK_OTHER,	21);
-static G12A_PCLK(g12a_vclk2_enct,		HHI_GCLK_OTHER,	22);
-static G12A_PCLK(g12a_vclk2_encl,		HHI_GCLK_OTHER,	23);
-static G12A_PCLK(g12a_vclk2_venclmmc,		HHI_GCLK_OTHER,	24);
-static G12A_PCLK(g12a_vclk2_vencl,		HHI_GCLK_OTHER,	25);
-static G12A_PCLK(g12a_vclk2_other1,		HHI_GCLK_OTHER,	26);
-
-static G12A_PCLK_RO(g12a_dma,			HHI_GCLK_OTHER2, 0);
-static G12A_PCLK_RO(g12a_efuse,			HHI_GCLK_OTHER2, 1);
-static G12A_PCLK_RO(g12a_rom_boot,		HHI_GCLK_OTHER2, 2);
-static G12A_PCLK_RO(g12a_reset_sec,		HHI_GCLK_OTHER2, 3);
-static G12A_PCLK_RO(g12a_sec_ahb_apb3,		HHI_GCLK_OTHER2, 4);
+#define G12A_PCLK(_name, _reg, _bit, _flags) \
+	MESON_PCLK(_name, _reg, _bit, &g12a_clk81.hw, _flags)
+
+#define G12A_PCLK_RO(_name, _reg, _bit, _flags) \
+	MESON_PCLK_RO(_name, _reg, _bit, &g12a_clk81.hw, _flags)
+
+/*
+ * Everything Else (EE) domain gates
+ *
+ * NOTE: The gates below are marked with CLK_IGNORE_UNUSED for historic reasons
+ * Users are encouraged to test without it and submit changes to:
+ *  - remove the flag if not necessary
+ *  - replace the flag with something more adequate, such as CLK_IS_CRITICAL,
+ *    if appropriate.
+ *  - add a comment explaining why the use of CLK_IGNORE_UNUSED is desirable
+ *    for a particular clock.
+ */
+static G12A_PCLK(g12a_ddr,			HHI_GCLK_MPEG0,	 0, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_dos,			HHI_GCLK_MPEG0,	 1, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_audio_locker,		HHI_GCLK_MPEG0,	 2, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_mipi_dsi_host,		HHI_GCLK_MPEG0,	 3, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_eth_phy,			HHI_GCLK_MPEG0,	 4, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_isa,			HHI_GCLK_MPEG0,	 5, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_pl301,			HHI_GCLK_MPEG0,	 6, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_periphs,			HHI_GCLK_MPEG0,	 7, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_spicc_0,			HHI_GCLK_MPEG0,	 8, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_i2c,			HHI_GCLK_MPEG0,	 9, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_sana,			HHI_GCLK_MPEG0,	10, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_sd,			HHI_GCLK_MPEG0,	11, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_rng0,			HHI_GCLK_MPEG0,	12, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_uart0,			HHI_GCLK_MPEG0,	13, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_spicc_1,			HHI_GCLK_MPEG0,	14, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_hiu_reg,			HHI_GCLK_MPEG0,	19, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_mipi_dsi_phy,		HHI_GCLK_MPEG0,	20, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_assist_misc,		HHI_GCLK_MPEG0,	23, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_emmc_a,			HHI_GCLK_MPEG0,	24, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_emmc_b,			HHI_GCLK_MPEG0,	25, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_emmc_c,			HHI_GCLK_MPEG0,	26, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_audio_codec,		HHI_GCLK_MPEG0,	28, CLK_IGNORE_UNUSED);
+
+static G12A_PCLK(g12a_audio,			HHI_GCLK_MPEG1,	 0, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_eth_core,			HHI_GCLK_MPEG1,	 3, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_demux,			HHI_GCLK_MPEG1,	 4, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_audio_ififo,		HHI_GCLK_MPEG1,	11, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_adc,			HHI_GCLK_MPEG1,	13, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_uart1,			HHI_GCLK_MPEG1,	16, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_g2d,			HHI_GCLK_MPEG1,	20, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_reset,			HHI_GCLK_MPEG1,	23, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_pcie_comb,		HHI_GCLK_MPEG1,	24, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_parser,			HHI_GCLK_MPEG1,	25, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_usb_general,		HHI_GCLK_MPEG1,	26, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_pcie_phy,			HHI_GCLK_MPEG1,	27, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_ahb_arb0,			HHI_GCLK_MPEG1,	29, CLK_IGNORE_UNUSED);
+
+static G12A_PCLK(g12a_ahb_data_bus,		HHI_GCLK_MPEG2,	 1, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_ahb_ctrl_bus,		HHI_GCLK_MPEG2,	 2, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_htx_hdcp22,		HHI_GCLK_MPEG2,	 3, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_htx_pclk,			HHI_GCLK_MPEG2,	 4, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_bt656,			HHI_GCLK_MPEG2,	 6, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_usb1_to_ddr,		HHI_GCLK_MPEG2,	 8, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12b_mipi_isp_gate,		HHI_GCLK_MPEG2,	17, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_mmc_pclk,			HHI_GCLK_MPEG2,	11, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_uart2,			HHI_GCLK_MPEG2,	15, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_vpu_intr,			HHI_GCLK_MPEG2,	25, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12b_csi_phy1,			HHI_GCLK_MPEG2,	28, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12b_csi_phy0,			HHI_GCLK_MPEG2,	29, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_gic,			HHI_GCLK_MPEG2,	30, CLK_IGNORE_UNUSED);
+
+static G12A_PCLK(g12a_vclk2_venci0,		HHI_GCLK_OTHER,	 1, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_vclk2_venci1,		HHI_GCLK_OTHER,	 2, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_vclk2_vencp0,		HHI_GCLK_OTHER,	 3, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_vclk2_vencp1,		HHI_GCLK_OTHER,	 4, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_vclk2_venct0,		HHI_GCLK_OTHER,	 5, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_vclk2_venct1,		HHI_GCLK_OTHER,	 6, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_vclk2_other,		HHI_GCLK_OTHER,	 7, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_vclk2_enci,		HHI_GCLK_OTHER,	 8, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_vclk2_encp,		HHI_GCLK_OTHER,	 9, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_dac_clk,			HHI_GCLK_OTHER,	10, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_aoclk_gate,		HHI_GCLK_OTHER,	14, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_iec958_gate,		HHI_GCLK_OTHER,	16, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_enc480p,			HHI_GCLK_OTHER,	20, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_rng1,			HHI_GCLK_OTHER,	21, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_vclk2_enct,		HHI_GCLK_OTHER,	22, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_vclk2_encl,		HHI_GCLK_OTHER,	23, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_vclk2_venclmmc,		HHI_GCLK_OTHER,	24, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_vclk2_vencl,		HHI_GCLK_OTHER,	25, CLK_IGNORE_UNUSED);
+static G12A_PCLK(g12a_vclk2_other1,		HHI_GCLK_OTHER,	26, CLK_IGNORE_UNUSED);
+
+static G12A_PCLK_RO(g12a_dma,			HHI_GCLK_OTHER2, 0, 0);
+static G12A_PCLK_RO(g12a_efuse,			HHI_GCLK_OTHER2, 1, 0);
+static G12A_PCLK_RO(g12a_rom_boot,		HHI_GCLK_OTHER2, 2, 0);
+static G12A_PCLK_RO(g12a_reset_sec,		HHI_GCLK_OTHER2, 3, 0);
+static G12A_PCLK_RO(g12a_sec_ahb_apb3,		HHI_GCLK_OTHER2, 4, 0);
 
 /* Array of all clocks provided by this provider */
 static struct clk_hw *g12a_hw_clks[] = {
diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index ce8d2e9e071759ab8b8aa8619ad7400f1513c319..2bf45fd7fe4ba0783e736fbbb126209870985b22 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -23,7 +23,7 @@
 #define AO_RTC_ALT_CLK_CNTL0	0x94
 #define AO_RTC_ALT_CLK_CNTL1	0x98
 
-#define GXBB_AO_PCLK(_name, _bit)					\
+#define GXBB_AO_PCLK(_name, _bit, _flags)					\
 static struct clk_regmap gxbb_ao_##_name = {				\
 	.data = &(struct clk_regmap_gate_data) {			\
 		.offset = AO_RTI_GEN_CNTL_REG0,				\
@@ -36,16 +36,16 @@ static struct clk_regmap gxbb_ao_##_name = {				\
 			.fw_name = "mpeg-clk",				\
 		},							\
 		.num_parents = 1,					\
-		.flags = CLK_IGNORE_UNUSED,				\
+		.flags = (_flags),					\
 	},								\
 }
 
-GXBB_AO_PCLK(remote,		0);
-GXBB_AO_PCLK(i2c_master,	1);
-GXBB_AO_PCLK(i2c_slave,		2);
-GXBB_AO_PCLK(uart1,		3);
-GXBB_AO_PCLK(uart2,		5);
-GXBB_AO_PCLK(ir_blaster,	6);
+GXBB_AO_PCLK(remote,		0, CLK_IGNORE_UNUSED);
+GXBB_AO_PCLK(i2c_master,	1, CLK_IGNORE_UNUSED);
+GXBB_AO_PCLK(i2c_slave,		2, CLK_IGNORE_UNUSED);
+GXBB_AO_PCLK(uart1,		3, CLK_IGNORE_UNUSED);
+GXBB_AO_PCLK(uart2,		5, CLK_IGNORE_UNUSED);
+GXBB_AO_PCLK(ir_blaster,	6, CLK_IGNORE_UNUSED);
 
 static struct clk_regmap gxbb_ao_cts_oscin = {
 	.data = &(struct clk_regmap_gate_data){
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 608c2cd34a455f48087dd65809dbcda54f153a71..ccc1490a092814c242e719d4c37c66c4b3e27f07 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -2721,100 +2721,110 @@ static struct clk_regmap gxbb_gen_clk = {
 	},
 };
 
-#define GXBB_PCLK(_name, _reg, _bit) \
-	MESON_PCLK(_name, _reg, _bit, &gxbb_clk81.hw)
-
-/* Everything Else (EE) domain gates */
-static GXBB_PCLK(gxbb_ddr,		HHI_GCLK_MPEG0, 0);
-static GXBB_PCLK(gxbb_dos,		HHI_GCLK_MPEG0, 1);
-static GXBB_PCLK(gxbb_isa,		HHI_GCLK_MPEG0, 5);
-static GXBB_PCLK(gxbb_pl301,		HHI_GCLK_MPEG0, 6);
-static GXBB_PCLK(gxbb_periphs,		HHI_GCLK_MPEG0, 7);
-static GXBB_PCLK(gxbb_spicc,		HHI_GCLK_MPEG0, 8);
-static GXBB_PCLK(gxbb_i2c,		HHI_GCLK_MPEG0, 9);
-static GXBB_PCLK(gxbb_sana,		HHI_GCLK_MPEG0, 10);
-static GXBB_PCLK(gxbb_smart_card,	HHI_GCLK_MPEG0, 11);
-static GXBB_PCLK(gxbb_rng0,		HHI_GCLK_MPEG0, 12);
-static GXBB_PCLK(gxbb_uart0,		HHI_GCLK_MPEG0, 13);
-static GXBB_PCLK(gxbb_sdhc,		HHI_GCLK_MPEG0, 14);
-static GXBB_PCLK(gxbb_stream,		HHI_GCLK_MPEG0, 15);
-static GXBB_PCLK(gxbb_async_fifo,	HHI_GCLK_MPEG0, 16);
-static GXBB_PCLK(gxbb_sdio,		HHI_GCLK_MPEG0, 17);
-static GXBB_PCLK(gxbb_abuf,		HHI_GCLK_MPEG0, 18);
-static GXBB_PCLK(gxbb_hiu_iface,	HHI_GCLK_MPEG0, 19);
-static GXBB_PCLK(gxbb_assist_misc,	HHI_GCLK_MPEG0, 23);
-static GXBB_PCLK(gxbb_emmc_a,		HHI_GCLK_MPEG0, 24);
-static GXBB_PCLK(gxbb_emmc_b,		HHI_GCLK_MPEG0, 25);
-static GXBB_PCLK(gxbb_emmc_c,		HHI_GCLK_MPEG0, 26);
-static GXBB_PCLK(gxl_acodec,		HHI_GCLK_MPEG0, 28);
-static GXBB_PCLK(gxbb_spi,		HHI_GCLK_MPEG0, 30);
-
-static GXBB_PCLK(gxbb_i2s_spdif,	HHI_GCLK_MPEG1, 2);
-static GXBB_PCLK(gxbb_eth,		HHI_GCLK_MPEG1, 3);
-static GXBB_PCLK(gxbb_demux,		HHI_GCLK_MPEG1, 4);
-static GXBB_PCLK(gxbb_blkmv,		HHI_GCLK_MPEG1, 14);
-static GXBB_PCLK(gxbb_aiu,		HHI_GCLK_MPEG1, 15);
-static GXBB_PCLK(gxbb_uart1,		HHI_GCLK_MPEG1, 16);
-static GXBB_PCLK(gxbb_g2d,		HHI_GCLK_MPEG1, 20);
-static GXBB_PCLK(gxbb_usb0,		HHI_GCLK_MPEG1, 21);
-static GXBB_PCLK(gxbb_usb1,		HHI_GCLK_MPEG1, 22);
-static GXBB_PCLK(gxbb_reset,		HHI_GCLK_MPEG1, 23);
-static GXBB_PCLK(gxbb_nand,		HHI_GCLK_MPEG1, 24);
-static GXBB_PCLK(gxbb_dos_parser,	HHI_GCLK_MPEG1, 25);
-static GXBB_PCLK(gxbb_usb,		HHI_GCLK_MPEG1, 26);
-static GXBB_PCLK(gxbb_vdin1,		HHI_GCLK_MPEG1, 28);
-static GXBB_PCLK(gxbb_ahb_arb0,		HHI_GCLK_MPEG1, 29);
-static GXBB_PCLK(gxbb_efuse,		HHI_GCLK_MPEG1, 30);
-static GXBB_PCLK(gxbb_boot_rom,		HHI_GCLK_MPEG1, 31);
-
-static GXBB_PCLK(gxbb_ahb_data_bus,	HHI_GCLK_MPEG2, 1);
-static GXBB_PCLK(gxbb_ahb_ctrl_bus,	HHI_GCLK_MPEG2, 2);
-static GXBB_PCLK(gxbb_hdmi_intr_sync,	HHI_GCLK_MPEG2, 3);
-static GXBB_PCLK(gxbb_hdmi_pclk,	HHI_GCLK_MPEG2, 4);
-static GXBB_PCLK(gxbb_usb1_ddr_bridge,	HHI_GCLK_MPEG2, 8);
-static GXBB_PCLK(gxbb_usb0_ddr_bridge,	HHI_GCLK_MPEG2, 9);
-static GXBB_PCLK(gxbb_mmc_pclk,		HHI_GCLK_MPEG2, 11);
-static GXBB_PCLK(gxbb_dvin,		HHI_GCLK_MPEG2, 12);
-static GXBB_PCLK(gxbb_uart2,		HHI_GCLK_MPEG2, 15);
-static GXBB_PCLK(gxbb_sar_adc,		HHI_GCLK_MPEG2, 22);
-static GXBB_PCLK(gxbb_vpu_intr,		HHI_GCLK_MPEG2, 25);
-static GXBB_PCLK(gxbb_sec_ahb_ahb3_bridge, HHI_GCLK_MPEG2, 26);
-static GXBB_PCLK(gxbb_clk81_a53,	HHI_GCLK_MPEG2, 29);
-
-static GXBB_PCLK(gxbb_vclk2_venci0,	HHI_GCLK_OTHER, 1);
-static GXBB_PCLK(gxbb_vclk2_venci1,	HHI_GCLK_OTHER, 2);
-static GXBB_PCLK(gxbb_vclk2_vencp0,	HHI_GCLK_OTHER, 3);
-static GXBB_PCLK(gxbb_vclk2_vencp1,	HHI_GCLK_OTHER, 4);
-static GXBB_PCLK(gxbb_gclk_venci_int0,	HHI_GCLK_OTHER, 8);
-static GXBB_PCLK(gxbb_gclk_vencp_int,	HHI_GCLK_OTHER, 9);
-static GXBB_PCLK(gxbb_dac_clk,		HHI_GCLK_OTHER, 10);
-static GXBB_PCLK(gxbb_aoclk_gate,	HHI_GCLK_OTHER, 14);
-static GXBB_PCLK(gxbb_iec958_gate,	HHI_GCLK_OTHER, 16);
-static GXBB_PCLK(gxbb_enc480p,		HHI_GCLK_OTHER, 20);
-static GXBB_PCLK(gxbb_rng1,		HHI_GCLK_OTHER, 21);
-static GXBB_PCLK(gxbb_gclk_venci_int1,	HHI_GCLK_OTHER, 22);
-static GXBB_PCLK(gxbb_vclk2_venclmcc,	HHI_GCLK_OTHER, 24);
-static GXBB_PCLK(gxbb_vclk2_vencl,	HHI_GCLK_OTHER, 25);
-static GXBB_PCLK(gxbb_vclk_other,	HHI_GCLK_OTHER, 26);
-static GXBB_PCLK(gxbb_edp,		HHI_GCLK_OTHER, 31);
+#define GXBB_PCLK(_name, _reg, _bit, _flags) \
+	MESON_PCLK(_name, _reg, _bit, &gxbb_clk81.hw, _flags)
+
+/*
+ * Everything Else (EE) domain gates
+ *
+ * NOTE: The gates below are marked with CLK_IGNORE_UNUSED for historic reasons
+ * Users are encouraged to test without it and submit changes to:
+ *  - remove the flag if not necessary
+ *  - replace the flag with something more adequate, such as CLK_IS_CRITICAL,
+ *    if appropriate.
+ *  - add a comment explaining why the use of CLK_IGNORE_UNUSED is desirable
+ *    for a particular clock.
+ */
+static GXBB_PCLK(gxbb_ddr,		HHI_GCLK_MPEG0,  0, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_dos,		HHI_GCLK_MPEG0,  1, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_isa,		HHI_GCLK_MPEG0,  5, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_pl301,		HHI_GCLK_MPEG0,  6, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_periphs,		HHI_GCLK_MPEG0,  7, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_spicc,		HHI_GCLK_MPEG0,  8, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_i2c,		HHI_GCLK_MPEG0,  9, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_sana,		HHI_GCLK_MPEG0, 10, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_smart_card,	HHI_GCLK_MPEG0, 11, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_rng0,		HHI_GCLK_MPEG0, 12, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_uart0,		HHI_GCLK_MPEG0, 13, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_sdhc,		HHI_GCLK_MPEG0, 14, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_stream,		HHI_GCLK_MPEG0, 15, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_async_fifo,	HHI_GCLK_MPEG0, 16, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_sdio,		HHI_GCLK_MPEG0, 17, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_abuf,		HHI_GCLK_MPEG0, 18, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_hiu_iface,	HHI_GCLK_MPEG0, 19, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_assist_misc,	HHI_GCLK_MPEG0, 23, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_emmc_a,		HHI_GCLK_MPEG0, 24, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_emmc_b,		HHI_GCLK_MPEG0, 25, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_emmc_c,		HHI_GCLK_MPEG0, 26, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxl_acodec,		HHI_GCLK_MPEG0, 28, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_spi,		HHI_GCLK_MPEG0, 30, CLK_IGNORE_UNUSED);
+
+static GXBB_PCLK(gxbb_i2s_spdif,	HHI_GCLK_MPEG1,  2, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_eth,		HHI_GCLK_MPEG1,  3, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_demux,		HHI_GCLK_MPEG1,  4, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_blkmv,		HHI_GCLK_MPEG1, 14, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_aiu,		HHI_GCLK_MPEG1, 15, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_uart1,		HHI_GCLK_MPEG1, 16, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_g2d,		HHI_GCLK_MPEG1, 20, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_usb0,		HHI_GCLK_MPEG1, 21, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_usb1,		HHI_GCLK_MPEG1, 22, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_reset,		HHI_GCLK_MPEG1, 23, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_nand,		HHI_GCLK_MPEG1, 24, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_dos_parser,	HHI_GCLK_MPEG1, 25, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_usb,		HHI_GCLK_MPEG1, 26, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_vdin1,		HHI_GCLK_MPEG1, 28, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_ahb_arb0,		HHI_GCLK_MPEG1, 29, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_efuse,		HHI_GCLK_MPEG1, 30, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_boot_rom,		HHI_GCLK_MPEG1, 31, CLK_IGNORE_UNUSED);
+
+static GXBB_PCLK(gxbb_ahb_data_bus,	HHI_GCLK_MPEG2,  1, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_ahb_ctrl_bus,	HHI_GCLK_MPEG2,  2, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_hdmi_intr_sync,	HHI_GCLK_MPEG2,  3, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_hdmi_pclk,	HHI_GCLK_MPEG2,  4, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_usb1_ddr_bridge,	HHI_GCLK_MPEG2,  8, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_usb0_ddr_bridge,	HHI_GCLK_MPEG2,  9, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_mmc_pclk,		HHI_GCLK_MPEG2, 11, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_dvin,		HHI_GCLK_MPEG2, 12, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_uart2,		HHI_GCLK_MPEG2, 15, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_sar_adc,		HHI_GCLK_MPEG2, 22, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_vpu_intr,		HHI_GCLK_MPEG2, 25, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_sec_ahb_ahb3_bridge, HHI_GCLK_MPEG2, 26, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_clk81_a53,	HHI_GCLK_MPEG2, 29, CLK_IGNORE_UNUSED);
+
+static GXBB_PCLK(gxbb_vclk2_venci0,	HHI_GCLK_OTHER,  1, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_vclk2_venci1,	HHI_GCLK_OTHER,  2, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_vclk2_vencp0,	HHI_GCLK_OTHER,  3, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_vclk2_vencp1,	HHI_GCLK_OTHER,  4, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_gclk_venci_int0,	HHI_GCLK_OTHER,  8, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_gclk_vencp_int,	HHI_GCLK_OTHER,  9, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_dac_clk,		HHI_GCLK_OTHER, 10, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_aoclk_gate,	HHI_GCLK_OTHER, 14, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_iec958_gate,	HHI_GCLK_OTHER, 16, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_enc480p,		HHI_GCLK_OTHER, 20, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_rng1,		HHI_GCLK_OTHER, 21, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_gclk_venci_int1,	HHI_GCLK_OTHER, 22, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_vclk2_venclmcc,	HHI_GCLK_OTHER, 24, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_vclk2_vencl,	HHI_GCLK_OTHER, 25, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_vclk_other,	HHI_GCLK_OTHER, 26, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_edp,		HHI_GCLK_OTHER, 31, CLK_IGNORE_UNUSED);
 
 /* Always On (AO) domain gates */
 
-static GXBB_PCLK(gxbb_ao_media_cpu,	HHI_GCLK_AO, 0);
-static GXBB_PCLK(gxbb_ao_ahb_sram,	HHI_GCLK_AO, 1);
-static GXBB_PCLK(gxbb_ao_ahb_bus,	HHI_GCLK_AO, 2);
-static GXBB_PCLK(gxbb_ao_iface,		HHI_GCLK_AO, 3);
-static GXBB_PCLK(gxbb_ao_i2c,		HHI_GCLK_AO, 4);
+static GXBB_PCLK(gxbb_ao_media_cpu,	HHI_GCLK_AO, 0, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_ao_ahb_sram,	HHI_GCLK_AO, 1, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_ao_ahb_bus,	HHI_GCLK_AO, 2, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_ao_iface,		HHI_GCLK_AO, 3, CLK_IGNORE_UNUSED);
+static GXBB_PCLK(gxbb_ao_i2c,		HHI_GCLK_AO, 4, CLK_IGNORE_UNUSED);
 
 /* AIU gates */
-static MESON_PCLK(gxbb_aiu_glue,	HHI_GCLK_MPEG1,  6, &gxbb_aiu.hw);
-static MESON_PCLK(gxbb_iec958,		HHI_GCLK_MPEG1,  7, &gxbb_aiu_glue.hw);
-static MESON_PCLK(gxbb_i2s_out,		HHI_GCLK_MPEG1,  8, &gxbb_aiu_glue.hw);
-static MESON_PCLK(gxbb_amclk,		HHI_GCLK_MPEG1,  9, &gxbb_aiu_glue.hw);
-static MESON_PCLK(gxbb_aififo2,		HHI_GCLK_MPEG1, 10, &gxbb_aiu_glue.hw);
-static MESON_PCLK(gxbb_mixer,		HHI_GCLK_MPEG1, 11, &gxbb_aiu_glue.hw);
-static MESON_PCLK(gxbb_mixer_iface,	HHI_GCLK_MPEG1, 12, &gxbb_aiu_glue.hw);
-static MESON_PCLK(gxbb_adc,		HHI_GCLK_MPEG1, 13, &gxbb_aiu_glue.hw);
+static MESON_PCLK(gxbb_aiu_glue,	HHI_GCLK_MPEG1,  6, &gxbb_aiu.hw, CLK_IGNORE_UNUSED);
+static MESON_PCLK(gxbb_iec958,		HHI_GCLK_MPEG1,  7, &gxbb_aiu_glue.hw, CLK_IGNORE_UNUSED);
+static MESON_PCLK(gxbb_i2s_out,		HHI_GCLK_MPEG1,  8, &gxbb_aiu_glue.hw, CLK_IGNORE_UNUSED);
+static MESON_PCLK(gxbb_amclk,		HHI_GCLK_MPEG1,  9, &gxbb_aiu_glue.hw, CLK_IGNORE_UNUSED);
+static MESON_PCLK(gxbb_aififo2,		HHI_GCLK_MPEG1, 10, &gxbb_aiu_glue.hw, CLK_IGNORE_UNUSED);
+static MESON_PCLK(gxbb_mixer,		HHI_GCLK_MPEG1, 11, &gxbb_aiu_glue.hw, CLK_IGNORE_UNUSED);
+static MESON_PCLK(gxbb_mixer_iface,	HHI_GCLK_MPEG1, 12, &gxbb_aiu_glue.hw, CLK_IGNORE_UNUSED);
+static MESON_PCLK(gxbb_adc,		HHI_GCLK_MPEG1, 13, &gxbb_aiu_glue.hw, CLK_IGNORE_UNUSED);
 
 /* Array of all clocks provided by this provider */
 
diff --git a/drivers/clk/meson/meson-clkc-utils.h b/drivers/clk/meson/meson-clkc-utils.h
index 3e1fb7efe6da1f5d8e55993541d12d40464a47f5..03e38992c4c73ff4ee24f0fa99b7c34134376992 100644
--- a/drivers/clk/meson/meson-clkc-utils.h
+++ b/drivers/clk/meson/meson-clkc-utils.h
@@ -27,7 +27,7 @@ struct meson_clkc_data {
 int meson_clkc_syscon_probe(struct platform_device *pdev);
 int meson_clkc_mmio_probe(struct platform_device *pdev);
 
-#define __MESON_PCLK(_name, _reg, _bit, _ops, _pname)			\
+#define __MESON_PCLK(_name, _reg, _bit, _ops, _pname, _flags)		\
 struct clk_regmap _name = {						\
 	.data = &(struct clk_regmap_gate_data) {			\
 		.offset = (_reg),					\
@@ -38,14 +38,14 @@ struct clk_regmap _name = {						\
 		.ops = _ops,						\
 		.parent_hws = (const struct clk_hw *[]) { _pname },	\
 		.num_parents = 1,					\
-		.flags = CLK_IGNORE_UNUSED,				\
+		.flags = (_flags),					\
 	},								\
 }
 
-#define MESON_PCLK(_name, _reg, _bit, _pname)	\
-	__MESON_PCLK(_name, _reg, _bit, &clk_regmap_gate_ops, _pname)
+#define MESON_PCLK(_name, _reg, _bit, _pname, _flags)			\
+	__MESON_PCLK(_name, _reg, _bit, &clk_regmap_gate_ops, _pname, _flags)
 
-#define MESON_PCLK_RO(_name, _reg, _bit, _pname)	\
-	__MESON_PCLK(_name, _reg, _bit, &clk_regmap_gate_ro_ops, _pname)
+#define MESON_PCLK_RO(_name, _reg, _bit, _pname, _flags)		\
+	__MESON_PCLK(_name, _reg, _bit, &clk_regmap_gate_ro_ops, _pname, _flags)
 
 #endif
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 446e57d45d8deeab9516a923ddddcba7fa274203..a16ebbbf664cdd56b2c74db4f88a8d0a22d2ddc3 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -2701,100 +2701,109 @@ static struct clk_regmap meson8b_cts_i958 = {
 	},
 };
 
-#define MESON8B_PCLK(_name, _reg, _bit) \
-	MESON_PCLK(_name, _reg, _bit, &meson8b_clk81.hw)
-
-/* Everything Else (EE) domain gates */
-
-static MESON8B_PCLK(meson8b_ddr,		HHI_GCLK_MPEG0, 0);
-static MESON8B_PCLK(meson8b_dos,		HHI_GCLK_MPEG0, 1);
-static MESON8B_PCLK(meson8b_isa,		HHI_GCLK_MPEG0, 5);
-static MESON8B_PCLK(meson8b_pl301,		HHI_GCLK_MPEG0, 6);
-static MESON8B_PCLK(meson8b_periphs,		HHI_GCLK_MPEG0, 7);
-static MESON8B_PCLK(meson8b_spicc,		HHI_GCLK_MPEG0, 8);
-static MESON8B_PCLK(meson8b_i2c,		HHI_GCLK_MPEG0, 9);
-static MESON8B_PCLK(meson8b_sar_adc,		HHI_GCLK_MPEG0, 10);
-static MESON8B_PCLK(meson8b_smart_card,		HHI_GCLK_MPEG0, 11);
-static MESON8B_PCLK(meson8b_rng0,		HHI_GCLK_MPEG0, 12);
-static MESON8B_PCLK(meson8b_uart0,		HHI_GCLK_MPEG0, 13);
-static MESON8B_PCLK(meson8b_sdhc,		HHI_GCLK_MPEG0, 14);
-static MESON8B_PCLK(meson8b_stream,		HHI_GCLK_MPEG0, 15);
-static MESON8B_PCLK(meson8b_async_fifo,		HHI_GCLK_MPEG0, 16);
-static MESON8B_PCLK(meson8b_sdio,		HHI_GCLK_MPEG0, 17);
-static MESON8B_PCLK(meson8b_abuf,		HHI_GCLK_MPEG0, 18);
-static MESON8B_PCLK(meson8b_hiu_iface,		HHI_GCLK_MPEG0, 19);
-static MESON8B_PCLK(meson8b_assist_misc,	HHI_GCLK_MPEG0, 23);
-static MESON8B_PCLK(meson8b_spi,		HHI_GCLK_MPEG0, 30);
-
-static MESON8B_PCLK(meson8b_i2s_spdif,		HHI_GCLK_MPEG1, 2);
-static MESON8B_PCLK(meson8b_eth,		HHI_GCLK_MPEG1, 3);
-static MESON8B_PCLK(meson8b_demux,		HHI_GCLK_MPEG1, 4);
-static MESON8B_PCLK(meson8b_blkmv,		HHI_GCLK_MPEG1, 14);
-static MESON8B_PCLK(meson8b_aiu,		HHI_GCLK_MPEG1, 15);
-static MESON8B_PCLK(meson8b_uart1,		HHI_GCLK_MPEG1, 16);
-static MESON8B_PCLK(meson8b_g2d,		HHI_GCLK_MPEG1, 20);
-static MESON8B_PCLK(meson8b_usb0,		HHI_GCLK_MPEG1, 21);
-static MESON8B_PCLK(meson8b_usb1,		HHI_GCLK_MPEG1, 22);
-static MESON8B_PCLK(meson8b_reset,		HHI_GCLK_MPEG1, 23);
-static MESON8B_PCLK(meson8b_nand,		HHI_GCLK_MPEG1, 24);
-static MESON8B_PCLK(meson8b_dos_parser,		HHI_GCLK_MPEG1, 25);
-static MESON8B_PCLK(meson8b_usb,		HHI_GCLK_MPEG1, 26);
-static MESON8B_PCLK(meson8b_vdin1,		HHI_GCLK_MPEG1, 28);
-static MESON8B_PCLK(meson8b_ahb_arb0,		HHI_GCLK_MPEG1, 29);
-static MESON8B_PCLK(meson8b_efuse,		HHI_GCLK_MPEG1, 30);
-static MESON8B_PCLK(meson8b_boot_rom,		HHI_GCLK_MPEG1, 31);
-
-static MESON8B_PCLK(meson8b_ahb_data_bus,	HHI_GCLK_MPEG2, 1);
-static MESON8B_PCLK(meson8b_ahb_ctrl_bus,	HHI_GCLK_MPEG2, 2);
-static MESON8B_PCLK(meson8b_hdmi_intr_sync,	HHI_GCLK_MPEG2, 3);
-static MESON8B_PCLK(meson8b_hdmi_pclk,		HHI_GCLK_MPEG2, 4);
-static MESON8B_PCLK(meson8b_usb1_ddr_bridge,	HHI_GCLK_MPEG2, 8);
-static MESON8B_PCLK(meson8b_usb0_ddr_bridge,	HHI_GCLK_MPEG2, 9);
-static MESON8B_PCLK(meson8b_mmc_pclk,		HHI_GCLK_MPEG2, 11);
-static MESON8B_PCLK(meson8b_dvin,		HHI_GCLK_MPEG2, 12);
-static MESON8B_PCLK(meson8b_uart2,		HHI_GCLK_MPEG2, 15);
-static MESON8B_PCLK(meson8b_sana,		HHI_GCLK_MPEG2, 22);
-static MESON8B_PCLK(meson8b_vpu_intr,		HHI_GCLK_MPEG2, 25);
-static MESON8B_PCLK(meson8b_sec_ahb_ahb3_bridge, HHI_GCLK_MPEG2, 26);
-static MESON8B_PCLK(meson8b_clk81_a9,		HHI_GCLK_MPEG2, 29);
-
-static MESON8B_PCLK(meson8b_vclk2_venci0,	HHI_GCLK_OTHER, 1);
-static MESON8B_PCLK(meson8b_vclk2_venci1,	HHI_GCLK_OTHER, 2);
-static MESON8B_PCLK(meson8b_vclk2_vencp0,	HHI_GCLK_OTHER, 3);
-static MESON8B_PCLK(meson8b_vclk2_vencp1,	HHI_GCLK_OTHER, 4);
-static MESON8B_PCLK(meson8b_gclk_venci_int,	HHI_GCLK_OTHER, 8);
-static MESON8B_PCLK(meson8b_gclk_vencp_int,	HHI_GCLK_OTHER, 9);
-static MESON8B_PCLK(meson8b_dac_clk,		HHI_GCLK_OTHER, 10);
-static MESON8B_PCLK(meson8b_aoclk_gate,		HHI_GCLK_OTHER, 14);
-static MESON8B_PCLK(meson8b_iec958_gate,	HHI_GCLK_OTHER, 16);
-static MESON8B_PCLK(meson8b_enc480p,		HHI_GCLK_OTHER, 20);
-static MESON8B_PCLK(meson8b_rng1,		HHI_GCLK_OTHER, 21);
-static MESON8B_PCLK(meson8b_gclk_vencl_int,	HHI_GCLK_OTHER, 22);
-static MESON8B_PCLK(meson8b_vclk2_venclmcc,	HHI_GCLK_OTHER, 24);
-static MESON8B_PCLK(meson8b_vclk2_vencl,	HHI_GCLK_OTHER, 25);
-static MESON8B_PCLK(meson8b_vclk2_other,	HHI_GCLK_OTHER, 26);
-static MESON8B_PCLK(meson8b_edp,		HHI_GCLK_OTHER, 31);
+#define MESON8B_PCLK(_name, _reg, _bit, _flags) \
+	MESON_PCLK(_name, _reg, _bit, &meson8b_clk81.hw, _flags)
+
+/*
+ * Everything Else (EE) domain gates
+ *
+ * NOTE: The gates below are marked with CLK_IGNORE_UNUSED for historic reasons
+ * Users are encouraged to test without it and submit changes to:
+ *  - remove the flag if not necessary
+ *  - replace the flag with something more adequate, such as CLK_IS_CRITICAL,
+ *    if appropriate.
+ *  - add a comment explaining why the use of CLK_IGNORE_UNUSED is desirable
+ *    for a particular clock.
+ */
+static MESON8B_PCLK(meson8b_ddr,		HHI_GCLK_MPEG0,  0, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_dos,		HHI_GCLK_MPEG0,  1, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_isa,		HHI_GCLK_MPEG0,  5, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_pl301,		HHI_GCLK_MPEG0,  6, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_periphs,		HHI_GCLK_MPEG0,  7, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_spicc,		HHI_GCLK_MPEG0,  8, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_i2c,		HHI_GCLK_MPEG0,  9, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_sar_adc,		HHI_GCLK_MPEG0, 10, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_smart_card,		HHI_GCLK_MPEG0, 11, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_rng0,		HHI_GCLK_MPEG0, 12, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_uart0,		HHI_GCLK_MPEG0, 13, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_sdhc,		HHI_GCLK_MPEG0, 14, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_stream,		HHI_GCLK_MPEG0, 15, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_async_fifo,		HHI_GCLK_MPEG0, 16, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_sdio,		HHI_GCLK_MPEG0, 17, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_abuf,		HHI_GCLK_MPEG0, 18, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_hiu_iface,		HHI_GCLK_MPEG0, 19, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_assist_misc,	HHI_GCLK_MPEG0, 23, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_spi,		HHI_GCLK_MPEG0, 30, CLK_IGNORE_UNUSED);
+
+static MESON8B_PCLK(meson8b_i2s_spdif,		HHI_GCLK_MPEG1,  2, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_eth,		HHI_GCLK_MPEG1,  3, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_demux,		HHI_GCLK_MPEG1,  4, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_blkmv,		HHI_GCLK_MPEG1, 14, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_aiu,		HHI_GCLK_MPEG1, 15, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_uart1,		HHI_GCLK_MPEG1, 16, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_g2d,		HHI_GCLK_MPEG1, 20, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_usb0,		HHI_GCLK_MPEG1, 21, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_usb1,		HHI_GCLK_MPEG1, 22, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_reset,		HHI_GCLK_MPEG1, 23, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_nand,		HHI_GCLK_MPEG1, 24, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_dos_parser,		HHI_GCLK_MPEG1, 25, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_usb,		HHI_GCLK_MPEG1, 26, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_vdin1,		HHI_GCLK_MPEG1, 28, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_ahb_arb0,		HHI_GCLK_MPEG1, 29, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_efuse,		HHI_GCLK_MPEG1, 30, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_boot_rom,		HHI_GCLK_MPEG1, 31, CLK_IGNORE_UNUSED);
+
+static MESON8B_PCLK(meson8b_ahb_data_bus,	HHI_GCLK_MPEG2,  1, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_ahb_ctrl_bus,	HHI_GCLK_MPEG2,  2, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_hdmi_intr_sync,	HHI_GCLK_MPEG2,  3, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_hdmi_pclk,		HHI_GCLK_MPEG2,  4, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_usb1_ddr_bridge,	HHI_GCLK_MPEG2,  8, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_usb0_ddr_bridge,	HHI_GCLK_MPEG2,  9, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_mmc_pclk,		HHI_GCLK_MPEG2, 11, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_dvin,		HHI_GCLK_MPEG2, 12, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_uart2,		HHI_GCLK_MPEG2, 15, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_sana,		HHI_GCLK_MPEG2, 22, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_vpu_intr,		HHI_GCLK_MPEG2, 25, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_sec_ahb_ahb3_bridge, HHI_GCLK_MPEG2, 26, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_clk81_a9,		HHI_GCLK_MPEG2, 29, CLK_IGNORE_UNUSED);
+
+static MESON8B_PCLK(meson8b_vclk2_venci0,	HHI_GCLK_OTHER,  1, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_vclk2_venci1,	HHI_GCLK_OTHER,  2, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_vclk2_vencp0,	HHI_GCLK_OTHER,  3, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_vclk2_vencp1,	HHI_GCLK_OTHER,  4, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_gclk_venci_int,	HHI_GCLK_OTHER,  8, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_gclk_vencp_int,	HHI_GCLK_OTHER,  9, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_dac_clk,		HHI_GCLK_OTHER, 10, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_aoclk_gate,		HHI_GCLK_OTHER, 14, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_iec958_gate,	HHI_GCLK_OTHER, 16, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_enc480p,		HHI_GCLK_OTHER, 20, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_rng1,		HHI_GCLK_OTHER, 21, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_gclk_vencl_int,	HHI_GCLK_OTHER, 22, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_vclk2_venclmcc,	HHI_GCLK_OTHER, 24, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_vclk2_vencl,	HHI_GCLK_OTHER, 25, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_vclk2_other,	HHI_GCLK_OTHER, 26, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_edp,		HHI_GCLK_OTHER, 31, CLK_IGNORE_UNUSED);
 
 /* AIU gates */
-static MESON_PCLK(meson8b_aiu_glue,		HHI_GCLK_MPEG1, 6, &meson8b_aiu.hw);
+static MESON_PCLK(meson8b_aiu_glue, HHI_GCLK_MPEG1, 6, &meson8b_aiu.hw, CLK_IGNORE_UNUSED);
 
-#define MESON_AIU_PCLK(_name, _reg, _bit) \
-	MESON_PCLK(_name, _reg, _bit, &meson8b_aiu_glue.hw)
+#define MESON_AIU_PCLK(_name, _reg, _bit, _flags) \
+	MESON_PCLK(_name, _reg, _bit, &meson8b_aiu_glue.hw, _flags)
 
-static MESON_AIU_PCLK(meson8b_iec958,		HHI_GCLK_MPEG1, 7);
-static MESON_AIU_PCLK(meson8b_i2s_out,		HHI_GCLK_MPEG1, 8);
-static MESON_AIU_PCLK(meson8b_amclk,		HHI_GCLK_MPEG1, 9);
-static MESON_AIU_PCLK(meson8b_aififo2,		HHI_GCLK_MPEG1, 10);
-static MESON_AIU_PCLK(meson8b_mixer,		HHI_GCLK_MPEG1, 11);
-static MESON_AIU_PCLK(meson8b_mixer_iface,	HHI_GCLK_MPEG1, 12);
-static MESON_AIU_PCLK(meson8b_adc,		HHI_GCLK_MPEG1, 13);
+static MESON_AIU_PCLK(meson8b_iec958,		HHI_GCLK_MPEG1,  7, CLK_IGNORE_UNUSED);
+static MESON_AIU_PCLK(meson8b_i2s_out,		HHI_GCLK_MPEG1,  8, CLK_IGNORE_UNUSED);
+static MESON_AIU_PCLK(meson8b_amclk,		HHI_GCLK_MPEG1,  9, CLK_IGNORE_UNUSED);
+static MESON_AIU_PCLK(meson8b_aififo2,		HHI_GCLK_MPEG1, 10, CLK_IGNORE_UNUSED);
+static MESON_AIU_PCLK(meson8b_mixer,		HHI_GCLK_MPEG1, 11, CLK_IGNORE_UNUSED);
+static MESON_AIU_PCLK(meson8b_mixer_iface,	HHI_GCLK_MPEG1, 12, CLK_IGNORE_UNUSED);
+static MESON_AIU_PCLK(meson8b_adc,		HHI_GCLK_MPEG1, 13, CLK_IGNORE_UNUSED);
 
 /* Always On (AO) domain gates */
 
-static MESON8B_PCLK(meson8b_ao_media_cpu,	HHI_GCLK_AO, 0);
-static MESON8B_PCLK(meson8b_ao_ahb_sram,	HHI_GCLK_AO, 1);
-static MESON8B_PCLK(meson8b_ao_ahb_bus,		HHI_GCLK_AO, 2);
-static MESON8B_PCLK(meson8b_ao_iface,		HHI_GCLK_AO, 3);
+static MESON8B_PCLK(meson8b_ao_media_cpu,	HHI_GCLK_AO, 0, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_ao_ahb_sram,	HHI_GCLK_AO, 1, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_ao_ahb_bus,		HHI_GCLK_AO, 2, CLK_IGNORE_UNUSED);
+static MESON8B_PCLK(meson8b_ao_iface,		HHI_GCLK_AO, 3, CLK_IGNORE_UNUSED);
 
 static struct clk_hw *meson8_hw_clks[] = {
 	[CLKID_PLL_FIXED]	    = &meson8b_fixed_pll.hw,
diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
index fc1500df926d056ce17252987dd91095a8399b55..23b51d84d8de40aa540dbc6dd5db9fb627e579de 100644
--- a/drivers/clk/meson/s4-peripherals.c
+++ b/drivers/clk/meson/s4-peripherals.c
@@ -3165,61 +3165,70 @@ static struct clk_regmap s4_gen_clk = {
 	},
 };
 
-#define S4_PCLK(_name, _reg, _bit) \
-	MESON_PCLK(_name, _reg, _bit, &s4_sys_clk.hw)
-
-static S4_PCLK(s4_ddr,		CLKCTRL_SYS_CLK_EN0_REG0, 0);
-static S4_PCLK(s4_dos,		CLKCTRL_SYS_CLK_EN0_REG0, 1);
-static S4_PCLK(s4_ethphy,	CLKCTRL_SYS_CLK_EN0_REG0, 4);
-static S4_PCLK(s4_mali,		CLKCTRL_SYS_CLK_EN0_REG0, 6);
-static S4_PCLK(s4_aocpu,	CLKCTRL_SYS_CLK_EN0_REG0, 13);
-static S4_PCLK(s4_aucpu,	CLKCTRL_SYS_CLK_EN0_REG0, 14);
-static S4_PCLK(s4_cec,		CLKCTRL_SYS_CLK_EN0_REG0, 16);
-static S4_PCLK(s4_sdemmca,	CLKCTRL_SYS_CLK_EN0_REG0, 24);
-static S4_PCLK(s4_sdemmcb,	CLKCTRL_SYS_CLK_EN0_REG0, 25);
-static S4_PCLK(s4_nand,		CLKCTRL_SYS_CLK_EN0_REG0, 26);
-static S4_PCLK(s4_smartcard,	CLKCTRL_SYS_CLK_EN0_REG0, 27);
-static S4_PCLK(s4_acodec,	CLKCTRL_SYS_CLK_EN0_REG0, 28);
-static S4_PCLK(s4_spifc,	CLKCTRL_SYS_CLK_EN0_REG0, 29);
-static S4_PCLK(s4_msr_clk,	CLKCTRL_SYS_CLK_EN0_REG0, 30);
-static S4_PCLK(s4_ir_ctrl,	CLKCTRL_SYS_CLK_EN0_REG0, 31);
-
-static S4_PCLK(s4_audio,	CLKCTRL_SYS_CLK_EN0_REG1, 0);
-static S4_PCLK(s4_eth,		CLKCTRL_SYS_CLK_EN0_REG1, 3);
-static S4_PCLK(s4_uart_a,	CLKCTRL_SYS_CLK_EN0_REG1, 5);
-static S4_PCLK(s4_uart_b,	CLKCTRL_SYS_CLK_EN0_REG1, 6);
-static S4_PCLK(s4_uart_c,	CLKCTRL_SYS_CLK_EN0_REG1, 7);
-static S4_PCLK(s4_uart_d,	CLKCTRL_SYS_CLK_EN0_REG1, 8);
-static S4_PCLK(s4_uart_e,	CLKCTRL_SYS_CLK_EN0_REG1, 9);
-static S4_PCLK(s4_aififo,	CLKCTRL_SYS_CLK_EN0_REG1, 11);
-static S4_PCLK(s4_ts_ddr,	CLKCTRL_SYS_CLK_EN0_REG1, 15);
-static S4_PCLK(s4_ts_pll,	CLKCTRL_SYS_CLK_EN0_REG1, 16);
-static S4_PCLK(s4_g2d,		CLKCTRL_SYS_CLK_EN0_REG1, 20);
-static S4_PCLK(s4_spicc0,	CLKCTRL_SYS_CLK_EN0_REG1, 21);
-static S4_PCLK(s4_usb,		CLKCTRL_SYS_CLK_EN0_REG1, 26);
-static S4_PCLK(s4_i2c_m_a,	CLKCTRL_SYS_CLK_EN0_REG1, 30);
-static S4_PCLK(s4_i2c_m_b,	CLKCTRL_SYS_CLK_EN0_REG1, 31);
-
-static S4_PCLK(s4_i2c_m_c,	CLKCTRL_SYS_CLK_EN0_REG2, 0);
-static S4_PCLK(s4_i2c_m_d,	CLKCTRL_SYS_CLK_EN0_REG2, 1);
-static S4_PCLK(s4_i2c_m_e,	CLKCTRL_SYS_CLK_EN0_REG2, 2);
-static S4_PCLK(s4_hdmitx_apb,	CLKCTRL_SYS_CLK_EN0_REG2, 4);
-static S4_PCLK(s4_i2c_s_a,	CLKCTRL_SYS_CLK_EN0_REG2, 5);
-static S4_PCLK(s4_usb1_to_ddr,	CLKCTRL_SYS_CLK_EN0_REG2, 8);
-static S4_PCLK(s4_hdcp22,	CLKCTRL_SYS_CLK_EN0_REG2, 10);
-static S4_PCLK(s4_mmc_apb,	CLKCTRL_SYS_CLK_EN0_REG2, 11);
-static S4_PCLK(s4_rsa,		CLKCTRL_SYS_CLK_EN0_REG2, 18);
-static S4_PCLK(s4_cpu_debug,	CLKCTRL_SYS_CLK_EN0_REG2, 19);
-static S4_PCLK(s4_vpu_intr,	CLKCTRL_SYS_CLK_EN0_REG2, 25);
-static S4_PCLK(s4_demod,	CLKCTRL_SYS_CLK_EN0_REG2, 27);
-static S4_PCLK(s4_sar_adc,	CLKCTRL_SYS_CLK_EN0_REG2, 28);
-static S4_PCLK(s4_gic,		CLKCTRL_SYS_CLK_EN0_REG2, 30);
-
-static S4_PCLK(s4_pwm_ab,	CLKCTRL_SYS_CLK_EN0_REG3, 7);
-static S4_PCLK(s4_pwm_cd,	CLKCTRL_SYS_CLK_EN0_REG3, 8);
-static S4_PCLK(s4_pwm_ef,	CLKCTRL_SYS_CLK_EN0_REG3, 9);
-static S4_PCLK(s4_pwm_gh,	CLKCTRL_SYS_CLK_EN0_REG3, 10);
-static S4_PCLK(s4_pwm_ij,	CLKCTRL_SYS_CLK_EN0_REG3, 11);
+#define S4_PCLK(_name, _reg, _bit, _flags) \
+	MESON_PCLK(_name, _reg, _bit, &s4_sys_clk.hw, _flags)
+
+/*
+ * NOTE: The gates below are marked with CLK_IGNORE_UNUSED for historic reasons
+ * Users are encouraged to test without it and submit changes to:
+ *  - remove the flag if not necessary
+ *  - replace the flag with something more adequate, such as CLK_IS_CRITICAL,
+ *    if appropriate.
+ *  - add a comment explaining why the use of CLK_IGNORE_UNUSED is desirable
+ *    for a particular clock.
+ */
+static S4_PCLK(s4_ddr,		CLKCTRL_SYS_CLK_EN0_REG0,  0, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_dos,		CLKCTRL_SYS_CLK_EN0_REG0,  1, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_ethphy,	CLKCTRL_SYS_CLK_EN0_REG0,  4, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_mali,		CLKCTRL_SYS_CLK_EN0_REG0,  6, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_aocpu,	CLKCTRL_SYS_CLK_EN0_REG0, 13, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_aucpu,	CLKCTRL_SYS_CLK_EN0_REG0, 14, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_cec,		CLKCTRL_SYS_CLK_EN0_REG0, 16, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_sdemmca,	CLKCTRL_SYS_CLK_EN0_REG0, 24, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_sdemmcb,	CLKCTRL_SYS_CLK_EN0_REG0, 25, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_nand,		CLKCTRL_SYS_CLK_EN0_REG0, 26, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_smartcard,	CLKCTRL_SYS_CLK_EN0_REG0, 27, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_acodec,	CLKCTRL_SYS_CLK_EN0_REG0, 28, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_spifc,	CLKCTRL_SYS_CLK_EN0_REG0, 29, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_msr_clk,	CLKCTRL_SYS_CLK_EN0_REG0, 30, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_ir_ctrl,	CLKCTRL_SYS_CLK_EN0_REG0, 31, CLK_IGNORE_UNUSED);
+
+static S4_PCLK(s4_audio,	CLKCTRL_SYS_CLK_EN0_REG1,  0, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_eth,		CLKCTRL_SYS_CLK_EN0_REG1,  3, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_uart_a,	CLKCTRL_SYS_CLK_EN0_REG1,  5, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_uart_b,	CLKCTRL_SYS_CLK_EN0_REG1,  6, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_uart_c,	CLKCTRL_SYS_CLK_EN0_REG1,  7, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_uart_d,	CLKCTRL_SYS_CLK_EN0_REG1,  8, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_uart_e,	CLKCTRL_SYS_CLK_EN0_REG1,  9, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_aififo,	CLKCTRL_SYS_CLK_EN0_REG1, 11, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_ts_ddr,	CLKCTRL_SYS_CLK_EN0_REG1, 15, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_ts_pll,	CLKCTRL_SYS_CLK_EN0_REG1, 16, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_g2d,		CLKCTRL_SYS_CLK_EN0_REG1, 20, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_spicc0,	CLKCTRL_SYS_CLK_EN0_REG1, 21, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_usb,		CLKCTRL_SYS_CLK_EN0_REG1, 26, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_i2c_m_a,	CLKCTRL_SYS_CLK_EN0_REG1, 30, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_i2c_m_b,	CLKCTRL_SYS_CLK_EN0_REG1, 31, CLK_IGNORE_UNUSED);
+
+static S4_PCLK(s4_i2c_m_c,	CLKCTRL_SYS_CLK_EN0_REG2,  0, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_i2c_m_d,	CLKCTRL_SYS_CLK_EN0_REG2,  1, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_i2c_m_e,	CLKCTRL_SYS_CLK_EN0_REG2,  2, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_hdmitx_apb,	CLKCTRL_SYS_CLK_EN0_REG2,  4, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_i2c_s_a,	CLKCTRL_SYS_CLK_EN0_REG2,  5, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_usb1_to_ddr,	CLKCTRL_SYS_CLK_EN0_REG2,  8, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_hdcp22,	CLKCTRL_SYS_CLK_EN0_REG2, 10, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_mmc_apb,	CLKCTRL_SYS_CLK_EN0_REG2, 11, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_rsa,		CLKCTRL_SYS_CLK_EN0_REG2, 18, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_cpu_debug,	CLKCTRL_SYS_CLK_EN0_REG2, 19, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_vpu_intr,	CLKCTRL_SYS_CLK_EN0_REG2, 25, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_demod,	CLKCTRL_SYS_CLK_EN0_REG2, 27, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_sar_adc,	CLKCTRL_SYS_CLK_EN0_REG2, 28, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_gic,		CLKCTRL_SYS_CLK_EN0_REG2, 30, CLK_IGNORE_UNUSED);
+
+static S4_PCLK(s4_pwm_ab,	CLKCTRL_SYS_CLK_EN0_REG3,  7, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_pwm_cd,	CLKCTRL_SYS_CLK_EN0_REG3,  8, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_pwm_ef,	CLKCTRL_SYS_CLK_EN0_REG3,  9, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_pwm_gh,	CLKCTRL_SYS_CLK_EN0_REG3, 10, CLK_IGNORE_UNUSED);
+static S4_PCLK(s4_pwm_ij,	CLKCTRL_SYS_CLK_EN0_REG3, 11, CLK_IGNORE_UNUSED);
 
 /* Array of all clocks provided by this provider */
 static struct clk_hw *s4_peripherals_hw_clks[] = {

-- 
2.47.2


