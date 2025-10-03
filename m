Return-Path: <linux-kernel+bounces-841081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FDBBB6384
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 10:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2E8E4E88E3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 08:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF7D269AFB;
	Fri,  3 Oct 2025 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/cKm0ev"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C40B25EFBE
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759479012; cv=none; b=ZKUhtDfTDVAHvf4mQL0GhP3dfNVRwFxTBsM2pEHS7hwsIGo3ZASxQjdwwd+hDTFH0/vmUOcMTf17NbTWSs2w6VfyvQ8Rd7tJwmqAZ6IHn4Fog/yyu2sDZGxfp3rRb3ekVy0CPClPTLthWlpphiESmq2X1tvXAN1lw6X6TlspzJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759479012; c=relaxed/simple;
	bh=CDojOjHiNpGDqkUj+nol7HDMziH5oL0Gcc2huoZa/XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k46vAfE0zztuwQNshSzSaBllNorhxjV2Juh6xbJMMxXImzAPbqyK+e8HkgSsEgflwgknW2Q4YGyKALJPnFB1+9TeDjEWKQJ58T867kCU4f3Ib8cqtiHhGZLyPcXmyFCZ6DFp5FbNDnLRE+QDJxHaiQiMbnnf6vw9xPh67caK1l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/cKm0ev; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7322da8so414487266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 01:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759479009; x=1760083809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVJ/Veu9dSAAGjGHBCma/AA2tUle10swNZ3pefVk2qk=;
        b=J/cKm0evWGQvIzCa3pqCh4q3WqlTuUmVfGHpLQhgb/ktu1yGlSuH7s26H7rvRWs+5t
         dmyCbdHvyLhYfwXr11usiTGwI4Xy+nmaHYlRX8nzZlc6BnYOo5oP0G6tYabkX78Og2BS
         R9Bq6Tyi1zgvh6somULSmjQU4STAlgo8xqRpidRHJh79O1UuyhWLuUOVTAswoDIMnVE/
         0C/YraZYn9wFGnHHWC1fYbjbAk33HiIzWpnaxwrZ4QUtTfVOeRVKXJYbfaUsnRBbbqr8
         CxJMZYJ92JkHhEHWxaCakeKnuUtMkF63m5b8xGSnk0AlRX0K9w8C2jxUbVUCLVkelWyJ
         pfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759479009; x=1760083809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVJ/Veu9dSAAGjGHBCma/AA2tUle10swNZ3pefVk2qk=;
        b=OcsW3pxHe5EC6lXOgIHB0W8mVcYFvzte/LBkmBYfezpMK6DtFsldf7t8NMUQzo41Iy
         s87f//9UOw4nY2jkPgHe9wMOHfmWJpA1/tUxL1Yq5c66JeGzQXNDZIBFY5iDedAi08m+
         Bio4qCgmHxF2RGskQ3DmcGEwx1vxj9WVDf/PEthMxDXGxlCdtRGnwyO03c/U4XiNrte5
         0el65iDmOMbBMEJ13UoYVW1caMq6IYwZDI+oLq7ag4gxax5lkHjHIALQpN1yA8jSlen0
         v7bHocVpjrLEb9Q+HyVXMvdpQrgQc3Q9uUBGrz/ZgRJ++r6TAX/4tXz1ULZl9b1tRclr
         kcRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc8gczIHzc0JuF4a7pOwtCvrupxTrrV7KaNV2tNSBqsx6uY9lV8rEl+Nsr3JRD/LmJ7/v3kvvRpDswIbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPYS6wNQCBLtTKhc8OYGHXIdM6mHNcedEgQBKmmsGHD+/+QGzt
	BeVbkWCTCRxj8BKRMleaEZtOlhSWoaLESgAwvwvD4QkPJ/a8gPE3srcW
X-Gm-Gg: ASbGncvDUL9anEPbfwhgd3XSrd3XgdO9ydrDXmk4/rFuYKywStwcK/rb2IzG7qcmSsS
	eaKkXC3CRkEvSC+BaiZKsmZIdOEKfkTb6p1T4q4PfcmMVkmiuvChn70IQzx0QdLL2myHlQFk44y
	NaeKypf1NxMMkOe5Yfd3yPQUkvnXLat2ipF8xFfsJz4P4MnbBAuvHR7/GM1doqbA8wUeMVANstY
	WYgw2G0ez9IZ7zfuRuH/GeGUel8fN8AkBBamqUPnLTB1byRpngfdQkdYYdMl3M6iw6eu7ANa8Ra
	ee9ysAUBVSuOkrzrOsrP9/9FsMxl/edMijzGXMoAYH6qm/ZjH/pdwibFbJWWmLA1jkc929Yu/gY
	aLVGfCABArapBZFEt/mS4nryvsxHgoEZFHVyCehF+Ot8/UQ+WyN7Vgnq7QiDbhzp5AGI2Es6p84
	09QA==
