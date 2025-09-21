Return-Path: <linux-kernel+bounces-825949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B808BB8D2F2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 02:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768A9189ADC0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 00:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBD97261D;
	Sun, 21 Sep 2025 00:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYmqX3WL"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B68525771
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 00:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758416230; cv=none; b=YmEkZk24lMMCnMwF/4dlwt3Zzrj+Useat5Y2LnmHTgyybjkB+9HnqrI3VpR+AgdamUufzdGgjykyIqSGceo0EkUUC2UdOG1zEu22MZ8+3DIZ3UnzlPtA/eiYOhzhJsdXC5u4je1ms6tHui/ns/bZOhmslEOmxFhGp9dqfu+tk8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758416230; c=relaxed/simple;
	bh=o3OrUKxK7HcHUCr3FmFBiFhLFlsL5Ami0Z0razBf2iU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SkVAsflfCxo5rEefhLTzvACO9CArkK/NLPQ2MlS7yc4dHYJdrY3zICYzFy/Jj/gOn46HzMekp2jQ41Wm6xZqB0DESNrL2SWYLfNqUvCcn5WEB2DJyA6DC2T1+Vf01mOZrhykWRRsLzRDmZuv7s3fYc3khsQ+49FDi7ulVjs+6nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYmqX3WL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-329e1c8e079so3033832a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 17:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758416228; x=1759021028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oVT4J5OS8x6TS28feBmHNMsJJq1gQBMwGWqkfUiPnb0=;
        b=CYmqX3WLva496zK9x2x3rEeDJKMBkCpcYTuoGAap7xfJAIB/FVzGpgvUYIsBuXM1z3
         a8R68LeoSJsaVBJ1ds5oQT0WLwSJdSW/CMpmdqJgcz3rg2BLItprfh7C922MSZtkFrnC
         5SinARAQiKpS3RQK+gNn7VBgM+c0DxX8iW91/tGLG+MqktfxZBBnlz6qOABpeMOIuyGF
         +MBVAo8+dGb1r299GmeMwbkOF9Ak29hDI1FmoRwgBZo4ZCezZrr+7LR0casuvibwbLSp
         9yf9bV4aOdsdc79zGKX5AByMWK/CHE+rk17HvGVErOZiBbtWv8DrM2zVpJNaolUqvCCT
         DoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758416228; x=1759021028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVT4J5OS8x6TS28feBmHNMsJJq1gQBMwGWqkfUiPnb0=;
        b=MdLC/IyEOz0+IxDgrw5iDvLtVXWKz4a/S/Z1cXT0SREy+4gZzLXsOPjLzr7oA9b6ta
         1wFHhRSYEetqRNxrNGc8SdWt3gLn3+80IXGv4swLIZVOe8AMHApuEvnY5Vak+j6O4EuF
         TYkRvEVzOLuHfrZsUHudbcL5wpLefUBQxZ9FB1nocov+d14uHWEkq45u06UoI9sIodN3
         Q/j/LBF1Cg18F1bdCcBX36pF/deToyW3jPeZ/2EVZOYRbxZjMxluCLQHE4kXPr5kYV3K
         Dk2oZyWDplWyxQ72rDIhsf2ICRJNraND8lR5xxFHf6FCmvsvVdxNnfNUA6SYGdxP6isQ
         bDdw==
X-Forwarded-Encrypted: i=1; AJvYcCUtqdhAEpoTJGJk7sKcLVRk8TtxlrTEby5fNfNvKVLI7d7u4LfBkub0AUOcc7Heh2W1fIdvuPjA1s/C50s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxZKhESQd0PA+OL6ImD3lsVcIEYr5HMEZwwoi9lfloNL98eLVg
	A+oZuxbGHGRjCAtT5DlpkB22nI/iNyDt2v6ODY+D11gsxnGndP0bcIWY
