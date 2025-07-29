Return-Path: <linux-kernel+bounces-749285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B469FB14C53
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC74754654A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778F42877DA;
	Tue, 29 Jul 2025 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z0Mwb1NP"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF5A28A3FC
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785400; cv=none; b=Q2sTFXH9WboWzfzrdecLcDJnEPioSiwSKVouoRyrVWyDPY4RcT34jY7If/igY7X65WmpyZxPOWtO3unneNLOZTl+mVMnTSvHxnDCJ+y2Tto1LTw7BVwELR2aEEPg6Ft8n+2kkX7L9CJbLe5AX4o1RcwRvYv8q7jfEQt7usKNfGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785400; c=relaxed/simple;
	bh=vbJJ56VU7p92Dn6IGl4obLt5d57ZoN9r6yd+NE7p+Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVH4AAzNbHH5VPilSsIuB5OvlW1inJXnhxyh3VSvCfZ/gq/nuB3egTgxqsfHG+4X8ll5T8nT2fbLBq+6tj3mAdu+OSMPIsY7frKMiH1/xAHP5aHFirMPhEVIxEG0PfogcfVu0VoHNJUd7tenwZj+2npwZXmRjr4oxsFvkEa7D6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z0Mwb1NP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b78b2c6ecfso1053430f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753785396; x=1754390196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILZsmFm+KaxI485jnWnzugD9ziJLMIRNNh5UIMPlOzk=;
        b=z0Mwb1NP26m1ooTa/067jD3gtvhVsjtYJWNZ42Lh5RxFAgSLeNaKWgS7soTwz9FyKl
         U8zh5hU1kJequWxvHtN8BxVyhywsFxE0+le2aw4h41jEPb+I54AIBtlnvlpFlTgOu8Sv
         5nLA9O54B9HZVdGJepNzwKWZ9iWRDrej66ReK674vsRp9AFLjwoGkMeQQhxZD0LNa907
         kxGfJo3UcOxXvr5jCoEOZoVifLuig/26+a1fO1pvLbyevYCeB5JQC8Sasua6arFuiM9z
         FJL890w42oLDePUhGZnh7tOKmTO/rwj/ItS8K7qX7OmroJWWJBulXzEvrLsXTwTfgVWH
         vbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753785396; x=1754390196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILZsmFm+KaxI485jnWnzugD9ziJLMIRNNh5UIMPlOzk=;
        b=QBgo8yJj7WIPmnjqXqrNr6FRL4w2vaz8pFEhtSa2QrO5pTaYDCZUc7Z3jUZMfegaRO
         oZXK/4NEwNxbMgiTm/SO02dq2/55gmTynzhsbhoBWtj1Va0FBmh6ZkzbP04K2OEGgxbu
         ySbV+O6VPrp6jaXD4MasqKKi0DUmBHcxX5S8+Y084rHh3ytEaan59mKI4L6fdW1kGczT
         W8orvIONJyeG8kx2bOhKtm14rgws5B6KQ6CW+8AmGEs/dIRJPsOMD/+Q61ufIlHHQVIm
         CZUroqkFrO5tkg5GGI0Efd2dWwCJlPjItlL0NtvTIb+KXn9lVgpW8+veSaLdg4Gx/pGo
         3k7g==
X-Forwarded-Encrypted: i=1; AJvYcCUZvRqnesaiADLF2tKbpK2WI1SSReKSQjMHbaysgf7vqMA1l4xv+gl65PFgTywSt8bLxazrMWck6+WGSF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSsYh8bbS0B94DwPwQW8AroXVCD36SmtkWS7OAN1ADC66Y5j9N
	0RBPi+92lQXeVIOPOYDG4XWJW/eClXDPMovpeQo1lbpEfkxgfO8R8zZlfToTwitRCkE=
X-Gm-Gg: ASbGncuA1NvJUcWoOKJYEnlDuxMwIMqsZPx69o75prOLMZE9hAgrjtEvmh83GBPXs1K
	gdPXZ/rmyDsxfkH8w0OnT+psP8xlZAtMTZpzeaqvITvBuhX3Ju37XVPNHg7R7hRzJlBvHQIAE4p
	58Ter3ClF3s93hlE4OUNRB+oZJHui066ak6LpiaEg0Y6Q+HXp1urStiex+AH0/vnTcG8s/aTO8T
	zO9oVXgIAmpAzLkYVcV5FPUFoeWxUnOZKq3hH7sp9x5HL45/9B3aBWzBxEJson4f9OiEKwUfCj8
	avYIKhnqXqx/32npCjWjQUWPpCM6ilaw5pUq7kmYx7fMiZPpqgjVGDThZp6189wuqK5yu7+QeWq
	NuxpodL2nq5IGjW///P2JY3doTSJF30xYBLpmbqohEac1gyhNkD/7yUJ3CJhiMquEfR+HtfuYIa
	0=
