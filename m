Return-Path: <linux-kernel+bounces-815490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10597B56738
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 09:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE62917EFD4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 07:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9F9220F5C;
	Sun, 14 Sep 2025 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2s6XjVD"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B729021257B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757835698; cv=none; b=Ix8x4PRgMTXjavWwKZj+4m0ntWm5ZsNs87eXRUSeE9ZlxR8aWIgLWqeeE87MKY7zmq4P4P6hhEFUCl5+u2Cm2nhoA1UHAyqJ/RHAzO1U571MI2era2luP5ZRW8BNt51QqvsY3K9jCFcX6VxP32q1iwBmf1lBvz7SWkJiahsDiUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757835698; c=relaxed/simple;
	bh=pmQMhinXOhrMn7twXeioOkcACZnshftCDLBST5UA2PM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PF1R+/pfq/mkrl/mk+yH6hdRQFhj33MIloPkFwsVPIEkD5Xw6u2VkCEd/fLos3+rIvv4DbA1E7ObiLlDkk6O3nxMuzxUBKrGQ04D9JpDVRhqYRwSB28wrTCj+8U+HdDBl7kGqBmyYA35skmlzCkWvTWKhlhuqxBIUAQbMeS4+TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2s6XjVD; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so5140223a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 00:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757835695; x=1758440495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nVz0/HlF5BDemuRDpr/RdeWre5VSdXxEH0yfhTNk8c8=;
        b=h2s6XjVDG8ESFF4BN2Y0WoCpxUxuhCPWc5yiZtIjAYPim5ltN0OfYKsHkon//iklmU
         aIZg1EIXrvsYK5HxtcE8Ms9uUECdoPSqrAzwXJ7TVYvq54yOFDC/9VSF7fXvwdi6fvDT
         5ZRNRfE8UFReeyMrdV26wIgwck/w5WSESf7L4/qE2144EP8FMEFOfneZUXO1GWtDHhfN
         Y+Ub4I3qMVzYAqecTBodbNuzSGxQDHk4+pZrX9xTH3He8uAXFuqPOyLWJWc7aFJPHJcR
         utXvW8qvmGweqEPxNjODSX4pXHmdh76yA6BkmRIg8oCV3VDH+3Wse4bUdqOmz7430490
         EEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757835695; x=1758440495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVz0/HlF5BDemuRDpr/RdeWre5VSdXxEH0yfhTNk8c8=;
        b=KCKmhEu0akM+1j6UNqaaCpNWHjlse+TPpK2w8MvdDxL8jwtmBxv/1W/aomf55rWxLm
         OQGLftFoxhR0iC/wsn8Bq3P89Ti2zndm4zJ1r7eP/A4AgUlbQuuPgG79AAuucADGzGYJ
         9U30BoJJ/udJl6U5vRmuMvVgqoXCXKtxT2AUoJsYWX2PnDiqn4HyQ5y+jc28zpqJ9x/O
         EdbD16JDFl3dxD91oL1bm9rCxmktJekpgwjhyiKDVGEsmhQdioSc+gxGx58QZUzleeig
         hI9wrM9OCXp6kgT4FhU5kbPSbZ91QiJXoeiXmJ3WX4iGsgbGZGVkpXW1N+Hqh0nGVA+5
         inaA==
X-Forwarded-Encrypted: i=1; AJvYcCUJM+KdjRbfZt6OFR+gd2tKS5KSyCGb+xPvBk+bW5dfuRa6UhNAuRkxx3tEMOX1glV/KbAM95QmjQIcbyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmIBRiO2/H+ATluXGrB+SDdSRaqzUfJvlcEN2tO+V6P6PNZ14y
	Cw/2D+qhf1Z89fHyOMptxk6x33S/Gi8XYuCcpDSsYgGzlIzieUlyLtkX
X-Gm-Gg: ASbGncs5GIPPUIgXpQpswMG3UENZUVniyouHrOoNebR/E9sX4WjJvFpI3mtKsAqOP6N
	cfUdIOsPHziB8JFazTQd/8aewu11Szd1Io0LLeOBZG/SUe7gN25hWXzN5e7WzILpbtbCNMD7Ry8
	3uie9rXV/2mECdHhwVH3V85gcY/vZGZ6BHc8urRs4OjJOkhX9LmDOR0MggSDhCLvcq5aA9rxu3N
	lasWuqDftgfUsUUjygC14Ch4aJim8upIyRtJCKQSOIUCB7qqzDksitqofqa0svyE6zuIzJU8ffh
	6eih8mulVhRwkcN165rj18DHK3Fcw3lLbrg6f/3HheWQXLsH2+zBaVLo99I3HRsm2DhiBrUxF6w
	ic0gfFwI/AkihJFdz2HD78WiNqGc4393Zj+pQUzAK1Sg6GoYri0f/JQ==
X-Google-Smtp-Source: AGHT+IGLYz4jfjdFSz+MYmIiQbcg7D/ueOUPZPKysgwUDND7TVCItTEm/+HVOxXfc/JBMcUVkJEbug==
X-Received: by 2002:a05:6402:4559:b0:62b:2899:5b31 with SMTP id 4fb4d7f45d1cf-62ed80b6b91mr7436333a12.5.1757835694751;
        Sun, 14 Sep 2025 00:41:34 -0700 (PDT)
Received: from puma.museclub.art ([2a00:6020:b3ea:9c00:26e7:b56a:5a2d:1d72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33ad741sm6752413a12.21.2025.09.14.00.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 00:41:34 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Shane Fagan <mail@shanefagan.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) add ROG STRIX X670E-E GAMING WIFI
Date: Sun, 14 Sep 2025 09:41:14 +0200
Message-ID: <20250914074125.135656-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shane Fagan <mail@shanefagan.com>

Add support for ROG STRIX X670E-E GAMING WIFI

Signed-off-by: Shane Fagan <mail@shanefagan.com>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst | 1 +
 drivers/hwmon/asus-ec-sensors.c         | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index 6a9c5f30e016..836d41373848 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -33,6 +33,7 @@ Supported boards:
  * ROG STRIX X570-E GAMING WIFI II
  * ROG STRIX X570-F GAMING
  * ROG STRIX X570-I GAMING
+ * ROG STRIX X670E-E GAMING WIFI
  * ROG STRIX X670E-I GAMING WIFI
  * ROG STRIX X870-I GAMING WIFI
  * ROG STRIX Z390-F GAMING
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 32d4dd26aa84..3f6d89bcc8a2 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -614,6 +614,13 @@ static const struct ec_board_info board_info_strix_x570_i_gaming = {
 	.family = family_amd_500_series,
 };
 
+static const struct ec_board_info board_info_strix_x670e_e_gaming_wifi = {
+	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
+		SENSOR_TEMP_MB  | SENSOR_TEMP_VRM,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_SB_PCI0_SBRG_SIO1_MUT0,
+	.family = family_amd_600_series,
+};
+
 static const struct ec_board_info board_info_strix_x670e_i_gaming_wifi = {
 	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
 			SENSOR_TEMP_MB | SENSOR_TEMP_VRM,
@@ -764,6 +771,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_strix_x570_f_gaming),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X570-I GAMING",
 					&board_info_strix_x570_i_gaming),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X670E-E GAMING WIFI",
+					&board_info_strix_x670e_e_gaming_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X670E-I GAMING WIFI",
 					&board_info_strix_x670e_i_gaming_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X870-I GAMING WIFI",
-- 
2.51.0


