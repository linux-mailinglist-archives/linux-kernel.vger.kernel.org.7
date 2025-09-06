Return-Path: <linux-kernel+bounces-804369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0B7B473F0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2311B7A8B87
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076782472B6;
	Sat,  6 Sep 2025 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9mx4lZ9"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81A8221DB5;
	Sat,  6 Sep 2025 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757175475; cv=none; b=ExdxHuZhQIWGs7aIdEYG1wD5HrddXGgQu+uEqGOTYcZxA/6VvhtNO518yaZGRe7xXYadA/VIPRuenH2r0baRJFdRxGSmUznvLffTz58Ycr0HdNwp8Gttf2zasYr/a7GnAPhuiL8U20xRuAR5+tRbNzVMix17xphcUAf8KtxIn8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757175475; c=relaxed/simple;
	bh=nMnk5F8OH6/wiRW0/mH/UflH4IDMAJyb8QrYKxIEKPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YB+LvJH86R6Q9ITXA+tOCg8PdQg8tSPC81cjapejGugHTXseFHgWMYDwTOWqoarUgg6crh21z8qgX7Rxn8omqosgpu5en5R6+MB9liNo9QIdu0WHF8KRHOQ+4wMORfrYT31N1ZFBmZEwBccwOjjLHrnulrBJUko9wGUtp0n+6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9mx4lZ9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b046fc9f359so586945466b.0;
        Sat, 06 Sep 2025 09:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757175472; x=1757780272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PHYzPGzEQyIok4BBwUy01gZVfQJMItWgnzXRkCk+QwE=;
        b=L9mx4lZ9eIPq56LmqZYa4oY0QN258Zd/whZjlQLH0un0CJOngjmr7X487bftGZ/vce
         QdiFeCXOj8Z/GjdooeXiCzRbxs9mCEH4VdTez3g5/eSxrodt1nw035q9VMiuK1U0oiwk
         ghdqjAqf6qqQRl31QAFPMzp4y7o3iLxc/4ZGAVlv1lQDWfLTeaQp5rJLiPXJpwS3XnMY
         RaXUByP9YUjtS3psKyTa+Uabf7/dlG8IEVzKhWyXnnRBL6IBDQUqs8S9Ke/dThr4H4Xg
         2lktvnNc8t5+IL0wQVMaBC2Bq0adcUMjFC1DyExnxwvoROSbkHCrM750w8dx6p4wLRZo
         rtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757175472; x=1757780272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHYzPGzEQyIok4BBwUy01gZVfQJMItWgnzXRkCk+QwE=;
        b=om/W3SjvTZHZv1dGX7mflkkIpLDbvtIl5FZfgdN2odfVDQM4njq3KCQ6cqJGSxft+F
         rQrwQG9eI0CHfq4VALnGi/VzPD9xIVwpibBDNzhKH0RoYblVwLyaFAQEYO4QBneEXeMi
         7kUTtQ2HCheRJMyZ1Zt3kvvYP5ZcInhQx8RrWaypYYp8dGOZwgzAvsZPLzw4uXqSUxOQ
         ozxqTx8VK37NTSMhTO8NEddoy7LYB4Smv9NWUaolgJJV91B8HTjGOXWj3Ty8KrBufA6/
         V6MisOELSu/vyOR+Z7b3cF97T1HJTer+CHDGxQwf4z21z3OY0CCJxbsQRsmdjY3Es0BA
         SM8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZVBJgp+zYEtZpx7/WDz3+aRiebMVqw3UL9t2unIp7BxvrjDIjoOzPCUHJnZ+RN2+PRMUaS65Z5BA=@vger.kernel.org, AJvYcCXlfRVcpkN8l98PYDygCDtWoP98Q7uVv328K1YHe/jgFJ2MbORBlKREc81TbZWPkbF9XRl3FakxptBC5Mw=@vger.kernel.org, AJvYcCXn3cvxxo8Jk+y8pSbhiUbKVkzNhEJk0C8vKweWcz0VYWqqylpN6S5tPNmNKlXR5QGKlzBwedoym7XrhdMI@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg4Bl6J66YcEtnGHyLWlsx7MTOQ+dans9Mqtyp9XJhohOWP2Pb
	zEsHiCK883SwoafJbODqPLPgRY+c2rHb15zePjoKY0/dyW3tbezbB+yA
