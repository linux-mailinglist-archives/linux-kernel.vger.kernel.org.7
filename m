Return-Path: <linux-kernel+bounces-793094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60222B3CE48
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09C32067FE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808DB2D6407;
	Sat, 30 Aug 2025 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw12f11H"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3088F2D6406
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756575551; cv=none; b=sHiwY2Uqlh3uPmoRZ+5z1MI+sfiZf+smkEJ0noQgvD6kPYAir2EmQch7TTnPyS2LPzgQ2MoMHGoUxmUQdaxHmqngy83De6jLW7bN7fp5gMXBfhgxFMI67JxSN3K/infT245nhC/eJpHB3xxEoFvXPfD+CZAhhpF5ixGv7AzWaxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756575551; c=relaxed/simple;
	bh=t14jI/u1SV+Q5BrfgSBejLw9iZW+We1ooUjKGSA+KFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZP4e6r93aX6Fgmef8cuvsIkJonE7OJ20jpqe21YYtrcbAeblgdcDhydMRpIVv+hrK/o7WSMm8eXdLc+CqiqqZaPqZU9/E3VzdacNOfvI8jlKTK59hiDqSIr7/61c7zMxYAc3b3gZYsuJ60IazkECtT7YTRX0HEfIbHjMKssLcrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw12f11H; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-248e3eade89so5602115ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756575549; x=1757180349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOoCafVA6rbpLZQPmX36iB5alrObXaK1nsnhC+086Mk=;
        b=Rw12f11H5hE6tvR40ldfpVfDjzCjGJBYA00fdJSshHlXrCyQvY1bSbGivPH4m7kPoz
         S56NFwHuV0WMlJoAe67o/URilN61XRZ4H2NcLKqi+/jWDgF9qnzi1vxAoBy16M3P9ItV
         /+7mzG2b4Yktqi5BGqYahIOFkxjAN7NLkdo4wkhmVJnFh+U8RlfSoLm3d/k/zz7ZZpjq
         vOuLzbubvkVbycTCz66G1Ivo4OB/8X9YHi/M760TwwNLcqpoYaveXTwDGrWkdVo+fipn
         R3k+GxC+G6JyDTJ5XG8F8XtJ2/7TBgE2aJ09wSetcpg6hd0j653wXeIiWbXAhaBb9Sv+
         xaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756575549; x=1757180349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOoCafVA6rbpLZQPmX36iB5alrObXaK1nsnhC+086Mk=;
        b=m1nuIXdRZM24vKsBqpuKESy6wVfpvoNzrv1UjlJ1dwZEi6S81/hsLAW4gnRy3uZd0D
         RftVLz7O94N6DAYCKDblY/y8Hstt5lB7SCjOskAkfNQnJzWssFkIEV9DC67LbMdeapQ9
         UEe2rGtGvTRDSFLrjeXApRyr3ohTNiHLKSvFMHNCASj4TfdHw/IzFJtwuxQ8hpcgOADp
         VWDrVkPYDGLZKCJk4N4yJyQMSe+IozgKI7s9rmfe16VXvPQTfYFK9mo1WXqulJAb3mQX
         ZOXepTRoW1KN9EoEH9xWd2aPCrvJpK4mRWYxw5dg841uiCRHWOWRyCJVLX9Whb/j0s2Y
         vNEw==
X-Forwarded-Encrypted: i=1; AJvYcCX4bgFKklbQZBHcwmu+WuggZxKJsylYj7rtTuVYh1stIPAm0HWvni9aqNKmxRfHy6u5l75VzGrduksoJwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXBaobxV+dAQflk7DkUWZwwlFzBsgyIuQuFMg49gZF61bQL916
	Mq5ufK+XPvar+ZgU7NHqs7dhoiSM5FK6AulA4t9x+FqMwE7U5C1E+ciw27R08g==
X-Gm-Gg: ASbGncuP7msoLpe0c0Z77K7D/P22vVFkcjvC41NCjDRkl5c/3eb7OH84F7s/63G5Zc5
	OTnoeFmmeGRXxvksBUdcQhXyd7ci3jSk+t1v/0oN4PvIdB4xuT+sP0XPIJWrVfL3XCVyuUt3Rar
	2RHc+8MMBXWwOJh1PDcI0Ocp+2mBuC5YXTTcnYyVpbDQLwqd63ZgizI4H6ndww4Wy/fUALfiJtm
	xJpMjSRQwbxzcnwdYRIYKWlJS9sOg3Otr1NoSS6j5V2RWzMDbeHVQ1PWyeMHNLbJRSO98R+HUE9
	C4DteJzY8sjawYHHu0eLN2xehDtpvMRDSuyxDUyH9ICY+6OcqAvGqigccHx2ANmZkGbWZrZ3ZbV
	rbk913qq117GvElh7RC7Dj8U6jR5rE/REKzdIxj1uqw==
