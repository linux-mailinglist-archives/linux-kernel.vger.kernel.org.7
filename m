Return-Path: <linux-kernel+bounces-877689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E8BC1EC18
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603B919C4BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD89933B6F8;
	Thu, 30 Oct 2025 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GF+3QyNL"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2EF33A039
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809290; cv=none; b=gGfZYtU+nkETr+KLJnbWYuvRU4GBlAd/s5DquCxAMcMXV6UAlbJ6c2mNNCSh1QnegmlIsOlg2tlY6MWEk/bSqyVTqpG+3E7GkGVxtRL8H1IKaZF7D6aWDunB+l74PZ1+H/XfR1hV6S1LD2azpMdKbiY11A+8jhNTjCmsRwbs2YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809290; c=relaxed/simple;
	bh=ryWrHwVNfLrlYPtWRwT19syvjek2k+I8uWyDlcucveg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=exyGnfdyYJ5vmu2er8eSWP8a1hGuCyUezn55uSOGCeTzXba3K7xgg3m5Z2FVlqkFQ/fFAdm5HTFnkV9C730IXtp8qSTYMS91KAUdxlpaIppRuomTV0AnXX5Wp9QRt7G+8AOmhzXk1h2E67dvJopxB3f6eAfwdrwwS45ISSyDkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GF+3QyNL; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b64cdbb949cso165266566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761809283; x=1762414083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mj5IeQfrnY7EW0pWlNNC0h+E0DMhgzqscBGxInRy3qI=;
        b=GF+3QyNLsVV+4Rvefo6Ss4Ihc+UefxKeRH7y4tvWl0W1V1olvGmhQtSgXtNIidf4DS
         YsO6E0F/ggSb0Aoc1Tt1pjHXQNj8QzCuk6/9rciEngQVLLTuBTlKDdOQufKymBUetFJN
         kYvKa8NB+eWMJeBaXVxdXEbLqQzVYClUpR+ama0LbqlYEVEc9+X3DV/0B/kbQIOxIDHe
         6B+Xplao1dQoOfQUF1Kmo5ofvH8BjVP98knSJx5UP6Ed8EeSuLCueI37lcOft/nMqKfE
         efWnMLCsMgJUUp9eFx4nbHoeyzPNycHTNKS2hgGf2jGc/V/+x75Wynp2vbSKgHVkKOTf
         M9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761809283; x=1762414083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mj5IeQfrnY7EW0pWlNNC0h+E0DMhgzqscBGxInRy3qI=;
        b=DLe3QdgmgaPUgQ8xtwL98xpMZ04JEScGcw1XQesjBSsIBLdHnfVN9SeAwvGMHpayx8
         J54Gzif6pPWtfL1H03GUHCSD2OpJzTR0OtEQKJLBPWDNxUNHJClLbydl30eo5zKJJlar
         Gaiieu/MUkm4ggaNozcyL/LTpmDymDJ64VpaDK5KWgIeEJt0DSU4/zIFJbLUzV9tgDiz
         l3ggKbi50ymTOdbFOkqFgNJ8zduYRHmW8HT3NqRtPqxtEQupyzAZZ351oUymuApYj+at
         +V0+Yilki5RRVmfnMD6QSNnppGaPP7qZh3fl1S0w0fozWz8uu1Xn0mk2tjmAVg/dnkVc
         iZqA==
X-Forwarded-Encrypted: i=1; AJvYcCV9+jHERKvDXRXV2aA9TRnUxggDg4QFeYbeUAprQ/jVxA0+5mtqKR9eJF8Th0uA5+dkuKfd6xgHWxMhJHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0++W3gp1fKS9aQxUfkETg+/i2jXiK4lBtvvVOg2Lx7xjpLFgw
	zdKHQbW3Zxk1Mp1tzo2WBd6DIJCynbBAjESAm4/7MolwoR3YBkeYSUT2gvVAhS+KzTY=
X-Gm-Gg: ASbGncsuE24tSveTzBq9MYYqpFgD+v1n/jCrFDpS7T3ZxqwTNYi6l7H63y05n8iGOGa
	O5Gf5e/1kb6qtGFuNBK+hCguFkUQyNOuNK7qZfBr/l5L0Lbi1g1ZcJy3BHcmXUJHQauVIQCSj4S
	5hSdHrulb/a3zhGSHJFncQ02jtPNxd2x/BGxvPgf1qOhrdZ7Zkzey6WMBlrGDBzs9vBnny7GnnI
	6J1lotDtA4lyb6xD4lI4xiuPsfc3fsz+sSfIjCqj3wgcpvNlrTWTb9/AJOVU8m/SHHMHjAdW3ww
	DYcTXVjSUrmte4/OaGHKu482SCCrzbQiBYq+y48Ikcn2IQcbE1MKyx23232o9/JnwnAxsIZCbW4
	GTjtu6DHd4hWQqIn/HusarXifDRl/8ANx7HY/FKIIQVXZtD02xWoH9MTKtpXhTYqHn54UZrEfIg
	grR59N9rUbKse8esLFdsymtzqkVXVdfKg+aAl9
X-Google-Smtp-Source: AGHT+IEKsu/bkeeIK0jg8SgH2xnO4BzyoQGDQXrrvwW8FZKWoxRprqP1EvGLr4TamAbC/0bHRkjfRw==
X-Received: by 2002:a17:907:a088:b0:b46:31be:e8fe with SMTP id a640c23a62f3a-b703d2b187cmr591713266b.11.1761809283450;
        Thu, 30 Oct 2025 00:28:03 -0700 (PDT)
