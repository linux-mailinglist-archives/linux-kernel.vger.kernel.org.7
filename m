Return-Path: <linux-kernel+bounces-888264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8092FC3A59C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A33E3AD094
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF662E7F02;
	Thu,  6 Nov 2025 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPC8C40F"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C892BE7DD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762425959; cv=none; b=ILTIkmdIQdcWsj40KSI2IJEDTTNNAQDpPX2woz1uG1PiKmNzr17zTwd3Q47tapKDTTpRSn63mlq8mkR1LZqODUU0RVMLRu5diDJY+bEQi8nRv+SO2HyW4gcW4PglYOpaz6d4iiOiVy2rB0AuEZOoaAABjDZC4XG3m2mFze0KPC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762425959; c=relaxed/simple;
	bh=j1+M3emMe9tqmPSbKCgIoXD49IQZIb4FHliGCLpUH2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=E1ArrFwooOPROoAAfQnsHgr1S75cxaCr/3h68/OXqtqFP8zcltM/CpHyx9V65gg5Rlqj7pOVv2R+D7fWdAYxUznvow0d+kao2Xi2rNQew0gCVlx3E33cZEL923oPalCMB4Myoll3lB5B9LIGOsRKDqNcaOI617/mmhboGEU+7dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPC8C40F; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-341d07c020fso750607a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 02:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762425957; x=1763030757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bU7AjJowjDZcDckJUJRmtF/yOybguMZZsthXphjlG7M=;
        b=dPC8C40FSF/2NU67d8uEdc/lJIsnEun9IWGqKUw3aMl2FucG7j8kNYX1dtolirV9Py
         oEzWU6dYkAkiuduU3A0VtR5YQjqEuWi/I9A+Cnlsp8v1JB9QYlAanhCl7XvmgNm8YIPT
         OfH+dQXcFv4gLiGaz5HgT45Ut6z3UddYUxzX13MSPNgAqpmEb6HiKFfAex9Uk3Q+DHyL
         kVzMkIxUzXIzcUqbN1n1tJ3UauIcj0YALBZmvi5rTImpETp+k4zJjSh/wjDM+Y1Xw0ZL
         a30Hrp7/Ek8Z14RSDBQedZStuA7vEv1juObUfZGbAowxbqYGP2ND3CrC/GTd5B5kgilg
         D9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762425957; x=1763030757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bU7AjJowjDZcDckJUJRmtF/yOybguMZZsthXphjlG7M=;
        b=QlMOlihXrIQ6+3ruKA5B4daqJtn4gw8FuS7mEXaxwwR2W3xgHSHz6n4ez23AZnyyz0
         8eLiVYQhBoKiRsD2mr+xg1peJ3EacurAHq/h7O5TgAZj730DwTfSTDwXZd2wNiE4hSIZ
         VJc7HuhPOIEBgAh0NW+E/ILcMIl8///gquG7FhohGmKCokVLkwwcHVkv/sUXjyQTqHxu
         pNKY/ygBiery9rlAdIQOPJwSFHY+C+Mz88/B5QCAfYvVB3559nZnAD2LH97vuHSCYNbK
         UYMrR9dX0Zv23oMNlpmBvDJ36x20inPX/FT4UxBLGewEv+2ELb//fVpzQsms4doAaiFZ
         zMaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyJswb7EPqVIyuJPQ/bliHNrgKDjaXMpJ7NXxWSKuf6bJDSEgt0zd401K+eSH8voYWqIn0qrfeJ8yea5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcJJplUcrLUOExP5A6q+QBBo+xWEV84IxcAO1vGeZpLUIVI/CK
	t8TXfBGl6I/nLtjLmxN46pxCwAzFRWBCuB0wPr1mfYm42hfwY3NN2CqA
X-Gm-Gg: ASbGncuoqrNjnd5fGSm9xJMaEunqn3v3NkzD77W3QrXlfdTUNqRZ8gEDsXSg6tV23Bw
	ASBsL4oQ3sXcBygS1iIcR8GwI9OcTxQNbhHCZv4naaRL0gn5HDJyUiugqKeJJ7u1GyI8bK2+LYy
	Vl+eOjizgBjWwh3s4jY4UOW7q1F5T4TDhWukodMQqrssEX0dHg3HvUlmbCu9PNrC8+YK+26gj4k
	wsXk+hV1lat7m9Hmq9A1fDjszXxXuyLSGCFNWRQjoJESvXA1r7lQOjtUI586witkwr71dxscEDc
	yFwRxEsrbA8rU76I4FNuosLKYcA9dXWQj3QyVxjymOHW04xS5JQnqNtcxqumYhFgt4FOjHtgk0r
	iUNN2BG9saHlNlJRutwb9xiOMQAw+QEMeadUZqMjIbHbxnwH3GoDHjYfwQawuPcNBsmzQwtsAWH
	MZc+EvuQ/mgreMT+QTcQa7oPQM46gsJxhhI6FklduHTjid9OHBy7xSbWhdnRUiq8P0IrgWEZw=
X-Google-Smtp-Source: AGHT+IGYrXhINDrTOE+vTAyq/Tkw8JbEf+DgYAklG0E/QFs01OgyfTt1FyK/cKOnyNVyajgOy73KAg==
X-Received: by 2002:a17:902:dad1:b0:295:8da5:c634 with SMTP id d9443c01a7336-2962ad835bemr73847405ad.9.1762425956833;
        Thu, 06 Nov 2025 02:45:56 -0800 (PST)
