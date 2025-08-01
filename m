Return-Path: <linux-kernel+bounces-753782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3F6B187E1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99B9AA5580
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4959B28D8F3;
	Fri,  1 Aug 2025 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgT5Tbmk"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C211F5EA;
	Fri,  1 Aug 2025 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754077834; cv=none; b=ilVWV0WDuPGVz8exSzSfNuonQYKebVta+OD1lQFdp9JBY+uL1idmgsWB+y/WV8p4OdMDS9MY5ubXneUqc5M50hvCY4GIHiopO8+8eI4OSSnPLJIw73xTXNXx0gnpntDOXfmBh25Csl6cXTWtvZuyEWDZabGyXDOZ002lJEaYpls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754077834; c=relaxed/simple;
	bh=TxwqeLiyxrFmCex1fQNYnnsdY4bbWS538k8UsVmmPzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cm8YSbuCSooi3KcjoCi54M57Ye69AkR6c8GRe5qnt2/kZghRKCH+VEqOaBsEpgYAyzxkD0KxY0et3WFVUt3kafnvQMA1wFfTLRNvGU/NjRi0uJ93JBlfpJ+NOHp1YWOGCKUKZ3ZUJFsdjH1v860eYz7RFm5NuccYwTLcFof3yfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgT5Tbmk; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0c571f137so490386466b.0;
        Fri, 01 Aug 2025 12:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754077831; x=1754682631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bfjnsGeGtjnwVQ/SY06BSOuewn04OC/WC0iFfe0ne20=;
        b=OgT5TbmkWaXG0LVif5av+zeKsQpWQk95f18g4k76A/U/7J31Gy+C1Jq6xS31EIZkdP
         aOMuYBrXRDtPJZy7EsghhBgQXa3/Qlo/5V6tN4rD9Yj89dKqd+G72DneR8AOJi+A7exd
         EcY16FQ3GNF9jZ25CWAe1qPYHwfbQlmDZcxtyKW6Hs8ZPPGI7B10Ecxh8OGbMIRB6Prb
         qw4qEhih/L2ExZp3g9UadWJAd65i2A7n0qLVxlbITeQWVcxAkU0VdH1Z+1oV/ehEVkhp
         WWbDr4H6XgfqQP27KE/d738sJYjqtv8NSXMcgnPPwdtbBBEemDGQGdaUOqjW72oW46aj
         xBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754077831; x=1754682631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bfjnsGeGtjnwVQ/SY06BSOuewn04OC/WC0iFfe0ne20=;
        b=MuKqyEIHK+pTHUQRLI5GbO3vb92hZhVu1YnFiUZ8mH1X9z1KrJ+SXKSr6kXXYPnIat
         Salnq0Jbl11EyxaWoASqRS6xsrHeiSEp7nB/hBDQjYCd25y0izVRMyF8jGXcaBpGPfM8
         W4Cr5rsSPnbED79EnZVjbMnZYIh2izXxivxZvOfYSRI0gsMMKl4yttdpVSvqozYvZ2ei
         KDGSxOuOzgnG+SG2fZKOTST9KlSITsFq5LGsdGBJQbIp8SisofVvYZzoz9OLZGDLt/dH
         BztDvYBu1oSNaYPDkQ9Y9qNVng7NVUmQsxjdfykBVUs3BeA39z7j1KET9txyfesb9cfD
         SW1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZQ3E2Sz3+DkpP8uKcpFhsvkN0bK9L2JXYdnJrPKw/kAUiEKnQYqquy2V1g34k0swxUUzB2ZR6gRI=@vger.kernel.org, AJvYcCVN0HeS2hpYuFnV4qAbVDzv0ZquuvMJ5H4wrpyROlxL4HXlkEkwDoaAOvW0k+fuLS44RIa4OnY+LX28j4m0@vger.kernel.org, AJvYcCW7vhYzPPn/9cxgcmqDAaiqJkWAKcVGfY4pTI324+sntJfWUUUn9wYgg5sK7TjTnGJyz5nLDTKbIyGAr4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSzAFmjmi6tMoAKHPAFdMM7wrH9mlQHGaSADHNa8VzGw+aDT/4
	J21C9njD1rDrLOhc9lGidF5WYG0JR/G/o2HMt2EZOjaW76nzFPXtu+fb
