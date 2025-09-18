Return-Path: <linux-kernel+bounces-798765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A79B422AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF582061E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327113126B7;
	Wed,  3 Sep 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GbCt9QwN"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6510930EF7A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907811; cv=none; b=CsFPPrUeVyJDCJKBp0KkyCZp4UOvdDjEjI2MY3CqoKQqEXS2H0xjOclq2/1duliKC8WXkMXcyK7Rb6rx0UQMhyahWXRq18JA+1DyNjZTJHICPe2tcHsMrPBSAoOM1mzJA+D7QAgbUfNg4rRtBWaIoJ4Z2wjbc2kiCJKo7DdL3Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907811; c=relaxed/simple;
	bh=dz7gQjCygFQTHCpzStxcsEQEHazG0z97bLLdbPJU1cI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ieI9Bbp6068w477uKZiEjfCFgmTpcycwV3htYIQMvXSX9YXvrsnXCsgTlrGq676QctNT1DWZrofZeY82GN4u9vNVTWlUpm0M5HZko1XuQdq1ZmCwCA57itxijhC0gNDxPZKAH2lDBhGZy6MDBxRxa04+E4Afj7sTjTCZ2BLDNbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GbCt9QwN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b7c56a987so23382835e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756907806; x=1757512606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYuv3IrS7IPuMyikGmW/lennhceiqK2zrsQcCIyLu+Y=;
        b=GbCt9QwNqPh1zBRtVaheAtuNrRo8B1bIuw+9aZo28tskobvempbkFwJkVGCRPEyroz
         +4d2YeOut4IztKqcjFgBovxJfTm8yzEUnS7F1peemX2iFNGEzCI7vbtjUcTJncZVeW5D
         yKpKbcbDxf+3IYsrIxmwXM8Q2z3UxO3ycd2jSjVfHq/P0QaDTHIfkqycBxkFfv6ws1Be
         XDrOr0LD0El8ja5BvNH3Q1Ld24WknaLtFVuxxO0uIlSL0QKevog97dBEQpkCwAuPO8i7
         HXHvM1huNXkcSpDfwLfD/EgE0vA3xsplKDheXK74XR13PjFm9Tonv9TKKQgbaAxUsduF
         Xazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756907806; x=1757512606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYuv3IrS7IPuMyikGmW/lennhceiqK2zrsQcCIyLu+Y=;
        b=EGT//pJI3SCL+tPTxLrn7YSoymAWFHv1l1nexWaxUeETBYKtd6Laugfz5WRERRH7ss
         Zsl7gj36UfOdjPvB6rrKqfY7OwjGir0y63HoDmYWTkeGvWb4cwg2zNRrGeQCLzqDGg2i
         YQAsBjqcLGCAHdzu37epYy87Hn/jfqiIwfWU4yxBwAsP6RPK4XfJCnTt/fEQtlVRIs8E
         7gg9P4Uri5o5k/3t7WB1yASr2boKFZZ408Z3nONUkYU3Lhk2ktZjONCvmDV3oR71E3/T
         oB6XkmJevmoB4THbyG0KRLRemxt6UAycV/2rz/TfVYJOJ2z7vF3ZhqIvVfKQovPdSABE
         22VQ==
X-Gm-Message-State: AOJu0Yzqrhqg/RtiEMAIITt8QtL//vMpCzezbrtSr7YNKAU5+6mcg2F3
	vDnM15P6ES4ODyyyt3HP+BkDYl5azZ/BQ/3Cw+IoxQEn4U9bPUfed4RGkNtjiS7/Hi4=
X-Gm-Gg: ASbGncubW5tBytK1V2pTuG1ryDMk0WC3kH9DRNoWvXwdarIdt0m6SSlNBcVdi/w2KbP
	rKlzWGJEF0WmOElQ5Lxsekx7fnn2oHvA4/+GjTOqwIEUHNZiXMyHOFdN9sfUAQ19z7WzKNlMRRn
	qiClZgpFf8YplY98tB95koOPgGQAQrm5zQEJebJ03Gbo4NGhD+FcC5Jf0y/t9yPcS2mW+Ndf0Nh
	+xsy2H/29HOKZvL3O+o/nZyWGGfePwHvw+1QXEiTwFiEFM1zPbQjDjh/dLozRbplqZT1cLBJUu9
	a1vUm56mIb1SeMYt0+I5XAbDOAjC2z30rzsO1XPWD6/df/I9MqCkicU6WztJESQQEI5cZuy2qHP
	0/sKSbHMGOWTGL0PfEOYWa2jhbWtyf3AxHbqH4Q5qcb/+lX9Md/XzWmUNibJ4/b+qPvE47OeWoJ
	rishCFyGnfHTcARpliurv+EHM=
