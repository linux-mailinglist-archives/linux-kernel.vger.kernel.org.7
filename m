Return-Path: <linux-kernel+bounces-726575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E83B00ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27711CA76F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E6A2C3745;
	Thu, 10 Jul 2025 22:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lygnHjyB"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192BC2BFC65
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187242; cv=none; b=GTIeLLcf0+WqHufXaXnHftk837GxRMnOLwYsp+vKnLWVDpWjIJ4ptNCtEWnBTy9f2rJlL0+qLPTadwgbylsFf7NYqRENZVqCrTPBq9cmpYXaE8oqh+YowAZHW3NbOSZSJYsdFtmiOm/ASlpXfHGK9ffv/4mUQ2iSrMoazVOrV+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187242; c=relaxed/simple;
	bh=IJZKvY6FBhurwS1AU0uzFel1FJe911tg+2DmrcpgsRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cIn0O7MF59aEkGBuRAlW5wEr6LLn192DebdL/EfQK8wYhIyhl4935tG8CU58Nsw5xwjWv1rqt7Hhjn+O/cXiVADobLKFHy7csVd9ZmH/bcrLj8r2sAzYLnkt4Pj1vd6Lx+L4iFct60MUjnahjiybZgHVqQo6uCqdKrPeJWtbnVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lygnHjyB; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-407aaace4daso613798b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752187240; x=1752792040; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=om7b5uZ8WHk1bPibPL7QZXk7ri+VTy/kb134tH/V9wI=;
        b=lygnHjyBosaBs9UF3etlMLBnr4/doZmaAqU7/cfJlqxj0RHBXJ0+bf5DMfu30rVJpu
         J1ykBcaygpMDsFWYKeOFgeJwYRyG4qLjTvtZWo1pyK9hUF1zS2QX7d3N1sJi410TE9PF
         /8sZ16b6td8FRMsJZbCN+W4i3pMg3EzWpTOH+oq8iFvXhN51VfvGtLromyj2tSuBTLqt
         hoAnY8M3nyh2sdr9hqTQlzn4YpM3sfIA3m459PDqAaSH/8T8tP/c/JBZv83bFqfYHeVH
         6zAx9ZUPRvjHg/Hb8PvzqivKIpCWFxk8KG0pUfFOhKySWRoJXJNxg1HNhynQoLA4SNbh
         4LPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187240; x=1752792040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=om7b5uZ8WHk1bPibPL7QZXk7ri+VTy/kb134tH/V9wI=;
        b=EvqqNznH9nkcE/tT3zVaBzYF55pgKpZAsMWcJZ5QIQWtVH6T86LV833m0csWKvcL1V
         sldM4ISbtzKqD9QuzrdR5gOurrhfTMRmwDf7O3b6vHfUXk6T2Y7mdnDjY+UzdclIcSQ8
         3T41laV0snjdJQjF1BpnmAXVTd6fbNr4UlNAM+dhLBTTxOClr7k2bnzDiqT/n89DI8oh
         dRoLzOQa7dAVsIIeniC3f9lDTk6zG9B8THrXH+WUSPM6SyPomYjvPE+wRVKMPNN4opnx
         YIKJQLoe3YrBGq8wIqEWS/RO8l8FqzppZYowLR2AAkKgWZkfAXyD333vfrCLNdJKpx1U
         L8sw==
X-Forwarded-Encrypted: i=1; AJvYcCWmTlMbjNNJwDLq17aCjjhf76zV/LRUUH6noSPhLvH/VZ9eq2QFddfQTHuLtlFJP+/vHljyNXhZB/0nt5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQIIhUTJV6Ropg06DURVqZ4YV8fZM+qjx6FgwSx7Ac+8q8PEGg
	ME7+xizqfM+hrDXBXBcSeX6uKqGVCUAlaJr45OMRZ4BilyUuUDrzKfJgARwIAYuE9D5p6D5bgnQ
	TyAWcspw=
