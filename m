Return-Path: <linux-kernel+bounces-859661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43572BEE39E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 13:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7893C189C2CD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 11:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE3C2E7182;
	Sun, 19 Oct 2025 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="VR8xO4EH"
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51732DBF73;
	Sun, 19 Oct 2025 11:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760872353; cv=none; b=KafcXM4jsgm7ZjkDa1wW+BVkygWvCXl0Ol8wGdbJdcXQUOYIh/D/8MjJhHYXr4TWPmxjn2QFxwJqEhjyqcVqy0to6ZRwJL7e8Ms1nhWycc3daDfLC7q7Kj9lI2xK80pO1no0MgYlMSO67aCgc1FDoNPf3UYnoTG8WE9RvOyycNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760872353; c=relaxed/simple;
	bh=ViFDhxXfXqYGFT3ML2m8KILTHvTPJeZwNKyCfUUpwG0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=pllNxmT5fVC0DDnRt3M46qFHXEQizn1grjQ3P8ZDdNh7SZsT6e0rbgkaDoWIR8QrxXc+KJkWSxNLW1+9DyhZbbdp4YnhUrHBV3Z/SMW7dNSLBMLS/yh5uI3be7vHWXYDzhoBVoJDQBFwIUDiLU/nyv8NnEFyH/N0vNU3bUG1/9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=VR8xO4EH; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1760872038;
	bh=d4/SeFKNwjY60mRjWZbXkjpm0iXyRUzZLl6UdTOsZbg=;
	h=From:To:Cc:Subject:Date;
	b=VR8xO4EH/hGqTG9sJUSpY/anZDGak0CP8xgqkyJsI/Da9WaBLhO/Aa+lwwb6cbP5B
	 PLK+HfwCObvZG19ubC3BvDN9lXGSMRzazR2SDcIk0K1SKB5Bo3wFjDF+ZF8Pt4VI53
	 RwdBR6rSehW9/2HCgggL3Id38hm+31cpM/xLyzu4=
Received: from localhost.localdomain ([171.223.167.242])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id B300803B; Sun, 19 Oct 2025 18:44:48 +0800
X-QQ-mid: xmsmtpt1760870688t9qrb6831
Message-ID: <tencent_0066A06B7D93DDC53FCE20AD3149F8B01908@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XOfkFTOzMFtqyLznh8cgR5P0BNQ28HEM2W9CEwT7LMJbCNSR8Qg
	 yVUfcaaF9tiEK3UkvGtuWdugupl6qmBAaub+6fvu/H507cWSGaHTFibtGiEWEmpfullYRiQalK2V
	 J1pjxTBHIqi3UnEhOJKyFip8GbQLNVYO/TgyFPrfYv6zbTxoODBno56LbGmMB+kr53xgu8kmEQsQ
	 iBgoDC9iyR8/fK8Wg/kxZvZXBZF0EnUhrQZcvgKYJdg2pM2PmWDutIuNRQfkkXxgemVrB9sixHIW
	 OWh/w7eacLLHMFVNHZjwvlO4NezWJtwFpEBccNG4e46kg9Y0iCoi4szIZ1sdgaRfaoSo4Tti8Xfq
	 JyIZYbQzXgXIpPGi/akbOQl3gooxuc2MZkHKbzx3Jz91Ftpzp+hDp1W+X2TcjUPH7ZI5iaMjLgHS
	 KMnSvFviB5g0xgfJc0oJVTHWydE2T3p4OdnnJgZuix0LoK66q8cD+zp5KfB6ioA/d3BNhSxjDTqu
	 c/VYQoXTXi34X3Bt8LKp4bWNs1t/Vs6QqKDXNsK/qBerzrCHCzKWWFsvYYK0bq3lN5fj/8ApierL
	 ewoDIf+Z4HnFHpaNhCsGafm/qJbp8oYsSLWh433ETGzTnBxzS+vNNuvWCGWa9A9cr1lgsQiZHiwM
	 1jsnWq5mE6HsH+YpH0IVRYdoJu/ripKos8o8V+HsRVANIr8PJh22AtU84otq0YncM7NQr7oJDL7i
	 q2dhozBR3sQeG4lplkTwJyaUNWUmN15xt1KbkQXJzlDNNuxJK7DMrU/LvqPc86Xmupe6SeiKpse/
	 TR/E20nkObZVl1yB9vm/u1brZrCRaFHZ7FuhvVBpXzozST9Lf/D86Gm13gDyz1+piA7SEUI5fF2C
	 fjUN2LO3LCIRMFNKQsykwgnfTGUMxBvpf96S8K/rO+Iom90v6O7EOlcuftaumGRNvAq2R/3J1NBR
	 Voq/vK3TCl9BGcFak5t57al31pRXFdBZeF7/GihMXfKQAnxVy9FpkfcXn2vRI/cdgF9VOl9n0kF3
	 ps2eap4e4bGg/t0NGlEJ+azccyXMS8CVOLDQFdBA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Renjun Wang <renjunw0@foxmail.com>
To: johan@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Renjun Wang <renjunw0@foxmail.com>
Subject: [PATCH] USB: serial: option: add UNISOC(Spreadtrum) UIS7720
Date: Sun, 19 Oct 2025 18:44:38 +0800
X-OQ-MSGID: <20251019104438.11167-1-renjunw0@foxmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for UNISOC(Spreadtrum) UIS7720(A7720) module.

T:  Bus=05 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  5 Spd=480 MxCh= 0
D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1782 ProdID=4064 Rev=04.04
S:  Manufacturer=Unisoc-phone
S:  Product=Unisoc-phone
S:  SerialNumber=0123456789ABCDEF
C:  #Ifs= 9 Cfg#= 1 Atr=c0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=e0(wlcon) Sub=01 Prot=03 Driver=rndis_host
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 7 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0&1: RNDIS, 2: LOG, 3: DIAG, 4&5: AT Ports, 6&7: AT2 Ports, 8: ADB

Signed-off-by: Renjun Wang <renjunw0@foxmail.com>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 62e984d20e59..667de914a5eb 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -619,6 +619,7 @@ static void option_instat_callback(struct urb *urb);
 #define TOZED_PRODUCT_LT70C			0x4055
 /* Luat Air72*U series based on UNISOC UIS8910 uses UNISOC's vendor ID */
 #define LUAT_PRODUCT_AIR720U			0x4e00
+#define UNISOC_PRODUCT_UIS7720			0x4064
 
 /* Device flags */
 
@@ -2467,6 +2468,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9291, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, UNISOC_PRODUCT_UIS7720, 0xff, 0, 0) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0530, 0xff),			/* TCL IK512 MBIM */
 	  .driver_info = NCTRL(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0640, 0xff),			/* TCL IK512 ECM */
-- 
2.39.5


