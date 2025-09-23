Return-Path: <linux-kernel+bounces-829561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B07B9757E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD4A1891594
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0758305054;
	Tue, 23 Sep 2025 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ctc9sJDq"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF892E7F27
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655786; cv=none; b=CLk2hw/k4qi7ZV09gK/d/tXGQn9/bQiIwj0XKURbukAol3pZLHSaXBLgrlhuTdgb6ChOkFLOaaX7jQkFHuYqrqyGY22HohEkzNMrSlhrCr8UWBIRv2aJ5XaDdKZ9iM42y1Aeb8Y8zBoyuUeBnKEW/oeasK6sEWp/BwDyoQfG8Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655786; c=relaxed/simple;
	bh=bNPIQa1hzSUEp21UxvqcCD/DXZb5BW2TnmlqseXqEIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRh8nCH/iFL8ak7VeyLexjNITyInxcPUE0OQSSxU2/T88eYGlmDHpFBz1joIgclx4c1s97l7DF/J2CTimlhogS2q5Z7rXluosbmqFu1v7gfL4jFiBOChTcMoHnLJMGaahEuC/3b/809QrLoB+rjIFsl38ZjZJOR355vzfRINjwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ctc9sJDq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0b6bf0097aso1084181566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758655783; x=1759260583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvvR3TD1/hZKig5BdYwMjCQxtKWaPvP8LVDupYgSUE4=;
        b=Ctc9sJDqwo8AQm2YQNJq3lrL3mgGpYCtgSAb6KnN6fjA7GCiCeUiGb4xJghtJUT8/P
         CteZmkXX+lwZgcYtFIbzyCb1MB77uaB1o9mtMMX8ZX15pOJ8ecQGE+D8ikbTxRI1eVDw
         VMMgmbzxQpGu9z4chiII8xj6bVouRypev0ePBoJN5DycEnqNoClHNoFcwIbN5tb6rpd2
         jS7BRpJXB8vc8P3yfNNaZ4iuE2j5h0JnWuWdxf3ZiZ9UHQvd6uQUmr+MSXxamMoAUJaC
         83wT7J2qVken2nrKdgUCpaYZoLnEfmqSz+k+5g2ZOFB0dvcQThAM2YPNuxD159DJA5wD
         YnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758655783; x=1759260583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvvR3TD1/hZKig5BdYwMjCQxtKWaPvP8LVDupYgSUE4=;
        b=Qfg9IqssUf0XaKiyfYt4d+SN4o/f6Ah2P3I3LjZaSFc7B9fzCaGvN3EfdY2U77IW4K
         6BXql0xZ94y7O8bjU/YfXGulZhlCqdN+CIrpn/7mULnx9phFZWD+OrhELMm99mip4ZlO
         HqDULRIoiZeaL/hY0qVcNf1TLdjev/0U1fqno0BSdEEnsUOAbh9Ndoi0glcVb6dMI1Eg
         WZVJxXCsSzkUERr7Xl0D+MsOLLaJRBjKhvdQbm9Bx9nNsvXT0N+Pl+MateX+ItmT8RZ0
         JI9msVhWNH7cmmzL3XoXiZLaCsMZ5eAgQzny3tp0IfPF3nSwASzI96YLUloicuAqHwaK
         TmcA==
X-Forwarded-Encrypted: i=1; AJvYcCXEBoBU6bL+7efnK31T6strT0528/G6y9GX7jFhlFZeLpEv8LnWixGm0ID/mR+SQ8V6reZM2zSmVI34FDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEFHDL+xHSbXzE/+Dbbg0KlLnh4FhZmbOsw5uREZDfxCijfmdF
	6MfIzvKMiXc+gy4vwBq2QSlAyY7ZhoRxj0Y//7y15P9oAa3ksKDHUTyn
X-Gm-Gg: ASbGncszyj8gbGjEF0b/CQVcy9jVwgt0VyGt13l6JumpBBMj090yJqnxXvvmn25Hv1j
	I+S1d8ulbHpxdagHZDiGDCGGW4FEpVmMfcv7H5quTcUYVTCgXZhjL2mDskcqCv21dB+K3cGSMdu
	gp9d5QRhbwA1xV0A/iK28IKbFQkfiGfKeS45XO9zSG3DjNdqr5J5vy5hpB+sm8Yea0hvqqjesaP
	DKwSKw8HfIJaGUAOPOUkbFkK08Wt0Fx02f1rwKKqi0QBuJzD9hFUA3kAz8RahhM3icF3KJnUe6H
	x4vDvbxHRNFZvaCVvBuP6t9Mmh6NctRrXEAOESd0U5HA/dQFQUqADQCwvOHoG7ov3TlqdTRXWm1
	TeLLoTOhWpQxDu1vFDTOgXb0O8b5ytM+4h0gyctSXz4U=
X-Google-Smtp-Source: AGHT+IEI1qY18abvzA/F7kn9QvR+PwKMk7ak3Dt4UcaNlDekyOebnd5iqa0LFl9nA8m6jghAwB8cpA==
X-Received: by 2002:a17:907:7f8b:b0:b28:f64f:2fd3 with SMTP id a640c23a62f3a-b302a17b9e9mr306236866b.35.1758655782832;
        Tue, 23 Sep 2025 12:29:42 -0700 (PDT)
Received: from puma.museclub.art ([2a00:6020:b3ea:9c00:26e7:b56a:5a2d:1d72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd271f895sm1370710466b.97.2025.09.23.12.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:29:42 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Ben Copeland <ben.copeland@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: (asus-ec-sensors) add ROG STRIX X870E-E GAMING WIFI
Date: Tue, 23 Sep 2025 21:26:55 +0200
Message-ID: <20250923192935.11339-2-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923192935.11339-1-eugene.shalygin@gmail.com>
References: <20250923192935.11339-1-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Copeland <ben.copeland@linaro.org>

Add support for ROG STRIX X870E-E GAMING WIFI

This board uses the same sensor configuration as the
ProArt X870E-CREATOR WIFI motherboard.

Signed-off-by: Ben Copeland <ben.copeland@linaro.org>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index 4a99b65338bf..a5a58c00c322 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -36,6 +36,7 @@ Supported boards:
  * ROG STRIX X670E-E GAMING WIFI
  * ROG STRIX X670E-I GAMING WIFI
  * ROG STRIX X870-I GAMING WIFI
+ * ROG STRIX X870E-E GAMING WIFI
  * ROG STRIX Z390-F GAMING
  * ROG STRIX Z490-F GAMING
  * ROG STRIX Z690-A GAMING WIFI D4
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index dff13132847c..ce3ea0333fd9 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -635,6 +635,14 @@ static const struct ec_board_info board_info_strix_x870_i_gaming_wifi = {
 	.family = family_amd_800_series,
 };
 
+static const struct ec_board_info board_info_strix_x870e_e_gaming_wifi = {
+	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
+		SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
+		SENSOR_FAN_CPU_OPT,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_SB_PCI0_SBRG_SIO1_MUT0,
+	.family = family_amd_800_series,
+};
+
 static const struct ec_board_info board_info_strix_z390_f_gaming = {
 	.sensors = SENSOR_TEMP_CHIPSET | SENSOR_TEMP_VRM |
 		SENSOR_TEMP_T_SENSOR |
@@ -777,6 +785,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_strix_x670e_i_gaming_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X870-I GAMING WIFI",
 					&board_info_strix_x870_i_gaming_wifi),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X870E-E GAMING WIFI",
+					&board_info_strix_x870e_e_gaming_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z390-F GAMING",
 					&board_info_strix_z390_f_gaming),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z490-F GAMING",
-- 
2.51.0


