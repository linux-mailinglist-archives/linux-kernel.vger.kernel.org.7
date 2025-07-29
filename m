Return-Path: <linux-kernel+bounces-749282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E207EB14C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA07818A1618
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5141228A708;
	Tue, 29 Jul 2025 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3bzUXVXk"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D66273D78
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785397; cv=none; b=Tq1z8HHMtuf2IOp7XahYg3/hArPWSe+kQTWGbH0jhPkWinG0Ro55KJmWF7V+ZE8WyviM7qiQMtBLaLSoQudikJ4Y+FuSasdC+cR7wtoCRTlK0KMRUdLIT/Ee3fqynVGE6enXLgvlGB80o0mizJv7WbFOMQjlmgq2bR+0lEEVcB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785397; c=relaxed/simple;
	bh=vFkS3MCcz044w85i6x5Sg9hS8f9ssjZYZP9S3l0oUV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwpGghrSmgx94p61/aq23xAqrGro/CwreT8XJOaFNg5LDBY3/LNGiOf1C+kmen0L5nhJdLq4gTowWjQVZSGf1WTpvRuY4hs8jE2m0+PIveXjdLJlhesldLz7jdabc6cr9O20hSztvYr9F2IVnMP52iu+A0h6tZly+tDTiQr/6ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3bzUXVXk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4550709f2c1so42061865e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753785393; x=1754390193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7jjlbIUi5gdyqWR9uROLdSWPZjnUGwKYOi8+eCrVJk=;
        b=3bzUXVXkBdKFW4ev8y9adFFqwMtwmK6moQiLCAdHIptAOKAa7GteLDse9/Q8dX7Llv
         Ptxp4Q9ObH7LZeflnp6MZw7uEmmi5Aad2kA1wj/+iquBKNv+t1ZKzKWb3C44XhYtf0t2
         EmlduSgtL9bCcUlS5VzTLU0gGYV/HcKy8yMO/JMXjLN+XZSdSN7m3EQqkj8+t+uAYJLs
         mbh44q8uVn7m3Hk6ARqrqVIWZyr0FUsSetbJUlUAggw1D8AiAlFcDzZ+oQxkl+fACsJ+
         qA+XRKaOAhJTpSfs6/U8Uesyp78Neu5dKhsSJSduKlYn5rNJGz76PtmEPfXrcVDZP/0h
         N+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753785393; x=1754390193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7jjlbIUi5gdyqWR9uROLdSWPZjnUGwKYOi8+eCrVJk=;
        b=oFouTXT+eMtE+lXYcEZ1J4j7hSWO9fkpT1ZPG4/iCfYnd3wRX3bR3G6KBRjEThAEiq
         SoMCd9a1slmJCwPdsBHHv3YpSnaPVwAoM+BCQ7Woc7A2UROKc952F0MqvE7O8Ogqachq
         l5QnZrEs+cM24Bxp5nZ4PUAEcg/Eu8ERPJOcnkykS/bJx3Kvlysd5dpzCZc8jyLQHRgW
         ZhT7rs4TfiVRBCjXwcxx0Ffji8MP4qVG8JI3CIKI2AB84DXhe48lKZnBWZ78s9tntV7b
         eS3FD8BZPY61+sBIJUoXf/JefgGsMJ2E4YepcWKW5IyA1Nk7KgpjkAwSx0wL+1iPpXDX
         i0tQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+73NcnnnZy4evWmmBwu+0WSvwEKBaIwRxCINMYxWaZzj1vwN9cmb+bQ0GUO4M6ztVQu1D3KgsZAUgc7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBdTWn4D4pga6NthIYlCVc5ELpyqK/KZc7YcBDlanWtGuJ5MQ+
	tVAyMKNb8N3hNbgn6TEADWYkRhiLnofO+H4SgK7ZsPg02Wb0Kvrgc9YGc4b3QHUQcO8=
