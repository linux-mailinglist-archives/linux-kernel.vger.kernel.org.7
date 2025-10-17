Return-Path: <linux-kernel+bounces-858533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54141BEB133
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0145E4EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734D0306B20;
	Fri, 17 Oct 2025 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kkUTA/rT"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3D2F0C75
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760722334; cv=none; b=gmTbCEQqL37BfbOE6Gs34UXWIgPgdS0id6P/QImmK42vOdxewBra9A4sCp8WUKgQqo/Vzw9/2dTmGsak0SGtWOu/QXJjlSSz9bktPbVQXQAEFJBdtTeJ2MWEup2ariy0aCgfSNIjkVl4pvxRQ3iQofTacjDo/eMe2dxiFv8Knig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760722334; c=relaxed/simple;
	bh=Vt4QuNpa1HskNCLVWXjo6kfPhjGorIFy2mKeAkCHnjg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Dp0/0+a2qtsygzuftRO1rhwdQhUDrmQyZkwhOV5Rv6FvL1o5IR0wjUg+nIczUauOF+3bB2/bhAc57l7GJg+3ENhKy0xAXIh0zBhkk/MSAQcMgovabhrJgzGYSw76rLVDiOVGbyhog1kgcVT2H50h3Ko9TW68mYHuYe3B14R8/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kkUTA/rT; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63994113841so3813105a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760722330; x=1761327130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUTogbEE62M9rZ8zQUrRDxkGI0cZ9XEO0tggIYX7Y2o=;
        b=kkUTA/rTwppLA4aG7m5S5grrDWTFDpz6ciNy6kV4zA8zE4Aofs14qS63PkxRmyIbWW
         qrbZFnzGPS467rF8dpF7ab00FdjWsXT+ctc1lPbg/FsQG0KDXm1b1UJmC5w4trwCpTo3
         rSkVRrw8pj/NWPc0bKu4SSEVxGomqmA1VoaSZmxmLLM6C6xYGmkPIeLp2XNsp+nS4Srm
         v4U9c4XSY+Nwbfqj43MCig5IdwjEQbBd6NsQvj7TSh6tlfuCpwa+x+/fD6EFYN6wOUB9
         iPzPsNV+Vzlhp2KOVY2vg2xSatdoFA/y4wN/jBcmpudmnxw0LtXTK751vWdjBFnMe+n+
         kamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760722330; x=1761327130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TUTogbEE62M9rZ8zQUrRDxkGI0cZ9XEO0tggIYX7Y2o=;
        b=fQDMUtfgzzv0QZ00O5Zcn/cUmyTmPWzo+y/kLhkU/0qtOs+sreXa2+I6h3fsIY5kzr
         ZqmBndR8ZoWDvf/k5IKHBitdwESU3SVDAZdGzqOffpYL6i1zviKjiEqaMyTO46pINGjK
         zmOsIrvCrUd2uU+JkkZNIa79WiJOs6uonoY1bFB2gvSHqdoNhUaZk7R1I4TtWbTini8g
         rqW8x9pTInd1lAFUik5XnPy7BEk/bbT6GVUTOwFEEfLN/Pre7S6QY6XxUieiqGVJNRvX
         k8/flH9qZYz4+AwTzC3udD+R3vJZUlkWSxkBWET4uwhCA1/S2bDJwQ4Y2q9+nlytIlCR
         Ut5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUC3gQKoWSbuWKlF42heoSL8v0MmYXwdR9Uwbg/B0zdx4dvSorRTpG062amFaz7SyWUTN1wwVUmS/KPn0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP2gwFc1nYZNSQGzQ5x5oBI4ku89G0Mlx2QETEJr09iR5Vsvnc
	dvgipBjJiFPzg9Wx9fO02/K5s2DRZ1h+tpf9yvRzXt7UX9OA6dQUOCZz488ZmoBzPc0=
X-Gm-Gg: ASbGncv+ctdkUqUFgEUMuI6eD4wsyW+MU4JNRDm9pbDB0ocghgAhfDZCSBg/FT6xprU
	2q0pUFO7s2xZze6mD+mRqhpet40WZkxlW0vymRKRJ08cxcmIRxUL2xeNDFvOhezNJ7WyU7dBcS+
	8/r7IIKS+HRmTYr3x04iCRUjer9/2CUS2SToIsMnUYsDvGzCbGXs2kvyJnl5aP6TA4M2yCg0Pm2
	vcdIs5CYv9STcL/TyHKn7TrbpsK5nzKd9T3cnJKVTrs215GkmNpLMBlqPkS6GAzK9gSEdedMnnM
	AoU45+5Z0zodxSilE1yUe8xFLBm/ntt7QH9hSfA44Mh9/mTyKKIk8AKl2asCde4KKi4iSaTOiR3
	Clbzrkn/dn2XkRr9yl5/LX7CdlZiuF9L+24jh44CWI7xBEGLATGkpfm6dxD4x8sK9DVW1KQccev
	Yktw6yxgBt/McrKSO2flQX61qxlUhJ2D+OrDx5
