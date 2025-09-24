Return-Path: <linux-kernel+bounces-829887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D269DB981FB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3F519C836C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54E1239562;
	Wed, 24 Sep 2025 03:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=simcom.com header.i=@simcom.com header.b="cK9GFmrE"
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB1820E023;
	Wed, 24 Sep 2025 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758683844; cv=none; b=PmSVI88YZicilNlLHUuWoMpJXHoyAJWIgxn2qNttjnMTgVoDMf6fVf2TuU4JoHGuph4+9gMokCITnuBkrKWA8IO/sXM+Ax75l/f6FfOm7LBQtPPasGLxJikYhG+DimKD6eKbofdqdpIKO9aDBIgTF27XZQ8/O2MyOwFvAsFIs6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758683844; c=relaxed/simple;
	bh=c7V474mTW5IspYQd1awSOV7f9p8Em3dMruZdyTMq0P8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kAAdkGrobO4hqZ3VS3J8VmTwg4XCQYwRBKqBflG1DTFIhiqyfiHetIFrqFZh5tnnHTl5qgIGqA4Vz2rgeCgWFA9JUyePOWBSZsx57Ozr/WTA/KP2TF2cfrBG/Ugq9BcmPJwgqv5aVhCw6MfS50Vwy7d7zBOM5jCISU/FjDh+vrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=simcom.com; spf=pass smtp.mailfrom=simcom.com; dkim=pass (1024-bit key) header.d=simcom.com header.i=@simcom.com header.b=cK9GFmrE; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=simcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simcom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simcom.com;
	s=oxqy2404; t=1758683808;
	bh=kYs7tdBXiTXV0luFtV3IW+T23C6F01Eh7K9J1nRHWso=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=cK9GFmrED0JxR0EbGhqpI30TNwcw+mpAxIKoJIQ+vrgcshLBpDWxgUHypN4rkmiqT
	 M1kHgRtbc+3GKn8bStpEwdM8xfch9Hpw7bKD+iy7nYE8KGkdkQZvgZTcydLkZxlnTU
	 6Rpi5jd2slqE8z8wQfwrhpVCyW4lcoqqYmgh0N30=
X-QQ-mid: esmtpgz11t1758683807tafb474eb
X-QQ-Originating-IP: o2IbDyyME8aA/smVpXzpHmHqeEG9D/s/K/GvE1PuV1M=
Received: from smart.. ( [113.233.137.23])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Sep 2025 11:16:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6637117805200387109
EX-QQ-RecipientCnt: 5
From: Xiaowei Li <xiaowei.li@simcom.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiaowei Li <xiaowei.li@simcom.com>
Subject: [PATCH v3] USB: serial: option: add SIMCom 8230C compositions
Date: Wed, 24 Sep 2025 11:16:24 +0800
Message-Id: <20250924031624.2784347-1-xiaowei.li@simcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:simcom.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OUC5DGN0mB58p9ZWp4jYvfXYaQB7Z+ozyfezPw1NMkJvTTDSGYyL8nO2
	uI29xHC9Be22SHdIKnHyKURMjs6FdZTdQm618MYy37Ykdn/Xl0XJqzh38ypJ0fQ0DMDrGoi
	zSCNaTagGYYnwIc/FuCHY8aUEweMPWMCkVRilcvNYkgQgjayH202nIQvs7uI+FzWf5p2KVN
	3/4k5Kx/a7SdPLZUAd5h78r0bsjqCufGvkT2tCqntBgZgiq+F/4qaQhtribFJgpjxOR3vJa
	rmkvYo6l8H3ka7eTwg2IgfwJmTX2lz82GCX29dwFsCrz0dYVBonE39va0yDRderITkWAK49
	nvh2qzWBt4s8m1mNJc6hlyKkUQc1GMZRxwLCDnsypqyHdIEWLwNR/se+iefg9HUJsP4q+b0
	elA/dyRMp3dZFyEOiOZPWJ9Y8v7eLJufXaE7QqH4hNFl13knfmlGcokChEMRlCQXW3k40Uv
	N+fiR4Sd5QAttC9iQ/fm+SerJEWuLzoT1olsTT97xIt7NBUtnLJZZfl51iWxbBknhkzGVyT
	ie7UHOfKC5YFDAMGbb3KqOksvIJr+GQgFbwvVn+75qjIatxh3HYtP2nST73TBmN92zOD8Qy
	/TSpLPfmcJpR4KpcU1f8HmX7RkIE4Si4YnV5fxx9ZMhf2ZiFB1IvE/doiZiQW9cN8VKE1aW
	FLPYiwa+eWNozVyELRYoqF3kq8DmrhxXWqt4JCyEH2JfuOK9LBCTkeAuvTJBkO1z3XJ9im0
	CxJAlhsVVHYv89fH8fhhqLICkAlWTvtDX0K+vsP9DeJkNA1bmDB7KUR2ekq5k+tk0wnoF50
	wOHqWwsArnNDS73Nhqa8gpuwxxy7QGzW/OEF8jFDWFSzK7M4SCAjJ8tjzfmfFaTS7E1XKzw
	F2wRxF3HXxnxuz/tX6bc4IWp0hDz/J9U4GnWiYz3xrypWg8LTkhbk5x7R3YXrwJjjGohbK6
	jscZqiJjrP9L3Z9ryhjbJFaofmyiWs1oAWSsCmYLYKrKpgwdBmIr/4uge
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Add support for SIMCom 8230C which is based on Qualcomm SDX35 chip.
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
Changelog:
v3:
- Fixed From and Signed-off-by mismatch.
- Added introductory sentence in commit message.
- Added comments for new USB device entries.

 drivers/usb/serial/option.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index fc869b7f803f..d6616d635c9f 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2114,6 +2114,12 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9003, 0xff) },	/* Simcom SIM7500/SIM7600 MBIM mode */
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9011, 0xff),	/* Simcom SIM7500/SIM7600 RNDIS mode */
 	  .driver_info = RSVD(7) },
+	{ USB_DEVICE(0x1e0e, 0x9071),	/* Simcom SIM8230 RMNET mode */
+	  .driver_info = RSVD(3) | RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9078, 0xff),	/* Simcom SIM8230 ECM mode */
+	  .driver_info = RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x907b, 0xff),	/* Simcom SIM8230 RNDIS mode */
+	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9205, 0xff) },	/* Simcom SIM7070/SIM7080/SIM7090 AT+ECM mode */
 	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9206, 0xff) },	/* Simcom SIM7070/SIM7080/SIM7090 AT-only mode */
 	{ USB_DEVICE(ALCATEL_VENDOR_ID, ALCATEL_PRODUCT_X060S_X200),
-- 
2.34.1


