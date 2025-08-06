Return-Path: <linux-kernel+bounces-757824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 235D9B1C71A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D4D563612
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6E528DB48;
	Wed,  6 Aug 2025 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWpKPG+R"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A147E28C5DA;
	Wed,  6 Aug 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754488438; cv=none; b=q25JxHbMhHE0KaRcmIwabLtF0dNg4bUTGpW36dIUDgjNFpB50eCwcMzVd9ZuLlOiB9O+nK21DzI/DQ/MEnZfsH6OICpoffr8WSHAQTAoD7bOlR2z1Vp4vde137Kdrknlmg5iIoy0xtTvw46IpvjyLXfFVo19ahgZDwyTVZeMInc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754488438; c=relaxed/simple;
	bh=p1VzCynwLsnvWrmQqLYsgjJEMrN3u9WNhMiyVp0CVzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUg2vg5u4hnlY7tuL5OXWggxFrkqK+mUVd3kNHOtof9uwKnZFE9DWrgNqjjRL3aUZMlpaIieeuEQ4F5e3ykC9yC4oQveMbGNKZeG59fu9x3/LQStlBx0sIF9Gbu+CEKeVpTXAibbmWjFQb89ojtXnRHqMzUJ0Hy6hrxef1rhtGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWpKPG+R; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b780bdda21so4708806f8f.3;
        Wed, 06 Aug 2025 06:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754488434; x=1755093234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig5I7ozA2QyRty8Owcdpp1cPBHOmlpLlayno0u6m2k4=;
        b=KWpKPG+RNA5UCYLRo5tt1yXF/VK4N8sXt6CV4PPHjqwtL9uDaP7ugD6DEjAzeFfMnl
         cfqLFs4oTYtj54kL0k+WxFFnjUKSP7gYxcNmvfO7ZLbkWOYYmj9LX5679ci1H80ab15Q
         fo2IZW40KwaRdyROlltEau1qtimBe2O3CJ1Ws5r/GdbYMnZPkzC/t+H2elDkN0sigR/G
         p1YxL8BxkfjCpUqL6InNeVVKCAlSAqZiqBuWJ1P8k5CWEzZl9E3WtIvgy0zfxlOjXs08
         MjHJwgl3DBkBtfZB7TYLbB3KUa1Xuql4ba7EyLRjsdqTk+nPfK8pz0qxhSWnwDBYw7bR
         IdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754488434; x=1755093234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ig5I7ozA2QyRty8Owcdpp1cPBHOmlpLlayno0u6m2k4=;
        b=JRuSH0bZmaLfj4ekE8UPPq2j6fI8APn/awv3pK0LP7U8TqJBZ9olgL19nRd8E7PiVL
         CeBqvKhaFUSEqVvC1Eb1zTEWSqE+AdC8ju8wC3BUFcoT6owY1c4dMUqTkT0YPDTndV+t
         7UgaXvRZITegm+v+ABZ8sLFidac/aFq9BJyUCREiuDDLQpVk3zsYTS/CMQ163ukiLQ6O
         zVpD817pzHsV6Ct/gBNcQeIdPUvUSNU4Fnl3znB9Teyf83L7LGclNmYwU+S3l4YQ0E5x
         GrXwPDUlujbMvY9H3Oi0mMzLFvU8y5Ux0VawHvZuJzhYkAUHiXnmr8gFoMpDHJLdBL99
         Waig==
X-Forwarded-Encrypted: i=1; AJvYcCVOKCgf29YD0Pbf6bo2RTWkfNhqbq7y1CbNU8tXGV0koN/Y38BxY9II2rHgBmPU9cy6Xhp1fuW5IW107/JU7bymiVnb@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8/Y0q45tFXV7LCmHcuBLntS4Vhs/osx8zwxlEpZfI2N6LK49
	1qrhvNyxsB2eYLSt0bKAWWrgtpfB2SN+TFXeFSVSHhnVYHi5F45g9ef48+qrlQ==