X-Google-Smtp-Source: AGHT+IFa/CFDIaAaH9tN7MNxbpnS3kOcobWhqvyDzNhQqLICbSJo5bNe1bjRQG5+K8fTlTpOov4j+A==
X-Received: by 2002:a05:6000:18aa:b0:3b7:9233:ebb with SMTP id ffacd0b85a97d-3b79233114cmr965649f8f.6.1753785396364;
        Tue, 29 Jul 2025 03:36:36 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b778f0c866sm11498851f8f.55.2025.07.29.03.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:36:35 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Jander <david@protonic.nl>,
	Clemens Gruber <clemens.gruber@pqgruber.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] pwm: pca9685: Drop GPIO support
Date: Tue, 29 Jul 2025 12:36:03 +0200
Message-ID:  <d975376fce9640c90ddc868e3722adeb83fff279.1753784092.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753784092.git.u.kleine-koenig@baylibre.com>
References: <cover.1753784092.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6256; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=vbJJ56VU7p92Dn6IGl4obLt5d57ZoN9r6yd+NE7p+Ik=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoiKQb9SqfmS4RnreDDX1ciLqZhHV8R1R8o0k2V 160jncMWAqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIikGwAKCRCPgPtYfRL+ TlnBCAC6Wopoy4dP5sNZ2aYzStnFhX1+7F9Z9If3RETL7v5qT880/SgjSEYL4J+84zyMtvZHMuj BzZAQvuHlFtGSeXUga8wIuws/aa7sUHGgqJae+l6CeF08Ph5NLsvP5n78J23gHo+qZ6VT2bCtq9 q/saNiFraYFglZSj5kMGfOPtwGb9WIgGPc4R/hM+8pbFQn7ScexGUjUva42fa3sV5dOPlciVrw5 poaRGbL5Tyk1pe+jazRTfXDscUN3XVlDEGxTpQEd45vELVXA80ZhaQAv/7N11NfqCpUJUm8SU88 7ZMp1cxNvJZHq6nyaPabI5UXDkwDYd90yw4HNx6rFbVudXE6
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The functionality will be restored after the driver is converted to the
waveform API as the pwm core optionally provides a gpio chip for all
pwm chips that support the waveform API.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-pca9685.c | 156 --------------------------------------
 1 file changed, 156 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 536a3e15a254..3f04defd3718 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -26,7 +26,6 @@
  * that is enabled is allowed to change the prescale register.
  * PWM channels requested afterwards must use a period that results in the same
  * prescale setting as the one set by the first requested channel.
- * GPIOs do not count as enabled PWMs as they are not using the prescaler.
  */
 
 #define PCA9685_MODE1		0x00
@@ -80,10 +79,6 @@ struct pca9685 {
 	struct regmap *regmap;
 	struct mutex lock;
 	DECLARE_BITMAP(pwms_enabled, PCA9685_MAXCHAN + 1);
-#if IS_ENABLED(CONFIG_GPIOLIB)
-	struct gpio_chip gpio;
-	DECLARE_BITMAP(pwms_inuse, PCA9685_MAXCHAN + 1);
-#endif
 };
 
 static inline struct pca9685 *to_pca(struct pwm_chip *chip)
@@ -217,147 +212,6 @@ static unsigned int pca9685_pwm_get_duty(struct pwm_chip *chip, int channel)
 	return (off - on) & (PCA9685_COUNTER_RANGE - 1);
 }
 
