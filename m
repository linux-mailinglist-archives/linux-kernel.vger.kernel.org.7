Return-Path: <linux-kernel+bounces-739218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9583AB0C378
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F0A7B34E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB3A2D4B79;
	Mon, 21 Jul 2025 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ICIN54ku"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74CD2BDC3F;
	Mon, 21 Jul 2025 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098011; cv=none; b=B0aJe+aEqs7P8G1bmXoIiEOrsAqlREmcz4vHM9R05dPbhpU3Zs9z2duyJbmxJpH2m7jXOo2sY9kNE561GaE1DeRIt6P7IQC3NEgakPBKyi2bv+LY06bAYGuW/opVzwsBzFiVW6CH/jd1lIHDcfzEaQh7/a6U9tZAenyISlKeI6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098011; c=relaxed/simple;
	bh=6XGCN6S+1ArKPaLcQX+53Yuwp0acP87Qo4TRmYe6BLM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gOjg9LY/1UgQgSut8yOAE+Nxhc5X8DkVMo7Gy1LbrY8u4FaJ/Ux/L6iVBZsjyK1f24ND0s2ud5F5pSwFPK4NoF+f4wtgdfI8OnNQ0PSRbvCQJaQuGz3gYnBE78b86QoAAZDBOdwZdo1/nxHeaFWTNZeahz4VLfOur4squOe/KPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ICIN54ku; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Au
	vjFB3nFeeLKyzHtgEk9AR+erzZgqabDf1jFFq3NcM=; b=ICIN54kuJl4BHa88VQ
	nVNU94P0YvHD9KOw93eobcM6R7b+tQjkG4I01HZlIyLbEezXe4QPJKiZSuBWrTnU
	mjoBgP+Ek5G8cu+F6YI5OPYUPQcaJf3m+R78ZD4s4dtL2+73/6NFR2G6ZQnn+lww
	1iqpfYnBhf0GyQG2LjoKxp+0Q=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wC37AHvJn5obfSwGg--.15604S2;
	Mon, 21 Jul 2025 19:39:28 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: johan@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] USB: serial: option: add Foxconn T99W709
Date: Mon, 21 Jul 2025 19:39:19 +0800
Message-Id: <20250721113919.28577-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC37AHvJn5obfSwGg--.15604S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1xtw47ZFyrtw4rJrWUArb_yoW8Zw4rpr
	n0yr12vFWDXFWfXF97trn5ZrWrWws3Kry2g3ZrAw43WF1Iyrs7t34Iy34fXFn2krs5WrsF
	vrs0krWUK3Z5JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRhNVhUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiow2RZGh+Huan9AAAsm

T99W709 is designed based on MTK T300(5G redcap) chip. There are
7 serial ports to be enumerated: AP_LOG, GNSS, AP_META, AT,
MD_META, NPT, DBG. RSVD(5) for ADB port.

test evidence as below:
T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  7 Spd=480 MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e15f Rev=00.01
S:  Manufacturer=MediaTek Inc.
S:  Product=USB DATA CARD
S:  SerialNumber=355511220000399
C:  #Ifs=10 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:  If#=0x2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
I:  If#=0x6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x7 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 147ca50c94be..1fc7ee5fa91d 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2348,6 +2348,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(5) | RSVD(6) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe167, 0xff),                     /* Foxconn T99W640 MBIM */
 	  .driver_info = RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe15f, 0xff),                     /* Foxconn T99W709 */
+	  .driver_info = RSVD(5) },
 	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
 	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x1782, 0x4d10) },						/* Fibocom L610 (AT mode) */
-- 
2.25.1


