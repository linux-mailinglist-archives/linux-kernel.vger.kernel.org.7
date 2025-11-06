Return-Path: <linux-kernel+bounces-888979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B83B5C3C5DE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B9FD34E6E2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A9D34FF47;
	Thu,  6 Nov 2025 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJD8B4+A"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F61F34EEF1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445806; cv=none; b=AeO39qgT994x/bk5mftkvzKwP8o0yoYyBqJLfVIlKP6YVL2X+oS7Pf3Oy7jh9hmAqZEiWPV5PQY+gyYFNv8O/A2mOruDncYg4PwbdPYB+SjcQDeQVOHzqpiu+UKZxHABTVnzQQvLP4ropcI2hhQtaUAgpMuCWzQzvK3dLFh3Qhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445806; c=relaxed/simple;
	bh=ZT2hMJMzDp444RtFAMt6NxeIg8ehhxp6qQkq6o38pVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b+BGVx4N0SdQUXGpsN4z5T7ovVOdTFEoGiqjSJ029EZqMDzyTIfYYUBqemcYBRmHQXAcKair+GgoPWteqslP9FFNGWMt7BOKa28rSBajQM5twMtKRtfFsNnvXRIVKeAh1OaDzvDFHuuCggeaAVyhcg638z0ldVCpTXSHeXoslGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qJD8B4+A; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64094a79237so162694a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762445800; x=1763050600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fnpzlv5TqPyTNVopTKhYQKTQxoXkISz35QRtVU9Hac=;
        b=qJD8B4+AnmymLzyCk5PXjbQ1MNcfSmC1/d6kt8V0d+to2YxDcLNuk7sUkHf3Rh/QKn
         PVlJK1ycCTejvmViENrubKKBXCmCWpvCeRw8EzkZHhffeuIXsDC6Ckz0whCR8YLO84z/
         UFwIcCyc1+E0zwuzqqtnY6F9Nhd3E9wB0/hT4D/C3UMAx1HFgxm3Dzc4W4onJxvEjMEn
         J+78stNEUs3UzjQLGwtpDrvK53BX4m8Hoq+URajD5u12v0bVL7scWaVkenizQLsdfVYz
         a9VvQ30nY9ngYbjwkmIPIPE+MrJiBOMo/UWB2wRvzSOD0MAtewD+7b1rvkMD+ReZTzhS
         fUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445800; x=1763050600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fnpzlv5TqPyTNVopTKhYQKTQxoXkISz35QRtVU9Hac=;
        b=hdu/IZyNCy0ATa78FBl7oWiMGnwajkU0gcLBlqOY+wlqwn3+LWfWAH8xCQ5g12keGk
         qma0Jba1Gj4DXLZjIG22MN7w/TCHdg3/fOZWMB7LrsPSTkI+TYxgRNtsXZGO2jPadKeU
         vdFtsNOB68CXeYeTmxlY5fHQqOsIKOtSDmAUYZjRrlmpgzM+XH6XROLGF9MSeteg8ZIN
         d1o5dCKcFmmqH//S2sUZuH1H2ZnNCw1Mbzc+dKvTbDZkcGFqtMMYybAht6dH+fWfgPO0
         62PW4SE2c7c6LNKOtgjVdgphBSkd6i4Ct8+CuisjBaj/21Ww9Zh9TAxp/R8d5NP2nvw/
         +pTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr2HieRJu4WTRkDGgyUfDcyGMG6IguhXdQwsG74nFReNwEeptkRn0FB/TZWLtaWCmwuR9WqYsFK1dC2BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZi7Hocgqgt9jdc9M35ZK3pbE3qES2G2Y+FnkGi1OnEUFJNDZs
	XAD2zCtpUHzsmiLlE46X/xLgPhkm/b3dfpbt/kYAf+9XkrNVamQREyG58JpiZeJSUAw=
X-Gm-Gg: ASbGncv8x007Ki9/r10+tSnhOlUr2MOnh/+jT/lJQeuoQLz+TTOtvu8pRSo1REd5Jyy
	QBJCg2Ano5esAW0hnPvyGhmmP0mOQmmMjVajgVIJJym/C7pOvNG41JMS4NLa4TDQExBHLD2ESXN
	41vLVONJTgilsrrGosdzn+tiGrtd5FL1L1MAdUINGsxLBo1Xj4RiivUSvqhaKpdl6J3aG6Xfjl2
	1IuRiEquVfpCDWgUzxk054Yh+waXB/ysAf2NTb5RZG/c9KVPFUVK5bhtW3yOJ0xAGH646lXhjrw
	XNGph0WYm+BZAGGTxZZ7nD/6fi3eFH6MA2EEVf6b0a3IbDPDdYhAOcEn2wTWKqBna5WL8G6gcGo
	Zxs1KxatC5R8iFbGYAoVKCE4V571ZYqJN820gb5REXCx+nvEaUH1T0KQrYLqZayTWqLzZyzGQuO
	e/rd8DTr+ScPMuYQDxbh0iw7N1yiI=