-#if IS_ENABLED(CONFIG_GPIOLIB)
-static bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca, int pwm_idx)
-{
-	bool is_inuse;
-
-	mutex_lock(&pca->lock);
-	if (pwm_idx >= PCA9685_MAXCHAN) {
-		/*
-		 * "All LEDs" channel:
-		 * pretend already in use if any of the PWMs are requested
-		 */
-		if (!bitmap_empty(pca->pwms_inuse, PCA9685_MAXCHAN)) {
-			is_inuse = true;
-			goto out;
-		}
-	} else {
-		/*
-		 * Regular channel:
-		 * pretend already in use if the "all LEDs" channel is requested
-		 */
-		if (test_bit(PCA9685_MAXCHAN, pca->pwms_inuse)) {
-			is_inuse = true;
-			goto out;
-		}
-	}
-	is_inuse = test_and_set_bit(pwm_idx, pca->pwms_inuse);
-out:
-	mutex_unlock(&pca->lock);
-	return is_inuse;
-}
-
-static void pca9685_pwm_clear_inuse(struct pca9685 *pca, int pwm_idx)
-{
-	mutex_lock(&pca->lock);
-	clear_bit(pwm_idx, pca->pwms_inuse);
-	mutex_unlock(&pca->lock);
-}
-
-static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
-{
-	struct pwm_chip *chip = gpiochip_get_data(gpio);
-	struct pca9685 *pca = to_pca(chip);
-
-	if (pca9685_pwm_test_and_set_inuse(pca, offset))
-		return -EBUSY;
-	pm_runtime_get_sync(pwmchip_parent(chip));
-	return 0;
-}
-
-static int pca9685_pwm_gpio_get(struct gpio_chip *gpio, unsigned int offset)
-{
-	struct pwm_chip *chip = gpiochip_get_data(gpio);
-
-	return pca9685_pwm_get_duty(chip, offset) != 0;
-}
-
-static int pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
-				int value)
-{
-	struct pwm_chip *chip = gpiochip_get_data(gpio);
-
-	pca9685_pwm_set_duty(chip, offset, value ? PCA9685_COUNTER_RANGE : 0);
-
-	return 0;
-}
-
-static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
-{
-	struct pwm_chip *chip = gpiochip_get_data(gpio);
-	struct pca9685 *pca = to_pca(chip);
-
-	pca9685_pwm_set_duty(chip, offset, 0);
-	pm_runtime_put(pwmchip_parent(chip));
-	pca9685_pwm_clear_inuse(pca, offset);
-}
-
-static int pca9685_pwm_gpio_get_direction(struct gpio_chip *chip,
-					  unsigned int offset)
-{
-	/* Always out */
-	return GPIO_LINE_DIRECTION_OUT;
-}
-
-static int pca9685_pwm_gpio_direction_input(struct gpio_chip *gpio,
-					    unsigned int offset)
-{
-	return -EINVAL;
-}
-
-static int pca9685_pwm_gpio_direction_output(struct gpio_chip *gpio,
-					     unsigned int offset, int value)
-{
-	pca9685_pwm_gpio_set(gpio, offset, value);
-
-	return 0;
-}
-
-/*
- * The PCA9685 has a bit for turning the PWM output full off or on. Some
- * boards like Intel Galileo actually uses these as normal GPIOs so we
- * expose a GPIO chip here which can exclusively take over the underlying
- * PWM channel.
- */
-static int pca9685_pwm_gpio_probe(struct pwm_chip *chip)
-{
-	struct pca9685 *pca = to_pca(chip);
-	struct device *dev = pwmchip_parent(chip);
-
-	pca->gpio.label = dev_name(dev);
-	pca->gpio.parent = dev;
-	pca->gpio.request = pca9685_pwm_gpio_request;
-	pca->gpio.free = pca9685_pwm_gpio_free;
-	pca->gpio.get_direction = pca9685_pwm_gpio_get_direction;
-	pca->gpio.direction_input = pca9685_pwm_gpio_direction_input;
-	pca->gpio.direction_output = pca9685_pwm_gpio_direction_output;
-	pca->gpio.get = pca9685_pwm_gpio_get;
-	pca->gpio.set_rv = pca9685_pwm_gpio_set;
-	pca->gpio.base = -1;
-	pca->gpio.ngpio = PCA9685_MAXCHAN;
-	pca->gpio.can_sleep = true;
-
-	return devm_gpiochip_add_data(dev, &pca->gpio, chip);
-}
-#else
-static inline bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca,
-						  int pwm_idx)
-{
-	return false;
-}
-
-static inline void
-pca9685_pwm_clear_inuse(struct pca9685 *pca, int pwm_idx)
-{
-}
-
-static inline int pca9685_pwm_gpio_probe(struct pwm_chip *chip)
-{
-	return 0;
-}
-#endif
-
 static void pca9685_set_sleep_mode(struct pwm_chip *chip, bool enable)
 {
 	struct device *dev = pwmchip_parent(chip);
@@ -487,9 +341,6 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
 
-	if (pca9685_pwm_test_and_set_inuse(pca, pwm->hwpwm))
-		return -EBUSY;
-
 	if (pwm->hwpwm < PCA9685_MAXCHAN) {
 		/* PWMs - except the "all LEDs" channel - default to enabled */
 		mutex_lock(&pca->lock);
@@ -511,7 +362,6 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_unlock(&pca->lock);
 
 	pm_runtime_put(pwmchip_parent(chip));
-	pca9685_pwm_clear_inuse(pca, pwm->hwpwm);
 }
 
 static const struct pwm_ops pca9685_pwm_ops = {
@@ -615,12 +465,6 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	ret = pca9685_pwm_gpio_probe(chip);
-	if (ret < 0) {
-		pwmchip_remove(chip);
-		return ret;
-	}
-
 	pm_runtime_enable(&client->dev);
 
 	if (pm_runtime_enabled(&client->dev)) {
-- 
2.50.0


