Return-Path: <linux-kernel+bounces-786419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D20E5B359A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC9F7B4A70
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9917831B139;
	Tue, 26 Aug 2025 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xpir+IF/"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7445B327790
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202092; cv=none; b=WAScUd/KzUGhx6tPnSn9rzniyspmWMp3V8ii8NHVB3bQH4/ekGEggWy9KmP3GKL3jABVujO1hdaP4qfCmc5jdiQ1wl7/NwQrVy9hwtlW+Ll94MVMsrc76ZUQbpVRA6jt7d9K4mvO816owioJ6778iXuZvLzYaKrV61pcF8VfdVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202092; c=relaxed/simple;
	bh=QD0kfyNxuvyOuW5PIlZnDrSaU1LLSm7x29aIhGnXwdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iWvOPGVW+aFwLwVubL8upyXlKr2J0HKjh0sdYs6rLMxgtOEZKsUZB/EzKDwLc4tE5kgaWoGEW5ZVLuDE8neVHg87F0aovdX1UgRoSnqc4oezcamRWsX0WmK4fyzD+aoj5Z8BYWNY2XZIerUg4S0Ea9KTUd+Fo1bVaO8pIKJjiGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xpir+IF/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b0bde14so28931115e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756202088; x=1756806888; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hr9ezDvbabWM+JIoWhpxzu2N2664G4DRU3GkdP0Hsaw=;
        b=xpir+IF/P1VyF1dAWPInLtIACb95qUdleoEP/tyy7uMk00q1Zmj/KangX/r0gzITsB
         OzGIcOrSzXDoG1NWc1yzc79qMJQCLaO2JEZNIbAUIz3nOraqwjBNK3mopVPfCSpUYdHP
         xzvUEEYfTtIWFkcOB6Ux6x1dneAPLeMSrzNhSBZdfy9Yt9YDpSfw1HyhlzyuWh6FaFAj
         KH3LsuNigocVXrqHCqlY+WrJ2rWys6KVDzv7W4PcVfGePteEIOiota1k9bKJdPy4/qja
         jenCHjs/wku5Q1mVCEc8blhKQOqx2MEGrB2TyjmK1uNlRw1ogg1ijQQAO+57QSHzFw5o
         6Txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756202088; x=1756806888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hr9ezDvbabWM+JIoWhpxzu2N2664G4DRU3GkdP0Hsaw=;
        b=XycM7k9GQLppxozi6hcBaooNlWFnQcNNewsGm2AfISXGVGxAZ/4kLu1jCmBIFHpWDV
         14ArtlmZgn9kRNlAVOF3EX6lqKw459O8UB87coDmE2TX1RpVNyyxJejMWPw+CdeCDnij
         tPIYQFss6cSDhElILZf9fmCsUJ1Nz4j2GRhR5M917/2zhjqfAJqMRhB4NllbUkgYb6Zk
         0FIojDNqabsySFs0Lphub/jLxNVauTrnlsDa/IRD5zzDbWLvf7W1i3gBCbrpekeq5Mff
         6wpu3JCDz4hJL9mygola3q1L6XH/HtzbnD+5gd8kBYZlnkLgcD1NAD3RA1JRrID7KMVs
         t26w==
X-Forwarded-Encrypted: i=1; AJvYcCXzDEEH7zPKWrUSCuaNBvpJ1LV5HC9KM+r82Mx/VfCPdiHBFvbH+wLWSxNO81jJF5xSIILNSUz3IfMNLDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9kmxMIS4W21Qnw0jUgRNXFNixykWHe9KChxOToke9I5jspk8q
	g3pMyLLS1t9ZhDMa9zd3DSw6n07bn2TEFHn1QQj4dgtKFWUwk7S7860kpQ9rKijjmlE=
X-Gm-Gg: ASbGncvlx/1AdB+VIhzVYHK0waBxr6/FUjLglOugkTLshxhDvlhR2UM2dTA0+TiOZAa
	hpxIOPVwovTO/jgtWRzdHBhVQCUa/wgamNspX0BTS2LQ9hR9ZpohFfzDiRtHlZnf6HtBYCAsN2n
	bAf7p1dQZer+hDRLDKZAh0iLq/P0El6GC+oAcCEQS6MQOEn0GRp3heNO20HCnAkPpVaxpvW7v0a
	tcEo/fp6i4KqbJoPhb4xIA7TNSWuDatKxcYWEwJ9dxuSySLX3uAHZ/ekVbfOjFxbTfucX3YztqB
	TOE76Ohb/jnYCvTIoiFBHno7lwYPZ4yo8TMOwWWIcu/2ZC6vPgyh7CrL/HFKAhAoxVG37CD3yqa
	1Dsf/+6vgCQ52ohfIxNqc3YnptIxf
