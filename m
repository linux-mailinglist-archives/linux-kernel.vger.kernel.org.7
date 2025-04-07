Return-Path: <linux-kernel+bounces-590611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DE8A7D4ED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 09:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371E716CDBF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 07:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5773224B10;
	Mon,  7 Apr 2025 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wmmgvEgw"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD55A4642D
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744009580; cv=none; b=BoscecgUU9P77I24wddrLu2ObE+9Nfyj6puWJbphj/5syQbNsIFpqUQekTYXobgnSb8z4rDbEt6FCHMElkhk6214QauPKF+AwdMg7em5kohm1UGHNUX/3OGTfF2vkiMRSaOfoDjmGn8vw/WPHmMlreRCUUEgimDxNC87Y9GV2sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744009580; c=relaxed/simple;
	bh=XKHfm6nEx4smjwYHy2yy9P0aUj3c8eJQxZYUkxx8vxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jHP9Qgmk9bkw82TvO2U8TF3XpPQZORidMxfCzBcpzku+V46xNxjGZnVNV2w0Zn9UjWHYiupDBuj8nPY2kcazPKmwoQq+8waV7Znnl+xnKs9kt8ACQ5HZN6nNE8NhDlzuzTxbo+U/ZgBll5ytlrdi3AHohc41PrLniqNo61OfThM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wmmgvEgw; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39bf44be22fso2637378f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Apr 2025 00:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1744009577; x=1744614377; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KPDspcrWc8SNTv+COKTrEOpyOhzCwatjdmhFOFL1x1g=;
        b=wmmgvEgw8RzDEVJcNKr5MgCn5Zyx839zpgQsgZAytl27hwHnE8CXFezlsE/bbobU85
         +wycfCipVvCwUMkroY0wqyYErqvpGmtHl3s9mwDLTkKApN1qtQvuuD2ZoVdpr+AGIb9z
         W1qKq77c6mUDYYT8TJB0rRy2xDFaa2b+vSWQKz8j/bUV7pCJXWKe7t034il22hTLxkaX
         lpQyRDynpLFbxWGPSkELaSzdrdgubqBRZuDUEhrLeWbpY/CIvLSWk3wTn2JqpKc3Cw+r
         pXLZUnc90qWMZIcwRolagSXTbb6ep/B5Tdv6HaXgiJHdoDzgtVVMVtigY8sj9a4rODB1
         mhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744009577; x=1744614377;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPDspcrWc8SNTv+COKTrEOpyOhzCwatjdmhFOFL1x1g=;
        b=gh53D8uf7PFHuuGCF6RYRhB7USKpfuznimgmmb1EoZ85WrAsmNbYzdXHvhm62zo5ZH
         Yx/jVJdqenQwhh5D6GeGlkKxoqWQF4DUGK0RMdCM2W7Zmo3M1JMS3enVZ+ZVNiLsvhfG
         MPhyDzRTc0u/OnewFwfEalY0xVmKSSZm3IVCrWtCrq0Ub2PW2hejEDM0CSaXD49iML4k
         zURVA1zpFIdge2wDYy6hlK1NvBr9VY2MS9VydlLLdRT1LKSqI96opRkgcxWg2nqAqQSm
         ADiaF7Md3QvYI5nixh7TErT3vk5aSg+PlkD2YXnz5+eiyNrjpT8bEDPZK0K/jUyUZ6J1
         CXkg==
X-Forwarded-Encrypted: i=1; AJvYcCXEG57aNTqhHwIY6+qcWQqLnJH7Bpg1WHsGVv7tXpI0lkebvrBle+uOwFArl88wh/JkHhX2YxhM3elsPeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxovGvJ9aqaI5Upg4Wzf+J3up7UVpc/jp5OtNI1thwDh/wBCNRo
	r8NYsWPANGWKbRNoPn3Dira8Q0SCauMP6euaTqWA/NqhS58q1jyk/1Vss7VVzoBIF8y360yFZZ7
	3VVI=
X-Gm-Gg: ASbGnctHwQuEXgYVfOraoINKFoBa/zugpyAwbNl8qOVde0TpcHm/TwnWhugbttb4+V9
	iXErnjttVZEi3Fu9zDQ5iI6sBnkedak3oMn97jMHoTZ9sM1t/9zumLfnxUYnCFSvv487+4mtdGk
	w+LxNWvTsr7trMaISK0Z62MWkeVYsDwOmOydcLeO8Wf1VsW/3/RRkbdMnuaCOYEgFozVYEwZVIn
	AWX8494m1xiyEYtnXnfl3izHjR6kO8AbyRKdMlkfodqLcrfMI6A0BBuN4k9YAN3S7d70PxNMs1y
	4xncYc5AU1XEriiSkuMXDf0r4wpUe5L4KY8hNg==
