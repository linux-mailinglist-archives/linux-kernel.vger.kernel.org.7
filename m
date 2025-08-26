Return-Path: <linux-kernel+bounces-786417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AB6B35988
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F192A6CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB2332142B;
	Tue, 26 Aug 2025 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="N8vzcdQf"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A7321F5E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202089; cv=none; b=DFP1xSwjt+krsq74GNZgrlTuqBIANFj+PAR10ugNgTJfy2clKgox8sSGrspcHKHIBUuqZ7Hm2qzINFqtQUT4vCHEbLPSZzkJFlVQCNGk765D/FgnXZ84BthpgIBysC53xImHpIcRW9FikRQZJkS0LbpceNrw19KhZxSwu14DO38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202089; c=relaxed/simple;
	bh=+DluEEQpDv5mv+wbchOBlw1mfwuVuCWh3IvBbqKoweo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rLxYK85D3YClB2x2qAlrTsYj0uHWzrR74lm5+XOpcZhH/bFOrDVVGJkiDzQJ8RnemlY7gCmoKizc0R8OjViGDIrbhJfzKtb1MKbwVbZmCZiiaAsJdPll0ZY/B3uj2ag6LjLR9XM8pBG77bDwenv5TufyVe3dU5/Ln2g6ccn16l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=N8vzcdQf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c6743a10e3so2191500f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756202086; x=1756806886; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUzxj3AwlFMn/Cb4ZnmJ6RjeXFL5y1o/ilqQYnR/MVw=;
        b=N8vzcdQf2IFpR6d8nemE8YHYMaMb5riEZY6SC56BXU2y8gXzgGdZQIBzAsG7gaTQ1Q
         IzUDUtu4tvPYNiuPLrpzBokYpvXX7BwwcZaqZsOmmbbTRAFKPvGisFjL2WLvl7X7tW3z
         ndHdQRaoikB4CPOQEFd98OLWFJrPcgLk2h4u+CIarZivQCyXiLPyEChy/Ha77U5K5V68
         O8bU8C2n11bz8U0ZGq27jWo79E72wZHcEijGl2nhJdbx17as0BiG6zD1GYEUgL6K9bv8
         vAUwkrkBvOLtdrYez0rTA1El88u6YKHWQ7hpmEvxYqPpceLwPjQCWGFKdMr5ZX7BvQIE
         t5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756202086; x=1756806886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUzxj3AwlFMn/Cb4ZnmJ6RjeXFL5y1o/ilqQYnR/MVw=;
        b=EMsMbr+D+l0Z9Egq/V7ANMg08qSKYbyuVIyADUC6NXH6TJCzeCjRVeSv7DGkz92NA/
         LJYKJ6DP+UzhMA+2ggjtLlgnwR9p5RqBElPxI9v01GE4feuGzych/DIKE9eadOhob8RG
         9NecviQwR6axJBg2o/6sBre1WJlw/WHu4ggt9R31rE15Ssa/F4cCZi30NTAPix0PJ34e
         3l5vXRC3r6y4OXKWUH8Q+hW85BpLsjF0/oVV5ZSscL3zkV8oPpRSEVdsvfBjC2kvu7tF
         Woqhv02rbs3VDYC+JoPY7mnfrNkkmarcc5X4f0Hq8CFu8RWQz0HES5s2Qih+ZOtMiw1l
         MBBw==
X-Forwarded-Encrypted: i=1; AJvYcCXHTa9e2rvdxWpOw5j+U9k5ST+t3mIEsQsAhiYq6kSYi6tVyHjQzg9DLJQvghBBCFT84n5NdUuG2Cw/4Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGCXcr5TGLJwJtLAWrzGgIMiXXnD/I6oaXU4Lmp7yDYoVru3dm
	LNXfvgIbiMdXNsaex9cVJU6G30B3Csy3LpO1HiNS0Z4j2O9Xv9ou8KBSD7pM1822yHg=
X-Gm-Gg: ASbGncs5b8P7Ee7ZOsrXtz7Ce84hfMggmir9kzgtWNZUqkV67cvYa9tz+Fb987D+Xtj
	vAukmjOvgA7mXl9hTHbCYiUtuKg1wvaggDLLmTM/cQjjIkGxtNmnll98qB4OdXZUJHXNN02XZms
	yAqm9JQBJOGsRwkItkCBpNmk98kVFNQscEPP46AwgNMQ3xqemaok2GXT45ggOHITctLo0g7vkfh
	SwFdxOQdNnqsPg+ahgKYQQeErJe1Q/KNLHzRmbrTjBVQVcmCwLAUUQ6wSDX23m0UQSg0vvwRK+v
	SAZj392A6RX7acNV1k/JB7g/FpmTQRgQqFSnvVvtho0fMeHtZXMNJMYaphZhdeAmRi9M2Su5Qzn
	jOy9nJQX3NXcptfmWnw==
