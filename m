Return-Path: <linux-kernel+bounces-882575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE62C2AC99
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B657718938B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C7B2F2909;
	Mon,  3 Nov 2025 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="b0z4p6g3"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCA62F1FD2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162554; cv=none; b=rcfzMNT59bUK73Qh2ygc2oEIsFd5COmkqrMpdgwRWxSrqk3DJjiKQvE/S00FisXXf7fxBFG3E0Kc1gq5CxMTCI56/twtFDCqx7ss00oxsSwFNRyvKCtKPVuuyc9XbvqCMCSZJWehIbqUdNfcICxjs/ugZICtaxSbKbWUjd+1urY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162554; c=relaxed/simple;
	bh=z0YSr7KrcAc/k0WngzdsyXNvl3twXbRlw/uwLjuKOK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dtqHvgpvOyxw2fYTvglVQ21qhkwb9q5sco4bJbnLpFGXaQ1SxGgqB2VNNiMXKkLankVIb1UkvKps9Ueb3yC7w0UCzdAvMGr+hRNfMwdEVin4g5fZBBEOsCpnsCEVIHMCrUm5WCPUznkvRvV55K5+kh/uIc+h/JSHRuKLKYpeO0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=b0z4p6g3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429c48e05aeso1295094f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762162551; x=1762767351; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fvp1VGmfGTlzha3gDCL6Cw0t8OXa3klcmoFT2A8KMRg=;
        b=b0z4p6g3JNUPxg8hAxGKB+l+vjI8QK3D6iKM/m+MhMW88WPRYed5O9bFI4AqptUq8Y
         aSDxlnV64lyF7jnaQMgFWG41TAMYY5/z4ocy64HIx7LgRUxvg77PIQWUSfJ4sYsaB8fv
         EyJNRtVN/B4c/fnuTS2Qf/TPj4COgjM5ik8KlSK34Fh6dawZqhpsJ1BIZE94fB6VhHSo
         WnYnNWB0O3scqvwK30WBEAJSmgEtdwRN9jTiMSYRfd0iB6+6or6XWw7TxYGIv/ObCjdt
         NROQVVESRNTOb1VXKF9BXoROhxUdL0ofdq1ukWl7afbXQ4L3R0x9HY08y4eRUUtf1Bri
         Zl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162551; x=1762767351;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fvp1VGmfGTlzha3gDCL6Cw0t8OXa3klcmoFT2A8KMRg=;
        b=sP4zT2bGOrU8NWhI/Pc52U/llqQ/ePEbvduCGOBhXaaCgkKhfDmjBuXj2aX4rZUjmg
         TMCnQ9FWCZ4d8en6WULoVAbPaw4HfSJD7tIvxyO5+Wm3Tx8rgv6Vtk1/2eE6EozRjxSZ
         lTGi4QMF6HcO8A5cHE81YVN6j13sWyvlNlud5JQKFyfVkgZlwpv1V3uELCNGf+AeGnan
         9u4JePlu5cMgL8KpTMs5ZYbUGH4GTy1IZc9Ey5VA0u4Cc2NEJSVK8ShfXU9rUH1qyy1V
         adqtGBauWpaOuvAwiRMgZpTQ2kxCeuNNRUuU1AktfSxuoj/I49+h2FzjUFXEq/dF2Kaz
         6TcA==
X-Forwarded-Encrypted: i=1; AJvYcCV2L94gsbdmkYJ1wso7CRpFk0vh8vMf7Q8Fws8okovLApId1d6kDnyYlzO2loLOuOWEgD2sjh8QDtj3B+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU0W/FuZMOD2+Vkxfhox8tqzF8tMQhmrqh+JyTd21d6rM2ZDcP
	uzzWPJfkPJkSuSNbbxSVwyboMWyraVxQt2913NwPdcWLeBjQWS3sQ8gsr88OciFLxhA=
X-Gm-Gg: ASbGncsQqphCkVJqQPlcZr12Dx8pyZqkdMGxekSntURTbYfl+sTeWwQcIEGM4qboEsx
	u84YBT1NHjiGE14n8NTpEkI+yD+dBVIfkM53BqUcDZwhARZJD8eYaz/cGx/rGGKwicUcrbiTY1Z
	Cd0znUMPQYJM7tQaxnt1NmNeVQfcfVbm+Sc8VHNymIx/qjC9AqkWnfuMfwl32rrv900TyZbiNrW
	K7jOBAJCDCgrhBNXNWHLx5WMDI9V2hdIkL9E+QmzKV6D5nJN7MyMgOSgS4v8nvDwqDA7GWr+0UI
	IsKzPI1K3BQNHSFTW1Cc0GdGkZ4eJWAILj5kGNwAf9n7d80nLbY8eJ7ucBRF8j2/AYUbgL1F7YW
	UWfzN3gW/2VmvuSeOyo9xajCVkeLvCMiZTB+68JoreliuqbOL7T/SkDH/1m2cAb7lMC/UUw==
X-Google-Smtp-Source: AGHT+IFqQ3S3CYZwWZGiMnZAuPwjhp/XDiyDZlbpjM1Wxu0aIIWefjdKsx+v5M34KYPoW6PDxxUowg==
X-Received: by 2002:a05:6000:615:b0:429:bc68:6ca0 with SMTP id ffacd0b85a97d-429bc686fd5mr10797897f8f.4.1762162551136;
        Mon, 03 Nov 2025 01:35:51 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e6eb:2a19:143f:b127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c4ac5d6sm147285675e9.8.2025.11.03.01.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:35:49 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Nov 2025 10:35:28 +0100
