Return-Path: <linux-kernel+bounces-877688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D5CC1EC0C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B4E19C455B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2785F33A036;
	Thu, 30 Oct 2025 07:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xWsNjuTv"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3F4338F23
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809287; cv=none; b=TIc96CowNszGSjJYq7y8E2ritNNDsfFtExlgzMMkbH2oxqkBm00YzTe+J6MqtAOctX7NlD0x3xBoGUNjyWyHROVxe3qD4zperP80tkbwlX/a5DoSbV+5zI6Uewfz37mKpu3qc1IIJz96m5xE2yn7F8wPGcB7vZ9uUAzycg8R2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809287; c=relaxed/simple;
	bh=WcwF899ijzMkV7KsctD1Rs0qOwaqBA4nOWWB8G5J4uI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O38XacfMBoegh8eVP0amCTvPkHor1T4nHyt6hHqmkfVwA9OyN/ebslsfGyj0Ef7dL/A2Jhq5GNMLFS6HgpcDjnvq+Rf7NbyJKoiw3m7AL9UYHAN0QJy8+pHmPy13JojeW3GP8vx9opSkhHfQf/hJhPBGRary9oIq9PEWgW5vz0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xWsNjuTv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c2d72582cso1228591a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761809282; x=1762414082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iU3VmjxFWQVTxfFInnvPCoNmKzRhY9rVV2g8Tv3wIqE=;
        b=xWsNjuTvqmWXs4D9WC3oi9DyKdk6L7mKQ49janzmAsVPH5IfiTlkZ9HK1Yel4T+3/e
         3fob1uvPOY1nT21gjTw9mr1V6K13+BsYgtRwNuNqKr/5WQq04ALgECcVtcuir/RODIUD
         lfk479H4dsygc4PdhFh2+8jFMRzF1iXzC9RiBV+SyFKz8/0Y81n5Emh4XWeGhMvYdX6o
         SQlpusqynfWwA/QVp/v/ju8B23DaMfT/VwSIAhI+1KfJr29t2kMx6Biqs0gHHfV6yEOe
         pOsYG3hlUGLu/d+sAjS4zIxax/WU+ciUONuv3XZX72NkTsTOCW8AJcqp96tIrC4Ejfo8
         OfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761809282; x=1762414082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU3VmjxFWQVTxfFInnvPCoNmKzRhY9rVV2g8Tv3wIqE=;
        b=tYYLbMVirrWUqOwxZ5AywtYg1Z9ZYtgrYCcldVCJ/aiHdhDpuABS5Q2HxlERS9S0mT
         KgSrZUszoktGOR8qKqs4jkkzkWT8JwoZsfKmyiuGeAXqm3UKzv6BPyZtq++RRVQfLJY8
         oQUpSqQFS0n8HUIx5d/6XKVuZXVgIuQ9KJE40IGzb6WMgC2kuccdkelBfhcwCtj6tq2Z
         SBcFf/8xFu5WUuAipzMaiqbPNpdWDaJVFDIBYAQXGpkqpciR5B6F/uUNEIacnVezR8SY
         Aac13s1htorg80muRofKa0/FqZH4oIVI2gAQZW6+fN5xA274K4xGanA6oBNxd88P8rQ7
         db6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRexAFsd5ngRlRe/GcpQXZL0t5j/jpoviUbAZvrPdK28r4kM/BMtPIMa8modwVguYN9FBh9n43+vYN89s=@vger.kernel.org
X-Gm-Message-State: AOJu0YziuVhAnjRR/b+F9FOvPEhmdxFM23urcpI8+Sv3PWdf3VdFMGfM
	nTom82YQBm2LKr5l41eus9xNJO8aH/G8IZPY0RoX71JpRem/4VYwlrVI42fpXN+zqZo=
