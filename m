Return-Path: <linux-kernel+bounces-765530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FF7B23984
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58D76E286D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF062FDC2A;
	Tue, 12 Aug 2025 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sUUlxX7D"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF512D0603
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028887; cv=none; b=Lh8AXZjHjIfhmZHgx4w/pLITvv87+EwY2OZpkjTRv/07/J/zgb/bOZ/RM/lGWow70RhLF4J3J3R+8q9lZI8NwX7W90LUhh1rWXSJ4xUW2kYa4iYVXCAEQi61UCCNHfENZ4lh1camBSI6GCeHheWlAH2y/aeh+1AET3WhWPmROmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028887; c=relaxed/simple;
	bh=QhsYH0yhdInsawGFOOU7wcTCxTp2DjRCkw5oJ+fqeTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eS/hNsWGbMS9q8pRvmKcpHdqAZ1TvhlMxkbuYcI9vZNjw2yB+uhHus6NXm/1oXTHKA1qdnhMJP1xeHUOltC+HlDE1tWrApmSGx24qLuhPZAhwGbhxz63OMKNIim95E6gK2kRAjdWfcQuqExoGM7rOZP9+K+yqhakXMP9W/XmUpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sUUlxX7D; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-459eb4ae596so53929395e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755028883; x=1755633683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffT6YWZkdUEe6FghMWArz7x5VLbOw7EcrzjaESrmOVU=;
        b=sUUlxX7D+MPNbVs6ggl8le841YLuoj6GuKA3gt/FLUNZmLtni020nQwC8HlAoe+53u
         4mygUvLxn/KuSmm9E0E6YPWuL9zEig5bp+ex1qvTmtgxGwWOgRpW9frW0zLi1hWUKWoz
         Us5mARKyUxA/tUlqFb5TNOn1E7TAPBLhmrvYE7HzLzLRKizRvox0JsE6rfA+gUMf7Vl2
         psmJTdTuG6uRFtsEqq9M768sDaLXN/rx6nf8NFHdPAz1yvspjefjQXDtbPuO0kmdkyCv
         2yM1KcHtXayF647/ozLBRorzhjDm3DHR/S2coDOksP96uclJ2EpwvMvqmoLVgd/5SKgJ
         K0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755028883; x=1755633683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffT6YWZkdUEe6FghMWArz7x5VLbOw7EcrzjaESrmOVU=;
        b=XULLWtDoUXjReWx8zDH7iChc6h9HEHY07sYlmYQwTYP+dJds7fWSWOnksGCxDz4APY
         421M8r1Y5FbEd3ixVBRY4Op4VikDtbYvOQ1Oaz2ZWlQZLsEm4AxffFl60hg19ip+5k40
         +IhttB6sKvBv9O8h32Tku7H1OV7+BeW3strI5Uf+LFXsVjW3cdvNhXoJCxLOZ5qMtRfp
         nZiaImmnJ6oDWM4ACiA++m3pnpRhfD9TaLmjnmmZFDw2FsptQi05kP6d02XqSgokoKyt
         Wc6yd8uzu/gtMlt6U3g5LlWWmT2a3pjLfm8pHCynFbDm3azL5e/E2xK2xZBaPjZmA6bw
         vxSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiOX7P/6NgAZadOQldouMtPCPkIbuySxIX8Hba5OfygoMxgeVHCXlI6a8Vdb5kGShOYgaUWPj6F4i73p4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7rgkaxqrcahN/BnHOwyHAuPC1higU6tNEcdfznyFzzvS4zuGm
	gbkJ10XmXqdugF/6eqjpCh8PYIQ5hm8+iqfLPfrbQD3RmYFZA9WXsZ703QSTJywppf0=
X-Gm-Gg: ASbGncsGma7f8xEwwKaSebqT499X8jgqMFVCtO7N6Q0guRlMddpFhF+YLOQNtLKHEDi
	npy8wlg6ubIDdEkKbcLSejOri8/KB4ap5Qe0ZbIbJ4RCxWjnZfQBRM6XhgGDSybwk0PMhujapbT
	0REh5BPwcGuENjtLAwM3tHz7GdKQcogSWmHfktnMAePLjYWIzGaFrDlokP2vMjgV505+5U3tzNh
	YpqdP6oraCHCaly/us0+ttt5r5Ie8y1W6ceUvug0P4W/qeEoE4cpvqfjwZ2/gacbjiGV/sQLDo8
	K2ucMsqg4vsDl4DB1fV6Da4+Ytq5j3FiKfZqFSuglV/d769Ju6fCo6bDnJ177yerO2CDDWgvaNc
	d6wm9D3I5rPh3jYDkmtaf4rTLevBuy/9ZK70JX654YBlvFYzp
