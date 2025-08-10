Return-Path: <linux-kernel+bounces-761380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DE5B1F95B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 10:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A501897345
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 08:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E120823B611;
	Sun, 10 Aug 2025 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKEw1VJ8"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D6FEAD7;
	Sun, 10 Aug 2025 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754815398; cv=none; b=Pwh/Nm7AXJEfFI5D0XY7/f9XRBJWi3wq+FxqLA0COxqFI+7ClpkSKXR1OM+48oB2wCdTQvnzURd1707qWoVtzu98lZM+tjGD8ht+nQy8oY6OU4oNt5K2EK5x5byuN320lwgqxRGSRxGqYj2ysTi/MCPfHa5YcAnPFWdjFI8SHmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754815398; c=relaxed/simple;
	bh=ppCJeTu1YeA6qHONU32Ty1zGuS+mqv5333eqlMd6qik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mAvEzv6Gu1tEKulJ07OIv14iv3PnX1hFHZ+B2WjgE8aLS8OsNAfQ54FNMWtTzQJWNv4uBlMnoAjytOTE54dcRUwje4SSe/p1+aTNEezjOxzdaUOmce81xUMOF6iG5pOd9KePMkYtCDh4Hnl6ELl1WA+tBpKa9CBBzggBQKcEP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKEw1VJ8; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-af51596da56so2615955a12.0;
        Sun, 10 Aug 2025 01:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754815396; x=1755420196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/3IGPFu9mc82V6fPShp5O7kmjw815P/hxAzaDJrujq8=;
        b=cKEw1VJ8KOpCWTMd/iLOiXDPM9Yzen6KJuXBgYAacJmKGe15G6BXBcAkfe0XEWrLQe
         dvoZ/P0jb6LuE0mI5NH+SYw5kBq9fj4qqYi53trHFj0Vo03cPoGo95FYQ7SIg/aOxC5B
         Qc3fgfHlerOOGLpLeQoIZJNtb/36vHT7bu+//mOcuEbRmiaJ1cqhS5/O8Z3sn+lCxspE
         Yf7eOpw32kidU7wM87LCo72KFD6/lRLQEyryBgfrzpGxqE8+H8MRraOC7ovX0P5X7nGo
         AorKkWk9VI5VBkQaJgnLfSjRh26oHtk2mKs/AO0xmDzgKitQGbm+t43kbUG3pVMQ+six
         e/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754815396; x=1755420196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3IGPFu9mc82V6fPShp5O7kmjw815P/hxAzaDJrujq8=;
        b=QMMm/t2wTLzP946TBI5ySVfSTlTFnpfdNzmO6/k0ZhEO1/1hOI0fkqbvk3mq+Y0q3O
         GyqDPpsRPGaXW4+3/IOHq9hTRYjmqaDRj7p2ZDn3ovTbyBhxtvCM5OmSKOX/UCVUWTqJ
         R846Y7DXPiEGW5Z/d33X6iuu6NO69ZRNPwBpnJhNnv0SFNSYeUOnACU6XbK2tMRQQH43
         snK/Ech32b9kpljY94C/IZdxVlEXR6ZReq2tT8gJb7OM8g5VYEP77RWuCam/szT17oZI
         QjvTyd/X5WznZcJjpcrnKg8VASJRzuF5LzeKYb0UnF0w2OqhDoFzKDTQN8Pm8oWoghrE
         LiIA==
X-Forwarded-Encrypted: i=1; AJvYcCWHwlgcwauyXtrK35VkPLcVeN79ZpoIrWCIfEbSWdGo5nik1n8vL8aFsBsfUbgEjlsjN3JLQVva9ESgtw==@vger.kernel.org, AJvYcCXFGzaItoaftXyRGpvI9W88zCJRho3TNQkMEpYvxPykcjtmuWygl/kW/nvneKNUwyBITgeTZTb2aFIif760@vger.kernel.org
X-Gm-Message-State: AOJu0YwccA4KmNJq9TDHKikNOMIcN7Vbhew99ejBGyrRllrtxMpow8JB
	U0rzxV95Xvfj39briWnchFNbCVtWt2z5+5WglatiOfto4GbA/jd1w9ao
X-Gm-Gg: ASbGnctmlvKsqqAR6vufjLG/DPVgDGWs2Eba8a4yxXIX4L2lB3ht31M35z0EmWI2vY8
	Mt1exohIvAOEPxjqgzkd17atOIUyLU2fOH1q0DoVvoqPmkm6vgjef3CBi+n/aYZ61DKB+9PEVuU
	kAh/UNvkquyufIKViACMYGeTldU1VQw98M7EpbjZb4GRt+56L32MsowRsCRl/1bDl22KkwBm6lx
	H2J3QLWe9690M+v5oHc1VDJV3UkT3y/QYfDMrdaH51x3+mT+rOKBM4nyHcZ/5o/HxuDcaxLpSYk
	bagouxEhCdrE9QXYYr/ymKjIC7uaVO7cU9LJX8JRCPkO/cIGlRadmDIk8lm29ycBAwzzxGREcFa
	C4g6AXNNQY7Gz25YBfayAM5p0yGFGN3DUZGknFbRi0ppFxuNzLGc=