X-Google-Smtp-Source: AGHT+IEbmQ0wfHfNzU9A3vt56aJAW/TBqrp+wvsnCIpOz+MxEDmOeIEf5KV7QmY38nQb25bnONIElQ==
X-Received: by 2002:a5d:5f81:0:b0:3b8:f2f2:e417 with SMTP id ffacd0b85a97d-3c5dcdfc643mr11727394f8f.51.1756202087749;
        Tue, 26 Aug 2025 02:54:47 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5977sm15708447f8f.51.2025.08.26.02.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:54:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 26 Aug 2025 11:54:38 +0200
Subject: [PATCH 4/6] gpio: wm8994: don't print out global GPIO numbers in
 debugfs callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-gpio-dbg-show-base-v1-4-7f27cd7f2256@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=EvQ1SYQWer3RkO4fMSasYvVhk1H3yin4vuMK3XRhqvo=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorYRhUQXOMPagC4V/EkuzJhJIamLzxI+KALqfB
 q+9XnyzgSqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaK2EYQAKCRARpy6gFHHX
 chyoEADLBUcH51ZCT1TXPLgWv7MXnlLoympGVuWzAFP9Pii3SX74H3kEVV+0Tmba/cDTVmJSNzm
 2TaTrIzWerfU3YhuqiLeRkzA/mvIQWWL54Gl8Q2m9i9Ff52r0rTdNiq06a02hMBGmfN0rP8koT3
 axInx/kv5tIUpzfUuWlQSzhfSA4A84rEw5exxvxFxzoradZcvjs+GLRkZrVwXIKpNVNDCzYcvSc
 TccxQGCFVYff0ZND0qqLyAWYy5gwO2LufjeBzw5GiY9cBhiZMYm3Xuw+MBJAXrApo+3LPwU9PBy
 tDjmwsNpbgaRCwQyEEGbR7C1ifbrZwzf/taYJA1u5BvEXbFrFfFVpANN23Nj32K0Oj0qKOPwfkM
 1cwDE+Iq6omUOPOh8Df4UPmMisd3PiEhH0p77kt3MjOoIbdJhi7LNWJKLg2HOrFQEGBD3BTMdUZ
 +8dK0PQ9QVJlenx3Ah02EY5H8G/yfhPdhQp0e6sy8tnvKW+kErc00iJ8monRSd5t6gXJGHs/oz/
 Vifi0VfWOAimS0AklTN8w2ITiOxsp3wi6kozrnyZCVBe40tGIyGhbA+MIAb3nk9xTvZY9/DTYWe
 4FrpxochWDmvq/SFr5tuIVd+69KtLXOdTFeZa5CrnFMZaKeHtyXRDYUGk5yU/+qG3JVi1OSegyL
 PsyR0iUxyMNOVbg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In order to further limit the number of references to the GPIO base
number stored in struct gpio_chip, replace the global GPIO numbers in
the output of debugfs callbacks by hardware offsets.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-wm8994.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-wm8994.c b/drivers/gpio/gpio-wm8994.c
index df47a27f508d94d53056bbe666a67e887637f516..a0665cf3ff2f45640cef740deca7712606791f47 100644
--- a/drivers/gpio/gpio-wm8994.c
+++ b/drivers/gpio/gpio-wm8994.c
@@ -194,7 +194,6 @@ static void wm8994_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	int i;
 
 	for (i = 0; i < chip->ngpio; i++) {
-		int gpio = i + chip->base;
 		int reg;
 
 		/* We report the GPIO even if it's not requested since
@@ -208,14 +207,13 @@ static void wm8994_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 			continue;
 		}
 
-		seq_printf(s, " gpio-%-3d (%-20.20s) ", gpio,
+		seq_printf(s, " gpio-%-3d (%-20.20s) ", i,
 			   label ?: "Unrequested");
 
 		reg = wm8994_reg_read(wm8994, WM8994_GPIO_1 + i);
 		if (reg < 0) {
 			dev_err(wm8994->dev,
-				"GPIO control %d read failed: %d\n",
-				gpio, reg);
+				"GPIO control %d read failed: %d\n", i, reg);
 			seq_printf(s, "\n");
 			continue;
 		}

-- 
2.48.1


