Return-Path: <linux-kernel+bounces-841082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B37ABB6387
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 10:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BCFC19E7A50
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 08:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2983C26C3A8;
	Fri,  3 Oct 2025 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOMk5kEd"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D03E265296
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759479013; cv=none; b=A1v1LWIABWBYwVYn6R5PGpMEK9G5mX/AICp9mGckVc2Zuskw9bodjOcA5SKJYGcRs8VU9AUe/2sVsOHhF0THZ+hy0X86vR81Bmu040M98qHZkoYlWg5BdVq7NtwAg40h5nTMdTeZx0y5e5yWM9xElKyPkHhjkA3cMjMYDVBHsKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759479013; c=relaxed/simple;
	bh=9DIPpA35pdmafui+h8OIPEgV4xoI8t7vOOsaXVJCgN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACUBIt8mhgahtAq6x0PDjqQZiJcGaLNyfZd82oisnACadBeLc8yqLp9WAPJgKw1U6pfu7uWCTIqcYgRRg/6O9Fn8eiNZiO8I7ped1X7dfxia7jqfcWIcdEEmnGCeS3MuGn3GQPL5gI6MMu0ZZaaZjqtJA3zdrhuhYAFIyAp/DM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOMk5kEd; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62fa062a1abso3561913a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 01:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759479010; x=1760083810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hds0qbpzpiavg7ZwHmljrB5iCR52ykw9ON25aiglDTw=;
        b=fOMk5kEdKi6xBk3FSWZuXJn+lV2Djbpsm2RYmuyLZPw9jVfWB9wMHpSMidyd2e2y/2
         c22bJh4tve5YLsGrzuGCqiGKpf/OO6p1kWVLOVILA3ANpQ/oAFSDaMifQyy+uUNRhDhC
         2ifcLWwFnbkgFd/ZpMF8JUWgBx3D3Hs3A/Fa6Gkk5Mgi3Tr3wsiIjtmNGRDvlkwjXalC
         0TidYkYht3n9HQVwO8y4xKuCeeQFS9Wwnn2ONaKxQbJjKmFF+r620BrVUhuZmgvoBE1G
         isB5PAswkI4FhgQ9e/gm2wmIz3VF/LWThbNhQed/4xCMzFCeoJJHWl//pWangCSLV4gD
         YwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759479010; x=1760083810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hds0qbpzpiavg7ZwHmljrB5iCR52ykw9ON25aiglDTw=;
        b=KCuAllv6CftStBFJ443PNcoW09V2Gz3MRD5ZsBZN/KFHIaQN6Jydba41NBZtVHn2kU
         hJ6B7c34BgYLKGndw4QgwfGJhpuCGNsby96mDOMSSsGs3PRuCCCyyB1OZgoSqtSBA64e
         Iqd746nwYyqfK+hZdfQ0pE8PjeIodX1KY/p/FQUGSfxw0cLawtZjw5UtT8Jrsz6VjZzS
         hRxQFHatk6/wezy2B2mqG4NGI7lm7C7nqlMKhXiHmKHSQRgdYEQsv7kviwfIzErg60DD
         wz6WSVCBJmhjud30iQ3v2t76M6tXCg7cuZBWpyrMadN4pVYaqe6W/2DrUVVq1q22Sd1e
         sxFg==
X-Forwarded-Encrypted: i=1; AJvYcCXVLuAKcNVItnpqDG/p9TXi6zDYp9MpqabSatw1OSjSpfPjRPNZAs5iO2jJC5+8tYfG7K9m1kTey4nOnqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqB5TywxzideRGJGQ2rOh+3pMRciOCReQWme3JbkSBceLRNOvG
	5WCMH+vb3uL9F9LygBRGiOU2v46GCnp74Tp7Dn8a71ElRbEocPBTx597
