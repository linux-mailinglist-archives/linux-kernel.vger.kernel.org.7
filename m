Return-Path: <linux-kernel+bounces-763431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951F9B21476
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A730817FFD3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A382E2840;
	Mon, 11 Aug 2025 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VCQ9hLQN"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C84277026
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937165; cv=none; b=LEmR4/WssDoFOX1hn4t9OkKuJPFvglr8YUGB4F+AZ1StbLtoAmzEW08BL2n0PvagB1cUNSElj7gEE6fi/eAqy97ttls7xFQmIJpuksVA2spaIFzE6NhYLMmakKjqet+3MLZcnFwaIFMMN5t7Sq8yZisI6Z0EVOhFZOIr8tb64DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937165; c=relaxed/simple;
	bh=i92KrAXmkGnYQlja1zCEPVko6hhcZloXCLpvdvs61co=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bBufczVCs4IXVCtsCliB3kx8tEf6koiiBggGEJYQApIoxHxzyC3EPrq151To/RIyKKpnGAU+kjQwk4nUNQFgBK+ZlH0gLKfvHSBqm1ryx7HlEhOiqo/gfB8pM2KRFOIsCrp7Tibgb23jUlBp/j9jjdzBt0kKSwUEhw5JzebCHLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VCQ9hLQN; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30c08969614so3177402fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754937162; x=1755541962; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LeTxH6JVzhuvOOHt8PDT/8nTwuTCFSD9kgIvJbyD4sQ=;
        b=VCQ9hLQNHSxdj3OFbhOBDZyODGlAJgb3BG0a+f/chz7+MbyKUrHTF5f89vq4SwkNTF
         cz5Ha3I8T9HRQKx5qhpz6E6RTM28XuX+7Q3hlRNYWfJTrdYfu2aeAwS/ID/k6gvEaxOC
         E9grKXgK+tsjNjFNCL6WItjcsB5tyP6MJBC1N1X5jHhBG8quwsawXdD+4bpvF2to1tkV
         8tHe8GCpt5KRJakMQBKGvR6JkA3ysh7cfV8G+PwkgFiO0AM+USTiBAYQyvCQp9SRg/C1
         ieNYQSuSvNd0m+5AIpOcF5JKEGIB1OH/PbZrBP1tGmchNyCboJ0DEnh4imOxzGOFQLps
         C1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754937162; x=1755541962;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LeTxH6JVzhuvOOHt8PDT/8nTwuTCFSD9kgIvJbyD4sQ=;
        b=ZfZoNqcO9Q1XeYXZxcInS+wyVeUBhTT+ApW1qCrCj8yU6+P+8Wj6L9Tydm2whKG/eH
         dRzvfW7CURL7RWQXDz4bFCPrKmCJ6HNTAeHDFzaOYDYPqlHEeozu2Vj7EGHGmoTss4oY
         mo3xCAuqzzlI0Fs7PieLCjsE03qoOuKmNuIi0sAZ/A14BCzlPd//weHRofbPOk8VVTax
         5YepR1iSdi1Rq0E/U0X0aye9MIyjs/lQ2IuiPvdCy0TDTsZ5yqJCDSSPKIf5PPji0yk9
         AxoJwRXZ6OFHyfaiNbc5GUZblym9lNp1nRx4sMFkB4pxyHop/ic/FWoIAerUdmInhuST
         Dr0A==
X-Forwarded-Encrypted: i=1; AJvYcCUOxvpQxnD+qDd8HvQ3Yn9ep9YTQNQSGHhgU6M5H9+dBwSnI5cYO6XnpDXLR0GX9qxYdrJcIwpByzFX9zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk3hi3bBvIt05akONawHA1Jm9J6IlH2huhF7Z6zIuo3XarOaMU
	Onsbnu2fBYviLhb4a0FF5yEoDUlonzE+mi0twovTFQyGdieVHOHgkrPObCDgXucgEms=
