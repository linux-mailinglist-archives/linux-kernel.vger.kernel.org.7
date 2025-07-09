Return-Path: <linux-kernel+bounces-722884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9057BAFE050
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E511884104
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703D127AC44;
	Wed,  9 Jul 2025 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EzYZ0x8K"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEE5279DAE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 06:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043352; cv=none; b=AAMbZlB50SwZJ1ran/qq6YETK3Y6IKNOx3eWfcSeTIilFJAuolTrmg1T9rdB7iTdIt6IB9MVRaoYCGzfwIbptDrgAx8XQBCWe/BiglLOfnsXQkYvqyY9M3U1q0at7C67Kz5yqbMqrU8avq9/GvISOZS8M2cZieZFgjv2McbA3TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043352; c=relaxed/simple;
	bh=vgZikG7Ep+QVUd5wW3DPZfI2mYJuJ/v++wBP5JlNjj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VN2jl6Wqw1V1DtZPMol32M3cBvewmjwycD+nDhXyIw+qMVg3wTeQacmnS1lQpzdUuuD8LtEBVR6zaCLGtmYNsZBAygE3x0ftm07i8vX3sSS1yNebGJTuBIRnbnrnajbsK+oaVcBfBqMaxJQJrtFLVwUvKnrGp4+YUjfjt+bBlnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EzYZ0x8K; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so59344415e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 23:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752043349; x=1752648149; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPGUhdmlwfDijB5p8c2jdqMRyyLRw0XzIvWRRxywz5g=;
        b=EzYZ0x8K6/FPXiWEoYVMOtMF+8wF0LfpXSD6ZbMkdaPL2HuKqzw3U8W23x3/G1+zSC
         RHRHiRSmJML1fuBLu0R1NFPAf7R8seDlMQNShas0CP/WnVyiRLv4HbZSLPBqXgWkZ0uA
         uTKB8ua/Q8DzCYTdYjySMLxhKczJyoODjZhNgulhhPW6ji7rzdLIhrrHsc4nWomlf1cx
         SCB0CxHpOwpf5q0r32zuLWr8RA/o2nmTBML7cGOu2FNMRyzVMpcTMmlLVVjDu49U+4we
         p8cwjD4pdUsDZTdA4ipQn5S2raNWsKhTmGJ2HXJgrKSDxHwGH5hwmAi4SFPmqyHG7vXJ
         b3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752043349; x=1752648149;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPGUhdmlwfDijB5p8c2jdqMRyyLRw0XzIvWRRxywz5g=;
        b=g6bOchesOAm/9E6VvfrrnyaVxb9YIb40sWNQq0NIMIVSvPWCsi3m6CykaHOkc7/Yoa
         bJGx0hV+P6mwzaVpX0StfJo5gxkC6V6aumKcG682N8xRLgWsTaDjjNe5XD/7lqPyLqIW
         Wm6A9Npuhg2EVAGV25rKRVRsOWBeMZh+B0upZwRLwf8j0POAEqkls/PLIopzXaQoOztO
         lZBUO4N+XfQJtLd07kbOHYDADGjefvMJ52VraJPbiJrpHLFRAPpAGjRmxfUazsqLLQZC
         DlgiePS7KVLqSm2H5tY5Q4tqHGJrblCQAF7Lw/dAg1z+10urdcQDyR+virRWXs4sTmsh
         uVOA==
X-Forwarded-Encrypted: i=1; AJvYcCUnBm/m2CKNfz/DHn2sYwYxhmCBuw1rfl+fEGrZvcEEKjB/+EH9fwA+lv5cB7AOJ8hOwsMEHM9B2KR+y4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRiceNOTJU7aVnmHkxvqeYMcbIknNmkfU+ArMKRfcyQxqP2Y2G
	WlGExVbTbUT7ko8HcC2q+TixkJOboESxh4xqeKk5Bkfe+9qkG7LKYEw2zlHn1bi1pElfDX54ah1
	iMQJv+Pc=
X-Gm-Gg: ASbGncsMEMEIa445Jvw3bea9hGp3vycdfaqvy4QawE0dw+fXzYd3PjP4meQdsNYkLwq
	g4QxVE/6A/ZZbn7FTnOhm9yYcOPe4T7MvLMJxDXowRnStHqQk1tly4yTIbxvdVuBpccnWcrAmPC
	unfeLVEUGNuW175ClaxGHcWhwWM4fVEMXWS+GNoi4EeUp31WS92X6qOFIGyfA+dfeB1tWdA6B7+
	OuKOgzMVRYhzC/lEcDxFmm2YTjfv1UDkeSg+Zac7wEO4oSsb7RdxPbBxOlO5IN6KbTlZbpSRL81
	M3SQMqCLs22qlehYC2hI7AjPvjcVlpSpqKQ4CSG4BHWSGz6TD2fbTiig
