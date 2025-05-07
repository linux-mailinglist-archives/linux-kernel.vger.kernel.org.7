Return-Path: <linux-kernel+bounces-638750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331A3AAED3F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 22:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70553B20151
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 20:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FE128FFF0;
	Wed,  7 May 2025 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ybQv8gBW"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877428FFCD
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650631; cv=none; b=GxCmZaOeJzvsNYWlt6j2e3t3toCaNVx0UJsqnpAGWtbSrUTUIdxmmUnyXiTzOHQuDuh6fbExijxfnN95prj2OSvY++5Q/ay7nI5fKZKBLRQcLRQlgtUn6FBoTEmaAu5J3fD/aLX7Q7t+ez+4xIxd6soBbcxA4gaVMiinphU8WE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650631; c=relaxed/simple;
	bh=qTxxm8SfPufoyQPrSsaW7TicDEaOrmpRvi6YmXZisJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eopWgv+NMdmnF2pjdmqgek7gU/m2gjM4Hld5TGY2RQIm7kMNS/+WJIMLOQfqagHr4KjUw2MP0xuWdL2ZIgeDXubbPZSRejRUG4GfrQZNG+snXZCVJk+4CONl37CvmCRbDov+wTTVKe5YWrQtEhRcA9l6WAzLv3CxfMLmK5X3QPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ybQv8gBW; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2c2504fa876so169387fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 May 2025 13:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746650628; x=1747255428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pd1rWEvK2H4HurtXzFWa/x9Szbu0oBY1TfY1+UU3AHc=;
        b=ybQv8gBWjSUNEdSDY7GyPVL59jR7GAG0qUOyrmNwgHCWam1Ajbe9M5YDQDMekrhOtA
         lKQ9do8IvjHYN3gdPqbOlYQtTq8jsSeulauSUUtzux9R5zaxUT4141jPnDytXs9L/3A/
         KoLObW42+uLJT3oUpBKPXw6b0VEtLD9JM2gfBYSmqYTZ5d6vhJWb2VW8qISV7c5AOCyi
         DdM6v2B+UrpWZpxIkw0hXwbPjJsVDiwFekDIZcuOB1Mnu/q4/FVRGzrKc6Ce04rMv9Ur
         MDHqV5hHdb0nsigYviTTukfrP4OjWjkgyirGOZaOhC7ImindJSMCWLf3r4eBxpYckA29
         ZwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746650628; x=1747255428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pd1rWEvK2H4HurtXzFWa/x9Szbu0oBY1TfY1+UU3AHc=;
        b=qjm1Dx7ccQkANJoPaFA+ID2DMcSDM7HWwYIZOYdu50f4hBs8SULWux9UjSbUmH1gLJ
         riLLs10clWnR/kXhqr+quiMrLmblzQZS32C6SZ16zJ+gJOF0ZYJvY6rTnVoknxi+dIge
         vmHm3mfzZsxGN90jiDurqYujGyBi95Kxvs0O/Lbl/M6lFNzugzlu8qhgAyJD9wtMzq5u
         wpto7nBSUK/LM9daBsBCXf8TDKC0jFhIAnIghiGdKUbp9Ln8eU8tHXmD72FhBALJFknV
         X8R1UjeYo4UEgYsmALfIoWKjInKv4dXgwzl9CgRia3e1mmXs0EEOyKDU2quXP3t/NRay
         uisA==
X-Forwarded-Encrypted: i=1; AJvYcCWSC01xYWirz9lfYQSOP2I4oAAi0ufEzlI3tLTMyvexiu+w++gLM1Jt28aVp5xkKdWt4Lmno6G54gm6mT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Hv01wc/0eqXiumbxBH80iu4VLosxAFzPE61EqkxylkHZ92Dw
	diPJ+K111oIG/w6K+xxYky/EtcWUe5DZueM2YnPStN4gddI5JZFBbqy7nFDnBug=
