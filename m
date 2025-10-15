Return-Path: <linux-kernel+bounces-853582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF03ABDC09B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBDD3E5E96
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E622FB0B5;
	Wed, 15 Oct 2025 01:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edu9c7lc"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D262FBE1A
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492984; cv=none; b=CU4gOJeE/Aa0gg5NBrxHxXUBm1cN9HLhnENh0g3MMjpuvrIuKf2oIe6wcmH6I2MEJaMsqqiS98Vij5RIeOCX8awcUCQbLSAGC+0r9b4GMmW+kfPSyPvhm20h0FcoWEFTSNRqz1GffNniRhAlsBLVhR3o0/SQ2As8gVCXEw3LoNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492984; c=relaxed/simple;
	bh=JCk7VqzZDm0N9em80Jlh9Edcp6PBHzBN9/7plUWcVDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6eK+04fyYwMaRrxCaZlywaYKFvJuDHG+6iHoaH7MTuElNLS/uWZTrjHokshFrPw23mpi2DPxmCTSAriF9qMlWGRaRdgheAfaPZhSd2kTnUpDv06gaQmoLiKs0RoLxoY+7GQ9H0rjDYu1dqDFW89D+xTjeC0LxfHc3Voyg3V5dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edu9c7lc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42557c5cedcso3211029f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760492981; x=1761097781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Fxy/cL1NOLAJha530jz1vfM7F1ZmkTYxBgTPvWr6HI=;
        b=edu9c7lcOrcu8nEOVf5OEvvp7ub9T/GOcoEmGCR+6nDiNTYMwIiL6Po9wn/mmomZAT
         zkPNojfz9aS+MqZE1TkRWWxwSee1aTUSbc08AaAB7SjF1YL9GT1FlO2/4Tlkr/63FsuU
         dR2gnIgQfvgw+lyVWWD2he49uXKbheoRwS5X0+AjWjYH3eQ5Y9VnSwZ+ypv9yLc5Zmj3
         tMNusFuRpbi6Eob/DscdDyy55nS0aVTAGX6mAKXpCj0D9/0a795Pa0efzOOKPmyFRIcX
         HA8l/IaHiw41J0noHro23+n4M+LlRnH8UCo3FtNWiHs3EV1vkqHjR4bqlt3oMNEf5AwT
         q0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760492981; x=1761097781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Fxy/cL1NOLAJha530jz1vfM7F1ZmkTYxBgTPvWr6HI=;
        b=Jp+RqNMEqTNMsfyEzLc9LG3LJtVhtJxpn5Jq7jdpD8gzfJDPYUj87Ql0zfFRV2hHUb
         QsOYRPuKhVZGz0ZTjfoPHDDbhbT4GzyfJXfYiVhsYoF2EFz5SW5RrL4624GsZuOEcr84
         RwiaYIut0+z13Fg0lFyyzPktOVvbEtBVp2pVYwzRVlowX/7kNqD5PPhzzC2NnaoVfY9Z
         N30+c5gNEwFIAx7Ezqi8ltjrD5QkyzkazyexbcV4nPe51ByxqE5H3r6sRMEbQkR+kvCU
         Ni35zU2BTtEMCmOAGaNr+bT16KEOrpLtMRcdYMEUIRGLPQrYAsK9H0ukyBOmRm27QQHf
         LYqg==
X-Gm-Message-State: AOJu0YyU9f8WGL66vzeQURyQYA3maIch9qDzi6dtwlp996QQ33Pp6Kjp
	0uUNeHsF21ZWM9shBDA2mBCdfsg0lAmcVszqsELDjoJ/mvtzCWitvx6pAM9q/w==
X-Gm-Gg: ASbGncscOqjm4WWq0ccCNcAownl23a5LBRZ0A4buAtze30zug24givmhHj0ubi56FmR
	+/sdsbrnFltDe4E0aCb4heB7ZWNfiFH29OuJ6lGcLvgkmEIB6ufHm+vA5zvhV93AQfF3JWu3tnG
	6abm4UHG9yHSscG7SY2pYy1HgpP2vqUnCcprnujyrMT/W0Ibmq3mSgVp0Ayb56OcId/JMHB+C/F
	FWMEbo9bfRecHHuqUhbIXpoK93+oFS68S/ks+RqZGJC3HCeV8VP7BkWuiX7J/QfvRlk9De1xwt7
	D2dXMheZEm068TmxlRkxefEETEjTcoPxaUJ5ADdNSPqxeywcddbcUSGx5lfMl+8opls4G8BKvsx
	U2EhQDnUCAK6ViqFzjpqSKwL+CeE/ESHQydRWMhvmI1FqPg==
X-Google-Smtp-Source: AGHT+IFPE9i3YnSnYkGk+8WL8qcYOO8XFGnUtR952/JUmTXbwxSCwjFj6JYZncS6crsmwS9AfuzdCg==
X-Received: by 2002:a05:6000:2388:b0:425:8255:fedf with SMTP id ffacd0b85a97d-4266726c31fmr16505848f8f.23.1760492981296;
        Tue, 14 Oct 2025 18:49:41 -0700 (PDT)
Received: from denis-pc ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d49bsm27368995f8f.10.2025.10.14.18.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:49:41 -0700 (PDT)
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
Subject: [PATCH v14 3/9] platform/x86: asus-armoury: add panel_hd_mode attribute
Date: Wed, 15 Oct 2025 03:47:30 +0200
Message-ID: <20251015014736.1402045-4-benato.denis96@gmail.com>
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


