Return-Path: <linux-kernel+bounces-729115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A155BB031F5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7090F3B5463
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 15:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D5A2820D6;
	Sun, 13 Jul 2025 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRr6k/f8"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B833D27A134
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752422407; cv=none; b=BmTV5WDQxZ/tOShjxY2B0yNBKiegUzT6Nu4YqsGxOewQVvU1XWbKSK51UM22T5lTPbey6dz744/u67gFHdeDuMP6T9LBtbO0ojJapfV6kgXJACGGKa99uDVUQ+ADu0oQdhkhrk9D6JIzDiki3hbSVM3otMnc26Lx92vjCOb2To4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752422407; c=relaxed/simple;
	bh=pZ5MDP5896+CodT7/GaaH3Pyhvg8Pb9YgvnX3lpXxR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtBSPHCuhJpmd3WFyud4wYntHvnLtZynDkQwanfqZQTFr4jujYvbMtvGGL42olMLkz/j67yoRaO+9kv+SwHJFUpw4vod0vSGa1oXo+rWM2Makbe8ec7A66QBHFVLsE/4r1XSd+fndWr5DE3Whh5qhGheUCyOII13hJo4tAR4jPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SRr6k/f8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4535fc0485dso4188195e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 09:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752422404; x=1753027204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8y1sdmncLaVM2+uiJONbouUazUbSvW6Un6/51FtSJI=;
        b=SRr6k/f8XqANkCg3hPI075ymtccuOWkg2WAi8kALvBYN8rEH+3cm3uG3zQvNF8GNeF
         VWYd12fHsu5KSZ8e6PR3FZzkYeHSQbmAGLlnnTO899BJjasy+PBZ6zC+NNDhgvyR9xAj
         ZZlLC3JJX+YVnAe2p0mMBnhcTqDFM5bjvl09L7eqyrxoePg7+iZAw/djijF4+v3SbtD0
         zQQwNTUfO3qD4E4N5H7Lpax93QU7sL/ye7Gyt5wFiQ34qLbfEPTAEvGawE0BdAuKeSW0
         ZdhCTRJY1SQ08KP9L3n6yDeuwjNcTXqlARvr1djPI36noUK6uFDaoWt05nbQJTWCOjDA
         xSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752422404; x=1753027204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8y1sdmncLaVM2+uiJONbouUazUbSvW6Un6/51FtSJI=;
        b=urdyWfwKJ5helIhfQAThktEKyAiAXOFw8RhIAKE0JKN+5YmNKB8d7iBQH5o7odAKr1
         1/dPsf6We0mhPefNo0qaeuIuoBHVsxduakUIgXbanEjh9HE5ZA+jnixjntBcfV511ko6
         l6Og2d7fc3b0vqy72QwPu29lSFu2mIKvTOa+3NJYeYS7VFuoWR2a2/vIpH7RYjTVBrTJ
         nzs7C3zqyI3bXPfaDPnyrmrlzHlyCCbMjvB3ezwcrl9BwewcXMqR98AXYCQ8ua66VHFu
         Xe6oClMQl/jHWzic3+wOf0HSJCM6kJlwkdRBPAC93OFP54G/ZP2LluzMdhd5VEquhyXK
         dbkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ79yL9BwWMevgJ4u+DOvSFbmGHhSQW5kRvYoTn7r0ziu2PIWqXbgPKIOsOSFQd/t9IP+EqfS3PvvnFPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH4tTAlS3WOYdWH/GKKhnd5HxTLovJjFwBhoQgkxam7Hsi8SZK
	X2eugI2IpLYoBjXBZLr3YNijKFL66fDUduRqpM0BqiwzDJSU/qulFLmysCvJpXzNDXJCqI2CUXG
	dQx8F