X-Google-Smtp-Source: AGHT+IHTDqX8ysZkgx+mDXMRZKsxTFu34Ov03/Jj/KOA6Fo+OIeYKzdlGZBtzPGukVtx80QGvKg5DQ==
X-Received: by 2002:a05:6a21:3391:b0:203:cb2e:7a08 with SMTP id adf61e73a8af0-243c8457780mr3986145637.5.1756575549342;
        Sat, 30 Aug 2025 10:39:09 -0700 (PDT)
Received: from raspberrypi.flets-east.jp ([2400:4050:d860:9700:eabe:57a8:cf74:875e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28ad39csm5154525a12.27.2025.08.30.10.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 10:39:08 -0700 (PDT)
From: Masaharu Noguchi <nogunix@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev
Cc: vaibhav.sr@gmail.com,
	mgreer@animalcreek.com,
	johan@kernel.org,
	elder@kernel.org,
	greybus-dev@lists.linaro.org,
	florian.fainelli@broadcom.com,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	dave.stevenson@raspberrypi.com,
	laurent.pinchart@ideasonboard.com,
	hverkuil@kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Masaharu Noguchi <nogunix@gmail.com>
Subject: [PATCH 1/2] staging: greybus: audio_topology: avoid -Wformat-truncation
Date: Sun, 31 Aug 2025 02:38:49 +0900
Message-Id: <20250830173850.323897-2-nogunix@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250830173850.323897-1-nogunix@gmail.com>
References: <20250830173850.323897-1-nogunix@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    - Fix -Wformat-truncation when prefixing device id to widget/control
      names.
    - Write the prefix with scnprintf() and copy the remainder with
      strscpy().
    - This avoids potential truncation and satisfies W=1 builds in
      drivers/staging/greybus.

Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
---
 drivers/staging/greybus/audio_topology.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index 6ca938dca4fd..5bf8b5e29dd8 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -1013,7 +1013,7 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
 				      struct snd_soc_dapm_widget *dw,
 				      struct gb_audio_widget *w, int *w_size)
 {
-	int i, ret, csize;
+	int i, ret, csize, n;
 	struct snd_kcontrol_new *widget_kctls;
 	struct gb_audio_control *curr;
 	struct gbaudio_control *control, *_control;
@@ -1087,7 +1087,8 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
 
 	/* Prefix dev_id to widget control_name */
 	strscpy(temp_name, w->name, sizeof(temp_name));
-	snprintf(w->name, sizeof(w->name), "GB %d %s", module->dev_id, temp_name);
+	n = scnprintf(w->name, sizeof(w->name), "GB %d ", module->dev_id);
+	strscpy(w->name + n, temp_name, sizeof(w->name) - n);
 
 	switch (w->type) {
 	case snd_soc_dapm_spk:
@@ -1138,7 +1139,7 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
 static int gbaudio_tplg_process_kcontrols(struct gbaudio_module_info *module,
 					  struct gb_audio_control *controls)
 {
-	int i, csize, ret;
+	int i, csize, ret, n;
 	struct snd_kcontrol_new *dapm_kctls;
 	struct gb_audio_control *curr;
 	struct gbaudio_control *control, *_control;
@@ -1169,8 +1170,8 @@ static int gbaudio_tplg_process_kcontrols(struct gbaudio_module_info *module,
 		control->id = curr->id;
 		/* Prefix dev_id to widget_name */
 		strscpy(temp_name, curr->name, sizeof(temp_name));
-		snprintf(curr->name, sizeof(curr->name), "GB %d %s", module->dev_id,
-			 temp_name);
+		n = scnprintf(curr->name, sizeof(curr->name), "GB %d ", module->dev_id);
+		strscpy(curr->name + n, temp_name, sizeof(curr->name) - n);
 		control->name = curr->name;
 		if (curr->info.type == GB_AUDIO_CTL_ELEM_TYPE_ENUMERATED) {
 			struct gb_audio_enumerated *gbenum =
-- 
2.39.5