Subject: [PATCH v4 08/10] reset: make the provider of reset-gpios the
 parent of the reset device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-reset-gpios-swnodes-v4-8-6461800b6775@linaro.org>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
In-Reply-To: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3056;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=wbCx8dCgwX5b7rXFrK7TZvcGe4EfqUhDGU8MlxrqJm4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCHdmjaKONBp+ZDwctFnf8uPx6KzunB5fUw5Zg
 wWT/KtbtiKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQh3ZgAKCRARpy6gFHHX
 ch+FD/9tLKBeH+qBRy7BkvsAFMEbFnHPkMDgKjUcjv1AVhVI7VFeoJKKJWIFEtHTITKBIcTexV4
 8pAOVSbdm6beFGoZw0hFIto27EVZW+mIryG0c/MsGGKQ2Huh0kGq2d9F4fxDS1vNlJyJuJDTNqU
 HnMFacVNjWz5LUVyexDb/vCHlD6ZmWttOjzt73nOoNhvxn4qYyygFCuXTU7sgGxJ66O6YghLClE
 +GHtdR1qSwtQuvfwuursUuffU2OZQYy4NIwJOpRXLxVnRWjhv2cSBgoJklLQdnqwd8vtS6r+8SZ
 b2PsQbH1cBn+UC4dIZkdQgmEZyWfpIw5YdCU6a5dvKboXVFzxe32l4LUufGk1TMmirE9FC3oxVY
 YK0LjpoEcuuzxJIU25S/1/3fS6AMJANPW9V4J3xLlY5hpw2qZnFkg4AQqbWAlrSLfdx3J3ugWj5
 JY7Ef7FiXbf9arwakLmtLes57DCymO1SgXp0bOD+fs6xAdlM0H5IMQZRg1OuhxcO6SAATOQQ/uH
 0M732pDaQ9XFdJdMz8UHDpofGgGJlKdZxhjgzQznfp0CSmyIMA4ZeM1efd/Yr70OB/QFIwkbKeF
 YHj5AZt2DgAFut0E+m1ln17H094s/4Jk25HHtoFwP0QKGmiKdidw4M0PO2mRCXFk52Ja3qJqBpc
 AMsEHuu5xybJ7sQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Auxiliary devices really do need a parent so ahead of converting the
reset-gpios driver to registering on the auxiliary bus, make the GPIO
device that provides the reset GPIO the parent of the reset-gpio device.
To that end move the lookup of the GPIO device by fwnode to the
beginning of __reset_add_reset_gpio_device() which has the added benefit
of bailing out earlier, before allocating resources for the virtual
device, if the chip is not up yet.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index a368b14144e7bc29ae23becab2eb7a96a4adbe44..af42f4d12bbbfcba225219eac6d6c7edbe2405cc 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -822,11 +822,11 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
-static int __reset_add_reset_gpio_lookup(int id, struct device_node *np,
+static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
+					 struct device_node *np,
 					 unsigned int gpio,
 					 unsigned int of_flags)
 {
-	const struct fwnode_handle *fwnode = of_fwnode_handle(np);
 	unsigned int lookup_flags;
 	const char *label_tmp;
 
@@ -841,10 +841,6 @@ static int __reset_add_reset_gpio_lookup(int id, struct device_node *np,
 		return -EINVAL;
 	}
 
-	struct gpio_device *gdev __free(gpio_device_put) = gpio_device_find_by_fwnode(fwnode);
-	if (!gdev)
-		return -EPROBE_DEFER;
-
 	label_tmp = gpio_device_get_label(gdev);
 	if (!label_tmp)
 		return -EINVAL;
@@ -899,6 +895,11 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 */
 	lockdep_assert_not_held(&reset_list_mutex);
 
+	struct gpio_device *gdev __free(gpio_device_put) =
+		gpio_device_find_by_fwnode(of_fwnode_handle(args->np));
+	if (!gdev)
+		return -EPROBE_DEFER;
+
 	guard(mutex)(&reset_gpio_lookup_mutex);
 
 	list_for_each_entry(rgpio_dev, &reset_gpio_lookup_list, list) {
@@ -919,7 +920,7 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 		goto err_ida_free;
 	}
 
-	ret = __reset_add_reset_gpio_lookup(id, args->np, args->args[0],
+	ret = __reset_add_reset_gpio_lookup(gdev, id, args->np, args->args[0],
 					    args->args[1]);
 	if (ret < 0)
 		goto err_kfree;
@@ -931,7 +932,8 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 * Hold reference as long as rgpio_dev memory is valid.
 	 */
 	of_node_get(rgpio_dev->of_args.np);
-	pdev = platform_device_register_data(NULL, "reset-gpio", id,
+	pdev = platform_device_register_data(gpio_device_to_device(gdev),
+					     "reset-gpio", id,
 					     &rgpio_dev->of_args,
 					     sizeof(rgpio_dev->of_args));
 	ret = PTR_ERR_OR_ZERO(pdev);

-- 
2.51.0


