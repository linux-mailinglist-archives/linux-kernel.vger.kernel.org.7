Return-Path: <linux-kernel+bounces-799292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 663F0B429A3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E962B1BC5985
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C752D8DC3;
	Wed,  3 Sep 2025 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGbUQaCx"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E9E2D374A;
	Wed,  3 Sep 2025 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927091; cv=none; b=PBXdLkCpy7c2hNNsmWOoME7s3ave0Ro+2m//2/A/B2c4Ba+kliU+lQ3S3D/C3pH/hkNKuTKwV05L4/sjBRW4G9AwTSnBGxeqR+pgSxiq9Sq3/tcYyCReWiUtAQjPmpBvnYNy6mCydEItte5Z+KsB61ZZMzcCL+fxfsLD3mBK9OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927091; c=relaxed/simple;
	bh=xV6xUW0ek1YrmfzGK0fIqZX3dLfJdOS48+64L23kSHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T8KoP4xZ4ulDLCBxfiH4M4/48nj9pVqcSQ7DlcdYpl20rHEn+tiRzRVbbdYuaIBvPIPmggdAuHQ2H+D4tFGiYqvjOFd5LHYmCosefwePCGF9F2G3Q6ctme5EJHrsmBIOe+1vDKFh8UEwzFH6X3SKd39moaxWZzsnD4vzGivKXxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGbUQaCx; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afec5651966so46541966b.2;
        Wed, 03 Sep 2025 12:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756927088; x=1757531888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NEW9ENpf9cDlrx7DZwA8LgLuO53fBauEZC+hXrAMCLw=;
        b=mGbUQaCxS99di+FcoJuQOvf2fdZhYWb/40mkKafOBsSZ6WenDerd68Y2+01T/+3zNG
         X0BW1k3pT3gXTQN13ceTsYIhBJ/ttewZCnztM8ZVajVu2bEpY4AjmjM1NIEAtdHswRC0
         7NfGh+AFan0rYmZtyTvrd/cxNwMmoDXe707EWbRF7KyI92wAVzMnX9ZINOy5spzJz39y
         R9vIx87Zog88e84z+cENemrnsKfOPFrHaSUPksaks+b4jrAjPEFVqHf9l7GaTWM76H8B
         H2CYq9yEC5mnu4LvHgfYA3bo2tEY1e7lhnq29MUxw6aIfuEafEpGT61T3QjCNKQQotGF
         V/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756927088; x=1757531888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEW9ENpf9cDlrx7DZwA8LgLuO53fBauEZC+hXrAMCLw=;
        b=DEpR8naCNa//kn2Z9DvmqzEEjN2axMhcEjbwHxOfqsx11Kj/N08GJ3hkSH4EENFL8O
         4zZxhiBd3Ubz5AyuneuibXoQ9ONb3IytM7qz2zfoDJuXf+4BmtqB59CjmQuNH88LDoAu
         aEhcF11cNR076nMgteaq0lzpJ0CrifCEidZ07Jj6s0uWTDmyqMJEWpFy++DnSabZ8mW6
         N3ftukZOKaeOWATksSPFiQBsicHp1Bnong04+UZsFUU/DrTqP2dUZjY9uaRGpw5OsxdH
         yBb2eiS3kNNcrpfVVv7cGXC348mB+yxaO+gx4OXPZkfUNEthgQHHx7e2gIyZLJXoCrRI
         Tetw==
X-Forwarded-Encrypted: i=1; AJvYcCVdYEx/yvM3vN88962MQljhQbiV8JQRostHGLIvSXuyhJcOchrP3aMYEJ2N3uC8NoQCyJt64RiYfuOSYW7C@vger.kernel.org, AJvYcCVmliSKD5yJ/BZZiQjStvZ+nqGXhfIlKND0PcpPQ3DVlVg7QFxxtK6OYpymbj0j/HFzREnlzI4u8BboeaM=@vger.kernel.org, AJvYcCVwQ24hVrxDrcIbDMJipfs4voYPItFYGai18cMOc8sKjMU0hVLYGtvhjJETfJLB67gUt3KuY0+UjQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEhbLfe61gBfcH8HDULblgazx7eUI6g8kTTZ9gbVmoxIuUq/kM
	faou+pN/ZZjkmPjcsYfOa0KBh16bdQDzP8vvYKl/YMYJD18bgQxKH9ng
X-Gm-Gg: ASbGncvk56GmukXd9mHW44/b91KbbxWz/9LPvbyJERcDr/tZL2aUDFXqtsaSdqf+hAp
	PkUmeqgM513rm+mJUeO0dmuGKvX9veUEencodm15xnMJDGikRRfhMASX0ZPZ1kQaO1sX5QVC8na
	pFlJjOGwE/h9NPbJPjvp4C9TtfpEUsiGR/oP/8sh98TN0LvnHjbavQg7YMZXNNsbZvc59NSyZJT
	8d0fflfRCT2M8hZK0hJ4/HAjmxuyzEp5SSDa82NtBNT6UVcwPvQo0R6hU3sqvtd5Wb3KA2r4E7/
	mGwdFlwetlN3/+F9yCTe9tiX/8tZRYV4LrHp+qB/Ge09keQ/+dreqOQT87dwnEpMFY5qPg623Hm
	CoX+rK1AEvF51HDQ0Cl4d+rahgJmpOP8rP446GA7vqSc=
