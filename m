Return-Path: <linux-kernel+bounces-764721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7BBB22675
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1B31B64205
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A509A2F0C7E;
	Tue, 12 Aug 2025 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hP3tGwV9"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4415D2F0C44
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000778; cv=none; b=SxvXwsE3g8onHAmFK7IJqdlH+KjhuWKHpyI0YicycLPvR830K1VRqF4aC1oQzNc0U/j4QJv0sa22dMccr21BIotq/VyIoPNrkndSkK+2/Njbj0aMb8ozIpuJYynd/89SNwnj2RH8eEzipqGM0pDQdfhWfquZ/qQxz8+O7/r0Zag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000778; c=relaxed/simple;
	bh=CjOqg/tMVuGjCBjMfchIIOcWxbiHZ10GFFMMWZMqLdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fjxn5zKa7ulQ4PVN5WaJG1xuU/R9hQZNOfqIKe9OmI5iSbiH+wxclTdin51ttdX/FXmFGPNVrohf55Fkv6YH49X2C0V1N51Y+S7KGl784z5qLR5hBP5PSGtHiLiVNU3f1XWguNreRhUreLh7NshCI34JRC7oraaMHsllFj1OibY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hP3tGwV9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b7886bee77so3903481f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755000776; x=1755605576; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEezOkT0DMYtBQNI+88wui4CFNSwtPL8noFajy31AHM=;
        b=hP3tGwV9LDnGwzNdepSEGfeYspXHe2T6BEWLV3TjxLz5KUpHc7E3yO9CUP4T7WPAn5
         yeiyIuLN/yQp0KEGiHX8Lq0o67v4PPtv0ssjZgyDUIJ5FWKKUYHrbZI6+HspdnWX8Omk
         Nz8awHP7O2hBZIuTgRXBZTb5TW7W58ZDy5AWfDeqhWxw2nIcdjWr0ruuunhTSPfrAxOZ
         7U5KdqF1mgJK25yhqVkFhdFWJZun3UWrbQkQ8w7JIbCl11A21qKfGfM7CNOqggPvWuCU
         BBE9jxPInF+cL4CsZRuOyZLd7ArxEm9xmmBrt5E7aG5Kd3jRyuRpuPxSZ3BcPvV+6so2
         cweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755000776; x=1755605576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEezOkT0DMYtBQNI+88wui4CFNSwtPL8noFajy31AHM=;
        b=ER57RUuim2e6B+qTdZaQNB4VFv1L8k5Tn+RGKZJtw64M6KvQ1TCrcBXVdyIxlkMgMf
         y8Kx6f91H5QgcThF/tPSRc6hJgeqSHNYrCtqsJvP4SoXO6dXBEQ/Y/aNPa0Yfp7HSbCy
         5O3bbWdk5Twcsg31zKHTzQ/q+aDy9vJLz/LnCkQ/lDq7kzU7F1z+hsx9tG6ZaW5NquQU
         PnK2bz5fwmgMaFOAPqOAirFFC3crIrReSXzsEF8XtLx11zzbFS/XpRFeiIXWg0vF0aAp
         gryiTxvwEZQnFySg36ONw+If65Pq2sAz+Y12v0TQQlYPYVigGy5jFP0ERpCO5wtXB0FJ
         ZCiw==
X-Forwarded-Encrypted: i=1; AJvYcCWvZmnYO6CxRlgl0QcLwJV8Iycr1i7OOZRvltVy0dB/iu2MeqeQmbIXaoCSEVDjklEtC1vkY+xqoNIvv7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG68vOle+i6LAJ4g8dWTPf/FUNsfbNBXpQTtiSKxp/PHK9yN+v
	V7Z9OflbzwEdGqS1EgZxw+shl0tv6DgdrHnuObuLEu3dtJDEvigaCVvv+QfP4Tjpt20=
