Return-Path: <linux-kernel+bounces-856692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C9CBE4D49
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4785E359DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6915230FF3C;
	Thu, 16 Oct 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yjqItfth"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF31F21C173
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635289; cv=none; b=FAjB/DvXGQ2gj0Aka6CWwJcPXj9InhrEfMeA3bJYL5X3QMwfCyIUxkf1fSPFBAZvI4BBoY8mhpRLuzPk3kEKGoEm1cYB9/R/j/UoBHv0WfWZh81pj4FaYE4Bb4LDEPMTf9dXYbn3rzyeaEOghae3j4wuodkoTgawo8Y84xLJmeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635289; c=relaxed/simple;
	bh=wBY2cs92+fygg+uCMwB58jzVy7qCTwKs8jhbQwv+zXM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dELL/3LZ4A9k2w6uRpn+xO0th7jLG35xg7/Uvqq7ACPbxGBUKhKQNeMgw6Q7/n8qlt378AF4o+oPZnVkYbmDSO45AOH+L+6kYzLweLz1uzjXh0SLQuvkwjQQWegL3K4cJqs2qTH/4eK/ojmHRRmIon4/+XPSfFriSnisf5dQhvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yjqItfth; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-427007b1fe5so572836f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760635286; x=1761240086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPtpl05ucdsH554VPwBpisewoWIW4AQUlxIpVcCcSz8=;
        b=yjqItfthWvzSoNGCjnquVriEdZ/8pV59ElIPFcVtuzlVrSxxJHduT0Jr4ZXjWSpQ4R
         7JonvfJ1Mr8tFWVTheiHsu2H+jYe275z/Z+CyKztMrd3906p68KZ4qSeDFWsDqI00tIm
         NQSLCBWbcZoK0Ows2Av/+hAUu82kOVQCWk/RRr3q44Ur4sCngzdVaMbRTWYQ1Akr6XpL
         F1H4x/wK+ASqvpE5GaE4q/GhqIbVTFRyo2cYaHkzBiPTjZKCCkK6o7KmOq6VbJaL2g5U
         fN/xBjZmy/YK445P5yHpk8Iindw1+7kPgHOnM5Qjk3zWJMs4b09iHGuBBqyf5J48iA9M
         CceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760635286; x=1761240086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPtpl05ucdsH554VPwBpisewoWIW4AQUlxIpVcCcSz8=;
        b=o83cHpWvCclmYHuu3cVGpLPk5eLwvg9PrIbq4rKhPRCK1O9HYYQgrG1TRl8Be9cZsg
         ohHAdVujebTbKkVF6Tr1KETYYLLeH4RVdtT0sAbyObuIhw5MP+djV3hggZhKbjhMSECU
         AIfmVu4LhABvGzcl8/MTvYzTgcvCXGav3ybsqzRLYNEVXWT0otBLVcAaoPQyC6Plem/F
         IpI2fLu8w8/ETZeXJQJbaEChgXJs/0ZYK4znm12Qlp/dfif7lXXvn9qBfSliCIaRvHix
         ItpEqQLkKuXI55qUxYek58ofp/nze1AdFAU8cb+STEwXe+nF8cUi5sOF8sJ/bkfmz3NO
         1MDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX48YoqOSChAyLtt5AshyhYmWvEkhuIuIkw1ZUhEEbu4laf5gy+R+31fRV8O9LQqWD6QelzO24uP62yeWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ofL/It+s/k1mdXELd5IvrY1bN8Pux7/1CU1gwnGZWVwHh40F
	ZcA9TRkcGvnxe5wvR7ZR5E+P7fq2TBLIJt6ODM9OA7Ywxy093yXkDvCcS2Evz2O3k+4=
