Return-Path: <linux-kernel+bounces-768863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 319B1B2669C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B33118983B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13423002C5;
	Thu, 14 Aug 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Aot98PMG"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02632FF652
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176999; cv=none; b=akTBHxfEBlBy22OzAAat68OhhiBtsUdP4d3HL7953wvVr2XZ+aYlrq3gQxcjEof5yB85pjtH7xhAhztGbEjPKcA42rbYb0dMV5mH44lJcIdoZh4VhV/IbGoWWKNLKQ92Xnm3riFI3CyikwjQ2Rq8e/bpTMdy2ztx0tzE8kdD6r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176999; c=relaxed/simple;
	bh=XapmLNsynVBe0ZoJT8h7BjDRKlVkCJx+PngCC0ybMks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hJmvzRwdxxWwL1pZVXtHouYiJaygAddrtiTcOx4sCaLsEONgTRjHpKGvIYrlh2/CDAybSaeJGhsRt4XE3pB9eHnVSK1cF2uuczbNikxPmF2BdKEhNssQnHqlX2p4tMgef5TgfRbwwJ5tas3t+yDQt5TpI+3Tabsh9bIurmyOi1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Aot98PMG; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id A5EF5C6CAD;
	Thu, 14 Aug 2025 16:02:17 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 169DAC6CA3;
	Thu, 14 Aug 2025 16:02:17 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a02:2149:8b54:2b00:4bbe:4554:f657:4bd5])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 0D8001FE3E1;
	Thu, 14 Aug 2025 16:02:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1755176536;
	bh=WiJI36ZxgIHG3IWjsv2puiYuNel6VEw/UCUbhtyUxvY=; h=From:To:Subject;
	b=Aot98PMGcmlrTW+tPiFZbBruwJomXpWqoU5ckevyJAdK+HbpcmbwTqzrSDSo60A9X
	 M3YqP8coE2fgxswW5Hk4nHqqioIRY47x2otHSMgdRHsNav5ZEKY8n5q8AABV1TO+8h
	 C37j4SpL2dNoVWZ8bjtFAdhcMv5n9du1h8JbUwH7a7pMj8esuMYndmTMZc4GjUD72u
	 ybDRszh7P3OoxhPZJVgY7syYZEr8OGpo7u5UW47mbuCsup3PgovbhTDDtiqSX30NpD
	 3eiaCkeqhYGkZY75ZIM2ll+EUuMxBb95VcU0q1iUWEC5WqAOs7BDDBZizwZXOAKj/8
	 xaT8KsyHZN6FA==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a02:2149:8b54:2b00:4bbe:4554:f657:4bd5) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: inux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v1] HID: Asus: add Z13 folio to generic group for multitouch
 to work
Date: Thu, 14 Aug 2025 15:01:51 +0200
Message-ID: <20250814130151.8276-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175517653679.1700557.4626801639225690136@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The Asus Z13 folio has a multitouch touchpad that needs to bind
to the hid-multitouch driver in order to work properly. So bind
it to the HID_GROUP_GENERIC group to release the touchpad and
move it to the bottom so that the comment applies to it.

While at it, change the generic KEYBOARD3 name to Z13_FOLIO.

Reviewed-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/hid/hid-asus.c | 6 +++---
 drivers/hid/hid-ids.h  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 4b45e31f0bab..10b2f9ff78a3 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1378,9 +1378,6 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD3),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR),
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
@@ -1410,6 +1407,9 @@ static const struct hid_device_id asus_devices[] = {
 	 * Note bind to the HID_GROUP_GENERIC group, so that we only bind to the keyboard
 	 * part, while letting hid-multitouch.c handle the touchpad.
 	 */
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_Z13_FOLIO),
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD) },
 	{ }
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 5a1096283855..cff7d95c8d59 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -223,7 +223,7 @@
 #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3 0x1822
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD	0x1866
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2	0x19b6
-#define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD3	0x1a30
+#define USB_DEVICE_ID_ASUSTEK_ROG_Z13_FOLIO		0x1a30
 #define USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR		0x18c6
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY		0x1abe
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X		0x1b4c

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1