X-Google-Smtp-Source: AGHT+IHstD97LXrR7kCqozIneuLvVFnzoqnkRs3ynNFU6iLZQy8YzuWHbqG2isuTt+xpGxDVlv7dzg==
X-Received: by 2002:a05:6000:2506:b0:38f:3073:708 with SMTP id ffacd0b85a97d-39d6fc00b6dmr6456015f8f.3.1744009576685;
        Mon, 07 Apr 2025 00:06:16 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:8c64:734d:705a:39a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ea978378esm114228205e9.1.2025.04.07.00.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 00:06:16 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 07 Apr 2025 09:06:15 +0200
Subject: [PATCH] gpio: ds4520: don't check the 'ngpios' property in the
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-gpio-regmap-ngpios-v1-1-5ea63fcbde39@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGZ582cC/x3MQQqAIBBA0avIrBtQo6iuEi3EJptFJg5EEN49a
 /kW/z8glJkEJvVApouFz1hhGgV+dzEQ8loNVttOt7bHkPjETOFwCeMHQTK9c2Q27ccBapgybXz
 /03kp5QXNH3U3ZAAAAA==
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=/LygrKyYAl6OdB73ywIWR2YsLqt7yWTazhF+InwtTFA=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn83lnDTPLrwv6iTKolrak8X9ZMzx4lxBcU/9Mf
 lxgjSry/gCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ/N5ZwAKCRARpy6gFHHX
 ctvrD/4/0X18xMH/ngawSSeL+Z1Hp5SGK57eY99F0ZFneZjiZG5dCVBZXQAUiN2J16itdhNmVE4
 WLPHONSOyONf2sgLiuKbZi2IFUbRqfbDSrvhcfGFnRg2X4I8yy3BsRQmXuzYbUYxt8XQ0PWSkZz
 WzWclH88Q76cFFmHU8gaGaGfuM6FUxlxth5Arw52J/4LVTLGZIhx98a0nk6a6Fnflpij4V0gARc
 lZDhrkkMSFbmmoayoSHuRAXmhdR/lAtN+DgM70VM/sD4O2R+GCcFBUqb0xrxhd/zx8tyOruOnvM
 O8TXjwFi7og6B3T9MOKubiS3MG5Ro2a/Gz5sDovjJi0BBOSihoAZJA+0BJwU2o2cl1c169IoZ5V
 AQZ5Q/uH7q2v1nOjWeUuyj9V0fD9ubmgfBmTIuUpgKuM+NgBI9YsL/v9X6rC3QoahD19OUhKq5t
 t+1knD1lZ7+Qd7yBrsWDAg33oUhUfpNTDYL2lSze7HwkQPO1/FTUdLbo2RaZ944AbRouERxrZG1
 86v87LhRg1lWqPYDfNISxIrvouAWPd1yhriYzK1NsyhKrNhoDHyi2BThmva3rM68l/lcpvxLpkn
 RJR6UmTaJHV5KJ7BzWgEOh0cE4XDacenik9W1zXpU8uAYgK6Cuh3QR2BGACNbthHtBd7cJtP8jA
 zeUfqtb2TXJ0jRw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This is already done by the gpio-regmap abstraction by calling
gpiochip_get_ngpios(). We don't need to do this at the driver level.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-ds4520.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpio/gpio-ds4520.c b/drivers/gpio/gpio-ds4520.c
index 1903deaef3e9..2390f53dae46 100644
--- a/drivers/gpio/gpio-ds4520.c
+++ b/drivers/gpio/gpio-ds4520.c
@@ -33,10 +33,6 @@ static int ds4520_gpio_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "Missing 'reg' property.\n");
 
-	ret = device_property_read_u32(dev, "ngpios", &ngpio);
-	if (ret)
-		return dev_err_probe(dev, ret, "Missing 'ngpios' property.\n");
-
 	regmap = devm_regmap_init_i2c(client, &ds4520_regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250326-gpio-regmap-ngpios-e16aae1f0c98

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


