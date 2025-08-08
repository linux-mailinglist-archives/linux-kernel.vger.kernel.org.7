Return-Path: <linux-kernel+bounces-759659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A33B1E0C5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 05:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 030F07AF126
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFE317BB21;
	Fri,  8 Aug 2025 03:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=simcom.com header.i=@simcom.com header.b="LxZgQmX7"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC923FE5;
	Fri,  8 Aug 2025 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754622235; cv=none; b=OOy8LJZATSX+mpPSLu/HAZJ2/uSHop9JbSc/H0nqSjYo566GDWaU87KUk6sN14wwNpspoV67qIHdb71SdLmZXtsNjd5Fn+9CnZYzfHXMgjKgtQy/ZtjKahhwOog3cjlSc/2YGfZRp8wSomYHZ+XxuHbQvdck5w+qJZSzTgmz9WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754622235; c=relaxed/simple;
	bh=stRERAg2wgomgjxydsqnJkUaypKbHT1nPBCw9MNOCxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9BJQOFyVGcN/t/eugJ68WfXioGL+roLEGI818SX+Xjm7p/4Php3M47BfLLj6sNfebj1IffgzVpc4xulz5qbok9okAFfNaFo8a/5aAU5wDmWkk5unVku9yDao01xSVDMqYZl4wC3xXUcnLOXS8xb5fQ8T6Aji1SgGR2PqT2jLXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=simcom.com; spf=pass smtp.mailfrom=simcom.com; dkim=pass (1024-bit key) header.d=simcom.com header.i=@simcom.com header.b=LxZgQmX7; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=simcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simcom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simcom.com;
	s=oxqy2404; t=1754622189;
	bh=pae9KKegl4sxNzUItyO9+rS2pILLx5Sk+0WJMhOX0Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=LxZgQmX7mloRilPTsEkMVdLIclgPYh1fjc82YnjVnDcnFDjFfs3/p/7ZvUJZYz284
	 AAkrf5lOvBzPvnRut+4fnY9GAXJRtPx5JGBw42PkxlD7ns8ci/F1qBgkLy+QcUHL22
	 f6X0tKxC/ttZ6pOYx1uu1WYcLV1Lferiq3rJzmRI=
X-QQ-mid: esmtpsz10t1754622184tf559a92a
X-QQ-Originating-IP: RpBSfrq+xN61jAbtpmFVfXPpVRS/rADNW4W6eIcjLj4=
Received: from [127.0.0.1] ( [116.2.183.233])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 08 Aug 2025 11:03:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 440950556618151497
Message-ID: <DDC9EDC62A6DE38C+2d02241f-8f5d-49c8-bdca-53e982d889e3@simcom.com>
Date: Fri, 8 Aug 2025 11:03:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: serial: option: add SIMCom 8230C compositions
To: Lars Melin <larsm17@gmail.com>, Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250807075215.300961-1-xiaowei.li@simcom.com>
 <58ac9a75-6b0d-4b13-9be4-89a46b8e4136@gmail.com>
