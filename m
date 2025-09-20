Return-Path: <linux-kernel+bounces-825924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C55B8D20F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 00:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBCE5634EB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B3A23AB9D;
	Sat, 20 Sep 2025 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWGmEeBJ"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8190F1FF7B3
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758408739; cv=none; b=HD5M6TvPTpny6OkYj4xDIglrgrDGtdlLSbJpTmpE2ZjwK44AY1O3kMaWqjFC62nR86toicZHTDuHfXUGMyvbUCJrjT0Ak/y4e7uzGTdJoCF85YDkpy9XWwUAda60+XaqoT1ZSPHszD/oD8QotJsFTm47qlQ//s/sxTf38z+31rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758408739; c=relaxed/simple;
	bh=aJfEvIc1NdLGBcUJgWs0H3jQOP07X7qtQfkLKlTEno0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rN1mU/z7JuuDGCdKJzRHDzgyF+uBBtLbPn6xOYHU5mRRryybIzM4egBeAA7HhjK0GnWJicJSuWsnafAaglVQl/G2Lh9KJWXfhsysG6OO15poDaiWL5UR0B+WFiq29WZgBYxClqP2lsRkMQoCQprphhJ/51mp94zrzZBTRf49QkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWGmEeBJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-26983b5411aso22841285ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758408737; x=1759013537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qvabovd6exkrtvk5aKX60w6o7MqzSjRxPqJB3uqAe+Q=;
        b=DWGmEeBJ1BmJUcxRmFEDZK5/aucdGq/C5Kq24L62mSl1xGZC7ZxdPqtErrpyvHKYL8
         ijmMTkQ1UdMBRJc+x2vwN/LNpAjMLvYMhmnreOLLUeGfOXSWw4eL39MUFbZ1dCQN0SQZ
         SxA+yQjQoerA7sr46JXBBJ64Z+q+i75Mdd8IAPLUfsyj0bZPqoVKrWNGJvHSvS3CwL5O
         lf1PuuBc8z19wDQoHFSKFZvjWR3YI8qv+NIMpog9PxbDfgFs0Qm3wuF0RHOuQAALlgZW
         1SPWw0Z72hvKdzJZqaUH7/y6s6jl2PD0I4zEVoiRc3F6fwk9OEP9RYorUuwH6lm5LJIQ
         e+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758408737; x=1759013537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qvabovd6exkrtvk5aKX60w6o7MqzSjRxPqJB3uqAe+Q=;
        b=YWRJ76Ier/qfCaabEAHxKiuVTyj/v61rbje1DPUy0EjRSmKNQpgpNLwKbIB3I9sPpQ
         m23y/oSYjrIPulAXQ8NF5nHvGNWKYt1l+dGtNcrfMOuBOLOORMElQZUCnUyycOl5TNSZ
         8GlO+0dfaSnVpTRWXt6h9hhVWcMZoRZzxfvnMaGkCSFuaND1jBVMNFo9DIWOkEcPYzMb
         zYhjIBYG0ymvYWAzvs2lLRIZNEFa24tOrJIxNnlno3ABIHAT7JZkwrXA2R5SZUZi0pOU
         3ScgK3JsdhMlm6VrYkUteJkMo77EfQkrNTHIRtpnIgvzwDKDDRDU3meRrNMVTIjWizer
         6dAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuNhFBnueZ7Kp2dKtWWQwVTzAVv6/hh5DBp6Pz4lhPcSokCk3UncIUpO+Olykj17B37r+lJQXYSr2w7q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDtqo6Fx+BdMr0Z5oOgBm2eWUz6/MWWUPk6yWubCr5Gj7kubgQ
	Jm1n81/JBl8bYmqDznB9DXlMQWG72IEPCJSA8KERts6Zy94Xuf0+F7SJ
X-Gm-Gg: ASbGncs9Xs5IpDMFvMxJ4dFq66K6IO4V1/yGVY+dqZypHOVgOp+rN5xwpDSqBabZ9er
	hxPKGcojIgvIPwU23h4faIN6NxZvf0Acs7Na9JdpVp15PJ8qcd4RI6m5aC3VIrY+ZjP/IMDSlv8
	T6vZfD4Opszmj9CPyno8R5PDOMKSmCZXh4yILcIFcvzS/zW+uj/1jrlCIAz2H0y95Hn4+qF6Le3
	ZLmyl8KHQ2CtGn3QW4rsk24cHKAsF1IkWAAtlHpUtgvG5GjJNwgrZdJvc/vZql5MCxYyicMW1cz
	kKYkcaa4mOjkpSdEg3MRV6ApAg2T1jrw72k0FI1JPboaOuXqAZg93eoJtKOJv7dfbr9g7SN8fTX
	AgXW8YF0IYQnG7tDqSElucB8=
