Return-Path: <linux-kernel+bounces-722882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A97BAFE043
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA4A37A92BD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C097F2797AE;
	Wed,  9 Jul 2025 06:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sLLQdMN+"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0095276024
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043350; cv=none; b=XYDUtANHtXTHiE+vnGbRdib1r5Raj26WqK/zYhENiqgVtMqMzCVlYjkonrk3pzfopHHQ2NvqpOASXs7SUoApelKT3FodAu5v895ph3aHuo3MCjkDswg4StxUats7wKfDEwitaUuY0nIZgB2X8nFdho4tI7ENC17kI1CwL2SK+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043350; c=relaxed/simple;
	bh=ad9DCTIDIG1HoGv3OWrphMCnqlXUD+s+6vvEtXdghAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K1ue2NSnzJfsmHmcgvuziM5KU8v78VMGPmhnnCl9rhoGwia/EXIw6lXOUVc+drYzmdvNCis087z1wI4buXtjV3vpxJaNGk6HR8smO6h/DAIsyZQa8+nKYYTnGCtH+t9+8tdtpuaZmWO79ZP6hnDnsysT78uXclyG3VmSEUy/dWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sLLQdMN+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so349363f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 23:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752043346; x=1752648146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tt1tyd2V2XXog5654TpX5Ey9biqwEwVKUDOprHna+xg=;
        b=sLLQdMN+BincdpJz2yJ5h+Hw9xRqvW7c9k5xXaX6ZTzI/IGxna885dSenj+4YJIHvP
         SPiza2XxSApCl2sUmW+jb2g5wfAS2M7DxDyRx3t9NyPZXHxQu5JGxlJdX6Sq8dMJg1NG
         b7ZfzPOz1HspeRNpS97T1XqFQxBJGtOSwRoUOtkHDFVfwBGoVK05Lo4vgRoZFPjTueBW
         SRGC/JA9Q83YQLfcvtJNqCOYgh3Mi+80IZQbsloBgxjMK+7g8HhSg1n8PMHwMGQXir/s
         Ca8zz1FPJ67bXC/wLP46Jrpg6N235M7MP7l624VZ/8gylMZRtODgrWU2jQhb/FQX8IJn
         pyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752043346; x=1752648146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tt1tyd2V2XXog5654TpX5Ey9biqwEwVKUDOprHna+xg=;
        b=przfLj/wiIydPEEn1LyZ3zL5tSvtReusxQlx3Fyv0VTs1sTJJGhBzaLbbJzRzhSlE5
         ikmP8CPe3XPju0ClGHTfZe0xhB/sIiVNDsbWJ3zGmsour3LNZNyC+t59MNSH3KeHx8DH
         r7X8nWUFjWAetpiZGe+9cEoy/zWa8iPXDWmIty7K95nlC1c3oSDC4q2kDHYPxk/QLaHH
         ZPLySKJO7lolVF0RuqzS9Cv4165/ljcKepc3MQrnGym7W/8KjQf1Fli7iLkTzBH8efuh
         J8SDCIvvlq2pCUP14ejA67CkVp18ut2KgPbRvDU2j+V3/JFmzLDK3bikQnq+SJX36uA4
         u5pw==
X-Forwarded-Encrypted: i=1; AJvYcCVzBibepjRlnpuHYqYFkqhS2yjeh8nrJzl5Nd2IIcQ2TSDy+DgOwKWzTLlbIPwjJaBk+SZmCUCRunvlsOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDCsggbgSPQqHqAZCFkm6BhV+JqNbX7GAaS9wU0j8OpQ6nVHw6
	mG3BfXEezrZ84OyytRQU/j1BaRXR/kVUjDonhHEh2HvX6qgjtAyZWwP8FCL3/wfE7Dc9VSQNm3Q
	Tlx0xUkM=
X-Gm-Gg: ASbGncs5tHtBlpCl6WiWu8Ak7erKllXAQqid9YFllwkr9aOGgvfY/2lpysu5I+oH+Ab
	aDGBSJart9FkdWXpz0XLpL4G2eujMCN93U8iELd6ihrx/GbuxkdMxN0s+FIV8R2INCHjZsbVpWi
	AcNa2HJ2DqzOKnkVtDZISxWo6P5w4rtpolCKy4AJeMdTkXF51JK3f4dUVbElUCn+k0wLfF/6Mlv
	WF/5GZCRWU6VM1Kmk7Izeq/+sHl5J952M5BO6O3LRMFsvGWJ7QFS9s3FxwXhepd7yrcunixDXlX
	cmzRTw7YYIqD7p+IpNcwpIlVkj25GWUGgJLBl1dliNcc9sX0ashmtgSf
