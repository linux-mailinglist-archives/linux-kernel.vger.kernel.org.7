Return-Path: <linux-kernel+bounces-861799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D2CBF3AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 749254FBF35
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3660A334689;
	Mon, 20 Oct 2025 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQ9GjNb4"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87708333755
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995085; cv=none; b=WtMC3jtw7jqzli+CZe3kn6sdC/s+ErGQCM9wFl66kAPp6oGNGtFzcDB4Yt+DgE4AJ7HQhGTW+7WEKYhuGFn/T2RTNfoBXCocNpCZqcoLcXLDtjTE+EOycBfi5TRDGmbwwW09LYzS2D34b5mKGanC4IKXGDuW5uO9+OJVPbMWo50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995085; c=relaxed/simple;
	bh=IUe8CY/Lm4LqDKi0P5EID+TradzYFT1Di8fc7InZTC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ig5CA+z9+2eyE2jlz9m6uaQCKBuaMKX0DWXBEKh0oTRN88IiY4OWZOHHnyxJ62BVjO0G/9o0UgMtg3GYFgOV2+NACYBxDXG4M+/IMIF5i44waeFzCyPkx8msByD1swifF60aPYZpki/+6dJQBdWX5UPvWBEXIF3jt4Wo2mEZsx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQ9GjNb4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4711b95226dso35733345e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760995082; x=1761599882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aJ+dhLzBqzw1XunhXi7lUbfSsyrtcVJMPwmoabXwKE=;
        b=kQ9GjNb4RtavcGil/YPFAFBr31Ac3b9u19cB3kkbkuMIVNRR1HmpikqxgVLvQj/lJ8
         Ssg6GBvLWDnYadL89IYYE+75xUy3R3lon8FaLrGCz/7ibgSvSDsGfe/aPlx0ED/Mu8Bj
         qCVk+rPksIf/RmGwQSUy6WwEtkEyxK3w+c67Y9/kQElJDPKwLQr5sannAoFmxEXG3oYv
         rN39MPm/n6GrhhlOz9PvXNnSBdq+l44j34WNphvyuWaO2YaBe9ahwcHFRPECfJ3N7ye+
         QMXTZGwHI8Su3kI7IYKCY5hO5C47xunAaaFkPFd9YZ0KQxdHDj6GBPy8pIhpAi20Jby/
         29Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760995082; x=1761599882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aJ+dhLzBqzw1XunhXi7lUbfSsyrtcVJMPwmoabXwKE=;
        b=K5tuMxBQcBSxPTxQJx9ly0ddKknyZCUA+/xxzkExC3tj3x0Gm1i+JazVcfQi3mrhBp
         dtHeRYyKVz1iFPmvvuhW2fKfZI3JIift0T3mlpdOfZtB6zj7nRDeGyJ+clUZuh42vq5x
         1sm8X4JnyLWUrtWHp5MFKPCdTS3UAx1MIb573Sl9p92OJhlcgFjyPvmM4dH2cuRD8eRP
         mqVhtc379DOUplGuiShjGmGMlAiJ9FsqWPBERx+YhnzzH/D/lawY6Jrif7uvicb7GP0I
         5ZjX0hFoWB3mhX9uWjsFEEsB97lWDgANJCNHjPoAhJMy6HGnazgbWxkYUH0nbeDeWTT8
         c0vQ==
X-Gm-Message-State: AOJu0Yy83pQHdIH3EUjpItrKIoPsPwg1OwSVSAI5vhrK4N9z/YtR97GD
	FYdEtAgnuahmfsFvHfSwfmDHEcIMlTqwmr7NaQO1Ax7iJiTIcKQkAnsnB6lDmw==
X-Gm-Gg: ASbGncttimifK2O3ZVj4+oLMIRr+Vt75vCDjSAC15Rr/plO7XlzS75I9i6HsDGtqy26
	6Cxsn6p7gApeD9deaRYpM5gndu++ygTuYntkCnUWkQ/bkZ5mqkv21EvZws2UUUTHymQR0qcS3wR
	KF7Wqd8z/BC5K7eEAd03wivViwSoDgVXcp9Jpo3uwWn3tjVcjwDu3rT57YgDCShmcEDN+kd/uBF
	pglPiyggV+jeoPBWjYtu9NiTOhVl290R9cXc/XA373bifmjVGv8pixD/Sq/aYXji2X5PRYPvN0c
	olRFptaf8+7UBzpBr7bhEjc6ot1wku3wN1ebvwQ9SBOGylbJiN47DPUNMdxeub+ZaXWM/BlNTnH
	kTag5BeRE0eEva9JORsSReTN137qG1v/avJOItbMNzEb9aqxAxzfvDq01XfqABCfdjm0jBd9C4+
	w8Dw==
X-Google-Smtp-Source: AGHT+IE8NTSTXGy9JVF847QjoXFPJXHadskUMaLuPIb15N28TJHgBCaBwGQRppvT700gsNt3+NBcFg==
X-Received: by 2002:a05:6000:2209:b0:428:3ef4:9a0d with SMTP id ffacd0b85a97d-4283ef49ed1mr5507547f8f.49.1760995081544;
        Mon, 20 Oct 2025 14:18:01 -0700 (PDT)
Received: from denis-pc ([151.49.75.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a976sm17254971f8f.32.2025.10.20.14.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 14:18:01 -0700 (PDT)
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
	porfet828@gmail.com,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v15 3/9] platform/x86: asus-armoury: add panel_hd_mode attribute
Date: Mon, 20 Oct 2025 23:17:34 +0200
Message-ID: <20251020211740.719676-4-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251020211740.719676-1-benato.denis96@gmail.com>
References: <20251020211740.719676-1-benato.denis96@gmail.com>
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

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
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
2.51.1


