Return-Path: <linux-kernel+bounces-792940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D11EBB3CAB3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 14:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB767BAD20
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD69274FC2;
	Sat, 30 Aug 2025 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X80tUGE8"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CBD36124;
	Sat, 30 Aug 2025 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756555301; cv=none; b=hWGIiMgVesjxrVrAzYhrbZPART7fKGuBsUuELZnnY14L6JxYTvYSlt90wtP35XbiUN14GPUn5JU8DffBAtwgW6MpBAZYgrkz/xoGxem2qvZ2GPdqbucvVVSFskQcOEy4xXqkCmXcmRCwkWiS6vlJPDzbjBKjWJKPnjYLQjlq3dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756555301; c=relaxed/simple;
	bh=gb9UkeNto1/BNEHgq6njWuFQrrt4ne0giWpt9+P91Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hVt2xyuWPUI0wWeHXTlbIGUwVh13MCdB42n9cNXgvbmF7Z0xgtxUjpqTojAf3HiXZT4r+TS0u6wKreXIpFvRjgJT/Has+M1fgVzWyA0HwTxYipmhPxOkvl59SaICqF5zEJVHDb7cytp4TQe2zFBTI8q6Iyxk3Q4Gdg+X458vb1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X80tUGE8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so410367966b.3;
        Sat, 30 Aug 2025 05:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756555298; x=1757160098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qNM9jmJJXyJUITGuqHjYXb/UUEkokqSq0ogj6yONehM=;
        b=X80tUGE8ml1WOU4u1LMJlvAzw3W+7nQZj/2pJEbguIYMTPb9u6HvYbEhRu0b68458Z
         U9T5l0ul5fbJ5kZEtdpVRXJWXAJqxeSYz2TfEQiQdTlXGAg04J8BdQsr9MpUMYCONygw
         Ht0xNa63MbivFwaKySV2MSxRXXZyMjglQr0arLnLTcpJ425kmomsernNrwLLmEI9M040
         oiNmig6y/n/Mzg1NagurShdDCxaOmlqrXrYgLmjIMzlf5pQrTLA0EfoRQMnM0FZVeSep
         Odx2z6CvkxDtzUE3K+2tvDYh/hqbv3YOp8jKI6zzYT8dg8XvUufEKyIjqrfS9xQ2mKG0
         S/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756555298; x=1757160098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNM9jmJJXyJUITGuqHjYXb/UUEkokqSq0ogj6yONehM=;
        b=UVDn6oSLuEau6/BuRNnyhepRIbYSI6LqmH0zvs8o1cH2ldtTWVZ6TsBlzLnt6Pg56a
         I8Y0n9SZ4t8gZJnr+keGy0juiTBp599EkA8FpNys9pPT7Nj5dYPjTUFaYOGkdaa2kfoP
         Z7s0fdFEHX4ullUAfUelvycBlw4wadHZ/02T8OM+ZUVX7HbuRTcr1+NQZlzmyyJUUcAt
         Exg6rtMvRjTRvMpVsQzcl4u3gqA6IeNJVzB6dWjFoOsZtSeLhUMywZxLLD9tu6f039tE
         wARkQtGD/SGWrLsMpuZvH9P5icEqrvOSdVrRMSepb/uKkYAJ2mo0vsgUXK8A5j0a5Bnn
         mPDg==
X-Forwarded-Encrypted: i=1; AJvYcCVRVD244kXLjmrRAMUw5MlKGPfFGuCnt7TUMjXv37f8qn2nCs/LdN/ot0jpVrZ74nI8r0dXfOPwC4lnh90=@vger.kernel.org, AJvYcCWyXtu4Mqs9PdGFPFFJbzs9PcHB39zoaLqTL+82USZL7+qlU0/lu08qf9l+nCoQbqFkgzlsRytI8n8risQ3@vger.kernel.org, AJvYcCXurWlLQuhHorPHLMyVHulEU1rt2mtT5RXidObWravVQNGd56Yyg7l/0Z7XUu7Q8XvVIifV8WSISWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTRzxg7iBcLxaP1xViddTQWoHfpyA8iw9UBkQV/DZCBvYxGLBZ
	AqpzG10xYBxzLpV/eWQyESPc0MWK94rDb+KVY6TxpMhapUqJtTB4Q+DbNmYqgAQPylg=