X-Google-Smtp-Source: AGHT+IEZ+7ajqngcGNRxS4IgmVgR6llUtRmBUAcwez6MZC50YpqE5y+OqWJMpaWDWfZCfD0IY+W7Eg==
X-Received: by 2002:a05:6402:1d49:b0:63c:43e6:16f7 with SMTP id 4fb4d7f45d1cf-63c43e618d3mr1622123a12.26.1760722329861;
        Fri, 17 Oct 2025 10:32:09 -0700 (PDT)
Received: from localhost (mob-176-247-36-41.net.vodafone.it. [176.247.36.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48a928c3sm235947a12.3.2025.10.17.10.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 10:32:09 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: fix array size for st_lsm6dsx_settings fields
Date: Fri, 17 Oct 2025 19:32:08 +0200
Message-Id: <20251017173208.1261990-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2218; i=flavra@baylibre.com; h=from:subject; bh=Vt4QuNpa1HskNCLVWXjo6kfPhjGorIFy2mKeAkCHnjg=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBo8n2KwMuel9b5XNmYBoUVfInNSwF1QhazfH4cA 4znIA7EHLiJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaPJ9igAKCRDt8TtzzpQ2 X7q5C/9/OMvjhN/4aiwg+ptdRZZrcPXmWex5mXe9uLy8P5lZ7baavSMvhDKMPljoSL51CS4LcxZ N7y93rQWSD/n8Y4fOXHoVVoKVDo1hF9U/yG3OLsZ2IWOqTS/bRYXmxT52rAnSnxuRYU88urAExw ZBJUIepXoYsKZE5Y9OkE7DuV1gSYvNAZtVnPu+2UikR2Sjm4g2TjaT3sfChQrFMhGgBknPKUXnQ B6jAA8RxX1nmhfFoXQHW3HJo6Zu4taYfulxZwfmqqPCIrL+GSzR/IGLrWV2Foa2YHZKEy6amcm8 dyFt7+GYgx4AyWLEuKWwEy2sCD6chgg7uCUWLF0DoDAi5IwR4xL9icHp/oEAcS2EH4ohWLkF1Mf N6m0cf10ekT1+RXD2oneMEieHxqvsyMWsWHhjGzOZlUK0JdRVNra3yy55mRWR2kRX6ZIw34Do3Y FmKnvGQZF41hP+l/9OxaEEs1KGaZwHngXMzrhT9cSwpI8hmhFu4c36iUURujfxmUiL1E0=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The `decimator` and `batch` fields of struct st_lsm6dsx_settings
are arrays indexed by sensor type, not by sensor hardware
identifier; moreover, the `batch` field is only used for the
accelerometer and gyroscope.
Change the array size for `decimator` from ST_LSM6DSX_MAX_ID to
ST_LSM6DSX_ID_MAX, and change the array size for `batch` from
ST_LSM6DSX_MAX_ID to 2; move the enum st_lsm6dsx_sensor_id
definition so that the ST_LSM6DSX_ID_MAX value is usable within
the struct st_lsm6dsx_settings definition.

Fixes: 801a6e0af0c6c ("iio: imu: st_lsm6dsx: add support to LSM6DSO")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 3cd520bdec46..a4f558899767 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -252,6 +252,15 @@ struct st_lsm6dsx_event_settings {
 	u8 wakeup_src_x_mask;
 };
 
+enum st_lsm6dsx_sensor_id {
+	ST_LSM6DSX_ID_GYRO,
+	ST_LSM6DSX_ID_ACC,
+	ST_LSM6DSX_ID_EXT0,
+	ST_LSM6DSX_ID_EXT1,
+	ST_LSM6DSX_ID_EXT2,
+	ST_LSM6DSX_ID_MAX,
+};
+
 enum st_lsm6dsx_ext_sensor_id {
 	ST_LSM6DSX_ID_MAGN,
 };
@@ -337,23 +346,14 @@ struct st_lsm6dsx_settings {
 	struct st_lsm6dsx_odr_table_entry odr_table[2];
 	struct st_lsm6dsx_samples_to_discard samples_to_discard[2];
 	struct st_lsm6dsx_fs_table_entry fs_table[2];
-	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
-	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
+	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_ID_MAX];
+	struct st_lsm6dsx_reg batch[2];
 	struct st_lsm6dsx_fifo_ops fifo_ops;
 	struct st_lsm6dsx_hw_ts_settings ts_settings;
 	struct st_lsm6dsx_shub_settings shub_settings;
 	struct st_lsm6dsx_event_settings event_settings;
 };
 
-enum st_lsm6dsx_sensor_id {
-	ST_LSM6DSX_ID_GYRO,
-	ST_LSM6DSX_ID_ACC,
-	ST_LSM6DSX_ID_EXT0,
-	ST_LSM6DSX_ID_EXT1,
-	ST_LSM6DSX_ID_EXT2,
-	ST_LSM6DSX_ID_MAX,
-};
-
 enum st_lsm6dsx_fifo_mode {
 	ST_LSM6DSX_FIFO_BYPASS = 0x0,
 	ST_LSM6DSX_FIFO_CONT = 0x6,
-- 
2.39.5


