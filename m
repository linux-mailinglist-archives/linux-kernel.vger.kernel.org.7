Return-Path: <linux-kernel+bounces-748608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5936B14391
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 997287AFF76
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E3B264F8A;
	Mon, 28 Jul 2025 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InJFsI3b"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6221A426;
	Mon, 28 Jul 2025 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753735907; cv=none; b=uDP9d1L9yMDdVCLgtcDKeJ+Aj7PYNprgShQe7aKsRHrx374w28gEwjEZ+rfrNxrc7mkIDKoRWZONbdSdMr+yqLnLx3DcGBCBBBxlnocAriGgZb4F2FpOtscssp9RUorESmp3l1aHjvm6y2VCVJaa2heTJu7Vg4enxClqjuyHDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753735907; c=relaxed/simple;
	bh=9L1XalRIwPPWVSXh0tYj9s5F0OwNFltZN/dz0j+HKIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWWCbe6XmVjB/Om9PLFPXjbmL2IJ5Vk+qJyPLLno9ejj8yetYSNt1QUCTBiXdyAaoxaZ3lQZlJMJ5GrwtSTym4DMBC1V7GMPxDX1B20aD1WNBQhtWH0ANg+zjdihNbpLRE4B4Gzw45lff8lf48bJkGm//FaXvNVZaOEiFV2amUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InJFsI3b; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0de1c378fso693174066b.3;
        Mon, 28 Jul 2025 13:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753735903; x=1754340703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2n3mYAWKTyQ8yEUXtVLCIx2eOMrLWHpx6qhNv4HBuKs=;
        b=InJFsI3bHrTnhjZLfW/UnaIznTPj6FKhOwxWJLnIn4UTbZ+GgDtpDj0fayq1IoyngU
         FtciEzM9amZg4q5yAlf1pIBnAP8RVXgxgGK5BTcmLt2Bl77wnV2syIqa9MZq2aiigh1g
         EI3XmclbMtcHyYGRUlEenmMLgvcBwUO4vPQKnzzwQ588ax4fbIWSV9MT2ilRZ18KXe+5
         Rb8U/T7jQaszv695yFJJZnPywmxxjueL7sqBZFOiOzT0yvQCZBvBldrlyD0ksO7k56RR
         hkfNuUQvoQsLHcxqlZhebXvrIcn0BSY+oy8GJ2AfgDf5RcSTOO4c2MX9wvuaSdoBfQL3
         Yq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753735903; x=1754340703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2n3mYAWKTyQ8yEUXtVLCIx2eOMrLWHpx6qhNv4HBuKs=;
        b=j5qOFHMZQ8yqSN/Pai2fpgZKhF+iQGp9CZ1paq1xbqSy/X3sT0iyM4R0Z1A8HSksRF
         BmpX3o4zg7aM+oAk7PlyG1BrFxDqTaM58wUNneNtkNHp1wBGmHDqAvtorVxQLuzCUtXJ
         ak32GdSfQyafGiwf/BOnp+oPde1C7Iw9vOcH/knqqhTWfrRTrG3EoSA7WalvuktYSkli
         AaZf0xTDk4kSSfBolE3k9nAMxQ8xJuoqnr6z/5hsFqGQKt5d+yV3hiJlU9ba+68wT2Yr
         1jdzAiQiEdBxuDQtzgngxTXk0b4hdAnvvUomhPfGvJzqUEwiVNdGkgpoluje3+6W6XDG
         w1WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgrctbckh3qUlgjBQDCKaj5qpxZ/ScGqvZz9iNTGU7iP389luX7shWFlMkyiuXhLs4J4AjMLonAfbLGWs=@vger.kernel.org, AJvYcCVq60b0Yz+6jijKYUdhCb6EPTEF2Wq8skErd/2iaapKl6hDLcDGUsqw0GgdFRHidzGCXmH11o1UXqk=@vger.kernel.org, AJvYcCWA0tloH8hwwQX8lxLKnGVA6KPWZhVzbw5DivLJeaWzYq7/g1ZhlFr/y0Gd+luQJX7CbcJN7xczF27g4Tns@vger.kernel.org