X-Gm-Gg: ASbGncv31/P/wscWksRE92WNxE+zLmPfHXeawz3oDm/D7ugQ5wr/3Koc7e524BQoGbo
	EBx/ZsEPl6XKJQrP2+cl3uGM81E4OQTBdD6omcF9wEu4cP6kSsApqoJI1NH5qb3robK6E4hMqUN
	5KDa0Zdp4yL4wqQeLzYk6RbRXmZ/LkMnFfEA274xr3ByENuRg3I2izMGp3zl5DnwK0VdXfe/DWF
	xUc9Z2iSC28MjznS5d2sKZ3+OlIuNbFjHHelkiGa91qW4FiBEmQaFKqfKDyycoBSoTx74FdzE/Z
	tv54l46ov++K460GMCDqSmJUJqVSajdvWgOuLAxDTHu9Y5vQdsCodKwGDI0b7n+QYjVKo9BOasx
	UzCls/tbcH4N1OtVToi+lFZxUuQTDjtyoSw==
X-Google-Smtp-Source: AGHT+IErFBXkyclIXuETJ0n418k5wfOgqD1TNuVNmHW7S//MyRJkGXsw9LZY9BPJLbkOxLN7dWjRBQ==
X-Received: by 2002:a17:90b:4b05:b0:32e:aaac:907 with SMTP id 98e67ed59e1d1-33097fdd68cmr8637024a91.5.1758416227818;
        Sat, 20 Sep 2025 17:57:07 -0700 (PDT)
Received: from fedora ([172.59.162.206])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cff22b7e7sm8595821b3a.103.2025.09.20.17.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 17:57:06 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: mchehab@kernel.org
Cc: laurent.pinchart@ideasonboard.com,
	hansg@kernel.org,
	hverkuil+cisco@kernel.org,
	cascardo@igalia.com,
	ribalda@chromium.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v3] media: i2c: wm8775: parameterize wm8775_platform_data based on config
Date: Sat, 20 Sep 2025 17:56:35 -0700
Message-ID: <20250921005635.949377-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parameterized wm8775_platform_data struct, removing the single boolean
for determining device type. wm8775_standard_cfg struct will be used
for standard devices and wm8775_nova_s_cfg for nova_s devices. 

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
Changes in v2:
- rebased from mchehab linux media onto media committers tree
- resolve patch and build errors
Changes in v3:
- cc updated maintainers list
 drivers/media/i2c/wm8775.c          | 109 ++++++++++++++++------------
 drivers/media/pci/cx88/cx88-video.c |   4 +-
 include/media/i2c/wm8775.h          |  25 +++++--
 3 files changed, 83 insertions(+), 55 deletions(-)

diff --git a/drivers/media/i2c/wm8775.c b/drivers/media/i2c/wm8775.c
index 56778d3bc..6218fc3fe 100644
--- a/drivers/media/i2c/wm8775.c
+++ b/drivers/media/i2c/wm8775.c
@@ -50,6 +50,43 @@ struct wm8775_state {
 	u8 input;		/* Last selected input (0-0xf) */
 };
 