X-Gm-Gg: ASbGncvzgI1A63D8Twrn3ra+NNWn8Y5I9FzHEEnfmkhFZzjUwGEF0YTSLlR2JUVuJvv
	EXYosCVfMiJ8/gMf3q7PfiQx9P5vM+cSahx8/Bb6oc8xKUWMMrXgkpKGuY4rhR8oRwBtS6ZuL1m
	/Fsb/VHyDt+CepAxUFe0yRYXEYn0msgoMtB6ocqedercKVMm2H5OhimPilBW/OpCu80FQ/ZEtwW
	36YH52cvKkqUvamElw1FTPzT7tdKmuuFSFbu1bF8UfL6ZqBSnDYGfyBrd9fTNzZ4ozALhoZaKrh
	8cGn+BjcKOZMnUfyEiB8QaReI6UrvPIW/MG/aEUgpYN5mPmdJtUnYLWD//+AhrfOQmBaACRzD5J
	R6qR+7rzdM3hiI1V+wjoZYl+11ihYQdiel1U=
X-Google-Smtp-Source: AGHT+IFfN0tKGpjA2XDmzWfaQpadhYw8GCe11fup1mVTVRts8iQ1mPmpwsxWSuFlXmUWtCcvILtahQ==
X-Received: by 2002:a5d:5f53:0:b0:3b7:93c3:7d49 with SMTP id ffacd0b85a97d-3b8f49274a1mr2292766f8f.39.1754488433649;
        Wed, 06 Aug 2025 06:53:53 -0700 (PDT)
Received: from denis-pc ([151.49.205.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bc12csm23646087f8f.28.2025.08.06.06.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 06:53:53 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	mario.limonciello@amd.com,
	"Luke D . Jones" <luke@ljones.dev>
Subject: [PATCH v10 3/8] platform/x86: asus-armoury: add panel_hd_mode attribute
Date: Wed,  6 Aug 2025 15:53:14 +0200
Message-ID: <20250806135319.1205762-4-benato.denis96@gmail.com>
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

Add panel_hd_mode to toggle the panel mode between single and high
definition modes.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/asus-armoury.c        | 6 +++++-
 include/linux/platform_data/x86/asus-wmi.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index 57ed9449ec5f..68ce2c159ae1 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -92,7 +92,8 @@ static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
 
 static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
 {
-	return !strcmp(attr->attr.name, "gpu_mux_mode");
+	return !strcmp(attr->attr.name, "gpu_mux_mode") ||
+	       !strcmp(attr->attr.name, "panel_hd_mode");
 }
 
 static int armoury_wmi_set_devstate(struct kobj_attribute *attr, u32 value, u32 wmi_dev)
@@ -403,6 +404,8 @@ ATTR_GROUP_BOOL_RW(mcu_powersave, "mcu_powersave", ASUS_WMI_DEVID_MCU_POWERSAVE,
 		   "Set MCU powersaving mode");
 ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANEL_OD,
 		   "Set the panel refresh overdrive");
+ATTR_GROUP_BOOL_RW(panel_hd_mode, "panel_hd_mode", ASUS_WMI_DEVID_PANEL_HD,
+		   "Set the panel HD mode to UHD<0> or FHD<1>");
 ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID_EGPU_CONNECTED,
 		   "Show the eGPU connection status");
 
@@ -416,6 +419,7 @@ static const struct asus_attr_group armoury_attr_groups[] = {
 	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
 	{ &mcu_powersave_attr_group, ASUS_WMI_DEVID_MCU_POWERSAVE },
 	{ &panel_od_attr_group, ASUS_WMI_DEVID_PANEL_OD },
+	{ &panel_hd_mode_attr_group, ASUS_WMI_DEVID_PANEL_HD },
 };
 
 static int asus_fw_attr_add(void)
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 24d448b6b9fe..adbc4e0e7576 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -76,6 +76,7 @@
 #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO 0x00110019
 
 /* Misc */
+#define ASUS_WMI_DEVID_PANEL_HD		0x0005001C
 #define ASUS_WMI_DEVID_PANEL_OD		0x00050019
 #define ASUS_WMI_DEVID_CAMERA		0x00060013
 #define ASUS_WMI_DEVID_LID_FLIP		0x00060062
-- 
2.50.1


