Return-Path: <linux-kernel+bounces-812904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7939B53E02
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A07188A8AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185DE2DF70F;
	Thu, 11 Sep 2025 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PqAxMzHT"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA142DF3CC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626979; cv=none; b=qgOl1OuCGJviHIv3KxPV/LLkbZoR2RlDcjT4aR0fP41rSQIn1C075mA7EbHx/ri1YdPK1vdKjFP4/Q5dvC48TCb5XXfnYZpuxc9beJosObh5eO1o09IncgPKewz8SySWrSIoFi2UELkEVLckq4Y14QRmLaggdQ7hTFIdPiUeauQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626979; c=relaxed/simple;
	bh=vky8ZBYH6Ai0NSmG5ho3XsINbssqMEB6+aMv2/QM2u8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NUPUZh9jUUh/hu/hyx0zYVJu+EpjVLOSRhTRaTxOO/NJ74OGogAM+hjpf4IOsmg7P97v6qrQkwfJaPpv07ebgMBFsHzdzJhUxqJMATs1HOgRyGHzsE07B2QLB+rHM9WftkqnjCK8PkcnaORvMPxGPj7QpY61k5El7w6v8m/oMqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PqAxMzHT; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-750b77699b4so1068947a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757626975; x=1758231775; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRGV/5JAWSAB321ugkVWopex4kAcYr4Tkq9Fy877fY0=;
        b=PqAxMzHTks6VHCV140r+T4WSEkfZYjJAq3ZGT/Ugi08MB5SnNkFUxqMu0JLKLt+lL9
         xWdWu3FAHDdJN6eWutHbraZuEBypeIM1F5nSPSsjdHTRJIDfYFv8YpcC8b6+4NSdIIkA
         GikIz/pG347GgGDcyD3ae1GK/z004YMwRKhUU/HtSD7/SiiNLXrOiQ0YxENkIftdAX5t
         cLTEGTGxBSXzIUwvy2Ass3gluwKNl5Zs9p8iMx1NZ5l42NYjWp8v7p8Ocg7LmUxcjmuk
         JUcF8I8hpS9ERmuybpGANqjgpY1n0hOfs0dDL4iYp6cAuaEGfja2eRgjdcBrYPJBX590
         Nx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626975; x=1758231775;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRGV/5JAWSAB321ugkVWopex4kAcYr4Tkq9Fy877fY0=;
        b=FlOWzuc6JhYTxAJZYbELXwMyreM5jpSrQ8RE5mS+bYrvYTknVYudx2jJxkyCCW8Zmf
         alc2Abthvt+ar2yfJlrfnR68mYXkQ0ABNX6trRiogmVC70E6np1pHKgWhrvSd3vIkwXk
         fHrOjfNwJExtB2h21PNH8JNEXmjPYB48FIauSWLsFt90J+pg01KrT4J6UD4N7+YWDbkH
         9gjBWeme0+1s4Tl8amTTu+AAeRTI0FfRCSLLRjQZv0BvGUELCg04v65BW08HfGMiW8CK
         hZYDy3O4UrjJKAqSlOaDKnlItjdsghDoLa/inac8CX6se8DEtQkgSeDaitRIVCWY2TxF
         se0g==
X-Forwarded-Encrypted: i=1; AJvYcCVCNST612itSPz1pAm80HTIfaup4MUFU95xY+6hb0eE4zSfA8ojMWfbHOIKd2wC2DusNzyExwitXekF/EM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx86Snrkzxan8zAPEfconvfveLQKsg6tl8AdTwF1teojWKn+Wdn
	+Rd3/RzWuvHM8wLW2yhOHvrULJTu0Ubx5VX7dKxw44VNLcXNPkrssR753FeOZcX0d6c=
X-Gm-Gg: ASbGncvR+mxPrqeByhu0juihbe/O8wyPbCyTjnE0bC/MEPmiCOr6jjptcQMTYngiYq6
	boTYxWyyANVYBcgTcCaCC6hJHKQCPIhGfiv/iEKMcT1m2FCBT2fLrIvKw/+V8u/QI9qkw3PC2kR
	fD3Gh6Scy5rbYANIjPJjhyFGHBRJpnRZSSsE0yUcOhYqmdiNgVvfELFpS5s2pQqRVJ+TLY9nXAS
	vy0nPYRJzyF0woJjE0PO/BDq6M/T7B+EESM+8NO68LznwMD7my7vtWTJCua5iC2Ir8F8wXMvVUr
	N8jDW11Emh1cUb9WdUkJ/3tNB9uM8ncw8sYEYhAPjfx9mrHCPPOWdUe/7Yu5FtdHiLcjNGpHjii
	WIxEVvszZF6WrkLbBCno0eZTnNPntr64eGlHIhyE=
