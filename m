Return-Path: <linux-kernel+bounces-823339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23058B8626D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFA97E1D9E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FD63164CB;
	Thu, 18 Sep 2025 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVUyHkgD"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD81308F39
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215214; cv=none; b=coX8j0JRt+A7tBSjn0jr3jjad5v3hhx+R9MDq/DC/2EmB+H2TFnpnoGR9AUMVsePPL12nLsk25eB6/luirHDDg/PlXLI6d5QAQLZt8BFgZHZXQ83em+ysI8t7OIh2NYr2KhGcbNKdjNnBYERktYHD9ioGrRlDo3FlyzP5hDjZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215214; c=relaxed/simple;
	bh=ud3n6D1ohJwT1gs/SFf/aPQf961smhUDzNFZvPxvybE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=giq5O1whf0Eriwu0BW5DyM9eSHv9tZyVDOr7zRw+kt2uUdI/sAi0yNzY/y8HwDYNeBhuoPhckoFDFfhTsS63m0MAZOUYSL29W1kUYq5LWFOpwEJnqvNXD/P6RxlS5hYx+qyR0qUFkZzUjMuS52sVsAO++n3iBVZoZSVppL/8LQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVUyHkgD; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b0418f6fc27so204853766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758215211; x=1758820011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWsr8e6vH5fTx87zU6KQFrQxbge8SZ8hqdc98Y5sKN8=;
        b=SVUyHkgDWrqeqGGKODHFjA3Mo4WTAT+aR0DQu2P9//8WWpMY1QBEQV1r/tEfdcskEs
         Ok12q8+mW7UQZ33R+jODIC1HlGbQ8+3ync8P7BjnLMHf0F0Eu8Zr20qxlETEEraDo/l+
         RC3Z4JCovMxSYMerxGwdh0KfJJ5c6oPw+88tjaTJhZPN0yXneKCZMUYkIzi0CNBAwVK7
         TTziVP9b8RHnPPiknkwtDLcf8cLoc1t/6fQjHvcFYUPCkZ89zX5qocND969n1K+Wjj53
         T1H9Ucjrj8aZCPxKv9WPbZuyCUDWWvX0VmbBWMsl7Gkn0O8SPf4DnFTTn1S3RsPhhqCX
         Pq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758215211; x=1758820011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWsr8e6vH5fTx87zU6KQFrQxbge8SZ8hqdc98Y5sKN8=;
        b=cwD26uxbGPjlN2cOssiIGSs1WCeiFxBA5FCgWs569jj6cES6AF/Zb8ctmZOn88f6SX
         jqxnYTHUPZcqP3IDUB1gS601DmFlKFp3aPM0vrXiNi0QJqi0HeqOaGelK4LLULHwWh3P
         HBHx9rmbvo27xNGBhMt3+mMYH6mi/FtAPQZWG3pdzLvtkLy5cMUrFRXHjxtJGiXR1N0S
         e4jBNdxt+R6FdCr8CXEDJjjDlJxqllwTqcRUeipC7ge8SqOBjwnPS/WyuCjDg2dnUm77
         hYn06m70GLYT5tGLQ+CetUQFDyTYE6juI2UQPZc4KuZMfLZLIEDXPKkIrDbERX3hQANu
         OYfg==
X-Forwarded-Encrypted: i=1; AJvYcCUK8aO/MCOP0NUgeUN1RMGPIQxxH3FW4a/ABFK+7GJNr5KScR80jMqACaqOUoVnQspqFPf6ro4nHtTFTEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyDJR4zLZj3ruO4MamcMUUAWRagw7rywNt1QAyQOzCCaI0pCKy
	jdCxxK4mn1JJIqm9PEFV73whCQwd84zq7IpcPdi0RSeNLzLPuxserNDe