X-Gm-Message-State: AOJu0YwfrACmzTyPexTYxSMCrxc4RR0v6ymhW4zO+N1WCPi3X++a7zJb
	a8vswnzTlgnWWa3HtuaSHYZ3WRf6xlN42dluqFU2WDPfiHwBIj2kD5sSkKkcdebyGdA=
X-Gm-Gg: ASbGnct48lsG/v+rOJ/9DEiNwSQ7gzBi5nKBoKLUrVTr0bndsa26yUcIn3RysOzqmN0
	xBek8eH+shmNsLaH4ld/BvlC9L6xoEdi/foWYjIVAyWKWqHl/5iwq19PJMPQEJz1eMy1eUhEAqi
	Fg6WriNoJaEjLKF68WpMUExDN9u417AeFtp0kY8EmZ4T2FOTTJskWHVPZv/ouJWZTSQlFsw44j0
	GBZ9qxqnE7kZDBro0EcbybKOSL3o+yAoJ1jQ19ObMrvGdvd6SqMQeaKVAhd17Ac8KITZKYGOv0T
	oAseOatTLhNwGBsNKwm3FpdhY2KrHvm7wEZ1cUK6/HJib7LETyxOscQYWyL2dHUraydos0aShr8
	sOiKprFY9n1v9EZO1naHtjjBaaApTnYvdkVY75FcLoohIzvcJCf7x/3AY94D50fWfo12pHjZ11S
	cFQO63yPzCRkf15qI1XHPOcsQ=
X-Google-Smtp-Source: AGHT+IFZmXqxmZJeF8WAaJ0gHWuPHpfzsCzW5wwMIhD6skNykBWilzJPJa53zA9vqdBFV0a+87Sy/Q==
X-Received: by 2002:a17:907:6d1b:b0:aec:609f:6359 with SMTP id a640c23a62f3a-af61dd5256emr1322831466b.60.1753735903251;
        Mon, 28 Jul 2025 13:51:43 -0700 (PDT)
Received: from puma.museclub.art (p200300cf9f013400cc194b80e1760d4a.dip0.t-ipconnect.de. [2003:cf:9f01:3400:cc19:4b80:e176:d4a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635ad589csm469943066b.118.2025.07.28.13.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:51:42 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Lucas Yunkyu Lee <lucas@yklcs.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] hwmon: (asus-ec-sensors) add STRIX B850-I GAMING WIFI
Date: Mon, 28 Jul 2025 22:49:08 +0200
Message-ID: <20250728205133.15487-2-eugene.shalygin@gmail.com>
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

From: Lucas Yunkyu Lee <lucas@yklcs.com>

Adds support for the STRIX B850-I GAMING WIFI

Signed-off-by: Lucas Yunkyu Lee <lucas@yklcs.com>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst | 1 +
 drivers/hwmon/asus-ec-sensors.c         | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index de2f2985f06f..558755f9fdd5 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -25,6 +25,7 @@ Supported boards:
  * ROG MAXIMUS Z690 FORMULA
  * ROG STRIX B550-E GAMING
  * ROG STRIX B550-I GAMING
+ * ROG STRIX B850-I GAMING WIFI
  * ROG STRIX X570-E GAMING
  * ROG STRIX X570-E GAMING WIFI II
  * ROG STRIX X570-F GAMING
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 4ac554731e98..4d8b887b8a55 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -495,6 +495,13 @@ static const struct ec_board_info board_info_strix_b550_i_gaming = {
 	.family = family_amd_500_series,
 };
 
+static const struct ec_board_info board_info_strix_b850_i_gaming_wifi = {
+	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
+		SENSOR_TEMP_MB | SENSOR_TEMP_VRM,
+	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
+	.family = family_amd_800_series,
+};
+
 static const struct ec_board_info board_info_strix_x570_e_gaming = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
 		SENSOR_TEMP_T_SENSOR |
@@ -628,6 +635,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_strix_b550_e_gaming),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-I GAMING",
 					&board_info_strix_b550_i_gaming),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B850-I GAMING WIFI",
+					&board_info_strix_b850_i_gaming_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X570-E GAMING",
 					&board_info_strix_x570_e_gaming),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X570-E GAMING WIFI II",
-- 
2.50.1