X-Google-Smtp-Source: AGHT+IEq7Pdf+yKsvkWm+MwW4ovsbwrrSZre17IZ6PflaifIEPCYnP/bAcdG3LE+PYHL5F83Vsr22Q==
X-Received: by 2002:a05:6000:26c8:b0:3c8:e436:a5c6 with SMTP id ffacd0b85a97d-3c8e436aaccmr5104411f8f.23.1756202086354;
        Tue, 26 Aug 2025 02:54:46 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5977sm15708447f8f.51.2025.08.26.02.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:54:46 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 26 Aug 2025 11:54:37 +0200
Subject: [PATCH 3/6] gpio: wm831x: don't print out global GPIO numbers in
 debugfs callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-gpio-dbg-show-base-v1-3-7f27cd7f2256@linaro.org>
References: <20250826-gpio-dbg-show-base-v1-0-7f27cd7f2256@linaro.org>
In-Reply-To: <20250826-gpio-dbg-show-base-v1-0-7f27cd7f2256@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-pwm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=0doGTq4jVCHH5hAlopIUV2rywiE5EAOXG6MofWNOqdk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorYRgPCC7iTt/8LaCLZ4zIye40qfjGVFVH5elC
 XqjSnKoEeKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaK2EYAAKCRARpy6gFHHX
 chxeD/0Z4DZnn9ZzUFJ05Yd1652M+GEyzC29T6CIFKaE/dlhyax7hUNfKtRHYE7U+/Spudq+OPU
 vJpWBxUSWpqDHubZ2+FPbYRFosDePbdOqRMxdp6PogyXJ6HA0eWV9lh/DRkC+YMUdAVFZkgHWCt
 EHFhnQDH9SorKiEdPmOueFadYPqipZA6k/dJTyGQBqAhZbymA0vEDlHdPZlIwzciFLnGrFaDEaF
 E4Mb5Z642juTfhqJTlMTtqqH4YpCM7hA+I8TehIxj3asLn8h03M6Uv/wndoaanBjNzP+3IVvXTJ
 MAe7b1pfQmMSdvjjcJCOJI1YJlkMfpzj9MT5QsNb3N790NaJqK9ADIUAyEBK5y8AVbK9fc4cQt4
 CKOND2GqpYC7JfJzlizaV7LUtlSDc/HCRZiZq5LuZYiojlL2MzexXaLVgbKzJaQwmtzRvLAJzDE
 Tz7aeHvkzd1zExLGalCuHKHq5VBgf8ER6svb5hI74wr9dF1MYN87PkOERip+qF0spc5T6TDwvO8
 JiUwldshiqUlKmLFe/jhOAeFGDSqFn7UdHbFe4oNKtPwQA5Km8D353wRUjpBGbc26wCZYou+zH8
 c6rkZ/kNTgnFo9mYAVMVY1J2JlFZf0AF6uNaP4/Ho19bN9924Iah7g1D96Yxentnt61AeCveARD
 tThXGIwo2MT83dQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In order to further limit the number of references to the GPIO base
number stored in struct gpio_chip, replace the global GPIO numbers in
the output of debugfs callbacks by hardware offsets.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-wm831x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-wm831x.c b/drivers/gpio/gpio-wm831x.c
index f03c0e808fab27349c39f9efc41e5ea420b2d03b..489479d6f32b3a8bcd7592e46ad61ec70794a2ab 100644
--- a/drivers/gpio/gpio-wm831x.c
+++ b/drivers/gpio/gpio-wm831x.c
@@ -159,7 +159,6 @@ static void wm831x_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	int i, tristated;
 
 	for (i = 0; i < chip->ngpio; i++) {
-		int gpio = i + chip->base;
 		int reg;
 		const char *pull, *powerdomain;
 
@@ -175,13 +174,13 @@ static void wm831x_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 		}
 
 		seq_printf(s, " gpio-%-3d (%-20.20s) ",
-			   gpio, label ?: "Unrequested");
+			   i, label ?: "Unrequested");
 
 		reg = wm831x_reg_read(wm831x, WM831X_GPIO1_CONTROL + i);
 		if (reg < 0) {
 			dev_err(wm831x->dev,
 				"GPIO control %d read failed: %d\n",
-				gpio, reg);
+				i, reg);
 			seq_putc(s, '\n');
 			continue;
 		}

-- 
2.48.1


