Return-Path: <linux-kernel+bounces-764493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9F8B223BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8F23AF89B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8BB2EAB8E;
	Tue, 12 Aug 2025 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tmIjmeJ9"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3135264628
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992352; cv=none; b=RXNzA8VHXc9MLUkkL+EKwC4dZYXuACDS8dPP3pEq4d5HpSGEoblFjejV2rTXzX7a5APhtCKfw5n2JHxbR8cImOXQNiAw+Xy8bBWduoRo5J2Kq5Yimi7OsyRlZ3JPDpXmUQKZSGPglAu7qzboTS3FEiPCAm5BNX67h5eDp1Qi9Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992352; c=relaxed/simple;
	bh=CjOqg/tMVuGjCBjMfchIIOcWxbiHZ10GFFMMWZMqLdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MecxCZSrlZzuljFbCB4Jg5HV9Ufz5pc2vr4Uj/Kv2GhLdU4YB8lta3nukgS/Aek/wyuqbjFn7RJuWtAvAm5sGWRxjoo1Cff/GxFQMMTuOCjR7UpEIS3c5/AsSqzf4pzHrB6OqzLCwgVwh7G13mWhdwRqKRqXgQPrjTAgBWvrbTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tmIjmeJ9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-459d44d286eso26931235e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754992349; x=1755597149; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEezOkT0DMYtBQNI+88wui4CFNSwtPL8noFajy31AHM=;
        b=tmIjmeJ98P8bId0dysY6tjXSjLE9Ws+Nc1P5yvqXUbLr0+NCy5kMpU7QhvLSRfQSFJ
         s9BSbkgr3mAxxKUv3xOEKcnJndHf2cfkC/pN8SvE6zUzGguraKilxlhTA9pip+wk5/TC
         Svjwf5ZelDlZSQ4PsDqyYQocVTfpSvm4OhQ9DO7h1GC+zqJFZTWbncdVq6MNsWIB3xM9
         THM2Wcm1hRGnoGx004pLJABv54k9FJTuisq5ZPRVI8qgAY47v97f7mxRmiDwm48XHTj4
         34t0nhecDXGK16PxE905tKPrpFS0ol+zibIeOUsjciQCNZuaI6jaAWohA1yALfh8eiHP
         RNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992349; x=1755597149;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEezOkT0DMYtBQNI+88wui4CFNSwtPL8noFajy31AHM=;
        b=szweEmqdSI9tJUfdmRMdVLdrAWfMrzyTRNW5pbgsXdCYmCarjz7LDaS7Xuo5K3IfIX
         lrwxBFE7HeTyeAfWjhDL5b3YkNlpfuRHD1b0pJBLUbd+j0V2oooy1QEwV0kZ3rDNJ7Js
         y4v+tvebDHEE33gGhKU+tAr75s5nbfBfKJS04bre8gAdXYBuyWWT108nIIt2W8iFbYH/
         W34xZF7HCxp3DXrRkgaZdAzhXvE/VKL14R7eFElWwiYX+OSTqGGf5IhzsriNq6tWsyfH
         rACgWdd7I3a9xn2dt56UgnzIv3QXWSscpFKzlvo0m2yUmC4FpL6wJN7uTdoF0VUpT9UU
         mSiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ14gwkbXhV+w5Xi97dTen9f9acpW94v+WdsHpjVeHuJZHWcPenG46edje4/cRPvVSeIyOPLCsotqF0M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfrAvbbK2xmWF/HiTntNM/UUVulh/X/SKtn7q8vxB/xroDQuh5
	af8NRVx4Rkpcq3sQvWpKjayTdV1kYKUAxu8Pha6FG8tHK4w6qu0Dq1qtumu12X8Mrik=
X-Gm-Gg: ASbGncuqPg5GLOHkENDMqzxQSfNt2y4ht0F8C8/8iPQIk08QVubVrxXnzvYD6c+It2d
	loJc+lBCc5FVRYL825rgcd4VL3rbhXv9nVi78ad0Fh6DUHQc6aWwB97Y1X7K0BXEStHcxvv5x3Q
	LsWAKxR1mxC452Xqbc76SXTKb4HfY7Rqo6kpd2SP0kMY6p+cGrfWJeDLKv2Ctuqd6BOqwdpf7vz
	TmWJIYSmVbe/2eKIgdKL7c1NPOzXxFOjBa6hZm/fVErWUfHh27wLOSHCYT154Co4600OWBFCTUR
	DKfL8rLenp76xq5nbR3XSw2OZqy59N0bBRiE9uskfHR4GpM9dbKwCIwPlz/az63glmev9z65t7d
	WlFHih0J2M2T3MImoar4SIfnovQ==
