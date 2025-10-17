Return-Path: <linux-kernel+bounces-858470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4943BEADDF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A80745A81F6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECD32E03E3;
	Fri, 17 Oct 2025 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z+Z/lKsI"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20292C325F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719383; cv=none; b=WPe6h4fhAu21gRwvbuo7lbDE+2OPZ7XuN9M/dzNSUvZ/LTXVXxd/bttkZPskb2SzG+gRcsSDzatKvl3tYCo4A3pf4yZPbglreHQam9yhG5+hWLqAPdo0taAlNnxzB72WF0G5zPHQJKWoAps7QZamf2EQwkQnXzVtRoosFXF7Fpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719383; c=relaxed/simple;
	bh=EbGOgWCx+khawQFOQHDAVhH9bYeArl+G3z9a0/QKsAI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=W4fv4wAM/YMFAdK0EsdEXN8anS603iZxAtc1Lpj06CiUyH4AcVg5sfuCGVYvDXOWJxYANkj18P7X7eeegXa+hsQgTdv/fachiQ8/VNXHyC7w2/ox0dA1zUd9aE7OmBlyaSSMo3h1ep6xuu4FdMOnQO5WRiGcosfdJzo9VcUuR1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Z+Z/lKsI; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b5a8184144dso325600066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760719378; x=1761324178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Y6ZFTaO484vvvOp+LnE17zfufVeY7YudrTHPSJCX3w=;
        b=Z+Z/lKsIvGlysfkJgc3/URezmV2UibNrUNu+dNfu4x7D3hIhaI488QQKohJSgHdwIW
         AMydoUo0oP3CDDpHSp6nezXsQccvqLMVSyTBbaWl6PvKe3afdFVnHzk7/cpP1W2kPbpY
         NoTyQJ/SQ9xLEv8cj5CZpsmiYZUVCWOhRCd3/izeCl2DbwIE/IZUC3w68XC/sFOt7Nif
         3zyx1NwsJmYfXBC24TuO7/zJCwgZzBhMcsTAwEB+4v+vzLTWU8b4Y4kmyuf9q0bw3Eja
         BqOsGK6wv/ASB4SEOoJCcCnck3XjCdgklzkEnJ+I3gtBwoXCbv146jJS0KH3DCHpraJ7
         CCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719378; x=1761324178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Y6ZFTaO484vvvOp+LnE17zfufVeY7YudrTHPSJCX3w=;
        b=U3l7c6NfY1q24WedMYZUxA7sC31+kYxgIsm+YyGzYY8VKt+6sm/OLgz/CfWfZ/0Ju7
         8q3sjB7YtzxKTG32I37NjF/ZE0u0TAJi07p2AYXLVOryXirQJhaksTRFNcc+TtjVEkz1
         yyEPe3orbMuwoomyav5ROOr7dj752dLKr3cAVg+wSc2diQeOFCc/t6pQCcKd6bW7CQOk
         nRSom93CDgLVK6htf01aJAboxBZZATdXh8V8f9UfHwZE0XRzOPl0keIC2qGm7/T0acrj
         JEpNgM/9pyvqBtvjDY/7rESJXJv36F7XowGMzBx1DeVwCLi6gYJovqgQ0hWTN/Q5NFzo
         otBg==
X-Forwarded-Encrypted: i=1; AJvYcCXhTCEPuusDZF9Byi5iAB5BfiS5Rgw4pXqAtgeOVt0tr1dSt3HB3ltPXnCdVYKQPbaCAnp2C2m9M5SPHvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE+evK80f+G7TlfhNgbWj0Fd6hJ4ukde9E416ZbCEuKsS0vRnP
	LSqGB4uVxSNykOd7J3NdyK5gAU10V05dyigKFxtG7g9WgHw9AcpcT1AatBJ6ozjy4i6gd3b1nSu
	nwOazbAc=
X-Gm-Gg: ASbGncsr6KoaWO6gHj1N1EvBxunDzRFQmhQfvWQFitib7srmBOjfSfShZU8FEPZKM8M
	KFfMa2rH/P6uRUW1KhmiTVFC78lArifh4vNcvW4youAdHrpHDz27XKxmIgv0maaXbx8HAFD+sP5
	3TWa7gxP3G6UlkOMz+Gaw8pid17QnxoJv4C2/Kf7HNbeW0AcOfNMzospw/5260vDYa6NXx//9vN
	PZGYerDxA+02ERHcimTL4jGM/MnbZtorlRy43x7iD0z4N18hsMYQatx3rXvNqnle2QtSAha18Bw
	HBgNUdHuqYukWoHSt3cDtcWYhWwYpHXlwfwW8vN1ZAa4wYJscndGQnn97pXuuk1yZa7YJsuWYtR
	uSIC4aojzzQdj+Gs2duezBOci72LUaFvp3in1vVKlhqnayVKgaeCIR/eVL+xGg2SdKcWyRRpcdq
	c8CrDIhaDztvkWE1Wc23LdfSbjEBmpEjvSlTdx
