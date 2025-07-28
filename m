Return-Path: <linux-kernel+bounces-748610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F08DB14395
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315874E3527
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1380127877D;
	Mon, 28 Jul 2025 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmuBAeIM"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56502235057;
	Mon, 28 Jul 2025 20:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753735909; cv=none; b=DVXYuDpTISHtDef54yOidMZkajw7nJ8H30PoIdIXP8YjF0pQPFRq9rXArr1iZ0QO3X6NNqf/+pAbbnX3JpoXqcpYLD4xWyNtQ52qyeV+JiCVhQcIGZG3QNk5lJMgVZgnBGWstfVZWL/w+WQxZoMDeoCeYOmzoABIWs2q/ZueTRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753735909; c=relaxed/simple;
	bh=LbU9QNjIJ9o/RrOlnemX+xU1Ff0wX8+W+xvJQ3POAq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3pRWQfYgvdqLVILr7wfhMMo5+wP0HfmiD0SrsD/x8qyb8NUvQtKK+kA0a+bwK3rW3dCxj1igzLAIeoatpW3OykTuH0Vh+6UTFxUfXb9xMCnO5WCDb2ZAwuam4tfNSxARPCv6U+x7Mno77KfcmWCaMUmev5YlCScQQeHferrWYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmuBAeIM; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso7759244a12.1;
        Mon, 28 Jul 2025 13:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753735905; x=1754340705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08lRxFVNZckhlMJF1tDmvh9bauDWalm4tpzq6lHddRU=;
        b=AmuBAeIMLDUx9eq02HQWDl58LV1z8TJBDQGDDpxgyxJ8h0BnZ5UbhGx0R+uEmcI3JB
         qxVgeaXd4Djiwy1ginDbGkOVT0BGiclX8IW4PUbZDV1BiC+/tMRGji51sbj6En3mv9qq
         jrza2cV7CHZ7Ens7oKPD22reHGnsdBe9inIS1Zt6rgv2FtsF6z/iloPEMh2C6ltYNndD
         oWS92U3GoxawS3zAN2oS4drCxpKQep4Td8GppTUwf8fPVzsdODp7KqjHH685J2m/lVLA
         SwFulHWeHh2EjADPCZV0oBl2Iux8eeOJnGuwZ+Xsvk3X4vho6b4xFCCMpopOJV7I3jbZ
         Kmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753735905; x=1754340705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08lRxFVNZckhlMJF1tDmvh9bauDWalm4tpzq6lHddRU=;
        b=ukF3qQLZfLnk00DSgDk/TdtbYbNdfa8iLA8290OmO019XUSC6nhgJ/MfRa63Bkg/Vn
         aGRfF6X567Tuc3zwtY/lmMYE70wsp0PSH2NfnPBk/imnYoWl2rThZmZv/RbnNYOROTlv
         mRYXSfB+HfsVijykEPDlUjoDsjRiMdn2RsgnvpUijED0HlgEHKKS5g5JcFS8UK94H0au
         h3BoyYU0pZf6Dl2MHKZ7OVXNZCHIQAQ2kcfiP6UnwoF+3PDEuWv6GxJeSWGC0WV5uY4i
         HG5s5gQr0y0tN0mj1q0HFrLB+z9BsphtPU/2QWo0q0Lbp3uQKHdrhLQb7Xk99BP54SXi
         S9uA==
X-Forwarded-Encrypted: i=1; AJvYcCUSObcEwysDhrU1CnFEauwt0JoT19+Y1XaHuk3TgYcD3MQsJncZMR8Qbn8iL5mKPxfgHO8j8E0sHIc=@vger.kernel.org, AJvYcCX+pFF3OAkimakjrFDoxV3bYcpEPi6Cj8TOmPITkJwP04tV9iY/wlnmgVSVLscsQd/Q1bzk42u+H4MgmFw=@vger.kernel.org, AJvYcCX0Od46Q03QJ2Zq8I9dp6C7swKiinVqASkWP93h+4i2f7S63lo7VlKFr+C5CjfqQ+E4IJ4+JpvdrNdrP8yn@vger.kernel.org
X-Gm-Message-State: AOJu0YwLVo+p1xRZq/N60ZYwuWvGQ8uFvulTPlK9v2IPLyNENRRp17DP
	pvzXvPbBM6uIS9/NsFbK2/lien6aAB1h932xYGQM1kxNE1833fRCSCz0
X-Gm-Gg: ASbGnct38jJIzFdRCKnIVIZ9LhAECcdiJKrpCPaPOb5GgePCO48rJ8S1p4y+RQuH978
	eG1WA5OphkiRYAlLhGN/PePEZ6elAAMrcRn4tGMVqf977IYRoUJ18fSnjGb7/HT890mPNo4in5L
	q9v6HGzyyXxt1qEYfRVcI282ikBozgPvSJz8hDT8pwlo+mPymfGXZ3tgv/OGXdX9mgB91KKPmX4
	a2CKSKZxO42oZooy3NJ04weOBJfqQyvuMIhKHUieY18sBtHJehdIRut1Y9NA345ILYQdVwyVsdk
	1Nx0SasQ9vYCAeuwhei5YFBPz9U6KuR33TIdiZMR7ZlLgbkYH03v6JBQXKfwPp1vWFjqYViAh8q
	VNYIporKbGKC8ay8qdUQ9G9CzRn90DXeAj1JVnDX4clXnClny/MIPUumi6C806aK/+IwHQw6E//
	ptaroEgmO9bVIWEAwQNbUpvTk=