X-Google-Smtp-Source: AGHT+IHMlTWJIYSmrVv4nHMCQDUriTkj7c/K/tgN+L+KmxopYAfuvalo7DHTecAilNpRXOwvXfPrEg==
X-Received: by 2002:a05:600c:46c7:b0:459:443e:b18a with SMTP id 5b1f17b1804b1-45a10dad362mr25112195e9.14.1754992348766;
        Tue, 12 Aug 2025 02:52:28 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:16c8:50:27fe:4d94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e587e154sm312580295e9.27.2025.08.12.02.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:52:28 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 11:52:01 +0200
Subject: [PATCH 04/14] gpio: ts4800: remove the unnecessary call to
 platform_set_drvdata()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-gpio-mmio-gpio-conv-v1-4-9f43e95dea98@linaro.org>
References: <20250812-gpio-mmio-gpio-conv-v1-0-9f43e95dea98@linaro.org>
In-Reply-To: <20250812-gpio-mmio-gpio-conv-v1-0-9f43e95dea98@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Hoan Tran <hoan@os.amperecomputing.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Yang Shen <shenyang39@huawei.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=749;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=l19XxlCMzrhQb7segGk57h4S+g8U8d8cxgGqBJH6nF0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomw7GUepK6ewZZ+J6N2Dw1g70BlgPl9ljHv9BU
 tgefMYjfa+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJsOxgAKCRARpy6gFHHX
 ctJ4D/9aMoxs1l2GSsPyDnhyzSc7IwkViTAepGrUetHNYsUUQ/wdOaj4Uw5xkBZsfSf/xRuZnMe
 iKAPIqHP2VfZKUpqA4DYvtfbdNysZCmVZ1Ygck+LSYYrnRDdZ2niK9VY5JAZE8kPYAbleXoARhp
 p4bHmZpzFOH7zxZ0VFpeOVdSBzmzb3RMBiQENwuzubY9Ivq9TNir/umhW2c1TNc3+u3mHUf5Pr9
 7Pq7vXm+Qw9WfPibg21H/5xH4rPsLivx5yVZNbEc4MoqjNLie/fiytXOr0GD6ze9nw2P5IB/37+
 oztaO/MgcERiiu+xC9uJiUp9dkHreQwjiJtCt6KzQWCCPTqBSoiIbEoYy0+ipjo+oYo9OHOHuMx
 AClhC4sFmehVvzuby9BtLDqz/YbHF0jfUatsfgCjxFTGFhS23dTt3hFYz/xYNrl/bLWs6bKguxk
 Yg+MFoalXzuB1KvlNvTVNwpLnQmRon4xZasBnmWKPK7j7i183BcxmC6pbmzlzXri+yI12dKrmJs
 JnAP+CbQpc99EhOlw3XQDRHvbmrij9Vix+D+NZ/ggaWecB3/bt0uKKPl4si6qhHa+5R2+5iLNMs
 Y0f7k1N9wSxVPRxP/F5QrU28/FYhpRTAy2BBv5U3V7d7aEPJ6dGTQLiJNnjnSk8Nrz+bvEf3Kl8
 8Q+yjtyYH/gZ89w==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There's no corresponding call to platform_get_drvdata() or
dev_get_drvdata(). Remove the call to platform_set_drvdata() from
.probe().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-ts4800.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-ts4800.c b/drivers/gpio/gpio-ts4800.c
index 4748e3d47106cd2db6a994928b20f76921540a60..86f7947ca9b2d23292c1e6660fe93c611e0cb837 100644
--- a/drivers/gpio/gpio-ts4800.c
+++ b/drivers/gpio/gpio-ts4800.c
@@ -51,8 +51,6 @@ static int ts4800_gpio_probe(struct platform_device *pdev)
 
 	chip->ngpio = ngpios;
 
-	platform_set_drvdata(pdev, chip);
-
 	return devm_gpiochip_add_data(&pdev->dev, chip, NULL);
 }
 

-- 
2.48.1