X-Gm-Gg: ASbGncufJtAZGIO7mVdywXx56gx+Cdbgt9s47gjA7DEjkmIxxFp4p/kNwgLUGKqEHgI
	ShW0JhPXl0naZVFJ/50lmkv2uqhkgdiSzKER+0Er1sdyDFHzkcL5ZcSfEy951SE+i0AMe6uZPbd
	Ua1Nlk4ELtbc61r76j95UAh9wisbr+uf/mkq+mNv9E+wTnN46lUhz1eZFAhTve2BYSxHlYt0Arb
	7NbxIfOjzyrT+xJ6feoPQaHxa+IrtxGgO90OTxAEDxiMoXIVFDqO8M0y+DzeeOOlEkkkuvoKBvW
	gk5lns/GDeq31RPqEO3Lj9Ld0+hkeTtgqOBGc328XSje3wBml7BTlSRe5ScL8OL4QbZcUmAR/X2
	OLOUBLQ0H5RnCof4Ex1g6WhU99n0WApE7IZeD6As=
X-Google-Smtp-Source: AGHT+IGHlQRsOQLA9RN8I/CrgNHvt/H6WdqUKeIr/pzj0zxbQAM207v53to9+K03H7v4vJ+hcoVBaA==
X-Received: by 2002:a05:6870:8a27:b0:2ff:8ee5:d1f7 with SMTP id 586e51a60fabf-30c94e77364mr400690fac.1.1754937162356;
        Mon, 11 Aug 2025 11:32:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4a4f:fe55:51b4:b5ba])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30b8e3c9b32sm6232275fac.24.2025.08.11.11.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:32:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 11 Aug 2025 13:32:31 -0500
Subject: [PATCH] iio: adc: ad7380: fix missing max_conversion_rate_hz on
 adaq4381-4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-iio-adc-ad7380-fix-missing-max_conversion_rate_hs-on-ad4381-4-v1-1-ffb728d7a71c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAD43mmgC/x2NQQrCMBBFr1Jm7UCmiTR6FZEQkrGdRRPJSCmU3
 t3o4i8efN47QLkJK9yHAxpvolJLB7oMkJZYZkbJnWE049V4IhSpGHPqm6w3+JIdV1GVMuMa95B
 q2bj9LKHFD4dFsZZ+dtYTOrx5tuSIxjwR9Ma7cTf8+4/neX4BOid1VY8AAAA=
X-Change-ID: 20250811-iio-adc-ad7380-fix-missing-max_conversion_rate_hs-on-ad4381-4-98e314112d71
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=i92KrAXmkGnYQlja1zCEPVko6hhcZloXCLpvdvs61co=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBomjdAStnk0tMGWQaRUeeDLLtlb0sbFDmq9mK+0
 tYbeGd/PfyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaJo3QAAKCRDCzCAB/wGP
 wN5nB/9Wap7GFHeigPM5zdM9S8jvsd9EdolBlu6nPVi/x8znraa4c8l0NVO83kjtDtWDZtOGooR
 x9Bi7zje+jnMAY8H1fdh9Fxeg6pTqJBEQyuSVh3II63x18bu6e7B4jMYVI0xotunzJhHd/G+J3/
 VvogRIoYk/DLl2K8o1979zZSiYBlBjwpadx90gaMQROLCivEjLtbjuJQxu8BlbSu4ui3Wa0Lol3
 kuNoXmGnkmLp/gyGzXZyyLQwRu3uljn5C7CbvALuDY/9g+H5qWPRg4pbk52VjbbhP2KSrucY1wQ
 SZY+sx/2CdjR2c4NMqziQjl1yoUzCso/3t5WConwToIBvhOi
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add max_conversion_rate_hz to the chip info for "adaq4381-4". Without
this, the driver fails to probe because it tries to set the initial
sample rate to 0 Hz, which is not valid.

Fixes: bbeaec81a03e ("iio: ad7380: add support for SPI offload")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 6f7034b6c266bd6075e0e2fd8d567c4490171e7b..fa251dc1aae6ab0a0d36792fa37b2cc22b99dfe6 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -873,6 +873,7 @@ static const struct ad7380_chip_info adaq4381_4_chip_info = {
 	.has_hardware_gain = true,
 	.available_scan_masks = ad7380_4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
+	.max_conversion_rate_hz = 4 * MEGA,
 };
 
 static const struct spi_offload_config ad7380_offload_config = {

---
base-commit: 80e8c3730645f6e097a79e99e658201530bc2881
change-id: 20250811-iio-adc-ad7380-fix-missing-max_conversion_rate_hs-on-ad4381-4-98e314112d71

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


