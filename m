Return-Path: <linux-kernel+bounces-841658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC85BB7EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8294A48C1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179242DFF12;
	Fri,  3 Oct 2025 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkujKlcZ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB092DF15E
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759517742; cv=none; b=EXI+q2qjlMu2eJDR3Q9G4zYHa1NLnfg2PyXadv4IPz6k6Hm3Nb7e/2J4KaFru4th3tEUE+TSj7rvj6DJCcC0Sycioj947ZTUe0qvcvSPNvZ19z0GXqXgZipmGXv0sO05hV+FwKbdMav8KqQjU0vdBQzxRXcZVgDlgJNafthKuZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759517742; c=relaxed/simple;
	bh=JCk7VqzZDm0N9em80Jlh9Edcp6PBHzBN9/7plUWcVDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bt7ukUGMvHtvEr1w5AvbW+Ef107CE9jr3/uxWprsq2jBMFLqT5UnEbZa20q7HPpvXAY0P4/4l/DxF5t4q32DkSef71dON0o8CYSJ/iKFqmBVQ4hNMGmPAU9PDHR3uVxNx33ybSrzTodO8cf8TvK+lPv9a2Ng8Z5uIIu7czHUjGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkujKlcZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e542196c7so21151575e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759517739; x=1760122539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Fxy/cL1NOLAJha530jz1vfM7F1ZmkTYxBgTPvWr6HI=;
        b=SkujKlcZ444nCHDWiczLu+rKBNh6z4rs7hRKkRt79Zoa0WRb7BhE+QZbWAxS/BS5hi
         B9P6vV0p/DDmfAUyadcRMQLqp0qKXMppKHr6T09MuE17ERB3OawVNJdqnhsX4yeiTAbM
         Xk1sq6AHqKFKeEBy7G6Cv3JWhgkwKuXnXcua3tPilZc0fEgqE21ponmyUxTTQvm7asOy
         ePbT53KNzGrO8kZlXk4wVYJTbV2tkiEthfVgVstDk4TSdZsTdW+NR4cXWm7Q0upttlap
         s+uuqmdqftjrBmifIIIZwWhC28ntlZH6rRDxugGfxp0PqU9LMHx5chNQ4eDXHkJUktep
         b8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759517739; x=1760122539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Fxy/cL1NOLAJha530jz1vfM7F1ZmkTYxBgTPvWr6HI=;
        b=lHktytZHlfjoDVxMtkcw1up4e6UO4iqQCjzNi7fNz04jp0j1ap8qq5vYehQfkatboY
         V9bjcZlJihZ0VLrnzeq3nJR+8VRy9+HuzTgnQovepv8xzEfzYHV5R+q9SAtNIguRBN90
         4LcJCvWHCVDA0wAvS4ARAK1BsUxZ7rCjfetyPNn5dC1BbjlrWgSYrWvx/ouFjO9hOg01
         yLznv1/p26hWq/2MEz7CEz8gyZh96DLsm061B0hxV2JMKO0VNdz2iyZ2m9QfvLLHZ4Ih
         aJQ0w3JN6jD9uzQ/to50tXvB4nixWpHWYHcS3PqVpztW0b5iNd/qUETWiYsftlXaHI+q
         mCNw==
X-Gm-Message-State: AOJu0YywN6/AFn7vOBF63ZvDiDxX+eiTZ+911IEqOZXF3LAjnZB+DlZT
	1clz30YLhPO/FysA4n5Esh5J6ScemIxgCNj/h39ap8LwUzljtOzT1V1vNjkOTpO0
X-Gm-Gg: ASbGncss0WeNTeCvgOMerZkOkqF/xMgYW/x3hZrYeki42YsMuQnDirWQhYJkzEpYwJf
	pmA8WLv3I3RkkifKO8jX2foAbGAx/X4KNPlYe/S32+9NbrDwFuzr/kBotKQlQOzwPNNnwjl5L95
	a1WxItO4p+Q3l2+DMBvBMFmtKg+8in8ZOFq4lvZTzNEvRR85WoFq0FLSw4HbS1SZ2P3MCSyHgdh
	4cycaYXtSxjYaYk104UUj0JMFlc4obw3p5fvKHAYov3zMSviBLDmySKt4cVbEZ2k9Q55MVOioAk
	e10OVTZpdirIAU3B7A+gneadKPNrh5Ja4L4HJmFFG0ZlArhNvNZqXEVzjrG/+SX/51wyE1wmYKm
	27/FqMq8Iy/PYYy4DbaA/uQHNqJk/7opI+ukOF28ifhBKmK8TaUNee2qKr9YfmTP8P7aXN0X0
X-Google-Smtp-Source: AGHT+IFYFP078sRLCamY+MbXneSKWbxK4prNXYDUkjO0MDBhgDCDp2ldzZac5f7foMrbwM68kfavYw==
X-Received: by 2002:a05:6000:4023:b0:3b9:14f2:7edf with SMTP id ffacd0b85a97d-4255d294cdfmr4898051f8f.1.1759517738878;
        Fri, 03 Oct 2025 11:55:38 -0700 (PDT)
Received: from denis-pc ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9762sm8946927f8f.38.2025.10.03.11.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 11:55:38 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Alok Tiwari" <alok.a.tiwari@oracle.com>,
	"Derek John Clark" <derekjohn.clark@gmail.com>,
	"Denis Benato" <benato.denis96@gmail.com>
Subject: [PATCH v12 3/8] platform/x86: asus-armoury: add panel_hd_mode attribute
Date: Fri,  3 Oct 2025 20:55:15 +0200
Message-ID: <20251003185520.1083875-4-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003185520.1083875-1-benato.denis96@gmail.com>
References: <20251003185520.1083875-1-benato.denis96@gmail.com>
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
index 71c68425b3b9..10acd5d52e38 100644
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
2.51.0