X-Gm-Gg: ASbGncv2a6zZ4WMcDzfNqf3lpX+ac7+N4xJcV+rJbMYBthtV5+oEqQfA7TkHbb4cymc
	2YnwzL35zpP10b8BCFjTf3tQi7ld2xaLZlq47eADzaXS8HLF3us9VTMXjFtmQRjwEb/pZOE4rJL
	G05SLkVs9Dtl6ZuPnbD6RtS3m6ANIHT6HEbte3a0zYrmlVMtKZm5za7Ai5gs4XgLjQQQn9//25/
	/2ETeAB1hksbXPvCTcYJsXdkd344pTNzmPBZjYgdu2R11hMINHNnKf6IYPM0XQL2vNV0pycMKt1
	Tk7NnF8HGD9msiB9I43NOEQtPYtIymBE6RuZZIxo+ha0tg==
X-Google-Smtp-Source: AGHT+IFG69yhKzeAewFZifPcUv9VhJ1g9tWX1TCPK3VZrLJYfK0PymFFMWYMU/UQ1P6qhCb/J4P36g==
X-Received: by 2002:a05:6870:898b:b0:2b7:7abf:df6b with SMTP id 586e51a60fabf-2db5c0800cemr3373849fac.26.1746650628324;
        Wed, 07 May 2025 13:43:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3356:f6f6:bf76:a32])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2db5cd716d3sm898642fac.21.2025.05.07.13.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:43:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 May 2025 15:42:44 -0500
Subject: [PATCH v6 5/7] iio: adc: ad7380: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-5-4aee1b9f1b89@baylibre.com>
References: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-0-4aee1b9f1b89@baylibre.com>
In-Reply-To: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-0-4aee1b9f1b89@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1297; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=qTxxm8SfPufoyQPrSsaW7TicDEaOrmpRvi6YmXZisJ0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoG8XlBguqCmqtDIVqJDkB9dfLXj5+9lqxiP29V
 msICqsmsqaJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBvF5QAKCRDCzCAB/wGP
 wPyNB/4w+gWujWX4jrqO+DhhHJDthKJLkpfmKOfGt826Ejvq9ojUsmr0EKTXXTuQoDDSteDB83j
 232ECMEEZ1/KxZMYGwRwHiM7Ql44o7XJVgtVi4/DjdGE9ifE1ahwNlEGqa47IszLrZdnK2RpumW
 1TuYPeS83q/0utvHbfyguuS0I/5Y22fc2zz05e3brqnNH0DdRYqEafq5YI/1W+xHeUgqLJeBrYi
 gpkXbPspkbP10Fa7K0EccZnti/onu6l8ieO2a8V5z3Kia7EVPO4B9snycru05rcE4psJ0OZcwJY
 AavywEoibXqRuD1VIRuAezcdL4J+GPfOlgNCxhb2k8DLea7R
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_DMA_BUFFER_WITH_TS() to declare the buffer that gets
used with iio_push_to_buffers_with_ts(). This makes the code a bit
easier to read and understand.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

As discussed in v1, this one stays u8 because it is used with both 16
and 32-bit word sizes.

v3 changes:
* Use IIO_DECLARE_DMA_BUFFER_WITH_TS() and drop __align()

v2 changes:
* None (but I messed up and there was supposed to be a change).
---
 drivers/iio/adc/ad7380.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index f93e6c67766aa89b18c1a7dec02ae8912f65261c..ed5e43c8c84cfcc9c4ce1866659a05787c1d6f5e 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -909,8 +909,7 @@ struct ad7380_state {
 	 * Make the buffer large enough for MAX_NUM_CHANNELS 32-bit samples and
 	 * one 64-bit aligned 64-bit timestamp.
 	 */
-	u8 scan_data[ALIGN(MAX_NUM_CHANNELS * sizeof(u32), sizeof(s64))
-			   + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
+	IIO_DECLARE_DMA_BUFFER_WITH_TS(u8, scan_data, MAX_NUM_CHANNELS * sizeof(u32));
 	/* buffers for reading/writing registers */
 	u16 tx;
 	u16 rx;

-- 
2.43.0