From: "xiaowei.li@simcom.com" <xiaowei.li@simcom.com>
In-Reply-To: <58ac9a75-6b0d-4b13-9be4-89a46b8e4136@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:simcom.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ONNbXhDT8KJ/GJ4HyHFpqlGsTvkAPu+RDqsWfuTVndvJUux013O51OGx
	Yv2pLJTTfx8wOQvd+jJzRHaL+JNCn0sAzEV5st7UyYQfmAzbEeXH6yHarPj8LBwhpFLIKR9
	GBAZQgDqBWnU3CFw8BrZZw6EhLfU6zE6kpy9uXNCfUBK1OFfzM81eBBBIrc0wgFFjesJuID
	EeK2b+jc1UNpkdmwipcz9v87oqUpf2QMWxRWKMk+92QEYPbIY3qzwGTBAXGFyfuGB1V3BZj
	B4xQZD1nj1PQTi2doU0O88DaUgzZXMtJPJ8MjxJsY+wz2xY4gzzuBqwy0TyJAqM/xCspavW
	XctcHfWQNguUUNKcah52TwqldFhVGggQzRFWljOoP84XvUHoqbhb6ryYGSwGtnoa3q3/p43
	gb1h27KYr0s8XThmzHcPWeb2AhwzeJI6I9ykDWa4/jOSJpMWkdVftH7xdS299rwkVvrFF1A
	FpIj0QGJ2kyDMi7izvdRdy7z4IdP6Ab5dHY/kKYd3lpaeHmQjudk0JkAaNu34jJnwk6qwC9
	iYqLJLaiIF2G/aYWGmXbbBNy1pvnC5NHLCNeZqaYEKkMhhpM4pFxHUq9t55IHCj3L9MLH8M
	CqDQn5EH5cS0cqlD5l/+0Z6ygJIA4wkkPyIcHWOL8XOah1gY2sU/Wn156jDMIJlopVqa7VL
	8SU4bLHcOXSyHBIVonMe1Fdt2uVV21hVIX9q0o34xe6Pt3J8MxE1Z1wc+NvRNqR5x6BLYxl
	lRFXKA7zjwayL7Og+G3SFNm0FrU8fn6KyHhTL/8Km85zOaq5cEorvEo5TVkcvYxVc7Uf2LU
	YFDnuh4ZOQFONu52UePNt17Dntr8Hsv4EF5C9js1TSxifxBZ295tmBO4fZzAT//m8dki4xP
	4peASO1c9LODAMQQnq+4Hby91XifMNSNlONMnKE3Lt50nxw+HUEw/otvEMSCSunR56sBcUk
	5kwxikWqsoggnT1zxyaWpkUJLwiFYkyr8n6uauUgjxdLD2F99Q306ALqtSjGLITiQtXyOzi
	qvLyLEHQ==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0



在 2025/8/8 1:27, Lars Melin 写道:
> On 2025-08-07 14:52, xiaowei.li wrote:
>> Add the following SIMCom 8230C compositions:
>> 0x9071: tty (DM) + tty (NMEA) + tty (AT) + rmnet
> 
> snip
> 
>> ---
>>   drivers/usb/serial/option.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
>> index e5cd33093423..8c4d28dfd64e 100644
>> --- a/drivers/usb/serial/option.c
>> +++ b/drivers/usb/serial/option.c
>> @@ -2097,6 +2097,12 @@ static const struct usb_device_id option_ids[] = {
>>       { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9003, 0xff) },    /* 
>> Simcom SIM7500/SIM7600 MBIM mode */
>>       { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9011, 0xff),    /* Simcom 
>> SIM7500/SIM7600 RNDIS mode */
>>         .driver_info = RSVD(7) },
>> +    { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x907b, 0xff),
>> +      .driver_info = RSVD(5) },
>> +    { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9078, 0xff),
>> +      .driver_info = RSVD(5) },
>> +    { USB_DEVICE(0x1e0e, 0x9071),
>> +      .driver_info = RSVD(3) | RSVD(4) },
>>       { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9205, 0xff) },    /* 
>> Simcom SIM7070/SIM7080/SIM7090 AT+ECM mode */
>>       { USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9206, 0xff) },    /* 
>> Simcom SIM7070/SIM7080/SIM7090 AT-only mode */
>>       { USB_DEVICE(ALCATEL_VENDOR_ID, ALCATEL_PRODUCT_X060S_X200),
> 
> Hi,
> you are blacklisting interfaces 4 and 5 which are not present in your 
> usb-devices listings and which are also not included in your interface 
> function description.
> You need to state the interface function which you can do as  .....tty 
> (AT) + rmnet + {ADB} and also explain why the interface is hidden in
> your usb-devices listings.
> 
> thanks
> Lars
> 
> 
> 
> 

Dear Lars,
Interfaces 4 (for 0x9071) and 5 (for 0x9078 and 0x907b) are reserved in 
the option.c driver using RSVD() to prevent the option driver from 
binding to the ADB interface.The ADB function is optional, so it was 
hidden in the previous usb-devices listings.I have attached the new 
usb-devices listings.

Best regards,
Xiaowei Li

----
USB: serial: option: add SIMCom 8230C compositions

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
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 
Driver=qmi_wwan_simcom
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



