Return-Path: <linux-kernel+bounces-859703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 638B6BEE5BD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C6794E724C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 12:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAA92EA729;
	Sun, 19 Oct 2025 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="le5Oghbv"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37522EA474;
	Sun, 19 Oct 2025 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760878565; cv=none; b=qq+SFoWBdT28mVTTPkphlZG3PB5ymfPcX0peqA8mXRwYyYgcYloJH9O0tGKftwZfSrBi3X/Ic/ltW48/BNaMIbHKxAsd9hjGKmz159ZvXBtoa0leTDaZFpHmg70L7Li0S5qJYtByXUkltcDouG7HPSThI2IFwKHHyQKZ0XI1f2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760878565; c=relaxed/simple;
	bh=L99iwiGRSsMMaZ4qJbP5ThO0hitHjHgjeBtbP7eow0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzAhxqPKcrsRwXKOkLiBBZs8Qz10mY9oN4pokDIlsjFl6h6lGK0yYaRiypq55lXa9pdEEwZjmK8vYxbahS2RFD0E8zP4AfxD990pZjdN0S/A8DWCMQBaczZBO1PBrRi0UNI4SIusdqCDBKutOAmKLRabmjgFZzf6YBRr0L0tfq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=le5Oghbv; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1760878251;
	bh=oztK+0pOpjsgj+fyUmrVDHpObsG8G9CDzExjQnJ4fQI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=le5OghbvF718IyzPp8XJ5PuBg/ZmqikQ17fKo3nAZgdLE7yQhw2GGTsa1u7WjbiOo
	 QkPc1Md3ckz8cUPVgrAqxHVrjk6K+GWPF+W7CXMlhKNqYiDxrjEqMFQtarDt9F2Baf
	 vHjx/0qTfgWEy2WDZpz8UoXc4gB/dGyuNbNPi6F0=
Received: from [198.18.0.1] ([171.223.89.76])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id CB1924D7; Sun, 19 Oct 2025 20:50:49 +0800
X-QQ-mid: xmsmtpt1760878249tsaurhgks
Message-ID: <tencent_F25AF0A47F3182B368AB6AD234AC81D9DB06@qq.com>
X-QQ-XMAILINFO: MF2s0TKt0BDQyTs4be0pMO1y30Zp12xs/PdjKj3gx6F8hXqLAgXmuOWjYEZrcf
	 LWfCECx5VxTO7IuVSCrr5Xq2g+5i03978tPHBkj58FVm3+Pm66tzeRZKQ95Zi6xb6LUsuPmvshJC
	 T5NF7gNFUyUT4hjcCIdMmuRLRmJH5fgNv6Qy2cNVHT84BljaH1/mYUdkGN9o9oSst8q3Gvzwi1P+
	 0piae209Lkulv3V4hnDoTnabyVTWxlKkPDWu8DzXuNmHBociKBOPcC/HY+GBpmgBN8UMFc2TGEde
	 UsWK3qNDvDRJX1fhCA1wK3Rcwxli+O0rtonyVIJ8lIaTVviFP5eutlKd6P2h8CAxnbQq06H1CLE/
	 YhUg8rD3u4MWlT+7R6uGjFXaWbCYgirEmhoXGClQIbY97Ql2h2CrFjMQ70vElGylMSblRYiSoRG7
	 yfSlbhn7MEBwbfH33SHE3bAwyJFIrV0+PNYlK6t18YsWr3xC1MFqWF5V6G/pB+dtetdgD1wNnEaj
	 FcSv19U4mTbZpw/1ktIcwrmNbazzgypgyZvQf7UAQsw8qTRgOaUns1uBaClkKXHv9eJ9kgiZ+osu
	 0vuWWwCzPncenNOARHopndIOeADWFJO6eza8Bj3UQ0H7JZMWRLcuFfnWktAQ2wSb3HvGQvu9YidQ
	 QEDNiM9DMYPJaUAdXfTsezZle69qshMHD8/wCmsHId+dHXfB+/QV0xBuTNx9oVVtaC6aABsnZXcD
	 f8WNR8rCeHOh8qlNgReRi44WdZI8fZVBlgDPueP08qF7z2Jdl9b9ZFhkbEg3XRC4QeGleqxD2VI3
	 g8d2ReVm4JmoplmIZ/n+67PnS4Z9z9Mrm0FxzfE6bnaMD1WICxzWTsfgvWKddtWzZdRt8F49fJWU
	 WmFyGrq6+Bzu/hDPZCncq0jzgJl6Z0E7xo0AiRAAC59zIrsBDQhYk3lX5cII+Vul1mt8sm308ShV
	 DXHRA/rZLfd4assW/nMS068Ns60ZTlRX92c5bEeLBpoX4WE0Ovq/ge4rIjB3SQejpUozRt/Dq8Se
	 zfGNQbrSuL5oAcq5cG9PTZJGhmFFlkxKNBj47l+sT9Sk/C4kW2I7EZgYfazLI=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-OQ-MSGID: <a8f312b7-a752-40bd-b2bd-47baaf0f0187@foxmail.com>
