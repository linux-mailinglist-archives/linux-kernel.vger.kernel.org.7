Return-Path: <linux-kernel+bounces-784958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08361B34417
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E9A16F304
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AB2304BAE;
	Mon, 25 Aug 2025 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bHfKq4pP"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6645F302772
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132035; cv=none; b=PlhQowjfg4psUNwhV24+3ulWXKxOfPoeT4II4f6VWEQu90+SdbqOzeAiDRxmzMkAQ6QGme2/Ljeynb22JEqOFdkZlme+q7Be+sUkPF9C7Co2uorzioCVy4yXJBTlPdXL+ywoGmrA2iRtSm8BW4Azp4f5JVfYb7MxrdV7esTXlus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132035; c=relaxed/simple;
	bh=ey5cZdSnxDBMQWblcJDibJDA5OZgFBnUd6WG9uhMGLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JYLlrH+BmFiQ4JzP4SRQKVwNKDSvsOgDZNnmLn98vvUj5fWVuR+0sf2M+bL6hOpbR2mvQ2k6gFeKbFa/iYz/Dt64CgigUPCf/UGoe+Tfn+g57mHCx9YKVMdgK8/ZNsdHRvkZPtckwxtWNpNO5/E4qbqes2ML9YFhGwoImVrmPVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bHfKq4pP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso3756344f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756132029; x=1756736829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKeGjfnHALhz/AAzO7aZ77kwy1JfZMTwKgyrIVs7M5M=;
        b=bHfKq4pP1L8QXyHmrE3MH5F1giPmr7VN1c0rp2g3XX71LvD6vVill6AdNgOfY+sU9p
         XyjVtl9jA7R1vwZjqjbJNR2ZsIwG3/3/JIIGKwPQ5nNl88CBg+1lJUw4TlzihmGzwEvj
         XgYg2r6cAzh71SaMotH5QMCwrqYC44KmiRe62L0TA7Q+6LXmucpnVUmRSuDbryjACBFV
         st/ZG8ddhOewEKK7hYEHRXuBQT2IAk300lDxA22sZovN/UX6gvdUPhxbArFIbjw+CfEY
         i1wQFG4H7uP2Y2xJvqiSnQPS+l8JEc8XRDa5lDpoO5N4JEsDtRttQdTyId+cclSzb/rm
         jn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756132029; x=1756736829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKeGjfnHALhz/AAzO7aZ77kwy1JfZMTwKgyrIVs7M5M=;
        b=pOpuHsAKa40MomOhWFj/HoYEQILLJsaTtLtvJINCfm9mby2wsyjII/7mrbrxt/k0lu
         RaDqO7ZwQNI9X/8Z8Riatmey0zpeTvve1EAEKm6LP97GzJBGcVgvsqjOeJB99KHNnH+c
         31lwpTt6zDA/EjM/CbEFPedOGl59chkEUVNLArwrEGVtlpIul4l0u5XFVkxtqDVCIOWo
         IEadZAV2zapXN9KeClrvDod8lWE9atJqBMkj6o3iytBLy0dfb6AkiPNclgsAiGNNl6g/
         VaS8tK/KVQF8GjnZUDDZ23nztW1g0SYYwj3PCrIGcFd6sqz6VVn8vknG/ZPjD0z/biQC
         ueUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLpk6YnWiD4NBX5xfmqqarF6IkSfLuKx+t1mIRn/YzggujC4i+u6AupLPFqLWdbMRpvWM7PgeI1bKLtj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwkx0OLUS8D7UTKyYeiac+SkNfaGMXT+iLJz4dP5BWmPHqA4r0
	Qj9Beiy/FkRz8/EWA1IW/g2F4arrqDhQL3p/XdrOWcNdelDzKg7jwDO62VoN3erRwr0=
X-Gm-Gg: ASbGncsb29ZvF4BCm/Vy6D2IoVmx8oCoXxxhUEopd/TdwZDDNuX8e4isd7jrZNEfHAx
	SCxNezFUtz/Xpf6uLCR22j+amFSOb9ANMGyksigWK5v68vpkvwKI3gUN23HlRLF7+wX75avzsqw
	WBBK+gGsk03s3A+qKfg3gei4eh/DuSLIU+qkemnhDhPwD5JQk+o8mKBFNvGHuuxc97biUOasEaI
	AoOP+0yVD5pMG/79o94ILKvHwozi4K13QKjQEE7bZYJRSWFqYrsluoruaIPgGQEWChNip/9r+VX
	DdJTlaVjsy1iGUmqR4SFz0Lz08yYwO0sruJR6ScqMt6ijBiPY1g+IbYWbyo/LP/VtCt3PJ52tzI
	/astVcpTM0wIbpmavlVWE5eD0xjcdoI2zjvsI