X-Gm-Gg: ASbGncufeU43xOYO0HzyEqPDmHKh9mZbyfjQdakSk2HFrcAVrdF/ueKpYP5xrLDINVs
	MrluF059NF16vd7Up4iHIvywZa0TkWhTXRRIrIW1PkivqXRs3c0pjvCUIdKgpYw9mF9k0KO03Jz
	5TVOJ2N9hjU0W79jINk15a7UVcWojpaCzPS6jq0YaocK3Qyd22QU5GqIQcum1k0FYrTKhWu0TNg
	zvfVqWA9+R1OkgMnXFDfrMo9Gr/XdkOCdENPSjhEkerJ73rI1DaHT1neLbfF/4HJ56tov3OKz5O
	16qtb7Sde+OtaUEgnFlrGS5HYOlOol9nS5GHfhEdbivNMTS6F7OpjWH0ZdZItFarqBKM96OYNp/
	GC0bfEBVSWO/4hoMxSEWhD8w1CA5Eo22J3EfUx4cBxLA=
X-Google-Smtp-Source: AGHT+IF9n8qLsSkF2n1WH2/YbYqIpHuWGkS8V9yMYPfF6CuoWVza+3hNtdPTgvqrDhz6YVsydJHudg==
X-Received: by 2002:a17:907:9705:b0:b04:5e64:d7ce with SMTP id a640c23a62f3a-b04b1542fdemr228167066b.35.1757175471809;
        Sat, 06 Sep 2025 09:17:51 -0700 (PDT)
Received: from puma.museclub.art ([2a00:6020:b3ea:9c00:26e7:b56a:5a2d:1d72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0307435422sm1820465966b.78.2025.09.06.09.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 09:17:51 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Maciej Zonski <me@zonni.pl>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) add ROG STRIX X870-I GAMING WIFI
Date: Sat,  6 Sep 2025 18:17:37 +0200
Message-ID: <20250906161748.219567-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Zonski <me@zonni.pl>

Add support for ROG STRIX X870-I GAMING WIFI

Signed-off-by: Maciej Zonski <me@zonni.pl>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst | 1 +
 drivers/hwmon/asus-ec-sensors.c         | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index baf9eba5957c..6a9c5f30e016 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -34,6 +34,7 @@ Supported boards:
  * ROG STRIX X570-F GAMING
  * ROG STRIX X570-I GAMING
  * ROG STRIX X670E-I GAMING WIFI
+ * ROG STRIX X870-I GAMING WIFI
  * ROG STRIX Z390-F GAMING
  * ROG STRIX Z490-F GAMING
  * ROG STRIX Z690-A GAMING WIFI D4
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index f580ff2e212f..32d4dd26aa84 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -621,6 +621,13 @@ static const struct ec_board_info board_info_strix_x670e_i_gaming_wifi = {
 	.family = family_amd_600_series,
 };
 
+static const struct ec_board_info board_info_strix_x870_i_gaming_wifi = {
+	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
+		SENSOR_TEMP_MB | SENSOR_TEMP_VRM,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_SB_PCI0_SBRG_SIO1_MUT0,
+	.family = family_amd_800_series,
+};
+
 static const struct ec_board_info board_info_strix_z390_f_gaming = {
 	.sensors = SENSOR_TEMP_CHIPSET | SENSOR_TEMP_VRM |
 		SENSOR_TEMP_T_SENSOR |
@@ -759,6 +766,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_strix_x570_i_gaming),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X670E-I GAMING WIFI",
 					&board_info_strix_x670e_i_gaming_wifi),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X870-I GAMING WIFI",
+					&board_info_strix_x870_i_gaming_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z390-F GAMING",
 					&board_info_strix_z390_f_gaming),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z490-F GAMING",
-- 
2.51.0


