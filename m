Return-Path: <linux-kernel+bounces-609516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4DEA9231F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 18:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512C6175325
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 16:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62082561DF;
	Thu, 17 Apr 2025 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lOiTv+Uv"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B22561DD
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908831; cv=none; b=DuzzaCbkBYVHoLq0N4Zt1N+Bf7xSlvgEzdEa8ghM/q7ElD8ewFUI7aRsMJwso98Bm/rj73LZrzhMuQmnlFiejOzPiOjaCoXN5vHnBC88UjhA5V4/YqV/rQvE8PK3c/JeuAvdCD/EacyCarC/hVOWfrcqa42pZtx5lXkajzh/k/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908831; c=relaxed/simple;
	bh=r2Lf6V871r0X8NFwArauQL/aP2ip9vu9Z8iRNi1+BAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VGku3SIfhWfC8mj9B+6WzLlyBdjVpnh9uLT1zPYeojha0amiJgW8tqJn5Qlm1AtlL1B0VEokyvDt78xe/5w3khslyQd42P7EdUlJkf4VS4K/BeqNDfxSIRlenEP2a3HXqp4/NjyKh2GdgKy5WLHcsNCKfF9Cxxc9kBIPCmcJB8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lOiTv+Uv; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2d0920c6f96so594295fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 09:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744908828; x=1745513628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9S/SvzijUhAxaY2WkAr6cvZfGG4Ius95xkJsmSTFocc=;
        b=lOiTv+UvUHYpAJBGzONlHmDOu4571hWnaUefOA2jYzitIMUm0lZUGH3fU+uN1GMS4M
         VtXFWdlneZWjEDCysw/V6QerTqT7ax06cTDXvDVlmvsUYbc7aG0uY/C66rIjeUjUr19r
         x/MPZsPm0AhWgZnzO/NXsRac/NgNcYs12HA//yLivKzx3EEs4OozepurYS6lPwMUJxHu
         bRS5nivTB4pYlC2ruuxVRa666HDTLJgKO3Yzmyignw/GOrpLDrAFS1Vunzsl+DsgyDRC
         XIH7pAX8J9FihvPHCVKJ5FMhZ28oI4DPq/ILu93zrKzgZXIEEu6fbEHlHq3aa7ynZ1lW
         fDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744908828; x=1745513628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9S/SvzijUhAxaY2WkAr6cvZfGG4Ius95xkJsmSTFocc=;
        b=ASPW/y/YeLUebH0fLE9ivi8/YItHTotflD6G2ZiL6kV+nZ23okcoHLwrNSAKI4Ry5x
         Cq2+AJQgxRSLB3p3fxlRrD3gIZVdxRULy7h4jD5e6LzwjFuU61FXtq+bCeLyeJeBbM4H
         RYbkqku9AdI5kjWzXFmQ33pBwUqJNcjBCERPinIY3G83vEJBBZpa0TVUcvtZEzHf/1Oz
         C0skTuKdXUpLKvZNVd/Fot/9sT8rLOclMB4l80tQdtvVbLPXAU/MPzW0EWIza6UK4aPe
         dYT/aEgUB1DmsEfxeANYuhy2Dy8IgxNU//iiaNRsxylruG2l98NLQba6HlvFs49nMXeT
         8gHg==
X-Forwarded-Encrypted: i=1; AJvYcCWs7ZdvGiJ/kjeerr5rBEUA84stK8xka46ubqFhoo7JMpmUqBQtW2EOVYoRrS1cNRXFhnH/2F7jhhkJ98U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Pb50acmDCoVpAxO4H32+5wftq2ru7iX4XvOV6yDkU1g02xLn
	q6r7+nm+kcFgt5CF8PJu+IsDxR4aNj8O8uwg+MYE78HI/lwL6F9YTZEwdyn5cT8=
X-Gm-Gg: ASbGncs4pvXV/1r0Ow7jyafqD4zSunh0HhZODR0cyV4AuZozBAAw18X0lW8LMUsigUR
	1+O0F3KQx+GI3yZHXWTMrDataZ6F+FbmcBsdm4Us2Tlhs9Tu0mBJn9L5mTIJ15p27pZY8Jqw/ce
	4jf/y5Hp9RSEQ+yy+ocEnFVpTvSbGGzWTa0P1+Ue2pIz6BMAb5hkH7xBmSe6Eph9C1sfh14Yc2C
	BTBtdq22dIQ4c54zL1I4eG8OZWEBll7TE5Gq3aCtSyNtl45z71bAxI/pe8f/zfDdOxa/RSC6v4X
	YfFtS877k+Qh3GWfKgpk3Os8Fkjb39UMhc5OCyReNu1yehA=
X-Google-Smtp-Source: AGHT+IF2cc6nvhloIatR296bKaZ80w5oIIi+XgsIxUdwxJ2bRiFa0lwjx2pRXiLn6TVPGEuHIrcesg==
X-Received: by 2002:a05:6871:aa10:b0:29e:24c7:2861 with SMTP id 586e51a60fabf-2d4d2aa5915mr3876098fac.13.1744908828514;
        Thu, 17 Apr 2025 09:53:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d5218248b7sm15812fac.47.2025.04.17.09.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 09:53:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 17 Apr 2025 11:52:39 -0500
Subject: [PATCH 7/8] iio: imu: inv_mpu6050: align buffer for timestamp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-iio-more-timestamp-alignment-v1-7-eafac1e22318@baylibre.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Tomasz Duszynski <tduszyns@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=r2Lf6V871r0X8NFwArauQL/aP2ip9vu9Z8iRNi1+BAo=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoATIA+teM+VsDaed33qq9DGEWH0kyRosXw6BwA
 FFyhafZOMSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAEyAAAKCRDCzCAB/wGP
 wKsAB/49x03HWwW8kibDISBd6Ld/CibPThaqCLxFDvm4mQF6Lwdkjzvmy0QtIyU0hwRJG2fl+Lh
 4pIf4SyMG/WlJYZzS2R6JHm1Dm/WhAw2FYk/K4XAmzvakOcJDp7frIcgxKMgIiS03ab0WkHktkP
 e4iQNzBwOC88d06nrgETtFhtQoZ8nyU6wPWQuq8RMQ+J96hkRf3QYNT6XnuN6j2nFuDNHysfKDR
 RwSoR6I5TUGwsJiiMEIpykJQUvwfGiQpFkxOdvDy51nDD4Izr18DudobB0FWvxwiIC086FaF5OJ
 6kkLPmFBHSgFMmXXVmHKRUa1AJ8QDjp/Iw3muuNM7vA3a9Pr
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Align the buffer used with iio_push_to_buffers_with_timestamp() to
ensure the s64 timestamp is aligned to 8 bytes.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 3d3b27f28c9d1c94aba93678261ce0d63099e1dc..273196e647a2b5a4860e18cfa34a088c773540e4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -50,7 +50,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	u16 fifo_count;
 	u32 fifo_period;
 	s64 timestamp;
-	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
+	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE] __aligned(8);
 	size_t i, nb;
 
 	mutex_lock(&st->lock);

-- 
2.43.0


