Return-Path: <linux-kernel+bounces-764724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C82B22686
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477F8621026
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124772F3C1C;
	Tue, 12 Aug 2025 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="s/tq+Vy/"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07612F1FE1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000782; cv=none; b=mumysMhehl0iT4wBmWL3XE5IYQjFpaqarX9M+1XxPJyEAe0UWpIh/xUjk2DAz35vSXRgVsDKGl8ItrF2msyeFcvsbhIvHuJt66vBHo6lW+CAdQPgrn1zA/hkmtZj/abu2GjKrxAiSOqd94j2/kc4sXuFAspACzKiOjmGyUDLGdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000782; c=relaxed/simple;
	bh=SYiQSK9Yx+cBGLCJfpD8TWgHeSTe3Ypi2zryPKR/RRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YF5HCWUhHEtkp2w5RTWNpUiidupbbSpIxtSjd6ZebkY6uNHdUxs0J4ghRlaLZ+kkT4jK5p1mzLNDeei2ywznj2My7JP9tAUxb1yslrCwAfAapK6MbxM2sPivpatmW04eimPbVDeFliY5WE53oe/+rpKd6SHBAIYuH7sMJg5cHNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=s/tq+Vy/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b790dbb112so3314960f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755000779; x=1755605579; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2pDGvu2eB22QFjf1je4Uit6bFjIzrUYVwBKgpkRJ98=;
        b=s/tq+Vy/DArO/2yWEJgrdgIBDgjIVbd1TCt0XCP+YdXaoLEuwd3dyum5E6l5xrJNbh
         1jEJFw+L7IIwFmaP8iYYW8jEZhkcvoMLvq+GrWpVbvUk8+Db6Ti9KZOHStzNDG+9La9n
         7bWJiIlIafPGHVLF1f+2K1ETm4pNZYSyY/OV8aamarK5GVp6/q+OgwalMfslzefhG+Zw
         OI+KBrE+U+A2ZNqiAGI1xUsT5VjJOG1kyqF0SdnE+GYO7oVchCNbOz0k/uRrLwSrZ6B2
         H2492TpQ5oGLgb6hN2ue14tTJ309uT/Kx9R4efCEyGh/r7VXbVX6rWRfuhW9Qn/RzYPi
         BXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755000779; x=1755605579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2pDGvu2eB22QFjf1je4Uit6bFjIzrUYVwBKgpkRJ98=;
        b=fXAVjafOQpErlf3O4k/ICp/bHwy0pxnE1hU4NZK3QVJxtTMg82h8QjSpZLnRRiXIQR
         2INcVCIcgSpY4qZrqi/LjS11Q+9Q4d/dYXt6EfeCjiZ/i8rET8zZ1zwnIYj8mQBtT25B
         M8MzL2QmZmH3eDWohEHd47NKo/QWeEpe9htS6vW7wf2RH9RUvA70xrq1QP8Wr0seLirb
         7pzNRYcqalGiDRuaukgy6ingL5vqm7kr1bWJSQM+CutZj7vw3Ep+fvkeEp71rM5TOK76
         077w42tr99aexdCDRkHC6tonFP/sIwkq6DFzTaI2td3bL1Xl2Kf/3jltZJzlaCKrsSct
         YqfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9KMi9Ct1HsRIJ9ZKtg/G2Fz5f1LaWQwJhAywvhhN5fqYplcPNgHDqCoLXUjn2RRznGRqbt/2SACSrV7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGrsuOe2y5FOB57akE7uStPvfxoUL8KjxDDd8WZCjGMMnuelto
	p0vH9dLQuwh3hyJrA+Y4/SKGVpAQMLQZwFtrdRW1IM//lgESTDcgxBCOM6fb0v5j27M=
X-Gm-Gg: ASbGncvyJZFmAiyn7CWDk1hasrdVv2WgYb84oL2LtB6EKBzgNKg97RDIN2Gze/Fobt6
	mZBw+XJzKi3aMPBdmubP01scdsxJgSRfhDTMUjUHaUNlMx9u9JKLInriO+VNuEcUDL/rXSlM69r
	dDyQCImm5enOQdpAjPNs/PNSSj21ogeuPNahmoDR3ttNkuE1YFM3EEn55NHj4UpgBKEF9oYcwa4
	iRs6uo/NkVCRbpM8f1UmeSXFg0xVPTcUMDHdfBGvqnM1Rs8GFNFFxZuBYA5sKBRt1iJ1ls0JQJ/
	T0d3QWbDpeaJCPd3UEr0oDKXTOv8YeWE1jRJPWisoZWY3RsKGk7VEU4JiVRDoQCcsjFpobaAymH
	lCyh12Sow5Sh2jPM=