X-Google-Smtp-Source: AGHT+IE8LtuqxCMSqXBcy1wxY978agOCmf7lJxi+2kH3TcpeKBnhcxVmwLWRtFhaD+L8h6NCqJvuew==
X-Received: by 2002:a17:902:daca:b0:240:71ad:a442 with SMTP id d9443c01a7336-242c1ecc346mr131872435ad.9.1754815396043;
        Sun, 10 Aug 2025 01:43:16 -0700 (PDT)
Received: from CHUACHEN-M-44LQ.cisco.com ([64.104.44.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6c62sm247979275ad.4.2025.08.10.01.43.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 10 Aug 2025 01:43:15 -0700 (PDT)
From: Chuande Chen <chenchuande@gmail.com>
To: jdelvare@suse.com
Cc: linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chuachen@cisco.com,
	chenchuande@gmail.com
Subject: [PATCH] hwmon: sbtsi_temp: AMD CPU extended temperature range support
Date: Sun, 10 Aug 2025 16:43:07 +0800
Message-Id: <20250810084307.41243-1-chenchuande@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuande Chen <chuachen@cisco.com>

Many AMD CPUs can support this feature now.
We would get a wrong CPU DIE temp if don't consider this.
In low-temperature environments, the CPU die temperature
can drop below zero.
So many platform would like to make extended temperature range
as their default configuration.
Default temperature range (0C to 255.875C) degree celsius.
Extended temperature range (-49C to +206.875C) degree celsius.
Ref Doc: AMD V3000 PPR (Doc ID #56558).

Signed-off-by: Chuande Chen <chuachen@cisco.com>
---
 drivers/hwmon/sbtsi_temp.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/sbtsi_temp.c b/drivers/hwmon/sbtsi_temp.c
index 3c839f56c..15e49c2a0 100644
--- a/drivers/hwmon/sbtsi_temp.c
+++ b/drivers/hwmon/sbtsi_temp.c
@@ -30,6 +30,14 @@
 #define SBTSI_REG_TEMP_LOW_DEC		0x14 /* RW */
 
 #define SBTSI_CONFIG_READ_ORDER_SHIFT	5
+/*
+ * Bit for temperature measurement range.
+ * Value=0: Use default temperature range (0C to 255.875C) for reporting temperature.
+ * Value=1: Use extended temperature range (-49C to +206.875C) for reporting temperature.
+ */
+#define SBTSI_CONFIG_EXT_RAGE_SHIFT	2
+
+#define SBTSI_TEMP_EXT_RAGE_ADJ	49000
 
 #define SBTSI_TEMP_MIN	0
 #define SBTSI_TEMP_MAX	255875
@@ -74,7 +82,12 @@ static int sbtsi_read(struct device *dev, enum hwmon_sensor_types type,
 {
 	struct sbtsi_data *data = dev_get_drvdata(dev);
 	s32 temp_int, temp_dec;
-	int err;
+	int err, cfg;
+
+	err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
+	if (err < 0)
+		return err;
+	cfg = err;
 
 	switch (attr) {
 	case hwmon_temp_input:
@@ -85,12 +98,8 @@ static int sbtsi_read(struct device *dev, enum hwmon_sensor_types type,
 		 * so integer part should be read first. If bit == 1, read
 		 * order should be reversed.
 		 */
-		err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
-		if (err < 0)
-			return err;
-
 		mutex_lock(&data->lock);
-		if (err & BIT(SBTSI_CONFIG_READ_ORDER_SHIFT)) {
+		if (cfg & BIT(SBTSI_CONFIG_READ_ORDER_SHIFT)) {
 			temp_dec = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_DEC);
 			temp_int = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_INT);
 		} else {
@@ -122,6 +131,8 @@ static int sbtsi_read(struct device *dev, enum hwmon_sensor_types type,
 		return temp_dec;
 
 	*val = sbtsi_reg_to_mc(temp_int, temp_dec);
+	if (cfg & BIT(SBTSI_CONFIG_EXT_RAGE_SHIFT))
+		*val -= SBTSI_TEMP_EXT_RAGE_ADJ;
 
 	return 0;
 }
@@ -130,9 +141,14 @@ static int sbtsi_write(struct device *dev, enum hwmon_sensor_types type,
 		       u32 attr, int channel, long val)
 {
 	struct sbtsi_data *data = dev_get_drvdata(dev);
-	int reg_int, reg_dec, err;
+	int reg_int, reg_dec, err, cfg;
 	u8 temp_int, temp_dec;
 
+	err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
+	if (err < 0)
+		return err;
+	cfg = err;
+
 	switch (attr) {
 	case hwmon_temp_max:
 		reg_int = SBTSI_REG_TEMP_HIGH_INT;
@@ -146,6 +162,8 @@ static int sbtsi_write(struct device *dev, enum hwmon_sensor_types type,
 		return -EINVAL;
 	}
 
+	if (cfg & BIT(SBTSI_CONFIG_EXT_RAGE_SHIFT))
+		val += SBTSI_TEMP_EXT_RAGE_ADJ;
 	val = clamp_val(val, SBTSI_TEMP_MIN, SBTSI_TEMP_MAX);
 	sbtsi_mc_to_reg(val, &temp_int, &temp_dec);
 
-- 
2.39.5 (Apple Git-154)


