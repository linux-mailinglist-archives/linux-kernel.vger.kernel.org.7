Return-Path: <linux-kernel+bounces-722706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F053FAFDE01
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8E63A450B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A351F4E57;
	Wed,  9 Jul 2025 03:13:39 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A9E41760;
	Wed,  9 Jul 2025 03:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752030818; cv=none; b=gFKASmITTiro0FvmWa8dGKD3Rv39XRJ1SXay5f4fzIUOc8uD5JuPAeb1HwEwBn8Cpv5YpJJN+7n7MGMmN3hCRJAyaPfXHdJXoqmDKftvG30JEN1d48W5Mi1yOAwDg4wlgM++tuMakqFJGJtLksPpDGwuKAAh3FOwtsQzq70hAfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752030818; c=relaxed/simple;
	bh=hfM59/eh6N8wBYkqESiGLBYZjlk4OaX55Ho5jXZKwaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0QrudLLiKh59lQhd/nJOecUx7u0rOZcqYVUzb6KLC5LeERgBqjp8D9DRxR2jAgKImTW4+Uz3+cBf9og9qSQLmWGc6i/Vt5UJMR6ZVGDuG3M9hbhiTPqlkyriAJk8kAErFeag4olgohwqVbKo/F/s8oviyJAcSPY+A4847JaXiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: aad77c725c7211f0b29709d653e92f7d-20250709
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:df9bab53-0e06-44d2-be73-66e28e5212c9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:cf1e7a028788195e57e165485a11aef1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: aad77c725c7211f0b29709d653e92f7d-20250709
X-User: dengjie03@kylinos.cn
Received: from [10.42.12.86] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <dengjie03@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 96761095; Wed, 09 Jul 2025 11:13:21 +0800
Message-ID: <d19ad4df-8c68-4682-9580-76f9ac6a3ed2@kylinos.cn>
Date: Wed, 9 Jul 2025 11:13:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: storage: Ignore UAS driver for SanDisk Extreme
 Pro 55AF storage device
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
References: <2025070422-punctured-opal-f51e@gregkh>
 <20250707062507.39531-1-dengjie03@kylinos.cn>
 <2025070725-circle-recite-bc04@gregkh>
 <2c4af4f8-5763-4ebf-8070-c7eabf43fe5e@kylinos.cn>
 <2025070830-edge-deprive-ce6b@gregkh>
From: Jie Deng <dengjie03@kylinos.cn>
In-Reply-To: <2025070830-edge-deprive-ce6b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/7/8 15:32, Greg KH 写道:
> On Mon, Jul 07, 2025 at 05:52:31PM +0800, Jie Deng wrote:
>> 在 2025/7/7 16:47, Greg KH 写道:
>>>    　> So ignore UAS driver for this device.
>>>>> Signed-off-by: Jie Deng <dengjie03@kylinos.cn>
>>>> ---
>>>> v2:
>>>> 	* According to the file modification rules (sort by VendorID > 	
>>> first, then by ProductID.) Add the newly added "UNUSUAL_DEV" > 	  in the
>>> correct position.
>>>> v1:
>>>> 	* The newly added "UNUSUAL_DEV" was directly added to the end > 	
>>> without modifying the format according to the file.
>>>>> ---
>>>>   drivers/usb/storage/unusual_uas.h | 7 +++++++
>>>>   1 file changed, 7 insertions(+)
>>>>> diff --git a/drivers/usb/storage/unusual_uas.h
>>> b/drivers/usb/storage/unusual_uas.h
>>>> index 1477e31d7763..6b1a08e2e724 100644
>>>> --- a/drivers/usb/storage/unusual_uas.h
>>>> +++ b/drivers/usb/storage/unusual_uas.h
>>>> @@ -52,6 +52,13 @@ UNUSUAL_DEV(0x059f, 0x1061, 0x0000, 0x9999,
>>>>   		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
>>>>   		US_FL_NO_REPORT_OPCODES | US_FL_NO_SAME),
>>>>   > +/* Reported-by: Jie Deng <dengjie03@kylinos.cn> */
>>>> +UNUSUAL_DEV(0x0781, 0x55af, 0x0000, 0x9999,
>>>> +		"SanDisk",
>>>> +		"Extreme Pro 55AF",
>>>> +		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
>>>> +		US_FL_IGNORE_UAS),
>>>> +
>>>>   /* Reported-by: Zhihong Zhou <zhouzhihong@greatwall.com.cn> */
>>>>   UNUSUAL_DEV(0x0781, 0x55e8, 0x0000, 0x9999,
>>>>   		"SanDisk",
>>>> -- > 2.25.1
>>> Why is there two "v2" patches sent here?  Shouldn't this be "v3"?
>>>
>>> confused,
>>>
>>> greg k-h 　 　 　 　 　 　 　 　 　 　　
>>>
>> The first sent V2 patch was missing the description of the
>> differences between V1 and V2 patches. The V2 patch sent for
>> the second time only adds a description of the differences
>> from the V1 patch compared to the V2 patch sent for the first time.
>> There is no modification to the code. So it is rashly believed
>> that it does not need to be defined as a V3 patch.
>>
> Think about what you would do if you got sent 2 "v2" patches?  :)
>
> Remember, some of us get hundreds/thousands of emails to handle a day,
> please make it very obvious what to do here.
>
> thanks,
>
> greg k-h
I'm very sorry. I'll pay attention when submitting patches later

