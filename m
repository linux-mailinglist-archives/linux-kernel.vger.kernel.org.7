Return-Path: <linux-kernel+bounces-784428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26441B33B97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95FF4870BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687E62D321B;
	Mon, 25 Aug 2025 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sQuRLIXm"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D782B2D12F5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115337; cv=none; b=irnFLtnKGHrgbhkggXnqd4Xfh19sFwWPzYK4YpCam4W1Gp1o5J2czcTWJcYHk1SgsIBllaljQUyW/61WPHuhwlI1Z6b9M7Y5Tflb8HO+u7w/4Qpl+MQqScZsM1i+ubCIy8dDp/Je2pN+iieHYkgI5w8gVfup8bTM/nNuzhBxhdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115337; c=relaxed/simple;
	bh=CjOqg/tMVuGjCBjMfchIIOcWxbiHZ10GFFMMWZMqLdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RGHD7eOo2Pv/XB6UNl47i0EOYLuxOaVO0tNt/u0wB9r/hVFXnkMk/YqYFlckZjCkVvrEUi7aAGKJYLJAmzWZRT2xUaMFkvXu6y/5fX81UXwfKiTouTIZPCp78qTlDVfX4Xt6WN0LyOsyxzfVTj2uAqHMOozDnUmtXTgo5o8nutY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sQuRLIXm; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3c8b0f1b699so814988f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756115334; x=1756720134; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEezOkT0DMYtBQNI+88wui4CFNSwtPL8noFajy31AHM=;
        b=sQuRLIXmWt3x+TJ8B0ldiG92yIBCc4kCCNVwRIjJ5hhGOcmcL21fNh097ZihPDWh9L
         y+pvhYMhanywRvQv/1Kwj7a1jrS79XVxKC4BEgWbzsddEm5IMIu/GFZzGUu6sFSr3IsQ
         sjB4UiTfCwztu4zOFcR62Ul4iiQJ3E1IQb4XDoaqoSNewT651JfGmP4lJBFkkBlCiWgr
         2gigDprCev7rt4r0Hjvvv1o/nDbi3Xsfh/2FJxw6tdnvUM8BOBThGtcb7rz9f6NsQPDG
         Ss2WT7BK8PG1y3jJcwE9LWNxELweQcO0m+V3DAgE1i+w764QR2m+xtGBKuv+GNUt8LDD
         JCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756115334; x=1756720134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEezOkT0DMYtBQNI+88wui4CFNSwtPL8noFajy31AHM=;
        b=lqsvYZKo4O/PpSsHaZXfRzQSiKg39u/DVDH5Pmd7lH+BGif4/o4Hw4QTxuj3tG9Lne
         UPAENub4C/ZBnhTUZ/oUvFxiBbLWXb6V7a1f2TN3hhsnBtlUFejlyQ4x16XbNx1aY2Zi
         mnrVb6wbaIP6EWoeeLOuH8s5J8zYACr+jUaeBj2y2UR9bBys/GC/xsGcIodZ0ob/73ZT
         nNWlq2trDyN/g+YsPGRZuAexNY0PSn6eLtaRWx0tguxYz7qPrdbS2a0Jhrbh6J29JdQa
         DQ3DJWUHZCPBiNrq0cC2BBljOpUlJ57lQ9QIEWs4y/TIPrNOKJAcwfkW7/iKJJcRYYFZ
         Vmxw==
X-Forwarded-Encrypted: i=1; AJvYcCW6NRwv3+rZlgB/cjA+jSsfs97Z7yhRdlxx0dA0pX4hvqdFu2O9drBQIM8ChJIma2EWtbTm3KVAOJTH0uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoftjW0KVdxAAoeXs64Z6ACwsMHtzrAueS6N7xT4kqrdC8lTaO
	ps6dDEyIqpkXZP0J/Dc3BN8Nru6944KO2X9ElTA11H9cu09nRr+afDy3ClyUpFOvwzLRNZMJkEl
	w/iaS
