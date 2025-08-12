Return-Path: <linux-kernel+bounces-764720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193D2B22679
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09E35630C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02182F0C6D;
	Tue, 12 Aug 2025 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tmOD0cKN"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C2C2EFDA5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000778; cv=none; b=LRvpqCiCp9vfCJnxUuobDyvNGsGPzzBklMIBfX/gQ4hZZSq/bTHYwYc/FLFvuJia3rOjPunq93HGLOgubjWFhO2pfkYDUR2eQoKWa9sBJ5iCpEUntRUnTrXNI5+G+3PshvXrSMNR3HcAUZ8b+Ev/m1Fo1wGBfb+k3RpQRsxLrBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000778; c=relaxed/simple;
	bh=gsmPjfJ2QmHUYm2T6GbsR3/AGbz0mExN80EXjsadE2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bpDY0C/fIL/7jKqB4vS9RPt45boZew27nH2+HhFo7gmxFyScx2rBDQNCCLS7fxE3BebgndLoYjAlr+uFWpytKg4m12eR1TTRLfU4S2L7SFMT0DhKMkPEIw7nl1TWMxN79V4KeO+hYeCAH8/NEjXLGBWCTuG1TQ+VeBUIfwOji2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tmOD0cKN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45994a72356so42715235e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755000775; x=1755605575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1M2z9RjV0ZuXBRlE0vMWSKVCPkQUD2amGo6k0F1OlA=;
        b=tmOD0cKNTd2GSZossG7W7lMCci1+TigzwNrda7LpLrCwhzY7fFWVE4VwKahnE6e62p
         zrB65+/ok+ATWuodMPjXN7AgzMt4JO8YTamGoyMaT5YuPnERaQ4AnAt6OSzu2aApN4Kd
         lYGyFGM8cHH+P5BqRjwYt5CS10ftBAM1cubdmUGbxa1PBUA+SDXcCldZZNkRwO+MvFps
         oJX/shfhHFLM/mFJhFumzfH/kyFxarNbjQhkcpuspSLEGZ7uA9XKWdscRSUFGd5m+lzw
         5wYBbIaoYl8TzKvjBczJGwBrIr1+GaVbDCwh9MoaE4mYLRzNE1XxWD+N3FK4wKoEMjhR
         g4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755000775; x=1755605575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1M2z9RjV0ZuXBRlE0vMWSKVCPkQUD2amGo6k0F1OlA=;
        b=hDvivqE5Kgc48xCyN1gppfz2zbov8N7qCIcnP5sn00Q2aPWO2jl/g2iBrvKEvACILo
         dYmF1YuIMxYQDkczBllh4x88PkBKN44Tg9RtnNZ43TcA0ZfBAGG8YuG+83JNuk15Nwr9
         fkAV3nuFu5aJbMFqdzS26VqMqunU1wykjGrW/hZxfxeRH8JNAIqJbyd7XBeDvqgx7JfI
         NDkoqQ2xsDXiAcyXA5EUTh/GlzpZFqUmgVVlGy/tKgj+/p55tgWe8xO9h7TaNUL7+6js
         PHrr8sNAudAYxcyoI4jdrFgubG2PQPUiIbqmrKzFHqUzUWSxDRonGSD9v3TrBwTgjR+i
         QlYA==
X-Forwarded-Encrypted: i=1; AJvYcCX2cJsxQbXdHlNli3zTCKMmMv83oarC6LGPUvGOQvytOYqUs4HT50uU6apySQBeEdd9avW5ZwR8ccA9zDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuy+B969qHzmYujhgYSl2peVzwiX4Xr+FRuYj2w8mix2rtqn9p
	ozVPZebi1sNt6SDejHlQCFVUEjFu6ct3ogSsLIqI1iXT9K46F9g+8Cp1tZlzzJvdR3s=
X-Gm-Gg: ASbGncuGqkYFrn+fK6JdKC83LYqW5C5ewZNiM9mPgYoVFg/pY42ruLMop84OhvsLf7S
	fH49lp6cPMVixQrsjlJnW+TsmqBYe5k7lySUroVbyRgVcM+wkUWn9riR0ZbcZe/CX14z/cmFxXO
	Tue0+dXgQLz6nZXpReIJxAS5fQ3gUczr1s9N2xtfUpjxJosG54jLI/IegwwFDGFH2zRxzLNLCkq
	Yv97Nk7jhoxMblhtkNw5k1DEcPvXqcCCR7NDqohZZVxb1U1g/nP17pXQSUrquOQBxu9f28YqDuU
	vaJhBy/QFOh6SVR8rxUtcmOKvUzDSJwUAGTOKPsHPfLJ8YErq99XAubL3ktULFOjqaSx9A0qKFD
	GBevLLSXsPof2Xec=