X-Gm-Gg: ASbGncue1Dx2LSr/TndlWgzl5qCqVrvxosOTGC7qAu4zocKy7ypSv/gyRGzVYZQ+gZF
	f2wou40Ba6JsynUzVG1YTiffwSW5bHarW3oRscCVbGHCSoTW2H3vEFaghRLi2ORhgP7iRv+XpiB
	xAzt8rra9WJui57INSaF7muZkOqXpw1e8JwG050QZbDMRxZb2HCIeevblF0IR2R5QTr3a0ndT6T
	vq+k8IhjnD5icu34efFAgQ5uelXjAhsNL1s8b1Z9BtzAsxms9URLkHvBvkBSi0e7vaRIWgycF2O
	c/udjHDiMRnDpWVH6gF2CdOcNGTe9W4AnasRZpAEojYil98xnvn/2kRHy9MyWEHA/6KOQIUmGoK
	9Vhha6bli01It9x+Om61rNk2VdSWAPnlEpiysoNhR9aEko0x7hC9s/m2/BHtbmfHq8YoUykUSq4
	eFlXgIc6/C7iE2g5GubtdCKNIK9H+C92Re/R+i
X-Google-Smtp-Source: AGHT+IGk4IG0pOgH6w0d4p7m6u5vpiZbUz4rJ/M64G/oyDVzMmCpWEQhZEqdyBbrxSEcpB1EqYyZrg==
X-Received: by 2002:a05:6402:440d:b0:63c:215e:4377 with SMTP id 4fb4d7f45d1cf-6404424a5bfmr5200349a12.24.1761809282442;
        Thu, 30 Oct 2025 00:28:02 -0700 (PDT)
