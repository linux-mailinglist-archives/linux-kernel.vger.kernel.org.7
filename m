Return-Path: <linux-kernel+bounces-891750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A2AC4361A
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 00:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 491284E303D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 23:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F30A287259;
	Sat,  8 Nov 2025 23:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CpR5NOMW"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF7F28851C
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762643607; cv=none; b=p7qcEQP/u3X/JQz3Ryt0FpASGIJzCZnGgMzYISWox5v7D0zqTxX4vYj7fTdH0MwoRMPNMLfMxJ4fdRV+IqBgYEM8ZtWNgp+t/BVpk8CT7ixlGrFh/uuqOJa0LVM5vAI3KlAFOVNjE8kyGsg2kGLeGfTlmIIRssu0TteM5721w8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762643607; c=relaxed/simple;
	bh=HKvLDGntfxAdVB5jKwgETSQbj7yN244c1FScM9L9Ef4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+r9ZYCENwA0w65IKYSztewx58DXFt/BdPOVvvML/hOYPbUzkAwuStN0B1XMTMqdda6fr467VQyYeYUpl0WzrmFJ1ZARm37w6370FCeycNrsNbm9g5fENWd29OiFe4AbZc7H947qhf7YTf3+SQfAF1t6HUDNb2mKHQ19h5SbmSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CpR5NOMW; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so3204697a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 15:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762643604; x=1763248404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72U297d2NX6RO9yoD7XU9KTbdxctb0+CTvTsi0z9044=;
        b=CpR5NOMWT20k3aaRILBJwZyiUS7m6EXt7cjtUjW1Jf/mcN34ZzLvtA6IVJ9yFUn0IT
         CqGVtE1YpRCuiKtu5wG4jz2j6suDa8EyzSGl6O3s2Fc8i5eP41+sC1ctxokx9IiQu7y6
         kQcdvpKt1P23ST0prLxnF2YkDrClquYfYajGPx8c9NZ83V/9eaWJZS5IZYwijYq/eH/V
         JfahJYKbI+u2bja0Z6sgD1CAbMG46KRKaGSFfKvcG9H1kwmNvx9a5UUlsvQ3YIy5PBDP
         z63cVQFxog+dpbBDarQPHaxGZVmqoqpKwdRFkxzRRjsN1NGMCsrRLC84vI/ZpNszpbVi
         AT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762643604; x=1763248404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=72U297d2NX6RO9yoD7XU9KTbdxctb0+CTvTsi0z9044=;
        b=MtuSjKwlAZYczgT6UxZP17A/ehVxdZNn45qp3TTYvShjh9WQvyVuUejiYJ6xtUKEah
         NCz31NU0EoqyWdfpHQy5cvxllJPT/TRJgR2kIFvHtQwS+itLgIXw8jR/cDTd4imZ3H7a
         6Cp+UKVdzYQFUfRJHvNXuTWZY7bhGzQyYUaSroVfUcxnHhefU8kaHPrDsFLTg4MujLeL
         +HnudyaQKNDTgb+IBnoDOqoktQlcKvKLiqqpidOrpt0Fs2pYGiVAZE9c2obe6yw7whBc
         P6MN5otjjsEcvBUunXehzBRCZCcGHyxnzw4pWIhsSGoFSrqPP4R4yxLl87//zvdUeMLH
         Xgcg==
X-Forwarded-Encrypted: i=1; AJvYcCWW/M0ViUMSKhutNBfcT9kUErzbgDu3E6gY4d2ivoMcJmERlj5AZoJWDd5BAhzyO6yW+ItYwGHZO/OIk+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKiksLGSnKzk2nb+CmgqaiZ3JOprJLJaZVc1A5VrSJBujYcsW5
	T5SBKtl18DFYv8pqwCCHpaatPiFvFlYGTZywn52XNeF7COt6xonnSxDG
X-Gm-Gg: ASbGnct7BrW4b7vteopLoofZogo5fh1ukma2gtGx7RYoq0oLKyrDwo30W2Y9bp4g1Ab
	tbvivvpUh9Vc1KIZu+gxJXxlnVthvmO2NcZPJE905QLFpZSwgld3iCpcNP9fQS1ExVQsy2VytFV
	lGGPWze/N7I7QpwKTNxQJTfkp1ndTdO4VusJZzMgR0FOGRFejF5LBc3cFrlvFI+xPF/j19EfUhZ
	3DOUtK3aJCY1VUdb1ecB7xp4MY0EtT/5xei39m4v0/NBxeYalXbzgk6opaSc+sufg8D7Sl14pfq
	zLWywL66yQSuAo+pcO5OPIM/VtozDBPPfXFqRHyrJs+mdn0e2KKdohbo21am4btMt2i5FArFJxv
	SIFqDDHlr0leg3jKu+NzjaBvzfAKUkTRnUUulelbkYWf/HqVvI46yYeYj2LG46HIUWA3bUIbOAf
	ldcv8iiR86hO+3+OUw8fiXWfDobkY9etnG/Uq1bUXYRmHBXFf31mmvjWEgsOT4E504VmRxKrjW0
	/eaqs6jN6L9VdAD+nCykV8Z0WaOWBBsfXOMVaH4e0c=
