Return-Path: <linux-kernel+bounces-723905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C613DAFEC4D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3417E177A66
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E31E2E8E0E;
	Wed,  9 Jul 2025 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FrEeYwKO"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764AA2E7F28
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071957; cv=none; b=fzQerYbyeuJs7B7C2Il0IpizaZ721JPEx8qc9/J2DudTkKICMLCIJz7L04xQQHNjwmpYDhGti3YLaofRxM01TR7LXBDLZYjQ8z19oBh0eu38eDHD6CbXIJvjLdDnQ2CSoM4+50Oq9PztyztyX23E2bZGrokoVsX/kaKvfwpMkCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071957; c=relaxed/simple;
	bh=A5Gapvd9pmG5KGm8z0XjdGP1Xzkbg1ds0KDnXyuVVrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bJqUqeb3nLgbN4wgR8JFJHa9yv4AKr4jMq4XUxhyXLr2ktrBYHO2PGdJONw4qCYrBEwZM9yqIiigSjHkiCW/b76XyFAI9pBJKo0sbaZbahLmTYslHwBk+SY50lwENNz1QOEXAzY1j2YAADZrEO2kCSCq9AXmFL1XO0PHY9oirF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FrEeYwKO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451d6ade159so49952925e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752071954; x=1752676754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyQR7nMIaqJhvjojyZVdCfat6irNE82iu33KzL+Vh5k=;
        b=FrEeYwKOczEpJfu7eQwuv4+DKwqUzvpIKcNbCd7tjzA2tafnocBlFEa+UYev29agYh
         26BLXvybBhJ0BiPPyp9pjhZrfv7Mg8stH0wVKtn5VCCNRq/d6sXtBaN0TEguYHmRm2oB
         psjOTAWOqj86YhCpshxoaeFR/x7h1oMFleyksOwObHaKWVl//QK+3vN6KAuLwpWqC301
         UUCNduxR5SD/pbLUFHuLd04qvzNcU37HMDYwesls5DZA+vzz5MUwlek8OT6zcl9DQPuE
         872ncpsyUo7T2l+4tIFydt7udBe1zoN3xjtORcQi9EMwLTzuC3i7Ld0n21ecYUl5L3GB
         Nftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071954; x=1752676754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyQR7nMIaqJhvjojyZVdCfat6irNE82iu33KzL+Vh5k=;
        b=pAodOi9gzXZKqhkdTxXFZBXXNjFbxO0JgN76pDoU1my+dNEZs8pblguCDJq9m0Snsu
         5kMtfW7McokStPU98/4QdJZIDkkxPbJ+sl66Fpol+s1cz5QI1mlE8ATt85WlA0jj3mHL
         s9eJHxPb+hW9GlkFNFlMBWLyMEon1cNBxfDbbfWCEaM6n58KqjaIyfL2PSvCDDi7hTTB
         4jo+cEyV8HftCbF09hXCQtzwsx7hSypd8WNu8YmM2Ks2SEet6qxRLSq/Gk4sSS92sf1U
         2EpiSiSY7YDtByW/0CU492NosKkouhlluS9iwoCN6CLu06b4tdWRDZ28Ha0YpKdE7pw3
         /5/A==
X-Forwarded-Encrypted: i=1; AJvYcCULTdYL1nBHDN/2zsr2KTIgbG5JrKzCyp/1FWZ4mjN/gX2a/hcGHpjmx2nuTsWI6ScTHtMo7MaAv4xcI88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7fyLrdQ90TZH4o+GYu+FcqIGSOW8cXTmGCPjWtpVnJ6Hli478
	5QZNevCG3MVLwiPIh8UzzxcTujUdf4Z27rVtgXPLJs9ieyK/jdAcd58LfC2xIrqiG38=
X-Gm-Gg: ASbGncsRDK1aymygh9c8WEDnYpCB1hVPJZqsyjgQlnIzt1n8oFrlEZaB1y++AaOW4L3
	HGXTC4m0y+6ssRg3EUKw7CI2nJe6Dz+Nd1i1Q0Itvuc9IJB+fqL11WkpJPjtf+oY5CD9KPu1WnA
	Jdl3HdPw8VPdkLqg/AzAALwAbfoQEjhGrpnIdoh9e/WuATmwWwzoO9jR7pL/f0AyYsVXS4vAuix
	RI8FhNh+9wWciKXEXz50V0RqkBng6jwT8kc9p8IUJzH7OzdjRYcIUKv4hZdBS+lZXFzR1CglQpQ
	/ltlhFcLsBt46Y4MJkwBxBBDg4iL+kjRapEMzTYhwqaAdGNiH2VvmQ0=
X-Google-Smtp-Source: AGHT+IGsHwl5+rMjFVilVGS4uZ9wBps6vIXNpmci7apkTHJjRa6NtZeF0fWAhzC6zphVIGoh9yt5ag==
X-Received: by 2002:a05:600c:601:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-454d558720fmr19496665e9.6.1752071953726;
        Wed, 09 Jul 2025 07:39:13 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b04e:cfc4:3bd9:6180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5dfbf56c9sm4480687f8f.79.2025.07.09.07.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:39:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 09 Jul 2025 16:39:04 +0200
