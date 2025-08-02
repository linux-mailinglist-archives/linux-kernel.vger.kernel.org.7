Return-Path: <linux-kernel+bounces-754144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F75FB18E9A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 15:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF072AA59F2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 13:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2622323B631;
	Sat,  2 Aug 2025 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZE/v2/Tc"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C038022128B;
	Sat,  2 Aug 2025 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754140159; cv=none; b=PjagQIqVCX8ZmAhGGii9DVoQd1KQh8+iHoqkqv7RwlUfMO7KExX19skdrfdfAk6MhSKoJ8vXAi/E/sOGFUhkWkrqsZzLhVQn7N4a1GbFiGhftRu+vD/PArwzSHvdFVR87aY8T5l0UHyBR3ZwWpr4bEBI2xsl7Xv8lkaK95PoYeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754140159; c=relaxed/simple;
	bh=bCB9IfmBe3GszsiUxXN5U8QTeY3yJiR+n3Dm+i6S8r4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QwIe8ZUIsW7WQM+e9wFtQjk0ToQlLgV03/N8COk6cfNWECvhyhnf6w5VNeaSJ76coiOe4YxJ2bJc62NTJlg6YhMiOcNGu3bHcXLC4h0Os2vKJWAU/EMHwI+LM1ZZfrqwPRufS9YjciVO7c6CYBaTG8GrUR9PAjbJJwqZ0XDRXFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZE/v2/Tc; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-615460d9897so3247825a12.0;
        Sat, 02 Aug 2025 06:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754140155; x=1754744955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LR6RtVeNg3Q+svUWV406Ui0fVcP9z9XbzX2f5A+PR1E=;
        b=ZE/v2/TcP801EBrQJjmxaZrotkxZlnmwuAko4k9zYzlnffOLeFI1Un5D4Z6UrIqkMC
         RFEPS+26QTFDefb9+wxbcHIIDpJdfpoohy3jfU/FuNrZ+MoBAVIXj77p2h7qV1DJIDMZ
         tneAQ6C1Bsu0PuLdOpaVJOMl8+FsUKojNBoVHgFepYx8TFr8361OAa+Uj1R7bF9xiHv8
         3HVATBQ62z+lA2ylE+TE+tqPubnIYK+moDUm0kFfB0CC25HVXpCuN+hCzlvYXn3PB8C+
         fC33O2jUIlVsxQrg8GNND5AZy9Idq/FrJ/2T/1wWRQ2+oJHMkiLIIx7kNofRi4zXA3YT
         65kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754140155; x=1754744955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LR6RtVeNg3Q+svUWV406Ui0fVcP9z9XbzX2f5A+PR1E=;
        b=m42ZY0t8jqnCNSBQpzBB8EpzI4i8+E5Sbek7HQyCqGRrvruPJ0rC4TnjbprcfwmTd3
         B4nNYl7/jw1ewRhRgkq3RGaVhqhwgKgZ3CnXmCCeZpZzxJluYgBZBC0osisbe+pTs3hD
         llkDCiNTk2DksTQZiUWXPKijaQXMew7z1u218T2TfJnuZhyJBqzZx+AUW3ok1LkG6D1c
         SjoMD8JmyH/NfyD75a/XK65BxhjJHH8Q/8hC5FucxFGJSWX3lZy4GwHR5v1qSuizO+Gq
         yTEZGrfrqTTVrE5ESYksqZYgvK23iQCyVo89DnuxV2AS01PPtiSak55a44gjSa3iNeog
         DYpA==
X-Forwarded-Encrypted: i=1; AJvYcCX1R6Y+ju0nM3C0iATa+ekPQ0a5fy9RuFiOhqKp3YkDZIv+IdhndzhJBJe3oIz3IBOlCHSg2yWbsxgsk2vl@vger.kernel.org, AJvYcCXJqDEzYY/RFoOIimLLBbBUTWQxxLA0NeoMtgT/WILU+3vPasPzUDIJiFu0vMcjSvSu4H8nUTY1/YAnqd0=@vger.kernel.org, AJvYcCXz1nCRb/oL4CcCs3v0WT2sD/4RCLRXrDtJu1Rld9EmIbAT9lWJ/XUufkHwcLgZzjibLcyhalDQJTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWYwLNWcYoCqZxLuGRSlK0iNrckVz9NDgzpU1Fgl4WWtkr0JQy
	ctenQ3/lr3ys+5zxetXspVGBhSzrN9p5FWuhOYO7hDsYIZin5pvJ7pxw
