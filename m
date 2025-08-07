Return-Path: <linux-kernel+bounces-758774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4273FB1D3B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F1017BDB7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D302242D6E;
	Thu,  7 Aug 2025 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=simcom.com header.i=@simcom.com header.b="oM5tB8Fu"
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A486C1DF258;
	Thu,  7 Aug 2025 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553192; cv=none; b=P1fWhN32/Uh2v5TW8Dcyf/9A/5Z46eLmdbH7zulgGI7yf8EpmnJKXyDkbfzOnwj5gpCA9gLAd1xAzCCKbCAaPTiAlFzDfepJzJXQjB8igKmjrfl7fNxzzQOfVAPddTf9J3QpBZ7+j/CmEfqFS/MJ0m4hcy5qc/fyEsta8ByTzhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553192; c=relaxed/simple;
	bh=8XxMsvLOYaC+WM7LR69Miz4McnegbfMPsP7A7EgkeHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tBOCObZ7VSVbDJ4hFUTZswtIOl3H/2Go5PF/5gnGeOYaBD3xLvudl/tZeVCnhoSOcj/zfn8ncuYdepljuYo0AESXGVgGDNcjBlWer2CKfGitJx/UpFqWympqQvzSCgUMt8LcvyvHAyV7gmiLSYjIM5AEngHewrfctsIjN9Q3AFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=simcom.com; spf=pass smtp.mailfrom=simcom.com; dkim=pass (1024-bit key) header.d=simcom.com header.i=@simcom.com header.b=oM5tB8Fu; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=simcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simcom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simcom.com;
	s=oxqy2404; t=1754553147;
	bh=HiE/0TmLxibv/01AKQlq1CRw9J+Vd4dJoOA68xq4W/o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=oM5tB8FuEQm50LT1FOCAv7p367b8Hr0AoCD+ooZbtmXyyAffJ1ln6wsivSgb0kVDw
	 BEGG9viPTH00xTSc83BaXPcTLC+aeT2CwGA7JjFfKxDu39gZnSFI6yt7e5T1C59pLB
	 /nm8ulSW0rk/B7f8ada/duRNb6VKZKSJN5/8susI=
X-QQ-mid: esmtpgz14t1754553146tc0531960
X-QQ-Originating-IP: S2UZYmKh7Ii0wrxz0JpihFSwNjI7Htb+xDvCUhuQRhM=
Received: from smart.. ( [116.2.183.233])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 Aug 2025 15:52:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12694709793691857421
EX-QQ-RecipientCnt: 5
From: "xiaowei.li" <xiaowei.li@simcom.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"xiaowei.li" <xiaowei.li@simcom.com>
Subject: [PATCH] USB: serial: option: add SIMCom 8230C compositions
Date: Thu,  7 Aug 2025 15:52:15 +0800
Message-Id: <20250807075215.300961-1-xiaowei.li@simcom.com>
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
X-QQ-XMAILINFO: NQdjjoqryYrjzVqAP0pnYsBLg8x4cPlAk9ajedXw8W870yoc3cugESwo
	9oWulke1uDGyQw0v7/Z3lwXzPcU0b8KibCUB+PkGR1UCHLCM/8jKnfe4e2ioPpkD4TAMufd
	Zr5LBizo5SkCfXeFK0xy0hJVk4aCke8v5kOJGNRtYP6lBRkOmv7kZphIOLjYiIf5Lw7nwMV
	jRe251ni+d5H9uTfD/yeoAoD+wwzP0uwGmkbm2Q25P/FKef96hOacltvhkCM8z4MODFpstn
	w1HSPt4nkimTA54uk/gqi9QYoH9CKaWAdNYM9Cri8pEGG+hCcBo+K4f60ZDqhpKsOt3EhiQ
	3Z8jkeugp6rZfhReojqQouac6SSwFs8GNBQ7SLINUma+bPoqi9rma1iaREFU3rIrLeq9FSJ
	FtHqu5TPI7ozjY0wQcHOu3f7tkaK+CR5nss0al7b5kfetnfvxn751oJ2mk7rGizh/TQFMAI
	QusSH0xtCeMWUKO9zpbQvkvOE23OoMx6aF9Akf//FWzHuYxRQI6egoAl3CGNWfV3/63Tsec
	L0MolfMwyLfsWzLKHBV5fRxJNVSil3Rryt7LEH31cVA+xs5ikkU3ltTOr4V5dXenM3iqbLS
	1TyJd/OZ/f1L8JADWI5kaI6+zHSI4waLNKDf2yAVXXi/IYqP23AZcXi1lmzqc1n7wu0O4ms
	l1KwI/pkupqTIwfe/CSPqU4ske1M2mfdTMQ2OYdUGOcWjZSnLDSv4GA/JMp608NX23a7wmK
	NaPc8ZqKHROhye6BG1R2/dteY/XXwukfoMAru5fXMJITSrHZ0nPbFYDnNkp8vpND39HGMSP
	HTyxrK+8OpH7Eqq2IINSl2JJ9EDvcANet4cM4CCFuDhPxxBPg/VDmNoKsuHWGIsDnrP8/Zo
	PsQfXrg6JRBTz+c3Jx0rVLtO3IsDH5NgzgaxKSPIdm/We3BpNiluT/prU11wNwKBgMzRkIz
	XLAY+9QIs38qYSguSvGEaoVre9F8WsSqtIIemIQsH12443/XBpy7HPwy5Jyo6evBTDiEzeu
	/baguaaC5wDK4hQdQx/RwykrOqmf8=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Add the following SIMCom 8230C compositions:
0x9071: tty (DM) + tty (NMEA) + tty (AT) + rmnet
T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=02 Dev#=  5 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1e0e ProdID=9071 Rev= 5.15
S:  Manufacturer=SIMCOM
S:  Product=SDXBAAGHA-IDP _SN:D744C4C5
S:  SerialNumber=0123456789ABCDEF
C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=500mA
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

0x9078: tty (DM) + tty (NMEA) + tty (AT) + ECM
T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=02 Dev#=  6 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1e0e ProdID=9078 Rev= 5.15
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
I:* If#= 3 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
E:  Ad=86(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
I:* If#= 4 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x907b: RNDIS + tty (DM) + tty (NMEA) + tty (AT)
T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=02 Dev#=  7 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1e0e ProdID=907b Rev= 5.15
S:  Manufacturer=SIMCOM
S:  Product=SDXBAAGHA-IDP _SN:D744C4C5
S:  SerialNumber=0123456789ABCDEF
C:* #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
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