X-Google-Smtp-Source: AGHT+IHQ3CHb4jb+VIygIExljfM3JmMajc+rt5xDIR0ZNFFyFiSDaKq+XZKeWIc95ztLMnrVrUJ7WA==
X-Received: by 2002:a17:907:a0d1:b0:af6:36d0:d28d with SMTP id a640c23a62f3a-af636d0d31fmr1090744566b.22.1753735905358;
        Mon, 28 Jul 2025 13:51:45 -0700 (PDT)
Received: from puma.museclub.art (p200300cf9f013400cc194b80e1760d4a.dip0.t-ipconnect.de. [2003:cf:9f01:3400:cc19:4b80:e176:d4a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635ad589csm469943066b.118.2025.07.28.13.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:51:44 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Nicholas Flintham <nick@flinny.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] hwmon: (asus-ec-sensors) add ROG STRIX Z790E GAMING WIFI II
Date: Mon, 28 Jul 2025 22:49:10 +0200
Message-ID: <20250728205133.15487-4-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728205133.15487-1-eugene.shalygin@gmail.com>
References: <20250728205133.15487-1-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicholas Flintham <nick@flinny.org>

Adds support for the ROG STRIX Z790E GAMING WIFI II board

Signed-off-by: Nicholas Flintham <nick@flinny.org>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index 1e8274dba35f..da9a00111d1c 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -34,6 +34,7 @@ Supported boards:
  * ROG STRIX Z390-F GAMING
  * ROG STRIX Z490-F GAMING
  * ROG STRIX Z690-A GAMING WIFI D4
+ * ROG STRIX Z790-E GAMING WIFI II
  * ROG ZENITH II EXTREME
  * ROG ZENITH II EXTREME ALPHA
  * TUF GAMING X670E PLUS
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 0b19d148f65d..b9543eda2522 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -56,6 +56,8 @@ static char *mutex_path_override;
 
 #define ASUS_HW_ACCESS_MUTEX_RMTW_ASMX	"\\RMTW.ASMX"
 
+#define ASUS_HW_ACCESS_MUTEX_SB_PC00_LPCB_SIO1_MUT0 "\\_SB.PC00.LPCB.SIO1.MUT0"
+
 #define ASUS_HW_ACCESS_MUTEX_SB_PCI0_SBRG_SIO1_MUT0 "\\_SB_.PCI0.SBRG.SIO1.MUT0"
 
 #define MAX_IDENTICAL_BOARD_VARIATIONS	3
@@ -168,7 +170,8 @@ enum board_family {
 	family_amd_800_series,
 	family_intel_300_series,
 	family_intel_400_series,
-	family_intel_600_series
+	family_intel_600_series,
+	family_intel_700_series
 };
 
 /*
@@ -323,6 +326,14 @@ static const struct ec_sensor_info sensors_family_intel_600[] = {
 		EC_SENSOR("Water_Block_In", hwmon_temp, 1, 0x01, 0x02),
 };
 
+static const struct ec_sensor_info sensors_family_intel_700[] = {
+	[ec_sensor_temp_t_sensor] =
+		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x01, 0x09),
+	[ec_sensor_temp_vrm] = EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x33),
+	[ec_sensor_fan_cpu_opt] =
+		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
+};
+
 /* Shortcuts for common combinations */
 #define SENSOR_SET_TEMP_CHIPSET_CPU_MB                                         \
 	(SENSOR_TEMP_CHIPSET | SENSOR_TEMP_CPU | SENSOR_TEMP_MB)
@@ -568,6 +579,13 @@ static const struct ec_board_info board_info_strix_z690_a_gaming_wifi_d4 = {
 	.family = family_intel_600_series,
 };
 
+static const struct ec_board_info board_info_strix_z790_e_gaming_wifi_ii = {
+	.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+		SENSOR_FAN_CPU_OPT,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_SB_PC00_LPCB_SIO1_MUT0,
+	.family = family_intel_700_series,
+};
+
 static const struct ec_board_info board_info_zenith_ii_extreme = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
 		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
@@ -660,6 +678,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_strix_z490_f_gaming),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z690-A GAMING WIFI D4",
 					&board_info_strix_z690_a_gaming_wifi_d4),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z790-E GAMING WIFI II",
+					&board_info_strix_z790_e_gaming_wifi_ii),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME",
 					&board_info_zenith_ii_extreme),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME ALPHA",
@@ -1142,6 +1162,9 @@ static int asus_ec_probe(struct platform_device *pdev)
 	case family_intel_600_series:
 		ec_data->sensors_info = sensors_family_intel_600;
 		break;
+	case family_intel_700_series:
+		ec_data->sensors_info = sensors_family_intel_700;
+		break;
 	default:
 		dev_err(dev, "Unknown board family: %d",
 			ec_data->board_info->family);
-- 
2.50.1


