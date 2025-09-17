Return-Path: <linux-kernel+bounces-820519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699EFB7CFAD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92FE581777
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358DC2EAB89;
	Wed, 17 Sep 2025 10:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=simcom.com header.i=@simcom.com header.b="ERtky+rV"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FE4275B1F;
	Wed, 17 Sep 2025 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758106736; cv=none; b=Sv2KjVyvdsQKB1jE4BQw4kZR5IAQ7msr6w0b/N1r9HfyrWpkVjdnSi4SgwyHzsqlHlRd/vNl+NcEjymUusPYJQmp2uRDPY2CDQOgfJF5dSrNdLOh3uJxVeeC9dF9c4in47+OuwmindqikI5b/tgm69LGjEMMmfDfZJ/JtnCIgNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758106736; c=relaxed/simple;
	bh=yCrM5j6YeGUGRgl4TEvoOMyPTxDAD2ZUM2GFXLrAUgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5GXoaiS/2XbMNtLDoe0ew9cD4mzhVGoNom2T9H35Vsm4zhuJg51hJky0eJIEdlJupCN3uXxS8ajOYqM2MhhaX+1cjbYCmFBicKuFXAwa27T+0sZbyK/DSddvpys5ZrjmJ30AENaegIOV1Ff/SfA1Hyteuk/afVSxd2gzj3GJVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=simcom.com; spf=pass smtp.mailfrom=simcom.com; dkim=pass (1024-bit key) header.d=simcom.com header.i=@simcom.com header.b=ERtky+rV; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=simcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simcom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simcom.com;
	s=oxqy2404; t=1758106696;
	bh=xGKblNdb+UxaZlG0+v+TKTamCcDdaFF/sMJbnNCUAI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ERtky+rVxt6v6aRDNR3JnCnLPJkfcYaBhdE6anG1IUCDwpwEaEXQL6FmwqfCweYUV
	 RzzxVwMj7QjIapnS4ZIJPdFqSm2WEjSsWic54CQTP283Fi7fRECBUGnQs62QInOElj
	 W+3mNXWnCIoFZAsdA9tyQaDfltlcs3uFaniakNtU=
X-QQ-mid: esmtpsz19t1758106691te935c0a6
X-QQ-Originating-IP: uzvmPhEmSBHpiYyFT4gYG8RF0OGhw0UXKsFniBjTn6c=
Received: from [127.0.0.1] ( [60.17.15.194])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Sep 2025 18:58:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11535672838644639261
Message-ID: <8338C8A316C4CE7E+7fea7917-ab90-4db2-91d0-ff64ff74f894@simcom.com>
Date: Wed, 17 Sep 2025 18:58:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: serial: option: add SIMCom 8230C compositions
To: Johan Hovold <johan@kernel.org>
Cc: Lars Melin <larsm17@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250807075215.300961-1-xiaowei.li@simcom.com>
 <58ac9a75-6b0d-4b13-9be4-89a46b8e4136@gmail.com>
 <DDC9EDC62A6DE38C+2d02241f-8f5d-49c8-bdca-53e982d889e3@simcom.com>
 <aK2EIRdqgEafWT0a@hovoldconsulting.com>
From: "xiaowei.li@simcom.com" <xiaowei.li@simcom.com>
In-Reply-To: <aK2EIRdqgEafWT0a@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:simcom.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N5Iui8YkiXhhSEX9PRqLptezddGPtn8BwibEWatB3I60EGPjpfTGESJT
	KeAS7cbG1z2ZLwJNj4r+Vp7zlqvlg5LTS+FfT8aEatqvF9MFFf/vbHKniu9Ej65koncAXLZ
	bEBYZ3TtongjZ17FmyT/ExQT3g28kh/qdm1ZTyCxyl+g6zXE+3dhBaTgRBIQpSWw/S9l5jk
	lB41fhHWD9omtRXWAa27Bn6vu3t6QwQqL9xVzcdo3tFexvQR9TFsruTgObkTD2SgqhcRFat
	dDLJV209UYbH+rREp4mNRbm5+ymKsAUp/UXQDm7/9R+6FDOkoVpBNRheHe637yVOV7Ll6P2
	rRLJIUGZ9fXRiwmZcPYFVx5zAyjfc9D6UukpFUbSwRlDEe/ptwMcH5XWCDUo8pftbx6caAv
	5cBu3Mx5axCrLZS62eH7dnbL1dHtPlhud5F6fQ4m6g7j5my7HU/nO0hAYOeJovYLKb5UjZK
	c6TfmAhCWOadou+jZz0JBANUYjxECLlMDr8zug/Lrw9o097bxMSaN6D0DtzAB5oo0EAXNwW
	q9s72cHppFi/oXCJC7q5PCUNKjayiBxKp5lV0ZKiB6l7bF982FQtJpkZyZXfQDpqO7HJure
	Epudp4TRqZTcO6rmgMthmwA68gBev+MJQQ0/5FqsWOe7kwmVaTphCYf3BTlOmDWVxgNlvZF
	M3fQZ5eAKpJljiaC2seorwLWZhdjzntA8/FOw+wDTjd6xKQ6zmYmzyZoxAW9T6tEv/0ERvl
	mdSFnHV+fozJMhOgZoxkFH/4AETmAJ5twRvRumpBcGXk5WIZ6wJcLssK/OlpZcgQI70XBrr
	b8veJITQrX0AzJZvsX1ObJuZEBeSuCBDeeMehoj8f3X4jbYY4/7wI1e82HEvJVlal+tBS9u
	I1wd6wXdMU+UGv2kntuC17llrjs3CJBwcnXFi2gzAiDP6VZV0DLS+h9mI7U+kwW9VU1jcpx
	Ov7l55B2dadwIU15E2XCY5JOUedqzChjgEW0aQxzzcRqA4+fo1x2+7tNyf3i0NHMO+iy8ej
	TxEa5/uHP3hBoake5IleHobynPR7/qGm2j2oXWNsrhcVEXRpHv+M4J8+lqvICeg5kd48GXa
	A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