X-Gm-Gg: ASbGncsEjeFoNi5iHZN1Kqja12k+YBB5PHIHqm/wP7Ipn0qkivj0JKOamCGv1qWuqnI
	RapSX+GMM1DEPDJIwNtZUVVEnIqyLUe1cdToszqUDJUBItXEB/zw/iQFDdWFSx/b6DoZH0yYtFa
	avlBwwX36YA91wFSxAuzhsVt+c6NwDfX31UTlx9HcLdhGjNWMwxlr1ad8hwIHu1+0UNYolWTDOO
	co8PEDqfFsbKqu0G3vFjkjC/F1jWSmEFhXAvZIjjBJPOujvQatnOaoDZ/LrmwflgdlgNfC9miUh
	zb/IQCL3c5NM8SN80nXTG3D6Y90kDI6sLJnuSr1CCbgxotHR+ogR40ROQH1YRXiSa3cBaSeuIq3
	vtGRcPsQcxt38TaZH7O5zUGfUyF771oN1/S1msB0=
X-Google-Smtp-Source: AGHT+IFO7H/oRfjej8T/40hL+S0Y+BHvYcFJrb/QGkPp33/o3RN4Yit5ipR+4qxch1bmEHnpcoSsKw==
X-Received: by 2002:a17:906:6a1e:b0:afe:ffb6:bfaf with SMTP id a640c23a62f3a-b1bb50c4058mr788419966b.3.1758215211237;
        Thu, 18 Sep 2025 10:06:51 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b1fd271f895sm225845366b.97.2025.09.18.10.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:06:50 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 18 Sep 2025 20:06:46 +0300
Subject: [PATCH v4 2/9] mfd: max77705: max77705_charger: move active
 discharge setting to mfd parent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-max77705_77976_charger_improvement-v4-2-11ec9188f489@gmail.com>
References: <20250918-max77705_77976_charger_improvement-v4-0-11ec9188f489@gmail.com>
In-Reply-To: <20250918-max77705_77976_charger_improvement-v4-0-11ec9188f489@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758215207; l=1975;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=ud3n6D1ohJwT1gs/SFf/aPQf961smhUDzNFZvPxvybE=;
 b=xypHKca0j5M1syTuCeKPcjcuJZoX++iQSgCUF6/BcZw/D1MOYGtqeSQwA84yTFR2PQXqNZ7Eo
 q96B/Xz4Zg2AvK3XUE+S1xsKrR7DOO/5fw4tZ8H5AOjjyKUjVv1+Piq
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Active discharge setting is a part of MFD top level i2c device, hence
cannot be controlled by charger. Writing to MAX77705_PMIC_REG_MAINCTRL1
register from charger driver is a mistake.

Move active discharge setting to MFD parent driver.

Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
Acked-by: Lee Jones <lee@kernel.org>
---
Changes in v4:
- commit msg: remove blank line between tags
- commit msg: change prefix in summary to mfd: max77705
- add Acked-by: Lee Jones <lee@kernel.org> tag
---
 drivers/mfd/max77705.c                  | 3 +++
 drivers/power/supply/max77705_charger.c | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/max77705.c b/drivers/mfd/max77705.c
index 6b263bacb8c2..ff07d0e0d5f8 100644
--- a/drivers/mfd/max77705.c
+++ b/drivers/mfd/max77705.c
@@ -108,6 +108,9 @@ static int max77705_i2c_probe(struct i2c_client *i2c)
 	if (pmic_rev != MAX77705_PASS3)
 		return dev_err_probe(dev, -ENODEV, "Rev.0x%x is not tested\n", pmic_rev);
 
+	/* Active Discharge Enable */
+	regmap_update_bits(max77705->regmap, MAX77705_PMIC_REG_MAINCTRL1, 1, 1);
+
 	ret = devm_regmap_add_irq_chip(dev, max77705->regmap,
 					i2c->irq,
 					IRQF_ONESHOT | IRQF_SHARED, 0,
diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 59090703cc7a..b8f648dd4d63 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -487,9 +487,6 @@ static void max77705_charger_initialize(struct max77705_charger_data *chg)
 	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_00,
 				MAX77705_WDTEN_MASK, 0);
 
-	/* Active Discharge Enable */
-	regmap_update_bits(regmap, MAX77705_PMIC_REG_MAINCTRL1, 1, 1);
-
 	/* VBYPSET=5.0V */
 	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_11, MAX77705_VBYPSET_MASK, 0);
 

-- 
2.39.5