X-Google-Smtp-Source: AGHT+IHbNQTEVG2cKof3S4FeUIgLFrT/DVsyswwXVAtJnkg7b3F2iGq4VQNvhnBsPlTOOJ7clsnvPQ==
X-Received: by 2002:a05:6402:270c:b0:640:d0d9:71d3 with SMTP id 4fb4d7f45d1cf-6415dc2ea5fmr2873707a12.6.1762643603577;
        Sat, 08 Nov 2025 15:13:23 -0800 (PST)
Received: from blackbox (dynamic-2a02-3100-a9b3-6600-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:a9b3:6600:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6411f814164sm7642807a12.13.2025.11.08.15.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:13:22 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 3/7] mmc: meson-mx-sdio: Refactor internal clock initialization
Date: Sun,  9 Nov 2025 00:12:49 +0100
Message-ID: <20251108231253.1641927-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
References: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use modern common clock framework helpers for simplifying the clock
controller management:
- switch to struct clk_hw for internal clocks and only get the
  "cfg_div_clk" (which has to be managed at runtime) as struct clk
  using devm_clk_hw_get_clk() which is then the only clock used by
  struct meson_mx_mmc_host.
- use CLK_HW_INIT_FW_NAME and CLK_HW_INIT_HW helper macros for simpler
  init data initialization
- keep the clock controller memory allocation separate to prevent a
  potential use-after-free because struct meson_mx_mmc_host_clkc is
  free'd before controller_dev

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-mx-sdio.c | 119 ++++++++++++++++---------------
 1 file changed, 61 insertions(+), 58 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 1159cc911359..ce1828d915da 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -99,15 +99,15 @@
 #define MESON_MX_SDIO_RESPONSE_CRC16_BITS			(16 - 1)
 #define MESON_MX_SDIO_MAX_SLOTS					3
 
+struct meson_mx_mmc_host_clkc {
+	struct clk_divider		cfg_div;
+	struct clk_fixed_factor		fixed_div2;
+};
+
 struct meson_mx_mmc_host {
 	struct device			*controller_dev;
 
-	struct clk			*parent_clk;
-	struct clk_divider		cfg_div;
 	struct clk			*cfg_div_clk;
-	struct clk_fixed_factor		fixed_factor;
-	struct clk			*fixed_factor_clk;
-
 	struct regmap			*regmap;
 	int				irq;
 	spinlock_t			irq_lock;
@@ -548,8 +548,7 @@ static int meson_mx_mmc_add_host(struct meson_mx_mmc_host *host)
 
 	/* Get the min and max supported clock rates */
 	mmc->f_min = clk_round_rate(host->cfg_div_clk, 1);
-	mmc->f_max = clk_round_rate(host->cfg_div_clk,
-				    clk_get_rate(host->parent_clk));
+	mmc->f_max = clk_round_rate(host->cfg_div_clk, ULONG_MAX);
 
 	mmc->caps |= MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY;
 	mmc->ops = &meson_mx_mmc_ops;
@@ -565,54 +564,62 @@ static int meson_mx_mmc_add_host(struct meson_mx_mmc_host *host)
 	return 0;
 }
 
