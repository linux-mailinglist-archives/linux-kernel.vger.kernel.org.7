Return-Path: <linux-kernel+bounces-851139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D5BBD5A45
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E04FC34FA40
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F9E2D2489;
	Mon, 13 Oct 2025 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NexCQi08"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FB02D0C95
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760378764; cv=none; b=MOBPAclMheAonUtAiw/PHF4Ac4ap5tOMY3dgE0RAsB4FbCjqBo97+r5eMiPkLXUAtABBhkyLlHWk10U2QXWP/90wlixDh8M/dy4iCW8ZEoup7veXfIinXVY/Gej/NNUzz9Mp5ZGYW0QZe2LzMM0Ui78VW/Jx6li8l9hnl7U98ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760378764; c=relaxed/simple;
	bh=JCk7VqzZDm0N9em80Jlh9Edcp6PBHzBN9/7plUWcVDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAMfiJw7z/OoWITpGvCwYQ1hmpHQHooVDeM12CacAjW4HUidv2T1NK2/lIE4R/62VfzckSpLgfj0W5DpZVZj3MNUZ2HiNXkeb4rvcVyxkSimlvACUETmh8h/fQvMKLq5woC+/eV5sWECbtD0Ne4rgQCfRGvnc0IF4u7RTMpkRGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NexCQi08; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4257aafab98so3831401f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760378761; x=1760983561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Fxy/cL1NOLAJha530jz1vfM7F1ZmkTYxBgTPvWr6HI=;
        b=NexCQi08x/FZYSZa/mtyE2svonHF5EeSUFD9AF5lvHTXmv7fLjwRyKyuMMA0wTYvwR
         qVfEr5lc+6485J4k+RQocrwiB5Rb0GfKVNZknA57u1yZTJlP7SDMygvmbxDfFI8F11BZ
         4Mgh0P+I5rX1Wdg18ACHtbjwyArmJRgqNgQDC3hGOhV0Nb/tIfKUagnbs5rmCkXnf0rL
         EKFJH+wsO/usu46IvKv9DH7MSXt2N3GuxBc3wM0CllhzYP0GcyGoeG7Fe+SPUzja5U9f
         GThbZsG3BR5OptyfU1nq0zYJGrpKMcby3qLiwsjxL6od8f8n3GtNiLO+aqDkiNiamD81
         TBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760378761; x=1760983561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Fxy/cL1NOLAJha530jz1vfM7F1ZmkTYxBgTPvWr6HI=;
        b=XPFdjT5ogzgP5vEJqNvFhSekNMjIFvAiD22/XOjzJ2q5wBZuYYkWLbw+AfDjjWIKrs
         H1GxekVzYxzjL8q3gimVuSBzqk2qIirTB7pZ/Y61OMz3F1i3U0N3bac6Tv21QPuYwl9P
         kwCUyYqKVYGJG1SF3h2zvII4PPChVlS9odfIvt/5S2wKxsI87EzyAyt4mAHfQujnUeJU
         jrNsxrAWKAxu7CaTAN2+04lTEwdMPEO5Z/XDjJyqCMGAsZSnQPgR+OJ6iMGoeGt2XXpy
         86GqCBae5Dw0r3kLnYDLn0CrMwUKgTUQh7ECHwTOmVY56OKg7s2wLON0g7vRbOKGe5PF
         jmyg==
X-Gm-Message-State: AOJu0YzkJdhCdUQli5LNZOdBjEP4s6pS1VMZR/YmDeI6p5WD4a4gn46C
	H7qNQe1t4tKQ8OrnCNwnooVMYnFhiTTH2fz8E+SH0I/d+1UsVKgYuIC7N/JluQ==
X-Gm-Gg: ASbGncuG3Wj66wuV7ep6lrL1MLGIPhbU9he1OU/44TyWBKrqWA4vpBSG4djKzl1Y+Qn
	x+j4qlaPpYpaUlU/Oa1/NBObXKPsocWwi7CvZ4dTAYTScZv1okBAXsIu5Ep+O16UBwhOJT8Bx3G
	rtChAivjp+GkdftR8FlE1a+EVmkS33NTzcrRHaA47/9f+ILLMzDkn9BS66Y38Xq5m+dGfDBJoGn
	Wn83bivq4DDmJWpHmTi6MA4JvguzwxQ7+dnzzQQ8CBK5Gv4pSJ63lGkqgODzoCKOhScjP3QihKA
	DxhcW0aqbDpEHcBQScTuQOh7lwCiC9gPY7EM78qrmQI4pyMyJN5qqmAzqUGxydW4idbQUZdGrVO
	GDFviBlgbg0D9yzcVsOjMsLbwaFlL1oxdSr9yUkKfj1itpjWfvDEWTOE79ZnCSkhQYUc=
X-Google-Smtp-Source: AGHT+IE/Piq4iUI2yyiBoQ2SKW8waFEfQdsOU8j81sEVmDknFR04+8+MVQjit1d6dVH4bXCYkY18vA==
X-Received: by 2002:a05:6000:603:b0:407:77f9:949e with SMTP id ffacd0b85a97d-42666ac7026mr13525477f8f.21.1760378761225;
        Mon, 13 Oct 2025 11:06:01 -0700 (PDT)
Received: from denis-pc ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce589b3dsm19933428f8f.24.2025.10.13.11.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 11:06:00 -0700 (PDT)
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
Subject: [PATCH v13 3/8] platform/x86: asus-armoury: add panel_hd_mode attribute
Date: Mon, 13 Oct 2025 20:05:29 +0200
Message-ID: <20251013180534.1222432-4-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013180534.1222432-1-benato.denis96@gmail.com>
References: <20251013180534.1222432-1-benato.denis96@gmail.com>
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