X-Gm-Gg: ASbGnctEkDKp4WizOa0tg+fbpm7Csw7HwfSaeuF7lK5nAhbp69HhtHUxXop502n1DTS
	h80Xfc+qmGcZ0Yzf9oLN9n+9PP7aVSKplF2NI5IVflqMST9v15aT7v6MWekl7E7KLtEW+2fDyvv
	d9kBvAY/mEi+YzHkLIPwRWA0yGTRZqN5oKfn/n282s7QJbtG5MNT7vqLXl9J3dzCuupHxdUAqCW
	Q0D5CBGeOpRCitZtWtSNNDMHlJJOKGN4+TgVYjqgkEpCfzcVQsMV+KMlJOxxf2kl8j0dWNFKfHT
	bdxPUlCyasQ9lcgiFpltK5ab6aFVUnwi93zjCPFbYhfBBihF5zZL8MXEzijAipw20t1rEG6U8II
	FVLbcLzZuQGPwpJL1K2GBVl+RSA==
X-Google-Smtp-Source: AGHT+IGV6HBrFWz+tHpNptE5u87WlNfv9fSRMeLEg9obnOkAgSX/3KrF2tqOFqyPzQt7UV8Nk5GuIQ==
X-Received: by 2002:a05:6808:3006:b0:403:3c95:3684 with SMTP id 5614622812f47-41537566dd0mr443537b6e.1.1752187240141;
        Thu, 10 Jul 2025 15:40:40 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:891b:7836:c92:869])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9d950f1sm305944eaf.18.2025.07.10.15.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:40:39 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 10 Jul 2025 17:39:53 -0500
Subject: [PATCH 4/5] iio: ABI: alphabetize filter types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-iio-adc-ad7137-add-filter-support-v1-4-acffe401c4d2@baylibre.com>
References: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
In-Reply-To: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2034; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=IJZKvY6FBhurwS1AU0uzFel1FJe911tg+2DmrcpgsRc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBocEFTOhSmUKEQ9LoHSdk245HzX8F7z5dzSMUAS
 l/m2GBOQsSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaHBBUwAKCRDCzCAB/wGP
 wCVdB/98NLFD/0vupVh2gFzCrWI+k0DI8fsPAQGcjrM4TjOUsyuqZ/7b3wZI6JNZ3S2/0iVzo4b
 S9HVqWHcFUrYK1/qJXVtMIhd6zwF0NyTA67D+AHAScySjRPoJQGIWw0vvpgUu0v1fxwSiMMKPiN
 63Ic1g8UPXEwKVhguxYlq1wdd2ueXdpwP89Hcmn8mzXIYmcUns/Kn9xmL8TcQFoqdWOGxIVfCfE
 vu22WpJ++7+uhepGjRPev6CY523rhsBWlSLHGYH2TnmxaNg1guUpphnEiflTr3SD5v8GJh56iOW
 E2LbG/lT5GqvRUp7KqK2xgMxv2oUOGDvWAPdH7Ali5wyu0gC
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Put the filter types in alphabetical order by name. This makes it easier
to find a specific filter type when looking through the documentation.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index fcc40d211ddf388ad70f489177ba2fcebdb9f8dc..3a13596b6eb081483a1f45fb0c446d2ab3b4c708 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2307,21 +2307,21 @@ Description:
 		  conversion time. Poor noise performance.
 		* "sinc3" - The digital sinc3 filter. Moderate 1st
 		  conversion time. Good noise performance.
-		* "sinc4" - Sinc 4. Excellent noise performance. Long
-		  1st conversion time.
-		* "sinc5" - The digital sinc5 filter. Excellent noise
-		  performance
-		* "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
-		  time.
-		* "sinc3+rej60" - Sinc3 + 60Hz rejection.
-		* "sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion
-		  time.
 		* "sinc3+pf1" - Sinc3 + device specific Post Filter 1.
 		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
 		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
 		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
-		* "sinc5+pf1" - Sinc5 + device specific Post Filter 1.
+		* "sinc3+rej60" - Sinc3 + 60Hz rejection.
+		* "sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion
+		  time.
+		* "sinc4" - Sinc 4. Excellent noise performance. Long
+		  1st conversion time.
+		* "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
+		  time.
+		* "sinc5" - The digital sinc5 filter. Excellent noise
+		  performance
 		* "sinc5+avg" - Sinc5 + averaging by 4.
+		* "sinc5+pf1" - Sinc5 + device specific Post Filter 1.
 		* "wideband" - filter with wideband low ripple passband
 		  and sharp transition band.
 

-- 
2.43.0