X-Gm-Gg: ASbGnctLB63m68l5OB+76jtS6EFmBBHl8Z/u33Ufpi1Sh9i7JQJsFY2gX370B/EL9mx
	lsmiVwAfm5xpFqAGnte5suXB9faAkmvB1ZbI2AM0dSs8Ejx+tFjmcDkQaU4XpvCW1lH0eZs5SsN
	Mf4mVrcLmhLUvgibtlahLxGL6ccfs1i/L2oVu7BAELuYJ3j61u84hyJJUx2VbepVqrh11gr9DDX
	9uGLXHrqRajCs8SrOoC2MkWQjMFoz6VRx/5SuGTpWNncMKcx5mnczKX7FnNqMp3H5Vq4u8V23JT
	vKZjuXJBNykOvz9QVvhQNpfmA6M01UuEvLJPgJc233lzkgVqNpkJlylmiVW8I2NmyD1GEUSMeB5
	Qflm1i4CT3M9eelohpuPcM9rEftN56jgiGrvRcgMDf2rHcwUoigIF41nljqmjtpu4xrseQk6dyD
	Q4HiejTB22VIgJI+SpibdTSgGb
X-Google-Smtp-Source: AGHT+IEFbCVP+IOT4HMvDVcw9I91CdbWhFf4pBenc7P1eqGHowAvS2x6fVTXuGhq+dqDEy07KvCXzQ==
X-Received: by 2002:a17:907:7f05:b0:ad8:9257:573a with SMTP id a640c23a62f3a-af93ffcc3bbmr123416366b.5.1754077830932;
        Fri, 01 Aug 2025 12:50:30 -0700 (PDT)
Received: from puma.museclub.art (p200300cf9f013400cc194b80e1760d4a.dip0.t-ipconnect.de. [2003:cf:9f01:3400:cc19:4b80:e176:d4a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a23fec4sm327375666b.121.2025.08.01.12.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 12:50:30 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: =?UTF-8?q?Runar=20Gr=C3=B8n=C3=A5s?= <noizez@me.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) add X670E-I GAMING WIFI
Date: Fri,  1 Aug 2025 21:50:08 +0200
Message-ID: <20250801195020.11106-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Runar Grønås <noizez@me.com>

Add support for ROG STRIX X670E-I GAMING WIFI

Signed-off-by: Runar Grønås <noizez@me.com>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst | 1 +
 drivers/hwmon/asus-ec-sensors.c         | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index da9a00111d1c..49f6cac63d19 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -31,6 +31,7 @@ Supported boards:
  * ROG STRIX X570-E GAMING WIFI II
  * ROG STRIX X570-F GAMING
  * ROG STRIX X570-I GAMING
+ * ROG STRIX X670E-I GAMING WIFI
  * ROG STRIX Z390-F GAMING
  * ROG STRIX Z490-F GAMING
  * ROG STRIX Z690-A GAMING WIFI D4
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index b9543eda2522..33c5fcb0a09e 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -553,6 +553,13 @@ static const struct ec_board_info board_info_strix_x570_i_gaming = {
 	.family = family_amd_500_series,
 };
 
+static const struct ec_board_info board_info_strix_x670e_i_gaming_wifi = {
+	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
+			SENSOR_TEMP_MB | SENSOR_TEMP_VRM,
+	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
+	.family = family_amd_600_series,
+};
+
 static const struct ec_board_info board_info_strix_z390_f_gaming = {
 	.sensors = SENSOR_TEMP_CHIPSET | SENSOR_TEMP_VRM |
 		SENSOR_TEMP_T_SENSOR |
@@ -672,6 +679,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_strix_x570_f_gaming),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X570-I GAMING",
 					&board_info_strix_x570_i_gaming),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X670E-I GAMING WIFI",
+					&board_info_strix_x670e_i_gaming_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z390-F GAMING",
 					&board_info_strix_z390_f_gaming),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z490-F GAMING",
-- 
2.50.1