-static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host,
-				      void __iomem *base)
+static struct clk *meson_mx_mmc_register_clk(struct device *dev,
+					     void __iomem *base)
 {
-	struct clk_init_data init;
-	const char *clk_div_parent, *clk_fixed_factor_parent;
-
-	clk_fixed_factor_parent = __clk_get_name(host->parent_clk);
-	init.name = devm_kasprintf(host->controller_dev, GFP_KERNEL,
-				   "%s#fixed_factor",
-				   dev_name(host->controller_dev));
-	if (!init.name)
-		return -ENOMEM;
+	const char *fixed_div2_name, *cfg_div_name;
+	struct meson_mx_mmc_host_clkc *host_clkc;
+	struct clk *clk;
+	int ret;
 
-	init.ops = &clk_fixed_factor_ops;
-	init.flags = 0;
-	init.parent_names = &clk_fixed_factor_parent;
-	init.num_parents = 1;
-	host->fixed_factor.div = 2;
-	host->fixed_factor.mult = 1;
-	host->fixed_factor.hw.init = &init;
-
-	host->fixed_factor_clk = devm_clk_register(host->controller_dev,
-						 &host->fixed_factor.hw);
-	if (WARN_ON(IS_ERR(host->fixed_factor_clk)))
-		return PTR_ERR(host->fixed_factor_clk);
-
-	clk_div_parent = __clk_get_name(host->fixed_factor_clk);
-	init.name = devm_kasprintf(host->controller_dev, GFP_KERNEL,
-				   "%s#div", dev_name(host->controller_dev));
-	if (!init.name)
-		return -ENOMEM;
+	/* use a dedicated memory allocation for the clock controller to
+	 * prevent use-after-free as meson_mx_mmc_host is free'd before
+	 * dev (controller dev, not mmc_host->dev) is free'd.
+	 */
+	host_clkc = devm_kzalloc(dev, sizeof(*host_clkc), GFP_KERNEL);
+	if (!host_clkc)
+		return ERR_PTR(-ENOMEM);
+
+	fixed_div2_name = devm_kasprintf(dev, GFP_KERNEL, "%s#fixed_div2",
+					 dev_name(dev));
+	if (!fixed_div2_name)
+		return ERR_PTR(-ENOMEM);
+
+	host_clkc->fixed_div2.div = 2;
+	host_clkc->fixed_div2.mult = 1;
+	host_clkc->fixed_div2.hw.init = CLK_HW_INIT_FW_NAME(fixed_div2_name,
+							    "clkin",
+							    &clk_fixed_factor_ops,
+							    0);
+	ret = devm_clk_hw_register(dev, &host_clkc->fixed_div2.hw);
+	if (ret)
+		return dev_err_ptr_probe(dev, ret,
+					 "Failed to register %s clock\n",
+					 fixed_div2_name);
+
+	cfg_div_name = devm_kasprintf(dev, GFP_KERNEL, "%s#div", dev_name(dev));
+	if (!cfg_div_name)
+		return ERR_PTR(-ENOMEM);
+
+	host_clkc->cfg_div.reg = base + MESON_MX_SDIO_CONF;
+	host_clkc->cfg_div.shift = MESON_MX_SDIO_CONF_CMD_CLK_DIV_SHIFT;
+	host_clkc->cfg_div.width = MESON_MX_SDIO_CONF_CMD_CLK_DIV_WIDTH;
+	host_clkc->cfg_div.hw.init = CLK_HW_INIT_HW(cfg_div_name,
+						    &host_clkc->fixed_div2.hw,
+						    &clk_divider_ops,
+						    CLK_DIVIDER_ALLOW_ZERO);
+	ret = devm_clk_hw_register(dev, &host_clkc->cfg_div.hw);
+	if (ret)
+		return dev_err_ptr_probe(dev, ret,
+					 "Failed to register %s clock\n",
+					 cfg_div_name);
 
-	init.ops = &clk_divider_ops;
-	init.flags = CLK_SET_RATE_PARENT;
-	init.parent_names = &clk_div_parent;
-	init.num_parents = 1;
-	host->cfg_div.reg = base + MESON_MX_SDIO_CONF;
-	host->cfg_div.shift = MESON_MX_SDIO_CONF_CMD_CLK_DIV_SHIFT;
-	host->cfg_div.width = MESON_MX_SDIO_CONF_CMD_CLK_DIV_WIDTH;
-	host->cfg_div.hw.init = &init;
-	host->cfg_div.flags = CLK_DIVIDER_ALLOW_ZERO;
-
-	host->cfg_div_clk = devm_clk_register(host->controller_dev,
-					      &host->cfg_div.hw);
-	if (WARN_ON(IS_ERR(host->cfg_div_clk)))
-		return PTR_ERR(host->cfg_div_clk);
+	clk = devm_clk_hw_get_clk(dev, &host_clkc->cfg_div.hw, "cfg_div_clk");
+	if (IS_ERR(clk))
+		return dev_err_ptr_probe(dev, PTR_ERR(clk),
+					 "Failed to get the cfg_div clock\n");
 
-	return 0;
+	return clk;
 }
 
 static int meson_mx_mmc_probe(struct platform_device *pdev)
@@ -682,16 +689,12 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 		goto error_free_mmc;
 	}
 
-	host->parent_clk = devm_clk_get(host->controller_dev, "clkin");
-	if (IS_ERR(host->parent_clk)) {
-		ret = PTR_ERR(host->parent_clk);
+	host->cfg_div_clk = meson_mx_mmc_register_clk(&pdev->dev, base);
+	if (IS_ERR(host->cfg_div_clk)) {
+		ret = PTR_ERR(host->cfg_div_clk);
 		goto error_free_mmc;
 	}
 
-	ret = meson_mx_mmc_register_clks(host, base);
-	if (ret)
-		goto error_free_mmc;
-
 	ret = clk_prepare_enable(host->cfg_div_clk);
 	if (ret) {
 		dev_err(host->controller_dev, "Failed to enable MMC clock\n");
-- 
2.51.2


