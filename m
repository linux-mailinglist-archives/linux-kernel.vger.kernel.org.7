Return-Path: <linux-kernel+bounces-798669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE04B42126
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E151BC1CF7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146CC2D0637;
	Wed,  3 Sep 2025 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kGFd976y"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81C246BA4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905551; cv=none; b=ZQCmlHw6bo1lf4p/0O1zSkXJJiFcDzzByN2M4zAGcYPFaM/bS+of0VjGz1p9wvCht1EMfxm+6r3e1A0yXriMTVBXBgcNGRiz4ubFALzxhY6QE6AtOiGPST83AMqa2gpK6wGN1csqpbbwb0xiCopb3fJ7qwTcmTBVzAKG38IIycA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905551; c=relaxed/simple;
	bh=AxnjN8HdcrrRJdD3Em5OxZHWI30slwPQxLIaH5Dm8zU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fy0b/zdHD29o2NpQBUR7oepjmNuBwk6ALn1G7Ua7mTBtVx9r8xaqz+Z90/D8HQN5pZ078wRbAmIV6qRpGGJ4tQJZtqkN1VzfOdW/huyk0pZIcwe/POBfo1mrBl8T7ZVNEAIPMrJq064E1MrfXmdbME30FyWgQRPSOI112gbIAAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kGFd976y; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3df2f4aecc7so340403f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756905547; x=1757510347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SorLujCi/8VwUy2DiiZuGVeG0//OIQh6/vMrgqY4imo=;
        b=kGFd976yp/IwUwTJO9WR3PD27Bv8MnZhhABRIXlDypzqZM2lTLId2agh2plNE4PRUl
         yjXoSFqLx8xz2kv60nbMMtw8XW/7Ath3vhE6YUgvWT70srfXk11kKnnxZsjwdkHLbjxl
         2FEtuekDmbQ8J7bIYwXZwXD29mG2Mrl8orb0YgPGXsHbFxdmD2NwMXIh3esRNoR1powg
         BzDkHOo6QKPyvgGBd2j5dlZmtDpC15uZPkMZE6D2bmIGrI5RYIyZ7tPM65VzCBVVcyVn
         KmGXshoSfZa/Msdh9nK2Ow0hlZiGTw3wTfndYHtoNTUYsYFLpTW4zANju/dzOZL6o+7l
         1z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756905547; x=1757510347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SorLujCi/8VwUy2DiiZuGVeG0//OIQh6/vMrgqY4imo=;
        b=rb7R+we/I5M+f3nzntK3gnVjhRnBjy0m+moOW/LJxhtlCM6LrwIQQwpg5b2pXT/LEn
         zakznIPYXyluOTg2E1K+J7h4iK24E6iz9aEgt1FyvhnfZt6mOphu+1ybM9tb+M74xvhO
         I2oRRAaKRTzwK6CoP4iLwtIsnRqUmzyloM1Aa3cHrk2qpS5swboKyzV0PED/Xo/piKNK
         JeRehs8c6Z7p1sroQQOp3Ds7VZeoU/ouLSzPAGD1rANx058JT2dGNDevsGPdOFtaP1Km
         R7W7/pXtUn7J6Rc7wv7cQ/3gIlc/LoBo9Xd59/illIuIV4twoya8JjuiZwACdZTnXiHo
         6OYg==
X-Forwarded-Encrypted: i=1; AJvYcCU3SAquR/XRKZrp/I+numUGBiRa0vaAgaIXH9w42CKU19pnPRA5zPGDfpEuiU/cWks8scCziDyeFnE/H9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvQQPwaqntOuaUL7WSSg+u2AyK2oBFEAFZdEctpeEY11MgD5A0
	XUKAnSWtIlfiR0z9WhFxJmefAGLZ9uysI9dDtlmcNq8pNHj93OQ289AgWGrg+/sI+caFrytTFo4
	g3caU
X-Gm-Gg: ASbGncsCe/1nahZbauIEO56Tk8PQhSvxL4t9Vc/Ji9Ye5nluCK7JIjHNy10wy4iMgmv
	QI1A8QWwX8rADN1hsOV+WI1xVoSF0Hu49YOzqCx5ftWX7LgdwQaBdTCFUhQjHAa9wKST7zVYrss
	V4TYGeNUY/E8VsooRbFokJNH+67F7XKQTWdEG6syNMTZoYRvrRqgOenXg/bfjKeKOV4b5uu/TBX
	QpJZ8qp7sXmD2LzrA4VV2/1+HOpB45SX8+CVmwhF54XKxrSSXTBPvDyBbMRk3n1vMyJMlrtRy25
	oCKZaa7IsWDtE7R/z8BI2hayWBf2OdJH1vGN5Agca5Eexb8icb+/eAHZ2LM6/Pse3EIofDHNHkk
	x47Y39bJ3w1H5ZrkoQQdIXX85A+Gl/L0i4/4=
X-Google-Smtp-Source: AGHT+IGknUG6HgigUOQWTunTcwtIb0WJ5XnoTsT77lsG/WciW3ylo6pBLCzcVEAz8Ytw/rgRDnZgiA==
X-Received: by 2002:a05:6000:2911:b0:3ce:f0a5:d597 with SMTP id ffacd0b85a97d-3d1e04bd373mr13481486f8f.47.1756905546669;
        Wed, 03 Sep 2025 06:19:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:2f8b:4799:6bd6:35df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d2393sm239486025e9.3.2025.09.03.06.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 06:19:06 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] gpio: nomadik: wrap a local variable in a necessary ifdef
Date: Wed,  3 Sep 2025 15:19:03 +0200
Message-ID: <20250903131903.95100-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The 'desc' local variable in nmk_gpio_dbg_show_one() is now only used
with CONFIG_PINCTRL_NOMADIK enabled so wrap its declaration with an
appropriate ifdef.

Fixes: ddeb66d2cb10 ("gpio: nomadik: don't print out global GPIO numbers in debugfs callbacks")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509032125.nXBcPuaf-lkp@intel.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-nomadik.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index fde4b416faa8..97c5cd33279d 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -400,7 +400,9 @@ void nmk_gpio_dbg_show_one(struct seq_file *s, struct pinctrl_dev *pctldev,
 			   struct gpio_chip *chip, unsigned int offset)
 {
 	struct nmk_gpio_chip *nmk_chip = gpiochip_get_data(chip);
+#ifdef CONFIG_PINCTRL_NOMADIK
 	struct gpio_desc *desc;
+#endif
 	int mode;
 	bool is_out;
 	bool data_out;
-- 
2.48.1


