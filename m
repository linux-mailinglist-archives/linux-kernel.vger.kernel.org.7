Return-Path: <linux-kernel+bounces-737362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40424B0AB5B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB551C279FC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B6621D3EF;
	Fri, 18 Jul 2025 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ueVioxyj"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CC9213E89
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873741; cv=none; b=IFcpfH9gXdqYH/fcGH5ccRn9XN+uI94Jj5bM+MfnRh62rwAl7m4nEcYZOnJs6p217GbM2oe/R4zFT2uH2C2qAXmPT5m2J9tEljWXk22LHOF/iPYY50xHwJ5Q4UR0y5MP4Zfhf3yT3gn9G6yfu3MyA748YT5UNXapeOh1rJcXX9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873741; c=relaxed/simple;
	bh=N9uR98yXNs5KB5/f4ZmeEMdWhEPvJSr4tS8Zew8+sSw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Wo96Jh7co0s9S5S+8B50GUYehHYiD3iMlRp9d4QxvCDqLyN8S6BdNYGbT8djkzj37evQ2tKdbHidxoog76SPewbTbaM+uEygH1Jx1CpUp+l5G+FnN6B8EnBMsCPD5TXXXe0ZscCFUgdtO5ail9HzrUTv+aYqRcnzA31mJVPTMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ueVioxyj; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-41b4bf6ead9so1528208b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752873738; x=1753478538; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JXAPwF0LYL0fWlGzUDFZv1Tx2pY7hr+gzK8mcCbzuRg=;
        b=ueVioxyjGAOPCIwOwj5y9z/kd7eXUAw8rlqr0u+KSSFPkYKKLTsz8AR0UbeEYKX8Xu
         Y9MMiz0nn9cm2G3d/qEuudy1ocND0a57kgwmNOaC5zZtaDx1HkOGSgGHPZN4VS7f/LMo
         Q2ckyyZmPEC0yBSeky5o7wJtGOX+y47ARuwIyFkbmtxJlZ6NKbUbxJChLICHs2H4LZ6E
         XRdmmdgEau16gywm08Q6YbszcnBLViXt8VWmoUbeH27LEaVEfyncpl7WB7GYCZJ4DLjh
         42/9ox8fU2Oq/JNcDiiHTXS5dIz8QOInxpTPsd9Q1/6GFV1E0eEITB04HoBo1+c3nUa4
         HsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752873738; x=1753478538;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXAPwF0LYL0fWlGzUDFZv1Tx2pY7hr+gzK8mcCbzuRg=;
        b=WdJMFKPGN46yWjQ9nbBhlY5ohMXZ5UT/bItWI5iAJrBjzerd2AkxgHX913yKJcd5fJ
         mO+9nUmqCibD6awQFLOpTPwZzCbE3u8kMuGgbwUYtdZd5y1G2dINF7P5yc5rEe454qK/
         X0WdWZ7djs96svBxohOUNWvTG7+Vj+nDuGwlB6dFHcqTCPSo0mE+BstWVADKHMIAVu0z
         fokWgsW0ZMTZ6/tCtWJ2moMUg/HYDLtVqPUPAsP7Vvfvk9br06Pq4WqXBUf3JOM+nFSW
         zUHw722IT519R5ojFk7vDAsKxEipZk9KbmRCenr9rlhTP2kwpYu3R8MP2F41mGidqgv5
         K8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWrCz1iZx5Lsv27S6Isqjf9FDdQZ90sSURlQ5fywsK1veBx6ViZB9ccEaJABaZVGymKB3dXJzKRAAs5wc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy7lke5sVzr0UZ9RxptgCIF5QFIKGam8hXVXNIbf5w25fwM0/i
	zdz59JI9aT3JTjwMeUjAxKNIGvTapxA/9ydyeREYPW3mGnsifj7djsa5tInbY68u2YudXLW0lmg
	uK+pI
X-Gm-Gg: ASbGncvSNsM+iGPM7dv0oMxM+RDsa+L+dWmqsFBZeW3iRm3KHgQvrC23cuPg6AVHX2x
	AwC3c9cxQYL/26ZdqY+MT9dHaMRV1N8JWBWT2UzjCS8cyLmk/cErCYsKjmh3NqjBYqR02A54l/N
	Uzw4Y+/BtUIKZiumEkZ/kjityXMTuuSZsGkl9m2g4BpdZBY7OwCecxLHrzfonT7VgbU2CgNh9fx
	WRx/5yu0DH5H8g5ct3zWNkYrVH2owY0SUgkfL685G6GjTUngLAgqIFSqWIp1os1SQ9D2AUXdWcF
	xFydoC9cnwq66Gq9tLN/cwG9Srzy4SPDGPnz4M4LdAXXo9wt82YLy9EC8xHmABsBRC0j7IR5htl
	cNxo8LIGQW04=
X-Google-Smtp-Source: AGHT+IEndzum4VB8B8UC3k1gRZhi4Ec/gRg44iqGZ2544M+GbzncYZLEIkBlxtCSHtft8KG6Ia8oYw==
X-Received: by 2002:a05:6808:6a82:b0:40d:f3d:cef7 with SMTP id 5614622812f47-41d032fb39cmr10072122b6e.4.1752873738224;
        Fri, 18 Jul 2025 14:22:18 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1fec])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-41fd5465431sm749285b6e.37.2025.07.18.14.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 14:22:17 -0700 (PDT)
Date: Fri, 18 Jul 2025 16:22:15 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] gpio: sysfs: Fix an end of loop test in gpiod_unexport()
Message-ID: <747545bf-05f0-4f89-ba77-cb96bf9041f1@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The test for "if (!desc_data)" does not work correctly because the list
iterator in a list_for_each_entry() loop is always non-NULL. If we don't
exit via a break, then it points to invalid memory.  Instead, use a tmp
variable for the list iterator and only set the "desc_data" when we have
found a match.

Fixes: 1cd53df733c2 ("gpio: sysfs: don't look up exported lines as class devices")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index f31adc56bef1..b64106f1cb7b 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -927,7 +927,7 @@ EXPORT_SYMBOL_GPL(gpiod_export_link);
  */
 void gpiod_unexport(struct gpio_desc *desc)
 {
-	struct gpiod_data *desc_data = NULL;
+	struct gpiod_data *tmp, *desc_data = NULL;
 	struct gpiodev_data *gdev_data;
 	struct gpio_device *gdev;
 
@@ -945,9 +945,12 @@ void gpiod_unexport(struct gpio_desc *desc)
 		if (!gdev_data)
 			return;
 
-		list_for_each_entry(desc_data, &gdev_data->exported_lines, list)
-			if (gpiod_is_equal(desc, desc_data->desc))
+		list_for_each_entry(tmp, &gdev_data->exported_lines, list) {
+			if (gpiod_is_equal(desc, tmp->desc)) {
+				desc_data = tmp;
 				break;
+			}
+		}
 
 		if (!desc_data)
 			return;
-- 
2.47.2


