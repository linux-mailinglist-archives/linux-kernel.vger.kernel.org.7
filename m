Return-Path: <linux-kernel+bounces-768272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B13B25F15
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCEEA72256F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A09E2E7BB5;
	Thu, 14 Aug 2025 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=simcom.com header.i=@simcom.com header.b="NeOPeJPq"
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264991A317D;
	Thu, 14 Aug 2025 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160736; cv=none; b=jbwsfqyKfgu5KEx3T+yakRluOZMRW/W9CUDcGT6V+y0gkFLZPT9wLDpxfEajOqO8yfGuTnKtDnSpP/1zgFGuJuBmEl2OulJa/7Tr4gIa70xZdbmeS5/OB+CN9h6JgGv+acJPGgVPeYIvO6Yzsd6ba6y8d89wgYhvbv11tp2WkDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160736; c=relaxed/simple;
	bh=oC4w0r+Y8/lS2On04LFvZMxS/7HpI84hdXY8N9SeUYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n1tSTQ6ZvG+KCJ8tAYz7lXoe0tTPPstcrWl92nDAO959JThza5VSXmBU/C1Ax531cF8T0MreyOQ4NrVVIpWfCaK+bTLZd2T3KXWEpj8JgI9u3dH7xQ7D7g5bE6TvjemFTXiEz39ZTMRbFEIk/uV4rAFA7gUtIVnx71TGVNky03s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=simcom.com; spf=pass smtp.mailfrom=simcom.com; dkim=pass (1024-bit key) header.d=simcom.com header.i=@simcom.com header.b=NeOPeJPq; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=simcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simcom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simcom.com;
	s=oxqy2404; t=1755160697;
	bh=TmzLBsblzlVCGEigafIkJTDDPkH67MJneLNgOeHkKl0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=NeOPeJPqg6hnP1cDxVt9Xw2IByLCMB87kEJGCiSz7AWfKwzQ+XPY9fIYCl4rs7yCa
	 rVbyh12InNdt1a8lhPYM5kJwCzZzRo7+ulqrZAQ2ZMTGESdBfFWDyf4IklRl1FgLVW
	 DKDVw5B1f5wfsoedT/R8vqcqS968b4oM+pwmq+mM=
X-QQ-mid: zesmtpgz1t1755160695t54cc26cf
X-QQ-Originating-IP: FSUdK7A9mQBvAWnD53mTRB/7AddW/leOstDRoZZH0XY=
Received: from smart.. ( [116.2.183.233])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Aug 2025 16:38:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6810780293316914624
EX-QQ-RecipientCnt: 5
From: "xiaowei.li" <xiaowei.li@simcom.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"xiaowei.li" <xiaowei.li@simcom.com>
Subject: [PATCH] USB: serial: option: add SIMCom 8230C compositions
Date: Thu, 14 Aug 2025 16:38:11 +0800
Message-Id: <20250814083811.2033720-1-xiaowei.li@simcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:simcom.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NrYaBztQq5Mh5bKvkQFJnIqoy5bGmzsoJ8Q3o6gCRKglEdfovpmJxor8
	crG4FQyL/Pr0yT4Gspgrsol268ua4qITPDrfsd5NCAViuCoHgjMe/jGSrjVWaXYpn1jEk6g
	b4PRdy7Qk6QfXkYEO7AqWzSbBtU5P8IlCCzaTZkZ8yEax2wOe0D+iLfHR63TibgaOoNpKSL
	mJ39jpiSlkVap/JOPm7wtW2530x5ld7MAut+yD+Qce7YuZ4tEJ/oB/HPS0YVj0a2yzggOpM
	ha9cmEhlxA9InIUD87hEQ3VhyxF81BHCdE/o1odYzyWGDBOC4m1FuLgxpvCeBVrvtHXtURQ
	IlBI7rFJLDLP6nGNFkVDRP7NXMgKr5SfDXUoWqGpA33W5lqrajov3Pe3AMrZINUgl4IRHs2
	gk4lEMEUVGaWNqkyaHlub1j9kxPyezsDW/AVRSGueuphBOKk9X7BYnXQQg6OyCoAHJMhs4D
	HNdZl7jJJGFUDWHVc+8uONrKOVaOg8ow9PKGOTwXOtzwDAZ9LdaoybF5KoiNM0rcAFKA9+U
	KlMNIy+jWGNCtulyOo5L7kz2tUO0JChtiFI0tZMu2nOSoGgeH3msr+a/UuJAD8rkhjicnQu
	SOSI7iHdh4Sfd2oexX+mAJVigphdQBtc1/guiZpSC4He9WRY+4v5ZliBQ1ZKlkBttbUV3SK
	3V0i33ybSly1OpurosevcFshqym+0HhxGrEVElRns25aY32BVH826BtupeCLC1N9GrunKJf
	vH8dCp8tHg3rTVG6ohhAb5trCNyIuLPvOZgtE62t+dLs9ulZpl4gLSVpd16E1DX/7ZsNnz0
	mfBi0BS6kKW2KYslZ1o1/5KrqXdnG0DqeBTSmesNl1Uj8VknicWiD1bkpjO7PRdccWltbip
	USnVVdiDWe2HwlFgDODWXPuFSTZ1HpvUvMft/nNkGvs0B0rklOuSC4N5u3CHOAyFVr30uGO
	3H9yNdmUZwsiG+0H8wz0X5dmFRuDz2+T+9KXmPN6wQvx1r1hNSrL619ZVigpRPJNyJibOfT
	HS9tsWHe28Di4RFp2P
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