Received: from JF.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5c72esm24199615ad.33.2025.11.06.02.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 02:45:56 -0800 (PST)
From: Jeff Lin <jefflin994697@gmail.com>
To: jdelvare@suse.com,
	linux@roeck-us.net
Cc: Mariel.Tinaco@analog.com,
	andriy.shevchenko@linux.intel.com,
	cedricjustine.encarnacion@analog.com,
	chiang.brian@inventec.com,
	grantpeltier93@gmail.com,
	gregkh@linuxfoundation.org,
	jbrunet@baylibre.com,
	johnerasmusmari.geronimo@analog.com,
	kimseer.paller@analog.com,
	krzysztof.kozlowski@linaro.org,
	leo.yang.sy0@gmail.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ninad@linux.ibm.com,
	nuno.sa@analog.com,
	peterz@infradead.org,
	thorsten.blum@linux.dev,
	tzungbi@kernel.org,
	william@wkennington.com,
	Jeff Lin <jefflin994697@gmail.com>
Subject: [PATCH v2] drivers/hwmon/pmbus: Add support for raa229141 in isl68137
Date: Thu,  6 Nov 2025 18:45:19 +0800
Message-Id: <20251106104519.2014853-1-jefflin994697@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The RAA229141A is a digital dual output multiphase (X+Y ≤ 12) PWM
controller designed to be compliant with Intel VR13, VR13.HC, VR14 and
VR14.Cloud specifications, targeting VCORE and auxiliary rails.

The RAA229141A supports the Intel SVID interface along with PMBus V1.3
specifications, making it ideal for controlling the microprocessor core and
system rails in Intel VR13, VR13.HC, VR14 and VR14.Cloud platforms.

Signed-off-by: Jeff Lin <jefflin994697@gmail.com>
---
v1 -> v2:
- Modify subject and description for the requirements
- Remove CONFIG_SENSORS_RAA229141 in Kconfig
- Remove the part for multifunction pin in v1 patchset
- Rename function raa_dmpvr2_2rail_isys to raa_dmpvr2_2rail_pmbus
- Link to v1: https://lore.kernel.org/all/20250926014552.1625950-1-jefflin994697@gmail.com/
---
 Documentation/hwmon/isl68137.rst | 10 ++++++++++
 drivers/hwmon/pmbus/isl68137.c   | 14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/hwmon/isl68137.rst b/Documentation/hwmon/isl68137.rst
index 5bc029c98383..e77f582c2850 100644
--- a/Documentation/hwmon/isl68137.rst
+++ b/Documentation/hwmon/isl68137.rst
@@ -414,6 +414,16 @@ Supported chips:
 
       Publicly available (after August 2020 launch) at the Renesas website
 
+  * Renesas RAA229141
+
+    Prefix: 'raa229141'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Provided by Renesas upon request and NDA
+
 Authors:
       - Maxim Sloyko <maxims@google.com>
       - Robert Lippert <rlippert@google.com>
diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
index 6bba9b50c51b..97b61836f53a 100644
--- a/drivers/hwmon/pmbus/isl68137.c
+++ b/drivers/hwmon/pmbus/isl68137.c
@@ -65,6 +65,7 @@ enum chips {
 	raa228246,
 	raa229001,
 	raa229004,
+	raa229141,
 	raa229621,
 };
 
@@ -73,6 +74,7 @@ enum variants {
 	raa_dmpvr2_1rail,
 	raa_dmpvr2_2rail,
 	raa_dmpvr2_2rail_nontc,
+	raa_dmpvr2_2rail_pmbus,
 	raa_dmpvr2_3rail,
 	raa_dmpvr2_hv,
 };
@@ -399,6 +401,17 @@ static int isl68137_probe(struct i2c_client *client)
 		info->read_word_data = raa_dmpvr2_read_word_data;
 		info->write_word_data = raa_dmpvr2_write_word_data;
 		break;
+	case raa_dmpvr2_2rail_pmbus:
+		info->format[PSC_VOLTAGE_IN] = linear,
+		info->format[PSC_VOLTAGE_OUT] = linear,
+		info->format[PSC_CURRENT_IN] = linear;
+		info->format[PSC_CURRENT_OUT] = linear;
+		info->format[PSC_POWER] = linear;
+		info->format[PSC_TEMPERATURE] = linear;
+		info->pages = 2;
+		info->read_word_data = raa_dmpvr2_read_word_data;
+		info->write_word_data = raa_dmpvr2_write_word_data;
+		break;
 	case raa_dmpvr2_3rail:
 		info->read_word_data = raa_dmpvr2_read_word_data;
 		info->write_word_data = raa_dmpvr2_write_word_data;
@@ -469,6 +482,7 @@ static const struct i2c_device_id raa_dmpvr_id[] = {
 	{"raa228246", raa_dmpvr2_2rail_nontc},
 	{"raa229001", raa_dmpvr2_2rail},
 	{"raa229004", raa_dmpvr2_2rail},
+	{"raa229141", raa_dmpvr2_2rail_pmbus},
 	{"raa229621", raa_dmpvr2_2rail},
 	{}
 };
-- 
2.34.1