X-Google-Smtp-Source: AGHT+IGN3jYzsYBVQXca7oAD/0BQQusDB4bsYzgS6qA4xKDldMmyctpavKuQxOQXivexALoM9jM+dQ==
X-Received: by 2002:a05:6000:310b:b0:3b7:96cb:2271 with SMTP id ffacd0b85a97d-3b91100ae21mr2612125f8f.37.1755000779223;
        Tue, 12 Aug 2025 05:12:59 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:16c8:50:27fe:4d94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e6867193sm298878535e9.6.2025.08.12.05.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:12:58 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 14:12:49 +0200
Subject: [PATCH RESEND 07/14] gpio: ts4800: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-gpio-mmio-gpio-conv-v1-7-aac41d656979@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2141;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=zakPacry7z23T70PXyuXPcLNJS53LcxlBowKWXzkU5o=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomy/Ai0zdbA9R7kLhmcZdq7CJgxh3wbhU1lkte
 T30n8twZeeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJsvwAAKCRARpy6gFHHX
 cuvdEACCH4xT6jGvLc0hzJ3+j0uJSqe3SolQuG4ChaqKeaIWZkTr4h6JKSEml/CLwrEy0keO1xm
 A+CpD5Ai940L1rK3JRNs1EHf5WxBNusLTqiQ5bUxpcrJvNQxA01E+17MIoj14ZJwF+QSTXfpqTj
 9XyFoDnT/TxHqLGhUSFO5Sy5dWqA2SP0P/ssqJ6TwWB9JuQq/S+rsfoBwXPhEF5ZM8JSU/CzNfz
 WFYsQrXGr3/3A1R3gjE1BXGBkIuh8Jkcu7BK0iH+OhAxtAO8SnV5SpQmeEafkMHKtov+8x85g6e
 77QRCsd6Xn9q0sjwSwFiLVvWarQqCqtOmMrUJjOMK/04gxXn7uRRoE391orIbqFr+Ult2VnSYQA
 LnKk0+1D95njTGs3dV1cNSjIXWBJQ8Evsta+aFmDiia4db7Ost5/gFbOOaHdZAOghbLggI+AqCk
 jbjG03E7eQckCLIK6No3x3n6s0mx5oP/oO0ryBMQGSOqOfUnRIqM2bb+pdVdcSOahmRX5Ze8Lgr
 RlRsLTZaz04iI7Y0Fuyk5EY6t4qn+/hhm3BTTmLQTQdkTLkKpzGeJ1yMebWVneIWbhZI3gx2zyv
 pAJut1r1Ls/tzHcFrvK4UMty15VHHufejXEwrYqHj0HHlQlZ90jwlg4MFFEuyYCcXpr4GQ10h/y
 5fuq/iLqQ+2ZsWA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-ts4800.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-ts4800.c b/drivers/gpio/gpio-ts4800.c
index cb3eeeb1e9df9aa687e880b16f8d0a31b04a3b07..844347945e8e71fa0f456be0ba8de7217f6760a3 100644
--- a/drivers/gpio/gpio-ts4800.c
+++ b/drivers/gpio/gpio-ts4800.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -17,13 +18,14 @@
 
 static int ts4800_gpio_probe(struct platform_device *pdev)
 {
+	struct gpio_generic_chip_config config;
 	struct device *dev = &pdev->dev;
-	struct gpio_chip *chip;
+	struct gpio_generic_chip *chip;
 	void __iomem *base_addr;
 	int retval;
 	u32 ngpios;
 
-	chip = devm_kzalloc(&pdev->dev, sizeof(struct gpio_chip), GFP_KERNEL);
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
@@ -37,15 +39,22 @@ static int ts4800_gpio_probe(struct platform_device *pdev)
 	else if (retval)
 		return retval;
 
-	retval = bgpio_init(chip, &pdev->dev, 2, base_addr + INPUT_REG_OFFSET,
-			    base_addr + OUTPUT_REG_OFFSET, NULL,
-			    base_addr + DIRECTION_REG_OFFSET, NULL, 0);
+	config = (typeof(config)){
+		.dev = dev,
+		.sz = 2,
+		.dat = base_addr + INPUT_REG_OFFSET,
+		.set = base_addr + OUTPUT_REG_OFFSET,
+		.dirout = base_addr + DIRECTION_REG_OFFSET,
+	};
+
+	retval = gpio_generic_chip_init(chip, &config);
 	if (retval)
-		return dev_err_probe(dev, retval, "bgpio_init failed\n");
+		return dev_err_probe(dev, retval,
+				     "failed to initialize the generic GPIO chip\n");
 
-	chip->ngpio = ngpios;
+	chip->gc.ngpio = ngpios;
 
-	return devm_gpiochip_add_data(&pdev->dev, chip, NULL);
+	return devm_gpiochip_add_data(dev, &chip->gc, NULL);
 }
 
 static const struct of_device_id ts4800_gpio_of_match[] = {

-- 
2.48.1


