Return-Path: <linux-kernel+bounces-760517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C7DB1EC53
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FBA18C514A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDB8285CAE;
	Fri,  8 Aug 2025 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="KYjN7iNa"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8304D1C4A17;
	Fri,  8 Aug 2025 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668105; cv=none; b=Gn6/5ufTa00qA53YuFKKcJBS5+cH/g9oIdlF/WRrOfbnGZkGoyicR48Yv2oXRJb/FG7i6VFydOZEl+2vTbIJaI0ayddLtnXELRE8lR+Tb8zzzxxtZpQtzVF7kVh2xxUZ0KNjm9RaoGD3V2D21p2P8mhzXKSWVesFo0Y8AvNmXP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668105; c=relaxed/simple;
	bh=BxcxdD+6B3ePEG6o+deXsXhUyLLBmCLw7GUpLlK5FB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbrGPyQfSfkawyJ6FwBghudlLcOqzAOoTgMnGVfT5MIjMZmXv3rW6WqH9nO9vjz7KqdWoY8n0QY25K1mO2M5QnjVHLvw7TUOU8XU4pJ9gO1hIKbvFj7q+vkXdtV4+A2BIMInPs2PP0pQDZns2tihoaF2P/Fc7MOuh3XzTeetz0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=KYjN7iNa; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 6962C485E1;
	Fri,  8 Aug 2025 18:48:13 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id BE9CA485AD;
	Fri,  8 Aug 2025 18:48:12 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a02:2149:8b54:2b00:4bbe:4554:f657:4bd5])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 6C65A1FF5EB;
	Fri,  8 Aug 2025 18:48:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1754668092;
	bh=1pisc8itCupEC6yF0QbAx3+tWiL9TopVmvOj4YdlXZ0=; h=From:To:Subject;
	b=KYjN7iNaAlXF9Su2aiqEZtBlTeq8TOnpX+S5/JnnQ/I+M8fn50asvo3feVJSOX7GN
	 JHuPM2bRAtZU0AZrFIoZbeSFZ+R7RdRsDus5lDYo2v/o8ljjitDNqcJXwjVHl1MXnr
	 Kc+lXZ5VyZGhuj9WWqJbnbn90rNYsU1O9WL9GxbGCpLRPX87HtKJHaAAw/8jrH9YE1
	 nTxYxc75/iv/nHKHfLRWacd8yW/Db92SlWXTs5FCwdsrNAFBgIQZVCg2Yyg7bgLE7K
	 r+GfXoDmKT+6fkKqV59zVB3Ys6Gq8dOVlv5rQhRkaqqbW0uk/wE45AcjnRt2bWuxjg
	 +5RujAwIxtHHg==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a02:2149:8b54:2b00:4bbe:4554:f657:4bd5) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Mathieu Fenniak <mathieu@fenniak.net>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v2 2/2] platform/x86: asus-wmi: Fix ROG button mapping,
 tablet mode on ASUS ROG Z13
Date: Fri,  8 Aug 2025 17:47:10 +0200
Message-ID: <20250808154710.8981-2-lkml@antheas.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808154710.8981-1-lkml@antheas.dev>
References: <20250808154710.8981-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175466809231.1696274.15961524146752800610@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.0.9 at linux3247.grserver.gr
X-Virus-Status: Clean

On commit 9286dfd5735b ("platform/x86: asus-wmi: Fix spurious rfkill on
UX8406MA"), Mathieu adds a quirk for the Zenbook Duo to ignore the code
0x5f (WLAN button disable). On that laptop, this code is triggered when
the device keyboard is attached.

On the ASUS ROG Z13 2025, this code is triggered when pressing the side
button of the device, which is used to open Armoury Crate in Windows.

As this is becoming a pattern, where newer Asus laptops use this keycode
for emitting events, let's convert the wlan ignore quirk to instead
allow emitting codes, so that userspace programs can listen to it and
so that it does not interfere with the rfkill state.

With this patch, the Z13 wil emit KEY_PROG3 and the Duo will remain
unchanged and emit no event. While at it, add a quirk for the Z13 to
switch into tablet mode when removing the keyboard.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/asus-nb-wmi.c | 23 +++++++++++++++++++----
 drivers/platform/x86/asus-wmi.h    |  3 ++-
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index e6726be5890e..6928bb6ae0f3 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -147,7 +147,12 @@ static struct quirk_entry quirk_asus_ignore_fan = {
 };
 
 static struct quirk_entry quirk_asus_zenbook_duo_kbd = {
-	.ignore_key_wlan = true,
+	.key_wlan_event = ASUS_WMI_KEY_IGNORE,
+};
+
+static struct quirk_entry quirk_asus_z13 = {
+	.key_wlan_event = ASUS_WMI_KEY_ARMOURY,
+	.tablet_switch_mode = asus_wmi_kbd_dock_devid,
 };
 
 static int dmi_matched(const struct dmi_system_id *dmi)
@@ -539,6 +544,15 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_asus_zenbook_duo_kbd,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS ROG Z13",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Flow Z13"),
+		},
+		.driver_data = &quirk_asus_z13,
+	},
 	{},
 };
 
@@ -636,6 +650,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_IGNORE, 0xCF, },	/* AC mode */
 	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
 	{ KE_KEY, 0xBD, { KEY_PROG2 } },           /* Lid flip action on ROG xflow laptops */
+	{ KE_KEY, ASUS_WMI_KEY_ARMOURY, { KEY_PROG3 } },
 	{ KE_END, 0},
 };
 
@@ -655,9 +670,9 @@ static void asus_nb_wmi_key_filter(struct asus_wmi_driver *asus_wmi, int *code,
 		if (atkbd_reports_vol_keys)
 			*code = ASUS_WMI_KEY_IGNORE;
 		break;
-	case 0x5F: /* Wireless console Disable */
-		if (quirks->ignore_key_wlan)
-			*code = ASUS_WMI_KEY_IGNORE;
+	case 0x5F: /* Wireless console Disable / Special Key */
+		if (quirks->key_wlan_event)
+			*code = quirks->key_wlan_event;
 		break;
 	}
 }
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index 018dfde4025e..5cd4392b964e 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -18,6 +18,7 @@
 #include <linux/i8042.h>
 
 #define ASUS_WMI_KEY_IGNORE (-1)
+#define ASUS_WMI_KEY_ARMOURY	0xffff01
 #define ASUS_WMI_BRN_DOWN	0x2e
 #define ASUS_WMI_BRN_UP		0x2f
 
@@ -40,7 +41,7 @@ struct quirk_entry {
 	bool wmi_force_als_set;
 	bool wmi_ignore_fan;
 	bool filter_i8042_e1_extended_codes;
-	bool ignore_key_wlan;
+	int key_wlan_event;
 	enum asus_wmi_tablet_switch_mode tablet_switch_mode;
 	int wapf;
 	/*
-- 
2.50.1



