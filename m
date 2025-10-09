Return-Path: <linux-kernel+bounces-847265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC32BCA647
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDC018933CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CE42472A2;
	Thu,  9 Oct 2025 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rf7Hj9MJ"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AFB225A38
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031374; cv=none; b=JwsvXOcJ91a3LF3TY+WoPpIX0uzKVYdxKxraCDJnrF4IwsF9v/OB646/qHYxXHXbwkpkMRQR3m0n7p8Wn6t/g3R4vh10LGPYnr5hZ1BzmptSx6qQRQDYXLZHzMySea0KIa92EecxXIT1qAXqJzA/Xi2YeMAb5+GokNFOep2xLlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031374; c=relaxed/simple;
	bh=/SYeFNLU2iy8w3uWLIu2KCxURtmYd9CoHQg5tdH9/1w=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZUf20hEvi2/y67qLV+ly7LPz0lHyspWxgrmCowZZhkFhgpV72t8Ecln7EwHAQEVJ3sDauVl4KaDVkSVgMe5Ncdo9Uxc2KF3gb3WM+bNv4QkSxdW1DBrvUFd82S+FUkTNe/trkKtl4RObr/fnqXJBId/TBL8uvRImOlZPX8x8wLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rf7Hj9MJ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b403bb7843eso252170066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760031370; x=1760636170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mh0GCFbXX/Jg13wPTNrh0yswWb/BBihUyjMJ4MtlgV4=;
        b=rf7Hj9MJiyk/jNiPXhJfXm/OcxDdcehku/47+/hYEFste2CHDlsvzH63jDu21J2+2o
         edUtyHPjUHjxxkAbCJiT1AZyzUzwlITFj8Abk2qDD1oqxXfBfTH/cAkQTn8kl5SXobJM
         MKP55IZRtKDuQA2slOfES5MCqZv/76XDTZ9UymdI9BNykKj3YkuLVjvuULyQ2CqJGLz+
         Tz0WIqrbzDUrHLVljncIhRr7Fvsr749amuvZ3xGvtEQ4oG3N8+3sASVNLICeh3yc/Rm1
         HLFCu8ZdjAUiN1RuZIURNc7SSDo+EpJzwiFtO7034WEr9Aamlg/lRVCh7z9DXz3TjHTu
         7oIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760031370; x=1760636170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mh0GCFbXX/Jg13wPTNrh0yswWb/BBihUyjMJ4MtlgV4=;
        b=jAV6qNhu7bAViVCFPZ02pHHBEMSUljGUuzpX85skeXN/tA6NkqeRSY6Aey85kzZlxc
         oHYCCrQdoETYsaT38ngEESfriKRDul1KC5yHapyaFVK6+aj/SucDN7EDxggzRII2V7BG
         XModPnP6b+vxtssCafbveSNIh1vGTfm8sWLfeJAzj8+dyixz5Pq6u20DG/baT6Aic5Lo
         e3z1GchMY3WtAGjLhnn73vakuPMMjENIgOc8Bfk3UT4IxVzhpcEj4ONKT7N6oosH8MBL
         2Nd7kh8Fn7q9JblJSe2hOngCFFl33KuXZJOz/dR+h9sUnju1fuzAzcjIGuSPkwZXIIlb
         1kOA==
X-Forwarded-Encrypted: i=1; AJvYcCXNPIoC5++u2fu8Gpv6s3Vxljmu7XuET18V048FfLDx/OR2IsTHtEsPIBxN5ER/15pTbEZWYON8zBWq29M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg/pAGrfKi+iw/sXZC8vY+XSmi+210SxFUt5kFz4oEkz+gJnKj
	3vR4U/w0VgQx7RQ7JuiBsja+YIsjGUElz51jw+59wDxVcb2i9yb0gXSo0NZ8O3TRW7A=