X-Google-Smtp-Source: AGHT+IE2jvkZ74rwtuTBLN0s4Szaycx+neThxKbyunEms3rb2frFFesUKJYspBXp7dISaXs9HS/W2Q==
X-Received: by 2002:a05:600c:1911:b0:43c:ec97:75db with SMTP id 5b1f17b1804b1-454d53255d2mr8934065e9.11.1752043349033;
        Tue, 08 Jul 2025 23:42:29 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b04e:cfc4:3bd9:6180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030c443sm15115341f8f.11.2025.07.08.23.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 23:42:28 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 09 Jul 2025 08:41:49 +0200
Subject: [PATCH 12/19] gpio: xlp: use new GPIO line value setter callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-gpiochip-set-rv-gpio-remaining-v1-12-b8950f69618d@linaro.org>
References: <20250709-gpiochip-set-rv-gpio-remaining-v1-0-b8950f69618d@linaro.org>
In-Reply-To: <20250709-gpiochip-set-rv-gpio-remaining-v1-0-b8950f69618d@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 Srinivas Neeli <srinivas.neeli@amd.com>, 
 Michal Simek <michal.simek@amd.com>, Nandor Han <nandor.han@ge.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=x5FG4U/gJyhRjJj1XtGDAFvboyuoHh6dqBdfJYy1RfI=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBobg9Dsiv5Ee6xWbG1tOxvjELtQVLwaBXfailSx
 fKyWGQWASOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaG4PQwAKCRARpy6gFHHX
 cksoEADFcZiJ30xLcfVWrKzRcZxE1q3PPoKP43SjyxcmuIi+zrZ+y3J0LisV+VlPko2f7Ph+Euy
 ZkoyRKhuRLBLJEuKWrCSbPCk72/wNJ+eCmeOJKewpEyBK2mQpm4BD0TwIan8yCbiJAPQ1/8r4W9
 iFfDTWQC9SxufumDbCAmrLcVogjijtJyVYw8pjfdxgFQWy8hfj2dJ6+A+IfZYnjSis928pwaWrP
 TgVXoZ7vBx3GldWKPa9hY3iPT2hl9/oS/nQpSszD3D/azPMEYsXbU/zQ8axfcp4Njw3WNRE2BUb
 3s2ovfGkB2LFIXazVw12zmDMVTREnvNUf2GzR3N3u7RueeOAa9wyr3f0YGrNLRkX0gaGnfOviC8
 nZ87GozcWVrc9RZ5y+T9vu4vUzLD0MBn+vh+1jciOhiW66Nc1Xe7WjAH2uShR0WNULKl4Hz3sD6
 zAVMTg49cvmhEypnXfwgi9YG39a9FO7Qd6iJXQQcSCVtwn8kD08g+HO9nNk+9pqMcCcYu+L4Lb6
 8b/c8IEAobs7tkOc3aO2QiUond9/n9Cb5i6QGVgthUfWd2SVeMtWYjMYa6wN1+X5Hb7ZxTtr1gH
 4pOz0ptwjPI2wuFqf0WZX6ahORlE+PPFtQESv55c01xRhZXg1eioM/ROW8Hjof4FbwqfEZQEVT3
 r4jRxEPJehu5fOg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-xlp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-xlp.c b/drivers/gpio/gpio-xlp.c
index 35b376c73ce312df1312ab09b53246fb5905152a..bcd2dfec462d0d25b3f97d682866ab035f207c3a 100644
--- a/drivers/gpio/gpio-xlp.c
+++ b/drivers/gpio/gpio-xlp.c
@@ -227,11 +227,13 @@ static int xlp_gpio_get(struct gpio_chip *gc, unsigned gpio)
 	return xlp_gpio_get_reg(priv->gpio_paddrv, gpio);
 }
 
-static void xlp_gpio_set(struct gpio_chip *gc, unsigned gpio, int state)
+static int xlp_gpio_set(struct gpio_chip *gc, unsigned int gpio, int state)
 {
 	struct xlp_gpio_priv *priv = gpiochip_get_data(gc);
 
 	xlp_gpio_set_reg(priv->gpio_paddrv, gpio, state);
+
+	return 0;
 }
 
 static int xlp_gpio_probe(struct platform_device *pdev)
@@ -272,7 +274,7 @@ static int xlp_gpio_probe(struct platform_device *pdev)
 	gc->ngpio = 70;
 	gc->direction_output = xlp_gpio_dir_output;
 	gc->direction_input = xlp_gpio_dir_input;
-	gc->set = xlp_gpio_set;
+	gc->set_rv = xlp_gpio_set;
 	gc->get = xlp_gpio_get;
 
 	spin_lock_init(&priv->lock);

-- 
2.48.1