X-Google-Smtp-Source: AGHT+IFYmw9Y+CWdz19QjFSQJCJMdCKeKiZa3YQOd9OZPKNEuXldvogb8WZLSN/ZGoEzK5VTcC62+g==
X-Received: by 2002:a17:907:c20:b0:b45:27e0:7f35 with SMTP id a640c23a62f3a-b64764e1c66mr519633766b.46.1760719378035;
        Fri, 17 Oct 2025 09:42:58 -0700 (PDT)
Received: from localhost (mob-176-247-36-41.net.vodafone.it. [176.247.36.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036846sm14971166b.54.2025.10.17.09.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:42:57 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate
Date: Fri, 17 Oct 2025 18:42:53 +0200
Message-Id: <20251017164255.1251060-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2410; i=flavra@baylibre.com; h=from:subject; bh=EbGOgWCx+khawQFOQHDAVhH9bYeArl+G3z9a0/QKsAI=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBo8nH3tw8+nFc8mO5BnEJGdJ/joIXFe+sacU/oy n46BGq0NheJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaPJx9wAKCRDt8TtzzpQ2 X0T2DACtX3b4mY2q84kxLKrZkPbIcL7BFRGCz9y6co1vO8c+IaWc+yny1HRM3yOl+OqhDpGlFv9 6KHlI6u9C1NcTZMFjbpJZ6mOCcyzOsVQBeSqqiyQLc8KGfBkCKqyvApwfc31+2jgTreEyvFlXDq 2rrBMk43ZB9p8Eqr2NiGPEWfttxA/hEPDecpNscQQ1tuEEgzL72wsjS/Lh9Vl9Z/n/Ys+Z6Zq0V p1A4qTQqNlklbTqVApNk6Eilh3rPZ8T+HKrMwpN/oMOP8JVR4h56o8kNXxUUwYFuMa8mrRTpWjk odAIUgFF7vR8yeBAg90c5myDBLnMrcQVZdZXMDHKD8TmmCdhjJrXqk8ClnXHGjrzEEKNTn9GE7V G7gB5LzunmiLvRyICrjyYaJ8bQ4AkkcIEBor5dLWWa80quy84zXowhxVbU5K7BY++EFlPgyTVHf oL0NUxzALVfXb1Hq2l0RmV1+IKvTZRzwvjaxIgRzVCnJofkqBCA6qmfG6ZZNCQRWiygD8=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The rate at which accelerometer or gyroscope sensor samples are fed
to the hardware FIFO (batch data rate, or BDR) does not have to
coincide with the sensor sampling frequency (output data rate, or
ODR); the only requirement is for the BDR to not be greater than
the ODR. Having a BDR lower than the ODR is useful in cases where
an application requires a high sampling rate for accurate detection
of motion events (e.g. wakeup events), but wants to read sensor
sample values from the device buffer at a lower data rate (e.g. to
minimize the amount of I2C or SPI traffic and the rate of periodic
interrupts).
This change set amends the st_lsm6dsx IIO driver to support the above
use case. The first commit is a trivial fix to the source code comment
that indicates what measurement unit is used for the `odr` field of
struct st_lsm6ds_sensor, while the second commit introduces a new
`hwfifo_odr_mHz` field in the same struct to implement the new functionality.

Changes from v2 [2]:
 - fixed Fixes tag in patch 1/2
 - removed local variable from st_lsm6dsx_hwfifo_odr_show() (Lorenzo)
 - replaced multi-assignments with on assignment per line (Lorenzo)
 - added Acked-by tags to patches 1/2 and 2/2 (Lorenzo)

Changes from v1 [1]:
 - added Fixes tag to patch 1/2 (Lorenzo)
 - in sysfs store handler, moved iio_device_claim_direct() call to beginning
   of function (Lorenzo)
 - changed new struct st_lsm6dsx_sensor field name from `bdr` to
   `hwfifo_odr_mHz` (Lorenzo, David)
 - replaced min_t() and max_t() calls with min() and max() (Andy)
 - added setting of buffer frequency equal to main frequency whenever the
   latter is updated via sysfs (Jonathan)
 - miscellaneous stylistic modifications (Lorenzo, Andy, Jonathan)

[1] https://lore.kernel.org/linux-iio/20251009173609.992452-1-flavra@baylibre.com/T/#u
[2] https://lore.kernel.org/linux-iio/20251016172122.1220332-1-flavra@baylibre.com/T/#u

Francesco Lavra (2):
  iio: imu: st_lsm6dsx: Fix measurement unit for odr struct member
  iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  4 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 71 ++++++++++++++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  7 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  |  2 +
 4 files changed, 73 insertions(+), 11 deletions(-)

-- 
2.39.5