+struct wm8775_platform_data wm8775_standard_cfg = {
+	.reset = 0x000, /* RESET */
+	.zero_cross_timeout = 0x000, /* Disable zero cross detect timeout */
+	.interface_ctrl =
+		0x021, /* HPF enable, left justified, 24-bit (Philips) mode */
+	.master_mode = 0x102, /* Master mode, clock ratio 256fs */
+	.powerdown = 0x000, /* Powered up */
+	.adc_l = 0x1d4, /* ADC gain +2.5dB, enable zero cross */
+	.adc_r = 0x1d4, /* ADC gain +2.5dB, enable zero cross */
+	.alc_ctrl_1 =
+		0x1bf, /* ALC Stereo, ALC target level -1dB FS max gain +8dB */
+	.alc_ctrl_2 = 0x185, /* Enable gain control, ALC hold time 42.6 ms */
+	.alc_ctrl_3 = 0x0a2, /* Ramp up delay 34 s, ramp down delay 33 ms */
+	.noise_gate = 0x005, /* Enable noise gate, threshold -72dBfs */
+	.limiter_ctrl = 0x07a, /* Window 4ms, lower PGA gain limit -1dB */
+	.adc_mixer = 0x102, /* LRBOTH = 1, use input 2. */
+	.should_set_audio = false,
+};
+
+struct wm8775_platform_data wm8775_nova_s_cfg = {
+	.reset = 0x000, /* RESET */
+	.zero_cross_timeout = 0x000, /* Disable zero cross detect timeout */
+	.interface_ctrl =
+		0x021, /* HPF enable, left justified, 24-bit (Philips) mode */
+	.master_mode = 0x102, /* Master mode, clock ratio 256fs */
+	.powerdown = 0x000, /* Powered up */
+	.adc_l = WM8775_REG_UNUSED,
+	.adc_r = WM8775_REG_UNUSED,
+	.alc_ctrl_1 = 0x1bb, /* Stereo, target level -5dB FS, max gain +8dB */
+	.alc_ctrl_2 = WM8775_REG_UNUSED,
+	.alc_ctrl_3 = 0x0a2, /* Ramp up delay 34 s, ramp down delay 33 ms */
+	.noise_gate = 0x005, /* Enable noise gate, threshold -72dBfs */
+	.limiter_ctrl = 0x0fb, /* Transient window 4ms, ALC min gain -5dB  */
+	.adc_mixer = WM8775_REG_UNUSED,
+	.should_set_audio = true, /* set volume/mute/mux */
+};
+
 static inline struct wm8775_state *to_state(struct v4l2_subdev *sd)
 {
 	return container_of(sd, struct wm8775_state, sd);
@@ -195,12 +232,8 @@ static int wm8775_probe(struct i2c_client *client)
 	struct wm8775_state *state;
 	struct v4l2_subdev *sd;
 	int err;
-	bool is_nova_s = false;
-
-	if (client->dev.platform_data) {
-		struct wm8775_platform_data *data = client->dev.platform_data;
-		is_nova_s = data->is_nova_s;
-	}
+	struct wm8775_platform_data *data = client->dev.platform_data ?:
+						    &wm8775_standard_cfg;
 
 	/* Check if the adapter supports the needed features */
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
@@ -233,49 +266,29 @@ static int wm8775_probe(struct i2c_client *client)
 	}
 
 	/* Initialize wm8775 */
+	wm8775_write(sd, R23, data->reset);
+	wm8775_write(sd, R7, data->zero_cross_timeout);
+	wm8775_write(sd, R11, data->interface_ctrl);
+	wm8775_write(sd, R12, data->master_mode);
+	wm8775_write(sd, R13, data->powerdown);
+	if (data->adc_l != WM8775_REG_UNUSED)
+		wm8775_write(sd, R14, data->adc_l);
+	if (data->adc_r != WM8775_REG_UNUSED)
+		wm8775_write(sd, R15, data->adc_r);
+	wm8775_write(sd, R16, data->alc_ctrl_1);
+	if (data->alc_ctrl_2 != WM8775_REG_UNUSED)
+		wm8775_write(sd, R17, data->alc_ctrl_2);
+	else
+		wm8775_write(sd, R17,
+			     (state->loud->val ? ALC_EN : 0) | ALC_HOLD);
+	wm8775_write(sd, R18, data->alc_ctrl_3);
+	wm8775_write(sd, R19, data->noise_gate);
+	wm8775_write(sd, R20, data->limiter_ctrl);
+	if (data->adc_mixer != WM8775_REG_UNUSED)
+		wm8775_write(sd, R21, data->adc_mixer);
+	if (data->should_set_audio)
+		wm8775_set_audio(sd, 1);
 