X-Gm-Gg: ASbGncvseTOqf9Mq+kInJU5PuxOl6PRBVbeMcP4w67k7chqMXzBLBaBUyI7Xk8bBCmO
	I4LP9QIcjCs5O6uq2AWivJLJGrt4Gppl3DWIKwE5wI3t2C1Ej5ZF1sNWaEKsc4uvGMj1RWJYpKd
	R/GPnWzlPBVOMmluA41ohYU7MEOlPdRY4w9OZCzuZXd8VuPjX4hXNWJqTddGA1JCov9Vukg2/gD
	ysBUK7k3aPY/RYKUiNVQQElnWbogcxLVF/sQcuVpNqj8v5hwrL7dSPGphFH1gLKUUNY9US+mWja
	B7HyMx85P7WCjl9przyTrRNVH6SdGYmqILuv1X0Hfg3taXxQGBKNjVSNI6g+hAJPcjT1XWtTBoA
	ssA9OO8ccJct8kg4E4Q==
X-Google-Smtp-Source: AGHT+IGUUgl923dofvYWCnwnBwJ5iK2BEsUopPu/EtG79xhGj80FMsabxCaEHX/FEtkUyNvprEpvHA==
X-Received: by 2002:a17:907:7fa4:b0:b3c:82d5:211c with SMTP id a640c23a62f3a-b50aae981e1mr1032203866b.27.1760031370431;
        Thu, 09 Oct 2025 10:36:10 -0700 (PDT)
Received: from localhost ([151.35.157.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d951deb6sm20543466b.76.2025.10.09.10.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:36:10 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate
Date: Thu,  9 Oct 2025 19:36:07 +0200
Message-Id: <20251009173609.992452-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; i=flavra@baylibre.com; h=from:subject; bh=/SYeFNLU2iy8w3uWLIu2KCxURtmYd9CoHQg5tdH9/1w=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBo5/JEGVK232nIvaF1SA41k2gIPzlcjF3hijamy YYigWNY0lKJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaOfyRAAKCRDt8TtzzpQ2 X5RwC/9Y0G0mcswp/6fziCZGCcrAe0pRmtUdIzh7fwUhXHM8+fOWaCfjoggts8fN6HM4n07H9Lr zo2TP/JesAzzsZ1onjRK1YmhHAg1CjZJHoHueZZbmU+bb4ppftICM2g8sh5CZcK6N6dVSohRSTM T4BtpRKF0yF0Mg0+8B0SEI9nACfoO17sL8H+obwZycETXbsBmuE0z14OrUTgg9KhuFTTFSMSlyP P7e8SFUHzZdnLJoEqzjwhGpguFvSrFbqurs/2OiC/6NxwqZdVFeBEUIt3+yGAPZTkrMep3WUNO3 8QvD4LpSEJA7sHeIHr2J7js1jS9hocXO3JrJad9D319fYfuf7QrGzMjGNvMnG+R5W2jRWU3xEkA tBd8zjrR83SB6KsXVxXuR+k3ibZujJPuZjXPpH8LZO07lqD8JSIGcwAB7BajZYrLuOSdL/mfxov 2extpN6rcVSzZbQREqm6sdJj7zhTDqA9zm3y9OV9h5UColUJmY7dnK5DQpglZ7Zwhe9nk=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The rate at which accelerometer or gyroscope sensor samples are fed
to the hardware FIFO (batch data rate, or BDR) does not have to
coincide with the sensor sampling frequency (output data rate, or
ODR); the only requirement is for the BDR to not be greater than
the ODR. Having a BDR lower than the ODR is useful in cases where
an application requires a high sampling rate for accurate detection
of motion events (e.g. wakeup events), but wants to read sensor
sample values from the device buffer at a lower data rate.
This change set amends the st_lsm6dsx IIO driver to support the above
use case. The first commit is a trivial fix to the source code comment
that indicates what measurement unit is used for the `odr` field of
struct st_lsm6ds_sensor, while the second commit introduces a new `bdr`
field in the same struct to implement the new functionality.

Francesco Lavra (2):
  iio: imu: st_lsm6dsx: Fix measurement unit for odr struct member
  iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  4 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 64 ++++++++++++++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  9 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  |  4 +-
 4 files changed, 67 insertions(+), 14 deletions(-)

-- 
2.39.5