X-Gm-Gg: ASbGncuJXhMs1BXk3wnXjUlC/HaxzDRNc3XkrZGNCmjSPZhMYuEKWjX8/IoXxdr7e8L
	fgYy+U5MFt4Qv6VAgXJitWWRhvNUizClr14ag+Q09FaF+7ANxVrSXiLyI8oYnoSZhVVF4IqqRNp
	RaT/DZ9v6qX/cn8xsHOOg1IZr2UUrVVRsHTasIcCUvAKN8ALMIRwWL9FA92tZK/n/numHNzKkQn
	fYlzVwj80WB2dwVawIOJgf+YIlMCATilG9o+UyBHblXlVxUArl+wM+cak9cCBaZRsADE1EwJO1Q
	OfFJn7wanfN4Jo7rMlCt/O1bax0TVyAbB8AQ3MIQzYp0V7lTq7/zif+hPIuYIg0sd+AU3bemp21
	W8TREToh23Be1RjEGlbEu4pT9kYgefmkrqliiFnnuYvA=
X-Google-Smtp-Source: AGHT+IEjUNCKwMFmcTC1mCtp+g1NvGYMh8RhRZKd2zGNdC2UZrlX+wiBj0p0U84WvOuYu+ql8obEqw==
X-Received: by 2002:a17:907:1c85:b0:afe:bd37:5d5f with SMTP id a640c23a62f3a-b01d8a26e70mr146645466b.7.1756555297729;
        Sat, 30 Aug 2025 05:01:37 -0700 (PDT)
