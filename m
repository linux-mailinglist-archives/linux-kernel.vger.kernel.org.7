Return-Path: <linux-kernel+bounces-748609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FC8B14392
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C7C541185
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74B5253F03;
	Mon, 28 Jul 2025 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ybr0QFhG"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B5E2343C9;
	Mon, 28 Jul 2025 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753735908; cv=none; b=qaoIH15q5nuHMScNQQIdkBSuwcpT/Ed85b/5dQ9RnzSiXdhALcmZ4wxp0ulox5fFZ7MHnHUxcmG+XyuyhinqcdNFWVcAkV00ihSrMTLopfP2NGCR58iovwM88ZG40BHUoWAZ6UnhU0+aX78TnQU+fChtifDZ/uE5mrjI0uKJQPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753735908; c=relaxed/simple;
	bh=C6l+/DRoI453Mjvmyx5QQpgLaOWzaQMhd9UcAnVWLSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkF7HHXBTafOnkW5GrpSFZdkKN9dis8JHCs149PUw0dMOdh76ORjMnhR06XfYBnQX8Puw6lC4LWVBrQscK8gsGT7k4K6ZPWA4FCB2S8kAcgTQ08xasCKuyTS8iM5ISTsOkF7CqLFdljoXAjo+T45/5LycDy+6W6uTTHdQ9qlFnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ybr0QFhG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae360b6249fso861771666b.1;
        Mon, 28 Jul 2025 13:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753735904; x=1754340704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEqs22eX6pF7StmdQbLsh5nWfaHY4d90/U/HnCwB8Qc=;
        b=Ybr0QFhGsrjRrBsCyuE5kvvUPbfwRWYtVB8p/S6dqkSOG6v6JR87rh73Lb5eEe6xNX
         75XuBKRoawLblNj+1eB3ReRJ52Xnl5e05LftjUQxh3lXIdQpOd11Kz2pgycspJmwNC9P
         eXKAhqY1zqKN0fePZmPpDPW2+zj3/cgEqm+6haKEEK0B+HyczQWg/1AZsVBKoINmCANZ
         jW5SJPPM78MSoPFnKfLzAHftkBnmYutLu+PjXZaN8W/X6Kr07UrJCX2kn1l79cFZaFp1
         LVDxGHzlN72aAezWbGwvskcibxO8OqTgFaQRmXvH5tccFw9UhpZR9Tmr6VQnL9zZitoG
         pbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753735904; x=1754340704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEqs22eX6pF7StmdQbLsh5nWfaHY4d90/U/HnCwB8Qc=;
        b=gRcHuaSXYaxR3+HuIuoJ/6a+LpwnAHv+5rPzuVGrPe96GAZwb1bPAg7ITPwC2KPXEb
         sqdnSapzDw+40rPTUE9T2PDRH9WJtZp0FJPf3Jwx1IRX0e2X95ysb4p8IieZF1FO2Kcm
         Yc4Mr4mk4HTDOYFZBoV0aiEI5cdfbN5DWonMlR44R+eOSxSfjRdrV0wSKRHNbqObQ4zI
         RMqEkkQqI2p+mx0YVCY0kw2HXtssCjetvR4AHhphpnkWbNYcdKEn+dBXdc3g6AaCPk4k
         RjbSvBxrrFwQjpOnGblS8riZVO6kuyRHEc7aOeDva+tPAy0IgJmUSYKWeDQdIQw0IkxJ
         whrA==
X-Forwarded-Encrypted: i=1; AJvYcCUo/Isiitop5VBAlZdeYYaOCAjfu3Z8Mtd5RkDJlmIK4NT24pcCncadV+uq8aufz1CtYW0vPTH+oN6NBGMz@vger.kernel.org, AJvYcCV7iAK8DmjbOC2eRBMrlsFh36ix2mha/G/1yap75MwkD1mfxc4M+QnlEzHMQM4iyiaxTp9iayIoub8=@vger.kernel.org, AJvYcCXlcnRg6Mnq77OiwvSzt5Lffjd4FtAejSj7jOW3+Xi0b1iYhusSvIr/jIBDKU702tFMdhen0QrW4QcfB5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqcaqZ14lCn8hcKC/uKlYNwKXEuYGR6sttuRHUq4JJfbY8Che8
	jKjQmuTKjv9J57nkcr0BIQNA+HIqHnUOWj3moQCysWdmzj2Y4yPSU584