X-Gm-Gg: ASbGncs2CUq/vvrr0pS1AQWVFSPJFiIDiXUquqSEP8NTPeWw4Y10zhd3PVyVaMG5AZr
	uW4ZS3jiFNNSJsnavDMknMk+jcvBfBcHQfy0emJEno2MVTZdFhvvVo1WMe93DQF0q/C7SMfbOHi
	EL/jZeZ87i4Cpn3I4/oQ3RTAZRtmGxocXlpK6jfKhEwc0SBKUcY29b5C0oZO6W7y0SqVE76H9MN
	gpDi54AenNCOwu8W9I3iKT9jxFiIKiflbpKnInngIWfxj9QGZZJfqxwqajbDMHkXQ91eA9X5HbW
	9mGUJDgr/YVhUGlyOvSeaYOZ2cO88/rUYXosrr10t4Hzv41TDyScrqkENi1dQL84P2WAqMhr49b
	OWjKitC6fcvglP9M=
X-Google-Smtp-Source: AGHT+IEGQDIavEdwAVseF7zTTEBlsP3iW7+rCM7AvFwCujx1KCDQS0QsNDaVetuCN3LIEKies+x0jQ==
X-Received: by 2002:a05:6000:4283:b0:3b7:b3f2:f8b3 with SMTP id ffacd0b85a97d-3b911007702mr2510510f8f.38.1755000775696;
        Tue, 12 Aug 2025 05:12:55 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:16c8:50:27fe:4d94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e6867193sm298878535e9.6.2025.08.12.05.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:12:54 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 14:12:46 +0200
Subject: [PATCH RESEND 04/14] gpio: ts4800: remove the unnecessary call to
 platform_set_drvdata()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-gpio-mmio-gpio-conv-v1-4-aac41d656979@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=749;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=l19XxlCMzrhQb7segGk57h4S+g8U8d8cxgGqBJH6nF0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomy+/9er37Ak/sFPPdUpU+bYimsPDTN2yc6x42
 FQ8FY/oejWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJsvvwAKCRARpy6gFHHX
 cs1kEACnksREk9QmO2FhzrwUyQY6DFqRCpWOw11t0IdlkTmT1crGP48e6IKjx54SKHyp4sN42jo
 stgwcLRvwFedR2zvmHej3NLE2HegxIm4m7iEfrgRnaPO3fLODyWUW/lMX114rXBqNa6GrspT2ne
 dP5ciZfuBXiSlsOVW16bgOErzHt187wcG825R98099jTmshxHjqsrTUlIsEsTtrLi3FEN4zIzv0
 hr5+6atZ0zl9joHZx2V7PTzwKZGbgzWcQrs6PieTOlLSiSCvWomMaM/tZhuro2JemTnb476JlhH
 //BD0Iw7ncTNdylkaDpA3Xb3JTcbgipc3GNuhp7mJhdruTE7AfWI0V92/a2P4rWfWSHPvAurGnC
 Nte/Q7KLeNVJzz1rv1O/6Phap6sCLBL7Brkop+kaa5OQPDW2wWX6fBTiC+UiYm0E5WwP/JhhxYK
 DGTWaHo7PDMXaxR9zrtJVnPiPLa/RRbAx4MUpsbEFx60d6vuyTkBFj4iDmVILm/a0fd0BxssCA5
 GvKxj0iXDd3zlORV3S3Ux716TyKOEVfwghYqPxOs5ZI84XPMKMuo4zsZXniZWfY+Cr690AiYvcX
 f9lCK5D8o3flMW7LKN5i2yjOd5DAJAHljz+naFZ34U5udYaR5ywzIftABA2Q0648whgtGJ0IEGM
 uS04lz8L4PvZKuQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There's no corresponding call to platform_get_drvdata() or
dev_get_drvdata(). Remove the call to platform_set_drvdata() from
.probe().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-ts4800.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-ts4800.c b/drivers/gpio/gpio-ts4800.c
index 4748e3d47106cd2db6a994928b20f76921540a60..86f7947ca9b2d23292c1e6660fe93c611e0cb837 100644
--- a/drivers/gpio/gpio-ts4800.c
+++ b/drivers/gpio/gpio-ts4800.c
@@ -51,8 +51,6 @@ static int ts4800_gpio_probe(struct platform_device *pdev)
 
 	chip->ngpio = ngpios;
 
-	platform_set_drvdata(pdev, chip);
-
 	return devm_gpiochip_add_data(&pdev->dev, chip, NULL);
 }
 

-- 
2.48.1


