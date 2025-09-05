Return-Path: <linux-kernel+bounces-803526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43944B461EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4CC16F25E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB69280A52;
	Fri,  5 Sep 2025 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cn5NjbNb"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E893531C576
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095970; cv=none; b=WdAEATgw9DGsBENneoIDTUPULg9ADNadQr88ujL3QHwGbHkhkb4wNdyqdTTkfzgOMX3z6GtqtoE5/5tGnSSba2VBy/U56Z1LiINs5KCNarX5xpVnapX+MLR5kueMCFIc58xe0lHjSPP1qBd2pVe4N4IzcPyIvOoJzoApgXyswXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095970; c=relaxed/simple;
	bh=bEX5lsWv42f0P9lxFUEB4JGiSJnlYwccISSJPVPgnW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BT32OSmW4nwDtmpEyi1ykC3jl7GmLqtrA4IPuq8WruvRdiMpierAcmnlRFWDSwPj+GjBGS8hwYfYix1wwjRmksWuXsYJe9DVkE9OacQbb2EczV4Qwr72A/TT+TZN9UnOFObhS63VHuESk9BAZ885sCyDVX3+3TUWjTK2wsPL9rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cn5NjbNb; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-315bb486e6dso2007036fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 11:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757095967; x=1757700767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwGy0PMkLWc/SggMpjeM/SSxNiNG4AhknUu9JH7miSw=;
        b=Cn5NjbNbkVUoViAp3lnYXE9wiWSYv80utUPv5YPd1VFezZFG5N2BfwwILOu5WR05RM
         zgOR+UuDyXCJLVBZd8vUpNyHObId7s6RWXpqF26y2VMNVFoCInK0KDT38FH5ElxVbnNS
         4evAbihzhL0fdgg3+okkPH7QgEW0Dq94NYvCmkLV+evi6CZjQGS2XvG9qF3XgBGTxs1z
         x3ASOuOFIcIGIFRCw1ysD6RCDtAPQKYzDpm3v7kPIZ3Ks/ZOoqC0T1piupqgxLaSiMtl
         BD232y1x+xrFme1ybzLq/vk9bYkM3WLfAR8tbSX9vM0R01ZjlXk/tUIjTaGkH50OVTMD
         6o7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095967; x=1757700767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwGy0PMkLWc/SggMpjeM/SSxNiNG4AhknUu9JH7miSw=;
        b=ZkK/Pv6nXeTZ/R4gv5zFfg3DZmzyXm3AAfScWapMJ9VNVnhJFSd6vR4Pm/f/2c5CTA
         Ysq9H1zT+uypzHDPh7bFb17CvmARQTcPXqKTuJue6Y5MX59It566mtCU27iPSpO3gqXu
         /DTfr/nBs6DWw5gH/LlrMIo5W22KFwnVymokUJalujBnBdwmll0utZnME7Bwi65xSti1
         MmNrK5zOIksCbBfYmqjH3h8pdbhjPfQHMH0jnkQpFVfEnwav/z6HCO/wGe3HrofYvoi2
         JyJsirEEaw8DfxM3MNqhthg0y3Hmf5HYTRFL+87aSwx9FutZO7heO9O2oAV/rkx5px/a
         9Skw==
X-Forwarded-Encrypted: i=1; AJvYcCWV5b5Tyr/HbUZkLdgVFeiqOm72J488wbnzgc1mmJhUA8WRSeY49zRDxuSjatBxxUmATukDDWdL32doguI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8R6Hcb57n9zYhlSLT3J2XF1MqnzvVCe3EmTe78v5aQRjBKJrG
	3MhtulhThKaU7vCU4s4aaopfsGGKT5E/9PidUxKmLwkxbxWzTlt9kLP0Srvyr4rZWQU=
X-Gm-Gg: ASbGncuU1BaQS1p4KwyL8ADfKvQEp9zc06xHf/9IL97wNFASfEZqdr3TdnC2mYCl1KZ
	FCu5PMMLL1EMMAuXsUOuMrqyUJWkQlCabIG1Cr0Hxe36JKtobopkYXkho7y1rGeUUqJKzMyEw+I
	/IkZMR3NKhr3uZJh3qqy+nBakcJBbPGhKS+HVKhN8EjUP/Nz6EXR5LpHnxfeIGfnGli05LfyPpM
	Rw2kBc9tLv+nKoXpcUIH3y4yaeA0Pww3BszcgQGnYPiQOnX8THw5wjvkYQILFdm4wFrxiwfpQtO
	xpPO066T7qITvootjrK7WYmWyE/2TGEcAl3mbfCLft2/pTDnnlbYc8C5HcwMLOtFxUrFBxs4dLD
	Yq13FEgL2Wtkp6CHlztMJ5SEX/ak=