X-Google-Smtp-Source: AGHT+IEoyExlS6rYPTpon15iXuE+6tLaiZklhi4QcFOQ+OzZY3ty4xX+fxKtzGTX+6wtazkljaTTJg==
X-Received: by 2002:a17:903:32ca:b0:26c:3e5d:43b6 with SMTP id d9443c01a7336-26c3e5d4675mr92067215ad.32.1758408736729;
        Sat, 20 Sep 2025 15:52:16 -0700 (PDT)
Received: from fedora ([172.59.162.206])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980310e89sm91565035ad.99.2025.09.20.15.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 15:52:15 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v1] media: i2c: wm8775: parameterize wm8775_platform_data based on config
Date: Sat, 20 Sep 2025 15:52:07 -0700
Message-ID: <20250920225207.864348-1-alex.t.tran@gmail.com>
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
 drivers/media/i2c/wm8775.c          | 114 ++++++++++++++++------------
 drivers/media/pci/cx88/cx88-video.c |   4 +-
 include/media/i2c/wm8775.h          |  25 ++++--
 3 files changed, 88 insertions(+), 55 deletions(-)

diff --git a/drivers/media/i2c/wm8775.c b/drivers/media/i2c/wm8775.c
index d4c83c398..1fec8c0c2 100644
--- a/drivers/media/i2c/wm8775.c
+++ b/drivers/media/i2c/wm8775.c
@@ -50,6 +50,48 @@ struct wm8775_state {
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
+	.alc_ctrl_2 =
+		0x185, /* Enable gain control, use zero cross detection, ALC hold time 42.6 ms */
+	.alc_ctrl_3 =
+		0x0a2, /* ALC gain ramp up delay 34 s, ALC gain ramp down delay 33 ms */
+	.noise_gate = 0x005, /* Enable noise gate, threshold -72dBfs */
+	.limiter_ctrl =
+		0x07a, /* Transient window 4ms, lower PGA gain limit -1dB */
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
+	.alc_ctrl_1 =
+		0x1bb, /* ALC stereo, ALC target level -5dB FS, ALC max gain +8dB */
+	.alc_ctrl_2 = WM8775_REG_UNUSED,
+	.alc_ctrl_3 =
+		0x0a2, /* ALC gain ramp up delay 34 s, ALC gain ramp down delay 33 ms */
+	.noise_gate = 0x005, /* Enable noise gate, threshold -72dBfs */
+	.limiter_ctrl = 0x0fb, /* Transient window 4ms, ALC min gain -5dB  */
+	.adc_mixer = WM8775_REG_UNUSED,
+	.should_set_audio = true, /* set volume/mute/mux */
+};
+
 static inline struct wm8775_state *to_state(struct v4l2_subdev *sd)
 {
 	return container_of(sd, struct wm8775_state, sd);
@@ -196,12 +238,8 @@ static int wm8775_probe(struct i2c_client *client,
 	struct wm8775_state *state;
 	struct v4l2_subdev *sd;
 	int err;
-	bool is_nova_s = false;
-
-	if (client->dev.platform_data) {
-		struct wm8775_platform_data *data = client->dev.platform_data;
-		is_nova_s = data->is_nova_s;
-	}
+	struct wm8775_platform_data *data =
+		client->dev.platform_data ?: &wm8775_standard_cfg;
 
 	/* Check if the adapter supports the needed features */
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
@@ -234,49 +272,29 @@ static int wm8775_probe(struct i2c_client *client,
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
index 8cffdacf6..efba7477f 100644
--- a/drivers/media/pci/cx88/cx88-video.c
+++ b/drivers/media/pci/cx88/cx88-video.c
@@ -1354,9 +1354,9 @@ static int cx8800_initdev(struct pci_dev *pci_dev,
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
index 836758176..856f9ec64 100644
--- a/include/media/i2c/wm8775.h
+++ b/include/media/i2c/wm8775.h
@@ -20,13 +20,28 @@
 #define WM8775_AIN3 4
 #define WM8775_AIN4 8
 
+#define WM8775_REG_UNUSED ((u16)-1)
 
 struct wm8775_platform_data {
-	/*
-	 * FIXME: Instead, we should parametrize the params
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


