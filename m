Return-Path: <linux-kernel+bounces-803525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF9BB461EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D281CC462B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9B231C588;
	Fri,  5 Sep 2025 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sSiolotQ"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDDE31C563
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095969; cv=none; b=jUYKfS2C928U6XUqLWpVqtoVIaEdjB8bCpyXl43/+9Ws4y2NrdtCj21OgQztxALqnHLli6JWzQXkgDNJwAyc++xXTJopwacBESSkLyCG2ZfsPFgkvEEvte/htv9Gug6qVJdLZ8HIhqgCUTAZX2ElqFJALCbxse6qNvZIkM2BeEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095969; c=relaxed/simple;
	bh=aRfBzEhu9pJri4r6TxRz2ZjFBxLSwzNywqlNQlQhkbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVD82ftTugckcPWFM2NtcoXxuObA/uLQeSOnoSHHBV/DFzzoKRSfs+mmvLzXtq4T9RSF87mnIDrp9uLy47el+E9TL/mLeMYKw9bwc+Uk5u3nufDmB96cp1XpsEIDROW75oays4sy4ze8dT/OYwJyvYTpzThdIqvnmNqG6X9myTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sSiolotQ; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-32170a988a1so545789fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 11:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757095967; x=1757700767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Rel3qpsff+gDGTMnN0Ax6EW5tJ8mX6ZG/EwN44Ue6Y=;
        b=sSiolotQ78ML35Q1d1qfRZqAWX02ov8ayKFeBDK/J+rCE8DSwLyzA7e9vLGpSb8pUj
         /EkaXKLOBYbQ3LkxXU1aECQ814bCcm/pVprYRkleYXhyGF9WDG09vpeehXEGJOpqtvud
         4RwYJal/Vft/RkPvAS68dPzec9AUaY0PgHTjOEf9DW0rCYd5tc0d+jdMJ3W1zKPS6+7J
         F9Dw6/6G/iDlYp1DLFSyY0AqHKon+dRrnjbJwUKgxoUFQW4Pr+eG4qAhDp5zld2iyIoY
         lPBURpNoitZK6NSUDZj0Hti+/Qin/0jqmjgVMLeqUxTy4uBRwyG9V67sw/QMgTIuwOiR
         Qyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095967; x=1757700767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Rel3qpsff+gDGTMnN0Ax6EW5tJ8mX6ZG/EwN44Ue6Y=;
        b=jPsQ4pAcn/uCH3IKrFCb5a48bN7cIc1re7MRD8BsPPEsL66It/vFlToowPKTD7V06o
         7sOPIC0lLihByipW5+2gMSvZzXj56yFMMecTOMmBw7/SGEqOkUC1fMeRXbjkcE0FAdH+
         lNwSYuoLWDgFhKpPuAgwmf6U+asVvpCNKhKxsIomm0mvEu6kIEP9xKrULpuUzCSzzy85
         FtZwaC3ZRyZ7wnhQv+WY2E28c16z8BllEdzChp9J8li0sLahX+d2+tLVsidbHc1OR6SW
         sD9huCwgRgVrN5hXZGBt7gSP5uXWhWmRMNL9rRa/rebAepKneqtlC+2eR7eQZf4TQDAn
         qHVA==
X-Forwarded-Encrypted: i=1; AJvYcCWSZFM7OuKxgvvYqeK2yVhDdqmnnHG/gRk20zOhIIhRvSJ+hrRsy7xw+hm748Ry3COejGj1lFu+3z01mTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfALWZoybQhydM0s/DtM2QMpgXgOKtQMtMfLdAFY+3ruYdQBOv
	hzs5tYEufI5ZSMY/DeuvIb+kJY9gD+cLD9HzPl6ysUrG0HVr9Dzo/zRVEWs5OVD5t9Y=
X-Gm-Gg: ASbGnct+ssoupGLgH1sHTL24uO1iMBusBS8/lzxFVwtVhlh3FTAF0WpVpIJExd2K3K7
	4tGBonUwD5YVLQLrBePhhwQJLwXze9Se4JLEL2/SYGmu8vaMEnH1MVbPHlgz5fZSgnnBAomLJxU
	W/vwT6NDeMfjNJQ5NcH72ktoxiMwPV6d9BQiWzJYqdaEH/VtDPNnrP+Mu03nGVOSnTVQhdc/2M3
	B1tolB3IENFv+6rOr97exBuw8V4REU1cVhFZ6LEg8GR5F9/g7s9tR6DSZLxQxfU+71VDX5gmGa0
	z30mAebQncTjux2Cz3iiV+fRzeCS81Ao4GBg2j7uLH/EmB70Q/w9mm8kSNknE7ExEG0s0ckcycf
	3ggLD2uT87VdHxEBvgoZDG9E3c/g=
X-Google-Smtp-Source: AGHT+IGqggS7ImmH+ozn+4pHmV0yVb9SKPD6zm7ihmdJjtBN01yI79Prlbl7ZlaGcmfJAzqIX3im4Q==
X-Received: by 2002:a05:6871:114:b0:314:b6a6:688a with SMTP id 586e51a60fabf-319633cba8bmr10194612fac.42.1757095966053;
        Fri, 05 Sep 2025 11:12:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-31d686398e1sm3052292fac.13.2025.09.05.11.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:12:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 05 Sep 2025 13:11:56 -0500
Subject: [PATCH 1/6] iio: adc: ad7124: use clamp()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-iio-adc-ad7124-add-filter-support-v1-1-aee3834be6a9@baylibre.com>
References: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
In-Reply-To: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=aRfBzEhu9pJri4r6TxRz2ZjFBxLSwzNywqlNQlQhkbQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBouyf04cLLwK890vtIhWNBsqRs22IatbAYDNJzJ
 HFtVhBFMRuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaLsn9AAKCRDCzCAB/wGP
 wKnECACA92Gh+z/nR0gemOyoVcCM6t20IP9jDEYOOkB9GQPL1fabyAMAaqJ/xrkFeu2p0cu6a8i
 XRZYrIo54EAEz5+NFyt+wGuXyLzgqmsu4ZGIuEpUV+hBtJ5kjEwf0GGejP2lWP9BqzjmrlLe1Ug
 bW91kC3W3RS8/PwSnvM317o2+zzBDVzjcG7UdMjnTVbCBdDho1WGNnQ9HRsYV7ByBRkP5LmjnpP
 zNj7ZWgkU7pNMquiBQvv36aAVDZIktYC0m1O/5UqMhhqGLzShDmc82kbkto7g8DJA//ZYcqFzXf
 IkZZ6aOr+734VbjI6TM9CJY6/Sh8K9B+iMfl/A6wLHdI2d7C
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use clamp() instead of open-coding clamping.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 70f458e3ccc12db884dda9003abcffdf48989e5e..117777fc8ad05b773da09c113cf84927c75d6b7b 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/kfifo.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
@@ -301,11 +302,7 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
 	 * FS[10:0] can have a value from 1 to 2047
 	 */
 	factor = 32 * 4; /* N = 4 for default sinc4 filter. */
-	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * factor);
-	if (odr_sel_bits < 1)
-		odr_sel_bits = 1;
-	else if (odr_sel_bits > 2047)
-		odr_sel_bits = 2047;
+	odr_sel_bits = clamp(DIV_ROUND_CLOSEST(fclk, odr * factor), 1, 2047);
 
 	if (odr_sel_bits != st->channels[channel].cfg.odr_sel_bits)
 		st->channels[channel].cfg.live = false;

-- 
2.43.0