X-Google-Smtp-Source: AGHT+IHc34Qhx2TDH0Xoena1J/lnQZ1RBfr849sg07pnAZNEpqQgsf69asw97faoWVn6n3rrPRwosw==
X-Received: by 2002:a5d:584c:0:b0:3a4:ef70:e0e1 with SMTP id ffacd0b85a97d-3b917f41aaamr188136f8f.55.1755028883037;
        Tue, 12 Aug 2025 13:01:23 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abed3sm45143947f8f.10.2025.08.12.13.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 13:01:22 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ghennadi.Procopciuc@nxp.com,
	s32@nxp.com
Subject: [PATCH v3 2/2] pwm: Add the S32G support in the Freescale FTM driver
Date: Tue, 12 Aug 2025 22:00:36 +0200
Message-ID: <20250812200036.3432917-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812200036.3432917-1-daniel.lezcano@linaro.org>
References: <20250812200036.3432917-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>

The Automotive S32G2 and S32G3 platforms include two FTM timers for
pwm. Each FTM has 6 PWM channels.

The current Freescale FTM driver supports the iMX8 and the Vybrid
Family FTM IP. The FTM IP found on the S32G platforms is almost
identical except for the number of channels and the register mapping.

These changes allow to deal with different number of channels and
support the holes found in the register memory mapping for s32gx for
suspend / resume. The fault register does not exist on the s32gx and
at resume time all the mapping is wrote back leading to a kernel
crash.

  /* restore all registers from cache */
  regcache_cache_only(fpc->regmap, false);
  regcache_sync(fpc->regmap);

The regmap callbacks 'writeable_reg()' and 'readable_reg()' will skip
the address corresponding to a register which is not present.

Tested on a s32g274-rdb2 J5 PWM pin output with signal visualization
on oscilloscope.

Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/pwm/pwm-fsl-ftm.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index c45a5fca4cbb..e0069dbdb02d 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -3,6 +3,7 @@
  *  Freescale FlexTimer Module (FTM) PWM Driver
  *
  *  Copyright 2012-2013 Freescale Semiconductor, Inc.
+ *  Copyright 2020-2025 NXP
  */
 
 #include <linux/clk.h>
@@ -31,6 +32,8 @@ enum fsl_pwm_clk {
 
 struct fsl_ftm_soc {
 	bool has_enable_bits;
+	bool has_flt_reg;
+	unsigned int npwm;
 };
 
 struct fsl_pwm_periodcfg {
@@ -386,6 +389,20 @@ static bool fsl_pwm_volatile_reg(struct device *dev, unsigned int reg)
 	return false;
 }
 
+static bool fsl_pwm_is_reg(struct device *dev, unsigned int reg)
+{
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
+
+	if (reg >= FTM_CSC(fpc->soc->npwm) && reg < FTM_CNTIN)
+		return false;
+
+	if ((reg == FTM_FLTCTRL || reg == FTM_FLTPOL) && !fpc->soc->has_flt_reg)
+		return false;
+
+	return true;
+}
+
 static const struct regmap_config fsl_pwm_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -394,23 +411,26 @@ static const struct regmap_config fsl_pwm_regmap_config = {
 	.max_register = FTM_PWMLOAD,
 	.volatile_reg = fsl_pwm_volatile_reg,
 	.cache_type = REGCACHE_FLAT,
+	.writeable_reg = fsl_pwm_is_reg,
+	.readable_reg = fsl_pwm_is_reg,
 };
 
 static int fsl_pwm_probe(struct platform_device *pdev)
 {
+	const struct fsl_ftm_soc *soc = of_device_get_match_data(&pdev->dev);
 	struct pwm_chip *chip;
 	struct fsl_pwm_chip *fpc;
 	void __iomem *base;
 	int ret;
 
-	chip = devm_pwmchip_alloc(&pdev->dev, 8, sizeof(*fpc));
+	chip = devm_pwmchip_alloc(&pdev->dev, soc->npwm, sizeof(*fpc));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	fpc = to_fsl_chip(chip);
 
 	mutex_init(&fpc->lock);
 
-	fpc->soc = of_device_get_match_data(&pdev->dev);
+	fpc->soc = soc;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -526,15 +546,26 @@ static const struct dev_pm_ops fsl_pwm_pm_ops = {
 
 static const struct fsl_ftm_soc vf610_ftm_pwm = {
 	.has_enable_bits = false,
+	.has_flt_reg = true,
+	.npwm = 8,
 };
 
 static const struct fsl_ftm_soc imx8qm_ftm_pwm = {
 	.has_enable_bits = true,
+	.has_flt_reg = true,
+	.npwm = 8,
+};
+
+static const struct fsl_ftm_soc s32g2_ftm_pwm = {
+	.has_enable_bits = true,
+	.has_flt_reg = false,
+	.npwm = 6,
 };
 
 static const struct of_device_id fsl_pwm_dt_ids[] = {
 	{ .compatible = "fsl,vf610-ftm-pwm", .data = &vf610_ftm_pwm },
 	{ .compatible = "fsl,imx8qm-ftm-pwm", .data = &imx8qm_ftm_pwm },
+	{ .compatible = "nxp,s32g2-ftm-pwm", .data = &s32g2_ftm_pwm },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_pwm_dt_ids);
-- 
2.43.0