X-Gm-Gg: ASbGncu3IDeL4JY+XDk+qbSdbaGeQYr7DdUCdcXilohUO+axy5xcr3MRYEpiqTEXfiT
	I1Lux0Px6q2/+7d6NYuR0FNYEXrz1rDAggoSU/aouukTzzTXA7bMo6Y56t5uEInn5QirmJTDtkp
	vCphg1RfEPLVe7w6816mDwMA7dKAd9i6rzCvYv2KuH9BNTPOzexrvh5TS0NCciiGDl5q/Ldh7uW
	0NPTR9TF9ISRkayLkDtYomI4znoMmTzqTUIUO6bzAqUvakyB+rTyx4oKklYuTATGm7YIdKdYwkQ
	8yujtfLwJ+sREe0p7KArQkU6e96JDvlM9686VLU9xqetL4kw2oCHhqHvPZftWYaKvo2WOFjpViV
	dlORo/Y3taUypqvu8kYT4qP/70cSE7nIUYrYE2/CtTb89GoAvJoU9+z2arzbMeUHOsCwu+xl0Q9
	f9QQ==
X-Google-Smtp-Source: AGHT+IEbAwOLpN+3gLcIXSlwje3hgYAK4GcMgt9FiO6xlV5Qw7qtPGE7OeuueIeTbngPsjCV45Lc7w==
X-Received: by 2002:a05:6000:4205:b0:401:70eb:eec7 with SMTP id ffacd0b85a97d-42704db8ccbmr625604f8f.43.1760635286027;
        Thu, 16 Oct 2025 10:21:26 -0700 (PDT)
Received: from localhost ([151.35.142.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711443e81asm40085805e9.10.2025.10.16.10.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:21:25 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: Fix measurement unit for odr struct member
Date: Thu, 16 Oct 2025 19:21:21 +0200
Message-Id: <20251016172122.1220332-2-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251016172122.1220332-1-flavra@baylibre.com>
References: <20251016172122.1220332-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1011; i=flavra@baylibre.com; h=from:subject; bh=wBY2cs92+fygg+uCMwB58jzVy7qCTwKs8jhbQwv+zXM=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBo8SlG/5SlI7hO8FM0OzFXZY/MDRumIt3Y6VWoA foWjMafTBWJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaPEpRgAKCRDt8TtzzpQ2 X0iuC/9y/vx/TgX0ojCFHNuz8sAIt4HxpRJS1SuidRyW4MvcgKpXVW4TlqdE+d9AJUyIcWuyVs0 wHzBYOzfJZ8pjtytYCjLf7TPuSRBF0AqviR5SFdAWZpHe4U3L/uS45fsWdoU1LY6+DoKX0/XCpD nFT7FJansxCiKxGE5IPhH2H4wlvXmf/X1X05wFSK32OM7cmDpgheSeNl8Ag4sl4nsd7ajGm8RYf APDSzudrK9uDYCzrEItJHKMV3XG2JGySTyumqYGkNnIAz3fOgjH2SN2kdPHP8Yvd6hiQ4E5t/yy +FkMsaEzfKlh/IId6vJJz1IQNWSFbAH7a6EweZR1AMY4+mSimCbKCviJqZd0Sb2aX6B1vgvla2I vlAUoHRQcd2H+BeAh+cK9CaqXVJONg6EjcWXSXgXXLY+pB7tNZYN3wNJsFpR9NWlJ41nbHFx/Qu KCl+HVL/oRNgQgJtnfhzVS+yI0hK7sW0Iim5lGADApjxkVMGiCCr3aTul1boMWIByTIiM=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The `odr` field in struct st_lsm6dsx_sensor contains a data rate
value expressed in mHz, not in Hz.

Fixes: 290a6ce11d938 ("iio: imu: add support to lsm6dsx driver")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index c225b246c8a5..bd366c6e282a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -365,7 +365,7 @@ enum st_lsm6dsx_fifo_mode {
  * @id: Sensor identifier.
  * @hw: Pointer to instance of struct st_lsm6dsx_hw.
  * @gain: Configured sensor sensitivity.
- * @odr: Output data rate of the sensor [Hz].
+ * @odr: Output data rate of the sensor [mHz].
  * @samples_to_discard: Number of samples to discard for filters settling time.
  * @watermark: Sensor watermark level.
  * @decimator: Sensor decimation factor.
-- 
2.39.5