X-Google-Smtp-Source: AGHT+IHt4lgpYTFRKVUdHW44E3mNT49oLGAxgQr8oV91u9YCleboiVtqxtigsGd/l4FjIi9FOMDqlA==
X-Received: by 2002:a5d:64e4:0:b0:3ca:6a35:13f4 with SMTP id ffacd0b85a97d-3ca6a3516c3mr1642673f8f.46.1756132029030;
        Mon, 25 Aug 2025 07:27:09 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:b261:baab:ed3d:3cb6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm12634462f8f.14.2025.08.25.07.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:27:08 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 25 Aug 2025 16:26:29 +0200
Subject: [PATCH v2 04/12] clk: amlogic: aoclk: use clkc-utils syscon probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-meson-clk-cleanup-24-v2-4-0f402f01e117@baylibre.com>
References: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
In-Reply-To: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5340; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=ey5cZdSnxDBMQWblcJDibJDA5OZgFBnUd6WG9uhMGLo=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBorHKxESzysED9LwfQG3fV63KVp0SL8l2UgmZXi
 8CCokopy0WJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaKxysQAKCRDm/A8cN/La
 ha3yD/9FcCX7DiK/3I/l/3yH9yWepYrt+n+X3Gsl9mHQ0mS1p7l2/X+flH6m5LUNMEZDZj3203n
 +XvvAepAIKNwsGiqA00GHEmFIHZZmb1zgbjUx5zO80SjyPOMrXyxh5Ur0yM/9Jq6D1c0XqBbb7Y
 vpr+z7bmk2PphcrU+eA4R3aJo2EJFsHxSyQvtiNO/wAsQQMM35SM/goZyXvG5sUSND1FZuw9QMF
 lURAPl8N8+OmKOIrHbRndwoNnyRMM2MzZpoE+mh4i/x8ObxZisk5hn1its81dCEXuct3CxRdxPi
 K/IOo62RiY3lZGIhJ0lIubUW5fWLE+26rnwq7qfyqxmvZ68ifUzLMvJbYc5gU1sTSLRYdKiSVVG
 fdX4jgbLi8iWJbUd64Z3Qf5fJGlWlqWzcroWZIGciOM2+lI+Tp54TX2x+SiKcBbbh8Q714YoiTt
 pfkladXgNyTMzwJLYsPl3/8YDTDS8SOzrXtb/P3eq6Inb63FyTjl+FfwvXE3qg5pV0hpHoxT8Yb
 CAbnwrPNULHYs9jzbGFSZ88sl2Ds8KXNn9IcYA19LULt9Yji+Od+YwBJvM4cfbhT22/hLSK8XbG
 +agSjfpjdmbbzE3WHEIndXwlvrYZxYiVxeAAjEE6DOtZVQpl7eePNCi0vSTKHEJaeyQklyofR0p
 xu7N++N9VE+YEyA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The clock related part of aoclk probe function duplicates what
the clkc-utils syscon helper does. Factorize this to have a single path to
maintain.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg-aoclk.c   | 10 ++++++----
 drivers/clk/meson/g12a-aoclk.c  | 10 ++++++----
 drivers/clk/meson/gxbb-aoclk.c  | 10 ++++++----
 drivers/clk/meson/meson-aoclk.c | 32 ++++++++++++++------------------
 drivers/clk/meson/meson-aoclk.h |  2 +-
 5 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/drivers/clk/meson/axg-aoclk.c b/drivers/clk/meson/axg-aoclk.c
