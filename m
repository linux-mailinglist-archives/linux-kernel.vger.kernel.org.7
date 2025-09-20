Return-Path: <linux-kernel+bounces-825801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90866B8CD71
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7DB189F23D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5332EBBB2;
	Sat, 20 Sep 2025 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MnY5Crvb"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BE153363
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758386679; cv=none; b=i1ff14VXA+ytL+7/5Zh+89oTgEMAlATMlcQZ+235Wj/vQemWgRqQPBkcrdDGcmn8235IYfX+NHV9rhEkfvzZUQxVMw+n/mRbw1lN40NMp4AnMd4R6s0h0w+JHegQln69LqdPY51mK03DIy8pvP7U35pm085PZ1gS/I8Z+VPWRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758386679; c=relaxed/simple;
	bh=+KkVAUbjvzLqQ372TaC6mYdwu51f82R/koh/j0LBnXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Pn8BdKJDk1oKgyXO9CJtPpMTQTVKhfE3Sc4KbuBLfg1wQL7z3fu1ShTsiQT0JfmhhzF+goaYOMHUFs1vDk0VAhXn0aXftYAJESMkT2SeRxfVCEqKeX1M0yRJRdBjW1YeIFQbYNbcyMWd2T896KsGqqQJFnd0aQe7ZHhPh7aawME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MnY5Crvb; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-62189987b54so1685063eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 09:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758386677; x=1758991477; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YrLTZ7Rl/iAlP5NeobqvU69yd5e90hi+ZynPAnpcxH8=;
        b=MnY5CrvbUYEcYcg93JYgDpEORIHfjdj6wjFa8auvioqOGhX1YYRW0gAPGO0J5iiSZO
         XKY2t+do3FW5dB2TNX9YqQapIe8W8lnb7HfYilPZITt6i2gNimwaBoOMMybidV0Jsp+y
         0iZrb+j3BPKcGooFQn61nDsF8IBzLRVBhqTciC5ZSrj2TlgIzQrpFNxx95Aq6NivCEE1
         SCiXu7MaztlNCfDHqCvy0oewLfNfqmdpqMN6oWCStbtpPDqJOqEzF8qNIBr5K0XHd0Dd
         nqAVq69WlT02/YcAwMpN1dsoIZS1IYRD1j3SvPyzbW/3wrW0KiH8GVgWCB93K08HqV58
         dwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758386677; x=1758991477;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrLTZ7Rl/iAlP5NeobqvU69yd5e90hi+ZynPAnpcxH8=;
        b=lytEmXakGG8ixJI3J+RXpZtPLACQhpqwYILhtznLjLOu5wiYQbh/nj6XPRc11CdnpG
         B/QTBg1Z2zT2tTNsJ+6URTAaYQ+v2uDOi6598Wtl7x786kBMvx3otthSJUh1itXBJ2fT
         X0I7YZvCcIlk2WrtQAPxtKhzEnxzdmiC68RgL+ef76Ms46b8po+inMcwX+BLCrt8Ah2V
         e2e+e6EW9hSiLdlvTpk4bUkU/0m9lhPbV8NOVsFWkk2YW7TIxXBE5x2YQq0hfxcppLT8
         uVm0flrN5eY7ILiWm4NRpToSW1ydHZ7Xz6cgwfOERpco5yZ/r69ATF06oI3M0IPRwVwK
         nuGA==
X-Forwarded-Encrypted: i=1; AJvYcCURNqrV9A+KWNLWOibjI7vG3sZ+O5dXW+pAOS1ZtdIjYPKAHE63np9fYBCHQTDUsluKNwzmXg132WpP+tM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqcaR9Iivg1Tv8OjobeVRq7NbtxZqXuZhZBP8VFrYWSrCyHhdK
	qVOH2pTKBwUJ7Yoder8/LksR50REQnxhcZlS/7IQhjiKiqDfXnAqD5QXqLw8kDRZ9DcaLZdkoH0
	OdLQsjWs=
X-Gm-Gg: ASbGncu7nBjqS4E7o3bzgIPkXiaUwtjus0Tu833YqxVy/6Z1lxci51ef8x5oq9O/5UT
	r2j9jO7Yy0/ERpGgpo/Shfedo4B09z15Mlo1ctBZs/q0ty/2gMQs4QDx1OX7m3vSsrH/j8AQDtd
	kGvQM1fLpr2EibbZXzoRBwkv/vCULNxm3uj9dW2/NvavATFdRFVdC8jq+pECYtB+4AO9iQfl1kl
	gw9xiaUnzw7WVopM0aNNewmOyoABt6Ms1d6BhRzlDUXxADAF/LJRxAkp3WWtZM+woNFXSDTrNtV
	DTT9TpQFPLtq6XM1ySUwAbi7UtWRPLJAPnoMJHyNcsOTmop7OtbgasoRGFwoXpTTJrebRwhHoxR
	GGDXugEmxYdJCyUG65vu6IHRy8eUYt0+V5cW/HA0=
