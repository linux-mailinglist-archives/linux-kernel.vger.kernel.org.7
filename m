Return-Path: <linux-kernel+bounces-726557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5992B00EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B433B1CA4760
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884E029993F;
	Thu, 10 Jul 2025 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C7ArjtEe"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B014884C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752186134; cv=none; b=TS+eK1G1Lo4MK0oRlcrvzJ/AGl6ayH8+EcSBJRHCUH9AGwBxzj4Ty0Xo1xwH3+8LrXL03wobyWlX/348VxMmIoIbp/BxgF5zWFxuokI9tqSBSqT0yP38YjYH0mJfh7CzIRa7YEqAE36mU+PpCRhkT8+Zu6CsCPsFaWaS086tjgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752186134; c=relaxed/simple;
	bh=SsrP1cgk5ZxHAw1T5LxKC2jzRBKUCL3UkePoEJyRuqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=i7u/7pSiPjLTlA9Hls8KmT50sMIr26Ij3XDtSB9IkkupovS26fr1Yfy3Uv6Zs7Qdrglw62P0s6SAT8vg6AXNRJYFH+wxo6DoC6+z3XpCrNrrH05LNXY1GBYPM0AcSU7IQPW7VmSm/Uld8LlwJAFMhY4dlofZfK11ftTqqYrK9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C7ArjtEe; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-612033bb26cso629828eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752186131; x=1752790931; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kx73u9VXSxci3zVsfu1OAUwwaENWROKjKLvmUe4fglc=;
        b=C7ArjtEek9xwxd5fuP8Dvcl+vL8UwtRqL8hZpH+dBAi+5+6r9NtdjXvRfg3VuSFnOf
         jkfuKWR4o1iSzY/Z4oEuWmjTSRRXGiulTfmmRfhlRE4kqMr8ULoVpXfaJtio0NkWntoc
         JyldGSjnsB5Q/Zid1HPy9isnytGAYl1BkMyoBAcF6Ry01fs6LrMOIr58oWe6MrCg+Dm2
         NhOm5pMbm/K9zlyfpEjglz3fUffda5rtAkW7tJfs1tf5QjnS+SzN3hRCxIiaI551k4RP
         I2hrymBpEcGdGTFpis1dyyEECWa7muXoDj7Whg+CztgDH5wHtceCDirC4cua0ctT9dj1
         kGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752186131; x=1752790931;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kx73u9VXSxci3zVsfu1OAUwwaENWROKjKLvmUe4fglc=;
        b=jpTrMGZh4MslgtHXeOOrfn/tITjljArtBmjxVO16khUlMKgsuBthkG1Wn+4m4y6cTL
         4G5LvDxOhp6mp+EauBWWjM4XX+fJW1N4Q/29P0ESXr8V1GgPV04nKwqkU+CmFmB+mQjV
         dguQR4zujd/wsxziVjaZv4vNk8QJowBPSUcRuJFRepU8BuUMLW1xKq3t/AE0a4enGWji
         0XxMNoNg8tqkPeMG5qroR7ZwpAmxBAvS1A55DQ8FrDF+kX1+I9hzGhA0sVeCPYrwG3Et
         /zH8u8CFbmqg5S01Ca4lFRdq5nYOfWi+xJypdZmUlszob2mNOKMz4/PAZ/TTd1n6H4y+
         FIhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuoyxaQLg3M2dNBkuoWNbKlQTQqCweizXyqayeDcns21URtmalpuWG5zv6ifxp3fV8f9E0UiL2K/d0cnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLN/6twnyK2siUfy6zilEHEs5AvIpUkjuC/MnBvvOE4V2iF+Zy
	miicNf3v721SR5s5WRIdFZ3dpcMRSJpgfdNqIYPMpx1et1U7Awp/LqFctIYoDh0OaXw=
X-Gm-Gg: ASbGncuucOad07hYe7n7k0uOda2YgVnl0kGtLMZaBmanUOWp3VKyfFSxNMRw6BWrven
	QZvVL6u7Fbsgb7QWZj2RpT2JvfnsZGxZVlQtejQuw5UjUnYGnibBuaJHinnS5ORLCAH1PYPuSyG
	z9ow9H1qY74HRbJSruP1AgH/00apc8uzytiliDSxqKj7xpLwWifURrvOGkPVQREjhWnOs+pdPPU
	JGEvltth1A3XCaszLqo5P2CCAZVqA8W8AQfLpfGu2EQTZkUAtEhX8teFj6GOaS9GCwqYqFbZKCV
	Rn+kY93DqjaR5ZEiRNFXbFQakoWDIvf5vdytVKXgnNCSkv1WxEpioTxKw6kh8HTFfgdavHCaFuI
	1y6rUfhvvBEAlNtJ8UdQ61t5zXfamH99yA1VZ
X-Google-Smtp-Source: AGHT+IEc3zIBRrJ1Gk7ZuO0QXFIOJGwMkp/NqiOVJD7kofSvu0fdkrbmripzvrkjUvOsIDs5Q1hHUA==
X-Received: by 2002:a05:6820:4df3:b0:611:e30a:fa1c with SMTP id 006d021491bc7-613e5eeb902mr502134eaf.1.1752186130755;
        Thu, 10 Jul 2025 15:22:10 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:891b:7836:c92:869])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9f28e35sm310885eaf.39.2025.07.10.15.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:22:10 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 10 Jul 2025 17:22:00 -0500
