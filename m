Return-Path: <linux-kernel+bounces-759255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3782CB1DB16
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B20585411
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EBD264A97;
	Thu,  7 Aug 2025 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pDhSkzzw"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF8D262FE6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582085; cv=none; b=eB3O2wyLBm1+25Wjk9T+GTWeQIi8l6EN8ZlPaXXbJKQncw6FAuX4BLtRX7lDs3wK0LK7ypvpOh7qBRS5MSUKrSuWohEX4pU06BWIHnZF2pfqjgzhNhfu+khtZn1DKKP0RR7wj3Bkuqf2YtxkYVAEdpBs2Xn4tTxL0Fli2U7QRrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582085; c=relaxed/simple;
	bh=dQnC/rev4tac0Ts401jwqrEOatxbEZjF8FGi4DM7cuE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S3sq4cEXq3uxFBVLBEc3fSlqm80WK6reAK4YJPdK7ERbbjXTaFLVtbzaP/axDbKgmu9lrgW7sxKN/DaqdrcF92Tz1u9pPbon9EbZz4/yOIDW3ISLfYNbKyP2Bzhz0c1XNDIapsDcp6W/qsKOFGDLaPirSHyaLZVzi4m5IXlvSv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pDhSkzzw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so9880905e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754582082; x=1755186882; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ueKHvcoj//pcE68ugp7qzX4T0VIpPeXJwA1UBSmhQZM=;
        b=pDhSkzzwsUQOUR01OauCzE+IMQQRfBYHOiGyhqD9G9K4zHjwihWk7kgvgNnp5AZb2f
         mLbQ8hTSe1TN4ZoE+NdwzQ0U8roQeam3U5gTnv+yfdx+G27kNNMnkcWq/vB6viZ9H0WF
         /I3eABW8I5UO8zswUYxbSFU0zo8d1hHIVJa5eGD3MfFM65lgYLJRXr85qbkfb/3UmgFn
         86zKt8Ox/KFit+ZsShPaynooikEJEKjRAbwtxSxEtYRFeRptp7mhM0X4wECqpMaRfHYX
         5j2l45ACw05K73vaKVn9KGeFb8CKQDD5ClGrEnL9gHvCSf1zQDPy2Sjx6iyWKkoRy+Xc
         CjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754582082; x=1755186882;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueKHvcoj//pcE68ugp7qzX4T0VIpPeXJwA1UBSmhQZM=;
        b=jo0HcDkiYSGC7k3NUtMuVRqd+PRRUjRJOqaMJ0UkigqqIx2XgDNluuKw1QroAhO1iE
         9eQOQA1ZcQ/5V+/vGZPNawuDwJ5MT0Si8r8AUQgXsbrfb3sgujbE0xlCLqz8ek9IdpJf
         z3DSRYvbas1TtbOMNTA/MU5Oa3knN3JoVoF43JDg3deAnj8i+ACk5Iy3tEWNYXPWPbSu
         FLbZf3bJXaBqc/qVaBSx+HvuMMX3wXmyroGROdYQLPjB5xGK6etaIC+THHnBGDSq+PG+
         +DijzypXVMOG0FHvsRbG1es+QIaTq6dPyVzOs8Rb1oumABukMh8HjGPToF7sxO7qyeaG
         xQAg==
X-Forwarded-Encrypted: i=1; AJvYcCWaGBpqyxjmgCr1bQrca7O5M/whCMOz9Bv1o9CZcvzPRazXUDgY7BdWEPGaWz31UxdnIzNVGgOeBuHattU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIv/0r8mNkMzk015BMkAobLS7FSJUPfWCZrO95YuzRpqChZtXV
	a1tu4psAEX0XWdbJtVpHDe5TEHOkiBPlc4f0NDI/l+ZPEXNJNhCelaB6/nglomhKzpk=
X-Gm-Gg: ASbGncsJv5able4pv51Wxa2ej2bMEPzMTT8W2cE6jMQHm0yqZ7ejFeXzpHWEa8Y7bSC
	QrB4mtQP8T+CNpK9onWqfYoQnuy1842iOPZ8hrokdd5sYx/HcXeN+QQD92qOxsDk0KC+tLYT4Xc
	V4Ks0fdXoPFlgHtW0+5V+646EhX7hMJuCv0e+Gcaazq9xop5c+UORhbYhlB4Bll9VeuEJmpOQNt
	b23OMT1RikN7e/QcLCCdESyFUiCraGQk2ECHtMA8LsCbOo4OPYojkWFjXDEtMMosp2ACZvRZlGx
	VtDsNP50yEU1uFhL2StYYVbtHVGCWzqmPd1egDiL/V9vgoJfuYZRN2wohLUkp1UVhbZnTvSLVwW
	EoX18k7Vkvq6E9XAZa48FIRYCLcw=
X-Google-Smtp-Source: AGHT+IFZ7tU4QT0M69GUy2O5NIPrZtS9sVVhdfW1gHaibbjzTCtPYoGYDhegeuvn9CZmTQptWfLgtA==
X-Received: by 2002:a05:600c:5254:b0:453:81a:2f3f with SMTP id 5b1f17b1804b1-459e74bc7a7mr74819405e9.30.1754582081709;
        Thu, 07 Aug 2025 08:54:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459dc900606sm162804165e9.15.2025.08.07.08.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 08:54:40 -0700 (PDT)
Date: Thu, 7 Aug 2025 18:54:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] serial: max310x: Add error checking in probe()
Message-ID: <aJTMPZiKqeXSE-KM@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Check if devm_i2c_new_dummy_device() fails.

Fixes: 2e1f2d9a9bdb ("serial: max310x: implement I2C support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/tty/serial/max310x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 541c790c0109..2b42a4c21a9b 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1644,6 +1644,8 @@ static int max310x_i2c_probe(struct i2c_client *client)
 		port_client = devm_i2c_new_dummy_device(&client->dev,
 							client->adapter,
 							port_addr);
+		if (IS_ERR(port_client))
+			return PTR_ERR(port_client);
 
 		regcfg_i2c.name = max310x_regmap_name(i);
 		regmaps[i] = devm_regmap_init_i2c(port_client, &regcfg_i2c);
-- 
2.47.2


