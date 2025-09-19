Return-Path: <linux-kernel+bounces-825191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62964B8B3DB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE2CA005C3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359E52C3276;
	Fri, 19 Sep 2025 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mW0BX05Y"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B97279DB6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758315048; cv=none; b=bYEZdAGu1bJXu4Bj74tDuVeGaJ7vigAD22ZFRl+q1RdFl0x0KzthGEm9OmCYisqanemUsd9x8vVwzhIcIev1BPaCBSORas6pxX4WggZ4aoNUDgi4dB6W/diLJYnbp9RPUqt9d2ykHNTwCXzB7hRYf9YnIWl1G9Il8cZGycONgWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758315048; c=relaxed/simple;
	bh=T1pjRY/F/SkgSjWuJdk27VR8oZOxZjfSXUdbtPBD4jY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PWMLrGhm0Grl5AhxTywOO9GkMqSPVZnzTsTDfrwF1fpmsrHNGN6dXqo6L+sc7FqgJG91sAKFX6hLpkjqbB9MJVr/951rypFHyhtxT2SAlsOjMweIPjB2eOoTupOLjbUTQKjqG6SYdzS6NdgRd7Twyh5ckDOkEtZLH2nIBwOxThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mW0BX05Y; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-62355a687e6so1745344eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758315044; x=1758919844; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9S8gTyZHpLrd3UuYpDvVcBF3/jRK8JAKEasp6QLRjXQ=;
        b=mW0BX05YycfX/KGzsAnoAoAX3MoQk0A4QcFXcGhPE9NOO8GzHn+k3NcxzNqPL4BHyW
         eEJ0N3oB6mwO7qNpqqlYdCMz3PVSS5osA2SCWe9UjSdajlynAlnPYaAZQFT+tD3woLWB
         ep6cgxB495R6+XYXPE+qUOONXVKubx/WyI8vsmLZzUDcZGJcw6mD92XvCVwW0ygrRICl
         f7ZDr+gV6hEzOW15ewfmKFGsf4EQQkMC08CV/NHYjzuOq92sW0wg06tB7m86XAofdrvh
         GmrzJUxH0LxY61VI3f4YeilG8/pXAOwKbiheMGJQLCyizEGHyigJ6ADuScUKEm1ndceA
         7PaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758315044; x=1758919844;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9S8gTyZHpLrd3UuYpDvVcBF3/jRK8JAKEasp6QLRjXQ=;
        b=sDkg3DNqXx2y6SwO4ojvHM41XYVcvd9tysJe1mo9fAfxflKR2P5aiUnNG0b3lRA9Ip
         JEc0MM7t6CtT6NibDLZuAwE1HrISqck8uXeH4OBQlqIh/5CG+I92zDfkaa9g/cYIMSrN
         l1T30AxEY3qMIFw2KMGSt9HWCDKDr8v3rBlZH1jabiVndTcnIUGTpiWU412I1ybU3KOJ
         R51cSAkN5tcDoPxkPtyPi+t1w9Du0D8lHVzV2akB+P5wTIRisvv8QnRLgIPt2OmKW3Nc
         kxL5flElbkM5CoR3DO0687pGKbbKM0qYkBY4ExVFzS5EYmYnsuaiat68s683fvdgUwcV
         9M+g==
X-Forwarded-Encrypted: i=1; AJvYcCU40Yq8jgPE+yWYRV21yXSRQ1tZqKJk8SY2p8TKL2jyk3EubDz9sssg8oycPPWi+EpZA5kFlwDkq1QF3sE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEQXztVnwaTiWQo3wuYWFtocmVvKqm1oquzBbPm2JN2iUm6KUO
	PlZQo9Ft5Ww9cRkuuoIAGpeqdgXEsyGLMU3WuGotwfqouU72M0KlQDuSI5ppQ4qyG3W1I/d/a5N
	Pbvm/c1s=
X-Gm-Gg: ASbGncuWu6az5zc2iwgSGNrfn2hDI+TBSZnKRIWdACrZHHPc4tANDME97+0iOHfChzy
	Lu+cCUi7bbNNEWNiIN4Xu6JAUBE5AfSgAxun6dODX5j2jfAh7/upWm1bDNr5NacYN0gPgvgW+LL
	ZOr9I4Yjxq6o0RSIhYw/xsE/7rpy3br0EiUMQisFoZwO78z8tJIz9GO76fAp3JNOQvjuzJpBSGr
	dZjbuufauZN4xdyEWoUeW7RhzRmNH92U4n6mqJFK0nouT/bQ0pPxDbz3MK6W4sfa3hX2PtW84+D
	+DmXdNvbCHIcXff/82Wi8WzWK2yIhmzqgRSfqaxEzautkS5quBuCzo65Bd0YB+W4r0Im8ljvdRn
	i4R1vwWW0jU+DaerlmMuVqPVw8CDd
