Return-Path: <linux-kernel+bounces-853586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF283BDC0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F28604F0CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55B72FB984;
	Wed, 15 Oct 2025 01:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zwv/AYzJ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9062FE568
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492988; cv=none; b=F9BVhXmBzLZo8hBf4ojkyaEbuX7MqQbWtAcAsyOaZUc+Dl5n5agnjKRSdWEd3Nu6W4l7lC0b9LZWFFJYHc+OaHpw/TsSA/FieYefzFciSEhvJWPW869Ko4CFafQGEUAncZSwma3tWg899RMvlnnFjlveV/WSTszXS1sGkrgOPsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492988; c=relaxed/simple;
	bh=TbswgXQwCCTmzsX3hGAnNwHOzR/5QSN6bjAPmQkfsmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEwo5UwHCONaejL4qisYkZxWtMm7ukCQaVZNuwjsClEQEwzc76JAy1HBUwZlQbfynWybRUY+3eoxcNbQqE/KurN6CXainbTYciAEqSUEoJcTY9zYsGiUtOMffoHVZkPsF0JTBD8XbsGJ9M7gAoKp0+M4G5WSEkPJ7ph0YteoQOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zwv/AYzJ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-421851bca51so3965796f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760492985; x=1761097785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txV+xh/18MrOzYRQN9sCc73WlopP1Drxah2geRIuTgY=;
        b=Zwv/AYzJjU4tK5bsCzXsY4jAfptjxWTsyWmLcUYDnjAnVwzGrMp0XoIw2pVeKERKbp
         UW40OBcfsa/9t7YXIL+s5iGi/gOueYvXSplUnahf6GeDLrLTPA5Bkh/wYqp5LNBfJcEW
         C1DNJxyrlP1qaI3YHpvWmO9I1mAFRBdw6vwXhzjMqOmstqJwpXmf6Zh8m2x8pbogZ5oz
         f8yYARBqvuxTILUqMraB5e6MHD8a2fAc16Hac576Vw1MdcngfCG4Qkyw4qME1GlnBeTu
         lJY/kcIgwDsPNXiH5h6Q7O57VLaotQHrGSkMbAL35bdKRr6SsLuA4Vbz6dFP3+osRE0D
         x9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760492985; x=1761097785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txV+xh/18MrOzYRQN9sCc73WlopP1Drxah2geRIuTgY=;
        b=fi5zqbnxPQ0OoKd6oZHTJ181Iwmi2KYP9DKpClqKIE8o4Dl9FDxwB1QXy5e3W5W6PJ
         tY2xExePTSEG3FpxDLK4i3/xs8Z9Q8RK5My/FcjU/aiT38ziKibCxNGwBqJTIKLWSRzA
         S3CIK1Tq1XGzN5wtOLqNs58wQtKnjy5ilc4lLOBUpYOlY4aQF1jOdWKf03G9HwSWhda2
         IL/hPj94PB7K0bsN7STV5H+IF//zOsw2/f6hFSTm46u/I8SO3BeoCeMThPweIdqAkOWA
         3mnglTwMPZIbH9FwsvbGku0nYTNF8MFhQ6i7fDOdFzevc0SRQl3q63j0ltZUwpj2prud
         x1mA==
X-Gm-Message-State: AOJu0YwHrCVKr6r+z6yCBaAkRoUl0H4WnugGEr7JgwMXL02v6PmoGHrw
	XzxBccew2BMI8KaImFyCeeq2BNpIa4BD7QFp6NKFmE8URnwqAdvM51tist8ytA==