-	/* RESET */
-	wm8775_write(sd, R23, 0x000);
-	/* Disable zero cross detect timeout */
-	wm8775_write(sd, R7, 0x000);
-	/* HPF enable, left justified, 24-bit (Philips) mode */
-	wm8775_write(sd, R11, 0x021);
-	/* Master mode, clock ratio 256fs */
-	wm8775_write(sd, R12, 0x102);
-	/* Powered up */
-	wm8775_write(sd, R13, 0x000);
-
-	if (!is_nova_s) {
-		/* ADC gain +2.5dB, enable zero cross */
-		wm8775_write(sd, R14, 0x1d4);
-		/* ADC gain +2.5dB, enable zero cross */
-		wm8775_write(sd, R15, 0x1d4);
-		/* ALC Stereo, ALC target level -1dB FS max gain +8dB */
-		wm8775_write(sd, R16, 0x1bf);
-		/* Enable gain control, use zero cross detection,
-		   ALC hold time 42.6 ms */
-		wm8775_write(sd, R17, 0x185);
-	} else {
-		/* ALC stereo, ALC target level -5dB FS, ALC max gain +8dB */
-		wm8775_write(sd, R16, 0x1bb);
-		/* Set ALC mode and hold time */
-		wm8775_write(sd, R17, (state->loud->val ? ALC_EN : 0) | ALC_HOLD);
-	}
-	/* ALC gain ramp up delay 34 s, ALC gain ramp down delay 33 ms */
-	wm8775_write(sd, R18, 0x0a2);
-	/* Enable noise gate, threshold -72dBfs */
-	wm8775_write(sd, R19, 0x005);
-	if (!is_nova_s) {
-		/* Transient window 4ms, lower PGA gain limit -1dB */
-		wm8775_write(sd, R20, 0x07a);
-		/* LRBOTH = 1, use input 2. */
-		wm8775_write(sd, R21, 0x102);
-	} else {
-		/* Transient window 4ms, ALC min gain -5dB  */
-		wm8775_write(sd, R20, 0x0fb);
-
-		wm8775_set_audio(sd, 1);      /* set volume/mute/mux */
-	}
 	return 0;
 }
 
diff --git a/drivers/media/pci/cx88/cx88-video.c b/drivers/media/pci/cx88/cx88-video.c
index 0c8732768..a3729fd73 100644
--- a/drivers/media/pci/cx88/cx88-video.c
+++ b/drivers/media/pci/cx88/cx88-video.c
@@ -1353,9 +1353,9 @@ static int cx8800_initdev(struct pci_dev *pci_dev,
 		struct v4l2_subdev *sd;
 
 		if (core->boardnr == CX88_BOARD_HAUPPAUGE_NOVASPLUS_S1)
-			core->wm8775_data.is_nova_s = true;
+			core->wm8775_data = wm8775_nova_s_cfg;
 		else
-			core->wm8775_data.is_nova_s = false;
+			core->wm8775_data = wm8775_standard_cfg;
 
 		sd = v4l2_i2c_new_subdev_board(&core->v4l2_dev, &core->i2c_adap,
 					       &wm8775_info, NULL);
diff --git a/include/media/i2c/wm8775.h b/include/media/i2c/wm8775.h
index a02695ee3..99678d165 100644
--- a/include/media/i2c/wm8775.h
+++ b/include/media/i2c/wm8775.h
@@ -20,13 +20,28 @@
 #define WM8775_AIN3 4
 #define WM8775_AIN4 8
 
+#define WM8775_REG_UNUSED ((u16)-1)
 
 struct wm8775_platform_data {
-	/*
-	 * FIXME: Instead, we should parameterize the params
-	 * that need different settings between ivtv, pvrusb2, and Nova-S
-	 */
-	bool is_nova_s;
+	u16 reset; /* RESET (R23) */
+	u16 zero_cross_timeout; /* Zero cross detect timeout (R7) */
+	u16 interface_ctrl; /* Interface control (R11) */
+	u16 master_mode; /* Master mode (R12) */
+	u16 powerdown; /* Power down (R13) */
+
+	u16 adc_l; /* ADC left (R14) */
+	u16 adc_r; /* ADC right (R15) */
+	u16 alc_ctrl_1; /* ALC control 1 (R16)*/
+	u16 alc_ctrl_2; /* ALC control 2 (R17) */
+	u16 alc_ctrl_3; /* ALC control 3 (R18) */
+	u16 noise_gate; /* Noise gate (R19) */
+	u16 limiter_ctrl; /* Limiter control (R20) */
+	u16 adc_mixer; /* ADC mixer control (R21) */
+
+	bool should_set_audio;
 };
 
+extern struct wm8775_platform_data wm8775_nova_s_cfg;
+extern struct wm8775_platform_data wm8775_standard_cfg;
+
 #endif
-- 
2.51.0