Received: from localhost (mob-176-247-57-96.net.vodafone.it. [176.247.57.96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef9a5cbsm14151348a12.23.2025.10.30.00.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:28:02 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] iio: imu: st_lsm6dsx: add event configurability on a per axis basis
Date: Thu, 30 Oct 2025 08:27:51 +0100
Message-Id: <20251030072752.349633-9-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251030072752.349633-1-flavra@baylibre.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5102; i=flavra@baylibre.com; h=from:subject; bh=WcwF899ijzMkV7KsctD1Rs0qOwaqBA4nOWWB8G5J4uI=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpAxNL4n9ehavBMpqRL2pwa2X216ad7wnHUYFlu w9apBAI6Y2JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaQMTSwAKCRDt8TtzzpQ2 X8T7C/9rHBv1KulTrWD/56agpc3fL1uB0j7Yl1kfeit7xbnJADo2NKexHNOOkE6cPNuqV9ICL7H Q4y81WOD7z+9+X3zDW7etoUkFDQas78lsEAVAlGeyEXASz7cSMxAIqnHKnFT2Mch3ppwFcSoGtc 7e8CP7035Zpt51QtAmNw+GE5GegUf6ZJFka+ZlwR57PNrlEIvFZZSttAZw7iQw5emt32JuSe576 Fy6jaoS5XrlhEfrVlyjbOH5Ro75qJ3YIkw/mM2EymvLo/C40MvfC23fAs2Uw6QDm8yqV2tE3lyP 0OjthEhx+jADriOiMh+6UYdMtxBOvDhqpx5JWrUY5/ns02dyfbXE5Mf4XAd9EC5suyV2Heaa9aD qyft9xvM7fav9JtvTHtmml2dPo36dJIHvjEcQZdB0liA/dSq5WeGDd7pzdWKPbHPPiLk+976XKN woEKoe94PF2evpksGNM9i9rur83Tye6+Al2LQAWSKmQbHNNFARpaPv9m3b1mRHL6u0QBo=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

In order to be able to configure event detection on a per axis
basis (for either setting an event threshold/sensitivity value, or
enabling/disabling event detection), add new axis-specific fields
to struct st_lsm6dsx_event_src, and modify the logic that handles
event configuration to properly handle axis-specific settings when
supported by a given event source.
A future commit will add actual event sources with per-axis
configurability.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  7 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 77 ++++++++++++++++----
 2 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 0e0642ca1b6f..62edd177c87c 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -228,7 +228,14 @@ enum st_lsm6dsx_event_id {
 
 struct st_lsm6dsx_event_src {
 	struct st_lsm6dsx_reg value;
+	struct st_lsm6dsx_reg x_value;
+	struct st_lsm6dsx_reg y_value;
+	struct st_lsm6dsx_reg z_value;
 	u8 enable_mask;
+	u8 enable_axis_reg;
+	u8 enable_x_mask;
+	u8 enable_y_mask;
+	u8 enable_z_mask;
 	u8 status_reg;
 	u8 status_mask;
 	u8 status_x_mask;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 87d40e70ca26..6d1b7b2a371a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1802,10 +1802,38 @@ static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, enum st_lsm6dsx_even
 	u8 enable_mask;
 	unsigned int data;
 	int err;
+	u8 old_enable, new_enable;
 
 	if (!hw->irq_routing)
 		return -ENOTSUPP;
 
+	if (src->enable_axis_reg) {
+		switch (axis) {
+		case IIO_MOD_X:
+			enable_mask = src->enable_x_mask;
+			break;
+		case IIO_MOD_Y:
+			enable_mask = src->enable_y_mask;
+			break;
+		case IIO_MOD_Z:
+			enable_mask = src->enable_z_mask;
+			break;
+		default:
+			enable_mask = 0;
+		}
+		if (enable_mask) {
+			data = ST_LSM6DSX_SHIFT_VAL(state, enable_mask);
+			err = st_lsm6dsx_update_bits_locked(hw, src->enable_axis_reg,
+							    enable_mask, data);
+			if (err < 0)
+				return err;
+		}
+	}
+	old_enable = hw->enable_event[event];
+	new_enable = state ? (old_enable | BIT(axis)) : (old_enable & ~BIT(axis));
+	if (!!old_enable == !!new_enable)
+		return 0;
+
 	/* Enable/disable event interrupt */
 	enable_mask = src->enable_mask;
 	data = ST_LSM6DSX_SHIFT_VAL(state, enable_mask);
@@ -1823,6 +1851,31 @@ static enum st_lsm6dsx_event_id st_lsm6dsx_get_event_id(enum iio_event_type type
 	}
 }
 
+static const struct st_lsm6dsx_reg *st_lsm6dsx_get_event_reg(struct st_lsm6dsx_hw *hw,
+							     enum st_lsm6dsx_event_id event,
+							     const struct iio_chan_spec *chan)
+{
+	const struct st_lsm6dsx_event_src *src = &hw->settings->event_settings.sources[event];
+	const struct st_lsm6dsx_reg *reg;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = &src->x_value;
+		break;
+	case IIO_MOD_Y:
+		reg = &src->y_value;
+		break;
+	case IIO_MOD_Z:
+		reg = &src->z_value;
+		break;
+	default:
+		return NULL;
+	}
+	if (!reg->addr)
+		reg = &src->value;
+	return reg;
+}
+
 static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
 				 const struct iio_chan_spec *chan,
 				 enum iio_event_type type,
@@ -1840,7 +1893,10 @@ static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
 	if (event == ST_LSM6DSX_EVENT_MAX)
 		return -EINVAL;
 
-	reg = &hw->settings->event_settings.sources[event].value;
+	reg = st_lsm6dsx_get_event_reg(hw, event, chan);
+	if (!reg)
+		return -EINVAL;
+
 	err = st_lsm6dsx_read_locked(hw, reg->addr, &data, sizeof(data));
 	if (err < 0)
 		return err;
@@ -1872,7 +1928,10 @@ st_lsm6dsx_write_event(struct iio_dev *iio_dev,
 	if (val < 0 || val > 31)
 		return -EINVAL;
 
-	reg = &hw->settings->event_settings.sources[event].value;
+	reg = st_lsm6dsx_get_event_reg(hw, event, chan);
+	if (!reg)
+		return -EINVAL;
+
 	data = ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
 	err = st_lsm6dsx_update_bits_locked(hw, reg->addr,
 					    reg->mask, data);
@@ -1915,20 +1974,11 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	if (event == ST_LSM6DSX_EVENT_MAX)
 		return -EINVAL;
 
-	if (state) {
+	if (state)
 		enable_event = hw->enable_event[event] | BIT(axis);
-
-		/* do not enable events if they are already enabled */
-		if (hw->enable_event[event])
-			goto out;
-	} else {
+	else
 		enable_event = hw->enable_event[event] & ~BIT(axis);
 
-		/* only turn off sensor if no events is enabled */
-		if (enable_event)
-			goto out;
-	}
-
 	/* stop here if no changes have been made */
 	if (hw->enable_event[event] == enable_event)
 		return 0;
@@ -1965,7 +2015,6 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	if (err < 0)
 		return err;
 
-out:
 	hw->enable_event[event] = enable_event;
 
 	return 0;
-- 
2.39.5


