Return-Path: <linux-kernel+bounces-838417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06461BAF23C
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 07:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DDF1C7742
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 05:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D55254AFF;
	Wed,  1 Oct 2025 05:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkahNtKm"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8281C224245
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 05:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759295908; cv=none; b=Yhr///CpZR8oOPEpKoT/b9Qy/qqAyfDNxzPtmucMRMcvUAm+5PiBWQhxX01lST657nq5aXUIEqxJ9liLu08rKe/a6AEIQ+AR6Xjc+Pz+yIzF9/W4UsmuuVLaC9HvKz8M6mlNVg2lNkALaFXnWbWEhG/rYDKWCNTwK1URTpCVbFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759295908; c=relaxed/simple;
	bh=xxwvSBOILhwI15jLvRnwksExUOxD0yHKJNQdrM8Ov34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtHa7vB/I+uKrhB7aWR+7tvtofICCgMro61su1vfNbYj2H4iFIysUP8+sAzD+5TSPis1Tz9GO6ToT1s1Xp2DvZ97hZzpKIeqEB0eMeejImWMB0JOBKsXBUIb+EPWd4zAi1ARS91FVAU/G1IUesZEyCvU2FsrItyL2tiHNR4rpIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkahNtKm; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4e0302e2b69so36572531cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 22:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759295905; x=1759900705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5FSwmUJbMLVCjFRb+Vr5NhUBdgOWlp+2CBEpJK60MQ=;
        b=EkahNtKm7ETMCDuIeGWabMBZfEmDSxBry9Xu3SGh54RjR+3Cioje9VzHDy+s0DsRf+
         0VGOabiFdQLJXjqk6sqfeGxL5gA5V6kw+dw7s6LTxWWg1Ss836fCv6gLh/74nT8EzuZr
         7sKmaq4708/QpGc9IwPi2gH/1TGuAhor1wtmoQoiP+OB6id36MW0yhvMMDWIc7fmC6Dt
         A6aoanB4Qku87lF97Qoe9iNGZEwX/sWHh4qCo8nbLF1236aYmYjWOvffB+OcMFkUd/Ey
         xxradOE7A6Tetz5WqZ5jz9vzItphzvEE/Nmi68lv7eTUQ1CsHR/xf07PnknxFXXCQrrg
         zccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759295905; x=1759900705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5FSwmUJbMLVCjFRb+Vr5NhUBdgOWlp+2CBEpJK60MQ=;
        b=f9d0QANPWYeXA3toMpOxcqzY1cqdiWS/9f0m95+7NthR29MIpruj93sLTZ+g7eMyzw
         TrwFdM57eY8W5QuFxiqC8Spx3atlTcNjEz42ig0KN8+0vfuUcjIJz6fwg6rieulYE07J
         R3ZLuxxJC2Gi2xDRO66kmxaBzbbsVHAVD0AARN6p+/Ny/hrWMplgo9Hngiuup14XvT3Y
         3u9pjaax9R2VgNfJnQTn1ZzFyaOK0rt3+HzSLNttPFmkTXNmZCRQLV+gZ9Q0Y6p8/8vn
         0PpNHpSLzFbFUBkdpe6OQaqqh49vXBJvXf0wbXCkZkV3oPQTvD5Mgy7NttgK93hy/mZD
         6Agw==
X-Forwarded-Encrypted: i=1; AJvYcCUNck4NMP0xygvJe6xbuuBCl+GmH0use12LBozKEbvik0Zp3wSK7Bgqoc6+wCtBltUPzsyiTbdb7eyl5MY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc8k2HUk4QgFP63EkKqo5Bdgh0rBTBmLV/HyMlHB99m6H87blg
	fhwFvIFKZqpvuJo41RDuJT3wYhvYnNATi1okdz/aW8bnfrIIaWCwmJH1
X-Gm-Gg: ASbGncutIBWU8M7M9P5TaxIW7M0vpox3Jzs++BP8dWaO+YsmXESF9+t1ZzfvDiXHSiJ
	GwxASMBgbS+LP8QwcSIGiTy2+JK5LgufCCiezJHA3CcQZwfN7eibng5lLA7tPXIaPDYOjs0Ou3h
	1Z9n945fLx3FDY+OWTN8B7vozwGqcZ9v7M4YexTRZsTxgwDSOGkVdJinurMiZQ3yfgWd8/mgG+l
	dJ0v6RxGMD88roi3O7GVIovyLYnNeft5nDo6lIp8CIItZCM1+EVUyuaQyCbKtJTg7egiyawu3N+
	To7VRyHYJLayVkL/nNHQ23cgAiB5RsnIXu6ZEzOLeyekk7BPBfjLBZhnqWgMwpzDI9HkFR4EYod
	yHwMncDvqbyyzBOucsvsKGGFWZ2iIbVKcPpLtCIs8vf1rNhCClaKj3Z4=
