Return-Path: <linux-kernel+bounces-757826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122CBB1C71E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3515C563660
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7B928E5F3;
	Wed,  6 Aug 2025 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OffscTjZ"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22028CF64;
	Wed,  6 Aug 2025 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754488440; cv=none; b=LfX/0W9Ajz2ST9tgimNGd5NWIvfN5jQz/5h0bsX8cTTBiXEkJWNbLFGl2SVL9/LlRGDNKNiUR9vSaWttdzYz4QkOXDG6x6F2JjA8DZ+bgZrEYWGIpZZ6gzPBWpxXPRfcVt1Ft/QY56uygnXfvMhekdt/4Cbl1I4IdDm5GrBsSn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754488440; c=relaxed/simple;
	bh=OxQBCVIRGDSLaxwSWnR+pZYN7IJX3nZQ+HCBgGE2Sxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BH2lY0+kim0/XBC3qHLf/kayePA8Q8UWDJVtz5lTX3JvIRdvO2sn2TgJLSrjKShoR1AfjmU6g2izKezvb98U7AIybGT+ArMxwxXIkawgP/CZ9bc1E4+m7NnJ9xiXgU8AsWjtiwQSq6u6xAvKpJGppt1LOJ6EuiUbulV4sm9nRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OffscTjZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b790dbb112so3777655f8f.3;
        Wed, 06 Aug 2025 06:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754488436; x=1755093236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7+Z0OmSBKwVxIIJ8aTGKOkqCQCixyQZfy+H+rgeu0M=;
        b=OffscTjZvOz+/xVqZoGtlfveDpJ3kIKhoP+DbqAN32uiGr4fI6UhW/NY4fgZT6oRkO
         dcUapdm9mqqGtlfv55MzfHsh9/1p6c/5FcuGpKo8PrlvIm3RLqV3Noo7pqmfLnyR13pj
         8G2hQ8DtC2D1Ww92cpj3RLoJ2cAWZmOVWZe1A6JRuZ/Zap2U1NluISkv6sVGj7UeM9lm
         vji6gQh/Gq7I48yn4OCvyhKVirK74fbO6Kozm7CIM5UrPhWN0vKGxSNhf4HKUIgqwXDu
         P45Zcc9/zGLX00ZrYZd55/VzGWakz1wByafyj5fKzeeAoGVE+cz50ULQ7ZW2LgVqILVE
         tmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754488436; x=1755093236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7+Z0OmSBKwVxIIJ8aTGKOkqCQCixyQZfy+H+rgeu0M=;
        b=ZlhU9e4NNRYi+zC9Vxdixf1OMR+pxO7iLDb1B2FASrds1xDmJNV/H1vObtJvZ+FSKx
         GXUWOLIH7ovxg660L5YD7M6lKeBUnoOgX49IMiTFXHyt0T0T7Mg0Jb6cnhXfmqjxeGD/
         oYDu6a8z7gnfYCzQAueAE2vYUqPDt1yCUJI/Lsq5p5zkU88t1iYHaTOVuRtO7OzY4Sky
         nv4Etcllnh7ntjTHS1EIbEWFP1ofU7rixF7g/YzAi2cWw1475bnB7dpZLYdW/aQ04KkD
         5f404BL59+8kyHl6+pH71RLkt4YM/tCGp67Vk6a8MyASOqqm0/x3oVSzSw/P6xLJ6ryR
         KK6w==
X-Forwarded-Encrypted: i=1; AJvYcCXlcJ0joIEKVJ4sWbgjM3aR44L/ReYoVg5eiFJBUOlyeTcVvhdnzsjxtk8Vl6dsnvgT9TMDG++46D9Szt4/CB0aMyDF@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgd3+1+IIL94qiTuY6rpJxDz71G217xOwFqOsjaHZkiIwESkF+
	jtU3fmAdGgqy+gmmYpNfZpVOG/96r39KrOJuvwiAnNygMrzqfjfKEHmW1ep6Mw==
X-Gm-Gg: ASbGncvdXlL/ELi2gFjjevGqRnXbse8IMP+Zwm9i1K8NrASBnuOrQonPjovkYpvOlwT
	aV1g4CU2o6WHhwdywVTC8uRX0s7tpAjIpHaAvQdXX6O8eqr1AtD0hrTeIls+ZxGGTV7a2vZTkHm
	55soUkmlEcJgaWS5oWVrahjoCtm5gstZbrGNXZwCbJdqik73mey1ida412BHD/Tm52X5okQFsPq
	Q9ZYkkY7pLe96iSVwy2yWS/V28YFC8iUIqIpNdV/WUBbjPHqw9bG3V/plq4NhNqEn1HfQzvY3bz
	LkVJqGc9h7TbRg/vTEBEIxvmTlzY6GSxuBAToNUx42dPax9MfvcgyQLzAYL7BRnn/PnGm/AIJgH
	AGuheQJLaczsORt3ss0/+3xeP/vFRTP6Diqs=
X-Google-Smtp-Source: AGHT+IFEZGwYJ9Uf8whp6ywxuyMpKU8MRqotups1+m2niz2At8Q4bgaQgb4HlslDZaZbC007u7+SDg==
X-Received: by 2002:a05:6000:2204:b0:3a6:d349:1b52 with SMTP id ffacd0b85a97d-3b8f41980femr2388655f8f.21.1754488435945;
        Wed, 06 Aug 2025 06:53:55 -0700 (PDT)
Received: from denis-pc ([151.49.205.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bc12csm23646087f8f.28.2025.08.06.06.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 06:53:55 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	mario.limonciello@amd.com,
	"Luke D . Jones" <luke@ljones.dev>
Subject: [PATCH v10 6/8] platform/x86: asus-armoury: add screen auto-brightness toggle
Date: Wed,  6 Aug 2025 15:53:17 +0200
Message-ID: <20250806135319.1205762-7-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806135319.1205762-1-benato.denis96@gmail.com>
References: <20250806135319.1205762-1-benato.denis96@gmail.com>
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
index 4629389c4c25..36571290fc40 100644
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
index 3e7491f8e01a..1191760297d7 100644
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
2.50.1