I have resubmitted the following patch.

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
index fc869b7f803f..8eadcfe33ecd 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2114,6 +2114,12 @@ static const struct usb_device_id option_ids[] = {
{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9003, 0xff) }, /* Simcom 
SIM7500/SIM7600 MBIM mode */
{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9011, 0xff), /* Simcom 
SIM7500/SIM7600 RNDIS mode */
   .driver_info = RSVD(7) },
+ { USB_DEVICE(0x1e0e, 0x9071),
+   .driver_info = RSVD(3) | RSVD(4) },
+ { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9078, 0xff),
+   .driver_info = RSVD(5) },
+ { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x907b, 0xff),
+   .driver_info = RSVD(5) },
{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9205, 0xff) }, /* Simcom 
SIM7070/SIM7080/SIM7090 AT+ECM mode */
{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9206, 0xff) }, /* Simcom 
SIM7070/SIM7080/SIM7090 AT-only mode */
{ USB_DEVICE(ALCATEL_VENDOR_ID, ALCATEL_PRODUCT_X060S_X200),
--
2.34.1

在 2025/8/26 17:53, Johan Hovold 写道:
> On Fri, Aug 08, 2025 at 11:03:01AM +0800, xiaowei.li@simcom.com wrote:
>> 在 2025/8/8 1:27, Lars Melin 写道:
>>> On 2025-08-07 14:52, xiaowei.li wrote:
>>>> Add the following SIMCom 8230C compositions:
>>>> 0x9071: tty (DM) + tty (NMEA) + tty (AT) + rmnet
> 
>>>> @@ -2097,6 +2097,12 @@ static const struct usb_device_id option_ids[] = {
>>>>        { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9003, 0xff) },    /*
>>>> Simcom SIM7500/SIM7600 MBIM mode */
>>>>        { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9011, 0xff),    /* Simcom
>>>> SIM7500/SIM7600 RNDIS mode */
>>>>          .driver_info = RSVD(7) },
>>>> +    { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x907b, 0xff),
>>>> +      .driver_info = RSVD(5) },
>>>> +    { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9078, 0xff),
>>>> +      .driver_info = RSVD(5) },
>>>> +    { USB_DEVICE(0x1e0e, 0x9071),
>>>> +      .driver_info = RSVD(3) | RSVD(4) },
> 
> Please keep the entries sorted by VID/PID.
> 
>>>>        { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9205, 0xff) },    /*
>>>> Simcom SIM7070/SIM7080/SIM7090 AT+ECM mode */
>>>>        { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9206, 0xff) },    /*
>>>> Simcom SIM7070/SIM7080/SIM7090 AT-only mode */
>>>>        { USB_DEVICE(ALCATEL_VENDOR_ID, ALCATEL_PRODUCT_X060S_X200),
> 
>>> you are blacklisting interfaces 4 and 5 which are not present in your
>>> usb-devices listings and which are also not included in your interface
>>> function description.
>>> You need to state the interface function which you can do as  .....tty
>>> (AT) + rmnet + {ADB} and also explain why the interface is hidden in
>>> your usb-devices listings.
> 
>> Interfaces 4 (for 0x9071) and 5 (for 0x9078 and 0x907b) are reserved in
>> the option.c driver using RSVD() to prevent the option driver from
>> binding to the ADB interface.The ADB function is optional, so it was
>> hidden in the previous usb-devices listings.I have attached the new
>> usb-devices listings.
> 
> And please send a v2 with the updated commit message (e.g. usb-devices
> output and SoB).
> 
> Johan
> 