USB Device Listings:
0x9071: tty (DM) + tty (NMEA) + tty (AT) + rmnet (QMI mode) + adb
T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=02 Dev#= 10 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1e0e ProdID=9071 Rev= 5.15
S:  Manufacturer=SIMCOM
S:  Product=SDXBAAGHA-IDP _SN:D744C4C5
S:  SerialNumber=0123456789ABCDEF
C:* #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=86(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x9078: tty (DM) + tty (NMEA) + tty (AT) + ECM + adb
T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=02 Dev#=  9 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1e0e ProdID=9078 Rev= 5.15
S:  Manufacturer=SIMCOM
S:  Product=SDXBAAGHA-IDP _SN:D744C4C5
S:  SerialNumber=0123456789ABCDEF
C:* #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
E:  Ad=86(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
I:* If#= 4 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x907b: RNDIS + tty (DM) + tty (NMEA) + tty (AT) + adb
T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=02 Dev#=  8 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1e0e ProdID=907b Rev= 5.15
S:  Manufacturer=SIMCOM
S:  Product=SDXBAAGHA-IDP _SN:D744C4C5
S:  SerialNumber=0123456789ABCDEF
C:* #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=ef(misc ) Sub=04 Prot=01
I:* If#= 0 Alt= 0 #EPs= 1 Cls=ef(misc ) Sub=04 Prot=01 Driver=rndis_host
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Xiaowei Li <xiaowei.li@simcom.com>
---
 drivers/usb/serial/option.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index e5cd33093423..8c4d28dfd64e 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2097,6 +2097,12 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9003, 0xff) },	/* Simcom SIM7500/SIM7600 MBIM mode */
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9011, 0xff),	/* Simcom SIM7500/SIM7600 RNDIS mode */
 	  .driver_info = RSVD(7) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x907b, 0xff),
+	  .driver_info = RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9078, 0xff),
+	  .driver_info = RSVD(5) },
+	{ USB_DEVICE(0x1e0e, 0x9071),
+	  .driver_info = RSVD(3) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9205, 0xff) },	/* Simcom SIM7070/SIM7080/SIM7090 AT+ECM mode */
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9206, 0xff) },	/* Simcom SIM7070/SIM7080/SIM7090 AT-only mode */
 	{ USB_DEVICE(ALCATEL_VENDOR_ID, ALCATEL_PRODUCT_X060S_X200),
-- 
2.34.1


