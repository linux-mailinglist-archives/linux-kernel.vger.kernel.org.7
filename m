Return-Path: <linux-kernel+bounces-726572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2A7B00ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C809E7B124B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15D52BD013;
	Thu, 10 Jul 2025 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SD03mh7/"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F1C29C35B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187240; cv=none; b=LDyZoPF6czFsUkkZZaiAcf56bZiJFulGAXwaJyaj4fXCcbU1WZGsAmtoUNzBV9XJZfMafWnMTnB9RnX+FvQRDO3uaTN95hNQeb9ra2VBBk9FzY6ZOVVUZOVNpNSaVg2+/n/og3PQ8xqpSYqA0Z5GGWGCtOTewDHLenEWhteePyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187240; c=relaxed/simple;
	bh=MaYXwOVhgpK5Xi5DZi0kiBPz0Bgrh0rRZus9pfeI4MU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S96Z62bsF1YkW24h6ol0P41f+qC9kJpnKu2EKo4rj7XNGE5wK+/pH9YBAoAa8kbxLLwmTAah2vDIChOJ2t75RRHc1y1o/6wnLOqZoZfSEVspXAa9fVaB+BDV0adGqrDxvlynuppfuSrsNprglfctgM5Fu9FqPIS8aonGVLLry/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SD03mh7/; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-40ba3c10b3bso539422b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752187237; x=1752792037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cn3FuFolIz/oVPrLKB9jwmwj/1LLi3bqA0GwWnqdwBs=;
        b=SD03mh7/YN5TeWOyUNkBhg8L6KPpmbnIsnPsXFCMIETGsbQ5eYuwEpVdUnGvNeKvfA
         m0VL+HVJeT6aktlf8z+EcEN/cHqL1dXm1CxOqidpyORWpPLQVbSbJN1uqjRylL1kptk1
         Fi37/3q+/gZhdT08KcPwx4FNMtOT5MLaPQj3rKaHQqNYmmJ0RdzQ+7cnZ5WxKe6HiNY9
         wX9XorbJGfoFjgFjoabjf6Spw1DNTc4njZvnhIxoX0/djbBHWdwRNA+HFYmfAfcLnEpK
         wfpGuTdzO5y6g/EPxHLjxngR3Q/2sop7LAoBgeHOZzFtsrqxzKbwuaHn7bmDmSwPa17U
         DspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187237; x=1752792037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cn3FuFolIz/oVPrLKB9jwmwj/1LLi3bqA0GwWnqdwBs=;
        b=IJ6V63Ry6x8qjKW5Zhl9Owpo14+JXVVqcQeJJgl25AtHiGEPLZ+rWNUWjzFcRmJ3Xr
         U39XbxfjVqAGyRtb9LfGesvHt6mqdNGlv8CydRfyDS3qZyU15qL4E0RtChnt8FdiEC7R
         sgGPhMl8gtsrFkDjpCh1tUnuBTb+KodSeo1wreJ/9y3bUm084UNFBJGQHskz2dTI8ngu
         XdH9YWL2FT5r9ZvINQc9Oy5g2gsQ43Qz83y2GKL7NMQ/LOMyR5ELjXGR3lwkPg8RvRkn
         Agc16EarlfdqKUa8j+hLUFvlxmszZpmnuKh7ZCT7FCzB3pemoa8m2UKaLGLkEdqdYII3
         c5MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt0pGIYtDLL3uf46g3OrO7qy5G+eZHEuNS6JWwQKnOgIKdoDNWy9oZ6PgUNUb/P8FaY0wtGMCWcEcbGTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSNTEUqDzulzNbI5H6MWZwA721lX3tfdAkx81CQGhh2S2ZCFnf
	NJFLXu3U0qMax7o8lOxSqDNDG1MVN319mbbG34qUi1sia2l9kvG6EvCHZuQMgoxN7Og=