Received: from localhost (mob-176-247-57-96.net.vodafone.it. [176.247.57.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d854763b1sm1661301666b.71.2025.10.30.00.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:28:03 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] iio: imu: st_lsm6dsx: add tap event detection
Date: Thu, 30 Oct 2025 08:27:52 +0100
Message-Id: <20251030072752.349633-10-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251030072752.349633-1-flavra@baylibre.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3025; i=flavra@baylibre.com; h=from:subject; bh=ryWrHwVNfLrlYPtWRwT19syvjek2k+I8uWyDlcucveg=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpAxNLuoGQgeF2bVzRfpEk/5RAI+1zVrRkSrMrR b1W978ht+qJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaQMTSwAKCRDt8TtzzpQ2 X9unC/41B/+tkoh1a9dryX84uhL23mUeKgMj7JYCt1IIZ1qSNZBtB2rLTi1m5wwg54p3FODIsRo QJ5cE8soOw4PEvXngPTLIEK5YsAfdNRLa58GMegk4x603vcjzw7CrF8gGDc8/SdWv7OIPtG+TQy ODt4rU3HltHbDEMce9jR0xwdc24dsrh89KyQZkoBnnuIPOMNl99Bp6v750rQdOHGIkwR3fLgDRz dgfDEnNAFiZVtL9QXZ9PPnaheX6uxLT3gP51wRm285M0PR9+p+MqKDKb3msjzi5bm3KHR/gzUQP oc8edF75oSicvW/mTBb3UXWlxxVWq+8qL9KjFmpw5CEzDFN4rPbKCiAbkwaM4RlLxAb0YEHPpXn 7l7kFfwLOr4QPQ4+9Djh1NnNTNMN5wjAy3jsLiVVys5KM9AMCYt68y34dMRdTv6qEV5mr71Deh1 gy0n0m6yh8F55IZOKa3K0IGNpY4s3xxJnPTv2r/wsIo+MwbQUtShc1IzdESuLo//GCq0k=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

Add the logic to advertise tap event capability and report tap
events; define a tap event source for the LSM6DSV chip family.
Tested on LSMDSV16X.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 35 ++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 62edd177c87c..75953a78fc04 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -223,6 +223,7 @@ struct st_lsm6dsx_shub_settings {
 
 enum st_lsm6dsx_event_id {
 	ST_LSM6DSX_EVENT_WAKEUP,
+	ST_LSM6DSX_EVENT_TAP,
 	ST_LSM6DSX_EVENT_MAX
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 6d1b7b2a371a..1bc69c6c1b9d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1349,6 +1349,30 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.status_y_mask = BIT(1),
 					.status_x_mask = BIT(2),
 				},
+				[ST_LSM6DSX_EVENT_TAP] = {
+					.x_value = {
+						.addr = 0x57,
+						.mask = GENMASK(4, 0),
+					},
+					.y_value = {
+						.addr = 0x58,
+						.mask = GENMASK(4, 0),
+					},
+					.z_value = {
+						.addr = 0x59,
+						.mask = GENMASK(4, 0),
+					},
+					.enable_mask = BIT(6),
+					.enable_axis_reg = 0x56,
+					.enable_x_mask = BIT(3),
+					.enable_y_mask = BIT(2),
+					.enable_z_mask = BIT(1),
+					.status_reg = 0x46,
+					.status_mask = BIT(5),
+					.status_x_mask = BIT(2),
+					.status_y_mask = BIT(1),
+					.status_z_mask = BIT(0),
+				},
 			},
 		},
 	},
@@ -1846,6 +1870,8 @@ static enum st_lsm6dsx_event_id st_lsm6dsx_get_event_id(enum iio_event_type type
 	switch (type) {
 	case IIO_EV_TYPE_THRESH:
 		return ST_LSM6DSX_EVENT_WAKEUP;
+	case IIO_EV_TYPE_GESTURE:
+		return ST_LSM6DSX_EVENT_TAP;
 	default:
 		return ST_LSM6DSX_EVENT_MAX;
 	}
@@ -2427,6 +2453,13 @@ static int st_lsm6dsx_chan_init(struct iio_chan_spec *channels, struct st_lsm6ds
 				event_spec->dir = IIO_EV_DIR_EITHER;
 				event_spec->mask_separate = BIT(IIO_EV_INFO_VALUE) |
 							    BIT(IIO_EV_INFO_ENABLE);
+				event_spec++;
+			}
+			if (event_sources & BIT(ST_LSM6DSX_EVENT_TAP)) {
+				event_spec->type = IIO_EV_TYPE_GESTURE;
+				event_spec->dir = IIO_EV_DIR_SINGLETAP;
+				event_spec->mask_separate = BIT(IIO_EV_INFO_VALUE) |
+							    BIT(IIO_EV_INFO_ENABLE);
 			}
 		}
 	}
@@ -2553,6 +2586,8 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 
 	events_found = st_lsm6dsx_report_events(hw, ST_LSM6DSX_EVENT_WAKEUP, IIO_EV_TYPE_THRESH,
 						IIO_EV_DIR_EITHER);
+	events_found |= st_lsm6dsx_report_events(hw, ST_LSM6DSX_EVENT_TAP, IIO_EV_TYPE_GESTURE,
+						 IIO_EV_DIR_SINGLETAP);
 
 	return events_found;
 }
-- 
2.39.5