X-Google-Smtp-Source: AGHT+IG/5tTc7ZxspWUa/B8lb4VJAe+mwb5eciTvDLKhw+fK6fmt5UhwDE0B5Na16xt3VKGSskNthQ==
X-Received: by 2002:a05:6402:234a:b0:640:9aed:6ac4 with SMTP id 4fb4d7f45d1cf-64105a44b67mr3713567a12.3.1762445800269;
        Thu, 06 Nov 2025 08:16:40 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eabsm2113408a12.11.2025.11.06.08.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:16:39 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Nov 2025 17:16:26 +0100
Subject: [PATCH 2/4] gpio: aspeed: Simplify with of_device_get_match_data()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-gpio-of-match-v1-2-50c7115a045e@linaro.org>
References: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org>
In-Reply-To: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 Srinivas Neeli <srinivas.neeli@amd.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ZT2hMJMzDp444RtFAMt6NxeIg8ehhxp6qQkq6o38pVU=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGkMyd/IHnLxQ8aaVNi31HhlicsroQ2rUZcgWUqQhqbqfNgTz
 4kCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJpDMnfAAoJEME3ZuaGi4PXQc0P/A43
 VlDZbJcd8JJgzif8Kxz45G85Cei+azNOhCDEWH00UmdsmhkuwJmwLV+Ajksw1M4M6mgS80zGzly
 5O02OU5dduEuqs5AZNvaL0cVqHiVZhq+YhmANDSBQ0/E3jRTOOR/y9Kzpb9wIJ9YPoNJ2Qtyf3m
 9CiCBFsHGxIT2Asnc0bw2xxxIXDfLJkc0ru5+Hzwr5y0OH6ips03STdfYXBGn82p0xsT4abiVXr
 XW38qszaEhKlyNt/SNUyEhOmddIAXFWNGLymNcCKEUrXEsNJFmCMEbC5SjHYcBkmHthI7LIIAF+
 Xxpmjh52IS6RfKOOLmJEVlRlayLX80kQ9FsGDef3p6FtQEkX9tJPerYMs4SFtxopCN+HF7MixoY
 buUncg8Cw7RYV6DswaMKg4q01FNFuvYAVMAmOTAO1apdaWDsQi40ET5rYH0vkJ1fL7gvPByVP3L
 /uyg6aZubCZd8D55phWmbVsC0kW8hgiZKvjuR7A1zzIhKIxGrx8bpIgiEMaUbxsDIl5G4qxqIh8
 tcABibfodCZr+m12ITCbUUoCgEfmSwcoE57jaZ6Cf6Y0wwzIEnqqP1h0L/smNhts94gcsIoTZMG
 edD5iw8glo6+FCxSFKYbaOvyeqrRYLGb6SNZPRh9N0GGlO3Cch7OoaZuBlidPfbXhcC/r6xtUUG
 VRHv1
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver's probe function matches against driver's of_device_id table,
where each entry has non-NULL match data, so of_match_node() can be
simplified with of_device_get_match_data().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpio-aspeed.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 2e0ae953dd99..3d675b63936c 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1305,7 +1305,6 @@ MODULE_DEVICE_TABLE(of, aspeed_gpio_of_table);
 
 static int aspeed_gpio_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *gpio_id;
 	struct gpio_irq_chip *girq;
 	struct aspeed_gpio *gpio;
 	int rc, irq, i, banks, err;
@@ -1323,8 +1322,8 @@ static int aspeed_gpio_probe(struct platform_device *pdev)
 
 	raw_spin_lock_init(&gpio->lock);
 
-	gpio_id = of_match_node(aspeed_gpio_of_table, pdev->dev.of_node);
-	if (!gpio_id)
+	gpio->config = of_device_get_match_data(&pdev->dev);
+	if (!gpio->config)
 		return -EINVAL;
 
 	gpio->clk = devm_clk_get_enabled(&pdev->dev, NULL);
@@ -1334,8 +1333,6 @@ static int aspeed_gpio_probe(struct platform_device *pdev)
 		gpio->clk = NULL;
 	}
 
-	gpio->config = gpio_id->data;
-
 	if (!gpio->config->llops->reg_bit_set || !gpio->config->llops->reg_bit_get ||
 	    !gpio->config->llops->reg_bank_get)
 		return -EINVAL;

-- 
2.48.1


