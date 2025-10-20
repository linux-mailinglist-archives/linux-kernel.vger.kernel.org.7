Return-Path: <linux-kernel+bounces-860238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE91BEFA49
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44ED23E4386
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0334F2D9EE5;
	Mon, 20 Oct 2025 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q756PmHl"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B432DCBEB
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944685; cv=none; b=bsom3cTuiIGbzw661z3RN9FfmXqg5GWMRMUaGkI9xtsSiCvlSa4MaTv83Rcgx7XTUIM2W33oWRlZXQwqdZgv7nvWH9Y68I2fUNmV6IdMDs342qGwGPJad12nE09zmXNjS+I7q0dqOE4XFvb2Rx7LyqqRwKzUNBbIjkN5xiAulFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944685; c=relaxed/simple;
	bh=FTihK6uYT4ixjF50Vw4ynXL5CEP05/iNF9Xq9F5RApY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OVAZ0oNzt0y+fIEQIoTryGx085kKgrdtBZauEoQFe+V/hcRxlSlLRGj508T1v4t080OJMb2oQQlukvEwlCuio4AgAycem5wH46P0z1eyjF0L7ZR2NFFwi1UFlR73ZKbRUsLpCFK9Cjn3mtMgIhM/Ru2ypX1GRIANKcPSJGmnwoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q756PmHl; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-375eff817a3so44075661fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760944682; x=1761549482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahXnYEIy0Y1Nce01ca/pyKJBMfwBwWqGfxBJ5FNQLYM=;
        b=Q756PmHlViTOTuiGlDS8T5xx38YU9eoNwIIT+R/E4NfoyFBqvHkOYG5GW/N/SxNisC
         toA8xYvm/vUadZ1P0jaVlgigvKkvNaVTHiYKyoY4khE0MERuAe/1SmFnribui7Nlg+CS
         gAN5Vg7hlMwFWKljHuyG/YfzfzATGEKvFp25cnRxnRGW07ua9WunjZ74qYSFHbP/ekRe
         IvfIEgpXbeFIksfHYMNjYNxAT62cH9Wa0I5zdTDSAE1SJGtjdONIY5YzzElVdqD64+G9
         Dtr4hGIfzG+qLbqGz3Xt6IhtkrSGRc14nfDuwDtbAVGAm7e4v2Xfc/VYPPiyPUuco222
         BiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760944682; x=1761549482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahXnYEIy0Y1Nce01ca/pyKJBMfwBwWqGfxBJ5FNQLYM=;
        b=FimUeqhjsAlo0eJ2jfCGItwfR+MTc2OAg77Tsx4ZE5Wv8R5/V8ijUueztII/VcS4cm
         sNHa7bb5SAky2X6stI9RcqE9wiUbiVpF4SiVG98ZXGMoianPWxCSE7wmfEyXZXCzhfjE
         lBhR7Bry1zt5z/yjvWk3S4i6zokvaCqwoHfEjOVacX9blCqHTJe5MIioc2G7GNscAKNf
         QvO0MtBtpYiVnCGPEhp+06dexomlxaVB4PXNvt+Nxt0lM9DqsBfgwRUTOjLOnf4q/Kfk
         TLBYS1C1+1lhPAqOB06P4pzP4FPk19AhD6OGyX49bIxbz5EPpV+iM3ihuypxIzZawzNZ
         Vu4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXS5/KOVsodmH41HugcK1mEvwp8KNhgjAUuefZY8PyGJbASNvit6xYYybLa7JNz4CqXIrPrHLr5dPC+4jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtWO5ZO/UBKNaC0eulsIvvRwRGjYdVqJD0UqbflWsiHRuh2Dpi
	LP37siv/lxIYnGLBas5SwWsZoLoxeLm5YOhlS8OjSnekM6GgOeXo9f1W
X-Gm-Gg: ASbGnctUJ6EQB4U5UXjNGuiinoWGoNhP2p+LO95vxEr6cuIDsdEDn3xIamO3SuzRPPw
	Qw607CPdu5GBlvdd5YMtSt8JifwljU0LxF7MH0IGaoWTJ0q7oFG3gvsT3Owg/RMky3A+FRTI+GV
	39TnVKtmBfzqyN7htQB09qV1qHHk1itVfotdxx1Esbea21jYnGMCf7crFUIm/qNiiOJQznKCXnI
	nTCB93H4EUZYZsummfsS3tYU9cY1Slh4HFuRC9EzhRBy8HqbCAKlZLvVAP38TefRNUPYvUbxLlx
	z89P9JKka5+c3YIqI1q9cbs8T++lYCKQ2Hkd3ywkR2SQjHKuzn4BgAR3w3TVG4pHi6HD5OE3KnR
	cP7wxP/v/exSyLk1hEDGQ/WtGs0RVIUyQvbSws3c6EWMmN+CN8bERDCASIcnyUbSE4+rOMCi4B0
	VARMSBOAqMaalZs/eH7VdsmmrU9LMVf6OGSOGHhuwVf04/
X-Google-Smtp-Source: AGHT+IHc20f5dVJc4cXk+lySAahWKiNgFNk1yyb9uo2f2CQAkVWvE8JLzorsxqq/7Nc7apWUcybs5A==
X-Received: by 2002:a2e:bd02:0:b0:376:3a83:4287 with SMTP id 38308e7fff4ca-37797ad9579mr41086221fa.49.1760944681398;
        Mon, 20 Oct 2025 00:18:01 -0700 (PDT)