X-Google-Smtp-Source: AGHT+IF2ea21HKAS81wLf56Mq0AIPSr600EN/0rVVpbnaxu/GWrAz/8h8pQHVucR38/aYa3a/AU9dw==
X-Received: by 2002:a05:622a:1214:b0:4b5:eb27:c241 with SMTP id d75a77b69052e-4e41c352d09mr29188731cf.3.1759295905244;
        Tue, 30 Sep 2025 22:18:25 -0700 (PDT)
Received: from localhost.localdomain ([23.162.8.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0b56fe22sm107656811cf.20.2025.09.30.22.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 22:18:24 -0700 (PDT)
From: Forest Crossman <cyrozap@gmail.com>
To: mchehab@kernel.org,
	linux-media@vger.kernel.org
Cc: Forest Crossman <cyrozap@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] media: mxl692: Add configurable crystal and MPEG settings
Date: Wed,  1 Oct 2025 00:15:26 -0500
Message-ID: <20251001051534.925714-2-cyrozap@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001051534.925714-1-cyrozap@gmail.com>
References: <20251001051534.925714-1-cyrozap@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Other devices that use the MxL692 need to be able to adjust these
parameters, so add them to the mxl692_config struct to make them
configurable.

Signed-off-by: Forest Crossman <cyrozap@gmail.com>
---
 drivers/media/dvb-frontends/mxl692.c  | 38 ++++++++++++++++++---------
 drivers/media/dvb-frontends/mxl692.h  | 19 ++++++++++++++
 drivers/media/usb/em28xx/em28xx-dvb.c |  9 +++++++
 3 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/drivers/media/dvb-frontends/mxl692.c b/drivers/media/dvb-frontends/mxl692.c
index bbc2bc778225..9ecef72263f3 100644
--- a/drivers/media/dvb-frontends/mxl692.c
+++ b/drivers/media/dvb-frontends/mxl692.c
@@ -29,6 +29,9 @@ struct mxl692_dev {
 	int device_type;
 	int seqnum;
 	int init_done;
+	u8 xtal_calibration_enable;
+	u8 xtal_sharing_enable;
+	struct MXL_EAGLE_MPEGOUT_PARAMS_T mpeg_params;
 };
 
 static int mxl692_i2c_write(struct mxl692_dev *dev, u8 *buffer, u16 buf_len)
@@ -879,8 +882,8 @@ static int mxl692_init(struct dvb_frontend *fe)
 	xtal_config.xtal_cap = 26;
 	xtal_config.clk_out_div_enable = 0;
 	xtal_config.clk_out_enable = 0;
-	xtal_config.xtal_calibration_enable = 0;
-	xtal_config.xtal_sharing_enable = 1;
+	xtal_config.xtal_calibration_enable = dev->xtal_calibration_enable;
+	xtal_config.xtal_sharing_enable = dev->xtal_sharing_enable;
 	status = mxl692_config_xtal(dev, &xtal_config);
 	if (status)
 		goto err;
@@ -949,7 +952,7 @@ static int mxl692_set_frontend(struct dvb_frontend *fe)
 
 	int status = 0;
 	enum MXL_EAGLE_DEMOD_TYPE_E demod_type;
-	struct MXL_EAGLE_MPEGOUT_PARAMS_T mpeg_params = {};
+	struct MXL_EAGLE_MPEGOUT_PARAMS_T mpeg_params = dev->mpeg_params;
 	enum MXL_EAGLE_QAM_DEMOD_ANNEX_TYPE_E qam_annex = MXL_EAGLE_QAM_DEMOD_ANNEX_B;
 	struct MXL_EAGLE_QAM_DEMOD_PARAMS_T qam_params = {};
 	struct MXL_EAGLE_TUNER_CHANNEL_PARAMS_T tuner_params = {};
@@ -994,15 +997,6 @@ static int mxl692_set_frontend(struct dvb_frontend *fe)
 
 	usleep_range(20 * 1000, 30 * 1000); /* was 500! */
 
-	mpeg_params.mpeg_parallel = 0;
-	mpeg_params.msb_first = MXL_EAGLE_DATA_SERIAL_MSB_1ST;
-	mpeg_params.mpeg_sync_pulse_width = MXL_EAGLE_DATA_SYNC_WIDTH_BIT;
-	mpeg_params.mpeg_valid_pol = MXL_EAGLE_CLOCK_POSITIVE;
-	mpeg_params.mpeg_sync_pol = MXL_EAGLE_CLOCK_POSITIVE;
-	mpeg_params.mpeg_clk_pol = MXL_EAGLE_CLOCK_NEGATIVE;
-	mpeg_params.mpeg3wire_mode_enable = 0;
-	mpeg_params.mpeg_clk_freq = MXL_EAGLE_MPEG_CLOCK_27MHZ;
-
 	switch (demod_type) {
 	case MXL_EAGLE_DEMOD_TYPE_ATSC:
 		status = mxl692_i2c_writeread(dev,
@@ -1321,6 +1315,26 @@ static int mxl692_probe(struct i2c_client *client)
 		goto err;
 	}
 
+	dev->xtal_calibration_enable = config->xtal_calibration_enable;
+	dev->xtal_sharing_enable = config->xtal_sharing_enable;
+
+	dev->mpeg_params.mpeg_parallel = config->mpeg_parallel;
+	dev->mpeg_params.msb_first = MXL_EAGLE_DATA_SERIAL_MSB_1ST;
+	dev->mpeg_params.mpeg_sync_pulse_width = config->mpeg_sync_pulse_width;
+	dev->mpeg_params.mpeg_valid_pol = MXL_EAGLE_CLOCK_POSITIVE;
+	dev->mpeg_params.mpeg_sync_pol = MXL_EAGLE_CLOCK_POSITIVE;
+	dev->mpeg_params.mpeg_clk_pol = MXL_EAGLE_CLOCK_NEGATIVE;
+	dev->mpeg_params.mpeg3wire_mode_enable = config->mpeg3wire_mode_enable;
+	dev->mpeg_params.mpeg_clk_freq = config->mpeg_clk_freq;
+	dev->mpeg_params.mpeg_pad_drv.pad_drv_mpeg_syn =
+		config->mpeg_pad_drv.pad_drv_mpeg_syn;
+	dev->mpeg_params.mpeg_pad_drv.pad_drv_mpeg_dat =
+		config->mpeg_pad_drv.pad_drv_mpeg_dat;
+	dev->mpeg_params.mpeg_pad_drv.pad_drv_mpeg_val =
+		config->mpeg_pad_drv.pad_drv_mpeg_val;
+	dev->mpeg_params.mpeg_pad_drv.pad_drv_mpeg_clk =
+		config->mpeg_pad_drv.pad_drv_mpeg_clk;
+
 	memcpy(&dev->fe.ops, &mxl692_ops, sizeof(struct dvb_frontend_ops));
 	dev->fe.demodulator_priv = dev;
 	dev->i2c_client = client;
diff --git a/drivers/media/dvb-frontends/mxl692.h b/drivers/media/dvb-frontends/mxl692.h
index 77764a047c07..5aee46480982 100644
--- a/drivers/media/dvb-frontends/mxl692.h
+++ b/drivers/media/dvb-frontends/mxl692.h
@@ -16,9 +16,28 @@
 
 #define MXL692_FIRMWARE "dvb-demod-mxl692.fw"
 
+struct mxl692_mpeg_pad_drv_config {
+	u8 pad_drv_mpeg_syn;
+	u8 pad_drv_mpeg_dat;
+	u8 pad_drv_mpeg_val;
+	u8 pad_drv_mpeg_clk;
+};
+
 struct mxl692_config {
 	unsigned char  id;
 	u8 i2c_addr;
+
+	/* xtal config */
+	u8 xtal_calibration_enable;
+	u8 xtal_sharing_enable;
+
+	/* mpeg config */
+	u8 mpeg_parallel;
+	u8 mpeg_sync_pulse_width;
+	u8 mpeg3wire_mode_enable;
+	u8 mpeg_clk_freq;
+	struct mxl692_mpeg_pad_drv_config mpeg_pad_drv;
+
 	/*
 	 * frontend
 	 * returned by driver
diff --git a/drivers/media/usb/em28xx/em28xx-dvb.c b/drivers/media/usb/em28xx/em28xx-dvb.c
index 9fce59979e3b..738fd8df475c 100644
--- a/drivers/media/usb/em28xx/em28xx-dvb.c
+++ b/drivers/media/usb/em28xx/em28xx-dvb.c
@@ -1471,6 +1471,15 @@ static int em2874_dvb_init_hauppauge_usb_quadhd(struct em28xx *dev)
 	/* attach demod/tuner combo */
 	mxl692_config.id = (dev->ts == PRIMARY_TS) ? 0 : 1;
 	mxl692_config.fe = &dvb->fe[0];
+
+	mxl692_config.xtal_calibration_enable = 0;
+	mxl692_config.xtal_sharing_enable = 1;
+
+	mxl692_config.mpeg_parallel = 0;
+	mxl692_config.mpeg_sync_pulse_width = 0; /* BIT */
+	mxl692_config.mpeg3wire_mode_enable = 0;
+	mxl692_config.mpeg_clk_freq = 2; /* 27MHZ */
+
 	addr = (dev->ts == PRIMARY_TS) ? 0x60 : 0x63;
 
 	dvb->i2c_client_demod = dvb_module_probe("mxl692", NULL,
-- 
2.51.0


