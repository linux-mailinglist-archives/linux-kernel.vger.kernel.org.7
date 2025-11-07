Return-Path: <linux-kernel+bounces-889812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD63DC3E982
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 07:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C19604E9600
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 06:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FAE2D5C74;
	Fri,  7 Nov 2025 06:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fwswkhzZ"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558942D063C;
	Fri,  7 Nov 2025 06:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762495893; cv=none; b=NxVt/Ziu5OajhyfZdsVQhitwGVvNOhT32hJ58aOBD4oqHGmYf14wU2PbjnuKNCpsxCcdDb97DnAII4RmouhFsFghV5wjj/EEQgz86nTcqlT1Qoez2JQqEjeei1jDlhZHeXWn8aB+j1tEHOEo36m4nopcdc7HVC5/XwLVBanokds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762495893; c=relaxed/simple;
	bh=lOpOxoKvkhQOdKC2q5dlK2OnJGPYLZ1QfoWs/zT0E34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IBftB5bMOhFzUX4hvsQMmfNrZ61SlwB6c6NbkLgGzAo0iwZ9Y6stKD4QwiR8s/6daoqQVm89GKqh+aQ7+wbXH3hPTSQIt3pTQ/XwJeThFXVoELKQ4coNtYJfjBv//HR8vjjVmTT5niINsVtY9foaaMqW0fROG+XZhGFiTB54A1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fwswkhzZ; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=PO
	/1F22LyRnQppxy3e+nd1++VbIYO9chSNDlRIEVrNw=; b=fwswkhzZktD6I1rsAK
	pbmU8r/yKG6mE7hWrNIPnIOVe80066SQGpCKa7O8dl22OjH2wwxu734r+dS5d8Xa
	zx8dyG0RNeQ9sNPrMZGMeAb0bB/bVy2qw9nbiSUnCQwpd9URfTT8gdOTvJwHMIuL
	tl8ioxK+8/bUUA8qmfMMmpKuE=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDHYMFojQ1pXhliCw--.29130S2;
	Fri, 07 Nov 2025 14:10:48 +0800 (CST)
From: ccc194101@163.com
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	Chen Changcheng <chenchangcheng@kylinos.cn>
Subject: [PATCH] usb: usb-storage: No additional quirks need to be added to the ECD819-SU3 optical drive.
Date: Fri,  7 Nov 2025 14:10:46 +0800
Message-Id: <20251107061046.32339-1-ccc194101@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDHYMFojQ1pXhliCw--.29130S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw1UurW8Xr4fZF47GF48Zwb_yoW5JF43pr
	WUArs8CrWkGF1Sgwn7tFWUZFyft3WkAF48GayUG3y5Xr1Yya1kJr98Aa48J347Cw43ZF4I
	gayqvry8KFy8J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYsjUUUUUU=
X-CM-SenderInfo: 5fffimiurqiqqrwthudrp/1tbiQRj+3mkNhLu6qQAAsx

From: Chen Changcheng <chenchangcheng@kylinos.cn>

The optical drive of ECD819-SU3 has the same vid and pid as INIC-3069,
as follows:
T:  Bus=02 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  3 Spd=5000 MxCh= 0
D:  Ver= 3.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=13fd ProdID=3940 Rev= 3.10
S:  Manufacturer=HL-DT-ST
S:  Product= DVD+-RW GT80N
S:  SerialNumber=423349524E4E38303338323439202020
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=144mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=02 Prot=50 Driver=usb-storage
E:  Ad=83(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=0a(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms

This will result in the optical drive device also adding
the quirks of US_FL_NO_ATA_1X. When performing an erase operation,
it will fail, and the reason for the failure is as follows:
[  388.967742] sr 5:0:0:0: [sr0] tag#0 Send: scmd 0x00000000d20c33a7
[  388.967742] sr 5:0:0:0: [sr0] tag#0 CDB: ATA command pass through(12)/Blank a1 11 00 00 00 00 00 00 00 00 00 00
[  388.967773] sr 5:0:0:0: [sr0] tag#0 Done: SUCCESS Result: hostbyte=DID_TARGET_FAILURE driverbyte=DRIVER_OK cmd_age=0s
[  388.967773] sr 5:0:0:0: [sr0] tag#0 CDB: ATA command pass through(12)/Blank a1 11 00 00 00 00 00 00 00 00 00 00
[  388.967803] sr 5:0:0:0: [sr0] tag#0 Sense Key : Illegal Request [current]
[  388.967803] sr 5:0:0:0: [sr0] tag#0 Add. Sense: Invalid field in cdb
[  388.967803] sr 5:0:0:0: [sr0] tag#0 scsi host busy 1 failed 0
[  388.967803] sr 5:0:0:0: Notifying upper driver of completion (result 8100002)
[  388.967834] sr 5:0:0:0: [sr0] tag#0 0 sectors total, 0 bytes done.

Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
 drivers/usb/storage/unusual_uas.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index 1477e31d7763..6d32b787bff8 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -97,6 +97,12 @@ UNUSUAL_DEV(0x125f, 0xa94a, 0x0160, 0x0160,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_ATA_1X),
 
+UNUSUAL_DEV(0x13fd, 0x3940, 0x0310, 0x0310,
+		"Initio Corporation",
+		"external DVD burner ECD819-SU3",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		NULL),
+
 /* Reported-by: Benjamin Tissoires <benjamin.tissoires@redhat.com> */
 UNUSUAL_DEV(0x13fd, 0x3940, 0x0000, 0x9999,
 		"Initio Corporation",

base-commit: 284922f4c563aa3a8558a00f2a05722133237fe8
-- 
2.25.1


