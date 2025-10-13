Return-Path: <linux-kernel+bounces-851143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 068F3BD5A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C775C4E2A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974712D3EC7;
	Mon, 13 Oct 2025 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSjS5rCj"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55782D248E
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760378767; cv=none; b=lQB/n0gITPlNp3N+2CD+6bhRPJLaTzZM4gaclvH23s7E6ECWVmshK6HRZT1OemWalTPySzTVujS1BHQHVKflPvfiZIJnewxS8whZvndGYVI5wA9AeAbAR2ztopdRnOqOeR7pvUddUJe4Zg0XJ1fEcTjWXAnBdS872qhnOXyX+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760378767; c=relaxed/simple;
	bh=TbswgXQwCCTmzsX3hGAnNwHOzR/5QSN6bjAPmQkfsmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VK8QkxqplBKXCAcwChRwW3q0YcHdd1EuD+/arm0Uiel5cl1MmyeGPbXRALxLzWTnyvT/CQX3BrUvL2u71MAlIbVus+slWDIImwYb/iM+wRS10YnAyALDXOaZjYZvFtkyoxGS80nwfalgFp4RtJbq2WzTFTEbIwq6kujqbv4DDO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSjS5rCj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso3590727f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760378764; x=1760983564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txV+xh/18MrOzYRQN9sCc73WlopP1Drxah2geRIuTgY=;
        b=FSjS5rCj33mirLI3LPJg+ZZIXs4puMXe0d4x48SQmr/A1+FRYRTe5JdziokqUTuEth
         Rkx04uYg0AH60ZGFQetO0CQDijs1c85aQvG5pNASTkYkR8HjR5S3orNK2/pXavtiyUel
         ezy8CZhmK8VXPJS4XeCpw7PM1Bd2lRpQcnuVagcDh/cJAPb00G1WvCxH7n9vBtgtqJ3q
         xdLKH9wjJ1BxUeBxPrZ+79hwnZqwQqXlX+BwtQXKQFz2YA5/cy6sS1orkCmhQku6B095
         ayGUW6TJPUeX/+F0eYlsQtONuvvCxnR78B4bS6zN8md9MbYnVO529b+Wbtx0glUPP+Ll
         0MMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760378764; x=1760983564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txV+xh/18MrOzYRQN9sCc73WlopP1Drxah2geRIuTgY=;
        b=rsElcinqjhe5qwGQ6HrzVs+h51z18wc/l/sVY75Dc6FYbBYukP5mFl0TZ+N+ZEmHxY
         OemuPRXnj04GD7j5KVC+/3SsE41dPvR3pPGwKfeOS/zlSEN7wVW43GRo8VbenVd4Y/Qh
         wiPV7GI4j0abAtlw/V3UiA8Js+mdI0LCVfEWnhFHQqOabie66aOY0NJY+CMdz38bwjMD
         rCrsKnTH1EZmnuktFhCAJO4lQq6FTsutPxMhYYSL9HwuHj2PjaWLwA/Du4ADJavh0sbe
         5bxyihE+rxTxYdQEL+C2bkVqQySFbrY7Treg077D0yc+h2gHDQqAv2wgK5PgAtlUdC+r
         Nb9w==
X-Gm-Message-State: AOJu0YzlAGK6r8fUdmA4tvfqZzb1O2EBvw139qluTJuzHBQZL0miWH2z
	uf8pIRPFWV8+A1gyvD264E/i23/zCEEeODR4NEo4aUbD8G+0tuUvVo22kxvc4A==
X-Gm-Gg: ASbGncsv+gTB07Qa3JMpFrHJ2O9uRGAYKahYZZEaxoNzA0hmKXDFNyPRN75TGf10/Fg
	x/qnS96S9Dde1XLhFbPDRydmmdoYsxwA4/bprBL7mKmy1G8HlJXHMjjI86eARwfshUy429K2EoN
	HxxwFjrgLkI93gXEGA+/8pClQEtdIgyYS40z/1q/NfyfwZNwTcSVYMvEY5+R2Y9tUYLF2gF9wTO
	LR18TkwySUSv92TgR4WWN6c+uI5Igvcw5e52QqxTaL/ICnfm2Hko1MQLMFIMsaZU5svJisFv8nN
	bCk5sw53aVAXSp7Cz+doFhbVjZktB9RrXf6cfdxdWJ4pQWuOsifBO//Ja7xoNhJKY59N2mcceiM
	WO46l9XwjelMPIkIiRgWMHIqFO4FH/n8N8USBxvve0CN14A==
X-Google-Smtp-Source: AGHT+IE2I9xORwtrK2Nu7nQ1GfoRfwgnIUo+IlSIPD1ojVpvyKYovXwUWxmEbOvJzHN2uTTqI/lKzg==
X-Received: by 2002:a05:6000:250a:b0:402:a740:1edd with SMTP id ffacd0b85a97d-4266e7dfeb4mr15484754f8f.39.1760378763722;
        Mon, 13 Oct 2025 11:06:03 -0700 (PDT)
Received: from denis-pc ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce589b3dsm19933428f8f.24.2025.10.13.11.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 11:06:03 -0700 (PDT)
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
Subject: [PATCH v13 6/8] platform/x86: asus-armoury: add screen auto-brightness toggle
Date: Mon, 13 Oct 2025 20:05:32 +0200
Message-ID: <20251013180534.1222432-7-benato.denis96@gmail.com>
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


