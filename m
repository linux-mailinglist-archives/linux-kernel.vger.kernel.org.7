Return-Path: <linux-kernel+bounces-878269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A98B1C20243
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0101897216
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CAD35503C;
	Thu, 30 Oct 2025 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uw74WCFx"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857434D923
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829417; cv=none; b=ktKccHwX6QrRRfKV05o4nmaLQKwvKT+T2sw1MKP2N3D7aOm6Nj1Rxp5oAi+3CXdAZ+t2+nhhI8yIV/NRal1FtFuiumDHVIOs2XINvN7zMWTFryA48U9DIveGEtVxbKYOu9YVLB4OdkQmlRVhLGpGZI7gTGDdE5iIq5xkbaZr5OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829417; c=relaxed/simple;
	bh=R9mAF6qLE3YCxZKPeFZv9fkqWAFDMuDhrDSZ/tKnSYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1FccbYo9LxY70SLVBKQs4smyZTh06UnKT/folnhXh3RfiRYMNh7s84yfIXQROxWjTx926/c56RYZPQJjBSoorNrXNjrhVWvKtWQPwDDPbnfKH/odzK/pkn8AO01DiwG2zpZWHCD2ssQaT9FOscmkInbl0JN1TlKT30vxxlgIoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uw74WCFx; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761829412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mo5klVoZiXmYYC0XYgbuZT7b0s5kcvmrxtFfaQHdw8=;
	b=Uw74WCFxYP7pVphio66rGxgzWib4MqDotR9AfXHAqot0wwIjCVdSGtY8xZZzY6aDdsa1B7
	tAtfUKRBwKISH1Z80II5rcD0HkpXvbpF9LkQFbrdD7nQQ/wsCSEbOhXYToUW94HeZ48ZMP
	b06H5NUFqEQrccYH611kpyXloZWs/9o=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Alok Tiwari" <alok.a.tiwari@oracle.com>,
	"Derek John Clark" <derekjohn.clark@gmail.com>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	porfet828@gmail.com,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v16 3/9] platform/x86: asus-armoury: add panel_hd_mode attribute
Date: Thu, 30 Oct 2025 14:03:14 +0100
Message-ID: <20251030130320.1287122-4-denis.benato@linux.dev>
In-Reply-To: <20251030130320.1287122-1-denis.benato@linux.dev>
References: <20251030130320.1287122-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: "Luke D. Jones" <luke@ljones.dev>

Add panel_hd_mode to toggle the panel mode between single and high
definition modes.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/asus-armoury.c        | 6 +++++-
 include/linux/platform_data/x86/asus-wmi.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index c5fe61557582..20edf4f5370a 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -96,7 +96,8 @@ static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
 
 static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
 {
-	return !strcmp(attr->attr.name, "gpu_mux_mode");
+	return !strcmp(attr->attr.name, "gpu_mux_mode") ||
+	       !strcmp(attr->attr.name, "panel_hd_mode");
 }
 
 /**
@@ -600,6 +601,8 @@ ASUS_ATTR_GROUP_BOOL_RW(mcu_powersave, "mcu_powersave", ASUS_WMI_DEVID_MCU_POWER
 			"Set MCU powersaving mode");
 ASUS_ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANEL_OD,
 			"Set the panel refresh overdrive");
+ASUS_ATTR_GROUP_BOOL_RW(panel_hd_mode, "panel_hd_mode", ASUS_WMI_DEVID_PANEL_HD,
+			"Set the panel HD mode to UHD<0> or FHD<1>");
 ASUS_ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID_EGPU_CONNECTED,
 			"Show the eGPU connection status");
 
@@ -613,6 +616,7 @@ static const struct asus_attr_group armoury_attr_groups[] = {
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
2.51.2