X-Gm-Gg: ASbGncsWE0/owFk/g8i2vyLvDKNee2P8e7PmartI1lN346bmGg/oHDiO1nd17CFEvhc
	ftsBjCAf03CzqibfYc2ITGzub9z9ceS5cayNQcf1JKmjBBMaGwyKb3OrmG5IEussn1wifXSjyxS
	tj0k0q/CyvmdzJBb+r3FhNLhvG5HWx8HV9p0qQfnojg6vyJw20tb4NaTWNG7zm88Emmmyp5xGys
	iGZLmpxod7KkgfP9q4PnmBW0mNQ+IqxtiZOPZ5EkaY82nBsK1Tn76QOjGI/Dlb1syNrnTECyoXu
	k3r7xQikiFjDtpU6+um70KFPQWku1dS8Hs4EZ1n5Zh0pheB3suo1nBLkYb2l9WO5yLpv5yEP62J
	/eBAxzkvFtrXlP08q/2jN7WqOQ8ZTLDoCqJaz3nVoMOG8qkpXoAPdKa5p9nL96RXuP7RbFA93LA
	l0nHDNBu3pe+ZGjpifcJ/zyvY=
X-Google-Smtp-Source: AGHT+IGfY9QtsQrAEy8PrjWhyCqNNjIhJAF9gsLxaAKWD1yIouJUcSrb0mmoMGsaAU7wyYF7jJPMHw==
X-Received: by 2002:a17:906:9fd2:b0:ae0:cf2e:7ea4 with SMTP id a640c23a62f3a-af61e6368a2mr1369912666b.40.1753735904337;
        Mon, 28 Jul 2025 13:51:44 -0700 (PDT)
Received: from puma.museclub.art (p200300cf9f013400cc194b80e1760d4a.dip0.t-ipconnect.de. [2003:cf:9f01:3400:cc19:4b80:e176:d4a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635ad589csm469943066b.118.2025.07.28.13.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:51:43 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Dylan Tackoor <mynameisdylantackoor@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hwmon: (asus-ec-sensors) add B650E-I
Date: Mon, 28 Jul 2025 22:49:09 +0200
Message-ID: <20250728205133.15487-3-eugene.shalygin@gmail.com>
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

From: Dylan Tackoor <mynameisdylantackoor@gmail.com>

Adds support for the B650E-I board

Signed-off-by: Dylan Tackoor <mynameisdylantackoor@gmail.com>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst | 1 +
 drivers/hwmon/asus-ec-sensors.c         | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index 558755f9fdd5..1e8274dba35f 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -25,6 +25,7 @@ Supported boards:
  * ROG MAXIMUS Z690 FORMULA
  * ROG STRIX B550-E GAMING
  * ROG STRIX B550-I GAMING
+ * ROG STRIX B650E-I GAMING WIFI
  * ROG STRIX B850-I GAMING WIFI
  * ROG STRIX X570-E GAMING
  * ROG STRIX X570-E GAMING WIFI II
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 4d8b887b8a55..0b19d148f65d 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -495,6 +495,13 @@ static const struct ec_board_info board_info_strix_b550_i_gaming = {
 	.family = family_amd_500_series,
 };
 
+static const struct ec_board_info board_info_strix_b650e_i_gaming = {
+	.sensors = SENSOR_TEMP_VRM | SENSOR_TEMP_T_SENSOR |
+		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_IN_CPU_CORE,
+	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
+	.family = family_amd_600_series,
+};
+
 static const struct ec_board_info board_info_strix_b850_i_gaming_wifi = {
 	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
 		SENSOR_TEMP_MB | SENSOR_TEMP_VRM,
@@ -635,6 +642,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_strix_b550_e_gaming),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-I GAMING",
 					&board_info_strix_b550_i_gaming),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B650E-I GAMING WIFI",
+					&board_info_strix_b650e_i_gaming),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B850-I GAMING WIFI",
 					&board_info_strix_b850_i_gaming_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X570-E GAMING",
-- 
2.50.1