X-Google-Smtp-Source: AGHT+IHh3ERXstA5DE7ysHRecHHXbKMa8uwlY9kNdhsVCzCl9/CU4gwGE1Ebp2Q0PUXXb8p15ahb8Q==
X-Received: by 2002:a05:6820:2218:b0:61f:f591:8a2c with SMTP id 006d021491bc7-627256b01b1mr3146123eaf.0.1758386677042;
        Sat, 20 Sep 2025 09:44:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:14ea:b68a:f92c:93c4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625db6d4e4csm2738142eaf.20.2025.09.20.09.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 09:44:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 20 Sep 2025 11:44:26 -0500
Subject: [PATCH] iio: adc: at91-sama5d2_adc: explain why indio_dev->name =
 dev_name() is wrong
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-iio-indio_dev-name-wrong-v1-1-d376436abbb6@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAOnZzmgC/x2MwQqDMBAFf0X27EISFGt/pYiEZmPfwU1JQIXgv
 zf0OAwzlYpkSKFnVynLgYKkDWzf0fvjdRNGaEzOuNHM1jGQGBqQ1iAHq9+Fz5x049j8I7hhmKK
 lln+zRFz/9Wu57x8t98rVagAAAA==
X-Change-ID: 20250912-iio-indio_dev-name-wrong-f5098d2447f1
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2271; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=+KkVAUbjvzLqQ372TaC6mYdwu51f82R/koh/j0LBnXQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoztnt4EI83nJVNgPFT3zACkJTkiVAF2gkuvMgL
 tO6punI8keJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaM7Z7QAKCRDCzCAB/wGP
 wEXIB/9E9AyAd97dAArJLyEWpfyyRsU8VSkAM80UT+sSsOWflQLHDKf+U6qVsyZ3d/4SttHykyy
 j188+VF6Xy5XnAGPskyvca5iQ8c2J5TYAn3FK+Wjb1E+MJ/i6j+kU5S2aF5eLxdtsqPG7beYm85
 MX055IwHDekH8D90IKE0LoZhAXPtDeG8Y7fYI0P0LLqFSfH/V/Y6auBzNg0KKik8MPZDshsOjk6
 GqI69MYAcVUKwf6KGUJj9z7CmKTMwlNx/2N2F3ygnfyX/+trVsok13TWcLYplpZ61dYGAf//4A3
 C2l3Wg9VOEre11GC5n+lBoGyoz/ONyQBAQr7p4CQBVcSTdCu
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add an explanatory comment on why indio_dev->name = dev_name(dev) is
wrong, and that we can't fix it without breaking userspace.

The idea is to prevent future drivers from making the same mistake by
copying this code. And if this driver is ever modified again, we can
at least make sure any new compatible IDs use the correct name.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
It came up in a recent review that there are some (mostly older) IIO
drivers that are incorrectly setting indio_dev->name = dev_name()
instead of the "part number" of the device and that we can't fix these
without breaking userspace.

There are actually about 40 instances of this that I found, so it is
likely that these will be copied to new drivers and we don't catch it
like happened somewhat recently with magnetometer/si7210.

I'm just submitting a single patch for now to see if this is looks like
the right approach. After we refine it, then I can make a series that
fixes it everywhere. I assume we would want one patch per file for this?
---
 drivers/iio/adc/at91-sama5d2_adc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index b4c36e6a7490aa9002a702e70a8b37ee3eae6324..cac408fda8eb6f45ab79531a71d5ad868115d735 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2318,6 +2318,13 @@ static int at91_adc_probe(struct platform_device *pdev)
 	else
 		num_channels = st->soc_info.platform->max_channels;
 
+	/*
+	 * The device name is supposed to be the "part number", not the kobject
+	 * name. Do not copy this code for new drivers. We can't "fix" this
+	 * without breaking userspace, so we have to live with it. However, if
+	 * any new compatible IDs are added, please do something similar to
+	 * adc/ltc2497-core.c so that at least the new part numbers are correct.
+	 */
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 	indio_dev->info = &at91_adc_info;

---
base-commit: 411e8b72c181e4f49352c12ced0fd8426eb683aa
change-id: 20250912-iio-indio_dev-name-wrong-f5098d2447f1

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


