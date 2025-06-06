Return-Path: <linux-kernel+bounces-675935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7975EAD053A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 17:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 038087A8A06
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 15:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F012288CB7;
	Fri,  6 Jun 2025 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9sY+4Vw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C1B126C17;
	Fri,  6 Jun 2025 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749223990; cv=none; b=akSLRL8ThNN9qerhMBqTEcDvRrxrEQs42uhRU2NEfWx0I3XRd2af5ZjbzJuweGjw0nswqpRPSQuflAIo0XoeWGUD2HhAlMSSjF12UQi7mNiZf5bESqrNx1Mwf2vgbQqZm4Y6R4nTp/CUUQzrPlX4KTej8J+VPKHafsnN23gTW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749223990; c=relaxed/simple;
	bh=eFI9xeUFmF4rI2dCK4V9G58Eni9zAREHZy6uDgy3Crs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z0XXBDBcbo3XByNK7dl/PIoWM7pCJg8ZS0wh0LG2qGOi8ThiMxi/1DxZcmNJmiHIJcA/6Ew3d1cuUYFV5Fif7UxOT1bqPhZwYeOqc0zBH8v90Ql7nzgQOHtHcVwrUpu76Artd1bGJOFcw7u0a1hHgPNDE+0dDYd3jyZjaTSbrFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9sY+4Vw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A19BC4CEED;
	Fri,  6 Jun 2025 15:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749223990;
	bh=eFI9xeUFmF4rI2dCK4V9G58Eni9zAREHZy6uDgy3Crs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Y9sY+4Vwylp42SVCseYf+Xs9IllAuZ7nyJjRbl/gVeQ/Lacg9NXvsA5rIMajjzOb3
	 tAlhbSHPpYoil4TaQXo/NwCzJgQduIzrTl06AL6itN5GOfk+nFdMeZc2Zop+DZD+g7
	 gcSG+GcG83cbNq9MTnd4T9FkCa5ZOFPw/5fL7Pmvui6kzsRwALF9Px/bQpdi8WRB3X
	 R3cvH2IPzoZNtPyJGqSvF3/BLlVjnuA3ARUiEpWfL8wPxEKtiYPjMznE42xUMzWrlh
	 rBkR9tO5GzNlwyXHjJEXwjRvD4/JK0pIvwYiWVa9YLa1JcN4mZpplJGIuMCB2uHQjl
	 JOD0AEZJgZdSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0664AC61CE7;
	Fri,  6 Jun 2025 15:33:10 +0000 (UTC)
From: Haochen Tong via B4 Relay <devnull+i.hexchain.org@kernel.org>
Date: Fri, 06 Jun 2025 23:33:03 +0800
Subject: [PATCH] Bluetooth: btusb: Add a new VID/PID 2c7c/7009 for MT7925
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-btusb-mt7925-add-v1-1-9b64bfa86ea4@hexchain.org>
X-B4-Tracking: v=1; b=H4sIAC4KQ2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMwMz3aSS0uIk3dwSc0sjU93ElBRd4yRL00RLM3NjCzNLJaC2gqLUtMw
 KsJHRsbW1ANE/BQhiAAAA
X-Change-ID: 20250606-btusb-mt7925-add-3b95a9673869
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749223989; l=3127;
 i=i@hexchain.org; s=hitori; h=from:subject:message-id;
 bh=l1pzEMSqiCKHnCKcovE0KP8Jz664l6WVWK2Fa8hLWhY=;
 b=CXITlyYQ4OL76dWZM3RLlobupw/4ikv4zkqcYbPCxMnlwLo6C0qf5KFCMg924Z6zYq5zmg51+
 +GB8fdHiO1XBU4Yks3v2bf6/a60SPfjdM01L8feI2uV6+vVDDF2r2mB
X-Developer-Key: i=i@hexchain.org; a=ed25519;
 pk=PyxHSC4BlFPXyw6JBia4ophgQYawC9AZWZKF9uDPsz0=
X-Endpoint-Received: by B4 Relay for i@hexchain.org/hitori with auth_id=428
X-Original-From: Haochen Tong <i@hexchain.org>
Reply-To: i@hexchain.org

From: Haochen Tong <i@hexchain.org>

Adds a new entry with VID 2c7c and PID 7009 for MediaTek MT7925
Bluetooth chip.

The device information from /sys/kernel/debug/usb/devices is provided
below.

T:  Bus=03 Lev=01 Prnt=01 Port=04 Cnt=02 Dev#=  3 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2c7c ProdID=7009 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Signed-off-by: Haochen Tong <i@hexchain.org>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9ab661d2d1e69028061fa3accd5106f481094100..e4a45596762f8c7d8ba10b4107d6e6f2203188e2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -725,6 +725,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3630), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2c7c, 0x7009), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },

---
base-commit: e271ed52b344ac02d4581286961d0c40acc54c03
change-id: 20250606-btusb-mt7925-add-3b95a9673869

Best regards,
-- 
Haochen Tong <i@hexchain.org>