X-Google-Smtp-Source: AGHT+IE2LcKw8rjS26CcRnR5lLe9kyK4DWUbNSa945JYdSNP/FB2BhvPQUNxmFpnWH6teI1ZO0UI8Q==
X-Received: by 2002:a05:600c:8903:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-45a152e2fb4mr2926755e9.10.1755000774439;
        Tue, 12 Aug 2025 05:12:54 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:16c8:50:27fe:4d94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e6867193sm298878535e9.6.2025.08.12.05.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:12:53 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 14:12:45 +0200
Subject: [PATCH RESEND 03/14] gpio: hisi: use the BGPIOF_UNREADABLE_REG_DIR
 flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-gpio-mmio-gpio-conv-v1-3-aac41d656979@linaro.org>
References: <20250812-gpio-mmio-gpio-conv-v1-0-aac41d656979@linaro.org>
In-Reply-To: <20250812-gpio-mmio-gpio-conv-v1-0-aac41d656979@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Hoan Tran <hoan@os.amperecomputing.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Yang Shen <shenyang39@huawei.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=LGZlUs6AQDs8ng5Nn7ommqnFHh3w6/vhUJqzq5JniBE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomy+/mio72vVpANuTm+f6vM7UHBMPRPfzU4rJg
 eqw8jyheiiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJsvvwAKCRARpy6gFHHX
 ck0fEACNnQ0xuf1zm0bcXc4sWxmEp3tOkYyBQwtaCRBVqm/HoJdnPpkSK8qx0sulRperBpUkNKK
 C+RTJqLjVPlBJmnc0F88+P++7wbHardUSAhVj9bC9h4e+lf9fcOiSDQsmJa4W9fqdWgDA0Gxd2f
 yhOz+mAcQP93HOFDY2MQLZ0tuY6fjqv64hcXPht55HbMvAyVMHpJeKiibOLNXxvSuMKLzxptgRM
 PGuj+Nlwkalow2pp3vkHb8jm58K/8KCpKCb6oSCjSSzTRjNI856ZSB6ckSto8L0eRQMwtw4wTUW
 7tCIju4zu/Td3Z+p4Mdmh/SopuNCI8t8Y7XNUCJCpDhOMpxZ5dr1dkM9m265yvFAHR5aTgk0Bdq
 g/fVt1H9CiOPYaXS+uyc2YiTs60HSk9M6H5QVPhBtD9+lIUF5nBVEBVFwjBwvmVHYG+kRVs7luw
 JUCFCGJ+y2PXHazzlFdTBCDORR4iKWzBILE8rK3aJ6pAdB8ZG5qg6EL/jPlZ0lPrCXitueygA+U
 ErK5hxEzYcROEe8Qz5TmJUczRD7mVBcMXUxS86DRP3O/b7LRLzADpow3ioCNF4JzsN3C3fVYMss
 bb/YtS29AtLHA3JTMY0wMwm2puAbX4ZFUWo1wb5NvSm+pox6Hi1As5vNk9mtc0n+l9ViWu3Viu1
 pDQc6mC+42cYmJQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There's no reason for this driver to touch the gpio-mmio internals, we
have a dedicated flag passed to bgpio_init() indicating to the module
that the DIR register is unreadable.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-hisi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-hisi.c b/drivers/gpio/gpio-hisi.c
index ef5cc654a24e2327510b872563e68fb0b9aaef71..6016e6f0ed0fb80ea670ebb575452d9ec23976fa 100644
--- a/drivers/gpio/gpio-hisi.c
+++ b/drivers/gpio/gpio-hisi.c
@@ -295,7 +295,7 @@ static int hisi_gpio_probe(struct platform_device *pdev)
 			 hisi_gpio->reg_base + HISI_GPIO_SWPORT_DR_CLR_WX,
 			 hisi_gpio->reg_base + HISI_GPIO_SWPORT_DDR_SET_WX,
 			 hisi_gpio->reg_base + HISI_GPIO_SWPORT_DDR_CLR_WX,
-			 BGPIOF_NO_SET_ON_INPUT);
+			 BGPIOF_NO_SET_ON_INPUT | BGPIOF_UNREADABLE_REG_DIR);
 	if (ret) {
 		dev_err(dev, "failed to init, ret = %d\n", ret);
 		return ret;
@@ -303,7 +303,6 @@ static int hisi_gpio_probe(struct platform_device *pdev)
 
 	hisi_gpio->chip.set_config = hisi_gpio_set_config;
 	hisi_gpio->chip.ngpio = hisi_gpio->line_num;
-	hisi_gpio->chip.bgpio_dir_unreadable = 1;
 	hisi_gpio->chip.base = -1;
 
 	if (hisi_gpio->irq > 0)

-- 
2.48.1