X-Gm-Gg: ASbGncuiaBY6YUKovuURitOUhc1cif6a/jB352hJyO8CsTit7MCeRyIBVeb55WGXdHZ
	eJ8/AYq6LAEC9KwmMQ1348zHIPzwh+41h1hmbYCrguBmG6yn86ZuSUOCUb2tBEmhcXRq4k2gr/Q
	hf9WcASVLHi97PZV8hy9bbIVL07FFD/copmt8ibhooxAGTGkNgtdFLwkGi0xcFk3+JBSer/wDwt
	La0fFDPCCKKzhW3HIc2rHJ4F3A/IgQuz+l0DULBTR7qcTPYXH/PkAo8RRLL4xpelutS51vFMjvD
	KTk1urRNudaVxyfjhfMF2cZW6jUyrb6GvltiW7Bg7rMD9IMIrxU9BiZvh7fy5E8H++7cPMDwDm+
	jHt8hVF90FubI9zgABCELyzWfwg==
X-Google-Smtp-Source: AGHT+IHYUQBd8GeQ+9Tb5ObCJT4XR2tTpt4gxlV5blMQaypp/KU5zeE7veLWTa1cVd6iC+qH7UKS5w==
X-Received: by 2002:a05:6808:444b:b0:406:6fd3:ff14 with SMTP id 5614622812f47-4150f4bfee6mr1026731b6e.25.1752187236704;
        Thu, 10 Jul 2025 15:40:36 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:891b:7836:c92:869])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9d950f1sm305944eaf.18.2025.07.10.15.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:40:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 10 Jul 2025 17:39:50 -0500
Subject: [PATCH 1/5] iio: adc: ad7173: rename ad7173_chan_spec_ext_info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-iio-adc-ad7137-add-filter-support-v1-1-acffe401c4d2@baylibre.com>
References: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
In-Reply-To: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=MaYXwOVhgpK5Xi5DZi0kiBPz0Bgrh0rRZus9pfeI4MU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBocEE/eU1VlTlQKHR3pqsR26n9yqGb/IAQ3XTiT
 cAPJqfD+tCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaHBBPwAKCRDCzCAB/wGP
 wA7WB/9l/qvw969ULrPF3r4bQGB5gCkZBseIzNoyb3Ug2CjJ4ugerY7zMKfWU7tj/ppD37ti27D
 u7azLTGeGyjiYjzFlKVxSpLAPScBoE2a8MXkXoQ+1TbLyeufImoccg0pxeGFRX+D/DjqrX3gS7s
 36ZEWZ+j5Yt3506NfSSU6Ao7+yzKhlufkKTvsrVRNuR6dlO5yn0kwomQ9H7uFL10bHUPM+ZcVIf
 dIkYkiXEHySCMYE9bhLP28VYwNopnBX53OBJ0EatcRip0y8O7/gPO5Rio88HBNSipCmwEyhZgJL
 F8qxOUcZTpLOeRejMev/Bm/stOHkzTrm11E7z3lpKCUdmADA
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Rename ad7173_calibsys_ext_info[] to ad7173_chan_spec_ext_info[]. This
array is not limited to calibration attributes, so the name should be
more generic.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index ed5020167089ab96eb1927c9b1ae207e36f8b9e7..5daf21c6ba5637b2e47dcd052bdd019c3ecbb442 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -369,7 +369,7 @@ static const struct iio_enum ad7173_syscalib_mode_enum = {
 	.get = ad7173_get_syscalib_mode
 };
 
-static const struct iio_chan_spec_ext_info ad7173_calibsys_ext_info[] = {
+static const struct iio_chan_spec_ext_info ad7173_chan_spec_ext_info[] = {
 	{
 		.name = "sys_calibration",
 		.write = ad7173_write_syscalib,
@@ -1399,7 +1399,7 @@ static const struct iio_chan_spec ad7173_channel_template = {
 		.storagebits = 32,
 		.endianness = IIO_BE,
 	},
-	.ext_info = ad7173_calibsys_ext_info,
+	.ext_info = ad7173_chan_spec_ext_info,
 };
 
 static const struct iio_chan_spec ad7173_temp_iio_channel_template = {

-- 
2.43.0


