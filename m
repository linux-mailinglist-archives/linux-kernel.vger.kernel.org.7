Return-Path: <linux-kernel+bounces-754451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DCCB1946A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 17:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F841894BA4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DD31A3029;
	Sun,  3 Aug 2025 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="kERBThAX"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE8F9D6;
	Sun,  3 Aug 2025 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754236653; cv=none; b=HsfmIuVjozleTd/K5MS2eAaF9w0rZJe3lGi6Mfi4tkhJ7Qhbpn/0H9WtN1IWK+2RsT+b2mO2EXaCMBmjODkL6HeImfzmGqnmlMYU1rRo0U4+thE1li0qUKMNwAX5TRPX+L+Dz4U3ci17m63W+HcbvIwgCLWvcJAiirti8BPzcuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754236653; c=relaxed/simple;
	bh=al7T1FWjMjwKmTbPUskG64KwUlk36RRLLfe/QwnpdSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kSNGVX5yiW++sqrRSUD+YZbajFvdXIMZJC7zTvDr8oQU8rJA9MllDTQeklhrGUfeP2yGJmK9PXo5V7vcV+x7+5XSUbqjy9quOLcUPlG4y7oqIS3krdHHH9j6gnc6L7syeD4eaCbujvwk1JOyZ4k6ILFDaB1qngKtgciFZpv8vCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=kERBThAX; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 9EA834723C;
	Sun,  3 Aug 2025 18:57:19 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id C5FE74723D;
	Sun,  3 Aug 2025 18:57:18 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a02:2149:8bf7:1200:9e45:7272:4009:7cbe])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 778F1206241;
	Sun,  3 Aug 2025 18:57:17 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1754236638;
	bh=41QSebEo3/mIImT1U26grahV4bUi6o+jP+UydpIaAE8=; h=From:To:Subject;
	b=kERBThAXTZBG63Gd7sKBQKxgB9OguQoIofCNtgbaQf8Ey3oK+7gR6QliSOIP7IZtb
	 x+CC61CZ+vbQOhBHRgKwaZkx7EZWJeb0GCB5G0kQ8gxtqq/sbisfaytpivli68vd5X
	 0APiPz8EALoiccVf/dMLnhcAM+DCdQcGTM+aW6WMDF1JwifflwHcmcKdbp+uZekyE/
	 ZZvXhYR9sPs2YEZpIkL1Xhb/iEuXYrid9xfFE6xYehOQoBdP44v6/GAAfooVe8s5DE
	 aOF0sT9/kg2Zh/WTZ/zPl8mMI8X7JEttJe8dL36ltdCQc596Ze0/o0PtsoaF2Urv3Y
	 P2wJ51H9/ZQng==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a02:2149:8bf7:1200:9e45:7272:4009:7cbe) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v1] platform/x86: asus-wmi: Fix ROG button mapping,
 tablet mode on ASUS ROG Z13
Date: Sun,  3 Aug 2025 17:57:13 +0200
Message-ID: <20250803155713.9301-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175423663835.1954383.1974489386598058323@linux3247.grserver.gr>
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
unchanged and emit no event. This patch also removes the override for
codes 0x5d and 0x5e, as those were added for completeness in the
previous patch.

While at it, add a quirk for the Z13 to switch into tablet mode when
removing the keyboard.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/asus-nb-wmi.c | 25 +++++++++++++++++++------
 drivers/platform/x86/asus-wmi.h    |  3 ++-
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index f84c3d03c1de..6928bb6ae0f3 100644
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
 
@@ -655,11 +670,9 @@ static void asus_nb_wmi_key_filter(struct asus_wmi_driver *asus_wmi, int *code,
 		if (atkbd_reports_vol_keys)
 			*code = ASUS_WMI_KEY_IGNORE;
 		break;
-	case 0x5D: /* Wireless console Toggle */
-	case 0x5E: /* Wireless console Enable */
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

base-commit: 186f3edfdd41f2ae87fc40a9ccba52a3bf930994
-- 
2.50.1