Date: Sun, 19 Oct 2025 20:50:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: serial: option: add UNISOC(Spreadtrum) UIS7720
To: Greg KH <gregkh@linuxfoundation.org>
Cc: johan@kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_0066A06B7D93DDC53FCE20AD3149F8B01908@qq.com>
 <2025101907-living-zipping-3894@gregkh>
Content-Language: en-US
From: Renjun Wang <renjunw0@foxmail.com>
In-Reply-To: <2025101907-living-zipping-3894@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Greg,

On 10/19/25 19:16, Greg KH wrote:
> On Sun, Oct 19, 2025 at 06:44:38PM +0800, Renjun Wang wrote:
>> Add support for UNISOC(Spreadtrum) UIS7720(A7720) module.
>>
>> T:  Bus=05 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  5 Spd=480 MxCh= 0
>> D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
>> P:  Vendor=1782 ProdID=4064 Rev=04.04
>> S:  Manufacturer=Unisoc-phone
>> S:  Product=Unisoc-phone
>> S:  SerialNumber=0123456789ABCDEF
>> C:  #Ifs= 9 Cfg#= 1 Atr=c0 MxPwr=500mA
>> I:  If#= 0 Alt= 0 #EPs= 1 Cls=e0(wlcon) Sub=01 Prot=03 Driver=rndis_host
>> E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
>> I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
>> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
>> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
>> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
>> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
>> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> I:  If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
>> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> I:  If#= 7 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
>> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> I:  If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
>> E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>> E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>>
>> 0&1: RNDIS, 2: LOG, 3: DIAG, 4&5: AT Ports, 6&7: AT2 Ports, 8: ADB
>>
>> Signed-off-by: Renjun Wang <renjunw0@foxmail.com>
>> ---
>>   drivers/usb/serial/option.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
>> index 62e984d20e59..667de914a5eb 100644
>> --- a/drivers/usb/serial/option.c
>> +++ b/drivers/usb/serial/option.c
>> @@ -619,6 +619,7 @@ static void option_instat_callback(struct urb *urb);
>>   #define TOZED_PRODUCT_LT70C			0x4055
>>   /* Luat Air72*U series based on UNISOC UIS8910 uses UNISOC's vendor ID */
>>   #define LUAT_PRODUCT_AIR720U			0x4e00
>> +#define UNISOC_PRODUCT_UIS7720			0x4064
> Shouldn't this be in sorted order?
>
> thanks,
>
> greg k-h

I think it is not needed for this. As the information got from UNISOC 
official website,

these three products are  applied for different solutions(catalogs). 
UIS8910 is applied for

industrial IoT solutions[1] with 28nm process, and UIS7720 is applied 
for smart cockpit

solutions[2] with 6nm process.

[1] https://www.unisoc.com/en/solution/IndustryInternectUS/8910DM

[2] https://www.unisoc.com/en/solution/IGCockpitSolutionUS/A7720


Best Regards,

Renjun Wang