X-Gm-Gg: ASbGncsMXijjNCEf4ESeq/1iBm7mczEjbYulLCiVx9VhaFnFApyw9PJHSJ74K8/ZbHq
	G7Q574E4OFru4T4qVrSG9HwG6wX2s+qS6tl8Ui761ajEkbOYsBJugRgQFpn2ncIm0SUrFaZywRt
	Hm7rgGhwRbxKGbRwIEkvlu4+JBAuispRno+LhjmDTm8GQz5HC55WigVKqvzvQiiA+bBdxge234+
	lQEbyDX1BffmcPlkgXZ+tke6hKtRv4mc1Td3Fll9Vag0j2wGrFVDxoDGgvsE2ln77sYj2jba6vk
	Qb0ArVkYuL/lIsy++TDdV8dU1dpdvpy4eZrcM8Vz0uQZbDU16+KrZlMFu+aZaYXCiP4Q8adU972
	Z9vub7iVURZ9B6Plz3A==
X-Google-Smtp-Source: AGHT+IG0krJTq4Jgt1IPZ/cibP+uYVb/N3x1kVGXAllB8t7somMdG/PDXIbNNQwFp+zoe9Zmdf1r8w==
X-Received: by 2002:a05:6000:420c:b0:3c9:59f7:ae7c with SMTP id ffacd0b85a97d-3c959f7b103mr2545040f8f.20.1756115334197;
        Mon, 25 Aug 2025 02:48:54 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ef52:fc8d:34ad:9bfe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711bb1e3asm10877449f8f.57.2025.08.25.02.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:48:53 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Aug 2025 11:48:45 +0200
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
Message-Id: <20250825-gpio-mmio-gpio-conv-v1-4-356b4b1d5110@linaro.org>
References: <20250825-gpio-mmio-gpio-conv-v1-0-356b4b1d5110@linaro.org>
In-Reply-To: <20250825-gpio-mmio-gpio-conv-v1-0-356b4b1d5110@linaro.org>
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
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorDF+dmaB6cWzgm2SX91hFFwqfh18cFEuENOte
 nL8RUAd71KJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaKwxfgAKCRARpy6gFHHX
 cv1LD/92kRpIMtl2PZLTNmSBg/nbx4JFs5adi1jle8Ro6PoiveSkeouWOncXl7ZGS5367YmHXsm
 sVVjoeuol0qV685ZewLBky/Uh8Wc/i3mrR3YunQhN3fWnq3ZypbuHN+QSasKrtXzo5bKCJIubBX
 /arpVNk+o5r4co0IaZU5ZOBcNNzhkOkJ6KizZ2uYbA0zacx1D8765JmUpbPbVqyXTf3WmmDTz+r
 bNCSXq2TEgn37Bn2Qlg5K1UvtWeGl/Lhgw2DBezQboSRVARFq+2VHti/r/gzyoze2PXjOFFci2W
 U/PZQfbfow13027M7jD5UlSkWcdznjt1egU8aZtQwtYJFGxHa11FA1ozAeR2DAvPftb2WN1/4R7
 rzMIBUHtxstYWt6rbgdijl8YVgvPMmc6m7dxFyZkB5qMB8mNGhD4L/xGpC4LAP+P5N6wIdR+u7E
 0r8SoqCWuHo8D/kJPEz4UCXxXoLOlTLmx4LpZLUk7vGHRT/8RRvVJbaP1u34HdG103Q1k4xHFlW
 oyGIWH9nGCkrPeRSSIcelEJKZ9vMPO/pwzEBBlETXmG9K5DJRLHoxMj2gvxK8NTcFQ/9Ujz/vXu
 uwFVjwosz8GWkmTdng/1tY1TScUvLSBkhao3qKSnl7wpRttlC3GrAtnqGLd+0up1Vl9fWZiIQAT
 X4Zx4skN4CDLNxw==
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