X-Google-Smtp-Source: AGHT+IHFg+e4fOqvz7ofLnsec4K9Ow95HzlRIYWNVVd1U5YPgRsw3+v0zPkEBD11PFRkIVjO7utBIg==
X-Received: by 2002:a05:6808:3a13:b0:43a:f438:ef46 with SMTP id 5614622812f47-43d6c279c3bmr1952918b6e.36.1758315044441;
        Fri, 19 Sep 2025 13:50:44 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3838:157c:c9f9:2e3f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43d5c68cad0sm2353369b6e.2.2025.09.19.13.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 13:50:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 19 Sep 2025 15:50:34 -0500
Subject: [PATCH] iio: adc: ad7380: fix SPI offload trigger rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-iio-adc-ad7380-fix-sampling-frequency-for-single-ended-chips-v1-1-7b2d761766cf@baylibre.com>
X-B4-Tracking: v=1; b=H4sIABnCzWgC/x2NQQrCMBBFr1Jm7UBSKSZeRVykyaQdqEnMoCild
 3dw8RfvL97bQagzCVyHHTq9WbgWBXsaIK6hLISclGE042S89chcMaSou5ydwcwflPBoG5cFc6f
 ni0r8Yq4dRa+NkEqihHHlJmimec4UnPM2giZaJxX887f7cfwAkbOiMI4AAAA=
X-Change-ID: 20250919-iio-adc-ad7380-fix-sampling-frequency-for-single-ended-chips-05bbfea8891c
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=T1pjRY/F/SkgSjWuJdk27VR8oZOxZjfSXUdbtPBD4jY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBozcIcFW04iCCjadrwSaGczrKUaG0IEGgBkE20b
 bW/dRX4XYOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaM3CHAAKCRDCzCAB/wGP
 wEDbB/4lhrG0PaqMDHU7r9Lhw/vVXA8D2Wd6uxaAbiFtMM1t44VSbMLauy0B8u52G3+r1nEZvNr
 G0Fh2EpB66tc+LJBrsE6JcFS+hKDoHDkZhDewPKGXfM95FJtCutPYXTRIWtb/fY23Rvrx+2hna8
 k8lIU7t/L0720J2rbtxN0p1idDAJdPLVmM0vVXWplR/c0KG1bgIYS/FBbzkEE/zi2jwRwQBivHn
 VYk4Orbcz4x8/mnZ6WZo6wRd/cJqJG6a8scLAO/EADuqBQLeT7YWn6GfCP8Na6kJ0lEBfVihXMm
 ItD4G/0lj1lPbp23MKD7lxQbiCs8EOVFCyyqdCWI/qlBPudH
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a special case to double the SPI offload trigger rate when all
channels of a single-ended chip are enabled in a buffered read.

The single-ended chips in the AD738x family can only do simultaneous
sampling of half their channels and have a multiplexer to allow reading
the other half. To comply with the IIO definition of sampling_frequency,
we need to trigger twice as often when the sequencer is enabled to so
that both banks can be read in a single sample period.

Fixes: bbeaec81a03e ("iio: ad7380: add support for SPI offload")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
There was some unresolved discussion about this when we were adding
SPI offload support to the ad7380 driver, but it turns out that handling
the sampling frequency correctly for single-ended chips is actually
quite simple.
---
 drivers/iio/adc/ad7380.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index fa251dc1aae6ab0a0d36792fa37b2cc22b99dfe6..bfd908deefc0f40b42bd8a44bfce7a2510b2fdf1 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -1227,6 +1227,14 @@ static int ad7380_offload_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * When the sequencer is required to read all channels, we need to
+	 * trigger twice per sample period in order to read one complete set
+	 * of samples.
+	 */
+	if (st->seq)
+		config.periodic.frequency_hz *= 2;
+
 	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger, &config);
 	if (ret)
 		spi_unoptimize_message(&st->offload_msg);

---
base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
change-id: 20250919-iio-adc-ad7380-fix-sampling-frequency-for-single-ended-chips-05bbfea8891c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


