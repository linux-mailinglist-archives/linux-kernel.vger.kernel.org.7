Return-Path: <linux-kernel+bounces-722883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4BCAFE04E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE1F1C41C1C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F366D27A131;
	Wed,  9 Jul 2025 06:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jUS8lG/k"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CBD278E44
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043351; cv=none; b=bWTJgQeIe+Iz5QyFSI6VOgIO38pDfmjeBSQ0+RvUcUhuolXJsi6HdsBBF+Kl7QvbzEJ1b/A4Kt4gD846wOpjsKmlAr4BKm/XiD9AHPPpfCtUb3N8jA0uJioQRWkouUfGXtlqJCEZpWF2ciVDVO+HBS0rMkPnt4C1SWfj47GK4hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043351; c=relaxed/simple;
	bh=eeXTDWXsCLZsGmbUhM959DTFljohJJ1sIN4OdUouAxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fZUkrB0ktfdg2qp5fRgPozafchrToJqCJ2CD4ytjf/tc4qlRVOD3NNQchlGarQK96BVNBL7h77ipFpdOln3Kvx+HmUzZVz0k9CRFng5lazUBAnh2BLKsOWmORPsnvSHPTDk30xJtd2QeGnYtWUHl03rHMxn/1VOfA3BbNv6/RDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jUS8lG/k; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so37208165e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 23:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752043348; x=1752648148; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dhsKsvAkmlFqPDEeR+UcQMmg9tdoZDeEXP7FO3A/Ni8=;
        b=jUS8lG/kWCSnLisQJsjslyLq4gdlZdZjwDltDeN00cMzSaDmn4DHgDsXLg0VKqWlWL
         +41k96VSthO72Wv2bxFnhX6+DG0wE1DRNPlvqzSPVnPr6ARUzQ8cnRC72m7UZH7wthTo
         78v7mUeCehAGfEWM5vEvUjp9KQphydb11zsjnVMD9k5BqMf7c3+bNBJRS68r8/Rb9elL
         Fd7SRsB1XDUczvWNp/LYUaQqheza/4JXFxiiJOEwcuzbzOs0n9kvoZX4usaJ+xzZ9xNn
         9J4WnFzOUL3i5j8BZ4Bt5vwLsEJy+DBKvI5gdaKC+Fs31iAb/5IqD7ZwONrESkCjiJKW
         iQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752043348; x=1752648148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhsKsvAkmlFqPDEeR+UcQMmg9tdoZDeEXP7FO3A/Ni8=;
        b=tpwDsm1HHizvYkk9jcEI7ojX019JUsonpz7OdfILQeJEhd/RgBheson/kREV6I5eLd
         yoiODY8xu3DFW+O7/Q24T89fd+lXYPGvp5sCpeIRJkTO/hOvxy5jvJdUVc9H6BbjmoUK
         pM0vCNedGtRkmy7O/rxx/CWwnO/dcmRtNxyopUVlXsTOOitnM7/NEUQVXfr/7KgtkE2t
         K/GDnUz4O2YP2cQfsMsQnwtE9EtKH8dsRAuaTnndepwp4oPFLuRVWLXjArj4bdd/Q1Ak
         PkQWlKPCjYJNXpbBunPQVi2mivsg3d18uOs8RPkJPbYnFbMZ7f/C4my1vngi9hoUISwj
         Z6Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVB2hKZmes7L7G7FjsOYBuhGgOcnTKF/UpabTAiMz8hg4ykh8NksjJJRQkJZKJ6iqSdfcLXBgJBZoUeDMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/fw4mn5TQ2187QU9X1tDeTUx5fkKpLib7THZuhEDf++gqvZlx
	yKKx8SSw6XJ8mC9nXg1izM2ooSgH40YqqoNTeV7h3K71D3rZziyCGpERAzalNGq00/1+EmggkAS
	879Ye9J8=
X-Gm-Gg: ASbGnctR5OQ/FYQdDds+pHjC5cuuxBOPitoXCn2O12d0ZIhKEQY0byx679JBtpM+mw0
	i+JDU7hixOAyuOAAMD0hcZ0ZrHENLiEvecbWLRS73Iq/Z0YI4XYe5bdkEZRi1uRMlZBFb8vT3co
	Q1pWTyCBcjvBfwE7UhVLlLuZpxw6f9E3oCXRd4dKmqR0QUTCTCjKifEEOE2icVt3/+5DuhIoYA3
	0goTBSdVF1w9V+jzB5XlK6gIHtHfxsFpRl09bb+Fqh8K63ri1UFBOu4VWCEzCJH4NfunNl/dO3B
	F+jm795fG9SAjGZJexWyhlOvLJM1LbiI0lH26HleK4PZGDxpaLRXF47f