X-Google-Smtp-Source: AGHT+IGG1P+vjgNwczDz7OVnOVisBAgIx6LfcQ1UgBuGEG4CyxQSAhr+ZiqH6bvF46VroJFgJmB7xw==
X-Received: by 2002:a17:907:940c:b0:b04:5b47:8bd5 with SMTP id a640c23a62f3a-b045b478ebfmr630304066b.25.1756927087994;
        Wed, 03 Sep 2025 12:18:07 -0700 (PDT)
Received: from puma.museclub.art ([2a00:6020:b3ea:9c00:26e7:b56a:5a2d:1d72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b042523ee7bsm887768666b.109.2025.09.03.12.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 12:18:07 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: =?UTF-8?q?Jan=20Philipp=20Gro=C3=9F?= <janphilippgross@mailbox.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) add PRIME Z270-A
Date: Wed,  3 Sep 2025 21:17:26 +0200
Message-ID: <20250903191736.14451-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for the PRIME Z270-A board.

Tested-by: Jan Philipp Groß <janphilippgross@mailbox.org>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 27 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index e5052159ffa0..baf9eba5957c 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -8,6 +8,7 @@ Supported boards:
  * PRIME X470-PRO
  * PRIME X570-PRO
  * PRIME X670E-PRO WIFI
+ * PRIME Z270-A
  * Pro WS X570-ACE
  * Pro WS WRX90E-SAGE SE
  * ProArt X570-CREATOR WIFI
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index ecb058e8755b..f580ff2e212f 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -60,6 +60,8 @@ static char *mutex_path_override;
 
 #define ASUS_HW_ACCESS_MUTEX_SB_PCI0_SBRG_SIO1_MUT0 "\\_SB_.PCI0.SBRG.SIO1.MUT0"
 
+#define ASUS_HW_ACCESS_MUTEX_SB_PCI0_LPCB_SIO1_MUT0 "\\_SB_.PCI0.LPCB.SIO1.MUT0"
+
 #define MAX_IDENTICAL_BOARD_VARIATIONS	3
 
 /* Moniker for the ACPI global lock (':' is not allowed in ASL identifiers) */
@@ -181,6 +183,7 @@ enum board_family {
 	family_amd_600_series,
 	family_amd_800_series,
 	family_amd_wrx_90,
+	family_intel_200_series,
 	family_intel_300_series,
 	family_intel_400_series,
 	family_intel_600_series,
@@ -306,6 +309,18 @@ static const struct ec_sensor_info sensors_family_amd_wrx_90[] = {
 		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x01, 0x04),
 };
 
+static const struct ec_sensor_info sensors_family_intel_200[] = {
+	[ec_sensor_temp_chipset] =
+		EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a),
+	[ec_sensor_temp_cpu] = EC_SENSOR("CPU", hwmon_temp, 1, 0x00, 0x3b),
+	[ec_sensor_temp_mb] =
+		EC_SENSOR("Motherboard", hwmon_temp, 1, 0x00, 0x3c),
+	[ec_sensor_temp_t_sensor] =
+		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d),
+	[ec_sensor_fan_cpu_opt] =
+		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xbc),
+};
+
 static const struct ec_sensor_info sensors_family_intel_300[] = {
 	[ec_sensor_temp_chipset] =
 		EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a),
@@ -479,6 +494,13 @@ static const struct ec_board_info board_info_prime_x670e_pro_wifi = {
 	.family = family_amd_600_series,
 };
 
+static const struct ec_board_info board_info_prime_z270_a = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CPU_OPT,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_SB_PCI0_LPCB_SIO1_MUT0,
+	.family = family_intel_200_series,
+};
+
 static const struct ec_board_info board_info_pro_art_b550_creator = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
 		SENSOR_TEMP_T_SENSOR |
@@ -685,6 +707,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_prime_x570_pro),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X670E-PRO WIFI",
 					&board_info_prime_x670e_pro_wifi),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME Z270-A",
+					&board_info_prime_z270_a),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt B550-CREATOR",
 					&board_info_pro_art_b550_creator),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt X570-CREATOR WIFI",
@@ -1223,6 +1247,9 @@ static int asus_ec_probe(struct platform_device *pdev)
 	case family_amd_wrx_90:
 		ec_data->sensors_info = sensors_family_amd_wrx_90;
 		break;
+	case family_intel_200_series:
+		ec_data->sensors_info = sensors_family_intel_200;
+		break;
 	case family_intel_300_series:
 		ec_data->sensors_info = sensors_family_intel_300;
 		break;
-- 
2.51.0