Received: from puma.museclub.art ([2a00:6020:b3ea:9c00:26e7:b56a:5a2d:1d72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff0d9b1b53sm299445966b.96.2025.08.30.05.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 05:01:37 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Michael Tandy <git@mjt.me.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] (asus-ec-sensors) add Pro WS WRX90E-SAGE SE
Date: Sat, 30 Aug 2025 14:00:59 +0200
Message-ID: <20250830120121.738223-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michael Tandy <git@mjt.me.uk>

Add support for Pro WS WRX90E-SAGE SE

Signed-off-by: Michael Tandy <git@mjt.me.uk>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 42 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index bedddb6bf9e1..12c6b5b266bb 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -9,6 +9,7 @@ Supported boards:
  * PRIME X570-PRO
  * PRIME X670E-PRO WIFI
  * Pro WS X570-ACE
+ * Pro WS WRX90E-SAGE SE
  * ProArt X570-CREATOR WIFI
  * ProArt X670E-CREATOR WIFI
  * ProArt X870E-CREATOR WIFI
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 83047c3263d3..09a751b44ee2 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -117,10 +117,18 @@ enum ec_sensors {
 	ec_sensor_fan_cpu_opt,
 	/* VRM heat sink fan [RPM] */
 	ec_sensor_fan_vrm_hs,
+	/* VRM east heat sink fan [RPM] */
+	ec_sensor_fan_vrme_hs,
+	/* VRM west heat sink fan [RPM] */
+	ec_sensor_fan_vrmw_hs,
 	/* Chipset fan [RPM] */
 	ec_sensor_fan_chipset,
 	/* Water flow sensor reading [RPM] */
 	ec_sensor_fan_water_flow,
+	/* USB4 fan [RPM] */
+	ec_sensor_fan_usb4,
+	/* M.2 fan [RPM] */
+	ec_sensor_fan_m2,
 	/* CPU current [A] */
 	ec_sensor_curr_cpu,
 	/* "Water_In" temperature sensor reading [℃] */
@@ -150,8 +158,12 @@ enum ec_sensors {
 #define SENSOR_IN_CPU_CORE BIT(ec_sensor_in_cpu_core)
 #define SENSOR_FAN_CPU_OPT BIT(ec_sensor_fan_cpu_opt)
 #define SENSOR_FAN_VRM_HS BIT(ec_sensor_fan_vrm_hs)
+#define SENSOR_FAN_VRME_HS BIT(ec_sensor_fan_vrme_hs)
+#define SENSOR_FAN_VRMW_HS BIT(ec_sensor_fan_vrmw_hs)
 #define SENSOR_FAN_CHIPSET BIT(ec_sensor_fan_chipset)
 #define SENSOR_FAN_WATER_FLOW BIT(ec_sensor_fan_water_flow)
+#define SENSOR_FAN_USB4 BIT(ec_sensor_fan_usb4)
+#define SENSOR_FAN_M2 BIT(ec_sensor_fan_m2)
 #define SENSOR_CURR_CPU BIT(ec_sensor_curr_cpu)
 #define SENSOR_TEMP_WATER_IN BIT(ec_sensor_temp_water_in)
 #define SENSOR_TEMP_WATER_OUT BIT(ec_sensor_temp_water_out)
@@ -168,6 +180,7 @@ enum board_family {
 	family_amd_500_series,
 	family_amd_600_series,
 	family_amd_800_series,
+	family_amd_wrx_90,
 	family_intel_300_series,
 	family_intel_400_series,
 	family_intel_600_series,
@@ -278,6 +291,21 @@ static const struct ec_sensor_info sensors_family_amd_800[] = {
 		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
 };
 
+static const struct ec_sensor_info sensors_family_amd_wrx_90[] = {
+	[ec_sensor_temp_cpu_package] =
+		EC_SENSOR("CPU Package", hwmon_temp, 1, 0x00, 0x31),
+	[ec_sensor_fan_cpu_opt] =
+		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
+	[ec_sensor_fan_vrmw_hs] =
+		EC_SENSOR("VRMW HS", hwmon_fan, 2, 0x00, 0xb4),
+	[ec_sensor_fan_usb4] = EC_SENSOR("USB4", hwmon_fan, 2, 0x00, 0xb6),
+	[ec_sensor_fan_vrme_hs] =
+		EC_SENSOR("VRME HS", hwmon_fan, 2, 0x00, 0xbc),
+	[ec_sensor_fan_m2] = EC_SENSOR("M.2", hwmon_fan, 2, 0x00, 0xbe),
+	[ec_sensor_temp_t_sensor] =
+		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x01, 0x04),
+};
+
 static const struct ec_sensor_info sensors_family_intel_300[] = {
 	[ec_sensor_temp_chipset] =
 		EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a),
@@ -421,6 +449,15 @@ static const struct ec_board_info board_info_pro_art_b550_creator = {
 	.family = family_amd_500_series,
 };
 
+static const struct ec_board_info board_info_pro_ws_wrx90e_sage_se = {
+	/* Board also has a nct6798 with 7 more fans and temperatures */
+	.sensors = SENSOR_TEMP_CPU_PACKAGE | SENSOR_TEMP_T_SENSOR |
+		SENSOR_FAN_CPU_OPT | SENSOR_FAN_USB4 | SENSOR_FAN_M2 |
+		SENSOR_FAN_VRME_HS | SENSOR_FAN_VRMW_HS,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_RMTW_ASMX,
+	.family = family_amd_wrx_90,
+};
+
 static const struct ec_board_info board_info_pro_ws_x570_ace = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
 		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET |
@@ -650,6 +687,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_pro_art_x870E_creator_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt B550-CREATOR",
 					&board_info_pro_art_b550_creator),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("Pro WS WRX90E-SAGE SE",
+					&board_info_pro_ws_wrx90e_sage_se),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("Pro WS X570-ACE",
 					&board_info_pro_ws_x570_ace),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII DARK HERO",
@@ -1173,6 +1212,9 @@ static int asus_ec_probe(struct platform_device *pdev)
 	case family_amd_800_series:
 		ec_data->sensors_info = sensors_family_amd_800;
 		break;
+	case family_amd_wrx_90:
+		ec_data->sensors_info = sensors_family_amd_wrx_90;
+		break;
 	case family_intel_300_series:
 		ec_data->sensors_info = sensors_family_intel_300;
 		break;
-- 
2.51.0


