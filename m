Return-Path: <linux-kernel+bounces-856691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815CABE4D40
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34AED5E0273
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2321033469B;
	Thu, 16 Oct 2025 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uPDFTHTc"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2010321A453
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635288; cv=none; b=G7/BzO6iYSXoOWl+cjQ8U/koTIcVRmBQPqoOrkVU5zljYNrNS2ZdPmiyXMMCtM0WGS0VGt3EshyWJeYNGD5y0OH8DvVzFAzsJ79naxSW2s+n58S2dg7N0DS3GxYUPiYA/ZYzLbZK95PYiwmTPMC1JU72PGi2vLXgihKm7qiHEHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635288; c=relaxed/simple;
	bh=qhvgN3FL5LhV/QrYODPhFDcWPmr4o6Hpg4UP8n5lETY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=W3uvoG/I6PEcBSXi2qOAM7O9PP1tVkmeG2QS51JaeHT0uK0Jb1MkYkk6fDxCg2aE0pIVRJuHhorAq5bMyeicnlrwzh2qVx8AYMhwI6xcE/Pddo2wR5fqA+UF9Tq+e/HvTTnTBpkPj6BiULjQGVARR3aS9/W8o6+UuIbX7zfUp1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uPDFTHTc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-426f1574a14so615570f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760635284; x=1761240084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm9oHzTwa+9jdxvUFGS71kAV2vG5mm11Kk5UjOrH9s4=;
        b=uPDFTHTcQ4BjEoW4zK+53a6hcD/4oi4LQ3z1xbCZHJO8uBo+Em2GflCxJtjMNQlly0
         nYBQ4wReyAk7RBSY48LHNDhWqYegh2i/Jz410rXPyOHQAeAQavxvIvBJJEWP+TKtes97
         O9uVFqnQ3j1VXB9FCk01awpgPJFCGahXKR2xxzWFpR/ue/FIq+U92+DklU/B/l4pfm5D
         zpfm5UMl4JPokn/UGPR8pGhI0/JyB3pAjhvKxg4UAg0m33NnKhg719S8J0MvRCPTWOPQ
         FdHcLTuTFBFq2zHKOFDSXPM7OI5o05SKc4edhZHPhipJVGNh0XrOtkChoWnTNV9Z1ti4
         dJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760635284; x=1761240084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm9oHzTwa+9jdxvUFGS71kAV2vG5mm11Kk5UjOrH9s4=;
        b=D/4Qq20qa1mS6YRSCcfDBkK5hID4F7PWEBPs+Xu+jjvZMVsrL+3kuHrFqhsFahjs6w
         Andf3Gn0tKPr9V1W5QVDJsxJUN/6DahRpjWKKLZuZwnorkiZ33P9gZM+cdaxjvnE7znK
         OVNrs4rJJb016jhrRQT9mZ4/A6nM0ZrtYZOvFSxvY9i4+0ibXC0cotmcv7nw6h+kbkXx
         VzQBq3fT8hsCB8y6xeLKT92fkpqDuPDXVrQXDZiUoRS9YjHh0qGKNqVTCvOAtxsFeXgj
         qqcq3oI7ViKHl0m7p8m3/iPEe8lND1PKv82T3CSGEsFK3ulXeia3Coc/jT91aERSgwuL
         Sy5w==
X-Forwarded-Encrypted: i=1; AJvYcCWFVHJ5YEZujKspSR56KCTnxmGmolJTCTyvhgIC9IB9cZWHtOVpV1qrZdbg7oxXAuyyhmLO8/i1oqR35ho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2+xtd+I3MNZMNyYQxh48nhWwQNYBpAOIKUrTWydeAyAuI+/Km
	0BDOJaoh5lYnQOlzqZQvkRe2s0B/Z+UmEh8g+n5YoHXj4d4KmEpjqEtGl7euH3JnauU=
