Return-Path: <linux-kernel+bounces-881774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AA5C28E4E
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 12:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E48534E439F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 11:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ED02D8DD0;
	Sun,  2 Nov 2025 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhS6ZDlW"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91E12D8DA4
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762083691; cv=none; b=KITnA/r1LlOhTwqEvjOmzGVz7FS9WrOb6UKDU2wPhdmJsGAxe+YaEXkp+Mdlx6RoASGHqM7DJc/dQBYwWLmhYYopTlXvZqeblAc60fRPPZem4AuQYs46uC5/C6zGqSN3QgnmY4JdJLx4ms/NzJpoOxu9PDakoGfI8+7qBf+t59M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762083691; c=relaxed/simple;
	bh=VE04nYBxHQRsPdLjqT4ucuOmSxe8WDwlwIgyAhJMqM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IifUsTFFQv8dRXuATSr8sfeTkLOBxbl2Rw6Sm8icS7UN1B7g8dg76D0ENxAQ7nsmck2/KfrAKNoVzZcfK8P64GYwgYk4+JULQLZOEFZdpWBbhfDY/njQpqnkYazlDGYGxG1rdxH2KBfWO7F0Iv3vwDYNgT8zGMpSAFH04sGVNT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhS6ZDlW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ece1102998so2314544f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 03:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762083687; x=1762688487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CIsrhF8fKl6xpi4S7c5S0dmkUD1dE7woU6dFPC4oses=;
        b=KhS6ZDlWU/qRiK8YDzB7GGYfqqQ2nxJbtF2Un4k5j1bvqJCO+5/TPucUeQcp+93oTQ
         2iSc3K19HnolbTUL27bo04iMopQEQTMmleOgH3peFe9g8kZfzAaEqq/KgkOEp5qPJQ4y
         Dd9/EncN/epgCKPM6Dv2PQtKsmm/9Jmkyo0jAa4bWpCVvWhtKLkqCN+FLMNwlNscYJhU
         KLY+uprwHF6wUn+o8oQDc/BlCU7oz/gK6YbAOdtqBGpsN/ODRLwJWLc2Xbwo2bIwkboB
         TDm9cGxX8uZ/7QulpxCAR3cmQHEhE08tcLRENyNbtvR2uGBC/9c+08a/pM1JtC93i3HW
         y4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762083687; x=1762688487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIsrhF8fKl6xpi4S7c5S0dmkUD1dE7woU6dFPC4oses=;
        b=kgLwZZUrNF3DR7yzNi+OIlOTzkaU1QkgVUN6G0UC/GDhk9Lwewf5dtmDWPfNUxALxQ
         KklOISQfrueYlLgChdmRPQ2Aw7XE2+U2ankIbqjL7yQwnb3VduoJhL6WG1CC+pfwmnva
         WwdrLW1rTbS7sR3CVWYyBo5WVyEmL/Gle2F5ROURB+mIXX03ZfHuZeU7g7J4eynD5cB0
         vlhKXGJpbGxi/rmNK71CBjfEh3rY9Jk8N4KU7e198vBjFQ0sFsfB/TWtnCxIkmAZiC1n
         cAdW0GxZDEjkHTTlcJe48UqdYdGlV/joL+QDgHTv0jiOQZC6874xiobJu6tZUP1AGGJx
         s5rw==
X-Forwarded-Encrypted: i=1; AJvYcCVY1haVYX1CnxQeeZEcXfF1FTsvQ2c9QH9sR+97e+v5HlqQ3qhKdoyXboVm6QvT2GrQ0SZ/L8qdvUjHfWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMyeaPAJU9R++NMXwak67iInWFCpvafYLUE1/XDLixrG7Kj5hf
	m2+JHTShNLMgIjRTB0BEcVGwuLFMKtkK/VBFpP0jXmdih1wc9WujWoOG