X-Google-Smtp-Source: AGHT+IHvpRwL4gyNcss4buc5DbhMISzynWRKsNgohlceWdvTYfvFhoREEpevOPy7ECuUPWfEmr8Qgw==
X-Received: by 2002:a05:6000:4387:b0:3a4:e4ee:4ca9 with SMTP id ffacd0b85a97d-3b5e44ea0d1mr816440f8f.23.1752043347689;
        Tue, 08 Jul 2025 23:42:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b04e:cfc4:3bd9:6180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030c443sm15115341f8f.11.2025.07.08.23.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 23:42:27 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 09 Jul 2025 08:41:48 +0200
Subject: [PATCH 11/19] gpio: xlp: drop unneeded ngpio checks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-gpiochip-set-rv-gpio-remaining-v1-11-b8950f69618d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1526;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=kX7w+JHvWpXIE/MJI0TmNI75597pjwhk48BNek2A0I4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBobg9DjfalZzeUGBfvdwiGcfrZ171d4K3z9JFGc
 uxBWTNkcxKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaG4PQwAKCRARpy6gFHHX
 cotWEACQjbypuFIfdv3rxgS/QD1bm4WGA6KiqvpGj8xTu/C56/kieYtnc7vIzCpcbeScl1T8lE8
 EAitfkS8VLZ6X2UR1nfUyg659eVi8I38KWSCHuxFytaTF9kecqmJ/+OXroJ352In/zKzEFTEfX3
 Rz3WZocW6SdN2vBZaHNUHowmW6h+dRPwrOG9kDgJfduROKO8DTwrUFexaQ1oNahowRxAwiq4BF/
 3Ggo5BU45ewhQpE/xmtKlm1aDtXa2S/xRlfLPlx9aqLeapxAkB5DafjOpWPHkmvMYzjapLiJXQV
 LUEcoCB5t54gENH5mC+sszT2zgyzqGUbWCZDkIRHGji0wyACb1EYl3y6KIVzQxvBySkDL3/B2V9
 eaODg64UDmLTuxh2KnbJU7/opDLQcH+N3h6+2p6YJtwxaFajmW4YLmocqVWPdzllnZqEBy1Mycs
 ao8riuFbfo0wZigCrF48i/d7I6Q2rI+dFFY5TDIlg/OUpz70d+Ruw8SZ2K5YioyWR6ALBTnFG0V
 +z6JEUf9RhOwjc4YAra6bg/uJDbnNlRzvRwsadNg0w1tgtsyS8CAkQKJxi8Lw2jcjxxjAyNlhEQ
 P83OszlX+c6c+eM2yrfpeHs9l970j8D0wETvrH0O6EvlBpH1noVcT1+Gd9Nq0nyz2PUOIrqdVSs
 prGuwSQDyS2j30Q==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

GPIO core already makes sure that offsets higher than the number of GPIOs
are never passed to controller callbacks. We can remove the unnecessary
check.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-xlp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpio/gpio-xlp.c b/drivers/gpio/gpio-xlp.c
index b4b52213bcd955c3644b4410c2684d77951f03f2..35b376c73ce312df1312ab09b53246fb5905152a 100644
--- a/drivers/gpio/gpio-xlp.c
+++ b/drivers/gpio/gpio-xlp.c
@@ -206,7 +206,6 @@ static int xlp_gpio_dir_output(struct gpio_chip *gc, unsigned gpio, int state)
 {
 	struct xlp_gpio_priv *priv = gpiochip_get_data(gc);
 
-	BUG_ON(gpio >= gc->ngpio);
 	xlp_gpio_set_reg(priv->gpio_out_en, gpio, 0x1);
 
 	return 0;
@@ -216,7 +215,6 @@ static int xlp_gpio_dir_input(struct gpio_chip *gc, unsigned gpio)
 {
 	struct xlp_gpio_priv *priv = gpiochip_get_data(gc);
 
-	BUG_ON(gpio >= gc->ngpio);
 	xlp_gpio_set_reg(priv->gpio_out_en, gpio, 0x0);
 
 	return 0;
@@ -226,7 +224,6 @@ static int xlp_gpio_get(struct gpio_chip *gc, unsigned gpio)
 {
 	struct xlp_gpio_priv *priv = gpiochip_get_data(gc);
 
-	BUG_ON(gpio >= gc->ngpio);
 	return xlp_gpio_get_reg(priv->gpio_paddrv, gpio);
 }
 
@@ -234,7 +231,6 @@ static void xlp_gpio_set(struct gpio_chip *gc, unsigned gpio, int state)
 {
 	struct xlp_gpio_priv *priv = gpiochip_get_data(gc);
 
-	BUG_ON(gpio >= gc->ngpio);
 	xlp_gpio_set_reg(priv->gpio_paddrv, gpio, state);
 }
 

-- 
2.48.1