X-Google-Smtp-Source: AGHT+IFw2GK6AO8N1qwYsFnYtU7sgXmeBktWCQEzilPApQ2fSgjB0tfRGb3lF/N3hrpJWOUxc7p46g==
X-Received: by 2002:a17:907:3e85:b0:b45:420c:81c0 with SMTP id a640c23a62f3a-b49c373e917mr241514866b.36.1759479008580;
        Fri, 03 Oct 2025 01:10:08 -0700 (PDT)
Received: from puma.museclub.art ([2a00:6020:b3ea:9c00:26e7:b56a:5a2d:1d72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-637ef848199sm1990301a12.21.2025.10.03.01.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 01:10:08 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Paul Heneghan <paul@networks-extra.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: (asus-ec-sensors) add Pro WS TRX50-SAGE WIFI
Date: Fri,  3 Oct 2025 10:07:56 +0200
Message-ID: <20251003081002.1013313-2-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003081002.1013313-1-eugene.shalygin@gmail.com>
References: <20251003081002.1013313-1-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Heneghan <paul@networks-extra.com>

Added support for Pro WS TRX50-SAGE WIFI motherboard.

Signed-off-by: Paul Heneghan <paul@networks-extra.com>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index a5a58c00c322..ab0f255d9653 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -9,6 +9,7 @@ Supported boards:
  * PRIME X570-PRO
  * PRIME X670E-PRO WIFI
  * PRIME Z270-A
+ * Pro WS TRX50-SAGE WIFI
  * Pro WS X570-ACE
  * Pro WS WRX90E-SAGE SE
  * ProArt X570-CREATOR WIFI
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 34a8f6b834c9..d969c5dc4b0f 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -182,6 +182,7 @@ enum board_family {
 	family_amd_500_series,
 	family_amd_600_series,
 	family_amd_800_series,
+	family_amd_trx_50,
 	family_amd_wrx_90,
 	family_intel_200_series,
 	family_intel_300_series,
@@ -294,6 +295,15 @@ static const struct ec_sensor_info sensors_family_amd_800[] = {
 		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
 };
 
+static const struct ec_sensor_info sensors_family_amd_trx_50[] = {
+	[ec_sensor_fan_vrmw_hs] =
+		EC_SENSOR("VRMW HS", hwmon_fan, 2, 0x00, 0xb4),
+	[ec_sensor_fan_vrme_hs] =
+		EC_SENSOR("VRME HS", hwmon_fan, 2, 0x00, 0xbc),
+	[ec_sensor_temp_t_sensor] =
+		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x01, 0x04),
+};
+
 static const struct ec_sensor_info sensors_family_amd_wrx_90[] = {
 	[ec_sensor_temp_cpu_package] =
 		EC_SENSOR("CPU Package", hwmon_temp, 1, 0x00, 0x31),
@@ -533,6 +543,13 @@ static const struct ec_board_info board_info_pro_art_x870E_creator_wifi = {
 	.family = family_amd_800_series,
 };
 
+static const struct ec_board_info board_info_pro_ws_trx50_sage_wifi = {
+	/* Board also has a nct6798 */
+	.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_FAN_VRME_HS | SENSOR_FAN_VRMW_HS,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_RMTW_ASMX,
+	.family = family_amd_trx_50,
+};
+
 static const struct ec_board_info board_info_pro_ws_wrx90e_sage_se = {
 	/* Board also has a nct6798 with 7 more fans and temperatures */
 	.sensors = SENSOR_TEMP_CPU_PACKAGE | SENSOR_TEMP_T_SENSOR |
@@ -739,6 +756,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_pro_art_x670E_creator_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt X870E-CREATOR WIFI",
 					&board_info_pro_art_x870E_creator_wifi),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("Pro WS TRX50-SAGE WIFI",
+					&board_info_pro_ws_trx50_sage_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("Pro WS WRX90E-SAGE SE",
 					&board_info_pro_ws_wrx90e_sage_se),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("Pro WS X570-ACE",
@@ -1274,6 +1293,9 @@ static int asus_ec_probe(struct platform_device *pdev)
 	case family_amd_800_series:
 		ec_data->sensors_info = sensors_family_amd_800;
 		break;
+	case family_amd_trx_50:
+		ec_data->sensors_info = sensors_family_amd_trx_50;
+		break;
 	case family_amd_wrx_90:
 		ec_data->sensors_info = sensors_family_amd_wrx_90;
 		break;
-- 
2.51.0