X-Gm-Gg: ASbGncvfQCk7RxC3BCtFf/kigJ0RcrPH71ClqmJGgIJU9H/5tK/4wrdtS0ujay7zMoh
	OWflpt4s+fCBC3yNOMQ/X0dwHkEJ8TLOT49ml2l0Zn6RbKoZ+3JmDIRtYpyOYmr6MIbcmVxo4tC
	qDKkKPHbEk64cJ9rUDZiwqMubYQty1cFnGu/1SQN7pE/5x2W4sAElPL0whyHSqFIx2Lx0COYRj7
	ugq+HqZjecAH6dIyYIhmg2qKKGV+sc8epzlzPmuD8H7pVdzTd26YM064aVcuxAUEw2PGKsomjCM
	dk5NbjakUPbCXhHisPCiKdnssZUOY722CWRvAkSYJd0LkYLpc9UyMBNlrvAh/CBIRJxCS0dRBnw
	WdH2uO144yL9TlWl13TWsqvCSx3+w5p38ZdivC0F6RI+Fv9SXhRIsVexdGzmmouw0v4TMmEftwL
	SIERrNNzNg6kEOfZfixQ==
X-Google-Smtp-Source: AGHT+IFAW1GPGUitxzTNuVNXNVuU2PyIJB0/vZWm1b5inLEgfI1x1Obc+/SLssdUjGZyc5c64jbrIg==
X-Received: by 2002:a05:6000:2489:b0:427:608:c660 with SMTP id ffacd0b85a97d-429bd6adc06mr8057538f8f.59.1762083686851;
        Sun, 02 Nov 2025 03:41:26 -0800 (PST)
Received: from puma.museclub.art ([2a00:6020:b326:d300:d19:a765:d8d7:bedc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13f4732sm14138925f8f.43.2025.11.02.03.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 03:41:25 -0800 (PST)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) add ROG STRIX X870-F GAMING WIFI
Date: Sun,  2 Nov 2025 12:40:28 +0100
Message-ID: <20251102114038.283396-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the ROG STRIX X870-F GAMING WIFI board.
Testing done by the board owner [1].

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

[1] https://github.com/zeule/asus-ec-sensors/issues/83
---
 Documentation/hwmon/asus_ec_sensors.rst | 1 +
 drivers/hwmon/asus-ec-sensors.c         | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index 2666ed3a8ea3..f0a92ce30a02 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -36,6 +36,7 @@ Supported boards:
  * ROG STRIX X570-I GAMING
  * ROG STRIX X670E-E GAMING WIFI
  * ROG STRIX X670E-I GAMING WIFI
+ * ROG STRIX X870-F GAMING WIFI
  * ROG STRIX X870-I GAMING WIFI
  * ROG STRIX X870E-E GAMING WIFI
  * ROG STRIX X870E-H GAMING WIFI7
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 7f35eade3a9b..8c5eadd8786d 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -645,6 +645,13 @@ static const struct ec_board_info board_info_strix_x670e_i_gaming_wifi = {
 	.family = family_amd_600_series,
 };
 
+static const struct ec_board_info board_info_strix_x870_f_gaming_wifi = {
+	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
+		SENSOR_TEMP_MB | SENSOR_TEMP_VRM | SENSOR_TEMP_T_SENSOR,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_SB_PCI0_SBRG_SIO1_MUT0,
+	.family = family_amd_800_series,
+};
+
 static const struct ec_board_info board_info_strix_x870_i_gaming_wifi = {
 	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
 		SENSOR_TEMP_MB | SENSOR_TEMP_VRM,
@@ -810,6 +817,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_strix_x670e_e_gaming_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X670E-I GAMING WIFI",
 					&board_info_strix_x670e_i_gaming_wifi),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X870-F GAMING WIFI",
+					&board_info_strix_x870_f_gaming_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X870-I GAMING WIFI",
 					&board_info_strix_x870_i_gaming_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X870E-E GAMING WIFI",
-- 
2.51.2