Received: from [192.168.1.168] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a921ae62sm18863341fa.21.2025.10.20.00.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:18:00 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 20 Oct 2025 09:17:26 +0200
Subject: [PATCH v3 3/5] i2c: davinci: calculate bus freq from Hz instead of
 kHz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-i2c-mux-v3-3-908ac5cf9223@gmail.com>
References: <20251020-i2c-mux-v3-0-908ac5cf9223@gmail.com>
In-Reply-To: <20251020-i2c-mux-v3-0-908ac5cf9223@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Peter Rosin <peda@axentia.se>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2905;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=FTihK6uYT4ixjF50Vw4ynXL5CEP05/iNF9Xq9F5RApY=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBo9eITJgL8eZ4mgTF7Sje1LcSSVkFjVx0hh55ZX
 UtvDGMzVRaJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaPXiEwAKCRCIgE5vWV1S
 MqBmD/9zCdk4ai36HV8z4fap4cJ5nFGwa+6KluAzekdnmMs0wj78o9UrLZbVDEJnMFlPu+WDe/X
 9XiAy6rx/lR3jqukyWAfHrVdo1a0XnaZf6J7SvWJ6shWdnWpjUiEwOGSsv8X+kTR1Cb1ARvWanQ
 KvaGaiduD3gMq48ISJ4bHdWx0QCSetCnP2H5n9TLm0dh7hI1CJbq/OcQIUUuR6a+wRl9S3TdLLR
 xIIr8NlRS/ZxbpkhYqSXTnCyFWwPFaC1p6O1zYZC9ysbwZN28wjRWoSl7kbAkA9d33kaNlA5XvP
 30hYgo4s7zQbI/eTbK453pWv0HG0yIZevd3mk56cUypMoNcH/JNaEGW0WIGubADCELJXJnAsmar
 UaAm6hOL0FQApzNYUNSAy/sYN0jZtnoC6SlkKfZf+odNAw02mIL1Y8Eu+80UsDzUY7fdbPFv6GD
 x6zWB1uPfQ42kdkknvYXw2crH42kAn9jTAPIiEmMzIltaQ/Gg6sBFxrfyDMikqTshhygltgDJjB
 xTdqO2ptb0vpNLWTm70c2+BUU8BVkHaKwsvGXd9Em7M2NEDph+iKIhrfQXE88aVXg8GNymcZSug
 3RP1LH83VcZMwAXMscQkTYojDmMRABe9Ch3NYXyqzq5M6/sFK39GKfznPjbfVh/00JmAh6cWpjN
 JHx4QmCeU2r52aA==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

The bus frequency is unnecessarily converted between Hz and kHz in
several places.
This is probably an old legacy from the old times (pre-devicetrees)
when the davinci_i2c_platform_data took the bus_freq in kHz.

Stick to Hz.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/busses/i2c-davinci.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 6a3d4e9e07f45ecc228943e877cde1fd9d72e8cb..82f295619c4d0ef108c57d13c10004aa25014cbf 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -117,8 +117,6 @@
 /* timeout for pm runtime autosuspend */
 #define DAVINCI_I2C_PM_TIMEOUT	1000	/* ms */
 
-#define DAVINCI_I2C_DEFAULT_BUS_FREQ	100
-
 struct davinci_i2c_dev {
 	struct device           *dev;
 	void __iomem		*base;
@@ -134,8 +132,8 @@ struct davinci_i2c_dev {
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
 #endif
-	/* standard bus frequency (kHz) */
-	unsigned int		bus_freq;
+	/* standard bus frequency */
+	unsigned int		bus_freq_hz;
 	/* Chip has a ICPFUNC register */
 	bool			has_pfunc;
 };
@@ -209,16 +207,16 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 	if (device_is_compatible(dev->dev, "ti,keystone-i2c"))
 		d = 6;
 
-	clk = ((input_clock / (psc + 1)) / (dev->bus_freq * 1000));
+	clk = ((input_clock / (psc + 1)) / (dev->bus_freq_hz));
 	/* Avoid driving the bus too fast because of rounding errors above */
-	if (input_clock / (psc + 1) / clk > dev->bus_freq * 1000)
+	if (input_clock / (psc + 1) / clk > dev->bus_freq_hz)
 		clk++;
 	/*
 	 * According to I2C-BUS Spec 2.1, in FAST-MODE LOW period should be at
 	 * least 1.3uS, which is not the case with 50% duty cycle. Driving HIGH
 	 * to LOW ratio as 1 to 2 is more safe.
 	 */
-	if (dev->bus_freq > 100)
+	if (dev->bus_freq_hz > 100000)
 		clkl = (clk << 1) / 3;
 	else
 		clkl = (clk >> 1);
@@ -269,7 +267,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKL_REG));
 	dev_dbg(dev->dev, "CLKH = %d\n",
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKH_REG));
-	dev_dbg(dev->dev, "bus_freq = %dkHz\n", dev->bus_freq);
+	dev_dbg(dev->dev, "bus_freq_hz = %dHz\n", dev->bus_freq_hz);
 
 
 	/* Take the I2C module out of reset: */
@@ -761,9 +759,9 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 
 	r = device_property_read_u32(&pdev->dev, "clock-frequency", &prop);
 	if (r)
-		prop = DAVINCI_I2C_DEFAULT_BUS_FREQ;
+		prop = I2C_MAX_STANDARD_MODE_FREQ;
 
-	dev->bus_freq = prop / 1000;
+	dev->bus_freq_hz = prop;
 
 	dev->has_pfunc = device_property_present(&pdev->dev, "ti,has-pfunc");
 

-- 
2.50.1