X-Gm-Gg: ASbGnctpIx3ry6uzXViqVdb/JqRBE4ximBfl8geKi3qDNMbr/BLZer9BgDcpXtl/sH0
	CeT8VsUInfOMrLPbpL+mBJaS+AgH8of76w/iei7p7hh05v8pf/lv2i0TfgiekTgfLy5HGj9wSpG
	/vCrf3lrw4x5wNU/FIvn+FI110Vs8dzGIj+B2cOtcSDkLK41qImXHyxZfHYcMe2Mts8BRbO6yw4
	TdbqquwnK9z5GaWKrBQcL0R5O40xBoLwVsP7wUGbWg1aIqae17bOhsKz9gtkbsIKZIG9wZ9KSi3
	7/XB2u6KiclyP89yf0mH3zmc8OAnIBNYkjWXsxDmhtnpoOczXIOaCTSSaufbF6xfrojSQI40iOR
	QqvBNGfWlSDCwhbWuQqOQlxnY/wx1VE1fWiEsaxoqd8KINRVCyYcMoD8Ti9IQZw8OvgDMJ0FssY
	U=
X-Google-Smtp-Source: AGHT+IE489WzUw79++E6gpy0AVRKNP0OEKvG0wlAV4wlHbkf4ZyMvxG7le8uPm/54WoWsYCi2U1tXQ==
X-Received: by 2002:a05:600c:680a:b0:455:ed0f:e8ec with SMTP id 5b1f17b1804b1-4587c828227mr104851665e9.9.1753785393456;
        Tue, 29 Jul 2025 03:36:33 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4588d86f1basm14853635e9.0.2025.07.29.03.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:36:33 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Jander <david@protonic.nl>,
	Clemens Gruber <clemens.gruber@pqgruber.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] pwm: pca9685: Use bulk write to atomicially update registers
Date: Tue, 29 Jul 2025 12:36:01 +0200
Message-ID:  <bfa8c0267c9ec059d0d77f146998d564654c75ca.1753784092.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4024; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=vFkS3MCcz044w85i6x5Sg9hS8f9ssjZYZP9S3l0oUV8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoiKQWeJfvL02YkeNuhdb3nFbQJem3gmbhqK06N skiqzjuh3qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIikFgAKCRCPgPtYfRL+ TpY0CACdPgmKq0PzScj3jiGMLo8lamDzzLLZOz/G4MlOknxDQDIz8iJkKeWKlNtjOU33ecu9PeI jgp4YtGjb+ai5aiCmgqqfo9d1/kcVIgDYMB0N8keYJNRLaJOaFyaDq8I2wy2TP6EFNeyieO+6Xu gDxeSlpc5zBH7OpN9yCz8KgEzyXedOOf8pSMtwLc1bN6h/qFw9ZhonPKQuFbwyzkQCePOHvUNdD GhbTxvHrXGthKx0txJ10tjfdkWftWjCMv5NKosO2Izmo3pBb59Z3WNkVDT5dBHJIc/cniSm3SIE M6U1asG2zV8jn7S13FjUe1wlTnbY7qQ7T0KflFMNhxoI2P2Y
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The output of a PWM channel is configured by four register values. Write
them in a single i2c transaction to ensure glitch free updates.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-pca9685.c | 46 ++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 41eb8e034828..75cf10f2b269 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -61,6 +61,8 @@
 #define MODE1_SUB2		BIT(2)
 #define MODE1_SUB1		BIT(3)
 #define MODE1_SLEEP		BIT(4)
+#define MODE1_AI		BIT(5)
+
 #define MODE2_INVRT		BIT(4)
 #define MODE2_OUTDRV		BIT(2)
 
@@ -131,6 +133,19 @@ static int pca9685_write_reg(struct pwm_chip *chip, unsigned int reg, unsigned i
 	return err;
 }
 
