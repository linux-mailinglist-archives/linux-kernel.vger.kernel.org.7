Return-Path: <linux-kernel+bounces-815494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86248B56754
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 10:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E96917AC254
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 08:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF12423027C;
	Sun, 14 Sep 2025 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="At8o9FRl"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ED2222585
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757839227; cv=none; b=MQqIjTEU1xKLlkZnvm+EOB8r0duqLACD8az361CL/FO107/PEOxP1GhHBfR9qOa/KCNcFYk1PngHBN3OCw2aMS7ujgub4OKpJ1bI+dyEnm1tjPgwkrvlGC2EfbR80t5TI5mcLQbhgoazVT6cjstrh2/9DvUMMvlXuSUwALDj9go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757839227; c=relaxed/simple;
	bh=hvqqhKDwn0KttZ7YI/pFa/dPygt7+4qJkMXYteumt+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lieSp9Ml3ikjptHb9Xebqp4AaGwBRTg/+Twfcg35ipeTmD1rlA6CPfB0+TqBQppgn1Du34dHn0oXGNzeml1aXhA91xLUuHm1JZF88LmO475Tllw9ize7/9twx1sUxFx9RkV6XvLjc6MyZGX6XhPbkd6vNtwmuNVH8XbkEMUH648=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=At8o9FRl; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0428b537e5so444019266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 01:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757839224; x=1758444024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t8jAyzV+acKcWO9q4mFH0eEwR5GYgn/NUD1fgTglKnI=;
        b=At8o9FRl2eAk38KzuOlRAiZ/cRwD8tV1W6ynXM17DfpuMari9+LTOfGeZAH8Ll7RZm
         QILe7XZ95daOSh6ypaZoYjMNGQYilv4YuLKN9g9gxQlCanSsGhDeks/+MiXvaoAWlEJb
         nZxnK8vCC2xVKXcdx6IdYdS5SKyAmN12H+f28GEqLpkJRiRIhYYzARP8HuGpT4wANb7L
         IDKy2SvqfGAvkv7b+Z/GRb8+E9N5Pwin8T0rsWMml4RGqymhYe2GRrcFrJ1WofniLIWh
         IwL4DQzg1NpMrMkTIJWxQHADCR6lvNLz3wH/UF+q3pnhpShWnVnZBGI4hokEYk+x+3NX
         JMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757839224; x=1758444024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t8jAyzV+acKcWO9q4mFH0eEwR5GYgn/NUD1fgTglKnI=;
        b=EvDdz+o9WZmlNY6VdiiTFwzsQ1aL+bhRsRKHqyun5nN0gajcZDK3CT6bpLCUqBfMSI
         bup5Z2TKR6XuxzHqOtj1mz99YsMbAEUw8I3gVyYFJ6RzCx9+cjcEc/9xRImOQzbVuCS/
         WYbIRJxdYZRWz+QFSd/dCPMtlZvHRtMf6OwuSUESMpGAcodwoX05AjzGrsGLNPBAHxFn
         I4n9JGPNGRaOa8DoYGASd7WSPPIJw9eK+HTZSYzgsr4x+8+CZBDP8n9ubN+9LtbJlI5d
         HEwmxIAKAoy7b8GQcFGVZIxUytuW+xQOSXgl01ExDaw8fGymswDcTNmIFutZ0J0wWv30
         zSAw==
X-Forwarded-Encrypted: i=1; AJvYcCWUlfpFXOQKCUCBvp/XPtt7H+bClTS94lLccPAb9tSrxFQfd6/e693Vb3Jk5OeU1SgvkrbM0aJ+op0tVIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWcQaw/crXd1H6zVdHylw+HWC2my4qoEoWLn1ghhwxITpLqRd
	E5PdI7x0e1TJt8mcHEoFC2E7i+QJ+z5PvNLIRB+LfsBkmPlFybcth6yX
X-Gm-Gg: ASbGncuTtuJKTJ1DL9sMyOeCjNMtPZ91bIhAUSUTC/6z+Ap+E+pJMhphOkg8p8FDUpu
	PV+HdTXaX/4Z0jXIlKkuR2X5DWCkhDYed6Hv+mt6WqU4tEw3IpX+iuZ6G/QtAzfElROqO8QzQNP
	cXWLOeDu53x7l/ZVpmwLKml7Bghv3TXz/VB5H4TQorUUwHaNlSUfpk3pU89UdyvGc6lBPXdPU+M
	Rye2t1hM7xVumeeGPpKwKQSrp3mODkj2RvnjpAX0hReTX24fN8B5lq0h3jWf08YwKB0LRGnjtXe
	5sBrk/uafJNJ8iV5batRpddOvmNikD+0CZT+GXmOuDjLPBb7HFNbzVuI8nkj3ChN6iLBVh0WcaQ
	F9s2jGiTti2AIE+a1dKWmbmOVrmnkygYZmjEhv5WsCGh7xMZ0uZseqw==
X-Google-Smtp-Source: AGHT+IH5BreF0jNdm1JhmaZYhd36b3wPJHK9s5ZiIRSzQP1rPJTWRUoxQcoEakCnqIxdeYIuh1MxAQ==
X-Received: by 2002:a17:907:9621:b0:b0e:d477:4972 with SMTP id a640c23a62f3a-b0ed4777388mr94391266b.25.1757839223690;
        Sun, 14 Sep 2025 01:40:23 -0700 (PDT)
Received: from puma.museclub.art ([2a00:6020:b3ea:9c00:26e7:b56a:5a2d:1d72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f21a2sm721370466b.83.2025.09.14.01.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 01:40:23 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Mohamad Kamal <mohamad.kamal.85@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS WIFI
Date: Sun, 14 Sep 2025 10:40:10 +0200
Message-ID: <20250914084019.1108941-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohamad Kamal <mohamad.kamal.85@gmail.com>

Add support for TUF GAMING X670E PLUS WIFI

Signed-off-by: Mohamad Kamal <mohamad.kamal.85@gmail.com>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst | 1 +
 drivers/hwmon/asus-ec-sensors.c         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index 836d41373848..4a99b65338bf 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -45,6 +45,7 @@ Supported boards:
  * ROG ZENITH II EXTREME
  * ROG ZENITH II EXTREME ALPHA
  * TUF GAMING X670E PLUS
+ * TUF GAMING X670E PLUS WIFI
 
 Authors:
     - Eugene Shalygin <eugene.shalygin@gmail.com>
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 3f6d89bcc8a2..dff13132847c 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -795,6 +795,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_zenith_ii_extreme),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING X670E-PLUS",
 					&board_info_tuf_gaming_x670e_plus),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING X670E-PLUS WIFI",
+					&board_info_tuf_gaming_x670e_plus),
 	{},
 };
 
-- 
2.51.0