X-Google-Smtp-Source: AGHT+IGEl01KCALkIGqEs9Pw8gJ4WgOmRrVHa9jFPUfvAVcsjQNtiM2ULB9R/AkuEm+gstOYHQK5ow==
X-Received: by 2002:a05:6830:411c:b0:746:d995:4e56 with SMTP id 46e09a7af769-75353379d0fmr544332a34.11.1757626975017;
        Thu, 11 Sep 2025 14:42:55 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986a7c3sm604188a34.10.2025.09.11.14.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:42:54 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Sep 2025 16:42:02 -0500
Subject: [PATCH v2 3/6] iio: adc: ad7124: use guard(mutex) to simplify
 return paths
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-iio-adc-ad7124-add-filter-support-v2-3-b09f492416c7@baylibre.com>
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
In-Reply-To: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2323; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=vky8ZBYH6Ai0NSmG5ho3XsINbssqMEB6+aMv2/QM2u8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBow0JAk8XVD90CUzTjS0oO8Dv7bSp5UaygisRqy
 jfmR6XWqWOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMNCQAAKCRDCzCAB/wGP
 wAmoCACJcpjM4RHlzKsi4lK+w/6FqIKSLXSbFmiPHsuZ8fEVLarec1xnycx84N0zXdTazB6U1GP
 2ym0V+/13zQhHFIPl+DzxNQkOQov1/0FpuRK5JQj+VR6R1889PEt7qZ/biMosdMEPa8ZNrLTVxQ
 q8IFvK9oUMgO53wFdm1poJDFrT5qCYlDfD/jaXSdUyceF3KUKcTiACKi1y56inmBQdecDXGIUwx
 6GEfadpUhnDzyTxAoxbsJaLzDGGEtDSJaBbh5j1QHpHUK8hBndw2+vm6pqYKUuNR+YSYd5mcaQP
 izI755uedgLrLCcCDZiQZd7wQeNmnlRqdLZS4e/X87x3T/7U
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use guard(mutex) in a couple of functions to allow direct returns. This
simplifies the code a bit and will make later changes easier.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 97d601b3387524fe411cc0afc736618e32759880..3afc4dcc315e82ab822370ff8d21590086e0bc7e 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -739,24 +739,20 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 {
 	struct ad7124_state *st = iio_priv(indio_dev);
 	unsigned int res, gain, full_scale, vref;
-	int ret = 0;
 
-	mutex_lock(&st->cfgs_lock);
+	guard(mutex)(&st->cfgs_lock);
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val2 != 0 || val == 0) {
-			ret = -EINVAL;
-			break;
-		}
+		if (val2 != 0 || val == 0)
+			return -EINVAL;
 
 		ad7124_set_channel_odr(st, chan->address, val);
-		break;
+
+		return 0;
 	case IIO_CHAN_INFO_SCALE:
-		if (val != 0) {
-			ret = -EINVAL;
-			break;
-		}
+		if (val != 0)
+			return -EINVAL;
 
 		if (st->channels[chan->address].cfg.bipolar)
 			full_scale = 1 << (chan->scan_type.realbits - 1);
@@ -772,13 +768,10 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 			st->channels[chan->address].cfg.live = false;
 
 		st->channels[chan->address].cfg.pga_bits = res;
-		break;
+		return 0;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&st->cfgs_lock);
-	return ret;
 }
 
 static int ad7124_reg_access(struct iio_dev *indio_dev,
@@ -810,7 +803,8 @@ static int ad7124_update_scan_mode(struct iio_dev *indio_dev,
 	int ret;
 	int i;
 
-	mutex_lock(&st->cfgs_lock);
+	guard(mutex)(&st->cfgs_lock);
+
 	for (i = 0; i < st->num_channels; i++) {
 		bit_set = test_bit(i, scan_mask);
 		if (bit_set)
@@ -818,15 +812,10 @@ static int ad7124_update_scan_mode(struct iio_dev *indio_dev,
 		else
 			ret = ad7124_spi_write_mask(st, AD7124_CHANNEL(i), AD7124_CHANNEL_ENABLE,
 						    0, 2);
-		if (ret < 0) {
-			mutex_unlock(&st->cfgs_lock);
-
+		if (ret < 0)
 			return ret;
-		}
 	}
 
-	mutex_unlock(&st->cfgs_lock);
-
 	return 0;
 }
 

-- 
2.43.0