X-Gm-Gg: ASbGnctTO4Nh33EQyXLZP2GRj19f+JBj+Y18RUPBdrXksw9MBHi6So/iL7RY0ioj3us
	M4wpkwvH2ehEpjzWZQ2/WpMrsFbsLPMg8TOrvjIIp80Yy8fAGJbY0MISpk77vNOLrkQoa5ieDJA
	1etelS0PKraD0B48Xc0nRtdxVWOgtJ6Gk10X+Wj+k5kOARNVjuGHjGMcg3aaKapIGYfZgvwVljB
	DrbmeIVGrJjGf2C72dYvZRawjlMkFrQre5M6arTQISKU6qZXg8Mjr/Z9Lxefn1ziKM1pRGWiTvl
	xH3XkVQljUfdwC7MUtLaFf+GaTD577RS2HboW+e7jHdX2Hddm5JdpyQtHTS49sR9Hetd/WRjHFk
	hsLIDJanNb9nUHuLmK5DY0NUQjdYwqULM+Gm25FGcp44iHw==
X-Google-Smtp-Source: AGHT+IHF1sWPjvUGu8+8OrodAM8EEtHpDXES1qHmreRu52tK/mgqLAQMzqFl56vD3PWEl1xGAsxgsQ==
X-Received: by 2002:a05:6000:22c5:b0:3e7:5e19:5ec3 with SMTP id ffacd0b85a97d-4266e7e02dbmr15880705f8f.41.1760492984520;
        Tue, 14 Oct 2025 18:49:44 -0700 (PDT)
Received: from denis-pc ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d49bsm27368995f8f.10.2025.10.14.18.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:49:44 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Alok Tiwari" <alok.a.tiwari@oracle.com>,
	"Derek John Clark" <derekjohn.clark@gmail.com>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	porfet828@gmail.com
Subject: [PATCH v14 6/9] platform/x86: asus-armoury: add screen auto-brightness toggle
Date: Wed, 15 Oct 2025 03:47:33 +0200
Message-ID: <20251015014736.1402045-7-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015014736.1402045-1-benato.denis96@gmail.com>
References: <20251015014736.1402045-1-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Luke D. Jones" <luke@ljones.dev>

Add screen_auto_brightness toggle supported on some laptops.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/asus-armoury.c        | 4 ++++
 include/linux/platform_data/x86/asus-wmi.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index 3d963025d84e..e27f964aebf8 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -731,6 +731,9 @@ ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANEL_OD,
 		   "Set the panel refresh overdrive");
 ATTR_GROUP_BOOL_RW(panel_hd_mode, "panel_hd_mode", ASUS_WMI_DEVID_PANEL_HD,
 		   "Set the panel HD mode to UHD<0> or FHD<1>");
+ATTR_GROUP_BOOL_RW(screen_auto_brightness, "screen_auto_brightness",
+		   ASUS_WMI_DEVID_SCREEN_AUTO_BRIGHTNESS,
+		   "Set the panel brightness to Off<0> or On<1>");
 ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID_EGPU_CONNECTED,
 		   "Show the eGPU connection status");
 
@@ -748,6 +751,7 @@ static const struct asus_attr_group armoury_attr_groups[] = {
 	{ &mcu_powersave_attr_group, ASUS_WMI_DEVID_MCU_POWERSAVE },
 	{ &panel_od_attr_group, ASUS_WMI_DEVID_PANEL_OD },
 	{ &panel_hd_mode_attr_group, ASUS_WMI_DEVID_PANEL_HD },
+	{ &screen_auto_brightness_attr_group, ASUS_WMI_DEVID_SCREEN_AUTO_BRIGHTNESS },
 };
 
 static int asus_fw_attr_add(void)
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 9a79dae97adf..260796fee301 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -83,6 +83,7 @@
 #define ASUS_WMI_DEVID_LID_FLIP_ROG	0x00060077
 #define ASUS_WMI_DEVID_MINI_LED_MODE	0x0005001E
 #define ASUS_WMI_DEVID_MINI_LED_MODE2	0x0005002E
+#define ASUS_WMI_DEVID_SCREEN_AUTO_BRIGHTNESS	0x0005002A
 
 /* Storage */
 #define ASUS_WMI_DEVID_CARDREADER	0x00080013
-- 
2.51.0