Subject: [PATCH v2 08/12] pinctrl: qcom: use generic pin function helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pinctrl-gpio-pinfuncs-v2-8-b6135149c0d9@linaro.org>
References: <20250709-pinctrl-gpio-pinfuncs-v2-0-b6135149c0d9@linaro.org>
In-Reply-To: <20250709-pinctrl-gpio-pinfuncs-v2-0-b6135149c0d9@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Paul Cercueil <paul@crapouillou.net>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3084;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=X9Ki+5EzRPJP9Qn3Qvwbtr2ISnwV85fgPGCpNBHhMQ4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBobn8HFeMyI3D1Dqv2tlHQAY2Z38HnGvNZfdCo6
 FBcXb4w/zKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaG5/BwAKCRARpy6gFHHX
 cubfD/9US7MCY9XLoATZecFIFEpWPf0Uefyye79X1KjQbCS07kHwcGgfH29AFrNvz/x7bWA1zaQ
 j0tbicl/uEJT9H2rS9VI0wDfPs0Lp/jNv3kwL31mLZ5zrr3liqjA1SiWHdyvY3uJqL1WH75P2+T
 eGGET8T0GYpCbuS9ptjobR/lbIDAMAlpddosYHOTPxrv0jcwM8tQW0foOgj0biOm++Exqw04hE3
 lAxop7qj+e99fPMbaq2xxY+fPQDyhHDE+TLJk5rINgIzsoit0/fH2nQDW0ODRcdF34NLaGnJPjx
 KGwSupH2Mt4yw1yZnXBiAJOLOYMiuwwH1zIgy7393NLrdGEKE77UsiGEIe790H0qOryEeXPl5KV
 icLIoiQ5+fWHCwiLeEzdNycAmwN7WUCCKiQbt7rGm+XkhdzVYeFtM178q7tjRXqUTy/XeLHF86V
 gB5mDG0RP0tAc+2vIAsYPaZcNvMlbTtNx8Gs80NVJfnyFLZZUgkqEUXzMNCNnKDGUNxm7ThNvKr
 4CFo6uZG38y7BgdfFnuKMzQCjCQzXuaw7yT2vUolD6aZXlRTeZGwKmgp/AL8++3l7FXG0egh13Z
 TEZkDQdE/c0CUDcQgNfWaYCm2/c3uj45Zh/w+8K1Oimrzad/wNJH4iwwtyZ5/bek9McTHfuZW2U
 zL6jyCz1pu8lcNg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use the existing infrastructure for storing and looking up pin functions
in pinctrl core. Remove hand-crafted callbacks.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 43 ++++++++++++--------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index f713c80d7f3eda06de027cd539e8decd4412876a..965f0cceac56697bc4cdb851c8201db7508c042e 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -31,6 +31,7 @@
 #include "../core.h"
 #include "../pinconf.h"
 #include "../pinctrl-utils.h"
+#include "../pinmux.h"
 
 #include "pinctrl-msm.h"
 
@@ -150,33 +151,6 @@ static int msm_pinmux_request(struct pinctrl_dev *pctldev, unsigned offset)
 	return gpiochip_line_is_valid(chip, offset) ? 0 : -EINVAL;
 }
 
-static int msm_get_functions_count(struct pinctrl_dev *pctldev)
-{
-	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-
-	return pctrl->soc->nfunctions;
-}
-
-static const char *msm_get_function_name(struct pinctrl_dev *pctldev,
-					 unsigned function)
-{
-	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-
-	return pctrl->soc->functions[function].name;
-}
-
-static int msm_get_function_groups(struct pinctrl_dev *pctldev,
-				   unsigned function,
-				   const char * const **groups,
-				   unsigned * const num_groups)
-{
-	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-
-	*groups = pctrl->soc->functions[function].groups;
-	*num_groups = pctrl->soc->functions[function].ngroups;
-	return 0;
-}
-
 static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
 			      unsigned function,
 			      unsigned group)
@@ -288,9 +262,9 @@ static int msm_pinmux_request_gpio(struct pinctrl_dev *pctldev,
 
 static const struct pinmux_ops msm_pinmux_ops = {
 	.request		= msm_pinmux_request,
-	.get_functions_count	= msm_get_functions_count,
-	.get_function_name	= msm_get_function_name,
-	.get_function_groups	= msm_get_function_groups,
+	.get_functions_count	= pinmux_generic_get_function_count,
+	.get_function_name	= pinmux_generic_get_function_name,
+	.get_function_groups	= pinmux_generic_get_function_groups,
 	.gpio_request_enable	= msm_pinmux_request_gpio,
 	.set_mux		= msm_pinmux_set_mux,
 };
@@ -1552,6 +1526,7 @@ EXPORT_SYMBOL(msm_pinctrl_dev_pm_ops);
 int msm_pinctrl_probe(struct platform_device *pdev,
 		      const struct msm_pinctrl_soc_data *soc_data)
 {
+	const struct pinfunction *func;
 	struct msm_pinctrl *pctrl;
 	struct resource *res;
 	int ret;
@@ -1606,6 +1581,14 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 		return PTR_ERR(pctrl->pctrl);
 	}
 
+	for (i = 0; i < soc_data->nfunctions; i++) {
+		func = &soc_data->functions[i];
+
+		ret = pinmux_generic_add_pinfunction(pctrl->pctrl, func, NULL);
+		if (ret < 0)
+			return ret;
+	}
+
 	ret = msm_gpio_init(pctrl);
 	if (ret)
 		return ret;

-- 
2.48.1