X-Gm-Gg: ASbGncuAvcKR1JJkz9XfFEUZ9y6kKsiPrl78bhP2Dq9qI2es2stFCgSxEL5mKvBkbCM
	XlEo3dmTLEKFbhOnAaI9tE74FJwG1KFWWZ4hLZcxkg7Kq+KQc6TUIKFy1w/mMaRTvt13tvuhdKr
	tupyTI0BW7EG9hRXu78GKTuNQzlak3CjPBUWmXi7rfvwNfKBJg89TsOAGP5rqMKrcVyVX1sJkt7
	cjk5ZYVpnjwuhQ2cP5Y2VSlCoKn190cv48MyPmQamUqaMFU4tdpD5I6+DEtJfrTMv0opUsFYreh
	hDfxkP2tj9SwZmgtjRbbAyEzSk6kU305SLYJyBRPOwoxpMHUqvWDvlYkSsEw/H25+OEk6k/O5p8
	MDMQPJ+6XE3m1SI7vtAyKXiZHF3RMx/j6mNjLuiK3AqBn/nd17DUtfF6QGge+2ZJDzSY=
X-Google-Smtp-Source: AGHT+IEqisaXdckEsmmcxObj6O4FSoVTk3hYpVc9SVopAMX5ioSdl8WKqu61bvDnQa3GhxoROjJGWA==
X-Received: by 2002:a05:6000:240b:b0:427:2e8:fe48 with SMTP id ffacd0b85a97d-42704d830d5mr616099f8f.4.1760635284356;
        Thu, 16 Oct 2025 10:21:24 -0700 (PDT)
Received: from localhost ([151.35.142.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0efasm35684377f8f.41.2025.10.16.10.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:21:23 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate
Date: Thu, 16 Oct 2025 19:21:20 +0200
Message-Id: <20251016172122.1220332-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074; i=flavra@baylibre.com; h=from:subject; bh=qhvgN3FL5LhV/QrYODPhFDcWPmr4o6Hpg4UP8n5lETY=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBo8SlAOLOUkrUqpaC+DPMV2Y3DzkHj8CeEQmfOE +xiTdzKd0qJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaPEpQAAKCRDt8TtzzpQ2 X/WxC/9aT7H5WIL3KMz9t5NerFm9Go4Vc0IP9cV+4Htbxvo3FpWzCwS7oAWQdhQNvvt+GkgyKY7 qSoGjbH5knDjg7H1vOtEMfIPdmxCWXWBg1uD6x3F6L1NwWwQ8eAwE84RRWBkvxS6bgymvVs47eM O+MIU3aJnWUyxsRkxwvjPOhvfuNl0HbeIhFg0cJyn9KsZouRp4C1dJeTLm29JY/lJJ7dfFoaccL lorvyW6l9LynEW+DoMipUft+RmjfdsFar6/PUVGkATY0ZGEfvIJnAtLzqu711DHSMZOKAkuUcc4 OeVEP08sDM+bULrf0qlaJDK7wLeWmnL8qigXXzJ/uJ3zYf9D3ukP+bd0YVtlFCYmdadO/Ar7CZL fCBDf9eW2gwa3LF1K2TkeS7YMPD7Ro2DI8ZEAUXmgvkSP9noz70Lc9NVKTN8duKL/gJPOgAdIx+ UzJuK2YWnbODAKbFuSj+6TSvMaJJ69TDgwDV8gFseedL8Wi4oWi/x0is2NI2D6c4r368o=
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

Changes in v2:
 - added Fixes: tag to patch 1/2 (Lorenzo)
 - in sysfs store handler, moved iio_device_claim_direct() call to beginning
   of function (Lorenzo)
 - changed new struct st_lsm6dsx_sensor field name from `bdr` to
   `hwfifo_odr_mHz` (Lorenzo, David)
 - replaced min_t() and max_t() calls with min() and max() (Andy)
 - added setting of buffer frequency equal to main frequency whenever the
   latter is updated via sysfs (Jonathan)
 - miscellaneous stylistic modifications (Lorenzo, Andy, Jonathan)

v1: [1]

[1] https://lore.kernel.org/linux-iio/20251009173609.992452-1-flavra@baylibre.com/T/#u

Francesco Lavra (2):
  iio: imu: st_lsm6dsx: Fix measurement unit for odr struct member
  iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  4 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 71 ++++++++++++++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  |  3 +-
 4 files changed, 70 insertions(+), 11 deletions(-)

-- 
2.39.5


