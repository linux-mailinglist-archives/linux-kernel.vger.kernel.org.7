Return-Path: <linux-kernel+bounces-786415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7B7B3597E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4110C2A659C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F290322752;
	Tue, 26 Aug 2025 09:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EBIMWzaW"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C208131813A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202087; cv=none; b=rpnYZOXGtM3LwPH2yQj37SQUYf28BVE2k1vye0oXE96hPetmo4vtNe6a7qoH39X7cxzQjzayzzPlnTTK2vt3wqUxMqEggbZb0y/AThBYUDd6xzlAOyNqGe0i0K+u9xIQfrdKt0YcgLhWWJ83oz07w2UMa7K4nDC9c3/8miSjJ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202087; c=relaxed/simple;
	bh=CjedZyIKNMMMuPAne4ckGf14fUj8WSZo5DQuAPPyWdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g7PzCFyrz3Aohx0iumGyKtSiJC2uWP2liIEHfY2lq/b4fWsUP9SamVs1JDNt5zLJZHKHuDhwdFtQTdamdqT292G6zAMeZ5E+h3tbJA2bpY+HhJdiJ8vZxpwebYjCOs7jB+bsLoLdnBPbgnFrTh2zYQ2l3W1p3owRqjoeq56BOXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EBIMWzaW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b627ea685so11635615e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756202084; x=1756806884; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q67A6dEiGrYDiWG1Ph6/tY11Zd+/g6UDAqeQXHMdpI8=;
        b=EBIMWzaWXDn6l1el2mtV5Qa8oDCxZhCTYdhcrzot1siuDFaVZMjfx/TiBDfT37XsFU
         fjZHkPKHL2df5SlMSgsuo5jCIXExbGEgZTgu5sodsRnoTdvTmkN/Hq6iFnsUN5blFZ3U
         bcc8QYB6f6tiPMIWWcCb6VUzVEVISRz/Zom134OILZtsrYD2Zb27j15gdRpvXwxJITkr
         VtzvXgubQTXYxiOlMUz32/VHMtmwgimxeZMjCf1pgW4YI9hm9/BHDvEaDiL+pwss26Du
         +qiSS2KEXF2AxbymsBOMpqm6vXH3LZksYn8ZAHyQ58xsNK0YFGpPydEroLCS0X5pAltN
         Uerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756202084; x=1756806884;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q67A6dEiGrYDiWG1Ph6/tY11Zd+/g6UDAqeQXHMdpI8=;
        b=GVtsrI3lzDLxkwQgnblEt+4OkyHSxcSa166yLRH+jVHVziETzX+zHWVulSc/Yyo9cK
         oNTLzJ9CH9kvPY6SdTyIuhFRYmFh+ocYeYB1/+MOxLdhThl4YTseLLLviW2KqR69OxiY
         QoRB6b54Uuop7qkWdKz0qwSRHNYpOhwCTWzUMHE2GM2vKDmPKVDHUBiPRfYbWitvINNN
         kPDWcTvC6dUe13vMUN4vsdd/RSH2Fjccly8aDRmmseLLAe0Qhh0WLwGd07fDibuS+mSw
         pdJPWVPILu7WP49OZPaReTs20w1FBUXMceYdknYCFJtWK8UAZFAZtdBvfCaZLRh1OYCP
         9zdg==
X-Forwarded-Encrypted: i=1; AJvYcCU6cg6QY/NY9oS/LepuWpMi793PUARy0Q5d9ofoCaQ+eQO9N+NB/SYUWXX8+nct8MqFwZOSwtsaVxTJvtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7qPcuVSPfMRy+H9Z1h1xJ0CjqGR85YNf9vosdVD4cT8uU+7jk
	0FenzNh0kja8pcaw84znfHIzsn0ZP108fPHvoWr0i05LMMslfNUvHDgY6F773q9O/N8=
X-Gm-Gg: ASbGnct7I6jwXtL96B8FZj347ao6BHSlQS8eLdl3aReAj0gYJBcgMFlmwYiGzxwLiPR
	3qT4HHcicgxQ4IxFelnYP022v4KEDpb/zrRDkcx3kwruYOTwgA25LAIzLdXGEcc7Mksq9T7zCm1
	eSGVjmJgwmTHFpN6FYLTKVixd4wYpvpjc05kr8xM+oiwPRVfX1IR94gjl3XxnNVfIh7wRSHhzNn
	kWEvsjkzPhPZV11RBZpdM0jC9Ep5Ybql9Rek10x3G2XzJlTo4kNm2c3n1s4h1DLbJnYDVe+FUdT
	WzekLHWgcKUXIvOEJsufmo49zFZKXNGkrKLKxYGME756qpGBjHCaC9Nr/BKdUbquF2Rptoh+Olx
	vDyv8iyNx/lMt1/eR3Hf7wVi0IQMk