X-Google-Smtp-Source: AGHT+IHva0WhsywPttvRU08VnkKxXmjFcSCyLgh8W6d6O8qcvJcHST/EmQCRDTaYU3n47c8S3YTiAA==
X-Received: by 2002:a05:6000:4609:b0:3a3:6478:e08 with SMTP id ffacd0b85a97d-3b5e4494f5bmr774417f8f.23.1752043346514;
        Tue, 08 Jul 2025 23:42:26 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b04e:cfc4:3bd9:6180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030c443sm15115341f8f.11.2025.07.08.23.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 23:42:25 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 09 Jul 2025 08:41:47 +0200
Subject: [PATCH 10/19] gpio: xilinx: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-gpiochip-set-rv-gpio-remaining-v1-10-b8950f69618d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1599;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=4caU/UjNpZ2IdQFhAW2jpXfCzjS+1Tfp2bEeZ8+cvyg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBobg9CVnKQXMjtdHRDVguAejNFTXbTNXD8l/Kmb
 0yg+RrFm7GJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaG4PQgAKCRARpy6gFHHX
 cj5REACwOuns0WEq0gVfyFbzUJNtcYG3dTU1bFvtejpjQepJyTQ1QVwtA7TBbJfH+O+XnX66gtB
 1OfiIS2FNuQ4AHfxV7LboTF5hI8KSovydzIXZg5qSF9IVe7OpRxSPxNGAUCqD7lTfF33Cd90Q+c
 n0qSysZ2b87Crn+IKtlo4DpvhLae7AJvMItX+RB2jkn+G83L+aT7js214EuUz+C1tpIdj6n1ekb
 UNuybnnWCYASJ4Ow7ISTsfNiGGUDC4Yei49l3VVhUOBKtzyE5zMv2GxaS9l8FwpCxL4rHX7HzbL
 4t1ImuQA1UndA2UraMnoztrqLX0djej2yBwzwo3wTM53dwpWXsj7Y9JgOaBq8ylLmEVbtelV5pD
 riyAIpKwyvYawqYtwrQTOcNf0oRvRHMhCmMEW1QfqbAQcCEn7XXBF78kjj0nOKdYaijS8rXoAaY
 h2exh0E957oSjVG8N8BKMESWJI2IN7mdfWBf+8f0zr5kBc1xSVSpD8i4WevQZUI3E2/zfiOQ3f/
 I+cojRdDGefvTRIfXENlElRktzK9hA8a0pqrYUXXpGfZ84t5gVthoflduWApAuOF9Z+7RQtr3XJ
 Db3DQhlSzuuHlw5Y4uKbvj6NPvmJE2td0L4cqQTIVWrx2MUS0zuONDQ38BA2/GaLU8D/aOapH9E
 HkWM8Bc5jI66Ulw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-xilinx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index c58a7e1349b4b226057c6d045f901c7fea5da449..aaaa741179805d54e1cd1425579eb52a3579d6e5 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -148,7 +148,7 @@ static int xgpio_get(struct gpio_chip *gc, unsigned int gpio)
  * This function writes the specified value in to the specified signal of the
  * GPIO device.
  */
-static void xgpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+static int xgpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 {
 	unsigned long flags;
 	struct xgpio_instance *chip = gpiochip_get_data(gc);
@@ -162,6 +162,8 @@ static void xgpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 	xgpio_write_ch(chip, XGPIO_DATA_OFFSET, bit, chip->state);
 
 	raw_spin_unlock_irqrestore(&chip->gpio_lock, flags);
+
+	return 0;
 }
 
 /**
@@ -600,7 +602,7 @@ static int xgpio_probe(struct platform_device *pdev)
 	chip->gc.direction_input = xgpio_dir_in;
 	chip->gc.direction_output = xgpio_dir_out;
 	chip->gc.get = xgpio_get;
-	chip->gc.set = xgpio_set;
+	chip->gc.set_rv = xgpio_set;
 	chip->gc.request = xgpio_request;
 	chip->gc.free = xgpio_free;
 	chip->gc.set_multiple = xgpio_set_multiple;

-- 
2.48.1