X-Gm-Gg: ASbGncuGbC6AzCX5QmUKOQjHcIk3n14KfWPBXlr5cpTSUyXUFprOHqSSOhxT+0e2SyA
	YlJBpCWM4F9rCUREc3WJ2GTtNreAxdGG62Lsl4riuJDrbiIE/9RRH4CjvQiDe/Ssi+Aab/pxcyf
	ZXZg/KkFKTEr8jFKMHd0/LwTPOXVU2YqcRAreaHo5ys9DJZ1RVHHekp2nmRWM0BZhjPJbK/ZIJf
	WmkrFHyXfwtU/mSPi49zXGnyhdc3i6Qx6DwAYmn/K21nSRflAp3M0ORCjZWWUwem+NLwSPqrqu7
	iSxB9kZlgrdYiWo46YQ6wJEGgrz5Rf1Rm7FSh/7a6KPekI2OOVO3prMWB6OJH3xdkh9JAb/f/Iu
	xtScInq5SCwP0xXdtSSadUspViH5VPdWHJWE7eLB/gGifhihSiUlcHegsWHmL9EqTqSmSBml/jL
	01MQ==
X-Google-Smtp-Source: AGHT+IFu8wl8hwA2CjgUdqTHCDizrAkUMcbHTh2/6sxWmlyxSbvnHeDtk26mu8GVuA+QnvQcXPkJeg==
X-Received: by 2002:a05:6402:3585:b0:638:3f72:1258 with SMTP id 4fb4d7f45d1cf-639348e6463mr2252183a12.16.1759479009756;
        Fri, 03 Oct 2025 01:10:09 -0700 (PDT)
Received: from puma.museclub.art ([2a00:6020:b3ea:9c00:26e7:b56a:5a2d:1d72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-637ef848199sm1990301a12.21.2025.10.03.01.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 01:10:09 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Maximilian Luz <luzmaximilian@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (asus-ec-sensors) add ROG STRIX X870E-H GAMING WIFI7
Date: Fri,  3 Oct 2025 10:07:57 +0200
Message-ID: <20251003081002.1013313-3-eugene.shalygin@gmail.com>
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

From: Maximilian Luz <luzmaximilian@gmail.com>

The board has a similar sensor configuration as the ROG STRIX X870E-E
GAMING WIFI, with an additional temperature sensor header.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index ab0f255d9653..2666ed3a8ea3 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -38,6 +38,7 @@ Supported boards:
  * ROG STRIX X670E-I GAMING WIFI
  * ROG STRIX X870-I GAMING WIFI
  * ROG STRIX X870E-E GAMING WIFI
+ * ROG STRIX X870E-H GAMING WIFI7
  * ROG STRIX Z390-F GAMING
  * ROG STRIX Z490-F GAMING
  * ROG STRIX Z690-A GAMING WIFI D4
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index d969c5dc4b0f..7f35eade3a9b 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -660,6 +660,14 @@ static const struct ec_board_info board_info_strix_x870e_e_gaming_wifi = {
 	.family = family_amd_800_series,
 };
 
+static const struct ec_board_info board_info_strix_x870e_h_gaming_wifi7 = {
+	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
+		SENSOR_TEMP_MB | SENSOR_TEMP_VRM | SENSOR_TEMP_T_SENSOR |
+		SENSOR_FAN_CPU_OPT,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_SB_PCI0_SBRG_SIO1_MUT0,
+	.family = family_amd_800_series,
+};
+
 static const struct ec_board_info board_info_strix_z390_f_gaming = {
 	.sensors = SENSOR_TEMP_CHIPSET | SENSOR_TEMP_VRM |
 		SENSOR_TEMP_T_SENSOR |
@@ -806,6 +814,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_strix_x870_i_gaming_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X870E-E GAMING WIFI",
 					&board_info_strix_x870e_e_gaming_wifi),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X870E-H GAMING WIFI7",
+					&board_info_strix_x870e_h_gaming_wifi7),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z390-F GAMING",
 					&board_info_strix_z390_f_gaming),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z490-F GAMING",
-- 
2.51.0