X-Google-Smtp-Source: AGHT+IGbWWgfy4oVGNVw2G0/m0zq0IcbBhHudnTL2tazbGOxJcFH5HyRp6Ol0cIcccqIvQx6y5xP+g==
X-Received: by 2002:a05:600c:4747:b0:45b:627a:60cf with SMTP id 5b1f17b1804b1-45b627a62cbmr53835625e9.24.1756202084036;
        Tue, 26 Aug 2025 02:54:44 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5977sm15708447f8f.51.2025.08.26.02.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:54:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 26 Aug 2025 11:54:35 +0200
Subject: [PATCH 1/6] gpio: stmpe: don't print out global GPIO numbers in
 debugfs callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-gpio-dbg-show-base-v1-1-7f27cd7f2256@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2113;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=po0oP7+JqvmBUahZ4Cqs/cpV/Mj5xJP4shR7qEp8+ho=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorYRgPBjr2HKTi0bsdoQ+b83BxncLsMVofdaqL
 bBCOoX3jOuJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaK2EYAAKCRARpy6gFHHX
 cjpsD/9JA2Mu641ojLPtH3ELxbd1lMoD5z7nrGO7pgXSg3MrQTP3xEwfO960EIqZR329r7Z1QBW
 kgEI1Y9ntL0D9F2svgaOi7m77AL0fTt6DRGpXOeR6mck2ggG23Nl6NR+iXkFRaMUsLMh24VLl7f
 +TREbodVkT0wQO7Cms6iqxY+ok9xpZxm3q/RU5cUzMGvAybGlwifBuMwsUhXR0XfF5Cw+GC49u+
 K/09nsJ74+pwONQQJiUtzozSB5D/dkhRLdj1qUrMUDd5ctDD73jO31BDAmIgG1VKAyftQ9V3Wlg
 03KcmUwnODwAbhoQ3SZUgr0he2NGnEGekLPUjxxvcbKlwL3V6b5QvtaO4OwehJBb27wcmBANz8L
 CH0u/KdL/FAiqpAxaTKFLj4sPdgha+zuZRQaf37umOn3j9zl/IXlGtyj+KtP+fRR2IjU9/kpaza
 ahfnJHw3sbyOOcFycHXrgEUIpB6lYk/AZy8tUTTiGCzHqma44jp5C3bJhZQeqd4Rq14wyTvxER5
 fLK2WVpD09m17FcOX+f9Ok071nbFOnedGUkbLlHh0RLZf+5zazE7W6ZgTPSf1edBzJ+inVhaYIO
 KdFZSLDzy7ovq9Zmi5AaE3NkrCBlTI7WJy53WCGnsYGgkrZTB6FS+PRfWjXjVXeFjBoFCJ34hB6
 UIn+EnuvmR2BIkA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In order to further limit the number of references to the GPIO base
number stored in struct gpio_chip, replace the global GPIO numbers in
the output of debugfs callbacks by hardware offsets.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-stmpe.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index 7bf270af07fe49e7a778e91134b5bc5e7d0a13a5..6faf30347a36396fe9ab14ab4efb7331f78e95e3 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -262,9 +262,8 @@ static void stmpe_gpio_irq_unmask(struct irq_data *d)
 	stmpe_gpio->regs[REG_IE][regoffset] |= mask;
 }
 
-static void stmpe_dbg_show_one(struct seq_file *s,
-			       struct gpio_chip *gc,
-			       unsigned offset, unsigned gpio)
+static void stmpe_dbg_show_one(struct seq_file *s, struct gpio_chip *gc,
+			       unsigned int offset)
 {
 	struct stmpe_gpio *stmpe_gpio = gpiochip_get_data(gc);
 	struct stmpe *stmpe = stmpe_gpio->stmpe;
@@ -286,7 +285,7 @@ static void stmpe_dbg_show_one(struct seq_file *s,
 
 	if (dir) {
 		seq_printf(s, " gpio-%-3d (%-20.20s) out %s",
-			   gpio, label ?: "(none)", str_hi_lo(val));
+			   offset, label ?: "(none)", str_hi_lo(val));
 	} else {
 		u8 edge_det_reg;
 		u8 rise_reg;
@@ -354,7 +353,7 @@ static void stmpe_dbg_show_one(struct seq_file *s,
 		irqen = !!(ret & mask);
 
 		seq_printf(s, " gpio-%-3d (%-20.20s) in  %s %13s %13s %25s %25s",
-			   gpio, label ?: "(none)",
+			   offset, label ?: "(none)",
 			   str_hi_lo(val),
 			   edge_det_values[edge_det],
 			   irqen ? "IRQ-enabled" : "IRQ-disabled",
@@ -366,10 +365,9 @@ static void stmpe_dbg_show_one(struct seq_file *s,
 static void stmpe_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 {
 	unsigned i;
-	unsigned gpio = gc->base;
 
-	for (i = 0; i < gc->ngpio; i++, gpio++) {
-		stmpe_dbg_show_one(s, gc, i, gpio);
+	for (i = 0; i < gc->ngpio; i++) {
+		stmpe_dbg_show_one(s, gc, i);
 		seq_putc(s, '\n');
 	}
 }

-- 
2.48.1