Subject: [PATCH v4] iio: adc: ad7173: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-iio-adc-ad7173-add-spi-offload-support-v4-1-536857c4e043@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAc9cGgC/13NwQrCMAwG4FcZPRvWddrpXkVEuq3TgG1q04kgv
 rthHgQPIflz+L+XYp/Rs+qrl8r+gYwUJWw3lRqvLl484CRZGW122hoNiARuGmW6pmtlTcAJgeb
 5Rk7uJSXKBVrjmm4/WGtdq6QsZT/jc4WOp2/O/r6IV77PH9dXK9bp9h+TBohLOPONCgNFCMQFx
 ismhuGwN0ZbZ/TQ9I/VHBx7GCkELH0lPtfZBxKvlt5adsF4Uaf3+wPkmSvLBgEAAA==
X-Change-ID: 20250620-iio-adc-ad7173-add-spi-offload-support-32a178b666a3
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3244; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=SsrP1cgk5ZxHAw1T5LxKC2jzRBKUCL3UkePoEJyRuqM=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDIKbLm7Oq03/Suv9lbyPZm0VSnTMWyuznupynWeAbGu9
 /Qilyd3MhqzMDByMciKKbK8kbg5L4mv+dqcGxkzYAaxMoFMYeDiFICJvMnhYJhQZsGcGlj8XC5q
 ptJN2Z0sn8T/8XUX8fawz2lXaqlpPXGs4rybXLAL36OWCIMvWd+sMlZ7B9w3rRUNqDox17zr9DP
 m9P9T+U3Ssl6fKWHaEte5KSQwdabRd73Dk+Wsa5ec3bA54PpZ+VeNbbPu8vxfvvb6Y7ZQJ9Y3wu
 uCKic+bdl6X99PfcOajKpWjXuqXo43/Mx4ferqfLvW7qhyyXvrH6Tm139Fb/8+Kcv3s6yW8epOL
 px3/crLq4V67Psz1+Z6Gb1gDD1osyau8uOLZo5Zb8+ZnHj6xN3ML02u6MvXk5phoavnHvZo0PnJ
 HdzW5h6wSOiDW5eMsPaLVBEF8dW85eyVCqoHG1U/5kwEAA==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Enable SPI offload support for the AD7173 ADC driver.

The scan_type used for SPI offload is assuming that we are using the
ad411x_ad717x HDL project [1] which always stores data words in 32-bits.

Link: https://analogdevicesinc.github.io/hdl/projects/ad411x_ad717x/index.html [1]
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v3 was applied, but then we had to drop the final patch due to a
conflicting fix. Here is that patch again with the changes needed to
adjust it to the changes in the fix.

We'll have to wait for the fix to make it's way back into iio/testing
before we can apply this patch, so it will have to sit for a while.

v4 changes:
- Add one more instance of .supports_spi_offload = true,.
- Picked up Andy's Reviewed-by tag.
---
 drivers/iio/adc/ad7173.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 9730fda56186afc45f589899e669c41eb538af6b..3886d2f751d0370994ababf72409f4dcb328641d 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -747,6 +747,7 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_4_slots = {
 	.set_mode = ad7173_set_mode,
 	.has_registers = true,
 	.has_named_irqs = true,
+	.supports_spi_offload = true,
 	.addr_shift = 0,
 	.read_mask = BIT(6),
 	.status_ch_mask = GENMASK(3, 0),
@@ -763,6 +764,7 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_8_slots = {
 	.set_mode = ad7173_set_mode,
 	.has_registers = true,
 	.has_named_irqs = true,
+	.supports_spi_offload = true,
 	.addr_shift = 0,
 	.read_mask = BIT(6),
 	.status_ch_mask = GENMASK(3, 0),
@@ -779,6 +781,7 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_16_slots = {
 	.set_mode = ad7173_set_mode,
 	.has_registers = true,
 	.has_named_irqs = true,
+	.supports_spi_offload = true,
 	.addr_shift = 0,
 	.read_mask = BIT(6),
 	.status_ch_mask = GENMASK(3, 0),
@@ -1595,6 +1598,11 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		if (st->info->data_reg_only_16bit)
 			chan_arr[chan_index].scan_type = ad4113_scan_type;
 
+		if (ad_sigma_delta_has_spi_offload(&st->sd)) {
+			chan_arr[chan_index].scan_type.storagebits = 32;
+			chan_arr[chan_index].scan_type.endianness = IIO_CPU;
+		}
+
 		chan_index++;
 	}
 
@@ -1685,6 +1693,12 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		if (st->info->data_reg_only_16bit)
 			chan_arr[chan_index].scan_type = ad4113_scan_type;
 
+		/* Assuming SPI offload is ad411x_ad717x HDL project. */
+		if (ad_sigma_delta_has_spi_offload(&st->sd)) {
+			chan_arr[chan_index].scan_type.storagebits = 32;
+			chan_arr[chan_index].scan_type.endianness = IIO_CPU;
+		}
+
 		chan_index++;
 	}
 	return 0;

---
base-commit: f8f559752d573a051a984adda8d2d1464f92f954
change-id: 20250620-iio-adc-ad7173-add-spi-offload-support-32a178b666a3
prerequisite-change-id: 20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-b982206a20b1:v3
prerequisite-patch-id: 350fb675f3e0fe494e0ce4ddf5685d9369ffa11a

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