index a0c58dc8e950a05c340c3427af4f6ff7661fa84e..efc33fd18c197df233d537e5f8244a376d4d0924 100644
--- a/drivers/clk/meson/axg-aoclk.c
+++ b/drivers/clk/meson/axg-aoclk.c
@@ -300,16 +300,18 @@ static const struct meson_aoclk_data axg_ao_clkc_data = {
 	.reset_reg	= AO_RTI_GEN_CNTL_REG0,
 	.num_reset	= ARRAY_SIZE(axg_ao_reset),
 	.reset		= axg_ao_reset,
-	.hw_clks	= {
-		.hws	= axg_ao_hw_clks,
-		.num	= ARRAY_SIZE(axg_ao_hw_clks),
+	.clkc_data	= {
+		.hw_clks = {
+			.hws	= axg_ao_hw_clks,
+			.num	= ARRAY_SIZE(axg_ao_hw_clks),
+		},
 	},
 };
 
 static const struct of_device_id axg_ao_clkc_match_table[] = {
 	{
 		.compatible	= "amlogic,meson-axg-aoclkc",
-		.data		= &axg_ao_clkc_data,
+		.data		= &axg_ao_clkc_data.clkc_data,
 	},
 	{ }
 };
diff --git a/drivers/clk/meson/g12a-aoclk.c b/drivers/clk/meson/g12a-aoclk.c
index 3eaf1db16f45a0adf0acd901ed7ae1f51a9c8dc1..872a7b800bb86bdf1ead56c3eec7e47f30637dbd 100644
--- a/drivers/clk/meson/g12a-aoclk.c
+++ b/drivers/clk/meson/g12a-aoclk.c
@@ -424,16 +424,18 @@ static const struct meson_aoclk_data g12a_ao_clkc_data = {
 	.reset_reg	= AO_RTI_GEN_CNTL_REG0,
 	.num_reset	= ARRAY_SIZE(g12a_ao_reset),
 	.reset		= g12a_ao_reset,
-	.hw_clks	= {
-		.hws	= g12a_ao_hw_clks,
-		.num	= ARRAY_SIZE(g12a_ao_hw_clks),
+	.clkc_data = {
+		.hw_clks = {
+			.hws	= g12a_ao_hw_clks,
+			.num	= ARRAY_SIZE(g12a_ao_hw_clks),
+		},
 	},
 };
 
 static const struct of_device_id g12a_ao_clkc_match_table[] = {
 	{
 		.compatible	= "amlogic,meson-g12a-aoclkc",
-		.data		= &g12a_ao_clkc_data,
+		.data		= &g12a_ao_clkc_data.clkc_data,
 	},
 	{ }
 };
diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index 11b11fa7791eb1903938c0d3ee46121a23b94a46..ce8d2e9e071759ab8b8aa8619ad7400f1513c319 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -258,16 +258,18 @@ static const struct meson_aoclk_data gxbb_ao_clkc_data = {
 	.reset_reg	= AO_RTI_GEN_CNTL_REG0,
 	.num_reset	= ARRAY_SIZE(gxbb_ao_reset),
 	.reset		= gxbb_ao_reset,
-	.hw_clks	= {
-		.hws	= gxbb_ao_hw_clks,
-		.num	= ARRAY_SIZE(gxbb_ao_hw_clks),
+	.clkc_data	= {
+		.hw_clks = {
+			.hws	= gxbb_ao_hw_clks,
+			.num	= ARRAY_SIZE(gxbb_ao_hw_clks),
+		},
 	},
 };
 
 static const struct of_device_id gxbb_ao_clkc_match_table[] = {
 	{
 		.compatible	= "amlogic,meson-gx-aoclkc",
-		.data		= &gxbb_ao_clkc_data,
+		.data		= &gxbb_ao_clkc_data.clkc_data,
 	},
 	{ }
 };
diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
index 894c02fda072ddd0733165d5f60efe1d0da2388d..8f6bdea181197cc647398bd607d8b004ac81f747 100644
--- a/drivers/clk/meson/meson-aoclk.c
+++ b/drivers/clk/meson/meson-aoclk.c
@@ -37,15 +37,23 @@ static const struct reset_control_ops meson_aoclk_reset_ops = {
 int meson_aoclkc_probe(struct platform_device *pdev)
 {
 	struct meson_aoclk_reset_controller *rstc;
-	struct meson_aoclk_data *data;
+	const struct meson_clkc_data *clkc_data;
+	const struct meson_aoclk_data *data;
 	struct device *dev = &pdev->dev;
 	struct device_node *np;
 	struct regmap *regmap;
-	int ret, clkid;
+	int ret;
 
-	data = (struct meson_aoclk_data *) of_device_get_match_data(dev);
-	if (!data)
-		return -ENODEV;
+	clkc_data = of_device_get_match_data(dev);
+	if (!clkc_data)
+		return -EINVAL;
+
+	ret = meson_clkc_syscon_probe(pdev);
+	if (ret)
+		return ret;
+
+	data = container_of(clkc_data, struct meson_aoclk_data,
+			    clkc_data);
 
 	rstc = devm_kzalloc(dev, sizeof(*rstc), GFP_KERNEL);
 	if (!rstc)
@@ -71,19 +79,7 @@ int meson_aoclkc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* Register all clks */
-	for (clkid = 0; clkid < data->hw_clks.num; clkid++) {
-		if (!data->hw_clks.hws[clkid])
-			continue;
-
-		ret = devm_clk_hw_register(dev, data->hw_clks.hws[clkid]);
-		if (ret) {
-			dev_err(dev, "Clock registration failed\n");
-			return ret;
-		}
-	}
-
-	return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get, (void *)&data->hw_clks);
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(meson_aoclkc_probe, "CLK_MESON");
 
diff --git a/drivers/clk/meson/meson-aoclk.h b/drivers/clk/meson/meson-aoclk.h
index ea5fc61308af14c63489b7c72410d9d981d8745b..2c83e73d3a7753c2094d2acc7c75b524edb5bb9e 100644
--- a/drivers/clk/meson/meson-aoclk.h
+++ b/drivers/clk/meson/meson-aoclk.h
@@ -20,10 +20,10 @@
 #include "meson-clkc-utils.h"
 
 struct meson_aoclk_data {
+	const struct meson_clkc_data		clkc_data;
 	const unsigned int			reset_reg;
 	const int				num_reset;
 	const unsigned int			*reset;
-	struct meson_clk_hw_data		hw_clks;
 };
 
 struct meson_aoclk_reset_controller {

-- 
2.47.2