X-Gm-Gg: ASbGncsvEXj5ZhdRkM0JYPCcRx6bD39KDLcNToD5cJifPuc7q+F0mV8XQvGOrgHxY5O
	Fqaslgtmch4wFfT8jAfmchT3FuIZryy/LLEOGkNgkgDeqMJiCOABMROWCIJTa1TxRf3RqLN0VTc
	ObgS2y81kgV8ye5e6uVlXpK/gi7D7vvWeVf/k//zstnnoAB6lqorEJl8iAmpuERbhbxqaVF6QGH
	RWvI6zCPvWUUVwCuEk8+k0Sdx6Z5LOvII/8OAMgFYwFk1U/S+Gp735CM4L/ueh7Gj1+BlgOnIQZ
	46lf2gWEzs6k0MKDRNoa2l/GZe5q/kZgubJqLDCumUxGqxG5XQNVhWlVr7RjXaWvtJUDXAVinXK
	0Lw8cc5K6apiQO1m81omOuydaD3GLCjGexPoqVIiRaMkrdhBerXzYUBWJ0AaDI7UDgZ8z7s7QC+
	mLrahUjU9nVRy0BfGUguCYuwbeYdgsw6s7Tww=
X-Google-Smtp-Source: AGHT+IHSvulafVSZd46r7ifmQJL70hl/shPH7lVJn2yxde5U7XOVJ2haaLc5eeVbVy5VcRiwE9xbSQ==
X-Received: by 2002:a05:6402:35c9:b0:615:4728:f14 with SMTP id 4fb4d7f45d1cf-615e6f57dcdmr2467966a12.16.1754140154718;
        Sat, 02 Aug 2025 06:09:14 -0700 (PDT)
Received: from puma.museclub.art (p200300cf9f013400cc194b80e1760d4a.dip0.t-ipconnect.de. [2003:cf:9f01:3400:cc19:4b80:e176:d4a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7a32sm4191858a12.37.2025.08.02.06.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 06:09:14 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Jamie Vickery <j.a.d.mcmillan@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) add Z790-I GAMING WIFI
Date: Sat,  2 Aug 2025 15:09:02 +0200
Message-ID: <20250802130912.175543-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jamie Vickery <j.a.d.mcmillan@gmail.com>

Add support for the ROG STRIX Z790-I GAMING WIFI board

Signed-off-by: Jamie Vickery <j.a.d.mcmillan@gmail.com>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index 49f6cac63d19..bedddb6bf9e1 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -36,6 +36,7 @@ Supported boards:
  * ROG STRIX Z490-F GAMING
  * ROG STRIX Z690-A GAMING WIFI D4
  * ROG STRIX Z790-E GAMING WIFI II
+ * ROG STRIX Z790-I GAMING WIFI
  * ROG ZENITH II EXTREME
  * ROG ZENITH II EXTREME ALPHA
  * TUF GAMING X670E PLUS
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 33c5fcb0a09e..e2f7b8705cb1 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -329,6 +329,8 @@ static const struct ec_sensor_info sensors_family_intel_600[] = {
 static const struct ec_sensor_info sensors_family_intel_700[] = {
 	[ec_sensor_temp_t_sensor] =
 		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x01, 0x09),
+	[ec_sensor_temp_t_sensor_2] =
+		EC_SENSOR("T_Sensor 2", hwmon_temp, 1, 0x01, 0x05),
 	[ec_sensor_temp_vrm] = EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x33),
 	[ec_sensor_fan_cpu_opt] =
 		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
@@ -593,6 +595,13 @@ static const struct ec_board_info board_info_strix_z790_e_gaming_wifi_ii = {
 	.family = family_intel_700_series,
 };
 
+static const struct ec_board_info board_info_strix_z790_i_gaming_wifi = {
+	.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_T_SENSOR_2 |
+		SENSOR_TEMP_VRM,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_SB_PC00_LPCB_SIO1_MUT0,
+	.family = family_intel_700_series,
+};
+
 static const struct ec_board_info board_info_zenith_ii_extreme = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
 		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
@@ -689,6 +698,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_strix_z690_a_gaming_wifi_d4),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z790-E GAMING WIFI II",
 					&board_info_strix_z790_e_gaming_wifi_ii),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z790-I GAMING WIFI",
+					&board_info_strix_z790_i_gaming_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME",
 					&board_info_zenith_ii_extreme),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME ALPHA",
-- 
2.50.1