X-Gm-Gg: ASbGncsZ/at9pg9zyP8UIH7f64YQsakD43YtiE0SFyLLXpZ14dK2GBMS+4Lxe8K9V74
	kUQT4Vr9Lio1ydOtW4tFLk+xt8Jd9ciVBe4Sp6R/f2WuOxzOA5+3wqGWmOZn6sz+4fxgsVK1dwK
	SjyOz1AK0pmG/DGPOBiJCM5WSxcb5yJ/+AnOCznDsd9ad8n3YmOnZYzmYvXDbvoBKPI43x2O3r7
	2w6D+UjNDBbKhDuTWwS2Wxz93z1lZJQSJwtwzdQuQLcuUjc2yUxlqJiCzI41nAPJXPZE/kfWJJ7
	+LHNB0QfNL/5O6/FrI80mr46aqrwRUUqPw0QgHIPfx2i7BHby4/BcDkShHpUUhln+29veIvMhxr
	d/vXmITMVY0yWjb/CEh77f0PNOODlurXHZXCj
X-Google-Smtp-Source: AGHT+IFbwGJ8eDw9MDkFu4ZUj+3SZSOnkMhips1QRjC2anqcty50RynXo2+mXRWEUWGnb1Fseb4oqA==
X-Received: by 2002:a5d:5d83:0:b0:3a6:ed68:cef9 with SMTP id ffacd0b85a97d-3b5f2de5e18mr2504212f8f.3.1752422404016;
        Sun, 13 Jul 2025 09:00:04 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc23cfsm10244123f8f.37.2025.07.13.09.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 09:00:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 13 Jul 2025 17:59:56 +0200
Subject: [PATCH 2/4] iio: adc: vf610: Drop -ENOMEM error message
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-iio-clk-get-enabled-v1-2-70abc1f9ce6c@linaro.org>
References: <20250713-iio-clk-get-enabled-v1-0-70abc1f9ce6c@linaro.org>
In-Reply-To: <20250713-iio-clk-get-enabled-v1-0-70abc1f9ce6c@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=872;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=pZ5MDP5896+CodT7/GaaH3Pyhvg8Pb9YgvnX3lpXxR4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoc9f9JYaIlNouts3THjraDXpvRtleHlBPW86Jh
 HvIHBqKPKeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHPX/QAKCRDBN2bmhouD
 1/T+D/9cu6KCuZLxvV9SE6Bg0C2zZKRkchpEMBu6+aDBS31rwiYqlijW7JRmT1/LG2AlRLqE18y
 STa8LTPoR/NGReIDJMxF/qb7w5eWmjHiKvZjo/QD6CpEB/pIEy/oXnr6iwn3WErAcVEVpkrtBUU
 iwduMivsSe4mgCS+GRfn2IyrB6DGm2ZX/rdBTjtOTiHD28JVa5W75/V2otJ/5sHPD0Py+Jk7Ek+
 8LP3omqbYqwbu3jCLdpsCUtY8Carl1MfnG2uDqGwJO4kPvA6PSZAdHaehsKdoBBEU5Qfb01skZH
 tTKgkTRFcvP8Zs1PcEqOoLubyxPkbs9Oddd9nW7TQs35v2wLFcprFRAAvJpz8SNnsi4lr/6zNi7
 D/tO6n0dL0D9tO/OE3TRG6tNtKA+4lPDCH23vetWxFo6mzhH4OfthVPqsguym27xrTzjXXUWXz1
 mUMhfmplM6hc1E310SxcjhHbjaTEKugB5J9DlLj+UdTuskOvBJm1XeAJuX7S6+MJ33ZCMPvM9OH
 E+qvXLK3InKRrWV07cb9pXcKEd4Zg9fWKmlC3y5rLYrUd0/wLUOE7O9ssHGoIQY05LMx4314HWn
 tJ7rq5MK5jD9g0TDsX8Jz7ZGe1ZyuP/vR+qQyCfJ3nWV/el3l12Xdo7Xna+n3UnN0AfJli03vgX
 ghyGxv3lzpgKvBw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core already prints detailed error messages on ENOMEM errors and drivers
should avoid repeating it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/dac/vf610_dac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
index b30ff7bb44002d4f02c5eb4ac7633774d16b7813..b7ee16ab4edd596564580e7fc9cfb556b2a0ba1d 100644
--- a/drivers/iio/dac/vf610_dac.c
+++ b/drivers/iio/dac/vf610_dac.c
@@ -178,10 +178,8 @@ static int vf610_dac_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					sizeof(struct vf610_dac));
-	if (!indio_dev) {
-		dev_err(&pdev->dev, "Failed allocating iio device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	info = iio_priv(indio_dev);
 	info->dev = &pdev->dev;

-- 
2.43.0