X-Google-Smtp-Source: AGHT+IFETfk0c+71/rfkIaAQhcqoeN1xx7VWTTqo+tvrfNONZp00cKycE9KjbXq9WSp0xYJv4+MG8A==
X-Received: by 2002:a05:6871:68f:b0:315:2d27:447f with SMTP id 586e51a60fabf-3196334533fmr11887579fac.31.1757095966853;
        Fri, 05 Sep 2025 11:12:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-31d686398e1sm3052292fac.13.2025.09.05.11.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:12:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 05 Sep 2025 13:11:57 -0500
Subject: [PATCH 2/6] iio: adc: ad7124: use read_avail() for scale_available
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-iio-adc-ad7124-add-filter-support-v1-2-aee3834be6a9@baylibre.com>
References: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
In-Reply-To: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2868; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=bEX5lsWv42f0P9lxFUEB4JGiSJnlYwccISSJPVPgnW4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBouyf6FwzYUArfE6hzEym3sg1jjyRs2aRZ+M3OM
 ELov7al7wmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaLsn+gAKCRDCzCAB/wGP
 wMbFB/9xwjR38TbZF6CmFhGtV3N5s6jTnohNEv9mkCf/3XKhGiFOW0ffGffJBWnMwrL3xKW+6Hn
 9X3Vbk6ykG4oxmlqdm/k5rRGTRrbwel5DLrTurCHxKPAWm/tboz/GmJdmwqa9k5Ej2jHvulFfPx
 qRA0qDDJj8ekUqHzZxQY2dhVjYeQXrnJ2CEsjTNNlcJMxpbmdQ6HybGhOmDwR4baH8eAVDJzXYu
 4it5IX81dcNA32DskJMHMKJbxrx9qf9yKPmW4F4YnKnJMJIpfEzohgiwn3cD6dXmx7EQrml2Txq
 35WLJFRb5Rwf229E59rXoE0GkYKk7tbQKiat6FG+ScQG7nYR
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Replace custom attribute with the standard IIO read_avail() callback
to provide in_voltage_scale_available attribute.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 117777fc8ad05b773da09c113cf84927c75d6b7b..6c17cc59f33c6ddc241e94d1b0f43bceced1e719 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -623,6 +623,33 @@ static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
 	.num_resetclks = 64,
 };
 
+static const int ad7124_voltage_scales[][2] = {
+	{ 0, 1164 },
+	{ 0, 2328 },
+	{ 0, 4656 },
+	{ 0, 9313 },
+	{ 0, 18626 },
+	{ 0, 37252 },
+	{ 0, 74505 },
+	{ 0, 149011 },
+	{ 0, 298023 },
+};
+
+static int ad7124_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length, long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)ad7124_voltage_scales;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = ARRAY_SIZE(ad7124_voltage_scales) * 2;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ad7124_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long info)
@@ -777,18 +804,6 @@ static int ad7124_reg_access(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static IIO_CONST_ATTR(in_voltage_scale_available,
-	"0.000001164 0.000002328 0.000004656 0.000009313 0.000018626 0.000037252 0.000074505 0.000149011 0.000298023");
-
-static struct attribute *ad7124_attributes[] = {
-	&iio_const_attr_in_voltage_scale_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad7124_attrs_group = {
-	.attrs = ad7124_attributes,
-};
-
 static int ad7124_update_scan_mode(struct iio_dev *indio_dev,
 				   const unsigned long *scan_mask)
 {
@@ -818,12 +833,12 @@ static int ad7124_update_scan_mode(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info ad7124_info = {
+	.read_avail = ad7124_read_avail,
 	.read_raw = ad7124_read_raw,
 	.write_raw = ad7124_write_raw,
 	.debugfs_reg_access = &ad7124_reg_access,
 	.validate_trigger = ad_sd_validate_trigger,
 	.update_scan_mode = ad7124_update_scan_mode,
-	.attrs = &ad7124_attrs_group,
 };
 
 /* Only called during probe, so dev_err_probe() can be used */
@@ -1013,6 +1028,7 @@ static const struct iio_chan_spec ad7124_channel_template = {
 		BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
 	.scan_type = {
 		.sign = 'u',
 		.realbits = 24,

-- 
2.43.0