+static int pca9685_write_4reg(struct pwm_chip *chip, unsigned int reg, u8 val[4])
+{
+	struct pca9685 *pca = to_pca(chip);
+	struct device *dev = pwmchip_parent(chip);
+	int err;
+
+	err = regmap_bulk_write(pca->regmap, reg, val, 4);
+	if (err)
+		dev_err(dev, "regmap_write to register 0x%x failed: %pe\n", reg, ERR_PTR(err));
+
+	return err;
+}
+
 /* Helper function to set the duty cycle ratio to duty/4096 (e.g. duty=2048 -> 50%) */
 static void pca9685_pwm_set_duty(struct pwm_chip *chip, int channel, unsigned int duty)
 {
@@ -143,12 +158,10 @@ static void pca9685_pwm_set_duty(struct pwm_chip *chip, int channel, unsigned in
 		return;
 	} else if (duty >= PCA9685_COUNTER_RANGE) {
 		/* Set the full ON bit and clear the full OFF bit */
-		pca9685_write_reg(chip, REG_ON_H(channel), LED_FULL);
-		pca9685_write_reg(chip, REG_OFF_H(channel), 0);
+		pca9685_write_4reg(chip, REG_ON_L(channel), (u8[4]){ 0, LED_FULL, 0, 0 });
 		return;
 	}
 
-
 	if (pwm->state.usage_power && channel < PCA9685_MAXCHAN) {
 		/*
 		 * If usage_power is set, the pca9685 driver will phase shift
@@ -163,12 +176,9 @@ static void pca9685_pwm_set_duty(struct pwm_chip *chip, int channel, unsigned in
 
 	off = (on + duty) % PCA9685_COUNTER_RANGE;
 
-	/* Set ON time (clears full ON bit) */
-	pca9685_write_reg(chip, REG_ON_L(channel), on & 0xff);
-	pca9685_write_reg(chip, REG_ON_H(channel), (on >> 8) & 0xf);
-	/* Set OFF time (clears full OFF bit) */
-	pca9685_write_reg(chip, REG_OFF_L(channel), off & 0xff);
-	pca9685_write_reg(chip, REG_OFF_H(channel), (off >> 8) & 0xf);
+	/* implicitly clear full ON and full OFF bit */
+	pca9685_write_4reg(chip, REG_ON_L(channel),
+			   (u8[4]){ on & 0xff, (on >> 8) & 0xf, off & 0xff, (off >> 8) & 0xf });
 }
 
 static unsigned int pca9685_pwm_get_duty(struct pwm_chip *chip, int channel)
@@ -543,9 +553,8 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 
 	mutex_init(&pca->lock);
 
-	ret = pca9685_read_reg(chip, PCA9685_MODE2, &reg);
-	if (ret)
-		return ret;
+	/* clear MODE2_OCH */
+	reg = 0;
 
 	if (device_property_read_bool(&client->dev, "invert"))
 		reg |= MODE2_INVRT;
@@ -561,16 +570,19 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	/* Disable all LED ALLCALL and SUBx addresses to avoid bus collisions */
+	/*
+	 * Disable all LED ALLCALL and SUBx addresses to avoid bus collisions,
+	 * enable Auto-Increment.
+	 */
 	pca9685_read_reg(chip, PCA9685_MODE1, &reg);
 	reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
+	reg |= MODE1_AI;
 	pca9685_write_reg(chip, PCA9685_MODE1, reg);
 
 	/* Reset OFF/ON registers to POR default */
-	pca9685_write_reg(chip, PCA9685_ALL_LED_OFF_L, 0);
-	pca9685_write_reg(chip, PCA9685_ALL_LED_OFF_H, LED_FULL);
-	pca9685_write_reg(chip, PCA9685_ALL_LED_ON_L, 0);
-	pca9685_write_reg(chip, PCA9685_ALL_LED_ON_H, LED_FULL);
+	ret = pca9685_write_4reg(chip, PCA9685_ALL_LED_ON_L, (u8[]){ 0, LED_FULL, 0, LED_FULL });
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret, "Failed to reset ON/OFF registers\n");
 
 	chip->ops = &pca9685_pwm_ops;
 
-- 
2.50.0