X-Google-Smtp-Source: AGHT+IHYANMgRYGXdNHs2QyGL8QnX2/Tp8baR9s93U+KQIcT5D6VPk22Vpiz9HHftpfRlLtqh7LR+Q==
X-Received: by 2002:a05:600c:358c:b0:45b:9a3b:34aa with SMTP id 5b1f17b1804b1-45b9a3b36d5mr60145985e9.16.1756907806344;
        Wed, 03 Sep 2025 06:56:46 -0700 (PDT)
Received: from ta2.c.googlers.com (219.43.233.35.bc.googleusercontent.com. [35.233.43.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b87632365sm197257135e9.16.2025.09.03.06.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 06:56:45 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 03 Sep 2025 13:56:41 +0000
Subject: [PATCH v3 4/5] firmware: exynos-acpm: register ACPM clocks pdev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-acpm-clk-v3-4-65ecd42d88c7@linaro.org>
References: <20250903-acpm-clk-v3-0-65ecd42d88c7@linaro.org>
In-Reply-To: <20250903-acpm-clk-v3-0-65ecd42d88c7@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756907802; l=2606;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=dz7gQjCygFQTHCpzStxcsEQEHazG0z97bLLdbPJU1cI=;
 b=LnTHfH04YTaRtLtGrKsu0l2tPiCHi5kfhymeOk52FGnp5MzLrMabP6gJe0V4GjgInvVmxXtUf
 XE+PInRBnXoA2tDMR/QaB3Bf4NEDZH1HPg1Gifx67K5mHfQZQODjRKi
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Register by hand a platform device for the ACPM clocks.
The ACPM clocks are not modeled as a DT child of ACPM because:
1/ they don't have their own resources.
2/ they are not a block that can be reused. The clock identifying
   data is reduced (clock ID, clock name and mailbox channel ID)
   and may differ from a SoC to another.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 9fa0335ccf5db32892fdf09e8d4b0a885a8f8fb5..0cb269c7046015d4c5fe5731ba0d61d48dcaeee1 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -177,9 +177,11 @@ struct acpm_info {
 /**
  * struct acpm_match_data - of_device_id data.
  * @initdata_base:	offset in SRAM where the channels configuration resides.
+ * @acpm_clk_dev_name:	base name for the ACPM clocks device that we're registering.
  */
 struct acpm_match_data {
 	loff_t initdata_base;
+	const char *acpm_clk_dev_name;
 };
 
 #define client_to_acpm_chan(c) container_of(c, struct acpm_chan, cl)
@@ -604,9 +606,15 @@ static void acpm_setup_ops(struct acpm_info *acpm)
 	pmic_ops->update_reg = acpm_pmic_update_reg;
 }
 
+static void acpm_clk_pdev_unregister(void *data)
+{
+	platform_device_unregister(data);
+}
+
 static int acpm_probe(struct platform_device *pdev)
 {
 	const struct acpm_match_data *match_data;
+	struct platform_device *acpm_clk_pdev;
 	struct device *dev = &pdev->dev;
 	struct device_node *shmem;
 	struct acpm_info *acpm;
@@ -647,6 +655,18 @@ static int acpm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, acpm);
 
+	acpm_clk_pdev = platform_device_register_data(dev,
+						match_data->acpm_clk_dev_name,
+						PLATFORM_DEVID_NONE, NULL, 0);
+	if (IS_ERR(acpm_clk_pdev))
+		return dev_err_probe(dev, PTR_ERR(acpm_clk_pdev),
+				     "Failed to register ACPM clocks device.\n");
+
+	ret = devm_add_action_or_reset(dev, acpm_clk_pdev_unregister,
+				       acpm_clk_pdev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add devm action.\n");
+
 	return devm_of_platform_populate(dev);
 }
 
@@ -746,6 +766,7 @@ EXPORT_SYMBOL_GPL(devm_acpm_get_by_node);
 
 static const struct acpm_match_data acpm_gs101 = {
 	.initdata_base = ACPM_GS101_INITDATA_BASE,
+	.acpm_clk_dev_name = "gs101-acpm-clk",
 };
 
 static const struct of_device_id acpm_match[] = {

-- 
2.51.0.338.gd7d06c2dae-goog


